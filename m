Return-Path: <linux-kernel+bounces-176363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD328C2E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410AD283287
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66A134BD;
	Sat, 11 May 2024 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="Jo4bop5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ct/TTj0a"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AE11184;
	Sat, 11 May 2024 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392168; cv=none; b=HRK2XC/+ziSMrkp7Qq8XcdPWMWe3zTGsB7U5Yw07OlVPwwq4mh0xAQcqyOzA8yNrIYIXLkAKF68+7zEy7vaPnF5i+QvrlCmh/hl3Qm/fpL8kSVAIlppYeDDt6/eO3VyXJUdhexK/lUOfEdth1J7HN3L1xH0N0fhCJZUGPLuQMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392168; c=relaxed/simple;
	bh=S7WwEQQOLsNIt17Nax//c7rebtZYboLt0RIkp+0V6qU=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moPf+nHvWsAKzNy0L2h3EmP+BqP8vwBEVjdYTN3S0bhaKBuFMmJ+CcyIfDdHw9HtiYWy/XtYPRc9tCdw3jeEA2t2rmgdKt+b3MMKQO79BwuzeaE96n+bM+oifF16sSUWtrLMOxkD9mBGrgn3204c6ijIlHPf47kl3EbH6DFSoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=Jo4bop5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ct/TTj0a; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 873261C000E7;
	Fri, 10 May 2024 21:49:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 10 May 2024 21:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715392163; x=1715478563; bh=ocGjqcakjU
	5+Ytvyo0/yI73nxxOTe7gkTsRT02X55Ls=; b=Jo4bop5jUsRKcgqfYDiYcIv1ag
	KPHdKi9434vRBrW58z0GQiLd0qjMdMHQkfElB2DbhcrPZ6ZGq4bASfgO2s7tK3uL
	70hG/0yewzM2zFz54KICy/hs0OBnewydn1Em0PeEDzlXbvSCIkyAGI5nSSCq2atQ
	4bl8xvK6xiFhXW0hHqQLZifpCyQ9AGv81Mjgd+xjuShzZr5SXblt+2uBR2fM/AMj
	eQ0qoT+VqOt3WtxDxHpAWBt+mcqYm/TanTrttczRr+Kb1q5hDuTrO8J4pYLfdSeR
	dKaKEsyWqghRR4cdP5Pe8dp3zzY8hufWl0CaVP392d7DgF70khZrpWioOsOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715392163; x=1715478563; bh=ocGjqcakjU5+Ytvyo0/yI73nxxOT
	e7gkTsRT02X55Ls=; b=ct/TTj0aL6y1O9TeNI6yoCk45tfTG/OhPni3PEMPGBTe
	87ec6Y0CMQWUnnP/nPnJD/O/RiO4/dyvwPaXvl+VJBCXvbiSpEiljLj7YGLdYWeg
	k/pNdcTCCjS8G0FkN/rc8TTXASWxVZvGf4QkFwra913OYZUbMdfsjLvVSBR2I4e6
	UNVNZAsKnEP2khlY9vdeNG645kdNHVZb8kxoy+DQAWj2hgjLBje/o/eL6TbgFKPn
	4WAy337rVfsBrPh/oKzbFuZBikic7vFs3HxqboXsGP9lTUjG4AAKRFCPQKlByFcj
	iW3t5hlCaOaVw54BwFmjtOweNg0713mYYhiyzlbRbw==
X-ME-Sender: <xms:os4-Zh0h1vYY954Lz10tQMrJtPeLQdWUVl1qcK5fHpmPWCjSI2aNFg>
    <xme:os4-ZoFDnm85wEB5TDnEjw00UaS7T2BOQkTjVdYI4GjEKFWWh-QMPuOekVQNGn9fP
    eksLa_yPdqnm3hNeLU>
X-ME-Received: <xmr:os4-Zh78VMdHn6a2aYg8Zpkgv9z7sOe0jeNMQeMothIhPK1sJSBbrRtuW2Je8vQjbnJsk46-MCdh7h_J4Z5KdWXlbSjQfX82iVDsNRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepfefgheevfeeugedtjedugfeitedvuddvjeegffegfefhtefgvedutdfh
    geekueehnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhih
    nhguvghnohdrtggr
X-ME-Proxy: <xmx:os4-Zu24Pe4ZjCSILB3YreEGVguABFLqyJXh-uhJaa-TRqgcKnqTbg>
    <xmx:os4-ZkFvLCFW_6IAd_Dhbas-Jga-pA_xkrvjY7bmRbn1xrwIthUk5g>
    <xmx:os4-Zv9gsnoSjQQEeP2rBLcN2FM_G20iZyxX3Bszzn-l_7crkwSWVg>
    <xmx:os4-Zhn4yYCVROVX4nMZMHuJP-IYNbTvRQpve9_cCUwKp_iQEgoH_g>
    <xmx:o84-ZqHexmMhD4v0fL5buPiqFfTlbc4f3Wlp6_OxqjeWJ2ddwpYbkZmL>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 21:49:17 -0400 (EDT)
