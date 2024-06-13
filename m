Return-Path: <linux-kernel+bounces-212644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DDE906441
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836EDB244CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123E137901;
	Thu, 13 Jun 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNc60jfc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BD137767
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260830; cv=none; b=dK08DWCJX1dSQfT7WKzV2RXQNKj/C1P8g5wFB6xHbsJtmO8FjaM1wgp5GBuHLR2ORWfMcM5x7pwcUiacZHK+GjTo6SbXSHqNGVAj7sRQK/kfCTi3c4dxNa6iMC61xX5njAGAb4CeIsUdbPY6hPz8RQ3OKZ8zJTDu6nto0JgeMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260830; c=relaxed/simple;
	bh=dP+DR0PUHdZ/8JwSZ+6YcBk+BaYdsLktBS1wULRESuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyTLYuuWBbqZvXV9Wh3DxAs+HqSulsWVtnsebIBJi6shEhPcQnJA62Y5CJOmryN9USpK8piArk9KczlZhoC9S7D6CJhgdVcIEKJPFJnScvaYXBlgUdvknHWCdwZMSpT1hwjRLxWUn6j17j6hZkiuPHx1WTnxeakjbYZZtDm/dT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNc60jfc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260829; x=1749796829;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dP+DR0PUHdZ/8JwSZ+6YcBk+BaYdsLktBS1wULRESuM=;
  b=FNc60jfcQ0fN8mwdYskAAtiwomkgoIDsGkHCrt34ywEBc/kZMNGPCqrd
   IRT5LRq1It50F1Fhv+aFbFwnHeUpNhM01f8jUocakU98CiGKaW3Q/yKSu
   gDI40w+rLQKhMZUGrKRkpNgV2C3PCLrzKjsxwCDDyqJrneqdF9t7JlYb4
   qIc2snz04si7tD+cnT32mx37ACtj3kOZiur02s64UWCjoi3hVNVN0kWiI
   8WPfixSjZ3vYQppp36IuoHxW3U44quVNttzBZutYA4hYZtQ518YhAmGGl
   H7iHxh542fth/iVz+xCyYr+Y8yz7F+33VddzHYUybH4jSyXGwot+zexAx
   w==;
X-CSE-ConnectionGUID: gJfqCLAiStiDXm44zUUTkA==
X-CSE-MsgGUID: Kyagfr5oQaGY9s4yBNrLhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="37577014"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="37577014"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:40:28 -0700
X-CSE-ConnectionGUID: qFVb2rRCQEW1W1DphgaLyQ==
X-CSE-MsgGUID: A13FUX8sQCaTBFBXC76xlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40147172"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:40:26 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,  <hannes@cmpxchg.org>,
  <iamjoonsoo.kim@lge.com>,  <rientjes@google.com>
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
In-Reply-To: <20240613012738.GA2327@system.software.com> (Byungchul Park's
	message of "Thu, 13 Jun 2024 10:27:38 +0900")
References: <20240604072323.10886-1-byungchul@sk.com>
	<87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240604084533.GA68919@system.software.com>
	<8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240605015021.GB75311@system.software.com>
	<87tti8b10g.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240605021902.GC75311@system.software.com>
	<20240607071228.GA76933@system.software.com>
	<20240613012738.GA2327@system.software.com>
