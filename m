Return-Path: <linux-kernel+bounces-206831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21501900E63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACEF1F234B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662673455;
	Fri,  7 Jun 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6PoD1Xf"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D84F5EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717802095; cv=none; b=YKNQHfCRJvfIrazZ6A4MJZtw1DIi0pfhm6b4khTYsYnG2Ht+vakwi1aR5AtUFOJN8LnI0NHlZOWyobfUthTrNEof9DEV7XTL9tr5ov0jC4lFKcUSYazeLW/5aMZ8OLW8pj0pFpeEpZzzHluQsmn1One9gc5pu697JBSBiCVlQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717802095; c=relaxed/simple;
	bh=CmRjzypL0SqMkOxrilenn4psfDasUJ2Rr80DHbSvYqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LI1TmiZPz+V+0VhBlJHJQHEpGmHEgJdHWEmY2hJdtdthfap7qEUkaVpySrONJ5JEzN6LE6ZUV+Hlk5c4JsSBrUss2kzesgp4iP0YiZTKdsfTarXRbuDdYMjQBI0aY8P4WHg+4YwlZsQDOUt9n7VNZKx3Sng7fTuXToNLenDyok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6PoD1Xf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso923703a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717802092; x=1718406892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/NFoZRrQ3Oe99jHYpj59voH3AVeMqlDyxoL8EDvsTQ=;
        b=t6PoD1Xf1CvGmvm5BlY9BHv/+TO9p+eVBeu4FQKK6YSJ33PVe2F4whuUOlS9WkrEHW
         BUZb+cDAlN9sTIe9CXN7EEkXPIh2kpMW9auh3yBqo6ugOMJ1H2NhyVO/FjtYTfIzZXki
         FJ63OnB0j3/0kH01fsRCqHBTmS+rTxckbWw/9hFjDHcVdtpBzh0c61Bd3+6dRdES6s5x
         dzCT7xfotSamdCcZePZNWs9rOtnypKGkyFFhbsXYyauhnV4zVOfTmS7YzVG4okIHlvrk
         83AiAeQfwQac9BRfMFDVYWv7daR8LPn+zhxYrE1VbLRnVHyMF8ihMNZFe6igmP6cN6gr
         RtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717802092; x=1718406892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/NFoZRrQ3Oe99jHYpj59voH3AVeMqlDyxoL8EDvsTQ=;
        b=WjiUowq4p4d6+0EiKaCmPUjrbuFMSpFyE2NZzZKurXXBbdiN/j4vp3nthQNc77wJ8r
         3VDkkMFLBmYuSWAUaYVFOty1GE0oNrMIylS5FNzv0BCNzsFMkXV/+/0vXFC3jvnEJfEL
         vYmD+1ILloW7AHA8fjG6v9hwSJ5Bk2MMCqqivi5Pz2bdHP7XXYhFFfCYduzLlCLXz5wm
         sLZ16Uo3eE4wA8iOFuO8Njy898rsnHS47FnkMYCGE/QGcZ4VUm4pNqikQcQMoX5zfUUE
         kL9k87W2Py4YLcPTOruePfeuiwcUGj2gLsp3p+aQHwufld9Ak9TzooKpyRil0U37Y6Vp
         6+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXLUb2K9poPf7wrt76vF5BIsLuYxAsvLVtowpMW7BdVq9SfGmcLpxiJk/lSpSN2VXIcNczGzbI+Y6LtA3soFFaIwb3rEfeQIbJpsykd
X-Gm-Message-State: AOJu0YwFpotVa6BhlukBGUn6wlvN0jXa+5GCPY22oKOwkwAn2lpISGWa
	AVI+u8YiWpoM1tcMDVNPJZ7NdkrSlFwx9lSYVXELGNaq+dzWLtZPCcUIvW0YRD09JFnFswkn4gQ
	uO/eGLOS1ik4dP0B8eqY+ZFNYnYoDmbKOryZC
X-Google-Smtp-Source: AGHT+IGPrEWf1WL85cQqKtIbRvg/yPmsdJLHLXreQl2erm5kBz9tMNMEwFX/Ccjrv9JfJcfXifhcai345+M447MIZto=
X-Received: by 2002:a17:906:7705:b0:a6e:b1f:5e17 with SMTP id
 a640c23a62f3a-a6e0b1f5e6bmr154507366b.54.1717802091519; Fri, 07 Jun 2024
 16:14:51 -0700 (PDT)
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
 <CANeU7QkrXyv8f4JE+iUte2iTUg-dP_Q1==g2JwMjS4TEyiLovA@mail.gmail.com>
