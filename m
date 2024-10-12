Return-Path: <linux-kernel+bounces-362048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1499B04D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2769D1F23381
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695F83A09;
	Sat, 12 Oct 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmLDSrlQ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6D224D7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702306; cv=none; b=Z46BSQHxsSfyUj51wmoW94MeFN3NayxST9uvuxSLTesCCyxGOSU5L/0tuMd23MCoWqbA79tp8/O3Z3infTY+qRyQ7JXz7dNjWaS/YetYOnZmH8uAGT/jFfzII+xcjc6eE74ZUBagezDO9K1jVX+3P/y3nVzM4UcjfNnLwPj3Umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702306; c=relaxed/simple;
	bh=LjSJ27Fnf9o6v9CliVau+MP3vL0L6K1+XH40WQ2WW3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVxH/f2B0gjfSAhvsVknBlnmAUQt5R19/YjUGEHUyCSvRWHSmG4Q54XhQux0JtRBuPxeEtVVXY+/34QEPFIRdFnYVlPYe1kApXOf/2dm0K7VLTRiua5JcnDAwuMFN5Wwgv2caWf3jWWnwfWr1YIXqxPGpXgGJEfSUi09DYbY4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmLDSrlQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac60ab585so25123511fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728702303; x=1729307103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk7niJErJKzbUcQtEhxz674/baKisg6yPUx9MwQhy4k=;
        b=PmLDSrlQ1uGCHHs1NYUCMtb/ifaLpeqKFTB+05DMZ8+oVEBDAtFzwqM4uygLpgu0DO
         jl+CPxXO2n2SyqIVG3fwcelG1pmpib2lVwcUZWd6ICfyn/8FyJEu4Bpbsttd/EErNssi
         2u9/KaSNYG50wB4QNGogk2xtPYqmJlB69yHTglpYU11z6nNM04oVG8hsEgn+6bJPatWy
         eOfxeumFpRZAmhUzw8MYeouw2BHgG3Z08hyFRLuQexpKVYxo1fKFwHKFEchCnHM2Btfx
         7qYPz2a3cz6BojsMahNKPvTBH55TYPiSSDDnmXFAuo4cc8BSzpDDp7VyDRUJiZ9PPUMN
         l4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728702303; x=1729307103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk7niJErJKzbUcQtEhxz674/baKisg6yPUx9MwQhy4k=;
        b=KAobCdUF+bMpItDdKWpRTjzjg+hDzxC4whX5C9rdf6Q2nXFBN9JscLXujzDYPMEtSY
         Y1ItMvO+vXh9VWDFq68A++bcvhh/DvwW7ui3rbOUwQGX1qQVKC7rnf44moINPVT1UxTH
         clyo+DAm91tOuGeymbrbmlV1QlR6/bZQ5g2FF5tF+qbV//GGnmv+iEiMFwWpdGgcvuMy
         5mauKf7VzU2zSmi1xuXFG+t295T8vx7yOMYwkiLW98tO6N0G7DLBw5G09DcNAX7vEKIr
         XALU7iWfDeeKHiZa/GeYCkCKjVo0LfZQ8yWAZe+JhRr+Zn1ITcY4TN+KLJ3QcgmNwI5j
         S7bg==
X-Forwarded-Encrypted: i=1; AJvYcCWLctOS5UG8eaUER9U3Rh5Y2yLXT3Q9+J/1VMRBAtsszi0fJN2pi5iBU6zT5WXxRp/uqJXp0v9Wl5nnf3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsquqWz36MZtoHORkUHDqEBCLXVCzoMYUsShF+Pi2bYNAVeKV
	J90DKZoWgn14XFmpIQ9khFWOHKzHR9zu0UuekkUTet4Hg2tpCLF/iMl/sq+/fupMxmKd0DB7MQt
	ffPYrE0/8M0FHURe1qsH7kz9uZ2c=
X-Google-Smtp-Source: AGHT+IHb0uIxYZqPjnQEOFBOTrG3RPCAYkG2AeD3P42Mvi2wjTkPnF4IIU5TqywmJWU5rTF+qi7jHDqYe+R+8SnD2EI=
X-Received: by 2002:a2e:be2c:0:b0:2fa:cc50:41b with SMTP id
 38308e7fff4ca-2fb32704c72mr28492021fa.5.1728702302533; Fri, 11 Oct 2024
 20:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011171950.62684-1-ryncsn@gmail.com> <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
 <20241011182831.GC351101@cmpxchg.org>
In-Reply-To: <20241011182831.GC351101@cmpxchg.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 12 Oct 2024 11:04:45 +0800
Message-ID: <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary invalidation
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, "Huang, Ying" <ying.huang@intel.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johannes Weiner <hannes@cmpxchg.org> =E4=BA=8E 2024=E5=B9=B410=E6=9C=8812=
=E6=97=A5=E5=91=A8=E5=85=AD 02:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 11, 2024 at 10:53:31AM -0700, Yosry Ahmed wrote:
> > On Fri, Oct 11, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > zswap_invalidation simply calls xa_erase, which acquires the Xarray
> > > lock first, then does a look up. This has a higher overhead even if
> > > zswap is not used or the tree is empty.
> > >
> > > So instead, do a very lightweight xa_empty check first, if there is
> > > nothing to erase, don't touch the lock or the tree.
>
> Great idea!
>
> > XA_STATE(xas, ..);
> >
> > rcu_read_lock();
> > entry =3D xas_load(&xas);
> > if (entry) {
> >     xas_lock(&xas);
> >     WARN_ON_ONCE(xas_reload(&xas) !=3D entry);
> >     xas_store(&xas, NULL);
> >     xas_unlock(&xas);
> > }
> > rcu_read_unlock():
>
> This does the optimization more reliably, and I think we should go
> with this version.

Hi Yosry and Johannes,

This is a good idea. But xa_empty is just much lighweighter, it's just
a inlined ( =3D=3D NULL ) check, so unsurprising it has better performance
than xas_load.

And surprisingly it's faster than zswap_never_enabled. So I think it
could be doable to introduce something like zswap_may_have_swpentry as
Yosry suggested.

So how about a combined version with xas_load and xa_empty? Check
xa_empty first as a faster path, then xas_load, then xas_store.

Here is the benchmark result (time of swapin 2G zero pages in us):

Before:   1908944 1905870 1905322 1905627 1901667
xa_empty: 1835343 1827367 1828402 1831841 1832719
z.._enabled: 1838428 1831162 1838205 1837287 1840980
xas_load: 1874606 1878971 1870182 1875852 1873403
combined: 1845309 1832919 1831904 1836455 1842570

`combined` is xa_empty + xas_load.

