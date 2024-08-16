Return-Path: <linux-kernel+bounces-290249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA4955151
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6AEB22DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88681C460E;
	Fri, 16 Aug 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiJEcUoM"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1552F62
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836069; cv=none; b=SUXya3Jczj2TKH32sJG61jbDG/fBqlQsc9uBvUS5ooB23O9/qzwZJjdHPhcQhLCfx2MOqaMNshUReyooU+tGhv+V2LPrB/KdYJ2QB0AP6D33/0BaNGim/p24Sj2MdW7+pdS4u+hyEw6M4TzDa6faH8K3pGmkBsq4a8hJy4E6+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836069; c=relaxed/simple;
	bh=/fd9u9fUwoNH2HHRMW/4sNRO3D2Eus8e6w+71WUEk+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA71rVvsm0MrdJt+ybfXGPCDQQsEz/dhZRmNw2+xYDUSyU7IeA+0PZmoMl/QWByx1l/Oi9bHgOTPLv+z+6QVmu9RTV4bir9hwVisFdhDkQ8cNEqSopvb1zLyxYzwIDpRD41eCdm+I5/j3rnl6sN8I/pb3XKMbi+Pe98ACOProt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiJEcUoM; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-690ad83d4d7so23397847b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723836067; x=1724440867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAkZOqNhnveajHipNOMhpr0ZJRkMRtizq6QmxIcG1So=;
        b=aiJEcUoMzkJ0v7wWKYBnqxuiLc+K4ScjJIitYblS9FSRNTSDpKvX3sznHSMUrGe50Q
         PhrsW6V5vLJRRYI2XbQhIjTGJrHU99d/8pWJflN7Cu1F9CiWtrq7xtL612EF92J4BE6G
         YxQK/kAVgWuIsVdiM06lsg8Z/QlVK5AsNmVT+1oIMgrZWXSImagP/Gr7f1Un3Sm8TnNJ
         xl0kBh19MobT8UWkmaqxPPV1z2nhnrJwRcPm2BZZm2C1xZVKi/UqL8AX3lqlw35B9xur
         3hLvt/XNmdHnB2/Z/GRuxYV/Hm4zJZthRfq1VWVBq8MgHvMc+k3tUN+Ev/x1p3iI1c0Z
         XJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836067; x=1724440867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAkZOqNhnveajHipNOMhpr0ZJRkMRtizq6QmxIcG1So=;
        b=P53oAB0i6bOn2fWLB9IXOE0mSk+uR3fO0BbDihKMWJ3Nd6tPfeTdKuEu4nhww0g7fO
         IxmAbCsqshr3liNQWUHxjplLZ7KdxQHSJSwNY7v9+ZZpTIrl9fJur/YFZqUU+vr91w2P
         Fo3tt9rrq8PACTNwER0CpLu5/sunsOn9et2ZEfyawBaLIrAqIKFPZ3qqT2qTOwStyu2S
         IyQvLL4dlsaiNNy/0607mn9np0KOv1QLcmQ+3mcvQDaLejnux/WbI4EeAEie6q521SDk
         hVinxFPtjGvY14A+IW21QAqTq0Y1CATD0D+ZThGZozqMD2gO5LlvsojhunezqichPO/9
         Xutg==
X-Forwarded-Encrypted: i=1; AJvYcCWTn07frjBqi3seIXGLA/If0EfO/2/fUuJgrUQX8O2J2TVp4eXumlHRX6AuwMs4P/0Rf8psepphC00fiZ+L53iirTZMzy6K84RZakda
X-Gm-Message-State: AOJu0YxHU3NsPOcC+4E7VGeMZmntPjKdDMpldEQsmFb2/ap89bxcownH
	vt06gT9Woqqv+4TGsg1PYiiyfqWhvvF+SsTYdQ14SaouZdJj5BerKoqlNVyMrgRhFZD19El14EJ
	UPfqQBPz/VFgjq0X70YbTx3oLw8buE0YFKizr
