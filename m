Return-Path: <linux-kernel+bounces-171204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587768BE113
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DE1B22E76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4315252E;
	Tue,  7 May 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0vi9QH9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D36F525
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081871; cv=none; b=LzWii8Pik5VMaWtL0UwjIc/oMYEqaWj9uVor7AU4/0fMvuaDOr2tb4XqS7CfV07xX64ri62ao/bVhVjk6OPTviCMEhl/lqEclvXJhI6qFoLyEiaKr5HyaUMnYN1COBPNA14B6UHhTYN68juI2JSMCpgawnsHU6Hg9obKw3ZEfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081871; c=relaxed/simple;
	bh=o1+f8qhtjZbScy9I6oduapzfpxg7oa8w7+6dLgQniRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxcWtXYp+e77nq+J1c+aSkhIhGXO9ezOzIWlsAQtc2DzAjd+0rubu1d7ahP1nlELjijhIIzR1g67XyCfhAhCAASxUdZf5BorJZEw3hNZ5qRirzw+Y+pWXJT6AjJCQRHWmG7iByw11ePQoX2b797gDOR88jNH/iYsHSN5R3eBhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0vi9QH9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572adaa172cso5189449a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715081868; x=1715686668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVowKvBNRmaLSwmTfxUOvNc3tkHIphdsDpRhYMQ0c/o=;
        b=E0vi9QH9s7KR+fUhoP89eFq7WbbusKZa2Xzv3wuHJuBj8KlIft9p+rGXWVS63B8miB
         t3ye04bCuxh9E/0ANgIceoapt4gtH1rDIVWDiHJGWJpwnnkfylGvxojpXVN9Z66+Suug
         R2MYx//kjf3sSyvOnqhg1OV2zMuuJ6OZSpXmE87jDTL8iiYYVcOpmwzXzxVL99c9z5Uh
         msgRRy+cb7VPb8AvgKGvbc9pgOU3SxGtp6oLYesV4A9nzLIzLxIlBp/CxUwrU3kMnrXq
         4ft2hLd9dlMSeZas+IjTpOs3s2/bzN4/zJdoY3GVF7J0aqPQq3tD6ytqatUDcBJnOjNV
         YCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081868; x=1715686668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVowKvBNRmaLSwmTfxUOvNc3tkHIphdsDpRhYMQ0c/o=;
        b=FVNRmG+g17sHkHZwBM7NxsoYau81nkUXntIu0P6GAAk0H6BSso7UuVJALRT8vCrvuO
         5TImc+0ZNAVbyYrYTj79H7vEraltGEz3HqovxsitTkkH4RLxUZql62bRU/N28EMMy/pp
         MDH0nc379odj6hTWs0ufTGWCmQAgKN5Eo3f0I/rboolcOxZKrsLmOHdYoMz+ifSvgtl2
         LBXVI7e+IhAkKIocR6jp1vA9icrrdaMXRdSsM1UsuaX/JgB7PX5SZ+KyIWnVeBFMGWnN
         wQosgcsUtBrD6sZml3X2XMo48QNUZPyd1Ej/4ZzJZDrS/NTXt5xH4aMp7nsJMEf5rjyU
         T9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fbUqYLoUjeu/10JDuSoL++CCWDLQa3bjxHBZ76J63i94FxtnEHlARt8OzfHDJhg6ggsJ/XqcOHRW96/+hdjFUgbf9Yluz3xKOxNy
X-Gm-Message-State: AOJu0YzAgbNFqeuO8jYEHs7KaanQt3Sg9SPtr6tKxKsCZHUkcR8F1FCN
	t2Rde4285sLN+R2Hxn46RZ4fK4ZUzmTXqKbKn+XTKDe1jzEPCZO4t2xgDeltYCOXlRODBAraLGl
	LXygymsnWl9gTqLmbCn41NkN9S/Y=
X-Google-Smtp-Source: AGHT+IHDHHzQkWZ4IoIvLERx0xV1wwF+ok/vquwUdqvg4K7UJxICkkD09wYw+ItGB31QHzyhC+IyTP0ntpnQZ8a0RRo=
X-Received: by 2002:a50:9e82:0:b0:572:1fb7:2a77 with SMTP id
 a2-20020a509e82000000b005721fb72a77mr2022347edf.6.1715081868127; Tue, 07 May
 2024 04:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-4-ioworker0@gmail.com>
 <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com> <CAK1f24=gc7VojzSDyNck-03L03UWR4AFxji8Rw+xMKBg1_M7fw@mail.gmail.com>
 <CAK1f24=HYM8zAw88apModHZdaLu849PH=JKPrZ3nxGqQWWzoyQ@mail.gmail.com> <8c1d6e06-d84b-4be7-81c8-76e2d8fb9883@linux.alibaba.com>
