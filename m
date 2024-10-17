Return-Path: <linux-kernel+bounces-369103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E09A18EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75A31F217EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AF7DA6C;
	Thu, 17 Oct 2024 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEm2mgeb"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57778C6C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133960; cv=none; b=KmRN/uojECpWzZCNvnm3n8HyA8e0ccg1xCFX9+Gev5DDFOCzHJt4srPm/IYKD4advj+zYJguIPt/I5VeCPy2ZmyH8ToRvnVHgIHveEzHmdfNBMYg/R6oidqdCmE2rWvuAmBKJ1j1E0Gyvs58PRoZdO+eCeKo8g5WtJxyv6XJN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133960; c=relaxed/simple;
	bh=AfONj+CHYESdQTiConM/ic2wsLg3B0ytf8rHi8lvyHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocJQ66QNsnlu4TL5TrRFB8WzbxXBQccKeJSKgKgSBKowYmnca1mNeczNYNvmPeBuCzc8nAQUS0EhoBMViLgagza8EFVpS6+U935ot1i1mNY+rtA1VLXQwQGk52zg63vqc1OIfQSOt81mHAMoSdpoFjAVR7KQ8BE9x5COH/b7LiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEm2mgeb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so512124e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729133956; x=1729738756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64Gu52OfmifelGUMBTv6DW9eSWtSuQd6qWtq07/JDgE=;
        b=FEm2mgebJhxJsRpuaq249HEEQG2UpIfYD+tWN35oQ98GfL7zHuak7zVeupMLc2N6C6
         TlTav0JGNT1VCbVgBPJOlbNtq9Cq3kqORzxJqe414hJZRhbYkJvdBKVwincdsb72vGt4
         iZaAOhjDSGkdsKRF1lpW6Fmq2mxvZWeGLFIpBKQ0Hqvg7ikOf0yXqD7JGON/yUkpzpPB
         0aM/v3wACXPfjYpKi9wLXsavKPmWfdJqHqQJdgBI7lqN+AMzy69YDK023kaggiHMC44K
         S7drjpbkgMJfZBO2zB67LkEwCLDua35pYl6ezUMcyFGV5t2h9fwMGOtvshX8RNrCbX6S
         KKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133956; x=1729738756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64Gu52OfmifelGUMBTv6DW9eSWtSuQd6qWtq07/JDgE=;
        b=AYzpUj7AU7SEHiklTARkdsT1m+csPiQlwLfOjE22NroZ4iav5sx72gpZCvU8kQ1p3I
         g7JXvwAdFDYxujJO82FcZ4vN1piuSQ4g7ekSLfIVQFIuvwzLYkGRrTUEZIgwJrpko+Lo
         oHtxLWYjHp/+qMqcXJfJHgGpQu5oqiZHxcJZhlb+uXq5+6+UPhrFJ3zVtyAEtWCZZLYl
         vgWN7kIjo16uGsNepY6ChtTd/+Ge8pt36SX9eNun09ebJzZkI4F1tFtEGn4DfMzOlm99
         WMjhMq/JkAO/b3msvK5d+DZRP5LRLSdjneaHIr1qfq5CIsAlrBRvuBuBCHQ1leh7oTkA
         QuQA==
X-Forwarded-Encrypted: i=1; AJvYcCXXHkZE1U6Lz6jZFwAHpNxIKDPK06QnV/Q6aYkAugoM5pXjqExpr7Lt8xK/l9DT+wj6F/+gRgHWpFRI4iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJHG+KU5B95tXchlG8Epn1GXOoEZXyE43fD7uSMXK2fUkL+eJ
	VRyOj9naz+xU+bg0KsNOehVlwG+IaQnv+3vRe++J9IE4BQg7q4kpgaL5aB8D/4bQ6hcQUefiAmu
	ggATpph8Tmyqegdj2NoE+uuFIiC0=
X-Google-Smtp-Source: AGHT+IF0tJWUk79F87TFOwTieoLNOBPbgxyMlRUrBN87MEURCCCEN9nE0/URPzcJivnmTiOiNjAQUNOONMcwcmNo3BA=
X-Received: by 2002:a05:6512:10c4:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53a03f1992bmr3950665e87.13.1729133955340; Wed, 16 Oct 2024
 19:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925110235.3157-1-suhua1@kingsoft.com> <Zvkalqx12KRjXPAE@kernel.org>
 <CALe3CaBWQtGWVUnmW7Kkc7ayEEhqf=Xye0d1MymHn8c5qtx+GA@mail.gmail.com> <Zw-qR3fcOnXHRMf8@kernel.org>
