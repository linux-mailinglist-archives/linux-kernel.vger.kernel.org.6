Return-Path: <linux-kernel+bounces-176633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F88C325B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 18:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C5528184D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278F5674D;
	Sat, 11 May 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="QPFhN+7z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZvY1oup"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF656740;
	Sat, 11 May 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443358; cv=none; b=c7XCiVol6Oeu37CDzBPA10k2NmDmy80L045EAeyo/JYvFUg8V7j6U9WBrDY9GD+YQcpYGCpiQTnjBcL7VdFKHoOLsMlFqI3TnGpNLZwLo+s24Uf6Ogf9KOZs2Rz4HiencsC1Ono3DsG0TwBI8EPLKuQ7yAX3HhEAGlQ/EInmMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443358; c=relaxed/simple;
	bh=yPc/GwpD+6Q1KEh+Vhbj4eJbDmJmz3ykizNoY/yBMqA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QDQokVCV+14DZf5b997WsC+jQ1zhG/4b1hdBx6aCSuIO+cE992tUyAwwvLtwpVgJz702GepD56cdl9jDGNcKnPFggHCDEQiLr1Fc8k8lI+n2n5inGlP43kI5r/sppDC2pHP5Y7rZPMmnDO64TiOzRYpx8XKZ61nttadsJsE4akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=QPFhN+7z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZvY1oup; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 0AB5F1C000B5;
	Sat, 11 May 2024 12:02:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 11 May 2024 12:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715443354;
	 x=1715529754; bh=strE86BAFtrPR2iG1YeYaHUM+isb1AKO3LmGsyjTBFs=; b=
	QPFhN+7zAIxV/J0WrLKwqgFdT+9gAg0jdIIPTjgg1tNLYsy65NnzhzZXZz6XU1nN
	9hVWkpsl2pUyXpqpkQ2A3ANSQWaikOId3Njyi1PslFcRoQ7dNpGBP0I64dRCGaiy
	q7UBW5PAbkpLqADnPQqiROh4eZNEcPRSkajJmQ155Zsu04MIaXU5qIwTT7idKb5J
	WC7BXXiP/ramXIO/lzC83lRZT+oiqGLPFfCzx43HJprtmRGUTPTYQdhkovadi1Td
	li8FvlXAoJMhfmGrOY8LIUFHWFE7wxTF42al2THjOX/rdA+vuDbYN860evIql5Y5
	uiArcFmO/1RiXocqR17o/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715443354; x=
	1715529754; bh=strE86BAFtrPR2iG1YeYaHUM+isb1AKO3LmGsyjTBFs=; b=e
	ZvY1oup/T1Ry2WD/iqoZMItkxl99jdS97nA5styHmJTvlyFatoRVhs52jx0rAh7E
	N3OsFCEM+3JYI1BTOq779Bk3rQuyXfkkRFF4/J/0R5Dzee5jxFGUM9h7GsxDEDPM
	UCVn3qCyZFI4n0fbKnt0puR0qvgFuGZdpIySEF8PNOzG+T+wRjv7P8rAta1J7yWA
	kdHj4g184iVWEyQh64Irh/L5sPIlBAmudkeXleIb7FA5f8c4JVCHqhV5TnA8EoIi
	Ejpb7ncRRcnJNPWJSZ635gcpXVaWEIQpWlU1Y9FDGxRfrkcHHLgJs45XvvLEFvse
	L/5/UTVBGwPM2RxVcC4uw==
X-ME-Sender: <xms:mpY_Zr2xc85RNillMdU9mws_WMqxhyVOnhnC3B4gyKsnbiuFIO0vaQ>
    <xme:mpY_ZqGXJOGG-lP3rgQv9u_BnsBrWshHSHZGJZCeRMjtllG03pPylo-Um6ZH6sL0Q
    YFdJb8ImMGhAsaB2JA>
X-ME-Received: <xmr:mpY_Zr6Nmxr2eqFig3okwVcwd98wDSnMOwWgmsh14tXvwWDzhSM8kq7xC1sH7i_vubIs-WpSQIzTnautXGe1WiZh21mULIPs4Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpefnhihn
    ughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenucggtf
    frrghtthgvrhhnpeetieduveegueffhfefudetjeegtdefffehvdelveelueeviedukedu
    tdejkeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:mpY_Zg16n8mWG3QcixSilF0KSMty76TgIe_yOL3tn4wfJw3vr5HZJA>
    <xmx:mpY_ZuFpzibTb8cIrAaXsh_pDLCugiP-7MXLqSvr_h0XMFwlO77Zng>
    <xmx:mpY_Zh_XVTO2v3hS8RWhUUXzFwBFgu_e2tuFBll4ntAz2NQZgPGGbw>
    <xmx:mpY_ZrkDBKBlG3HUpkSKUFpOgB5xtfGC20fUmf5mQRlcZb32NnKETQ>
    <xmx:mpY_ZsHeFZlKn3jhmAwb1-nKyCerldERE3ieTkLFZsw4CSF0h06-Jwjp>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 12:02:33 -0400 (EDT)
