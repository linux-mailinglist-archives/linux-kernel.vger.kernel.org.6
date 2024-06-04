Return-Path: <linux-kernel+bounces-200419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1028FAFD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E34C283FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BA71448C9;
	Tue,  4 Jun 2024 10:25:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C113247D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496737; cv=none; b=CWYUsUBuVVRBAlVkuKZ58jbVnNpEu5JS9vfOxk5JdYOGx2cQLsuBPodiEIZWAgywanKJxX/grl2NDz2SZnCOc26CV1OkcXEssN09uDlM12ebQBVTcBNcca7VAzOaaGUsPDizV68MLOTOlQpUKIE0zvewRqm6KndtDVfQI+/B2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496737; c=relaxed/simple;
	bh=us+i8+a8998l/9tnRz+Xqt+AtWsDO6VVkjXKVbngQ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Koq/EE5A8w7FC9xu9R5eNVqmaHfXFx0EsYrrJHYb/X6qRKPgyjQIYqnMFtK7EPLblUIpQar5QlMsPrdChjFsyNrGZ3ficT/HeUL+t6sB2LCikpq7geoTDNmhxPbBRNegJAUmYQiduL9cKd3+AL3qH0IzkphtQpQ4+oTiSyqVtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-54-665eeb91dc3d
Date: Tue, 4 Jun 2024 19:25:16 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240604102516.GB28034@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604091221.GA28034@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604091221.GA28034@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoe6k13FpBr2tTBZz1q9hs1i9yddi
	ZXczm8XlXXPYLO6t+c9q0bZkI5PFyVmTWRzYPQ6/ec/ssWBTqcfiPS+ZPDZ9msTu0fX2CpPH
	iRm/WTw+b5ILYI/isklJzcksSy3St0vgymie/5694Ll6xf3lz9kbGG/IdTFyckgImEhMOH2e
	pYuRA8y+dFIFJMwioCIxp3cLO4jNJqAucePGT2YQW0RAQ+LTwuVAcS4OZoG1jBJHrrawgvQK
	C6RKHN8eAFLDK2Ah0fi9A6xGSOA3o8TBS+fYIBKCEidnPmEBsZkFtCRu/HvJBNLLLCAtsfwf
	B0iYU8BS4s3Cb2B7RQWUJQ5sO84EMkdCYA+bxLG97xghbpaUOLjiBssERoFZSMbOQjJ2FsLY
	BYzMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECQ31Z7Z/oHYyfLgQfYhTgYFTi4TVYFJsmxJpY
	VlyZe4hRgoNZSYS3ry46TYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILU
	IpgsEwenVAPjHMsIpegZWtHVUdtV9yxieHP5ydLyE567XnBx6HctfF7QKevZxrDiO1tT/GI7
	xViTKzutIwqK5ugvuhn4auOlLs8gn5/fz09a8/uuzR6zHWemnNw8eVPJ4qgW3fL3WZuf/nDc
	slZ8KcOFImOpZQKH3h610dGN9Du4eeXk+wwGxXcj++xCvLVfKrEUZyQaajEXFScCAOPnF/9x
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXC5WfdrDvxdVyaQfdRfYs569ewWaze5Gux
	sruZzeLw3JOsFpd3zWGzuLfmP6tF25KNTBYnZ01mceDwOPzmPbPHgk2lHov3vGTy2PRpErtH
	19srTB4nZvxm8Vj84gOTx+dNcgEcUVw2Kak5mWWpRfp2CVwZzfPfsxc8V6+4v/w5ewPjDbku
	Rg4OCQETiUsnVboYOTlYBFQk5vRuYQex2QTUJW7c+MkMYosIaEh8WrgcKM7FwSywllHiyNUW
	VpBeYYFUiePbA0BqeAUsJBq/d4DVCAn8ZpQ4eOkcG0RCUOLkzCcsIDazgJbEjX8vmUB6mQWk
	JZb/4wAJcwpYSrxZ+A1sr6iAssSBbceZJjDyzkLSPQtJ9yyE7gWMzKsYRTLzynITM3NM9Yqz
	MyrzMiv0kvNzNzECA3dZ7Z+JOxi/XHY/xCjAwajEw2uxMjZNiDWxrLgy9xCjBAezkghvX110
	mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAPjqp2ZbG/D
	FzDarxI5Mpc/VTGtSvWevZfvpear79PuV5lNqWfa8GfuF2WPsE1BU7PPaUs8ERGtFttt19d9
	xbZw/pb7XO++qV+/Oevplx9nli92nmzHm83LumNG5OL6ZYUn7pQ8dJn20m7VneMJAcHlvw0e
	5TLvv/zyg+3/DXtnJM74GlJaUVo3XYmlOCPRUIu5qDgRAM3vjUFYAgAA
