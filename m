Return-Path: <linux-kernel+bounces-448190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27C9F3CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464C81892868
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078F1D61A7;
	Mon, 16 Dec 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Exo/K1NW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E01B5EB5;
	Mon, 16 Dec 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383946; cv=none; b=pNsH4roCh7azDm52oil0Do37hyg0tSqQjJlWHomH5gtY3MXLzLZ/hsfgz4JxEurUnlcd3orFWywGgJcT0hSPk4ec3zFDky6JPIrXkV2a/54xAKrs59Tm9RsBQf0uQvyKNJWxx3up9EZGvB0EQaAVlilwtWFXvwyZZagf2Q9YmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383946; c=relaxed/simple;
	bh=ek+xYaJy87EX5UEGxygqRG6doJzbHOhTzFII2PC4n9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxh6TM8i9gZ8nRlUoSqj9OeGhQywcNOx31n4l1AEQ5JFeaGS4iFWNemJWKcw+QWC9i5Tc7u0KuF37A8jmaPVGwtN9efwlo2aIBAKC5cX5/INVtZ0wKl0In0+CMdMcgDypiUB+/7Y7VLUMsl8FOx8waKeD3a4kddeqAE3DZ1gdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Exo/K1NW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aq6kZVM12fgWzF+pq/rgcXR/bLmQmlEHBp3Dopc19M4=; b=Exo/K1NWyblsPnEfeIij0yFOdP
	mvrvETCJ6OQxMElyMkEOlQEEqCGu5JjNEtupMxwAShKwoU8WJ0N20jA0jpVkUG5P/ZZlKKWDkcXcv
	w8sFnvZ1Zl2UZd5oBNsEDp2JFnr9MCRUWhKljJivlQx3bxdwYUKhCtmUaiHzPdZl5oQq5Qah8P1tF
	cjsDLAbMDqO9DT6BdJMPBZN/NsOzI7uB0FEFXcsVyw+6tv+WDSU+ivXUsi4cF3zKkDH2N6SIJELtH
	QtLhBxviq9TJ8PBHoUGwsk70cr4DlrecqtOGGP4tSa94PF/qqWDc+MHvRquzAzmP9v80pHCkmiNPp
	7GToNoCg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNITz-00000004wgd-1GY9;
	Mon, 16 Dec 2024 21:18:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D7EBE30031E; Mon, 16 Dec 2024 22:18:26 +0100 (CET)
Date: Mon, 16 Dec 2024 22:18:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, lokeshgidra@google.com, minchan@google.com,
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 11/16] mm: enforce vma to be in detached state before
 freeing
Message-ID: <20241216211826.GA33253@noisy.programming.kicks-ass.net>
References: <20241216192419.2970941-1-surenb@google.com>
 <20241216192419.2970941-12-surenb@google.com>
 <20241216211635.GC9803@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216211635.GC9803@noisy.programming.kicks-ass.net>

On Mon, Dec 16, 2024 at 10:16:35PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 16, 2024 at 11:24:14AM -0800, Suren Baghdasaryan wrote:
> > exit_mmap() frees vmas without detaching them. This will become a problem
> > when we introduce vma reuse. Ensure that vmas are always detached before
> > being freed.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/fork.c |  4 ++++
> >  mm/vma.c      | 10 ++++++++--
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 283909d082cb..f1ddfc7b3b48 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -473,6 +473,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> >  
> >  void __vm_area_free(struct vm_area_struct *vma)
> >  {
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +	/* The vma should be detached while being destroyed. */
> > +	VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
> > +#endif
> >  	vma_numab_state_free(vma);
> >  	free_anon_vma_name(vma);
> >  	kmem_cache_free(vm_area_cachep, vma);
> > diff --git a/mm/vma.c b/mm/vma.c
> > index fbd7254517d6..0436a7d21e01 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -413,9 +413,15 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
> >  	if (vma->vm_file)
> >  		fput(vma->vm_file);
> >  	mpol_put(vma_policy(vma));
> > -	if (unreachable)
> > +	if (unreachable) {
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +		if (!is_vma_detached(vma)) {
> > +			vma_start_write(vma);
> > +			vma_mark_detached(vma);
> > +		}
> > +#endif
> >  		__vm_area_free(vma);
> 
> Again, can't you race with lockess RCU lookups?

Ah, no, removing vma requires holding mmap_lock for writing and having
the vma locked, which would ensure preceding RCU readers are complete
(per the LOCK_OFFSET waiter thing) and new RCU readers are rejected for
the vma sequence thing.

