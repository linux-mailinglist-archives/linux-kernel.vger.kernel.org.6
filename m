Return-Path: <linux-kernel+bounces-199726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6BB8D8C32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D435028C47C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B5113C3C0;
	Mon,  3 Jun 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSBCI2SW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFA2746B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449542; cv=none; b=FZIMITNjcVm73qWM2ur0/kFZ+0Cu4tWx52Kq5tgIQ6yGSjHot9WUKE5CF3OS/h8PSquiUeqz8LtaI9AFuS9yI4ueJo2SCTIpyUJqiRtyQMUfDgkhTSNso8bgYtdFlLShuA+BBHHLJf5y3cbss2ueBOr0vNlvyUyswsU5kdlvSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449542; c=relaxed/simple;
	bh=nSHXRjl+TrceKlGF2z9GdWM9y0O8jtReY9JJDcDx3D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2m+fWngM0upqRQV6YFr9veOZcAjYZX2Kzc5603jI2gwhmKfofYJCLLcrJa9RGb2XwDcAwG+svsrCpACUEjBvdKKRG/ENUDeVueoVx8gKM72oJZyCInqrKKSh2bSeA4TlVOTMH+menwtWbMqITXjfTu7s5eZA4Q1DkVE0LYLrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSBCI2SW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a52dfd081so2045735a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717449539; x=1718054339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVrbBmRHGcvk3HRKRL9q8xpV11gQOI4yc6uZd/VdwtI=;
        b=xSBCI2SWUPXELFESVi9+oPVJjiIrbls/FlgUfIaT4NSXXrJT4QOsSK8NtOIw9O2i9+
         wxvCaiQaOUl6OAFrlevxuu0wYPtX4a7uYggrx98obkxmzPrzuFadDQWGeJ0BUdLjwdp4
         pa0SNl3UzQn0URwfa6lroHKoBdFOvYBjDnoBw9IbIcYzypfxYxUKI8aa1fvGYQvFojS5
         0afJl9Skm07iGhyCOwaGsM/g+fAlWJyCc2C+b3EI/lSm9zh04svEOnP/+757qot7WiXE
         ppSb60kyXK7Bg7VLs4B8Jld49Jth/Qlfm9U0nlXfBuU6VdTdMBgLgj4CkfICXBlw830S
         svPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717449539; x=1718054339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVrbBmRHGcvk3HRKRL9q8xpV11gQOI4yc6uZd/VdwtI=;
        b=eM2nErukE79fm6YzmzaXZi+RM73zfSIXdTh9bxf7TFYsH02zjKIEkVwTUgXQ7Mr2fI
         a3FiaMlf/jb5bqb3MazFxms8jWOFpf2u9xWlH8AdJT1MSuukrWulqIGMKlJRygdAYG6v
         HiNhlwPKBVUIVYj3HfMp5M0ijZ/BcCoU8GbLxF51jqxKVZ6KJRDcz6daOQ0z/jJjC+3U
         d4tj3uwmuDHQjiFA3zOS6uvcufsMcepAfMMvSH2fE1FQi3QTtCYx34XhzLXJMxeFXbAB
         NxasTpGr/cabwc0WeoNaxykTWAczGOxGhKeitH6tPlR90Q0a6llQK6U3p/pUhBgX/mKz
         V1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX4+bQD16pel30VJcyGSvWjQ1YUt1adCJBcUHHmE4XEbA6G4hPQQuqNvPAyrod+xK0GL7aR7YF+C34b+GCoXj+DUCM+TBuZT44LP2tn
X-Gm-Message-State: AOJu0Yy7lXPRJuDBDwBxqom56CGFBt9ryFs+9waRjDAejsnnbq+ta0gm
	p13cjBsefkGmd5pX4+zgvBMcjm7ObhGSukkBpB/ydIcJ3VPImadY9U7dbLDbVeOvx1k2N2NsxB2
	bsexYpB9hpp338CNFKiZzdT/EWb3f33rVmg5J
X-Google-Smtp-Source: AGHT+IH/yEPXI0M7Xtcm0ZPZnhcTf9/owXFiJF2fVVCdieCSU1q1szG/HYEtuc6mqzhN0uHgQECl//zWoc7b8F/JoC8=
X-Received: by 2002:a17:906:6149:b0:a5c:e2ea:ba59 with SMTP id
 a640c23a62f3a-a681ff463demr629307666b.29.1717449538399; Mon, 03 Jun 2024
 14:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
