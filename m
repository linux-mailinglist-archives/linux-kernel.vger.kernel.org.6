Return-Path: <linux-kernel+bounces-378633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149999AD373
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D11F1C220EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B378B1D0E3E;
	Wed, 23 Oct 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMNxFyPn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309F611E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706421; cv=none; b=PDR1QK27xDSEYAgqel2oavGobNKc8wR0oKOGNL8aw2uUhfw2KmyTbLWf9FGqY13bl9pqEGvSl7UE3MOANtHodS732ctyyIfzfsTJWpEcMSeZdUXlzcyACZ+alqmxnn5wc+EzB7UhQo+1EpjVBfHL00jqe/k4h2h4GziAXA7khKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706421; c=relaxed/simple;
	bh=YMW2hzblLHeUhTFRV+wf8tXYK7WvvuHRAxQLZjhmg3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz6jhK67lmMXBeQrc2YiqASMxt81hCD+g7Op69X7cS1BBanlwj8oSXY1W3VMJnQeDUCKEMV6Z2tC3v0pVTxFjqMTV6Xpcr9fIGiOr4xxZ91sXKFK8r9lVa3oDpeYsxYi+DhsBnx6TCzFK4vqt1CKFMP/7QXTEGPD9LDrC8uhZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMNxFyPn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so59950a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729706418; x=1730311218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DYhn4x8Me8OJHGj5By/ME0wn8XuXxdZ40UKAsVjcFg=;
        b=MMNxFyPnF9AzgCFog5WwdIly+t9QGuRx0mtbMXiLRs6JPLbQcUsXcQ6dphus00EQj8
         WP0Vdy9WmYb4KKY9e6kd3W+nI41qMbxI4gW7+Ab1CM4VwyojE0vZ7hfS5HiREZ6KMaGm
         UEfu6TlpPqLiCvE3OqD9VmxEP978aUyGyybOHCbpAvTB6BHUtx/tT3/+NQbTNknKR9qk
         Hk29M2PbyzfZAOU1zCYqyr66PXyTHGFAx0KPuv1zUkap1HsBy5AmcdSpUObncs2wRilO
         t3ymTVoU8jOreItiBLWaw7V1sTBWicK3MVUVFdBkK7vuTZD8aGMQ5EStwI40/H8WzH3+
         nejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706418; x=1730311218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DYhn4x8Me8OJHGj5By/ME0wn8XuXxdZ40UKAsVjcFg=;
        b=BsRoaNYHoPlNJD2uD53gXaGJIkQEnYudjOJN8WFy25BOOXm7gAETZy8m5dNg1+OLh9
         Kp/+lOM+tTBmIVqsyJNPqm3bCgRQLYXML0wffVJ7slEmwpSTt8ugUiJQM1Tz1+nUgVVU
         aH6uKSAzjYDp6W5S7cQuRXxyVaG7q3wrDU/gMDL3kv3hDjvFpNZJU343L4XgokhT8d6s
         QdTdFoJF4XIHSZ2CEaK+MTw0x6ralyBAW2DkrfxJ0K4rQi3PqtwDw9nQ7SRNLIvDIsm5
         1GwWEoZUx9rTriDlBMNjHyJE1RO9XW4LDJqdwbdgot/2ZeznDcepT2xd1/v6h+NemobB
         yztA==
X-Forwarded-Encrypted: i=1; AJvYcCWoWkkxKAw9VaF/yMJxtlE5xp18wd5QEItNAGIbaH2XuxtPqLsGjPXi9lez20NokC8GlqyszUdk49PR92A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCC7GARiB+LwUBkrY9YArWLRiTJbUZsh7+CpmT/gSyifIgT8zN
	+325v5Mggv/3gIDLE4ySB1kQ/8VSeaYtR0+rX/snQqt4ZEmw/uFZOLA+FfANHEBcpiOaAaa/E1s
	m9qneQ6Kkd5qyBo/xbco7m7k8rs/7YIFZJ7GZ
