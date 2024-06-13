Return-Path: <linux-kernel+bounces-212433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8A906067
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F1E1F22191
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045ADDD8;
	Thu, 13 Jun 2024 01:27:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1EDF5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242077; cv=none; b=RorhiZ3RGz/OX6abjtWNCHACKz4Kr2B4pATBbo2Zzbe/YQ+UnAb117Ngth3nRJqT3u1alDR2rL69jVNtsKsny6dqKFtaNjqBfgqLDW4Op0rSf1JwZmSsUTxqlBk29ZGzgW8hjupLLtB7Xa3I1kjwp7hL267LqlHdttn1IIRPv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242077; c=relaxed/simple;
	bh=XfqJNkosyOYKqilrQ2edKUB6Xy+7+61h9xV0qtiLKZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2ZindlKzzN2694VOfSNLLpSUoIgDWAZs7l4lRXNm6bIib6sT0CgLxFHUpHZpGiqp1c8Xs+EkxJl6xYEg19R+d1dTbk3wV9UYEessSQgpM8pRiCo+cIxaPdpPwQLGfEnSZyeaXAlLxmXeORx3N0MnB7IbvOAvykwFSKUBxMJndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-93-666a4b0f1a48
Date: Thu, 13 Jun 2024 10:27:38 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240613012738.GA2327@system.software.com>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240605015021.GB75311@system.software.com>
 <87tti8b10g.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240605021902.GC75311@system.software.com>
 <20240607071228.GA76933@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607071228.GA76933@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoS6/d1aawdWbRhZz1q9hs1i9yddi
	ZXczm8XlXXPYLO6t+c9q0bZkI5PFyVmTWRzYPQ6/ec/ssWBTqcfiPS+ZPDZ9msTu0fX2CpPH
	iRm/WTw+b5ILYI/isklJzcksSy3St0vgyrjwdSZTwVrzin9LnjA3MLZodTFyckgImEjM3nuf
	EcZuW3OJHcRmEVCVePK9jQXEZhNQl7hx4ycziC0ioCHxaeFyoBouDmaBtYwSR662sHYxcnAI
	C6RKHN8eAFLDK2AusfTXVLCZQgK9zBI7DuZDxAUlTs58AjaTWUBL4sa/l0wgrcwC0hLL/3GA
	hDkFLCW6m4+DtYoKKEsc2HacCWSVhMAeNonFOz8xQ9wpKXFwxQ2WCYwCs5CMnYVk7CyEsQsY
	mVcxCmXmleUmZuaY6GVU5mVW6CXn525iBIb6sto/0TsYP10IPsQowMGoxMP7YGVmmhBrYllx
	Ze4hRgkOZiUR3jMx6WlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbB
	ZJk4OKUaGCd+cy2uWzxp+wavlfu+86guPM9/u3ez+m0hZkVhzdJL6ydoShrYLTdZLVb0ekHC
	9dUd798pJ5ukLOyYPOXmydMbj03S/c55sGHuKxFWxVXLiu9GnuhxY7i/3d/ZTuu48OTgw/Kt
	3quUF8h8fu8Umnj8po3AAROm1a5LZyqzpJ3v8Fg+46HwqjdKLMUZiYZazEXFiQAZAVk4cQIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXC5WfdrMvvnZVm8PCPvMWc9WvYLFZv8rVY
	2d3MZnF47klWi8u75rBZ3Fvzn9WibclGJouTsyazOHB4HH7zntljwaZSj8V7XjJ5bPo0id2j
	6+0VJo8TM36zeCx+8YHJ4/MmuQCOKC6blNSczLLUIn27BK6MC19nMhWsNa/4t+QJcwNji1YX
	IyeHhICJRNuaS+wgNouAqsST720sIDabgLrEjRs/mUFsEQENiU8LlwPVcHEwC6xllDhytYW1
	i5GDQ1ggVeL49gCQGl4Bc4mlv6YygthCAr3MEjsO5kPEBSVOznwCNpNZQEvixr+XTCCtzALS
	Esv/cYCEOQUsJbqbj4O1igooSxzYdpxpAiPvLCTds5B0z0LoXsDIvIpRJDOvLDcxM8dUrzg7
	ozIvs0IvOT93EyMwcJfV/pm4g/HLZfdDjAIcjEo8vA9WZqYJsSaWFVfmHmKU4GBWEuE9E5Oe
	JsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cCod2Xe6/1f
	lEKfbTt20d76SZ33rFp907hza63LItxljKPeWpWEHwvSeBL47uXai2e0I4onPP0n9GFH/QTz
	1YbiETf9J9rmrzvbseCr8tKttUs0jVMdXnseUf7g+PkIB4P1bb2njE9sGIpa5vbwqxvHRaqG
	cOvbCxxLbzyltYn7xbXSzXufPc1SYinOSDTUYi4qTgQAneEXPlgCAAA=
X-CFilter-Loop: Reflected

