Return-Path: <linux-kernel+bounces-208898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE9902A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90175B247DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51C4D8DD;
	Mon, 10 Jun 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7g5iqkB"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72714277
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053218; cv=none; b=jirBzNla3myfSwYExCqjnX64ACI92H6IiNipoCN5K/OVLmd+WLi2ZvfrsRkxNeoVd773Uq2Wa+KeSI98Os6hkuja1y4bBCUrfFS8RpIJo2tZQE7BsXtOWSKjJpLPmhMJ5091F9v9JQfp6UL6fA1o61d7rr7SKbT0HpPNfXJWlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053218; c=relaxed/simple;
	bh=8aUfNtikBLLbp2+cc77ISu5UUl3Dk8uk/ThHaiwku3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AivFpCeDzNjYJ95QwpKZMh5P6er4UZuOJS6oaWe7oUmFmQYIpspMw+sMTOzRP0Ki/m/PjRDLpBGTg5LevYMScXkhzvO9YegvSA+l20RKsXeZP+ULI5BEpaWRMs1P/gHvirted1j4tKI6sWSN+omaG2ekckjz6ZPZiKNppmUU+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7g5iqkB; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80b76c5de79so970049241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718053216; x=1718658016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtglSl5nJSLjnhryyMKeeZ/HJbTMOfyFyynMlPClQCc=;
        b=S7g5iqkBAn9Nkt9hF52GSHl6mtua/tm7e5AywAH6vgSEx0GW+eZahebdCRgobamYxE
         FG4m6M95cXPQwsVw0cu8rpBI5eO3p7DbYIkmRGA63hazjQ2utfXr8yPyIsR+FJ8V/Fgw
         Q3ar9RaGuVNp55eeZONSncYj37LMfqNQLyK6r5bPX2vc7h4Psexp8VKQJWLxBQa/JXe8
         TYPf1DgZ4Z242ewKve3cGe2NZDOHbDVfXtrVRFImZYF0J0hRf+H8MSjdYxAKTy0yK2lI
         bQwSEzbx0MWOA4W93asIyP0ff0YKsqrGbPejrOOI0jj4xkEjil6sV4C42tYivVbPRr23
         uuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053216; x=1718658016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtglSl5nJSLjnhryyMKeeZ/HJbTMOfyFyynMlPClQCc=;
        b=BOaPJGQJKYqoB9EKfgSwX2nNCfZV5YTcBYwNFxfoh740i413xMzU/uLzlDPxVQXjMd
         tl/k/3tFIJ6NYXGUd/DHbmErY5AlxIh9MYHlZHW4q38YxumcXWkskzCqQ0BJM+988DfL
         xCJpSs7HmICEu8C8NTI1hv6hQKeanSsMFG+fvKNgQ7ml0MYDPpD7e9Jq96gZtTavTesJ
         2pgoT/DlXwSaPvT4K3t63TitA6C53YETc1Q5VJLYfx/Ub17D6AYVMPdHbA0SBVd7SO/t
         qCaxn9VTEpDVWTHte3RWhbCmDZ6TAjLPcQyrsoUSlzYsmopyiL6OVnBYMfnhhTFzCk74
         yYIg==
X-Forwarded-Encrypted: i=1; AJvYcCWrDAv9FMnTlieCsvHCnJRllP6wXLtdkzbN+MDnb5CAAyd2riBTFgfJk5F0ITIvCHhn5rh2yg4jBvFba/n7xHyiaJwks4RFJFb0Kd1v
X-Gm-Message-State: AOJu0YxoQm9afWwJOUXXW1NuiG2LLgSj1BvSpnpa9ytGCKlJ4j8vtil5
	PuKJMp8yg29JG/RM2syFK6cAZ94m2K+yk4uBuPMj7icOlPnRRp+w+XGlzNIyPuOUDQlZYU9EtaN
	Pq2crkYc4RUefwQ6fNo/c8w5HSc0=
X-Google-Smtp-Source: AGHT+IFH91cYPqMQB2e5MjF84hEcwy9PEyTQdAbTPdEmgy+aTCyASRVIIvuAoOCusr9Da2e6/clC8wkqB0yx3OleiMk=
X-Received: by 2002:a05:6102:1277:b0:48c:329c:b3dc with SMTP id
 ada2fe7eead31-48c329cb660mr9229115137.11.1718053214959; Mon, 10 Jun 2024
 14:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
 <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
 <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com> <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com>
