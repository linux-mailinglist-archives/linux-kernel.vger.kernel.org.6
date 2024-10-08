Return-Path: <linux-kernel+bounces-354439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC2993D78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D9B1C22F38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6E376E0;
	Tue,  8 Oct 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5UkOivJ"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38522309
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357979; cv=none; b=Se2W+yil/YfB/7g6iuBrw3WQsz/VSPBFj1bWYs4TY9UKSUyzAqqCb8vAs2/vbzHMycGOSzS3rUnBu/SkllW6Avp/6IkkWswRnJONCINs7Ggj2Ts4E4c0UEjPwxHaywSGV+nyTZxwzINlm8zdJfXcv6s3Ud5SX19bOfFw7mrq8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357979; c=relaxed/simple;
	bh=B99PAWjk55sSUvvJ/bC1nCEO/qwqgUSZmTR7VE1Hb/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXVQI530joaJGYr/bLRn3a0uSmrg1uLs2ObY6ADrSy3kcXMEfrMX1xl5oBZeXvuBqojNc6QNKfjfYbddB6QAvDAMBIOwdyroR+EVnAboIvT/DBP3xEgMcBUtj7p6J4DjupcleAOYtyTzRFQ35X6hCPh/R4VGR0HtcVdGmibHLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5UkOivJ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84f98af14a0so252263241.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728357977; x=1728962777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HDlG+1eeGeo94ncM1ZKqkTVSW7EyMktJC8U74CrEpA=;
        b=Q5UkOivJTpndhHBf/04mF0HY37ZXtMSnU9rQloxibCL4mnoqBR565/xtgk8wxk8TmC
         gBbdywHKB42ieeYKWj5m+INi/5/Cr+EiR1a1sizwccpkVTWHklrq/Slh3fXQc/A3io3X
         YHjzPOhdeZtcTQINKa2oMtiuLAPflNR2K0wLUrXPYE5lqBxzVav9SQCtUgyIT+p5tiWb
         bf/iPPnyqVjPRqmRwDEW1Sd/LKw2pt+NjsQCvCw/cm9CRtJBwlKKK+aaaZLSfnvFR9cs
         Ps3sWv25LANs7sW8zsH6nC9Uq5qD8+RUfEW/SJ2i9vj3WZQP35G2gQD1/ZViv/vgWZNc
         iW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728357977; x=1728962777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HDlG+1eeGeo94ncM1ZKqkTVSW7EyMktJC8U74CrEpA=;
        b=MQ2vyIIcHMuWPVLmg7vO26tZ72UOV/G1DSkpmbf20zVtbN8itIi9/GWHCYwLx6BWRT
         g1U7aQ33ddmaMqDo/wsmx+Q6NDkvYt144B+a/UwdLyFhrcVmfi+x8GcXKIHhgerD/iYF
         s7FxDnMbL49XujtyWu2oNCQkB1Mbacqw0+Q1ZkfRLmnwO1URM2SJ57MDo6zjt2Xuf24r
         X8XRxhI8so8NfiLiozA8nBIS+PIf/IqMbXh35rPjcGCMMlMkr0xm/ono3HFVjc9LhRRi
         CDRhJzHOvA8gG/Z3DNJZjfnn0WHR1a4Cd9GZS9mkUoMOd5l1u8oxleFALyxR8X7Jper5
         0HpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNXVU83SLbmiaAink3X5UZU5dvz4nssErn/JVsQXARKrLWNlgQEOKpIBxXHh5dLp1YcgW3BK2CmrWmWE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/QJY0pnuWxRQ3u15DzVxMqkFSXFXOD1VqdL1RaPuxAZ8gKdW
	M6DMiF1P5w3911ov3vfy25hSj5HfS9SQT1vKd3XR2N/2nLqdZLNxUjDPvukuM/L/+HU06Ghe4iv
	DJ4D25emvdnGF3odDKis85aIjl1fS6Z+GB8DhWHEAALTXONiu2A==
X-Google-Smtp-Source: AGHT+IFrQeWlGciUKI4LkiokTwx2pF8Y0QELtAkw2r9IwTwujVDCZGfSLzk69uUV7Xgwe9usSB7jb2M25NuLCEa4BfM=
X-Received: by 2002:a05:6102:1620:b0:4a3:dbe3:a2d9 with SMTP id
 ada2fe7eead31-4a40576402fmr12321905137.9.1728357976510; Mon, 07 Oct 2024
 20:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Mon, 7 Oct 2024 20:26:03 -0700
Message-ID: <CAAPL-u8+qtxbfQ6XL511wjtTNj89HszDC7S-0BQmA=4kAZMR7Q@mail.gmail.com>
Subject: Re: [RESEND][PATCH v4] mm/vmscan: wake up flushers conditionally to
 avoid cgroup OOM
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	yuzhao@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 6:57=E2=80=AFPM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Jingxiang Zeng <linuszeng@tencent.com>
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
> ---
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
> @@ -4291,6 +4291,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                        int tier_idx)
>  {
>         bool success;
> +       bool dirty, writeback;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -4336,9 +4337,14 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, struct scan_c
>                 return true;
>         }
>
> +       dirty =3D folio_test_dirty(folio);
> +       writeback =3D folio_test_writeback(folio);
> +       if (type =3D=3D LRU_GEN_FILE && dirty && !writeback)
> +               sc->nr.unqueued_dirty +=3D delta;
> +

This sounds good.  BTW, when shrink_folio_list() in evict_folios()
returns, we should add stat.nr_unqueued_dirty to sc->nr.unqueued_dirty
there as well.

>         /* waiting for writeback */
> -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +       if (folio_test_locked(folio) || writeback ||
> +           (type =3D=3D LRU_GEN_FILE && dirty)) {
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4454,7 +4460,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_B=
ATCH,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_A=
NON);
> -
> +       sc->nr.taken +=3D scanned;

I think we should only include file pages (in sort_folio) and isolated
pages into sc->nr.taken, instead of all scanned pages. For example, if
there are only unevictable and unqueued dirty pages, we would still
like to wake up the flusher threads, but because nr.taken counts
unevictable pages as well, the wakeup condition in
try_to_shrink_lruvec() won't be met.

>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -4796,6 +4802,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc)
>                 cond_resched();
>         }
>
> +       /*
> +        * If too many file cache in the coldest generation can't be evic=
ted
> +        * due to being dirty, wake up the flusher.
> +        */
> +       if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty =3D=3D sc->nr.=
taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +

try_to_shrink_lruvec() can be called from shrink_node() for global
reclaim as well. We need to reset sc->nr before calling
lru_gen_shrink_node() there. MGLRU didn't need that because it didn't
use sc->nr until this change.

>         /* whether this lruvec should be rotated */
>         return nr_to_scan < 0;
>  }
> --
> 2.43.5
>

