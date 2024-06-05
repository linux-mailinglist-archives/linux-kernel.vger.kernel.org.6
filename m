Return-Path: <linux-kernel+bounces-201656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974EC8FC16D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1031F22BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CE5380F;
	Wed,  5 Jun 2024 01:50:34 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786963D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552234; cv=none; b=hm6Ii4Sro8XYwYNMEkenDksPu6/7xDK3hgxGHJQRWwhGnd+XyY1m1Jb/pnbW0kQ8xlf/NjzfUJIjxmW6MriNazKi8mZY/jHG5o9Mhj8Nwdbl9GF3X/Ncmy+UmLoaL8OXW8nVa+0y2fY5blBCRGtIetcm1r6WNUbgqPe/x83vaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552234; c=relaxed/simple;
	bh=+/WW9mo1VUWRrsh667APns4YfcJSzJ17CdWhqAAm26w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he1Hro2CbAit5HiPnio5rcl0SV83dFFR3rsI8JV0ccVaiyuamSsyMevfa49eyUxV+2ltLZFxupBK6Odeh1jkmNtDLu7g5r4XbMIVjj0SXrMaE7laJ/0MxozQ16lNFhsTlNIWXSmX7CFfkqJXj0Z3PxTbCdPTKhd42al5qBYEP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-33-665fc46277e5
Date: Wed, 5 Jun 2024 10:50:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240605015021.GB75311@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoW7Skfg0g0Wr5SzmrF/DZrF6k6/F
	yu5mNovLu+awWdxb85/Vom3JRiaLk7Mmsziwexx+857ZY8GmUo/Fe14yeWz6NIndo+vtFSaP
	EzN+s3h83iQXwB7FZZOSmpNZllqkb5fAlfHpZjdzQa9KRfuKC8wNjEtkuhg5OSQETCQunX7F
	2sXIAWZ/nOgEEmYRUJG4+GMRE4jNJqAucePGT2YQW0RAQ+LTwuXsXYxcHMwCaxkljlxtAesV
	FkiVOL49AKSGV8BC4u6fy6wgNUICZxglehvWM0EkBCVOznzCAmIzC2hJ3Pj3kgmkl1lAWmL5
	Pw6QMKeAnUTvovuMILaogLLEgW3HmUDmSAgcYJP42fmSBeJmSYmDK26wTGAUmIVk7CwkY2ch
	jF3AyLyKUSgzryw3MTPHRC+jMi+zQi85P3cTIzDUl9X+id7B+OlC8CFGAQ5GJR7eHb/i0oRY
	E8uKK3MPMUpwMCuJ8PoVx6cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpa
	kFoEk2Xi4JRqYLSf+HVKXWucWu72S4axYu/eROhN/jqJ+Xrm0UMGE41Ts7TPRL9SXcKtccRf
	bQ+rObP19n8bZkre0/Zeve9OddmNu+5X+jTe9RoGcnKffFG7Tm2ZZtCxNWWvHL/5KRes87m0
	auuU/dGF31mlXnHlbm5Zq6t0aK5CyvXHtVuPWF00OXn00esrzVlKLMUZiYZazEXFiQBD4Uny
	cQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXC5WfdrJt0JD7N4EiHsMWc9WvYLFZv8rVY
	2d3MZnF47klWi8u75rBZ3Fvzn9WibclGJouTsyazOHB4HH7zntljwaZSj8V7XjJ5bPo0id2j
	6+0VJo8TM36zeCx+8YHJ4/MmuQCOKC6blNSczLLUIn27BK6MTze7mQt6VSraV1xgbmBcItPF
	yMEhIWAi8XGiUxcjJweLgIrExR+LmEBsNgF1iRs3fjKD2CICGhKfFi5n72Lk4mAWWMsoceRq
	CytIr7BAqsTx7QEgNbwCFhJ3/1xmBakREjjDKNHbsJ4JIiEocXLmExYQm1lAS+LGv5dMIL3M
	AtISy/9xgIQ5BewkehfdZwSxRQWUJQ5sO840gZF3FpLuWUi6ZyF0L2BkXsUokplXlpuYmWOq
	V5ydUZmXWaGXnJ+7iREYuMtq/0zcwfjlsvshRgEORiUe3h2/4tKEWBPLiitzDzFKcDArifD6
	FcenCfGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTDe8QvY
	4TPl75OMkwuPCDYU2P2eLCR0eDKv6ssjn+Or3cOitbWWBP0pn/zp/o5H7G5TbcIPn7YvcSv1
	TGxbvbhS7MIDkR/Kn7emaUxbaCvnU1s6/XjZF+PLB1R4HHQfzzvWvEOVX3h+5VuZPP/VqxJu
	sSnqOmkYsot3bjsWE9Vi91n58BO2fgUlluKMREMt5qLiRABdMdU8WAIAAA==
