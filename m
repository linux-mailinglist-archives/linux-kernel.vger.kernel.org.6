Return-Path: <linux-kernel+bounces-253846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB19327D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA32282632
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9419B3D6;
	Tue, 16 Jul 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="S9ch75Bo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlwrLyaW"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1218EA61
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137894; cv=none; b=WdTnEe+YkQzAmeFyiLqXEQLa9EBFInXUFq5X0DpCqavX79NdzDyWIrn4F6dA4ka6U9L9m+YP2eYQ9Gk0mDax9fvb2sQA2KQwoCLC8UUPB5ow/+hjcAtU3fVJQR0mtumawdANEmzhyfc+XGDvCsmcisCptTWFGZwGuKpzqiqrRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137894; c=relaxed/simple;
	bh=wMHgw+W/JEbRZwGEkAbHUj1cJ4B2FOJKGkkGpmh+rzg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZIcMBEea7dA7XxINPzXsx22MsEMqZp74DLUcOMTDsskNoeFcWiL1GfrKi06ZSI9B7w8wmyApUxTbJKGnK4r/pQGlaXQClQSj8L6a9y2BPZYv6wnasO7WCP9kAVgA3FIWetEYxxNiV2amF84Gr18hOgvPtiECwf6XdbC+KwjnQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=S9ch75Bo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlwrLyaW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4FD771388D74;
	Tue, 16 Jul 2024 09:51:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 09:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721137891; x=1721224291; bh=WGMGM96iT1
	TLgR8LrcifU4YWPKUxd4MGL6xRGDGKqFY=; b=S9ch75Bo7AUUX75zfk3r+4LhLx
	NY38zgRSPuLIyYGAuJMvA5rez5xgR3uPpiqYnD9G/B6E29sAYMLyvRcos14nZgkf
	bn+Dc4H5BEC3AqKGbXE/937QCyfYF8rniEaI1fzdmBNWPKIKWKLYu8mPyGiUjFuT
	mVN6STWySOyR15OMaL0D5gVYofa80I9uaLGnDrnFSLAFZtLHHuxNLrj75y4nw2P8
	JfRi4VRjZYHGbZBI/Ivk8k52t8opHrVKqhkBKGeQgwRtBkSv5M4ntSFiahngAbG3
	B3KPL2f6agfyAcipUKwO6iuE8zI5lL+fySq7zMPRUrkP2sxNov+a3PFHvT3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721137891; x=1721224291; bh=WGMGM96iT1TLgR8LrcifU4YWPKUx
	d4MGL6xRGDGKqFY=; b=TlwrLyaWlX0scUhMG5ZWlJdLrerQhnqsDbogTDGGobRD
	AHWO3MK3jl4bWV2+QEhdaHWQbLQl6OHaTQb/HLofuAr6qSyZDPMj3lWo1I2ZaFHd
	SzZ/jOzfdmDPWDQrvvSuEAYvZmfjU3Y/sx3bYMkLhOYbbgTYPJlxlmOHy0HgQMl6
	fK9agxjxPpUp/Fz95TDVv4GHcGuWugcV9IuN3HD1Lp8YMCAHvzd8gY7ZXwVwwALk
	T3TrEy8kqQqkcsUvhDD8ATQIYmhyGVz2p42xEKxRjX96bDfsja/jiU+N164U3zrA
	CTAI3gEYbFN4bt4myuioZG9y+mhFAoc0iiq70ubw1A==
X-ME-Sender: <xms:4nqWZmLXd8LUCvkZZhMWM7E6DBsem5wAShpL97xCRSTfZs29IwAtzQ>
    <xme:4nqWZuLc1kp6XKB8bBZ1nbSyCoR2cSb7s5SX9h4M7y1Zraodd9qGTw2KNEwn27jYj
    Taumy2gucLm4C4j4Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4nqWZmtwp3uUhdkkOckQVm6G-VasvjTbkdtvHNfyY_rKbd5Xa6YTkQ>
    <xmx:4nqWZrZr0sbniIDqDqdUrwD_JyUJToqj3iiTidnYUv3DE8li3KJOcQ>
    <xmx:4nqWZtYkaRAtIQkz9Gg1Xn5qDX8BQ6vVRpeJH6nO3rGk04bKwGy7OQ>
    <xmx:4nqWZnCPC36rM6qx4hf-6qN1GOPKjlwE2a9Xt7td8tpUdOsxNPXdJw>
    <xmx:43qWZhFzbJ5CRfUV4zbrtgx7-Tsa7xktmx3xm7vHj3vyssHJx7fl2hkd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0F1D9B6008F; Tue, 16 Jul 2024 09:51:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83ac6b91-c7f1-4b18-a522-8188d6d1298b@app.fastmail.com>
In-Reply-To: <20240716132603.GA3136577@thelio-3990X>
References: <20240711120115.4069401-1-vattunuru@marvell.com>
 <20240716132603.GA3136577@thelio-3990X>
Date: Tue, 16 Jul 2024 15:51:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>,
 "Vamsi Attunuru" <vattunuru@marvell.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI
Content-Type: text/plain

On Tue, Jul 16, 2024, at 15:26, Nathan Chancellor wrote:
> On Thu, Jul 11, 2024 at 05:01:15AM -0700, Vamsi Attunuru wrote:
>> 
>
> After this change, ARCH=arm allmodconfig fails with:
>
>   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_write':
>   drivers/misc/mrvl_cn10k_dpi.c:190:9: error: implicit declaration of 
> function 'writeq'; did you mean 'writeb'? 
> [-Wimplicit-function-declaration]
>     190 |         writeq(val, dpi->reg_base + offset);
>         |         ^~~~~~
>         |         writeb
>   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_read':
>   drivers/misc/mrvl_cn10k_dpi.c:195:16: error: implicit declaration of 
> function 'readq'; did you mean 'readb'? 
> [-Wimplicit-function-declaration]
>     195 |         return readq(dpi->reg_base + offset);
>         |                ^~~~~
>         |                readb
>
> Including one of the io-64-nonatomic headers would resolve this but I am
> not sure which one would be appropriate (or perhaps the dependency
> should be tightened to requiring 64BIT, as some other drivers have
> done).

Right, a dependency on 64BIT makes sense here. The alternative is
to include linux/io-64-nonatomic-hi-lo.h or linux/io-64-nonatomic-lo-hi.h
in order to have a replacement readq/writeq implementation that
works on 32-bit architectures. However, doing this requires
understanding whether what the side-effects of accessing the
64-bit registers are and whether they require writing the upper
or lower half of the register last.

     Arnd

