Return-Path: <linux-kernel+bounces-208837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9B9029C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80516282ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D314F9E4;
	Mon, 10 Jun 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MHUtRCg"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B341B812
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050325; cv=none; b=a9cW3pk1b4p7GJwXXmSR51Z+da7ru/DdPQ8JC8/oCtrbeCLEBvTYxXs89TeiSHiUfvYkQtSZB5aPpd7NdWnz0eNcETbBpbpxSbmxPYmjnHu0eWaulgpXJn4oA0C86lFdq1hB6olhFMiJUJdRbHaTd07pU92e10DbbpP55bIsvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050325; c=relaxed/simple;
	bh=VcP9ObwSXXPcK1mTX8w1cNdVX2agyvoxfDt/RDGP4FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KckLvkS9s9WNC7SkH7wpg3m7LiJIVsoG9X6mP/I7vvWREd9qhdqS8uQl2Tq2T6BzecotNqHggUnM4FG5lm7rQhJziIJbdn16KMiesGBWX1+JqbAZ7CbMfW5vOnFpxt3SoWGAO91YY2jMuLjU1ZoIkLBEBonkHVQHP0mzAJPv4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MHUtRCg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso6984780a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718050321; x=1718655121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+OMv4uqkZA3HiJnLFERokf4naiqqWK7dCPgmQs4qAU=;
        b=0MHUtRCgaOcYeGie13sMac/1VLTJv29B938U1f6eXAu95WlVg4IQPTHxKWn9uT+Gi2
         8m3+X6XkD+tBpLwgvVBihrdQ/5jSrYIgM1KIYmQYUFfflyLo8/O/x443yg6hw0uR2OMK
         aU1JleHDEvWkncNFl+Anuaa0WWMaqPOcO1V3E9cnHjo4CMeU/VYlvEfvqWYg0TJrLSTq
         LaMgu9om+ymgIU+ThLHC3H00h0F89sgp8QA518fEsNy3zfyx9azVv1PitVgQrK8f6V6F
         KmhGwCwKYZQhtULOL/x432YHC3i222i4aK8zxfYt2eXq62dlVA/1gmYE72iQ00VJCIgk
         +zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050321; x=1718655121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+OMv4uqkZA3HiJnLFERokf4naiqqWK7dCPgmQs4qAU=;
        b=BfEerzyz82KQibBP8nSqx2dfZqE83ixki7m+W4OGVscspu7eOGNM69yYE/k+4HuTn9
         eyRtmDSY8qXlE8aPLKizZHokAVuzM0tIApy4lnLz5V1u2kvDOmocLY7J+Z0ef3eq/hkE
         pigFjBZnZPT7haPHx3ne8Asd4OMuUkm9uFYRz44xySpV4p77GLm4UJQHx7wAjFaGv2H8
         JQJPIcSHpAiH5hdFArPq8NM/yYu7IG8ZxeVRx60wmtJj04q7e04OPJ5nk9y/G/Xq+KNA
         r7v0BXmx/N5jq7kB8oMF1odRxGLHhwDTkkYLKhhrwzLuUcNDXHROB96DrQ3WkKBWFInU
         qwbA==
X-Forwarded-Encrypted: i=1; AJvYcCWSpp+fob8Na/uMfLXlrS2oD8gRacNMAPHpU2n3jxDpou+Vp3JKoYd1zxWsEcgj6Tr6V9o/GIrqoZ0pqtXqq2JHIr2YSB2e8NtLAV/9
X-Gm-Message-State: AOJu0YwcGk0/xr8YDQ7KKXRse/ygDZWB73OkX+GldhtLqOED51AMaBhO
	WjJDhA2/trEuj+35QbDiuj92uXvjXQpv3PKJjTACHS3Va/5eUgkCWCq7bz4jJnjAMuoCKFPO2if
	WJ2UjAdIYXeg1VOoIkO9rWt65yui5mLUkYub+EmlQmFH/Yq4UX7MD
X-Google-Smtp-Source: AGHT+IHWilHeDBacjA8+ws/Bwz7RYmfSL0ig50tdAjhy7t5F1gRRT/tcPiVNwm/5kt6HeAHM0Zcet6kEMywTDGeWjOQ=
X-Received: by 2002:a17:906:2994:b0:a6f:1dda:b04f with SMTP id
 a640c23a62f3a-a6f1ddab1c3mr243791266b.17.1718050321093; Mon, 10 Jun 2024
 13:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
 <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com> <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
