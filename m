Return-Path: <linux-kernel+bounces-424827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A279DB9F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB85DB21DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3D1B6D00;
	Thu, 28 Nov 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SfRGNbSx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iwjf8d79"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74381B3940;
	Thu, 28 Nov 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805511; cv=none; b=iIteNFIv0JPptijXtPw3uDHaOXlv373u357hUiYV2jsXfIdx+X/XojbHfKZ8K98eESAEL/H6Q8x79ket9/kMxG4CUkK2xKbCQOnuS6oqAMY8QkY0mS/+GA0q9Uu8OO2MYYTY3fnKtw8Q9fEmP8L/dVed0gKHw+Pu9/MdWE6fY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805511; c=relaxed/simple;
	bh=n8U2ayfWPgEeW+5Oau+MZHYURLe9sJhQQ6lBa6wBwT4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oStiZvuD/xfGYsc8J5IyHd2Rd/AwLEMBky6jRZ0YvVItcB4QwbZCPUFEWtoqhOfDt4GJlSoiWVpyT8O9+jrJ/9to1KkZIusd6BuQcZbWLT/eDnMcIMsBVDzzSg9AtW+5mSYEsC4nn43H/II0Yaw9ONXBO6eyKDMd7yUsSK0imCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SfRGNbSx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iwjf8d79; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF24425400A5;
	Thu, 28 Nov 2024 09:51:48 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 09:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732805508;
	 x=1732891908; bh=Nvj5qGX5G2PMGXhss3Df4ipdWlAYJ5skJ78Vn1xtCpY=; b=
	SfRGNbSxbf69WwlPPcdB+A1+NjxlMcy0lpC+SSd0ukpKdsJMirQRGMzJO0PBbgj6
	HruG0UkuOekrq50Y0hniLn2OAy9BAcQlhgB+ZLDDmXdTWBW8b4g2/3IuZcNxQuiC
	cnmWeELieUs9ftvYaaNUOcbGe1K2CsydwS0P9bmRHMJroNxWhVxJygo9yMwn1N0T
	IC0nmf+4eT4zlhubQLACHOwiGD6Meq/gkT/Nd3bUIW0Ss1+gsFzqV1hZRZK5sU4A
	ylRNuvq5n0oobNtYZQiME106Cp1uFqBpCqrvZ2XY6tzYizKyoeNIWp3bcpC8jX8m
	99ThUYqk/92PswG0nXLuWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732805508; x=
	1732891908; bh=Nvj5qGX5G2PMGXhss3Df4ipdWlAYJ5skJ78Vn1xtCpY=; b=I
	wjf8d798kFppIMUOEHDpaoZYD04jES73iokdsjAjBihZMPmgE4Q4rtszYHxcO+/y
	U+d8afCiWqQXGroNxxQDPiwUsK8gXzz2DQFioMeLvkApMRoPcFLyGVsJA58S2pS7
	/fY2rED59sjz7CGIi3s4JDz+ogsaHZRqcH3GNBGVxeOHz4IHcNBx7w8Rr877c1xu
	WG94n0x7HDe/m7O1AbQ9x+GWmr5Rs76OtDoitqRFKiC3WnPTA/w6i+sTbAhuKJLx
	hZaPBbkhB3OIylDKrxhFBIOshx08XGDiRkfz9JMlmQUZ35QH2Ujsm3WGGEUA8Yx1
	PZQ6LQZoQhb+V89ZPzOOg==
X-ME-Sender: <xms:hINIZwNXKTnPONIpMt50uNL7VqO-ITF1Gs-RdBHksp7jZbFoSmNLPw>
    <xme:hINIZ2_agJMIGAZYiO4G-v3bIeiqTzg5Qte3HkBIRxN4JKESiQcLf0P18357_-LPD
    BwaMOmx-QK2A6UtUZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeek
    leffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjsghruhhnvghtsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehkhhhi
    lhhmrghnsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvg
    essggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdgslhhumhgvnhhs
    thhinhhglhesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgrmhhlohhgihgtsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:hINIZ3QT0Sm-Bx4zfEyc_Z4ez2O-PnnwY5O8A3YC47TWeATbfKcaWQ>
    <xmx:hINIZ4vsUnEo-YyUZwjxjhTihjtuGvk1V_pBHL2wCwVDsRVhqE5xQw>
    <xmx:hINIZ4ddO5cu1zeBK71d0DcsvEazaW3Ku-eWSx4NOq_WebWWHf3Esw>
    <xmx:hINIZ824qIVlj1SfqluJBHFknWbFjfOG3ulCfXkKzVBc7FmRvT1S2w>
    <xmx:hINIZ5VfYG43sEXFIpDuk6K68328vo1UgBeR13LIUTptMxZ65LhvBHMq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4AED42220072; Thu, 28 Nov 2024 09:51:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 15:51:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
In-Reply-To: <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
References: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
 <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
 <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
 <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
 <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
 <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
 <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 28, 2024, at 15:39, Jerome Brunet wrote:
> On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>>> All clk, pinctrl or regulator are used by other driver yes, this one as
>>> well, sure.
>>>
>>> What special about this on is that it is an auxiliary bus driver.
>>> It is directly instantiated by another driver. That's where
>>> it differs. The axg-audio clock driver instantiate the auxiliary reset,
>>> it does not use it, which is why it makes sense for it to select the
>>> driver.
>>
>> Can you explain the logic behind this design? It seems that the
>> entire problem here is the split into more drivers than it
>> should be. It's common for clk drivers to also act as a
>> reset driver, and my impression here is that you were trying
>> too hard to split out the reset functionality into file
>> in drivers/reset/ rather than to have it in drivers/clk/.
>>
>> Could you perhaps move the contents of
>> drivers/reset/amlogic/reset-meson-aux.c into
>> drivers/clk/meson/axg-audio.c, and change the exported
>> symbol to a static function? This would still require
>> a dependency on the exported meson_reset_toggle_ops,
>> but that feels like a more natural interface here,
>> since it's just a library module.
>
> That's what we originally had. Reset implemented in clock.
> I was specically asked to move the reset part in reset using
> aux drivers.
>
> https://lore.kernel.org/r/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
>
> Eventually that will happen for the rest of the reset implemented
> under drivers/clk/meson.
>
> It allows to make some code common between the platform reset
> drivers and the aux ones. It also ease maintainance for both
> Stephen and Philipp.

I don't understand how this helps: the entire point of using
an auxiliary device is to separate the lifetime rules of
the different bits, but by doing the creation of the device
in the same file as the implementation, you are not taking
advantage of that at all, but instead get the complexity of
a link-time dependency in addition to a lot of extra code
for dealing with the additional device.

     Arnd

