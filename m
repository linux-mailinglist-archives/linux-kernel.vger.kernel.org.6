Return-Path: <linux-kernel+bounces-519749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BEA3A162
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C093A65A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CBA26D5A5;
	Tue, 18 Feb 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="tDb+G7QI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSMrSP2f"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA9262811;
	Tue, 18 Feb 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892883; cv=none; b=RbvB2758BmGJM6AQ1TTZUlMKVYoC0a+pi5dmuI5/IVTMWtM/IXH7R1Ym9jSzw4o83S4cs3S5VWiw3KmHx8ASmwUcOQRs7t86e1zNjnLgQE+YALCxr3y1vw9JPHgcVQYoGZY8/YT3ngLDGi3Nis3VFoRTXtG97xElTRmgN2WP7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892883; c=relaxed/simple;
	bh=GXMTpvkPCJ7m5KbW5KvE3Nphli4h5mo+kNooPAwQgpU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n2PpJkq6PHDmQMePKOiPg8AxfMcMgD0xKIz/TjpE/9SgpttjRQvtRG5Fz7VlsCBD4R7u/o4ExZeLidObhkGC/y4iZUJyb1kZqnO1hvZUV73EMm9K7K/NjIIhckiPDMBZW7G7mytbuHtEoG2AFOtuH0hJK1HkvauceRqKFGEcgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=tDb+G7QI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TSMrSP2f; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A88825401E6;
	Tue, 18 Feb 2025 10:34:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 10:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739892880; x=1739979280; bh=vNqt5U9GOUsRRqGjKu27jmxa6soUqk9Y
	UPA7tKq4cmQ=; b=tDb+G7QIGPYi+Fs+28MJiKIZFjovpT+nbWDuHk9SCVY7vG8B
	FDE+Oj3ct6izKaBhS8TTZrdJJF2zcGypfbY7eMaR5EUknH27Q4+oIJltEVQNI1LG
	zdoAcncw3B16d7+EK9rmqfxp1E09wLJrxiANy9g8ck6YCzzpJvg9O57HZlGPkvCE
	BxPLSYql2SuHy41fvIv8dbvYHX73gMAKTn9MPvqoT7031TVIewipcPZFI17XdFwJ
	Tm3UX86otR7V1GjxL6faowXM+ABjsGAN6iNvJFg+PHW0+2FvnQauPunSYsSJhvKy
	X2Ivblu9sHz2k2oNJTEJF142RIe+7pQ7wP8bqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739892880; x=
	1739979280; bh=vNqt5U9GOUsRRqGjKu27jmxa6soUqk9YUPA7tKq4cmQ=; b=T
	SMrSP2fsBeXreOuMb300Z2us+GwogmneAy6jSBBlMkE2DpFiIeNShZCJixCWBmsj
	N9N2ek/z+T99ppO8D+MBSelQu46TrnLyf4VmyGQl1uhKkbYK/NN6BhWHL9UA4r/i
	AFcFsb+7/TYPv9RFDaYLhQ3W9ocB4iwq/G9rDJ/f7CddKDZyYHKPkJbbWxUhqTwk
	p7FtlSBmWbLwzyLmf1hSmAr+mcoQq2Tli+Jfq3rcvr6PqHtvex5NxnfB+6dGzozw
	+MEQT8PcmbHYZSZu+x17VnLVXmJIrRus7vNZ1S8NJIcFpPfkoPczFLs6yELzlREq
	78IhWrDxwBcvnHMzmIlvQ==
X-ME-Sender: <xms:jqi0Z4nMHOJMaKq8uG_NlDxLPaw4n-vggnNKA9xjP5O_bl8OWzpscQ>
    <xme:jqi0Z31ISMrHY9hMU5YrjERGwn_v5tQSLO3CnnPAkOab1N-ZgOpyuE8JzHg6qzc__
    7Cc6WtJf4x-TMsTdP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeeutedtleeiuefgjedvgfejvefftdekleei
    gefgfffhheehkeetleehgfetgedtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghn
    sehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheplhhinhgrsegrshgrhhhilhhinhgrrdhnvghtpdhrtghp
    thhtohepvghrrhhorhdvjeesghhmrghilhdrtghomhdprhgtphhtthhopehjsehjrghnnh
    gruhdrnhgvthdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthht
    ohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplh
    hinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopehhrghrshhhihhtrdhmrdhmohhgrghlrghprghllhhisehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhioh
X-ME-Proxy: <xmx:jqi0Z2qDg0I7zAF77FbLuIaV1_8_wROYP2UYLMvCln1_tUcZQgGytg>
    <xmx:jqi0Z0mcq9CMwg__3FKOFptFKMlafcmGjCb3mchG7931NM9T4rmRNg>
    <xmx:jqi0Z23lCqX-FAKEjK0lSMxxuJj8DFyJMGJDDOCStSLrbnSsfBnskQ>
    <xmx:jqi0Z7s5JpdjaV9TyuvDZ5uPko3ClOed0aWVbeyL6WyXaX2WzH-Cng>
    <xmx:kKi0Z_usWWPE6CYtwzc8mZU67wVkMuPUMnI7L_RTvOCU9obF1tlfrnA_>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AEEDBA0072; Tue, 18 Feb 2025 10:34:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 16:34:17 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Harshit Mogalapalli" <harshit.m.mogalapalli@oracle.com>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Janne Grunau" <j@jannau.net>,
 "Asahi Lina" <lina@asahilina.net>, "Jens Axboe" <axboe@kernel.dk>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 "Dan Carpenter" <error27@gmail.com>
Message-Id: <0e609fea-48b0-4b39-aae4-90395a782ed8@app.fastmail.com>
In-Reply-To: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
References: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Wed, Feb 12, 2025, at 09:58, Harshit Mogalapalli wrote:
> This code calls kfree(bfr); and then passes "bfr" to rtk->ops->crashed()
> which is a use after free.  The ->crashed function pointer is implemented
> by apple_nvme_rtkit_crashed() and it doesn't use the "bfr" pointer so
> this doesn't cause a problem.  But it still looks sketchy as can be.
>
> Fix this by moving kfree() after the last usage of bfr.
>
> Fixes: c559645f343a ("soc: apple: rtkit: Pass the crashlog to the 
> crashed() callback")

This commit isn't upstream yet afaict, did you mean to post a review comment
to [1] instead?


[1] https://lore.kernel.org/asahi/20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net/


Best,


Sven

