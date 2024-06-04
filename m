Return-Path: <linux-kernel+bounces-200331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5D8FAE7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB3A1F241BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484214389F;
	Tue,  4 Jun 2024 09:12:36 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248A143890
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492355; cv=none; b=k+9waYr6h8wjXKyr+eCLyjIsIlcqdQS0KXqvRZPFa0E8LTUD4bCxDEg8EGqckeV3FpR+XijHinC/GJ1qFItUReR8gfDr0HrHu1RfFkDEVc/8kiA2PBKSkjNk8YvvetpNP9h9nd1Z8P3uGPFrggRRtgf6srwmoqNt4agq/qKVWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492355; c=relaxed/simple;
	bh=ZDk/Nypti9OkdiSrO0F3QWd83a+WWkijrwoDmER6QIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6PaH+cRNXUIxdKFPt+Car0Mcl4y2sIFpTXEVDW45Ght8XgFUWvhxbZFdW4pw/OvpArTcezyczyYbdImzRnaTZPdmrYbbB/42JG9I3XcrXYl6fTtM8h/GUkuDr8Wsx2Ow+Fg7N8GFQtK0V6HeXSrR8v+1xQtqGrWK2i4qJfFrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-5f-665eda7b264e
Date: Tue, 4 Jun 2024 18:12:22 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240604091221.GA28034@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnkW71rbg0g533xC3mrF/DZrF6k6/F
	yu5mNovLu+awWdxb85/Vom3JRiaLk7Mmsziwexx+857ZY8GmUo/Fe14yeWz6NIndo+vtFSaP
	EzN+s3h83iQXwB7FZZOSmpNZllqkb5fAlbHq41q2gq9KFTPf/WRrYFwg3cXIySEhYCLxYvID
	Jhi7rW0GO4jNIqAisXHhA1YQm01AXeLGjZ/MILaIgIbEp4XLgWq4OJgF1jJKHLnaAlTEwSEs
	kCpxfHsASA2vgIXEsiUvWUBqhATOMEr0NqxngkgISpyc+YQFxGYW0JK48e8lE0gvs4C0xPJ/
	HCBhTgE7id5F9xlBbFEBZYkD244zgcyREDjAJjHl7gMWiEMlJQ6uuMEygVFgFpKxs5CMnYUw
	dgEj8ypGocy8stzEzBwTvYzKvMwKveT83E2MwGBfVvsnegfjpwvBhxgFOBiVeHgNFsWmCbEm
	lhVX5h5ilOBgVhLh7auLThPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUg
	tQgmy8TBKdXA2PxZwXmDvxafxa2qZ2wvXqdy9OkJzWDiOsK6RfoOd8nf68JPTIo0arbb6ArF
	yW/oWNdTwv+VS45pa+Kk85wdonJZZ2N3aLNLfp24bWuxsUJZ5JKotO8XX5mnS39yfWaieMf6
	4m2Wh1JL/e/tW8+8+efSnokKffVHOr53M2p7LdRViD2ge3umEktxRqKhFnNRcSIARsvOv3IC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXC5WfdrFt9Ky7N4NkdLos569ewWaze5Gux
	sruZzeLw3JOsFpd3zWGzuLfmP6tF25KNTBYnZ01mceDwOPzmPbPHgk2lHov3vGTy2PRpErtH
	19srTB4nZvxm8Vj84gOTx+dNcgEcUVw2Kak5mWWpRfp2CVwZqz6uZSv4qlQx891PtgbGBdJd
	jJwcEgImEm1tM9hBbBYBFYmNCx+wgthsAuoSN278ZAaxRQQ0JD4tXA5Uw8XBLLCWUeLI1Rag
	Ig4OYYFUiePbA0BqeAUsJJYteckCUiMkcIZRordhPRNEQlDi5MwnLCA2s4CWxI1/L5lAepkF
	pCWW/+MACXMK2En0LrrPCGKLCihLHNh2nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1Sv
	ODujMi+zQi85P3cTIzB0l9X+mbiD8ctl90OMAhyMSjy8Fitj04RYE8uKK3MPMUpwMCuJ8PbV
	RacJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MPK65x5+
	ZDffzkAt7/z+9K2Oezq+K8aF3Gzh0t8wVbn3tdyV+o2iz25c2uxu7fzAr2p67oXCa8vmafs2
	NloYH3qjwjDx0JF/pQFmT7T/6U/bk5RpZP1LWmH60qf8hz2SHcNP8c/XvbN2w+bFC19FMJ1a
	nfqzrW6jduaGTVdCOa/P/HQjR3zZ5AYlluKMREMt5qLiRADimWPdWQIAAA==
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
> 
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

I mentioned "tiering" while I described how to reproduce because I ran
into the situation while testing with tiering system but I don't think
it's the necessary condition.

Let me ask you back, why the logic to stop kswapd was considered in the
first place?  That's because the problem was already observed anyway
whether tiering is involved or not.  The same problem will arise once
kswapd stops.

	Byungchul

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

