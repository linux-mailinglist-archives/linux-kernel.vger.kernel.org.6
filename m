Return-Path: <linux-kernel+bounces-288392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D97795399D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7F1F25360
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA83BBC1;
	Thu, 15 Aug 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKHm6Quw"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4452F70
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745104; cv=none; b=Q1SGvzZ+MmTRpDBplr3Kdyyvcb3Pxb1Me7BvHKAq1LEcmxZ+5VWY8BfLLf3ce1IcXQRpkWwrmv2blrN/8tdFpwZQGENrDfITXtSEwZXxIQHcU9PmkG1VQ6Qc9c4Q4nfAGNqqESLnWkMwv3DwENVibvM7N2D6krGvNzji8MUycD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745104; c=relaxed/simple;
	bh=HJx7oz1jnO0XyM46EterX/qcrdtKXVTGAsOwbuIpgnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArjDKF79zIqN+DWIWgAXlJ4t454TzhOn0jCHEttf9HMk6GPXRWBE9QRUz8ISHHbcI3d6IP7+e8V5+v7JVA0YDiCKRoyniWP7vhgN/dfhTEaVOxOaUFrvvuch9zUuPheEMfISyBN2pZrSgp5E/Tq9U7Nua5nla1iwfobsqYKJwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKHm6Quw; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-842fe6f6c04so221400241.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723745102; x=1724349902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5Us/X2wfBtenEMzSp227D6K2gQmF1SnwKG1OtyaOow=;
        b=SKHm6Quwr77O36nszYqwat1jkFvfKScB29qEoPTKIGe90zG1+oTL0vCLeRMvoyCrPp
         W9LvBYZNIEDNmv0FYg3vNQiJVXsnKFYmy5V4Eq9iAo29u2DMH9Hfr53kEFSTQGSynRDY
         nigsfZoFfWnV9DfAhLgch71YaNZLSIqN07qSS3R9VdZaRyxrABS9LvDHJSQJJsOyPHCG
         Rc8MQLluXpryfYK24D3n4xAbS+HJRGSiaSEMd7IHBmmkn3suOkhyIys/QlFnC+P7TFA1
         wEREbRoiuTkfo/0g5sM9+dKqA0SRCR4pD5T6NfrKVl9xxwx7ZGEBwlVjKNz8j6yMXUYc
         Ehbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745102; x=1724349902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5Us/X2wfBtenEMzSp227D6K2gQmF1SnwKG1OtyaOow=;
        b=vYeZ6Ua17xsjVP5mhHqRDlmEVnwoG+z4zH7K8ybmisO5xO00SDezQH+rSdMaKAtBDW
         Fyw4sIQLmUdgf4ChXijvCGoznVGy88FElE+Px15rXsHWq3m7WdXcRjTWKaYzRftYxEVR
         p+1oHv7P0n6Btz6NfZGLds9SzSqcgu8nSrqOsEC+EdVwSqExeOtsWW2MP+EkcMpoRsxR
         rug39iCIV4Bc0Zngvpd8O228uqav1YPuImTa3670P+MXLnK69YZdsLsVlt8mcGEZf646
         gASNW+79Rq/jK3PS6QGLGkVUwjqbANj0tD3LKHg4pYOL3oyOHMA3Hd2tCiPuKEFwCq6D
         clSg==
X-Forwarded-Encrypted: i=1; AJvYcCUzBZN7QZUsf2htgQofMT0j3xrtN9ACKVmwahfmnS+Asz4JPiLbyz6gZ8EhS42/2l+eks5h929fGHSso4bQ5SyPnw3NngPmUGU20CG6
X-Gm-Message-State: AOJu0YzlWlxaRgYsiKEJ7O42f0RqIGX22IQctcP6XsNlmORnZDlE46On
	AljKOoH0PkpF/7fp6L64rp8C4KslFS4RyuWWkKBKbFRmO6llrD5UslLtF+ZHb11cUqEMeOD+8Py
	BTLL5dKxudSDlnIA9RUgfnRy4JUWybDu4zU4t
X-Google-Smtp-Source: AGHT+IEpY1C8Xn02YoSSkv/8rKqTGWB40QjknSmPTnz1yERD6wKxUFKF8bdDsGxfyEBrkMXojDAVqMjxJ/gh3kXVtS0=
X-Received: by 2002:a05:6102:419e:b0:493:b006:e1a with SMTP id
 ada2fe7eead31-497798b92eemr810832137.7.1723745101741; Thu, 15 Aug 2024
 11:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811212129.3074314-1-yuzhao@google.com> <20240811212129.3074314-3-yuzhao@google.com>
 <6d19d790-92d2-40f9-9797-cc08bf3921fe@huawei.com>
