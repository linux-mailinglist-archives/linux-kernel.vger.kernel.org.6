Return-Path: <linux-kernel+bounces-249320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051B92EA03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BD01F23434
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E4161901;
	Thu, 11 Jul 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35vs5MdA"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384B15F40A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706123; cv=none; b=KW8o5o0yV05IjEXUqY5qqcI1FE0P19L5Ey4m0dXb0oqKWPzUe/NRitbzULZe9z36m2VMJfNJrGTqwM0LFrXre/+o2QDyuF/lwHGBRbI+mWY2RarVdgM+uRXtstnyYtiF+giyVDFLZ/Up7ZKjGn2KFLhonIH0YmjAZUqG5c12XPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706123; c=relaxed/simple;
	bh=wpmVBS1N7upgXdhIqB51MtPNKuR3Imjjucr/t0gf7ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5LagfnyG/DlpJJzL+EVmMM267SHoktBq+BoXjQoB+1eeWFErYLj+6FCI8acjqrDxQ+pzgRx490pqP5vElyxUhSrtpugS5g2bEstsWoymKm5KE5QwcMoAjt138VXC0bsmSwlw7Za0CEoMTq9tdsLV9//YW+e5xM/HWWsWjGpWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35vs5MdA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65bceed88a2so8559057b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720706121; x=1721310921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+/aiWEMrF4svKaqs+8tTNVUKOARX5jycLE0p/g9Z+Y=;
        b=35vs5MdAl+jmSdWD7gGSLPaaIYVJdOMiF62XHFrWXnHfyW5AIxP+QfGKKLFRMbslZn
         nfKwJu+S0ZqxD02t/hoG2p0/c5ISeLuKddiCR6H16gPwKY7h3X5T6ppUvTZpgMZH+KHy
         rFMaDpf91OAvvu6l+CmsSS6FjW/IZH8sm+J+8dYl8kAYlyR/qWZ4jXqZzA9yErmktkoM
         +Wsblbc3UljmitHvzZ8BP/rrhfVhXbBwHBNcYTe4cRMb46gk0a7ZhCSb8ThzN5l97UcX
         Sj2KLWLRK5EToRN9wbUrEd0uD6X5n6apZ6ZEyMtXxr7DHxI54W8Y0e1pkVJP5V5EOe1N
         IMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706121; x=1721310921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+/aiWEMrF4svKaqs+8tTNVUKOARX5jycLE0p/g9Z+Y=;
        b=kGy09c26mKo8KCukVrMUYhdadPzL1o7qEzG5lH/HgjMjDT/PYe4tTq4a1OZwBwiAFh
         WOaB/rh/ceM9fnMhSw1OWtt8aIZ+bthc3I5T+h5aLLrBTohDeMEKFUe0xiqtLhWAipqT
         56yvo+j/AuejBZAZQ3FTklBkNpLKn07QmFkKI5A6Gb/SgGSxNyygVONhntR5RS3ZI+mS
         J9PBxsRT3CQovEP3XjbOCW6IfRhqNe7dyD+AJfEzEhTm5ZW7nOgC4snk5AzOkROy9jx8
         1l3RhlyvGvxFRFFa8lwhA4IM9YfYDcDWkncUOhCdL/OAf2r+FOzF4i0JQE3+Ooc7Dhlp
         guIw==
X-Forwarded-Encrypted: i=1; AJvYcCVb9eNESJ81tCG6u+QzYCzex+LX/kWtIgVIOUGGW2EZ/82n8Z+xSRrgjWVOakf/9nG49+ewqTpDrWuR6kWgvmDscNWE+bGJQIpH/ikO
X-Gm-Message-State: AOJu0YzAj6Dw6TfQKkNHMf5nNh9K6e73HpeDgC7T6aMZSw7e7zEwBABm
	ZY+9waHIfsHGtNyIvYf8KFBkT65W7LYBj/w9fjejoz6AKUE4Xp95AphSJrHAf9pp08uolEMlBDz
	dAP4kxR3cYPC1imevxTb7AlUJ5pBjZ/FlNo4f
X-Google-Smtp-Source: AGHT+IFv5vpfbKostC5g3aePXzjWYD3i27LtxoUIHoL3ccZDFdBI6HAF5vES5pWsvRQq4hZ0i8kHGMMT6kw5GJg/5U0=
X-Received: by 2002:a05:690c:30f:b0:643:ed61:11bb with SMTP id
 00721157ae682-658ee791041mr107431767b3.7.1720706120508; Thu, 11 Jul 2024
 06:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710054336.190410-1-alexs@kernel.org> <20240710054336.190410-2-alexs@kernel.org>
 <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz> <9b1384e7-e75d-4d71-8798-0d47c33cece6@gmail.com>