In-Reply-To: <20240408183946.2991168-1-ryan.roberts@arm.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 3 Jun 2024 14:18:19 -0700
Message-ID: <CAJD7tkYyRCTVwiVeN_AXmzagpAPKKhPg-9UkWk=EWDVYMchvxQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Swap-out mTHP without splitting
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi All,
>
> This series adds support for swapping out multi-size THP (mTHP) without n=
eeding
> to first split the large folio via split_huge_page_to_list_to_order(). It
> closely follows the approach already used to swap-out PMD-sized THP.
>
> There are a couple of reasons for swapping out mTHP without splitting:
>
>   - Performance: It is expensive to split a large folio and under extreme=
 memory
>     pressure some workloads regressed performance when using 64K mTHP vs =
4K
>     small folios because of this extra cost in the swap-out path. This se=
ries
>     not only eliminates the regression but makes it faster to swap out 64=
K mTHP
>     vs 4K small folios.
>
>   - Memory fragmentation avoidance: If we can avoid splitting a large fol=
io
>     memory is less likely to become fragmented, making it easier to re-al=
locate
>     a large folio in future.
>
>   - Performance: Enables a separate series [7] to swap-in whole mTHPs, wh=
ich
>     means we won't lose the TLB-efficiency benefits of mTHP once the memo=
ry has
>     been through a swap cycle.
>
> I've done what I thought was the smallest change possible, and as a resul=
t, this
> approach is only employed when the swap is backed by a non-rotating block=
 device
> (just as PMD-sized THP is supported today). Discussion against the RFC co=
ncluded
> that this is sufficient.
>
>
> Performance Testing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I've run some swap performance tests on Ampere Altra VM (arm64) with 8 CP=
Us. The
> VM is set up with a 35G block ram device as the swap device and the test =
is run
> from inside a memcg limited to 40G memory. I've then run `usemem` from
> vm-scalability with 70 processes, each allocating and writing 1G of memor=
y. I've
> repeated everything 6 times and taken the mean performance improvement re=
lative
> to 4K page baseline:
>
> | alloc size |                baseline |           + this series |
> |            | mm-unstable (~v6.9-rc1) |                         |
> |:-----------|------------------------:|------------------------:|
> | 4K Page    |                    0.0% |                    1.3% |
> | 64K THP    |                  -13.6% |                   46.3% |
> | 2M THP     |                   91.4% |                   89.6% |
>
> So with this change, the 64K swap performance goes from a 14% regression =
to a
> 46% improvement. While 2M shows a small regression I'm confident that thi=
s is
> just noise.
>
> ---
> The series applies against mm-unstable (as of 2024-04-08) after dropping =
v6 of
> this series from it. The performance numbers are from v5. Since the delta=
 is
> very small I don't anticipate any performance changes. I'm optimistically=
 hoping
> this is the final version.
>
>
> Changes since v6 [6]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - patch #1
>     - swap_page_trans_huge_swapped() takes order instead of nr_pages (per=
 Chris)
>   - patch #2
>     - Fix bug in swap_pte_batch() to consider swp pte bits (per David)
>     - Improved docs for clear_not_present_full_ptes() (per David)
>     - Improved docs for free_swap_and_cache_nr() (per David)
>   - patch #5
>     - Split out change to get_swap_pages() interface into own patch (per =
David)
>   - patch #6 (was patch #5)
>     - Improved readability of shrink_folio_list() with longer lines (per =
David)
>
>
> Changes since v5 [5]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - patch #2
>     - Don't bother trying to reclaim swap if none of the entries' refs ha=
ve gone
>       to 0 in free_swap_and_cache_nr() (per Huang, Ying)
>   - patch #5
>     - Only update THP_SWPOUT_FALLBACK counters for pmd-mappable folios (p=
er
>       Barry Song)
>   - patch #6
>     - Fix bug in madvise_cold_or_pageout_pte_range(): don't continue with=
out ptl
>       (reported by Barry [8], sysbot [9])
>
>
> Changes since v4 [4]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - patch #3:
>     - Added R-B from Huang, Ying - thanks!
>   - patch #4:
>     - get_swap_pages() now takes order instead of nr_pages (per Huang, Yi=
ng)
>     - Removed WARN_ON_ONCE() from get_swap_pages()
>     - Reworded comment for scan_swap_map_try_ssd_cluster() (per Huang, Yi=
ng)
>     - Unified VM_WARN_ON()s in scan_swap_map_slots() to scan: (per Huang,=
 Ying)
