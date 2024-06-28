Return-Path: <linux-kernel+bounces-234538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443A91C7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E744B22B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955678C99;
	Fri, 28 Jun 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NCdpLDfy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRmgORX1"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CF1CF8D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608417; cv=none; b=G+ikodzHlgaWVL2ptYKANJXRrWUxJE1HjS4gISaJiaOTsaCpezC732tHtMLS2q7ypFhp4ysvVAOUwpAEapQfxY9kxktZIxoFm7+ruozW+OpBrypl/GUXpl22BtqydqAWHTgX+Hm2AwTatb8P3KlCm6Z9D5u6dz0aqakotbHx0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608417; c=relaxed/simple;
	bh=CtWCs2wGbhyleiCjGWuK47kYoaGFNCqDaEyTTc+kkKo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mpi3r6ixqOm2yxZF88g3LiVDhpokYit3esIoP+L67dXusOhCi7BfXlyoqIQm9FlKAIGWcecvqPvtbVhWkYTblI8u2EHtnuwtwLbtosO4RWRJNcxztp5h0cUWQqK02mr1T+Cv8ZttFm1YNfDTbDVFyuRB7nItvZey2inbx3plhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NCdpLDfy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRmgORX1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 46B901140237;
	Fri, 28 Jun 2024 17:00:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 28 Jun 2024 17:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719608414; x=1719694814; bh=YVYqcrvDQT
	z0OroayBbLdjZpn5c0vTGkVWn7x62VNdY=; b=NCdpLDfyfr3bGhFTnAbpLwp0rU
	ek6/gjPGH5jJygjvgK0+63F040EEuevcUkYEdN7YhpXyWe9vDl4OXZTTEt7upc4L
	znaLAMyfOe9UZtkYebGxGBKFZsLXqgQm7p2SaXl7qV9+PiGRO7L6PzQuEsvHtlfd
	UpTZIXtW/YGssY4StTHSx1StN0Ugsi7DdpeMi+WT6YjrcODQk4iFkc0hkuAiUiIK
	jgeWv/HWU6E7I7fh8Xuq9H0hUyVnOD9TFki6MrAGD58inBFzbKWtBeauvi9KhtNa
	jQLc/7Y0BdWumdWUjEGDozI0/O6bV5mQSPtXdVfhcUT4czmYXDUHRMcNTguA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719608414; x=1719694814; bh=YVYqcrvDQTz0OroayBbLdjZpn5c0
	vTGkVWn7x62VNdY=; b=eRmgORX1VVx/X8+VqsHZHWbWsWZ0EN/ie6a9UaNVbY1a
	OZCdv2nPcrfq+31Fq1trtZz2nkUZ+HiTuDtw4ns7pXwOZI/0P0KwynqlDxsaQqTj
	74RxSlTyOB58/fPaToGnsoblJaJw4c9PBEDR7Cs6DdAoP6DPEcb0p8M+KHd1R6kA
	uMyyHAoOKCC/db4JW4Glev6HiZNMREzs5h2hni4JaxJzOhbNqJ/OuV7CLuN0BnUY
	tjd9Nu+4aS76dcA/rezV7tzxnxA/1LagefGzUyMx3uxICeFF3avwik90jU+qhnYP
	Y0MHdbbkfcSf8l4SGUDwUH/h/v10/uIj5mA/HAZMDw==
X-ME-Sender: <xms:XSR_Zg7MIYYeKKnQathPErxyIlKuWX7HZM5XIWabI4m_ffElcVwvog>
    <xme:XSR_Zh6SlgIQ4Ftql2R9AKL7znGpHPP20ztBsvO_lM7UTDPnM1fNdhyu6UrMrmngx
    HjqGTnuefdyIh3Md9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdejgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XSR_ZveCaxCpeasjtVcmCJHoQBuAfCNpFkLCYJ4MnCwhtTbUnKmWnQ>
    <xmx:XSR_ZlIZCMjcjjPly6alSDCAacXBCo8tistS6aqBX_QoaTnFH5cE0A>
    <xmx:XSR_ZkI4DiLOLNUm3wvfXbdz1fAP1XmzSdA0lC1tL_SRf09gU_6x-Q>
    <xmx:XSR_ZmzcV-ChqDlXQq-oy9ybMDh7yczqaryU25LbktMX8-e8DW0BJg>
    <xmx:XiR_ZtrfYD0FE8rJ6J_jS85Fbm2UnHt5WsTjU_zCu0g_SX2xCOF-_9gF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C34D6B6008F; Fri, 28 Jun 2024 17:00:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed9dd921-56a6-48cf-9f25-b8bb079c4249@app.fastmail.com>
In-Reply-To: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
Date: Fri, 28 Jun 2024 22:59:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Linus Walleij" <linus.walleij@linaro.org>, soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
Content-Type: text/plain

On Fri, Jun 28, 2024, at 20:08, Dmitry Torokhov wrote:
> This series converts legacy pxa boards (spitz, gumstix) to use software
> nodes/properties to describe various GPIOs instead of relying on GPIO
> lookup tables. The benefit is that structure and behavior is closer to
> DT-described GPIOs.
>
> The very first patch ("ARM: spitz: fix GPIO assignment for backlight")
> is actually a fix that IMO should be applied sooner rather than later,
> the rest of patches are enhancements. The reason it is sent with the
> rest of the series is that later changes contextually depend on it.
>
> The last patch ("ARM: spitz: Use software nodes for the ADS7846
> touchscreen") soft-depends on corresponding changes by Linus Walleij to
> the ads7846 driver in input tree. It compiles without it, but the device
> will not sync with display refreshes. I have created an immutable branch
> (branched from v6.9) at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/ads7846-hsync
>
> in case you wish to pull it in.
>
> Regretfully it was only compiled as I do not have access to the relevant
> hardware.

Hi Dmitry,

I'm happy to pull these in directly, hopefully with some extra
review or ack from the maintainers. If there are no negative
comments, feel free to resend them to soc@kernel.org for me
to pick up.

Is your goal to of the series to eventually convert all
gpio descriptors over to software nodes, or are you working
towards converting all of mach-pxa to DT?

In the latter case, note that the reason we kept these
specific board files is that they have reasonable support in
qemu and you can probably figure out how to test them if you
try hard enough. I have not tried myself though, and there is
a high chance that current kernels won't boot without extra
fixes.

If your goal is to change all board files to software nodes,
I think we should take a step back, since most of those boards
are likely to get removed anyway. Two years ago, I removed
almost 90% of the board files remaining at the time after
showing that they were pretty much all unused. I kept the
ones that either had known users, or that someone wanted to
keep for some reason and work on doing the DT conversion.
For most of these (including PXA), there has been no work
on this in the past two years, so I think we should ask the
same question again and see which ones we can just remove
this time.

      Arnd

