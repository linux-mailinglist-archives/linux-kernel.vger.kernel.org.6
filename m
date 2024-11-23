Return-Path: <linux-kernel+bounces-419052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE89D68F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A88161490
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3633183CBE;
	Sat, 23 Nov 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXCHC26t"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF32A95C;
	Sat, 23 Nov 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362776; cv=none; b=jsrwHF6xa2oRiRIhTY5jTtJPqvkdPLM3G4wJQPVkG8S9xhHNNWwXRp4dxpMNxsNLKon9TukYwHG0Imv/WbZhnOMZgD4BMisHPLeW+/J3lPmwVdhg7VIfYgen63/axN9xLT5gWGyX8LGgSrD0AbW4RoAIOqjr3xgPkbE0TYILFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362776; c=relaxed/simple;
	bh=sjC3IUjasRJe3e325xkgqJHUMJHoA8hCRWVgcuAEQ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiMMvtMSwU3ckWCO6vH/H4CUmeT2YsypLarrPXucxAWdGD0Hd3v/QaX5qDAcfOnBST1GVf5AH4qwmibm/FoMWY8ddd4/GHyBvyQsf0BlkJICFJdZN0qX2RODndUL07OopXiHl7EAg9sqsBS6l1X/6ieUTGkXU7t0upGyaGCoRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXCHC26t; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso3985365a12.2;
        Sat, 23 Nov 2024 03:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732362773; x=1732967573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpYeWg5tLqXU6LNxh+IvItU4XvA2SjRZtV5zUxnv8kU=;
        b=IXCHC26t82vlckGgxEbSO1uDCEkcBp8NvvyjERH/ErlT8erDDzTuWRFgiv8fzG/AiG
         eJqCexvgou1GJ8jHBw4RgXn1rgdOlyH41e5CgcvaMq3NqNOY2Yq7A01WtTJQVHOSdV9i
         7vma0PvxbZP7zfpyx6Fpiur6yX9l12ps9rH4YDkrVk2Ag3kNMRNsvqfFk5T2tu1M0MKQ
         APHDA9xVPDidYnUhstvFiFj4SgCH7eZJrsFRqyxxVCqCoBdj3hWDx3oP0kg2Xdlql82j
         ZoAYhoV3k+o0BKO2u5+C2SPltsRESzt2X4m7nO0nLvJpuYWOSqgB3MSm+jagtfYSQC35
         X6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732362773; x=1732967573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpYeWg5tLqXU6LNxh+IvItU4XvA2SjRZtV5zUxnv8kU=;
        b=ffz1YwytiA4jNYQQCfs7xBt/Jm/djM2Ju9JAQHRDl+oalqTAdMDEwCeKpkZAnM/1wP
         0O+QXkJuRPNpTd9iPoo0GM3xojslXzsgTlLdTz7wgRF8wF9SkNRieh70hoENuTKLQwYm
         hkkf1enRpBqCtQf6b8GZMEEuqjXmTXd8rwt4WCi/zAQW/+M5D6HV9geQI/CbR9dtZlZK
         OgKdcew2frs2E/ZeanVBaOyhJv57nbSWE6fHNgy3469PSxfJiIv+74IkXv1jlsUMPpzj
         30rIafUEyxxRfLoRL4cH4LGTKobsTNd+c/N1hNSWHtjOim4KlXjB9OJMxcz8ae03ZZZh
         KjKg==
X-Forwarded-Encrypted: i=1; AJvYcCVtwIGQTuD2LVMaZPHWAJ7nU2VhsOKPrpjPCoouHxAcdZsCYzWIdlhOo1FeUJa89+gKmBAaKG5a+NI=@vger.kernel.org, AJvYcCX2XD6emwU/bhMAKN5MmiEazwMuib0+eYQL4xTJos82L82EuEYTVvoZOjKUGSFU2sxjp5hm1H7FJ5OxtMnh@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUzoiCsgTmPsuZMOMrJuVbt4B/GkLu+rmd5kRxQCwbVF7ZsLw
	AQoOW+k23qtRg8SnSGqSEe/lUgbz+lmM5K3ogbCjFiJHUMlUkm4C1Uq9BcYvgWEw+ajYb/ESEIt
	QsUd7lU1Lw4Azia2w4LlI5uqRVPs=
X-Gm-Gg: ASbGncsI/AeMdJ0P8DnIA3pAm8DTU5X3ffn+DxGuXBbBEfPccoATBEcuY/tYj3lgXyO
	BfwzhOcfwgZ5+9YVtEdWQPQD6JbU43VY=
X-Google-Smtp-Source: AGHT+IHZDBiZmyWqeLhXSmjfcdThvhX62TCZ1Dr988XqXFxyRIG7FRDsSiOVKVoAAXux0b/fJDpaxKEpMiTjnNi10js=
X-Received: by 2002:a05:6402:4582:b0:5cf:f319:452e with SMTP id
 4fb4d7f45d1cf-5d0207cc7d3mr5454420a12.34.1732362773116; Sat, 23 Nov 2024
 03:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161443.34667-1-haowenchao22@gmail.com>
 <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com> <CAGsJ_4w-u703LbrmnsgkNVzpFwFwY7tO9mFoo1RXGk3rb_r3mw@mail.gmail.com>
