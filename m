Return-Path: <linux-kernel+bounces-206638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B57900C30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7951F232D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B2143756;
	Fri,  7 Jun 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTI0Qjvj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6745000
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786731; cv=none; b=WuSVCG994ER1TCDI91iSDH2frPDgn0HI9WZv/YxDJAv3vqmQosGJ/EIOUk4qGPG422tcIKHitdu1Z4gqpJIGVYdrbstOT4DMAdp1zCyv65lUFI/T/vOX78lFiOWFrDs9tzaMa2CLD2BR47qm0InXs1LW2Z0G2ub6yuJ2LDXNQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786731; c=relaxed/simple;
	bh=kEkwg0KGAyh0gS2F9orpriCED+dLBSHYLOGTsVU9XPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE4U0QOmrG7QJu4YLoeMFoTJSvV5zNG/w6dd0/A3Y7hqejPSlJxl6VNDQlfzVNSUsoWSpNSTHiutzMiuNRXI64TwD/T/XcX3obcqB04eohH4BCMnP910gNUaGIvYcywog1wbZGjcYNP6WSZYMfwAnU1DrS5iZCVz97qDJiYSnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTI0Qjvj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaaa6so369141266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717786728; x=1718391528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2r17fv1NH+dhrx4S8f8edNGHFWcnHzqCYgrcf7L5As=;
        b=GTI0QjvjQzHB0Ot36ln+99onxWA3nC+6S84mtLTmQKR9VEnXSuY4Rv+xjQAhGMq6dY
         Hg+mkT5GB5B6KYMLLROftLaEix9MUbiq1ng69/8oG08SP8sH8gwKSi4DHVoEU7OYnJdj
         xelhAW8bjubQJ3LiCuKLY1PTXqD7H3Kly8lhRb3LnQgV9MEcZXPTiT7HUq44nizXgTp4
         Q7L23/VLqZadonKkOuH0gxwcBPBvByZcHMhb/9jRBFv3XxRK1Jwf/P10yFotnMZmqLzm
         Z4NUjYSdy/rdmP9Rcl0/uoXdRbUFfN4XVdLXv+i7ZW8LGqLUGMPGcrhkUgAOCuzmiQTf
         bNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717786728; x=1718391528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2r17fv1NH+dhrx4S8f8edNGHFWcnHzqCYgrcf7L5As=;
        b=BMX7m22snCTtMNvE9s1h3btibnYqTn68DWy7Psu6nuH+Ta1+yl2jybiMiBx4iKM14D
         r0bEiVL1jErHJzOYOjYDphqbe6LkTEBskVIioxd19yHBM5YeERivQZ4eR5Vu1E725Wvv
         6hfZw9drOkxoWh5JiTsGKshIlW9CQgyR6ip0zA4h7OxKnhohlvCLSrYMbcMWfCGXmK74
         xwDHeeiLGLk/KrVG2gD1EkAn2WBKBSDq9csb23hGFYFvOnoy72lUOr4Ax84e0pr1P4fd
         0S+qc4a+71sIpC6hLicPu7C/kHQtIbYJ1s2G7I38Jz+GRiCsEL45VV10sf2mtj9E5ri6
         C/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOwMKfH31sNr+04ytUwGmgaamy91uCTdI7YL4PtAhTGTwKS2D0wdg/1x+o1Qwx5ZMIGqCFKNU86agqEGwgOFyYqBdy1y0NUblCERE5
X-Gm-Message-State: AOJu0Yy+7J6MyDZZTZiBxVPYAH0yU9sSDBczGNtiE/4LC06jDSlwOOLw
	zx9YExAwVCxX2P4Lh91zekgCDhniYRzMwpv8U4Bp8lOdhSxbWL8Ypvt9rXE4rORXSfWjBSWu738
	PXSuWETo96lSk7B6vBAG3YoJpCV0W/TfW4iS2
