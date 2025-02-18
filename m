Return-Path: <linux-kernel+bounces-520571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51EA3ABA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7765E161FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4CA17A309;
	Tue, 18 Feb 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfXY9Uoj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01F2862A9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917523; cv=none; b=D5Mumfg8XC8j6kjQ1OD1e/s4V/aHkqThFiXMhQ74NrQax/gej+0eFKhCDrGImtnmAeIdPWwI+fLkB3mDxDd2RRjlOvI3OnltczUEjG0V3bESmcS6bJIxIcZNEjRcDXeL+OakUSn6hAXmmzsUPhNh8CXsGW0yRw/QqVqqfZM2V3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917523; c=relaxed/simple;
	bh=LLa1n0vgA60rft65PihFMpatdgjjR47ZYkSWGWjpsF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpaC7qb6BIqJ8+f53cQatsxuNxM2AE/ukQsZue5AHOQOew1grbgsI2HTmTVIjso9cNa3uVKlhn0rYYVxfvg/dA4Q89c9dr9uinnbp5INOkHG3VJjoljf8n60i6D/PThKyB3vz7gsENZNhNd7zNyc/oKDMB5jCQmmKt1cJaadW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfXY9Uoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739917519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uolaZicYHg5+y+Pz9RgAB2e8l9DfMJppe4IWrGSl24I=;
	b=AfXY9UojeL0HcZNo9R526eJ7wk4SMRee76ciwba1wFhl0wgG+weIWYTNE/62fKyxH2QkJq
	WeDpWld8U/mHSvgJXmSKjiWGRUCmKgfEcbo+6P2DJ5bjCeeK69X+l/wElAzHTho00C6BGH
	neMtDaGa8c0pr//ykVyRCV+o62JEFq0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-toW-1thOPOSG32s3tArXKA-1; Tue, 18 Feb 2025 17:25:16 -0500
X-MC-Unique: toW-1thOPOSG32s3tArXKA-1
X-Mimecast-MFC-AGG-ID: toW-1thOPOSG32s3tArXKA_1739917516
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f465f0f314so81760017b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917516; x=1740522316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uolaZicYHg5+y+Pz9RgAB2e8l9DfMJppe4IWrGSl24I=;
        b=eri8JnVXqAikFlunK2pj3XoPkINsGAIQp2AHWZijxXNaibhuNRNWgs9RMkSqr6UjQZ
         Usc2KRc1LPhxkihI3sSYZs+8DDMurZFWV5YO18+9V7NvzHmqATmlt40pe0sIB7iyX81J
         i0nA3BZ+Jf/dwpkW2MGAF9r1qyPrApUskIqJp1zwCSWTVyA3lSojsnpYhQzi/dHjmsjf
         myAvJII5aFMP6oNJYYoVQ4eQeWeEUu51fzYOpV1W+mCJ4pMvKV538qLe4I1vQ3JDVHQZ
         mrZWuBAwSs/fOJU+VPoGwiB3FAjZecgn3sJQ3hIg/wU1hIEBqmO3CnTVCgA7AyMxliBy
         8k6A==
X-Gm-Message-State: AOJu0YxKEj6kwm5W2Xl1Zfx5mfuSQsufxGLScpnwMLNOyiJ1EJ35ypSv
	50r3UG6sVhPKY0bfF8lPUNJU6bR1gddLTuo9qLIZ9nCtHhHnOh/3oyeKWWfneUp85m7vOqvn796
	QOOCB6SpeVSqKvNRqCFXj4hIPCVmGQFkDcT5A2XL0fflEMMMSnPcAda1IFqmTQlZLVCH+c31Gdm
	UuVIki91agvuNrQlgLTY2hPBcj7OCdMfZUuUDo
X-Gm-Gg: ASbGnctl8pjlspSLwJsz5QgNeg/g2w+z4hKn2BNjqfY3ZxzQpXuSh2a5botXT+/LrwD
	EftOqcObpzZuR82Yg1JDqO/GL5H03cDaDH+E8QIH/AETQBVvgCPKWs60ENUx2gHmZmbf1iqtfdE
	Y=
