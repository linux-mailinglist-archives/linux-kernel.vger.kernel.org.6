Return-Path: <linux-kernel+bounces-518281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9FBA38CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EB13A8441
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6C2376EA;
	Mon, 17 Feb 2025 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cthny8wy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B9372
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822203; cv=none; b=tZnkuSoCIYyQWl+EiNtgIFOaMpnM9Yar7l4Bh38s3YZd1SIMPrvvMdVCrIIiVGm1YEMYZTslNuSwEnyc87ukY2mQDIrARDRTvpmdyKRKSHSg2wfijpDRG7bHs+WD115A8apCquABwoakt3qi4oXo+qPMEAkt8VedF7HpDnt+lfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822203; c=relaxed/simple;
	bh=45zvzCpuZdiOQMH+CSHIRZqZFl4bhX5N9y5i5DgP08s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Us4ZiMfcxdgl7d9E7NmcjHA7V6pZQUf0XMt8KzhFPoeBRUp8MYX09ToLGJ5qFrTQDR0M8y1CeT8ndqMcE1s+2dDNZDeXdJb1wFLkkBvMYXICv2uX0HU1gbc5I2Rm7lOxsv82RWKGFBOBA9IqKnet/jbY0NED0c86997Yf/QtqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cthny8wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739822199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqCdFAjIMlG+m7JvnwnT/7LZs5YuDBGEp7uqaQeK9Xw=;
	b=cthny8wy3BFof/lBfbHKWV42U/leXpshAib3cqbubEF22QrEKTXD35mwgdBubtgV73bOWj
	9zrpsEXqWP26uD2t7UZ0V8y2PcKHHkrGL1ZtOhNGUQFKmjamJpmSKKEVUbBtAYUaSP3DEk
	0el6ZS4DWMvBybMLXgK6JVsnOQbGPRs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-A117eEvpMS2Ep2wTWn9gjQ-1; Mon, 17 Feb 2025 14:56:38 -0500
X-MC-Unique: A117eEvpMS2Ep2wTWn9gjQ-1
X-Mimecast-MFC-AGG-ID: A117eEvpMS2Ep2wTWn9gjQ_1739822198
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e5798866415so7542969276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822198; x=1740426998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqCdFAjIMlG+m7JvnwnT/7LZs5YuDBGEp7uqaQeK9Xw=;
        b=l51vhrmkIzaPV06D73pOk9fg9MAqc3jDvHuyyIjbia6j95zLDCJrO8no86kLCnirGf
         bBhKQcf9ZmJf2OMWHCj0LMrh4QSB5rZQpidaoSd1tn5f9rfWP1HyoFTQvKc1EBZIhgQU
         HYCiYsuMtzUtToMYcw50QXRH6yPVXO//Z17v3oMq95YsrexxukJagm2sZJGg6YcfjGsF
         NABnSyS/BmSUO9njeUv7t4wGa5h9cVLM/UPjv8y/Y+1JRXbo/pAukTv/rapFwn920K1M
         Fq0J/UF+DYTtEwLJI0uKdkT/WoDB3s18YYlQ7BgaBA4z7Unes9n2e3QNWanWAsZ/E4go
         zq7Q==
X-Gm-Message-State: AOJu0YyVtc4FYY8j6fDOal9NnBujDWRMW4HQWjc8o+SrtgZ4mAkK4iGE
	gGfQRjuS5tl8rjHm6ADA68SMXXUeCK4ryV/Dv7ypJMQtFrKviW3UR2g66yvv7plwtM0Qp29TRZp
	ixTFWon50SkNPwbFnnWx7NO6xhc7zIM46VJWY5V1aXBDLBV3i7U8Y9G9zOqf3/6OYp4fXSU8EF3
	gehaHFwtgufGM7vnsTILwOPlHQelv5kR4jdJTZ
X-Gm-Gg: ASbGnctp+aSfjyUw8PzNn6i/HZymOtM5CDshfocdCt5eqELw4nl+kz7V1dw2CxGhPe3
	MGRpSDV2x6l04opDmUGF0314VTClzGMbZ5Rzbjvwe8yeuFj29ju+JbpSbukOj4Mpj7W9hqw5+nM
	4=
X-Received: by 2002:a05:6902:10c9:b0:e5b:3f2b:28cc with SMTP id 3f1490d57ef6-e5dc9082c71mr10387610276.23.1739822197799;
        Mon, 17 Feb 2025 11:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0c+uqtnHXYo8YxqqHqGfRhytcD8J945ccQNdE/lv0NN9KVif1/J+AAv9kWkW4QXSEJUvh87oMtKMsTN20X9Q=
X-Received: by 2002:a05:6902:10c9:b0:e5b:3f2b:28cc with SMTP id
 3f1490d57ef6-e5dc9082c71mr10387573276.23.1739822197433; Mon, 17 Feb 2025
 11:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <20250211003028.213461-2-npache@redhat.com>
 <79c80db7-5786-4bb5-9d5d-fa76882116e8@gmail.com>
In-Reply-To: <79c80db7-5786-4bb5-9d5d-fa76882116e8@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:56:11 -0700
X-Gm-Features: AWEUYZk_MdQF26SDqyZdTE3j8L5mxZs6sCr0DlDyq0R_tw1lka-hNvuiPKWnvAU
Message-ID: <CAA1CXcAD0g250r6Dda4XpSDrUVR7g2gXXmFm6-WwtqKdfNXNNA@mail.gmail.com>
Subject: Re: [RFC v2 1/9] introduce khugepaged_collapse_single_pmd to unify
 khugepaged and madvise_collapse
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
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:11=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
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
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> > +
> > +     if (!*mmap_locked) {
> > +             mmap_read_lock(mm);
> > +             *mmap_locked =3D true;
> > +     }
> > +
> > +     if (thp_vma_allowable_order(vma, vma->vm_flags,
> > +                                     tva_flags, PMD_ORDER)) {
> > +             if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
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
>
> you will be incrementing khugepaged_pages_collapsed at madvise_collapse b=
y calling
> khugepaged_collapse_single_pmd which is not correct.

Ah good catch, Ill add a conditional around the incrementation. Thanks!

>
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


