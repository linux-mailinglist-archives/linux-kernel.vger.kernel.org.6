Return-Path: <linux-kernel+bounces-174620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA78C11BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E721F23F52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0115E7F2;
	Thu,  9 May 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="wseeupdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRVh6Xz8"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DD13C672;
	Thu,  9 May 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267518; cv=none; b=YmFAA5ZSwBBY+Kz/DvR8L9VL+Lzgz/Fu7LjmL562fHV8ApUZ8XfICi45Sk0RyRgsW1PvavZhM90PbdVeLp+CKxldUFe8ShK4azowMEz9Esg6ZesvAYjsVw+Qu/ztgRRXyHU6qPyxI82DxBTLNI5fA98YA8nA+3VgTeDDUTfYTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267518; c=relaxed/simple;
	bh=S0Je4Bi3wxZqJxDWwfO4lgsyHN9V5CWUEMEoC1uRP1g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tqC1aOBq2YHdRmMiQnEKIUdj8TMjBNumruGBUugmYyzOTundbeY79Absdu4/HL8EexvnYZnTFlvk/dhwCe7Uwb0AXM755wvp5bRiRHQLMLKCQnUqLKzr+xxNIeJG2YXdYhKfOPUZ8d746r/STjGXw+mc+1WliyDPjFLZ66RZflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=wseeupdL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRVh6Xz8; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 93F8D1C000B6;
	Thu,  9 May 2024 11:11:54 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 09 May 2024 11:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715267514; x=1715353914; bh=uRD3UGMTlM
	1va4wVkCN6cdsRowwChsRjRs6EMV+RywI=; b=wseeupdLcN1/eN/25ElX6mV/La
	+mlm8TWr3+UVqXqSgZzgUyVybwvUaSj7PIWA2Kcdq32bCThrPC2hGunCAXlh2aj7
	QhJAJz2MNT5ZnYdkpiY+1sGo0igw8EaM9MlYLkyiT5YTikOpOw2stbJxh3EYjGzR
	pXXr+U1C//9XfaMJduZ3vZD55GfVsBXuKtQVDVA6BxeZNnyVScPOlbM9eC8M2Mf2
	LfdWj4c3UfjSLlp+pRcljsDGkr7uwBzNZ6+n7TjwSRO/qBu9HCWkj2O3Gptk0z0v
	jjhuL6h9hSZYh7j0Qxtd7suTqfpB2RVjomVJhRZuReB7hQqrx90ZtCnhY+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715267514; x=1715353914; bh=uRD3UGMTlM1va4wVkCN6cdsRowwC
	hsRjRs6EMV+RywI=; b=FRVh6Xz8yWq1oIf9jBeswUd/KHcHWTzpSij7Hd4pMO8X
	aQ61FRVPqB3XYJnauU9BN6C5xyeBZa6+7eOqS5cho4C/dQ+Ozia5S+HeVc8yClaT
	UA9QsBQHjZgSFSyDsdQN/QHqmdOdxW547manvL/CKjl2svcfHHBA9UzqsnwglmuL
	oVxmFd65b1ZmVfm0QdmBZDOJXyIok0HC0KrRyZbsy7yfxh0r41bxPSO6gTbf4fkY
	iEk+ko8etYJ4f8MLBZbC+5hyU/UWegZZh9mo+ecLbseJmsnXo3AQgH62Ch7CmWfi
	KdDWQBFI+LMbBt7A/gX3bZVuf82ayJRSH/Jk37P7og==
X-ME-Sender: <xms:uec8Zkd4UsdElSvVk3wBC1lYzbsWTkoxpRNVHcUq0HR4W9CiX2kvaQ>
    <xme:uec8ZmMcl7EdbRO8awmjHgckfhRAuf7LolNP_FJXOoUmzBjgx1IgYsxgbeY5oGXhG
    SETFXoDnQ0tBIjjwVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfih
    nhguohhnucfurghntghhvgdfuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenuc
    ggtffrrghtthgvrhhnpeejieefhfegtdefieejtdegieelfeduueejvdfgteevveejjefg
    hfevteevledvffenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgv
    sehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:uec8ZlhgfF1SE1AJVXO19ngYR2dd87vbaYB4FUUBW3CZjuopERgEfg>
    <xmx:uec8Zp-Bh_L_NDrjPo_mjyRIWmCcUcEJnCygs_TQIuoBUQjpv6Vz-w>
    <xmx:uec8ZgvP_p6UIHpz246AzXBWo_UvIiY2xynG7zPr5uTpBZXPgIT4fg>
    <xmx:uec8ZgGmjIkfNNg08xSXHkGPiW-uwG4OQJfb5CW0i5kC0PLTUfFLZw>
    <xmx:uuc8ZgHG9LBOw3enlvVslj3ZMsTnXHuQYMrK1Wb3DfZDr4eiAqlzez5y>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75B48C600B0; Thu,  9 May 2024 11:11:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aaa1ebb5-3e0a-40ef-b53d-d8adc1589085@app.fastmail.com>
