Return-Path: <linux-kernel+bounces-447980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CB9F397B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347F6188E485
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328822080DC;
	Mon, 16 Dec 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpucEFSw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CD207A25
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376114; cv=none; b=aNrVHIQKaUCd5hOkFfVKwloI3DQOG0pWzae5eGE5MAhH+ecbiX+pP0Z2kZJJjh3++P9Neiz3Q2GY9p4WZcD3MZY4fg13Lwl712vVNCQvQEddz27ZKCcyC2RXNlpvzEvYeFq9JlkQDCgFvndsUJHPBhTpv4fePpvmywIjqh1VIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376114; c=relaxed/simple;
	bh=4trEnjg8FaxmQpSHn1SWeZif+Jxs/KgZUPCwYiK22zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko6xedHOivEa/xqxHUScCngqZkQ7PWXjVvlKGlKafN5e42vTpImgkh3eckwV0JjQW4HF9gmA4f56X7d/nefeQKeHE1C5+rkjBxjjJxQxvF+46U3K3/bBneQvKwekvSuib18aUNLk8qnhuMWmGClozLQDz91wUCz5KaycPuSzy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpucEFSw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so594338366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734376111; x=1734980911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGtjtDI9LlgFgESjDmCjd2UaDN7YrIT9myakWkQ2B98=;
        b=hpucEFSwyjaSdBr98UoFpv6SpZ38aLL35Upn23VeT9rSiumyeZyCNBwXmi1yVV8DJB
         AeBY0lww0IITg8GJnWjayHHGvz9d8KvhhWzbKj52zlyAa18qzZuce/jWi74HLBt+ycaf
         dX8ERsvDWpKc+s0W7W/xZeiVQKamwERxWDAv+BdtKB6gkIsuWpx6Q6CKF7apFc/thDgN
         vJwkCn+v0FNXFw69kGJI/qL7qBQyYzddIsRkJ4gc0Lt5HJH35vE6PcVsKRoeX979d8bR
         DuhKh7TFxclMoq/ZIr32/s7VZNiudRP4iSOco2TIW6C6lv3s2LSOA6k9aJU/8ICmwa4b
         qWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734376111; x=1734980911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGtjtDI9LlgFgESjDmCjd2UaDN7YrIT9myakWkQ2B98=;
        b=QTLd8fNx+2wgGaoVd5XvC3zAXD5Cph0V7wUhjnjTLLF7EmtjmToIg8GSTyodTfA3fD
         JFtDap7A+Ezscdz0xPJMUc7yrY5tfDiV/HIEf8ia0ReQnkB4iG18v7srFdBu1p7L4KhZ
         n05sOpR2uqZNuftPacyCgXI0F9pBmlCVE3irO0qhqaWYDvpygF83IeP53tEC7EVzZW9T
         rn1lfj1mlR7Zz3pl19A4nFWf9KXhnVvOVJ5Jer1hs47IoLzq9eiWhre5HgTxApSxjcgS
         S21CZS3NHsXb8RcpHBz+wRYqQjeN1nXm+kn0pKBHJMLNCZLzeNqWnXiboyZvcUcxE8My
         c0nw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJQnwN2ANyI4DNpfSWxKssxv+kjrqGbbTXYgfHVAdPZXOScFdKl+j+/T9wKRgVBnHD2+xmoB6DuZuj8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFH4Zd8Z1k+AD7e70J7fuZO6Y84Qiekho959pK8MUed6ez6yXH
	HO73nrmLZooiGA5LKahpPsm3SHaXXaD69GQI++mL/mnL9mznMFkb4Lfqf9X/f4k3zHZeBadKhGE
	cGON7PQQ5V8W5BNzpmhW+gy/B+4s=
X-Gm-Gg: ASbGnctAbUAc+8aDslD0S9Zy7noC0U54mFzkm2al/k1P+k6Ytkeht618Ju/ozIqczLg
	nsMy+bgkZUAgC5r3Es0yfpTtQNhVj5O36pOQk/w==
X-Google-Smtp-Source: AGHT+IGmKMOv6ZJKu1cQzOh7XKN9eDWLwpGeLuOpu1x9JSaUZb6hRRdAYJM4bVDCU77a34DUVfplqSbBKYkBhv5Dme0=
X-Received: by 2002:a05:6402:5109:b0:5d0:abb8:7a3 with SMTP id
 4fb4d7f45d1cf-5d63c30097cmr31780177a12.6.1734376110461; Mon, 16 Dec 2024
 11:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216165105.56185-1-dev.jain@arm.com> <20241216165105.56185-10-dev.jain@arm.com>
 <2215dd8e-233a-427b-b15c-a2ffbce8f46d@redhat.com>
In-Reply-To: <2215dd8e-233a-427b-b15c-a2ffbce8f46d@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 16 Dec 2024 11:08:19 -0800
Message-ID: <CAHbLzkr00Ks129c4i-RE61W=fpjggxMsPp=8jgc0tEoHLCe5fA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/12] khugepaged: Introduce vma_collapse_anon_folio()
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, willy@infradead.org, 
	kirill.shutemov@linux.intel.com, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.12.24 17:51, Dev Jain wrote:
> > In contrast to PMD-collapse, we do not need to operate on two levels of=
 pagetable
> > simultaneously. Therefore, downgrade the mmap lock from write to read m=
ode. Still
> > take the anon_vma lock in exclusive mode so as to not waste time in the=
 rmap path,
