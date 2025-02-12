Return-Path: <linux-kernel+bounces-511689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD1A32E56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE797A17D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40525E45C;
	Wed, 12 Feb 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqHBJqx3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228B25E44E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384234; cv=none; b=axpCbKNSspHmmXasMwfcUHsO7URJb+pRvC8yrsWlhkmw+yplR4kqKlyf8WKzCwTyMCt+XVsOZd8uDO7/6L6kqSmZ3H0PT4n89pRa55rHIP9RlUCUuCpuheJLPXi+g3bOB3FKOOlF8EkNAaSUUgBPpkQxOWPIFbNd7Usmc+IkvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384234; c=relaxed/simple;
	bh=BZAINun7TpconzyAj2+RapBVfff/XcO/6pVHFwswkrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/1NmNI1cZKAtkVg24cT/dV/hW0HpcMPygo8kKcz81uIzFCElBbRNPvFFenQdbtP0bkzOXMUVYA68sa5y+Qal5O33An121Cyabh9TtdZYuuwrmgwxwOWCYVXNwG/aRPrc/8KJST3Po8yU9I2UtjZMFEbTCiZXRqACeFh0usXpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqHBJqx3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739384231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxMveRKFz79cLdG4IH3t2o0E/2y0nocVQjmWDPhVhkA=;
	b=ZqHBJqx3VRolbWjRI2w5RP1FomQr5oxvxysP1b4/zkmq5ONNqsSu5BwXjLiwij3pLMzdcW
	g+Pmzay+X3EjVh0oMdTjgCnVCdLZ6wdq7ItoUctKYVNkvBZWG7BB73sWbypebX2ZxRaBPU
	IlXvCH9bOSDCzEVHLYampR7f23MxcLE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-XwiQdUAvO-eSBpiXJ5a1nw-1; Wed, 12 Feb 2025 13:17:10 -0500
X-MC-Unique: XwiQdUAvO-eSBpiXJ5a1nw-1
X-Mimecast-MFC-AGG-ID: XwiQdUAvO-eSBpiXJ5a1nw
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e5798866415so42107276.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739384229; x=1739989029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxMveRKFz79cLdG4IH3t2o0E/2y0nocVQjmWDPhVhkA=;
        b=NQqA+JAPgBZrafXRHb7rDm1VgHJ15pUD1sbcLfvhTHAZRASY6XAW1NZES7G0e1SQ8M
         +Mu1nwyzcci8vkPa26R3/d1xnqEmmFMiEDvtEo8oQwte58mFgtxNYveo9XCGAoHoYiXF
         QCkmUXgykxCvf9JoKScJx+ty2plzGj7w8Dhn+HUrzonfXOw62U25bPh8n1g6OJjGOtF1
         NTUbcrgl95edbkk+a96MBi8cnG5AKXh1nEawkdY0P60D0GW58+5VAhBtgQW8DhpgiV3D
         jZUb6uTRdOy2jTKxnnM8KLkXrjgaGdf/0LdY77RwKy8h9U7aPURsqLSFY0HAIH/FeyuZ
         9LTw==
X-Gm-Message-State: AOJu0Yykr3BCsa909r7W425I+G2e/3kzTcmyXcJ0lj4kC5O4h8N3PD/D
	C8ogLlyf/GNPaBiqfCcR7a+pV1BxWSYAJtsyGBUrgOnTYGCGkb3Td/ZaGcb2bGDICPOZa6BH8Dz
	JK6vGaLTRMOt6hbHws4ieYPGLxhHDLh0zzu09zKY9CIkDVLbpCWKRk4J+okdjmNdpf90mnClQF7
	rEGJUZRR6QcDIzlifi2FxOYRRgTHimr/P+DwlA
X-Gm-Gg: ASbGnctoRCheefDwChztK+9VTPzfCAw1yflJhq/1e0hfsNWLcp92fC/3mYLvIjPfLuY
	nmSxw65Y2S9fvM3lVGXOqzT64iD//f69BlfepbKD8U+DQulyJYLVHJKgx9OGEnxTHZIusd9/tX1
	E=
