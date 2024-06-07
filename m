Return-Path: <linux-kernel+bounces-206755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A7F900D5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7821C21414
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B61552EB;
	Fri,  7 Jun 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFbKTBnQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85CD2D600
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794847; cv=none; b=RYiuXYuU27e30fRZGEVAZXeR6O/zwVwjIg50nXHWJm5kIqkU/ozCwGjhSwsW26fwI/luIch1L8EnnmQxXJqlzrGch8cZg8itBCNr/mZ1lhItF6UmT3kWbF0EEtv5XJMij8WasSNHvVPfdRwzXGdWPI1/7Sp/urXWIycWUnXuECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794847; c=relaxed/simple;
	bh=+F1gR/dF9qEEeQEG7p+hJ6wJAsGgF2g2/pyS9AE0bOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gghiZDI5Zp23TzDnHAI1ZpYb+svdCKCvFxYCeALNlIYDzIkC+3nop8dZRkqblXi9qRWsSIhipBJkRJApBLuc2T3MG4yz+ywGGwVxgLGtnXMNUxYR0zwsKuqZ+ZYm4krzyXcJY+OPhXGCaHpRQMbBr+c1YQhE+LcZ5S25bUN0+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFbKTBnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4821AC32781
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717794847;
	bh=+F1gR/dF9qEEeQEG7p+hJ6wJAsGgF2g2/pyS9AE0bOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rFbKTBnQOqZ1IL0pKtYSkXZfZRC7/3LMGtJtC2ljhd8mslHEuwYpCmMtIkRD03pEc
	 op5rZlVeAGRQnAtvwTM0GEZFCXEKfiHEGuAd9UFZAYsJ/CwGCnu3xUY8PdrbIg7t95
	 h4GQu30T4bpPKaBFzi5Ne5QHw/5cmkj4pVamGiEeJo3OuyDVJJ7mudoX2i4XhAz9Oe
	 K2oC5JhgXSipPglBGlvTYGDQE9sCxmcLyleIwvv3ehP4VMgyhYgUH4L7LcbtQicutk
	 XSlBXMV5YFUHXP97nj1auiVSOJ72e8Byl821lgJymc+Z3XAEcmeVn/eiVeKNKONSj4
	 puFQE4R2yc7Bg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eabd22d441so40310251fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbkdoq05WfMNiyo/H/P6rRoLmrP/us6d08gkpaQ7oaZn5czNecyXhF/iLHH3tO0sjcDQ4zfrxCb/tXaIy6tLRbqgw9VU4HrWnX1deI
X-Gm-Message-State: AOJu0YzklM6u6Rd16qR4xWuGRbucioDVwtE7cEkx1KdC1BMPo6OcVJML
	JLOQE9/qVGkUe2h8I6o9KCCwn9ouFenmWG/APEpHg7fQIcGeREqEPX1fnUnLZMF6gun7f4vwEn+
	X13mmqniESb9XmHqNCkZQ8mz8UA==
X-Google-Smtp-Source: AGHT+IHHbwv2ef+TwD1olLISbgN32rX4SJw+PxqN0i4K6h3fv6l1Rz9SwNIbpusaKtmI6pg1LWA/DtkMtXIdngK0iZw=
X-Received: by 2002:a2e:3612:0:b0:2eb:17fe:a144 with SMTP id
 38308e7fff4ca-2eb17fea1c5mr7866711fa.34.1717794845911; Fri, 07 Jun 2024
 14:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
 <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com> <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
 <424c6430-e40d-4a60-8297-438fc33056c9@redhat.com> <CAJD7tkbaX-8OQm0JispxWWbuzX+PJrH=HN6yqEjqL2yxRcu=Aw@mail.gmail.com>
