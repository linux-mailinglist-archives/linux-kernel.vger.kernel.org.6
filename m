Return-Path: <linux-kernel+bounces-170754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A28BDB7F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A67B1F217EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D276F066;
	Tue,  7 May 2024 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx0IwoV4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357452EB08
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063539; cv=none; b=WzWOnU1fmE2Kz6wZMpO2K9efCaNXf0z6wrGsjmjHrTTIvwV0mpa8WKXq79y+Nhu4Eaewp7zy3dWFbqhRBSyRa0qOuyhHlLig+E2wIj/IsMzPpcBN5hfH/KTHhaw/W+DmNomaNg/etTQtcMH9XtNFIwHMOZ+VjMcioO249FW654s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063539; c=relaxed/simple;
	bh=yCaSLM86sk5PI+6/3fJn/j8Pt3SFmVBWXxQZfvQ8wCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgBCQfaC7/0PIxe5zvl8sPaMZNSCP2bWbI3CVnhsD46iOz7Fm7PjEXqZ9NE+8pCkTAE9dsg2hEnFtsnntBhiaEK+z4U2I/dmKESk3hBm9CukQtuDuvkyVluycoYHF5XmpiriZ0LmwrQBYd5xzSP5eaojno2ck3SigPnz+K1ijYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx0IwoV4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59b097b202so466177166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715063535; x=1715668335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DACqjnDAG0H4TrSShlBsGd57EdUYG6Ww5S2vGo61t14=;
        b=kx0IwoV4ZyvOvf0f1rfV0T2fT0pGn/qmM3If3vaC57fxA7Zr8lEj/kRS7h9C/nQvRz
         LuA42aoqAWfCk2rWz6aQ7kpZcJca8M76JOUi24yLz2r9nj4AcG6GmIpB9XlWftRCfliY
         f2sQKRCdEZX7z+fhICs4Zxrmgjs/vOW2TQQciHBQjhqmIjEzjVLb0Jr23ShCEF2z7OmB
         rY17MwtSoMVPA/nfO+KBkYcMplZH9oXEHThcLDdkTgxmiedOb6jSZwdA66uuYbyxlM12
         n8BqLbaBS84MpZC4iWBqBoYyBg9w+en+Lh7IhIdhk7gT5erAlB4ohrF+BEMH35i12jqJ
         bzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063535; x=1715668335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DACqjnDAG0H4TrSShlBsGd57EdUYG6Ww5S2vGo61t14=;
        b=PldeAUTXt+nzO3OrapjZ0HbtPNGZ6rVopUndXhI+Zjp4jZFExxHH5wb3IaoQLPAfD7
         qYVCEW0WBUmsZbQ4VxVGYupimUnG2EMVODKgX2K7ImHOMULXf9lCFLcaw6yFN24OOMbv
         3rqEyFl12nauJqpmEFx2XojxZxLSZXcphSDE0n21z71t4Cwrtbfg3a+5ARVb8ECd8NJY
         FDOxENZ05F6VS/Xb+oKaKxqB8f7RRY1YZnZc8ZzfqIyV6xQOfl/m6s+q98DD4YzqOIZD
         IqRoOzKZHGRict5u7tWtJ+616rU1xXK5z/3O/VwLzWFBnMKZ46EF9jpr1dxDjk+HBKM/
         QvlA==
X-Forwarded-Encrypted: i=1; AJvYcCVMdEZeoJdkOFEPUiIcw8UmmrhgLSzBYo3BAEtSVnxo1shYLubmL0RXp0xAtxCNkJDSktjV6bVqnwEg9J2HBp8mq0878b5BmiZxTlT/
X-Gm-Message-State: AOJu0YxYRcSMsBtevAuZ6BkqQdCht08T40v7/fhOkme6FVn33nNrAksF
	U4Yodb63ovWuK/ZnX0jMwBUFOMgV0oTQlPA90UgZRmOrh7SuVBu3AeJfSrsrH3ePnoCs/uBzcwU
	Ks1+4ab8uSsP7Fdgcajl5M0iSXY0=
X-Google-Smtp-Source: AGHT+IFxAwgX9ujafnqE6uur+NrXr1K7AHYM1IkHzuHZM6Y05H84S5oN5lk/83BVQUJbnhxBUJ/julxzNQhkkxzq2Qw=
X-Received: by 2002:a05:6402:354d:b0:572:6ee9:5a2d with SMTP id
 f13-20020a056402354d00b005726ee95a2dmr8396819edd.12.1715063535205; Mon, 06
 May 2024 23:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-4-ioworker0@gmail.com>
 <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com>
In-Reply-To: <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 14:32:03 +0800
Message-ID: <CAK1f24=gc7VojzSDyNck-03L03UWR4AFxji8Rw+xMKBg1_M7fw@mail.gmail.com>
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

Hey Baolin,

Thanks a lot for taking time to review!

On Tue, May 7, 2024 at 12:01=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/1 12:27, Lance Yang wrote:
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
> >   include/linux/huge_mm.h |  9 +++++
> >   mm/huge_memory.c        | 73 ++++++++++++++++++++++++++++++++++++++++=
+
> >   mm/rmap.c               |  3 ++
> >   3 files changed, 85 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 38c4b5537715..017cee864080 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
> >
> >   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long =
address,
> >                          pmd_t *pmd, bool freeze, struct folio *folio);
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio);
> >
> >   static inline void align_huge_pmd_range(struct vm_area_struct *vma,
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
> >   #define split_huge_pud(__vma, __pmd, __address)     \
> >       do { } while (0)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 145505a1dd05..90fdef847a88 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
> >       try_to_unmap_flush();
> >   }
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
>
> IIUC, you missed handling mlock vma, see mlock_drain_local() in
> try_to_unmap_one().

Good spot!

I suddenly realized that I overlooked another thing: If we detect that a
PMD-mapped THP is within the range of the VM_LOCKED VMA, we
should check whether the TTU_IGNORE_MLOCK flag is set in
try_to_unmap_one(). If the flag is set, we will remove the PMD mapping
from the folio. Otherwise, the folio should be mlocked, which avoids
splitting the folio and then mlocking each page again.

What do you think?

>
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
>
> Why add a new function, which is only used by unmap_huge_pmd_locked()?
> Seems can be folded in unmap_huge_pmd_locked(), but not a strong
> preference:)

Thanks for the suggestion!

Personally, I prefer adding a new function, rather than folding
__discard_trans_pmd_locked() into unmap_huge_pmd_locked().

While unmap_huge_pmd_locked() currently only deals with lazyfree THP,
It could be expanded to support other types of large folios that are
PMD-mapped in the future if needed.

Thanks a lot again for the review!
Lance

>
> > +
> > +     return false;
> > +}
> > +
> >   static void remap_page(struct folio *folio, unsigned long nr)
> >   {
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
> >                       /*
> >                        * We temporarily have to drop the PTL and start =
once
> >                        * again from that now-PTE-mapped page table.

