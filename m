Return-Path: <linux-kernel+bounces-378636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC89AD377
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95E41C221F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77521D0E2B;
	Wed, 23 Oct 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/aNM97z"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B61D0B82
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706523; cv=none; b=RXyvWfKpUAgMhG9qBi0bTjwcDGi9WASEXh0TSnmsGShGuATY59W81jzeJNnWlq71eJ6C5jshOSX+5Ltfab1+ip8uZD81SAVRk7i8PHq197ZaeOKNm+77FQgfLtMfKuFLn6TOeM/ksUqqdUD8V7uBWljIyEPl/K7T49uJ5nsp3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706523; c=relaxed/simple;
	bh=HLT9rZXvMCgHtKJsaF2yeV0mr5oHicEoinwIRaF/prc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUHzKCYgUqpX6V0e/iyC6wJgU3EX45UEjX1mxJhofh+deSP4x5gNxuRlO+hXmWbE5jyyTsMJZkyxG27wquWaScEWGf+hMQ+gakBdLFcWA3NHg2Z/sDs4rbSRMteREytOjp26Qg5teCp5XDz9NjW5IaOAlig02WtE9saoTzzGf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/aNM97z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so124031fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729706519; x=1730311319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U47sIJ9PHOb1fSCIYp40rfDTAjFWh2bSBSPJP79iQSQ=;
        b=K/aNM97zo/fdkHxEIBWTGv7jTiqwXdwQH0VciGYNVIzqdhOwckOLXoiBmPdvophd3Z
         JUpQhLCXcAyz1TRgR31G/ZVZYvqx/n32dMFcvLX+DzKGpbgZNSqjxSgzX5lOTp6qGtuh
         3RQFy3vZgZGbj8LUdVjAqCJb9bCjUpbOEhCIi9ABLycTpmZ8KzZWH66tH/4aaPmbxtcS
         jXMamDDpTLM2DKx+k4BE0MRwgzbJNAvtR2Le9EBWMzVNxRPm3Hpit7ZTyPbNNsAuhykm
         YDSPu3QlW8oLjnXQo92ZOhmX1jRtcSa4EgKEqow00EJ7TRm297mKe1TkdJb8PxzJ640w
         sDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706519; x=1730311319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U47sIJ9PHOb1fSCIYp40rfDTAjFWh2bSBSPJP79iQSQ=;
        b=UxOYuzJJ+tfZ3LpiG44cdyvq3UOVoRUtXac2/Ydvz9y+B06Uxo0U7IXRxBdiK6kVNR
         lS2DcxDJ4eXtY8Zl4qagUJv5P0loGqhE+IYnvI3iIbheGjzvKlmMXPUqQZs+7pAQB4NJ
         v0YZYmUSIKZV2Xqz7EUzKLGDS2n0bYUwGaJ4LZQItv88/Wdu61XIpo6IRkdpu1rE2hk9
         XiHG7Pl1EErGJ3SSEL7wRBnTJ6BvZJIYrVi1D9zlG8MTPG7liOJ4NhbNhzCsknP+h9I+
         aobGj6yu1ouXdg8UG8WYgyXRMKr5REK2UEACR3rQf83qrsseb2G65g6HFcQBmCk8j4gp
         OoAA==
X-Forwarded-Encrypted: i=1; AJvYcCXI5hL07zphJxxWo2emNXHUvW7VF8Wy3tK20nfqvAARTSI54KjHcxJdtERS3MnR4g6oL4tfgiHaI9lwzck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3U7U669FSnM+G7fBmMayKU3t33clTvE6nbUIKPT1Ux6XepxVK
	ElPWHx6T26eLhUl+H5TRf/fkPyNi999l67TLbjJxLbMO4W4yz9I/L7/quRaFR8AmRue7RKXfEdb
	hecrhQpHP+DzSt2w3mpUrnDUykTE=
X-Google-Smtp-Source: AGHT+IFh2MtCepMyUY1ii2y6lXwrBWWRW9Yh7AheSJv6uBC1mYmL/wETrS3gtuTKrt8fqflDZ5seez/kLs76aNKITic=
X-Received: by 2002:a05:651c:507:b0:2fa:d3a5:189c with SMTP id
 38308e7fff4ca-2fc9d5958c9mr17922811fa.36.1729706519282; Wed, 23 Oct 2024
 11:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022192451.38138-1-ryncsn@gmail.com> <87ed474kvx.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ed474kvx.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 24 Oct 2024 02:01:43 +0800
