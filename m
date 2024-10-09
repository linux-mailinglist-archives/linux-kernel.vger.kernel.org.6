Return-Path: <linux-kernel+bounces-356333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB9995FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC61F250EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7D156653;
	Wed,  9 Oct 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wxelYXM"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925161DA5F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454894; cv=none; b=lUEfh3Vhbl1OujHO/eYpx7RWIpSXk1fDAjYhS0SvRKpYPsmIXDWDRUk1eMqzHroeevyNSEzKiJt6Q7hnoG/FPEUdc4UodCcbCqnigZVzH5fAI1WrpSyOdHMLSzxVk+Lwn2xYQjqIdrrLpdHVY2FT6md8A5hjZj13kTPUPWluhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454894; c=relaxed/simple;
	bh=3xXNfo0exY96Ll+wMgBfsOLhJvNkUYi8NrMJvfj3E0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufnv4JSN9Xxo4mLW4LOtxJvmIbCFOGAeMt22O2rVuScBG/rRzpng+cn0sDI/5QBQQL1DxnA4yEtKGLz4bEQ5mR6GYVSQQgXaWeNr7b+ErbrPDC2ldQiLJAVM56jIaWG19EXx2pbzMW5VJZEwDbVGEZea3U1BaZxJN2FXSKRMKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wxelYXM; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a3a5cc3903so1630432137.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 23:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728454890; x=1729059690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TOthnCv/sVBZcyHUxm/JOdzM8eNGBCE+FKUptBcdQo=;
        b=3wxelYXMHJBkSi4NGYHshyu6m5a6erjcWmYqnXhbUqgoabAPrZV2Kw941WUqyFl0b0
         C57NtfUKHsd3hwzZel6bivRkYLrs+ayMDqQUEut8I3ufAx2LwNVOL+Zi3WyMxpbCwlJs
         WFmMkBClosF4SsQSIFsh2nPqf49lzwrHzmbYo11Lxsmoq3fmbyyw3CXX1m63L73u1icU
         30i7oEmXIU5L7YdEVgt4/eX++ueBB1mPvxzD6zMyv7Uk3iNTlBPWWOMQAgnsXllCbdS+
         FjZQefHyp+vQlRmlWUqlw4pMSECx436q/z8TCi6OIifP3P9Q5c5G239NYLoUPvcjx6P9
         zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728454890; x=1729059690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TOthnCv/sVBZcyHUxm/JOdzM8eNGBCE+FKUptBcdQo=;
        b=oob4j19BBqdHdKMpGIu/JnayeA5OOa2p8+MDbNnE/RxDvqt0SolldaTmP36gokrtgA
         r3TraTBu054bwE4dfjQmr2zNk12yL9TIa9WY1unff2bMJUUI7K4/re7EWQG03VbGSewH
         4fqZSXjWzvRocxwsY3IIvUV2hgh9yHQMDi8go7d/ziMoeRjExjZjJZA5RHxkby/0AlJR
         UHmKRywsGriL2TwZKAEHsqs0n0cIvrjU6IFTpNqcgmucUsNGHNR4MmXnCs6YLJ5JaAiz
         buRRaDtiDIqKhSiEjRrtZSMbFTMI3z6jiy5EH8QJgbpDKRy51RrGbjbZ/g+gAXLWh8R0
         h9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWWMDF15vvbHGPaek6PAgwqaJH3qIURx/py1U+XbYhsbvZv5nyHQ0OYfV5YjmGXJLj2MfC3xwblh8IxYL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGWcpIput4IGq6UUFgQ9eVRi9OVGJdBNAWhH87xzMzoWrxWRS
	YWBK/l9c8ncHbT2ohzJRTKw+FzdkzI2mXn5JdBC5/Bi0cN58dQ+4EWT1zIeaLR+1vdGftj8nMOB
	3lB5DGVyaFJqPgldnz+EcluN1wja8IaZZn8bG
X-Google-Smtp-Source: AGHT+IE8DCzR7OQOHS0UkC5EAjsR4LDS2DxYpf3ZUUsAu9f/m8ghZdyVynkuJLB+8e3Xp8hVxyfTEJ5Fg/lPmoGw1XM=
X-Received: by 2002:a05:6102:50aa:b0:4a3:c3cf:42b1 with SMTP id
 ada2fe7eead31-4a448e3dbb2mr1164256137.26.1728454890200; Tue, 08 Oct 2024
 23:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
 <CAAPL-u8+qtxbfQ6XL511wjtTNj89HszDC7S-0BQmA=4kAZMR7Q@mail.gmail.com> <CAJqJ8ihy1AfUus2tKR2cmC1vxADn_ApYTC9y1xTeacZXdhzSGA@mail.gmail.com>
