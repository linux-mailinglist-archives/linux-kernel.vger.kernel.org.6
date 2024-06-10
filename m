Return-Path: <linux-kernel+bounces-208829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585ED9029AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F81F1C21E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA114E2F1;
	Mon, 10 Jun 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TihzJ6D9"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54E1B812
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049965; cv=none; b=jnac9ZBNs5TXHQUgE9tDMtkcxrVXWaI+7S5C195adKBteL1G1gx4FDfmDWSajpKud1N/qcL3Zd9ejH8xV7A5ZAKmwCsG1CTKR5QnGQTgfL7bDv/IsTIt2E9Di5RsJv06oa0vCMhbliSXkVRgu1D8aYmVgCncAlqVHLrknS8TGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049965; c=relaxed/simple;
	bh=BXBrZlOWfyHGGrCxrpEImjxoKqCbOCcIeNET+4xYuok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdtEFpv7r+UMfXH4cH8wteNE5Dh8LunZgtR2+W/yEh8Wwfr2iV16rgfHSK2qWf4L92WkXD7LR7raRmuO284AL2YvvYKc4kn21OHp+oYUVkzQarHgzhH3yvbQ8ctqGRjj9u5kzXV5oPdnHE3+WqrYSPPC7dENM5qCM81RnQkZkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TihzJ6D9; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso70449e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718049963; x=1718654763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TuWnQeYsZIwbcmv6fZEt1TjdHGPfIr0qBppAqWptGs=;
        b=TihzJ6D9yspgGLmmgIPF2FCcGfeIutsA96L0jY2ium2HemRHHR8MgEKx5zKEElfddm
         ajVc+B8a/flxe1zWY7dCUqVV8xiYu9w5Lymp/63E+gYtXV1C+M5XRq66zrRmYye24J2J
         sJQYyASow/AWyyM/ulxxPz9kQtoB8I9ev5NVnF3sskfHJXTkJCimJkrQJH+N1aNruhp3
         fhgQGIvJTWrM+tFTv65bMQkkuc8lo1oBGyQ88UU6CUoSoP2h9FSww1OPsJeKs2NsJr7I
         SsyyMGHV/2Int3kLeFSEFBRiZcEO44g3sxIDYnhA2RlXem7t76IZ/E0feYi/YlWm4kwY
         CMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049963; x=1718654763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TuWnQeYsZIwbcmv6fZEt1TjdHGPfIr0qBppAqWptGs=;
        b=vPmx9T8n9GoOlFRdclKznZjmlOf8m+zf65KXJNFeNABQ53bl1Q4KxpeVMW3UjFktZR
         7sFuntWN09IayeMsaXrsx2h/zxPemtYT+6ptmBxxWGXlHmcNFrKZ8LAeS+vdIHYzU1dV
         26TelYYt4vhGcqDeaVXsT2yNZn2xiNMfMGohEZeb7A596nrU9yxdt5Sg1YacHKz41R6q
         OyiBOj84b46TiO/p++vPE49VDpTdtIpmvhV8H3e1/oo4ivgGaBJ4ctrb+QFuCv0Xb4C/
         kDjefg9jGl4RxsnCBlXu785WuEDEqZHyZCNYiY6iKxcc8pT6HfomOWP3Gh1keiAXDioF
         X9cA==
X-Forwarded-Encrypted: i=1; AJvYcCW1zjCU0IN6XbFQrf0e/T1Ve0AF3ebYiP7G/heh6S9JlqHPaMJQt6wvXlJLhOP4dge5x5a/pKXFSeJ3J0Uc87Kd0mKP2mdPGSWhx4ou
X-Gm-Message-State: AOJu0YyMRELiJFtsbImzNMtkt+EBBJsaikwYaVFvomBuDo9RwhpTUbEs
	g5Rtk5ALvvkQr6vOMjHi9zSasV7/QmM3467NF28kPSAgCEHWleJOxPeDc25SPqJXnBpUtfi5UvX
	ZQZRoy+6XCIbd18KNcaFzAcYXbFs=
X-Google-Smtp-Source: AGHT+IEr0OWElKiXriv2YopSfwlbufb6HiGoa79JOsFWRHbWC7m2ZbxwcjyExEZsldQUqWXiQQDM52cuysfjUcd1Rls=
X-Received: by 2002:a1f:f884:0:b0:4d8:7339:4c35 with SMTP id
 71dfb90a1353d-4eb562ceb57mr7967220e0c.13.1718049962449; Mon, 10 Jun 2024
 13:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com> <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
