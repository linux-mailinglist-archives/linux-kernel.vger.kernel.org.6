Return-Path: <linux-kernel+bounces-204985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A68FF5DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32097B22563
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43EE6F06E;
	Thu,  6 Jun 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXCfLILu"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE903FB87
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705951; cv=none; b=t2U4gXd47NAg+TtM03XZJ/3wxfy8AU7zA3NawzOCFZWCD1c05H0XizrYqLaPmDFmvJV99h56gsws7fYHgxI5QzlZ6fQl90jin4Rn2E9HtAUmhp2VXHlnO1483wIXgQaqm92ZNfSqxiGcB5TiFl+EWYoWjwDaEK12+MKJ7d+GfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705951; c=relaxed/simple;
	bh=rm6hjsWdlJ1zBWSNJIawZTvoxBgfoKpXcHykuoeHNHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUrfsSM34zH3LcGq+HnniR+HYPQV+zr1qId7wtYxyVSMi4NPzr+VGJc70xekIbPZi0R6JrASRMxjmR16cpMvTm+/o0lE+IIxVrNub3faIPDWX64hO2IYefiHdGgSUwG3rtW4JyfRcUivUStRoLg45o4EI/fMZdpULrdHRgl+C2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXCfLILu; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaad2c673fso20519931fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717705947; x=1718310747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YHCiTEkfpHoydmGC9AHr3146/m0kW0vBON+xrTSWjI=;
        b=NXCfLILuBkYkCrjb+kFSWqN8tr6oItF+BL6jfAO8YwvdKFi/lsnSW3vgaqI6S8eN8v
         ZK5rlUOINr6rEu0l2Pebz5wQyq5K01pfocMmy8c482fvZuGxowWy57FJVASMpNbrzPMx
         8RN7l449OH82JWRIGqbJHFzBCuLuJcd+05qKt5GXdjT/s1usrkMrOMx0nqSFJIQguuGH
         v8dJsVXEFSx5R8kPUHKaHo4QRTppl5zwLNVY3IOVmkmquxl+0JGku/jvPf1WAldWs4be
         MxiHDKj1KVTvq4+4totH1mcG5Fcd1LyFqdpVRS+j/69MG5PegqgCQqjIoxMnL8zLMCMy
         c7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705947; x=1718310747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YHCiTEkfpHoydmGC9AHr3146/m0kW0vBON+xrTSWjI=;
        b=Ghagz+4Wj39QOfl0918lsvvBdHy144MDgNKk1+FdMwNayCsIHm+aZ9JINsYE7Ibc2u
         TLXCoqAFFb4czIfOZ3Kamnj588atSZ8pThcJD5MIdges+x35+4g9AAIFbhuAb9onTaeG
         rFBFay1SymcopwC8HSNbR16jiR4MpQPHgtFgBdwjzfoyd2hvJvFv29K4+d3FGIkMY8ns
         mnwY189UTUBgWGTreUOhgSYl2JxzubrEQj4W9+2Y7tb443Or1L4Wgrbf9wZrYO9GK7EJ
         suZeFE7Cmv7SWnr6BwFYx3tjDxe67rkas/NtoYDY38Jy7gjrog6VDp+Mv0C1Yoi907IS
         HjVw==
X-Forwarded-Encrypted: i=1; AJvYcCVu0NsMmIf5H9Ln6jYINnQICHe83ZxShmr9pY9hImfzJKw6eeii04xLaH34u5yxWH/fBhaQbD+DkusfrENLhjscW3t6jz+ykC99iluV
X-Gm-Message-State: AOJu0YwB2BzS7np+Cr8pUlj4UH0eJLG8EyaoXreB+CrbFz3Sy8Aq/wyG
	L8Za2ClBny3V/bl9es6L23+EyF4ZsGsQ73LmamJ9dQzTgmKpCFE+8I7zKOWyGYsqhNsEmhFH4JG
	4e6oLF1XrFHwdCkHHKQfGM2/rUep74zsJsp1W768wJeEeEROl50qC87w=