X-Google-Smtp-Source: AGHT+IGaLyHIW1SBSQr07QnlmHDgDH7KFlEsBiXGiokHDAV0pbeIspcJEqdgIwi6nk79dQpahzFAFOFeJPx904w46p4=
X-Received: by 2002:a17:907:7ea0:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-a9abf92f2cbmr306662166b.51.1729706417924; Wed, 23 Oct 2024
 11:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022192451.38138-1-ryncsn@gmail.com>
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 23 Oct 2024 10:59:42 -0700
Message-ID: <CAJD7tkYzcxNbZLRL4DezWC27RqdEcfqr0Eafr2h0bUbacuRSjw@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> This series improved the swap allocator performance greatly by reworking
> the locking design and simplify a lot of code path.
>
> This is follow up of previous swap cluster allocator series:
> https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b929=
7@kernel.org/
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
>
> Currently, swap locking is mainly composed of two locks, cluster lock
> (ci->lock) and device lock (si->lock). The device lock is widely used
> to protect many things, causing it to be the main bottleneck for SWAP.
>
> Cluster lock is much more fine-grained, so it will be best to use
> ci->lock instead of si->lock as much as possible.
>
> `perf lock` indicates this issue clearly. Doing linux kernel build
> using tmpfs and ZRAM with limited memory (make -j64 with 1G memcg and 4k
> pages), result of "perf lock contention -ab sleep 3":
>
>   contended   total wait     max wait     avg wait         type   caller
>
>      34948     53.63 s       7.11 ms      1.53 ms     spinlock   free_swa=
p_and_cache_nr+0x350
>      16569     40.05 s       6.45 ms      2.42 ms     spinlock   get_swap=
_pages+0x231
>      11191     28.41 s       7.03 ms      2.54 ms     spinlock   swapcach=
e_free_entries+0x59
>       4147     22.78 s     122.66 ms      5.49 ms     spinlock   page_vma=
_mapped_walk+0x6f3
>       4595      7.17 s       6.79 ms      1.56 ms     spinlock   swapcach=
e_free_entries+0x59
>     406027      2.74 s       2.59 ms      6.74 us     spinlock   list_lru=
_add+0x39
>   ...snip...
>
> The top 5 caller are all users of si->lock, total wait time up sums to
> several minutes in the 3 seconds time window.
>
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
>
> And this also removed slot cache for freeing path. The performance is
> better without it, and this enables other clean up and optimizations
> as discussed before:
> https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_5=
9W1BWw@mail.gmail.com/
>
> After this series, lock contention on si->lock is nearly unobservable
> with `perf lock` with the same test above :
>
>   contended   total wait     max wait     avg wait         type   caller
>   ... snip ...
>          91    204.62 us      4.51 us      2.25 us     spinlock   cluster=
_move+0x2e
>   ... snip ...
>          47    125.62 us      4.47 us      2.67 us     spinlock   cluster=
_move+0x2e
>   ... snip ...
>          23     63.15 us      3.95 us      2.74 us     spinlock   cluster=
_move+0x2e
>   ... snip ...
>          17     41.26 us      4.58 us      2.43 us     spinlock   cluster=
_isolate_lock+0x1d
>   ... snip ...
>
> cluster_move and cluster_isolate_lock are basically the only users
> of si->lock now, performance gain is huge with reduced LOC.
>
> Tests
> =3D=3D=3D
>
> Build kernel with defconfig on tmpfs with ZRAM as swap:
> ---
>
> Running a test matrix which is scaled up progressive for a intuitive resu=
lt.
> The test are ran on top of tmpfs, using memory cgroup for memory limitati=
on,
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
>
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
>
> Build kernel with tinyconfig on tmpfs with HDD as swap:
> ---
>
> This test is similar to above, but HDD test is very noisy and slow, the
> deviation is huge, so just use tinyconfig instead and take the median tes=
t
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

Unfortunately I don't have the time to go through this series, but I
just wanted to say that this awesome work, Kairui.

Selfishly, I especially like cleaning up the swap slot freeing path,
and having a centralized freeing path with a single call to
zswap_invalidate().

Thanks for doing this :)

