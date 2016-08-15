FROM elixir
MAINTAINER tribou

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y \
  nodejs \
  postgresql-client

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

RUN mkdir -p /usr/src/app

ADD . /usr/src/app
WORKDIR /usr/src/app
RUN mix deps.get
RUN npm install

EXPOSE 4000
CMD mix phoenix.server
