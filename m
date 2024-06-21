Return-Path: <linux-kernel+bounces-224433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8891225A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594C2B20C78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D317165B;
	Fri, 21 Jun 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="mDS76UYR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7ffXTVS"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB217109B;
	Fri, 21 Jun 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965605; cv=none; b=tMpBV1s8pe3Yr07iwi5qhVZz9N6c0kdq4JWZjWt1ylqwBmMxRwBkx3tzyVv+Z4BWMHfeCCb+UR0b8xPsEspKT5RU1SZNFJcn7S4UYQYPqljJAXoKyg6EXmHhQIrib3wF8L8Vu8Ju73D7xnfDupcOqkk4vcqPHeepxsxSPf9UIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965605; c=relaxed/simple;
	bh=lDBSInCRchI2CbwuBjQ1xP+bDV/XmQY4fdHaHbHIt1U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=NPd7OmzCbNtv8h1CvXGp7SXL+pDPk6isCrzD76CO9Qs2cHv/cC1UqIXjVySPn6EPYftYV6H6SsnBX79QIm2jZjUrwrDcW/y+SzTDixsoRYMaVgPD5nKlVN1QgI+2xAZty16x4BHo9da50kTORdqd90XmG57D432FGoZ8Jeqw3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=mDS76UYR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7ffXTVS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6BFC7138023C;
	Fri, 21 Jun 2024 06:26:42 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Fri, 21 Jun 2024 06:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718965602; x=1719052002; bh=dUDuhAH2NJ
	EHt75xyTyc5omFTLA3FQOUNF+SXDDtfaI=; b=mDS76UYRcL0k5T4pZ+i7qoRiS4
	77mhGD0QmZIta+LIFpO+KDnU6Cv4R3+OJ1Pw+xmcLmBZy83O4v3HkHaS2dsIOYKw
	7Tq/Tcim0THl/sq4awvWm7JvKOttVoeve3XeS1TwgSDyRpjpgH2cioxtPYL4CKZ7
	GJtIiZHSwqJt0N/1k+QKnGcfcB8lzM70/VU/sB7LKpDIdMoUAGRjiHYrWrhF+BUR
	ZpWFMMUqt/MRtCfgNUQXx91mrHvFXiyxbyhnePh/OxvghtdWivRlPCR06ucmsj/Z
	Ldoha85LUgl+tVU++iVlEipHI0uWXP9kRof/1b0Hh6X7Wt3Oqcz9AvIPvHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718965602; x=1719052002; bh=dUDuhAH2NJEHt75xyTyc5omFTLA3
	FQOUNF+SXDDtfaI=; b=e7ffXTVS8Cn3vTd9y1rv2jRt2fu5aSB5MTe8pn60ThWB
	FJ6d5ZK+TvS2g2P9F1xdYE/VlTgdWl5mq544Q7HJ0m1Jt8raiFc8H3E3Z1A1DspG
	OD1vNKuNRymDgTIh89wmpVMek4lO0X94mNVB+e1oSLoKNWjJee48prQdNtHtH1Mf
	leObckor4jpwrejNLkpUCJPFuQN5XyjhI7x0x/Iu79aT21LUdpGnHMsAY1MmE/zX
	0xevTBrt/Obi4CgIwyD8E99+kep7Y7OD7cKjt/RjiD1uDLuZALz3DbpLlnJjQohN
	GQIXVmCmNbNUCq5qfIH5DpuzzIPz12ljUFlxerDL3Q==
X-ME-Sender: <xms:YVV1ZoaccLQvB1aii1NfG6x3HbQuw6z1zRgOkhfnRTv9aHr9NOV2HQ>
    <xme:YVV1ZjYlEchDJ2Pg0_dkW_TgF27Exd1_vIXM0Sksgg9BrqfSerc18uFjRYbpgufB_
    KeGo-LZBjlRmAf_qDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeelffevveffhfeuteetteevteelteduudfgjedvleejteetlefhieeiudfgveel
    feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:YVV1Zi-046_PBumwN5_4HBdXih-rb2r0GhyeCWkjEY8mZL02wXenoQ>
    <xmx:YVV1ZipeDZrNKas2IbCjxHkmQeB7WfYYrzWkyhNpKNSHoQGFXWKJ1w>
    <xmx:YVV1ZjqYRhEwPLniJbdjflep3f-uFAsWMGvK0jmTeApsMAwZKJ3Udw>
    <xmx:YVV1ZgSJMephclgf4Vyvn6hZ2T631KjVfXg0vn5n0D9lR7gubsIlPw>
    <xmx:YlV1ZkCX2BtIQcaHfpibZLd7L0_uxTuUpGwsIp_n_2Ka8k7h6562X7KF>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 71E5A2340082; Fri, 21 Jun 2024 06:26:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <373bcabb-5175-4937-88b7-bd0fec579357@app.fastmail.com>
