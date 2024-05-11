Return-Path: <linux-kernel+bounces-176620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3708C323B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8C61F21A85
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E635676F;
	Sat, 11 May 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="Ou8m4B77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9ysxKx1"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4B56759;
	Sat, 11 May 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442865; cv=none; b=uQ2CgMjb/WAcDW4zlWDkjn4bhhOcGLrtEOU7Camlpu8x0GaCYwuDfEUlwlQtQz0D2UmgwoxJ2gy2AwR853gL4us+UT4KxpgEQmyEItY+vrJjHQWB4Zh7pMsLs8P9IsDxRq313BCADHmJ5ADw4AMZyL/apYdS0PtnA3fFOK6/eGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442865; c=relaxed/simple;
	bh=/OoK6nS9kWRDr55rLtjnaDygu68ANF3fzQzTvLbCUa0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CgVrSBUIKdoeom/LIU0RIq8RQw8orMoQ1ViYPkhbK065UiAWkzx5NSRz0BgiS4iyyC2u2WJc8G9+o6SKiuJwRNLcQx0CX4lKnHPhXjZe2ZoSkutrvePDPPO8tsKnMyaV444SHhi+rEHquYbuY8Wg39e5ZvAIJu3LhMgmlmxbgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=Ou8m4B77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9ysxKx1; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 927C11C00072;
	Sat, 11 May 2024 11:54:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 11 May 2024 11:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715442861;
	 x=1715529261; bh=r2YwxeN0+AisPuVtRNZ5b9SrAK/2b5bZvbKwS1n6QOw=; b=
	Ou8m4B77KcS8NFxcDCRTKeyuCEBytw76dmOutj4WEVAT8EFAzTiRKB11oelvx/FN
	AjuGFgb7kXp3hQSi1nAY9DlZ3Oppnzc66Bw3cKI97u5dKQh5/7OOs3nXyZY6/kHG
	27Rh8QwM+ChBuDcBR0NYHqr6W9OHAwVJLm/Wo6vM6QaKd3TIpywhMqjpvkIZQ445
	jNQXytNryXzu4PLK5spbDoZ/y2XFW1W1/04zAHdKQrZmIy6ekvZDffwO7092Lurg
	+yqsW3vyXvrkXXpD8KFtrFL8XXptBOthh8IZlVaGh4IEcHctKzqDyiAIAmpm3WeN
	0vaIVqZTYEVP1FfUqQbZ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715442861; x=
	1715529261; bh=r2YwxeN0+AisPuVtRNZ5b9SrAK/2b5bZvbKwS1n6QOw=; b=g
	9ysxKx1s/Y9PHR7uvGkdP5t6dwKBLWd2nSXufUGGaum00aVzNRrTH9YcnHAaRES0
	/IfwrELU2Ge+/ilyn07bMTxfIUhb9hPi6dguIyuDTgSHqCq3fvJHJLFKlNwZsgAd
	KtQeU6iqhvM4O8WhVf0Wyupp1IeDwmQlVv/f7lKpK+WgFMYdoYgpMN3oT/G1B24k
	bcvj9wKdRwiN5SDOKNmchbBJrrGPxkp6NrLrAMl3KnKuQUvocYLeKeMrMGVuOKE9
	+1qugexWGXUR3Jqi6BMyzA+8x2Gb+QRY/dQ5qPXrhWYRfBYbFqceKfSPNNLMCC6C
	WPEQDMhbLxVU4TVcFTgmA==
X-ME-Sender: <xms:qpQ_ZjsgjcEdMYMPNenqvIxJTTqQYzU9OJDMVXLBGbNFnGZuOlbi1g>
    <xme:qpQ_ZkfXZVz54TK8qpF3tcIBdxwlnqKqj-TEQ1yCAmOjqyLO-r0-UaDICoCpHxKlq
    COFyD4dPi-0S_LLgmI>
