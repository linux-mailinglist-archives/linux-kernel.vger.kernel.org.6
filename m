Return-Path: <linux-kernel+bounces-356284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC03995EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC20B23C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AA15CD49;
	Wed,  9 Oct 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsYYSj1I"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F143AAE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452108; cv=none; b=Rpnql06S9ihrR3UO7lvYcubmkR2vAFOasg2wDH+NvDYsFeSamUnZDMpgKUezV8keKaJeaCfIMTehSC0wmcsD5s4/ipV3zPc0WluSM0wdwN4S/8CspooelGH0kUX3uqky8Zo9TNQ8+PXdrjb47sN12KBpo1fAUV5enV3KdBdvNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452108; c=relaxed/simple;
	bh=3oqyfbBqB3WUIbijDJyC+/gtiFdcJZyOIH4Oj9TdPJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+Qx5ZILGz+muO8Hzaawlqs/2Oq1XU2L3WcFBTRGzucQ/D0ADoDBj3nWld5GxzIjRL6HmwIVzU9pz9TKxrP2ifK+i3szYNhSmHZQ24hdmCocfdEyQe9IJs8MKvq7qCwjEHNCcb0oUq8TdZG7YCUyvVdNq6O3Frm0sIAziP0kOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsYYSj1I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c593d6b1cso12709255ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 22:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728452106; x=1729056906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMBy1FqazUH62o/ICplufSjK7LMBbZY7J4FwWcLit9c=;
        b=lsYYSj1IbbkOcsJdGqHMmvaF9d4GuJT6wQiLkqzGmdKSSRAJTudt/0BUyHLo32Fssh
         CvenAPHsi3NghhqXNblH1putvmv27QFrQI5hDfados0gM1fBR4OgJjveOT45BKpxDVmz
         miPi/PteSGlCE3dCcNVisoCD6rkVrxE0O7k6qAGcheaGZFa6viaGGz5L2xX1K0mJMFpc
         3NR3Etg4uYLUN4qcvvg/oc69T3ZGtVAJezrACnKP6GrxmVNuRLtAGaidNw7SgDtEq/C3
         6Y7aUQaKcFSi9DBAUxd55TsbXi04XytlQPm9O+rxRZntWuUdy99rRzM/UrwOH3b3db8Z
         pXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728452106; x=1729056906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMBy1FqazUH62o/ICplufSjK7LMBbZY7J4FwWcLit9c=;
        b=vqVsdsxmqdf3cYjKvU0z7rcOYF9p7eKtqOINtDh33yIQ130LwQdC+Jt4kLg6Fbeq7t
         ZcFjWZu1FpU6SmordGMrXhVm1yuf6xwtQZK42KL5Xtp1qs1a7SVP9A1zwRHtivh/5VFK
         vpbOVpxYCMGMOtifpSo9ZybJfXdgUX/z00tkej3IxvIEcj9mR4xvemP8po35yrVcFZo8
         tjWbH+ynXrIxoKj7ooyaQKc92M8AYCe6TXdNaAIwhL/2yVMRZjah+yrh93YE+vn6rkm1
         MlBbjKnd7qBCqiyqTAqIhS5G3frJu2jPKBfj8Rq+FeVbtNIQ04+n09V9C9TH990Id7+F
         5PEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+nr47JtyqM4TCZvOgdok3V3KePyfmUIbmvA+CTOG5+3IbhVT9u/i9QpbEqkpVExpxOkHilttD91MJnpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEAleHSMWwihF3sT1Jj4sq6xrTmBkffY5HEx9OxlxTokevFBe
	jC5jHDLQ+45Gv1AqmfZRXy/9AXCGHGdG1j1xHUI/osJ0CC9zhotVBES/iSoDjrnb/lltV5JeHg8
	6FI0GgNhP17IwwSbkZGWRX5rcq0sKAKHb
X-Google-Smtp-Source: AGHT+IHD9z/Wnf1e5PukYuyYa6ooWB/L/uL+spW+ZXRkn7NlmBLy50uhEDWmyCA+F5yUFgAELKccW0vXEKGtGw3d294=
X-Received: by 2002:a17:903:2ac6:b0:20b:85da:a6e5 with SMTP id
 d9443c01a7336-20c636de15amr21756155ad.8.1728452105853; Tue, 08 Oct 2024
 22:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
 <CACePvbXGPyPyyGa+EWkfdyU0wa9eHuwvzAVNBrE-tjb6otQ7KQ@mail.gmail.com>
