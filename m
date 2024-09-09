Return-Path: <linux-kernel+bounces-320936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41A97123A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D42D1C22617
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386881B1D57;
	Mon,  9 Sep 2024 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BMT/Vy3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="COEduUZQ"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124631B1D4C;
	Mon,  9 Sep 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870992; cv=none; b=g6Ru2FHFlGqGxmvG33hZQqbqGxHbmATo/GnVoFWz1TYEeyEbP6uFtHSV4NEmd1moqAHzdI2MqhxMzSbg9p2bW81Kx8KCCG/YBRRYBe0AcYL/xgA0ujaamg1KgwESv2WSjUmpj+abo8dNoZSrP8psur3gnHMBaPhPnLHMDCjTfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870992; c=relaxed/simple;
	bh=BRd7iguuq3YS6+3Jho+aSkFhAaF4SJbpROvfc/0ETRU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qJC++U/3Q1meaGaXIUV1YlWlIITEOFD7PB4ubQ+fmd0GBrVZiO1vGzWct6CMLeHclv0YB0JeLil0WShM9LBuV77jcVcwefom4bHhLCwdLSpKRqwt25ryja9oazg7lew5M3xQSHWrTyxUY6Bo61Tyex887XpyKDKBHPNARN4/x4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BMT/Vy3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=COEduUZQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 266AB1140236;
	Mon,  9 Sep 2024 04:36:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Sep 2024 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725870989;
	 x=1725957389; bh=eUXvZi3N7syICvlD+Ix540Dah1pJESMT13JfPSWJwLM=; b=
	BMT/Vy3rmsncpWkN+25cU3Fi2M574TZpnDkkEQ0dXHMrdljRr2koq2Eitvx1MP/h
	DeuL7oMQEkXgWGI8KvIHzN9xvGH7Nx6YWa4WuhfHQiXWeiU3JK6WyRs8aVdG8OG2
	CgnsAEJcTWJET/XzD4k51wyAQAElmjguczWbwspd0GwBqxMlgegQkFZwbbWL9vtf
	a3N+HuY12tKPIdIuv7175EgXdrus/Xh0NZJLjFoJCnYFGIi190Wn/Sq+3vFI/XDW
	BOgta8vJ53T5DJEUPi4xlb9ppTggJzujsHzJv8jvCYp9apt2O83GqzZPkE7YjCMO
	cLtLOgUyvG3Mn5aNUtCqDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725870989; x=
	1725957389; bh=eUXvZi3N7syICvlD+Ix540Dah1pJESMT13JfPSWJwLM=; b=C
	OEduUZQk+zgxb+1igY55Tx9mTQEkWQKCzfcBYBv8Uh71s0iI2aDU+hng2NTurZfM
	2rHQO5pty7bRfJKv2iVSGOHXADFvDlXlrsrxwxFj8NqMTTdy++UBV+MuH2FlDo5v
	jU0LMJJ31SMqmFvPf4opzqUNl7A2oYlmja+gVnE/DAyBC4XcQcJ2HL3ZssPFhJQ+
	J3E6J0SNl855lUqn3AzpldS0ZvemI83EPgiChjkoad1vLHZaT+yxxHUqk43jjsPT
	j7Y+dCGfB59F5mc4i1twt3OPcC+7cKDCdAhsgFsmRcLVU/wRSsd5Nz6OXl5mM889
	N4nez7k2ueKQ8Jm/WSUiw==