In-Reply-To: <9b1384e7-e75d-4d71-8798-0d47c33cece6@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 06:55:07 -0700
Message-ID: <CAJuCfpEJKLi2kzwWxdDCfSHu0gtRtLAkUrovtUpBwQhftbF+1w@mail.gmail.com>
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
To: Alex Shi <seakeel@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, alexs@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Randy Dunlap <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Masahiro Yamada <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:49=E2=80=AFAM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 7/11/24 4:11 PM, Vlastimil Babka wrote:
> > On 7/10/24 7:43 AM, alexs@kernel.org wrote:
> >> From: "Alex Shi (Tencent)" <alexs@kernel.org>
> >>
> >> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> >> extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
> >> memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't se=
e
> >> the necessary to enable SLAB_OBJ_EXT for MEMCG.
> >>
> >> Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
> >> alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
> >> the alloc_slab_obj_exts() return 0 for good. change its return value t=
o
> >> '-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessa=
ry
> >> code from MEMCG but !SLAB_OBJ_EXT.
> >>
> >> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
> >
> > This seems just wrong to me. The memcg hooks for slab do use obj_ext. Y=
ou
> > made alloc_slab_obj_exts() return -1 and that will just fail all memcg
> > charging (unless alloc profiling selects obj_ext). The kernel will appe=
ar to
> > work, but memcg charging for slab won't happen at all.
> >
> > So no, it can't be decoupled for slab, only for pages/folios (patch 1).
>
> Hi Vlastimil,
>
> Thanks a lot for clarification! Yes, the patch isn't correct.
>
> Just forgive my stupidity, why the memcg needs SLAB_OBJ_EXT?

Because when CONFIG_MEMCG_KMEM=3Dy, slabobj_ext contains obj_cgroup
(see: https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/memco=
ntrol.h#L1593)
and that's used for memcg accounting. Look into this call chain:

kfree
  slab_free
    memcg_slab_free_hook
      __memcg_slab_free_hook
        obj_cgroup_uncharge

>
> And why we need to alloc_slab_obj_exts() at line 3019 with !slab_obj_exts=
?
> 3015         for (i =3D 0; i < size; i++) {
> 3016                 slab =3D virt_to_slab(p[i]);
> 3017
> 3018                 if (!slab_obj_exts(slab) &&
> 3019                     alloc_slab_obj_exts(slab, s, flags, false)) {
> 3020                         obj_cgroup_uncharge(objcg, obj_full_size(s))=
;
> 3021                         continue;
> 3022                 }
>
> Thanks!
> Alex
>
> >
> >
> >> Cc: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Yoann Congal <yoann.congal@smile.fr>
> >> Cc: Masahiro Yamada <masahiroy@kernel.org>
> >> Cc: Petr Mladek <pmladek@suse.com>
> >> ---
> >>  init/Kconfig | 1 -
> >>  mm/slab.h    | 6 +++---
> >>  mm/slub.c    | 6 +++---
> >>  3 files changed, 6 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/init/Kconfig b/init/Kconfig
> >> index 26bf8bb0a7ce..61e43ac9fe75 100644
> >> --- a/init/Kconfig
> >> +++ b/init/Kconfig
> >> @@ -965,7 +965,6 @@ config MEMCG
> >>      bool "Memory controller"
> >>      select PAGE_COUNTER
> >>      select EVENTFD
> >> -    select SLAB_OBJ_EXT
> >>      help
> >>        Provides control over the memory footprint of tasks in a cgroup=
.
> >>
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index 8ffdd4f315f8..6c727ecc1068 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(st=
ruct slab *slab)
> >>      return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
> >>  }
> >>
> >> -int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >> -                        gfp_t gfp, bool new_slab);
> >> -
> >>  #else /* CONFIG_SLAB_OBJ_EXT */
> >>
> >>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> >> @@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(st=
ruct slab *slab)
> >>
> >>  #endif /* CONFIG_SLAB_OBJ_EXT */
> >>
> >> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >> +                    gfp_t gfp, bool new_slab);
> >> +
> >>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache =
*s)
> >>  {
> >>      return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index cc11f3869cc6..f531c2d67238 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache=
 *s, struct slab *slab, void **p,
> >>
> >>  #else /* CONFIG_SLAB_OBJ_EXT */
> >>
> >> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *=
s,
> >> -                           gfp_t gfp, bool new_slab)
> >> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >> +                    gfp_t gfp, bool new_slab)
> >>  {
> >> -    return 0;
> >> +    return -1;
> >>  }
> >>
> >>  static inline void free_slab_obj_exts(struct slab *slab)
> >

