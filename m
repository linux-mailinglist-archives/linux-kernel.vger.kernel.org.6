Return-Path: <linux-kernel+bounces-362125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F1799B161
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10642836A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7341713A87E;
	Sat, 12 Oct 2024 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIp8W5x2"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC885626
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716432; cv=none; b=nIzgVurmoYoKSyjXU/uGHuQ06iTgrC7TWap7+eWEbayl6xvbcgZ1EiNBVMGuac6jcjMTNxmOUmFoku8aAFFNLUwiOhcPcM78kcNInjAvaoHWk7jGQtUUhcOHmCiYsyHNyoflK2t/aNApd5aVhZi9OC5+j8cR/CiFQNi9MiBzCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716432; c=relaxed/simple;
	bh=oEkkQYH6f1NaC+hZc4NbmyfT6wdfuJmAYbfAGAT+OKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgLQoNry2SN19TZ2Z/56oXNra6IYAYUDJz2Nb32fNviwGkXX78NPyus58cw/fd126BF39krlc/CJNG9N77K8X8MradoIMv+wDRsjmSOoXqnEgrcR2ZcH3krRWa98LwmiwNW5dHOb1l4r8bDo4CNJ31QX83c1jQZumu37U7Bv+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIp8W5x2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so29076971fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728716429; x=1729321229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+rjhvfejhKc66T4VNRLDbldGPyzCO+IeH4dTtI1lxA=;
        b=CIp8W5x25k8QAiv6Z4V81BeFgeNrNlO3F/UvGcVwGDn2kBzfs05vIFIdajgP7+s8R6
         53rHdtP8oE3YrK3tyX+yonCwEnBZy4n9V35zAEBGlEHUm4Nfndt183aKgfzTxLpEZgQV
         xOGvA2X6QSijMyaIBPCoGx+reBScOi0lRRIwjad5Re/zXr/8yzBkdMDdnAfPMbgmmHdF
         ADWGVK2+n1hX2RNW4JMguuPxN0DrrfsJa4702co331lLPQBL/joPaKDN13CPrr0Vd1oc
         OuquOjwYPCLydVLL2sSwgzYMSQkDqPaeaoTrV3spMnyWDJbxm9ukiTbXiQ03TwSVdyVt
         33DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728716429; x=1729321229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+rjhvfejhKc66T4VNRLDbldGPyzCO+IeH4dTtI1lxA=;
        b=mKPbTNb0jZwlRNGlTE2eUng3t2t2OOIo2i71/cOtYMQc06B9GT0llZmfzDPlpQCHy6
         yYGVXLnZn/ryl6cSDUf1ZTutQkasbCkz/IzjvA1qxwqLJ55OCvZAHzyDFG3chSHwIQT2
         6Jzb7dpdOzJOSTQZMbuAD/kCXfC4YhMMnoTUSFHfufdY3zzysWtxqgZK63dRvZMOZv4/
         TtKThCQXpvhG/QIT17zjOQPV7MioenpjCdzPPPfa/LGtuok+yEhGaObt965OnhE2T1yw
         CtmcgyM5Dilkvlg23w2G268XaERInmcn0JqJOeNVb9Hx/HhgPML/3UwNcmgmibZ8ASj5
         95cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3rRpY9MI1aJakyb0WWwfr7tP5BWDgrvsR6AG8OLfA8pVA4bVRPzuVC3eVeJGQe7XBJcMgRd+AuHZS0aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3cI6UwJQrVtJTfpZ5CQvtbaW/y+lmkiXh5LO17H17xcEGJmB
	fmTVyf7TMswsYV84yeD9HdV5reZsrPlpK6kXwxBRz29IHg4ZtEkawZEh6LGwYYlzJq0uxxR5jbf
	brRjHVd86XiHUgFC76dFF9S3ZPvg=
X-Google-Smtp-Source: AGHT+IFUCULct4osFhNH4icf3XaVzR8jM+pcuE22BXGQHa+61qR0QNOQ/t5BDtAv2EI6ejnSzwoFg9M6B0Je2ISZpN0=
X-Received: by 2002:ac2:4e16:0:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-539da3c5ee1mr3094937e87.13.1728716428454; Sat, 12 Oct 2024
 00:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011080543.2422-1-suhua1@kingsoft.com> <C1125584-8165-473F-8E11-44CD4BD90BDF@linux.dev>
In-Reply-To: <C1125584-8165-473F-8E11-44CD4BD90BDF@linux.dev>
From: Su Hua <suhua.tanke@gmail.com>
Date: Sat, 12 Oct 2024 14:59:51 +0800
Message-ID: <CALe3CaAHHsLLGbRPS2orLyH23coJZXj+RauskdS=HkB8nYVMhw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Concentrated releases memory when cmdline
 specifies node requests for large pages
To: Muchun Song <muchun.song@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It does seem to be for a newly allocated huge page just call
enqueue_hugetlb_folio without the complicated decisions in
free_huge_folio.

Thanks
Su

