Return-Path: <linux-kernel+bounces-542165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B5A4C685
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799987A60B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80190219A6E;
	Mon,  3 Mar 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="Zi1qTlKj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4OcJ7WqU"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F721516B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018104; cv=none; b=r9mKqyvpoyeoMeVmBj2BcmPrTdpzJk/rybUYE4O8xVfSf15AHqupBu1AzSiIg69OVO8mY61DZtUX8ccckHN9Q2GalwpD0ryYo8tL4tNN7VJI7Ec9EvYu2ql35cA+uLSLvY18yJBiUix6WVS3BWG75JlstDx6OZ6IW60MbfIR0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018104; c=relaxed/simple;
	bh=6BR4u24CndhoIfJBpcQq/sKMFSqWxEklL6+36Y45z0A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KmqlzJqHffWT3yHOX+FUEJU2+7j8Pr0ZTGflA7DyX7+p3BNDCnOBNRU5ay6S1MMgptBh8BuwOSz1M6n+0tnmS39yW3FonArkSo6Zt4RFEk28GZHDlCz5Qb1VJZo9kYVKwJ1f/WW7fpF8NepfiFwFW1K/3s2S6htSIOKKsh6g0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=Zi1qTlKj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4OcJ7WqU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CB6711401D5;
	Mon,  3 Mar 2025 11:08:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-03.internal (MEProxy); Mon, 03 Mar 2025 11:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741018100; x=1741104500; bh=6BR4u24CndhoIfJBpcQq/sKMFSqWxEkl
	L6+36Y45z0A=; b=Zi1qTlKj9Y6OldLM6lz620Az1C0Fh5UofcGoDQujGmDhXhnP
	gXTOWmBHhpSElCWfXqpyJOC3Mp08aQ4Zdn/rlms0a1DkANA9jvaArJ6sQrMp9OP0
	iTfumkBSDgj/43BigCCOEKsXLSLonfPgB4/TSY5YIQx88UdB6g6vVxjXoTkaqapU
	+aKgR/pBjT63bqh9xWeUD+/S9S6csjFWoHi/YqXrdppvFdj3wC+9jcFEhgl3ppJM
	mhOlXFCWGEz0f4Gxz4M7GF7C6QSqUFLd2TxKjbIQ6NtgYRtMY/Uv7YfvRx1kEaBq
	sJY9rJk/RyE8Dy6/hNUvBFO2jmxpenGPOqgbnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741018100; x=
	1741104500; bh=6BR4u24CndhoIfJBpcQq/sKMFSqWxEklL6+36Y45z0A=; b=4
	OcJ7WqUxMK0GCYXS5cCNJGVilnqLDiAO2sT1CZbDnF42DjxvfjyaVRxz5y2FjjEN
	91qdDDw0Y+DE+C00rHL212ryC5JNnBe5Wkl7u6DqFxzhWwsIL7cuH/PwCId+Eh8i
	BjWLmP/wLexMPe3fPYkLAE+s8b6YaqtD4HYcBjL+WDjP6ftYwaU3o6vlZKakBz/W
	9jWQvuQ6jI2wXslDU/wimmMyohIwkuXnmmO4BvpRLeLXLR7iLRDrIqMDC7m4sPOj
	SxSgpyZsqSf+rCJPeWR/uBjLhgyoTdvF3incKkO9mhIIAAU82ihYBfcDkJnNNiUd
	lABY+SlyAHXPWjwQ0Qy/Q==
X-ME-Sender: <xms:9NPFZ8sTUp1mbgzU5tk1eQzld_NYFRcwxeuZnZPZNEGi8gNK6VFDsA>
    <xme:9NPFZ5fr1EobKMMKm_mOBWKH4Y2xtO_Akv4eeOWSf9n2d0B-YfMv47uIQgWQj_Jau
    l1qrIG4i_lw1-7uzcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeeutedtleeiuefgjedvgfejvefftdekleei
    gefgfffhheehkeetleehgfetgedtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghn
    sehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehj
    sehjrghnnhgruhdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhisehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghlhihsshgrsehrohhsvghnii
    ifvghighdrihhopdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9NPFZ3xR5kCZvrT6DI_V52eG2N3aSdTiCIJQlkiykupWVvBn0WLr-Q>
    <xmx:9NPFZ_OFeXr7SUqy90EjZW-ab4I8wO50H-gQGd8vZQiYmMJwC9ErEA>
    <xmx:9NPFZ88eXsZkgkXD89JAhuBR9lXriDFCyEgschTqBCmP3q67J67PLg>
    <xmx:9NPFZ3W0e29h2GHGOCUX9qX5D--dnCJKyWfMiQogBwGYsqGDm2eHTQ>
    <xmx:9NPFZ7mE15yIdZmTLNsEoPcZec4Sgi0x4SHGs65j5JGkj8hA3ses8Npk>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00982BA006F; Mon,  3 Mar 2025 11:08:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Mar 2025 17:07:59 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Neal Gompa" <neal@gompa.dev>, asahi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Janne Grunau" <j@jannau.net>
Message-Id: <634502ea-6389-43c8-8236-7f90f864f73a@app.fastmail.com>
In-Reply-To: <20250303154012.1417088-1-neal@gompa.dev>
References: <20250303154012.1417088-1-neal@gompa.dev>
Subject: Re: [PATCH] MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple
 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 3, 2025, at 16:40, Neal Gompa wrote:
> As a member of the Asahi Linux project, I (Neal) have been involved in
> reviewing the patches downstream as part of enabling the Fedora Asahi Remix
> distribution for years and have recently been reviewing patches for upstream
> submission as well.
>
> This formalizes my role as a reviewer for ARM Apple system support patches.
>
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> ---

Acked-by: Sven Peter <sven@svenpeter.dev>

Nothing much to add to that. You've been reviewing all of our downstream
patches when preparing Fedora Asahi Remix kernels for quite a while now
and provided good feedback so it makes sense to make this official.

I'll pick this up in a few days together with an update to MAINTAINERS
that includes our SPI driver files which I think we missed last year [1].



Best,


Sven


[1] https://lore.kernel.org/asahi/20241106-asahi-spi-v5-3-e81a4f3a8e19@jannau.net/