X-Received: by 2002:a05:6902:a06:b0:e5d:cb35:59ad with SMTP id 3f1490d57ef6-e5e0a130d82mr1456811276.31.1739917515908;
        Tue, 18 Feb 2025 14:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbLdIDA7W8b7S7Vw5wFLoiCrmHVgVEE4AdNMwuOX5Ui1GwIyfL4fakzqmMyQ3bo2Fzq3h+smXl4DCCzGL6h+Q=
X-Received: by 2002:a05:6902:a06:b0:e5d:cb35:59ad with SMTP id
 3f1490d57ef6-e5e0a130d82mr1456780276.31.1739917515590; Tue, 18 Feb 2025
 14:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-2-npache@redhat.com>
 <8d1fed22-5ba8-433b-9ef9-478b337b10d5@arm.com>
In-Reply-To: <8d1fed22-5ba8-433b-9ef9-478b337b10d5@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 18 Feb 2025 15:24:49 -0700
X-Gm-Features: AWEUYZncCSKg8r54HWOU0tx_q-3fZrZtewemdqSCm6AyoWEay7IYmb-RET1BGEU
Message-ID: <CAA1CXcA1btm3ddHzKfrCZcce8=ekVKfbo84=4SegabQSgqoeWw@mail.gmail.com>
Subject: Re: [RFC v2 1/9] introduce khugepaged_collapse_single_pmd to unify
 khugepaged and madvise_collapse
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

On Tue, Feb 18, 2025 at 9:26=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/02/2025 00:30, Nico Pache wrote:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create khugepaged_collapse_single_pmd to increase code
> > reuse and create an entry point for future khugepaged changes.
> >
> > Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> > the new khugepaged_collapse_single_pmd function.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
> >  1 file changed, 50 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5f0be134141e..46faee67378b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2365,6 +2365,52 @@ static int hpage_collapse_scan_file(struct mm_st=
ruct *mm, unsigned long addr,
> >  }
> >  #endif
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int khugepaged_collapse_single_pmd(unsigned long addr, struct m=
m_struct *mm,
> > +                                struct vm_area_struct *vma, bool *mmap=
_locked,
> > +                                struct collapse_control *cc)
>
> nit: given the vma links to the mm is it really neccessary to pass both? =
Why not
> just pass vma?
Ah good point!
>
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> > +
> > +     if (!*mmap_locked) {
> > +             mmap_read_lock(mm);
> > +             *mmap_locked =3D true;
> > +     }
>
> AFAICT, the read lock is always held when khugepaged_collapse_single_pmd(=
) is
> called. Perhaps VM_WARN_ON(!*mmap_locked) would be more appropriate?

Hmm, I'm actually not sure why that's there. Its probably left over
from a previous change I was trying a while back.

>
> > +
> > +     if (thp_vma_allowable_order(vma, vma->vm_flags,
> > +                                     tva_flags, PMD_ORDER)) {
> > +             if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
>
> I guess it was like this before, but what's the relevance of CONFIG_SHMEM=
?
> Surely this should work for any file if CONFIG_READ_ONLY_THP_FOR_FS is en=
abled?

Yeah I think David brought up a similar point during one of our
meetings. I'm just combining the collapse users, so I'll leave it for
now.

>
> > +                     struct file *file =3D get_file(vma->vm_file);
> > +                     pgoff_t pgoff =3D linear_page_index(vma, addr);
> > +
> > +                     mmap_read_unlock(mm);
> > +                     *mmap_locked =3D false;
> > +                     result =3D hpage_collapse_scan_file(mm, addr, fil=
e, pgoff,
> > +                                                       cc);
> > +                     fput(file);
> > +                     if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > +                             mmap_read_lock(mm);
> > +                             if (hpage_collapse_test_exit_or_disable(m=
m))
> > +                                     goto end;
> > +                             result =3D collapse_pte_mapped_thp(mm, ad=
dr,
> > +                                                              !cc->is_=
khugepaged);
> > +                             mmap_read_unlock(mm);
> > +                     }
> > +             } else {
> > +                     result =3D hpage_collapse_scan_pmd(mm, vma, addr,
> > +                                                      mmap_locked, cc)=
;
> > +             }
> > +             if (result =3D=3D SCAN_SUCCEED || result =3D=3D SCAN_PMD_=
MAPPED)
> > +                     ++khugepaged_pages_collapsed;
>
> Looks like this counter was previously only incremented for the scan path=
, not
> for the madvise_collapse path. Not sure if that's a problem?