In-Reply-To: <CANeU7QkrXyv8f4JE+iUte2iTUg-dP_Q1==g2JwMjS4TEyiLovA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 16:14:13 -0700
Message-ID: <CAJD7tkY2zNQs4Er4jkE+peYv1POv44+zV4zPuAq6OtJHT5rY+g@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > >
> > > > How about something like the following (untested), it is the minimal
> > > > recovery we can do but should work for a lot of cases, and does
> > > > nothing beyond a warning if we can swapin the large folio from disk:
> > > >
> > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > > --- a/mm/page_io.c
> > > > +++ b/mm/page_io.c
> > > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct
> > > > swap_iocb **plug)
> > > >          delayacct_swapin_start();
> > > >
> > > >          if (zswap_load(folio)) {
> > > > -               folio_mark_uptodate(folio);
> > > >                  folio_unlock(folio);
> > > >          } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > > >                  swap_read_folio_fs(folio, plug);
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 6007252429bb2..cc04db6bb217e 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1557,6 +1557,22 @@ bool zswap_load(struct folio *folio)
> > > >
> > > >          VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > >
> > > > +       /*
> > > > +        * Large folios should not be swapped in while zswap is being used, as
> > > > +        * they are not properly handled.
> > > > +        *
> > > > +        * If any of the subpages are in zswap, reading from disk would result
> > > > +        * in data corruption, so return true without marking the folio uptodate
> > > > +        * so that an IO error is emitted (e.g. do_swap_page() will sigfault).
> > > > +        *
> > > > +        * Otherwise, return false and read the folio from disk.
> > > > +        */
> > > > +       if (WARN_ON_ONCE(folio_test_large(folio))) {
> > > > +               if (xa_find(tree, &offset, offset +
> > > > folio_nr_pages(folio) - 1, 0))
> > > > +                       return true;
> > > > +               return false;
> > > > +       }
> > > > +
> > > >          /*
> > > >           * When reading into the swapcache, invalidate our entry. The
> > > >           * swapcache can be the authoritative owner of the page and
> > > > @@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
> > > >                  zswap_entry_free(entry);
> > > >                  folio_mark_dirty(folio);
> > > >          }
> > > > -
> > > > +       folio_mark_uptodate(folio);
> > > >          return true;
> > > >   }
> > > >
> > > > One problem is that even if zswap was never enabled, the warning will
> > > > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
> > > > static key if zswap was "ever" enabled.
> > >
> > > We should use WARN_ON_ONCE() only for things that cannot happen. So if
> > > there are cases where this could be triggered today, it would be
> > > problematic -- especially if it can be triggered from unprivileged user
> > > space. But if we're concerned of other code messing up our invariant in
> > > the future (e.g., enabling large folios without taking proper care about
> > > zswap etc), we're good to add it.
> >
> > Right now I can't see any paths allocating large folios for swapin, so
> > I think it cannot happen. Once someone tries adding it, the warning
> > will fire if CONFIG_ZSWAP is used, even if zswap is disabled.
> > At this point we will have several options:
>
> Here is my take on this:
>
> > - Make large folios swapin depend on !CONFIG_ZSWAP for now.
>
> I think a WARON or BUG_ON is better. I would need to revert this
> change when I am working on 3).  It is a make up rule, not a real
> dependency any way.

I am intending to send a new version with WARN_ON_ONCE() and some
attempt to recover.

It is not a rule, it is just that we don't have the support for it today.

>
> > - Keep track if zswap was ever enabled and make the warning
> > conditional on it. We should also always fallback to order-0 if zswap
> > was ever enabled.
>
> IMHO, falling back to order-0 inside zswap is not desired because it
> complicates the zswap code. We should not pass large folio to zswap if
> zswap is not ready to handle large folio. The core swap already has
> the fall back to order-0. If we get to 3), then this fall back in
> zswap needs to be removed. It is a transitional thing then maybe not
> introduce it in the first place.

We cannot split the folio inside zswap. What I meant is that the
swapin code should fallback to order-0 if zswap is being used, to
avoid passing large folios to zswap.

>
> > - Properly handle large folio swapin with zswap.
> That obviously is ideal.
>
> Chris

