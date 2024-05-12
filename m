Return-Path: <linux-kernel+bounces-176779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A808C34C8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867571C20EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD01FDD;
	Sun, 12 May 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="KoVW1USz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k53hAaUO"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB032363;
	Sun, 12 May 2024 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715472891; cv=none; b=gwbOb/lbvgtVX6KTxMM2C1jhbP1j1IlDizpKRvjlB9M/NpJv00ni7SaiX1eRqbWGdaY5LRlpBI9S50JGVOMDbzr9uJNz1T89btRxwbHCGFbEJvmIkY0WcfjggEVc+THwISQvBPGcQq6klEQ8uaF+SZD6B7F+wlIFjP4mIUzN0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715472891; c=relaxed/simple;
	bh=nzkbFRou+iaXiDduwf6Q2SfA+//b5YL/++/bmVUT+rE=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyBWso7S6no8Dc5NFgKnj3b298zqqNBVwemClZyMpbN7dhMNGKMQ8fuxyXORlcCgvZ7M0Eav3g7UgnLXfX07t924Yu8z6cxq+KsGp90jE6npcjy5Oe9zmhYflan+CSd0r92hYL4+NB+T8uOyZmcar6UkqZxrWHdC5V/IHkkVtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=KoVW1USz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k53hAaUO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BA18811400D6;
	Sat, 11 May 2024 20:14:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 11 May 2024 20:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715472887; x=1715559287; bh=c6doAEYnIq
	jrrHM2MDoHuTdMl+vjtXuzWQEYI9/Q2Hw=; b=KoVW1USzLff15+iz44EUfBxWNh
	f3PwdhdWzAgOuKeIPXXZv0KZkg+v+CIyxHpGfAahgxjGPkMKtMbWba+YUHzf69Sm
	fzZ7MkABkmoFKl1YJ4bA+j15oP/hNJ6+HpfCvBn9IcxrOizrVnXC9n8lib9eCSi/
	o6uQP/pB7uPsSCVgBXp1LG3oQKGsjPQ7Gd02SGZSJn/DZlEov0ZvRU9uhzsf8sgt
	k2TgegNHF57hJd73VBdkCrXQ9zORLao0K6ZENt814MKp9SzV3OW/C6v8vqyIsVMK
	7jaS32bfjbHyTzLm7e8VtLIlI7PxFDtfBqhd1ib4kUl37mvApnyLD8qRxOig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715472887; x=1715559287; bh=c6doAEYnIqjrrHM2MDoHuTdMl+vj
	tXuzWQEYI9/Q2Hw=; b=k53hAaUOsc7dym57eMykNLGQfuUEjbMXveyORUXO8jDZ
	qGwghJWxtfWoYhCx8LXClCrmsnwtRA/fnHS7l5pW438qZO1elvMQ84l9uVZXnlqF
	T5UPNHpku/glaLctNSvstePuqfWPArMx15xCc4CVdjOSe3zH92neJmSI/KwqelXL
	WCBZ/tRpIB86eXzhOtRC7eNcmbwlfKKu+XebJGQU4Jy5DSV76dAYNRE76BF19JMC
	2P/urwjoieC8mT8E5kLhDqzfRS30xRkxXK/PsGPu8bbFOcYun+zxnmyBV7XpQ3xi
	v+y27jdUay3A3/kDzP1hDZJxuJkmcLoSwO5aOpNrYw==
X-ME-Sender: <xms:9wlAZiV3_MYUsiyiOiu04Bp9xcpjFF6STRBfUbUA1KrWLaAtTkQguQ>
    <xme:9wlAZukUnMDMKGKraMbKvq68xJHMCYQl8c3CDsJmD5A82MVps1EzoAQPmz5n3HKbX
    QDTQkg8SAIsnW_1e4o>
X-ME-Received: <xmr:9wlAZmaVaolxR9suTSwQAya-4sPsudtshE9NIgHK8-4mnRs8jLIiQ-RjVSguvcML9RrkanH4jO88v-eHnjZHzu62XK6ohQ89e24LUUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeguddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepjeffueekgeeijefhvddugedtkeefveevtefghfevfeeufffgvdevleei
    udfhtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:9wlAZpWshrfrJ7KNwv4nj2N6-bDrzsZO4yQRfh2s--zgHsS8BaQkZA>
    <xmx:9wlAZskdBa-Hl3aRPRjTKY-Y7zB_P3K1i2295Jzgex6WgmnrkL-E1g>
    <xmx:9wlAZufgImKddnKIMctM4huazZe2PnptdsnFfv9KW4oszM2jT6vFAg>
    <xmx:9wlAZuHdejhCY6UuGGWvErcGhHKik1Ue28d25aguAFEw1s16e8JxiA>
    <xmx:9wlAZm3NY37imjmxz8TOhQDbMz1DsaNdEhUr30wrP2srxwRFOARExQYV>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 20:14:44 -0400 (EDT)
Date: Sat, 11 May 2024 18:14:36 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v6 2/2] platform/x86: dell-laptop: Implement
 platform_profile
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, lkp@intel.com, hdegoede@redhat.com,
	Yijun.Shen@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet
	<corbet@lwn.net>, Vegard Nossum <vegard.nossum@oracle.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Message-Id: <CCJCDS.REE5U5RAV942@lyndeno.ca>
In-Reply-To: <9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240511023726.7408-4-lsanche@lyndeno.ca>
	<9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



>> 
>>   }
>>     /* dell-rbtn.c driver export functions which will not work 
>> correctly (and could
>> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c 
>> b/drivers/platform/x86/dell/dell-smbios-base.c
>> index 6ae09d7f76fb..387fa5618f7a 100644
>> --- a/drivers/platform/x86/dell/dell-smbios-base.c
>> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
>> @@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] = {
>>   	/* handled by kernel: dell-laptop */
>>   	{0x0000, CLASS_INFO, SELECT_RFKILL},
>>   	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
>> +	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
>>   };
> 
> So when Alex checked on v5 that this doesn't load on workstations, it 
> has made me realize that doing this will block the interface totally 
> even on workstations.
> 
> So I think there are a few ways to go to handle this:
> 
> 1) Rename dell-laptop to dell-client or dell-pc and let dell-laptop 
> load on more form factors.  This would require some internal handling 
> in the module for which features make sense for different form 
> factors.
> 
> 2) Add a new module just for the thermal handling and put all this 
> code into it instead.
> 
> I don't have a strong opinion, but I do think one of them should be 
> done to ensure there aren't problems on workstations losing access to 
> thermal control.

My apologies, I accidentally sent my response in HTML format. Please 
see plain-text below:

Thinking about it more, we can leave dell-laptop as-is and create a 
common dell-pc module that does not check for specific form-factors, 
assuming that is possible. Thermal management can be the first function 
to go in there.

We will still block the calls from userspace regardless of which 
modules are loaded. If dell-pc fails because thermal management is not 
supported, we aren't losing anything by blocking that call anyway.

Thoughts?