In-Reply-To: <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Jun 2024 04:05:50 +0800
Message-ID: <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:42=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Jun 7, 2024 at 9:13=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > Zswap does not support storing or loading large folios. Until proper
> > > support is added, attempts to load large folios from zswap are a bug.
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
> > > In both cases, this will lead to silent data corruption. Proper suppo=
rt
> > > needs to be added before large folio swapins and zswap can work
> > > together.
> > >
> > > Looking at callers of swap_read_folio(), it seems like they are eithe=
r
> > > allocated from __read_swap_cache_async() or do_swap_page() in the
> > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
> > > everything is fine for now.
> > >
> > > However, there is ongoing work to add to support large folio swapins
> > > [1]. To make sure new development does not break zswap (or get broken=
 by
> > > zswap), add minimal handling of incorrect loads of large folios to
> > > zswap.
> > >
> > > First, move the call folio_mark_uptodate() inside zswap_load().
> > >
> > > If a large folio load is attempted, and any page in that folio is in
> > > zswap, return 'true' without calling folio_mark_uptodate(). This will
> > > prevent the folio from being read from disk, and will emit an IO erro=
r
> > > because the folio is not uptodate (e.g. do_swap_fault() will return
> > > VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but i=
t
> > > is better than nothing.
> > >
> > > This was tested by hacking the allocation in __read_swap_cache_async(=
)
> > > to use order 2 and __GFP_COMP.
> > >
> > > In the future, to handle this correctly, the swapin code should:
> > > (a) Fallback to order-0 swapins if zswap was ever used on the machine=
,
> > > because compressed pages remain in zswap after it is disabled.
> > > (b) Add proper support to swapin large folios from zswap (fully or
> > > partially).
> > >
> > > Probably start with (a) then followup with (b).
> > >
> > > [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@g=
mail.com/
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >
> > > v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosryahmed@=
google.com/
> > >
> > > v1 -> v2:
> > > - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some recove=
ry
> > >   handling (David Hildenbrand).
> > >
> > > ---
> > >  mm/page_io.c |  1 -
> > >  mm/zswap.c   | 22 +++++++++++++++++++++-
> > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > --- a/mm/page_io.c
> > > +++ b/mm/page_io.c
> > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct =
swap_iocb **plug)
> > >         delayacct_swapin_start();
> > >
> > >         if (zswap_load(folio)) {
> > > -               folio_mark_uptodate(folio);
> > >                 folio_unlock(folio);
> > >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > >                 swap_read_folio_fs(folio, plug);
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index b9b35ef86d9be..ebb878d3e7865 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> > >
> > >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > >
> > > +       /*
> > > +        * Large folios should not be swapped in while zswap is being=
 used, as
> > > +        * they are not properly handled. Zswap does not properly loa=
d large
> > > +        * folios, and a large folio may only be partially in zswap.
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
> > > +       if (folio_test_large(folio)) {
> > > +               if (xa_find(tree, &offset,
> > > +                           offset + folio_nr_pages(folio) - 1, XA_PR=
ESENT)) {
> > > +                       WARN_ON_ONCE(1);
> > > +                       return true;
> > > +               }
> > > +               return false;
> >
> > IMHO, this appears to be over-designed. Personally, I would opt to
> > use
> >
> >  if (folio_test_large(folio))
> >                return true;
>
> I am sure you mean "return false" here. Always returning true means we
> will never read a large folio from either zswap or disk, whether it's
> in zswap or not. Basically guaranteeing corrupting data for large
> folio swapin, even if zswap is disabled :)
>
> >
> > Before we address large folio support in zswap, it=E2=80=99s essential
> > not to let them coexist. Expecting valid data by lunchtime is
> > not advisable.
>
> The goal here is to enable development for large folio swapin without
> breaking zswap or being blocked on adding support in zswap. If we
> always return false for large folios, as you suggest, then even if the
> folio is in zswap (or parts of it), we will go read it from disk. This
> will result in silent data corruption.
>
> As you mentioned before, you spent a week debugging problems with your
> large folio swapin series because of a zswap problem, and even after
> then, the zswap_is_enabled() check you had is not enough to prevent
> problems as I mentioned before (if zswap was enabled before). So we
> need stronger checks to make sure we don't break things when we
> support large folio swapin.
>
> Since we can't just check if zswap is enabled or not, we need to
> rather check if the folio (or any part of it) is in zswap or not. We
> can only WARN in that case, but delivering the error to userspace is a
> couple of extra lines of code (not set uptodate), and will make the
> problem much easier to notice.
>
> I am not sure I understand what you mean. The alternative is to
> introduce a config option (perhaps internal) for large folio swapin,
> and make this depend on !CONFIG_ZSWAP, or make zswap refuse to get
> enabled if large folio swapin is enabled (through config or boot
> option). This is until proper handling is added, of course.

Hi Yosry,
My point is that anybody attempts to do large folios swap-in should
either
1. always use small folios if zswap has been once enabled before or now
or
2. address the large folios swapin issues in zswap

there is no 3rd way which you are providing.

it is over-designed to give users true or false based on if data is zswap
as there is always a chance data could be in zswap. so before approach
2 is done, we should always WARN_ON large folios and report data
corruption.

>
> >
> > > +       }
> > > +
> > >         /*
> > >          * When reading into the swapcache, invalidate our entry. The
> > >          * swapcache can be the authoritative owner of the page and
> > > @@ -1590,7 +1610,7 @@ bool zswap_load(struct folio *folio)
> > >                 zswap_entry_free(entry);
> > >                 folio_mark_dirty(folio);
> > >         }
> > > -
> > > +       folio_mark_uptodate(folio);
> > >         return true;
> > >  }
> > >
> > > --
> > > 2.45.2.505.gda0bf45e8d-goog
> > >
> >
> > Thanks
> > Barry

Thanks
Barry

