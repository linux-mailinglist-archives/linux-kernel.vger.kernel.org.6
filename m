Return-Path: <linux-kernel+bounces-262721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C5293CB44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D28A2829E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7BF145B05;
	Thu, 25 Jul 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uAPV4yBf"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6313CFBB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950440; cv=none; b=e92lkb/KGbSBUqRo1LHrlrYlCtSp/mJZNlgmSE2ZDFwF4kyR5d2payzy3xbqNEIfmXkxKdP5J2PPx6+8ytioamnWR0ci/U3aHNN05JtT9TAmOi7TnhTa6/BCQ9GTqTxjvxWFFaH4b5F6usrZP6QqQ10/M+l0OGXVv1//9cnzaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950440; c=relaxed/simple;
	bh=hQN/a6ZYatdkTGJGLUfgGwR5zF0yP8aX/FIZ/dBd7U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS3gug45PO1E0UbeVJPH5ENe6huT7B2SYc6nN+zBnwrdSMgq94ST5LXQnxpHS1ysXSC0EGuWdnNMyDENpM8xn8hChlhREOH4INEfDkaIDon1aBA6KXqRmVh5MzcJrYtCZDyoLGL5+mw597IMTWcTd/ulhfQkYd54M4BsxtHNISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uAPV4yBf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jul 2024 23:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721950435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+9XM/fW5RfwKkN8eewGZAUVoURY2akltnsnwAvZUkc=;
	b=uAPV4yBf/iuqodww1FoyZ6JHMnBCp2eGgGqbuI6xDaus8JYa6hr4e/AbUxU4i3nYKmM/42
	3BpEvWbXQnZ1YaS71Njy64i5ZH45wDxTLCDVUmuMPmdck3x0EFMavaPlO9vEkfZ17rcD+l
	HUzMr+eu/Q0s623RSlhnBjxmzcbmaDw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 3/5] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <ZqLg30nOUVlerBh1@google.com>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-4-roman.gushchin@linux.dev>
 <20240725214227.GC1702603@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725214227.GC1702603@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 25, 2024 at 05:42:27PM -0400, Johannes Weiner wrote:
