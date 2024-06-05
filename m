Return-Path: <linux-kernel+bounces-201674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9088FC1A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D971F22036
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19A5338D;
	Wed,  5 Jun 2024 02:19:18 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043941EB36
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553957; cv=none; b=ug2te8t3OMb+LFahsQk5o4fRFznPzbIaPRY/rdO2fBuhTY/Be4xLRMQLQIE8r5NKTd+BngIcFKbke0SI3CpB8l8LUvSt8J8rMbUGE5M8autAJd8mXnZlWhHXAoR13e0V0xnCY8jiJW6kT7pPi3RMrEFgGQ4qr9JeVi3P4u1Hh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553957; c=relaxed/simple;
	bh=Zxkhm0YeSTgwvm9hgTADfpfC5tsKNvUgfM1BTuRDc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWlKRBNKM+5Bu6ZJpAXmTACmGjqKpkMaiHnl1GhZtH8FOQK6nA7LKfIbN+pkM6H9Zq37wfRGw+ReNm8AmUrCrZFkc6+B2rKYSTF1HZVTBI8nv43u+0RuGIUlX7J4VNceTaZggxB1QDOF2WDUA/gVy5YLxuMzxyB+wUf+4dbNGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-b9-665fcb1bc2af
Date: Wed, 5 Jun 2024 11:19:02 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240605021902.GC75311@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240605015021.GB75311@system.software.com>
 <87tti8b10g.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tti8b10g.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnka7M6fg0g0+7WC3mrF/DZrF6k6/F
	yu5mNovLu+awWdxb85/Vom3JRiaLk7Mmsziwexx+857ZY8GmUo/Fe14yeWz6NIndo+vtFSaP
	EzN+s3h83iQXwB7FZZOSmpNZllqkb5fAlbGiaQtLQYd2xb6Pp1gaGDcpdjFycEgImEhcns3d
	xcgJZl66u5sdxGYRUJGY+/I8C4jNJqAucePGT2YQW0RAQ+LTwuVANVwczAJrGSWOXG1hBZkj
	LJAqcXx7AEgNr4CFxOlbkxlBaoQE1jNJ/Oh5yQ6REJQ4OfMJ2FBmAS2JG/9eMoH0MgtISyz/
	xwES5hSwk3g96RcTiC0qoCxxYNtxJpA5EgIH2CSuXLzAAnGopMTBFTdYJjAKzEIydhaSsbMQ
	xi5gZF7FKJSZV5abmJljopdRmZdZoZecn7uJERjqy2r/RO9g/HQh+BCjAAejEg/vjl9xaUKs
	iWXFlbmHGCU4mJVEeP2K49OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0t
	SC2CyTJxcEo1MLZ8W/RmRsXcRV/+eX9Y/P6rYFvfP4V3p0TuWcVc11Pb96jqm8UFt0LvY4Gp
	YZflbx86J6/3/scv5WUPGe7d/JidcXHN68e1nQKze88pV7xwZVeT57T0rdinFMTwvLlMqE1D
	a+3aB5duXFwjb/9cMuNmr6nNerMfvdt0jn5cuOcX5wzf+rhpOU+UWIozEg21mIuKEwFUkbkV
	cQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXC5WfdrCt9Oj7N4NltU4s569ewWaze5Gux
	sruZzeLw3JOsFpd3zWGzuLfmP6tF25KNTBYnZ01mceDwOPzmPbPHgk2lHov3vGTy2PRpErtH
	19srTB4nZvxm8Vj84gOTx+dNcgEcUVw2Kak5mWWpRfp2CVwZK5q2sBR0aFfs+3iKpYFxk2IX
	IyeHhICJxKW7u9lBbBYBFYm5L8+zgNhsAuoSN278ZAaxRQQ0JD4tXA5Uw8XBLLCWUeLI1RbW
	LkYODmGBVInj2wNAangFLCRO35rMCFIjJLCeSeJHz0t2iISgxMmZT8CGMgtoSdz495IJpJdZ
	QFpi+T8OkDCngJ3E60m/mEBsUQFliQPbjjNNYOSdhaR7FpLuWQjdCxiZVzGKZOaV5SZm5pjq
	FWdnVOZlVugl5+duYgSG7rLaPxN3MH657H6IUYCDUYmHd8evuDQh1sSy4srcQ4wSHMxKIrx+
	xfFpQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYz7ll+4
	Z8p9K/L73U+pjK2aNadbNq3y8o/YO4Vrth3j2jIm9vqXIslZLrZlXsXm1xrjd8p8ervk7LxF
	PVPPstpIL0s8+G6d500WvgPWIRFVvWdX57V7nJ9k3fuObaMvo2HvEc1JCWp2pyoen9d56bZE
	bjvLsWcqjX5feTwWbjP7qLO2YlPmbDslluKMREMt5qLiRADujAtHWQIAAA==
