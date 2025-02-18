Return-Path: <linux-kernel+bounces-519912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FFA3A37F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDE7A439E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895226FA58;
	Tue, 18 Feb 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="K+UCww/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVNgKfAK"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF926BDBD;
	Tue, 18 Feb 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898194; cv=none; b=lCLNYGBptJkaWIg0KIVxzLf/B36LGPoePv7StM9VSxUToDKkxB0y84bG+PCGi0krakpgl2Lp7oFZTHm7XGmc6GRjcNsDXOb4dsgYP/TJPpiiQVvYoOlSCrL6nvfnyoEjuIXmADkQra66Q2E+DADTzITZyVrtEHdCUJYgEldypQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898194; c=relaxed/simple;
	bh=JLetBBqpgl27EHjJTyI9RtdYxjxiqr2Sn/xzroU+T2Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DmyuWllTWZjqs06wQVBzkVSmlK67CWD2mZJMJ+bC7sGh9DvHuk3wM1OPo2DV6U8HgnRwEOvyloqpS0v7A63K1Fly6U2l7R2l8WYRYO4nzHkgoLySRj9Cysu4rWwtkh22ubJW0nfQpeDSzXPpquycekCFnPB2aWJZpwKAP3vcLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=K+UCww/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sVNgKfAK; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D72111401C0;
	Tue, 18 Feb 2025 12:03:12 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 12:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739898192; x=1739984592; bh=0BPHDdMFCbMZ0idV3mt5hV/uCpN8cnHh
	5jYvtwtgN9A=; b=K+UCww/NIrIrEP8qQiHyMIWxT2XidsJwASKOZ6KQAJdOfuDa
	Q72lSs+o0nLTN6n/tZNOtTxff8LabyFY2K+Y12Ld6d8zjTKSWhqcHqxLsxexIzSW
	u6wccgmFl18vcAO475+b6x7EW0WkM2FdWHSeoV8+uVfhdqaq+BRLTv2xWLN1LuNh
	YKWEjCWZHLPa3oVAq3zQyuP34K7+UBWzCpZpKvGhyIDWslGHmx/g4HfqoMTr3jB9
	5oDMg0rqqnuylseoitz9we/B1oasOgrRzADJCtYCUQhzORcMSG4nhtCUXBedyf+m
	LOZmCkogDDW45O2hq45SG2hZT2qeLlokO1dF/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739898192; x=
	1739984592; bh=0BPHDdMFCbMZ0idV3mt5hV/uCpN8cnHh5jYvtwtgN9A=; b=s
	VNgKfAKtyNlRKtWh3giQ/F6gXvKUDtvLi38mpUiu9rKBpF78xyl/dfbEgsMmPEx6
	2KSbJLPxXJgdM4h0B8/6LyqdZKHzbqq5ILWZB7hX7fJgM1MecXTSoGu3utBMhogf
	qGQjKDF/yoxyoFornmKvm8GgHWcs1FFFteDOVcQEFEpPR3dUQWtp272/qoApkSBz
	vb4oJQs8tL4mHmnIcIo+i2zhu8cmYCW90a1U6WFQr83Jw4ytHWaTqCRU4A/ftI7G
	R5+T6dXfv23dEbNvhj5cift2ta2sl+j9LUjaejYRj3L1m+6x3QoyqXadRD7BbUQi
	8xaFbHzNZ9m9KL2PloQGg==
X-ME-Sender: <xms:T720Z6gKhRoTTVPysiTW7Ew64BVgySoT16Xku7m0VJF4L5xRny_uTg>
    <xme:T720Z7CVDp1Q5BvUePpzJDOhELNKcuXUyxrZGX2JKMrrnGMkc737xGUhXATZbPFGZ
    35KwPDmaaxPfdqJNoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnrgesrg
    hsrghhihhlihhnrgdrnhgvthdprhgtphhtthhopegvrhhrohhrvdejsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheprgigsghovg
    eskhgvrhhnvghlrdgukhdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhn
    rghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhish
    htshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhs
    rdhlihhnuhigrdguvghvpdhrtghpthhtohephhgrrhhshhhithdrmhdrmhhoghgrlhgrph
    grlhhlihesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlhihsshgrsehrohhsvghn
    iiifvghighdrihho
X-ME-Proxy: <xmx:T720ZyE0Uo_RL4L9oANkNAaUZlRh00KHTaWthsC-Z-B_i8UdhvcmGg>
    <xmx:T720ZzREJdK2z8O2YRRSO-qR_zQvqGsVEgDoSBRSjx5Rx_mDrmj9nw>
    <xmx:T720Z3yGWCmRZMyB425hdtFL71FJtHMxtTbFz6FRhX0UQkotnwMD0g>
    <xmx:T720Zx5HuyadFMAiE-GH05qWA-d_rhmPai-REEyshc5d0VpYuGROVg>
    <xmx:T720Z8qvHTGNOVPcKX0nakfQEY7M9ziF0EllL3FEx_n2OpdA5SRyiJfS>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 11872BA006F; Tue, 18 Feb 2025 12:03:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 18:02:50 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Harshit Mogalapalli" <harshit.m.mogalapalli@oracle.com>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Janne Grunau" <j@jannau.net>,
 "Asahi Lina" <lina@asahilina.net>, "Jens Axboe" <axboe@kernel.dk>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 "Dan Carpenter" <error27@gmail.com>
Message-Id: <312a397a-ab54-4128-8f90-184ed719a9ac@app.fastmail.com>
In-Reply-To: <6c965dbc-9f01-414a-b218-2fa88155eb52@oracle.com>
References: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
 <0e609fea-48b0-4b39-aae4-90395a782ed8@app.fastmail.com>
 <6c965dbc-9f01-414a-b218-2fa88155eb52@oracle.com>
Subject: Re: [PATCH] soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Tue, Feb 18, 2025, at 17:01, Harshit Mogalapalli wrote:
> Hi,
>
> On 18/02/25 21:04, Sven Peter wrote:
>> Hi,
>> 
>> 
>> On Wed, Feb 12, 2025, at 09:58, Harshit Mogalapalli wrote:
>>> This code calls kfree(bfr); and then passes "bfr" to rtk->ops->crashed()
>>> which is a use after free.  The ->crashed function pointer is implemented
>>> by apple_nvme_rtkit_crashed() and it doesn't use the "bfr" pointer so
>>> this doesn't cause a problem.  But it still looks sketchy as can be.
>>>
>>> Fix this by moving kfree() after the last usage of bfr.
>>>
>>> Fixes: c559645f343a ("soc: apple: rtkit: Pass the crashlog to the
>>> crashed() callback")
>> 
>> This commit isn't upstream yet afaict, did you mean to post a review comment
>> to [1] instead?
>> 
>
> I made the patch based on linux-next, linux-next has the patch merged.

Whoops, I guess we accidentally already pushed that one to for-next without merging it.
I'll merge both and adjust the commit hash in your Fixes tag.


Thanks,


Sven


