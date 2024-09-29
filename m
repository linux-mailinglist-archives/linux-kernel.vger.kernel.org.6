Return-Path: <linux-kernel+bounces-342964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13964989534
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F402832C2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136715B995;
	Sun, 29 Sep 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE0b9mSs"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900A1386B4
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727610482; cv=none; b=Xs2E3GBZV2HzHGZ7fNr5fv2yrHUM59WD/LzyJGJ5HD7bNFCv9HKIYepdvsKEIMcYGiX5Uudjs4h7768p8FRnnP47815CZP/Z+B1jgivKgCHC4ik7UY/Ps6r5jXK9Vu8TR3C/gTDMK/euWx/ZTDzh5RugBcKfXcO3OJKaKNgAzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727610482; c=relaxed/simple;
	bh=fVu5hm0T3XtCcK/SO//R6RhYykHJtbhz0Hy5v8ZAjUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/K6FAOUhUphVl2+6HQQqbO+IpMGh5STcph9AGa2kpmHE4mekESm2xS32+PVzGDvVYfjSDq9rFcVKYvrrmukRzULNPXWoUupvOtVp3Qmm1C4QfiFYowuS/KnQWS1FGMdh/NDDNt1tdf8Z2iN2nUECmI6ky1RFSLXdX4eoCcf2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE0b9mSs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so2730787a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727610480; x=1728215280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8mo8HeEngP/BFulB3FSGKzlYrx1zjrrJXGv+TyyKuAM=;
        b=JE0b9mSsQzAeZLwZ8eGdZN3ROosxcs97JeZ/rvpLSpjNpInbOSqJ6/cFc/S4dHiBcJ
         C0DTY6qL8+dSEIr876qt04pKZEZAXqxy7gcoALkhAAQDxeqal3YBZF8xYmcpqjPzY+Ho
         qzBmkprd2KdGak0mTswhpZk4/hSUBgM9/TBOPPhaGbxkvpHrAFhyFL6FKiWWcfDL/1CI
         n3jlRDN6+/NuZIdISpx2pB6ZPBYnm3VJ5iPDeo5Do8u90vJ+Y6tLn5d2QN8DVR24irt2
         JFzlCI27ul737nGsH4WGwqzqErGg4ePtekvzPzR4wkwpxhc6nk2MrAIBJTr/i57REdVK
         49jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727610480; x=1728215280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mo8HeEngP/BFulB3FSGKzlYrx1zjrrJXGv+TyyKuAM=;
        b=RvzZzXRKhTgNf5/Q1+vcTqcYh5jfCAaOb0nstgn0Tuq8UBTaKDuDeXHHZAVSb88z8Z
         wHqLEF1usYy0gX6q9JiNJi6xHoEPUA7Aclvn4/tqxmXMy/fFloCuWpQlIVdsbcP+noXr
         TiUfzrup/aOP5UYlNR5feh57awC7Fwcr76kzlGPu7AkqJdN5BON80yo5wMA7BMIXABBS
         sZrWtLNxkJhnRxV6sqm0kIt8bBmwQ4LVaMBbWAPtncjMgcYJc/URObI90NvcKqljRS1m
         q+q2wzWtuDGclPnjmSLW5mNTsmbFaWxJyTYTdKgv4KvD/6/TsSJI3zRUVN/Q+phbZGr8
         vhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+omhNY5aMkreq3kvv8pxQlGEQAIXPXZIkddju0lesfgRZ8lPsSK4gITqnVE6UHLTzjA3T9EfO9wVnCw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERSpDo/JUp3wYfXZ5So5Ccu+0wNASt09KWTzLBT7nu7bl+8fG
	HkLaViwaDH93n11QTdbifedtPLjaw3xJLOmr6zEsMn47I7jR79Kwfh73qUUd+SXJ1OcKGH3pSsS
	5Fiyce6jZMRf7qFek4gZ0kas0rSFznKPKbNo=