In-Reply-To: <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Jun 2024 05:00:03 +0800
Message-ID: <CAGsJ_4zNxC5u088RRnKeM18skEJvwTd22mB_FWSA67K3S-CKPw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 4:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Jun 10, 2024 at 1:06=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Jun 11, 2024 at 1:42=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Fri, Jun 7, 2024 at 9:13=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > > >
> > > > On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > Zswap does not support storing or loading large folios. Until pro=
per
> > > > > support is added, attempts to load large folios from zswap are a =
bug.
> > > > >
> > > > > For example, if a swapin fault observes that contiguous PTEs are
> > > > > pointing to contiguous swap entries and tries to swap them in as =
a large
> > > > > folio, swap_read_folio() will pass in a large folio to zswap_load=
(), but
> > > > > zswap_load() will only effectively load the first page in the fol=
io. If
> > > > > the first page is not in zswap, the folio will be read from disk,=
 even
> > > > > though other pages may be in zswap.
> > > > >
> > > > > In both cases, this will lead to silent data corruption. Proper s=
upport
> > > > > needs to be added before large folio swapins and zswap can work
> > > > > together.
> > > > >
> > > > > Looking at callers of swap_read_folio(), it seems like they are e=
ither
> > > > > allocated from __read_swap_cache_async() or do_swap_page() in the
> > > > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, s=
o
> > > > > everything is fine for now.
> > > > >
> > > > > However, there is ongoing work to add to support large folio swap=
ins
> > > > > [1]. To make sure new development does not break zswap (or get br=
oken by
> > > > > zswap), add minimal handling of incorrect loads of large folios t=
o
> > > > > zswap.
> > > > >
> > > > > First, move the call folio_mark_uptodate() inside zswap_load().
> > > > >
> > > > > If a large folio load is attempted, and any page in that folio is=
 in
