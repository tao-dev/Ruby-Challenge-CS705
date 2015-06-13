require 'nokogiri'


class CiaBook

 def initialize(xml_file)
 	f = File.open(xml_file)
 	@xml_doc= Nokogiri::XML(f)
 end	

 def max_populated_country
 	node = @xml_doc.xpath('//country/attribute::population').sort_by{|n| n.text.to_i}.last
 	country, population = node.parent['name'] , node.text
 	puts " #{country} is the most populous country with population of #{population}"
 end	


def highest_inflation_countries
	nodes = @xml_doc.xpath('//country/attribute::inflation').sort_by{|n| n.text.to_i}
	highest_nodes = nodes.sort_by {|n| n.text.to_i}.reverse[0..4]
	highest_nodes.collect{|n| [n.parent['name'],n.text]}
end	


def continents
  nodes = @xml_doc.xpath('//continent').sort_by{|n| n['name']}	
  nodes.collect {|n| n['name']}
end	

def continents_with_countries
  nodes = @xml_doc.xpath("//country/attribute::continent")
  world = {}
  nodes.each do |n|
  	world[n.text] ||= []
  	world[n.text] << n.parent['name'] 
  end
  world	
end	

end



book = CiaBook.new('cia-1996.xml')


puts book.max_populated_country
puts book.highest_inflation_countries
puts book.continents
puts book.continents_with_countries

