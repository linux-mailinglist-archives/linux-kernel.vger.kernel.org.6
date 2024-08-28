Return-Path: <linux-kernel+bounces-305606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B496311B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBAB2867A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B313775E;
	Wed, 28 Aug 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lb4NItQ7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EA1ABEC4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874164; cv=none; b=iDV6Pf2kqkhvUSc+px7rYm6KrmHpngU8LmsTNMN/ULoURoqmAgWQTc5AVTUJt7fY5rtARhuKmAK8CPVTKMr3XYW/AzIi5weobQU39mYpak8zBdTYvz1Iv2oGQ6JSNGqkwtdAbAYxaAgIHHNvVAUE+xFhAT7jxirpd8OWSGhcZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874164; c=relaxed/simple;
	bh=HQBqbI3vqc3Bcx3pNu+VZlp0p9LqbFxV4bHBirX8AkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrdHHiPq9J0/w9bRzQbuqFlMPbxBire9HBWE0ELOUV5S72dnI1lnZ5zD17HHKF7D5i/tsVt67sj2w/HBtI/dJ24QNlmPUXuIagw+zTfz95qx2Y6DPLYsBWIoVY8fLvOVtYWWum/+4oym73e7pNt6WT3fb+gfA9JdAFB30sdd/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lb4NItQ7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533463f6b16so8397648e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724874161; x=1725478961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYxxPvPoeqG3UbrzSs+hI/pT48jtLhwVkJrK0KmWMu8=;
        b=Lb4NItQ7zlEwgcjLsvUyd9agUgBSTcF8LS8HJshm4KNkUqVIaunaf/ZYoMWvjKgDDk
         jLJWemC5OSX7VcXVUJic5YjiFYb8PHmuJrL6VtVzycRfkXy95mRSJ0RrXA1Al5Vspm0Z
         iKs7+ZRQkyMEPhJ07ZgwEBZRk0HcW2rbLiMEasbxYjtSP0MJ7vzgZRUM9mU3XO3dJaVt
         zWymKuE7W9cOjFQXDUdsOOdQ8AiDW47cko8ff/ZE7j50TS+3VdXjpO047y7uSI5OYUqm
         e1aZt88VTXJDF0vEcjFzqXN+W0zUqT+rB+Yor/yZ1+Z653kclF6jXx4c/xmkT9VIcAI4
         eA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874161; x=1725478961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYxxPvPoeqG3UbrzSs+hI/pT48jtLhwVkJrK0KmWMu8=;
        b=KFi2AvfXgBJHswIQPNCSMvMEtsENbkCniWrDOsT/JHY6XKbRPxXCItxx5IPbeEA0cU
         ZxuogeTAFkpkCJehqnPScLLshcbm/XW2O33IM179ffAGyTBwCb2OyU8wJYvZnJajN3a4
         eG0vNTyiS5WPMvfPAeZbtRCHKy3UseZLEzGgMEicL7L69MAjqZ4EgexOw8uUohHsBl5w
         8sx3F6jIPQ6ljQtXVpp8Iy2kBMrXX4Xb8kOG+R0DWoUZr7A4YEj9F1AmiRw+NuvQ90Uy
         PKmdUsveMklydSnNXdAwocwZC5pGWz+nmVhYci76L6qLl8ZAnowwrCtiiBhqYiwP4YaC
         7IdA==
X-Forwarded-Encrypted: i=1; AJvYcCXlhoQO2YfRds9dK69OW/FvGmhn3ldYGVb/Mphp8zi/9EfJ39xZqozVGfqC5F6qPFAQmDNEY7djQvTrGJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClfhpsM0XmT/X36aQ4wq6KMk9izmMQKbf5sQrxJCzp0YDJzi3
	2jHRF4nncPLwSM+E7E3czkoYjhBF3YgkdnPSpqt24RkQimSJdSXqdwmbhwsUznM94Uhx9mJ1z7Q
	J7sGneo741cJkMFBr16KmW+heR+bE3MsPBMiv
X-Google-Smtp-Source: AGHT+IHVBKj0gkQMxydj+pmHF8KhrUkMDl4LVeZT6YLJm4E2jrO8UA2WAlyIoAwfI9rEvm7k6H5Ce6NeBGCzBafM8OM=
X-Received: by 2002:a05:6512:3b8c:b0:52c:c5c4:43d2 with SMTP id
 2adb3069b0e04-5353e5b81f3mr214494e87.47.1724874159898; Wed, 28 Aug 2024
 12:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkawaUoTBQLW1tUfFc06uBacjJH7d6iUFE+fzM5+jgOBig@mail.gmail.com> <pq2zzjvxxzxcqtnf2eabp3whooysr7qbh75ts6fyzhipmtxjwf@q2jw57d5qkir>
In-Reply-To: <pq2zzjvxxzxcqtnf2eabp3whooysr7qbh75ts6fyzhipmtxjwf@q2jw57d5qkir>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 12:42:02 -0700
Message-ID: <CAJD7tka_OKPisXGDO56WMb6sRnYxHe2UDAh14d6VX1BW2E3usA@mail.gmail.com>
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

On Wed, Aug 28, 2024 at 12:14=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Aug 27, 2024 at 05:34:24PM GMT, Yosry Ahmed wrote:
> > On Tue, Aug 27, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> [...]
> > > +
> > > +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> > > +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> > > +
> > > +static __fastpath_inline
> > > +bool memcg_slab_post_charge(void *p, gfp_t flags)
> > > +{
> > > +       struct slabobj_ext *slab_exts;
> > > +       struct kmem_cache *s;
> > > +       struct folio *folio;
> > > +       struct slab *slab;
> > > +       unsigned long off;
> > > +
> > > +       folio =3D virt_to_folio(p);
> > > +       if (!folio_test_slab(folio)) {
> > > +               return __memcg_kmem_charge_page(folio_page(folio, 0),=
 flags,
> > > +                                               folio_order(folio)) =
=3D=3D 0;
> >
> > Will this charge the folio again if it was already charged? It seems
> > like we avoid this for already charged slab objects below but not
> > here.
> >
>
> Thanks for catchig this. It's an easy fix and will do in v3.
>
> > > +       }
> > > +
> > > +       slab =3D folio_slab(folio);
> > > +       s =3D slab->slab_cache;
> > > +
> > > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. =
*/
> > > +       if ((s->flags & KMALLOC_TYPE) =3D=3D SLAB_KMALLOC)
> > > +               return true;
> >
> > Would it be clearer to check if the slab cache is one of
> > kmalloc_caches[KMALLOC_NORMAL]? This should be doable by comparing the
> > address of the slab cache with the addresses of
> > kmalloc_cache[KMALLOC_NORMAL] (perhaps in a helper). I need to refer
> > to your reply to Roman to understand why this works.
> >
>
> Do you mean looping over kmalloc_caches[KMALLOC_NORMAL] and comparing
> the given slab cache address? Nah man why do long loop of pointer
> comparisons when we can simply check the flag of the given kmem cache.
> Also this array will increase with the recent proposed random kmalloc
> caches.

Oh I thought kmalloc_caches[KMALLOC_NORMAL] is an array of the actual
struct kmem_cache objects, so I thought we can just check if:
s >=3D kmalloc_caches[KMALLOC_NORMAL][0] &&
s >=3D kmalloc_caches[KMALLOC_NORMAL][LAST_INDEX]

I just realized it's an array of pointers, so we would need to loop
and compare them.

I still find the flags comparisons unclear and not very future-proof
tbh. I think we can just store the type in struct kmem_cache? I think
there are multiple holes there.

