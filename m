Return-Path: <linux-kernel+bounces-199652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36778D8A62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CB81F22AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1913A244;
	Mon,  3 Jun 2024 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CelqETK7"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762E40877
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443541; cv=none; b=kwp8e3EEctK1Z1kDZi34aJ10i7/eqpxPQXNOfy6FQd+MHJI/impWsUrwA66iV/SOMKALD3XdqbovJ71JgmIAqY39eVp8+i9CCcmYPKxBt0gGkv+Nz9K1BZL6VEzEuKnS+37vQrK15VUFWTil3PeT3YRxE2GCftNMFNGqmkaV7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443541; c=relaxed/simple;
	bh=Vo3vFnuDp/3jbVXCcdqZvPOhcBUrDvsCcl2k481F8Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDi/ZSQfhW6vhEhyZKpfQim8I7vG6x5q+BKGzGHaqjZKGX6/dd2q4Gj8AzcyQXpCxmnD3vd/yGHFXW/W7rUw6elA3RJtwu4Qq1VgsCTDBr8PTDSrwGYLw5oZo87X1jcP2Ba+pWIGJ3j5ttJ7Io5lIcnAn3Bx0t1usqPlTkefqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CelqETK7; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa588f7283so4903633276.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717443539; x=1718048339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+0v3cS2L8imGiJtp7mry/9OeR09ftWj8BQpNQZKrk4=;
        b=CelqETK7B4qTOx2Ydmmx6h2zpxQ6Iq+9f5FEMPonCg1ptTVFvBS+DCb+gHx9HT38Nn
         77pNSpcLteTCtwPL2QsCAA6hMk89sD9ZWG2IxzwSxMyn7mVz0y27Zk2f6UY+/8gziopD
         HfOHCjxPZoCpU0UJ8Gi6MJsfKfR3e5C5QgdtirQaG3f2cdJQY3Da5Id27HbpnJMPJBa+
         hFMy0etqC7nMq+I4fhRKoTS5y6KRo6DwXREaZ/FHf9OuHuJN2OjXuskGR8OMDrcj0iwd
         FiWcnaehuT/SRPSZXYfo53XWr372EX09frWAbMEMQ24zMHBZd/W2t/OAy6WGNYNcUdOI
         /KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717443539; x=1718048339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+0v3cS2L8imGiJtp7mry/9OeR09ftWj8BQpNQZKrk4=;
        b=N2YauA7QYu6slfCDKSw2IOlhh5YYr6l8UNhxUv9ugzgXI/1Zt/Fju/CB+QtZao7QWg
         /EOxyjbjjfrZ6iJJVrSUzpZLiZjBQtoGoQ6UY4WaOSNAKpq2tC7JVIleMT25sucRYaOe
         SAOiU6RUIV0H08qs+M20QL4x0VOCkNOtpvC2dK+0Phozvzy/gLkDycGjAnaRj8ZPrwcP
         dR0s1KweTEyHljz48tIDf2xn+gimfmMeJhbBNLGtFRipWU6xELQj8o9ad4ob2Ni4g3D+
         bKq2/pmqRY9w5xRYwLVLHHLIDVyl+OszpIFxxS70SOUN7gb+zNWUoDn29ZHoVI4L9Gdf
         T3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWbzECOrBnR7X3pNjg2tb/qYhFppP6nY48UmFnhXCgKDyuRUduVLMg10jdIzlcWFDdjrz2WXJFnVRt/AP3cNKkPNMCJbU+mpIk/74IE
X-Gm-Message-State: AOJu0Yx32Gk4sM+Nod37cqWj7CxRRH87S+E3fiRYWRzdUaMF9nXkvi7K
	elsMdcrcFb5XGhjCRBgD7Hp59hFGEJcNNtP/9cqgydP/ew+SvWU7ffPsOm+h885PgEZsunHoJy0
	yrdksb4X7Rq60Ew6zS21VMC9NNAMYkA==
X-Google-Smtp-Source: AGHT+IGSqwrlreEwQ0oHR/E84e1KJnMxhzowFGzywMPgu+Ei8RVzerIQSHkRHGWS2LFaAghCSf3W1CG49D5wetXnjPU=
X-Received: by 2002:a25:270a:0:b0:df7:7091:989e with SMTP id
 3f1490d57ef6-dfa73dd2b17mr8942740276.60.1717443538993; Mon, 03 Jun 2024
 12:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520194749.334896-1-vishal.moola@gmail.com>
 <ZkvErLsj8Ngj4qM3@casper.infradead.org> <CAOzc2px9sWGUPbCM+pHuqt8eAUONrDcKnEybvM6k6ot2ftpmmg@mail.gmail.com>
In-Reply-To: <CAOzc2px9sWGUPbCM+pHuqt8eAUONrDcKnEybvM6k6ot2ftpmmg@mail.gmail.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Mon, 3 Jun 2024 12:38:47 -0700
Message-ID: <CAOzc2pzvWaqkHLCMfQ=oMggVSDU7+0do1+u0BndbS2ijVeEZ5A@mail.gmail.com>
Subject: Re: [PATCH] Convert __unmap_hugepage_range() to folios
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 2:13=E2=80=AFPM Vishal Moola <vishal.moola@gmail.co=
m> wrote:
>
> On Mon, May 20, 2024 at 2:46=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Mon, May 20, 2024 at 12:47:49PM -0700, Vishal Moola (Oracle) wrote:
> > > Replaces 4 calls to compound_head() with one. Also converts
> > > unmap_hugepage_range() and unmap_ref_private() to take in folios.
> >
> > This is great!
> >
> > >  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_s=
truct *vma,
> > >                           unsigned long start, unsigned long end,
> > > -                         struct page *ref_page, zap_flags_t zap_flag=
s)
> > > +                         struct folio *ref_folio, zap_flags_t zap_fl=
ags)
> > >  {
> > >       struct mm_struct *mm =3D vma->vm_mm;
> > >       unsigned long address;
> > >       pte_t *ptep;
> > >       pte_t pte;
> > >       spinlock_t *ptl;
> > > -     struct page *page;
> > > +     struct folio *folio;
> > >       struct hstate *h =3D hstate_vma(vma);
> > >       unsigned long sz =3D huge_page_size(h);
> >
> > I would appreciate some further cleanup ...
> >
> >         size_t sz =3D folio_size(folio);
> >
> > I think there are further cleanups along those lines, eg
> > pages_per_huge_page(), hugetlb_mask_last_page(), huge_page_mask().
> >
>
> Gotcha, I'll look into those and change them in v2.

I took a closer look at your suggestions for cleanups here. Most callers of
unmap_hugepage_range() pass NULL as ref_folio - meaning we want to unmap
all pages in the range. This means alot of the preparatory work is
likely done without
a reference to a folio, so using folio_size() is unsafe.

For when we later have a reference to a folio, I think we should
continue to use the
hstate-defined values since using the folio in one place and hstate in
another makes
things harder to change (if we ever want to).

