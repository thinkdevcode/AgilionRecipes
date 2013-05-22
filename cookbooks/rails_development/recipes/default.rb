# Install Ruby version defined in vagrant file and set as default.
rvm_settings = node['rvm']
ruby_version = rvm_settings['default_ruby'] || '2.0.0'
ruby_and_gemset = "#{ruby_version}@vagrant"

# Install node.js for JS compilation.
package 'nodejs' do
  action :install
end

rvm_shell 'bundle' do
  cwd '/vagrant'
  ruby_string ruby_and_gemset
  code 'bundle'
end

rvm_shell 'create_databases' do
  cwd '/vagrant'
  ruby_string ruby_and_gemset
  code 'rake db:create:all'
end

rvm_shell 'migrate_development_database' do
  cwd '/vagrant'
  ruby_string ruby_and_gemset
  code 'rake db:setup'
end

rvm_shell 'load_test_db_schema' do
  cwd '/vagrant'
  ruby_string ruby_and_gemset
  code 'rake db:test:prepare'
end
