Return-Path: <linux-kernel+bounces-201671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E178FC195
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E2A1F24B85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8A2AE75;
	Wed,  5 Jun 2024 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAIu2qyX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375ED266
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553797; cv=none; b=OA1905mEpHyvDrpDdBQJmQmqJ/+errGLEx/XI7vhsTnSGHN2HNA/sejph2vZQUc36Heb5DC5CWJVmd+giE4DF9CY1bf3NytuGADFJcqx9/m97FNPdtNKQpsh5RiQOzXfkFchI6g9gXp1R7zttN735U2bYZj7RXN3YGr8jyz9dgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553797; c=relaxed/simple;
	bh=iTshI2+OpSiVkEKiYrGh8IzDkfFT++7Je5S7wqZu3nE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ve+Y8shyxpmOfgOxluJweEOkme+R1W6GgVCJb9X99qYUEOWipJYFCaPgwGgrkErQdJpdz4sabZn94wxDempD+APMZXrt5n9XAbgXUXEWSz5pxetm1feNo1Ah22ztlFWEWuky8r26RPj8FQXG2ZmnNxr7kb4jT3xLC1dory1h4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAIu2qyX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717553795; x=1749089795;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=iTshI2+OpSiVkEKiYrGh8IzDkfFT++7Je5S7wqZu3nE=;
  b=lAIu2qyXhbj354i/h8jA5vj8XN/MG7GHS4XgJZcUGdONQjCG2ppSJAWR
   qJ+gDX7UYmxEVblIVPhp9aBpkMPWSx7Ekts6wS8EUAkAnM+TAt+Il/9GQ
   7ynlXbB0670eL2cfv7qzezZI06k9sRymMg6AqVQuv+i3Z6MHT1M+1BrKa
   gaOXs9bUD2UsqU3EvwDmO45ahkd8LvBF/9ctd5W6uTqWrKA2gIuoylQQr
   XJ+bGbQHKpXJ5KCR70c9UJffKrCE3ZZZdZHekDb7GNWvwIEpnik7PMwPL
   o/UsVHzoc4U7/pGmOsy5cJHw5npKTUIXaSKCycthUdWYGT9KY8PCRhmz4
   w==;
X-CSE-ConnectionGUID: SKDvVB2HSwyG/31PjSf4KA==
X-CSE-MsgGUID: gc61V0ToQEC6HyPb62JaNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13887110"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13887110"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:16:19 -0700
X-CSE-ConnectionGUID: OyG7tzCeSteeJKEouJNjAA==
X-CSE-MsgGUID: Fs7wXbBOSx2P3DTutfPCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37996371"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:16:16 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,  <akpm@linux-foundation.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kernel_team@skhynix.com>,  <iamjoonsoo.kim@lge.com>,
  <rientjes@google.com>
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
In-Reply-To: <20240605012412.GA75311@system.software.com> (Byungchul Park's
	message of "Wed, 5 Jun 2024 10:24:12 +0900")
References: <20240604072323.10886-1-byungchul@sk.com>
	<87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240604084533.GA68919@system.software.com>
	<8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240604091221.GA28034@system.software.com>
	<20240604102516.GB28034@system.software.com>
	<20240604122927.GA1992@cmpxchg.org>
	<20240605002114.GA23651@system.software.com>
	<87y17kb3xm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240605012412.GA75311@system.software.com>
