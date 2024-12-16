Return-Path: <linux-kernel+bounces-447285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34C9F3008
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1951218850FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E120459A;
	Mon, 16 Dec 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JEwhNiz+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D24145A11
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350601; cv=none; b=QVdqkECwGQdzfKO6yQ4v7Z40pCvMFauowdfhaTybIVlDIROYXJHLAgvxkhEyaHgEy0UolEFgk0cJwRIisFqBaVYO6EWAEeBjGwqdXPfGHWe8aIVDIoklHUNzRFpqSEYZwMHYpoIYsFYY0+MgnnmAefnOYrhS89kiUMHPgE8mXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350601; c=relaxed/simple;
	bh=XbzKpovKEVpX2L8GaGQp02q8fcdvh1LOzdWttXOTzgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geNluA+UzaxLoP1lkcrSa5hTf70ZiSueXCTS9kGKv+dSJ4JdBL3kjPIrLd7/A5iZjYoMjBCqHZzQ6OzJ7HW295lroEt2N6j99zYie1qSXgiiaq27/tmXPy2khAT5mAg+ElPluve2J6fmFau/Xmc5AsWYLIKu9mmfCnnfVot/ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JEwhNiz+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GqtiXAiLKRhO9WaOADcBcZ5nHd2bJ5BklFEOYKx+ttg=; b=JEwhNiz+ZbklId3UqK7BKrLp4J
	oqfcU+LJjvn73TUiED5/LZy7CepQsariwDMRdO6yJcHMdQkjI+sJ2a9LbUZQt1TVA9SAywJDHhw2W
	cIXLH0qNiOgen62ImXuvjjq27MRpGUbUArINSSIwPecrmQzd03EZdAbt07r6fgQx1y6kTMxtIYL8J
	0PKdYsalrSebcnFEJ0x2kJI9+oJ4aIL8DXaP+BIKtDbrjO8/iqC0G2pGSjwVaZDIL3it4L1ctVoL/
	lMmWMjxgQkqAyhOKMNOB6WOzIpOXk67rc0CrWywPWWyrhc+LdZFBH57WYpBnUocttsQgfkUaAYFCF
	Dpc4ndhA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tN9og-0000000G5DB-0JNP;
	Mon, 16 Dec 2024 12:03:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8FA1F30031E; Mon, 16 Dec 2024 13:03:13 +0100 (CET)
Date: Mon, 16 Dec 2024 13:03:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com,
	hughd@google.com, yuzhao@google.com, willy@infradead.org,
	muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Message-ID: <20241216120313.GE12500@noisy.programming.kicks-ass.net>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216120043.GA11133@noisy.programming.kicks-ass.net>

On Mon, Dec 16, 2024 at 01:00:43PM +0100, Peter Zijlstra wrote:
> On Sat, Dec 14, 2024 at 05:02:57PM +0800, Qi Zheng wrote:
> 
> > diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> > index c73b89811a264..3e002dea6278f 100644
> > --- a/arch/s390/mm/pgalloc.c
> > +++ b/arch/s390/mm/pgalloc.c
> > @@ -193,13 +193,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
> >  	pagetable_dtor_free(ptdesc);
> >  }
> >  
> > -void __tlb_remove_table(void *table)
> > -{
> > -	struct ptdesc *ptdesc = virt_to_ptdesc(table);
> > -
> > -	pagetable_dtor_free(ptdesc);
> > -}
> > -
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  static void pte_free_now(struct rcu_head *head)
> >  {
> 
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index 709830274b756..939a813023d7e 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> 
> >  #define MAX_TABLE_BATCH		\
> >  	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
> >  
> > +#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
> > +static inline void __tlb_remove_table(void *_table)
> > +{
> > +	struct ptdesc *ptdesc = (struct ptdesc *)_table;
> > +
> > +	pagetable_dtor(ptdesc);
> > +	pagetable_free(ptdesc);
> > +}
> > +#endif
> 
> 
> Spot the fail...
> 
> That said, all this ptdesc stuff is another giant trainwreck. Let me
> clean that up for you.
> 
> ---

> -static inline void __tlb_remove_table(void *_table)
> +static inline void __tlb_remove_table(void *table)
>  {
> -	struct ptdesc *ptdesc = (struct ptdesc *)_table;
> +	struct ptdesc *ptdesc = page_to_ptdesc(table);
>  
>  	pagetable_dtor(ptdesc);
>  	pagetable_free(ptdesc);

And now observe that __tlb_remove_table() is identical to
asm-generic/pgalloc.h pte_free(), pmd_free(), __pud_free() and
__p4d_free().

And I'm sure we don't need 5 copies of this :-), wdyt?

