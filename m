Return-Path: <linux-kernel+bounces-235306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65191D365
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969A81F210A0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18310153503;
	Sun, 30 Jun 2024 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkubfGsL"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F46BFD4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719775256; cv=none; b=KoZwEvDJb+QPoCUt4e4ULtf6W2xlPJY+izTTPwwYlt6+cZNQGWQUYqvGBcVA4OIjUK2+piRG6U8E/9t+JfabVHjyWaxqfkF88rviWDkjDa01XEagPvvyrvk/5kl+hSQrw5Q3Q3kjr9a4iXPXDFK10T0wvacS41n/Y3dCMXs7z+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719775256; c=relaxed/simple;
	bh=Y9TOcpLulOZFrN5XtJjl7Oi6Aq55ZZoIpVs239hA5Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi3E0BAfEtmmMLe2TTuqf2HLWmNaS/qPMW+VO9r7uhxvZ4c7AH3OLqF3sC3ulFmfEvXp03VKMNLKSBLuWzsPzOfOuhSiymT3vu7YrSYE+eTgLSXbL3cTXu75uBujXqKujEOLVgFxitwJFN8ppNBKFqPKpKc70bwYu6udxO9Xi4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkubfGsL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-643f1ee4b3cso21164927b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719775254; x=1720380054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C06Lxu2qWtoIPdhV6FpMtGF74vdhlrNGojrNRfofH9A=;
        b=MkubfGsLlC4Dk6HK5q0QoaTKgCIX63n3AlJn/CCWgL+Fp6OZEbkXLU00yMyn/SdGlJ
         VgFxBbkt+zS7IccYlkPvX3jUbVSZlIeHRyJstR02bQoDphtV6Q+yi/77XBx1I3C3XeOs
         +SOTH1rKirgNem3dgk5dIi0ZWRlJeZjh5kqhG8XKI5NDgGLYmrPMU8PAzZV9Z9Py+lE5
         QID6guNmmlvq8D2hqfRwzOqMGoutjH5UO2z2/o+cxPdKpJj3mTeKdXzh/Vxc0iS5///g
         rj1wX0nMSb6mXBfU4aIXuiUAzXUy8tbtJ4hMlRQpd7G6zopL7NouAlmMz2TrM2aldLvr
         3Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719775254; x=1720380054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C06Lxu2qWtoIPdhV6FpMtGF74vdhlrNGojrNRfofH9A=;
        b=qWAkHlbc1qg5RjOuPkvozTYB3oNUJS7ntm33bgBQz7XWTPygrLHzMuw6TRtxiAgCje
         ScSvJutcui++FiqTjpmNa9U7ueLjtsUAAK7CN1n8zpAIuOPXH9XdR04YN2rPGlR9xtu+
         uJDyy/WQtrOEIds1H4l6qmGF8aFTvmQcfL5yR1yj502X7+HHDfMrkl1l35M4uQuZe6U5
         5urrL5GC2PebJgmHYp8sbuv6qSNXJIwe6+ARwfDWXj9cF2g0/DyYEjJrEnAPDOeanKEK
         7d9dsavC2p22+uQzaUTFq2NVKD/Uq0HRHlV7T1SYQoaA5EQqalfw42AoBkTsylUScZgP
         JZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVyGPP46eFFZEqKtwazKEfmAqLIbLH/WJwswkgMtUzl62W1pxXdxzDrsl3ZFpLO46U9UNIBCJ7KxHcng2Pr+XZ2xT+GF1xo2w24q2/5
X-Gm-Message-State: AOJu0YxYhRzL8v5pyXF/2HTcPFND06jPrHRZKfMTFF5jrVQsk6KOML97
	RH0oN+R9I6vOJGUQi4HomCPSihNuL26aah+69Wz7LpnZ45ToXR3z0WftfUVK3ZfnwhnMOf5lgXp
	200GRFQSkpkKK1eKrdiN3Sa2HJCG4432kpkFz
X-Google-Smtp-Source: AGHT+IGCOqYO5pqQ2PG6c8jd1PMpmtTfTOZf69o8IXJqeg8eV2Vim7tcDe/Fn0eirZ3xG+EnMPI+pXn4eXzAftJKWyQ=
X-Received: by 2002:a81:60c2:0:b0:647:eaea:f4d9 with SMTP id
 00721157ae682-64c73ae7b6dmr30365037b3.52.1719775253512; Sun, 30 Jun 2024
 12:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614225951.3845577-1-surenb@google.com> <18a30d5c-abf3-4ceb-a7fd-2edfd8bee2a8@suse.cz>
In-Reply-To: <18a30d5c-abf3-4ceb-a7fd-2edfd8bee2a8@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 30 Jun 2024 12:20:42 -0700
Message-ID: <CAJuCfpFPDAjE5aNYxTngxzAusz_9QkOdnELSRNadi2Sxb4O=oA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/slab: fix 'variable obj_exts set but not used' warning
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 6/15/24 12:59 AM, Suren Baghdasaryan wrote:
> > slab_post_alloc_hook() uses prepare_slab_obj_exts_hook() to obtain
> > slabobj_ext object. Currently the only user of slabobj_ext object in
> > this path is memory allocation profiling, therefore when it's not enabl=
ed
> > this object is not needed. This also generates a warning when compiling
> > with CONFIG_MEM_ALLOC_PROFILING=3Dn. Move the code under this configura=
tion
> > to fix the warning. If more slabobj_ext users appear in the future, the
> > code will have to be changed back to call prepare_slab_obj_exts_hook().
> >
> > Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allo=
cation and free paths")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406150444.F6neSaiy-lkp=
@intel.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> But it seems to me we could remove the whole #ifdef if current->alloc_tag
> (which doesn't exist with !MEM_ALLOC_PROFILING) had an access helper, or
> there was a alloc_tag_add_current() variant?

Hmm. I'll check if current->alloc_tag is the only reason for this
ifdef. If so then you are correct and we can simplify this code.

>
> > ---
> >  mm/slub.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1373ac365a46..4927edec6a8c 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3902,7 +3902,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
> >                         unsigned int orig_size)
> >  {
> >       unsigned int zero_size =3D s->object_size;
> > -     struct slabobj_ext *obj_exts;
> >       bool kasan_init =3D init;
> >       size_t i;
> >       gfp_t init_flags =3D flags & gfp_allowed_mask;
> > @@ -3945,9 +3944,11 @@ bool slab_post_alloc_hook(struct kmem_cache *s, =
struct list_lru *lru,
> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >                                        s->flags, init_flags);
> >               kmsan_slab_alloc(s, p[i], init_flags);
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> >               if (need_slab_obj_ext()) {
> > +                     struct slabobj_ext *obj_exts;
> > +
> >                       obj_exts =3D prepare_slab_obj_exts_hook(s, flags,=
 p[i]);
> > -#ifdef CONFIG_MEM_ALLOC_PROFILING
> >                       /*
> >                        * Currently obj_exts is used only for allocation=
 profiling.
> >                        * If other users appear then mem_alloc_profiling=
_enabled()
> > @@ -3955,8 +3956,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
> >                        */
> >                       if (likely(obj_exts))
> >                               alloc_tag_add(&obj_exts->ref, current->al=
loc_tag, s->size);
> > -#endif
> >               }
> > +#endif
> >       }
> >
> >       return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
> >
> > base-commit: c286c21ff94252f778515b21b6bebe749454a852
>