Date: Thu, 13 Jun 2024 14:38:35 +0800
Message-ID: <87ed9173f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Fri, Jun 07, 2024 at 04:12:28PM +0900, Byungchul Park wrote:
>> On Wed, Jun 05, 2024 at 11:19:02AM +0900, Byungchul Park wrote:
>> > On Wed, Jun 05, 2024 at 10:02:07AM +0800, Huang, Ying wrote:
>> > > Byungchul Park <byungchul@sk.com> writes:
>> > > 
>> > > > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
>> > > >> Byungchul Park <byungchul@sk.com> writes:
>> > > >> 
>> > > >> > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
>> > > >> >> Byungchul Park <byungchul@sk.com> writes:
>> > > >> >> 
>> > > >> >> > Changes from v1:
>> > > >> >> > 	1. Don't allow to resume kswapd if the system is under memory
>> > > >> >> > 	   pressure that might affect direct reclaim by any chance, like
>> > > >> >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
>> > > >> >> >
>> > > >> >> > --->8---
>> > > >> >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
>> > > >> >> > From: Byungchul Park <byungchul@sk.com>
>> > > >> >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
>> > > >> >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
>> > > >> >> >
>> > > >> >> > A system should run with kswapd running in background when under memory
>> > > >> >> > pressure, such as when the available memory level is below the low water
>> > > >> >> > mark and there are reclaimable folios.
>> > > >> >> >
>> > > >> >> > However, the current code let the system run with kswapd stopped if
>> > > >> >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
>> > > >> >> > until direct reclaim will do for that, even if there are reclaimable
>> > > >> >> > folios that can be reclaimed by kswapd.  This case was observed in the
>> > > >> >> > following scenario:
>> > > >> >> >
>> > > >> >> >    CONFIG_NUMA_BALANCING enabled
>> > > >> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>> > > >> >> >    numa node0 (500GB local DRAM, 128 CPUs)
>> > > >> >> >    numa node1 (100GB CXL memory, no CPUs)
>> > > >> >> >    swap off
>> > > >> >> >
>> > > >> >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
>> > > >> >> >    2) Continue adding the same workload to the system.
>> > > >> >> >    3) The anon pages are placed in node0 by promotion/demotion.
>> > > >> >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
>> > > >> >> >    5) Kill the memory hoggers to restore the system.
>> > > >> >> >
>> > > >> >> > After restoring the system at 5), the system starts to run without
>> > > >> >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
>> > > >> >> > the mechanism relies on kswapd for demotion.
>> > > >> >> 
>> > > >> >> We have run into the situation that kswapd is kept in failure state for
>> > > >> >> long in a multiple tiers system.  I think that your solution is too
>> > > >> >
>> > > >> > My solution just gives a chance for kswapd to work again even if
>> > > >> > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
>> > > >> > reclaimable folios.  That's it.
>> > > >> >
>> > > >> >> limited, because OOM killing may not happen, while the access pattern of
>> > > >> >
>> > > >> > I don't get this.  OOM will happen as is, through direct reclaim.
>> > > >> 
>> > > >> A system that fails to reclaim via kswapd may succeed to reclaim via
>> > > >> direct reclaim, because more CPUs are used to scanning the page tables.
>> > > >
>> > > > Honestly, I don't think so with this description.
>> > > >
>> > > > The fact that the system hit MAX_RECLAIM_RETRIES means the system is
>> > > > currently hopeless unless reclaiming folios in a stronger way by *direct
>> > > > reclaim*.  The solution for this situation should not be about letting
>> > > > more CPUs particiated in reclaiming, again, *at least in this situation*.
>> > > >
>> > > > What you described here is true only in a normal state where the more
>> > > > CPUs work on reclaiming, the more reclaimable folios can be reclaimed.
>> > > > kswapd can be a helper *only* when there are kswapd-reclaimable folios.
>> > > 
>> > > Sometimes, we cannot reclaim just because we doesn't scan fast enough so
>> > > the Accessed-bit is set again during scanning.  With more CPUs, we can
>> > > scan faster, so make some progress.  But, yes, this only cover one
>> > > situation, there are other situations too.
>> > 
>> > What I mean is *the issue we try to solve* is not the situation that
>> > can be solved by letting more CPUs participate in reclaiming.
>> 
>> Again, in the situation where kswapd has failed more than
>> MAX_RECLAIM_RETRIES, say, holeless, I don't think it makes sense to wake
>> up kswapd every 10 seconds.  It'd be more sensible to wake up kwapd only
>> if there are *at least potentially* reclaimable folios.
>
> 1) numa balancing tiering on
>
> No doubt the patch should work for it since numa balancing tiering
> doesn't work at all once kswapd stops.  We are already applying and
> using this patch in tests for tiering.  It works perfect.

If my understanding of the code were correct, it doesn't work if there
are not many pages allocated after kswapd stops.  For example, if
some processes use many fast memory become idle.

> 2) numa balancing tiering off
>
> kswapd will be resumed even without this patch if free memory hits min
> wmark.  However, do we have to wait for direct reclaim to work for it?
> Even though we can proactively prevent direct reclaim using kswapd?

Please prove it with data instead of reasoning.  You patch adds some
overhead in hot page allocation path.  If the number of CPU is large,
cache ping-pong may be triggered because shared variable
(pgdat->nr_may_reclaimable) is accessed.

--
Best Regards,
Huang, Ying

> 	Byungchul
>
>> As Ying said, there's no way to precisely track if reclaimable, but it's
>> worth trying when the possibility becomes positive and looks more
>> reasonable.  Thoughts?
>> 
>> 	Byungchul
>> 
>> > 	Byungchul
>> > 
>> > > --
>> > > Best Regards,
>> > > Huang, Ying
>> > > 
>> > > > 	Byungchul
>> > > >
>> > > >> In a system with NUMA balancing based page promotion and page demotion
>> > > >> enabled, page promotion will wake up kswapd, but kswapd may fail in some
>> > > >> situations.  But page promotion will no trigger direct reclaim or OOM.
>> > > >> 
>> > > >> >> the workloads may change.  We have a preliminary and simple solution for
>> > > >> >> this as follows,
>> > > >> >> 
>> > > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
>> > > >> >
>> > > >> > Whether tiering is involved or not, the same problem can arise if
>> > > >> > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
>> > > >> 
>> > > >> Your description is about tiering too.  Can you describe a situation
>> > > >> without tiering?
>> > > >> 
>> > > >> --
>> > > >> Best Regards,
>> > > >> Huang, Ying
>> > > >> 
>> > > >> > 	Byungchul
>> > > >> >
>> > > >> >> where we will try to wake up kswapd to check every 10 seconds if kswapd
>> > > >> >> is in failure state.  This is another possible solution.
>> > > >> >> 
>> > > >> >> > However, the node0 has pages newly allocated after 5), that might or
>> > > >> >> > might not be reclaimable.  Since those are potentially reclaimable, it's
>> > > >> >> > worth hopefully trying reclaim by allowing kswapd to work again.
>> > > >> >> >
>> > > >> >> 
>> > > >> >> [snip]
>> > > >> >> 
>> > > >> >> --
>> > > >> >> Best Regards,
>> > > >> >> Huang, Ying

