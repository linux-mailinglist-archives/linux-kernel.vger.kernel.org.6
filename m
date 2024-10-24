Return-Path: <linux-kernel+bounces-379118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7CF9ADA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2A1B225FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764715B13D;
	Thu, 24 Oct 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLB1dKX8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807941537CE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739306; cv=none; b=bhbY9ksd7QPQ+tIntFL046/Eq5XGMTnvXb+Xp1FPfLeXYdWrudH98iTPIwxqtPt2Jn2KM89J7L1p1ltU8XCeREAZ20NKdKYngVB7aU1YU9fykzfI6+/G19PnG/UQnsizeKQf/rlFzv74ni2TnEr9y0s1D/+HIX23ZSE36rh4sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739306; c=relaxed/simple;
	bh=mQoQUqn5jIhvcnk++g/CuO0SnOgEVHMl1BozhFvksWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHita8Y5ehLsqW1MAV85F3WzOI2bLFcIBMG/dJLu2MJdGlGl79AOFinF6WdjA/gxh3eTfc0R68MgBMs4UMMz0idj+/2y6IurLSw7AlJkP9EgQWW1ptYXnuS7Wu1ysX6ZeOwRMB2nU/VKGiD34hWJlD1Y0lyVcYo1WuttxTcr5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLB1dKX8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729739303; x=1761275303;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=mQoQUqn5jIhvcnk++g/CuO0SnOgEVHMl1BozhFvksWI=;
  b=QLB1dKX8wkbkelqUfDwG2rPy2ZgYE6vkiNP0S+5Fn+C0vNbcrbLs+j0+
   9zSN6jQuIPqYzC+O7hEaTiJb7/jNTb+AVw9YJgh1gs51EkoumQqI8jbjI
   4PcBqRe9/yOHa/kBXUXOBsTsRIWw2hm+jwmnKfWiop08xUcU5nzksTx80
   7FT86HEIdaK9jfHBHPhstMv9YDmM1np7BlyHYldXMQKn3HblUgNYb2PCj
   BXabcR9uoT8Zu2j3YFELc2xE8iObNnS9utBVjSCPrwNSFfy0lFtc0PkZv
   GDYmeQ5YJbwjha8qWrQZ5HC/F5SKTcNqaWWxIuBy3z6Uzbb/KuFiHPhQ4
   w==;
X-CSE-ConnectionGUID: GaTOXhlpRLG43kIRk/9X9A==
X-CSE-MsgGUID: gK6CchhlQGCbDVdEC3QkZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40746262"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="40746262"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:08:23 -0700
X-CSE-ConnectionGUID: vMSpCKBFT0W74HPHRzYT3Q==
X-CSE-MsgGUID: EwYFOJ6OQv2Bf+noFqiCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85240153"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:08:20 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Hugh Dickins <hughd@google.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  Tim Chen <tim.c.chen@linux.intel.com>,  Nhat
 Pham <nphamcs@gmail.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
