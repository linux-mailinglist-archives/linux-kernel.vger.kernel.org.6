Return-Path: <linux-kernel+bounces-174487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2948C0F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E2F1F21D04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2114AD3A;
	Thu,  9 May 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqYhL5AT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C112F5B3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257042; cv=none; b=MaPAeA9H6EnNTHcL0978/OxRJ3P77bP1i/XR9f4ebRfJB/ax2LmdanJbpuOs1Sw44kpZsyelYJnZx/XqpZsQ/2IndAkJCnnaXNTvlZBCrIs8wvoPKm3eN+1VX6iCsebfqhNb/Uw/a+WsRpGeoae/12Gbn3wc0skRk4ukqOQUkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257042; c=relaxed/simple;
	bh=iGoSOIi+vliVXbnjKHGm7IUCwf0PbcGIQj65flzVDUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhE7zpbKfoXn53w/8dCP74ToQBhm+XwB4brgtsRofQuNojVCr80x/ka44ZjY5kJHseMIomGYIx8/sInc0F6B+MLjnAgi/4KMvOtygNOdf4ergRKxrtOazkEKTmS7FKO5cOgQA60QBECyUrs9hOeQvPHBPraq7v72v2uqEIIBiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqYhL5AT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so1349904e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715257038; x=1715861838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXwwXW5AOn6SfEw6hk8ufXJisedvrYItqxzpT+rKDlU=;
        b=mqYhL5ATEYG0/SgjGZZ3wom6MQuwL+1bWwDwikWhqbIyu0ZdDOURZNzivFHyPHWcH2
         sg0g3JhPsEZXjDjki4CHZEnG+gr9My1AxBRS9V9Z5SKuycYhyNVsL8WU6pURCbmLuIug
         Qma15TyTW5vbf7xnYlQM54IpZ5yQfqN4OuXzJdSTO28Gcn6tj28Tq8HYFr9L0Y2QJ9+w
         O9Qforlu/GecYqyLkuhlRjIgtt+BtBYDIyNfiXq08uzs6tmcA0sXZrNMoftipr3icE7y
         QlZn13wZhad3ub1ivJbsS3ovFygieBn6RNVTklENgB6D+hJdqanLQ3i741xdNyoN5EMI
         7eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715257038; x=1715861838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXwwXW5AOn6SfEw6hk8ufXJisedvrYItqxzpT+rKDlU=;
        b=DmbEVgkte+FpmxzTpxCrA6R/tKJ0XwEyJxanUupbhnDJnY6LU2FRvddE3rAK2ysEHq
         OmcOLg2H4tSMUWuZmakVvvwld3qezxp5AzQ5jwvSqqW6xA0jHo33GjiicPjIXelf7CPu
         j9Qixyw/47wc4qKXPrXRiZVo7kcSVNpDeYiXEJNuI+pOQabGjnj0RHBn5B7WsPy8NbP7
         eFIG6AK2esUVuaGX0XXdrLHGyfB0yz9yZOcQBRntfuEdDDAonod3QBbX5xYxub7dyW91
         cHwRfXxRMRj8qckllgg1rLeTl81EE+uWTUqxPhwucVqh4dp9Yjy0tutyy6AtlTxcNcQ6
         J0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUWCIgP21QbTu8MYqM7ugw2iFSZw2QStkmmp8irXZR1t6KNMSGStiNpCrRijgLd1s0aSgJZwF1aX6hau0Qj2Yl733V6bXIuT5GyDeg4
X-Gm-Message-State: AOJu0YyV3KsiEr+g6XTQ6RNpvlQyYLjvpDfnZ8aKsHudMv2fzFu1HHVG
	qkM5PRn1guh8WPHGrPSd+ak7u4ezKf/qJlCF3m53a9+W6b71lzcq7FWu5WdOvnSR6YmKlNMRY8K
	BML/H1h1XhOBaG0snz5VSW5M0Yjk=
X-Google-Smtp-Source: AGHT+IHEZRTUG4sNCTpSU/IPF3LmOu3fZrxkgYwxhqWp+0l0eaD2NyMD8gSZelOyKhuBoQbGxkVhsLIQ5IjKl8zEn+s=
X-Received: by 2002:ac2:43bc:0:b0:51d:8842:f0b8 with SMTP id
 2adb3069b0e04-5217c373de3mr4572333e87.13.1715257038121; Thu, 09 May 2024
 05:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-4-ioworker0@gmail.com>
 <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com> <CAK1f24=gc7VojzSDyNck-03L03UWR4AFxji8Rw+xMKBg1_M7fw@mail.gmail.com>
 <CAK1f24=HYM8zAw88apModHZdaLu849PH=JKPrZ3nxGqQWWzoyQ@mail.gmail.com>
 <8c1d6e06-d84b-4be7-81c8-76e2d8fb9883@linux.alibaba.com> <CAK1f24=+-jtjUpyNEXQyhgtGeqKEXr1tRN89Nzg3WQONAZEMMw@mail.gmail.com>
 <c49e2663-a7a6-410d-b694-59cd3fb28c78@linux.alibaba.com>