In-Reply-To: <CAGsJ_4w-u703LbrmnsgkNVzpFwFwY7tO9mFoo1RXGk3rb_r3mw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 23 Nov 2024 19:52:17 +0800
Message-ID: <CAK1f24meJBDA1wzX56=2y2NQm7BVP6OudFXJuGnZuUFnZKUh+A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swap-in fallback/fallback_charge
 counters
To: Barry Song <21cnbao@gmail.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Usama Arif <usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, Nov 23, 2024 at 10:36=E2=80=AFAM Lance Yang <ioworker0@gmail.com>=
 wrote:
> >
> > Hi Wenchao,
> >
> > On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM Wenchao Hao <haowenchao22@gmai=
l.com> wrote:
> > >
> > > Currently, large folio swap-in is supported, but we lack a method to
> > > analyze their success ratio. Similar to anon_fault_fallback, we intro=
duce
> > > per-order mTHP swpin_fallback and swpin_fallback_charge counters for
> > > calculating their success ratio. The new counters are located at:
> > >
> > > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
> > >         swpin_fallback
> > >         swpin_fallback_charge
> > >
> > > Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> > > ---
> > > V2:
> > >  Introduce swapin_fallback_charge, which increments if it fails to
> > >  charge a huge page to memory despite successful allocation.
> > >
> > >  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
> > >  include/linux/huge_mm.h                    |  2 ++
> > >  mm/huge_memory.c                           |  6 ++++++
> > >  mm/memory.c                                |  2 ++
> > >  4 files changed, 20 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentati=
on/admin-guide/mm/transhuge.rst
> > > index 5034915f4e8e..9c07612281b5 100644
> > > --- a/Documentation/admin-guide/mm/transhuge.rst
> > > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > > @@ -561,6 +561,16 @@ swpin
> > >         is incremented every time a huge page is swapped in from a no=
n-zswap
> > >         swap device in one piece.
> > >
> >
> > Would the following be better?
> >
> > +swpin_fallback
> > +       is incremented if a huge page swapin fails to allocate or charg=
e
> > +       it and instead falls back to using small pages.
> >
> > +swpin_fallback_charge
> > +       is incremented if a huge page swapin fails to charge it and ins=
tead
> > +       falls back to using small pages even though the allocation was
> > +       successful.
>
> much better, but it is better to align with "huge pages with
> lower orders or small pages", not necessarily small pages:
>
> anon_fault_fallback
> is incremented if a page fault fails to allocate or charge
> a huge page and instead falls back to using huge pages with
> lower orders or small pages.
>
> anon_fault_fallback_charge
> is incremented if a page fault fails to charge a huge page and
> instead falls back to using huge pages with lower orders or
> small pages even though the allocation was successful.

Right, I clearly overlooked that ;)

Thanks,
Lance

>
> >
> > Thanks,
> > Lance
> >
> > > +swpin_fallback
> > > +       is incremented if a huge page swapin fails to allocate or cha=
rge
> > > +       a huge page and instead falls back to using huge pages with
> > > +       lower orders or small pages.
> > > +
> > > +swpin_fallback_charge
> > > +       is incremented if a page swapin fails to charge a huge page a=
nd
> > > +       instead falls back to using huge pages with lower orders or
> > > +       small pages even though the allocation was successful.
> > > +
> > >  swpout
> > >         is incremented every time a huge page is swapped out to a non=
-zswap
> > >         swap device in one piece without splitting.
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index b94c2e8ee918..93e509b6c00e 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -121,6 +121,8 @@ enum mthp_stat_item {
> > >         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > >         MTHP_STAT_ZSWPOUT,
> > >         MTHP_STAT_SWPIN,
> > > +       MTHP_STAT_SWPIN_FALLBACK,
> > > +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
> > >         MTHP_STAT_SWPOUT,
> > >         MTHP_STAT_SWPOUT_FALLBACK,
> > >         MTHP_STAT_SHMEM_ALLOC,
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index ee335d96fc39..46749dded1c9 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_S=
TAT_ANON_FAULT_FALLBACK);
> > >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAU=
LT_FALLBACK_CHARGE);
> > >  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> > >  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> > > +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> > > +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBAC=
K_CHARGE);
> > >  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> > >  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> > >  #ifdef CONFIG_SHMEM
> > > @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] =3D {
> > >  #ifndef CONFIG_SHMEM
> > >         &zswpout_attr.attr,
> > >         &swpin_attr.attr,
> > > +       &swpin_fallback_attr.attr,
> > > +       &swpin_fallback_charge_attr.attr,
> > >         &swpout_attr.attr,
> > >         &swpout_fallback_attr.attr,
> > >  #endif
> > > @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] =3D {
> > >  #ifdef CONFIG_SHMEM
> > >         &zswpout_attr.attr,
> > >         &swpin_attr.attr,
> > > +       &swpin_fallback_attr.attr,
> > > +       &swpin_fallback_charge_attr.attr,
> > >         &swpout_attr.attr,
> > >         &swpout_fallback_attr.attr,
> > >  #endif
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 209885a4134f..774dfd309cfe 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct v=
m_fault *vmf)
> > >                         if (!mem_cgroup_swapin_charge_folio(folio, vm=
a->vm_mm,
> > >                                                             gfp, entr=
y))
> > >                                 return folio;
> > > +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBA=
CK_CHARGE);
> > >                         folio_put(folio);
> > >                 }
> > > +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> > >                 order =3D next_order(&orders, order);
> > >         }
> > >
> > > --
> > > 2.45.0
> > >
>
> Thanks
> Barry

