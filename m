Return-Path: <linux-kernel+bounces-212939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFA906876
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EC91F23840
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB313E030;
	Thu, 13 Jun 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca4cvwmg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2213DBA4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270483; cv=none; b=OVbaHobXvFuV3nKs5VfPh+ZgLB3+D/TWgXp0ZpM4bOEunCgXwxZEmgx7rMNoj9HQ573iyXRM7fU4XoKo+i6OgbndwWyst8fdFp3kH7yshFyY96u9x+YkDrrbLq6WrY/RdhbP2KmQLSfeopMFgDcSZ3LRCRa4SzPjem1VgtUYOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270483; c=relaxed/simple;
	bh=Qb59uFGIYrEALt4uU6gJAxSY0VQuYAMYmhCHrW+cF7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rgg7uFa5gzaUQCiv2S+9nio3IkKoS2IQeOouI8G9NQ+476b247VBlxds/604MqPpdsD2HMH2yO46Db+s+oVtuhiV61ON86QFhJtYMGKdQD8mnX2+rh9/egm+XEITCgyGd1UbypS3bdzlaK64ElvLQBNA1NhD8CgXvO+aUWIpTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca4cvwmg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so715355a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718270479; x=1718875279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRtqnD5t+ohGXkbp2lKM09Q2LnCUwBKJroE7NvFdMjI=;
        b=ca4cvwmgccROPTi1Ski5Jo7UqFUqLWPCducHNL4VrLBk/mVOk0jkLCgyENrs19EltM
         5wCzxW87p6iVKycOyX5klBOZhNPMi9bdreo7vQgd1ETxKJlvXPXkivH/6+cAm91v25jZ
         eHosaivtol3/0IvFZu4+uAhZr6YUsoM/Kvh3yqFBj/2+qZINMryUr1+ZVHnzEfVK+RLj
         12IcPYmCWwDcwbvFSBwgp5fH6sxT3QsGYbxF34iiHefuCPPOatneuBVarKIEORLPEbYB
         mocj7v160lIqolxCzWTHW/TcEyy7q4fW+iS/2Sq1/Vw2hoy6CccS28lzoEGSfE+WIseQ
         7YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270479; x=1718875279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRtqnD5t+ohGXkbp2lKM09Q2LnCUwBKJroE7NvFdMjI=;
        b=XenJCn9+AhKeIh23P7BU38SWIEYvZzeivySuosNK9dwC9Jnr9mTr2E65c4RfBXC6iW
         9mesEEqQaCDgp453xxrArQoirucefz0sJ+mr8TQS4+rvIdXzAcf0dtT+hICXSJAKzEaF
         YnNn/WO8kgNSQO6LW6OYdjiE1tMdYeGCjbuUvYKEUtxW6SBK2XeQbzExrH6/005Jv9i2
         w12GjzT4moLJAICbr/DNj7huSa/Qf4RSy1VRojPXUtN0f5LKeAj5Garp1y0M6D4f712Q
         4uHrMprPCG0yi8uL4cFLRPCuqMiL/Rzey5xcj/4JqHVYN259UHKxg0+gQDRhhTrMIkE1
         Tnsw==
X-Forwarded-Encrypted: i=1; AJvYcCURM0PFf2NWUPOjvx+5GF34r+PCuoTwI9J2KIEmJs1D3fRBc/Qukxzt9/QBLvW86FJKsrVoCU7BbcpcOv7ks1/FB/nV2Wk8dU/dV0jJ
X-Gm-Message-State: AOJu0Yy9tDq//NW/wnU5TQcQsjltTV1MA1SyYplsIYL3yaSUdQvjV9q4
	CGenHsN/50r15eVr5AShAiW12OPzEmw6kgsaCuGR4GNjI7etQSrq7H8w4rtnwOQ57ZpHxFTL0se
	e/qEu9tlTbEwUi1PtdUXK3vhT3Rs=
