Return-Path: <linux-kernel+bounces-201582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9548FC062
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68170B20ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385B184E;
	Wed,  5 Jun 2024 00:21:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A565C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546889; cv=none; b=patg1bjJYHwz/PQESfK224eDKOAQ3gt7hvR0mB8XeQs1/reBDMCveRGA7JxNYPZG8nuP/t9Lpb/ZACNxN18UdXSW2qM3Zs290EIW7JyQn0BJRwq96qNBpV0TGzFyFNHlzNpcKNqrzU9LeGOi3ayqtHCLOUOmlRD7xnzNeimNwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546889; c=relaxed/simple;
	bh=xdfWrF1qujjwhxwbb6igPTngTXPnCU+wUDMmn5J4rlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdgBhMbaHSjVro9A05kedQt8+VjE37GKBGGjr3xODRmGpUeZyA6YKsl/dT7svRF9T7ap2YJUTZhKEitHi9MIWygXyKGmqnb4MjEqLjNqNLYOFz5yPVWprHgIkaUe3laYiGuwxnKZ3uIScy6WqPo5zRTYTyIbnvhbxezPAk7TLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-85-665faf7fe9ab
Date: Wed, 5 Jun 2024 09:21:14 +0900
From: Byungchul Park <byungchul@sk.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, iamjoonsoo.kim@lge.com,
	rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240605002114.GA23651@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604091221.GA28034@system.software.com>
 <20240604102516.GB28034@system.software.com>
 <20240604122927.GA1992@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604122927.GA1992@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnoW79+vg0g8dNlhZz1q9hs1i9yddi
	ZXczm8XlXXPYLO6t+c9q0bZkI5PFyVmTWRzYPQ6/ec/ssWBTqcfiPS+ZPDZ9msTu0fX2CpPH
	iRm/WTw+b5ILYI/isklJzcksSy3St0vgyjh85BVLwXbtilMbNjA1MPYodjFyckgImEic/feJ
	BcZ+d/ghE4jNIqAi8fruYTCbTUBd4saNn8wgtoiAhsSlRR1sXYxcHMwCBxkl3hy8y97FyMEh
	LJAqcXx7AEgNr4CFxOW3T1hBaoQELjBJzPl7kBUiIShxcuYTsGXMAloSN/69ZALpZRaQllj+
	jwMkzClgIHFq9y+wvaICyhIHth1nApkjIXCATeLb3XnsEIdKShxccYNlAqPALCRjZyEZOwth
	7AJG5lWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgcG+rPZP9A7GTxeCDzEKcDAq8fDu+BWXJsSa
	WFZcmXuIUYKDWUmE1684Pk2INyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC
	1CKYLBMHp1QDY6PNjVDTgu/y6e1XTz5t2LjP/r5fw579R167LJP4LvFfmrt1flOUmZeg7M3S
	Ag6tk7fZ3DdsWW8WvHDDvDlH17ZyXTmoWxjHXBEfcWxfw8/90lNWz/33KHbninWeT///6Nef
	e5nv7K/GGM6Ga4zXv3V8SxK9/Wb5H46+4psPW3JUNaw+v+N3WKTEUpyRaKjFXFScCADDet72
	cgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXC5WfdrFu/Pj7N4OV2Q4s569ewWaze5Gux
	sruZzeLw3JOsFpd3zWGzuLfmP6tF25KNTBYnZ01mceDwOPzmPbPHgk2lHov3vGTy2PRpErtH
	19srTB4nZvxm8Vj84gOTx+dNcgEcUVw2Kak5mWWpRfp2CVwZh4+8YinYrl1xasMGpgbGHsUu
	Rk4OCQETiXeHHzKB2CwCKhKv7x4Gs9kE1CVu3PjJDGKLCGhIXFrUwdbFyMXBLHCQUeLNwbvs
	XYwcHMICqRLHtweA1PAKWEhcfvuEFaRGSOACk8ScvwdZIRKCEidnPmEBsZkFtCRu/HvJBNLL
	LCAtsfwfB0iYU8BA4tTuX2B7RQWUJQ5sO840gZF3FpLuWUi6ZyF0L2BkXsUokplXlpuYmWOq
	V5ydUZmXWaGXnJ+7iREYustq/0zcwfjlsvshRgEORiUe3h2/4tKEWBPLiitzDzFKcDArifD6
	FcenCfGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTC6sbG/
	PHtPWjky/ZJIuPn9nW8tzu99p3l0fVX0TxPtLcI/Fuww4zXR3Pvif1DIsT/rl+894bWsSfje
	tZ911hrfNQonNH/4cay+82FUkcKcqwssGNd8mlduqHfrN/ueBclpz+0nKJwyT9yQtO1n3lKn
	XRvf3+ePPc2Zkn39xK+Lf79O6/y9jF/ujxJLcUaioRZzUXEiACWHbTNZAgAA
