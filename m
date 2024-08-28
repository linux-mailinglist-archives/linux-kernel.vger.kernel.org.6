Return-Path: <linux-kernel+bounces-305689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7D9632E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702E51F22120
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195F1B142C;
	Wed, 28 Aug 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r6VWAOlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33921AC89F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877878; cv=none; b=Qzgu4sU3G1DnzuW8D9oHSyUfCp7vOp3c+0SRgZ7LcszaEbpD0f/JehQsRAosaweTWTj7FiHa+ZgehyLlmZAFV4IuTLXpy3iGqIC2Q6mjJZykB8Ji6mRN3cYt1vl3f8ee/tf0k6UiM+rTrnHvHi/7fvs+9creM5Bz3FB1LUB1hAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877878; c=relaxed/simple;
	bh=e7XQvZ+MuNAj42+YJ2nOrwq1Pe5cILXmL1FaVf/3W14=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vw4bXSedGFffH1FblKxhslGUCt/ALBkfevNtUZrUjuXNL4H5D8uy/DqIRhUZWIjBAVCA8uKpx0Gf4dU1vm6XyysXAO4BiqlaknN3aEaeS8evvXgiZ8SfmA8zQvibGbn2DR+hUkU87lPlEgXP9SumGljjPecBhQTelVo7FIPVUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r6VWAOlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A84C4CEC0;
	Wed, 28 Aug 2024 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724877877;
	bh=e7XQvZ+MuNAj42+YJ2nOrwq1Pe5cILXmL1FaVf/3W14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6VWAOlbGqku82EjBNHSGm9GgfIlS4gGTzzwjS5RihJ0dVO9v6WeKKfqsXSKxFBIu
	 jNq7rIlxgLkYjbaf/aPYG8l2vqb0rocipxXOrNZXE2dH0MAWSSnd9J5VIVzA0stdM+
	 iszqTWFlzryrzrmugnoNR9HmCXTDokCOMnX8lhns=
Date: Wed, 28 Aug 2024 13:44:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: muchun.song@linux.dev, dave@stgolabs.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] mm/hugetlb: sort out global lock annotations
Message-Id: <20240828134435.443d7f7ec65eba1db4436434@linux-foundation.org>
In-Reply-To: <CAGudoHE73o5oK77iOFKqH4D4Cz6t9TAu4882+_F9vHH7muNH-A@mail.gmail.com>
References: <20240828160704.1425767-1-mjguzik@gmail.com>
	<20240828124929.db332259c2afad1e9e545b1f@linux-foundation.org>
	<CAGudoHE73o5oK77iOFKqH4D4Cz6t9TAu4882+_F9vHH7muNH-A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 22:13:49 +0200 Mateusz Guzik <mjguzik@gmail.com> wrote:

> > It's conventional (within MM, at least) to put the section thing at the
> > end of the definition, so tweak:
> >
> > --- a/mm/hugetlb.c~mm-hugetlb-sort-out-global-lock-annotations-fix
> > +++ a/mm/hugetlb.c
> > @@ -72,14 +72,14 @@ static unsigned int default_hugepages_in
> >   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
> >   * free_huge_pages, and surplus_huge_pages.
> >   */
> > -__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
> > +DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
> >
> 
> I tried things in this order and this does not compile for me:
> In file included from ./arch/x86/include/asm/current.h:10,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/mm.h:7,
>                  from mm/hugetlb.c:8:
> ./include/linux/cache.h:80:3: error: expected ‘,’ or ‘;’ before ‘__attribute__’
>    80 |   __attribute__((__aligned__(SMP_CACHE_BYTES),                  \
>       |   ^~~~~~~~~~~~~
> ./include/linux/cache.h:86:36: note: in expansion of macro ‘__cacheline_aligned’
>    86 | #define __cacheline_aligned_in_smp __cacheline_aligned
>       |                                    ^~~~~~~~~~~~~~~~~~~
> mm/hugetlb.c:75:31: note: in expansion of macro ‘__cacheline_aligned_in_smp’
>    75 | DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~

Well that's annoying.  It's because DEFINE_SPINLOCK includes an initializer.

--- a/mm/hugetlb.c~mm-hugetlb-sort-out-global-lock-annotations-fix-fix
+++ a/mm/hugetlb.c
@@ -72,7 +72,7 @@ static unsigned int default_hugepages_in
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
  * free_huge_pages, and surplus_huge_pages.
  */
-DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
+spinlock_t hugetlb_lock __cacheline_aligned_in_smp = __SPIN_LOCK_UNLOCKED(hugetlb_lock);
 
 /*
  * Serializes faults on the same logical page.  This is used to
_

We'd need a new DEFINE_SPINLOCK_ALIGNED() or something.

Ho hum, I'll fix.

