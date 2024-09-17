Return-Path: <linux-kernel+bounces-331448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5B97AD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40830B29079
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9415667E;
	Tue, 17 Sep 2024 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iA7rSkyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jb7dxzh8"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460615358F;
	Tue, 17 Sep 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562777; cv=none; b=dB2iQAROQHENvy+/ODITgYF9C2aEzuJCTSVChRCUOlyY36soWaLhC4AZwr9scLxuJTX+vNi5zjiZOojOK1ja4ucRcDcMU2Sp0ax/PUxpY80QE2D7zNG0IrzTkT0UCsgx5npNQzN7kuVWs/xMC0BwXfspMwlxNeu/ucKwZ+W6ehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562777; c=relaxed/simple;
	bh=7il+1Y+xDmFDzhpMMo6AtEpUg427MJzyHRGjoapMw1w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J5kAdyJRO8JoLhYJdDjwT52SYcaitaRNmT+N1XyEwRTY9wF29qnu1eNrdNWcibXWEj2Y4Jumz344YYzSr0zr4Xqx+85ImdWHeqN/pi/8IbjCz5JLqQQroandrmInMI9eNCGhtakGW8o9AgmT83o6mnv8Csbzt24WIdvZTFuZgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iA7rSkyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jb7dxzh8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 27EC313802EA;
	Tue, 17 Sep 2024 04:46:14 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Tue, 17 Sep 2024 04:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726562774;
	 x=1726649174; bh=r02SC9UwRVZI3dSIERxjx/Dlw5QW6ywAV9eCY3QxIfc=; b=
	iA7rSkycZ7jdRG1k5E9R0WBk4tNh3E41X7vYFI+8VNIgBY4EH7/18ikik+fWXm93
	95TAzL2aBtaFyFSv+E8XkXwvNmbCsvYyM3xI29Br6KPzHlK7hzmCqgIB/fStu6cl
	gTfZCyW0S2lW8TxOJ+2Lwde4kgIau/9X8DeZqs5eswUMduaWBubkyq35u5Tce+r1
	T2a5IPdWwUG8w31UTpFy2HQCoIkWphycAJh1ZU+4FfJ7giqL4JibjjECB1NftZtk
	0P9Uq80a7n2OUDgb0p598j321nq5Wy/oY6CO3nKFUPwPfkbt1zLEiyN0ZRkAQ/5D
	jBfTUouEwHbY+BUFyVEiZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726562774; x=
	1726649174; bh=r02SC9UwRVZI3dSIERxjx/Dlw5QW6ywAV9eCY3QxIfc=; b=j
	b7dxzh8JFyYdqB9WYcA1E2UY0f6eYM3/mn9B/Y9f8XvPcCaeNGhmdKXr1GMlNFLF
	F3lbl6Y/3N0rW4CGbF1+V4VIKwQIGeSwUnpJC/ZZPZkz2zavCpMnP/SHyVu/rzXr
	+IIj6qyAy9GI6jWqomx5aXqei4MUd1BqKkNietQkuPzuSYBo70ryi7/yoEZZ+Eyt
	r8wsOYWLB5ZZsyFLcPSORHM6dP4MjvPf26/rwyhcdFoH52RsONVBJ3/3i0i+hx+8
	VtwtQufvLZ2rxDi0NlpPbqm23Je+h2bhbS/7ojcBPQ0cwyKFDZFz4yUU+3kryM4a
	R/UcAu8Ykjoi44nxoqRRA==
X-ME-Sender: <xms:1UHpZug18bT4z4dUwrKZ7a29BTkMq93PtcHDLjeoR2hAu13HRuLoDA>
    <xme:1UHpZvB_-Op6mvOb8NQ-6ZVtaXNGHyz9o7UL3IFEJ8IlnjTdKT8HzoUb4SapDysTJ
    FF7Bmb7o8sE-yjWgTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpeevteelkeefueeuleejveetueetvefggfeuledvhfdv
    gedvheelfeelkefhgfetheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhho
    nhgvshdruggvvhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrg
    htfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1UHpZmFxYFdEmvwOf_ZB1SZ9jAuNe4vWqasyLsspy-I2UCUrJKtk-Q>
    <xmx:1UHpZnTYPMKYRvef4vLNAs7Y5nE57ntRryK27hjMI2vd15YaQKevXg>
    <xmx:1UHpZrwllL2HPMGTrTxnjrWxMgiwVdgruost1Y6nQxKyRdxxKHze1A>
    <xmx:1UHpZl6VMSQIGjQ1xIdZNaK0OuNGIPZ_u_8-N5sqhHne9deYShexdw>
    <xmx:1kHpZr8IaFQOclHulvd-JEycuOHKPak5L6z0OpFN9CLuXpHP-ASHbAcb>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89FF93360077; Tue, 17 Sep 2024 04:46:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 20:45:53 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
Message-Id: <b7cd34f6-b0d9-466b-b1b4-3e4283b6f6c8@app.fastmail.com>
In-Reply-To: <6ad5b0ee-d05f-4e8e-8946-cbeb350add8a@redhat.com>
References: <20240910045443.678145-1-luke@ljones.dev>
 <6ad5b0ee-d05f-4e8e-8946-cbeb350add8a@redhat.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: don't fail if platform_profile already
 registered
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024, at 12:32 AM, Hans de Goede wrote:
> Hi,
> 
> On 9/10/24 6:54 AM, Luke D. Jones wrote:
> > On some newer laptops ASUS laptops SPS support is advertised but not
> > actually used, causing the AMD driver to register as a platform_profile
> > handler.
> > 
> > If this happens then the asus_wmi driver would error with -EEXIST when
> > trying to register its own handler leaving the user with a possibly
> > unusable system. This is especially true for laptops with an MCU that emit
> > a stream of HID packets, some of which can be misinterpreted as shutdown
> > signals.
> > 
> > We can safely continue loading the driver instead of bombing out.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Thank you for your patch. I've applied this now, dropping the second
> unnecessary chunk manually so there is no need to send out a new version.
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
> 
> Regards,
> 
> Hans


Okay Thanks Hans,


> 
> 
> 
> > ---
> >  drivers/platform/x86/asus-wmi.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index fbb3345cc65a..d53c4aff519f 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3876,8 +3876,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
> >  asus->platform_profile_handler.choices);
> >  
> >  err = platform_profile_register(&asus->platform_profile_handler);
> > - if (err)
> > + if (err == -EEXIST) {
> > + pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> > + return 0;
> > + } else if (err) {
> > + pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
> >  return err;
> > + }
> >  
> >  asus->platform_profile_support = true;
> >  return 0;
> > @@ -4752,7 +4757,7 @@ static int asus_wmi_add(struct platform_device *pdev)
> >  goto fail_fan_boost_mode;
> >  
> >  err = platform_profile_setup(asus);
> > - if (err)
> > + if (err && err != -EEXIST)
> >  goto fail_platform_profile_setup;
> >  
> >  err = asus_wmi_sysfs_init(asus->platform_device);
> 
> 

