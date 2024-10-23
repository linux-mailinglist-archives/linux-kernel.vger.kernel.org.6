Return-Path: <linux-kernel+bounces-377222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD39ABB79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C0AB22B78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC414644E;
	Wed, 23 Oct 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkO6hidT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC551CA81
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650460; cv=none; b=oTnSqFGn6XK7qJX4kIUll/uUYwtJ8usi45JHahZOBJ9YSORAXD7/emtDfSdpMlF2zrCTanv5FoRur99KDQFTyFH/xO1XcRDEcTMfbFO8qeAKDcA9G079Y3rWmmsErThzZ+bv5d1NS9K8rDvwqsCh2mgTQLqNrkN+DHGwus+FOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650460; c=relaxed/simple;
	bh=fuVtBA9cPZe1gQNr73Lk5YhzIyqWJ+cmkqQaWK4ASz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeWkBtqjHyWCs2bmTiWSfYBMRIbadRAg4nW/uAzDjQUr6U7NHpzQiCW0Sm2p5Q1Q6BXT9FiLk1CzUO68CSeB1EBBEtvmJwrmMij/lJ8n/BM6Aeh11lG4HD9XMFyN3Q4m3Jfy2BuAOOBkPycm2o+QzQIVegSONdRzvBOYArf21BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkO6hidT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729650458; x=1761186458;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fuVtBA9cPZe1gQNr73Lk5YhzIyqWJ+cmkqQaWK4ASz8=;
  b=LkO6hidToVQgowxsg17BetJdsDW1OKw/nHR4SzVNprKge4t4d5qFoCrB
   4jbVkKvDxFQKjVxZZE0GwVhvDAp/JBTHZzOWymukdmrVzPlC2+4FUzz0d
   zjanQ7XzBmTLdoy5p8er4Qm5m1qAbTgLTqsSaxYAElOos+ZHom1HBM8Dg
   QTm9rNADHYm6c2q1IwohyJNzlIF67By7rbWB7vz0NsP8Sa5iXgtTq0XTn
   mQpMdMcRvjj3Y1i1ehOus2Dxrx3SrJHQQVPEfckb5mTGpAnUJQUeqaXA9
   O0pSWssqQLlhVdPZLAsB7HxmdzkQzaZF/HtlH88nnIYIjUdpyEyL9dXRD
   Q==;
X-CSE-ConnectionGUID: erWv6WOKSyyoK2ffQfyV1w==
X-CSE-MsgGUID: o6H9sh8UQeutjApwjtlqPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32917264"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32917264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:27:38 -0700
X-CSE-ConnectionGUID: IgSnxehUT9ymgV8NtATNkg==
X-CSE-MsgGUID: aJX4CzuNTgunRF0G7imKSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84035163"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:27:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Hugh
 Dickins <hughd@google.com>,  Yosry Ahmed <yosryahmed@google.com>,  Tim
 Chen <tim.c.chen@linux.intel.com>,  Nhat Pham <nphamcs@gmail.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 23 Oct 2024 03:24:38 +0800")
References: <20241022192451.38138-1-ryncsn@gmail.com>
Date: Wed, 23 Oct 2024 10:24:02 +0800
Message-ID: <87ed474kvx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Kairui,

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> This series improved the swap allocator performance greatly by reworking
> the locking design and simplify a lot of code path.
>
> This is follow up of previous swap cluster allocator series:
> https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/
>
> And this series is based on an follow up fix of the swap cluster
> allocator:
> https://lore.kernel.org/linux-mm/20241022175512.10398-1-ryncsn@gmail.com/
>
> This is part of the new swap allocator work item discussed in
> Chris's "Swap Abstraction" discussion at LSF/MM 2024, and
> "mTHP and swap allocator" discussion at LPC 2024.
>
> Previous series introduced a fully cluster based allocation algorithm,
> this series completely get rid of the old allocation path and makes the
> allocator avoid grabbing the si->lock unless needed. This bring huge
> performance gain and get rid of slot cache on freeing path.

Great!

> Currently, swap locking is mainly composed of two locks, cluster lock
> (ci->lock) and device lock (si->lock). The device lock is widely used
> to protect many things, causing it to be the main bottleneck for SWAP.

Device lock can be confusing with another device lock for struct device.
Better to call it swap device lock?