In-Reply-To: <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 13:11:24 -0700
Message-ID: <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:06=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Jun 11, 2024 at 1:42=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, Jun 7, 2024 at 9:13=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > Zswap does not support storing or loading large folios. Until prope=
r
> > > > support is added, attempts to load large folios from zswap are a bu=
g.
> > > >
> > > > For example, if a swapin fault observes that contiguous PTEs are
> > > > pointing to contiguous swap entries and tries to swap them in as a =
large
> > > > folio, swap_read_folio() will pass in a large folio to zswap_load()=
, but
> > > > zswap_load() will only effectively load the first page in the folio=
. If
> > > > the first page is not in zswap, the folio will be read from disk, e=
ven
> > > > though other pages may be in zswap.
> > > >
> > > > In both cases, this will lead to silent data corruption. Proper sup=
port
> > > > needs to be added before large folio swapins and zswap can work
> > > > together.
> > > >
> > > > Looking at callers of swap_read_folio(), it seems like they are eit=
her
> > > > allocated from __read_swap_cache_async() or do_swap_page() in the
> > > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
> > > > everything is fine for now.
> > > >
> > > > However, there is ongoing work to add to support large folio swapin=
s
> > > > [1]. To make sure new development does not break zswap (or get brok=
en by
> > > > zswap), add minimal handling of incorrect loads of large folios to
> > > > zswap.
> > > >
> > > > First, move the call folio_mark_uptodate() inside zswap_load().
> > > >
> > > > If a large folio load is attempted, and any page in that folio is i=
n
> > > > zswap, return 'true' without calling folio_mark_uptodate(). This wi=
ll
> > > > prevent the folio from being read from disk, and will emit an IO er=
ror
> > > > because the folio is not uptodate (e.g. do_swap_fault() will return
> > > > VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but=
 it
> > > > is better than nothing.
> > > >
> > > > This was tested by hacking the allocation in __read_swap_cache_asyn=
c()
> > > > to use order 2 and __GFP_COMP.
> > > >
> > > > In the future, to handle this correctly, the swapin code should:
> > > > (a) Fallback to order-0 swapins if zswap was ever used on the machi=
ne,
> > > > because compressed pages remain in zswap after it is disabled.
> > > > (b) Add proper support to swapin large folios from zswap (fully or
> > > > partially).
> > > >
> > > > Probably start with (a) then followup with (b).
> > > >
> > > > [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao=
@gmail.com/
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > ---
> > > >
> > > > v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosryahme=
d@google.com/
> > > >
> > > > v1 -> v2:
> > > > - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some reco=
very
> > > >   handling (David Hildenbrand).
> > > >
> > > > ---
> > > >  mm/page_io.c |  1 -
> > > >  mm/zswap.c   | 22 +++++++++++++++++++++-
> > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > > --- a/mm/page_io.c
> > > > +++ b/mm/page_io.c
> > > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struc=
t swap_iocb **plug)
> > > >         delayacct_swapin_start();
> > > >
> > > >         if (zswap_load(folio)) {
> > > > -               folio_mark_uptodate(folio);
> > > >                 folio_unlock(folio);
> > > >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > > >                 swap_read_folio_fs(folio, plug);
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index b9b35ef86d9be..ebb878d3e7865 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> > > >
> > > >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > >
> > > > +       /*
> > > > +        * Large folios should not be swapped in while zswap is bei=
ng used, as
> > > > +        * they are not properly handled. Zswap does not properly l=
oad large
> > > > +        * folios, and a large folio may only be partially in zswap=
.
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
> > > > +       if (folio_test_large(folio)) {
> > > > +               if (xa_find(tree, &offset,
> > > > +                           offset + folio_nr_pages(folio) - 1, XA_=
PRESENT)) {
> > > > +                       WARN_ON_ONCE(1);
> > > > +                       return true;
> > > > +               }
> > > > +               return false;
> > >
> > > IMHO, this appears to be over-designed. Personally, I would opt to
> > > use
> > >
> > >  if (folio_test_large(folio))
> > >                return true;
> >
> > I am sure you mean "return false" here. Always returning true means we
> > will never read a large folio from either zswap or disk, whether it's
> > in zswap or not. Basically guaranteeing corrupting data for large
> > folio swapin, even if zswap is disabled :)
> >
> > >
> > > Before we address large folio support in zswap, it=E2=80=99s essentia=
l
> > > not to let them coexist. Expecting valid data by lunchtime is
> > > not advisable.
> >
> > The goal here is to enable development for large folio swapin without
> > breaking zswap or being blocked on adding support in zswap. If we
> > always return false for large folios, as you suggest, then even if the
> > folio is in zswap (or parts of it), we will go read it from disk. This
> > will result in silent data corruption.
> >
> > As you mentioned before, you spent a week debugging problems with your
> > large folio swapin series because of a zswap problem, and even after
> > then, the zswap_is_enabled() check you had is not enough to prevent
> > problems as I mentioned before (if zswap was enabled before). So we
> > need stronger checks to make sure we don't break things when we
> > support large folio swapin.
> >
> > Since we can't just check if zswap is enabled or not, we need to
> > rather check if the folio (or any part of it) is in zswap or not. We
> > can only WARN in that case, but delivering the error to userspace is a
> > couple of extra lines of code (not set uptodate), and will make the
> > problem much easier to notice.
> >
> > I am not sure I understand what you mean. The alternative is to
> > introduce a config option (perhaps internal) for large folio swapin,
> > and make this depend on !CONFIG_ZSWAP, or make zswap refuse to get
> > enabled if large folio swapin is enabled (through config or boot
> > option). This is until proper handling is added, of course.
>
> Hi Yosry,
> My point is that anybody attempts to do large folios swap-in should
> either
> 1. always use small folios if zswap has been once enabled before or now
> or
> 2. address the large folios swapin issues in zswap
>
> there is no 3rd way which you are providing.
>
> it is over-designed to give users true or false based on if data is zswap
> as there is always a chance data could be in zswap. so before approach
> 2 is done, we should always WARN_ON large folios and report data
> corruption.

We can't always WARN_ON for large folios, as this will fire even if
zswap was never enabled. The alternative is tracking whether zswap was
ever enabled, and checking that instead of checking if any part of the
folio is in zswap.

Basically replacing xa_find(..) with zswap_was_enabled(..) or something.

What I don't like about this is that we will report data corruption
even in cases where data is not really corrupted and it exists on
disk. For example, if zswap is globally enabled but disabled in a
cgroup, there shouldn't be any corruption swapping in large folios.

That being said, I don't feel strongly, as long as we either check
that part of the folio is in zswap or that zswap was ever enabled (or
maybe check if a page was ever stored, just in case zswap was enabled
and immediately disabled).

Johannes, Nhat, any opinions on which way to handle this?