>     - Removed redundant "order =3D=3D 0" check (per Huang, Ying)
>   - patch #5:
>     - Marked list_empty() check with data_race() (per David)
>     - Added R-B from Barry and David - thanks!
>   - patch #6:
>     - Implemented mkold_ptes() generic helper (pre David)
>     - Enhanced folio_pte_batch() to report any_young (per David)
>     - madvise_cold_or_pageout_pte_range() sets old in batch (per David)
>     - Added R-B from Barry - thanks!
>
>
> Changes since v3 [3]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - Renamed SWAP_NEXT_NULL -> SWAP_NEXT_INVALID (per Huang, Ying)
>  - Simplified max offset calculation (per Huang, Ying)
>  - Reinstated struct percpu_cluster to contain per-cluster, per-order `ne=
xt`
>    offset (per Huang, Ying)
>  - Removed swap_alloc_large() and merged its functionality into
>    scan_swap_map_slots() (per Huang, Ying)
>  - Avoid extra cost of folio ref and lock due to removal of CLUSTER_FLAG_=
HUGE
>    by freeing swap entries in batches (see patch 2) (per DavidH)
>  - vmscan splits folio if its partially mapped (per Barry Song, DavidH)
>  - Avoid splitting in MADV_PAGEOUT path (per Barry Song)
>  - Dropped "mm: swap: Simplify ssd behavior when scanner steals entry" pa=
tch
>    since it's not actually a problem for THP as I first thought.
>
>
> Changes since v2 [2]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
>    allocation. This required some refactoring to make everything work nic=
ely
>    (new patches 2 and 3).
>  - Fix bug where nr_swap_pages would say there are pages available but th=
e
>    scanner would not be able to allocate them because they were reserved =
for the
>    per-cpu allocator. We now allow stealing of order-0 entries from the h=
igh
>    order per-cpu clusters (in addition to exisiting stealing from order-0
>    per-cpu clusters).
>
>
> Changes since v1 [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - patch 1:
>     - Use cluster_set_count() instead of cluster_set_count_flag() in
>       swap_alloc_cluster() since we no longer have any flag to set. I was=
 unable
>       to kill cluster_set_count_flag() as proposed against v1 as other ca=
ll
>       sites depend explicitly setting flags to 0.
>  - patch 2:
>     - Moved large_next[] array into percpu_cluster to make it per-cpu
>       (recommended by Huang, Ying).
>     - large_next[] array is dynamically allocated because PMD_ORDER is no=
t
>       compile-time constant for powerpc (fixes build error).
>
>
> [1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.robert=
s@arm.com/
> [2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.robert=
s@arm.com/
> [3] https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts=
@arm.com/
> [4] https://lore.kernel.org/linux-mm/20240311150058.1122862-1-ryan.robert=
s@arm.com/
> [5] https://lore.kernel.org/linux-mm/20240327144537.4165578-1-ryan.robert=
s@arm.com/
> [6] https://lore.kernel.org/linux-mm/20240403114032.1162100-1-ryan.robert=
s@arm.com/
> [7] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmai=
l.com/
> [8] https://lore.kernel.org/linux-mm/CAGsJ_4yMOow27WDvN2q=3DE4HAtDd2PJ=3D=
OQ5Pj9DG+6FLWwNuXUw@mail.gmail.com/
> [9] https://lore.kernel.org/linux-mm/579d5127-c763-4001-9625-4563a9316ac3=
@redhat.com/
>
> Thanks,
> Ryan
>
> Ryan Roberts (7):
>   mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
>   mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
>   mm: swap: Simplify struct percpu_cluster
>   mm: swap: Update get_swap_pages() to take folio order
>   mm: swap: Allow storage of all mTHP orders
>   mm: vmscan: Avoid split during shrink_folio_list()
>   mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD

+Zi Yan

While looking at the page splitting code, I noticed that
split_huge_page_to_list_to_order() will refuse to split a folio in the
swapcache to any order higher than 0. It has the following check:

if (new_order) {
        /* Only swapping a whole PMD-mapped folio is supported */
        if (folio_test_swapcache(folio))
                return -EINVAL;
        ...
}

I am guessing with this series this may no longer be applicable?

>
>  include/linux/pgtable.h |  59 ++++++++
>  include/linux/swap.h    |  35 +++--
>  mm/huge_memory.c        |   3 -
>  mm/internal.h           |  75 +++++++++-
>  mm/madvise.c            |  99 +++++++-----
>  mm/memory.c             |  17 ++-
>  mm/swap_slots.c         |   6 +-
>  mm/swapfile.c           | 325 +++++++++++++++++++++++-----------------
>  mm/vmscan.c             |  20 +--
>  9 files changed, 422 insertions(+), 217 deletions(-)
>
> --
> 2.25.1
>
>