Date: Fri, 10 May 2024 19:49:09 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: "Shen, Yijun" <Yijun.Shen@dell.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Pali =?iso-8859-1?b?Um9o4XI=?= <pali@kernel.org>, Armin Wolf
	<W_Armin@gmx.de>, srinivas.pandruvada@linux.intel.com,
	Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	kernel test robot <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, platform-driver-x86@vger.kernel.org, LKML
	<linux-kernel@vger.kernel.org>, Dell Client Kernel
	<Dell.Client.Kernel@dell.com>
Message-Id: <X1TADS.8PTII3LXSHHX1@lyndeno.ca>
In-Reply-To: <aaa1ebb5-3e0a-40ef-b53d-d8adc1589085@app.fastmail.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240501215829.4991-2-lsanche@lyndeno.ca>
	<BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
	<aaa1ebb5-3e0a-40ef-b53d-d8adc1589085@app.fastmail.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Thu, May 9 2024 at 09:10:51 AM -06:00:00, Lyndon Sanche 
<lsanche@lyndeno.ca> wrote:
> On Wed, May 8, 2024, at 8:24 AM, Shen, Yijun wrote:
>>  Hi Lyndon,
>> 
>>   Thanks for working on this patch.
>> 
>> 
>>   Dell side has an initial testing with this patch on some laptops, 
>> it
>>  looks good. While changing the platform profile:
>>  1. The corresponding USTT option in BIOS will be changed.
>>  2. thermald will not be impacted. The related PSVT and ITMT will be
>>  loaded.
>>   Some Dell DTs does not have the USTT, Dell'll have a check if 
>> nothing
>>  is broken.
>> 
>>    Additional, with this patch, follow behavior is found:
>>   1. For example, the platform profile is quiet.
>>   2. Reboot the system and change the USTT to performance.
>>   3. Boot to desktop, the platform profile is "quiet", the USTT will 
>> be
>>  changed back to "quiet".
>>   This looks like not a proper user experience. The platform profile
>>  should honor the BIOS setting, aka, the platform profile should be
>>  switched to "performance".
> 
> Hello:
> 
> Thank you for your email. This is definitely undesirable behaviour, I 
> will have a look at the code to see why this is happening. Does it 
> always revert to quiet on boot, or always the mode that you had 
> switched to prior to reboot?
> 
> Do you happen to have power-profiles-daemon or something similar 
> running? My understanding is it remembers profiles across reboots, 
> this could potentially also revert the profile back to what it was. 
> See this release for details:
> https://gitlab.freedesktop.org/upower/power-profiles-daemon/-/releases/0.9.0
> 
> I will assume there is a bug in my code at this point. I will test 
> with and without ppd running on my system to see if it changes across 
> reboots.
> 
> Are USTT settings exposed in your BIOS configuration menu? On my 
> laptop they are not and I have to use smbios-thermal-ctl.
> 
> Thank you,
> 
> Lyndon

Hi Yijun:

I tested this on my computer (XPS 9560). I do not have access to the 
USTT settings in the BIOS screen so to substitute that, I booted 
without the patch and set the USTT manually using smbios-thermal-ctl. 
Here are my findings:

Scenario #1: Without power-profiles-daemon (ppd) running

1. Boot with patch, set platform_profile to quiet
2. Boot without patch applied (no platform_profile)
 - smbios-thermal-ctl confirms USTT is set to quiet
 - use smbios-thermal-ctl to set USTT to performance
 - confirm set to performance
3. Boot with patch again
 - platform_profile is set to performance

Scenario #2: With ppd running
1. Boot with patch, set platform_profile to performance with ppd
 - Confirm platform_profile is performance
2. Boot without patch applied (no platform_profile)
 - smbios-thermal-ctl confirms USTT is set to performance
 - ppd reverts to balanced (only controlling intel_pstate in this case)
 - use smbios-thermal-ctl to set USTT to quiet
 - confirm set to quiet
3. Boot with patch again
 - platform_profile and ppd is set to performance

In my case, the setting in the smbios is honored if it was switched 
with another method. When using a userspace program that manipulates 
the platform_profile, the program seems to remember the previous state 
and switch to that.

So I do not think there is a bug in this patch related to this issue, 
at least in my case. Please let me know if you have any questions.

Thanks,

Lyndon