In-Reply-To: <CAJqJ8ihy1AfUus2tKR2cmC1vxADn_ApYTC9y1xTeacZXdhzSGA@mail.gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Tue, 8 Oct 2024 23:21:17 -0700
Message-ID: <CAAPL-u9=Bo9=NONYpu-AFQMzM7hwFCRNDxaCbb4tu8iHUerzPQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v4] mm/vmscan: wake up flushers conditionally to
 avoid cgroup OOM
To: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	yuzhao@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:52=E2=80=AFPM jingxiang zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> On Tue, 8 Oct 2024 at 11:26, Wei Xu <weixugc@google.com> wrote:
> >
> > On Mon, Oct 7, 2024 at 6:57=E2=80=AFPM Jingxiang Zeng
> > <jingxiangzeng.cas@gmail.com> wrote:
> > >
> > > From: Jingxiang Zeng <linuszeng@tencent.com>
> > >
> > > Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle"=
)
> > > removed the opportunity to wake up flushers during the MGLRU page
> > > reclamation process can lead to an increased likelihood of triggering=
 OOM
> > > when encountering many dirty pages during reclamation on MGLRU.
> > >
> > > This leads to premature OOM if there are too many dirty pages in cgro=
up:
> > > Killed
> > >
> > > dd invoked oom-killer: gfp_mask=3D0x101cca(GFP_HIGHUSER_MOVABLE|__GFP=
_WRITE),
> > > order=3D0, oom_score_adj=3D0
> > >
> > > Call Trace:
> > >   <TASK>
> > >   dump_stack_lvl+0x5f/0x80
> > >   dump_stack+0x14/0x20
> > >   dump_header+0x46/0x1b0
> > >   oom_kill_process+0x104/0x220
> > >   out_of_memory+0x112/0x5a0
> > >   mem_cgroup_out_of_memory+0x13b/0x150
> > >   try_charge_memcg+0x44f/0x5c0
> > >   charge_memcg+0x34/0x50
> > >   __mem_cgroup_charge+0x31/0x90
> > >   filemap_add_folio+0x4b/0xf0
> > >   __filemap_get_folio+0x1a4/0x5b0
> > >   ? srso_return_thunk+0x5/0x5f
> > >   ? __block_commit_write+0x82/0xb0
> > >   ext4_da_write_begin+0xe5/0x270
> > >   generic_perform_write+0x134/0x2b0
> > >   ext4_buffered_write_iter+0x57/0xd0
> > >   ext4_file_write_iter+0x76/0x7d0
> > >   ? selinux_file_permission+0x119/0x150
> > >   ? srso_return_thunk+0x5/0x5f
> > >   ? srso_return_thunk+0x5/0x5f
> > >   vfs_write+0x30c/0x440
> > >   ksys_write+0x65/0xe0
> > >   __x64_sys_write+0x1e/0x30
> > >   x64_sys_call+0x11c2/0x1d50
> > >   do_syscall_64+0x47/0x110
> > >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > >  memory: usage 308224kB, limit 308224kB, failcnt 2589
> > >  swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> > >
> > >   ...
> > >   file_dirty 303247360
> > >   file_writeback 0
> > >   ...
> > >
> > > oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3Dtes=
t,
> > > mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test,task=3Ddd,pid=
=3D4404,uid=3D0
> > > Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512k=
B,
> > > anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> > > oom_score_adj:0
> > >
> > > The flusher wake up was removed to decrease SSD wearing, but if we ar=
e
> > > seeing all dirty folios at the tail of an LRU, not waking up the flus=
her
> > > could lead to thrashing easily.  So wake it up when a mem cgroups is =
about
> > > to OOM due to dirty caches.
> > >
> > > ---
> > > Changes from v3:
> > > - Avoid taking lock and reduce overhead on folio isolation by
> > >   checking the right flags and rework wake up condition, fixing the
> > >   performance regression reported by Chris Li.
> > >   [Chris Li, Kairui Song]
> > > - Move the wake up check to try_to_shrink_lruvec to cover kswapd
> > >   case as well, and update comments. [Kairui Song]
> > > - Link to v3: https://lore.kernel.org/all/20240924121358.30685-1-jing=
xiangzeng.cas@gmail.com/
> > > Changes from v2:
> > > - Acquire the lock before calling the folio_check_dirty_writeback
> > >   function. [Wei Xu, Jingxiang Zeng]
> > > - Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-ji=
ngxiangzeng.cas@gmail.com/
> > > Changes from v1:
> > > - Add code to count the number of unqueued_dirty in the sort_folio
> > >   function. [Wei Xu, Jingxiang Zeng]
> > > - Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jin=
gxiangzeng.cas@gmail.com/
> > > ---
> > >
> > > Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle"=
)
> > > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > Cc: T.J. Mercier <tjmercier@google.com>
> > > Cc: Wei Xu <weixugc@google.com>
> > > Cc: Yu Zhao <yuzhao@google.com>
> > > ---
> > >  mm/vmscan.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index dc7a285b256b..2a5c2fe81467 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4291,6 +4291,7 @@ static bool sort_folio(struct lruvec *lruvec, s=
truct folio *folio, struct scan_c
> > >                        int tier_idx)
> > >  {
> > >         bool success;
> > > +       bool dirty, writeback;
> > >         int gen =3D folio_lru_gen(folio);
> > >         int type =3D folio_is_file_lru(folio);
> > >         int zone =3D folio_zonenum(folio);
> > > @@ -4336,9 +4337,14 @@ static bool sort_folio(struct lruvec *lruvec, =
struct folio *folio, struct scan_c
> > >                 return true;
> > >         }
> > >
> > > +       dirty =3D folio_test_dirty(folio);
> > > +       writeback =3D folio_test_writeback(folio);
> > > +       if (type =3D=3D LRU_GEN_FILE && dirty && !writeback)
> > > +               sc->nr.unqueued_dirty +=3D delta;
> > > +
> >
> > This sounds good.  BTW, when shrink_folio_list() in evict_folios()
> > returns, we should add stat.nr_unqueued_dirty to sc->nr.unqueued_dirty
> > there as well.
>
> Thank you for your valuable feedback, I will implement it in the next ver=
sion.
> >
> > >         /* waiting for writeback */
> > > -       if (folio_test_locked(folio) || folio_test_writeback(folio) |=
|
> > > -           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > > +       if (folio_test_locked(folio) || writeback ||
> > > +           (type =3D=3D LRU_GEN_FILE && dirty)) {
> > >                 gen =3D folio_inc_gen(lruvec, folio, true);
> > >                 list_move(&folio->lru, &lrugen->folios[gen][type][zon=
e]);
> > >                 return true;
> > > @@ -4454,7 +4460,7 @@ static int scan_folios(struct lruvec *lruvec, s=
truct scan_control *sc,
> > >         trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_L=
RU_BATCH,
> > >                                 scanned, skipped, isolated,
> > >                                 type ? LRU_INACTIVE_FILE : LRU_INACTI=
VE_ANON);
> > > -
> > > +       sc->nr.taken +=3D scanned;
> >
> > I think we should only include file pages (in sort_folio) and isolated
> > pages into sc->nr.taken, instead of all scanned pages. For example, if
>
> Unqueued dirty pages are not isolated, but promoted to the newer generati=
on
> in the sort_folio function. So I tend to wake up the flusher thread when =
the
> number of scanned pages is equal to the number of unqueued dirty pages.
>
> > there are only unevictable and unqueued dirty pages, we would still
> > like to wake up the flusher threads, but because nr.taken counts
> > unevictable pages as well, the wakeup condition in
> > try_to_shrink_lruvec() won't be met.
>
> The situation you mentioned will not happen because the number of
> scanned pages does not include unevicatble pages.
> However, there is another situation that needs attention. When the
> scanned pages contain anonymous pages and unqueued dirty pages,
> the flusher cannot be woken up. I will fix this situation in the next ver=
sion.
>

Pages in unevictable LRUs are not scanned, but unevictable pages that
are not yet moved to unevictable LRUs can be included in scanned
pages. See the !folio_evictable(folio) check in sort_folio().

> >
> > >         /*
> > >          * There might not be eligible folios due to reclaim_idx. Che=
ck the
> > >          * remaining to prevent livelock if it's not making progress.
> > > @@ -4796,6 +4802,13 @@ static bool try_to_shrink_lruvec(struct lruvec=
 *lruvec, struct scan_control *sc)
> > >                 cond_resched();
> > >         }
> > >
> > > +       /*
> > > +        * If too many file cache in the coldest generation can't be =
evicted
> > > +        * due to being dirty, wake up the flusher.
> > > +        */
> > > +       if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty =3D=3D sc-=
>nr.taken)
> > > +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> > > +
> >
> > try_to_shrink_lruvec() can be called from shrink_node() for global
> > reclaim as well. We need to reset sc->nr before calling
> > lru_gen_shrink_node() there. MGLRU didn't need that because it didn't
> > use sc->nr until this change.
>
> Thank you for your valuable feedback, I will implement it in the next ver=
sion.
> >
> > >         /* whether this lruvec should be rotated */
> > >         return nr_to_scan < 0;
> > >  }
> > > --
> > > 2.43.5
> > >