X-Google-Smtp-Source: AGHT+IG12famSdUV7QWzpiG6d5wFEJ1L0urOdbl6yfxU1g/eEu5anDYt31tfyAV9GqApw8iQOqI6g+0Cf8ejNNMqEeA=
X-Received: by 2002:a05:690c:6603:b0:6ad:8bbd:aecb with SMTP id
 00721157ae682-6b1b8ddfd7cmr56760747b3.21.1723836066332; Fri, 16 Aug 2024
 12:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815072113.30288-1-hao.ge@linux.dev> <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
 <4a24c134-d4d3-20c5-45f5-4dfa961fbd73@linux.dev>
In-Reply-To: <4a24c134-d4d3-20c5-45f5-4dfa961fbd73@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Aug 2024 12:20:53 -0700
Message-ID: <CAJuCfpEEoq__+yeCXCn0F7HARrVndeEm86sM5XvYeo+UT0cr9g@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Add check for s->flags in the alloc_tagging_slab_free_hook
To: Hao Ge <hao.ge@linux.dev>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org, 
	kent.overstreet@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 6:46=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> Thank you for taking the time to review this patch.
>
>
> On 8/16/24 05:00, Suren Baghdasaryan wrote:
> > On Thu, Aug 15, 2024 at 12:21=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> When enable CONFIG_MEMCG & CONFIG_KFENCE & CONFIG_KMEMLEAK,
> >> the following warning always occurs,This is because the
> >> following call stack occurred:
> >> mem_pool_alloc
> >>      kmem_cache_alloc_noprof
> >>          slab_alloc_node
> >>              kfence_alloc
> >>
> >> Once the kfence allocation is successful,slab->obj_exts will not be em=
pty.
> >> Since in the prepare_slab_obj_exts_hook function,we perform a check fo=
r
> >> s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE),the alloc_tag_add func=
tion
> >> will not be called as a result.Therefore,ref->ct remains NULL.
> >>
> >> However,when we call mem_pool_free,since obj_ext is not empty,
> >> it eventually leads to the alloc_tag_sub scenario being invoked.
> >> This is where the warning occurs.
> > Ok, I was trying to understand why "Once the kfence allocation is
> > successful,slab->obj_exts will not be empty.". alloc_slab_obj_exts()
> > has to be called to create slab->obj_exts. Normally that is done in
> > prepare_slab_obj_exts_hook() which has the s->flags & (SLAB_NO_OBJ_EXT
> > | SLAB_NOLEAKTRACE) check and the cache that kfence_alloc() uses here
> > is the object_cache (passed from mem_pool_alloc()) which has
> > SLAB_NOLEAKTRACE:
> > https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/kmemleak.c#L453.
> > Therefore, prepare_slab_obj_exts_hook() should have skipped it and did
> > not create the slab->obj_exts. So, it must have been called from
> > account_slab() or __memcg_slab_post_alloc_hook() to create
> > slab->obj_exts for memcg accounting in slab->obj_exts.objcg. Ok, now I
> > understand why you need the CONFIG_MEMCG & CONFIG_KFENCE &
> > CONFIG_KMEMLEAK combination.
> > Please confirm that slab->obj_exts creation is happening the way I
> > described above and for those reasons and if so, please update the
> > description of this patch to explain that.
>
> It's mostly correct, but in the context of kfence, the assignment
> actually takes place within the kfence_init_pool function.
>
> https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/kfence/core.c#L606
>
> So in version 2, I have included this explain "because it has already
> been assigned a value in kfence_init_pool."
>
> >> So we should add corresponding checks in the alloc_tagging_slab_free_h=
ook.
> >> For __GFP_NO_OBJ_EXT case,I didn't see the specific case where it's
> >> using kfence,so I won't add the corresponding check in
> >> alloc_tagging_slab_free_hook for now.
> >>
> >> [    3.734349] ------------[ cut here ]------------
> >> [    3.734807] alloc_tag was not set
> >> [    3.735129] WARNING: CPU: 4 PID: 40 at ./include/linux/alloc_tag.h:=
130 kmem_cache_free+0x444/0x574
> >> [    3.735866] Modules linked in: autofs4
> >> [    3.736211] CPU: 4 UID: 0 PID: 40 Comm: ksoftirqd/4 Tainted: G     =
   W          6.11.0-rc3-dirty #1
