Return-Path: <linux-kernel+bounces-189889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA78CF68E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B31F218AC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3513A250;
	Sun, 26 May 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="oBwvI8k1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsXpOrFi"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9A8821;
	Sun, 26 May 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716763110; cv=none; b=ebMCGLqvnoHX+5+qzUSAzmCfAI0AwMHaNBNI1bVTMibpAiEzAENr+767ZTXKD1xvOf8mboLvF8MyKwX+vOICpaG484XMvfWbn3D6Po1XuuN2N29hWVQPjTncNuABtg9Z0SoVGOnwXBZZp4tBEf4GJaa4fOaKWFiNLAQkVLHB+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716763110; c=relaxed/simple;
	bh=reA8eHYsArXgnJbw+L2mKoJcL7wKiFISjIKZb3hdsXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHRiiZDveUC8LdSTb6Vw7k2wE4ujUH5rpzFEvJzrNM7BLaf3dlWr0kY9ybTGxsaOz+wTDDUgJ/pInooTOH0kxOispKZ/yHZv3B7GmR9+d4uZCG+yW5jbN0NQAnDZ+dA7zOu5MJIUHFKEQAxglzEglquW/55lzGqP7zKiZCCBiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=oBwvI8k1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsXpOrFi; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id C668D18000A7;
	Sun, 26 May 2024 18:38:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 26 May 2024 18:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1716763106; x=
	1716849506; bh=verWM+mHlaf6cnIfpJqCaMrY5Bs6PSQJQ61V2ksLkrQ=; b=o
	BwvI8k1HAQdyG9VJjUvUYG7mIvBTvUgXh/dhAQykVwbIjPAN08HD/o4zAM0VLb0G
	nI8IkN253H+VsvDVWcIldgIckYoW0JLz1In3zzqWJSM0NZ8RJezOaKm2VMaU3ZTv
	uTF4gCa6BtQbfo8gu9lmohdu/Hs5zW9JOFcsFnRoYgiwCnMyjWq/Pv1pnwy6jb96
	axKCir4YxhxGOdAF4VMCyd/FUBTEY9bmEXlH6mtVzQGU5aRmYwoasU630TNXmXVe
	Vaht0tyQcuO1pIWt6yoUfhq/tMWre+btTUtoHZx1w1hNI8NY9VLFKO6R6d0FaPlC
	TM/f96gsEKgesS4OwWY+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716763106; x=1716849506; bh=verWM+mHlaf6cnIfpJqCaMrY5Bs6
	PSQJQ61V2ksLkrQ=; b=YsXpOrFiamQN6j2y89FkobMuUuRDPBei+HM3wbo7E1CD
	PGBiOZr64zO384ShHNNjnb3w5/auQ/sQQcr/a3cYHyqGUvLpHhwKMIUj/SkmjM8W
	aqTeQHW7pUhvLmUrvDpM9T7CUBQsQQoxf/sf1UNZ1n4QWjhewjD4qnnOrRYsKv5A
	qp6OvIFJgKMhbK6lK0tAiR6JQtUunaoW1E2V/CbQueT3VC/X9+B34BxBjgLSLlSN
	1BQIkN2sINO7YGNBagWVh3cJv8cnvOt1M6ODdj4NTRQLvG+xkVMjPcZlH4J0RXkE
	MYqI3hGYQV2Tj/j0x6qjwQmVyK+RMAdTwBew3+Yeig==
X-ME-Sender: <xms:4rlTZtIz26-35jmbBAl8IYHjepyYmQYpF8LF23Ig545FlssP6iQhhA>
    <xme:4rlTZpLYcfqcdf2q7DNaW9ALp8U945v8PfJrF7COfAfYpCqQYC3cXB8zFgIUnaVii
    zOJoamOm-BEy_isxEg>
X-ME-Received: <xmr:4rlTZlu6BCU6S3rqr7MDdeKn8eykggdOMJJTkQjFjhm2W4KNFBmC3qpPkpXVThAwcCEjKLC_ZqpuDNQcwOW3h7xNPzXznL5GWix4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:4rlTZuaGOP2M4XSN9lvK-yCN80kt-ok-t-UiEGj4Woa32Ht5IA4f0A>
    <xmx:4rlTZkbYj6aTYqK_yAr5pftohACm9GDR3YJzMH9AQlNX0Q4HkdKA1A>
    <xmx:4rlTZiCW_LzQdwXqvjnacT16Vc8pGhNVJ4UMiUqXkYd4mwOOYxlcUA>
    <xmx:4rlTZiY9iv6DxhqkJMRISOfXtgGsSXaMR2KqmYU70diGUltNfEe1iw>
    <xmx:4rlTZrUKPHFDRku8iYYLTM2bD1vK8MNYzfaxZ3a8bZzHrfMTxAu_WyBM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 May 2024 18:38:24 -0400 (EDT)
Date: Mon, 27 May 2024 07:38:21 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firewire: add missing MODULE_DESCRIPTION() to test
 modules
Message-ID: <20240526223821.GA342669@workstation.local>
Mail-Followup-To: Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
References: <20240523-md-firewire-uapi-test-v1-1-6be5adcc3aed@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-md-firewire-uapi-test-v1-1-6be5adcc3aed@quicinc.com>

On Thu, May 23, 2024 at 04:22:34PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/uapi-test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/packet-serdes-test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/firewire/packet-serdes-test.c | 1 +
>  drivers/firewire/uapi-test.c          | 1 +
>  2 files changed, 2 insertions(+)

Applied to for-linus branch. I'll send it to mainline in the part of
v6.10-rc1 fixes.


Thanks

Takashi Sakamoto

