Return-Path: <linux-kernel+bounces-565264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1423A664DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B4D189B101
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAEA30100;
	Tue, 18 Mar 2025 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8qOLmA+"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2E184E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260822; cv=none; b=NHsUu6NSDTZAhdi0wTaAgYILCFqExAkk58AHWOQDrjGAMdIdj/BFUmpCgOZoMTJmLlfuocZd8arTDwvHqHF47eMpTtZT5CcOoIxiXHA6FcFYTdRiNOM7HUvg0oYVp/m6NtbidqHtIRI64hvlLo3Iic2aQjXRZlQlAaqc4a7cLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260822; c=relaxed/simple;
	bh=XouFCXKKpXLs77apd+bHsKKnvHmtRmJEKfww8kJFlTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWCH+wIe0DvYz2XcwxA/tFJ7gdsHNh+OT909tJ8rTYzC78UWujXKu55rAAAc+mnLwphVtpNfrUf9rwUzC7FQhNoOTJuTrQSrUpo047Zz5H49wyNhS810FZg8kQwPjBt+Y4OW22UodPOcnrDA9GplBueoI5rcnviO+4TJD4ciAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8qOLmA+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vpwPHrf20lSWnkzGhdqIPFZKWwfBUMFQHDJp14oi8M=;
	b=U8qOLmA+CT7DQ2Jg5YUmxUs0T3NNLq9xr+yALISTNzUP1Q8xMThUfPIMAoAY8Ml45RRB08
	/Fhu3IQUMZ//yX5o2IYqitzyY9VlilY3csrYJC6kG/Hfn4Z5fGCI5aWuDjfZAsKWfsGX11
	9aUwTeUnLuWIewKUBUL6YiLMvlENnUI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 8/9] memcg: combine slab obj stock charging and accounting
Message-ID: <Z9jKSZpr41hcrqvD@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-9-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-9-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:29AM -0700, Shakeel Butt wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> 
> When handing slab objects, we use obj_cgroup_[un]charge() for
> (un)charging and mod_objcg_state() to account NR_SLAB_[UN]RECLAIMABLE_B.
> All these operations use the percpu stock for performance. However with
> the calls being separate, the stock_lock is taken twice in each case.
> 
> By refactoring the code, we can turn mod_objcg_state() into
> __account_obj_stock() which is called on a stock that's already locked
> and validated. On the charging side we can call this function from
> consume_obj_stock() when it succeeds, and refill_obj_stock() in the
> fallback. We just expand parameters of these functions as necessary.
> The uncharge side from __memcg_slab_free_hook() is just the call to
> refill_obj_stock().
> 
> Other callers of obj_cgroup_[un]charge() (i.e. not slab) simply pass the
> extra parameters as NULL/zeroes to skip the __account_obj_stock()
> operation.
> 
> In __memcg_slab_post_alloc_hook() we now charge each object separately,
> but that's not a problem as we did call mod_objcg_state() for each
> object separately, and most allocations are non-bulk anyway. This
> could be improved by batching all operations until slab_pgdat(slab)
> changes.
> 
> Some preliminary benchmarking with a kfree(kmalloc()) loop of 10M
> iterations with/without __GFP_ACCOUNT:
> 
> Before the patch:
> kmalloc/kfree !memcg:    581390144 cycles
> kmalloc/kfree memcg:     783689984 cycles
> 
> After the patch:
> kmalloc/kfree memcg:     658723808 cycles
> 
> More than half of the overhead of __GFP_ACCOUNT relative to
> non-accounted case seems eliminated.

Oh, this is huge!

I believe the next step is to also integrate the refcnt management,
it might shave off few more percent.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

