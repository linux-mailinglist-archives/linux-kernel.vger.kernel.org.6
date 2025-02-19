Return-Path: <linux-kernel+bounces-521964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFECA3C461
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FC63B4C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E31F3B83;
	Wed, 19 Feb 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOpton/l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074C1ADC74
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980997; cv=none; b=iC8nOX8lfAisO7q5jcxjBC/DHEGBauda51WCoJ0g38VjQSrfmJUQta9f6i3FB1bAF2gkbBDvA8q4Pz8yxLz+Om8oUiPtV9HBl/rmwKYRxJCKCbGMnqNAzfoLaYaNLkzMdA7lWhZAnaaCGFVwqG95cxsr+SiZQ9NuFnzbfJl+ZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980997; c=relaxed/simple;
	bh=C1FYVMlB69XAsUzC0FtLCrEC/VGofM6jlY5r+uqg6mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poWGfrdE4kfOzF9P09hW1W2T2xIV36iqdkTgsA3xrNF3CnSSgMLVfocJIXZRa5aY9VDuVhG2M6RGgkqzIkMskJLAB6jfIX4DSloZumVFQRBb85ay9l9yRRt8uAiCdLK+RPJ+1uUzqSKO4j7GOlWe8y61LSjmO1EbqajbaKvMN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOpton/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739980994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKFk2/ljiWc6fVTCMyYKPq5syAbeFPqi3+XwMwfuQyQ=;
	b=dOpton/lQBnsOtqe2OZuwAm31h0o8lNibvp6b0fDg6dFNzfjdEeyWNcu7PjlPlyzeoN1OS
	6DjkePwPUl1eS+Sv29lMvsJe4KhjLpTOV5PGRNSCNdor10lgfrrdThGeRxZvpaQUeENaLr
	LdA3cmDxG/mR0x4WqIWFssWWCFYjiUs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-dXPX4yeBPO2mrhVwYEv9Xg-1; Wed, 19 Feb 2025 11:03:13 -0500
X-MC-Unique: dXPX4yeBPO2mrhVwYEv9Xg-1
X-Mimecast-MFC-AGG-ID: dXPX4yeBPO2mrhVwYEv9Xg_1739980993
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e3a109984a5so7762185276.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739980993; x=1740585793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKFk2/ljiWc6fVTCMyYKPq5syAbeFPqi3+XwMwfuQyQ=;
        b=bSe6TZsMnw4SBRIioxTYOtieyRjX+GOUo981Dfo4G7wr6KjCykv5DyNYnMnUkGuktW
         w4XZ4NJq4lc8A3gME+9waIterlaCYu2dxvvC5N9mpTiscc8c7h7wWXMCXi6jUPRyxzDk
         l7iWRuBggdA43atIUMHfHugJy9Zy6+RnhBTEueO9fy6o68K5f5lEZuYVvDEtwwuGvxnR
         TX5Z16s/d5BUCFeBDVtJ8MaMyUQN9BX1KsQU8AKylO/HHYTqAaKsKtGTsUI4+sE9xaAN
         woswT9wrOrPMOZc1h7VVpjOpsO+qajJrJE7UY+KkvfHQ/KK6h6flZkOf5Al47wv2xisn
         2FCA==
X-Gm-Message-State: AOJu0YykbLaYZnDVz76Ys/3xtNqTRqr20ltC7uMumHx1JrSqe9v7a7+X
	92iVegQ4aT5YJa3BRR4A1BBs9/UwhldjqDIsZEFpjRzV+V2en0kVcEgAHawKkCBFpC/wvk9Feow
	UxQLfIoTpUhDdc8+ZogVngLk/NKSGfpbulKgxURcP69xJ1WZK24WjeVgT9ag+Eo3ZNubf0qX3yV
	/8UwIXlVX0iL39ptdAcHYhjwO9cTGym+nTWJ4c
X-Gm-Gg: ASbGncs3nTSCEJkU+0cXBlvw65Z60oliMvaw9vSiAw1V8rUgGcm1Rm6KSC/FMl4hGVO
	j7ZgIIzuC6MCaC1/an94ksJAW1zBAbE5Eca5zo0WtCyJ4zM/PjhaT2+hXiD+VIDyBZQE5V86HJQ
	E=
