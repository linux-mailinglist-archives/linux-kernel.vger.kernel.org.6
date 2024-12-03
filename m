Return-Path: <linux-kernel+bounces-429460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB639E1C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF3E167488
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB11EB9E6;
	Tue,  3 Dec 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OWpbv2Sd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQl/Q/j6"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085E1EB9ED;
	Tue,  3 Dec 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229808; cv=none; b=dDurCyfOCc53mWxcuhpVO1RPTnO0R97+ifrxVAzcTJK6esdkBRxgKGsgB9s9XEvvyRBCeOPoPs8t5g8v4zknFe1BJ8NjxCjS5zD7j5tvS9FVS/aXB4BE8WJKef8kpAP60JMRL6eIkboSEmOGAMC4r+QXEMM4rvyhyYpDB4cT7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229808; c=relaxed/simple;
	bh=Lv2Z6NbTKMdxZZtSRvaijlwyt37zgKQUjTIZPiJEhLM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RtQFXj7ODv2RzWVBCP0XcF+VLQ7cF15zMeBchM7TY+AKeIaea7iNMTqBuplcEQcn5fLkrPughUpp6G2clNVIjY40GPaQNUJ5CrVppWtlRqC8ycgrJDljsJ4tLrecGqTkYqHcK3wUqlawHGI7oFMl8CJTmVnUL+sMpghN4LrQvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OWpbv2Sd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQl/Q/j6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F9A41140120;
	Tue,  3 Dec 2024 07:43:24 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 03 Dec 2024 07:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733229804;
	 x=1733316204; bh=e3rwoHqIVnmxtNxDPSG6Cqf+q8c4DgmmReYZaA9pX3Q=; b=
	OWpbv2SdQuVdeXsxgYdIYA/KQEOsujuHaYuE+skl6m9P5hdrE1UaFcyybQkPuq76
	6bDBp5NqD2kG0j0jDI6+04wCI5uvt1TO1z92YBGOc33JBgoO/zGJ7xpXQnYwB5VU
	667WPgV0VTiOBBpkrYn1oW+AajdtHHYz6yjw5weKd0VHoteQxB+Sni1pyWC94cVn
	oyFzT3pAVGLUe7OzVVq9M5pz5Jti3NLHzc3+9ZdMpRBKGK8Veka5ELFQby51OiUr
	+1jr9TL1AJxvhzsOWtsUmoZ5MzY/TNz7PGb7rrIVtaHXyYXgqgniHuQDEzfkh6o4
	fFAjI8NgK94sk2ElzYY0PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733229804; x=
	1733316204; bh=e3rwoHqIVnmxtNxDPSG6Cqf+q8c4DgmmReYZaA9pX3Q=; b=K
	Ql/Q/j6EGWizSaPnM78KL9nimX4jWHu9cNWoF4HcO7W/wVQ1uUjxhZFhTTfx5Aqa
	33M2uwreBzdZ3DpqTmvU9GsBnGJ2GjS79KV6sFxNvqIOKmm2TJyKdUUhVFzEBEDb
	lyqQYwbrXuCV6yN+Unumr0KACnFBJH18vNTwqmfdn2113Vjze7mf4HCB5Kc7g352
	8qWG+EANLFAd/r6OQYNVyMAloDENk/oyZBqHUwQMx8ARCxhZuq1mr5QNc0tIVy1G
	UDhSXHQ/HU+fKLtkUQDQtrCBozEGl8F/KA4WbYh/NRa+QJrAKdCSCdjHG60cVwqd
	Oo3OPhib3xoDag3C274eQ==
X-ME-Sender: <xms:6_xOZ37LmToeylSHwE4pDy2CC6E5m2h_r4emE7KwttNNJVQHVt814g>
    <xme:6_xOZ870bERLOl4bEyq42aEL1h4E0640CllVZme8LosqvVIuXgXJ4C9HRHoJHCkcP
    5RY2rk4pE1J9tS-748>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdduhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:6_xOZ-ennU-tpmMXwOsu6RaxhRKa7cQJ3SLICt0PVwd4NRL5gMtdig>
    <xmx:6_xOZ4Jz0epV8mXeYVZkTuiQXVfz4hRW3uVdMBbCiJgN2KBOEe3SwA>
    <xmx:6_xOZ7K-EJ0vlzGs_aawZZIr1KnCETj6hPiF1n82ixW_cVLWxCwPXw>
    <xmx:6_xOZxy6c5QJ1uApKdY5MSpVFiSi-rLKFyt4L4vkrPcScJcNH3bxoA>
    <xmx:7PxOZ4BhzLtJMlJEFOxcFCY0DqjofD7tFay4QLAAL-V2FXPVnqzKTQKW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 913E62220072; Tue,  3 Dec 2024 07:43:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 13:43:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stephen Boyd" <sboyd@kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <0f07300a-8b32-4d3e-a447-b3fe3cf1ca81@app.fastmail.com>
In-Reply-To: <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org>
References: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
 <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
 <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
 <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
 <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
 <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
 <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
 <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
 <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
 <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
 <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2024, at 03:53, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2024-11-28 07:34:46)
>> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
>> Stephen, can you please take a look here and see if you
>> have a better idea for either decoupling the two drivers
>> enough to avoid the link time dependency, or to reintegrate
>> the reset controller code into the clk driver and avoid
>> the complexity?
>
> I think the best approach is to add the reset auxilary device with a
> function that creates the auxiliary device directly by string name and
> does nothing else. Maybe we can have some helper in the auxiliary
> layer that does that all for us, because it's quite a bit of boiler
> plate that we need to write over and over again. Something like:
>
>   int devm_auxiliary_device_create(struct device *parent, const char *name)
>
> that does the whole kzalloc() + ida dance that
> devm_meson_rst_aux_register() is doing today and wraps it all up so that
> the device is removed when the parent driver unbinds. Then this clk
> driver can register the reset device with a single call and not need to
> do anything besides select AUXILIARY_BUS. The regmap can be acquired
> from the parent device in the auxiliary driver probe with
> dev_get_regmap(adev->parent).

I like the idea. Two questions about the interface:

 - should there be a 'void *platform_data' argument anyway?
   Even if this can be looked up from the parent, it seems
   useful enough

 - What is the scope of the 'ida' number? My impression was
   this should be local to one parent device, but I don't
   know how the number is used in the end, so maybe a global
   number allocator is sufficient.

       Arnd