X-ME-Sender: <xms:jLPeZhUyLAkdryxEs3c0hraB1VvLhrnUZ_lD1-E8tj9irAhMjSQXhw>
    <xme:jLPeZhlNIkYmZwLfqGo5IRfY2bioFLOLaX77nhMdvoZG8UXSBMZNKnq3hG3XB4Umc
    a8xOPYc3C5ipYdTyWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtohepjhhvvghtthgvrheskhgrlhhrrgihihhntgdr
    tghomhdprhgtphhtthhopeihshhiohhnnhgvrghusehkrghlrhgrhihinhgtrdgtohhmpd
    hrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishht
    shdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:jLPeZtahS2ZLyg3YkDbQyoWcrJFkGknCRxl_wd3kBJ4WkFmu-9Hiyw>
    <xmx:jLPeZkWYxYsozfaIpozex_S5D_NobsRXJ7aQK0dUQ-fYWYplAr_NFA>
    <xmx:jLPeZrmXz3snPfgI1_4ioqEImXXW3ZaB4lGhBJ0VhMJKt60-OgDqLw>
    <xmx:jLPeZhdsJgdACef-6CPyGF_ka-bcGaW_9D45aLR9BrvDAVHuV_eXHQ>
    <xmx:jbPeZpeym_a4JGjP8qaz6EpICL5aHSbqNRjfxQaXaglw2LUgDzFwiccs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48B4C222006F; Mon,  9 Sep 2024 04:36:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 10:35:58 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <3c56dbee-241c-4742-a586-254e10b98cbb@app.fastmail.com>
In-Reply-To: <20240906114151.519028-2-jvetter@kalrayinc.com>
References: <20240906114151.519028-1-jvetter@kalrayinc.com>
 <20240906114151.519028-2-jvetter@kalrayinc.com>
Subject: Re: [PATCH 1/4] Consolidate __memcpy_{to,from}io and __memset_io into a single
 lib
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2024, at 11:41, Julian Vetter wrote:
> Various architectures have almost the same implementations for
> __memcpy_{to,from}io and __memset_io functions. So, consolidate them and
> introduce a CONFIG_GENERIC_IO flag to build the given lib/io.c.
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>

Thanks for working on this. The implementation looks correct
to me and we should be able to use this on most architectures,
but since this is a shared file, it would be good to make it
as polished as possible.

>  lib/Kconfig  |   3 ++
>  lib/Makefile |   2 +
>  lib/io.c     | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 lib/io.c

I feel the name is a little too geneal, maybe use io_copy.c and
CONFIG_GENERIC_IO_COPY for the name?

Alternatively, this could be part of lib/iomap_copy.c,
which already has some related helper functions. In that
case, I think we would rely on the per-architecture "#define
__memcpy_fromio __memcpy_fromio" etc macros instead of a
Kconfig symbol.

> +void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
> +{
> +	while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
> +		*(u8 *)to = __raw_readb(from);
> +		from++;
> +		to++;
> +		count--;
> +	}

There is a corner case that this bit actually misses (same in the
existing implementation): If the __iomem buffer is aligned, but
the 'to' buffer is not, this may cause an alignment fault on
architectures without native unaligned stores. At the moment
I think both csky and some configurations of loongarch64 can
run into this. I think the best way to deal with this is to
use get_unaligned()/put_unaligned() in place of the pointer
dereference. This has no effect on architectures that have
native unaligned access but otherwise uses byte access on the
kernel buffer, which I think is a good tradeoff.

> +	while (count >= NATIVE_STORE_SIZE) {
> +		*(uintptr_t *)to = __raw_read_native(from);
> +		from += NATIVE_STORE_SIZE;
> +		to += NATIVE_STORE_SIZE;
> +		count -= NATIVE_STORE_SIZE;
> +	}

The use of __raw_read_native() somehow bothers me, it seems
a little more complicated than open-coding the two
possibles paths, or even using the aligned-access
helpers like

      if (IS_ENABLED(CONFIG_64BIT))
             __iowrite64_copy(to, from, count & WORD_MASK)
      else
             __iowrite32_copy(to, from, count & WORD_MASK)

Those helpers do require the kernel buffer to be naturally
aligned though.

> +void __memset_io(volatile void __iomem *dst, int c, size_t count)
> +{
> +	uintptr_t qc = (u8)c;
> +
> +	qc |= qc << 8;
> +	qc |= qc << 16;
> +#if IS_ENABLED(CONFIG_64BIT)
> +	qc |= qc << 32;
> +#endif

If you use IS_ENABLED() here, please do it like

       if (IS_ENABLED(CONFIG_64BIT)
              qc |= qc << 32;

      Arnd

