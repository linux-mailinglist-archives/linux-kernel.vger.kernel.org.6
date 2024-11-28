Return-Path: <linux-kernel+bounces-424783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79CD9DB959
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C64163AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A21AE00B;
	Thu, 28 Nov 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cLj0RLHG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7oCvGV3"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455B145A0F;
	Thu, 28 Nov 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803143; cv=none; b=ZGYHO2FY+Kht733evE5W54il4Bhn3M0e6piB2r+nOOj09vGeVF0WXNg4KSqGE+r8p172gXhNvo8LZjmDghk8eQpvKHeMnLnVQqe8Cs9Jqv6cS4EONrFhs8+x6UjV1KR8kTCAiGdotoBKchsQOWl0GogX79apa2lCCIItJWwuzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803143; c=relaxed/simple;
	bh=OcLfaaYYWwzI0/pYy/cZOKqOhYIXgbBKdUDIRpnWSLk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gLdCwkUf0oAAPZM38hUnS/4Ot9kC64jzz685YZG+ZjF0ez3Je33XEIygqYGX1hdZomRY6V5MyD3L/Oez53blFNw0czFd1oxLWxxu5/0QNvmObGF3u2nTpHJlJd02DgQqtFNSCkjeBh50BmTwDKXc7l3oi1lUVehGyntUiOI8Kpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cLj0RLHG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7oCvGV3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BDAFC114018B;
	Thu, 28 Nov 2024 09:12:17 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 09:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732803137;
	 x=1732889537; bh=53dfOzVmJQypdRBGQEw+/C6xquQgJGoz2MLq/Iv9RFQ=; b=
	cLj0RLHGjpFa5JldyNUe4RiLwdBQ+gSbloKo02q7zR9V3veBsqm9sC7x1yBrbUgB
	/U47zkwzcAEPnz2tAZ0ZGYqGV/ePwBwgvLWhE5CxcQwMZdyAeb7+K/Rq3c8OkWmU
	/NkqMzVpmyW1Y883daQXrRuPSWhc70sarEbsnDBx/wDdlElmN3ZKa+hm2XKkEYUz
	BDBusArMWZrcziEc4QrXa5FhkX38tO+CSBpJNNIsouCQY0XoifukOKWsdvZf+ZC7
	CQ3KZwSC82yO2eSfyHyMZnevEXyrO7KWBNllVPiXc7P1RBMQiET+BotOaxQfKWDO
	AuCpI9Uu/y4oZ61Uvf+org==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732803137; x=
	1732889537; bh=53dfOzVmJQypdRBGQEw+/C6xquQgJGoz2MLq/Iv9RFQ=; b=c
	7oCvGV3Q1h7CGzm+YVKdM608SLP54gfOuWP7MTPiUt2o+BVyspiCsJkR4ng0vYG/
	9747WXl/Iv08O//s69JBuHm1g5j5i5y6/jWunD5EZh6pzW586ej1fawW08izJR9i
	ujPNzbuK+UOD0hILKdqnP0DdvaVpSPVoNpgjHIb9G9wDw79i2niQIuA5DLRELqXs
	TWkUxUkZfMRoR6E50MaWsukZ5pl0NOvgpaYRZJNRkpJNGeWNCgv/I41Y9z1UgBgj
	bi8nWWBwlZnxVa301dsMgnw/0lXqOYWtToCk/2zS3K5vZXYH5kIV52YmlLRuSnJz
	KS4Ow9sM5x22PAySJGULw==
X-ME-Sender: <xms:QXpIZ8qzWVZJi8Rf33OCKo52P5-UepIx4NMuxSIJUy5VRJjpGRYbng>
    <xme:QXpIZyol540eSbF9SBFK9-cTJBkNxehqN5yr9-y4cKS7dkPOKpbMy1RAeleCSR08F
    0Pusx28dWVmBqbTrlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgsrhhunhgvthessggrhihlihgsrh
    gvrdgtohhmpdhrtghpthhtohepkhhhihhlmhgrnhessggrhihlihgsrhgvrdgtohhmpdhr
    tghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtth
    hopehmrghrthhinhdrsghluhhmvghnshhtihhnghhlsehgohhoghhlvghmrghilhdrtgho
    mhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhdrrghrmhhsthhr
    ohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghmlhhoghhitg
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    rhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:QXpIZxPn5rxxB64Glh6_weGNdT5ip9nlyqxeMiNGwA-ksc4NkQw8Eg>
    <xmx:QXpIZz7hUqaG9iRv3BVvH_KQTbr0OS8f4kQQFBmTZSW7PapNaCw4cQ>
    <xmx:QXpIZ75fE-2pXSHd3bcNjtJczAUGC7zFMmAc2me8OMOcmDTHPxjC7w>
    <xmx:QXpIZzgUU-F46A1yvnF9jF5sAnaBoIO387BZIViMwxfyERjMCAjtQg>
    <xmx:QXpIZ4xdKYuttpVMqNnQrJ_2qXE_y-li76YlRBhCcaHGHUGwAxNwibFU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4FE182220072; Thu, 28 Nov 2024 09:12:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 15:11:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
In-Reply-To: <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
References: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
 <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
 <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
 <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
 <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 28, 2024, at 14:33, Jerome Brunet wrote:
> On Wed 27 Nov 2024 at 22:23, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Wed, Nov 27, 2024, at 21:56, Jerome Brunet wrote:
>>> On Wed 27 Nov 2024 at 20:30, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>>>
>>>> It looks like RESET_MESON_AUX is a user-visible symbol,
>>>> so you can simply ask users to turn it on, and add it to
>>>> the defconfig.
>>>
>>> That would work yes but It's really something a user should not be
>>> concerned with. I can follow-up with another change to remove the user
>>> visibilty of RESET_MESON_AUX. It is always going to be something
>>> requested by another driver.
>>
>> But that's true for all reset drivers, each one of them is
>> only useful because it's going to be used by another driver,
>> same for clk, pinctrl, regulator, ...
>>
>
> All clk, pinctrl or regulator are used by other driver yes, this one as
> well, sure.
>
> What special about this on is that it is an auxiliary bus driver.
> It is directly instantiated by another driver. That's where
> it differs. The axg-audio clock driver instantiate the auxiliary reset,
> it does not use it, which is why it makes sense for it to select the
> driver.

Can you explain the logic behind this design? It seems that the
entire problem here is the split into more drivers than it
should be. It's common for clk drivers to also act as a
reset driver, and my impression here is that you were trying
too hard to split out the reset functionality into file
in drivers/reset/ rather than to have it in drivers/clk/.

Could you perhaps move the contents of
drivers/reset/amlogic/reset-meson-aux.c into
drivers/clk/meson/axg-audio.c, and change the exported
symbol to a static function? This would still require
a dependency on the exported meson_reset_toggle_ops,
but that feels like a more natural interface here,
since it's just a library module.

     Arnd