X-Received: by 2002:a05:6902:1544:b0:e39:6e4d:32fb with SMTP id 3f1490d57ef6-e5dc930fa51mr15415700276.45.1739980992704;
        Wed, 19 Feb 2025 08:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI7IQsVTMnMVLEJ2cJxBl9fAUC6OUXY62unlxjHD7pfGGI8q/oaPqqiFE0ielKIWRuxe1/wAMbICEfz1qGuXI=
X-Received: by 2002:a05:6902:1544:b0:e39:6e4d:32fb with SMTP id
 3f1490d57ef6-e5dc930fa51mr15415609276.45.1739980992083; Wed, 19 Feb 2025
 08:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-6-npache@redhat.com>
 <8524c7c7-024f-4f17-9b89-ef9aedfca672@arm.com>
In-Reply-To: <8524c7c7-024f-4f17-9b89-ef9aedfca672@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 19 Feb 2025 09:02:46 -0700
X-Gm-Features: AWEUYZkL6je729yXmSmtgH-gbFE3ksuWMe_jMa24RPmXy6JkqrgJgdItUGDZZtU
Message-ID: <CAA1CXcCf6=zFw5znf1KE-4tu9q1Am-76DZfQS2XRrUGUBy9QiQ@mail.gmail.com>
Subject: Re: [RFC v2 5/9] khugepaged: generalize __collapse_huge_page_* for
 mTHP support
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, usamaarif642@gmail.com, audra@redhat.com, 
	akpm@linux-foundation.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:39=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/02/2025 00:30, Nico Pache wrote:
> > generalize the order of the __collapse_huge_page_* functions
> > to support future mTHP collapse.
> >
> > mTHP collapse can suffer from incosistant behavior, and memory waste
> > "creep". disable swapin and shared support for mTHP collapse.
> >
> > No functional changes in this patch.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 48 ++++++++++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0cfcdc11cabd..3776055bd477 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -565,15 +565,17 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >                                       unsigned long address,
> >                                       pte_t *pte,
> >                                       struct collapse_control *cc,
> > -                                     struct list_head *compound_pageli=
st)
> > +                                     struct list_head *compound_pageli=
st,
> > +                                     u8 order)
>
> nit: I think we are mostly standardised on order being int. Is there any =
reason
> to make it u8 here?

The reasoning was I didn't want to consume a lot of memory for the
mthp_bitmap_stack.
originally the order and offset were u8's, but i had to convert the
offset to u16 to fit the max offset on 64k kernels.
so 64 * (8+16) =3D 192 bytes as opposed to 1024 bytes if they were ints.

Not sure if using these u8/16 is frowned upon. Lmk if I need to
convert these back to int or if they can stay!