In-Reply-To: <CACePvbXGPyPyyGa+EWkfdyU0wa9eHuwvzAVNBrE-tjb6otQ7KQ@mail.gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Wed, 9 Oct 2024 13:34:54 +0800
Message-ID: <CAJqJ8ijzAhVxuE16-oawhhs3YmHKWmmoo0ca5KyaLGME7aoXjw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v4] mm/vmscan: wake up flushers conditionally to
 avoid cgroup OOM
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	weixugc@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Before I released the V4 version, I also ran the swap stress test you gave =
me,
with -j32, 1G memcg on my local branch:

With the V4 patch:
1952.07user 1768.35system 4:51.89elapsed 1274%CPU (0avgtext+0avgdata
920100maxresident)k

Without the patch:
1957.83user 1757.06system 4:51.15elapsed 1275%CPU (0avgtext+0avgdata
919880maxresident)k

My test results are the same as yours. This should not be test noise. I am
trying to analyze whether it can be further optimized.

Jingxiang Zeng

On Wed, 9 Oct 2024 at 01:12, Chris Li <chrisl@kernel.org> wrote:
>
> Hi Jingxiang,
>
> I did run the same swap stress test on V4 and it is much better than V3.
> V3 test was hang there (time out). V4 did not hang any more, it
> finishes in about the same time.
>
> If we look closer of V4, it seems suggest that v4 system time is slightly=
 worse.
