Return-Path: <linux-kernel+bounces-330204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D6979AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030BCB21355
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB51381B1;
	Mon, 16 Sep 2024 05:58:47 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AE22EF0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726466326; cv=none; b=tUOd4cuL9cOwewrFWiSzaZrdxO0EhpwCcW3pOElLpaaHS2dAThhioq1PxTd+HBmKNrlwA7gNqJl6AQfcQ7uD6VwdWbu568QNLDdcUjvmXfecM+8IGfPh6tG4GUbPLzerIUJO9b77D2npDTxklo5Id6k3MZBdnCHwuAMYWu24gsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726466326; c=relaxed/simple;
	bh=9sFED27O6fj7biJ0aw62eljD9hPAsb3QPnccmrtr8gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=len342unXPm35ZTWYUUtQW0j0HnJ8+jhJpPaFpnSzWTvwGFHRTSwDb4F1eU1VHse492vPA9WNmto7Q1IalVsRLmgYg10Vw4EzDVB7H90Os90KkPTi3T51xC9M9IzFTUJYuDTfmI1zlWhabym24y73Xe2ytI+lH2AE5hapLJCWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49bd27b3507so1279600137.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726466324; x=1727071124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hJT+txCRKjGC9WhGmri/YkmrtjflyDminSTQplDjCY=;
        b=wvPQkUJJSCm95mtA5h3WrsibbmdbAi97iNfzHsBZEDZ38UEQSe+JdrYOK1iqIfunHO
         TDS8Pgxkysz23MiFa/euJV51l5c2OJVYnATHGwg6KCKVjpQzML7LJ55YCsJcW5xDQlFm
         1zdBfAhaobEuBciZmAaLFURUK+KPZHe3/BOADk1pF6K2eAX86rOLsBfLyWDl2VvalP57
         MYreWypBf11GtkgFfqSOdBUU6icKYJXwKprGsUlKS8YTmYkg1jjQC2DNNz1ZILQYbndI
         YD1xpZJtE98Flr+GAf3xkyLs7TNXqj8E3B4ay1cUyZXrfKz9EvHoc2I7wM2I6QV8P39M
         XHQg==
X-Forwarded-Encrypted: i=1; AJvYcCXpA9cUeWh3BUbVSltY9e73lQsw9RqlZd5WXER5L7bUVpRmyZUQ1d/ljC1Meh4U83wMrksbPBFxywQe8Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDefp+eK9xUjuvOQBBILa/XjO3BDv2qB0jLKGMM+QhoyWGaAmg
	INBHqN5VLicswLP/SLfQ/swmb66xNsCOnAG9iNvxaBVLLSH9yZt9OaawTw5yuJHXnnMe/JrM4BC
	Fu9N0na+Qls8lninzQp8Ffdfuhc8=
X-Google-Smtp-Source: AGHT+IH/1DWYerKzMUk0aLOXExkBU6NhlheCwfrs4h435JiREB/QhRSZ98tJF30z5gGWeJM1ceXkTBqVNaciY6wOr84=
X-Received: by 2002:a05:6102:3052:b0:48f:cb62:231a with SMTP id
 ada2fe7eead31-49d41563d9emr9792525137.23.1726466324039; Sun, 15 Sep 2024
 22:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913091902.1160520-1-dev.jain@arm.com> <CAGsJ_4yRadEPiO5H7Nd1jXQ1Gydt43VtUjfQDEp5Q+U9yddTnA@mail.gmail.com>
 <ba7594d4-5d3c-4950-a1bb-e50b68a74832@arm.com>
In-Reply-To: <ba7594d4-5d3c-4950-a1bb-e50b68a74832@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 16 Sep 2024 13:58:32 +0800
Message-ID: <CAGsJ_4z9Bus2=A7bdyEGx+aNake9Le-a7f8=rJZQoGT+9Gn3ZQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, hughd@google.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, 
	baolin.wang@linux.alibaba.com, gshan@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 1:20=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 9/16/24 10:42, Barry Song wrote:
