Return-Path: <linux-kernel+bounces-205092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1D8FF6F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FF1F22D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689C13A3E2;
	Thu,  6 Jun 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmxRO90M"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6E7173C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709879; cv=none; b=Psae9jsRIEsM82MxIEoH8/60MV8UW5d4RDSVJqw3UGeDYdYQJBoZ+1+1wxHDpYPKLox0yjKjA070TpuYUmUyngWDxBxHAES3Lkzg70qRa5gMLtqy3QlbTdyr7UlpEexv8j5CwZhVpPn/s1nDWxHUgFJA6ZSg4GKJP2dl/l7CVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709879; c=relaxed/simple;
	bh=IDu6IVkzEOV31c/IIDT9tjfCWXhhixoaE+lG5XLaTXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbxF7AWtyUeEFCs4L+qsBzxwfR9gn4u8uwAiIHpjFXGXpxS11jn+WpOShrY4Ipfz7sBHbmaxzkBXdU2XdGpvcx2924xn3S8cBk9qE/4KcvJ5kS7o5I9tJFuygUA6pECgaSkKwUT/NHnetr7V4R+CTOgSXuROzQqbCb5Q9igw3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmxRO90M; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68ee841138so187393066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717709876; x=1718314676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxVCgkdsWxZe9cdiBSCygSUxoUzaQUcqMVcfSn0jQS0=;
        b=vmxRO90MJTov+W0OjmmUCMvnoK24Zlimu+KsG3XAsDVdokRRTOWaHE4DvdTTd/a8jL
         +FwF/5/DR3VGyYE1OLKiUtJzqfcZ/H3oKtyxGgxflbnGiqlCi8vYNEENdJdO2v+xMWtt
         QFoLgTk6cFmGC6HFqGIOy2UaIaH23n/w74hjEKygRAiwx2U4g4JJ6a9Hkn+AMs8z04Sd
         sEuGYOtcfL9grQrM6FXXg13Y5hykV/mCctUKWJAFl5Vl8EQuhU11+alaDWafIJq/CGXU
         /cYC1VZxwyut3MUzx6LynSxAvrZU9YzNSMhpiqRnivMgBJJxJfx6zflNpXN1FGdqSceh
         yqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709876; x=1718314676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxVCgkdsWxZe9cdiBSCygSUxoUzaQUcqMVcfSn0jQS0=;
        b=M8x9XWt/0tMe0wKSSsiwvTPm/4SJmJ6cf7R5Av1QdbQMueXA+YKB2QOQEiQrda8tjj
         Ah6E7pZd0es/rNif2y5WzBfAfOAbC3iMXVsXYnxVczLb2dxdVC1o7WzPzcpG8v+Rmg7F
         Zt/S4aVOSfEmCMTGb8W0JojgHEbiALJ6OsHWzkfbVb0GYLUGqRUIqzWTm+4bfLC8vbYQ
         SSh9TTRx8E6mbUSES43i3OGagFdC02BZQBOAOXE7t14kj9COLW8MD9k4D3iIkx1d0usP
         RS67gIeXmNBz17u531dAGOSmWhv1Ea+kSVcFmTKWNa8Zl90Z2gfq2wBqDK2EsUuYdMlB
         Opeg==
X-Forwarded-Encrypted: i=1; AJvYcCW5RRfv6Iad8Cw1+o69uw2ZeOh+YoXb/bav6DXH9IxTVUbOH13IHyIMa3BbufN3G+xvyj+pbDlL48pppPHdCIEjClPthN93Tol2SbsL
X-Gm-Message-State: AOJu0YztouY6lJANuJaL7Ok3p6PUfjcrKbSxRYqwOFfbYckieTWOLcYP
	Zv5BxuzRhhSr07jZsYhd9m9tTkGZ8ojIk1OtXes77HEz/GDcYMkBGE3LV0X3WEwvklBwg74rXEO
	N8e2vKB53uyAN62N+CbsUhKIrJ9dkaxGsSmMZ
X-Google-Smtp-Source: AGHT+IFz21LxWp7vj7WlCkGN3SL4ptgwrC5kesIuuV/yxsfzNrANxMI5zU81PuX1StwHQU6dhfApOuiL5BX6T9jLKRY=
X-Received: by 2002:a17:906:f590:b0:a62:2b65:1dd5 with SMTP id
 a640c23a62f3a-a6cdaa0f67dmr73830066b.58.1717709875765; Thu, 06 Jun 2024
 14:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 14:37:19 -0700
Message-ID: <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Fri, Jun 7, 2024 at 9:17=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 06.06.24 22:31, Yosry Ahmed wrote:
> > > On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> > >>
> > >> On 06.06.24 20:48, Yosry Ahmed wrote:
> > >>> With ongoing work to support large folio swapin, it is important to=
 make
