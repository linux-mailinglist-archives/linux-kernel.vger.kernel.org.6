Return-Path: <linux-kernel+bounces-205500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018448FFCD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7BB1C211DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843571527A0;
	Fri,  7 Jun 2024 07:12:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AA14285
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744369; cv=none; b=cpjD10leZf62twAP2KuqbjM4xN5mNLoFa51cuB7wbqsqKccnwryq3N4WVYnSHf5QK5msxICgGtCmXlQ4y2P/RrSdb6Y+VHEw/vs4sY+pqdJulBKmDLRMQr/5d4lLJyOLZ+/v+txb3NU6uhy82zDMCPbR/ohbvsJWHF6JdrtzlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744369; c=relaxed/simple;
	bh=O8ZyCSqSbXgB/fxih83bxYqRFlxQw0ZGVrdkrBclupQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGHOcVVeFUmWA9LRaS0u633q6uCASJOLO71AzdVqG0A3oIzQ9vgEpp8MfvyP1QjlHzzTgEU0teNfr536ujmoPoZrO1gFsbFHIVbl6ractVyMR3Dm8wv0ZkGFWO5r4DyKFAkzIklfRTQyxYHkTHDdwCYONt71vMfhVkhxshwA7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ed-6662b2e1bdcd
Date: Fri, 7 Jun 2024 16:12:28 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240607071228.GA76933@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240605015021.GB75311@system.software.com>
 <87tti8b10g.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240605021902.GC75311@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605021902.GC75311@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoe6jTUlpBhsmMFrMWb+GzWL1Jl+L
	ld3NbBaXd81hs7i35j+rRduSjUwWJ2dNZnFg9zj85j2zx4JNpR6L97xk8tj0aRK7R9fbK0we
	J2b8ZvH4vEkugD2KyyYlNSezLLVI3y6BK2Pn41WMBT8MKlb3rGZsYDyh2sXIySEhYCLx+8wx
	ti5GDjB7wg5jkDCLgIrEtfNf2EFsNgF1iRs3fjKD2CICGhKfFi4HinNxMAusZZQ4crWFFaRX
	WCBV4vj2AJAaXgELiTn/l7OA1AgJ3GOS2PtjMiNEQlDi5MwnLCA2s4CWxI1/L5lAepkFpCWW
	/+MACXMKWEpsP7QfrFxUQFniwLbjTCBzJAT2sEms6zzKAnGzpMTBFTdYJjAKzEIydhaSsbMQ
	xi5gZF7FKJSZV5abmJljopdRmZdZoZecn7uJERjqy2r/RO9g/HQh+BCjAAejEg/vhU2JaUKs
	iWXFlbmHGCU4mJVEeP2K49OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0t
	SC2CyTJxcEo1MM6yVZhwm8d8wtyKg3XlC2YwOa16yr7qxUnJeJtday5aL1L21GNbWffmVr5Q
	z2HF7J/erxim3YifZrfzfsKV2w+z+MuNflwJmB+Y6cfRO/O2s6XNFIv7cw/fzvapt299V3zT
	QOk2X9u/lavD/009w3H5gPM365Y/hz9kz/DU1mV63VCzQTCgIEyJpTgj0VCLuag4EQDgNlSm
	cQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXC5WfdrPtwU1Kawd2/ehZz1q9hs1i9yddi
	ZXczm8XhuSdZLS7vmsNmcW/Nf1aLtiUbmSxOzprM4sDhcfjNe2aPBZtKPRbvecnksenTJHaP
	rrdXmDxOzPjN4rH4xQcmj8+b5AI4orhsUlJzMstSi/TtErgydj5exVjww6Bidc9qxgbGE6pd
	jBwcEgImEhN2GHcxcnKwCKhIXDv/hR3EZhNQl7hx4ycziC0ioCHxaeFyoDgXB7PAWkaJI1db
	WEF6hQVSJY5vDwCp4RWwkJjzfzkLSI2QwD0mib0/JjNCJAQlTs58wgJiMwtoSdz495IJpJdZ
	QFpi+T8OkDCngKXE9kP7wcpFBZQlDmw7zjSBkXcWku5ZSLpnIXQvYGRexSiSmVeWm5iZY6pX
	nJ1RmZdZoZecn7uJERi4y2r/TNzB+OWy+yFGAQ5GJR7eGzsT04RYE8uKK3MPMUpwMCuJ8PoV
	x6cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MJY/VAyJ
	spyh/rONuf/y88beih4N44Crtq5dIaaH58gHLU87euSWIOt88TLv1wuub32h8msB4y2Zs9Ur
	2a2/zFOvLkq79lHrVzZ7oVtJ8Yo30p9kwp6u21SSVXjP2ffKkumrLTZ8eObv81P797OiLXaM
	HH2GH4uSF7Iwd+geig048ofVokntphJLcUaioRZzUXEiAFe+ZiZYAgAA
X-CFilter-Loop: Reflected