> Is that kind of expected or might be the noise of my test? Just trying
> to understand it better, it is not a NACK by any means.
>
> Here is the number on mm-unstable c121617e3606be6575cdacfdb63cc8d67b46a56=
8:
> Without (10 times):
> user    2688.328
> system  6059.021 : 6031.57 6043.61 6044.35 6045.01 6052.46 6053.75
> 6057.21 6063.31 6075.76 6123.18
> real    277.145
>
> With V4:
> First run (10 times):
> user    2688.537
> system  6180.907 : 6128.4 6145.47 6160.25 6167.09 6193.31 6195.93
> 6197.26 6202.98 6204.64 6213.74
> real    280.174
> Second run (10 times):
> user    2771.498
> system  6199.043 : 6165.39 6173.49 6179.97 6189.03 6193.13 6199.33
> 6204.03 6212.9 6216.32 6256.84
> real    284.854
>
> Chris
>
> On Mon, Oct 7, 2024 at 6:57=E2=80=AFPM Jingxiang Zeng
> <jingxiangzeng.cas@gmail.com> wrote:
> >
> > From: Jingxiang Zeng <linuszeng@tencent.com>
> >
> > Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> > removed the opportunity to wake up flushers during the MGLRU page
> > reclamation process can lead to an increased likelihood of triggering O=
OM
> > when encountering many dirty pages during reclamation on MGLRU.
> >
> > This leads to premature OOM if there are too many dirty pages in cgroup=
:
> > Killed
> >
> > dd invoked oom-killer: gfp_mask=3D0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_W=
RITE),
> > order=3D0, oom_score_adj=3D0
> >
> > Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x5f/0x80
> >   dump_stack+0x14/0x20
> >   dump_header+0x46/0x1b0
> >   oom_kill_process+0x104/0x220
> >   out_of_memory+0x112/0x5a0
> >   mem_cgroup_out_of_memory+0x13b/0x150
> >   try_charge_memcg+0x44f/0x5c0
> >   charge_memcg+0x34/0x50
> >   __mem_cgroup_charge+0x31/0x90
> >   filemap_add_folio+0x4b/0xf0
> >   __filemap_get_folio+0x1a4/0x5b0
> >   ? srso_return_thunk+0x5/0x5f
> >   ? __block_commit_write+0x82/0xb0
> >   ext4_da_write_begin+0xe5/0x270
> >   generic_perform_write+0x134/0x2b0
> >   ext4_buffered_write_iter+0x57/0xd0
> >   ext4_file_write_iter+0x76/0x7d0
> >   ? selinux_file_permission+0x119/0x150
> >   ? srso_return_thunk+0x5/0x5f
> >   ? srso_return_thunk+0x5/0x5f
> >   vfs_write+0x30c/0x440
> >   ksys_write+0x65/0xe0
> >   __x64_sys_write+0x1e/0x30
> >   x64_sys_call+0x11c2/0x1d50
> >   do_syscall_64+0x47/0x110
> >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> >  memory: usage 308224kB, limit 308224kB, failcnt 2589
> >  swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> >
> >   ...
> >   file_dirty 303247360
> >   file_writeback 0
> >   ...
> >
> > oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3Dtest,
> > mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test,task=3Ddd,pid=3D4=
404,uid=3D0
> > Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
> > anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> > oom_score_adj:0
> >
> > The flusher wake up was removed to decrease SSD wearing, but if we are
> > seeing all dirty folios at the tail of an LRU, not waking up the flushe=
r
> > could lead to thrashing easily.  So wake it up when a mem cgroups is ab=
out
> > to OOM due to dirty caches.
> >
> > ---
> > Changes from v3:
> > - Avoid taking lock and reduce overhead on folio isolation by
> >   checking the right flags and rework wake up condition, fixing the
> >   performance regression reported by Chris Li.
> >   [Chris Li, Kairui Song]
> > - Move the wake up check to try_to_shrink_lruvec to cover kswapd
> >   case as well, and update comments. [Kairui Song]
> > - Link to v3: https://lore.kernel.org/all/20240924121358.30685-1-jingxi=
angzeng.cas@gmail.com/
> > Changes from v2:
> > - Acquire the lock before calling the folio_check_dirty_writeback
> >   function. [Wei Xu, Jingxiang Zeng]
> > - Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-jing=
xiangzeng.cas@gmail.com/
> > Changes from v1:
> > - Add code to count the number of unqueued_dirty in the sort_folio
> >   function. [Wei Xu, Jingxiang Zeng]
> > - Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jingx=
iangzeng.cas@gmail.com/
> > ---
> >
> > Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: T.J. Mercier <tjmercier@google.com>
> > Cc: Wei Xu <weixugc@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > ---
> >  mm/vmscan.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index dc7a285b256b..2a5c2fe81467 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4291,6 +4291,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio *folio, struct scan_c
> >                        int tier_idx)
> >  {
> >         bool success;
> > +       bool dirty, writeback;
> >         int gen =3D folio_lru_gen(folio);
> >         int type =3D folio_is_file_lru(folio);
> >         int zone =3D folio_zonenum(folio);
> > @@ -4336,9 +4337,14 @@ static bool sort_folio(struct lruvec *lruvec, st=
ruct folio *folio, struct scan_c
> >                 return true;
> >         }
> >
> > +       dirty =3D folio_test_dirty(folio);
> > +       writeback =3D folio_test_writeback(folio);
> > +       if (type =3D=3D LRU_GEN_FILE && dirty && !writeback)
> > +               sc->nr.unqueued_dirty +=3D delta;
> > +
> >         /* waiting for writeback */
> > -       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > +       if (folio_test_locked(folio) || writeback ||
> > +           (type =3D=3D LRU_GEN_FILE && dirty)) {
> >                 gen =3D folio_inc_gen(lruvec, folio, true);
> >                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]=
);
> >                 return true;
> > @@ -4454,7 +4460,7 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
> >         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU=
_BATCH,
> >                                 scanned, skipped, isolated,
> >                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE=
_ANON);
> > -
> > +       sc->nr.taken +=3D scanned;
> >         /*
> >          * There might not be eligible folios due to reclaim_idx. Check=
 the
> >          * remaining to prevent livelock if it's not making progress.
> > @@ -4796,6 +4802,13 @@ static bool try_to_shrink_lruvec(struct lruvec *=
lruvec, struct scan_control *sc)
> >                 cond_resched();
> >         }
> >
> > +       /*
> > +        * If too many file cache in the coldest generation can't be ev=
icted
> > +        * due to being dirty, wake up the flusher.
> > +        */
> > +       if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty =3D=3D sc->n=
r.taken)
> > +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> > +
> >         /* whether this lruvec should be rotated */
> >         return nr_to_scan < 0;
> >  }
> > --
> > 2.43.5
> >

