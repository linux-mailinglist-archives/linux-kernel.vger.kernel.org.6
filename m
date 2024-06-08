Return-Path: <linux-kernel+bounces-206856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F313900EE2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168AA1F21A2C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC072256A;
	Sat,  8 Jun 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDruvzkQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD37F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717806553; cv=none; b=swFos48fcVm37W/L/7NSzjPqQiKDAVjeCmZJwo8d/nsoR3atOfdT1LG20wR4F221QFLnuFigtHqGt9yySGd8tHppreZNZgw45Ru5yEEOwhO5cdo/5Q+08fz4lDfFj3LysPzmmFUChSz7tlHpLSDItE2jZ4s4gKj/PwyV6Yl3T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717806553; c=relaxed/simple;
	bh=kjmv8RmXDLcFGRxZg9i2sgDpiC6aPIiaGPsEdtZHlbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ33fDeOzpBmySYlB4pVMu1YDw+7D2xnCzQFmus9LtF+YrzhHjCH+BZGTzN6z3ba5Uez2rSy/LBNvFZybXnsIVfXmTY5t0JwAGlKXdI1SzJdLjl8v1QylaiU+SR2C/hTYvWVbLf8ed66VceepEle+waaWyXCJ+aCx6VdHOxgOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDruvzkQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c614c572aso892277a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717806549; x=1718411349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU3lVIkMLo3Prbwhc1rQ2oK3OOx/42O1VO+Q7TSex8Q=;
        b=sDruvzkQJhovD+iPsvy8ddQNF6DhWSOUL2bnqXsW0Vi0rRJsoAM/kgqNpDEnsKUcWp
         tVo4fCsAXM0H8zvndnCMDlDdeNDkYP8bT9gUkcNg+ZajIfXzTqNeuO6refigXBIO4heQ
         CAVJfjlYi7VdSxSVoSXTj9TmcgB7xjCYAgpx9lcb8BwkYoky0wb/ZXMSnuUG72nbxdbk
         VTBHE+YMDVHD8st2rRL7gV1XFcnjjSlXapSQj3KWw4R3TD2NkNnCjVkQrpld4OYVPDr7
         xWV00BLz2pgTkSASCdcAQTxAVoeD46DunbMgEkTuatRoes3TJF0OBNSciCGLjhkQGQah
         zH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717806549; x=1718411349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU3lVIkMLo3Prbwhc1rQ2oK3OOx/42O1VO+Q7TSex8Q=;
        b=mM2xZAU4qBK1eO6uMCptcMMSM8j97pSPHg4s296JJD8weqWapIKSXS+FfrFVTTg5CR
         AnOeEDMy8+g3V99QbNRe5myRWiVTLKrZJZf7ZbyPvxTF7z4Cv0CVMS8a/7nkcL3adEex
         VwXHbrY+s8eMJIawvEaOAcxftG9B+j8EJ4OZBGekv6wd+arW6jj579+VcHh9Mrrv3H6Q
         W30hfw+oqBXI0qu9/x5RxLX/poBkl6woQMdW0CpCf1qCfw1P3FP4fsEBcFDx6b6yuv3G
         4g7aw3CuifvnP2o0lYrDdMuSQ502QZwm8x4jDAtLZBHK2/3VOAD0Fc/JVO/sMEY+YtJv
         8JHg==
X-Forwarded-Encrypted: i=1; AJvYcCVS8ptdLL2t3pH0N1sbdG94J/CVVdgfBOIPYRNXbg+PkvOFlnjaLUtKIETbeWKA/gOJuVquot0NQTlwzglILs6+T+3UNB02WxFDW/FH
X-Gm-Message-State: AOJu0YymIlSkyPxEJBurOVc9oRebOpnuP9rxy4FVmFCGeHrzkLxFNzLk
	jfzN1NMCMMufakAx3m/DQKZD6WyYVKffBlSPW8n2mgQX5CYDOVcOEoQWuBRJq0J5ncGzQkQ9KwB
	Y81JA0TG0hqAJ0h0eXaQbiPbT9EbJ0RUA8OBL
X-Google-Smtp-Source: AGHT+IHQQu/Y3GsH2EmT7P8sedBCKxXKqo26tmnnUS0qb5g5cbMQgeK4Co23t0sVkzAq9TvzjnJth/vuu8mkfUVo+NY=
X-Received: by 2002:a17:906:54e:b0:a6c:8be4:7f25 with SMTP id
 a640c23a62f3a-a6cdaa0f4f6mr269861366b.56.1717806549286; Fri, 07 Jun 2024
 17:29:09 -0700 (PDT)
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
 <CAGsJ_4zu1_oMsskrndfpk0gaaHGDrTRnMKkQxF05jwCabxtfDQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zu1_oMsskrndfpk0gaaHGDrTRnMKkQxF05jwCabxtfDQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 17:28:30 -0700
