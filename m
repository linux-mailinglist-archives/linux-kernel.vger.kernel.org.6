Return-Path: <linux-kernel+bounces-260880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4420993AFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC779283B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136F1553BD;
	Wed, 24 Jul 2024 10:23:27 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAA1C6A3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816606; cv=none; b=nzS8leKMjSjMnEr6UdKCVkNmnwKkflngqwZ4YdICGkSi53mMpQsGgujQiek+ADNP6t11JzK9vGKHPjw6mgjqr2yq3xNcGSvqfICTGTp7bgYeiwktlWpytkzf9o0+2RtNlKx+l16o2AzmbBguWlLJuoxpIe6BzSceIMeynSRtDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816606; c=relaxed/simple;
	bh=xCcZ5MmEB6EMpRfZspoxEmmbiYjA1ELlUOTkrAOVoSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gd8WmcMGWbz8V/FKusA2eXFBret1HQmp/ljPcu56EdAnBrfe8KiYVd52RII69z0fgdq5RGpuF++mB4E5gqGIs1lE8cZoPGryl6qsZciaPosHPzvaknEyA+CLdRfJT9zvjKRRZtrCw7fwwj0LETFJfATuthmWs4RP0ugwvO+vrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-810177d1760so1970109241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721816603; x=1722421403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkIYtHK9zAI2mVfqs2m7noG5/FMJoIhu1hhEtMBZiGw=;
        b=KOnHjomc/bYM4JRh2tJ9Kiye8OApfXFbY6m+yxVXfSzCa9JemMrwGpEhAdFIY31TfT
         8fPj5h+pJB+dwhdjD9p90v6Rc/CewIOJq8PvXhgCwyTPpaMPnzRNYeaGh+a+PgKwaf1p
         xsjkFw1zkxP0UUBlmfFDag38e0juvlPb+ZuEwJXefo1lrSjOF4zQ1BHZGWyKKKcGA+Ew
         cPJFns/V6OqtTJyt5UDb+31AM3ezsbP8tp1NxCEqJN/QvVvRiYmK6qEr/cx02+OZfTeZ
         2lfvzJILPZ239b+TOiNAu5YrB3eWeHpUn/nwsnxjwmQKO5tOOnBCtIJVuo3XweoaUVwj
         0UCA==
X-Forwarded-Encrypted: i=1; AJvYcCWnC4/osImYV/zFgFaSEctY0uaRgFqwZ55WDAtflpzlKDbIGu1AvGgcOYjGqdlE9pGQ2JsIKTR6HYNkmnyYps/4H3fzwxgxu2wxAd+p
X-Gm-Message-State: AOJu0YzrfDEE5GnSMrmN36HNJ9UBMV/Bl7plcdwxMpl4FatNZNDsCLCt
	JEBXaNMTvGaEJ70AA76+0RFeYcOiOOiz4DFlVmAz7WL2FBHN0/y56qxjmghwksjnuk51xQ9j9Qs
	z8+4KQcH8HWMrZhhVgFq9BEYbulpMpTe9
X-Google-Smtp-Source: AGHT+IH46wTYXWwzmrGyVtUN6LxRMskuoTyF0NDe2yE9aqmXMJt1QonlifQaLxeRm985pR7fHy14tQuqru364zQ/g9o=
X-Received: by 2002:a05:6102:2c03:b0:492:9adb:f4de with SMTP id
 ada2fe7eead31-493c4ad8f59mr2023242137.5.1721816603366; Wed, 24 Jul 2024
 03:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
 <20240716135907.4047689-4-ryan.roberts@arm.com> <CAGsJ_4xfiVNH-cQtD_rMrHvzx1a9Ap6CcqsqbxyAEOTB-9Jvhw@mail.gmail.com>
 <223acdf2-ba25-4c31-94df-a212d31bd6c3@arm.com> <CAGsJ_4wz-rMZC1PX1mM+aq7gdFhOFvSUvtfsN5ufz74w_jEfbw@mail.gmail.com>
 <a9b11f05-62a6-4e30-aac8-ffb44b6d7d36@arm.com>