On Fri, Jun 07, 2024 at 04:12:28PM +0900, Byungchul Park wrote:
> On Wed, Jun 05, 2024 at 11:19:02AM +0900, Byungchul Park wrote:
> > On Wed, Jun 05, 2024 at 10:02:07AM +0800, Huang, Ying wrote:
> > > Byungchul Park <byungchul@sk.com> writes:
> > > 
> > > > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> > > >> Byungchul Park <byungchul@sk.com> writes:
> > > >> 
> > > >> > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> > > >> >> Byungchul Park <byungchul@sk.com> writes:
> > > >> >> 
> > > >> >> > Changes from v1:
> > > >> >> > 	1. Don't allow to resume kswapd if the system is under memory
> > > >> >> > 	   pressure that might affect direct reclaim by any chance, like
> > > >> >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> > > >> >> >
> > > >> >> > --->8---
> > > >> >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> > > >> >> > From: Byungchul Park <byungchul@sk.com>
> > > >> >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> > > >> >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> > > >> >> >
> > > >> >> > A system should run with kswapd running in background when under memory
> > > >> >> > pressure, such as when the available memory level is below the low water
> > > >> >> > mark and there are reclaimable folios.
> > > >> >> >
> > > >> >> > However, the current code let the system run with kswapd stopped if
> > > >> >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> > > >> >> > until direct reclaim will do for that, even if there are reclaimable
> > > >> >> > folios that can be reclaimed by kswapd.  This case was observed in the
> > > >> >> > following scenario:
> > > >> >> >
> > > >> >> >    CONFIG_NUMA_BALANCING enabled
> > > >> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > > >> >> >    numa node0 (500GB local DRAM, 128 CPUs)
> > > >> >> >    numa node1 (100GB CXL memory, no CPUs)
> > > >> >> >    swap off
> > > >> >> >
> > > >> >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> > > >> >> >    2) Continue adding the same workload to the system.
> > > >> >> >    3) The anon pages are placed in node0 by promotion/demotion.
> > > >> >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> > > >> >> >    5) Kill the memory hoggers to restore the system.
> > > >> >> >
> > > >> >> > After restoring the system at 5), the system starts to run without
> > > >> >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> > > >> >> > the mechanism relies on kswapd for demotion.
> > > >> >> 
> > > >> >> We have run into the situation that kswapd is kept in failure state for
> > > >> >> long in a multiple tiers system.  I think that your solution is too
> > > >> >
> > > >> > My solution just gives a chance for kswapd to work again even if
> > > >> > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> > > >> > reclaimable folios.  That's it.
> > > >> >
> > > >> >> limited, because OOM killing may not happen, while the access pattern of
> > > >> >
> > > >> > I don't get this.  OOM will happen as is, through direct reclaim.
> > > >> 
> > > >> A system that fails to reclaim via kswapd may succeed to reclaim via
> > > >> direct reclaim, because more CPUs are used to scanning the page tables.
> > > >
> > > > Honestly, I don't think so with this description.
> > > >
> > > > The fact that the system hit MAX_RECLAIM_RETRIES means the system is
> > > > currently hopeless unless reclaiming folios in a stronger way by *direct
> > > > reclaim*.  The solution for this situation should not be about letting
> > > > more CPUs particiated in reclaiming, again, *at least in this situation*.
> > > >
> > > > What you described here is true only in a normal state where the more
> > > > CPUs work on reclaiming, the more reclaimable folios can be reclaimed.
> > > > kswapd can be a helper *only* when there are kswapd-reclaimable folios.
> > > 
> > > Sometimes, we cannot reclaim just because we doesn't scan fast enough so
> > > the Accessed-bit is set again during scanning.  With more CPUs, we can
> > > scan faster, so make some progress.  But, yes, this only cover one
> > > situation, there are other situations too.
> > 
> > What I mean is *the issue we try to solve* is not the situation that
> > can be solved by letting more CPUs participate in reclaiming.
> 
> Again, in the situation where kswapd has failed more than
> MAX_RECLAIM_RETRIES, say, holeless, I don't think it makes sense to wake
> up kswapd every 10 seconds.  It'd be more sensible to wake up kwapd only
> if there are *at least potentially* reclaimable folios.

1) numa balancing tiering on

No doubt the patch should work for it since numa balancing tiering
doesn't work at all once kswapd stops.  We are already applying and
using this patch in tests for tiering.  It works perfect.

2) numa balancing tiering off

kswapd will be resumed even without this patch if free memory hits min
wmark.  However, do we have to wait for direct reclaim to work for it?
Even though we can proactively prevent direct reclaim using kswapd?

	Byungchul

> As Ying said, there's no way to precisely track if reclaimable, but it's
> worth trying when the possibility becomes positive and looks more
> reasonable.  Thoughts?
> 
> 	Byungchul
> 
> > 	Byungchul
> > 
> > > --
> > > Best Regards,
> > > Huang, Ying
> > > 
> > > > 	Byungchul
> > > >
> > > >> In a system with NUMA balancing based page promotion and page demotion
> > > >> enabled, page promotion will wake up kswapd, but kswapd may fail in some
> > > >> situations.  But page promotion will no trigger direct reclaim or OOM.
> > > >> 
> > > >> >> the workloads may change.  We have a preliminary and simple solution for
> > > >> >> this as follows,
> > > >> >> 
> > > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> > > >> >
> > > >> > Whether tiering is involved or not, the same problem can arise if
> > > >> > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> > > >> 
> > > >> Your description is about tiering too.  Can you describe a situation
> > > >> without tiering?
> > > >> 
> > > >> --
> > > >> Best Regards,
> > > >> Huang, Ying
> > > >> 
> > > >> > 	Byungchul
> > > >> >
> > > >> >> where we will try to wake up kswapd to check every 10 seconds if kswapd
> > > >> >> is in failure state.  This is another possible solution.
> > > >> >> 
> > > >> >> > However, the node0 has pages newly allocated after 5), that might or
> > > >> >> > might not be reclaimable.  Since those are potentially reclaimable, it's
> > > >> >> > worth hopefully trying reclaim by allowing kswapd to work again.
> > > >> >> >
> > > >> >> 
> > > >> >> [snip]
> > > >> >> 
> > > >> >> --
> > > >> >> Best Regards,
> > > >> >> Huang, Ying

