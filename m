Return-Path: <linux-kernel+bounces-173417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57168C002D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D36428C46D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF7126F07;
	Wed,  8 May 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBwZxZEw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7F86AF4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178946; cv=none; b=UIJC2YC3HqEbHOE7NfnypqehkyMqL60SHfqYP3LHFclSzBFv5w6Us8BmRWJngb6poCX7J7/Lpn3yGrz2hnc8AmrYtrAxhVtn6brnEEf4TDRL1c16Ubt/Hb9z8/SW/CsGDtV6B+UkmGjI3bs3hFlyr9LRUOehIQr5eP5dIoeEMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178946; c=relaxed/simple;
	bh=h2DGbp7NLxfHhIvrEwhp1mIr4hlCgEmCUhLmc+daBaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe9+BaKnW398tXYlCcRx/gaPANenioxRA+tk8iRapuFk3vL3bCdCZDL5Z03iWzwAbyuJKbCXoPHCSXQI6q0N8bD3SMvGXU25V/4LCccRNqzpbjSFXEFE+zhj49kk3RRH4GaSQXqUURtr0T+0WWPWQoa7u9kpQuPq0iAEklcxu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBwZxZEw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59e4136010so664842466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178942; x=1715783742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSdFQi7WEyAPecRMBfbjj3HF+3TVM1BEUIWbOf9ypA8=;
        b=CBwZxZEwU3ZEZL5R71a+O6MH9PjrgM+UkA+MWhYumP8U/dX+YdUZMeYCLM2NwxumVv
         i/pJkKSGDUtCEPt6V62VH/F8HEba7OfuMRpXr0/iCzaukPCFo3//3v92x4N6Q/LRUfEv
         BNx9Ub0oYtgbna5xZKbflgCafH31NL0Earupzi84UDgr4pQGf8oEqHz+ESs+rvK51/vE
         sOHwxLHGAguY52KMDlteJDilEv+snHaNswunySXzIGh4M92mC90ox5ML3nB9MBgXbhyL
         QZDHN+RaFTviEQTDnB9WObll9AQjFDesxxmQL2UNuOvFwaDUX3c6hW9XJFjcPBe3xjuf
         3oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178942; x=1715783742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSdFQi7WEyAPecRMBfbjj3HF+3TVM1BEUIWbOf9ypA8=;
        b=OqT6c74lIVZ0070ulOkfZRptIWOQCdgKA4zLrbAxjeXyVmi8HlGx074rCd3n975F7K
         3MDFL10NtjV0rc7yLYVpE/1+ZIGFLYeCwg40weU5i6gu8nS4JZYZUeB5wp3+PTVQhvei
         /luRRoMHBGBF0+eVVpl4VAcLivJXXJ7Z50ckLJiHfTVLVQS84X3PfAyPftXi0/g/zuhS
         SENwTgyyV83hXdKg17vqz188OXAICDW5kuuD0E3JNgRjcrkSENA4Mo8q1NVVL63ZBCJ8
         aTAnO+c77WcIonKshwZ2CtG5Efv5OzoGuB1iOyYaAcBlQYhv6o7rIFm3Ljm/abMdO6hY
         rvOg==
X-Forwarded-Encrypted: i=1; AJvYcCUj9TiKmkOcYkpVjZN7nd7Lp5oG9amepLSdH63Y7zZP83Hmx1VQV4M6fqxH6aeslUfCNtvCyRDhmIg5HEwMCCeLIXmQ9yBMqK/uLV/P
X-Gm-Message-State: AOJu0YyBqj1DBXblMPmvQ2FcfXF2Cpe3WWnEBakUePuJGqylvihB5vyc
	6qv+40aKDNDib/peRE+3x3Qu7qbLclwQElo1hQP4V516dSHvPE7lSl7YTJbKn5GkgE0jV6d1CDc
	2zgoAJ2Y5lS0yMfkwXRCV8Wp7WP8=
X-Google-Smtp-Source: AGHT+IFM3fxW+ad9Mrsz43fhcWZSiYP7UCfoc7C2RZAuglscuVMehmOhWV4iB9t7DmAW9r/6Sn7RL7PPzMw3wIWsBGc=
X-Received: by 2002:a50:c34f:0:b0:572:943a:cdf2 with SMTP id
 4fb4d7f45d1cf-5731d9b659bmr1881465a12.1.1715178942095; Wed, 08 May 2024
 07:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com> <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