In-Reply-To: <c49e2663-a7a6-410d-b694-59cd3fb28c78@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 9 May 2024 20:17:05 +0800
Message-ID: <CAK1f24=vNputsQDFuceaYLenQXYTLJDPzsoD9bhNC1ey=b-+Dw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:36=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/7 19:37, Lance Yang wrote:
> > On Tue, May 7, 2024 at 5:33=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 2024/5/7 16:26, Lance Yang wrote:
> >>> On Tue, May 7, 2024 at 2:32=E2=80=AFPM Lance Yang <ioworker0@gmail.co=
m> wrote:
> >>>>
> >>>> Hey Baolin,
> >>>>
> >>>> Thanks a lot for taking time to review!
> >>>>
> >>>> On Tue, May 7, 2024 at 12:01=E2=80=AFPM Baolin Wang
> >>>> <baolin.wang@linux.alibaba.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2024/5/1 12:27, Lance Yang wrote:
> >>>>>> When the user no longer requires the pages, they would use
> >>>>>> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, t=
hey
> >>>>>> typically would not re-write to that memory again.
> >>>>>>
> >>>>>> During memory reclaim, if we detect that the large folio and its P=
MD are
> >>>>>> both still marked as clean and there are no unexpected references
> >>>>>> (such as GUP), so we can just discard the memory lazily, improving=
 the
