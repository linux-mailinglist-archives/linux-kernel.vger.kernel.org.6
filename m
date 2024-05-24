Return-Path: <linux-kernel+bounces-188186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65DF8CDEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655811F2169D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0016116;
	Fri, 24 May 2024 00:47:52 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FC81F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511672; cv=none; b=c56otq0N5WjotXhonFyh/fRTwymhwBIiTAPjmRIDXSGXXLcMsQs3MhM7wefaGQvuTj0N66RNF7xEJlKV1K1qB424t93/uipdWuBE/DPI/tWNkb1IE0CKluLrBhlsGcCEty7CsWUKIcBv9R3FsGAr0uW4Dj9k782j/ZNjc/TL+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511672; c=relaxed/simple;
	bh=9TiQ1NawlgxMFkjnvp0VImY+CBDxe13HEElO1pLM4yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRWNNh1YLuXh0p68KxUuZGNcrDM+d/W6F66/lemZHQUqig7sVUzk9ue1D3/xsS/K4rLdykbh5QA/KJihq29/gTiX5Gn7Na+SLzUPnC/uAQP8Z0DP1DN4e72Rnx4KmA3zWN2wE2FtS3Y4Rro2HPZi9se1d6Oq+ReM3zm4y/03G2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-40-664fe3a87ca5
Date: Fri, 24 May 2024 09:47:31 +0900
From: Byungchul Park <byungchul@sk.com>
To: Karim Manaouil <kmanaouil.dev@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240524004731.GA78958@system.software.com>
References: <20240523051406.81053-1-byungchul@sk.com>
 <Zk88UTrNIAMWdLMs@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk88UTrNIAMWdLMs@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsXC9ZZnke6Kx/5pBs/n6lvMWb+GzeLthO2M
	Fpd3zWGzuLfmP6sDi8fOWXfZPTZ9msTucWLGbxaPz5vkAliiuGxSUnMyy1KL9O0SuDLOnG1j
	KlhkXjF13SPmBsafWl2MnBwSAiYSU39+YoexJ35dzwZiswioSvxuWsoMYrMJqEvcuPETzBYR
	0JGY8LQdqJ6Dg1kgS2J6axRIWFggSaLn3gYmEJtXwEJix4J1jCC2kECCxIZvPcwQcUGJkzOf
	sIDYzAJaEjf+vWSCGCMtsfwfB0iYU8BU4tqNxWAlogLKEge2HQcq4QK6bAKbxMYDm6HOlJQ4
	uOIGywRGgVlIxs5CMnYWwtgFjMyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQIDdlntn+gdjJ8u
	BB9iFOBgVOLhPaDvnybEmlhWXJl7iFGCg1lJhDd6pW+aEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsbcxr6jDaEmSR5HL9zmqIy49NWiZP9Fm7li3Ndv
	50YJGXsbzaluSkp9u8Rdrl9glrH4tiXP3x23lLPc9XFdlugXI4U1x346rGacJpC11qr2Xt23
	hXPfnM25w7d29iOJXRmvagVSV53ql8rbddvms8UVftbAPQz2ETGXN37/X13eunK205TS485K
	LMUZiYZazEXFiQChxJnnVAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsXC5WfdrLvisX+aweT/chZz1q9hszg89ySr
	xdsJ2xktLu+aw2Zxb81/VgdWj52z7rJ7bPo0id3jxIzfLB6LX3xg8vi8SS6ANYrLJiU1J7Ms
	tUjfLoEr48zZNqaCReYVU9c9Ym5g/KnVxcjJISFgIjHx63o2EJtFQFXid9NSZhCbTUBd4saN
	n2C2iICOxISn7exdjBwczAJZEtNbo0DCwgJJEj33NjCB2LwCFhI7FqxjBLGFBBIkNnzrYYaI
	C0qcnPmEBcRmFtCSuPHvJRPEGGmJ5f84QMKcAqYS124sBisRFVCWOLDtONMERt5ZSLpnIeme
	hdC9gJF5FaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmD4Lav9M3EH45fL7ocYBTgYlXh4D+j7
	pwmxJpYVV+YeYpTgYFYS4Y1e6ZsmxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1
	OzW1ILUIJsvEwSnVwLiu57xNe9zCmbnd9/5VZT/9omHDu7BptpKNpL3zv3UBj1uktm479v+T
	RHTRZkfN/M3sy2tuTupuNtTWf7+Ay7XkSOivS3XNzdtD7gU/27xc+3PQ9eBLM/y5AmdbsJpt
	u/VVjqtp5uPf/7bPadn5L6je+uzVuZlr3tZ8UePxXRApOGH604X6Rh+UWIozEg21mIuKEwER
	keXAOwIAAA==
X-CFilter-Loop: Reflected

On Thu, May 23, 2024 at 01:53:37PM +0100, Karim Manaouil wrote:
> On Thu, May 23, 2024 at 02:14:06PM +0900, Byungchul Park wrote:
> > I suffered from kswapd stopped in the following scenario:
> > 
> >    CONFIG_NUMA_BALANCING enabled
> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >    numa node0 (500GB local DRAM, 128 CPUs)
> >    numa node1 (100GB CXL memory, no CPUs)
> >    swap off
> > 
> >    1) Run any workload using a lot of anon pages e.g. mmap(200GB).
> >    2) Keep adding another workload using a lot of anon pages.
> >    3) The DRAM becomes filled with only anon pages through promotion.
> >    4) Demotion barely works due to severe memory pressure.
> >    5) kswapd for node0 stops because of the unreclaimable anon pages.
> 
> It's not very clear to me, but if I understand correctly, if you have

