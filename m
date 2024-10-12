Return-Path: <linux-kernel+bounces-362072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C999B089
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983E81C2118E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CF86277;
	Sat, 12 Oct 2024 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nomKBn/B"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11EA41
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705372; cv=none; b=Y6smahNTSv+8lXQONxFKf4tzGS/ot6S9YRza7QtNEhZttxyhXyIHMkyWX451olQSDvw5NhyEp4uM2HYoYw6SeWm1dAqxuZu9mpi/mv4KJG9aEalHnui6epfFOy0xYZhQ7p5rTvquFwVToHT/9Gm2d3m8vQNofkW/1pcfmlR9AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705372; c=relaxed/simple;
	bh=/FNldQTYLRaRNdMhfffmSUO35wUxwivYkc4/7qGa9fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPU6PojCeGy3IqPEOieH3oimMROrmV3E0MLfqRZy2UOO39qNMgjOlcGkXyDfB3LflRnuxb7GqQ2YlPfrvnQkh2EQ/w81gfOMn+Tcey2i9AfT+alG6QSJXNdvybOyBpQGUNbCemdqBYTdML5NN3biQjngg5nxoRMuN//El1qGOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nomKBn/B; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d0929f20so1796788e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728705368; x=1729310168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU52FN+J0/hnIDa7OCRKyJ9HWXb9RLs18SXoJG1d8Ck=;
        b=nomKBn/ButvVzrw5Yz5AlzMH8CPHMUcu3aNu1K2FjMlR3i3oi7uD4Yia6l9ia+NeiX
         vB360x7Z+xNWf+PLhdw5ZaXN5FVxTqVuysWD9f7YrgCBZ+CuMPZhOuvPSYyIB1kX0WLP
         ph6QMT1XoXS1MkdzcOG+5KCRHm7h4D17uwAVrSi7bx9e142/6ukisWh1qPUTUZ/7lW36
         RnC+Xjch5XEyeDbWDJA4COp6nzQy9fQXDFqVMXg/w2NEgZsxI0ukSxDEEyA3co+qpN7k
         14KTIZpY/+cdU/uFm/d6zKeIRBve6FB+y44usEmf66/7VQZHiwNPrXPFgtiDs0//zwdY
         NAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728705368; x=1729310168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU52FN+J0/hnIDa7OCRKyJ9HWXb9RLs18SXoJG1d8Ck=;
        b=jbQV6XPovqmh+z679tux9QK9PwK/KKRpATENW2zUkmaxgmyLhDUPany9tyVTIqZxDy
         9bi/OjFD64j5QCL9Mxz++AjJDVHpW3oUYJELG69cGgr+sBDpphaw5Y0VRyNuBWwXppD3
         YOk3fFelzPJYDE2LXtDfbpWM5CK3dqhwFESetp1r0wJ80KjO7IVxFkgCBObnOcDQl5Xv
         C5RAlPaweLxwb8RDhHBkxCpE1Z8WZ536m1GE/XGkfZY+fCgpjxncAnqMVuBojM+3i4nj
         d9B8uUC3YoF9InacEMtKh+5+2B28+mDGwfQ6fRuRp63H4cFaXIVMCFxh0mnjuMFYH2Ba
         ubiA==
X-Forwarded-Encrypted: i=1; AJvYcCVWYcGQ3voXm4NH3Q76h6QbFXEvJMOaqNiEXhslG/aGL3O3hhEplpgIwMNV3SBm2z8ktR7lnawFqH2P5Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDs/GxdidvO9Us7sRjCdMKY5Dt3RX8r6IKGgT1jponqHn3451Q
	pS8lpbsnBQ9LlMH98C7MLVeB154zLlPk9hEl4JBYG+DAgAkIy0SSJvWhANdRy24WdsGHdc7f1LF
	2TA/km0ujVfmS+hIiQ1gAL9putOg=
X-Google-Smtp-Source: AGHT+IHJ3suir3QdeEfWYMb/Qkj1g+JwmbDCoY3KQ1qbRzkCF3cbRrKILDnEpJgSLbB+8jTEOG06fFokookQDaybnUk=
X-Received: by 2002:a05:6512:10d4:b0:539:8ad5:50a2 with SMTP id
 2adb3069b0e04-539c988197fmr3216740e87.14.1728705368045; Fri, 11 Oct 2024
 20:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925110235.3157-1-suhua1@kingsoft.com> <Zvkalqx12KRjXPAE@kernel.org>
In-Reply-To: <Zvkalqx12KRjXPAE@kernel.org>
From: Su Hua <suhua.tanke@gmail.com>
Date: Sat, 12 Oct 2024 11:55:31 +0800
Message-ID: <CALe3CaBWQtGWVUnmW7Kkc7ayEEhqf=Xye0d1MymHn8c5qtx+GA@mail.gmail.com>
Subject: Re: [PATCH v1] memblock: Initialized the memory of memblock.reserve
 to the MIGRATE_MOVABL
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike

Thanks for your advice and sorry for taking so long to reply.