In-Reply-To: <a9b11f05-62a6-4e30-aac8-ffb44b6d7d36@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 24 Jul 2024 22:23:12 +1200
Message-ID: <CAGsJ_4xc4zhdCtMKtBUmHXNpEzG5r9Enb2=9VUMS4XY8gji7MQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: mTHP stats for pagecache folio allocations
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:12=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 23/07/2024 23:07, Barry Song wrote:
> > On Fri, Jul 19, 2024 at 8:56=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 19/07/2024 01:12, Barry Song wrote:
> >>> On Wed, Jul 17, 2024 at 1:59=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> Expose 3 new mTHP stats for file (pagecache) folio allocations:
> >>>>
> >>>>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
> >>>>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallb=
ack
> >>>>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallb=
ack_charge
> >>>>
> >>>> This will provide some insight on the sizes of large folios being
> >>>> allocated for file-backed memory, and how often allocation is failin=
g.
> >>>>
> >>>> All non-order-0 (and most order-0) folio allocations are currently d=
one
> >>>> through filemap_alloc_folio(), and folios are charged in a subsequen=
t
> >>>> call to filemap_add_folio(). So count file_fallback when allocation
> >>>> fails in filemap_alloc_folio() and count file_alloc or
> >>>> file_fallback_charge in filemap_add_folio(), based on whether chargi=
ng
> >>>> succeeded or not. There are some users of filemap_add_folio() that
> >>>> allocate their own order-0 folio by other means, so we would not cou=
nt
> >>>> an allocation failure in this case, but we also don't care about ord=
er-0
> >>>> allocations. This approach feels like it should be good enough and
> >>>> doesn't require any (impractically large) refactoring.
> >>>>
> >>>> The existing mTHP stats interface is reused to provide consistency t=
o
> >>>> users. And because we are reusing the same interface, we can reuse t=
he
> >>>> same infrastructure on the kernel side.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  Documentation/admin-guide/mm/transhuge.rst | 13 +++++++++++++
> >>>>  include/linux/huge_mm.h                    |  3 +++
> >>>>  include/linux/pagemap.h                    | 16 ++++++++++++++--
> >>>>  mm/filemap.c                               |  6 ++++--
> >>>>  mm/huge_memory.c                           |  7 +++++++
> >>>>  5 files changed, 41 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 058485daf186..d4857e457add 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -512,6 +512,19 @@ shmem_fallback_charge
> >>>>         falls back to using small pages even though the allocation w=
as
> >>>>         successful.
> >>>>
> >>>> +file_alloc
> >>>> +       is incremented every time a file huge page is successfully
> >>>> +       allocated.
> >>>> +
> >>>> +file_fallback
> >>>> +       is incremented if a file huge page is attempted to be alloca=
ted
> >>>> +       but fails and instead falls back to using small pages.
> >>>> +
> >>>> +file_fallback_charge
> >>>> +       is incremented if a file huge page cannot be charged and ins=
tead
> >>>> +       falls back to using small pages even though the allocation w=
as
> >>>> +       successful.
> >>>> +
> >>>
> >>> I realized that when we talk about fallback, it doesn't necessarily m=
ean
> >>> small pages; it could also refer to smaller huge pages.
> >>
> >> Yes good point, I'll update the documentation to reflect that for all =
memory types.
> >>
> >>>
> >>> anon_fault_alloc
> >>>         is incremented every time a huge page is successfully
> >>>         allocated and charged to handle a page fault.
> >>>
> >>> anon_fault_fallback
> >>>         is incremented if a page fault fails to allocate or charge
> >>>         a huge page and instead falls back to using huge pages with
> >>>         lower orders or small pages.
> >>>
> >>> anon_fault_fallback_charge
> >>>         is incremented if a page fault fails to charge a huge page an=
d
> >>>         instead falls back to using huge pages with lower orders or
> >>>         small pages even though the allocation was successful.
> >>>
> >>> This also applies to files, right?
> >>
> >> It does in the place you highlight below, but page_cache_ra_order() ju=
st falls
> >> back immediately to order-0. Regardless, I think we should just docume=
nt the
> >> user facing docs to allow for a lower high order. That gives the imple=
mentation
> >> more flexibility.
> >>
> >>>
> >>>                 do {
> >>>                         gfp_t alloc_gfp =3D gfp;
> >>>
> >>>                         err =3D -ENOMEM;
> >>>                         if (order > 0)
> >>>                                 alloc_gfp |=3D __GFP_NORETRY | __GFP_=
NOWARN;
> >>>                         folio =3D filemap_alloc_folio(alloc_gfp, orde=
r);
> >>>                         if (!folio)
> >>>                                 continue;
> >>>
> >>>                         /* Init accessed so avoid atomic
> >>> mark_page_accessed later */
> >>>                         if (fgp_flags & FGP_ACCESSED)
> >>>                                 __folio_set_referenced(folio);
> >>>
> >>>                         err =3D filemap_add_folio(mapping, folio, ind=
ex, gfp);
> >>>                         if (!err)
> >>>                                 break;
> >>>                         folio_put(folio);
> >>>                         folio =3D NULL;
> >>>                 } while (order-- > 0);
> >>>
> >>>
> >>>>  split
> >>>>         is incremented every time a huge page is successfully split =
into
> >>>>         smaller orders. This can happen for a variety of reasons but=
 a
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index b8c63c3e967f..4f9109fcdded 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -123,6 +123,9 @@ enum mthp_stat_item {
> >>>>         MTHP_STAT_SHMEM_ALLOC,
> >>>>         MTHP_STAT_SHMEM_FALLBACK,
> >>>>         MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> >>>> +       MTHP_STAT_FILE_ALLOC,
> >>>> +       MTHP_STAT_FILE_FALLBACK,
> >>>> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
> >>>>         MTHP_STAT_SPLIT,
> >>>>         MTHP_STAT_SPLIT_FAILED,
> >>>>         MTHP_STAT_SPLIT_DEFERRED,
> >>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> >>>> index 6e2f72d03176..95a147b5d117 100644
> >>>> --- a/include/linux/pagemap.h
> >>>> +++ b/include/linux/pagemap.h
> >>>> @@ -562,14 +562,26 @@ static inline void *detach_page_private(struct=
 page *page)
> >>>>  }
> >>>>
> >>>>  #ifdef CONFIG_NUMA
> >>>> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int or=
der);
> >>>> +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int =
order);
> >>>>  #else
> >>>> -static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, u=
nsigned int order)
> >>>> +static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp,=
 unsigned int order)
