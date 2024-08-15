Return-Path: <linux-kernel+bounces-288418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D639539ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C7E2865EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6315B1FB;
	Thu, 15 Aug 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Tu/BGTI"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BD52F70
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746364; cv=none; b=I5MOUohBf0L0IGYq3b7fry6umDj9jgtUehQDNPCw5MzdYQY/xo4O7R6KsGYah2bpNSVVBzc3PzWh2v9KAHa/SuIeS+2KXN3usP7GtVegerJPCJr+P3lpWrSUrVCqzKi28nhSNgi/sg29Cm8MppIDiXpx/Gf2y9qT6r2GTe0xs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746364; c=relaxed/simple;
	bh=8cK1V49dfXrOsUh73tgTUq5mcn2CcmQ51yI8Sor4RoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgN6DOIrgOSV5exlihL1qJGN9JCUvBgU3E0qbdPWms4NSYOPNzJVftb38bWLGKEmt2J6pOWxmpweO1pEjSvrfezIKT5rBdUqhewpSdqrXxUcnS7WvHi393knQhdWUP8IF8Besw8f+LMTGhXdHfllMns01X4AtFLI5CR5APiQlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Tu/BGTI; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso398063e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723746362; x=1724351162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7lbG5NVksEtueYKnvc4KrlalQ7KzPWhZ4ML0LABPOo=;
        b=4Tu/BGTIpE0FzQmVDX4diHDUsQrc/aHP/c5p91WjUrouA8/hCa6hqqNEd+x5LTPfuE
         Ykcu7/wzvMjxEAWC1h6D/JR4YfwroTR4nkzRZG37J4xgMjCMj6k4NawGTy9GJWGLlcoH
         cMfXgdDKLUIvm5MfRoZ0ujMT3B2voQ+6OTQ/HMOGHKMgDY9pYE9EjXSVEwVSAeB+b8EW
         uO+4EOoBSFVZW3O6N58Bmr/B8tSPWXnKDPeWflgyWMR86DC8sBKT13hMtnh/JxU8Xl7u
         vsCem7O466A2PLzpcRBQMcJ+y6NHQXwsktQUUL6rB3N3pV0UE+RUjbv/iTekmNkZnv3A
         A51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746362; x=1724351162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7lbG5NVksEtueYKnvc4KrlalQ7KzPWhZ4ML0LABPOo=;
        b=PQK6Ac6+B3V3NfQ1dFUhS9J0fsWhc9pAZdHR//984/+izUcuL6Zs128YcSMzls9p1f
         goSeQCYbGtelbR/WI4rHiJgwcEtaSDJAv7RRWTyRcDI0R3SwfMZxBEHXuFLkwJgdXdzc
         qTZYz9B33b9aNXfYVpld7JkvE0lumR6dQNbOAbtwdRaZ9mmbkhKHK4N8cyce5it6edxt
         2GVb+2DUGwZfyShjUfmnczpwQpywB7lTmpsW9C/OuA04M2jF+XQgh4u/Tna3j8IKHYIo
         P591G8q/S1urAD67IXl5h4HBppM31sSy9ZV2YdSwB5zHNDRsnKzy/rJbwDmDxiBTCj6E
         BC9A==
X-Forwarded-Encrypted: i=1; AJvYcCWi/Njp0vo9wcHRYGcI/hH1G/3vXnnoE6z53g/Kw0vHplwNPXZlpxp00KbMIX3j65XQ4q+iAR1N0Kn4nO+SQauEdPdejjLgIr00jsPV
X-Gm-Message-State: AOJu0YxkZpEh+qOBIJ2VsyrUG/+7825KLT5OqxzAAsXyOWUw+DmtueY+
	VDHep87vxE9ok+bjjjJ+pVxeNKfsI/Io++qeURnmnNKd4UsggAbceyy2u1wJ1T55/3CTU9axJ3t
	YiorMBnmdqjCO2k5pMsfq08SB/U5ktuGr8hnc
X-Google-Smtp-Source: AGHT+IH0WYOuSf4YxanFIc7yEBAh2vgDOsthihfp45gSExACZ+n/Z4Pm6FXpigqMNFgeAvtSza7H1e1ANtpwjjXofag=
X-Received: by 2002:a05:6122:1348:b0:4df:1a3f:2ec1 with SMTP id
 71dfb90a1353d-4fc6c5a41aemr859131e0c.1.1723746361775; Thu, 15 Aug 2024
 11:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811212129.3074314-1-yuzhao@google.com> <20240811212129.3074314-3-yuzhao@google.com>
 <6d19d790-92d2-40f9-9797-cc08bf3921fe@huawei.com> <CAOUHufbJ3jXUp3-w5jfiRrf37vZxon+VyVdPP+6Y07vgxCwkQA@mail.gmail.com>