Yep! Usama noted that too, already fixed in the next version :)

Thanks!
-- Nico

>
> Thanks,
> Ryan
>
> > +     }
> > +end:
> > +     return result;
> > +}
> > +
> >  static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *r=
esult,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> > @@ -2439,33 +2485,9 @@ static unsigned int khugepaged_scan_mm_slot(unsi=
gned int pages, int *result,
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> >                                 khugepaged_scan.address + HPAGE_PMD_SIZ=
E >
> >                                 hend);
> > -                     if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous=
(vma)) {
> > -                             struct file *file =3D get_file(vma->vm_fi=
le);
> > -                             pgoff_t pgoff =3D linear_page_index(vma,
> > -                                             khugepaged_scan.address);
> >
> > -                             mmap_read_unlock(mm);
> > -                             mmap_locked =3D false;
> > -                             *result =3D hpage_collapse_scan_file(mm,
> > -                                     khugepaged_scan.address, file, pg=
off, cc);
> > -                             fput(file);
> > -                             if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPA=
GE) {
> > -                                     mmap_read_lock(mm);
> > -                                     if (hpage_collapse_test_exit_or_d=
isable(mm))
> > -                                             goto breakouterloop;
> > -                                     *result =3D collapse_pte_mapped_t=
hp(mm,
> > -                                             khugepaged_scan.address, =
false);
> > -                                     if (*result =3D=3D SCAN_PMD_MAPPE=
D)
> > -                                             *result =3D SCAN_SUCCEED;
> > -                                     mmap_read_unlock(mm);
> > -                             }
> > -                     } else {
> > -                             *result =3D hpage_collapse_scan_pmd(mm, v=
ma,
> > -                                     khugepaged_scan.address, &mmap_lo=
cked, cc);
> > -                     }
> > -
> > -                     if (*result =3D=3D SCAN_SUCCEED)
> > -                             ++khugepaged_pages_collapsed;
> > +                     *result =3D khugepaged_collapse_single_pmd(khugep=
aged_scan.address,
> > +                                             mm, vma, &mmap_locked, cc=
);
> >
> >                       /* move to next address */
> >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> > @@ -2785,36 +2807,18 @@ int madvise_collapse(struct vm_area_struct *vma=
, struct vm_area_struct **prev,
> >               mmap_assert_locked(mm);
> >               memset(cc->node_load, 0, sizeof(cc->node_load));
> >               nodes_clear(cc->alloc_nmask);
> > -             if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> > -                     struct file *file =3D get_file(vma->vm_file);
> > -                     pgoff_t pgoff =3D linear_page_index(vma, addr);
> >
> > -                     mmap_read_unlock(mm);
> > -                     mmap_locked =3D false;
> > -                     result =3D hpage_collapse_scan_file(mm, addr, fil=
e, pgoff,
> > -                                                       cc);
> > -                     fput(file);
> > -             } else {
> > -                     result =3D hpage_collapse_scan_pmd(mm, vma, addr,
> > -                                                      &mmap_locked, cc=
);
> > -             }
> > +             result =3D khugepaged_collapse_single_pmd(addr, mm, vma, =
&mmap_locked, cc);
> > +
> >               if (!mmap_locked)
> >                       *prev =3D NULL;  /* Tell caller we dropped mmap_l=
ock */
> >
> > -handle_result:
> >               switch (result) {
> >               case SCAN_SUCCEED:
> >               case SCAN_PMD_MAPPED:
> >                       ++thps;
> >                       break;
> >               case SCAN_PTE_MAPPED_HUGEPAGE:
> > -                     BUG_ON(mmap_locked);
> > -                     BUG_ON(*prev);
> > -                     mmap_read_lock(mm);
> > -                     result =3D collapse_pte_mapped_thp(mm, addr, true=
);
> > -                     mmap_read_unlock(mm);
> > -                     goto handle_result;
> > -             /* Whitelisted set of results where continuing OK */
> >               case SCAN_PMD_NULL:
> >               case SCAN_PTE_NON_PRESENT:
> >               case SCAN_PTE_UFFD_WP:
>


