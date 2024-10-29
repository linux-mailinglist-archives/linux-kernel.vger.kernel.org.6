Return-Path: <linux-kernel+bounces-386106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC239B3F31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D78F283642
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC5B664;
	Tue, 29 Oct 2024 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdp7pN4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06A14A85
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161864; cv=none; b=peN3jOLcsMFEHX9nxBAMaLc5VC2EImujCmR9jr9mS6rHy8fMLAEJxGFp8Bikjcb32Jp9uSbLNY4vpS8YBNWHAVtCrjd/s5BEnvyBjIqbZgAm8PqHwEby0NJwANAL0ZE0GkVX0CcxuhT2MpFcXrmyzGxatS+AVUk5NBGzJYkpM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161864; c=relaxed/simple;
	bh=dzTOr2HjdJHYnogYZZG9pALJwWB0FAVEi1wLiO1akW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnmHXXLq0LaU+GFFtE7N6v9Zl/P9vqPDYIOh9y0VHetC3td3bZOuFrewsfjt4McOZ54XN/o8RKrnq2Dn6sMXmvgc3QfIkfZTC4VUaeiOq8hjW7/+R5YCMhl3l8VlPQzFIxrbnCVQWN+32S0XxIYB33zwU0jNBysHPNrHO7S+qNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdp7pN4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F82C4CEC3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730161863;
	bh=dzTOr2HjdJHYnogYZZG9pALJwWB0FAVEi1wLiO1akW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xdp7pN4z+NNmYMl+iRLNbBLjAySqoxWNHVYD4N9JXj72kuWhwyimNJEQSvRGxm9JQ
	 Sc9U+JUiWeOUA/7m5D5/vFyjiaoEWu4gYhnMDqB1Kj+uNzGealuAkEZVYcWa8gpL6W
	 2nNfze075Z7IF88iQawiM8YcOjlmS5MFRgeIGbUpNmYTIvgLg50KkmmJuygqXHtm+O
	 cKzqq02PVQkazHgGCJk7GNB8gBcKP+B12hEziFgW8gBijy91kPuSAtnv+S3x69bOfb
	 Ha5nakZq0TPazm+33ChOTz/o1xgXra+uLhL6kZytpJz7UqX2NeRuftiSWftcr4DgMF
	 7yKr8TYbm8eKg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e35fb3792eso46037177b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:31:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEXmUEczH3pT8pwySCpiyFgWhkr9KGQjJ3Sa407Qu9+tg73+l7nWmP1vAg5HMx27iDLsDigfDGKnq0AfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHi6MJrvrUV13iBGlRVjnzeSo7YXmcWsNcOxJrpbC71vc8CAy
	VB7SX4RuN/Mh04OsyzFniuB8B2yWb89j73IZJV8Wv2o8z8QTX1s4xBjkr6vqbP3ka9r6LZXyNll
	B2GwIEfbXusBY7fE6BP6cVY9ora3GlQxHhvodeg==
X-Google-Smtp-Source: AGHT+IH6kqP8Xi2efM+dZgZorRJuE0iCzEGYc+sE1HNITBIs/zNmmqSEqhBbDim5y+ywnlUCeezD11YPCvHAgen6eDk=
X-Received: by 2002:a05:690c:2e82:b0:6e5:ac5f:9c43 with SMTP id
 00721157ae682-6e9d8b5ae33mr73445127b3.39.1730161862750; Mon, 28 Oct 2024
 17:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026115714.1437435-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20241026115714.1437435-1-jingxiangzeng.cas@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Oct 2024 17:30:51 -0700
X-Gmail-Original-Message-ID: <CACePvbX3TtFqdK1DxSkd-we6dGDtyfwc7g7kToWiNngZSZ0xOA@mail.gmail.com>
Message-ID: <CACePvbX3TtFqdK1DxSkd-we6dGDtyfwc7g7kToWiNngZSZ0xOA@mail.gmail.com>
Subject: Re: [PATCH v6] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, tjmercier@google.com, weixugc@google.com, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jingxiang,



On Sat, Oct 26, 2024 at 4:57=E2=80=AFAM Jingxiang Zeng
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
> I did run the build kernel test[1] on V6, with -j16 1G memcg on my local
> branch:
>
> Without the patch(10 times):
> user 1449.394
> system 368.78 372.58 363.03 362.31 360.84 372.70 368.72 364.94 373.51
> 366.58 (avg 367.399)
> real 164.883
>
> With the V6 patch(10 times):
> user 1447.525
> system 360.87 360.63 372.39 364.09 368.49 365.15 359.93 362.04 359.72
> 354.60 (avg 362.79)
> real 164.514
>
> Test results show that this patch has about 1% performance improvement,
> which should be caused by noise.

I make another test run on your V6 with mm-unstable b5d43fad926a just
to add more data point:

With your V6:
user    2764.801
system  6297.883 : 6227.46 6238.48 6254.14 6281.08 6304.32 6307.43
6326.12 6331.02 6346.66 6362.12
real    289.961

Without (mm-unstable b5d43fad926a)
user    2777.293
system  6177.172 : 6022.84 6128.81 6142.93 6172.24 6174.08 6186.1
6194.72 6206.77 6266.87 6276.36
real    286.514

The system time is still a tiny little bit slower. But my swap
pressure might be much higher. In my test it spend much more time in
system rather than user space. So my stress level might not be
typical. Good news your V6 does not have crashes.

Tested-by: Chris Li <chrisl@kernel.org>

Chris

>
> ---
> Changes from v5:
> - Make wake-up conditions stricter. [Wei Xu, Jingxiang Zeng]
> - Use sc->nr.file_taken to count. [Wei Xu, Jingxiang Zeng]
> - Link to v5: https://lore.kernel.org/all/20241018052942.3810740-1-jingxi=
angzeng.cas@gmail.com/
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
> Suggested-by: Wei Xu <weixugc@google.com>
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 084de0efe59b..794730c8c1de 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4282,6 +4282,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                        int tier_idx)
>  {
>         bool success;
> +       bool dirty, writeback;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -4327,9 +4328,17 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, struct scan_c
>                 return true;
>         }
>
> +       dirty =3D folio_test_dirty(folio);
> +       writeback =3D folio_test_writeback(folio);
> +       if (type =3D=3D LRU_GEN_FILE && dirty) {
> +               sc->nr.file_taken +=3D delta;
> +               if (!writeback)
> +                       sc->nr.unqueued_dirty +=3D delta;
> +       }
> +
>         /* waiting for writeback */
> -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +       if (folio_test_locked(folio) || writeback ||
> +           (type =3D=3D LRU_GEN_FILE && dirty)) {
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4445,7 +4454,8 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_B=
ATCH,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_A=
NON);
> -
> +       if (type =3D=3D LRU_GEN_FILE)
> +               sc->nr.file_taken +=3D isolated;
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -4579,6 +4589,7 @@ static int evict_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int swap
>                 return scanned;
>  retry:
>         reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
> +       sc->nr.unqueued_dirty +=3D stat.nr_unqueued_dirty;
>         sc->nr_reclaimed +=3D reclaimed;
>         trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
>                         scanned, reclaimed, &stat, sc->priority,
> @@ -4787,6 +4798,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lr=
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
file_taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>         /* whether this lruvec should be rotated */
>         return nr_to_scan < 0;
>  }
> @@ -5932,6 +5950,7 @@ static void shrink_node(pg_data_t *pgdat, struct sc=
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