In-Reply-To: <CAOUHufbJ3jXUp3-w5jfiRrf37vZxon+VyVdPP+6Y07vgxCwkQA@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 15 Aug 2024 12:25:25 -0600
Message-ID: <CAOUHufZ==+ETxNW5qwbTeEbSgOic7WA-JgqPPGTngeKNY-RKDA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 2/3] mm/cma: add cma_alloc_folio()
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:04=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Aug 15, 2024 at 8:41=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huaw=
ei.com> wrote:
> >
> >
> >
> > On 2024/8/12 5:21, Yu Zhao wrote:
> > > With alloc_contig_range() and free_contig_range() supporting large
> > > folios, CMA can allocate and free large folios too, by
> > > cma_alloc_folio() and cma_release().
> > >
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > ---
> > >   include/linux/cma.h |  1 +
> > >   mm/cma.c            | 47 ++++++++++++++++++++++++++++++------------=
---
> > >   2 files changed, 33 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > > index 9db877506ea8..086553fbda73 100644
> > > --- a/include/linux/cma.h
> > > +++ b/include/linux/cma.h
> > > @@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, =
phys_addr_t size,
> > >                                       struct cma **res_cma);
> > >   extern struct page *cma_alloc(struct cma *cma, unsigned long count,=
 unsigned int align,
> > >                             bool no_warn);
> > > +extern struct folio *cma_alloc_folio(struct cma *cma, int order, gfp=
_t gfp);
> > >   extern bool cma_pages_valid(struct cma *cma, const struct page *pag=
es, unsigned long count);
> > >   extern bool cma_release(struct cma *cma, const struct page *pages, =
unsigned long count);
> > >
> > > diff --git a/mm/cma.c b/mm/cma.c
> > > index 95d6950e177b..46feb06db8e7 100644
> > > --- a/mm/cma.c
> > > +++ b/mm/cma.c
> > > @@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma=
)
> > >       spin_unlock_irq(&cma->lock);
> > >   }
> > >
> > > -/**
> > > - * cma_alloc() - allocate pages from contiguous area
> > > - * @cma:   Contiguous memory region for which the allocation is perf=
ormed.
> > > - * @count: Requested number of pages.
> > > - * @align: Requested alignment of pages (in PAGE_SIZE order).
> > > - * @no_warn: Avoid printing message about failed allocation
> > > - *
> > > - * This function allocates part of contiguous memory on specific
> > > - * contiguous memory area.
> > > - */
> > > -struct page *cma_alloc(struct cma *cma, unsigned long count,
> > > -                    unsigned int align, bool no_warn)
> > > +static struct page *__cma_alloc(struct cma *cma, unsigned long count=
,
> > > +                             unsigned int align, gfp_t gfp)
> > >   {
> > >       unsigned long mask, offset;
> > >       unsigned long pfn =3D -1;
> > > @@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned =
long count,
> > >
> > >               pfn =3D cma->base_pfn + (bitmap_no << cma->order_per_bi=
t);
> > >               mutex_lock(&cma_mutex);
> > > -             ret =3D alloc_contig_range(pfn, pfn + count, MIGRATE_CM=
A,
> > > -                                  GFP_KERNEL | (no_warn ? __GFP_NOWA=
RN : 0));
> > > +             ret =3D alloc_contig_range(pfn, pfn + count, MIGRATE_CM=
A, gfp);
> > >               mutex_unlock(&cma_mutex);
> > >               if (ret =3D=3D 0) {
> > >                       page =3D pfn_to_page(pfn);
> > > @@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned =
long count,
> > >                       page_kasan_tag_reset(nth_page(page, i));
> > >       }
> > >
> > > -     if (ret && !no_warn) {
> > > +     if (ret && !(gfp & __GFP_NOWARN)) {
> > >               pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu=
 pages, ret: %d\n",
> > >                                  __func__, cma->name, count, ret);
> > >               cma_debug_show_areas(cma);
> > > @@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned=
 long count,
> > >       return page;
> > >   }
> > >
> > > +/**
> > > + * cma_alloc() - allocate pages from contiguous area
> > > + * @cma:   Contiguous memory region for which the allocation is perf=
ormed.
> > > + * @count: Requested number of pages.
> > > + * @align: Requested alignment of pages (in PAGE_SIZE order).
> > > + * @no_warn: Avoid printing message about failed allocation
> > > + *
> > > + * This function allocates part of contiguous memory on specific
> > > + * contiguous memory area.
> > > + */
> > > +struct page *cma_alloc(struct cma *cma, unsigned long count,
> > > +                    unsigned int align, bool no_warn)
> > > +{
> > > +     return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? _=
_GFP_NOWARN : 0));
> > > +}
> > > +
> > > +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
> > > +{
> > > +     struct page *page;
> > > +
> > > +     if (WARN_ON(order && !(gfp | __GFP_COMP)))
> > > +             return NULL;
> > > +
> > > +     page =3D __cma_alloc(cma, 1 << order, order, gfp);
> > > +
> > > +     return page ? page_folio(page) : NULL;
> >
> > We don't set large_rmappable for cma alloc folio, which is not consiste=
nt
> > with  other folio allocation, eg  folio_alloc/folio_alloc_mpol(),
> > there is no issue for HugeTLB folio, and for HugeTLB folio must without
> > large_rmappable, but once we use it for mTHP/THP, it need some extra
> > handle, maybe we set large_rmappable here, and clear it in
> > init_new_hugetlb_folio()?
>
> I want to hear what Matthew thinks about this.
>
> My opinion is that we don't want to couple largely rmappable (or
> deferred splittable) with __GFP_COMP, and for that matter, with large
> folios, because the former are specific to THPs whereas the latter can
> potentially work for most types of high order allocations.
>
> Again, IMO, if we want to seriously answer the question of
>   Can we get rid of non-compound multi-page allocations? [1]
> then we should start planning on decouple large rmappable from the
> generic folio allocation API.
>
> [1] https://lpc.events/event/18/sessions/184/#20240920

Also along the similar lines, Usama is trying to add
PG_partially_mapped [1], which I have explicitly asked him not to
introduce that flag to hugeTLB, unless there are good reasons (none
ATM).

[1] https://lore.kernel.org/CAOUHufbmgwZwzUuHVvEDMqPGcsxE2hEreRZ4PhK5yz27Gd=
K-Tw@mail.gmail.com/

