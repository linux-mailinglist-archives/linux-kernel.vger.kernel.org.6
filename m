Return-Path: <linux-kernel+bounces-170871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86D8BDD22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628AE2834DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0A13C91F;
	Tue,  7 May 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLETlW+z"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A914087C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070409; cv=none; b=rgIABIA7qJYwAsDIXEFG6F/em0tnyskUanVGTKo7luupAeSm6FL9a/oNDBmg32SP9GlAZL9F6UE0pqVuXsAe3X8Mt0TeWOoF6RxX6tYgRXjwZ/RRR3nDA8anDFt+CANApdtVYGQt2Xzb19ntw91HltqJHz03dDpdRO/FoHC7G64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070409; c=relaxed/simple;
	bh=5X97teEDwdlg+wj/1dAb6da3SRv06Mi+ZtNsrnpQKJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULDVlmbSzL/PrO43PDnQoW04YdJgTKXAjJ0rLPSa8Z65gwgvYAV6f9ugp6/lT0mrHXrx/jNjY8iiy9A4hYR5AlWeuWItAl4SUIU92Q0KkaDG3OknpZ8NxS0G9a6J6EwjfvjfpqLbuAyDvXeeoDK/rUVOy7XrH0jMueAHOuj4FR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLETlW+z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59b58fe083so416703466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715070406; x=1715675206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ABsOP8SEu68sVFLiASZm/u0Hmy8w+mAVpH8nCUwY0A=;
        b=cLETlW+zmEL/lBs12DgakGlBsXqjQov1VvyuOhNQRTHzo/vAfkp0oo4Wm6dHNZQwIU
         X36vnNKE7BxjaoVHIfgFOhKxUVziaO25vV94Oor8IJf6Guka59mkSVhaBUYHQsRd/6Rc
         IyLreqdAQ84uyy079A5f1+rWU8JN/xJ9bA5NSZt+bjMiajbfiLqqK9TKoTcme8XJpPPR
         wR+6zlBwynxboI3Lq5f/6rsGEIyPpSwUp4L63d4mYt0O063RoJFFCaz8D5OdJu4lMFXe
         cISEefW8sldbOdpOxR20CyumaLJwqw14t/qsuQFDYghqw9QU+KkELKxmHh6HqSLXOf0T
         PKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715070406; x=1715675206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ABsOP8SEu68sVFLiASZm/u0Hmy8w+mAVpH8nCUwY0A=;
        b=uNtOzwolg1cvV4tAZ9mBjR0DgEKHgEc2I9wpnUQW1Y6/oPAyRf/DO3SxJQ7Er4RL5/
         eLd1+9+0+Rum5Wwb95oRJYYu/Pli9nKNXn9Ci3kiCSTK5Q4bOKv0Sygkf5NvB4Un57WM
         oleS/qXvotBKNgsAeeDuvY1aWSk/rLhIUef+832OIWT6zNOtXJ7S+TrpDZ0QRcBfHL+b
         hAD9Gld2UNwuWHge9VxGnJD3JM4EAu5/On/Bs8gTUAiA6an7G6SGv4jB075OS92eq3uK
         L9OmBn496GHLBEeqFCn7VsJVevM6SpjxZhu2v+9qU0TWnBjAOO+HK0zk7/mDQW2U9pT/
         V9VA==
X-Forwarded-Encrypted: i=1; AJvYcCX+f4TRWewNjIUNYn+vy1Ts7DQ+32opReAAzJafFyuVLsJ4Tu0i5cWdSQ2Mar6RlWvRD+Yzd0Gk5drld0u0KGIH5Z95Jikaz8EhivMS
X-Gm-Message-State: AOJu0YzCRH/bQN/02me4kdYNIQeUSBnwnXi1l8AhSz3Z/Ijyuv6X4CxT
	i3myAvW1EWYNwmprPPYQmua03A6Tdp1ZMSzpkU3phbClPbPf1lGBB33MCcMuqtPP4wGxgxIjRNa
	bjKTVHo40SSzTFSPbcCTUfwWWMbo=