X-ME-Received: <xmr:qpQ_ZmzLmtV0Ostu11hpSdh0-YqGznpr9AK_8jqNrCAMUOXMZG_7-9e04SksSrncvXTainBeYlaX0rYV6SWGqVkdcU_xFTbycgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevufgfjghfkfgg
    tgfgsehtqhhmtddtreejnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrg
    hntghhvgeslhihnhguvghnohdrtggrqeenucggtffrrghtthgvrhhnpeetgffhffeuheeg
    gedvlefhgfeuheetgeehffefleffgefhffffhedtfeelteevfeenucffohhmrghinhepuh
    hrlhguvghfvghnshgvrdgtohhmpdhfrhgvvgguvghskhhtohhprdhorhhgpdgsohigrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:qpQ_ZiMRH3rESb2Ve7PoO4Te-t-BKCJPpbnUBe30mw83wcTJd8SALA>
    <xmx:qpQ_Zj-CJ0s6AKT6QszipofQCjxpe_seWrJX4Yf7z062o0mQvwuf_A>
    <xmx:qpQ_ZiWr0bNXVXXSQIIv2lZHWqdDWq6o-LpMNfWIekuoAmp7kzL3dw>
    <xmx:qpQ_Zkeuwj6kklMv6gF4TjzgklHkZnTZkoCBppEJ9vEXFtj-R-jNfg>
    <xmx:rZQ_ZqeSrbDKJ7U2sSzXX2mDHSsxz4m5uooXLX26wJojgmdkUAAKPaSz>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 11:54:17 -0400 (EDT)
Date: Sat, 11 May 2024 09:54:15 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: "Shen, Yijun" <Yijun.Shen@dell.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 kernel test robot <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
Subject: RE: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
User-Agent: K-9 Mail for Android
In-Reply-To: <BY5PR19MB39223A0977CE393BA6833DB29AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240501215829.4991-2-lsanche@lyndeno.ca> <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com> <aaa1ebb5-3e0a-40ef-b53d-d8adc1589085@app.fastmail.com> <X1TADS.8PTII3LXSHHX1@lyndeno.ca> <BY5PR19MB39223A0977CE393BA6833DB29AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
Message-ID: <5D1A41F2-8740-45E5-9A86-396A9B615BDB@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 11, 2024 9:22:23=E2=80=AFa=2Em=2E MDT, "Shen, Yijun" <Yijun=2EShen@=
dell=2Ecom> wrote:
>
>
>
>Internal Use - Confidential
>> -----Original Message-----
>> From: Lyndon Sanche <lsanche@lyndeno=2Eca>
>> Sent: Saturday, May 11, 2024 9:49 AM
>> To: Shen, Yijun <Yijun_Shen@Dell=2Ecom>
>> Cc: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>; Pali Roh=C3=A1r
>> <pali@kernel=2Eorg>; Armin Wolf <W_Armin@gmx=2Ede>;
>> srinivas=2Epandruvada@linux=2Eintel=2Ecom; Ilpo J=C3=A4rvinen
>> <ilpo=2Ejarvinen@linux=2Eintel=2Ecom>; kernel test robot <lkp@intel=2Ec=
om>; Hans de
>> Goede <hdegoede@redhat=2Ecom>; Matthew Garrett <mjg59@srcf=2Eucam=2Eorg=
>;
>> Jonathan Corbet <corbet@lwn=2Enet>; Heiner Kallweit
>> <hkallweit1@gmail=2Ecom>; Vegard Nossum <vegard=2Enossum@oracle=2Ecom>;
>> platform-driver-x86@vger=2Ekernel=2Eorg; LKML <linux-kernel@vger=2Ekern=
el=2Eorg>;
>> Dell Client Kernel <Dell=2EClient=2EKernel@dell=2Ecom>
>> Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_p=
rofile
>>
>>
>> [EXTERNAL EMAIL]
>>
>>
>>
>> On Thu, May 9 2024 at 09:10:51 AM -06:00:00, Lyndon Sanche
>> <lsanche@lyndeno=2Eca> wrote:
>> > On Wed, May 8, 2024, at 8:24 AM, Shen, Yijun wrote:
>> >>  Hi Lyndon,
>> >>
>> >>   Thanks for working on this patch=2E
>> >>
>> >>
>> >>   Dell side has an initial testing with this patch on some laptops,
>> >> it  looks good=2E While changing the platform profile:
>> >>  1=2E The corresponding USTT option in BIOS will be changed=2E
>> >>  2=2E thermald will not be impacted=2E The related PSVT and ITMT wil=
l be
>> >> loaded=2E
>> >>   Some Dell DTs does not have the USTT, Dell'll have a check if
>> >> nothing  is broken=2E
>> >>
>> >>    Additional, with this patch, follow behavior is found:
>> >>   1=2E For example, the platform profile is quiet=2E
>> >>   2=2E Reboot the system and change the USTT to performance=2E
>> >>   3=2E Boot to desktop, the platform profile is "quiet", the USTT wi=
ll
>> >> be  changed back to "quiet"=2E
>> >>   This looks like not a proper user experience=2E The platform profi=
le
>> >> should honor the BIOS setting, aka, the platform profile should be
>> >> switched to "performance"=2E
>> >
>> > Hello:
>> >
>> > Thank you for your email=2E This is definitely undesirable behaviour,=
 I
