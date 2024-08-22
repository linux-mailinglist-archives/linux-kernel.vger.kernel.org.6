Return-Path: <linux-kernel+bounces-296933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676395B0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF221C221ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7833170A10;
	Thu, 22 Aug 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMcI+W3J"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5124CE05
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316289; cv=none; b=YsFiXCX36fIvSNOjWQdcrHaqv9E3Gkbe54gSJ7tOhVuuwj6mcGRyP+ieoh5AXvuofdvhBP1eltRqhDz6zIljjaKDo9Yzpw4RNF2oPmM9f8fqvRDy8ZT9pNhxf8bF+sjJHjxNDxxBhw2BGSFbJ2rgM3B8v6mUW0ggUNnXtcnfLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316289; c=relaxed/simple;
	bh=n7BCfV/YRT0tqNkzWZqO7Xsb7Pcfcj17GVkd6f9lV54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3hagwBS+7jZrx+D7obqp9cre7bpfBf6CGQjFJc2O184NzhRmqtcVFMRbiycY3dGAUkNteNZhksNRUZUektJil/z0dw/Ub5x+eMh29cthJ8WXQLV4MSqWwzLKX1caeiaS7jkeFwON5ANjivgE6Cq7o69KLh5uI03u7s8UA/iagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMcI+W3J; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8430fdf256bso173623241.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316285; x=1724921085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIO21vDdB9JW0rAwIaxs62jHknF62iZEFTwbURftOkk=;
        b=CMcI+W3JTzKFRzjl7SmBjAGZ2DK18tvAeZnn1fuH9gYkyuSQGVjfJ4FYeeuld6Yf0k
         CB4V/o6dZNK5KZqFGS7AlwC0Vhztj1qZUewLbHaQidEsRcmYUsIYGDc+tGINO4SMkPzu
         uS6KEdiaj63JBTzoNyva6P1FEBjQsnQaK+dd4NfChv6dtJseYSuCjoLIrsaMSN7AwGbe
         tiSIg5dgI+nWRLocpF8kBpj9IYvuW3XjCbx/6c2VCymAgGECF2K6Qk+h0cCT4sjjqsIE
         lRMIrpLkV5vDH4ehSUSW4sMr4O7XV1xZZkrlD54Ays14NVIS84boWBFrJ4lJMvukQTzB
         ASmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316285; x=1724921085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIO21vDdB9JW0rAwIaxs62jHknF62iZEFTwbURftOkk=;
        b=NUwlsKF/DO22224yLlJp4WU//KZ9wm28PhRxOPPTHvMerGzMCM3ZyBxv0WUCgAAKzQ
         bfeEQ5IjQdWieNy0SdfE6+p/luLGJIEZXeRyUZVxutFHT6aAOsfeMfMEZs85EqV++Vag
         4JqqRLhcliO/4k10sWR1IoERk/dVzW4yUy/33QoV4g0oZU8e6zPf2KvDER5JVMl4+qQ2
         sdvM9ailpb8FqVS7pKZkY3eXwqfdCd9rXYjJmJxuaOhK/dYQKl+AQfVr/hkFXql2Aj/q
         5BTAH1fOBFv8H86OvveesntJG9hAxGO6xgihB0ydK3o5rBrHFGrmwhoaRT1S8S4W9dXz
         4C0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnsX8C1xeQWLUCEabPqx52Ns0vuhryTKxEDNze/4N3vOIIuMlPUExdRTeoK6FUmkI5EpfB4BfXpT2UqTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmd714l/d/+cIImz0iGvfcWAGUPnL5irGrWtls56FESd2b10F
	11cwT+nmgwpEDjZsSFywxplrnH7mgrObv0OdS5FkcDkFIoO3ebUD402fWMq8kMpelXUH+dl6fxR
	bCabL1X3gz5j3xQI0k6Ty0gcdVRQ=
X-Google-Smtp-Source: AGHT+IGMSTK8oyJMHzMp0SaYBAXM8UyTM8XVkRv+OC7S9RdFR/EBMu8FLmIS2TiZf3+irMJk9R6s5QNkrqPnLnEjQfY=
X-Received: by 2002:a05:6122:3199:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-4fd098c38c9mr1503865e0c.3.1724316285074; Thu, 22 Aug 2024
 01:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <20240811224940.39876-2-21cnbao@gmail.com>
 <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com> <CAGsJ_4w9gg=z6KgAZ4Tur+t-ZhpXdvmq4A5tOQiUZLeuPFSupg@mail.gmail.com>
