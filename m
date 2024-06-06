Return-Path: <linux-kernel+bounces-205012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9A8FF623
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7234A2866E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9655E196DAB;
	Thu,  6 Jun 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD79WkSl"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EE13C67B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707310; cv=none; b=UyKjyXA2uStx1laXA/+Lqcmh3zJC7MPOX7VHnLqezynF5YWCAlypg/eJkgcePxH8g1+aqJE+xprenIfb1ZpOIdA96m/Qmk7MikEMGkdlJY7AWd6P3qR78Qn/UgXMnO/Ab7/80G7hqSQBxv8EYN/ESMzELZPvxJsC3b/AyEGwBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707310; c=relaxed/simple;
	bh=umOIhey/oqSigy9oxZ9JmAIfpr4+c1V6FQJLEtzPmQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuLpaNEf4DzBHXjDzJMW75R7FVYo6qil8gQuuYVtxLq1GouoMXeNvcuihoeRMVedKwoNeDnItGkBBFZoptt1e0bulX26ebjkQjGwS0XmRqXTtDKbFpnihJ79RqupuSm5JInarXvrW4UReWas7m2qAEee1wfb0Z7ccKMiBocr1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD79WkSl; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80acf1bca86so436214241.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717707308; x=1718312108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL7tTfGLqeY7hfzIjcIfo8g+rxb0Tacathwl6LUj7oY=;
        b=FD79WkSlPFGyoU+TZIgQnjTvZ/6QwdlGBZdXlfLpVBbAfc0Vw2/6OczpafSdQP0ROI
         orNmddU6w5q5rD5J2FkckrHvUijhlj3F16a9lVz2LHfhBckjYdC8kpLNq/T2vtoM2c+X
         9mjkEvfcifrAf0ZycsierhZjevt/G47F/R0+4lkyk8C63TFm+zrbjELXqxJzC+0ajsaP
         uD8R54YsuaJ1SK4yEj3cSV+x5uMWoyVMPXTCmv1YrQ7tGrjbOFa4+xtpgFTgYouSxJ86
         BIkV0I5I7uzTY9iZ0Vd2zkeKjVlMQNfzJnA/IvSewIb8yFkdhrlNspPs5QSVoDeZ9TTz
         n0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707308; x=1718312108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL7tTfGLqeY7hfzIjcIfo8g+rxb0Tacathwl6LUj7oY=;
        b=DUtqYi8MCrCOVt4uYm+1H8f0SltDRrAkn1BHOCqA65JbnQzzfRyJBkaJgquy/Oi5HB
         oSlkDz+v2nGpTCVNhaGfPkWtYRpOB/0v3mQYRzUZ/zXB7P6V3GKPg9EVPDUaogX6gMTQ
         Yke1EQfPv6xsiXlyAPZKURPJcSDZuUURDy7h97LpJLPQ+7TPnZia45oV+YBdEwK7eaWu
         AEHrTPqFrIWUR3vIcvEE9H9wBXenkjJc6NpS5qx+UlemnCpdMXOpmKKKAPlwCHICRbWp
         Ekth16x5swEl3ZD56fWbnKXgmQ3dwpXCXYnZoA6lahMzc59/ff3beEoH/GjljqbpTAZJ
         6XxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrMUzd2S2fa9PLkIZqsuNgGYqlF72/5aJ6vZcawdj0g+FfC3mimrbZ+oa1A3XD+yKOKBrNn6goHSr74XK4kK4Zeg88znEpTS2b1v2/
X-Gm-Message-State: AOJu0Ywu4Fr5mc09gCy/2IZMrN+O9u1kRhiXwLXoGKpmPPv9Y0YkD9oH
	Z9Ppzk1WDo6pz60VHz6KGouA6uma23FktkYXv85JLHS3QEO7AbsUcRD582jCQ9C/qHsSk6gWzIA
	EH87kr+urezKTFLr7+47yPoFgGA8=
X-Google-Smtp-Source: AGHT+IGEMm31cV6zs8jOV7+Yxw+4wnR4rELpKUYSMnjAOhP+TMsXQ2LRqbi3mM2zzDUNVWV26FKc/C7VjbgOi0dPltU=
X-Received: by 2002:a05:6102:216a:b0:47b:d70c:ca9d with SMTP id
 ada2fe7eead31-48c275342e2mr468266137.29.1717707307769; Thu, 06 Jun 2024
 13:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