X-CFilter-Loop: Reflected

On Tue, Jun 04, 2024 at 08:29:27AM -0400, Johannes Weiner wrote:
> On Tue, Jun 04, 2024 at 07:25:16PM +0900, Byungchul Park wrote:
> > On Tue, Jun 04, 2024 at 06:12:22PM +0900, Byungchul Park wrote:
> > > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> > > > Byungchul Park <byungchul@sk.com> writes:
> > > > 
> > > > > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> > > > >> Byungchul Park <byungchul@sk.com> writes:
> > > > >> 
> > > > >> > Changes from v1:
> > > > >> > 	1. Don't allow to resume kswapd if the system is under memory
> > > > >> > 	   pressure that might affect direct reclaim by any chance, like
> > > > >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> > > > >> >
> > > > >> > --->8---
> > > > >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> > > > >> > From: Byungchul Park <byungchul@sk.com>
> > > > >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> > > > >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> > > > >> >
> > > > >> > A system should run with kswapd running in background when under memory
> > > > >> > pressure, such as when the available memory level is below the low water
> > > > >> > mark and there are reclaimable folios.
> > > > >> >
> > > > >> > However, the current code let the system run with kswapd stopped if
> > > > >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> > > > >> > until direct reclaim will do for that, even if there are reclaimable
> > > > >> > folios that can be reclaimed by kswapd.  This case was observed in the
> > > > >> > following scenario:
> > > > >> >
> > > > >> >    CONFIG_NUMA_BALANCING enabled
> > > > >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > > > >> >    numa node0 (500GB local DRAM, 128 CPUs)
> > > > >> >    numa node1 (100GB CXL memory, no CPUs)
> > > > >> >    swap off
> > > > >> >
> > > > >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> > > > >> >    2) Continue adding the same workload to the system.
> > > > >> >    3) The anon pages are placed in node0 by promotion/demotion.
> > > > >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> > > > >> >    5) Kill the memory hoggers to restore the system.
> > > > >> >
> > > > >> > After restoring the system at 5), the system starts to run without
> > > > >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> > > > >> > the mechanism relies on kswapd for demotion.
> > > > >> 
> > > > >> We have run into the situation that kswapd is kept in failure state for
> > > > >> long in a multiple tiers system.  I think that your solution is too
> > > > >
> > > > > My solution just gives a chance for kswapd to work again even if
> > > > > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> > > > > reclaimable folios.  That's it.
> > > > >
> > > > >> limited, because OOM killing may not happen, while the access pattern of
> > > > >
> > > > > I don't get this.  OOM will happen as is, through direct reclaim.
> > > > 
> > > > A system that fails to reclaim via kswapd may succeed to reclaim via
> > > > direct reclaim, because more CPUs are used to scanning the page tables.
> > > > 
> > > > In a system with NUMA balancing based page promotion and page demotion
> > > > enabled, page promotion will wake up kswapd, but kswapd may fail in some
> > > > situations.  But page promotion will no trigger direct reclaim or OOM.
> > > > 
> > > > >> the workloads may change.  We have a preliminary and simple solution for
> > > > >> this as follows,
> > > > >> 
> > > > >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> > > > >
> > > > > Whether tiering is involved or not, the same problem can arise if
> > > > > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> > > > 
> > > > Your description is about tiering too.  Can you describe a situation
> > > 
> > > I mentioned "tiering" while I described how to reproduce because I ran
> > > into the situation while testing with tiering system but I don't think
> > > it's the necessary condition.
> > > 
> > > Let me ask you back, why the logic to stop kswapd was considered in the
> > > first place?  That's because the problem was already observed anyway
> > 
> > To be clear..
> > 
> > The problem, kswapd_failures >= MAX_RECLAIM_RETRIES, can happen whether
> > tiering is involved not not.  Once kswapd stops, the system should run
> > without kswapd even after recovered e.g. by killing the hoggers.  *Even
> > worse*, tiering mechanism doesn't work in this situation.
> 
> But like Ying said, in other situations it's direct reclaim that kicks
> in and clears the flag.

I already described it in the commit message.

> The failure-sleep and direct reclaim triggered recovery have been in

Sure.  It's better than nothing.

> place since 2017. Both parties who observed an issue with it recently
> did so in tiering scenarios. IMO a tiering-specific solution makes the
> most sense.

So..  Is the follow situation in a non-tiering system okay?  Really?

   A system runs with kswapd disabled unless hitting min water mark,
   even if there might be something that kswapd can work on.

I don't undertand why it's okay.  Could you explain more?  Then why do
we use kswapd in background?

	Byungchul