I don't have free memory on CXL.

> free memory on CXL, kswapd0 should not stop as long as demotion is

kswapd0 stops because demotion barely works.

> successfully migrating the pages from DRAM to CXL and returns that as
> nr_reclaimed in shrink_folio_list()? 
> 
> If that's the case, kswapd0 is making progress and shouldn't give up.

It's not the case.

> If CXL memory is also filled and migration fails, then it doesn't make
> sense to me to wake up kswapd0 as it obvisoly won't help with anything,

It's true *only* when it won't help with anything.

However, kswapd should work again once the system got back to normal
e.g. by terminating the anon hoggers.  I addressed this issue.

> because, you guessed it, you have no memory in the first place!!
> 
> >    6) Manually kill the memory hoggers.

This is the point.

	Byungchul

> >    7) kswapd is still stopped even though the system got back to normal.
> > 
> > From now on, the system should run without reclaim service in background
> > served by kswapd until direct reclaim will do for that.  Even worse,
> > tiering mechanism is no longer able to work because kswapd has stopped
> > that the mechanism relies on.
> > 
> > However, after 6), the DRAM will be filled with pages that might or
> > might not be reclaimable, that depends on how those are going to be used.
> > Since those are potentially reclaimable anyway, it's worth hopefully
> > trying reclaim by allowing kswapd to work again if needed.
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/mmzone.h |  4 ++++
> >  mm/page_alloc.c        | 12 ++++++++++++
> >  mm/vmscan.c            | 21 ++++++++++++++++-----
> >  3 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index c11b7cde81ef..7c0ba90ea7b4 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1331,6 +1331,10 @@ typedef struct pglist_data {
> >  	enum zone_type kswapd_highest_zoneidx;
> >  
> >  	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
> > +	int nr_may_reclaimable;		/* Number of pages that have been
> > +					   allocated since considered the
> > +					   node is hopeless due to too many
> > +					   kswapd_failures. */
> >  
> >  #ifdef CONFIG_COMPACTION
> >  	int kcompactd_max_order;
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 14d39f34d336..1dd2daede014 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1538,8 +1538,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >  static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
> >  							unsigned int alloc_flags)
> >  {
> > +	pg_data_t *pgdat = page_pgdat(page);
> > +
> >  	post_alloc_hook(page, order, gfp_flags);
> >  
> > +	/*
> > +	 * New pages might or might not be reclaimable depending on how
> > +	 * these pages are going to be used.  However, since these are
> > +	 * potentially reclaimable, it's worth hopefully trying reclaim
> > +	 * by allowing kswapd to work again even if there have been too
> > +	 * many ->kswapd_failures, if ->nr_may_reclaimable is big enough.
> > +	 */
> > +	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
> > +		pgdat->nr_may_reclaimable += 1 << order;
> > +
> >  	if (order && (gfp_flags & __GFP_COMP))
> >  		prep_compound_page(page, order);
> >  
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 3ef654addd44..5b39090c4ef1 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4943,6 +4943,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
> >  done:
> >  	/* kswapd should never fail */
> >  	pgdat->kswapd_failures = 0;
> > +	pgdat->nr_may_reclaimable = 0;
> >  }
> >  
> >  /******************************************************************************
> > @@ -5991,9 +5992,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * sleep. On reclaim progress, reset the failure counter. A
> >  	 * successful direct reclaim run will revive a dormant kswapd.
> >  	 */
> > -	if (reclaimable)
> > +	if (reclaimable) {
> >  		pgdat->kswapd_failures = 0;
> > -	else if (sc->cache_trim_mode)
> > +		pgdat->nr_may_reclaimable = 0;
> > +	} else if (sc->cache_trim_mode)
> >  		sc->cache_trim_mode_failed = 1;
> >  }
> >  
> > @@ -6636,6 +6638,11 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
> >  	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
> >  }
> >  
> > +static bool may_recaimable(pg_data_t *pgdat, int order)
> > +{
> > +	return pgdat->nr_may_reclaimable >= 1 << order;
> > +}
> > +
> >  /*
> >   * Prepare kswapd for sleeping. This verifies that there are no processes
> >   * waiting in throttle_direct_reclaim() and that watermarks have been met.
> > @@ -6662,7 +6669,8 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
> >  		wake_up_all(&pgdat->pfmemalloc_wait);
> >  
> >  	/* Hopeless node, leave it to direct reclaim */
> > -	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
> > +	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
> > +	    !may_recaimable(pgdat, order))
> >  		return true;
> >  
> >  	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
> > @@ -6940,8 +6948,10 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >  		goto restart;
> >  	}
> >  
> > -	if (!sc.nr_reclaimed)
> > +	if (!sc.nr_reclaimed) {
> >  		pgdat->kswapd_failures++;
> > +		pgdat->nr_may_reclaimable = 0;
> > +	}
> >  
> >  out:
> >  	clear_reclaim_active(pgdat, highest_zoneidx);
> > @@ -7204,7 +7214,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
> >  		return;
> >  
> >  	/* Hopeless node, leave it to direct reclaim if possible */
> > -	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
> > +	if ((pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
> > +	     !may_recaimable(pgdat, order)) ||
> >  	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
> >  	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
> >  		/*
> > -- 
> > 2.17.1
> > 
> > 