> Cluster lock is much more fine-grained, so it will be best to use
> ci->lock instead of si->lock as much as possible.
>
> `perf lock` indicates this issue clearly. Doing linux kernel build
> using tmpfs and ZRAM with limited memory (make -j64 with 1G memcg and 4k
> pages), result of "perf lock contention -ab sleep 3":
>
>   contended   total wait     max wait     avg wait         type   caller
>
>      34948     53.63 s       7.11 ms      1.53 ms     spinlock   free_swap_and_cache_nr+0x350
>      16569     40.05 s       6.45 ms      2.42 ms     spinlock   get_swap_pages+0x231
>      11191     28.41 s       7.03 ms      2.54 ms     spinlock   swapcache_free_entries+0x59
>       4147     22.78 s     122.66 ms      5.49 ms     spinlock   page_vma_mapped_walk+0x6f3
>       4595      7.17 s       6.79 ms      1.56 ms     spinlock   swapcache_free_entries+0x59
>     406027      2.74 s       2.59 ms      6.74 us     spinlock   list_lru_add+0x39
>   ...snip...
>
> The top 5 caller are all users of si->lock, total wait time up sums to
> several minutes in the 3 seconds time window.

Can you show results of `perf record -g`, `perf report -g` too?  I have
interest to check hot spot shifting too.

> Following the new allocator design, many operation doesn't need to touch
> si->lock at all. We only need to take si->lock when doing operations
> across multiple clusters (eg. changing the cluster list), other
> operations only need to take ci->lock. So ideally allocator should
> always take ci->lock first, then, if needed, take si->lock. But due
> to historical reasons, ci->lock is used inside si->lock by design,
> causing lock inversion if we simply try to acquire si->lock after
> acquiring ci->lock.
>
> This series audited all si->lock usage, simplify legacy codes, eliminate
> usage of si->lock as much as possible by introducing new designs based
> on the new cluster allocator.
>
> Old HDD allocation codes are removed, cluster allocator is adapted
> with small changes for HDD usage, test is looking OK.

I think that it's a good idea to remove HDD allocation specific code.
Can you check the performance of swapping to HDD?  However, I understand
that many people have no HDD in hand.

> And this also removed slot cache for freeing path. The performance is
> better without it, and this enables other clean up and optimizations
> as discussed before:
> https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_59W1BWw@mail.gmail.com/
>
> After this series, lock contention on si->lock is nearly unobservable
> with `perf lock` with the same test above :
>
>   contended   total wait     max wait     avg wait         type   caller
>   ... snip ...
>          91    204.62 us      4.51 us      2.25 us     spinlock   cluster_move+0x2e
>   ... snip ...
>          47    125.62 us      4.47 us      2.67 us     spinlock   cluster_move+0x2e
>   ... snip ...
>          23     63.15 us      3.95 us      2.74 us     spinlock   cluster_move+0x2e
>   ... snip ...
>          17     41.26 us      4.58 us      2.43 us     spinlock   cluster_isolate_lock+0x1d
>   ... snip ...
>
> cluster_move and cluster_isolate_lock are basically the only users
> of si->lock now, performance gain is huge with reduced LOC.
>
> Tests
> ===
>
> Build kernel with defconfig on tmpfs with ZRAM as swap:
> ---
>
> Running a test matrix which is scaled up progressive for a intuitive result.
> The test are ran on top of tmpfs, using memory cgroup for memory limitation,
> on a 48c96t system.
>
> 12 test run for each case, it can be seen clearly that as concurrent job
> number goes higher the performance gain is higher, the performance is
> higher even with low concurrency.
>
>    make -j<NR>     |   System Time (seconds)  |   Total Time (seconds)
>  (NR / Mem / ZRAM) | (Before / After / Delta) | (Before / After / Delta)
>  With 4k pages only:
>   6 / 192M / 3G    |    5258 /  5235 / -0.3%  |    1420 /  1414 / -0.3%
>  12 / 256M / 4G    |    5518 /  5337 / -3.3%  |     758 /   742 / -2.1%
>  24 / 384M / 5G    |    7091 /  5766 / -18.7% |     476 /   422 / -11.3%
>  48 / 768M / 7G    |   11139 /  5831 / -47.7% |     330 /   221 / -33.0%
>  96 / 1.5G / 10G   |   21303 / 11353 / -46.7% |     283 /   180 / -36.4%
>  With 64k mTHP:
>  24 / 512M / 5G    |    5104 /  4641 / -18.7% |     376 /   358 / -4.8%
>  48 /   1G / 7G    |    8693 /  4662 / -18.7% |     257 /   176 / -31.5%
>  96 /   2G / 10G   |   17056 / 10263 / -39.8% |     234 /   169 / -27.8%

How much is the swap in/out throughput before/after the change?

When I worked on swap in/out performance before, the hot spot shifts from
swap related code to LRU lock and zone lock.  Things may change a lot
now.

