Return-Path: <linux-kernel+bounces-335367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6A97E4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936CA1C20FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF35256E;
	Mon, 23 Sep 2024 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQpD8djV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BD391
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055869; cv=none; b=QPV1K6XAiY7GgtjStufG6WSqFnPdZs2yn/G8q5nGLVfJRNQyOyamCmZl8C7VSMQRMtz9X9stXykXKcgQoLEglzOAV6Qfd+xUK1821FKtMrxftkYRpyxows/468DdWLAdBVQJRH+DllyfzX1ES41xNeLsrHNnO8vey7tllUOMzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055869; c=relaxed/simple;
	bh=/SkMf+WOPVueZ8UEgoTul6g4l3cJNINW4rF9vphIcd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mna4uLgd9xZCjxMM/8SE+e4D07rWrQQtAw15aS3vWBMi6Vlsq9hEXodpwgeL66fpXv6twEMBD/BgK0W5Gb8lxVjmwqHzJbS/ROaQb4GCFxzCvcgmlOX7r5GdLI/2q7+f0bA8YKwtQfov6GI9vsaDtFUnpfMj+fqU0+f3dQyqVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQpD8djV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7198de684a7so2912775b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727055867; x=1727660667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCLAeT+5noF4UxAMDA+O3X9/Yxx/NTQ52fWdyh16Ba8=;
        b=KQpD8djVigChOzDLteUk1pfXgL0QXxBUy/WPoPCtDg0GdccW9hJ3AimFHrKPBvZZhV
         0bGn+3KqEUgROoZ10XWRASrZsYtRJ16KyARaWc4f/RhMyCiKa5epnTYD2sc+5YpN6Mzw
         CjYOR5+B6+y+FRQpAP0ytND59i36fqOnxh08cAG43NbWlpGe81+nb7Cv6FdIqxF/aXRm
         QjpcjF+0jFiIxGGx3mtM6h2r1QJCt44K7vdURLf85Xll7FcTcDEfA/sTgdJYAdA7HuyI
         K3JLtgBTkq/Y/Ggnz0UN5UQuCUgaHG4I/Lh4zGZkXk6jYpSkLFkcIwAf3DoZbyB1Ofr8
         48nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727055867; x=1727660667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCLAeT+5noF4UxAMDA+O3X9/Yxx/NTQ52fWdyh16Ba8=;
        b=MR08Rid+ycUYYNaxRx9TBBo9Ey1mJbV/JXWDf4sOZVuJl4uzgyEVvlRl6mfIc94Has
         zGQOipsDaSIz3cQadGQ0vACj/kq/TY0G77b/r06PKE+B0aRT91gxeBSG7ykgmrXdkfmh
         ftLPOFhteXJ2WqK4If+VrFdku//y1eboW+j/s2ob/ufxrmyfHT1hsfXLdV+tvg30PMdz
         CAhjDBY59ydNk/bmFjPw/yj3G4lvZ9JWvSb7biJn95DR2gyH6u3mHxl5cGyKP2US7Gyh
         tq7q4Z7I/Si6Ua2ojhRbFCl2J1ndKEV733t+g859T5G9QYNsLSS3at4jelN+YjMpo/ut
         6ptA==
X-Forwarded-Encrypted: i=1; AJvYcCUV39ufVtpUzJ2Mgw+8C9atVeHUH/l6gCltW5V7lB/dvlXnqVWXbn90IGOqIgI+XA0LyrFpcsHgVSXZ/R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPrF1OOxhMAOs4fRtEti73x1tGYMTnHjPDmoI3Lvvy9DGN6ZW
	/raLL0LzKziVt13U73L6sM4Tg5NDProrRnax4zfXjkm4isfdlk+IlQ6B5ErrFCU4Mc3z5OI+p2c
	YzJ9ABhYxFnb6psnDvsu3Um6zpnA=
