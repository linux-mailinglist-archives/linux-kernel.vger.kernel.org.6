Return-Path: <linux-kernel+bounces-435248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF0E9E750E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D02316088F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3C20D508;
	Fri,  6 Dec 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X39i1j9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155320CCF7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500990; cv=none; b=RgaHPOolWpzOMJYe8otuv39Hhts0Zh02liD/lZMAIS2pJ7hF95shMPA3gscAcPRWg2Us6Sbt6XnM1IqezFnOYlmffuxMkFiKm2S9NofcogfTqZqCSGJWv6jTZIHNLX+Be/8exeFaSlZhfLUsa2tmoGXZe1mDQnEOYuCIwjru5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500990; c=relaxed/simple;
	bh=mZV+xN6vU67NFP4ieN6iMI5586pQQ2JbDme+JaRFSPI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZDl+2a5sWo3pK3oNn1LTylxdpHKFdkIagbkL9iPuh3LvFH6qSdTWu3cfimzaJIa3KrxzYq+Oba9uvKT4+zDGQ1/+355PgkSQkYRWvUiXuFkWwTXYZE55IDNLtHy93ktgTsOUlvdb9nkk1HjSp94z53c+IOD+aOlnhOYvuLR0ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X39i1j9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68501C4CEDC;
	Fri,  6 Dec 2024 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733500990;
	bh=mZV+xN6vU67NFP4ieN6iMI5586pQQ2JbDme+JaRFSPI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=X39i1j9Spk4puEz27ymOB1xXhT44fwg0EA6ISEGsYtBHjMLMqOas+CkVJSkD9fBcm
	 Fc1A0lB/1xZhKunC/ce1VqOVJBcXwvYNzevc1cS2/q4jlaR4Mssct/GptawSjrByky
	 0ora29jEQQMK7fdDlqi/Nv1s/yPVpd6HF88HVCwlYB9PlDJnPvhv35cjxclzwluwm1
	 4EScn8WIWTKP00Ai+Bk6bfGQWpyOL3bf4UNHv5TxIQp68+ja7u8OYjt/N/SXNhRD0D
	 kjXt6b8BJYbKW7qFNnorVZrxgu1ctwVdjUzrPgLDVax4xqfRqfRAWwqhEu1I7PedXN
	 2EsG7vBjT2Pjg==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5AAED1200068;
	Fri,  6 Dec 2024 11:03:08 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 11:03:08 -0500
X-ME-Sender: <xms:OyBTZ90zrQ3HTOiakSHFiQUJjMMr2Rl41S6uXk3B1R9H0p0aqUDo8w>
    <xme:OyBTZ0G_CS0SXO9LSRUGQHd3gp-CYdL2_1F6P53FkeWI3ait9HVErQ967Sbh7CbTs
    63AM5-S5RBFtITb0Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohephigrnhhghihinhhglhhirghngheshhhurgifvghirdgtohhmpd
    hrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhlvgeslh
    hinhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghn
    khhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvh
    hinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhhes
    lhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OyBTZ94sR5Q4XBfxZ16lUBreB2awIr5guWbGY5cmWmkcyuu0nU2pIA>
    <xmx:OyBTZ636KDoTm8uMopku2yjxZ9VDsyWeoEnO4vzlu_S62CfamZKIpA>
    <xmx:OyBTZwHuae4A3yKy0g928pvzgMR07N8M_enIDmouYLREjlrpTEoXJg>
    <xmx:OyBTZ7_YwXbLCKxY9Sn9dnKxYO_IjG94E-O6PYB8Xh9SPL30t13U6w>
    <xmx:PCBTZ9l09p1091XHzkA11IFgyAZt2RxrphUCZvEEmQ9MDsfQeZIZ1-7n>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AD5602220074; Fri,  6 Dec 2024 11:03:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 17:02:04 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <e855900a-28d2-424b-8b3e-63c3c10c2848@app.fastmail.com>
In-Reply-To: <Z1Mb15vOY4fJjsKt@smile.fi.intel.com>
References: <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
 <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
 <Z1Mb15vOY4fJjsKt@smile.fi.intel.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 6, 2024, at 16:44, Andy Shevchenko wrote:
> On Wed, Dec 04, 2024 at 11:17:56PM +0100, Arnd Bergmann wrote:
>> On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:
>
>> I got stuck in this rabbit hole of running into more issues
>> with the 8250 driver. Any time you touch something, it breaks
>> elsewhere.
>> 
>> I've uploaded what I have here now:
>
> FWIW, I have briefly looked at it, some patches I appreciate very much, some of
> them I think need more testing and one thing I don't really like is putting
> code back to 8250_core. Thinking about that, perhaps we need to restore 8250.c
> (or alike) for collecting non-library / non-_particular_-driver-leaf?

Thanks for taking a look!

I thought you might have different ideas on where some of the
code needs to go,  as you were the one who moved it out
previously.

However, I think the two bits that I ended up moving back
really belong in the core:

- serial8250_setup_ports() is needed to get the
  serial8250_ports[] into a sane state. Ideally this
  array would just be statically initialized, but I don't
  think we can actually express that in C code.

- serial8250_init()/serial8250_exit() are required for
  registering the driver itself (serial8250_reg) Having
  that part in the ISA driver made no sense to me.

The bit that is definitely ugly is how serial8250_isa_init()
gets called from serial8250_init() and univ8250_console_init(),
and I would prefer to remove that, but any attempt to do
that made it worse.

The problem here is that we can't just rely on link order:
For the console initcall and  serial8250_isa_init_ports(),
we have to call this before the core driver initialization,
but the serial8250-isa platform device has to be registered
after the core driver does. If we link both files into
a loadable module, there is an additional problem of
not being able to have more than one module_init() call.

      Arnd