In-Reply-To: <6d19d790-92d2-40f9-9797-cc08bf3921fe@huawei.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 15 Aug 2024 12:04:23 -0600
Message-ID: <CAOUHufbJ3jXUp3-w5jfiRrf37vZxon+VyVdPP+6Y07vgxCwkQA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 2/3] mm/cma: add cma_alloc_folio()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:41=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
>
>
> On 2024/8/12 5:21, Yu Zhao wrote:
> > With alloc_contig_range() and free_contig_range() supporting large
> > folios, CMA can allocate and free large folios too, by
> > cma_alloc_folio() and cma_release().
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >   include/linux/cma.h |  1 +
> >   mm/cma.c            | 47 ++++++++++++++++++++++++++++++--------------=
-
> >   2 files changed, 33 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 9db877506ea8..086553fbda73 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, ph=
ys_addr_t size,
> >                                       struct cma **res_cma);
> >   extern struct page *cma_alloc(struct cma *cma, unsigned long count, u=
nsigned int align,
> >                             bool no_warn);
> > +extern struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t=
 gfp);
> >   extern bool cma_pages_valid(struct cma *cma, const struct page *pages=
, unsigned long count);
> >   extern bool cma_release(struct cma *cma, const struct page *pages, un=
signed long count);
> >
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 95d6950e177b..46feb06db8e7 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma)
> >       spin_unlock_irq(&cma->lock);
> >   }
> >
> > -/**
> > - * cma_alloc() - allocate pages from contiguous area
> > - * @cma:   Contiguous memory region for which the allocation is perfor=
med.
> > - * @count: Requested number of pages.
> > - * @align: Requested alignment of pages (in PAGE_SIZE order).
> > - * @no_warn: Avoid printing message about failed allocation
> > - *
> > - * This function allocates part of contiguous memory on specific
> > - * contiguous memory area.
> > - */
> > -struct page *cma_alloc(struct cma *cma, unsigned long count,
> > -                    unsigned int align, bool no_warn)
> > +static struct page *__cma_alloc(struct cma *cma, unsigned long count,
> > +                             unsigned int align, gfp_t gfp)
> >   {
> >       unsigned long mask, offset;
> >       unsigned long pfn =3D -1;
> > @@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned lo=
ng count,
> >
> >               pfn =3D cma->base_pfn + (bitmap_no << cma->order_per_bit)=
;
> >               mutex_lock(&cma_mutex);
> > -             ret =3D alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> > -                                  GFP_KERNEL | (no_warn ? __GFP_NOWARN=
 : 0));
> > +             ret =3D alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,=
 gfp);
> >               mutex_unlock(&cma_mutex);
> >               if (ret =3D=3D 0) {
> >                       page =3D pfn_to_page(pfn);
> > @@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned lo=
ng count,
> >                       page_kasan_tag_reset(nth_page(page, i));
> >       }
> >
> > -     if (ret && !no_warn) {
> > +     if (ret && !(gfp & __GFP_NOWARN)) {
> >               pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu p=
ages, ret: %d\n",
> >                                  __func__, cma->name, count, ret);
> >               cma_debug_show_areas(cma);
> > @@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned l=
ong count,
> >       return page;
> >   }
> >
> > +/**
> > + * cma_alloc() - allocate pages from contiguous area
> > + * @cma:   Contiguous memory region for which the allocation is perfor=
med.
> > + * @count: Requested number of pages.
> > + * @align: Requested alignment of pages (in PAGE_SIZE order).
> > + * @no_warn: Avoid printing message about failed allocation
> > + *
> > + * This function allocates part of contiguous memory on specific
> > + * contiguous memory area.
> > + */
> > +struct page *cma_alloc(struct cma *cma, unsigned long count,
> > +                    unsigned int align, bool no_warn)
> > +{
> > +     return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __G=
FP_NOWARN : 0));
> > +}
> > +
> > +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> > +{
> > +     struct page *page;
> > +
> > +     if (WARN_ON(order && !(gfp | __GFP_COMP)))
> > +             return NULL;
> > +
> > +     page =3D __cma_alloc(cma, 1 << order, order, gfp);
> > +
> > +     return page ? page_folio(page) : NULL;
>
> We don't set large_rmappable for cma alloc folio, which is not consistent
> with  other folio allocation, eg  folio_alloc/folio_alloc_mpol(),
> there is no issue for HugeTLB folio, and for HugeTLB folio must without
> large_rmappable, but once we use it for mTHP/THP, it need some extra
> handle, maybe we set large_rmappable here, and clear it in
> init_new_hugetlb_folio()?

I want to hear what Matthew thinks about this.

My opinion is that we don't want to couple largely rmappable (or
deferred splittable) with __GFP_COMP, and for that matter, with large
folios, because the former are specific to THPs whereas the latter can
potentially work for most types of high order allocations.

Again, IMO, if we want to seriously answer the question of
  Can we get rid of non-compound multi-page allocations? [1]
then we should start planning on decouple large rmappable from the
generic folio allocation API.

[1] https://lpc.events/event/18/sessions/184/#20240920