Message-ID: <CAJD7tkakM+1EcgoZyJFcH4Tk2NU4C-knkh43kWUN0f2oKHxyzw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 3:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Jun 8, 2024 at 6:58=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Fri, Jun 7, 2024 at 11:52=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > >> I have no strong opinion on this one, but likely a VM_WARN_ON woul=
d also
> > > >> be sufficient to find such issues early during testing. No need to=
 crash
> > > >> the machine.
> > > >
> > > > I thought VM_BUG_ON() was less frowned-upon than BUG_ON(), but afte=
r
> > > > some digging I found your patches to checkpatch and Linus clearly
> > > > stating that it isn't.
> > >
> > > :) yes.
> > >
> > > VM_BUG_ON is not particularly helpful IMHO. If you want something to =
be
> > > found early during testing, VM_WARN_ON is good enough.
> > >
> > > Ever since Fedora stopped enabling CONFIG_DEBUG_VM, VM_* friends are
> > > primarily reported during early/development testing only. But maybe s=
ome
> > > distro out there still sets it.
> > >
> > > >
> > > > How about something like the following (untested), it is the minima=
l
> > > > recovery we can do but should work for a lot of cases, and does
> > > > nothing beyond a warning if we can swapin the large folio from disk=
:
> > > >
> > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > > --- a/mm/page_io.c
> > > > +++ b/mm/page_io.c
> > > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struc=
t
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
> > > > +        * Large folios should not be swapped in while zswap is bei=
ng used, as
> > > > +        * they are not properly handled.
> > > > +        *
> > > > +        * If any of the subpages are in zswap, reading from disk w=
ould result
> > > > +        * in data corruption, so return true without marking the f=
olio uptodate
> > > > +        * so that an IO error is emitted (e.g. do_swap_page() will=
 sigfault).
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
> > > >           * When reading into the swapcache, invalidate our entry. =
The
> > > >           * swapcache can be the authoritative owner of the page an=
d
> > > > @@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
> > > >                  zswap_entry_free(entry);
> > > >                  folio_mark_dirty(folio);
> > > >          }
> > > > -
> > > > +       folio_mark_uptodate(folio);
> > > >          return true;
> > > >   }
> > > >
> > > > One problem is that even if zswap was never enabled, the warning wi=
ll
> > > > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable o=
r
> > > > static key if zswap was "ever" enabled.
> > >
> > > We should use WARN_ON_ONCE() only for things that cannot happen. So i=
f
> > > there are cases where this could be triggered today, it would be
> > > problematic -- especially if it can be triggered from unprivileged us=
er
> > > space. But if we're concerned of other code messing up our invariant =
in
> > > the future (e.g., enabling large folios without taking proper care ab=
out
> > > zswap etc), we're good to add it.
> >
> > Right now I can't see any paths allocating large folios for swapin, so
> > I think it cannot happen. Once someone tries adding it, the warning
> > will fire if CONFIG_ZSWAP is used, even if zswap is disabled.
> >
> > At this point we will have several options:
> > - Make large folios swapin depend on !CONFIG_ZSWAP for now.
>
> It appears quite problematic. We lack control over whether the kernel bui=
ld
> will enable CONFIG_ZSWAP, particularly when aiming for a common
> defconfig across all platforms to streamline configurations. For instance=
,
> in the case of ARM, this was once a significant goal.
>
> Simply trigger a single WARN or BUG if an attempt is made to load
> large folios in zswap_load, while ensuring that zswap_is_enabled()
> remains unaffected. In the mainline code, large folio swap-in support
> is absent, so this warning is intended for debugging purposes and
> targets a very small audience=E2=80=94perhaps fewer than five individuals
> worldwide. Real users won=E2=80=99t encounter this warning, as it remains
> hidden from their view.

I can make the warning only fire if any part of the folio is in zswap
to avoid getting warnings from zswap_load() if we never actually use
zswap, that's reasonable. I wanted to warn if we reach zswap_load()
with any large folio at all for higher coverage only.

I will send something out in the next week or so.


>
> > - Keep track if zswap was ever enabled and make the warning
> > conditional on it. We should also always fallback to order-0 if zswap
> > was ever enabled.
> > - Properly handle large folio swapin with zswap.
> >
> > Does this sound reasonable to you?
>
> Thanks
> Barry

