Return-Path: <linux-kernel+bounces-201665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A28FC17D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453F4B250F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A954AEE7;
	Wed,  5 Jun 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgGhPdTg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C940F503
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553043; cv=none; b=ZTttftI59N8VVRXJgpP7hwUbE23Yow/crEwDDrihCD2zX8qhvH+HTXyasMbU1LEIXxsvTbXOwoMdzc8C7ICrkqZdNbzOEBYvQyphIslpJO81DU2K3lGXfvNFfevUIXMvonIG5JHdM6jdE+r3L3BFwJFzeAj/b2mrK41+ihywGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553043; c=relaxed/simple;
	bh=6mehi3CoPBEEy+f+M0kPGZBBjoi2oPFm16L/sOvB6ZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sAzflmoZCMOFen4CJEyeNhHiQ5BDlg1U9j1Di2dpFbv9O+xiElIdr8/+PhoqeWLww3Bkwsan2hR2yIgkFo41obtw4FRhhf2fcBF3/v3TtJ0yqfNnBp5T6+2Kzyx8L+/mFqiayrk1b4dX0SmnXhw70yBPK6pa9uKLnffFS1VzpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgGhPdTg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717553041; x=1749089041;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6mehi3CoPBEEy+f+M0kPGZBBjoi2oPFm16L/sOvB6ZI=;
  b=GgGhPdTgoBW6KbCknGXAhVLvFM6gE1vqSaj+199Su5vYryvOcua7uMEU
   k6T3V8bdtc9q5fFxXnD52znhU/GtgHNmWHGPuPhRz5bOgg+pwzhETSu6l
   iwS1YmPDkp+AS4H2UHd7ZBVXf1RPXAP1/zg3ILUYuBoYjlhFegU/jsP4e
   MKLzqFgNIZpDyAJekeEVHN4BRDxSj8AoofZkC7Ir/39dk33AoWdP4K4Io
   KpZirPc4xQJE2wa7S338EfexQWh4pdolxPeiXOaJQwngIIH9KMJSDqMT6
   bhO1Xe/IU2GTsZuXIYr9IpJ2mxC7H7MgViOGQ40TsCes9TGAX9i+WlJ/C
   Q==;
X-CSE-ConnectionGUID: TrhITBZuTAaVqHAk3XuKlw==
X-CSE-MsgGUID: /Kwr8X9BRoK+YVdY68qayQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14269847"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="14269847"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:04:01 -0700
X-CSE-ConnectionGUID: KXtnQgulR5WKLLd9IyILJw==
X-CSE-MsgGUID: 2TVHDZuTTQ2VE9BfPFjcLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37440309"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:03:59 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,  <hannes@cmpxchg.org>,
  <iamjoonsoo.kim@lge.com>,  <rientjes@google.com>
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
In-Reply-To: <20240605015021.GB75311@system.software.com> (Byungchul Park's
	message of "Wed, 5 Jun 2024 10:50:21 +0900")
References: <20240604072323.10886-1-byungchul@sk.com>
	<87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240604084533.GA68919@system.software.com>
	<8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240605015021.GB75311@system.software.com>
Date: Wed, 05 Jun 2024 10:02:07 +0800
Message-ID: <87tti8b10g.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>> 
>> > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
>> >> Byungchul Park <byungchul@sk.com> writes:
>> >> 
>> >> > Changes from v1:
>> >> > 	1. Don't allow to resume kswapd if the system is under memory
>> >> > 	   pressure that might affect direct reclaim by any chance, like
>> >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
>> >> >
>> >> > --->8---
>> >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
>> >> > From: Byungchul Park <byungchul@sk.com>
>> >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
>> >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
>> >> >
>> >> > A system should run with kswapd running in background when under memory
>> >> > pressure, such as when the available memory level is below the low water
>> >> > mark and there are reclaimable folios.
>> >> >
>> >> > However, the current code let the system run with kswapd stopped if
>> >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
>> >> > until direct reclaim will do for that, even if there are reclaimable
>> >> > folios that can be reclaimed by kswapd.  This case was observed in the
>> >> > following scenario:
>> >> >
>> >> >    CONFIG_NUMA_BALANCING enabled
>> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>> >> >    numa node0 (500GB local DRAM, 128 CPUs)
>> >> >    numa node1 (100GB CXL memory, no CPUs)
>> >> >    swap off
>> >> >
>> >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
>> >> >    2) Continue adding the same workload to the system.
>> >> >    3) The anon pages are placed in node0 by promotion/demotion.
>> >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
>> >> >    5) Kill the memory hoggers to restore the system.
>> >> >
>> >> > After restoring the system at 5), the system starts to run without
>> >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
>> >> > the mechanism relies on kswapd for demotion.
>> >> 
>> >> We have run into the situation that kswapd is kept in failure state for
>> >> long in a multiple tiers system.  I think that your solution is too
>> >
>> > My solution just gives a chance for kswapd to work again even if
>> > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
>> > reclaimable folios.  That's it.
>> >
>> >> limited, because OOM killing may not happen, while the access pattern of
>> >
>> > I don't get this.  OOM will happen as is, through direct reclaim.
>> 
>> A system that fails to reclaim via kswapd may succeed to reclaim via
>> direct reclaim, because more CPUs are used to scanning the page tables.
>
> Honestly, I don't think so with this description.
>
> The fact that the system hit MAX_RECLAIM_RETRIES means the system is
> currently hopeless unless reclaiming folios in a stronger way by *direct
> reclaim*.  The solution for this situation should not be about letting
> more CPUs particiated in reclaiming, again, *at least in this situation*.
>
> What you described here is true only in a normal state where the more
> CPUs work on reclaiming, the more reclaimable folios can be reclaimed.
> kswapd can be a helper *only* when there are kswapd-reclaimable folios.

Sometimes, we cannot reclaim just because we doesn't scan fast enough so
the Accessed-bit is set again during scanning.  With more CPUs, we can
scan faster, so make some progress.  But, yes, this only cover one
situation, there are other situations too.

--
Best Regards,
Huang, Ying

> 	Byungchul
>
>> In a system with NUMA balancing based page promotion and page demotion
>> enabled, page promotion will wake up kswapd, but kswapd may fail in some
>> situations.  But page promotion will no trigger direct reclaim or OOM.
>> 
>> >> the workloads may change.  We have a preliminary and simple solution for
>> >> this as follows,
>> >> 
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
>> >
>> > Whether tiering is involved or not, the same problem can arise if
>> > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
>> 
>> Your description is about tiering too.  Can you describe a situation
>> without tiering?
>> 
>> --
>> Best Regards,
>> Huang, Ying
>> 
>> > 	Byungchul
>> >
>> >> where we will try to wake up kswapd to check every 10 seconds if kswapd
>> >> is in failure state.  This is another possible solution.
>> >> 
>> >> > However, the node0 has pages newly allocated after 5), that might or
>> >> > might not be reclaimable.  Since those are potentially reclaimable, it's
>> >> > worth hopefully trying reclaim by allowing kswapd to work again.
>> >> >
>> >> 
>> >> [snip]
>> >> 
>> >> --
>> >> Best Regards,
>> >> Huang, Ying

