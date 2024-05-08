Return-Path: <linux-kernel+bounces-172709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B358BF5B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03258B24569
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736D2030A;
	Wed,  8 May 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXl/E5F4"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAC17BC9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147029; cv=none; b=kxSC7cqh4Lois87iyA4MMf4vxcZu4yl2cnQMkrKZXFNv4HaCRM8oux9nl3wfJUq92ELUT3MIdwCf9esYmQu2D2DWYsuoHCXhttAE711nQsdLO1pk2XH8hsyebhF/mBrc6nTtoR9B+Jhbi+s1qVSHkPEn1b4aOKanR7pW8wxGV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147029; c=relaxed/simple;
	bh=EKr0nALOHoXOFoZ4Y4D71cUkrpALZRYSZJIDaMqetaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWttMJ5YQdGuO83CTFJzZw6MCJKq6iv2N9zSy52CVZa51aDsTKwJe5VvP+LqE58kF460jP+14c8PNYA47xk0tM4+lSYGzATErTU61luXN15bYGKIN78W3o0K+oR63ffhI2CRxHtKPt4TMgAp72L1mWIPOOSb/shXJlZ0RCFh3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXl/E5F4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db17e8767cso49587121fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715147025; x=1715751825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5PEmbYNWTmC8gM9cZHTBZBiwl2NVDZC9uwbao4CaT0=;
        b=UXl/E5F4W5MldHrAADibiQEOCZt7ysnckk/UvAw3mDi92LKg+YmZdTZigdH1Jvdy18
         ZK4vg0Mvx5EP1FoGD9hqLMhBfk/vHnVc/TXOinc6/NFTyNZwHLqeE8GC3CXeq+AddYEZ
         M1GO7soUujyX7nLJzdDpRD7FF1ifslCgADx9Axq57Tqv5ieXRS87z/Yx660KKBFVP/UU
         OT56kuPXiXM6o8URJyXEKNdGdxOJjq7aTX8i+mimJxoFX3kgRGSW9f6od5tdLuhhDj6C
         UVXhxn45qJ9M/kOutVIgbeq3FTgtay13Z4dc+wtuWcq1u/ufUlpHefYuOpnZ/1yZJxnN
         rE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715147025; x=1715751825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5PEmbYNWTmC8gM9cZHTBZBiwl2NVDZC9uwbao4CaT0=;
        b=JNp3u5I1L4DS65/LprvVxQK0WbfDF7vhv80eYetNwHymDaSV6gW1iKRNKjhAA2PD0i
         v+gDoOwjnWzZq9HTXJrsuS2WLD5Xi1jX6jtunARZxDrzHy95X1oX8HgUV3Ol9TSeX4vQ
         i0oLJsJFxSh1b1AyELRI0ffLB6GwNRJk8AYmnchxPjv//k7dOgNc2rfYP02WAd3b1A84
         YEaCiBH57W3/6J7bOAR57E6Kh0Y3Bmncfg8RPNYoDM8hDNJ7uWrGNdns29rG/wQc5zV2
         T+c8vr7heW35/6vxsX1/w6k5bCRabjzrf9C8QEsObaBoYI2qZ5sgzYtEm54BDGVfsqKS
         E+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXIr7UBseO1WnlFlad05qpLVvAwp3zhyyjaZTiM6UNAbT4ozYB4jzjRXu18OQzMV1LpPMXiF5q8R6OLdTrN2PShAc6vyOCsHwufW4wY
X-Gm-Message-State: AOJu0YxawctoNa9dF4wIZYIKMnBJ51jDxWkj0EY/SLw12H82qlG1Iuo/
	0iVNv3fDgMNCIqGMI+CEVfR5IBNzoQ617o4sblOE/5yvSSIrlAb50r6dDkKi77cfwMuVopOspfB
	JI2P/1U7Cnai2mazZS1GmTrc9HIg=
X-Google-Smtp-Source: AGHT+IEC3boq4vs89DL5IcnOxWiwLxU7007NeBGdGJmImLJ7/t3jkU8frkSKNMJew0yAAHME+Y++dYfiBJc9U+Ztybg=
X-Received: by 2002:a2e:a4ad:0:b0:2e2:350:556f with SMTP id
 38308e7fff4ca-2e4470878d6mr8707611fa.31.1715147025257; Tue, 07 May 2024
 22:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
