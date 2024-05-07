Return-Path: <linux-kernel+bounces-170651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019578BDA37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162321C22D94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE16A8C1;
	Tue,  7 May 2024 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGF7GK4y"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317566A356
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715056645; cv=none; b=VvcF6XYe9s+z+pyu7AqcEqsKizwnpjNAfeRZRbyidIAtYy/YVxJpIInOQEuAiR6T7BQjXtAchned92hUn3LVzb/DgY2S2IezA6M+lyX3J7+PZPkFNsR65z9sQN1k0aolMeJHuDE4O9U6MT23VNJZkFDfCpod1O4OnDc1gA8J86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715056645; c=relaxed/simple;
	bh=R72DOGK6RyONwlbirO7ESOZ822EPE3UVvj9FpkCj9/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klc2z+Pfd6WkzIO3ZZGHB24AsFov6Ix6WfOphBmAtBd3sa/BLrR8qln1Uvd0X5Ql8CNPWctKEMdI/9xQAtS+9X0JHvxBLichSJhdoPACbyK3MI4nKyn/733Vt9nG2H8YKQ/Sm1odmX4/qxoShx3l9Rs+TntoJg8I3BAYdTwoXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGF7GK4y; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ad344f7dso497288766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715056641; x=1715661441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDEi0vI8Iofmi+Jb2rsF44b3FI1pcGL98G5b9QzTf5k=;
        b=IGF7GK4yX6AmPxJU+QsuVlQkeSgvWaL9TtsFBA1ivm1yfxnN+QMx0QnpDjVY/v0rLe
         QDjSZAu0zA0iL4mmA2J4miHEdnHFe7w63Ysa8RsYke0XZsLo0VWYzXgBGd/Jpt/jBd3m
         X9BddCDn90ji1WhIMITo4b2VaXFWsTKC1NYZ2jDJwfCJccThvbYDI1zm61S3G58L8o4s
         Tlzf9+Ax0kaTOZhJS2/F0qkjNrBiVLQX0Ce591ThEyx9WMlFLfrrodUkgFM7f+50YcG7
         +dMpwpsZmoGSwjt+Xpdg1lra8CEXCoufG78RovMODh3cvpRCCYfOJhfr2BU1AGgGKXhV
         3Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715056641; x=1715661441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDEi0vI8Iofmi+Jb2rsF44b3FI1pcGL98G5b9QzTf5k=;
        b=f7qbHhxnU31NwdMkyw3OYqtR/9tiH5OHIjv9Fsi8WJ1rjJxi/JPe1yJqNVdEn+hplR
         ZMA52MkfBVVivSd2XkrgMMbz/hd+9XWRUxtUWruMQ8sUpci8zS0Pk1MBa9h1921UWwhL
         5PszJu1Oe6HLfDDtNXKKhgD9bUxnVEd1Q+b3rJeTHHqpddtjaIg/XtOlQ/Fbn7rzyeLY
         RIjfDV4qVZrE2VXk+o5lGjgbq2PIhNkQyweRVCVXKif3kVzMTrn2W2QblhpsrO7V+5TZ
         jdaYef05lbewmeyylSff3hn4uDGHJlLbyv6gYnvHJFoEPnThqawyKvtZSCnMoMKesUIC
         JqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYpWD8B1L6WKqswfZhdgdB7oPRoxheTZXEcv0sUnSMimZgOEDEUReorYIGxsaKU1xh1icFPJbfYaghRIYsFe6bdSqdnCroTX5/oYCw
X-Gm-Message-State: AOJu0YzZkU4QVfTwWU50ZnNHo4uNh74QsTH669LYxEH4rG4WquWolk9k
	NWslPr8IyXf+tmNhu7aKq2SbOGcwe7ZYr4PoilsaWMjtgURKe9tV0afeVUg+/YztOLATTXADLi+
	EY302Cn1Umby95U+0E4SWkHx/klQ=
X-Google-Smtp-Source: AGHT+IGjnJ4I7BOw3fF6piZmjPbN81pLzS9+ifamu3i+TBYkXnV5ID2ExlH22y0NF+lLcXO0JIGg9JngmdGFQeVPVKc=
X-Received: by 2002:a50:8d1e:0:b0:566:f5d6:4b4 with SMTP id
 s30-20020a508d1e000000b00566f5d604b4mr7087493eds.12.1715056641224; Mon, 06
 May 2024 21:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-3-ioworker0@gmail.com>
 <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
In-Reply-To: <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 12:37:09 +0800
Message-ID: <CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Baolin,

Thanks for taking time to review!

On Tue, May 7, 2024 at 11:40=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/1 12:26, Lance Yang wrote:
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address()
> > to split the folio.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/huge_mm.h | 20 ++++++++++++++++++++
> >   mm/huge_memory.c        | 42 +++++++++++++++++++++-------------------=
-
> >   mm/rmap.c               | 24 +++++++++++++++++------
> >   3 files changed, 60 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index c8d3ec116e29..38c4b5537715 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)
> >       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> >   }
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
> >   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> >   static inline bool folio_test_pmd_mappable(struct folio *folio)
> > @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_area=
_struct *vma, pmd_t *pmd,
> >               unsigned long address, bool freeze, struct folio *folio) =
{}
> >   static inline void split_huge_pmd_address(struct vm_area_struct *vma,
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
> >   #define split_huge_pud(__vma, __pmd, __address)     \
> >       do { } while (0)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 8261b5669397..145505a1dd05 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
> >       pmd_populate(mm, pmd, pgtable);
> >   }
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
> >   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >               unsigned long address, bool freeze, struct folio *folio)
> >   {
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
> >   }
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
>
> I am not sure why need this alignment?
> (1) For a partially mapped THP, 'range.start' and 'range.end' can beyond
> the VMA limits. For a PMD mapped THP, I think the address is already THP
> size alignment returned from vma_address(&folio->page, vma).
> (2) The range.end is not used.

Thanks for pointing that out!

I agree that this alignment is indeed redundant, and we should remove it.
Especially for a partially mapped THP, it could cause 'range.start' and
'range.end' beyond the VMA limits, which could lead us into trouble.

>
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
> > +                     pvmw.pmd =3D NULL;
> > +                     spin_unlock(pvmw.ptl);
>
> IMO, you should also make the 'pvmw.ptl =3D NULL;' after unlocking as
> page_vma_mapped_walk() did, in case some corner case met.

Yep, I'll also set pvmw.ptl to NULL here if any corner cases arise.

Thanks again for the review!
Lance

>
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