> >>>>  {
> >>>>         return folio_alloc_noprof(gfp, order);
> >>>>  }
> >>>>  #endif
> >>>>
> >>>> +static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, u=
nsigned int order)
> >>>> +{
> >>>> +       struct folio *folio;
> >>>> +
> >>>> +       folio =3D __filemap_alloc_folio_noprof(gfp, order);
> >>>> +
> >>>> +       if (!folio)
> >>>> +               count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> >>>> +
> >>>> +       return folio;
> >>>> +}
> >>>
> >>> Do we need to add and export __filemap_alloc_folio_noprof()?
> >>
> >> It is exported. See the below change in filemap.c. Previously
> >> filemap_alloc_folio_noprof() was exported, but that is now an inline a=
nd
> >> __filemap_alloc_folio_noprof() is exported in its place.
> >>
> >>> In any case,
> >>> we won't call count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK) and
> >>> will only allocate the folio instead?
> >>
> >> Sorry I don't understand what you mean by this?
> >
> > Ryan, my question is whether exporting __filemap_alloc_folio_noprof() m=
ight lead
> > to situations where people call __filemap_alloc_folio_noprof() and
> > forget to call
> > count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK). Currently, it seems
> > that counting is always necessary?
>
> OK to make sure I've understood, I think you are saying that there is a r=
isk
> that people will call __filemap_alloc_folio_noprof() and bypass the stat
> counting? But its the same problem with all "_noprof" functions; if those=
 are
> called directly, it bypasses the memory allocation profiling infrastructu=
re. So
> this just needs to be a case of "don't do that" IMHO. filemap_alloc_folio=
() is
> the public API.