X-Google-Smtp-Source: AGHT+IF0jDUUvlcUjVjTQnZ6YPtFqBDAtPQ4FSE7s7+H1V9lbJUvo7JZ6dtpIaCxEfRyi6RpoG4WFbQ41B0qq/63bk8=
X-Received: by 2002:a50:8755:0:b0:572:a183:49a4 with SMTP id
 21-20020a508755000000b00572a18349a4mr8345591edv.28.1715070405633; Tue, 07 May
 2024 01:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-4-ioworker0@gmail.com>
 <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com> <CAK1f24=gc7VojzSDyNck-03L03UWR4AFxji8Rw+xMKBg1_M7fw@mail.gmail.com>
In-Reply-To: <CAK1f24=gc7VojzSDyNck-03L03UWR4AFxji8Rw+xMKBg1_M7fw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 16:26:34 +0800
Message-ID: <CAK1f24=HYM8zAw88apModHZdaLu849PH=JKPrZ3nxGqQWWzoyQ@mail.gmail.com>
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

On Tue, May 7, 2024 at 2:32=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> Hey Baolin,
>
> Thanks a lot for taking time to review!
>
> On Tue, May 7, 2024 at 12:01=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2024/5/1 12:27, Lance Yang wrote:
> > > When the user no longer requires the pages, they would use
> > > madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> > > typically would not re-write to that memory again.
> > >
> > > During memory reclaim, if we detect that the large folio and its PMD =
are
> > > both still marked as clean and there are no unexpected references
> > > (such as GUP), so we can just discard the memory lazily, improving th=
e
> > > efficiency of memory reclamation in this case.  On an Intel i5 CPU, r=
eclaiming 1GiB of lazyfree THPs using
> > > mem_cgroup_force_empty() results in the following runtimes in seconds
> > > (shorter is better):
> > >
> > > --------------------------------------------
> > > |     Old       |      New       |  Change  |
> > > --------------------------------------------
> > > |   0.683426    |    0.049197    |  -92.80% |
> > > --------------------------------------------
> > >
> > > Suggested-by: Zi Yan <ziy@nvidia.com>
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > ---
> > >   include/linux/huge_mm.h |  9 +++++
> > >   mm/huge_memory.c        | 73 ++++++++++++++++++++++++++++++++++++++=
+++
> > >   mm/rmap.c               |  3 ++
> > >   3 files changed, 85 insertions(+)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 38c4b5537715..017cee864080 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
> > >
> > >   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned lon=
g address,
> > >                          pmd_t *pmd, bool freeze, struct folio *folio=
);
> > > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 addr,
> > > +                        pmd_t *pmdp, struct folio *folio);
> > >
> > >   static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> > >                                       unsigned long *start,
> > > @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct v=
m_area_struct *vma,
> > >                                       unsigned long *start,
> > >                                       unsigned long *end) {}
> > >
> > > +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> > > +                                      unsigned long addr, pmd_t *pmd=
p,
> > > +                                      struct folio *folio)
> > > +{
> > > +     return false;
> > > +}
> > > +
> > >   #define split_huge_pud(__vma, __pmd, __address)     \
> > >       do { } while (0)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 145505a1dd05..90fdef847a88 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
> > >       try_to_unmap_flush();
> > >   }
> > >
> > > +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> > > +                                    unsigned long addr, pmd_t *pmdp,
> > > +                                    struct folio *folio)
> > > +{
> > > +     struct mm_struct *mm =3D vma->vm_mm;
> > > +     int ref_count, map_count;
> > > +     pmd_t orig_pmd =3D *pmdp;
> > > +     struct mmu_gather tlb;
> > > +     struct page *page;
> > > +
> > > +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> > > +             return false;
> > > +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd=
)))
> > > +             return false;
> > > +
> > > +     page =3D pmd_page(orig_pmd);
> > > +     if (unlikely(page_folio(page) !=3D folio))
> > > +             return false;
> > > +
> > > +     tlb_gather_mmu(&tlb, mm);
> > > +     orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> > > +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> > > +
> > > +     /*
> > > +      * Syncing against concurrent GUP-fast:
> > > +      * - clear PMD; barrier; read refcount
> > > +      * - inc refcount; barrier; read PMD
> > > +      */
> > > +     smp_mb();
> > > +
> > > +     ref_count =3D folio_ref_count(folio);
> > > +     map_count =3D folio_mapcount(folio);
> > > +
> > > +     /*
> > > +      * Order reads for folio refcount and dirty flag
> > > +      * (see comments in __remove_mapping()).
> > > +      */
> > > +     smp_rmb();
> > > +
> > > +     /*
> > > +      * If the PMD or folio is redirtied at this point, or if there =
are
> > > +      * unexpected references, we will give up to discard this folio
> > > +      * and remap it.
> > > +      *
> > > +      * The only folio refs must be one from isolation plus the rmap=
(s).
> > > +      */
> > > +     if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> > > +         pmd_dirty(orig_pmd)) {
> > > +             set_pmd_at(mm, addr, pmdp, orig_pmd);
> > > +             return false;
> > > +     }
> > > +
> > > +     folio_remove_rmap_pmd(folio, page, vma);
> > > +     zap_deposited_table(mm, pmdp);
> > > +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > > +     folio_put(folio);
> >
> > IIUC, you missed handling mlock vma, see mlock_drain_local() in
> > try_to_unmap_one().
>
> Good spot!
>
> I suddenly realized that I overlooked another thing: If we detect that a
> PMD-mapped THP is within the range of the VM_LOCKED VMA, we
> should check whether the TTU_IGNORE_MLOCK flag is set in
> try_to_unmap_one(). If the flag is set, we will remove the PMD mapping
> from the folio. Otherwise, the folio should be mlocked, which avoids
> splitting the folio and then mlocking each page again.

