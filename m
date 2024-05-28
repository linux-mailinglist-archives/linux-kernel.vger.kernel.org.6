Return-Path: <linux-kernel+bounces-192666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3E68D205F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3541C23360
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591416F831;
	Tue, 28 May 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q1vvbeAq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvrcWN1N"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140971E867
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910239; cv=none; b=t0dG/HzkerpJd18bnaBh/b1K1/uggsqMTT8ZGizYrnrqZoWlW9yvp6XuqH6hT5h2xUGEs5foiKDLXQA2PyMrdEmLYUJPTRgNJ/woBR9ySMk8Nuab2m5OxuwjknyCpsH1USoaLUT7RG4xDpAyJF2U61lSLkNsQpShc2aXMSxZghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910239; c=relaxed/simple;
	bh=vNumeZh5q4NeM50VYxpxDIpureeBqrFisTwmf1VYd9E=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qiE/C3tZwbozZDnl56uVc7EBuirNdWejwD0kF5pkeWRZb1nIn0h8cnq+Hgs3XuiaVnVv9ehJnuG6L+KSAISyDYuswfVQBzqrX1Wfb8E1S6KBHwB2oKU32+xt8YqUgvw4hdrGe9cyciMDkKB7PV6B4eqmP7JJ7/Hp4XLfcRkGFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q1vvbeAq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvrcWN1N; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 98FCF1C00102;
	Tue, 28 May 2024 11:30:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 28 May 2024 11:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716910235; x=1716996635; bh=ZL76YP1Fqm
	/erlLogzqdx2qkHztyB9mHLwRpngkHDC0=; b=q1vvbeAqeSTGv/Yrb9ltqjTins
	oTQlNCeqvY2Vxg2Vl9mcW8WvaP/WtK6Ey0PEqAgclozXw3eQUMdpxXUH5gdaKTni
	0jQ6smLl8aupdW5K2lSfI0ZOXyEYHPFnj9u3POIShzDOsQHCqECeDY31vOQpcfdo
	6zE2lOI+Uvb68pN3oyptZUeESihG8+HC2AmXKcM+mGhKwrpmbE8oIJchq2qNvX9Y
	KViVO/7W0Ht+jXLp93827KjYS/7gATnWy36tYgqAWlHWf+gOiewP/dPUwns2Wr7Q
	HWJdUyER3X9mUSze2bx7vX947K+GBFH4onn/BWxd+5p5Laxu7uEpuBxMN77A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716910235; x=1716996635; bh=ZL76YP1Fqm/erlLogzqdx2qkHzty
	B9mHLwRpngkHDC0=; b=lvrcWN1Nb7PVePz/yF0C+au2qiOIwXeA3OMtNXkPnxio
	tEHRGkA85TkeDIdDD2D33SlthkSND+BtM7RG1ocqQi1degW4+j76uHrWOOBwk3F6
	edI/GsOVcvbfcA4DmjK6CzPsFliX1S5HbBU92xGccRJdlw1wRP3d802WA/cl8kvq
	mrrwuwG2DtZmlcZJa5hK7FTf8e020PTmBKUIL5rA+AKiUZXkDHuh590wiZvQ0U0c
	7heYKCEu86VUfkuCL7BKatq+nNKx6cC+V9zNTo6t2OgYd7FHvg2gc7VhU2RHeKrD
	qOEilUuplOtWUVSewZRndWe7Hc6+Vm/wdJdATOtZhA==
X-ME-Sender: <xms:mvhVZkz1qOoU_EpVArv5I9VfF740cmX4vA_YfZoZwdogCc5j1bBCYg>
    <xme:mvhVZoTVWAiAAsZKj7CH1pUuoQ961z7KX2VurGSUrLGaWqIMhzRII8V7xsg-4zKk-
    Pv30FJHB74JHTOzytI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mvhVZmXZt6JA_KJ0evNP0o_4ZZxBv6ZaTOxdG_FwrZSSJxUdzblApQ>
    <xmx:mvhVZii6l7nWcfwnOYwrOQjWp2hgue1dbJUNpNOeVmno_Lt4Xg_0dQ>
    <xmx:mvhVZmD3_d_kEcdSXwOF5RmAxLEeht17zOjhdjF57pOodbWQsJ7SSw>
    <xmx:mvhVZjIwyVhQ8oW_WmHMuhHG-hAdCXrohgMcO3-PMkr6GdayRd87hA>
    <xmx:m_hVZuu0L8bgp0F3Etn0936Lf8BLSzUAKUFNbeWDqW3JERfLr8u7BgaI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 850A3B60092; Tue, 28 May 2024 11:30:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dae50a9d-0d69-4653-aa3b-4bc463309c71@app.fastmail.com>
In-Reply-To: <20240528120844.3523915-1-arnd@kernel.org>
References: <20240528120844.3523915-1-arnd@kernel.org>
Date: Tue, 28 May 2024 17:30:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: "Valentin Schneider" <vschneid@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Baoquan He" <bhe@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/io: add constant-argument check
Content-Type: text/plain

On Tue, May 28, 2024, at 14:08, Arnd Bergmann wrote:

> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 4ff0ae3f6d66..44913f227060 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -199,7 +199,8 @@ void __iowrite32_copy_full(void __iomem *to, const 
> void *from, size_t count);
>  static inline void __const_iowrite32_copy(void __iomem *to, const void 
> *from,
>  					  size_t count)
>  {
> -	if (count == 8 || count == 4 || count == 2 || count == 1) {
> +	if (__builtin_constant_p(count) &&
> +	    (count == 8 || count == 4 || count == 2 || count == 1)) {
>  		__const_memcpy_toio_aligned32(to, from, count);
>  		dgh();
>  	} else {

I ran into the same issue on __const_iowrite64_copy()
now, will send an updated patch. I also noticed that
the __iowrite32_copy() and __iowrite64_copy() look
redundant after my change, so I wonder if we should
just remove those and rename __const_iowrite32_copy()
and __const_iowrite64_copy() accordingly.

    Arnd

