Return-Path: <linux-kernel+bounces-193122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63288D271E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2891C21BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3917BB16;
	Tue, 28 May 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="d20xLBfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxHWfasx"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45217B4ED;
	Tue, 28 May 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932096; cv=none; b=su1VT0ReQXjE473f5Lo7xP/wIDTRuJRA6SlHhztBdwsMpsViwcI9bA+JXkqCUYVkG4pJ0YBgQ3Ixe/1YGlT20WZxLWSXyg6oAIW54+O2XML9mTO+obJJsqj+fyCmWDjWKTK/w3USZmfGBhfCUz826zN4zkLmXy2INDRFmo6bFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932096; c=relaxed/simple;
	bh=OTUUZ1IOGn8N+025jO0LdHeT0aqbBWd4vImEqG7ne7A=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XYknWr2kDOj0uOWKIy01tORUBYKkxPH9iDw7JXs97ORQ/05g5a2V1ob0GQlOOjZBpWH7iS34dled2eLifrpQP8ah9HOfwxy/xmpqGCOXUAvUfbuo1pqA27rD9LJ1h3/6jhwkq1bs2rNcKVDoAoFS8VsDKm3TozZAE1ebtfVZ6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=d20xLBfh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxHWfasx; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 68A0E1800103;
	Tue, 28 May 2024 17:34:53 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 28 May 2024 17:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716932093; x=1717018493; bh=y7ZRNcwP4p
	jwdqwTtRlAY8w9sm0m48WlVfyUcA5amrM=; b=d20xLBfhlxbkU/SYrMvR0eoi4o
	P38uCGbL00szFMDeewkI5QLC0D9lUUXnL6xEI50wsxHaIDYOe9jPRGjjkvuISphu
	Kdgxk60UDYKdlAWA4hFbUAKjsOXPpUVm3Lbrathqh57/y69dU1qcIUUI/8QJQxbv
	0U7d6qeTS/zJunOInz5ACXTEKg9xUCkN0+bzcYGCYKbahFH/TWDMe+tAAwfkv5Aj
	4yxjPH5daLuOPpag3lKhHtHHPJ/Wv96r8AJddl7+EVWQpowmXxmqz2v99KIB2vNr
	zZPwCqMV4fxaU5V+F2jx1e0Lddzy9UmK1a472ZgZrZC8Lq9ZOjygCplZ4Myg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716932093; x=1717018493; bh=y7ZRNcwP4pjwdqwTtRlAY8w9sm0m
	48WlVfyUcA5amrM=; b=UxHWfasxL/NE8+/ONWIR9lUhoc95gRWvx5oR3Y3PVbmF
	pKfW0GtmXJ32YtR+62MwLQaynFI52BNUQuzXu01BDal8JNNqSyFR9SqzDhc1Im66
	Hmop0qAsoi52cGdQBZLu07TJNw/p6e1FOEIIRz6BV9TQIJ/W5YupBoFic1SHgfew
	s0JkemMGHOgbp3Ap9kGqAjibJlnjUUGOtdg5Np2HnNI5BWCrUgxOQpEdeCYecJwC
	lI2sT4i8Z+qp/K76FGDyEeDUzEDMjmQO1LfgtnkVS7YiWTnnsvNKLBrPai1B1Hyi
	rvKOcUFFaYkw8IMkHPdon8LJPeWWH7O8G/mXdXzLEA==
X-ME-Sender: <xms:_E1WZtmg2yYELxxfD-PVzMXAgBXDX0E5eBx6B9eUcVhNbA5PF-sHiw>
    <xme:_E1WZo2OCJyzDKKUwG874-CivXU89e3s47MrAH2tCZeN4shtUTOJHsj7UwvP1gppn
    NzavxcQvWRtQs0T_OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffv
    vefutgesthdtredtreertdenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukh
    gvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhephfeivdehffevtdehhfdt
    ffefheethfelfefgveeifffhgeeihfefheefhfeghfeknecuffhomhgrihhnpehgihhthh
    husgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:_E1WZjq4E8c3oEltPliO-RzJtT5qXLIpwQ8IgvtySU_4TOV3aiB25w>
    <xmx:_E1WZtn4ROESPwr608vRYbvoR9EEN7XgiHLQWkZo6d0TbGY8vzHMIg>
    <xmx:_E1WZr2uQLTd3A3yIHKz9CH7nLe5zqMSPBN4VCKTQ0nBzshRXixlyQ>
    <xmx:_E1WZsvQqlkLPYdiBbBme-IK-WDvaTd2eayflGC8_WwXkGu6usaPqw>
    <xmx:_U1WZr9icwl-iSU2Aj3UjbxC5xgV_aTnClx3XnlgA6UvNNSXkSfgb5x_>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 957612340080; Tue, 28 May 2024 17:34:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d4e7f1e-ccd0-4ac5-b450-f9c5f8d5c90e@app.fastmail.com>
In-Reply-To: <371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com>
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
 <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
 <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
 <ac597520-fb5b-40e5-ae1f-de825450d2db@app.fastmail.com>
 <371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com>
Date: Wed, 29 May 2024 09:34:31 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, richard@hughsie.com
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
Content-Type: text/plain



On Wed, 29 May 2024, at 9:16 AM, Mario Limonciello wrote:
> >> For any "new" attributes it's better to put them in that API than code
> >> duplication of the BIOS attributes API as well as a random sysfs file
> >> API that you can never discard.
> > 
> > Do you mean the firmware_attributes API? If so, I'm not opposed to adding all the existing ROG attributes to it also.
> > 
> > If I'm understanding the docs correctly, for example this apu_mem attr would then become:
> > - /sys/class/firmware-attributes/asus-bios/attributes/apu_mem/type
> > - /sys/class/firmware-attributes/*/attributes/apu_mem/current_value
> > - /sys/class/firmware-attributes/*/attributes/apu_mem/default_value
> > - /sys/class/firmware-attributes/*/attributes/apu_mem/display_name
> > - /sys/class/firmware-attributes/*/attributes/apu_mem/possible_values
> > - ..etc
> > 
> > That's absolutely much better than what I've been doing and I wish I'd known about it sooner.
> 
> Yup!  And even better "fwupdmgr get-bios-setting" and "fwupdmgr 
> set-bios-setting" [1] will work with bash completion too.
> 
> If you want to build a GUI around it, it could use the fwupd dbus 
> interface for getting those settings and manipulating them. 

My existing GUI effort revolves around me adding these attrs to both kernel and a dbus interface. So if I can drop that then all the better

> The dbus 
> interface policy is protected by PK.

What is PK? And I'm guessing this restricts users to requiring permissions to change settings?
 
> > 
> > So if I go ahead and convert all the new attr to this are there any issues with also converting much of the previous attr? And I'm aware of "don't break userspace" so really I'm a bit unsure how best to manage that (would a new module be better here also? "asus-bios.c" perhaps).
> > 
> > What I don't want is a split between platform and firmware_attributes.
> > 
> 
> My personal thought is add everything to the new API and then hide the 
> "old" interface behind some boolean Kconfig option that defaults to 
> disabled.  If someone enables it then when it's "used" (IE read from / 
> written to) then do something like a pr_warn_once() that it's a 
> deprecated interface and it will go away.  Wait until next LTS kernel, 
> and then rip it out after that.

I'm happy to do this. On a serious note though, I should make a new module for this right? It would make it much much easier to manage the "conversion" I think, and then it would act as a separation of concerns.

> 
> Need Hans and/or Ilpo agree to make with that though before you spend 
> too much effort on it though.

Ack

> 
> [1] https://fwupd.github.io/libfwupdplugin/bios-settings.html
> 

