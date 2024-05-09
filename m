Return-Path: <linux-kernel+bounces-174060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FD8C09CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD2B21DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEE84A32;
	Thu,  9 May 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdWj2Mzj"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976082871
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221825; cv=none; b=peu2N+aJv6ZzA+ELi39Ss1vutseA/S48CH8QPNQ7fzQjkvaEX+dbPgqE6ysSTlCD3VNe8Yep/0WcUtoJqHz5y3aD/k5qLNqLtv0F34FnpNX5/aTcvrUmcnukw81kq1YvXmrP/D+2bmxKOTrxVNxrcMdNkOqxaSLYmy1VUzJu9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221825; c=relaxed/simple;
	bh=795sl7jJfyvPuMLqOWTxVlBgpsSFOXCXlhdGDUBKCak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLX8Au8XdCVn2afEqNdtKABVXr2XmoJRYlbnkQXnrktMVHM4Pzv8UGBXMIWEItiFwUjG+KimndJrbq/enWf7aVofjm3HLpzTQmP6FuOirgfDtFRe78Q98lIZNsXOgd59kL+T9r64F8kznh8EaE3AhO3J6kSEDYq1v9PgdqGSwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdWj2Mzj; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47c10a4083fso123650137.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715221823; x=1715826623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f3ST9sz5MmD3ot+TRhiheKYqbtjUEokeBRH5FJqtOQ=;
        b=kdWj2Mzj6sol+Uto8pVuzYjcLWala64AshmHmF325cDnOjhjkhxh9aIL3hWIt7pHG3
         xi2+7M4KjCerR2d4dj54eCgI7x+0/8YCTuztrZ3Amnjl2p5VfJ8voAOL17w7udrOd0E1
         zojXQQHkZ06h4ADlGXScz7cj40A0j3xzMReucq0+p50dn3iivrBUbsILBxy0scSBvSO9
         /UaPtyvF0bzLWanl68LIGRbYTzPypfPuEnlBXH96qYOYl4/4HPlrS0uY0+mzlCV52ckV
         9rnra87hlhOw55WuGRK37GXuI4gtr/02OedRXU4/CQNGuIDwnPtkf0v2NJ7HDKopH+l2
         9j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221823; x=1715826623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f3ST9sz5MmD3ot+TRhiheKYqbtjUEokeBRH5FJqtOQ=;
        b=JR7ffUQJpEAGZD7fPAdhpcIDR2ZLi3XmuzTtKiHjHSKQIZe3463okJmN9c5H1piaJb
         mX2NMo8zNtkj6jbEjQCcD0WrGH14+h4kHPrgKU3npYsCWLnGnv+PnXnxnb6wO/f5njzt
         TlOc7tRO+txL9zmq3y48TLU6gcbY4qrb8kWqjcPvqU+fe+N11bTZTxtIMODued0/TOlp
         9csf5vUGbR6aV6Fd9Sh6gV8AbnJjPDS0KLC81fBhoV5z/yELQXfJKAmA1ePQrwRiFUll
         6z5vs5sVicDX5G7HBO5OlQik6KerWEn/Za/yReGhsCwrN9NdZ1lLXO7l+4xqetJT1H+m
         Xe4A==
X-Forwarded-Encrypted: i=1; AJvYcCWH8ueC5aFlpZzB/IkfWwpuLpXMgGuUbQsP+wGC9N3UJhpVf1QFItVHfij/EyVTCPaAzxtx5V+NHufbkF+HesAto0hpM9g5AcJQpRnE
X-Gm-Message-State: AOJu0Yxh0RQQNfmZi67BQO3DtR6Ylf+04YorFR4uaIYMZi/6mp515juO
	MGb9eZeZu7L6dkhY/80fplBbgGcefVnOppNEcgKb4Vk4sCXWnWUjVzYO/7LkyarvKeXYzE3NDlf
	7iRRlPylfV4BL8TIB8WSk9FHV3NY=
X-Google-Smtp-Source: AGHT+IHrVCSOY/tgNQtQg4/q8JJRFNZ5PXD3ffeHGcX5tUkSULJUHdOJ7WF7p+y4uRYQ290+hKjZLR59Tas/7hb9RU4=
X-Received: by 2002:a67:f405:0:b0:47c:1251:cf25 with SMTP id
 ada2fe7eead31-47f3c2dff19mr4302499137.12.1715221822798; Wed, 08 May 2024
 19:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <CAGsJ_4zZ=nR9ocjrSJNbhU=gKJBC0bqJ306R=GiAAXe2Oda06g@mail.gmail.com>