> > On Fri, Sep 13, 2024 at 5:19=E2=80=AFPM Dev Jain <dev.jain@arm.com> wro=
te:
> >> We use pte_range_none() to determine whether contiguous PTEs are empty
> >> for an mTHP allocation. Instead of iterating the while loop for every
> >> order, use some information, which is the first set PTE found, from th=
e
> >> previous iteration, to eliminate some cases. The key to understanding
> >> the correctness of the patch is that the ranges we want to examine
> >> form a strictly decreasing sequence of nested intervals.
> >>
> >> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> >> Signed-off-by: Dev Jain <dev.jain@arm.com>
> > I like this patch, but could we come up with a better subject for
> > pte_range_none()?
> > The subject is really incorrect.
>
> Are you asking me to change "Compute mTHP order efficiently" to
> something else?

Right.

Adjust the subject to more accurately reflect the specific changes
being made.

>
> >
> > Also, I'd prefer the change for alloc_anon_folio() to be separated
> > into its own patch.
> > So, one patchset with two patches, please.
>
> Fine by me.
>
> >
> >> ---
> >>   mm/memory.c | 30 +++++++++++++++++++++++-------
> >>   1 file changed, 23 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 3c01d68065be..ffc24a48ef15 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4409,26 +4409,27 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>          return ret;
> >>   }
> >>
> >> -static bool pte_range_none(pte_t *pte, int nr_pages)
> >> +static int pte_range_none(pte_t *pte, int nr_pages)
> >>   {
> >>          int i;
> >>
> >>          for (i =3D 0; i < nr_pages; i++) {
> >>                  if (!pte_none(ptep_get_lockless(pte + i)))
> >> -                       return false;
> >> +                       return i;
> >>          }
> >>
> >> -       return true;
> >> +       return nr_pages;
> >>   }
> >>
> >>   static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> >>   {
> >>          struct vm_area_struct *vma =3D vmf->vma;
> >>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +       pte_t *first_set_pte =3D NULL, *align_pte, *pte;
> >>          unsigned long orders;
> >>          struct folio *folio;
> >>          unsigned long addr;
> >> -       pte_t *pte;
> >> +       int max_empty;
> >>          gfp_t gfp;
> >>          int order;
> >>
> >> @@ -4463,8 +4464,23 @@ static struct folio *alloc_anon_folio(struct vm=
_fault *vmf)
> >>          order =3D highest_order(orders);
> >>          while (orders) {
> >>                  addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order)=
;
> >> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> >> +               align_pte =3D pte + pte_index(addr);
> >> +
> >> +               /* Range to be scanned known to be empty */
> >> +               if (align_pte + (1 << order) <=3D first_set_pte)
> >>                          break;
> >> +
> >> +               /* Range to be scanned contains first_set_pte */
> >> +               if (align_pte <=3D first_set_pte)
> >> +                       goto repeat;
> >> +
> >> +               /* align_pte > first_set_pte, so need to check properl=
y */
> >> +               max_empty =3D pte_range_none(align_pte, 1 << order);
> >> +               if (max_empty =3D=3D 1 << order)
> >> +                       break;
> >> +
> >> +               first_set_pte =3D align_pte + max_empty;
> >> +repeat:
> >>                  order =3D next_order(&orders, order);
> >>          }
> >>
> >> @@ -4579,7 +4595,7 @@ static vm_fault_t do_anonymous_page(struct vm_fa=
ult *vmf)
> >>          if (nr_pages =3D=3D 1 && vmf_pte_changed(vmf)) {
> >>                  update_mmu_tlb(vma, addr, vmf->pte);
> >>                  goto release;
> >> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)=
) {
> >> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) =
!=3D nr_pages) {
> >>                  update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> >>                  goto release;
> >>          }
> >> @@ -4915,7 +4931,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >>                  update_mmu_tlb(vma, addr, vmf->pte);
> >>                  ret =3D VM_FAULT_NOPAGE;
> >>                  goto unlock;
> >> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)=
) {
> >> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) =
!=3D nr_pages) {
> >>                  update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> >>                  ret =3D VM_FAULT_NOPAGE;
> >>                  goto unlock;
> >> --
> >> 2.30.2
> >>
> > Thanks
> > Barry
>