> >> [    3.736969] Tainted: [W]=3DWARN
> >> [    3.737258] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2=
/2/2022
> >> [    3.737875] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> >> [    3.738501] pc : kmem_cache_free+0x444/0x574
> >> [    3.738951] lr : kmem_cache_free+0x444/0x574
> >> [    3.739361] sp : ffff80008357bb60
> >> [    3.739693] x29: ffff80008357bb70 x28: 0000000000000000 x27: 000000=
0000000000
> >> [    3.740338] x26: ffff80008207f000 x25: ffff000b2eb2fd60 x24: ffff00=
00c0005700
> >> [    3.740982] x23: ffff8000804229e4 x22: ffff800082080000 x21: ffff80=
0081756000
> >> [    3.741630] x20: fffffd7ff8253360 x19: 00000000000000a8 x18: ffffff=
ffffffffff
> >> [    3.742274] x17: ffff800ab327f000 x16: ffff800083398000 x15: ffff80=
0081756df0
> >> [    3.742919] x14: 0000000000000000 x13: 205d344320202020 x12: 5b5d37=
3038343337
> >> [    3.743560] x11: ffff80008357b650 x10: 000000000000005d x9 : 000000=
00ffffffd0
> >> [    3.744231] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008237bad0 x6 : c00000=
00ffff7fff
> >> [    3.744907] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 000000=
0000000001
> >> [    3.745580] x2 : 68d66547c09f7800 x1 : 68d66547c09f7800 x0 : 000000=
0000000000
> >> [    3.746255] Call trace:
> >> [    3.746530]  kmem_cache_free+0x444/0x574
> >> [    3.746931]  mem_pool_free+0x44/0xf4
> >> [    3.747306]  free_object_rcu+0xc8/0xdc
> >> [    3.747693]  rcu_do_batch+0x234/0x8a4
> >> [    3.748075]  rcu_core+0x230/0x3e4
> >> [    3.748424]  rcu_core_si+0x14/0x1c
> >> [    3.748780]  handle_softirqs+0x134/0x378
> >> [    3.749189]  run_ksoftirqd+0x70/0x9c
> >> [    3.749560]  smpboot_thread_fn+0x148/0x22c
> >> [    3.749978]  kthread+0x10c/0x118
> >> [    3.750323]  ret_from_fork+0x10/0x20
> >> [    3.750696] ---[ end trace 0000000000000000 ]---
> >>
> >> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab all=
ocation and free paths")
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> ---
> >>   mm/slub.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index c9d8a2497fd6..1f67621ba6dc 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2116,6 +2116,9 @@ alloc_tagging_slab_free_hook(struct kmem_cache *=
s, struct slab *slab, void **p,
> >>          if (!mem_alloc_profiling_enabled())
> >>                  return;
> >>
> >> +       if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> >> +               return;
> >> +
> > Please add a comment before this check saying something like:
> > /* slab->obj_exts might not be NULL if it was created for MEMCG account=
ing. */
> >
> > Other than that the fix seems fine to me.
> > Thanks,
> > Suren.
> >
> OK,I have already made the modification in version 2.
> >>          obj_exts =3D slab_obj_exts(slab);
> >>          if (!obj_exts)
> >>                  return;
> >> --
> >> 2.25.1
> >>
> Thanks

For all fixes to allocation tagging please:

Cc: stable@vger.kernel.org # v6.10

Thanks,
Suren.

>
> best regards
>
> Hao
>