Muchun Song <muchun.song@linux.dev> =E4=BA=8E2024=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E5=85=AD 11:23=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> > On Oct 11, 2024, at 16:05, suhua <suhua.tanke@gmail.com> wrote:
> >
> > When HVO is enabled and huge page memory allocs are made, the freed mem=
ory
> > can be aggregated into higher order memory in the following paths, whic=
h
> > facilitates further allocs for higher order memory.
> >
> > echo 200000 > /proc/sys/vm/nr_hugepages
> > echo 200000 > /sys/devices/system/node/node*/hugepages/hugepages-2048kB=
/nr_hugepages
> > grub=EF=BC=9A default_hugepagesz=3D2M hugepagesz=3D2M hugepages=3D20000=
0
> >
> > Currently not support for releasing aggregations to higher order in the
> > following way, which will releasing to lower order.
> >
> > grub: default_hugepagesz=3D2M hugepagesz=3D2M hugepages=3D0:100000,1:10=
0000
> >
> > This patch supports the release of huge page optimizations aggregates t=
o
> > higher order memory.
> >
> > eg:
> > cat /proc/cmdline
> > BOOT_IMAGE=3D/boot/vmlinuz-xxx ... default_hugepagesz=3D2M hugepagesz=
=3D2M hugepages=3D0:100000,1:100000
> >
> > Before:
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > ...
> > Node    0, zone   Normal, type    Unmovable  55282  97039  99307      0=
      1      1      0      1      1      1      0
> > Node    0, zone   Normal, type      Movable     25     11    345     87=
     48     21      2     20      9      3  75061
> > Node    0, zone   Normal, type  Reclaimable      4      2      2      4=
      3      0      2      1      1      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > ...
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > Node    1, zone   Normal, type    Unmovable  98888  99650  99679      2=
      3      1      2      2      2      0      0
> > Node    1, zone   Normal, type      Movable      1      1      0      1=
      1      0      1      0      1      1  75937
> > Node    1, zone   Normal, type  Reclaimable      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    1, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> >
> > After:
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > ...
> > Node    0, zone   Normal, type    Unmovable    152    158     37      2=
      2      0      3      4      2      6    717
> > Node    0, zone   Normal, type      Movable      1     37     53      3=
     55     49     16      6      2      1  75000
> > Node    0, zone   Normal, type  Reclaimable      1      4      3      1=
      2      1      1      1      1      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > ...
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > Node    1, zone   Normal, type    Unmovable      5      3      2      1=
      3      4      2      2      2      0    779
> > Node    1, zone   Normal, type      Movable      1      0      1      1=
      1      0      1      0      1      1  75849
> > Node    1, zone   Normal, type  Reclaimable      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    1, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
>
> A good result. But the subject could be changed to:
>
>         "mm/hugetlb: perform vmemmap optimization batchly for specific no=
de allocation"
>
> >
> > Signed-off-by: suhua <suhua1@kingsoft.com>
> > ---
> > mm/hugetlb.c | 37 +++++++++++++++++++++++++++++++++----
> > 1 file changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 190fa05635f4..3441d380c90b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2077,6 +2077,24 @@ static struct folio *only_alloc_fresh_hugetlb_fo=
lio(struct hstate *h,
> >       return folio;
> > }
> >
> > +static struct folio *only_alloc_and_account_fresh_hugetlb_folio(
> > +             struct hstate *h, gfp_t gfp_mask,
> > +             int nid, nodemask_t *nmask)
> > +{
> > +     struct folio *folio;
> > +
> > +     folio =3D only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,=
 NULL);
> > +     if (!folio)
> > +             return NULL;
> > +
> > +     spin_lock_irq(&hugetlb_lock);
> > +     h->nr_huge_pages++;
> > +     h->nr_huge_pages_node[nid]++;
> > +     spin_unlock_irq(&hugetlb_lock);
> > +
> > +     return folio;
> > +}
> > +
> > /*
> >  * Common helper to allocate a fresh hugetlb page. All specific allocat=
ors
> >  * should use this function to get new hugetlb pages
> > @@ -3301,23 +3319,34 @@ static void __init hugetlb_hstate_alloc_pages_o=
nenode(struct hstate *h, int nid)
> > {
> >       unsigned long i;
> >       char buf[32];
> > +     LIST_HEAD(folio_list);
> > +     struct folio *folio, *tmp_f;
> >
> >       for (i =3D 0; i < h->max_huge_pages_node[nid]; ++i) {
> >               if (hstate_is_gigantic(h)) {
> >                       if (!alloc_bootmem_huge_page(h, nid))
> >                               break;
> >               } else {
> > -                     struct folio *folio;
> >                       gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THI=
SNODE;
> >
> > -                     folio =3D alloc_fresh_hugetlb_folio(h, gfp_mask, =
nid,
> > -                                     &node_states[N_MEMORY]);
> > +                     folio =3D only_alloc_and_account_fresh_hugetlb_fo=
lio(h,
> > +                                     gfp_mask, nid, &node_states[N_MEM=
ORY]);
>
> I think we could use only_alloc_fresh_hugetlb_folio plus prep_and_add_all=
ocated_folios
> to achieve the same goal but more simpler, right?
>
> >                       if (!folio)
> >                               break;
> > -                     free_huge_folio(folio); /* free it into the hugep=
age allocator */
> > +                     list_add(&folio->lru, &folio_list);
> >               }
> >               cond_resched();
> >       }
> > +
> > +     if (!list_empty(&folio_list)) {
> > +             /* Send list for bulk vmemmap optimization processing */
> > +             hugetlb_vmemmap_optimize_folios(h, &folio_list);
> > +
> > +             list_for_each_entry_safe(folio, tmp_f, &folio_list, lru) =
{
> > +                     free_huge_folio(folio); /* free it into the hugep=
age allocator */
> > +             }
> > +     }
>
> We could use prep_and_add_allocated_folios here.
>
> Thanks.
>
> > +
> >       if (i =3D=3D h->max_huge_pages_node[nid])
> >               return;
> >
> > --
> > 2.34.1
> >
>

