Return-Path: <linux-kernel+bounces-355657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3FF995567
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DBC1C234C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1571E1C32;
	Tue,  8 Oct 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0iYt5g0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4481E0DFC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407569; cv=none; b=nsaRlUjoTGpICJ91xEskKeSTZefVJ/hCM2LvZO2+DINh9Qv8lrKIXryjrXCvaEaZaXu3XuJqF+RBP1UuY3FvZ13Wgh+Vup6kjLDIgGFPVClNVm/kdgux3RBHh9na7G+MKGpEnOLaeT2Sagu2W3oDEbCpps5OQf7c/PYdtukBypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407569; c=relaxed/simple;
	bh=pqZeH2kCkOngtWGO1Hbjmr1efIxDjAlmQHz2/esCqmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpLF1DPmOpdBbu307kcntVLVvPpcGVDKawptwRDwtDda1lgwe/ch6cWs5dXvh93/XtIyc+AtU0Zfx71kzQBXXbgvLpPMn91CsRWA8uhz8NLC4tvrD9Tjq6hQgecEdHd6KFY6JGE1ciYV+qbI4rjXvQrrF7CRgGKryiw4sSEBE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0iYt5g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822EAC4CED2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728407568;
	bh=pqZeH2kCkOngtWGO1Hbjmr1efIxDjAlmQHz2/esCqmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I0iYt5g0+wLr9Aw6QnneQFEVW7d0Ci1C14UFnJ/8UVvJ388O5wOuqoS0SN3RTQdEy
	 kDc/2unj85VveJC4+ba9P1hdoDpQg9TbhnHhFFDZC6O3opP+qpa3WwDWJH89PZR/Bo
	 kh2v9jsC+P8HwLAO/mM0rWrm4TArrc/JMfdcesLSVjefB5Kd1EgWrnO34CpFhrZfl+
	 fOHpeoon4+b3EZyU1deHfS3pf5yFLH6c9CFhdYiNB37bqmSi6ACXH5CFP2WetvTT0x
	 CAsy6KQmusakkNBUJOiedM9+XEw1cA9MPTaAdJNsm9cSfsIrPzywD0dJkzWQ1ppUm+
	 WX0CKOnY7Bi/Q==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28a083d531so3547095276.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcBGZS13ny8iFdaHvIP4RjFLp2iHcaSxk+bxiDtDS3bBv5ujXJBvDCnoiFimm5pztXNJHKZL5Dm+DA8gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj06DsrygvKgr4IqEr4hG11RGoWQtNzd23XLkJl/TIoK6afvlH
	TQ3IWMbGUGzauZeSyJJnQSTkUH6uFuKlleG00/Oq+w+Y8PQZ0t9cHNBdIvm8gHDDciI3t1VKgOm
	IV0L7DAAePKVyenjVX/SbDd2cRTHUTYNeMNCSjQ==
X-Google-Smtp-Source: AGHT+IG6dUQ1yR+9kVwhoXU9JxIe7iqrrWw1GHi57Oek2YFEg3/bJ1xmyN18nbxEgvMvicbqYYd5Iz5hO2UrNy+AzZw=
X-Received: by 2002:a05:690c:f88:b0:6e2:3e17:1849 with SMTP id
 00721157ae682-6e2ecb69a8amr81785137b3.2.1728407567707; Tue, 08 Oct 2024
 10:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 8 Oct 2024 10:12:36 -0700
X-Gmail-Original-Message-ID: <CACePvbXGPyPyyGa+EWkfdyU0wa9eHuwvzAVNBrE-tjb6otQ7KQ@mail.gmail.com>
Message-ID: <CACePvbXGPyPyyGa+EWkfdyU0wa9eHuwvzAVNBrE-tjb6otQ7KQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v4] mm/vmscan: wake up flushers conditionally to
 avoid cgroup OOM
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	weixugc@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jingxiang,

I did run the same swap stress test on V4 and it is much better than V3.
V3 test was hang there (time out). V4 did not hang any more, it
finishes in about the same time.

If we look closer of V4, it seems suggest that v4 system time is slightly w=
orse.
Is that kind of expected or might be the noise of my test? Just trying
to understand it better, it is not a NACK by any means.

Here is the number on mm-unstable c121617e3606be6575cdacfdb63cc8d67b46a568:
Without (10 times):
user    2688.328
system  6059.021 : 6031.57 6043.61 6044.35 6045.01 6052.46 6053.75
6057.21 6063.31 6075.76 6123.18
real    277.145

With V4:
First run (10 times):
user    2688.537
system  6180.907 : 6128.4 6145.47 6160.25 6167.09 6193.31 6195.93
6197.26 6202.98 6204.64 6213.74
real    280.174
Second run (10 times):
user    2771.498
system  6199.043 : 6165.39 6173.49 6179.97 6189.03 6193.13 6199.33
6204.03 6212.9 6216.32 6256.84
real    284.854

Chris

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
>         /* whether this lruvec should be rotated */
>         return nr_to_scan < 0;
>  }
> --
> 2.43.5
>

