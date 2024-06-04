Return-Path: <linux-kernel+bounces-200266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5598FADD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C0D281FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99286142E7E;
	Tue,  4 Jun 2024 08:45:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2201411F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490748; cv=none; b=uf751IFQEqNrd4pULg5DI2Y6Tn4ew57R1UzFHX2zLjYRj2AAyJkhER78MySLu7PoknEWuQvLkvcfwC/WYrzdNye2Uzd1i7DM0mGyIQv3t0/JTTg0WTcWccrPPlQYUDZhDcRRXNwsN/N7sAARkGcE/gh+ARL6aoRNSrGP6LRPuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490748; c=relaxed/simple;
	bh=OQIffwSMMzPTLMkbkLwlXwwOwo3Bx6H8Zm5F5P0mvfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7Zt8jm1r4dllnBhqvJVoIwV8bGEs6x3hYG9E/ZHU0HwPclfb5HsTAxG/DXtCXlIbIaDoTPMUqSJn25/DFCKHZueI6rGWgO8m5RZ9JYyIHcmCfXzQJmZln2J0JE+nxNOjV33OF3Uy5NcHoSgYdRddrc00jFCZCWOiMBpyWjRXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-9a-665ed43276cc
Date: Tue, 4 Jun 2024 17:45:33 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240604084533.GA68919@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnoa7Rlbg0g/ZzOhZz1q9hs1i9yddi
	ZXczm8XlXXPYLO6t+c9q0bZkI5PFyVmTWRzYPQ6/ec/ssWBTqcfiPS+ZPDZ9msTu0fX2CpPH
	iRm/WTw+b5ILYI/isklJzcksSy3St0vgytixSr/gq0TF/kV3mRsYzwt3MXJySAiYSGzffIKt
	i5EDzF7RYAQSZhFQkVh05CoriM0moC5x48ZPZhBbREBD4tPC5exdjFwczAJrGSWOXG1hBekV
	FkiVOL49AKSGV8BC4t2xj2wgtpBApsSDnXuZIeKCEidnPmEBsZkFtCRu/HvJBNLKLCAtsfwf
	B4jJKWAnseOqFUiFqICyxIFtx5lANkkI7GGTaN01jR3iYkmJgytusExgFJiFZOosJFNnIUxd
	wMi8ilEoM68sNzEzx0QvozIvs0IvOT93EyMwyJfV/onewfjpQvAhRgEORiUeXoNFsWlCrIll
	xZW5hxglOJiVRHj76qLThHhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgt
	gskycXBKNTDapPX/Ngqcc/vqn09y+ic049a/9NJIvN9i8iL3+B1T7Tls9ZN+BTTJbJ2gxT/f
	qt1ueU55CnOnzOa1s1OOrvux9IVT8uZXijGp0/obnKPPPu6u/b5PgIcx5a+hvNL3o+u3L+1U
	4zii9PIZ40bDJyG9hwvlNlcem/Bdee7NxZ+6+aSdW8/UP1uuxFKckWioxVxUnAgAsAtk0m4C
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsXC5WfdrGt0JS7NoPuPqMWc9WvYLFZv8rVY
	2d3MZnF47klWi8u75rBZ3Fvzn9WibclGJouTsyazOHB4HH7zntljwaZSj8V7XjJ5bPo0id2j
	6+0VJo8TM36zeCx+8YHJ4/MmuQCOKC6blNSczLLUIn27BK6MHav0C75KVOxfdJe5gfG8cBcj
	B4eEgInEigajLkZODhYBFYlFR66ygthsAuoSN278ZAaxRQQ0JD4tXM7excjFwSywllHiyNUW
	VpBeYYFUiePbA0BqeAUsJN4d+8gGYgsJZEo82LmXGSIuKHFy5hMWEJtZQEvixr+XTCCtzALS
	Esv/cYCYnAJ2EjuuWoFUiAooSxzYdpxpAiPvLCTNs5A0z0JoXsDIvIpRJDOvLDcxM8dUrzg7
	ozIvs0IvOT93EyMwZJfV/pm4g/HLZfdDjAIcjEo8vBYrY9OEWBPLiitzDzFKcDArifD21UWn
	CfGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTD2vS5dvWlx
	DFtc/h/Xr4v1nzjOXPM39h8bk8le7bcT24+sSJhaemtfkve3wF9u77dUFlzo8X/xJ+bfzIse
	j39tbWc8nPb39eaw+/HHF0+3PhHZ5LGy8uyiig5mX4dG95/VHtImYU13fh1I8/5ov/SBWtDt
	BEalJ29Z0iOWL9rEEff2zJpb05ZMVmIpzkg01GIuKk4EAL/tOjJVAgAA
X-CFilter-Loop: Reflected

On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Changes from v1:
> > 	1. Don't allow to resume kswapd if the system is under memory
> > 	   pressure that might affect direct reclaim by any chance, like
> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> >
> > --->8---
> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> >
> > A system should run with kswapd running in background when under memory
> > pressure, such as when the available memory level is below the low water
> > mark and there are reclaimable folios.
> >
> > However, the current code let the system run with kswapd stopped if
> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> > until direct reclaim will do for that, even if there are reclaimable
> > folios that can be reclaimed by kswapd.  This case was observed in the
> > following scenario:
> >
> >    CONFIG_NUMA_BALANCING enabled
> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >    numa node0 (500GB local DRAM, 128 CPUs)
> >    numa node1 (100GB CXL memory, no CPUs)
> >    swap off
> >
> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> >    2) Continue adding the same workload to the system.
> >    3) The anon pages are placed in node0 by promotion/demotion.
> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> >    5) Kill the memory hoggers to restore the system.
> >
> > After restoring the system at 5), the system starts to run without
> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> > the mechanism relies on kswapd for demotion.
> 
> We have run into the situation that kswapd is kept in failure state for
> long in a multiple tiers system.  I think that your solution is too

My solution just gives a chance for kswapd to work again even if
kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
reclaimable folios.  That's it.

> limited, because OOM killing may not happen, while the access pattern of

I don't get this.  OOM will happen as is, through direct reclaim.

> the workloads may change.  We have a preliminary and simple solution for
> this as follows,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866

Whether tiering is involved or not, the same problem can arise if
kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.

	Byungchul

> where we will try to wake up kswapd to check every 10 seconds if kswapd
> is in failure state.  This is another possible solution.
> 
> > However, the node0 has pages newly allocated after 5), that might or
> > might not be reclaimable.  Since those are potentially reclaimable, it's
> > worth hopefully trying reclaim by allowing kswapd to work again.
> >
> 
> [snip]
> 
> --
> Best Regards,
> Huang, Ying