In-Reply-To: <CAGsJ_4w9gg=z6KgAZ4Tur+t-ZhpXdvmq4A5tOQiUZLeuPFSupg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 20:44:33 +1200
Message-ID: <CAGsJ_4yqf4KNvsg1P47cAz+bniZFVcUWPkdjYTqji91CgnrrfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 12:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Thu, Aug 22, 2024 at 5:34=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 12.08.24 00:49, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > Anon large folios come from three places:
> > > 1. new allocated large folios in PF, they will call folio_add_new_ano=
n_rmap()
> > > for rmap;
> > > 2. a large folio is split into multiple lower-order large folios;
> > > 3. a large folio is migrated to a new large folio.
> > >
> > > In all above three counts, we increase nr_anon by 1;
> > >
> > > Anon large folios might go either because of be split or be put
> > > to free, in these cases, we reduce the count by 1.
> > >
> > > Folios that have been added to the swap cache but have not yet receiv=
ed
> > > an anon mapping won't be counted. This is consistent with the AnonPag=
es
> > > statistics in /proc/meminfo.
> >
> > Thinking out loud, I wonder if we want to have something like that for
> > any anon folios (including small ones).
> >
> > Assume we longterm-pinned an anon folio and unmapped/zapped it. It woul=
d
> > be quite interesting to see that these are actually anon pages still
> > consuming memory. Same with memory leaks, when an anon folio doesn't ge=
t
> > freed for some reason.
> >
> > The whole "AnonPages" counter thingy is just confusing, it only counts
> > what's currently mapped ... so we'd want something different.
> >
> > But it's okay to start with large folios only, there we have a new
> > interface without that legacy stuff :)
>
> We have two options to do this:
> 1. add a new separate nr_anon_unmapped interface which
> counts unmapped anon memory only
> 2. let the nr_anon count both mapped and unmapped anon
> folios.
>
> I would assume 1 is clearer as right now AnonPages have been
> there for years. and counting all mapped and unmapped together,
> we are still lacking an approach to find out anon memory leak
> problem you mentioned.
>
> We are right now comparing nr_anon(including mapped folios only)
> with AnonPages to get the distribution of different folio sizes in
> performance profiling.
>
> unmapped_nr_anon should be normally always quite small. otherwise,
> something must be wrong.
>
> >
> > >
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >   Documentation/admin-guide/mm/transhuge.rst |  5 +++++
> > >   include/linux/huge_mm.h                    | 15 +++++++++++++--
> > >   mm/huge_memory.c                           | 13 ++++++++++---
> > >   mm/migrate.c                               |  4 ++++
> > >   mm/page_alloc.c                            |  5 ++++-
> > >   mm/rmap.c                                  |  1 +
> > >   6 files changed, 37 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentati=
on/admin-guide/mm/transhuge.rst
> > > index 058485daf186..9fdfb46e4560 100644
> > > --- a/Documentation/admin-guide/mm/transhuge.rst
> > > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > > @@ -527,6 +527,11 @@ split_deferred
> > >           it would free up some memory. Pages on split queue are goin=
g to
> > >           be split under memory pressure, if splitting is possible.
> > >
> > > +nr_anon
> > > +       the number of anon huge pages we have in the whole system.
> >
> > "transparent ..." otherwise people might confuse it with anon hugetlb
> > "huge pages" ... :)
> >
> > I briefly tried coming up with a better name than "nr_anon" but failed.
> >
> >
>
> if we might have unmapped_anon counter later, maybe rename it to
> nr_anon_mapped? and the new interface we will have in the future
> might be nr_anon_unmapped?

On second thought, this might be incorrect as well. Concepts like 'anon',
'shmem', and 'file' refer to states after mapping. If an 'anon' has been
unmapped but is still pinned and not yet freed, it isn't technically an
'anon' anymore?

On the other hand, implementing nr_anon_unmapped could be extremely
tricky. I have no idea how to implement it as we are losing those mapping
flags.

However, a page that is read-ahead but not yet mapped can still become
an anon, which seems slightly less tricky to count though seems still
difficult - except anon pages, shmem can be also swapped-backed?

>
> > [...]
> >
> > > @@ -447,6 +449,8 @@ static int __folio_migrate_mapping(struct address=
_space *mapping,
> > >        */
> > >       newfolio->index =3D folio->index;
> > >       newfolio->mapping =3D folio->mapping;
> > > +     if (folio_test_anon(folio) && folio_test_large(folio))
> > > +             mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1)=
;
> > >       folio_ref_add(newfolio, nr); /* add cache reference */
> > >       if (folio_test_swapbacked(folio)) {
> > >               __folio_set_swapbacked(newfolio);
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 84a7154fde93..382c364d3efa 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1084,8 +1084,11 @@ __always_inline bool free_pages_prepare(struct=
 page *page,
> > >                       (page + i)->flags &=3D ~PAGE_FLAGS_CHECK_AT_PRE=
P;
> > >               }
> > >       }
> > > -     if (PageMappingFlags(page))
> > > +     if (PageMappingFlags(page)) {
> > > +             if (PageAnon(page) && compound)
> > > +                     mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >
> > I wonder if you could even drop the "compound" check. mod_mthp_stat
> > would handle order =3D=3D 0 just fine. Not that I think it makes much
> > difference.
>
> i think either is fine as mod_mthp_stat will filter out order=3D=3D0
> right now.
>
> >
> >
> > Nothing else jumped at me.
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> >
>
> Thanks!
>
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> Barry

Thanks
Barry