X-Google-Smtp-Source: AGHT+IEuhg0v5vMIzqD0pYtPQG2SRGJinZeB6/vLBsysPeHGUCktyBgiRl+ZI1biCozI5+D2q92AiJ3o8kYmYc2So8M=
X-Received: by 2002:a50:d6da:0:b0:57c:7413:a6e0 with SMTP id
 4fb4d7f45d1cf-57ca9749920mr2871493a12.2.1718270478935; Thu, 13 Jun 2024
 02:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120209.66311-1-ioworker0@gmail.com> <20240610120618.66520-1-ioworker0@gmail.com>
 <933c7339-2dbd-464b-b342-e4cff7ad75a3@redhat.com>
In-Reply-To: <933c7339-2dbd-464b-b342-e4cff7ad75a3@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 13 Jun 2024 17:21:07 +0800
Message-ID: <CAK1f24mH1KvPRfMjijm8hC417HE5939Ko9cK9ZM_HoQn=BNxbA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, fengwei.yin@intel.com, libang.li@antgroup.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, maskray@google.com, 
	mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, sj@kernel.org, songmuchun@bytedance.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiehuan09@gmail.com, 
	ziy@nvidia.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:34=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 10.06.24 14:06, Lance Yang wrote:
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address() to
> > split the folio.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/huge_mm.h |  6 ++++++
> >   mm/huge_memory.c        | 42 +++++++++++++++++++++-------------------=
-
> >   mm/rmap.c               | 21 +++++++++++++++------
> >   3 files changed, 43 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 088d66a54643..4670c6ee118b 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -415,6 +415,9 @@ static inline bool thp_migration_supported(void)
> >       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> >   }
> >
> > +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> > +                        pmd_t *pmd, bool freeze, struct folio *folio);
> > +
> >   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> >   static inline bool folio_test_pmd_mappable(struct folio *folio)
> > @@ -477,6 +480,9 @@ static inline void __split_huge_pmd(struct vm_area_=
struct *vma, pmd_t *pmd,
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
> >
> >   #define split_huge_pud(__vma, __pmd, __address)     \
> >       do { } while (0)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e6d26c2eb670..d2697cc8f9d4 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2581,6 +2581,27 @@ static void __split_huge_pmd_locked(struct vm_ar=
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
>
> Curious: could we actually end up here without a folio right now? That
> would mean, that try_to_unmap_one() would be called with folio=3D=3DNULL.

try_to_unmap_one() would not be called with folio=3D=3DNULL, I guess.

I just moved 'VM_BUG_ON(freeze && !folio)' from __split_huge_pmd() to here,
and now __split_huge_pmd() will call split_huge_pmd_locked().

>
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
> > @@ -2592,26 +2613,7 @@ void __split_huge_pmd(struct vm_area_struct *vma=
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
> > index ddffa30c79fb..b77f88695588 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio,=
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
> > @@ -1668,9 +1665,6 @@ static bool try_to_unmap_one(struct folio *folio,=
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
> > @@ -1682,6 +1676,21 @@ static bool try_to_unmap_one(struct folio *folio=
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
> > +                     split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd=
,
> > +                                           false, folio);
> > +                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > +                     page_vma_mapped_walk_restart(&pvmw);
>
> If, for some reason, split_huge_pmd_locked() would fail, we would keep
> looping and never hit the VM_BUG_ON_FOLIO() below. Maybe we'd want to
> let split_huge_pmd_locked() return whether splitting succeeded, and
> handle that case differently?

Hmm... after calling split_huge_pmd_locked(), we also do
"flags &=3D ~TTU_SPLIT_HUGE_PMD", preventing re-entry into this block,
then triggering the VM_BUG_ON_FOLIO() below if split_huge_pmd_locked()
fails, IIUC.

What do you think?

Thanks,
Lance

>
> > +                     continue;
> > +             }
> > +
> > +             /* Unexpected PMD-mapped THP? */
> > +             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> > +
> >               pfn =3D pte_pfn(ptep_get(pvmw.pte));
> >               subpage =3D folio_page(folio, pfn - folio_pfn(folio));
> >               address =3D pvmw.address;
>
> --
> Cheers,
>
> David / dhildenb
>