In-Reply-To: 
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
Date: Thu, 09 May 2024 09:10:51 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: "Shen, Yijun" <Yijun.Shen@dell.com>
Cc: "Mario Limonciello" <mario.limonciello@amd.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Armin Wolf" <W_Armin@gmx.de>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "kernel test robot" <lkp@intel.com>, "Hans de Goede" <hdegoede@redhat.com>,
 "Matthew Garrett" <mjg59@srcf.ucam.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Vegard Nossum" <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Dell Client Kernel" <Dell.Client.Kernel@dell.com>
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
Content-Type: text/plain

On Wed, May 8, 2024, at 8:24 AM, Shen, Yijun wrote:
> Hi Lyndon,
>
>  Thanks for working on this patch.
>
>
> Internal Use - Confidential
>> -----Original Message-----
>> From: Lyndon Sanche <lsanche@lyndeno.ca>
>> Sent: Thursday, May 2, 2024 5:58 AM
>> To: lsanche@lyndeno.ca
>> Cc: mario.limonciello@amd.com; pali@kernel.org; W_Armin@gmx.de;
>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew Garrett
>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner Kallweit
>> <hkallweit1@gmail.com>; Vegard Nossum <vegard.nossum@oracle.com>;
>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Dell Client
>> Kernel <Dell.Client.Kernel@dell.com>
>> Subject: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Some Dell laptops support configuration of preset fan modes through smbios
>> tables.
>>
>> If the platform supports these fan modes, set up platform_profile to change
>> these modes. If not supported, skip enabling platform_profile.
>>
>> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
>> ---
>> v5:
>>  - Fix indent in smbios-thermal-ctl comment
>>  - Remove linux/wmi.h include
>>  - Add 'select ACPI_PLATFORM_PROFILE' to Dell KConfig
>> v4:
>>  - Make thermal_init and thermal_cleanup static
>>  - Rearrange order of added includes, did not edit current includes
>>  - Include bits.h
>>  - Switch comment style
>>  - Return error if platform_profile registering failed
>>  - Add thermal calls to call_blacklist
>>  - Align defines with tabs
>>  - Correct separation of function and error handling
>>  - Propagate error codes up
>> v3:
>>  - Convert smbios-thermal-ctl docs to multiline comment and wrap
>>  - Change thermal_mode_bits enum to directly be BIT() values
>>       - Convert related code to use this
>>  - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
>>       - Correct offset for getting current ACC mode, setting offset
>>               unchanged
>>  - Check if thermal_handler is allocated before freeing and
>>        unregistering platform_profile
>> v2:
>>  - Wrap smbios-thermal-ctl comment
>>  - Return proper error code when invalid state returned
>>  - Simplify platform_profile_get returns
>>  - Propogate ENOMEM error
>> ---
>
>  Dell side has an initial testing with this patch on some laptops, it 
> looks good. While changing the platform profile:
> 1. The corresponding USTT option in BIOS will be changed.
> 2. thermald will not be impacted. The related PSVT and ITMT will be 
> loaded.
>  Some Dell DTs does not have the USTT, Dell'll have a check if nothing 
> is broken.
>
>   Additional, with this patch, follow behavior is found:
>  1. For example, the platform profile is quiet.
>  2. Reboot the system and change the USTT to performance.
>  3. Boot to desktop, the platform profile is "quiet", the USTT will be 
> changed back to "quiet".
>  This looks like not a proper user experience. The platform profile 
> should honor the BIOS setting, aka, the platform profile should be 
> switched to "performance".

Hello:

Thank you for your email. This is definitely undesirable behaviour, I will have a look at the code to see why this is happening. Does it always revert to quiet on boot, or always the mode that you had switched to prior to reboot?

Do you happen to have power-profiles-daemon or something similar running? My understanding is it remembers profiles across reboots, this could potentially also revert the profile back to what it was. See this release for details:
https://gitlab.freedesktop.org/upower/power-profiles-daemon/-/releases/0.9.0

I will assume there is a bug in my code at this point. I will test with and without ppd running on my system to see if it changes across reboots.

Are USTT settings exposed in your BIOS configuration menu? On my laptop they are not and I have to use smbios-thermal-ctl.

Thank you,

Lyndon