Date: Wed, 05 Jun 2024 10:14:24 +0800
Message-ID: <87plswb0fz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Wed, Jun 05, 2024 at 08:59:01AM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>> 
>> > On Tue, Jun 04, 2024 at 08:29:27AM -0400, Johannes Weiner wrote:
>> >> On Tue, Jun 04, 2024 at 07:25:16PM +0900, Byungchul Park wrote:
>> >> > On Tue, Jun 04, 2024 at 06:12:22PM +0900, Byungchul Park wrote:
>> >> > > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
>> >> > > > Byungchul Park <byungchul@sk.com> writes:
>> >> > > > 
>> >> > > > > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
>> >> > > > >> Byungchul Park <byungchul@sk.com> writes:
>> >> > > > >> 
>> >> > > > >> > Changes from v1:
>> >> > > > >> > 	1. Don't allow to resume kswapd if the system is under memory
>> >> > > > >> > 	   pressure that might affect direct reclaim by any chance, like
>> >> > > > >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
>> >> > > > >> >
>> >> > > > >> > --->8---
>> >> > > > >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
>> >> > > > >> > From: Byungchul Park <byungchul@sk.com>
>> >> > > > >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
>> >> > > > >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
>> >> > > > >> >
>> >> > > > >> > A system should run with kswapd running in background when under memory
>> >> > > > >> > pressure, such as when the available memory level is below the low water
>> >> > > > >> > mark and there are reclaimable folios.
>> >> > > > >> >
>> >> > > > >> > However, the current code let the system run with kswapd stopped if
>> >> > > > >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
>> >> > > > >> > until direct reclaim will do for that, even if there are reclaimable
>> >> > > > >> > folios that can be reclaimed by kswapd.  This case was observed in the
>> >> > > > >> > following scenario:
>> >> > > > >> >
>> >> > > > >> >    CONFIG_NUMA_BALANCING enabled
>> >> > > > >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>> >> > > > >> >    numa node0 (500GB local DRAM, 128 CPUs)
>> >> > > > >> >    numa node1 (100GB CXL memory, no CPUs)
>> >> > > > >> >    swap off
>> >> > > > >> >
>> >> > > > >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
>> >> > > > >> >    2) Continue adding the same workload to the system.
>> >> > > > >> >    3) The anon pages are placed in node0 by promotion/demotion.
>> >> > > > >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
>> >> > > > >> >    5) Kill the memory hoggers to restore the system.
>> >> > > > >> >
>> >> > > > >> > After restoring the system at 5), the system starts to run without
>> >> > > > >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
>> >> > > > >> > the mechanism relies on kswapd for demotion.
>> >> > > > >> 
>> >> > > > >> We have run into the situation that kswapd is kept in failure state for
>> >> > > > >> long in a multiple tiers system.  I think that your solution is too
>> >> > > > >
>> >> > > > > My solution just gives a chance for kswapd to work again even if
>> >> > > > > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
>> >> > > > > reclaimable folios.  That's it.
>> >> > > > >
>> >> > > > >> limited, because OOM killing may not happen, while the access pattern of
>> >> > > > >
>> >> > > > > I don't get this.  OOM will happen as is, through direct reclaim.
>> >> > > > 
>> >> > > > A system that fails to reclaim via kswapd may succeed to reclaim via
>> >> > > > direct reclaim, because more CPUs are used to scanning the page tables.
>> >> > > > 
>> >> > > > In a system with NUMA balancing based page promotion and page demotion
>> >> > > > enabled, page promotion will wake up kswapd, but kswapd may fail in some
>> >> > > > situations.  But page promotion will no trigger direct reclaim or OOM.
>> >> > > > 
>> >> > > > >> the workloads may change.  We have a preliminary and simple solution for
>> >> > > > >> this as follows,
>> >> > > > >> 
>> >> > > > >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
>> >> > > > >
>> >> > > > > Whether tiering is involved or not, the same problem can arise if
>> >> > > > > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
>> >> > > > 
>> >> > > > Your description is about tiering too.  Can you describe a situation
>> >> > > 
>> >> > > I mentioned "tiering" while I described how to reproduce because I ran
>> >> > > into the situation while testing with tiering system but I don't think
>> >> > > it's the necessary condition.
>> >> > > 
>> >> > > Let me ask you back, why the logic to stop kswapd was considered in the
>> >> > > first place?  That's because the problem was already observed anyway
>> >> > 
>> >> > To be clear..
>> >> > 
>> >> > The problem, kswapd_failures >= MAX_RECLAIM_RETRIES, can happen whether
>> >> > tiering is involved not not.  Once kswapd stops, the system should run
>> >> > without kswapd even after recovered e.g. by killing the hoggers.  *Even
>> >> > worse*, tiering mechanism doesn't work in this situation.
>> >> 
>> >> But like Ying said, in other situations it's direct reclaim that kicks
>> >> in and clears the flag.
>> >
>> > I already described it in the commit message.
>> >
>> >> The failure-sleep and direct reclaim triggered recovery have been in
>> >
>> > Sure.  It's better than nothing.
>> >
>> >> place since 2017. Both parties who observed an issue with it recently
>> >> did so in tiering scenarios. IMO a tiering-specific solution makes the
>> >> most sense.
>> >
>> > So..  Is the follow situation in a non-tiering system okay?  Really?
>> >
>> >    A system runs with kswapd disabled unless hitting min water mark,
>> >    even if there might be something that kswapd can work on.
>> >
>> > I don't undertand why it's okay.  Could you explain more?  Then why do
>> > we use kswapd in background?
>> 
>> IIUC, it's okey.  One direct reclaiming will be triggered, then kswapd
>> reclaiming will be recovered.  So, the performance will not be
>> influenced much.
>
> So is it because the performance will not be influenced much?  Hm..  the
> system would get impacted at the moment when direct reclaim gets
> triggerred, even though kswapd can mitigate the impact proactively.
>
> However, I don't want to insist strongly if you all consider it's okay.
>
> Changing the topic to tiering, which one looks better between two
> appoaches to solve the issue that tiering doens't work once the failures
> hit MAX_RECLAIM_RETRIES:
>
>    1) periodically run kswapd
>    2) run kswapd if there might be reclaimable folios as this patch does

It's hard to capture all situations.  Folios may become reclaimable in
various ways, some folios become cold, swap devices are added, munlock,
folios freeing/allocating, etc.  It's hard to detect them all without
trying.

It may be not necessary to run kswapd periodically.  So, another
possibility is to allow wakeup kswapd after some timeout even if
kswapd_failures >= MAX_RECLAIM_RETRIES.

--
Best Regards,
Huang, Ying

> For 2), this patch should be modified a lil bit tho.
>
> 	Byungchul
>
>> Do you think that this will impact performance?  If so, please try to
>> prove it with test results.
>> 
>> --
>> Best Regards,
>> Huang, Ying