X-Google-Smtp-Source: AGHT+IEQeDJXMe3/6U2GCh4qZ/zAkvXxZfOf3WSEPFILc7G+7Q1zU+k7I6b8yx+bCwU/SW02Ftf8DKVe0wkLa9pqXDQ=
X-Received: by 2002:a17:90a:7302:b0:2da:61e1:1597 with SMTP id
 98e67ed59e1d1-2e0b8ec8e99mr10620993a91.36.1727610479911; Sun, 29 Sep 2024
 04:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240929112642.68087-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240929112642.68087-1-jingxiangzeng.cas@gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Sun, 29 Sep 2024 19:47:48 +0800
Message-ID: <CAJqJ8ii=hzWEOVHN7ZcpzHvDF8o7njekJSpsvRfOfPrJcrHL9w@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v4] mm/vmscan: wake up flushers conditionally to
 avoid cgroup OOM
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, kasong@tencent.com, linuszeng@tencent.com, 
	linux-kernel@vger.kernel.org, tjmercier@google.com, weixugc@google.com, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 19:26, Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>

There are some formatting issues with the title of this patch, please refer to
the latest updated patch:
https://lore.kernel.org/all/20240929113050.76079-1-jingxiangzeng.cas@gmail.com/
>
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering OOM
> when encountering many dirty pages during reclamation on MGLRU.
>
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed
>
> dd invoked oom-killer: gfp_mask=0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRITE),
> order=0, oom_score_adj=0
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
> oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=test,
> mems_allowed=0,oom_memcg=/test,task_memcg=/test,task=dd,pid=4404,uid=0
> Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
> anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> oom_score_adj:0
>
> The flusher wake up was removed to decrease SSD wearing, but if we are
> seeing all dirty folios at the tail of an LRU, not waking up the flusher
> could lead to thrashing easily.  So wake it up when a mem cgroups is about
> to OOM due to dirty caches.
>
> ---
> Changes from v3:
> - Avoid taking lock and reduce overhead on folio isolation by
>   checking the right flags and rework wake up condition, fixing the
>   performance regression reported by Chris Li.
>   [Chris Li, Kairui Song]
> - Move the wake up check to try_to_shrink_lruvec to cover kswapd
>   case as well, and update comments. [Kairui Song]
> - Link to v3: https://lore.kernel.org/all/20240924121358.30685-1-jingxiangzeng.cas@gmail.com/
> Changes from v2:
> - Acquire the lock before calling the folio_check_dirty_writeback
>   function. [Wei Xu, Jingxiang Zeng]
> - Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-jingxiangzeng.cas@gmail.com/
> Changes from v1:
> - Add code to count the number of unqueued_dirty in the sort_folio
>   function. [Wei Xu, Jingxiang Zeng]
> - Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jingxiangzeng.cas@gmail.com/
> ---
>
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index dc7a285b256b..2a5c2fe81467 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4291,6 +4291,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
>                        int tier_idx)
>  {
>         bool success;
> +       bool dirty, writeback;
>         int gen = folio_lru_gen(folio);
>         int type = folio_is_file_lru(folio);
>         int zone = folio_zonenum(folio);
> @@ -4336,9 +4337,14 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
>                 return true;
>         }
>
> +       dirty = folio_test_dirty(folio);
> +       writeback = folio_test_writeback(folio);
> +       if (type == LRU_GEN_FILE && dirty && !writeback)
> +               sc->nr.unqueued_dirty += delta;
> +
>         /* waiting for writeback */
> -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -           (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> +       if (folio_test_locked(folio) || writeback ||
> +           (type == LRU_GEN_FILE && dirty)) {
>                 gen = folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4454,7 +4460,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> -
> +       sc->nr.taken += scanned;
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check the
>          * remaining to prevent livelock if it's not making progress.
> @@ -4796,6 +4802,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>                 cond_resched();
>         }
>
> +       /*
> +        * If too many file cache in the coldest generation can't be evicted
> +        * due to being dirty, wake up the flusher.
> +        */
> +       if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>         /* whether this lruvec should be rotated */
>         return nr_to_scan < 0;
>  }
> --
> 2.43.5
>