> On Wed, Jul 24, 2024 at 08:21:01PM +0000, Roman Gushchin wrote:
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -5,14 +5,71 @@
> >  #include <linux/atomic.h>
> >  #include <linux/cache.h>
> >  #include <linux/limits.h>
> > +#include <linux/mm_types.h>
> >  #include <asm/page.h>
> >  
> > +/*
> > + * Page counters are used by memory and hugetlb cgroups.
> > + * Memory cgroups are using up to 4 separate counters:
> > + * memory, swap (memory + swap on cgroup v1), kmem and tcpmem.
> > + * Hugetlb cgroups are using 2 arrays of counters with HUGE_MAX_HSTATE
> > + * in each to track the usage and reservations of each supported
> > + * hugepage size.
> > + *
> > + * Protection (min/low) is supported only for the first counter
> > + * with idx 0 and only if the counter was initialized with the protection
> > + * support.
> > + */
> > +
> > +enum mem_counter_type {
> > +#ifdef CONFIG_MEMCG
> > +	/* Unified memory counter */
> > +	MCT_MEM,
> > +
> > +	/* Swap */
> > +	MCT_SWAP,
> > +
> > +	/* Memory + swap */
> > +	MCT_MEMSW = MCT_SWAP,
> > +
> > +#ifdef CONFIG_MEMCG_V1
> > +	/* Kernel memory */
> > +	MCT_KMEM,
> > +
> > +	/* Tcp memory */
> > +	MCT_TCPMEM,
> > +#endif /* CONFIG_MEMCG_V1 */
> > +#endif /* CONFIG_MEMCG */
> > +
> > +	/* Maximum number of memcg counters */
> > +	MCT_NR_MEMCG_ITEMS,
> > +};
> > +
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +#ifdef HUGE_MAX_HSTATE
> > +#define MCT_NR_HUGETLB_ITEMS HUGE_MAX_HSTATE
> > +#else
> > +#define MCT_NR_HUGETLB_ITEMS 1
> > +#endif
> > +
> > +/*
> > + * max() can't be used here: even though __builtin_choose_expr() evaluates
> > + * to true, the false clause generates a compiler error:
> > + * error: braced-group within expression allowed only inside a function .
> > + */
> > +#define MCT_NR_ITEMS (__builtin_choose_expr(MCT_NR_MEMCG_ITEMS > MCT_NR_HUGETLB_ITEMS, \
> > +					    MCT_NR_MEMCG_ITEMS, MCT_NR_HUGETLB_ITEMS))
> > +
> > +#else /* CONFIG_CGROUP_HUGETLB */
> > +#define MCT_NR_ITEMS MCT_NR_MEMCG_ITEMS
> > +#endif /* CONFIG_CGROUP_HUGETLB */
> > +
> >  struct page_counter {
> >  	/*
> >  	 * Make sure 'usage' does not share cacheline with any other field. The
> >  	 * memcg->memory.usage is a hot member of struct mem_cgroup.
> >  	 */
> > -	atomic_long_t usage;
> > +	atomic_long_t usage[MCT_NR_ITEMS];
> >  	CACHELINE_PADDING(_pad1_);
> >  
> >  	/* effective memory.min and memory.min usage tracking */
> > @@ -25,9 +82,9 @@ struct page_counter {
> >  	atomic_long_t low_usage;
> >  	atomic_long_t children_low_usage;
> >  
> > -	unsigned long watermark;
> > -	unsigned long local_watermark; /* track min of fd-local resets */
> > -	unsigned long failcnt;
> > +	unsigned long watermark[MCT_NR_ITEMS];
> > +	unsigned long local_watermark[MCT_NR_ITEMS]; /* track min of fd-local resets */
> > +	unsigned long failcnt[MCT_NR_ITEMS];
> >  
> >  	/* Keep all the read most fields in a separete cacheline. */
> >  	CACHELINE_PADDING(_pad2_);
> > @@ -35,8 +92,9 @@ struct page_counter {
> >  	bool protection_support;
> >  	unsigned long min;
> >  	unsigned long low;
> > -	unsigned long high;
> > -	unsigned long max;
> > +	unsigned long high[MCT_NR_ITEMS];
> > +	unsigned long max[MCT_NR_ITEMS];
> > +
> >  	struct page_counter *parent;
> >  } ____cacheline_internodealigned_in_smp;
> 
> This hardcodes way too much user specifics into what should be a
> self-contained piece of abstraction. Should anybody else try to use
> the 'struct page_counter' for a single resource elsewhere, they'd end
> up with up to 5 counters, watermarks, failcnts, highs and maxs etc.
> 
> It's clear that the hierarchical aspect of the page_counter no longer
> works. It was okay-ish when all we had was a simple hard limit. Now we
> carry to much stuff in it that is only useful to a small set of users.
> Instead of doubling down and repeating the mistakes we made for struct
> page, it would be better to move user specific stuff out of it
> entirely. I think there are two patterns that would be more natural:
> a) pass a callback function and have a priv pointer in page_counter
> for user-specifics; or b) remove the hierarchy aspect from the page
> counter entirely, let the *caller* walk the tree, call the page
> counter code to trycharge (and log watermark) only that level, and
> handle everything caller specific on the caller side.
>
> All users already have parent linkage in the css, so this would
> eliminate the parent pointer in page_counter altogether.
> 
> The protection stuff could be moved to memcg proper, eliminating yet
> more fields that aren't interesting to any other user.

Hm, Idk, I do agree with what you're saying about the self-contained
piece of abstraction (and I had very similar thoughts in the process),
but there are also some complications.

First, funny enough, the protection calculation code was just moved to
mm/page_counter.c by a8585ac68621 ("mm/page_counter: move calculating protection
values to page_counter"). The commit log says that it's gonna be used by the drm
cgroup controller, but the code is not (yet?) upstream apparently. I don't have
any insights here. If there will be the second user for the protection
functionality, moving it back to memcontrol.c is not feasible.

Second, I agree that it would be nice to get rid of the parent pointer in
struct page_cgroup entirely and use one in css. But Idk how to do it
without making the code way more messy or duplicate a lot of tree walks.
In C++ (or another language with generics) we could make struct page_counter
taking the number of counters and the set of features as template parameters.

I feel like with memcg1 code being factored out the benefit of this reorg
lowered, so how about me resending 2 first patches separately and spending
more time on thinking on the best long-term strategy? I have some ideas
here and I thought about this work as a preparatory step, but maybe you're
right and it makes sense to approach it more comprehensively.

Thanks!

