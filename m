Return-Path: <linux-kernel+bounces-186294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC8C8CC252
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DF228577A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AF140381;
	Wed, 22 May 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MGok1PkO"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E313FD91
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385275; cv=none; b=sBwXd9ulESHP372cYwYmiAD7b08DRRPukDUaXQJvVUW7OqWxBCxbK2sj30XFd3ope8g8Fag0L8OZ96bsPtgU3U2J3ai4D5YHQU5UYLAzdhbaArgqk6cqrPZHQ9SZAIVTtDi055mpEXSpe7U1KlY6vncQmrbp0SDtbG3namzjwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385275; c=relaxed/simple;
	bh=JILr1T+P3F3NBN+I1zA7Db/3TKsKONL/5zEv0TIf1W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nFCdvTXqleUlnFJ333Q/5A++f/mqKosDjzEuuzBTglHjYi/B2qxK53XepzTAysaNLdFoaOPfG+h5lcLu9vpbmlSXDGWn2u/1DtnP+Lhorcr7xOxGpibS7nvVcnkh2FOxMnxAQfYniPv9VBmYOjZlkdAubQEgIUsVfDdDDSc5//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MGok1PkO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716385269;
	bh=8/PBiZvFrBuII36XLpoKvRmLCaJ3SFHh2NHdHOARiBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MGok1PkOYR3nLYgp2li4zheiWLLmwM4Y+kBrvn+tV7pn1awxPXSoeQ54DxwYVsaja
	 1UWbN6lPGeu3PmJJrNE5EbUBm3eo7ie9TJDDzS9Tpq0JrpWUOXLP7hZL3blpQ6gxdO
	 S5Bz4IcYZh6CDuGTjp5aS2jG4ZgYj0iI+irkVpjI2NizSMSYppN+jR56rb6344idnG
	 qjj4sGLYCEUbV24RTvU82karag+LMEAlbYzrfv3s7aCHJ0da4HnnIMNZT3GlI1XhQn
	 j8gGhZbeBIZ+Ka9piZznvA3dvyIfexnFy0sZUuMdlfFRFCEPMlMdIW+kIaFIXon21V
	 muU/jdiNaS+lA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vkss031vVz4wcq;
	Wed, 22 May 2024 23:41:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eric Chanudet <echanude@redhat.com>, Mike Rapoport <rppt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Baoquan He <bhe@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Zhen Lei <thunder.leizhen@huawei.com>, Yajun
 Deng <yajun.deng@linux.dev>, Zhang Jianhua <chris.zjh@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nick
 Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] arm64: init: override deferred_page_init_max_threads
In-Reply-To: <xu2rcjwh35zdxx7c52ygep26dox3glnurfcuxuhj3sjqbopzij@zrazmowdb3x2>
References: <20240520231555.395979-5-echanude@redhat.com>
 <ZkzHX-4yYybEJdEQ@kernel.org>
 <xu2rcjwh35zdxx7c52ygep26dox3glnurfcuxuhj3sjqbopzij@zrazmowdb3x2>
Date: Wed, 22 May 2024 23:41:07 +1000
Message-ID: <87plte2ccs.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Chanudet <echanude@redhat.com> writes:
> On Tue, May 21, 2024 at 07:10:07PM +0300, Mike Rapoport wrote:
>> (added powerpc folks)

Thanks Mike.

>> On Mon, May 20, 2024 at 07:15:59PM -0400, Eric Chanudet wrote:
>> > This was the behavior prior to making the function arch-specific with
>> > commit ecd096506922 ("mm: make deferred init's max threads
>> > arch-specific")
>> > 
>> > Architectures can override the generic implementation that uses only one
>> > CPU. Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64
>> > platforms shows faster deferred_init_memmap completions:
>> > 
>> > |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
>> > |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
>> > |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
>> > |---------|-------------|--------------|-----------------|--------------|
>> > | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
>> > |---------|-------------|--------------|-----------------|--------------|
>> > | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
>> > | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |

How did you measure this, just some printks in page_alloc_init_late() or
something more sophisticated? Just so I can do some comparable measurements.

>> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> > index 9b5ab6818f7f..71f5188fe63d 100644
>> > --- a/arch/arm64/mm/init.c
>> > +++ b/arch/arm64/mm/init.c
>> > @@ -158,6 +158,13 @@ static void __init zone_sizes_init(void)
>> >  	free_area_init(max_zone_pfns);
>> >  }
>> >  
>> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> > +int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
>> > +{
>> > +	return max_t(int, cpumask_weight(node_cpumask), 1);
>> > +}
>> > +#endif
>> > +
>> 
>> Maybe we should make this default and let architectures that want a single
>> thread override deferred_page_init_max_threads() to return 1?
>
> It would affect more archs than I can try this on. Currently, only x86
> (with this change, arm64) return more than one thread.

I can test powerpc and we can find someone to test s390. No other arches
have it enabled in their defconfig.

> I'm happy to send a v2 inverting the logic if you find it preferable.

That seems preferable. It's a scalability feature, it makes no sense for
the default to be a single thread AFAICS.

cheers