In-Reply-To: <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 08:54:56 +1200
Message-ID: <CAGsJ_4zTJgOgkXE=4a=w=ZsuC4WuwoBNHf0v0BwP7tatkkJZqA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:32=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 06.06.24 20:48, Yosry Ahmed wrote:
> > > With ongoing work to support large folio swapin, it is important to m=
ake
> > > sure we do not pass large folios to zswap_load() without implementing
> > > proper support.
> > >
> > > For example, if a swapin fault observes that contiguous PTEs are
> > > pointing to contiguous swap entries and tries to swap them in as a la=
rge
> > > folio, swap_read_folio() will pass in a large folio to zswap_load(), =
but
> > > zswap_load() will only effectively load the first page in the folio. =
If
> > > the first page is not in zswap, the folio will be read from disk, eve=
n
> > > though other pages may be in zswap.
> > >
> > > In both cases, this will lead to silent data corruption.
> > >
> > > Proper large folio swapin support needs to go into zswap before zswap
> > > can be enabled in a system that supports large folio swapin.
> > >
> > > Looking at callers of swap_read_folio(), it seems like they are eithe=
r
> > > allocated from __read_swap_cache_async() or do_swap_page() in the
> > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so we
> > > are fine for now.
> > >
> > > Add a VM_BUG_ON() in zswap_load() to make sure that we detect changes=
 in
> > > the order of those allocations without proper handling of zswap.
> > >
> > > Alternatively, swap_read_folio() (or its callers) can be updated to h=
ave
> > > a fallback mechanism that splits large folios or reads subpages
> > > separately. Similar logic may be needed anyway in case part of a larg=
e
> > > folio is already in the swapcache and the rest of it is swapped out.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Barry Song <baohua@kernel.org>

this has been observed by me[1], that's why you can find the below
code in my swapin patch

+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+      ...
+      /*
+      * a large folio being swapped-in could be partially in
+      * zswap and partially in swap devices, zswap doesn't
+      * support large folios yet, we might get corrupted
+      * zero-filled data by reading all subpages from swap
+      * devices while some of them are actually in zswap
+      */
+      if (is_zswap_enabled())
+           goto fallback;

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.=
com/

> > > ---
> > >
> > > Sorry for the long CC list, I just found myself repeatedly looking at
> > > new series that add swap support for mTHPs / large folios, making sur=
e
> > > they do not break with zswap or make incorrect assumptions. This debu=
g
> > > check should give us some peace of mind. Hopefully this patch will al=
so
> > > raise awareness among people who are working on this.
> > >
> > > ---
> > >   mm/zswap.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index b9b35ef86d9be..6007252429bb2 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> > >       if (!entry)
> > >               return false;
> > >
> > > +     /* Zswap loads do not handle large folio swapins correctly yet =
*/
> > > +     VM_BUG_ON(folio_test_large(folio));
> > > +
> >
> > There is no way we could have a WARN_ON_ONCE() and recover, right?
>
> Not without making more fundamental changes to the surrounding swap
> code. Currently zswap_load() returns either true (folio was loaded
> from zswap) or false (folio is not in zswap).
>
> To handle this correctly zswap_load() would need to tell
> swap_read_folio() which subpages are in zswap and have been loaded,
> and then swap_read_folio() would need to read the remaining subpages
> from disk. This of course assumes that the caller of swap_read_folio()
> made sure that the entire folio is swapped out and protected against
> races with other swapins.
>
> Also, because swap_read_folio() cannot split the folio itself, other
> swap_read_folio_*() functions that are called from it should be
> updated to handle swapping in tail subpages, which may be questionable
> in its own right.
>
> An alternative would be that zswap_load() (or a separate interface)
> could tell swap_read_folio() that the folio is partially in zswap,
> then we can just bail and tell the caller that it cannot read the
> large folio and that it should be split.
>
> There may be other options as well, but the bottom line is that it is
> possible, but probably not something that we want to do right now.
>
> A stronger protection method would be to introduce a config option or
> boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> depend on it being disabled, or have zswap check it at boot and refuse
> to be enabled if it is on.

Thanks
Barry