Message-ID: <CAMgjq7BfO=dNYep4z1aS7nUAJU3bktR17gYAufx=kkLudq4dAQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:27=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Hi, Kairui,

Hi Ying,

>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > This series improved the swap allocator performance greatly by reworkin=
g
> > the locking design and simplify a lot of code path.
> >
> > This is follow up of previous swap cluster allocator series:
> > https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9=
297@kernel.org/
> >
> > And this series is based on an follow up fix of the swap cluster
> > allocator:
> > https://lore.kernel.org/linux-mm/20241022175512.10398-1-ryncsn@gmail.co=
m/
> >
> > This is part of the new swap allocator work item discussed in
> > Chris's "Swap Abstraction" discussion at LSF/MM 2024, and
> > "mTHP and swap allocator" discussion at LPC 2024.
> >
> > Previous series introduced a fully cluster based allocation algorithm,
> > this series completely get rid of the old allocation path and makes the
> > allocator avoid grabbing the si->lock unless needed. This bring huge
> > performance gain and get rid of slot cache on freeing path.
>
> Great!
>
> > Currently, swap locking is mainly composed of two locks, cluster lock
> > (ci->lock) and device lock (si->lock). The device lock is widely used
> > to protect many things, causing it to be the main bottleneck for SWAP.
>
> Device lock can be confusing with another device lock for struct device.
> Better to call it swap device lock?

Good idea, I'll use the term swap device lock then.

>
> > Cluster lock is much more fine-grained, so it will be best to use
> > ci->lock instead of si->lock as much as possible.
> >
> > `perf lock` indicates this issue clearly. Doing linux kernel build
> > using tmpfs and ZRAM with limited memory (make -j64 with 1G memcg and 4=
k
> > pages), result of "perf lock contention -ab sleep 3":
> >
> >   contended   total wait     max wait     avg wait         type   calle=
r
> >
> >      34948     53.63 s       7.11 ms      1.53 ms     spinlock   free_s=
wap_and_cache_nr+0x350
> >      16569     40.05 s       6.45 ms      2.42 ms     spinlock   get_sw=
ap_pages+0x231
> >      11191     28.41 s       7.03 ms      2.54 ms     spinlock   swapca=
che_free_entries+0x59
> >       4147     22.78 s     122.66 ms      5.49 ms     spinlock   page_v=
ma_mapped_walk+0x6f3
> >       4595      7.17 s       6.79 ms      1.56 ms     spinlock   swapca=
che_free_entries+0x59
> >     406027      2.74 s       2.59 ms      6.74 us     spinlock   list_l=
ru_add+0x39
> >   ...snip...
> >
> > The top 5 caller are all users of si->lock, total wait time up sums to
> > several minutes in the 3 seconds time window.
>
> Can you show results of `perf record -g`, `perf report -g` too?  I have
> interest to check hot spot shifting too.

Sure. I think `perf lock` result is already good enough and cleaner.
My test environment are mostly VM based so spinlock slow path may get
offloaded to host, and can't be see by perf record, I collected
following data after disabled paravirt spinlock:

The time consumption and stack trace of a page fault before:
-   78.45%     0.17%  cc1              [kernel.kallsyms]
                [k] asm_exc_page_fault
   - 78.28% asm_exc_page_fault
      - 78.18% exc_page_fault
         - 78.17% do_user_addr_fault
            - 78.09% handle_mm_fault
               - 78.06% __handle_mm_fault
                  - 69.69% do_swap_page
                     - 55.87% alloc_swap_folio
                        - 55.60% mem_cgroup_swapin_charge_folio
                           - 55.48% charge_memcg
                              - 55.45% try_charge_memcg
                                 - 55.36% try_to_free_mem_cgroup_pages
                                    - do_try_to_free_pages
                                       - 55.35% shrink_node
                                          - 55.27% shrink_lruvec
                                             - 55.13% try_to_shrink_lruvec
                                                - 54.79% evict_folios
                                                   - 54.35% shrink_folio_li=
st
                                                      - 30.01% add_to_swap
                                                         - 29.77%
folio_alloc_swap
                                                            - 29.50%
get_swap_pages

25.03% queued_spin_lock_slowpath
                                                               - 2.71%
alloc_swap_scan_cluster

1.80% queued_spin_lock_slowpath
                                                                  +
0.89% __try_to_reclaim_swap
                                                               - 1.74%
swap_reclaim_full_clusters

1.74% queued_spin_lock_slowpath
                                                      - 10.88%
