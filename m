Return-Path: <linux-kernel+bounces-324089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B29747C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EB41C25AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5542E64A;
	Wed, 11 Sep 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTFzSCk8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D552BB04
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018155; cv=none; b=UsygYtudsRWbNSAECQm9f0/VfSL6a6HjpRqxKMfXF7h4sBpOPW1zBlVFir92kIy1QdATUT0z+OMERs6nHdw5LPAEme/mY80+5/MzBrmcC3ZWK03lkLQXNgqzQ2m0jJfzd4ZyIpobc+HItMySL1jmYvhzsTv+DOlCakZ/420Pf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018155; c=relaxed/simple;
	bh=wjLKu8exd7CTiPTbzEOi81GlGCoh95GF3E1z1BIPCf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFdL2digWnaknqpXcz9DvK0YJu5Q1CeirUTC8zCzTX1pWaZNgZrNkNyO+gTiLSsLc6o7OIc83YCG6ECcNkwvVPAHEBs7952XL5sMVP4WommLLGByCEzWe14dt5Pqj2tuYc7XKGNb8zRLM8fHJ6p3HhIUnuBnqBHVerAOPzhynI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTFzSCk8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2059204f448so51838265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726018154; x=1726622954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1OBWrKfpGId+tTtbwHMSSyPPzeQ9yX3nZA5VxvaKaU=;
        b=eTFzSCk8Qr+p/TpB1V+oPf6ivHJY+sKPom36BuuW4XEefMhFvbKKTbL9Wzgaq2R0Ki
         UhjKCeQeLim0Xq0s2ozsw+QIXRxinHvH/gr0J6UzRNamyOEqyie9Ejk7Lu3zFvqn1MLh
         yRTlkMYX2zzJlNVyi7BMk2D+uQ9mWarzpxfFz2pFtkxCmdT1aZfutSUkw+XfFfcT9NQ7
         dRX0+b97YLiuG+RXUfi7eWm/rRz7T6/yzQboVYY5N+oM85YhkKAVskJYInlzFDy0klzH
         V3jzFn3eawe6Q2a+PATfXd5iJFGTXpRD4SRbSWikzpgxG+jls5GlZ11kqNGKkTt3pzFo
         ivHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726018154; x=1726622954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1OBWrKfpGId+tTtbwHMSSyPPzeQ9yX3nZA5VxvaKaU=;
        b=Lqe9Yg4p1q9AG0bA97c0gIO9/DLf85zghH9/2th7NvccdSEyfrvZ6WX3Ifc47ga+Q1
         Olb7WDwE4FfuuOlqs9K4wjpqKmGeg4MfQGvLWAclfGOGVWP69sdZhwztnm1mKBnzt2XJ
         DLkqkiRoWzdY+jcBljCrMl5723ebYvcZdO+Y5ewsi+4OVrc2w2Db1l72V0EoJtbcmzN5
         8Qm5/8klCDakpwKVAidS6ZBuAGjG7hKel0NNbOb/f4z+y+qPtnlOmgqAmti2w8EufSlS
         l00RfwR+KFk5Ko+5GzaT1CmjSPIopqA+7xmhdKPhkW50kkXxdZT0/0fVqQ6dG3PdJxA1
         78yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzN4Us56X7d0ITT1sPy5dwoKacqOCKjXqZNkUVeGovYEXrs4bXJ1VceZaaFwnhipe89YKgqPJBRguFnAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12a0ZSc12wSnZAKVhTOg9ZMRtm9+wx76AslgXHRJvbLbWTv9x
	HD/y244YHZJXn/u0I4GaOdNi+Yoa8/cV7z0F+YPswdifQhlp/ONt+MGPwH4h3H5oQefU9r3d9gz
	RJ3U4QM/0/xavpKhl+IprXsjsuOQ=
X-Google-Smtp-Source: AGHT+IG4s4csJ2N5oP+AmUsLcI41MpgtckELP5RTdFxsMseNkJLNN7IfffKpiQuIun53UxzQZHSAup6mMDZGolGbrnM=
X-Received: by 2002:a17:902:c94b:b0:205:8b9e:964b with SMTP id
 d9443c01a7336-2074c6ae1b8mr35643215ad.39.1726018153329; Tue, 10 Sep 2024
 18:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com> <CAAPL-u-ERAfjg+RP01QE1XfvQqPHn4ngKAwb_XZA2Cy8KTsVwg@mail.gmail.com>
In-Reply-To: <CAAPL-u-ERAfjg+RP01QE1XfvQqPHn4ngKAwb_XZA2Cy8KTsVwg@mail.gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Wed, 11 Sep 2024 09:29:02 +0800
Message-ID: <CAJqJ8ii4wzfrxNsyi2Qy-4tDKBNEoas2RZ+mzREcy_Nnmksp9g@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
To: Wei Xu <weixugc@google.com>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sept 2024 at 08:01, Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Aug 29, 2024 at 3:25=E2=80=AFAM Jingxiang Zeng
> <jingxiangzeng.cas@gmail.com> wrote:
> >
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> > removed the opportunity to wake up flushers during the MGLRU page
> > reclamation process can lead to an increased likelihood of triggering
> > OOM when encountering many dirty pages during reclamation on MGLRU.
> >
> > This leads to premature OOM if there are too many dirty pages in cgroup=
:
> > Killed
>
> Thanks for the patch. We have encountered a similar problem.
>
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
> > MGLRU still suffers OOM issue on latest mm tree, so the test is done
> > with another fix merged [1].
> >
> > Link: https://lore.kernel.org/linux-mm/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kK=
p8S6N-MZUmErNAXoXmw@mail.gmail.com/ [1]
> >
> > Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/vmscan.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f27792e77a0f..9cd8c42f67cb 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4447,6 +4447,7 @@ static int scan_folios(struct lruvec *lruvec, str=
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
> > @@ -4919,6 +4920,14 @@ static void lru_gen_shrink_lruvec(struct lruvec =
*lruvec, struct scan_control *sc
> >         if (try_to_shrink_lruvec(lruvec, sc))
> >                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
> >
> > +       /*
> > +        * If too many pages failed to evict due to page being dirty,
> > +        * memory pressure have pushed dirty pages to oldest gen,
> > +        * wake up flusher.
> > +        */
> > +       if (sc->nr.unqueued_dirty >=3D sc->nr.taken)
>
> Any reason not to use a strict =3D=3D check as in shrink_inactive_list()?
>
> Also, this check allows the wakeup of the flusher threads when both
> sc->nr.unqueued_dirty and sc->nr.taken are 0, which is undesirable.
>
> If we skip the wakeup for the cases where both counters are 0, then I
> think we need to handle the situation where only dirty file pages are
> left for reclaim in the oldest gen. This means that
> sc->nr.unqueued_dirty needs to be updated in sort_folios() (in
> addition to shrink_folio_list()) as well because sort_folios() doesn't
> send dirty file pages to shrink_folio_list() for eviction.
>

Your suggestion is correct. I will modify it and release the V2 version.
> > +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> > +
> >         clear_mm_walk();
> >
> >         blk_finish_plug(&plug);
> > --
> > 2.43.5
> >
>