On Wed, Jun 05, 2024 at 11:19:02AM +0900, Byungchul Park wrote:
> On Wed, Jun 05, 2024 at 10:02:07AM +0800, Huang, Ying wrote:
> > Byungchul Park <byungchul@sk.com> writes:
> > 
> > > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> > >> Byungchul Park <byungchul@sk.com> writes:
> > >> 
> > >> > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> > >> >> Byungchul Park <byungchul@sk.com> writes:
> > >> >> 
> > >> >> > Changes from v1:
> > >> >> > 	1. Don't allow to resume kswapd if the system is under memory
> > >> >> > 	   pressure that might affect direct reclaim by any chance, like
> > >> >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> > >> >> >
> > >> >> > --->8---
> > >> >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> > >> >> > From: Byungchul Park <byungchul@sk.com>
> > >> >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> > >> >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> > >> >> >
> > >> >> > A system should run with kswapd running in background when under memory
> > >> >> > pressure, such as when the available memory level is below the low water
> > >> >> > mark and there are reclaimable folios.
> > >> >> >
> > >> >> > However, the current code let the system run with kswapd stopped if
> > >> >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> > >> >> > until direct reclaim will do for that, even if there are reclaimable
> > >> >> > folios that can be reclaimed by kswapd.  This case was observed in the
> > >> >> > following scenario:
> > >> >> >
> > >> >> >    CONFIG_NUMA_BALANCING enabled
> > >> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > >> >> >    numa node0 (500GB local DRAM, 128 CPUs)
> > >> >> >    numa node1 (100GB CXL memory, no CPUs)
> > >> >> >    swap off
> > >> >> >
> > >> >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> > >> >> >    2) Continue adding the same workload to the system.
> > >> >> >    3) The anon pages are placed in node0 by promotion/demotion.
> > >> >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> > >> >> >    5) Kill the memory hoggers to restore the system.
> > >> >> >
> > >> >> > After restoring the system at 5), the system starts to run without
> > >> >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> > >> >> > the mechanism relies on kswapd for demotion.
> > >> >> 
> > >> >> We have run into the situation that kswapd is kept in failure state for
> > >> >> long in a multiple tiers system.  I think that your solution is too
> > >> >
> > >> > My solution just gives a chance for kswapd to work again even if
> > >> > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> > >> > reclaimable folios.  That's it.
> > >> >
> > >> >> limited, because OOM killing may not happen, while the access pattern of
> > >> >
> > >> > I don't get this.  OOM will happen as is, through direct reclaim.
> > >> 
> > >> A system that fails to reclaim via kswapd may succeed to reclaim via
> > >> direct reclaim, because more CPUs are used to scanning the page tables.
> > >
> > > Honestly, I don't think so with this description.
> > >
> > > The fact that the system hit MAX_RECLAIM_RETRIES means the system is
> > > currently hopeless unless reclaiming folios in a stronger way by *direct
> > > reclaim*.  The solution for this situation should not be about letting
> > > more CPUs particiated in reclaiming, again, *at least in this situation*.
> > >
> > > What you described here is true only in a normal state where the more
> > > CPUs work on reclaiming, the more reclaimable folios can be reclaimed.
> > > kswapd can be a helper *only* when there are kswapd-reclaimable folios.
> > 
> > Sometimes, we cannot reclaim just because we doesn't scan fast enough so
> > the Accessed-bit is set again during scanning.  With more CPUs, we can
> > scan faster, so make some progress.  But, yes, this only cover one
> > situation, there are other situations too.
> 
> What I mean is *the issue we try to solve* is not the situation that
> can be solved by letting more CPUs participate in reclaiming.

Again, in the situation where kswapd has failed more than
MAX_RECLAIM_RETRIES, say, holeless, I don't think it makes sense to wake
up kswapd every 10 seconds.  It'd be more sensible to wake up kwapd only
if there are *at least potentially* reclaimable folios.

As Ying said, there's no way to precisely track if reclaimable, but it's
worth trying when the possibility becomes positive and looks more
reasonable.  Thoughts?

	Byungchul

> 	Byungchul
> 
> > --
> > Best Regards,
> > Huang, Ying
> > 
> > > 	Byungchul
> > >
> > >> In a system with NUMA balancing based page promotion and page demotion
> > >> enabled, page promotion will wake up kswapd, but kswapd may fail in some
> > >> situations.  But page promotion will no trigger direct reclaim or OOM.
> > >> 
> > >> >> the workloads may change.  We have a preliminary and simple solution for
> > >> >> this as follows,
> > >> >> 
> > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> > >> >
> > >> > Whether tiering is involved or not, the same problem can arise if
> > >> > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> > >> 
> > >> Your description is about tiering too.  Can you describe a situation
> > >> without tiering?
> > >> 
> > >> --
> > >> Best Regards,
> > >> Huang, Ying
> > >> 
> > >> > 	Byungchul
> > >> >
> > >> >> where we will try to wake up kswapd to check every 10 seconds if kswapd
> > >> >> is in failure state.  This is another possible solution.
> > >> >> 
> > >> >> > However, the node0 has pages newly allocated after 5), that might or
> > >> >> > might not be reclaimable.  Since those are potentially reclaimable, it's
> > >> >> > worth hopefully trying reclaim by allowing kswapd to work again.
> > >> >> >
> > >> >> 
> > >> >> [snip]
> > >> >> 
> > >> >> --
> > >> >> Best Regards,
> > >> >> Huang, Ying