I looked at the logic again. deferred_init_pages is currently used to
handle all (memory &&! reserved) area memblock=EF=BC=8Cand put that memory =
in
buddy.
Change it to also handle reserved memory may involve more code
changes. I wonder if I can change the commit message: This patch is
mainly to
make the migration type to MIGRATE_MOVABLE when the reserve type page
is initialized, regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT
is set or not?

When not set CONFIG_DEFERRED_STRUCT_PAGE_INIT=EF=BC=8C initializes memblock=
 of
reserve type to MIGRATE_MOVABLE by default at memmap_init initializes
memory.

Sincerely yours=EF=BC=8C
Su


Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8829=E6=97=A5=
=E5=91=A8=E6=97=A5 17:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 25, 2024 at 07:02:35PM +0800, suhua wrote:
> > After sparse_init function requests memory for struct page in memblock =
and
> > adds it to memblock.reserved, this memory area is present in both
> > memblock.memory and memblock.reserved.
> >
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set. The memmap_init funct=
ion
> > is called during the initialization of the free area of the zone, this
> > function calls for_each_mem_pfn_range to initialize all memblock.memory=
,
> > excluding memory that is also placed in memblock.reserved, such as the
> > struct page metadata that describes the page, 1TB memory is about 16GB,
> > and generally this part of reserved memory occupies more than 90% of th=
e
> > total reserved memory of the system. So all memory in memblock.memory i=
s
> > set to MIGRATE_MOVABLE according to the alignment of pageblock_nr_pages=
.
> > For example, if hugetlb_optimize_vmemmap=3D1, huge pages are allocated,=
 the
> > freed pages are placed on buddy's MIGRATE_MOVABL list for use.
>
> Please make sure you spell MIGRATE_MOVABLE and MIGRATE_UNMOVABLE correctl=
y.
>
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy, only the first_deferred_pfn =
range
> > is initialized in memmap_init. The subsequent free_low_memory_core_earl=
y
> > initializes all memblock.reserved memory but not MIGRATE_MOVABL. All
> > memblock.memory is set to MIGRATE_MOVABL when it is placed in buddy via
> > free_low_memory_core_early and deferred_init_memmap. As a result, when
> > hugetlb_optimize_vmemmap=3D1 and huge pages are allocated, the freed pa=
ges
> > will be placed on buddy's MIGRATE_UNMOVABL list (For example, on machin=
es
> > with 1TB of memory, alloc 2MB huge page size of 1000GB frees up about 1=
5GB
> > to MIGRATE_UNMOVABL). Since the huge page alloc requires a MIGRATE_MOVA=
BL
> > page, a fallback is performed to alloc memory from MIGRATE_UNMOVABL for
> > MIGRATE_MOVABL.
> >
> > Large amount of UNMOVABL memory is not conducive to defragmentation, so
> > the reserved memory is also set to MIGRATE_MOVABLE in the
> > free_low_memory_core_early phase following the alignment of
> > pageblock_nr_pages.
> >
> > Eg=EF=BC=9A
> > echo 500000 > /proc/sys/vm/nr_hugepages
> > cat /proc/pagetypeinfo
> >
> > before=EF=BC=9A
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > =E2=80=A6
> > Node    0, zone   Normal, type    Unmovable     51      2      1     28=
     53     35     35     43     40     69   3852
> > Node    0, zone   Normal, type      Movable   6485   4610    666    202=
    200    185    208     87     54      2    240
> > Node    0, zone   Normal, type  Reclaimable      2      2      1     23=
     13      1      2      1      0      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    0, zone   Normal, type      Isolate      0      0      0      0=
      0      0      0      0      0      0      0
> > Unmovable =E2=89=88 15GB
> >
> > after=EF=BC=9A
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > =E2=80=A6
> > Node    0, zone   Normal, type    Unmovable      0      1      1      0=
      0      0      0      1      1      1      0
> > Node    0, zone   Normal, type      Movable   1563   4107   1119    189=
    256    368    286    132    109      4   3841
> > Node    0, zone   Normal, type  Reclaimable      2      2      1     23=
     13      1      2      1      0      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    0, zone   Normal, type      Isolate      0      0      0      0=
      0      0      0      0      0      0      0
> >
> > Signed-off-by: suhua <suhua1@kingsoft.com>
> > ---
> >  mm/mm_init.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 4ba5607aaf19..e0190e3f8f26 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -722,6 +722,12 @@ static void __meminit init_reserved_page(unsigned =
long pfn, int nid)
> >               if (zone_spans_pfn(zone, pfn))
> >                       break;
> >       }
> > +
> > +     if (pageblock_aligned(pfn)) {
> > +             set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVAB=
LE);
> > +             cond_resched();
> > +     }
>
> If you are trying to make initialization of pageblock migrate type
> consistent with or without CONFIG_DEFERRED_STRUCT_PAGE_INIT, move setting
> of migrate type from deferred_free_pages() to deferred_init_pages().
>
> > +
> >       __init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> >  }
> >  #else
> > --
> > 2.34.1
> >
>
> --
> Sincerely yours,
> Mike.