In-Reply-To: <8c1d6e06-d84b-4be7-81c8-76e2d8fb9883@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 19:37:36 +0800
Message-ID: <CAK1f24=+-jtjUpyNEXQyhgtGeqKEXr1tRN89Nzg3WQONAZEMMw@mail.gmail.com>
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

On Tue, May 7, 2024 at 5:33=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/7 16:26, Lance Yang wrote:
> > On Tue, May 7, 2024 at 2:32=E2=80=AFPM Lance Yang <ioworker0@gmail.com>=
 wrote:
> >>
> >> Hey Baolin,
> >>
> >> Thanks a lot for taking time to review!
> >>
> >> On Tue, May 7, 2024 at 12:01=E2=80=AFPM Baolin Wang
> >> <baolin.wang@linux.alibaba.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2024/5/1 12:27, Lance Yang wrote:
> >>>> When the user no longer requires the pages, they would use
> >>>> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, the=
y
> >>>> typically would not re-write to that memory again.
> >>>>
> >>>> During memory reclaim, if we detect that the large folio and its PMD=
 are
> >>>> both still marked as clean and there are no unexpected references
> >>>> (such as GUP), so we can just discard the memory lazily, improving t=
he
> >>>> efficiency of memory reclamation in this case.  On an Intel i5 CPU, =
reclaiming 1GiB of lazyfree THPs using
> >>>> mem_cgroup_force_empty() results in the following runtimes in second=
s
> >>>> (shorter is better):
> >>>>
> >>>> --------------------------------------------
> >>>> |     Old       |      New       |  Change  |
> >>>> --------------------------------------------
> >>>> |   0.683426    |    0.049197    |  -92.80% |
> >>>> --------------------------------------------
> >>>>
> >>>> Suggested-by: Zi Yan <ziy@nvidia.com>
> >>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>> ---
> >>>>    include/linux/huge_mm.h |  9 +++++
> >>>>    mm/huge_memory.c        | 73 ++++++++++++++++++++++++++++++++++++=
+++++
> >>>>    mm/rmap.c               |  3 ++
> >>>>    3 files changed, 85 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index 38c4b5537715..017cee864080 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
> >>>>
> >>>>    void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned l=
ong address,
> >>>>                           pmd_t *pmd, bool freeze, struct folio *fol=
io);
> >>>> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned lon=
g addr,
> >>>> +                        pmd_t *pmdp, struct folio *folio);
> >>>>
> >>>>    static inline void align_huge_pmd_range(struct vm_area_struct *vm=
a,
> >>>>                                        unsigned long *start,
> >>>> @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct =
vm_area_struct *vma,
> >>>>                                        unsigned long *start,
> >>>>                                        unsigned long *end) {}
> >>>>
> >>>> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma=
,
> >>>> +                                      unsigned long addr, pmd_t *pm=
dp,
> >>>> +                                      struct folio *folio)
> >>>> +{
> >>>> +     return false;
> >>>> +}
> >>>> +
> >>>>    #define split_huge_pud(__vma, __pmd, __address)     \
> >>>>        do { } while (0)
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 145505a1dd05..90fdef847a88 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
> >>>>        try_to_unmap_flush();
> >>>>    }
> >>>>
> >>>> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> >>>> +                                    unsigned long addr, pmd_t *pmdp=
,
> >>>> +                                    struct folio *folio)
> >>>> +{
> >>>> +     struct mm_struct *mm =3D vma->vm_mm;
> >>>> +     int ref_count, map_count;
> >>>> +     pmd_t orig_pmd =3D *pmdp;
> >>>> +     struct mmu_gather tlb;
> >>>> +     struct page *page;
> >>>> +
> >>>> +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> >>>> +             return false;
> >>>> +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pm=
d)))
> >>>> +             return false;
> >>>> +
> >>>> +     page =3D pmd_page(orig_pmd);
> >>>> +     if (unlikely(page_folio(page) !=3D folio))
> >>>> +             return false;
> >>>> +
> >>>> +     tlb_gather_mmu(&tlb, mm);
> >>>> +     orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> >>>> +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> >>>> +
> >>>> +     /*
> >>>> +      * Syncing against concurrent GUP-fast:
> >>>> +      * - clear PMD; barrier; read refcount
> >>>> +      * - inc refcount; barrier; read PMD
> >>>> +      */
> >>>> +     smp_mb();
> >>>> +
> >>>> +     ref_count =3D folio_ref_count(folio);
> >>>> +     map_count =3D folio_mapcount(folio);
> >>>> +
> >>>> +     /*
> >>>> +      * Order reads for folio refcount and dirty flag
> >>>> +      * (see comments in __remove_mapping()).
> >>>> +      */
> >>>> +     smp_rmb();
> >>>> +
> >>>> +     /*
> >>>> +      * If the PMD or folio is redirtied at this point, or if there=
 are
> >>>> +      * unexpected references, we will give up to discard this foli=
o
> >>>> +      * and remap it.
> >>>> +      *
> >>>> +      * The only folio refs must be one from isolation plus the rma=
p(s).
> >>>> +      */
> >>>> +     if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> >>>> +         pmd_dirty(orig_pmd)) {
> >>>> +             set_pmd_at(mm, addr, pmdp, orig_pmd);
> >>>> +             return false;
> >>>> +     }
> >>>> +
> >>>> +     folio_remove_rmap_pmd(folio, page, vma);
> >>>> +     zap_deposited_table(mm, pmdp);
> >>>> +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> >>>> +     folio_put(folio);
> >>>
> >>> IIUC, you missed handling mlock vma, see mlock_drain_local() in
> >>> try_to_unmap_one().
> >>
> >> Good spot!
> >>
> >> I suddenly realized that I overlooked another thing: If we detect that=
 a
