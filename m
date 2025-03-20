Return-Path: <linux-kernel+bounces-569901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1EA6A90F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93555465408
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE581E0DEA;
	Thu, 20 Mar 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Bw3lXaOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0x9aWYb"
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994AF2628C;
	Thu, 20 Mar 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482175; cv=none; b=uleGfuZ0E0kp+XvbpTY0CluRjmgm8JdC8t2YHhLesekpZuyrAXNtktsCILKBQQtk7nPlAuEPWd0arWgoLSXm2R/Npbq3CgdpzaT0knqwNPlBhmrFkjhffEYHGGT1B2RCfK5NRAXKueIgxA0mXKEo3uA/jOLVeik5+iBa9+H4ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482175; c=relaxed/simple;
	bh=bIeQ1Wu8a+Mrkgz5vApJf9zp6gXA5Aohfycah7Q3lIA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DowYgKgmj2Ieaj+Sc+ZM4Dfa3Xa4lTUcZMRez/Pjsd6hAC864evDLgPQg1cjbTvAHxF4yoJJSd+RkCjpmNiL85gDJ8teGkqaP19WFkKBqiIhKXGp3poE99Kb0CNcFzBVEZd88vJtOkZPYxq4TNJ+kNLZl2nmb2v40FY7n4VCof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Bw3lXaOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0x9aWYb; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id AEE401D416BB;
	Thu, 20 Mar 2025 10:49:30 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 10:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742482170;
	 x=1742489370; bh=9DLyOHmoAVb5Kjp+6FlYdojTGuwaxjtqiw9xkYFjrks=; b=
	Bw3lXaOmvk9EdHs1fHI4ePb/4my5fKxj/IMehz35ln/GbxTb2yfCvVNDmPag0Iyc
	6U4DAcH8l8GGqWTL/f+oEJeQwE2vg9NLGJjKJA56zHtY+rLW7mwDSGbyr5+p5XM9
	JCCrRvfUg8U9Ay9Equz57Dwz1WcN465IOEnw52kZ1BygBzU2OSdFKNAmAlWz1mAa
	FCAYffC5LmTTVMZFFSQLceuZN0f5ZPmPgd+JE4ytjReoN4stZJTs7zhSBTdzr9V3
	pPny3DzuG5icuFEqINH8fHGHXQ9PJLpj9cpXsRhS8AcpIVTbUyPQVl3J30MBzF1n
	X7rb7bbbVqo5z/rdkGcDTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742482170; x=1742489370; bh=9
	DLyOHmoAVb5Kjp+6FlYdojTGuwaxjtqiw9xkYFjrks=; b=Y0x9aWYb2wIAQmaSl
	Pq6kfxvFZ+vMSk4mUZVMwOCYQXFhwo4FJthV1YOsfpEAc5r56MQs00MWNWQ0JNDX
	BeT2gaYmcUUtXFUpth1PV9wPGsIz06xj9QEOolTvT2f3WnwVVP1ZBCYav2jRKaKv
	JGphU67eMFJd/qbRt0RbNP2aPRcqsGRMK+PLas0r1J3nRoQ21uqRPpGUL1iI2NVS
	FebfzaJxE+l3slXKq9Zx6IGVg+a9jxn/YDtEIn7PDb/xAnScxQ2sczmw0mug+qgD
	84PKh+sqX8mlDjlR5HIzegh2buZJErBnJqLHFtImfWvmvwlvJbFl2pDGiPe7CEeT
	1YNkQ==
X-ME-Sender: <xms:-CrcZyd9GW8HoH0R3IH91GtQzQt0CEr8OyRwG1O-nnJkeMuRCvK6Zg>
    <xme:-CrcZ8NvNa45BKatbeA4B1wgGCMT93ZcGxk0DSOqDPRgKGUn0zpZUmNESobrm7HKP
    to6wCniosQHayzwSCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhpshhtrhgvrghmsegrihhroh
    hhrgdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgt
    ohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnoh
    estgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegthiihsegthiihshgvlhhfrdhn
    rghmvgdprhgtphhtthhopegsvghnseguvggtrgguvghnthdrohhrghdruhhkpdhrtghpth
    htohepuggusegvmhgsvgguugdrtghomhdprhgtphhtthhopegrlhgvgigrnhguvghrrdhs
    vhgvrhgulhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhsuhgvlhhsmhhthh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:-CrcZzggTkjaKKMcIlgevkAvwlYjG5PkKJgdClNOo099WbN16OSVsA>
    <xmx:-CrcZ_9zuYJuN_HLg3rJNKPuHPA9shltG7CLzwdMTeYtvKj7bZxlGA>
    <xmx:-CrcZ-tBhZRJUgt6KbRsVeBxevJWA7uQVq4pldXImlnOXd_tXaUkew>
    <xmx:-CrcZ2HPgAWXYC_-FTq__I9R22-H0xsP9vJ2kl_t3HMh2-otp4xiig>
    <xmx:-ircZzt99E-ok_aWCfAWKBZl4vRai5AHEGnkM81fK97NzSmAflzBFw3S>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 660AA2220073; Thu, 20 Mar 2025 10:49:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0b2bddcaf378cae8
Date: Thu, 20 Mar 2025 15:49:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Marangi" <ansuelsmth@gmail.com>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Daniel Danzberger" <dd@embedd.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Yangyu Chen" <cyy@cyyself.name>, "Ben Hutchings" <ben@decadent.org.uk>,
 "Felix Fietkau" <nbd@nbd.name>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
 upstream@airoha.com
Message-Id: <d6e27266-dc5b-4ef8-b708-21cedd06621e@app.fastmail.com>
In-Reply-To: <20250320130054.4804-5-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
 <20250320130054.4804-5-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 04/11] soc: airoha: add support for configuring SCU SSR Serdes
 port
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 20, 2025, at 14:00, Christian Marangi wrote:
> Add support for configuring SCU SSR Serdes port. Airoha AN7581 SoC can
> configure the different Serdes port by toggling bits in the SCU register
> space.
>
> Port Serdes mode are mutually exclusive, force example the USB2 Serdes port
> can either used for USB 3.0 or PCIe 2 port. Enabling USB 3.0 makes the
> PCIe 2 to not work.
>
> The current supported Serdes port are:
> - WiFi 1 and defaults to PCIe0 1 line mode
> - Wifi 2 and defaults to PCIe1 1 line mode
> - USB 1 and defaults to USB 3.0 mode
> - USB 2 and defaults to USB 3.0 mode
>
> WiFi 1, WiFi 2 and USB 1 also support a particular Ethernet mode that
> can toggle between USXGMII or HSGMII mode (USB 1 only to HSGMII)
> Such mode doesn't configure bits as specific Ethernet PCS driver will
> take care of configuring the Serdes mode based on what is required.
>
> This driver is to correctly setup these bits.
> Single driver can't independently set the Serdes port mode as that
> would cause a conflict if someone declare, for example, in DT
> (and enable) PCIe 2 port and USB2 3.0 port.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

I think serdes drivers are usually implement in the drivers/phy
layer, and I see there is already a drivers/phy/phy-airoha-pcie.c,
which may or may not overlap with this one (I have not looked at
the details).

Have you tried to use the phy subsystem interface here instead
of creating a custom in-kernel interface?

      Arnd

