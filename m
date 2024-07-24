Return-Path: <linux-kernel+bounces-261338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96CD93B605
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF12820BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F915F406;
	Wed, 24 Jul 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTX8IFDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9652E639
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842408; cv=none; b=Nvjra2/jdfpMj+PnvyMlXn40sSLXl5NebpTaEfPq3r02emE9DPELlEbbZEOLlSpWbU05MjYs+lrQWWNIDYZaEpYMYOX0UnVG8EVJIKDYkOPDcXTNnZ/neljmNF+ikbBLsl/7TuH4byf9gq+adG5Ai3+3wdOsfb7v79RuVg0khLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842408; c=relaxed/simple;
	bh=k5wLDIsjbneFv5wGRryH1sr6jOqAO+CqLMj4RibZsKo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=NAfuyUt1QxpGxmsj5Tm9Mk3ft/FY5BrXT/UShMRgSWA2rz35CHkvUQwVWJDTyJ/4HC6S0JON27EwOD51a8BW8Dx62wttMbnHJYI2ozbUHVm4cimeE2xdiapXbDTnnOHyobkoydNDSgGFWLRK9MrrCWFoz/+dUR8oqiO19fL+I64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTX8IFDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BFDC32781;
	Wed, 24 Jul 2024 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721842408;
	bh=k5wLDIsjbneFv5wGRryH1sr6jOqAO+CqLMj4RibZsKo=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=ZTX8IFDCJC276STozusukSjyNkMrUHn6EYm8TrxU1LOR1cTF8NqDOOt3Qkq23y3Zd
	 xb1OPSam5xdHi1WOyFZEa3IIGTHPYjqvhOsCqyJV4fmpU3stF8BK7vPK87IKvu3/cG
	 yAY2/AF/bD8hjLSbWcEwhdKsxzYdHGNGZIdPS0/xBMq+rCTYQiupTpHXxY+1c/FWfM
	 WdrCKcieMpnua9mahwuUl5+L4u4MEHfEG0mR+1KCyWdefJDoPkOJ6LtHVoXcTDd6y2
	 S2liInCfXDdQm4ejCGGrnwRknuWs9a69Xyh5bITrc8nCJbe7pz+pPss6w2p0pLbfb1
	 t8TMHEZ9P40Iw==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F32FB1200066;
	Wed, 24 Jul 2024 13:33:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 13:33:26 -0400
X-ME-Sender: <xms:5TqhZnGqjC1QwMsm_R1SSG3HzTVQ20a-fxS-dF9U8_yULdXCBnk40Q>
    <xme:5TqhZkU0KCzrPRYlwHEurE5I-TwWsFC4-zCblnBYYIwiFLCWdd6Fw4UsHGeP7SXzL
    2RmebX42CfQRHFYEVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:5TqhZpKXEOkG1I7WuwlirRxgaW-k6unQRHqvpo4fe-aEXmDamgPxtQ>
    <xmx:5TqhZlEhub_YAunlNzIy5etfGgMpF6A0n7pa0BkrVxObh90W6JIR3A>
    <xmx:5TqhZtW5sSYzczdKctWyto2LpKknDZmaHGMAbcSenwtB5AK6-0OyFA>
    <xmx:5TqhZgMa5K3aHcMatPVlGJCFFZpmRaiGKs1Zeki_sTlw8V_bT0SqIA>
    <xmx:5TqhZs1W3wBF7UzCF3yYzk9OqNFf7lkLJVtoMlEhFSdVKO3UH64r4I1U>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 616A8B60092; Wed, 24 Jul 2024 13:33:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24be8665-4717-4ee2-8a81-80fed5181736@app.fastmail.com>
In-Reply-To: <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
Date: Wed, 24 Jul 2024 19:32:14 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "David Laight" <David.Laight@aculab.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>
Cc: "Matthew Wilcox" <willy@infradead.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "'linux-mm@kvack.org'" <linux-mm@kvack.org>
Subject: Re: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const, if_not_const)
Content-Type: text/plain

On Wed, Jul 24, 2024, at 16:29, David Laight wrote:

> +#define __if_constexpr(expr, if_const, if_not_const)		\
> +	_Generic(0 ? ((void *)((long)(expr) * 0l)) : (char *)0,	\
> +		char *: (if_const),				\
> +		void *: (if_not_const))
> +
> -#define __is_constexpr(x) \
> -	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> +#define __is_constexpr(expr) __if_constexpr((expr), 1, 0)

I don't immediately see anything wrong with this, but I'm
still scared of any change to it, especially if this is
meant to go straight into mainline.

Would it be possible to do patch 4/7 without the new
__if_constexpr() and instead still using __builtin_choose_expr()?

     Arnd