My previous response above is flawed - sorry :(

If we detect that a PMD-mapped THP is within the range of the
VM_LOCKED VMA.

1) If the TTU_IGNORE_MLOCK flag is set, we will try to remove the
PMD mapping from the folio, as this series has done.

2) If the flag is not set, the large folio should be mlocked to prevent it
from being picked during memory reclaim? Currently, we just leave it
as is and do not to mlock it, IIUC.

What do you think?

Thanks,
Lance

>
> What do you think?
>
> >
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 addr,
> > > +                        pmd_t *pmdp, struct folio *folio)
> > > +{
> > > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > > +     VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > > +     VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> > > +
> > > +     if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > > +             return __discard_trans_pmd_locked(vma, addr, pmdp, foli=
o);
> >
> > Why add a new function, which is only used by unmap_huge_pmd_locked()?
> > Seems can be folded in unmap_huge_pmd_locked(), but not a strong
> > preference:)
>
> Thanks for the suggestion!
>
> Personally, I prefer adding a new function, rather than folding
> __discard_trans_pmd_locked() into unmap_huge_pmd_locked().
>
> While unmap_huge_pmd_locked() currently only deals with lazyfree THP,
> It could be expanded to support other types of large folios that are
> PMD-mapped in the future if needed.
>
> Thanks a lot again for the review!
> Lance
>
> >
> > > +
> > > +     return false;
> > > +}
> > > +
> > >   static void remap_page(struct folio *folio, unsigned long nr)
> > >   {
> > >       int i =3D 0;
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 432601154583..1d3d30cb752c 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1675,6 +1675,9 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> > >               }
> > >
> > >               if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > > +                     if (unmap_huge_pmd_locked(vma, range.start, pvm=
w.pmd,
> > > +                                               folio))
> > > +                             goto walk_done;
> > >                       /*
> > >                        * We temporarily have to drop the PTL and star=
t once
> > >                        * again from that now-PTE-mapped page table.