try_to_unmap_flush_dirty
                                                         - 10.87%
arch_tlbbatch_flush
                                                            - 10.85%
on_each_cpu_cond_mask

smp_call_function_many_cond
                                                      + 7.45% pageout
                                                      + 2.71% try_to_unmap_=
flush
                                                      + 1.90% try_to_unmap
                                                      + 0.78% folio_referen=
ced
                     - 9.41% cluster_swap_free_nr
                        - 9.39% free_swap_slot
                           - 9.35% swapcache_free_entries
                                8.40% queued_spin_lock_slowpath
                                0.93% swap_entry_range_free
                     - 3.61% swap_read_folio_bdev_sync
                        - 3.55% submit_bio_wait
                           - 3.51% submit_bio_noacct_nocheck
                              + 3.46% __submit_bio
                  + 7.71% do_pte_missing
                  + 0.61% wp_page_copy

The queued_spin_lock_slowpath above is the si->lock, and there are
multiple users of it so the total overhead is higher than shown.

After:
-   75.05%     0.43%  cc1              [kernel.kallsyms]
                [k] asm_exc_page_fault
   - 74.62% asm_exc_page_fault
      - 74.36% exc_page_fault
         - 74.34% do_user_addr_fault
            - 74.10% handle_mm_fault
               - 73.96% __handle_mm_fault
                  - 67.55% do_swap_page
                     - 45.92% alloc_swap_folio
                        - 45.03% mem_cgroup_swapin_charge_folio
                           - 44.58% charge_memcg
                              - 44.44% try_charge_memcg
                                 - 44.12% try_to_free_mem_cgroup_pages
                                    - do_try_to_free_pages
                                       - 44.10% shrink_node
                                          - 43.86% shrink_lruvec
                                             - 41.92% try_to_shrink_lruvec
                                                - 40.67% evict_folios
                                                   - 37.12% shrink_folio_li=
st
                                                      - 20.88% pageout
                                                         + 20.02% swap_writ=
epage
                                                         + 0.72% shmem_writ=
epage
                                                      - 4.08% add_to_swap
                                                         - 2.48%
folio_alloc_swap
                                                            - 2.12%
__mem_cgroup_try_charge_swap
                                                               - 1.47%
swap_cgroup_record
                                                                  +
1.32% _raw_spin_lock_irqsave
                                                         - 1.56%
add_to_swap_cache
                                                            - 1.04% xas_sto=
re
                                                               + 1.01%
workingset_update_node
                                                      + 3.97%
try_to_unmap_flush_dirty
                                                      + 3.51% folio_referen=
ced
                                                      + 2.24% __remove_mapp=
ing
                                                      + 1.16% try_to_unmap
                                                      + 0.52% try_to_unmap_=
flush
                                                     2.50%
queued_spin_lock_slowpath
                                                     0.79% scan_folios
                                                + 1.20% try_to_inc_max_seq
                                             + 1.92% lru_add_drain
                        + 0.73% vma_alloc_folio_noprof
                     - 9.81% swap_read_folio_bdev_sync
                        - 9.61% submit_bio_wait
                           + 9.49% submit_bio_noacct_nocheck
                     - 8.06% cluster_swap_free_nr
                        - 8.02% swap_entry_range_free
                           + 3.92% __mem_cgroup_uncharge_swap
                           + 2.90% zram_slot_free_notify
                             0.58% clear_shadow_from_swap_cache
                     - 1.32% __folio_batch_add_and_move
                        - 1.30% folio_batch_move_lru
                           + 1.10% folio_lruvec_lock_irqsave

spin_lock usage is much lower.

I prefer the perf lock output as it shows the exact time and user of locks.

>
> > Following the new allocator design, many operation doesn't need to touc=
h
> > si->lock at all. We only need to take si->lock when doing operations
> > across multiple clusters (eg. changing the cluster list), other
> > operations only need to take ci->lock. So ideally allocator should
> > always take ci->lock first, then, if needed, take si->lock. But due
> > to historical reasons, ci->lock is used inside si->lock by design,
> > causing lock inversion if we simply try to acquire si->lock after
> > acquiring ci->lock.
> >
> > This series audited all si->lock usage, simplify legacy codes, eliminat=
e
> > usage of si->lock as much as possible by introducing new designs based
> > on the new cluster allocator.
> >
> > Old HDD allocation codes are removed, cluster allocator is adapted
> > with small changes for HDD usage, test is looking OK.
>
> I think that it's a good idea to remove HDD allocation specific code.
> Can you check the performance of swapping to HDD?  However, I understand
> that many people have no HDD in hand.

