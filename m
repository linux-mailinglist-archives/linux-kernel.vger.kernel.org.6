Return-Path: <linux-kernel+bounces-371039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF3C9A3585
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2C283A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47517C9F1;
	Fri, 18 Oct 2024 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj9jphrH"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0020E30E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233390; cv=none; b=oU809RGiXNEbcAx2o1ZUfXgeEnpJl6CXdSISqrjCCLNgNDXyXq3V7sxDjGY+lFTL/WrxX02WkUvbWUdBcximtUHRMX6PURNwYkW8Fn1eaAKN81St6IkqN27SEI8uXEQm1rLOUnZOr1LohI0no+ysdhIr1OZld/HHswD1eyfke4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233390; c=relaxed/simple;
	bh=UeUnAs+3ioFiHB8SIXWvnig+2Xyx5MlRXh7pmT4XU/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty+xVMqLA1X31TaaamLM/wqJs9lgnG0APB1AMjUqsY6/UfUaE14H/LvB2j14Ndp4GGYOD2fPfnxbRyI/R4pJjIdgmjg7EHarVt+FqkgHvSjFA7XiV70rjbspRkMW/wd7FAPpYO1cYETLXwhyYD+ruCUSAF5SyzUDwjWnEF7FFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sj9jphrH; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a46edda7d1so487192137.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729233386; x=1729838186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuj6DrKD+KQlPUUa5XDfdvYRoNewekiOugMVqppje00=;
        b=sj9jphrHhI4ZSJHiZ3JJmCHJBMAGaGJv+vqz1BFUJJl6H23PagCe1OBaGncixMi8/P
         RI+EkvsaoSkn14oYflPPl/FyfBUt4+ujxgQ1CpQ+5jASqLIsZwAMg7JXMl9BZWRh5O6x
         NU6L8O8cPvTpxr7i9Ur1+WS28CYMwdGPt6aQe+HbCEKLJgBzIGDqJxHlWamGSMA5oMh8
         le1NyyXH6idmkqqCW07wJ7soWjqCLdWyYFgb2+bpu25UfGBVv7sPJ8s1RlKWkrsg7BM7
         yFAj3+JEQq2Ddrrpgkzxu/tbC8UJGKpoiv9VYdUVRSxdZD9oe+71OFCPNW6gszMuiFo7
         mKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233386; x=1729838186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuj6DrKD+KQlPUUa5XDfdvYRoNewekiOugMVqppje00=;
        b=ls0JqJqLJCVGXvFbOTcKNsmcAw2vXfR4E/RJwnRRHlkdvhdaVmeV5fBDEGxYSsKNp6
         Ukfqt55uSwnln+Q0wOEvNpaTI7lxKl/xHQMXlIjOrN8gZxb+eTUSS5JOkDxKcKNN/HVV
         bB1eqySZ4cgsEsI5QhQMHzCqq1qDzUnUEFVM4639LaNr9R9K4bZd3ms6Pdm4dLOSPavd
         vBjjLl1KCe0B7zq9M5DYsy0go9iAdJGoQiPph4OmvkHvt/ioc53CGjrlOvjVhcuQSOFa
         vExRbOO3jy2/IIrmXxYFPdu2isrBj+ThcuKpMLa8C3V3dBz2Ka/R11Z52R0P6Od2jRG8
         5EMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0jWF8NcnYmSDF52KMBvFLZHhTzeVuPJWYXWzDiK1wgNcSpGmeKdDSrYaOwB9R9hczPZEO0qL1KjBMvrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlL4TbCgu1GFAB5QijxEl8auevOr/BIpo64HB/Hc0kgFuY2/EQ
	nhSw3oe1OMDNBw0f9KwIsT6qm4+i+TTibARIRPUGMJhDzOEl8/ArhBXgNLxST5fyG5ktAfRiUnP
	8rlZd9eRiflvrf2YtVn50qXrnm8WPGZO7PEqB