> > which is anyways going to fail since the PTEs are going to be changed. =
Under the PTL,
> > copy page contents, clear the PTEs, remove folio pins, and (try to) unm=
ap the
> > old folios. Set the PTEs to the new folio using the set_ptes() API.
> >
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > ---
> > Note: I have been trying hard to get rid of the locks in here: we still=
 are
> > taking the PTL around the page copying; dropping the PTL and taking it =
after
> > the copying should lead to a deadlock, for example:
> > khugepaged                                            madvise(MADV_COLD=
)
> > folio_lock()                                          lock(ptl)
> > lock(ptl)                                             folio_lock()
> >
> > We can create a locked folio list, altogether drop both the locks, take=
 the PTL,
> > do everything which __collapse_huge_page_isolate() does *except* the is=
olation and
> > again try locking folios, but then it will reduce efficiency of khugepa=
ged
> > and almost looks like a forced solution :)
> > Please note the following discussion if anyone is interested:
> > https://lore.kernel.org/all/66bb7496-a445-4ad7-8e56-4f2863465c54@arm.co=
m/
> > (Apologies for not CCing the mailing list from the start)
> >
> >   mm/khugepaged.c | 108 ++++++++++++++++++++++++++++++++++++++---------=
-
> >   1 file changed, 87 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 88beebef773e..8040b130e677 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -714,24 +714,28 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >                                               struct vm_area_struct *vm=
a,
> >                                               unsigned long address,
> >                                               spinlock_t *ptl,
> > -                                             struct list_head *compoun=
d_pagelist)
> > +                                             struct list_head *compoun=
d_pagelist, int order)
> >   {
> >       struct folio *src, *tmp;
> >       pte_t *_pte;
> >       pte_t pteval;
> >
> > -     for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
> > +     for (_pte =3D pte; _pte < pte + (1UL << order);
> >            _pte++, address +=3D PAGE_SIZE) {
> >               pteval =3D ptep_get(_pte);
> >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> >                       add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> >                       if (is_zero_pfn(pte_pfn(pteval))) {
> > -                             /*
> > -                              * ptl mostly unnecessary.
> > -                              */
> > -                             spin_lock(ptl);
> > -                             ptep_clear(vma->vm_mm, address, _pte);
> > -                             spin_unlock(ptl);
> > +                             if (order =3D=3D HPAGE_PMD_ORDER) {
> > +                                     /*
> > +                                     * ptl mostly unnecessary.
> > +                                     */
> > +                                     spin_lock(ptl);
> > +                                     ptep_clear(vma->vm_mm, address, _=
pte);
> > +                                     spin_unlock(ptl);
> > +                             } else {
> > +                                     ptep_clear(vma->vm_mm, address, _=
pte);
> > +                             }
> >                               ksm_might_unmap_zero_page(vma->vm_mm, pte=
val);
> >                       }
> >               } else {
> > @@ -740,15 +744,20 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >                       src =3D page_folio(src_page);
> >                       if (!folio_test_large(src))
> >                               release_pte_folio(src);
> > -                     /*
> > -                      * ptl mostly unnecessary, but preempt has to
> > -                      * be disabled to update the per-cpu stats
> > -                      * inside folio_remove_rmap_pte().
> > -                      */
> > -                     spin_lock(ptl);
> > -                     ptep_clear(vma->vm_mm, address, _pte);
> > -                     folio_remove_rmap_pte(src, src_page, vma);
> > -                     spin_unlock(ptl);
> > +                     if (order =3D=3D HPAGE_PMD_ORDER) {
> > +                             /*
> > +                             * ptl mostly unnecessary, but preempt has=
 to
> > +                             * be disabled to update the per-cpu stats
> > +                             * inside folio_remove_rmap_pte().
> > +                             */
> > +                             spin_lock(ptl);
> > +                             ptep_clear(vma->vm_mm, address, _pte);
>
>
>
>
> > +                             folio_remove_rmap_pte(src, src_page, vma)=
;
> > +                             spin_unlock(ptl);

I think it is ok not to take the ptl since the preempt is disabled at
this point by pte_map(). pte_unmap() is called after copy.

> > +                     } else {
> > +                             ptep_clear(vma->vm_mm, address, _pte);
> > +                             folio_remove_rmap_pte(src, src_page, vma)=
;
> > +                     }
>
> As I've talked to Nico about this code recently ... :)
>
> Are you clearing the PTE after the copy succeeded? If so, where is the
> TLB flush?
>
> How do you sync against concurrent write acess + GUP-fast?
>
>
> The sequence really must be: (1) clear PTE/PMD + flush TLB (2) check if
> there are unexpected page references (e.g., GUP) if so back off (3)
> copy page content (4) set updated PTE/PMD.

Yeah, either PMD is not cleared or tlb_remove_table_sync_one() is not
called IIRC, the concurrent GUP may change the refcount after the
refcount check.

>
> To Nico, I suggested doing it simple initially, and still clear the
> high-level PMD entry + flush under mmap write lock, then re-map the PTE
> table after modifying the page table. It's not as efficient, but "harder
> to get wrong".
>
> Maybe that's already happening, but I stumbled over this clearing logic
> in __collapse_huge_page_copy_succeeded(), so I'm curious.
>
> --
> Cheers,
>
> David / dhildenb
>
>

