Return-Path: <linux-kernel+bounces-305789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F5963470
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C361C2286D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB551AD3FD;
	Wed, 28 Aug 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyTo2tSg"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0D16B388
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883099; cv=none; b=KwXlpruUI5H4MH74reei8K/HjTRjt4DJgoL/Ol+T+rIKtpmf7YoT+x6cjt6IcK82BKPKgNH8RKc8IwfxMEbufNCy7dMxa0DhSHFnZ28laTfs9KHF7U0GB1OMbrX+nOplXLm018D6l8kaEw6vv50jD65dicT582w5VaOhVrexcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883099; c=relaxed/simple;
	bh=+4ZR8TmNP149UNg/rEkmkqbp5wBf3ItFGqtlod4sc+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orXw2IvWRiNEsKs1UQVb8oi6mKC2etrkYrD7SCuSDL2aydJV/tMXKD5N/q1yrwcG7xPskQDrOjHzuJ3TnuVCh/KVJRLvI2NBqhocIjogJH1xMKNVH0jcIK036cqft8oN6ySZTtncbeeIL/MbSbndGLkKmNX2/zowXw6+qZMohdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyTo2tSg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533496017f8so9761629e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724883095; x=1725487895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cedSdGJF8fk6JLURCpMr14nIZjcEqUjClDXhK33nqo=;
        b=YyTo2tSgVStr9F/JLEqOAdUV+waOFlrRgKZ5jb4SP1FR1/PosaVWu2CmELsKVuUGtm
         eqVVhZoP4FvKkIUuxFYNufGYgkJskZ1K0hIJMbuYRyh9+SDAXYBZCgQiiDfIXRmKenvc
         4YXPkWJxBqcvh5nXF0UEHLvDe+XULXk6jbCZc50d8gBK8SESeFuVYBk7ELqdKWls9jyQ
         yFlaQjIe+PGfAL/EoTmGlbHCF5gcxCiWfuJOenAT/H9LCdQ0mF8Ri/OT//RBZ0vPIyJB
         HML75JkwFeNGdwt8aqGet5vUypAydbDjt0SDAYcsWSJpvxLzn0qudiLKJ13a+KfwpvOS
         qBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724883095; x=1725487895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cedSdGJF8fk6JLURCpMr14nIZjcEqUjClDXhK33nqo=;
        b=OqVAovMwy+yQ4Xs5dBjcB7nf30v2zXMgP2Ccct6/oxzJiA2CUR7j7VmcftlMIFmXZQ
         oSQidmse91XPoNffmZAgfZE5hZ821o7W+iem/ZCP+NzRgDZ8wdMH6sKQ5P7XwUsPr0yp
         Muu+cj2T/UOU1ED7YrVXtkUWwzuF55mxZQLFwzI7KWmnMtg01sd6Yqqtu+j0CdN6CxdH
         JVPImrccgtSCfWVSyuuLQrhsHcoggWAhTM3bL+KJ/YKhciTd+VesmHjhtUEb54t6Ja5P
         f7Ts8SgDYdZsaeoEzQShqS1/CLR5NBP0iwrSJ+Cw3sVU6mXjSLTB8P99gJFNZqCVli0d
         YndA==
X-Forwarded-Encrypted: i=1; AJvYcCWf4ReIRCVgluVOJ2zeX7LhVI3xmcOcS4QLqMw+Whxp23J2YK3mLsMD56M3u1baeo9i1+SG1Sphvp6Rbio=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUwjIEMuUfZd8BQmyYGwKOS1sfos5wCsIajYuoMvUuq/Lmozq
	WKCbEiPmOe96/ZaomE5PrIIpqt16JGa5tDH75a45Pr4dBJ9iyvObInvpleRzT417A+Er3ozl9IC
	tbqDGCvqF3XFEtZsPs0Z0BrLcWkx4D2x1+n3h
X-Google-Smtp-Source: AGHT+IE7FgxeEp3oK3h/EHwPYj0Q+GKF27lVD8LDpzLVsN055ZLe7P8ayw7s6FdJcYtn6UQg5NpMNs5TEutsWVNnHFI=
X-Received: by 2002:a05:6512:3d07:b0:533:4191:fa47 with SMTP id
 2adb3069b0e04-5353e5b1135mr381607e87.47.1724883094592; Wed, 28 Aug 2024
 15:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com>
 <pq2zzjvxxzxcqtnf2eabp3whooysr7qbh75ts6fyzhipmtxjwf@q2jw57d5qkir>
 <CAJD7tka_OKPisXGDO56WMb6sRnYxHe2UDAh14d6VX1BW2E3usA@mail.gmail.com> <zjvmhbfzxpv4ujc5v7c4aojpsecmaqrznyd34lukst57kx5h43@2necqcieafy5>