X-Google-Smtp-Source: AGHT+IE3dUM3t2Ff2JFikj4TrNJdz/uC/CYKzj23GqNW4FtILLLjxMVHow3ICl2yIJu8TAutvqVQAV5kWGVgkDmgoBM=
X-Received: by 2002:a17:906:368d:b0:a68:a52b:7554 with SMTP id
 a640c23a62f3a-a6cdbef76a3mr221167966b.66.1717786727342; Fri, 07 Jun 2024
 11:58:47 -0700 (PDT)
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
 <424c6430-e40d-4a60-8297-438fc33056c9@redhat.com>
In-Reply-To: <424c6430-e40d-4a60-8297-438fc33056c9@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 11:58:08 -0700
Message-ID: <CAJD7tkbaX-8OQm0JispxWWbuzX+PJrH=HN6yqEjqL2yxRcu=Aw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:52=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I have no strong opinion on this one, but likely a VM_WARN_ON would al=
so
> >> be sufficient to find such issues early during testing. No need to cra=
sh
> >> the machine.
> >
> > I thought VM_BUG_ON() was less frowned-upon than BUG_ON(), but after
> > some digging I found your patches to checkpatch and Linus clearly
> > stating that it isn't.
>
> :) yes.
>
> VM_BUG_ON is not particularly helpful IMHO. If you want something to be
> found early during testing, VM_WARN_ON is good enough.
>
> Ever since Fedora stopped enabling CONFIG_DEBUG_VM, VM_* friends are
> primarily reported during early/development testing only. But maybe some
> distro out there still sets it.
>
> >
> > How about something like the following (untested), it is the minimal
> > recovery we can do but should work for a lot of cases, and does
> > nothing beyond a warning if we can swapin the large folio from disk:
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index f1a9cfab6e748..8f441dd8e109f 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct
> > swap_iocb **plug)
> >          delayacct_swapin_start();
> >
> >          if (zswap_load(folio)) {
> > -               folio_mark_uptodate(folio);
> >                  folio_unlock(folio);
> >          } else if (data_race(sis->flags & SWP_FS_OPS)) {
> >                  swap_read_folio_fs(folio, plug);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6007252429bb2..cc04db6bb217e 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1557,6 +1557,22 @@ bool zswap_load(struct folio *folio)
> >
> >          VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > +       /*
> > +        * Large folios should not be swapped in while zswap is being u=
sed, as
> > +        * they are not properly handled.
> > +        *
> > +        * If any of the subpages are in zswap, reading from disk would=
 result
> > +        * in data corruption, so return true without marking the folio=
 uptodate
> > +        * so that an IO error is emitted (e.g. do_swap_page() will sig=
fault).
> > +        *
> > +        * Otherwise, return false and read the folio from disk.
> > +        */
> > +       if (WARN_ON_ONCE(folio_test_large(folio))) {
> > +               if (xa_find(tree, &offset, offset +
> > folio_nr_pages(folio) - 1, 0))
> > +                       return true;
> > +               return false;
> > +       }
> > +
> >          /*
> >           * When reading into the swapcache, invalidate our entry. The
> >           * swapcache can be the authoritative owner of the page and
> > @@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
> >                  zswap_entry_free(entry);
> >                  folio_mark_dirty(folio);
> >          }
> > -
> > +       folio_mark_uptodate(folio);
> >          return true;
> >   }
> >
> > One problem is that even if zswap was never enabled, the warning will
> > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
> > static key if zswap was "ever" enabled.
>
> We should use WARN_ON_ONCE() only for things that cannot happen. So if
> there are cases where this could be triggered today, it would be
> problematic -- especially if it can be triggered from unprivileged user
> space. But if we're concerned of other code messing up our invariant in
> the future (e.g., enabling large folios without taking proper care about
> zswap etc), we're good to add it.

Right now I can't see any paths allocating large folios for swapin, so
I think it cannot happen. Once someone tries adding it, the warning
will fire if CONFIG_ZSWAP is used, even if zswap is disabled.

At this point we will have several options:
- Make large folios swapin depend on !CONFIG_ZSWAP for now.
- Keep track if zswap was ever enabled and make the warning
conditional on it. We should also always fallback to order-0 if zswap
was ever enabled.
- Properly handle large folio swapin with zswap.

Does this sound reasonable to you?