It's not hard to make cluster allocator work well with HDD in theory,
see the commit "mm, swap: use a global swap cluster for non-rotation
device".
The testing is not very reliable though, I found HDD swap performance
is very unstable because of the IO pattern of HDD, so it's just a best
effort try.

> > And this also removed slot cache for freeing path. The performance is
> > better without it, and this enables other clean up and optimizations
> > as discussed before:
> > https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW=
_59W1BWw@mail.gmail.com/
> >
> > After this series, lock contention on si->lock is nearly unobservable
> > with `perf lock` with the same test above :
> >
> >   contended   total wait     max wait     avg wait         type   calle=
r
> >   ... snip ...
> >          91    204.62 us      4.51 us      2.25 us     spinlock   clust=
er_move+0x2e
> >   ... snip ...
> >          47    125.62 us      4.47 us      2.67 us     spinlock   clust=
er_move+0x2e
> >   ... snip ...
> >          23     63.15 us      3.95 us      2.74 us     spinlock   clust=
er_move+0x2e
> >   ... snip ...
> >          17     41.26 us      4.58 us      2.43 us     spinlock   clust=
er_isolate_lock+0x1d
> >   ... snip ...
> >
> > cluster_move and cluster_isolate_lock are basically the only users
> > of si->lock now, performance gain is huge with reduced LOC.
> >
> > Tests
> > =3D=3D=3D
> >
> > Build kernel with defconfig on tmpfs with ZRAM as swap:
> > ---
> >
> > Running a test matrix which is scaled up progressive for a intuitive re=
sult.
> > The test are ran on top of tmpfs, using memory cgroup for memory limita=
tion,
> > on a 48c96t system.
> >
> > 12 test run for each case, it can be seen clearly that as concurrent jo=
b
> > number goes higher the performance gain is higher, the performance is
> > higher even with low concurrency.
> >
> >    make -j<NR>     |   System Time (seconds)  |   Total Time (seconds)
> >  (NR / Mem / ZRAM) | (Before / After / Delta) | (Before / After / Delta=
)
> >  With 4k pages only:
> >   6 / 192M / 3G    |    5258 /  5235 / -0.3%  |    1420 /  1414 / -0.3%
> >  12 / 256M / 4G    |    5518 /  5337 / -3.3%  |     758 /   742 / -2.1%
> >  24 / 384M / 5G    |    7091 /  5766 / -18.7% |     476 /   422 / -11.3=
%
> >  48 / 768M / 7G    |   11139 /  5831 / -47.7% |     330 /   221 / -33.0=
%
> >  96 / 1.5G / 10G   |   21303 / 11353 / -46.7% |     283 /   180 / -36.4=
%
> >  With 64k mTHP:
> >  24 / 512M / 5G    |    5104 /  4641 / -18.7% |     376 /   358 / -4.8%
> >  48 /   1G / 7G    |    8693 /  4662 / -18.7% |     257 /   176 / -31.5=
%
> >  96 /   2G / 10G   |   17056 / 10263 / -39.8% |     234 /   169 / -27.8=
%
>
> How much is the swap in/out throughput before/after the change?

This may not be too beneficial for typical throughput measurement:
- For example doing the same test with brd will only show a ~20%
performance improvement, still a big gain though. I think the si->lock
spinlock wasting CPU cycles may effect CPU sensitive things like ZRAM
even more.
- And simple benchmarks which just do multiple sequential swaps in/out
in multiple thread hardly stress the allocator. I haven't found a good
benchmark to simulate random parallel IOs on SWAP yet, I can write one
later.

A more close to real word benchmark like build kernel test, or
mysql/sysbench all showed great improment.

>
> When I worked on swap in/out performance before, the hot spot shifts from
> swap related code to LRU lock and zone lock.  Things may change a lot
> now.
>
> If zram is used as swap device, the hot spot may become
> compression/decompression after solving the swap lock contention.  To
> stress swap subsystem further, we may use a ram disk as swap.
> Previously, we have used a simulated pmem device (backed by DRAM).  That
> can be setup as in,
>
> https://pmem.io/blog/2016/02/how-to-emulate-persistent-memory/
>
> After creating the raw block device: /dev/pmem0, we can do
>
> $ mkswap /dev/pmem0
> $ swapon /dev/pmem0
>
> Can you use something similar if necessary?