>> > will have a look at the code to see why this is happening=2E Does it
>> > always revert to quiet on boot, or always the mode that you had
>> > switched to prior to reboot?
>> >
>> > Do you happen to have power-profiles-daemon or something similar
>> > running? My understanding is it remembers profiles across reboots,
>> > this could potentially also revert the profile back to what it was=2E
>> > See this release for details:
>> > https://urldefense=2Ecom/v3/__https://gitlab=2Efreedesktop=2Eorg/upow=
er/powe
>> > r-profiles-daemon/-/releases/0=2E9=2E0__;!!LpKI!jUAEHb-9foumkcmPlEKD6=
tnQrZ
>> > sqjB1sXdPDsYvH2fJ-gPV6G35MUtDW4q3xhlJ4IeLcIgmVpb3ztXqaOg8$
>> > [gitlab[=2E]freedesktop[=2E]org]
>> >
>> > I will assume there is a bug in my code at this point=2E I will test
>> > with and without ppd running on my system to see if it changes across
>> > reboots=2E
>> >
>> > Are USTT settings exposed in your BIOS configuration menu? On my
>> > laptop they are not and I have to use smbios-thermal-ctl=2E
>> >
>> > Thank you,
>> >
>> > Lyndon
>>
>> Hi Yijun:
>>
>> I tested this on my computer (XPS 9560)=2E I do not have access to the =
USTT
>> settings in the BIOS screen so to substitute that, I booted without the=
 patch
>> and set the USTT manually using smbios-thermal-ctl=2E
>> Here are my findings:
>>
>> Scenario #1: Without power-profiles-daemon (ppd) running
>>
>> 1=2E Boot with patch, set platform_profile to quiet 2=2E Boot without p=
atch applied
>> (no platform_profile)
>>  - smbios-thermal-ctl confirms USTT is set to quiet
>>  - use smbios-thermal-ctl to set USTT to performance
>>  - confirm set to performance
>> 3=2E Boot with patch again
>>  - platform_profile is set to performance
>>
>> Scenario #2: With ppd running
>> 1=2E Boot with patch, set platform_profile to performance with ppd
>>  - Confirm platform_profile is performance 2=2E Boot without patch appl=
ied (no
>> platform_profile)
>>  - smbios-thermal-ctl confirms USTT is set to performance
>>  - ppd reverts to balanced (only controlling intel_pstate in this case)
>>  - use smbios-thermal-ctl to set USTT to quiet
>>  - confirm set to quiet
>> 3=2E Boot with patch again
>>  - platform_profile and ppd is set to performance
>>
>> In my case, the setting in the smbios is honored if it was switched wit=
h
>> another method=2E When using a userspace program that manipulates the
>> platform_profile, the program seems to remember the previous state and
>> switch to that=2E
>>
>> So I do not think there is a bug in this patch related to this issue, a=
t least in my
>> case=2E Please let me know if you have any questions=2E
>>
>> Thanks,
>>
>> Lyndon
>>
>>
>>
>Hi Lyndon,
>
> I've made a video recorder of the issue: https://dell=2Ebox=2Ecom/s/3f3z=
nz1z8c6htbcll9juj6tyyu0zvvut
> My test environment is that I freshly installed the Fedora 40 and will n=
ot do any online updates=2E Then install the kernel with the v5 patch appli=
ed=2E
>
> XPS 9560 is a pretty old system which is RTS with 2017=2E No USTT settin=
g in the BIOS is expected=2E
> I've a check that the Dell system, at least shipped from 2022, the USTT =
setting will be valid in the BIOS=2E The system used in above link, it is L=
atitude 7350 which is shipped by 2024 April=2E
>
> I think the key point to duplicate of this issue that, the USTT needs to=
 be changed under BIOS but not under the Linux OS=2E
>
>Thanks
>
>


Thanks for the video=2E

Fedora 40 has power-profiles-daemon enabled by default AFAIK=2E This would=
 be changing the platform profile at load to match the last known state=2E

Are you able to rerun this test with PPD disabled? Just in case it is a di=
fference between setting it in BIOS and smbios-thermal-ctl=2E

Thanks,

Lyndon

