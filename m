Return-Path: <linux-kernel+bounces-247735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DD92D3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D45CB25075
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4F193476;
	Wed, 10 Jul 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tjwh9dAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGw3su6b"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BAE127B56
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620219; cv=none; b=ZabtVI43sUJiONw5+7yLzXoK0S4K/aOR32AscnY/BldTscLbWlzQGEKjVZDFUS299ECm9sezrflP+saLiKwUwb2/+4gWA9N0fa4TjzwOxdzEYafQgI7r38CEqqykaQF7KGFiIX9cRaILVn6lPy47npKAE+XtWMOzECdvULhe5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620219; c=relaxed/simple;
	bh=4F17oReFMOMx02qlh0eZiZ2Nm5fvG8lifyKxd6O0RUQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pkGHnutQW4jZrkhEH/bHybMSQpkn3CneyTHbs/WSFHzWgkVZ/9EnLksB2Q1JwFAb0X3WG85bJ2wqEzmiziDQueqwZMiZ480u66iFB+QQfif980080m3XsosiehjOoj93VGXNuZZwHkvhYa9dQwVoKgkxXFVj57u4wXiA2p/vo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tjwh9dAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGw3su6b; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D41F7138144E;
	Wed, 10 Jul 2024 10:03:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 10:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720620215; x=1720706615; bh=YqdMcmkKXF
	rzgQq7aBjRfp7vBb4LydO+KfF1Qn40cUM=; b=tjwh9dABUw6hUfO0QDoBVeXVJQ
	ghmNBqfvF/lkxdjVOHnIh2gnFfRkIR+lVooB5/84kLYul520j/1rZgjVdGII4X4/
	EZCGiDAC6s7PxynYbBS/A9RqGrggRR8rU8jlZc8a+t0+9J8QQmyWKp3CuWms5L3v
	/TjU2ABzv6G3T5D8fpZ2bwdilQbQy7awgySLGZ3GTTQbhghT5qcKnqQ1uj+5RaJS
	aSFmVQ5qwRJJNVvOyclR5K+ZxhYpevogj73SuG2r/I+Q/KJhO1dNdd4O/MI8UkLS
	WfWDBG3fj3HpuNTXCddtMzcDifdNOYpf9E1tgIdTmNwMxHhNjlo7DkP1WRFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720620215; x=1720706615; bh=YqdMcmkKXFrzgQq7aBjRfp7vBb4L
	ydO+KfF1Qn40cUM=; b=HGw3su6bFtxpfqW7FUZEg26Y1SjSBwxVH3cTu6Nq4yHC
	Y++tjEB35KmyrxXOAmueBclBseAKjwcG7F4k08qaqdbcd4PiiSPfjuSFCIZKvzCm
	T9oYfndqwlgXfoMjzltfN/mbwip6TbZdpx0W7Nv/vC/tX4Zu3RJBQqkxunnxsxT7
	5vUnoSYca9ekIXvViQ5gzhsyZqK3xIbroH2yQYrb9nsaV6P6+NQuyHDRLjPSssJR
	eHCaqxJzrGawmTHtQeTyL/rum/S2+ss9df7BrE9Ifh7/+qfIM2L2bWTn6F+Nsro3
	7pMMHVwd1Iq2AGwxAJLSyta2+80j06P4xzmQeaUHfg==
X-ME-Sender: <xms:tpSOZttPlp067QWO7ozV9N5gs_Fayw0K5XoaVk4Xm-H8WHKdFFUHwg>
    <xme:tpSOZmfemPTwnUQumCqwZ-UjQTMCVjfB9pLRhphtY0q9qXfmEEj0W8uRYdFYGoTZZ
    H0OxgeoiQAjOdDrVSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tpSOZgyUO82UY8r26SnfBeOucMp292hwwW5QshDI4g-e5yzWvbL_9w>
    <xmx:tpSOZkM9VBG6Hk7sJlUpfxX0kOIu4TnRD3gxEZhdeyj2r-bWNEYOhA>
    <xmx:tpSOZt8L8N-IN0SP2rCUX_cGvZgpIW3LMCf1HU4tpOKaLe382SR8lg>
    <xmx:tpSOZkUEWthQx-4TPiMcbJdzyjUSTsgZiVzFSldecoQvUL_so28YHQ>
    <xmx:t5SOZpaFU4sedTbaN2dSZvL7nFl7kPYNgk5Bc90K2jvg4jSaU5-uBf0R>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 25908B6008F; Wed, 10 Jul 2024 10:03:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f975aedd-adc2-4a12-bc9a-03b777c69aff@app.fastmail.com>
In-Reply-To: <2024071053-mahogany-cavalier-6692@gregkh>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071053-mahogany-cavalier-6692@gregkh>
Date: Wed, 10 Jul 2024 16:03:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Vamsi Attunuru" <vattunuru@marvell.com>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Srujana Challa" <schalla@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Content-Type: text/plain

On Wed, Jul 10, 2024, at 15:27, Greg KH wrote:
> On Wed, Jul 10, 2024 at 01:19:56PM +0000, Vamsi Krishna Attunuru wrote:
>> >
>> >Why does ARM64 matter here?  I don't see any dependency required of it.
>> >
>> Thanks, Greg, for your time. This DPI device is an on-chip PCIe device and only present on
>> Marvell's CN10K platforms(which are 64-bit ARM SoC processors), so added those dependency.
>
> Then perhaps keep the ARM64 and add a COMPILE_TEST option as well so
> that we can build this as part of normal testing?
>
> So that would be:
> 	depends on PCI && (ARM64 || COMPILE_TEST)
> right?
>

That looks correct to me, though for specific ARM64 SoC we tend
to also have a more specific option, which would make this
something like

       depends on PCI
       depends on ARCH_THUNDER|| COMPILE_TEST

This is what we use e.g. for the PMU driver. I had at some
point submitted a patch to rename ARCH_THUNDER to ARCH_OCTEON,
since we seem to have some drivers that get this wrong, e.g.

config CRYPTO_DEV_OCTEONTX2_CPT
        tristate "Marvell OcteonTX2 CPT driver"
        depends on ARCH_THUNDER2 || COMPILE_TEST

which should also be ARCH_THUNDER instead of the discontinued
ARCH_THUNDER2.

For reference, we have five lineages of arm64 SoCs from Marvell:

- ARCH_THUNDER: Cavium ThunderX CN88xx, Marvell OcteonTX
     CN80xx/CN81xx/CN82xx/CN83xx, Marvell OcteonTX2
     CN92xx/CN93xx/CN96xx, Marvell Octeon Fusion, Marvell
     Octeon CN10xxx

- ARCH_THUNDER2: Broadcom Vulcan, Marvell ThunderX2 CN99xx

- ARCH_MVEBU: Marvell ThunderX2 CN91xx, Marvell Armada 7K,
     Marvell Armada 8K, Marvell Armada 37xx, Marvell
     Prestera 98DX25xx

- ARCH_MMP: PXA19x8

- ARCH_BERLIN: Armada 1500 Ultra, Synaptics BG4CT/BG5CT,
     Synaptics VisionSmart VS6xx, Synaptics Astra
     SL16xx, SenaryTech SN36xx.


      Arnd