> > >>> sure we do not pass large folios to zswap_load() without implementi=
ng
> > >>> proper support.
> > >>>
> > >>> For example, if a swapin fault observes that contiguous PTEs are
> > >>> pointing to contiguous swap entries and tries to swap them in as a =
large
> > >>> folio, swap_read_folio() will pass in a large folio to zswap_load()=
, but
> > >>> zswap_load() will only effectively load the first page in the folio=
. If
> > >>> the first page is not in zswap, the folio will be read from disk, e=
ven
> > >>> though other pages may be in zswap.
> > >>>
> > >>> In both cases, this will lead to silent data corruption.
> > >>>
> > >>> Proper large folio swapin support needs to go into zswap before zsw=
ap
> > >>> can be enabled in a system that supports large folio swapin.
> > >>>
> > >>> Looking at callers of swap_read_folio(), it seems like they are eit=
her
> > >>> allocated from __read_swap_cache_async() or do_swap_page() in the
> > >>> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so =
we
> > >>> are fine for now.
> > >>>
> > >>> Add a VM_BUG_ON() in zswap_load() to make sure that we detect chang=
es in
> > >>> the order of those allocations without proper handling of zswap.
> > >>>
> > >>> Alternatively, swap_read_folio() (or its callers) can be updated to=
 have
> > >>> a fallback mechanism that splits large folios or reads subpages
> > >>> separately. Similar logic may be needed anyway in case part of a la=
rge
> > >>> folio is already in the swapcache and the rest of it is swapped out=
.
> > >>>
> > >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >>> ---
> > >>>
> > >>> Sorry for the long CC list, I just found myself repeatedly looking =
at
> > >>> new series that add swap support for mTHPs / large folios, making s=
ure
> > >>> they do not break with zswap or make incorrect assumptions. This de=
bug
> > >>> check should give us some peace of mind. Hopefully this patch will =
also
> > >>> raise awareness among people who are working on this.
> > >>>
> > >>> ---
> > >>>    mm/zswap.c | 3 +++
> > >>>    1 file changed, 3 insertions(+)
> > >>>
> > >>> diff --git a/mm/zswap.c b/mm/zswap.c
> > >>> index b9b35ef86d9be..6007252429bb2 100644
> > >>> --- a/mm/zswap.c
> > >>> +++ b/mm/zswap.c
> > >>> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> > >>>        if (!entry)
> > >>>                return false;
> > >>>
> > >>> +     /* Zswap loads do not handle large folio swapins correctly ye=
t */
> > >>> +     VM_BUG_ON(folio_test_large(folio));
> > >>> +
> > >>
> > >> There is no way we could have a WARN_ON_ONCE() and recover, right?
> > >
> > > Not without making more fundamental changes to the surrounding swap
> > > code. Currently zswap_load() returns either true (folio was loaded
> > > from zswap) or false (folio is not in zswap).
> > >
> > > To handle this correctly zswap_load() would need to tell
> > > swap_read_folio() which subpages are in zswap and have been loaded,
> > > and then swap_read_folio() would need to read the remaining subpages
> > > from disk. This of course assumes that the caller of swap_read_folio(=
)
> > > made sure that the entire folio is swapped out and protected against
> > > races with other swapins.
> > >
> > > Also, because swap_read_folio() cannot split the folio itself, other
> > > swap_read_folio_*() functions that are called from it should be
> > > updated to handle swapping in tail subpages, which may be questionabl=
e
> > > in its own right.
> > >
> > > An alternative would be that zswap_load() (or a separate interface)
> > > could tell swap_read_folio() that the folio is partially in zswap,
> > > then we can just bail and tell the caller that it cannot read the
> > > large folio and that it should be split.
> > >
> > > There may be other options as well, but the bottom line is that it is
> > > possible, but probably not something that we want to do right now.
> > >
> > > A stronger protection method would be to introduce a config option or
> > > boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> > > depend on it being disabled, or have zswap check it at boot and refus=
e
> > > to be enabled if it is on.
> >
> > Right, sounds like the VM_BUG_ON() really is not that easily avoidable.
> >
> > I was wondering, if we could WARN_ON_ONCE and make the swap code detect
> > this like a read-error from disk.
> >
> > I think do_swap_page() detects that by checking if the folio is not
> > uptodate:
> >
> > if (unlikely(!folio_test_uptodate(folio))) {
> >         ret =3D VM_FAULT_SIGBUS;
> >         goto out_nomap;
> > }
> >
> > So maybe WARN_ON_ONCE() + triggering that might be a bit nicer to the
> > system (but the app would crash either way, there is no way around it).
> >
>
> I'd rather fallback to small folios swapin instead crashing apps till we =
fix
> the large folio swapin in zswap :-)

I think David is referring to catching the buggy cases that do not
properly fallback to small folios with zswap, not as an alternative to
the fallback. This is at least what I had in mind with the patch.