X-Received: by 2002:a05:6902:723:b0:e5d:92ad:8e75 with SMTP id 3f1490d57ef6-e5d9f0cc9bamr4474898276.10.1739384229323;
        Wed, 12 Feb 2025 10:17:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmRWNmGPvTL92tISaSvzmzQRtTZjsAvB2xwfv4LnOVPEt2eDN8nv36YnRCgcFOENrQ+VKt/6e+xrukc/dlMKU=
X-Received: by 2002:a05:6902:723:b0:e5d:92ad:8e75 with SMTP id
 3f1490d57ef6-e5d9f0cc9bamr4474848276.10.1739384228926; Wed, 12 Feb 2025
 10:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-8-npache@redhat.com>
 <9ade1f26-1642-48b3-b7e4-ba571892c7d6@gmail.com>
In-Reply-To: <9ade1f26-1642-48b3-b7e4-ba571892c7d6@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Feb 2025 11:16:43 -0700
X-Gm-Features: AWEUYZn2zZJEb98yoS5kTPZnam4dYVVrwTZCheqvi5KbV76ot14n5LicrQs5wd8
Message-ID: <CAA1CXcApRSubSNPt03HHCwciqLK=MOz2c37Cc1zD9c3GJ6CpUA@mail.gmail.com>
Subject: Re: [RFC v2 7/9] khugepaged: add mTHP support
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, 
	apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org, 
	baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu, 
	haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org, 
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com, 
	surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com, 
	zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com, 
	willy@infradead.org, kirill.shutemov@linux.intel.com, david@redhat.com, 
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 11/02/2025 00:30, Nico Pache wrote:
> > Introduce the ability for khugepaged to collapse to different mTHP size=
s.
> > While scanning a PMD range for potential collapse candidates, keep trac=
k
> > of pages in MIN_MTHP_ORDER chunks via a bitmap. Each bit represents a
> > utilized region of order MIN_MTHP_ORDER ptes. We remove the restriction
> > of max_ptes_none during the scan phase so we dont bailout early and mis=
s
> > potential mTHP candidates.
> >
> > After the scan is complete we will perform binary recursion on the
> > bitmap to determine which mTHP size would be most efficient to collapse
> > to. max_ptes_none will be scaled by the attempted collapse order to
> > determine how full a THP must be to be eligible.
> >
> > If a mTHP collapse is attempted, but contains swapped out, or shared
> > pages, we dont perform the collapse.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 122 ++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 83 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index c8048d9ec7fb..cd310989725b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1127,13 +1127,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >  {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > -     pte_t *pte;
> > +     pte_t *pte, mthp_pte;
> >       pgtable_t pgtable;
> >       struct folio *folio;
> >       spinlock_t *pmd_ptl, *pte_ptl;
> >       int result =3D SCAN_FAIL;
> >       struct vm_area_struct *vma;
> >       struct mmu_notifier_range range;
> > +     unsigned long _address =3D address + offset * PAGE_SIZE;
> >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> >
> >       /*
> > @@ -1148,12 +1149,13 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >               *mmap_locked =3D false;
> >       }
> >
> > -     result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > +     result =3D alloc_charge_folio(&folio, mm, cc, order);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_nolock;
> >
> >       mmap_read_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> > +     *mmap_locked =3D true;
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, o=
rder);
> >       if (result !=3D SCAN_SUCCEED) {
> >               mmap_read_unlock(mm);
> >               goto out_nolock;
> > @@ -1171,13 +1173,14 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >                * released when it fails. So we jump out_nolock directly=
 in
> >                * that case.  Continuing to collapse causes inconsistenc=
y.
> >                */
> > -             result =3D __collapse_huge_page_swapin(mm, vma, address, =
pmd,
> > -                             referenced, HPAGE_PMD_ORDER);
> > +             result =3D __collapse_huge_page_swapin(mm, vma, _address,=
 pmd,
> > +                             referenced, order);
> >               if (result !=3D SCAN_SUCCEED)
> >                       goto out_nolock;
> >       }
> >
> >       mmap_read_unlock(mm);
> > +     *mmap_locked =3D false;
> >       /*
> >        * Prevent all access to pagetables with the exception of
> >        * gup_fast later handled by the ptep_clear_flush and the VM
> > @@ -1187,7 +1190,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >        * mmap_lock.
> >        */
> >       mmap_write_lock(mm);
> > -     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, H=
PAGE_PMD_ORDER);
> > +     result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc, o=
rder);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> > @@ -1198,11 +1201,12 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >       vma_start_write(vma);
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > -     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > -                             address + HPAGE_PMD_SIZE);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address=
,
> > +                             _address + (PAGE_SIZE << order));
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> > +
> >       /*
> >        * This removes any huge TLB entry from the CPU so we won't allow
> >        * huge and small TLB entries for the same virtual address to
> > @@ -1216,10 +1220,10 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >       mmu_notifier_invalidate_range_end(&range);
> >       tlb_remove_table_sync_one();
> >
> > -     pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> > +     pte =3D pte_offset_map_lock(mm, &_pmd, _address, &pte_ptl);
> >       if (pte) {
> > -             result =3D __collapse_huge_page_isolate(vma, address, pte=
, cc,
> > -                                     &compound_pagelist, HPAGE_PMD_ORD=
ER);
> > +             result =3D __collapse_huge_page_isolate(vma, _address, pt=
e, cc,
> > +                                     &compound_pagelist, order);
> >               spin_unlock(pte_ptl);
> >       } else {
> >               result =3D SCAN_PMD_NULL;
> > @@ -1248,8 +1252,8 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       anon_vma_unlock_write(vma->anon_vma);
> >
> >       result =3D __collapse_huge_page_copy(pte, folio, pmd, _pmd,
> > -                                        vma, address, pte_ptl,
> > -                                        &compound_pagelist, HPAGE_PMD_=
ORDER);
> > +                                        vma, _address, pte_ptl,
> > +                                        &compound_pagelist, order);
> >       pte_unmap(pte);
> >       if (unlikely(result !=3D SCAN_SUCCEED))
> >               goto out_up_write;
> > @@ -1260,20 +1264,37 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >        * write.
> >        */
> >       __folio_mark_uptodate(folio);
> > -     pgtable =3D pmd_pgtable(_pmd);
> > -
> > -     _pmd =3D mk_huge_pmd(&folio->page, vma->vm_page_prot);
> > -     _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > -
> > -     spin_lock(pmd_ptl);
> > -     BUG_ON(!pmd_none(*pmd));
> > -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
> > -     folio_add_lru_vma(folio, vma);
> > -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > -     set_pmd_at(mm, address, pmd, _pmd);
> > -     update_mmu_cache_pmd(vma, address, pmd);
> > -     deferred_split_folio(folio, false);
> > -     spin_unlock(pmd_ptl);
> > +     if (order =3D=3D HPAGE_PMD_ORDER) {
> > +             pgtable =3D pmd_pgtable(_pmd);
> > +             _pmd =3D mk_huge_pmd(&folio->page, vma->vm_page_prot);
> > +             _pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> > +
> > +             spin_lock(pmd_ptl);
> > +             BUG_ON(!pmd_none(*pmd));
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > +             set_pmd_at(mm, address, pmd, _pmd);
> > +             update_mmu_cache_pmd(vma, address, pmd);
> > +             deferred_split_folio(folio, false);
> > +             spin_unlock(pmd_ptl);
> > +     } else { //mTHP
> > +             mthp_pte =3D mk_pte(&folio->page, vma->vm_page_prot);
> > +             mthp_pte =3D maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
> > +
> > +             spin_lock(pmd_ptl);
> > +             folio_ref_add(folio, (1 << order) - 1);
> > +             folio_add_new_anon_rmap(folio, vma, _address, RMAP_EXCLUS=
IVE);
> > +             folio_add_lru_vma(folio, vma);
> > +             spin_lock(pte_ptl);
> > +             set_ptes(vma->vm_mm, _address, pte, mthp_pte, (1 << order=
));
> > +             update_mmu_cache_range(NULL, vma, _address, pte, (1 << or=
der));
> > +             spin_unlock(pte_ptl);
> > +             smp_wmb(); /* make pte visible before pmd */
> > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > +             deferred_split_folio(folio, false);
>
>
> Hi Nico,
>
> This patch will have the same issue as the one I pointed out in
> https://lore.kernel.org/all/82b9efd1-f2a6-4452-b2ea-6c163e17cdf7@gmail.co=
m/ ?

Hi Usama,

Yes thanks for pointing that out! I'll make sure to remove the
deferred_split_folio call.

>