X-CFilter-Loop: Reflected

On Tue, Jun 04, 2024 at 06:12:22PM +0900, Byungchul Park wrote:
> On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> > Byungchul Park <byungchul@sk.com> writes:
> > 
> > > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> > >> Byungchul Park <byungchul@sk.com> writes:
> > >> 
> > >> > Changes from v1:
> > >> > 	1. Don't allow to resume kswapd if the system is under memory
> > >> > 	   pressure that might affect direct reclaim by any chance, like
> > >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> > >> >
> > >> > --->8---
> > >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> > >> > From: Byungchul Park <byungchul@sk.com>
> > >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> > >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> > >> >
> > >> > A system should run with kswapd running in background when under memory
> > >> > pressure, such as when the available memory level is below the low water
> > >> > mark and there are reclaimable folios.
> > >> >
> > >> > However, the current code let the system run with kswapd stopped if
> > >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> > >> > until direct reclaim will do for that, even if there are reclaimable
> > >> > folios that can be reclaimed by kswapd.  This case was observed in the
> > >> > following scenario:
> > >> >
> > >> >    CONFIG_NUMA_BALANCING enabled
> > >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > >> >    numa node0 (500GB local DRAM, 128 CPUs)
> > >> >    numa node1 (100GB CXL memory, no CPUs)
> > >> >    swap off
> > >> >
> > >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> > >> >    2) Continue adding the same workload to the system.
> > >> >    3) The anon pages are placed in node0 by promotion/demotion.
> > >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> > >> >    5) Kill the memory hoggers to restore the system.
> > >> >
> > >> > After restoring the system at 5), the system starts to run without
> > >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> > >> > the mechanism relies on kswapd for demotion.
> > >> 
> > >> We have run into the situation that kswapd is kept in failure state for
> > >> long in a multiple tiers system.  I think that your solution is too
> > >
> > > My solution just gives a chance for kswapd to work again even if
> > > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> > > reclaimable folios.  That's it.
> > >
> > >> limited, because OOM killing may not happen, while the access pattern of
> > >
> > > I don't get this.  OOM will happen as is, through direct reclaim.
> > 
> > A system that fails to reclaim via kswapd may succeed to reclaim via
> > direct reclaim, because more CPUs are used to scanning the page tables.
> > 
> > In a system with NUMA balancing based page promotion and page demotion
> > enabled, page promotion will wake up kswapd, but kswapd may fail in some
> > situations.  But page promotion will no trigger direct reclaim or OOM.
> > 
> > >> the workloads may change.  We have a preliminary and simple solution for
> > >> this as follows,
> > >> 
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> > >
> > > Whether tiering is involved or not, the same problem can arise if
> > > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> > 
> > Your description is about tiering too.  Can you describe a situation
> 
> I mentioned "tiering" while I described how to reproduce because I ran
> into the situation while testing with tiering system but I don't think
> it's the necessary condition.
> 
> Let me ask you back, why the logic to stop kswapd was considered in the
> first place?  That's because the problem was already observed anyway

To be clear..

The problem, kswapd_failures >= MAX_RECLAIM_RETRIES, can happen whether
tiering is involved not not.  Once kswapd stops, the system should run
without kswapd even after recovered e.g. by killing the hoggers.  *Even
worse*, tiering mechanism doesn't work in this situation.

I hope what I meant has been delivered.

	Byungchul

> whether tiering is involved or not.  The same problem will arise once
> kswapd stops.
> 
> 	Byungchul
> 
> > without tiering?
> > 
> > --
> > Best Regards,
> > Huang, Ying
> > 
> > > 	Byungchul
> > >
> > >> where we will try to wake up kswapd to check every 10 seconds if kswapd
> > >> is in failure state.  This is another possible solution.
> > >> 
> > >> > However, the node0 has pages newly allocated after 5), that might or
> > >> > might not be reclaimable.  Since those are potentially reclaimable, it's
> > >> > worth hopefully trying reclaim by allowing kswapd to work again.
> > >> >
> > >> 
> > >> [snip]
> > >> 
> > >> --
> > >> Best Regards,
> > >> Huang, Ying