X-Google-Smtp-Source: AGHT+IGjOeKVtKGgR13bQg8qW5Cv42mcnsQtbopPin8/YkTWpckfS9UiNf1pM2EeF2gbFbauRTceMriznw5KI/f+zOc=
X-Received: by 2002:a2e:9207:0:b0:2e1:9c57:195a with SMTP id
 38308e7fff4ca-2eadce85f26mr5383061fa.32.1717705947131; Thu, 06 Jun 2024
 13:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com> <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com>
In-Reply-To: <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 13:31:48 -0700
Message-ID: <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.06.24 20:48, Yosry Ahmed wrote:
> > With ongoing work to support large folio swapin, it is important to mak=
e
> > sure we do not pass large folios to zswap_load() without implementing
> > proper support.
> >
> > For example, if a swapin fault observes that contiguous PTEs are
> > pointing to contiguous swap entries and tries to swap them in as a larg=
e
> > folio, swap_read_folio() will pass in a large folio to zswap_load(), bu=
t
> > zswap_load() will only effectively load the first page in the folio. If
> > the first page is not in zswap, the folio will be read from disk, even
> > though other pages may be in zswap.
> >
> > In both cases, this will lead to silent data corruption.
> >
> > Proper large folio swapin support needs to go into zswap before zswap
> > can be enabled in a system that supports large folio swapin.
> >
> > Looking at callers of swap_read_folio(), it seems like they are either
> > allocated from __read_swap_cache_async() or do_swap_page() in the
> > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so we
> > are fine for now.
> >
> > Add a VM_BUG_ON() in zswap_load() to make sure that we detect changes i=
n
> > the order of those allocations without proper handling of zswap.
> >
> > Alternatively, swap_read_folio() (or its callers) can be updated to hav=
e
> > a fallback mechanism that splits large folios or reads subpages
> > separately. Similar logic may be needed anyway in case part of a large
> > folio is already in the swapcache and the rest of it is swapped out.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > Sorry for the long CC list, I just found myself repeatedly looking at
> > new series that add swap support for mTHPs / large folios, making sure
> > they do not break with zswap or make incorrect assumptions. This debug
> > check should give us some peace of mind. Hopefully this patch will also
> > raise awareness among people who are working on this.
> >
> > ---
> >   mm/zswap.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b9b35ef86d9be..6007252429bb2 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> >       if (!entry)
> >               return false;
> >
> > +     /* Zswap loads do not handle large folio swapins correctly yet */
> > +     VM_BUG_ON(folio_test_large(folio));
> > +
>
> There is no way we could have a WARN_ON_ONCE() and recover, right?

Not without making more fundamental changes to the surrounding swap
code. Currently zswap_load() returns either true (folio was loaded
from zswap) or false (folio is not in zswap).

To handle this correctly zswap_load() would need to tell
swap_read_folio() which subpages are in zswap and have been loaded,
and then swap_read_folio() would need to read the remaining subpages
from disk. This of course assumes that the caller of swap_read_folio()
made sure that the entire folio is swapped out and protected against
races with other swapins.

Also, because swap_read_folio() cannot split the folio itself, other
swap_read_folio_*() functions that are called from it should be
updated to handle swapping in tail subpages, which may be questionable
in its own right.

An alternative would be that zswap_load() (or a separate interface)
could tell swap_read_folio() that the folio is partially in zswap,
then we can just bail and tell the caller that it cannot read the
large folio and that it should be split.

There may be other options as well, but the bottom line is that it is
possible, but probably not something that we want to do right now.

A stronger protection method would be to introduce a config option or
boot parameter for large folio swapin, and then make CONFIG_ZSWAP
depend on it being disabled, or have zswap check it at boot and refuse
to be enabled if it is on.