X-CFilter-Loop: Reflected

On Wed, Jun 05, 2024 at 10:02:07AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> >> >> Byungchul Park <byungchul@sk.com> writes:
> >> >> 
> >> >> > Changes from v1:
> >> >> > 	1. Don't allow to resume kswapd if the system is under memory
> >> >> > 	   pressure that might affect direct reclaim by any chance, like
> >> >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> >> >> >
> >> >> > --->8---
> >> >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> >> >> > From: Byungchul Park <byungchul@sk.com>
> >> >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> >> >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> >> >> >
> >> >> > A system should run with kswapd running in background when under memory
> >> >> > pressure, such as when the available memory level is below the low water
> >> >> > mark and there are reclaimable folios.
> >> >> >
> >> >> > However, the current code let the system run with kswapd stopped if
> >> >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> >> >> > until direct reclaim will do for that, even if there are reclaimable
> >> >> > folios that can be reclaimed by kswapd.  This case was observed in the
> >> >> > following scenario:
> >> >> >
> >> >> >    CONFIG_NUMA_BALANCING enabled
> >> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> >> >    numa node0 (500GB local DRAM, 128 CPUs)
> >> >> >    numa node1 (100GB CXL memory, no CPUs)
> >> >> >    swap off
> >> >> >
> >> >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> >> >> >    2) Continue adding the same workload to the system.
> >> >> >    3) The anon pages are placed in node0 by promotion/demotion.
> >> >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> >> >> >    5) Kill the memory hoggers to restore the system.
> >> >> >
> >> >> > After restoring the system at 5), the system starts to run without
> >> >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> >> >> > the mechanism relies on kswapd for demotion.
> >> >> 
> >> >> We have run into the situation that kswapd is kept in failure state for
> >> >> long in a multiple tiers system.  I think that your solution is too
> >> >
> >> > My solution just gives a chance for kswapd to work again even if
> >> > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> >> > reclaimable folios.  That's it.
> >> >
> >> >> limited, because OOM killing may not happen, while the access pattern of
> >> >
> >> > I don't get this.  OOM will happen as is, through direct reclaim.
> >> 
> >> A system that fails to reclaim via kswapd may succeed to reclaim via
> >> direct reclaim, because more CPUs are used to scanning the page tables.
> >
> > Honestly, I don't think so with this description.
> >
> > The fact that the system hit MAX_RECLAIM_RETRIES means the system is
> > currently hopeless unless reclaiming folios in a stronger way by *direct
> > reclaim*.  The solution for this situation should not be about letting
> > more CPUs particiated in reclaiming, again, *at least in this situation*.
> >
> > What you described here is true only in a normal state where the more
> > CPUs work on reclaiming, the more reclaimable folios can be reclaimed.
> > kswapd can be a helper *only* when there are kswapd-reclaimable folios.
> 
> Sometimes, we cannot reclaim just because we doesn't scan fast enough so
> the Accessed-bit is set again during scanning.  With more CPUs, we can
> scan faster, so make some progress.  But, yes, this only cover one
> situation, there are other situations too.

What I mean is *the issue we try to solve* is not the situation that
can be solved by letting more CPUs participate in reclaiming.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > 	Byungchul
> >
> >> In a system with NUMA balancing based page promotion and page demotion
> >> enabled, page promotion will wake up kswapd, but kswapd may fail in some
> >> situations.  But page promotion will no trigger direct reclaim or OOM.
> >> 
> >> >> the workloads may change.  We have a preliminary and simple solution for
> >> >> this as follows,
> >> >> 
> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> >> >
> >> > Whether tiering is involved or not, the same problem can arise if
> >> > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> 
> >> Your description is about tiering too.  Can you describe a situation
> >> without tiering?
> >> 
> >> --
> >> Best Regards,
> >> Huang, Ying
> >> 
> >> > 	Byungchul
> >> >
> >> >> where we will try to wake up kswapd to check every 10 seconds if kswapd
> >> >> is in failure state.  This is another possible solution.
> >> >> 
> >> >> > However, the node0 has pages newly allocated after 5), that might or
> >> >> > might not be reclaimable.  Since those are potentially reclaimable, it's
> >> >> > worth hopefully trying reclaim by allowing kswapd to work again.
> >> >> >
> >> >> 
> >> >> [snip]
> >> >> 
> >> >> --
> >> >> Best Regards,
> >> >> Huang, Ying