In-Reply-To: <CAMgjq7BfO=dNYep4z1aS7nUAJU3bktR17gYAufx=kkLudq4dAQ@mail.gmail.com>
	(Kairui Song's message of "Thu, 24 Oct 2024 02:01:43 +0800")
References: <20241022192451.38138-1-ryncsn@gmail.com>
	<87ed474kvx.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7BfO=dNYep4z1aS7nUAJU3bktR17gYAufx=kkLudq4dAQ@mail.gmail.com>
Date: Thu, 24 Oct 2024 11:04:47 +0800
Message-ID: <875xpi42wg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Oct 23, 2024 at 10:27=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Hi, Kairui,
>
> Hi Ying,
>
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > This series improved the swap allocator performance greatly by reworki=
ng
>> > the locking design and simplify a lot of code path.
>> >
>> > This is follow up of previous swap cluster allocator series:
>> > https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b=
9297@kernel.org/
>> >
>> > And this series is based on an follow up fix of the swap cluster
>> > allocator:
>> > https://lore.kernel.org/linux-mm/20241022175512.10398-1-ryncsn@gmail.c=
om/
>> >
>> > This is part of the new swap allocator work item discussed in
>> > Chris's "Swap Abstraction" discussion at LSF/MM 2024, and
>> > "mTHP and swap allocator" discussion at LPC 2024.
>> >
>> > Previous series introduced a fully cluster based allocation algorithm,
>> > this series completely get rid of the old allocation path and makes the
>> > allocator avoid grabbing the si->lock unless needed. This bring huge
>> > performance gain and get rid of slot cache on freeing path.
>>
>> Great!
>>
>> > Currently, swap locking is mainly composed of two locks, cluster lock
>> > (ci->lock) and device lock (si->lock). The device lock is widely used
>> > to protect many things, causing it to be the main bottleneck for SWAP.
>>
>> Device lock can be confusing with another device lock for struct device.
>> Better to call it swap device lock?
>
> Good idea, I'll use the term swap device lock then.
>
>>
>> > Cluster lock is much more fine-grained, so it will be best to use
>> > ci->lock instead of si->lock as much as possible.
>> >
>> > `perf lock` indicates this issue clearly. Doing linux kernel build
>> > using tmpfs and ZRAM with limited memory (make -j64 with 1G memcg and =
4k
>> > pages), result of "perf lock contention -ab sleep 3":
>> >
>> >   contended   total wait     max wait     avg wait         type   call=
er
>> >
>> >      34948     53.63 s       7.11 ms      1.53 ms     spinlock   free_=
swap_and_cache_nr+0x350
>> >      16569     40.05 s       6.45 ms      2.42 ms     spinlock   get_s=
wap_pages+0x231
>> >      11191     28.41 s       7.03 ms      2.54 ms     spinlock   swapc=
ache_free_entries+0x59
>> >       4147     22.78 s     122.66 ms      5.49 ms     spinlock   page_=
vma_mapped_walk+0x6f3
>> >       4595      7.17 s       6.79 ms      1.56 ms     spinlock   swapc=
ache_free_entries+0x59
>> >     406027      2.74 s       2.59 ms      6.74 us     spinlock   list_=
lru_add+0x39
>> >   ...snip...
>> >
>> > The top 5 caller are all users of si->lock, total wait time up sums to
>> > several minutes in the 3 seconds time window.
>>
>> Can you show results of `perf record -g`, `perf report -g` too?  I have
>> interest to check hot spot shifting too.
>
> Sure. I think `perf lock` result is already good enough and cleaner.
> My test environment are mostly VM based so spinlock slow path may get
> offloaded to host, and can't be see by perf record, I collected
> following data after disabled paravirt spinlock:
>
> The time consumption and stack trace of a page fault before:
> -   78.45%     0.17%  cc1              [kernel.kallsyms]
>                 [k] asm_exc_page_fault
>    - 78.28% asm_exc_page_fault
>       - 78.18% exc_page_fault
>          - 78.17% do_user_addr_fault
>             - 78.09% handle_mm_fault
>                - 78.06% __handle_mm_fault
>                   - 69.69% do_swap_page
>                      - 55.87% alloc_swap_folio
>                         - 55.60% mem_cgroup_swapin_charge_folio
>                            - 55.48% charge_memcg
>                               - 55.45% try_charge_memcg
>                                  - 55.36% try_to_free_mem_cgroup_pages
>                                     - do_try_to_free_pages
>                                        - 55.35% shrink_node
>                                           - 55.27% shrink_lruvec
>                                              - 55.13% try_to_shrink_lruvec
>                                                 - 54.79% evict_folios
>                                                    - 54.35% shrink_folio_=
list
>                                                       - 30.01% add_to_swap
>                                                          - 29.77%
> folio_alloc_swap
>                                                             - 29.50%
> get_swap_pages
>
> 25.03% queued_spin_lock_slowpath
>                                                                - 2.71%
> alloc_swap_scan_cluster
>
> 1.80% queued_spin_lock_slowpath
>                                                                   +
> 0.89% __try_to_reclaim_swap
>                                                                - 1.74%
> swap_reclaim_full_clusters
>
> 1.74% queued_spin_lock_slowpath
>                                                       - 10.88%
> try_to_unmap_flush_dirty
>                                                          - 10.87%
> arch_tlbbatch_flush
>                                                             - 10.85%
> on_each_cpu_cond_mask
>
> smp_call_function_many_cond
>                                                       + 7.45% pageout
>                                                       + 2.71% try_to_unma=
p_flush
>                                                       + 1.90% try_to_unmap
>                                                       + 0.78% folio_refer=
enced
>                      - 9.41% cluster_swap_free_nr
>                         - 9.39% free_swap_slot
>                            - 9.35% swapcache_free_entries
>                                 8.40% queued_spin_lock_slowpath
>                                 0.93% swap_entry_range_free
>                      - 3.61% swap_read_folio_bdev_sync
>                         - 3.55% submit_bio_wait
>                            - 3.51% submit_bio_noacct_nocheck
>                               + 3.46% __submit_bio
>                   + 7.71% do_pte_missing
>                   + 0.61% wp_page_copy
>
> The queued_spin_lock_slowpath above is the si->lock, and there are
> multiple users of it so the total overhead is higher than shown.
>
> After:
> -   75.05%     0.43%  cc1              [kernel.kallsyms]
>                 [k] asm_exc_page_fault
>    - 74.62% asm_exc_page_fault
>       - 74.36% exc_page_fault
>          - 74.34% do_user_addr_fault
>             - 74.10% handle_mm_fault
>                - 73.96% __handle_mm_fault
>                   - 67.55% do_swap_page
>                      - 45.92% alloc_swap_folio
>                         - 45.03% mem_cgroup_swapin_charge_folio
>                            - 44.58% charge_memcg
>                               - 44.44% try_charge_memcg
>                                  - 44.12% try_to_free_mem_cgroup_pages
>                                     - do_try_to_free_pages
>                                        - 44.10% shrink_node
>                                           - 43.86% shrink_lruvec
>                                              - 41.92% try_to_shrink_lruvec
>                                                 - 40.67% evict_folios
>                                                    - 37.12% shrink_folio_=
list
>                                                       - 20.88% pageout
>                                                          + 20.02% swap_wr=
itepage
>                                                          + 0.72% shmem_wr=
itepage
>                                                       - 4.08% add_to_swap
>                                                          - 2.48%
> folio_alloc_swap
>                                                             - 2.12%
> __mem_cgroup_try_charge_swap
>                                                                - 1.47%
> swap_cgroup_record
>                                                                   +
> 1.32% _raw_spin_lock_irqsave
>                                                          - 1.56%
> add_to_swap_cache
>                                                             - 1.04% xas_s=
tore
>                                                                + 1.01%
> workingset_update_node
>                                                       + 3.97%
> try_to_unmap_flush_dirty
>                                                       + 3.51% folio_refer=
enced
>                                                       + 2.24% __remove_ma=
pping
>                                                       + 1.16% try_to_unmap
>                                                       + 0.52% try_to_unma=
p_flush
>                                                      2.50%
> queued_spin_lock_slowpath
>                                                      0.79% scan_folios
>                                                 + 1.20% try_to_inc_max_seq
>                                              + 1.92% lru_add_drain
>                         + 0.73% vma_alloc_folio_noprof
>                      - 9.81% swap_read_folio_bdev_sync
>                         - 9.61% submit_bio_wait
>                            + 9.49% submit_bio_noacct_nocheck
>                      - 8.06% cluster_swap_free_nr
>                         - 8.02% swap_entry_range_free
>                            + 3.92% __mem_cgroup_uncharge_swap
>                            + 2.90% zram_slot_free_notify
>                              0.58% clear_shadow_from_swap_cache
>                      - 1.32% __folio_batch_add_and_move
>                         - 1.30% folio_batch_move_lru
>                            + 1.10% folio_lruvec_lock_irqsave

Thanks for data.

It seems that the cycles shifts from spinning to memory compression.
That is expected.

> spin_lock usage is much lower.
>
> I prefer the perf lock output as it shows the exact time and user of lock=
s.

perf cycles data is more complete.  You can find which part becomes new
hot spot.

>>
>> > Following the new allocator design, many operation doesn't need to tou=
ch
>> > si->lock at all. We only need to take si->lock when doing operations
>> > across multiple clusters (eg. changing the cluster list), other
>> > operations only need to take ci->lock. So ideally allocator should
>> > always take ci->lock first, then, if needed, take si->lock. But due
>> > to historical reasons, ci->lock is used inside si->lock by design,
>> > causing lock inversion if we simply try to acquire si->lock after
>> > acquiring ci->lock.
>> >
>> > This series audited all si->lock usage, simplify legacy codes, elimina=
te
>> > usage of si->lock as much as possible by introducing new designs based
>> > on the new cluster allocator.
>> >
>> > Old HDD allocation codes are removed, cluster allocator is adapted
>> > with small changes for HDD usage, test is looking OK.
>>
>> I think that it's a good idea to remove HDD allocation specific code.
>> Can you check the performance of swapping to HDD?  However, I understand
>> that many people have no HDD in hand.
>
> It's not hard to make cluster allocator work well with HDD in theory,
> see the commit "mm, swap: use a global swap cluster for non-rotation
> device".
> The testing is not very reliable though, I found HDD swap performance
> is very unstable because of the IO pattern of HDD, so it's just a best
> effort try.

Just to check whether code change cause something too bad for HDD.  No
measurable difference is a good news.

>> > And this also removed slot cache for freeing path. The performance is
>> > better without it, and this enables other clean up and optimizations
>> > as discussed before:
>> > https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmes=
W_59W1BWw@mail.gmail.com/
>> >
>> > After this series, lock contention on si->lock is nearly unobservable
>> > with `perf lock` with the same test above :
>> >
>> >   contended   total wait     max wait     avg wait         type   call=
er
>> >   ... snip ...
>> >          91    204.62 us      4.51 us      2.25 us     spinlock   clus=
ter_move+0x2e
>> >   ... snip ...
>> >          47    125.62 us      4.47 us      2.67 us     spinlock   clus=
ter_move+0x2e
>> >   ... snip ...
>> >          23     63.15 us      3.95 us      2.74 us     spinlock   clus=
ter_move+0x2e
>> >   ... snip ...
>> >          17     41.26 us      4.58 us      2.43 us     spinlock   clus=
ter_isolate_lock+0x1d
>> >   ... snip ...
>> >
>> > cluster_move and cluster_isolate_lock are basically the only users
>> > of si->lock now, performance gain is huge with reduced LOC.
>> >
>> > Tests
>> > =3D=3D=3D
>> >
>> > Build kernel with defconfig on tmpfs with ZRAM as swap:
>> > ---
>> >
>> > Running a test matrix which is scaled up progressive for a intuitive r=
esult.
>> > The test are ran on top of tmpfs, using memory cgroup for memory limit=
ation,
>> > on a 48c96t system.
>> >
>> > 12 test run for each case, it can be seen clearly that as concurrent j=
ob
>> > number goes higher the performance gain is higher, the performance is
>> > higher even with low concurrency.
>> >
>> >    make -j<NR>     |   System Time (seconds)  |   Total Time (seconds)
>> >  (NR / Mem / ZRAM) | (Before / After / Delta) | (Before / After / Delt=
a)
>> >  With 4k pages only:
>> >   6 / 192M / 3G    |    5258 /  5235 / -0.3%  |    1420 /  1414 / -0.3%
>> >  12 / 256M / 4G    |    5518 /  5337 / -3.3%  |     758 /   742 / -2.1%
>> >  24 / 384M / 5G    |    7091 /  5766 / -18.7% |     476 /   422 / -11.=
3%
>> >  48 / 768M / 7G    |   11139 /  5831 / -47.7% |     330 /   221 / -33.=
0%
>> >  96 / 1.5G / 10G   |   21303 / 11353 / -46.7% |     283 /   180 / -36.=
4%
>> >  With 64k mTHP:
>> >  24 / 512M / 5G    |    5104 /  4641 / -18.7% |     376 /   358 / -4.8%
>> >  48 /   1G / 7G    |    8693 /  4662 / -18.7% |     257 /   176 / -31.=
5%
>> >  96 /   2G / 10G   |   17056 / 10263 / -39.8% |     234 /   169 / -27.=
8%
>>
>> How much is the swap in/out throughput before/after the change?
>
> This may not be too beneficial for typical throughput measurement:
> - For example doing the same test with brd will only show a ~20%
> performance improvement, still a big gain though. I think the si->lock
> spinlock wasting CPU cycles may effect CPU sensitive things like ZRAM
> even more.

20% is a good data.  You don't need to guess.  perf cycles profiling can
show the hot spot.

> - And simple benchmarks which just do multiple sequential swaps in/out
> in multiple thread hardly stress the allocator.
>
> I haven't found a good
> benchmark to simulate random parallel IOs on SWAP yet, I can write one
> later.

I have used anon-w-rand test case of vm-scalability to simulate random
parallel swap out.

https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree=
/case-anon-w-rand

> A more close to real word benchmark like build kernel test, or
> mysql/sysbench all showed great improment.

Yes.  Real work load is good.  We can use micro-benchmark to find out
some performance limit, for example, max possible throughput.

>>
>> When I worked on swap in/out performance before, the hot spot shifts from
>> swap related code to LRU lock and zone lock.  Things may change a lot
>> now.
>>
>> If zram is used as swap device, the hot spot may become
>> compression/decompression after solving the swap lock contention.  To
>> stress swap subsystem further, we may use a ram disk as swap.
>> Previously, we have used a simulated pmem device (backed by DRAM).  That
>> can be setup as in,
>>
>> https://pmem.io/blog/2016/02/how-to-emulate-persistent-memory/
>>
>> After creating the raw block device: /dev/pmem0, we can do
>>
>> $ mkswap /dev/pmem0
>> $ swapon /dev/pmem0
>>
>> Can you use something similar if necessary?
>
> I used to test with brd, as described above,

brd will allocate memory during running, pmem can avoid that.  perf
profile is your friends to root cause the possible issue.

> I think using ZRAM with
> test simulating real workload is more useful.

Yes.  And, as I said before.  Micro-benchmark has its own value.

> And I did include a Sequential SWAP test, the result is looking OK (no
> regression, minor to none improvement).

Good.  At least we have no regression here.

> I can  have a try with the pmem setup later, I guess the result will
> be similar to brd test.
>
>
>>
>> > With more aggressive setup, it shows clearly both the performance and
>> > fragmentation are better:
>> >
>> > tiem make -j96 / 768M memcg, 4K pages, 10G ZRAM, on Intel 8255C * 2:
>> > (avg of 4 test run)
>> > Before:
>> > Sys time: 73578.30, Real time: 864.05
>> > tiem make -j96 / 1G memcg, 4K pages, 10G ZRAM:
>> > After: (-54.7% sys time, -49.3% real time)
>> > Sys time: 33314.76, Real time: 437.67
>> >
>> > time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, on Intel 8255C * 2:
>> > (avg of 4 test run)
>> > Before:
>> > Sys time: 74044.85, Real time: 846.51
>> > hugepages-64kB/stats/swpout: 1735216
>> > hugepages-64kB/stats/swpout_fallback: 430333
>> > After: (-51.4% sys time, -47.7% real time, -63.2% mTHP failure)
>> > Sys time: 35958.87, Real time: 442.69
>> > hugepages-64kB/stats/swpout: 1866267
>> > hugepages-64kB/stats/swpout_fallback: 158330
>> >
>> > There is a up to 54.7% improvement for build kernel test, and lower
>> > fragmentation rate. Performance improvement should be even larger for
>> > micro benchmarks
>>
>> Very good result!
>>
>> > Build kernel with tinyconfig on tmpfs with HDD as swap:
>> > ---
>> >
>> > This test is similar to above, but HDD test is very noisy and slow, the
>> > deviation is huge, so just use tinyconfig instead and take the median =
test
>> > result of 3 test run, which looks OK:
>> >
>> > Before this series:
>> > 114.44user 29.11system 39:42.90elapsed 6%CPU
>> > 2901232inputs+0outputs (238877major+4227640minor)pagefaults
>> >
>> > After this commit:
>> > 113.90user 23.81system 38:11.77elapsed 6%CPU
>> > 2548728inputs+0outputs (235471major+4238110minor)pagefaults
>> >
>> > Single thread SWAP:
>> > ---
>> >
>> > Sequential SWAP should also be slightly faster as we removed a lot of
>> > unnecessary parts. Test using micro benchmark for swapout/in 4G
>> > zero memory using ZRAM, 10 test runs:
>> >
>> > Swapout Before (avg. 3359304):
>> > 3353796 3358551 3371305 3356043 3367524 3355303 3355924 3354513 3360776
>> >
>> > Swapin Before (avg. 1928698):
>> > 1920283 1927183 1934105 1921373 1926562 1938261 1927726 1928636 1934155
>> >
>> > Swapout After (avg. 3347511, -0.4%):
>> > 3337863 3347948 3355235 3339081 3333134 3353006 3354917 3346055 3360359
>> >
>> > Swapin After (avg. 1922290, -0.3%):
>> > 1919101 1925743 1916810 1917007 1923930 1935152 1917403 1923549 1921913
>> >
>> > Worth noticing the patch "mm, swap: use a global swap cluster for
>> > non-rotation device" introduced minor overhead for certain tests (see
>> > the test results in commit message), but the gain from later commit
>> > covered that, it can be further improved later.
>> >
>> > Suggested-by: Chris Li <chrisl@kernel.org>
>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> >
>> > Kairui Song (13):
>> >   mm, swap: minor clean up for swap entry allocation
>> >   mm, swap: fold swap_info_get_cont in the only caller
>> >   mm, swap: remove old allocation path for HDD
>> >   mm, swap: use cluster lock for HDD
>> >   mm, swap: clean up device availability check
>> >   mm, swap: clean up plist removal and adding
>> >   mm, swap: hold a reference of si during scan and clean up flags
>> >   mm, swap: use an enum to define all cluster flags and wrap flags
>> >     changes
>> >   mm, swap: reduce contention on device lock
>> >   mm, swap: simplify percpu cluster updating
>> >   mm, swap: introduce a helper for retrieving cluster from offset
>> >   mm, swap: use a global swap cluster for non-rotation device
>> >   mm, swap_slots: remove slot cache for freeing path
>> >
>> >  fs/btrfs/inode.c           |    1 -
>> >  fs/iomap/swapfile.c        |    1 -
>> >  include/linux/swap.h       |   36 +-
>> >  include/linux/swap_slots.h |    3 -
>> >  mm/page_io.c               |    1 -
>> >  mm/swap_slots.c            |   78 +--
>> >  mm/swapfile.c              | 1198 ++++++++++++++++--------------------
>> >  7 files changed, 558 insertions(+), 760 deletions(-)

--
Best Regards,
Huang, Ying