In-Reply-To: <zjvmhbfzxpv4ujc5v7c4aojpsecmaqrznyd34lukst57kx5h43@2necqcieafy5>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 15:10:56 -0700
Message-ID: <CAJD7tkZNMsw9NjE8Xh7vDhbbr2p4QPN8C3W4Jpp+-a_OXuhQLQ@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:16=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Aug 28, 2024 at 12:42:02PM GMT, Yosry Ahmed wrote:
> > On Wed, Aug 28, 2024 at 12:14=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Aug 27, 2024 at 05:34:24PM GMT, Yosry Ahmed wrote:
> > > > On Tue, Aug 27, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > [...]
> > > > > +
> > > > > +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> > > > > +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> > > > > +
> > > > > +static __fastpath_inline
> > > > > +bool memcg_slab_post_charge(void *p, gfp_t flags)
> > > > > +{
> > > > > +       struct slabobj_ext *slab_exts;
> > > > > +       struct kmem_cache *s;
> > > > > +       struct folio *folio;
> > > > > +       struct slab *slab;
> > > > > +       unsigned long off;
> > > > > +
> > > > > +       folio =3D virt_to_folio(p);
> > > > > +       if (!folio_test_slab(folio)) {
> > > > > +               return __memcg_kmem_charge_page(folio_page(folio,=
 0), flags,
> > > > > +                                               folio_order(folio=
)) =3D=3D 0;
> > > >
> > > > Will this charge the folio again if it was already charged? It seem=
s
> > > > like we avoid this for already charged slab objects below but not
> > > > here.
> > > >
> > >
> > > Thanks for catchig this. It's an easy fix and will do in v3.
> > >
> > > > > +       }
> > > > > +
> > > > > +       slab =3D folio_slab(folio);
> > > > > +       s =3D slab->slab_cache;
> > > > > +
> > > > > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependen=
cy. */
> > > > > +       if ((s->flags & KMALLOC_TYPE) =3D=3D SLAB_KMALLOC)
> > > > > +               return true;
> > > >
> > > > Would it be clearer to check if the slab cache is one of
> > > > kmalloc_caches[KMALLOC_NORMAL]? This should be doable by comparing =
the
> > > > address of the slab cache with the addresses of
> > > > kmalloc_cache[KMALLOC_NORMAL] (perhaps in a helper). I need to refe=
r
> > > > to your reply to Roman to understand why this works.
> > > >
> > >
> > > Do you mean looping over kmalloc_caches[KMALLOC_NORMAL] and comparing
> > > the given slab cache address? Nah man why do long loop of pointer
> > > comparisons when we can simply check the flag of the given kmem cache=
.
> > > Also this array will increase with the recent proposed random kmalloc
> > > caches.
> >
> > Oh I thought kmalloc_caches[KMALLOC_NORMAL] is an array of the actual
> > struct kmem_cache objects, so I thought we can just check if:
> > s >=3D kmalloc_caches[KMALLOC_NORMAL][0] &&
> > s >=3D kmalloc_caches[KMALLOC_NORMAL][LAST_INDEX]
> >
> > I just realized it's an array of pointers, so we would need to loop
> > and compare them.
> >
> > I still find the flags comparisons unclear and not very future-proof
> > tbh. I think we can just store the type in struct kmem_cache? I think
> > there are multiple holes there.
>
> Do you mean adding a new SLAB_KMALLOC_NORMAL? I will wait for SLAB
> maintainers for their opinion on that. BTW this kind of checks are in
> the kernel particularly for gfp flags.

I meant maybe in new_kmalloc_cache() pass in 'type' to
create_kmalloc_cache() and store it in struct kmem_cache (we'd want a
KMALLOC_NONE a similar for non-kmalloc caches). Having a new flag like
SLAB_KMALLOC_NORMAL would also work.

Or maybe using the flags to deduce the kmalloc cache type is fine, but
in this case I think a well-documented helper that takes in a
kmem_cache and restores a type based on the combination of flags would
be better.

I just think in this case it's easy for the flags to change from under
us here, and the code is not very clear.

Hopefully the slab maintainers will tell us what they think here, my
concerns could very possibly be unfounded.