In-Reply-To: <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 8 May 2024 22:35:30 +0800
Message-ID: <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
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

On Wed, May 8, 2024 at 10:07=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 8 May 2024, at 1:43, Lance Yang wrote:
>
> > On Tue, May 7, 2024 at 11:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 1 May 2024, at 0:26, Lance Yang wrote:
> >>
> >>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> >>> folios, start the pagewalk first, then call split_huge_pmd_address()
> >>> to split the folio.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>> ---
> >>>  include/linux/huge_mm.h | 20 ++++++++++++++++++++
> >>>  mm/huge_memory.c        | 42 +++++++++++++++++++++------------------=
--
> >>>  mm/rmap.c               | 24 +++++++++++++++++------
> >>>  3 files changed, 60 insertions(+), 26 deletions(-)
> >>>
> >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>> index c8d3ec116e29..38c4b5537715 100644
> >>> --- a/include/linux/huge_mm.h
> >>> +++ b/include/linux/huge_mm.h
> >>> @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)
> >>>       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> >>>  }
> >>>
> >>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 address,
> >>> +                        pmd_t *pmd, bool freeze, struct folio *folio=
);
> >>> +
> >>> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> >>> +                                     unsigned long *start,
> >>> +                                     unsigned long *end)
> >>> +{
> >>> +     *start =3D ALIGN(*start, HPAGE_PMD_SIZE);
> >>> +     *end =3D ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
> >>> +
> >>> +     VM_WARN_ON_ONCE(vma->vm_start > *start);
> >>> +     VM_WARN_ON_ONCE(vma->vm_end < *end);
> >>> +}
> >>> +
> >>>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>>
> >>>  static inline bool folio_test_pmd_mappable(struct folio *folio)
> >>> @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
> >>>               unsigned long address, bool freeze, struct folio *folio=
) {}
> >>>  static inline void split_huge_pmd_address(struct vm_area_struct *vma=
,
> >>>               unsigned long address, bool freeze, struct folio *folio=
) {}
> >>> +static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
> >>> +                                      unsigned long address, pmd_t *=
pmd,
> >>> +                                      bool freeze, struct folio *fol=
io) {}
> >>> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> >>> +                                     unsigned long *start,
> >>> +                                     unsigned long *end) {}
> >>>
> >>>  #define split_huge_pud(__vma, __pmd, __address)      \
> >>>       do { } while (0)
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 8261b5669397..145505a1dd05 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_=
area_struct *vma, pmd_t *pmd,
> >>>       pmd_populate(mm, pmd, pgtable);
> >>>  }
> >>>
> >>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 address,
> >>> +                        pmd_t *pmd, bool freeze, struct folio *folio=
)
> >>> +{
> >>> +     VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
> >>> +     VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
> >>> +     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> >>> +     VM_BUG_ON(freeze && !folio);
> >>> +
> >>> +     /*
> >>> +      * When the caller requests to set up a migration entry, we
> >>> +      * require a folio to check the PMD against. Otherwise, there
> >>> +      * is a risk of replacing the wrong folio.
> >>> +      */
> >>> +     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> >>> +         is_pmd_migration_entry(*pmd)) {
> >>> +             if (folio && folio !=3D pmd_folio(*pmd))
> >>> +                     return;
> >>> +             __split_huge_pmd_locked(vma, pmd, address, freeze);
> >>> +     }
> >>> +}
> >>> +
> >>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >>>               unsigned long address, bool freeze, struct folio *folio=
)
> >>>  {
> >>> @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct *v=
ma, pmd_t *pmd,
> >>>                               (address & HPAGE_PMD_MASK) + HPAGE_PMD_=
SIZE);
> >>>       mmu_notifier_invalidate_range_start(&range);
> >>>       ptl =3D pmd_lock(vma->vm_mm, pmd);
> >>> -
> >>> -     /*
> >>> -      * If caller asks to setup a migration entry, we need a folio t=
o check
> >>> -      * pmd against. Otherwise we can end up replacing wrong folio.
> >>> -      */
> >>> -     VM_BUG_ON(freeze && !folio);
> >>> -     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> >>> -
> >>> -     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> >>> -         is_pmd_migration_entry(*pmd)) {
> >>> -             /*
> >>> -              * It's safe to call pmd_page when folio is set because=
 it's
> >>> -              * guaranteed that pmd is present.
> >>> -              */
> >>> -             if (folio && folio !=3D pmd_folio(*pmd))
> >>> -                     goto out;
> >>> -             __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> >>> -     }
> >>> -
> >>> -out:
> >>> +     split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
> >>>       spin_unlock(ptl);
> >>>       mmu_notifier_invalidate_range_end(&range);
> >>>  }
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 7e2575d669a9..432601154583 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >>>       if (flags & TTU_SYNC)
> >>>               pvmw.flags =3D PVMW_SYNC;
> >>>
> >>> -     if (flags & TTU_SPLIT_HUGE_PMD)
> >>> -             split_huge_pmd_address(vma, address, false, folio);
> >>> -
> >>>       /*
> >>>        * For THP, we have to assume the worse case ie pmd for invalid=
ation.
> >>>        * For hugetlb, it could be much worse if we need to do pud
> >>> @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >>>       range.end =3D vma_address_end(&pvmw);
> >>>       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm=
,
> >>>                               address, range.end);
> >>> +     if (flags & TTU_SPLIT_HUGE_PMD)
> >>> +             align_huge_pmd_range(vma, &range.start, &range.end);
> >>>       if (folio_test_hugetlb(folio)) {
> >>>               /*
> >>>                * If sharing is possible, start and end will be adjust=
ed
> >>> @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >>>       mmu_notifier_invalidate_range_start(&range);
> >>>
> >>>       while (page_vma_mapped_walk(&pvmw)) {
> >>> -             /* Unexpected PMD-mapped THP? */
> >>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >>> -
> >>>               /*
> >>>                * If the folio is in an mlock()d vma, we must not swap=
 it out.
> >>>                */
> >>> @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *fol=
io, struct vm_area_struct *vma,
> >>>                       goto walk_done_err;
> >>>               }
> >>>
> >>> +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> >>> +                     /*
> >>> +                      * We temporarily have to drop the PTL and star=
t once
> >>> +                      * again from that now-PTE-mapped page table.
> >>> +                      */
> >>> +                     split_huge_pmd_locked(vma, range.start, pvmw.pm=
d, false,
> >>> +                                           folio);
> >>
> >> Just in case you might miss here, since you will no longer align
> >> range.start as Baolin mentioned in another email and you have a VM_WAR=
N_ONCE
> >> in split_huge_pmd_locked(), you will need to align the input address n=
ow.
> >
> > Thanks for bringing that up!
> >
> > I do miss the alignment here when I decide to no longer align range.sta=
rt
> > in another email - thanks!
> >
> No problem.
>
> > Zi, could I move the alignment here?
> > IIUC, we will not encounter a partially mapped THP here, and range.star=
t
> > and range.end should also not beyond the VMA limits.
> >
> >                      align_huge_pmd_range(vma, &range.start, &range.end=
);
> >                      split_huge_pmd_locked(vma, range.start, pvmw.pmd, =
false,
> >                                            folio);
>
> I think you can just do
>
> split_huge_pmd_locked(vma, ALIGN(range.start, HPAGE_PMD_SIZE), pvmw.pmd, =
false, folio);
>
> since range will later be used by mmu_notifier_invalidate_range_end() and=
 changing
> it might cause secondary TLB invalidation issues.

Ok, makes sense to me - thanks!

But we probably cannot use the HPAGE_PMD_SIZE here; it will cause
broken compilation as seen in v3[1].

Perhaps we still need to add a new alignment function for the huge PMD?

[1] https://lore.kernel.org/linux-mm/20240429202040.187453-1-sj@kernel.org/

Thanks again for the review!

Best,
Lance



>
> >
> > Thanks,
> > Lance
> >
> >>
> >>> +                     pvmw.pmd =3D NULL;
> >>> +                     spin_unlock(pvmw.ptl);
> >>> +                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> >>> +                     continue;
> >>> +             }
> >>> +
> >>> +             /* Unexpected PMD-mapped THP? */
> >>> +             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >>> +
> >>>               pfn =3D pte_pfn(ptep_get(pvmw.pte));
> >>>               subpage =3D folio_page(folio, pfn - folio_pfn(folio));
> >>>               address =3D pvmw.address;
> >>> --
> >>> 2.33.1
> >>
> >>
> >> --
> >> Best Regards,
> >> Yan, Zi
>
>
> --
> Best Regards,
> Yan, Zi

