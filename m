Return-Path: <linux-kernel+bounces-174059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130318C09BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC5A1F2196E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFBA13CAAA;
	Thu,  9 May 2024 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy10o3CP"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399A3FBB2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221622; cv=none; b=SxYrfZ7ot+eX4V5a8S+whfitzkaB8zrlLwjyeoS83Y37if12sjvlXH22p0oGzrjfysoKw+cttJpDJiVwat/vkaFWroLB433XcIJJIpH2NsZ/xqGJe5Gg8qjVhR20CNQWimc4Pls4rGZNIRTj43lod0n28I/oP+aKfMey2IA6/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221622; c=relaxed/simple;
	bh=6ETiz6r4wb9E8nlIkf6t34VKpoJOWCFKl9l7TYUgD9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDlvUJXyNbBicxi67FVDGJmtoZCGhE8dW9m5QZz7i9bvs1bK0p8JgYeQNRGZepH+EmoSimEGgA7xkMFkZ63KaPvrHz5XqO29Sb2agHec95duOmxlnBEB/zDnkMAwR1Eck4WjfleS8SZNhk35YzB/A1mZoG+ozRO9Eh68qdu+Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy10o3CP; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7f395ac5b16so218012241.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 19:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715221620; x=1715826420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/IwJci/M1L70wMnZgMt9ntgAysQtlzkD6PVneKqaMA=;
        b=Iy10o3CPOkkld3xDft3zwBmLWHlkjkI/XhNeL3HCSHVTKJa+jf+F5gzw9Un++gF+sG
         yjHkDlcBpKLTDHnaPp4jSaU9YCuRg8HWaZJmanByCNx9BKM5VKnZa3ZvoF0ryQ5allnK
         7P1xB2LOC+mp6ndgJLc1wyzdKvnVT8C+TIYTw7vcAw+B8wOOYFDP2MJQVNoPDnYsP049
         3olDjOaWJw31FUH/GYkCPhJB2cWKjL38NDuhrGNJyAvOti285lKpFs3nGmYRgDA7rKFK
         hvqwDmzEJpxeLoMRYXlZFUWultLY6fxevItLGCFeJfvZ41+whd9V+X7JFiizZiR/NKP5
         pNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221620; x=1715826420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/IwJci/M1L70wMnZgMt9ntgAysQtlzkD6PVneKqaMA=;
        b=Q9t1xhmAQlleQ0hkku1GWFVAHhPlSkbmEz6PzE4s5nn9fJcyvstJ6VqlbZdEVMa4w+
         shpyYc8X/uGXXyzyYzBRT48oNnsb7wWOZmunfIyFnd4UeQMUBizGf9lyHue7Z8+xzz13
         A/x54kgcO9BSsK9wj8Cepl+xl3QSdPZXVkcI1tlP2USVqCvIBgC/RvTnhrY0R/JimWdd
         prOUlPqRnDlCL6a3WwWMha5dc5xv43KT7gXYtXP9jwPGPt+x3J0CpoJ10BY9XM39En9o
         4mlia4oaQ4Enkja89MbEB/AANslfoXTWHLWfUvN64KZoHGTl8e8usK/VgWM4+fx6QbW5
         DRug==
X-Forwarded-Encrypted: i=1; AJvYcCW7PDF+h3ePTkBTDCbFzpn60K1JcDuYZHq8XII1KcSLaUkGYgA2QNtvxI2zOD45wZxlCSErRx6zNUGcuVh8VynBjK39gFrWgI3oNfza
X-Gm-Message-State: AOJu0Yz4Bf1xyUXulRZVYG3r1Ib+9hUM+PJKqABV+a2663/3w59+DZaz
	i7kLXT/2jFGiHvkbDKAwqOM1R/kr/d3YmKOSduu/NS0Q5auNiomALI/jZ5ZWZRjBsDLMiuJo9Ex
	09SiOW2Ye/jp9i68ICc3Bb85+7sCGl6bhdAI=
X-Google-Smtp-Source: AGHT+IH+r1spgSsCipDIm7+FpmeR1lk49mezHcRkGEJ+f7hMQE4y8KEZHFZJKNa6mgPzazvCWogF2p+vjW2sq64SBJw=
X-Received: by 2002:a05:6102:508e:b0:47b:b044:4ba3 with SMTP id
 ada2fe7eead31-47fb6c4184dmr1323440137.12.1715221619746; Wed, 08 May 2024
 19:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com> <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 14:26:48 +1200