In-Reply-To: <Zw-qR3fcOnXHRMf8@kernel.org>
From: Su Hua <suhua.tanke@gmail.com>
Date: Thu, 17 Oct 2024 10:58:38 +0800
Message-ID: <CALe3CaAnSM7T7Fv=SJ2wAU3Os5OL70x6BaF-btvau65DHRkSAA@mail.gmail.com>
Subject: Re: [PATCH v1] memblock: Initialized the memory of memblock.reserve
 to the MIGRATE_MOVABL
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi,
>
> On Sat, Oct 12, 2024 at 11:55:31AM +0800, Su Hua wrote:
> > Hi Mike
> >
> > Thanks for your advice and sorry for taking so long to reply.
>
> Please don't top-post on the Linux kernel mailing lists

Thank you for the correction.

> > I looked at the logic again. deferred_init_pages is currently used to
> > handle all (memory &&! reserved) area memblock=EF=BC=8Cand put that mem=
ory in
> > buddy.
> > Change it to also handle reserved memory may involve more code
> > changes. I wonder if I can change the commit message: This patch is
> > mainly to
> > make the migration type to MIGRATE_MOVABLE when the reserve type page
> > is initialized, regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > is set or not?
> >
> > When not set CONFIG_DEFERRED_STRUCT_PAGE_INIT=EF=BC=8C initializes memb=
lock of
> > reserve type to MIGRATE_MOVABLE by default at memmap_init initializes
> > memory.
>
> This should be more clearly emphasized in the commit message.

Ok=EF=BC=8CI'll update the commit message.

> > Sincerely yours=EF=BC=8C
> > Su
> >
> >
> > Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8829=E6=
=97=A5=E5=91=A8=E6=97=A5 17:18=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Sep 25, 2024 at 07:02:35PM +0800, suhua wrote:
> > > > After sparse_init function requests memory for struct page in membl=
ock and
> > > > adds it to memblock.reserved, this memory area is present in both
> > > > memblock.memory and memblock.reserved.
> > > >
> > > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set. The memmap_init f=
unction
> > > > is called during the initialization of the free area of the zone, t=
his
> > > > function calls for_each_mem_pfn_range to initialize all memblock.me=
mory,
> > > > excluding memory that is also placed in memblock.reserved, such as =
the
> > > > struct page metadata that describes the page, 1TB memory is about 1=
6GB,
> > > > and generally this part of reserved memory occupies more than 90% o=
f the
> > > > total reserved memory of the system. So all memory in memblock.memo=
ry is
> > > > set to MIGRATE_MOVABLE according to the alignment of pageblock_nr_p=
ages.
> > > > For example, if hugetlb_optimize_vmemmap=3D1, huge pages are alloca=
ted, the
> > > > freed pages are placed on buddy's MIGRATE_MOVABL list for use.
> > >
> > > Please make sure you spell MIGRATE_MOVABLE and MIGRATE_UNMOVABLE corr=
ectly.
> > >
> > > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy, only the first_deferred_=
pfn range
> > > > is initialized in memmap_init. The subsequent free_low_memory_core_=
early
> > > > initializes all memblock.reserved memory but not MIGRATE_MOVABL. Al=
l
> > > > memblock.memory is set to MIGRATE_MOVABL when it is placed in buddy=
 via
> > > > free_low_memory_core_early and deferred_init_memmap. As a result, w=
hen
> > > > hugetlb_optimize_vmemmap=3D1 and huge pages are allocated, the free=
d pages
> > > > will be placed on buddy's MIGRATE_UNMOVABL list (For example, on ma=
chines
> > > > with 1TB of memory, alloc 2MB huge page size of 1000GB frees up abo=
ut 15GB
> > > > to MIGRATE_UNMOVABL). Since the huge page alloc requires a MIGRATE_=
MOVABL
> > > > page, a fallback is performed to alloc memory from MIGRATE_UNMOVABL=
 for
> > > > MIGRATE_MOVABL.
> > > >
> > > > Large amount of UNMOVABL memory is not conducive to defragmentation=
, so
> > > > the reserved memory is also set to MIGRATE_MOVABLE in the
> > > > free_low_memory_core_early phase following the alignment of
> > > > pageblock_nr_pages.
> > > >
> > > > Eg=EF=BC=9A
> > > > echo 500000 > /proc/sys/vm/nr_hugepages
> > > > cat /proc/pagetypeinfo
> > > >
> > > > before=EF=BC=9A
> > > > Free pages count per migrate type at order       0      1      2   =
   3      4      5      6      7      8      9     10
