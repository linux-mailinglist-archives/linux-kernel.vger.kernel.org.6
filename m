Return-Path: <linux-kernel+bounces-206800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386C900DE9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D795B22C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B097115530B;
	Fri,  7 Jun 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feWgTppC"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787D13E05F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798181; cv=none; b=C6PKAfSs4VjhTRMNLTpajVo2+0bwHpbdMDRoj5rv/7C5huY6mu63PFX8rWztAPVpe6QAUEyQIZ/UoZDtYqOrwRjKZERxTmZ3OBiecteU399V+3QtuKA7ofMFLSwnoZLDg0xbB0lmvVn4kXsmEGHFkP0nfTl8MObGa6BXQpi9+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798181; c=relaxed/simple;
	bh=diwB0l0UAVo8+Gt138de5hrciVGS337EObgtm0FDCE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZkbGJetVnNgoTC+gTbTveZCwBg7lkN4EX3SgirWQBKo5QZISrshILAtn+UwQX8T6L+QQuWwpMLUG4QtC2YkwOiKHvXAZXs2Z6QvYbwMSxgyEXM3VecxSAiLNMBuwn7YwB7Ii8aYmR8X55zkCQ4y8KnMW3pzEgMEqaKQs1XWAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feWgTppC; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4eb007a9f6fso788350e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717798179; x=1718402979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3UbizO+Gka3HudQXSONmDJzYnn656T2JMJbmkmqGFQ=;
        b=feWgTppCrmtQ7/QLzS2ayf3JFY6XFQmEovhm0zY33LbcfQ18iNnChcpfkloGCGfTwu
         7184U3qgH8y11Xp0lQI3I1yI/2M4QiOIvvwJP+7SaLP9qNFKl6qR0dV/NWg5a8EfaDCW
         Ih5ERDy0BiDMD97L6ywrCysefpN0Sxnca7TERfGbDlB5hqsCJQYX9pIyvku7MlUskAta
         2RNFpj6IVOWKHGVFiaKAL/XUk+LtannJbe+6leeNpsm3gV/RNc9vO9gTJRpheZKJXzCN
         pa1SwZRnVzLH1fnT1gDVhm764ssx8XRMUlJ0I11k8YMfX6elW0K7UGPfTpmTBeX7DEM0
         zk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717798179; x=1718402979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3UbizO+Gka3HudQXSONmDJzYnn656T2JMJbmkmqGFQ=;
        b=EgjFC3yeksdKshBpA7oplSvfmLROiHW/6ii8tIv2cwcl81b9VfhJvQpuSGKSUPIKzC
         PjhRigFVTGn1F3OPvimvABh8E6f43T0bNrtASrInfU+wuwoNaozlSAfwq2zt7ZJabgN6
         Klf3bA7wONmzaul76pOq7WEcU+mnhjxjIsf/ppb37DsrADLJvB5+huNbrLiK4W3waoIM
         RkAJN/oinQE8SZq5BLfYPhZhyw/zzR1a2sSbzpxZFarC5sd8BxQdgnSmMhbJaZc1nRJ2
         9xX1+Q/Dw739lEIUEB+RX1hnpV3m/XtW3RmQtH0SlULYQX8+UqPBji3Fgt05iDMI9q5b
         heTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYFSmFl4+z8cBSwerzfKflJ4W4Mz+I17VjY+wroIjOZRK3jExwlgy2RFZiou+23FaSErrUNri9wj4R9t9hNVGPn0m2ywcYqUjAlxjC
X-Gm-Message-State: AOJu0YykAFu+YggonP33bzDX5d6VAeoJDnYbepGGY9cre94FOazxgFZU
	5q0fE6WlpcAACrV+T5QKT4oiTZy1V/RME/6GdCSpFz522m1QV2pFX4pSuaMH6zFGZNiqt8AgS/r
	d83nBI3IptWF/uV04NX2pSWseK9I=
X-Google-Smtp-Source: AGHT+IFKrtWS09VgM/qMfXBfJEQoPRoU+YRBIX3AA7tPQagWmM7DHPio9ht6ifiOJyc2Nl1EJMrnq9cktV8Y3B5JB3c=
X-Received: by 2002:ac5:c5ab:0:b0:4d8:4a7f:c166 with SMTP id
 71dfb90a1353d-4eb562b291dmr3904888e0c.12.1717798178947; Fri, 07 Jun 2024
 15:09:38 -0700 (PDT)
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
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Jun 2024 10:09:27 +1200
Message-ID: <CAGsJ_4zu1_oMsskrndfpk0gaaHGDrTRnMKkQxF05jwCabxtfDQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 6:58=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
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
>
> At this point we will have several options:
> - Make large folios swapin depend on !CONFIG_ZSWAP for now.

It appears quite problematic. We lack control over whether the kernel build
will enable CONFIG_ZSWAP, particularly when aiming for a common
defconfig across all platforms to streamline configurations. For instance,
in the case of ARM, this was once a significant goal.

Simply trigger a single WARN or BUG if an attempt is made to load
large folios in zswap_load, while ensuring that zswap_is_enabled()
remains unaffected. In the mainline code, large folio swap-in support
is absent, so this warning is intended for debugging purposes and
targets a very small audience=E2=80=94perhaps fewer than five individuals
worldwide. Real users won=E2=80=99t encounter this warning, as it remains
hidden from their view.

> - Keep track if zswap was ever enabled and make the warning
> conditional on it. We should also always fallback to order-0 if zswap
> was ever enabled.
> - Properly handle large folio swapin with zswap.
>
> Does this sound reasonable to you?

Thanks
Barry