Message-ID: <CAGsJ_4zZ=nR9ocjrSJNbhU=gKJBC0bqJ306R=GiAAXe2Oda06g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: hailong.liu@oppo.com, asily.averin@linux.dev, 
	Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, May 9, 2024 at 12:58=E2=80=AFAM <hailong.liu@oppo.com> wrote:
> >
> > From: "Hailong.Liu" <hailong.liu@oppo.com>
> >
> > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > includes support for __GFP_NOFAIL, but it presents a conflict with
> > commit dd544141b9eb ("vmalloc: back off when the current task is
> > OOM-killed"). A possible scenario is as belows:
> >
> > process-a
> > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> >     __vmalloc_node_range()
> >         __vmalloc_area_node()
> >             vm_area_alloc_pages()
> >             --> oom-killer send SIGKILL to process-a
> >             if (fatal_signal_pending(current)) break;
> > --> return NULL;
> >
> > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages=
()
> > if __GFP_NOFAIL set.
> >
> > Reported-by: Oven <liyangouwen1@oppo.com>
> > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6641be0ca80b..2f359d08bf8d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >
> >         /* High-order pages or fallback path if "bulk" fails. */
> >         while (nr_allocated < nr_pages) {
> > -               if (fatal_signal_pending(current))
> > +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(curre=
nt))
> >                         break;
>
> why not !nofail ?
>
> This seems a correct fix, but it undermines the assumption made in
> commit dd544141b9eb
>  ("vmalloc: back off when the current task is OOM-killed")
>
> "
>     This may trigger some hidden problems, when caller does not handle
>     vmalloc failures, or when rollaback after failed vmalloc calls own
>     vmallocs inside.  However all of these scenarios are incorrect: vmall=
oc
>     does not guarantee successful allocation, it has never been called wi=
th
>     __GFP_NOFAIL and threfore either should not be used for any rollbacks=
 or
>     should handle such errors correctly and not lead to critical failures=
.
> "
>
> If a significant kvmalloc operation is performed with the NOFAIL flag, it=
 risks
> reverting the fix intended to address the OOM-killer issue in commit
> dd544141b9eb.
> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?

+ Vasily, Michal.

>
> >
> >                 if (nid =3D=3D NUMA_NO_NODE)
> > ---
> > This issue occurred during OPLUS KASAN test. Below is part of the log
> >
> > -> send signal
> > [65731.222840] [ T1308] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=
=3D(null),cpuset=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/apps/uid_101=
98,task=3Dgs.intelligence,pid=3D32454,uid=3D10198
> >
> > [65731.259685] [T32454] Call trace:
> > [65731.259698] [T32454]  dump_backtrace+0xf4/0x118
> > [65731.259734] [T32454]  show_stack+0x18/0x24
> > [65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
> > [65731.259781] [T32454]  dump_stack+0x18/0x38
> > [65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
> > [65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
> > [65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
> > [65731.260047] [T32454]  notify_die+0x114/0x198
> > [65731.260073] [T32454]  die+0xf4/0x5b4
> > [65731.260098] [T32454]  die_kernel_fault+0x80/0x98
> > [65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
> > [65731.260146] [T32454]  do_bad_area+0x68/0x148
> > [65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
> > [65731.260204] [T32454]  el1_abort+0x3c/0x5c
> > [65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
> > [65731.260248] [T32454]  el1h_64_sync+0x68/0x6c
> > [65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
> > --> be->decompressed_pages =3D kvcalloc(be->nr_pages, sizeof(struct pag=
e *), GFP_KERNEL | __GFP_NOFAIL);
> >         kernel panic by NULL pointer dereference.
> >         erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
> >
> > [65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
> > [65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
> > [65731.260339] [T32454]  read_pages+0x170/0xadc
> > [65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
> > [65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
> > [65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
> > [65731.260437] [T32454]  __do_fault+0xd0/0x33c
> > [65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
> > [65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
> > [65731.260509] [T32454]  el0_da+0x44/0x94
> > [65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
> > [65731.260553] [T32454]  el0t_64_sync+0x198/0x19c
> >
> > --
> > 2.34.1
>
> Thanks
> Barry