Indeed. Maybe I'm overthinking it.

>
> > Another option is that we still
> > call count mthp
> > within filemap_alloc_folio_noprof() and make it noinline if
> > __filemap_alloc_folio_noprof()
> > is not inline?
>
> I could certainly make filemap_alloc_folio_noprof() always out-of-line an=
d then
> handle the counting privately in the compilation unit. But before my chan=
ge
> filemap_alloc_folio_noprof() was inline for the !CONFIG_NUMA case and I w=
as
> trying not to change that. I think what you're suggesting would be tidier
> though. I'll make the change. But I don't think it solves the wider probl=
em of
> the possibility that people can call private APIs. That's what review is =
for.

Agreed.

>
> Thanks,
> Ryan
>
>
> >
> >>
> >>>
> >>>> +
> >>>>  #define filemap_alloc_folio(...)                               \
> >>>>         alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
> >>>>
> >>>> diff --git a/mm/filemap.c b/mm/filemap.c
> >>>> index 53d5d0410b51..131d514fca29 100644
> >>>> --- a/mm/filemap.c
> >>>> +++ b/mm/filemap.c
> >>>> @@ -963,6 +963,8 @@ int filemap_add_folio(struct address_space *mapp=
ing, struct folio *folio,
> >>>>         int ret;
> >>>>
> >>>>         ret =3D mem_cgroup_charge(folio, NULL, gfp);
> >>>> +       count_mthp_stat(folio_order(folio),
> >>>> +               ret ? MTHP_STAT_FILE_FALLBACK_CHARGE : MTHP_STAT_FIL=
E_ALLOC);
> >>>>         if (ret)
> >>>>                 return ret;
> >>>
> >>> Would the following be better?
> >>>
> >>>         ret =3D mem_cgroup_charge(folio, NULL, gfp);
> >>>          if (ret) {
> >>>                  count_mthp_stat(folio_order(folio),
> >>> MTHP_STAT_FILE_FALLBACK_CHARGE);
> >>>                  return ret;
> >>>          }
> >>>        count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
> >>>
> >>> Anyway, it's up to you. The code just feels a bit off to me :-)
> >>
> >> Yes, agree your version is better. I also noticed that anon and shmem =
increment
> >> FALLBACK whenever FALLBACK_CHARGE is incremented so I should apply tho=
se same
> >> semantics here.
> >>
> >> Thanks,
> >> Ryan
> >>
> >>
> >>>
> >>>>
> >>>> @@ -990,7 +992,7 @@ int filemap_add_folio(struct address_space *mapp=
ing, struct folio *folio,
> >>>>  EXPORT_SYMBOL_GPL(filemap_add_folio);
> >>>>
> >>>>  #ifdef CONFIG_NUMA
> >>>> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int or=
der)
> >>>> +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int =
order)
> >>>>  {
> >>>>         int n;
> >>>>         struct folio *folio;
> >>>> @@ -1007,7 +1009,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t=
 gfp, unsigned int order)
> >>>>         }
> >>>>         return folio_alloc_noprof(gfp, order);
> >>>>  }
> >>>> -EXPORT_SYMBOL(filemap_alloc_folio_noprof);
> >>>> +EXPORT_SYMBOL(__filemap_alloc_folio_noprof);
> >>>>  #endif
> >>>>
> >>>>  /*
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 578ac212c172..26d558e3e80f 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -608,7 +608,14 @@ static struct attribute_group anon_stats_attr_g=
rp =3D {
> >>>>         .attrs =3D anon_stats_attrs,
> >>>>  };
> >>>>
> >>>> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >>>> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >>>> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK=
_CHARGE);
> >>>> +
> >>>>  static struct attribute *file_stats_attrs[] =3D {
> >>>> +       &file_alloc_attr.attr,
> >>>> +       &file_fallback_attr.attr,
> >>>> +       &file_fallback_charge_attr.attr,
> >>>>  #ifdef CONFIG_SHMEM
> >>>>         &shmem_alloc_attr.attr,
> >>>>         &shmem_fallback_attr.attr,
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >

Thanks
 Barry