> > > > =E2=80=A6
> > > > Node    0, zone   Normal, type    Unmovable     51      2      1   =
  28     53     35     35     43     40     69   3852
> > > > Node    0, zone   Normal, type      Movable   6485   4610    666   =
 202    200    185    208     87     54      2    240
> > > > Node    0, zone   Normal, type  Reclaimable      2      2      1   =
  23     13      1      2      1      0      1      0
> > > > Node    0, zone   Normal, type   HighAtomic      0      0      0   =
   0      0      0      0      0      0      0      0
> > > > Node    0, zone   Normal, type      Isolate      0      0      0   =
   0      0      0      0      0      0      0      0
> > > > Unmovable =E2=89=88 15GB
> > > >
> > > > after=EF=BC=9A
> > > > Free pages count per migrate type at order       0      1      2   =
   3      4      5      6      7      8      9     10
> > > > =E2=80=A6
> > > > Node    0, zone   Normal, type    Unmovable      0      1      1   =
   0      0      0      0      1      1      1      0
> > > > Node    0, zone   Normal, type      Movable   1563   4107   1119   =
 189    256    368    286    132    109      4   3841
> > > > Node    0, zone   Normal, type  Reclaimable      2      2      1   =
  23     13      1      2      1      0      1      0
> > > > Node    0, zone   Normal, type   HighAtomic      0      0      0   =
   0      0      0      0      0      0      0      0
> > > > Node    0, zone   Normal, type      Isolate      0      0      0   =
   0      0      0      0      0      0      0      0
> > > >
> > > > Signed-off-by: suhua <suhua1@kingsoft.com>
> > > > ---
> > > >  mm/mm_init.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > > index 4ba5607aaf19..e0190e3f8f26 100644
> > > > --- a/mm/mm_init.c
> > > > +++ b/mm/mm_init.c
> > > > @@ -722,6 +722,12 @@ static void __meminit init_reserved_page(unsig=
ned long pfn, int nid)
> > > >               if (zone_spans_pfn(zone, pfn))
> > > >                       break;
> > > >       }
> > > > +
> > > > +     if (pageblock_aligned(pfn)) {
> > > > +             set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_M=
OVABLE);
> > > > +             cond_resched();
>
> No need to call cond_resched() here

Alright, there isn't much reserved memory, I'll remove this function.

> > > > +     }
>
> > > > +
> > > >       __init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> > > >  }
> > > >  #else
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.

Sincerely yours,
Su

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 20:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sat, Oct 12, 2024 at 11:55:31AM +0800, Su Hua wrote:
> > Hi Mike
> >
> > Thanks for your advice and sorry for taking so long to reply.
>
> Please don't top-post on the Linux kernel mailing lists
>
> > I looked at the logic again. deferred_init_pages is currently used to
> > handle all (memory &&! reserved) area memblock=EF=BC=8Cand put that mem=
ory in
> > buddy.
> > Change it to also handle reserved memory may involve more code
> > changes. I wonder if I can change the commit message: This patch is
> > mainly to
> > make the migration type to MIGRATE_MOVABLE when the reserve type page
> > is initialized, regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > is set or not?
> >
> > When not set CONFIG_DEFERRED_STRUCT_PAGE_INIT=EF=BC=8C initializes memb=
lock of
> > reserve type to MIGRATE_MOVABLE by default at memmap_init initializes
> > memory.
>
> This should be more clearly emphasized in the commit message.
>
> > Sincerely yours=EF=BC=8C
> > Su
> >
> >
> > Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8829=E6=
=97=A5=E5=91=A8=E6=97=A5 17:18=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Sep 25, 2024 at 07:02:35PM +0800, suhua wrote:
> > > > After sparse_init function requests memory for struct page in membl=
ock and
> > > > adds it to memblock.reserved, this memory area is present in both
> > > > memblock.memory and memblock.reserved.
> > > >
> > > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set. The memmap_init f=
unction
> > > > is called during the initialization of the free area of the zone, t=
his
> > > > function calls for_each_mem_pfn_range to initialize all memblock.me=
mory,
> > > > excluding memory that is also placed in memblock.reserved, such as =
the
> > > > struct page metadata that describes the page, 1TB memory is about 1=
6GB,
> > > > and generally this part of reserved memory occupies more than 90% o=
f the
> > > > total reserved memory of the system. So all memory in memblock.memo=
ry is
> > > > set to MIGRATE_MOVABLE according to the alignment of pageblock_nr_p=
ages.
> > > > For example, if hugetlb_optimize_vmemmap=3D1, huge pages are alloca=
ted, the
> > > > freed pages are placed on buddy's MIGRATE_MOVABL list for use.
> > >
> > > Please make sure you spell MIGRATE_MOVABLE and MIGRATE_UNMOVABLE corr=
ectly.
> > >
> > > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy, only the first_deferred_=
pfn range
> > > > is initialized in memmap_init. The subsequent free_low_memory_core_=
early
> > > > initializes all memblock.reserved memory but not MIGRATE_MOVABL. Al=
l
> > > > memblock.memory is set to MIGRATE_MOVABL when it is placed in buddy=
 via