> >>>>>> efficiency of memory reclamation in this case.  On an Intel i5 CPU=
, reclaiming 1GiB of lazyfree THPs using
> >>>>>> mem_cgroup_force_empty() results in the following runtimes in seco=
nds
> >>>>>> (shorter is better):
> >>>>>>
> >>>>>> --------------------------------------------
> >>>>>> |     Old       |      New       |  Change  |
> >>>>>> --------------------------------------------
> >>>>>> |   0.683426    |    0.049197    |  -92.80% |
> >>>>>> --------------------------------------------
> >>>>>>
> >>>>>> Suggested-by: Zi Yan <ziy@nvidia.com>
> >>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>>>> ---
> >>>>>>     include/linux/huge_mm.h |  9 +++++
> >>>>>>     mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++=
++++++++
> >>>>>>     mm/rmap.c               |  3 ++
> >>>>>>     3 files changed, 85 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>>> index 38c4b5537715..017cee864080 100644
> >>>>>> --- a/include/linux/huge_mm.h
> >>>>>> +++ b/include/linux/huge_mm.h
> >>>>>> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(voi=
d)
> >>>>>>
> >>>>>>     void split_huge_pmd_locked(struct vm_area_struct *vma, unsigne=
d long address,
> >>>>>>                            pmd_t *pmd, bool freeze, struct folio *=
folio);
> >>>>>> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned l=
ong addr,
> >>>>>> +                        pmd_t *pmdp, struct folio *folio);
> >>>>>>
> >>>>>>     static inline void align_huge_pmd_range(struct vm_area_struct =
*vma,
> >>>>>>                                         unsigned long *start,
> >>>>>> @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struc=
t vm_area_struct *vma,
> >>>>>>                                         unsigned long *start,
> >>>>>>                                         unsigned long *end) {}
> >>>>>>
> >>>>>> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *v=
ma,
> >>>>>> +                                      unsigned long addr, pmd_t *=
pmdp,
> >>>>>> +                                      struct folio *folio)
> >>>>>> +{
> >>>>>> +     return false;
> >>>>>> +}
> >>>>>> +
> >>>>>>     #define split_huge_pud(__vma, __pmd, __address)     \
> >>>>>>         do { } while (0)
> >>>>>>
> >>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>> index 145505a1dd05..90fdef847a88 100644
> >>>>>> --- a/mm/huge_memory.c
> >>>>>> +++ b/mm/huge_memory.c
> >>>>>> @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio=
)
> >>>>>>         try_to_unmap_flush();
> >>>>>>     }
> >>>>>>
> >>>>>> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma=
,
> >>>>>> +                                    unsigned long addr, pmd_t *pm=
dp,
> >>>>>> +                                    struct folio *folio)
> >>>>>> +{
> >>>>>> +     struct mm_struct *mm =3D vma->vm_mm;
> >>>>>> +     int ref_count, map_count;
> >>>>>> +     pmd_t orig_pmd =3D *pmdp;
> >>>>>> +     struct mmu_gather tlb;
> >>>>>> +     struct page *page;
> >>>>>> +
> >>>>>> +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> >>>>>> +             return false;
> >>>>>> +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_=
pmd)))
> >>>>>> +             return false;
> >>>>>> +
> >>>>>> +     page =3D pmd_page(orig_pmd);
> >>>>>> +     if (unlikely(page_folio(page) !=3D folio))
> >>>>>> +             return false;
> >>>>>> +
> >>>>>> +     tlb_gather_mmu(&tlb, mm);
> >>>>>> +     orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> >>>>>> +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * Syncing against concurrent GUP-fast:
> >>>>>> +      * - clear PMD; barrier; read refcount
> >>>>>> +      * - inc refcount; barrier; read PMD
> >>>>>> +      */
> >>>>>> +     smp_mb();
> >>>>>> +
> >>>>>> +     ref_count =3D folio_ref_count(folio);
> >>>>>> +     map_count =3D folio_mapcount(folio);
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * Order reads for folio refcount and dirty flag
> >>>>>> +      * (see comments in __remove_mapping()).
> >>>>>> +      */
> >>>>>> +     smp_rmb();
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * If the PMD or folio is redirtied at this point, or if the=
re are
> >>>>>> +      * unexpected references, we will give up to discard this fo=
lio
> >>>>>> +      * and remap it.
> >>>>>> +      *
> >>>>>> +      * The only folio refs must be one from isolation plus the r=
map(s).
> >>>>>> +      */
> >>>>>> +     if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) =
||
> >>>>>> +         pmd_dirty(orig_pmd)) {
> >>>>>> +             set_pmd_at(mm, addr, pmdp, orig_pmd);
> >>>>>> +             return false;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     folio_remove_rmap_pmd(folio, page, vma);
> >>>>>> +     zap_deposited_table(mm, pmdp);
> >>>>>> +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> >>>>>> +     folio_put(folio);
> >>>>>
> >>>>> IIUC, you missed handling mlock vma, see mlock_drain_local() in
> >>>>> try_to_unmap_one().
> >>>>
> >>>> Good spot!
> >>>>
> >>>> I suddenly realized that I overlooked another thing: If we detect th=
at a
> >>>> PMD-mapped THP is within the range of the VM_LOCKED VMA, we
> >>>> should check whether the TTU_IGNORE_MLOCK flag is set in
> >>>> try_to_unmap_one(). If the flag is set, we will remove the PMD mappi=
ng
> >>>> from the folio. Otherwise, the folio should be mlocked, which avoids
> >>>> splitting the folio and then mlocking each page again.
> >>>
> >>> My previous response above is flawed - sorry :(
> >>>
> >>> If we detect that a PMD-mapped THP is within the range of the
> >>> VM_LOCKED VMA.
> >>>
> >>> 1) If the TTU_IGNORE_MLOCK flag is set, we will try to remove the
> >>> PMD mapping from the folio, as this series has done.
> >>
> >> Right.
> >>
> >>> 2) If the flag is not set, the large folio should be mlocked to preve=
nt it
> >>> from being picked during memory reclaim? Currently, we just leave it
> >>
> >> Yes. From commit 1acbc3f93614 ("mm: handle large folio when large foli=
o
> >> in VM_LOCKED VMA range"), large folios of the mlocked VMA will be
> >> handled during page reclaim phase.
> >>
> >>> as is and do not to mlock it, IIUC.
> >>
> >> Original code already handle the mlock case after the PMD-mapped THP i=
s
> >> split in try_to_unmap_one():
> >
> > Yep. But this series doesn't do the TTU_SPLIT_HUGE_PMD immediately.
> >
> >>                   /*
> >>                    * If the folio is in an mlock()d vma, we must not s=
wap
> >> it out.
> >>                    */
> >>                   if (!(flags & TTU_IGNORE_MLOCK) &&
> >>                       (vma->vm_flags & VM_LOCKED)) {
> >>                           /* Restore the mlock which got missed */
> >
> > IIUC, we could detect a PMD-mapped THP here. So, I'm not sure if we
> > need to mlock it to prevent it from being picked again during memory
> > reclaim. The change is as follows:
>
> For the page reclaim path, folio_check_references() should be able to
> help restore the mlock of the PMD-mapped THP. However, for other paths

I understood, thanks for clarifying!

> that call try_to_unmap(), I believe it is still necessary to check
> whether the mlock of the PMD-mapped THP was missed.

Yeah, agreed!

The TTU_SPLIT_HUGE_PMD will no longer perform immediately, so we
might encounter a PMD-mapped THP missing the mlock in the VM_LOCKED
range during the pagewalk. It's likely necessary to mlock this THP to preve=
nt
it from being picked up during page reclaim.

Given this, I'll include the change below in the next version.

>
> Below code looks reasonable to me from a quick glance.

Thanks again for the review!
Lance

>
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index ed7f82036986..2a9d037ab23c 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1673,7 +1673,8 @@ static bool try_to_unmap_one(struct folio
> > *folio, struct vm_area_struct *vma,
> >                  if (!(flags & TTU_IGNORE_MLOCK) &&
> >                      (vma->vm_flags & VM_LOCKED)) {
> >                          /* Restore the mlock which got missed */
> > -                       if (!folio_test_large(folio))
> > +                       if (!folio_test_large(folio) ||
> > +                           (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD))=
)
> >                                  mlock_vma_folio(folio, vma);
> >                          goto walk_done_err;
> >                  }
> >
>

