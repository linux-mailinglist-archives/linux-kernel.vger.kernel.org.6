Return-Path: <linux-kernel+bounces-288602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E120A953C49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993AE282B17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E814F100;
	Thu, 15 Aug 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fniE6h9g"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98D14D457
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755634; cv=none; b=jxuehCs/WL9cNB4fSXT1LTlIBF9mY4q/FGcP0qdHOMrV5nCc9hAgjD0kE4Fj7XDDMAWx0ri/8TPzE2IvjqMzrgrc5yM0HLwQfOuAH493SnrziRypr7wcw8toPckQhg8/6lLHSImHC/dMzvBbM3AH+J2qWuJirFX/NAfA/qhH6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755634; c=relaxed/simple;
	bh=OS5O+lKoongcRl+Mrjb66FfusTzxBDkGpVoa+vMbk9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3IP9293VCSrJ7xOouTn63rCe0ZSXBfkBRR6cbqkb7EWeZ8IXfUCsYQY7ZfnDQJg1iPd2Kz8ihXvDRJ6uDWUgAtiks1g9Of/ukjSMjp0vD6BvK23KALnAyAbZCO0PftG3nfp+jtfyiYcZapXON0YoYzIS36hL27guW7D9nhHN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fniE6h9g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42819654737so8582685e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723755631; x=1724360431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjvo4uPexfb1MMhk6PP8N9GbbHa3wKGfn+pEz00q/d0=;
        b=fniE6h9gsEMqeP8bsXeKlHoqP/zDETzjjX6oLp/1y79KJfGt8qKX4arPcT/lULaRA9
         /xK1bxLdPLHU2FnQ4RtIZ1URjYReZnx1TYoZ42meQjITDkFJ/F9LFO4/13Kz0sVvkUgY
         7yHMOd/QHTV97JSnjHP8IUtXjdM++9gUT6qj1DOLWSHvEaPLNO0CBmPItKVdu/7ASvAk
         ADYAXRPRbEnCvGx7G1m1226W3uATc2kb4HNYn8Bt7yWzDNJUB3iZ9KOoBY0t7kB0sCFB
         E0ilo22d1yEMHkJubkVi39cGfyZz4ZoE866m60vuH5hY87d4AeP+kbw2R3HRTIFtH+9o
         E35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755631; x=1724360431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjvo4uPexfb1MMhk6PP8N9GbbHa3wKGfn+pEz00q/d0=;
        b=iVsi0oXs/qkcofqRffBq+VE6Jt4vME6VVUloVkZ5dDLeUMml8aoTtag7gBgxScY0mI
         fNjqGV9Dna3ybSp4KkKgjHOvH8HmiVQ3/7oSqeuUY5AktDxpwPAHTdJNH+tmcjen5Qf/
         2sfMp/ehFQHlPOeRVCzY+m+R67nZRo0wJINmyTVeZ1kTouJtWJEKoZVcHSMdraXPXWJ3
         PlwbpJ59KcvcOguXY379wEz5W6O6GQp76CBuEAmjeL6VXbuW2lJslE0HzduqQELCH0e9
         ebD8Xj2BdXqACOKWrFs5sKw5qCQcug3w7jehCnIeLxXwwQCEioW2UgLXbKsWl4o4V6Zs
         q6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwqeNfH8/AlBGYXa55I7mXSacaraN3uRyalhoWJ34rA+hf7qOkHAWmN07uE4/tahii0dX3LCB6CRoP8PrlwAUFteuleTy7avAQaTt3
X-Gm-Message-State: AOJu0Yw6CSPWRAWO9SG7Cu4iwQ3TH0oc5sUcx7TFWaNfdSEu1HJnoiS7
	SLdWA9H5OmNiFF58fQwDke9DS2DGUKkJkthHh4zeSC34gYuzWYjq3i/HYWuI8nx5fl2tHMQ53nR
	yvZ1LkY3f2mvYgntCdlEAARmO3IQTjw3eiKXn
X-Google-Smtp-Source: AGHT+IHKj1OuxluKkYou3AbmGl6SzajZmItgO2FzpHOwuARp8VcDhdPN/pbC85SdbUGusmDHzWiKVQMdH8ZFkbMcFTg=
X-Received: by 2002:a5d:54cb:0:b0:368:6f30:ddf1 with SMTP id
 ffacd0b85a97d-371946d0ac3mr353594f8f.59.1723755630555; Thu, 15 Aug 2024
 14:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815072113.30288-1-hao.ge@linux.dev>
In-Reply-To: <20240815072113.30288-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Aug 2024 14:00:16 -0700
Message-ID: <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Add check for s->flags in the alloc_tagging_slab_free_hook
To: Hao Ge <hao.ge@linux.dev>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org, 
	kent.overstreet@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:21=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> When enable CONFIG_MEMCG & CONFIG_KFENCE & CONFIG_KMEMLEAK,
