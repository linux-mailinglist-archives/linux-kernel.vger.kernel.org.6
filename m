Return-Path: <linux-kernel+bounces-337902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B69850D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05D41F24937
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96E13D62F;
	Wed, 25 Sep 2024 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbcMxeSf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135622907
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727230065; cv=none; b=DhNcKHy0iwE7g/hmlPKkVSbvbacTvfcsUp+Ldx8GN0BLrAopUX4hdY4d6LwB9406RhylbiWAghqweAgcQtCXkRpzCzvbmk5SquxCnWG1/Eg5ZHqmVNBFdsw6naGMDPJBbGmoLsRMBHIr29rZUUIw2EenzSyej0R9G3lLlajfBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727230065; c=relaxed/simple;
	bh=lj18Z52aMzSH/9GoeTIElboBBspmzY9xOQ06C8At3nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tG5B+XyZOD9br2awDTIA9MlSwX9ir1uWajg+NZm6RUuygP+eAto/7wfMVd12WvurpRafxRgZm1/7kuMaVuiz+vQP9WqSzYdjsV7ZKIr/LLw3HhxIGTE3MRMfSxdL1E9iXWLNlsi7911waSAvewV9QMPCaQvTfuWxO0DfSMXjfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbcMxeSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90824C4CED0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727230064;
	bh=lj18Z52aMzSH/9GoeTIElboBBspmzY9xOQ06C8At3nM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IbcMxeSfKmNJ/zrFLzoQm29LqZjw6LIsg5lf9PFL9OEylXECGwcOYelJLdYGwph9l
	 gfmlC3JC09rPY7bs0w1n/h1EOsBTUd2Ri4Xvt0Edj/YejFAoqX/uo0hU834sZAN4T4
	 h/QJ/X8SmN4D7bk3QjlNf/y/mLwDkQV2pGWbnDX9zZMHJDcmchUURUFpf5scQLoACR
	 dc04APNACn2+paDRV95kYQ7TkUlYV1DQaln06Icv1PqynWykeSRwW4RC3VuX9yBDW+
	 Q39VrL9d51m6J3fMm7aJaxa2x+/+jTEYjOMidq476KMfeebo6fzVVzG/cai977CTYG
	 bF58R9r3YDQRw==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso148565ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:07:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXf36jPYJXAql5+74kbOb50emGDoE23bQS3L+nhWv2alb0fyX+QX5cuJ0OT7GLFZrKlpCCd4oXlxZi5FdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGBh4MOivK8iUnX4irmBIyfHD8g0NtrrRsQiqysDf7p4a8IaZ
	8ErT88rG4oIb3VERutd17rKkAl3mKaPtx95ps5zwYwnUqi00FbNWKNV4f+1smWSlKruaSEJ6btN
	LLD2NBVFA/ivD3IUtY5aBh0+jdy1uo9o0Wdp4
X-Google-Smtp-Source: AGHT+IGsAX6Dq4L+moisbEyMVPV/W0EQ4y6e1Oow+CD0nOMsIqdX6U/6Zg9c+iFwJC1p60P3SXBZalQa9YHsgAi9Ggo=
X-Received: by 2002:a05:6e02:1ca6:b0:39d:1b64:3551 with SMTP id
 e9e14a558f8ab-3a2703b9a04mr929545ab.19.1727230063538; Tue, 24 Sep 2024
 19:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240924121358.30685-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240924121358.30685-1-jingxiangzeng.cas@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 19:07:30 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM2UobJEkrssR2KSLAwOF6fZmjRHANkXfjmdk+hM5+PWA@mail.gmail.com>
Message-ID: <CAF8kJuM2UobJEkrssR2KSLAwOF6fZmjRHANkXfjmdk+hM5+PWA@mail.gmail.com>
Subject: Re: [PATCH V3] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	weixugc@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jingxiang,

I just tested your v3 patch, apply on top of
d675c821b65f0c496df1d33150619b7635827e89("mm-memcontrol-add-per-memcg-pgpgi=
n-pswpin-counter-v2")
with 684826f8271ad97580b138b9ffd462005e470b99(""zram: free secondary
algorithms names") reverted.

Without your v3 patch it can pass the swap stress test in less than 5 mins.
With your V3 patch it is running over 30 minutes and still can't complete.
It does not produce kernel panic though, just extremely slow at the
linking phase.

Here is the top shows:
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
COMMAND
  33895 ...    20   0    8872   1780   1780 R  99.3   0.0  33:18.70 as
  34115 ...    20   0   10568   4692   2964 R   1.0   0.0   0:00.97
top

V3 also has regression on my swap stress test.

Chris

On Tue, Sep 24, 2024 at 5:14=E2=80=AFAM Jingxiang Zeng
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
> Link: https://lkml.kernel.org/r/20240829102543.189453-1-jingxiangzeng.cas=
@gmail.com
> Link: https://lkml.kernel.org/r/20240913084506.3606292-1-jingxiangzeng.ca=
s@gmail.com
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
> Changes from v2:
> - Acquire the lock before calling the folio_check_dirty_writeback
>   function.
> - Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-jingxi=
angzeng.cas@gmail.com/
> Changes from v1:
> - Add code to count the number of unqueued_dirty in the sort_folio
>   function.
> - Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jingxia=
ngzeng.cas@gmail.com/
> ---
>  mm/vmscan.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..12c285a96353 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4290,6 +4290,8 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         int delta =3D folio_nr_pages(folio);
>         int refs =3D folio_lru_refs(folio);
>         int tier =3D lru_tier_from_refs(refs);
> +       bool dirty =3D folio_test_dirty(folio);
> +       bool writeback =3D folio_test_writeback(folio);
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>
>         VM_WARN_ON_ONCE_FOLIO(gen >=3D MAX_NR_GENS, folio);
> @@ -4330,8 +4332,10 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, struct scan_c
>         }
>
>         /* waiting for writeback */
> -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +       if (folio_test_locked(folio) || dirty ||
> +           (type =3D=3D LRU_GEN_FILE && writeback)) {
> +               if (type =3D=3D LRU_GEN_FILE && dirty && !writeback)
> +                       sc->nr.unqueued_dirty +=3D delta;
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4448,6 +4452,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_A=
NON);
>
> +       sc->nr.taken +=3D isolated;
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -4920,6 +4925,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *l=
ruvec, struct scan_control *sc
>         if (try_to_shrink_lruvec(lruvec, sc))
>                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
>
> +       /*
> +        * If too many pages in the coldest generation that cannot
> +        * be isolated, wake up flusher.
> +        */
> +       if (sc->nr.unqueued_dirty > sc->nr.taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>         clear_mm_walk();
>
>         blk_finish_plug(&plug);
> --
> 2.43.5
>
>