In-Reply-To: <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 8 May 2024 13:43:33 +0800
Message-ID: <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 1 May 2024, at 0:26, Lance Yang wrote:
>
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address()
> > to split the folio.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 20 ++++++++++++++++++++
> >  mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
> >  mm/rmap.c               | 24 +++++++++++++++++------
> >  3 files changed, 60 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index c8d3ec116e29..38c4b5537715 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)
> >       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> >  }
> >
> > +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> > +                        pmd_t *pmd, bool freeze, struct folio *folio);
> > +
> > +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> > +                                     unsigned long *start,
> > +                                     unsigned long *end)
> > +{
> > +     *start =3D ALIGN(*start, HPAGE_PMD_SIZE);
> > +     *end =3D ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
> > +
> > +     VM_WARN_ON_ONCE(vma->vm_start > *start);
> > +     VM_WARN_ON_ONCE(vma->vm_end < *end);
> > +}
> > +
> >  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> >  static inline bool folio_test_pmd_mappable(struct folio *folio)
> > @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_area=
_struct *vma, pmd_t *pmd,
> >               unsigned long address, bool freeze, struct folio *folio) =
{}
> >  static inline void split_huge_pmd_address(struct vm_area_struct *vma,
> >               unsigned long address, bool freeze, struct folio *folio) =
{}
> > +static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
> > +                                      unsigned long address, pmd_t *pm=
d,
> > +                                      bool freeze, struct folio *folio=
) {}
> > +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> > +                                     unsigned long *start,
> > +                                     unsigned long *end) {}
> >
> >  #define split_huge_pud(__vma, __pmd, __address)      \
> >       do { } while (0)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 8261b5669397..145505a1dd05 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
> >       pmd_populate(mm, pmd, pgtable);
> >  }
> >
> > +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> > +                        pmd_t *pmd, bool freeze, struct folio *folio)
> > +{
> > +     VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
> > +     VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
> > +     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> > +     VM_BUG_ON(freeze && !folio);
> > +
> > +     /*
> > +      * When the caller requests to set up a migration entry, we
> > +      * require a folio to check the PMD against. Otherwise, there
> > +      * is a risk of replacing the wrong folio.
> > +      */
> > +     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> > +         is_pmd_migration_entry(*pmd)) {
> > +             if (folio && folio !=3D pmd_folio(*pmd))
> > +                     return;
> > +             __split_huge_pmd_locked(vma, pmd, address, freeze);
> > +     }
> > +}
> > +
> >  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >               unsigned long address, bool freeze, struct folio *folio)
> >  {
> > @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct *vma=
, pmd_t *pmd,
> >                               (address & HPAGE_PMD_MASK) + HPAGE_PMD_SI=
ZE);
> >       mmu_notifier_invalidate_range_start(&range);
> >       ptl =3D pmd_lock(vma->vm_mm, pmd);
> > -
> > -     /*
> > -      * If caller asks to setup a migration entry, we need a folio to =
check
> > -      * pmd against. Otherwise we can end up replacing wrong folio.
> > -      */
> > -     VM_BUG_ON(freeze && !folio);
> > -     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> > -
> > -     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> > -         is_pmd_migration_entry(*pmd)) {
> > -             /*
> > -              * It's safe to call pmd_page when folio is set because i=
t's
> > -              * guaranteed that pmd is present.
> > -              */
> > -             if (folio && folio !=3D pmd_folio(*pmd))
> > -                     goto out;
> > -             __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> > -     }
> > -
> > -out:
> > +     split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
> >       spin_unlock(ptl);
> >       mmu_notifier_invalidate_range_end(&range);
> >  }
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 7e2575d669a9..432601154583 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >       if (flags & TTU_SYNC)
> >               pvmw.flags =3D PVMW_SYNC;
> >
> > -     if (flags & TTU_SPLIT_HUGE_PMD)
> > -             split_huge_pmd_address(vma, address, false, folio);
> > -
> >       /*
> >        * For THP, we have to assume the worse case ie pmd for invalidat=
ion.
> >        * For hugetlb, it could be much worse if we need to do pud
> > @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >       range.end =3D vma_address_end(&pvmw);
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
> >                               address, range.end);
> > +     if (flags & TTU_SPLIT_HUGE_PMD)
> > +             align_huge_pmd_range(vma, &range.start, &range.end);
> >       if (folio_test_hugetlb(folio)) {
> >               /*
> >                * If sharing is possible, start and end will be adjusted
> > @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       while (page_vma_mapped_walk(&pvmw)) {
> > -             /* Unexpected PMD-mapped THP? */
> > -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> > -
> >               /*
> >                * If the folio is in an mlock()d vma, we must not swap i=
t out.
> >                */
> > @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >                       goto walk_done_err;
> >               }
> >
> > +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > +                     /*
> > +                      * We temporarily have to drop the PTL and start =
once
> > +                      * again from that now-PTE-mapped page table.
> > +                      */
> > +                     split_huge_pmd_locked(vma, range.start, pvmw.pmd,=
 false,
> > +                                           folio);
>
> Just in case you might miss here, since you will no longer align
> range.start as Baolin mentioned in another email and you have a VM_WARN_O=
NCE
> in split_huge_pmd_locked(), you will need to align the input address now.

Thanks for bringing that up!

I do miss the alignment here when I decide to no longer align range.start
in another email - thanks!

Zi, could I move the alignment here?
IIUC, we will not encounter a partially mapped THP here, and range.start
and range.end should also not beyond the VMA limits.

                     align_huge_pmd_range(vma, &range.start, &range.end);
                     split_huge_pmd_locked(vma, range.start, pvmw.pmd, fals=
e,
                                           folio);


Thanks,
Lance

>
> > +                     pvmw.pmd =3D NULL;
> > +                     spin_unlock(pvmw.ptl);
> > +                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > +                     continue;
> > +             }
> > +
> > +             /* Unexpected PMD-mapped THP? */
> > +             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> > +
> >               pfn =3D pte_pfn(ptep_get(pvmw.pte));
> >               subpage =3D folio_page(folio, pfn - folio_pfn(folio));
> >               address =3D pvmw.address;
> > --
> > 2.33.1
>
>
> --
> Best Regards,
> Yan, Zi