X-Google-Smtp-Source: AGHT+IExxspQDuhUEfgc6CF2fwU9MDFGQ0bF5R+eqSuQR8+AUByAOWu1vdoqmj7CGFhlab3vRBlTEipkrF0PAmzdEys=
X-Received: by 2002:a05:6102:32c7:b0:4a3:a137:b9b with SMTP id
 ada2fe7eead31-4a5d6ad1b8cmr1627995137.11.1729233386336; Thu, 17 Oct 2024
 23:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20241018052942.3810740-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20241018052942.3810740-1-jingxiangzeng.cas@gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Thu, 17 Oct 2024 23:36:13 -0700
Message-ID: <CAAPL-u_e=HxAXQPpvTzXSdv_3kLR-95S1CnFB9vk09nnOBYa_Q@mail.gmail.com>
Subject: Re: [PATCH v5] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	yuzhao@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:29=E2=80=AFPM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering OOM
> when encountering many dirty pages during reclamation on MGLRU.
>
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed
>
> dd invoked oom-killer: gfp_mask=3D0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRI=
TE),
> order=3D0, oom_score_adj=3D0
>
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5f/0x80
>   dump_stack+0x14/0x20
>   dump_header+0x46/0x1b0
>   oom_kill_process+0x104/0x220
>   out_of_memory+0x112/0x5a0
>   mem_cgroup_out_of_memory+0x13b/0x150
>   try_charge_memcg+0x44f/0x5c0
>   charge_memcg+0x34/0x50
>   __mem_cgroup_charge+0x31/0x90
>   filemap_add_folio+0x4b/0xf0
>   __filemap_get_folio+0x1a4/0x5b0
>   ? srso_return_thunk+0x5/0x5f
>   ? __block_commit_write+0x82/0xb0
>   ext4_da_write_begin+0xe5/0x270
>   generic_perform_write+0x134/0x2b0
>   ext4_buffered_write_iter+0x57/0xd0
>   ext4_file_write_iter+0x76/0x7d0
>   ? selinux_file_permission+0x119/0x150
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   vfs_write+0x30c/0x440
>   ksys_write+0x65/0xe0
>   __x64_sys_write+0x1e/0x30
>   x64_sys_call+0x11c2/0x1d50
>   do_syscall_64+0x47/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>  memory: usage 308224kB, limit 308224kB, failcnt 2589
>  swap: usage 0kB, limit 9007199254740988kB, failcnt 0
>
>   ...
>   file_dirty 303247360
>   file_writeback 0
>   ...
>
> oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3Dtest,
> mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test,task=3Ddd,pid=3D440=
4,uid=3D0
> Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
> anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> oom_score_adj:0
>
> The flusher wake up was removed to decrease SSD wearing, but if we are
> seeing all dirty folios at the tail of an LRU, not waking up the flusher
> could lead to thrashing easily.  So wake it up when a mem cgroups is abou=
t
> to OOM due to dirty caches.
>
> I did run the build kernel test[1] on V5, with -j16 1G memcg on my local
> branch:
>
> Without the patch(10 times):
> user 1473.29
> system 347.87 339.17 345.28 354.64 352.46 355.63 358.80 359.40 358.28
> 350.95 (avg 352.248)
> real 166.651
>
> With the V5 patch(10 times):
> user 1470.7
> system 339.13 350.58 350.07 355.58 348.96 344.83 351.78 336.39 350.45
> 343.31 (avg 347.108)
> real 165.821
>
> Test results show that this patch has about 1% performance improvement,
> which should be caused by noise.
>
> ---
> Changes from v4:
> - Add the number of unqueued dirty pages in the shrink_folio_list functio=
n
>   to sc->nr.unqueued_dirty. [Wei Xu, Jingxiang Zeng]
> - Reset sc->nr before calling lru_gen_shrink_node function.
>   [Wei Xu, Jingxiang Zeng]
> - Modified the conditions for waking up the flusher thread to avoid
>   interference from unevictable and anonymous pages.
>   [Wei Xu, Jingxiang Zeng]
> - Link to v4: https://lore.kernel.org/all/20240929113050.76079-1-jingxian=
gzeng.cas@gmail.com/
> Changes from v3:
> - Avoid taking lock and reduce overhead on folio isolation by
>   checking the right flags and rework wake up condition, fixing the
>   performance regression reported by Chris Li.
>   [Chris Li, Kairui Song]
> - Move the wake up check to try_to_shrink_lruvec to cover kswapd
>   case as well, and update comments. [Kairui Song]
> - Link to v3: https://lore.kernel.org/all/20240924121358.30685-1-jingxian=
gzeng.cas@gmail.com/
> Changes from v2:
> - Acquire the lock before calling the folio_check_dirty_writeback
>   function. [Wei Xu, Jingxiang Zeng]
> - Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-jingxi=
angzeng.cas@gmail.com/
> Changes from v1:
> - Add code to count the number of unqueued_dirty in the sort_folio
>   function. [Wei Xu, Jingxiang Zeng]
> - Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jingxia=
ngzeng.cas@gmail.com/
> ---
>
> Link: https://lore.kernel.org/all/CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=
=3Dpb_w51kucLKQ@mail.gmail.com/ [1]
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2d0486189804..97e0af338ee0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4292,6 +4292,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                        int tier_idx)
>  {
>         bool success;
> +       bool dirty, writeback;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -4337,9 +4338,14 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, struct scan_c
>                 return true;
>         }
>
> +       dirty =3D folio_test_dirty(folio);
> +       writeback =3D folio_test_writeback(folio);
> +       if (type =3D=3D LRU_GEN_FILE && dirty && !writeback)
> +               sc->nr.unqueued_dirty +=3D delta;
> +
>         /* waiting for writeback */
> -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +       if (folio_test_locked(folio) || writeback ||
> +           (type =3D=3D LRU_GEN_FILE && dirty)) {
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4455,7 +4461,8 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_B=
ATCH,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_A=
NON);
> -
> +       if (type =3D=3D LRU_GEN_FILE)
> +               sc->nr.taken +=3D isolated;
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -4589,6 +4596,7 @@ static int evict_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int swap
>                 return scanned;
>  retry:
>         reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
> +       sc->nr.unqueued_dirty +=3D stat.nr_unqueued_dirty;
>         sc->nr_reclaimed +=3D reclaimed;
>         trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
>                         scanned, reclaimed, &stat, sc->priority,
> @@ -4797,6 +4805,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc)
>                 cond_resched();
>         }
>
> +       /*
> +        * If too many file cache in the coldest generation can't be evic=
ted
> +        * due to being dirty, wake up the flusher.
> +        */
> +       if (sc->nr.unqueued_dirty && !sc->nr.taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);

This wakeup condition is too relaxed: We can wake up the the flusher
even when there are only one unqueued dirty page and many clean file
pages.

I'd suggest that we add dirty file pages to sc->nr.taken in
sort_folio() as well, in addition to isolated file pages in
scan_folios(). Then we can change the wakeup condition to be:

    if (sc->nr.taken && sc->nr.unqueued_dirty =3D=3D sc->nr.taken)

Also, given that only file pages are counted here, it would be better
to add sc->nr.file_taken as the new counter and use it in this patch
for more clarity.

> +
>         /* whether this lruvec should be rotated */
>         return nr_to_scan < 0;
>  }
> @@ -5942,6 +5957,7 @@ static void shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>         bool reclaimable =3D false;
>
>         if (lru_gen_enabled() && root_reclaim(sc)) {
> +               memset(&sc->nr, 0, sizeof(sc->nr));
>                 lru_gen_shrink_node(pgdat, sc);
>                 return;
>         }
> --
> 2.43.5
>