In-Reply-To: <dbe77711-f32e-4dce-b4a9-ee3114a435bf@doubly.so>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
 <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
 <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
 <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
 <f126562f-54c8-de58-3f98-7375c129f66a@linux.intel.com>
 <4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com>
 <dbe77711-f32e-4dce-b4a9-ee3114a435bf@doubly.so>
Date: Fri, 21 Jun 2024 22:26:20 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Devin Bayer" <dev@doubly.so>, "Mohamed Ghanmi" <mohamed.ghanmi@supcom.tn>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Content-Type: text/plain

On Fri, 21 Jun 2024, at 9:43 PM, Devin Bayer wrote:
> Hello Mohamed et al,
> 
> On 05/06/2024 09.43, Luke Jones wrote:
> > 
> > I am saying I would like to see ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED removed, or placed somewhere else such as in <sysfs>/asus-nb-wmi/hwmon/hwmon3/pwm1_enable.
> > 
> > It certainly shouldn't be included in platform_profile and I'm not keen on seeing it in thorttle_thermal_policy either.
> > 
> > A lot of this reasoning is now coming from the refactor I've just done of asus-wmi and the "features" such as this one to place them under firmware_attributes class and begin deprecation of them in asus_wmi. From what I've achieved so far with it it is much *much* more suitable than this ad-hoc style of adding features I've been doing here (I'll submit this work soon, it repalces the last patch series I did).
> > 
> > In light of the above I'm considering the possibility of removing throttle_thermal_policy completely to wholly favour the use of platform_profile. It doesn't make all that much sense to have two different things manipulating the same thing - and as such I don't think the "full speed fan" setting fits at all with platform_profile as it is not a performance tweak.
> > 
> > Mohamed, I would be happy to include the Vivo support so long as:
> > 1. the fullspeed setting is removed
> > 2. the modes map correctly to platform_profile
> > 
> > I hope this makes sense. Very sorry about the previous brief response (I was recovering from surgery trauma).
> 
> I recently created my own patch to toggle this control[^1]. I thought
> it was an alternative fan_boost_mode because the dev_id's were one apart. But with
> more testing I've realized it also controls the GPU power and supporting the standard
> platform_profile is better, so I prefer this patch.
> 
> I tested it and it works. However, it has a couple issues:
> 
> 1. This dev_id isn't Vivobook specific. My Zenbook UX3404VC (2023) has this control.

I'm not sure what else to call it. "thermal_throttle_alt" or otherwise, I don't know. The intention should be clear even if only in a comment.

> 2. The Zenbook only supports values 0-2 (standard, quiet and performance).
>    Calling the method with 3 causes the KEYBOARD_KEY event to fire instead of
>    adjusting the GPU power and fan speed.

I linked you to v4 of this patch in one of my responses. The link again is https://lore.kernel.org/platform-driver-x86/20240609144849.2532-1-mohamed.ghanmi@supcom.tn/T/#mcd18e74676084e21d5c15af84bc08d8c6b375fb9

> So I would suggest to remove the fullspeed setting and rename the constants,
> perhaps to ASUS_THROTTLE_THERMAL_POLICY2.
> 
> Mohamed, if you are busy I could also create a new version of this patch with
> the requested fixes.

As mentioned it is done in v4.

> 
> I wonder if the existing fan_boost_mode should also be considered a platform_profile?

No. It tends to be only fans, and usually fullspeed. Platform_profile is intended to control platform related variables. I would also be curious if you tested without the PPD (daemon) as recent versions may also control the energy performance preference and that will skew your results.