If zram is used as swap device, the hot spot may become
compression/decompression after solving the swap lock contention.  To
stress swap subsystem further, we may use a ram disk as swap.
Previously, we have used a simulated pmem device (backed by DRAM).  That
can be setup as in,

https://pmem.io/blog/2016/02/how-to-emulate-persistent-memory/

After creating the raw block device: /dev/pmem0, we can do

$ mkswap /dev/pmem0
$ swapon /dev/pmem0

Can you use something similar if necessary?

> With more aggressive setup, it shows clearly both the performance and
> fragmentation are better:
>
> tiem make -j96 / 768M memcg, 4K pages, 10G ZRAM, on Intel 8255C * 2:
> (avg of 4 test run)
> Before:
> Sys time: 73578.30, Real time: 864.05
> tiem make -j96 / 1G memcg, 4K pages, 10G ZRAM:
> After: (-54.7% sys time, -49.3% real time)
> Sys time: 33314.76, Real time: 437.67
>
> time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, on Intel 8255C * 2:
> (avg of 4 test run)
> Before:
> Sys time: 74044.85, Real time: 846.51
> hugepages-64kB/stats/swpout: 1735216
> hugepages-64kB/stats/swpout_fallback: 430333
> After: (-51.4% sys time, -47.7% real time, -63.2% mTHP failure)
> Sys time: 35958.87, Real time: 442.69
> hugepages-64kB/stats/swpout: 1866267
> hugepages-64kB/stats/swpout_fallback: 158330
>
> There is a up to 54.7% improvement for build kernel test, and lower
> fragmentation rate. Performance improvement should be even larger for
> micro benchmarks

Very good result!

> Build kernel with tinyconfig on tmpfs with HDD as swap:
> ---
>
> This test is similar to above, but HDD test is very noisy and slow, the
> deviation is huge, so just use tinyconfig instead and take the median test
> result of 3 test run, which looks OK:
>
> Before this series:
> 114.44user 29.11system 39:42.90elapsed 6%CPU
> 2901232inputs+0outputs (238877major+4227640minor)pagefaults
>
> After this commit:
> 113.90user 23.81system 38:11.77elapsed 6%CPU
> 2548728inputs+0outputs (235471major+4238110minor)pagefaults
>
> Single thread SWAP:
> ---
>
> Sequential SWAP should also be slightly faster as we removed a lot of
> unnecessary parts. Test using micro benchmark for swapout/in 4G
> zero memory using ZRAM, 10 test runs:
>
> Swapout Before (avg. 3359304):
> 3353796 3358551 3371305 3356043 3367524 3355303 3355924 3354513 3360776
>
> Swapin Before (avg. 1928698):
> 1920283 1927183 1934105 1921373 1926562 1938261 1927726 1928636 1934155
>
> Swapout After (avg. 3347511, -0.4%):
> 3337863 3347948 3355235 3339081 3333134 3353006 3354917 3346055 3360359
>
> Swapin After (avg. 1922290, -0.3%):
> 1919101 1925743 1916810 1917007 1923930 1935152 1917403 1923549 1921913
>
> Worth noticing the patch "mm, swap: use a global swap cluster for
> non-rotation device" introduced minor overhead for certain tests (see
> the test results in commit message), but the gain from later commit
> covered that, it can be further improved later.
>
> Suggested-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Kairui Song (13):
>   mm, swap: minor clean up for swap entry allocation
>   mm, swap: fold swap_info_get_cont in the only caller
>   mm, swap: remove old allocation path for HDD
>   mm, swap: use cluster lock for HDD
>   mm, swap: clean up device availability check
>   mm, swap: clean up plist removal and adding
>   mm, swap: hold a reference of si during scan and clean up flags
>   mm, swap: use an enum to define all cluster flags and wrap flags
>     changes
>   mm, swap: reduce contention on device lock
>   mm, swap: simplify percpu cluster updating
>   mm, swap: introduce a helper for retrieving cluster from offset
>   mm, swap: use a global swap cluster for non-rotation device
>   mm, swap_slots: remove slot cache for freeing path
>
>  fs/btrfs/inode.c           |    1 -
>  fs/iomap/swapfile.c        |    1 -
>  include/linux/swap.h       |   36 +-
>  include/linux/swap_slots.h |    3 -
>  mm/page_io.c               |    1 -
>  mm/swap_slots.c            |   78 +--
>  mm/swapfile.c              | 1198 ++++++++++++++++--------------------
>  7 files changed, 558 insertions(+), 760 deletions(-)

--
Best Regards,
Huang, Ying