> >> PMD-mapped THP is within the range of the VM_LOCKED VMA, we
> >> should check whether the TTU_IGNORE_MLOCK flag is set in
> >> try_to_unmap_one(). If the flag is set, we will remove the PMD mapping
> >> from the folio. Otherwise, the folio should be mlocked, which avoids
> >> splitting the folio and then mlocking each page again.
> >
> > My previous response above is flawed - sorry :(
> >
> > If we detect that a PMD-mapped THP is within the range of the
> > VM_LOCKED VMA.
> >
> > 1) If the TTU_IGNORE_MLOCK flag is set, we will try to remove the
> > PMD mapping from the folio, as this series has done.
>
> Right.
>
> > 2) If the flag is not set, the large folio should be mlocked to prevent=
 it
> > from being picked during memory reclaim? Currently, we just leave it
>
> Yes. From commit 1acbc3f93614 ("mm: handle large folio when large folio
> in VM_LOCKED VMA range"), large folios of the mlocked VMA will be
> handled during page reclaim phase.
>
> > as is and do not to mlock it, IIUC.
>
> Original code already handle the mlock case after the PMD-mapped THP is
> split in try_to_unmap_one():

Yep. But this series doesn't do the TTU_SPLIT_HUGE_PMD immediately.

>                  /*
>                   * If the folio is in an mlock()d vma, we must not swap
> it out.
>                   */
>                  if (!(flags & TTU_IGNORE_MLOCK) &&
>                      (vma->vm_flags & VM_LOCKED)) {
>                          /* Restore the mlock which got missed */

IIUC, we could detect a PMD-mapped THP here. So, I'm not sure if we
need to mlock it to prevent it from being picked again during memory
reclaim. The change is as follows:

diff --git a/mm/rmap.c b/mm/rmap.c
index ed7f82036986..2a9d037ab23c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1673,7 +1673,8 @@ static bool try_to_unmap_one(struct folio
*folio, struct vm_area_struct *vma,
                if (!(flags & TTU_IGNORE_MLOCK) &&
                    (vma->vm_flags & VM_LOCKED)) {
                        /* Restore the mlock which got missed */
-                       if (!folio_test_large(folio))
+                       if (!folio_test_large(folio) ||
+                           (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
                                mlock_vma_folio(folio, vma);
                        goto walk_done_err;
                }

Thanks,
Lance


>                          if (!folio_test_large(folio))
>                                  mlock_vma_folio(folio, vma);
>                          page_vma_mapped_walk_done(&pvmw);
>                          ret =3D false;
>                          break;
>                  }