> > > > > zswap, return 'true' without calling folio_mark_uptodate(). This =
will
> > > > > prevent the folio from being read from disk, and will emit an IO =
error
> > > > > because the folio is not uptodate (e.g. do_swap_fault() will retu=
rn
> > > > > VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, b=
ut it
> > > > > is better than nothing.
> > > > >
> > > > > This was tested by hacking the allocation in __read_swap_cache_as=
ync()
> > > > > to use order 2 and __GFP_COMP.
> > > > >
> > > > > In the future, to handle this correctly, the swapin code should:
> > > > > (a) Fallback to order-0 swapins if zswap was ever used on the mac=
hine,
> > > > > because compressed pages remain in zswap after it is disabled.
> > > > > (b) Add proper support to swapin large folios from zswap (fully o=
r
> > > > > partially).
> > > > >
> > > > > Probably start with (a) then followup with (b).
> > > > >
> > > > > [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnb=
ao@gmail.com/
> > > > >
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > ---
> > > > >
> > > > > v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosryah=
med@google.com/
> > > > >
> > > > > v1 -> v2:
> > > > > - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some re=
covery
> > > > >   handling (David Hildenbrand).
> > > > >
> > > > > ---
> > > > >  mm/page_io.c |  1 -
> > > > >  mm/zswap.c   | 22 +++++++++++++++++++++-
> > > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > > > --- a/mm/page_io.c
> > > > > +++ b/mm/page_io.c
> > > > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, str=
uct swap_iocb **plug)
> > > > >         delayacct_swapin_start();
> > > > >
> > > > >         if (zswap_load(folio)) {
> > > > > -               folio_mark_uptodate(folio);
> > > > >                 folio_unlock(folio);
> > > > >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > > > >                 swap_read_folio_fs(folio, plug);
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index b9b35ef86d9be..ebb878d3e7865 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> > > > >
> > > > >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > > >
> > > > > +       /*
> > > > > +        * Large folios should not be swapped in while zswap is b=
eing used, as
> > > > > +        * they are not properly handled. Zswap does not properly=
 load large
> > > > > +        * folios, and a large folio may only be partially in zsw=
ap.
> > > > > +        *
> > > > > +        * If any of the subpages are in zswap, reading from disk=
 would result
> > > > > +        * in data corruption, so return true without marking the=
 folio uptodate
> > > > > +        * so that an IO error is emitted (e.g. do_swap_page() wi=
ll sigfault).
> > > > > +        *
> > > > > +        * Otherwise, return false and read the folio from disk.
> > > > > +        */
> > > > > +       if (folio_test_large(folio)) {
> > > > > +               if (xa_find(tree, &offset,
> > > > > +                           offset + folio_nr_pages(folio) - 1, X=
A_PRESENT)) {
> > > > > +                       WARN_ON_ONCE(1);
> > > > > +                       return true;
> > > > > +               }
> > > > > +               return false;
> > > >
> > > > IMHO, this appears to be over-designed. Personally, I would opt to
> > > > use
> > > >
> > > >  if (folio_test_large(folio))
> > > >                return true;
> > >
> > > I am sure you mean "return false" here. Always returning true means w=
e
> > > will never read a large folio from either zswap or disk, whether it's
> > > in zswap or not. Basically guaranteeing corrupting data for large
> > > folio swapin, even if zswap is disabled :)
> > >
> > > >
> > > > Before we address large folio support in zswap, it=E2=80=99s essent=
ial
> > > > not to let them coexist. Expecting valid data by lunchtime is
> > > > not advisable.
> > >
> > > The goal here is to enable development for large folio swapin without
> > > breaking zswap or being blocked on adding support in zswap. If we
> > > always return false for large folios, as you suggest, then even if th=
e
> > > folio is in zswap (or parts of it), we will go read it from disk. Thi=
s
> > > will result in silent data corruption.
> > >
> > > As you mentioned before, you spent a week debugging problems with you=
r
> > > large folio swapin series because of a zswap problem, and even after
> > > then, the zswap_is_enabled() check you had is not enough to prevent
> > > problems as I mentioned before (if zswap was enabled before). So we
> > > need stronger checks to make sure we don't break things when we
> > > support large folio swapin.
> > >
> > > Since we can't just check if zswap is enabled or not, we need to
> > > rather check if the folio (or any part of it) is in zswap or not. We
> > > can only WARN in that case, but delivering the error to userspace is =
a
> > > couple of extra lines of code (not set uptodate), and will make the
> > > problem much easier to notice.
> > >
> > > I am not sure I understand what you mean. The alternative is to
> > > introduce a config option (perhaps internal) for large folio swapin,
> > > and make this depend on !CONFIG_ZSWAP, or make zswap refuse to get
> > > enabled if large folio swapin is enabled (through config or boot
> > > option). This is until proper handling is added, of course.
> >
> > Hi Yosry,
> > My point is that anybody attempts to do large folios swap-in should
> > either
> > 1. always use small folios if zswap has been once enabled before or now
> > or
> > 2. address the large folios swapin issues in zswap
> >
> > there is no 3rd way which you are providing.
> >
> > it is over-designed to give users true or false based on if data is zsw=
ap
> > as there is always a chance data could be in zswap. so before approach
> > 2 is done, we should always WARN_ON large folios and report data
> > corruption.
>
> We can't always WARN_ON for large folios, as this will fire even if
> zswap was never enabled. The alternative is tracking whether zswap was
> ever enabled, and checking that instead of checking if any part of the
> folio is in zswap.
>
> Basically replacing xa_find(..) with zswap_was_enabled(..) or something.

My point is that mm core should always fallback

if (zswap_was_or_is_enabled())
     goto fallback;

till zswap fixes the issue. This is the only way to enable large folios swa=
p-in
development before we fix zswap.

>
> What I don't like about this is that we will report data corruption
> even in cases where data is not really corrupted and it exists on
> disk. For example, if zswap is globally enabled but disabled in a
> cgroup, there shouldn't be any corruption swapping in large folios.
>
> That being said, I don't feel strongly, as long as we either check
> that part of the folio is in zswap or that zswap was ever enabled (or
> maybe check if a page was ever stored, just in case zswap was enabled
> and immediately disabled).
>
> Johannes, Nhat, any opinions on which way to handle this?

Thanks
Barry