X-Google-Smtp-Source: AGHT+IGxmt0c8PI3xrSQR81j4QSBN73PfD0BZf96G0D8xZn6yTvd913qjysMV7JOpfiJJH/v9IBFlbxbPxVPzuI4IzM=
X-Received: by 2002:a05:6a00:c90:b0:710:6f54:bc9c with SMTP id
 d2e1a72fcca58-7199cd7a3b1mr13644469b3a.2.1727055866966; Sun, 22 Sep 2024
 18:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240913084506.3606292-1-jingxiangzeng.cas@gmail.com>
 <CAAPL-u8s+mc1bY-DJ_zDJ1PLrhP_2w2MQXxdteN4z_U=qE6jfw@mail.gmail.com>
In-Reply-To: <CAAPL-u8s+mc1bY-DJ_zDJ1PLrhP_2w2MQXxdteN4z_U=qE6jfw@mail.gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Mon, 23 Sep 2024 09:44:15 +0800
Message-ID: <CAJqJ8ig=XtvpBq4ex=wX_dEW+WyuMAwg-ix8NSZnqJi_Kc_C5Q@mail.gmail.com>
Subject: Re: [PATCH V2] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
To: Wei Xu <weixugc@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Sept 2024 at 00:11, Wei Xu <weixugc@google.com> wrote:
>
> On Fri, Sep 13, 2024 at 1:45=E2=80=AFAM Jingxiang Zeng
> <jingxiangzeng.cas@gmail.com> wrote:
> >
> > From: Zeng Jingxiang <linuszeng@tencent.com>
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
> > could lead to thrashing easily. So wake it up when a mem cgroups is
> > about to OOM due to dirty caches.
> >
> > Link: https://lkml.kernel.org/r/20240829102543.189453-1-jingxiangzeng.c=
as@gmail.com
> > Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: T.J. Mercier <tjmercier@google.com>
> > Cc: Wei Xu <weixugc@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/vmscan.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 749cdc110c74..ce471d686a88 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4284,6 +4284,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio *folio, struct scan_c
> >                        int tier_idx)
> >  {
> >         bool success;
> > +       bool dirty, writeback;
> >         int gen =3D folio_lru_gen(folio);
> >         int type =3D folio_is_file_lru(folio);
> >         int zone =3D folio_zonenum(folio);
> > @@ -4332,6 +4333,9 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio *folio, struct scan_c
> >         /* waiting for writeback */
> >         if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> >             (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > +               folio_check_dirty_writeback(folio, &dirty, &writeback);
>
> We cannot simply call folio_check_dirty_writeback() here because
> folio_check_dirty_writeback() assumes that the folio is locked (e.g.
> see buffer_check_dirty_writeback()).

Thank you for your modification suggestion.
>
> > +               if (dirty && !writeback)
> > +                       sc->nr.unqueued_dirty +=3D delta;
> >                 gen =3D folio_inc_gen(lruvec, folio, true);
> >                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]=
);
> >                 return true;
> > @@ -4448,6 +4452,7 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
> >                                 scanned, skipped, isolated,
> >                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE=
_ANON);
> >
> > +       sc->nr.taken +=3D isolated;
> >         /*
> >          * There might not be eligible folios due to reclaim_idx. Check=
 the
> >          * remaining to prevent livelock if it's not making progress.
> > @@ -4920,6 +4925,14 @@ static void lru_gen_shrink_lruvec(struct lruvec =
*lruvec, struct scan_control *sc
> >         if (try_to_shrink_lruvec(lruvec, sc))
> >                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
> >
> > +       /*
> > +        * If too many pages failed to evict due to page being dirty,
> > +        * memory pressure have pushed dirty pages to oldest gen,
> > +        * wake up flusher.
> > +        */
> > +       if (sc->nr.unqueued_dirty > sc->nr.taken)
> > +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> > +
>
> The wakeups will be much more often than intended because
> sc->nr.unqueued_dirty includes the drity file pages now, but
> sc->nr.taken doesn't.

When the scan_folios function scans the coldest generation,
when the number of pages that need to be promoted due to
unqueued dirty pages is greater than the number of pages
that can be isolated, the logic here will wake up the flusher
thread.
This condition will indeed be triggered when there
are too many pages in the coldest generation that cannot
be isolated.
I think this condition for triggering the flusher to wake up is
reasonable. Are there any other good trigger conditions?
>
> >         clear_mm_walk();
> >
> >         blk_finish_plug(&plug);
> > --
> > 2.43.5
> >