> > > > free_low_memory_core_early and deferred_init_memmap. As a result, w=
hen
> > > > hugetlb_optimize_vmemmap=3D1 and huge pages are allocated, the free=
d pages
> > > > will be placed on buddy's MIGRATE_UNMOVABL list (For example, on ma=
chines
> > > > with 1TB of memory, alloc 2MB huge page size of 1000GB frees up abo=
ut 15GB
> > > > to MIGRATE_UNMOVABL). Since the huge page alloc requires a MIGRATE_=
MOVABL
> > > > page, a fallback is performed to alloc memory from MIGRATE_UNMOVABL=
 for
> > > > MIGRATE_MOVABL.
> > > >
> > > > Large amount of UNMOVABL memory is not conducive to defragmentation=
, so
> > > > the reserved memory is also set to MIGRATE_MOVABLE in the
> > > > free_low_memory_core_early phase following the alignment of
> > > > pageblock_nr_pages.
> > > >
> > > > Eg=EF=BC=9A
> > > > echo 500000 > /proc/sys/vm/nr_hugepages
> > > > cat /proc/pagetypeinfo
> > > >
> > > > before=EF=BC=9A
> > > > Free pages count per migrate type at order       0      1      2   =
   3      4      5      6      7      8      9     10
> > > > =E2=80=A6
> > > > Node    0, zone   Normal, type    Unmovable     51      2      1   =
  28     53     35     35     43     40     69   3852
> > > > Node    0, zone   Normal, type      Movable   6485   4610    666   =
 202    200    185    208     87     54      2    240
> > > > Node    0, zone   Normal, type  Reclaimable      2      2      1   =
  23     13      1      2      1      0      1      0
> > > > Node    0, zone   Normal, type   HighAtomic      0      0      0   =
   0      0      0      0      0      0      0      0
> > > > Node    0, zone   Normal, type      Isolate      0      0      0   =
   0      0      0      0      0      0      0      0
> > > > Unmovable =E2=89=88 15GB
> > > >
> > > > after=EF=BC=9A
> > > > Free pages count per migrate type at order       0      1      2   =
   3      4      5      6      7      8      9     10
> > > > =E2=80=A6
> > > > Node    0, zone   Normal, type    Unmovable      0      1      1   =
   0      0      0      0      1      1      1      0
> > > > Node    0, zone   Normal, type      Movable   1563   4107   1119   =
 189    256    368    286    132    109      4   3841
> > > > Node    0, zone   Normal, type  Reclaimable      2      2      1   =
  23     13      1      2      1      0      1      0
> > > > Node    0, zone   Normal, type   HighAtomic      0      0      0   =
   0      0      0      0      0      0      0      0
> > > > Node    0, zone   Normal, type      Isolate      0      0      0   =
   0      0      0      0      0      0      0      0
> > > >
> > > > Signed-off-by: suhua <suhua1@kingsoft.com>
> > > > ---
> > > >  mm/mm_init.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > > index 4ba5607aaf19..e0190e3f8f26 100644
> > > > --- a/mm/mm_init.c
> > > > +++ b/mm/mm_init.c
> > > > @@ -722,6 +722,12 @@ static void __meminit init_reserved_page(unsig=
ned long pfn, int nid)
> > > >               if (zone_spans_pfn(zone, pfn))
> > > >                       break;
> > > >       }
> > > > +
> > > > +     if (pageblock_aligned(pfn)) {
> > > > +             set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_M=
OVABLE);
> > > > +             cond_resched();
>
> No need to call cond_resched() here
>
> > > > +     }
> > > > +
> > > >       __init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> > > >  }
> > > >  #else
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.