> the following warning always occurs,This is because the
> following call stack occurred:
> mem_pool_alloc
>     kmem_cache_alloc_noprof
>         slab_alloc_node
>             kfence_alloc
>
> Once the kfence allocation is successful,slab->obj_exts will not be empty=
.
> Since in the prepare_slab_obj_exts_hook function,we perform a check for
> s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE),the alloc_tag_add functio=
n
> will not be called as a result.Therefore,ref->ct remains NULL.
>
> However,when we call mem_pool_free,since obj_ext is not empty,
> it eventually leads to the alloc_tag_sub scenario being invoked.
> This is where the warning occurs.

Ok, I was trying to understand why "Once the kfence allocation is
successful,slab->obj_exts will not be empty.". alloc_slab_obj_exts()
has to be called to create slab->obj_exts. Normally that is done in
prepare_slab_obj_exts_hook() which has the s->flags & (SLAB_NO_OBJ_EXT
| SLAB_NOLEAKTRACE) check and the cache that kfence_alloc() uses here
is the object_cache (passed from mem_pool_alloc()) which has
SLAB_NOLEAKTRACE:
https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/kmemleak.c#L453.
Therefore, prepare_slab_obj_exts_hook() should have skipped it and did
not create the slab->obj_exts. So, it must have been called from
account_slab() or __memcg_slab_post_alloc_hook() to create
slab->obj_exts for memcg accounting in slab->obj_exts.objcg. Ok, now I
understand why you need the CONFIG_MEMCG & CONFIG_KFENCE &
CONFIG_KMEMLEAK combination.
Please confirm that slab->obj_exts creation is happening the way I
described above and for those reasons and if so, please update the
description of this patch to explain that.

>
> So we should add corresponding checks in the alloc_tagging_slab_free_hook=
.
> For __GFP_NO_OBJ_EXT case,I didn't see the specific case where it's
> using kfence,so I won't add the corresponding check in
> alloc_tagging_slab_free_hook for now.
>
> [    3.734349] ------------[ cut here ]------------
> [    3.734807] alloc_tag was not set
> [    3.735129] WARNING: CPU: 4 PID: 40 at ./include/linux/alloc_tag.h:130=
 kmem_cache_free+0x444/0x574
> [    3.735866] Modules linked in: autofs4
> [    3.736211] CPU: 4 UID: 0 PID: 40 Comm: ksoftirqd/4 Tainted: G        =
W          6.11.0-rc3-dirty #1
> [    3.736969] Tainted: [W]=3DWARN
> [    3.737258] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/=
2022
> [    3.737875] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    3.738501] pc : kmem_cache_free+0x444/0x574
> [    3.738951] lr : kmem_cache_free+0x444/0x574
> [    3.739361] sp : ffff80008357bb60
> [    3.739693] x29: ffff80008357bb70 x28: 0000000000000000 x27: 000000000=
0000000
> [    3.740338] x26: ffff80008207f000 x25: ffff000b2eb2fd60 x24: ffff0000c=
0005700
> [    3.740982] x23: ffff8000804229e4 x22: ffff800082080000 x21: ffff80008=
1756000
> [    3.741630] x20: fffffd7ff8253360 x19: 00000000000000a8 x18: fffffffff=
fffffff
> [    3.742274] x17: ffff800ab327f000 x16: ffff800083398000 x15: ffff80008=
1756df0
> [    3.742919] x14: 0000000000000000 x13: 205d344320202020 x12: 5b5d37303=
8343337
> [    3.743560] x11: ffff80008357b650 x10: 000000000000005d x9 : 00000000f=
fffffd0
> [    3.744231] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008237bad0 x6 : c0000000f=
fff7fff
> [    3.744907] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 000000000=
0000001
> [    3.745580] x2 : 68d66547c09f7800 x1 : 68d66547c09f7800 x0 : 000000000=
0000000
> [    3.746255] Call trace:
> [    3.746530]  kmem_cache_free+0x444/0x574
> [    3.746931]  mem_pool_free+0x44/0xf4
> [    3.747306]  free_object_rcu+0xc8/0xdc
> [    3.747693]  rcu_do_batch+0x234/0x8a4
> [    3.748075]  rcu_core+0x230/0x3e4
> [    3.748424]  rcu_core_si+0x14/0x1c
> [    3.748780]  handle_softirqs+0x134/0x378
> [    3.749189]  run_ksoftirqd+0x70/0x9c
> [    3.749560]  smpboot_thread_fn+0x148/0x22c
> [    3.749978]  kthread+0x10c/0x118
> [    3.750323]  ret_from_fork+0x10/0x20
> [    3.750696] ---[ end trace 0000000000000000 ]---
>
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab alloca=
tion and free paths")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  mm/slub.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..1f67621ba6dc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2116,6 +2116,9 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, =
struct slab *slab, void **p,
>         if (!mem_alloc_profiling_enabled())
>                 return;
>
> +       if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> +               return;
> +

Please add a comment before this check saying something like:
/* slab->obj_exts might not be NULL if it was created for MEMCG accounting.=
 */

Other than that the fix seems fine to me.
Thanks,
Suren.


>         obj_exts =3D slab_obj_exts(slab);
>         if (!obj_exts)
>                 return;
> --
> 2.25.1
>

