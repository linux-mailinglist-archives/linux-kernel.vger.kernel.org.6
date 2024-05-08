Return-Path: <linux-kernel+bounces-172692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9F8BF585
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5438B1C22D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF89179BC;
	Wed,  8 May 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIT6xoEX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1117597
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145283; cv=none; b=LCn2pFRYROPUE/uVfN+azsLl/PjNnP50wAahye7sPEugUjcBNlVSNUcDMo31BwzVkml7CoIvUqfJiTARR/9O0jv7s5arAweJz0R0VlYP2RWQputu6Rk8V5zzCy+ZZKpC6gLrF1ofwe70CYsK0EAMXaS27khZhXlYPSG4ps9P5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145283; c=relaxed/simple;
	bh=dPS0rGrYQUxBpoJN3CR8XFSPSI7eBe4wL3aiWA/H1GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s59CfNR44eOa4LFD5t06Hoe+3INwbE4V10k3AmF8CH5GQ0SP6rFx2bXYxk5vlME8pYQqoC4GBCACbur2BHQMdMf5XB3k15rQkKQpTazyUtwlEVX293ZBpcZWYZQk92p5qYzo5VjGBjvfaaybEaygT7wXhSj0RpKNdTvEbrb6Nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIT6xoEX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572adaa172cso796082a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715145279; x=1715750079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LyzSFLYlexgFjtX1X6+Hr5dHIkUV+Eu+niVH388nLk=;
        b=AIT6xoEXQZP4ca3ezB1x5uh1piz9SiYT7Zhn4SWocfTdDbRnEuD0/1/EZXvfIbSUqP
         ej7U1k76XFrxmqb7i2kgChD0UmkdTAP02bXhs3Ytbsi5ZWD6+1Ff02IlFKzZvGMV90eQ
         7DJr/CpE3cMbkwxfnTHkcYk2nE3ioH/kyhfVFebqBQ9lcWH0JZ/xUK3qRa0ZJ9k2QQGz
         xTJcjDBQyEljrO6I062PfrfYsFvwPO6Hdz7NoxSEdG74sFS0Rr9Mdxaf049DEREO8fRp
         Nu8y6dNlAebuBCOkDo0mmEBnE0g32q23sM/k0ut+UktVVJvS1rx5jn0u0Jz2ieb2Ghiv
         DPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715145279; x=1715750079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LyzSFLYlexgFjtX1X6+Hr5dHIkUV+Eu+niVH388nLk=;
        b=m0R8UGMLuLe8svQGnGu9riec4xHerOOF/5PkRfQxddOnkCgTDRiDruV0hqAVEipK6E
         bvyjzEjFVqZlv2JmIa/S21NXJQkdQ54idlHgGWHfHiX2lJg6nMMl2Q/hJWrgxabbR3s9
         PTuTyCDIPbXo4pK+8i6J8NOtqOIRzSgqegUK08usQhRWdNNogtWpM7UUTqSD5fLtbiIz
         eGNYwImDbmFQ6HrWnuuXd3R4+mfweW5SdEjDa3QPUbkabT7cVDnzfOkaxZ4LngBTTmVW
         vWDHTdHIBXlgH2FIbvURfhhwnn9nYBYuswanHTak8VfK4MPz6rPc0VmUkD3AVzQYNNfI
         fveQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLPXzGehKjrByDQbFcBxvG6mfuOzArRC12DykXwnnJSgwhmJNo2hCkZEzT7B8GKD2Xe0ghwon3txqJkuxNrCzTsGiLiGPoeWaQDceu
X-Gm-Message-State: AOJu0Yz21zhvlvzc/8SuFD0Ju5SRUK7D4b2CqwqGx6gQlyuOYo39LMiI
	Db49MQsEhyQT+pjMH2DG5PUoGwN5Mhg51Pf3HXi9lwmh7kblwkGSpq5Nyf8efeD+LN6ZEaXhdL4
	tr5tcC1RpLTFpUAwrj4pv6EUnnJc=
X-Google-Smtp-Source: AGHT+IFSkxSQRrOJtQm4GC5stVxBepUVcQ95xgMMBKbXpuewUwp4OtsPe+AWdwvjRkdFYbk6eeSqSWQT0y344LzC03o=
X-Received: by 2002:aa7:c2d3:0:b0:572:5122:4845 with SMTP id
 4fb4d7f45d1cf-5731101d43fmr3949764a12.4.1715145279143; Tue, 07 May 2024
 22:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-4-ioworker0@gmail.com>
 <9BC53B16-A63F-48DF-BE0B-D51E0E82E1B4@nvidia.com>
In-Reply-To: <9BC53B16-A63F-48DF-BE0B-D51E0E82E1B4@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 8 May 2024 13:14:27 +0800
Message-ID: <CAK1f24m_kfj8bc3VpwX3Y=+=twU17qRtWZQhKRXWJZvQiYv8og@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
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

Hey Zi,

Thanks for taking time to review!