>
> >  {
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       bool writable =3D false;
> > +     int scaled_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER =
- order);
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + (1 << order);
> >            _pte++, address +=3D PAGE_SIZE) {
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || (pte_present(pteval) &&
> > @@ -581,7 +583,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> >                           (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                          none_or_zero <=3D scaled_none)) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -609,8 +611,8 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >               /* See khugepaged_scan_pmd(). */
> >               if (folio_likely_mapped_shared(folio)) {
> >                       ++shared;
> > -                     if (cc->is_khugepaged &&
> > -                         shared > khugepaged_max_ptes_shared) {
> > +                     if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> > +                         shared > khugepaged_max_ptes_shared)) {
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
>
> Same comment about events; I think you will want to be careful to only co=
unt
> events for PMD-sized THP using count_vm_event() and introduce equivalent =
MTHP
> events to cover all sizes.

Makes sense, Ill work on adding the new counters for
THP_SCAN_EXCEED_(SWAP_PTE|NONE_PTE|SHARED_PTE). Thanks!

>
> >                               goto out;
> > @@ -711,14 +713,15 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >                                               struct vm_area_struct *vm=
a,
> >                                               unsigned long address,
> >                                               spinlock_t *ptl,
> > -                                             struct list_head *compoun=
d_pagelist)
> > +                                             struct list_head *compoun=
d_pagelist,
> > +                                             u8 order)
> >  {
> >       struct folio *src, *tmp;
> >       pte_t *_pte;
> >       pte_t pteval;
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > -          _pte++, address +=3D PAGE_SIZE) {
> > +     for (_pte =3D pte; _pte < pte + (1 << order);
> > +             _pte++, address +=3D PAGE_SIZE) {
>
> nit: you changed the indentation here.
>
> >               pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> >                       add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> > @@ -764,7 +767,8 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >                                            pmd_t *pmd,
> >                                            pmd_t orig_pmd,
> >                                            struct vm_area_struct *vma,
> > -                                          struct list_head *compound_p=
agelist)
> > +                                          struct list_head *compound_p=
agelist,
> > +                                          u8 order)
> >  {
> >       spinlock_t *pmd_ptl;
> >
> > @@ -781,7 +785,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >        * Release both raw and compound pages isolated
> >        * in __collapse_huge_page_isolate.
> >        */
> > -     release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> > +     release_pte_pages(pte, pte + (1 << order), compound_pagelist);
> >  }
> >
> >  /*
> > @@ -802,7 +806,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >  static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
> >               pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
> >               unsigned long address, spinlock_t *ptl,
> > -             struct list_head *compound_pagelist)
> > +             struct list_head *compound_pagelist, u8 order)
> >  {
> >       unsigned int i;
> >       int result =3D SCAN_SUCCEED;
> > @@ -810,7 +814,7 @@ static int __collapse_huge_page_copy(pte_t *pte, st=
ruct folio *folio,
> >       /*
> >        * Copying pages' contents is subject to memory poison at any ite=
ration.
> >        */
> > -     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +     for (i =3D 0; i < (1 << order); i++) {
> >               pte_t pteval =3D ptep_get(pte + i);
> >               struct page *page =3D folio_page(folio, i);
> >               unsigned long src_addr =3D address + i * PAGE_SIZE;
> > @@ -829,10 +833,10 @@ static int __collapse_huge_page_copy(pte_t *pte, =
struct folio *folio,
> >
> >       if (likely(result =3D=3D SCAN_SUCCEED))
> >               __collapse_huge_page_copy_succeeded(pte, vma, address, pt=
l,
> > -                                                 compound_pagelist);
> > +                                                 compound_pagelist, or=
der);
> >       else
> >               __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> > -                                              compound_pagelist);
> > +                                              compound_pagelist, order=
);
> >
> >       return result;
> >  }
> > @@ -1000,11 +1004,11 @@ static int check_pmd_still_valid(struct mm_stru=
ct *mm,
> >  static int __collapse_huge_page_swapin(struct mm_struct *mm,
> >                                      struct vm_area_struct *vma,
> >                                      unsigned long haddr, pmd_t *pmd,
> > -                                    int referenced)
> > +                                    int referenced, u8 order)
> >  {
> >       int swapped_in =3D 0;
> >       vm_fault_t ret =3D 0;
> > -     unsigned long address, end =3D haddr + (HPAGE_PMD_NR * PAGE_SIZE)=
;
> > +     unsigned long address, end =3D haddr + (PAGE_SIZE << order);
> >       int result;
> >       pte_t *pte =3D NULL;
> >       spinlock_t *ptl;
> > @@ -1035,6 +1039,11 @@ static int __collapse_huge_page_swapin(struct mm=
_struct *mm,
> >               if (!is_swap_pte(vmf.orig_pte))
> >                       continue;
> >
> > +             if (order !=3D HPAGE_PMD_ORDER) {
> > +                     result =3D SCAN_EXCEED_SWAP_PTE;
> > +                     goto out;
> > +             }
>
> A comment to explain the rationale for this divergent behaviour based on =
order
> would be helpful.
>
> > +
> >               vmf.pte =3D pte;
> >               vmf.ptl =3D ptl;
> >               ret =3D do_swap_page(&vmf);
> > @@ -1114,7 +1123,6 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       int result =3D SCAN_FAIL;
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> > -
>
> nit: no need for this whitespace change?

Thanks! Ill clean up the nits and add a comment to the swapin function
to describe skipping mTHP swapin.
>
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> >       /*
> > @@ -1149,7 +1157,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> >               result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                                                  referenced);
> > +                             referenced, HPAGE_PMD_ORDER);
> >               if (result !=3D SCAN_SUCCEED)
> >                       goto out_nolock;
> >       }
> > @@ -1196,7 +1204,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> >       if (pte) {
> >               result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > -                                                   &compound_pagelist)=
;
> > +                                     &compound_pagelist, HPAGE_PMD_ORD=
ER);
> >               spin_unlock(pte_ptl);
> >       } else {
> >               result =3D SCAN_PMD_NULL;
> > @@ -1226,7 +1234,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> >                                          vma, address, pte_ptl,
> > -                                        &compound_pagelist);
> > +                                        &compound_pagelist, HPAGE_PMD_=
ORDER);
> >       pte_unmap(pte);
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> >               goto out_up_write;
>