I used to test with brd, as described above, I think using ZRAM with
test simulating real workload is more useful.
And I did include a Sequential SWAP test, the result is looking OK (no
regression, minor to none improvement).

I can  have a try with the pmem setup later, I guess the result will
be similar to brd test.


>
> > With more aggressive setup, it shows clearly both the performance and
> > fragmentation are better:
> >
> > tiem make -j96 / 768M memcg, 4K pages, 10G ZRAM, on Intel 8255C * 2:
> > (avg of 4 test run)
> > Before:
> > Sys time: 73578.30, Real time: 864.05
> > tiem make -j96 / 1G memcg, 4K pages, 10G ZRAM:
> > After: (-54.7% sys time, -49.3% real time)
> > Sys time: 33314.76, Real time: 437.67
> >
> > time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, on Intel 8255C * 2:
> > (avg of 4 test run)
> > Before:
> > Sys time: 74044.85, Real time: 846.51
> > hugepages-64kB/stats/swpout: 1735216
> > hugepages-64kB/stats/swpout_fallback: 430333
> > After: (-51.4% sys time, -47.7% real time, -63.2% mTHP failure)
> > Sys time: 35958.87, Real time: 442.69
> > hugepages-64kB/stats/swpout: 1866267
> > hugepages-64kB/stats/swpout_fallback: 158330
> >
> > There is a up to 54.7% improvement for build kernel test, and lower
> > fragmentation rate. Performance improvement should be even larger for
> > micro benchmarks
>
> Very good result!
>
> > Build kernel with tinyconfig on tmpfs with HDD as swap:
> > ---
> >
> > This test is similar to above, but HDD test is very noisy and slow, the
> > deviation is huge, so just use tinyconfig instead and take the median t=
est
> > result of 3 test run, which looks OK:
> >
> > Before this series:
> > 114.44user 29.11system 39:42.90elapsed 6%CPU
> > 2901232inputs+0outputs (238877major+4227640minor)pagefaults
> >
> > After this commit:
> > 113.90user 23.81system 38:11.77elapsed 6%CPU
> > 2548728inputs+0outputs (235471major+4238110minor)pagefaults
> >
> > Single thread SWAP:
> > ---
> >
> > Sequential SWAP should also be slightly faster as we removed a lot of
> > unnecessary parts. Test using micro benchmark for swapout/in 4G
> > zero memory using ZRAM, 10 test runs:
> >
> > Swapout Before (avg. 3359304):
> > 3353796 3358551 3371305 3356043 3367524 3355303 3355924 3354513 3360776
> >
> > Swapin Before (avg. 1928698):
> > 1920283 1927183 1934105 1921373 1926562 1938261 1927726 1928636 1934155
> >
> > Swapout After (avg. 3347511, -0.4%):
> > 3337863 3347948 3355235 3339081 3333134 3353006 3354917 3346055 3360359
> >
> > Swapin After (avg. 1922290, -0.3%):
> > 1919101 1925743 1916810 1917007 1923930 1935152 1917403 1923549 1921913
> >
> > Worth noticing the patch "mm, swap: use a global swap cluster for
> > non-rotation device" introduced minor overhead for certain tests (see
> > the test results in commit message), but the gain from later commit
> > covered that, it can be further improved later.
> >
> > Suggested-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >
> > Kairui Song (13):
> >   mm, swap: minor clean up for swap entry allocation
> >   mm, swap: fold swap_info_get_cont in the only caller
> >   mm, swap: remove old allocation path for HDD
> >   mm, swap: use cluster lock for HDD
> >   mm, swap: clean up device availability check
> >   mm, swap: clean up plist removal and adding
> >   mm, swap: hold a reference of si during scan and clean up flags
> >   mm, swap: use an enum to define all cluster flags and wrap flags
> >     changes
> >   mm, swap: reduce contention on device lock
> >   mm, swap: simplify percpu cluster updating
> >   mm, swap: introduce a helper for retrieving cluster from offset
> >   mm, swap: use a global swap cluster for non-rotation device
> >   mm, swap_slots: remove slot cache for freeing path
> >
> >  fs/btrfs/inode.c           |    1 -
> >  fs/iomap/swapfile.c        |    1 -
> >  include/linux/swap.h       |   36 +-
> >  include/linux/swap_slots.h |    3 -
> >  mm/page_io.c               |    1 -
> >  mm/swap_slots.c            |   78 +--
> >  mm/swapfile.c              | 1198 ++++++++++++++++--------------------
> >  7 files changed, 558 insertions(+), 760 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