On Wed, May 8, 2024 at 12:20=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 1 May 2024, at 0:27, Lance Yang wrote:
>
> > When the user no longer requires the pages, they would use
> > madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> > typically would not re-write to that memory again.
> >
> > During memory reclaim, if we detect that the large folio and its PMD ar=
e
> > both still marked as clean and there are no unexpected references
> > (such as GUP), so we can just discard the memory lazily, improving the
> > efficiency of memory reclamation in this case.  On an Intel i5 CPU, rec=
laiming 1GiB of lazyfree THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > Suggested-by: Zi Yan <ziy@nvidia.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  9 +++++
> >  mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++++++++++
> >  mm/rmap.c               |  3 ++
> >  3 files changed, 85 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 38c4b5537715..017cee864080 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
> >
> >  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> >                          pmd_t *pmd, bool freeze, struct folio *folio);
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio);
> >
> >  static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> >                                       unsigned long *start,
> > @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct vm_=
area_struct *vma,
> >                                       unsigned long *start,
> >                                       unsigned long *end) {}
> >
> > +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> > +                                      unsigned long addr, pmd_t *pmdp,
> > +                                      struct folio *folio)
> > +{
> > +     return false;
> > +}
> > +
> >  #define split_huge_pud(__vma, __pmd, __address)      \
> >       do { } while (0)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 145505a1dd05..90fdef847a88 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
> >       try_to_unmap_flush();
> >  }
> >
> > +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> > +                                    unsigned long addr, pmd_t *pmdp,
> > +                                    struct folio *folio)
> > +{
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     int ref_count, map_count;
> > +     pmd_t orig_pmd =3D *pmdp;
> > +     struct mmu_gather tlb;
> > +     struct page *page;
> > +
> > +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> > +             return false;
> > +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd))=
)
> > +             return false;
> > +
> > +     page =3D pmd_page(orig_pmd);
> > +     if (unlikely(page_folio(page) !=3D folio))
> > +             return false;
> > +
> > +     tlb_gather_mmu(&tlb, mm);
> > +     orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> > +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> > +
> > +     /*
> > +      * Syncing against concurrent GUP-fast:
> > +      * - clear PMD; barrier; read refcount
> > +      * - inc refcount; barrier; read PMD
> > +      */
> > +     smp_mb();
> > +
> > +     ref_count =3D folio_ref_count(folio);
> > +     map_count =3D folio_mapcount(folio);
> > +
> > +     /*
> > +      * Order reads for folio refcount and dirty flag
> > +      * (see comments in __remove_mapping()).
> > +      */
> > +     smp_rmb();
> > +
> > +     /*
> > +      * If the PMD or folio is redirtied at this point, or if there ar=
e
> > +      * unexpected references, we will give up to discard this folio
> > +      * and remap it.
> > +      *
> > +      * The only folio refs must be one from isolation plus the rmap(s=
).
> > +      */
> > +     if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> > +         pmd_dirty(orig_pmd)) {
> > +             set_pmd_at(mm, addr, pmdp, orig_pmd);
> > +             return false;
> > +     }
> > +
> > +     folio_remove_rmap_pmd(folio, page, vma);
> > +     zap_deposited_table(mm, pmdp);
> > +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +     folio_put(folio);
> > +
> > +     return true;
> > +}
> > +
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio)
> > +{
> > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > +     VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> > +
> > +     if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > +             return __discard_trans_pmd_locked(vma, addr, pmdp, folio)=
;
> > +
> > +     return false;
> > +}
> > +
> >  static void remap_page(struct folio *folio, unsigned long nr)
> >  {
> >       int i =3D 0;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 432601154583..1d3d30cb752c 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1675,6 +1675,9 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >               }
> >
> >               if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > +                     if (unmap_huge_pmd_locked(vma, range.start, pvmw.=
pmd,
> > +                                               folio))
> > +                             goto walk_done;
>
> You might not need to check (flags & TTU_SPLIT_HUGE_PMD) for
> unmap_huge_pmd_locked(), since you are unmapping a PMD here.
> TTU_SPLIT_HUGE_PMD is here because try_to_unmap_one() was not able to unm=
ap
> a PMD. You probably can remove it for callers that are unmapping
> the folio but not the ones are swapping.

Thanks for the suggestion!

Ageed. For unmap_huge_pmd_locked(), there is no need to check the
TTU_SPLIT_HUGE_PMD flag. We only need to check the flag for
split_huge_pmd_locked().

Given this, if we fail to remove the PMD mapping and the flag is not set,
I think we should stop the walk. So we can also remove the
VM_BUG_ON_FOLIO() below.

/* Unexpected PMD-mapped THP? */
VM_BUG_ON_FOLIO(!pvmw.pte, folio);

Zi, what do you think?

Thanks,
Lance

>
>
>
> >                       /*
> >                        * We temporarily have to drop the PTL and start =
once
> >                        * again from that now-PTE-mapped page table.
> > --
> > 2.33.1
>
>
> --
> Best Regards,
> Yan, Zi