In-Reply-To: <CAGsJ_4zZ=nR9ocjrSJNbhU=gKJBC0bqJ306R=GiAAXe2Oda06g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 14:30:11 +1200
Message-ID: <CAGsJ_4zpnpnVYgDrNoMXDuRqNpn36ZTvkC8Ge5681o5ty6WHXA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: hailong.liu@oppo.com, Michal Hocko <mhocko@suse.com>, vasily.averin@linux.dev
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:26=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, May 9, 2024 at 2:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Thu, May 9, 2024 at 12:58=E2=80=AFAM <hailong.liu@oppo.com> wrote:
> > >
> > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > >
> > > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc"=
)
> > > includes support for __GFP_NOFAIL, but it presents a conflict with
> > > commit dd544141b9eb ("vmalloc: back off when the current task is
> > > OOM-killed"). A possible scenario is as belows:
> > >
> > > process-a
> > > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> > >     __vmalloc_node_range()
> > >         __vmalloc_area_node()
> > >             vm_area_alloc_pages()
> > >             --> oom-killer send SIGKILL to process-a
> > >             if (fatal_signal_pending(current)) break;
> > > --> return NULL;
> > >
> > > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pag=
es()
> > > if __GFP_NOFAIL set.
> > >
> > > Reported-by: Oven <liyangouwen1@oppo.com>
> > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > > ---
> > >  mm/vmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 6641be0ca80b..2f359d08bf8d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >
> > >         /* High-order pages or fallback path if "bulk" fails. */
> > >         while (nr_allocated < nr_pages) {
> > > -               if (fatal_signal_pending(current))
> > > +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(cur=
rent))
> > >                         break;
> >
> > why not !nofail ?
> >
> > This seems a correct fix, but it undermines the assumption made in
> > commit dd544141b9eb
> >  ("vmalloc: back off when the current task is OOM-killed")
> >
> > "
> >     This may trigger some hidden problems, when caller does not handle
> >     vmalloc failures, or when rollaback after failed vmalloc calls own
> >     vmallocs inside.  However all of these scenarios are incorrect: vma=
lloc
> >     does not guarantee successful allocation, it has never been called =
with
> >     __GFP_NOFAIL and threfore either should not be used for any rollbac=
ks or
> >     should handle such errors correctly and not lead to critical failur=
es.
> > "
> >
> > If a significant kvmalloc operation is performed with the NOFAIL flag, =
it risks
> > reverting the fix intended to address the OOM-killer issue in commit
> > dd544141b9eb.
> > Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>
> + Vasily, Michal.

Sorry for my oversight. Fixed the email of Vasily.

>
> >
> > >
> > >                 if (nid =3D=3D NUMA_NO_NODE)
> > > ---
> > > This issue occurred during OPLUS KASAN test. Below is part of the log
> > >
> > > -> send signal
> > > [65731.222840] [ T1308] oom-kill:constraint=3DCONSTRAINT_NONE,nodemas=
k=3D(null),cpuset=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/apps/uid_10=
198,task=3Dgs.intelligence,pid=3D32454,uid=3D10198
> > >
> > > [65731.259685] [T32454] Call trace:
> > > [65731.259698] [T32454]  dump_backtrace+0xf4/0x118
> > > [65731.259734] [T32454]  show_stack+0x18/0x24
> > > [65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
> > > [65731.259781] [T32454]  dump_stack+0x18/0x38
> > > [65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
> > > [65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
> > > [65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
> > > [65731.260047] [T32454]  notify_die+0x114/0x198
> > > [65731.260073] [T32454]  die+0xf4/0x5b4
> > > [65731.260098] [T32454]  die_kernel_fault+0x80/0x98
> > > [65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
> > > [65731.260146] [T32454]  do_bad_area+0x68/0x148
> > > [65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
> > > [65731.260204] [T32454]  el1_abort+0x3c/0x5c
> > > [65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
> > > [65731.260248] [T32454]  el1h_64_sync+0x68/0x6c
> > > [65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
> > > --> be->decompressed_pages =3D kvcalloc(be->nr_pages, sizeof(struct p=
age *), GFP_KERNEL | __GFP_NOFAIL);
> > >         kernel panic by NULL pointer dereference.
> > >         erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
> > >
> > > [65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
> > > [65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
> > > [65731.260339] [T32454]  read_pages+0x170/0xadc
> > > [65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
> > > [65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
> > > [65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
> > > [65731.260437] [T32454]  __do_fault+0xd0/0x33c
> > > [65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
> > > [65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
> > > [65731.260509] [T32454]  el0_da+0x44/0x94
> > > [65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
> > > [65731.260553] [T32454]  el0t_64_sync+0x198/0x19c
> > >
> > > --
> > > 2.34.1
> >
> > Thanks
> > Barry