Date: Sat, 11 May 2024 10:02:32 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: "Shen, Yijun" <Yijun.Shen@dell.com>,
 Mario Limonciello <mario.limonciello@amd.com>
CC: "pali@kernel.org" <pali@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
Subject: =?US-ASCII?Q?RE=3A_RE=3A_=5BPATCH_v5=5D_platform/x86=3A_del?=
 =?US-ASCII?Q?l-laptop=3A_Implement_platform=5Fprofile?=
User-Agent: K-9 Mail for Android
In-Reply-To: <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240501215829.4991-2-lsanche@lyndeno.ca> <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com> <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com> <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
Message-ID: <94DD2C4F-D32A-465E-944B-E84ACC8F09B4@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 11, 2024 9:05:15=E2=80=AFa=2Em=2E MDT, "Shen, Yijun" <Yijun=2EShen@=
dell=2Ecom> wrote:
>
>Internal Use - Confidential
>> -----Original Message-----
>> From: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>> Sent: Wednesday, May 8, 2024 11:53 PM
>> To: Shen, Yijun <Yijun_Shen@Dell=2Ecom>; Lyndon Sanche
>> <lsanche@lyndeno=2Eca>
>> Cc: pali@kernel=2Eorg; W_Armin@gmx=2Ede;
>> srinivas=2Epandruvada@linux=2Eintel=2Ecom; ilpo=2Ejarvinen@linux=2Einte=
l=2Ecom;
>> lkp@intel=2Ecom; Hans de Goede <hdegoede@redhat=2Ecom>; Matthew Garrett
>> <mjg59@srcf=2Eucam=2Eorg>; Jonathan Corbet <corbet@lwn=2Enet>; Heiner K=
allweit
>> <hkallweit1@gmail=2Ecom>; Vegard Nossum <vegard=2Enossum@oracle=2Ecom>;
>> platform-driver-x86@vger=2Ekernel=2Eorg; linux-kernel@vger=2Ekernel=2Eo=
rg; Dell Client
>> Kernel <Dell=2EClient=2EKernel@dell=2Ecom>
>> Subject: Re: RE: [PATCH v5] platform/x86: dell-laptop: Implement
>> platform_profile
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On 5/8/2024 09:24, Shen, Yijun wrote:
>> > Hi Lyndon,
>> >
>> >   Thanks for working on this patch=2E
>> >
>> >>
>> >   Dell side has an initial testing with this patch on some laptops, i=
t looks
>> good=2E While changing the platform profile:
>> > 1=2E The corresponding USTT option in BIOS will be changed=2E
>> > 2=2E thermald will not be impacted=2E The related PSVT and ITMT will =
be loaded=2E
>> >   Some Dell DTs does not have the USTT, Dell'll have a check if nothi=
ng is
>> broken=2E
>>
>> Hi Alex!
>>
>> Have you had a check both on both your AMD laptops and workstations too=
,
>> or just the Intel ones?  I think it would be good to make sure it's get=
ting the
>> correct experience in both cases=2E
>>
>Hi Mario,
>
> I've a check for this, for both laptop and workstation, the dell_laptop =
module will not be loaded=2E So, AMD platform will not be impacted by this =
patch series=2E
>Follow is one example output with workstation=2E
> #lsmod | grep dell
>   dell_wmi               28672  0
>   dell_smbios            32768  1 dell_wmi
>   dcdbas                 20480  1 dell_smbios
>   dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
>   sparse_keymap          12288  1 dell_wmi
>   ledtrig_audio          12288  3 snd_ctl_led,snd_hda_codec_generic,dell=
_wmi
>   video                  73728  2 dell_wmi,nvidia_modeset
>   wmi                    40960  5 video,dell_wmi,wmi_bmof,dell_smbios,de=
ll_wmi_descriptor
>

Should AMD platforms be affected? Do they support the USTT modes as well?