X-CFilter-Loop: Reflected

On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > Changes from v1:
> >> > 	1. Don't allow to resume kswapd if the system is under memory
> >> > 	   pressure that might affect direct reclaim by any chance, like
> >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> >> >
> >> > --->8---
> >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> >> > From: Byungchul Park <byungchul@sk.com>
> >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> >> >
> >> > A system should run with kswapd running in background when under memory
> >> > pressure, such as when the available memory level is below the low water
> >> > mark and there are reclaimable folios.
> >> >
> >> > However, the current code let the system run with kswapd stopped if
> >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> >> > until direct reclaim will do for that, even if there are reclaimable
> >> > folios that can be reclaimed by kswapd.  This case was observed in the
> >> > following scenario:
> >> >
> >> >    CONFIG_NUMA_BALANCING enabled
> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> >    numa node0 (500GB local DRAM, 128 CPUs)
> >> >    numa node1 (100GB CXL memory, no CPUs)
> >> >    swap off
> >> >
> >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> >> >    2) Continue adding the same workload to the system.
> >> >    3) The anon pages are placed in node0 by promotion/demotion.
> >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> >> >    5) Kill the memory hoggers to restore the system.
> >> >
> >> > After restoring the system at 5), the system starts to run without
> >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> >> > the mechanism relies on kswapd for demotion.
> >> 
> >> We have run into the situation that kswapd is kept in failure state for
> >> long in a multiple tiers system.  I think that your solution is too
> >
> > My solution just gives a chance for kswapd to work again even if
> > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> > reclaimable folios.  That's it.
> >
> >> limited, because OOM killing may not happen, while the access pattern of
> >
> > I don't get this.  OOM will happen as is, through direct reclaim.
> 
> A system that fails to reclaim via kswapd may succeed to reclaim via
> direct reclaim, because more CPUs are used to scanning the page tables.

Honestly, I don't think so with this description.

The fact that the system hit MAX_RECLAIM_RETRIES means the system is
currently hopeless unless reclaiming folios in a stronger way by *direct
reclaim*.  The solution for this situation should not be about letting
more CPUs particiated in reclaiming, again, *at least in this situation*.

What you described here is true only in a normal state where the more
CPUs work on reclaiming, the more reclaimable folios can be reclaimed.
kswapd can be a helper *only* when there are kswapd-reclaimable folios.

	Byungchul

> In a system with NUMA balancing based page promotion and page demotion
> enabled, page promotion will wake up kswapd, but kswapd may fail in some
> situations.  But page promotion will no trigger direct reclaim or OOM.
> 
> >> the workloads may change.  We have a preliminary and simple solution for
> >> this as follows,
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> >
> > Whether tiering is involved or not, the same problem can arise if
> > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> 
> Your description is about tiering too.  Can you describe a situation
> without tiering?
> 
> --
> Best Regards,
> Huang, Ying
> 
> > 	Byungchul
> >
> >> where we will try to wake up kswapd to check every 10 seconds if kswapd
> >> is in failure state.  This is another possible solution.
> >> 
> >> > However, the node0 has pages newly allocated after 5), that might or
> >> > might not be reclaimable.  Since those are potentially reclaimable, it's
> >> > worth hopefully trying reclaim by allowing kswapd to work again.
> >> >
> >> 
> >> [snip]
> >> 
> >> --
> >> Best Regards,
> >> Huang, Ying