In-Reply-To: <CAJD7tkbaX-8OQm0JispxWWbuzX+PJrH=HN6yqEjqL2yxRcu=Aw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 7 Jun 2024 14:13:54 -0700
X-Gmail-Original-Message-ID: <CANeU7QkrXyv8f4JE+iUte2iTUg-dP_Q1==g2JwMjS4TEyiLovA@mail.gmail.com>
Message-ID: <CANeU7QkrXyv8f4JE+iUte2iTUg-dP_Q1==g2JwMjS4TEyiLovA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:58=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Jun 7, 2024 at 11:52=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > >> I have no strong opinion on this one, but likely a VM_WARN_ON would =
also
> > >> be sufficient to find such issues early during testing. No need to c=
rash
> > >> the machine.
> > >
> > > I thought VM_BUG_ON() was less frowned-upon than BUG_ON(), but after
> > > some digging I found your patches to checkpatch and Linus clearly
> > > stating that it isn't.
> >
> > :) yes.
> >
> > VM_BUG_ON is not particularly helpful IMHO. If you want something to be
> > found early during testing, VM_WARN_ON is good enough.
> >
> > Ever since Fedora stopped enabling CONFIG_DEBUG_VM, VM_* friends are
> > primarily reported during early/development testing only. But maybe som=
e
> > distro out there still sets it.
> >
> > >
> > > How about something like the following (untested), it is the minimal
> > > recovery we can do but should work for a lot of cases, and does
> > > nothing beyond a warning if we can swapin the large folio from disk:
> > >
> > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > --- a/mm/page_io.c
> > > +++ b/mm/page_io.c
> > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct
> > > swap_iocb **plug)
> > >          delayacct_swapin_start();
> > >
> > >          if (zswap_load(folio)) {
> > > -               folio_mark_uptodate(folio);
> > >                  folio_unlock(folio);
> > >          } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > >                  swap_read_folio_fs(folio, plug);
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 6007252429bb2..cc04db6bb217e 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1557,6 +1557,22 @@ bool zswap_load(struct folio *folio)
> > >
> > >          VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > >
> > > +       /*
> > > +        * Large folios should not be swapped in while zswap is being=
 used, as
> > > +        * they are not properly handled.
> > > +        *
> > > +        * If any of the subpages are in zswap, reading from disk wou=
ld result
> > > +        * in data corruption, so return true without marking the fol=
io uptodate
> > > +        * so that an IO error is emitted (e.g. do_swap_page() will s=
igfault).
> > > +        *
> > > +        * Otherwise, return false and read the folio from disk.
> > > +        */
> > > +       if (WARN_ON_ONCE(folio_test_large(folio))) {
> > > +               if (xa_find(tree, &offset, offset +
> > > folio_nr_pages(folio) - 1, 0))
> > > +                       return true;
> > > +               return false;
> > > +       }
> > > +
> > >          /*
> > >           * When reading into the swapcache, invalidate our entry. Th=
e
> > >           * swapcache can be the authoritative owner of the page and
> > > @@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
> > >                  zswap_entry_free(entry);
> > >                  folio_mark_dirty(folio);
> > >          }
> > > -
> > > +       folio_mark_uptodate(folio);
> > >          return true;
> > >   }
> > >
> > > One problem is that even if zswap was never enabled, the warning will
> > > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
> > > static key if zswap was "ever" enabled.
> >
> > We should use WARN_ON_ONCE() only for things that cannot happen. So if
> > there are cases where this could be triggered today, it would be
> > problematic -- especially if it can be triggered from unprivileged user
> > space. But if we're concerned of other code messing up our invariant in
> > the future (e.g., enabling large folios without taking proper care abou=
t
> > zswap etc), we're good to add it.
>
> Right now I can't see any paths allocating large folios for swapin, so
> I think it cannot happen. Once someone tries adding it, the warning
> will fire if CONFIG_ZSWAP is used, even if zswap is disabled.
> At this point we will have several options:

Here is my take on this:

> - Make large folios swapin depend on !CONFIG_ZSWAP for now.

I think a WARON or BUG_ON is better. I would need to revert this
change when I am working on 3).  It is a make up rule, not a real
dependency any way.

> - Keep track if zswap was ever enabled and make the warning
> conditional on it. We should also always fallback to order-0 if zswap
> was ever enabled.

IMHO, falling back to order-0 inside zswap is not desired because it
complicates the zswap code. We should not pass large folio to zswap if
zswap is not ready to handle large folio. The core swap already has
the fall back to order-0. If we get to 3), then this fall back in
zswap needs to be removed. It is a transitional thing then maybe not
introduce it in the first place.

> - Properly handle large folio swapin with zswap.
That obviously is ideal.

Chris

