Return-Path: <linux-kernel+bounces-208905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D033902A76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F571F249A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E126F306;
	Mon, 10 Jun 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E75d12JX"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C947A40
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053939; cv=none; b=G7Bdh0XKlBrgMyGiqP0xl+Ghhj33q3sRG+iy4HXeWivT9CLUi4b2EiAAgubXAc3xCWsidPMH1oGVA2HYrNhL+ANT9zzWZttnU9EFX0Cvoyg2JCJjkz/AK9SEwMEwEu6sQRbFnlNUCUgYyqtZzaPew3cgUAjxVIogbZVbE41dbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053939; c=relaxed/simple;
	bh=6HhADaMBbEyoScJs8v/thCbLenv1FNwaIsawu+YyByE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imbprcDPxU7Mp/hPQlNHt1Fk5s/uN7C+Bjb2F8Ep4qiTcGW+37bU5Cb/Ag0KeLr7EK9u//cWMAdCbHRRZL9MqCPSXE/eL3AZxQvRN+VgJFINyXkXl0HE83bZrdG4mE73M6HQx35KtJJpX+gvlYH2QIX9HIj+NGrTiNjGpXKc6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E75d12JX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6efe62f583so28095166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718053936; x=1718658736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uy3FcrR56dAJ33BptXmeq82zQbFLSxbtr1pm6OxI94=;
        b=E75d12JXgFIRLQ2/fRUzMkO4+N/oFAyBXT4oB7zeyA+6PZsTg+5PtaYcO9fBVXAopk
         PfQo+GoyzTprIlFePNPgfqxDz1mHBMzvT0k8kV5jwSQrhma0DKdGSMqFeg1Yx7HZbP9K
         6TYj92u5r7kcWyX5a4pY8qGaH7hZXDkqG6Yaq5qAHiXgN9Z1mvF8GZc7z3mX6XmSXBeq
         WDwNWnmJtej9SlezbmGx7X2VmOzDfqU7rBDgH6tWIPVtlhsHOEKtae+B2vPBNmviuI7V
         zwz4XXuMERlVNGo7OjjI8rhafCxmOXvfoNkPPZyd03oLSZ6LbT9C0UvGr7ddCMJMdLJj
         lhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053936; x=1718658736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uy3FcrR56dAJ33BptXmeq82zQbFLSxbtr1pm6OxI94=;
        b=A77+MhMilCFradBXkCmYy1LLU5cKTG80X0Mp0zpgLIH1vnAjXHWNu3ReeH0kY7f/Pn
         PEiqZZ/xrBi6YXL5d825htmtzFqHotCO7AyMdW075Hpq1Fj2S+gTSbji2L/zw+O0ZkV0
         NkkY3m2FGbgRuxhTEqD4vekNGyxt8F/gQBk468JnQv1HzDjfdNRiQ7vPygJbxG9Tj/fE
         5zO5SrF6jIwTnjyB9AsaL4Hl/PuHqVDaIqcAIUEv1imNTjulqciewpftlQ48JOq0etuW
         VmReCktiiO/Q5zEIWpkvCsdU1CsxLVnEb4jytxskKG8TtxIt21RcgymwN8BqRD0BVYRg
         loCA==
X-Forwarded-Encrypted: i=1; AJvYcCU+R4x5LHjDIJPD5KGXWTYSLO1y76XzSYVoL+bX0OfrNA7J8oo4MCzrAHhPm1oTMxhF1EcixFpm90zvkf9PNj1CeF7dgIxaRmwycUep
X-Gm-Message-State: AOJu0YyysAgxsoSArNwNf0kU9AnFgFaatBRineHdGD1rGd+cjFMZ9bnX
	dAHlvJJglAZ/Fs2VB47CkFJDOkgGAl0ruTMU6JoIBZQN6xYMf2PK6IqiPpQWqSXb44arETjVgPU
	+yei/IYFJ+D5Gl/RFAw6NALi3pKmweWzoDd9F
X-Google-Smtp-Source: AGHT+IEASnD5ua9yfrdUtvIzu+Lw46QXFzbx9CRxofl4dQ+vje03VpXXKBLIh1iGcqO9u1jSSMdugvsncTIN1lM0/tY=
X-Received: by 2002:a17:906:7fd0:b0:a6e:2275:95b8 with SMTP id
 a640c23a62f3a-a6e2275962emr460685966b.64.1718053935639; Mon, 10 Jun 2024
 14:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
 <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
 <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
 <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com> <CAGsJ_4zNxC5u088RRnKeM18skEJvwTd22mB_FWSA67K3S-CKPw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zNxC5u088RRnKeM18skEJvwTd22mB_FWSA67K3S-CKPw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 14:11:36 -0700
Message-ID: <CAJD7tkb0Rv4mSPS3DXqF888iVwd++nd99N3WrZYuJhLPDN+dhA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 2:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Jun 11, 2024 at 4:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Jun 10, 2024 at 1:06=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Tue, Jun 11, 2024 at 1:42=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Fri, Jun 7, 2024 at 9:13=E2=80=AFPM Barry Song <21cnbao@gmail.co=
m> wrote:
> > > > >
> > > > > On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed@g=
oogle.com> wrote:
> > > > > >
> > > > > > Zswap does not support storing or loading large folios. Until p=
roper
> > > > > > support is added, attempts to load large folios from zswap are =
a bug.
> > > > > >
> > > > > > For example, if a swapin fault observes that contiguous PTEs ar=
e
> > > > > > pointing to contiguous swap entries and tries to swap them in a=
s a large
> > > > > > folio, swap_read_folio() will pass in a large folio to zswap_lo=
ad(), but
> > > > > > zswap_load() will only effectively load the first page in the f=
olio. If
> > > > > > the first page is not in zswap, the folio will be read from dis=
k, even
> > > > > > though other pages may be in zswap.
> > > > > >
> > > > > > In both cases, this will lead to silent data corruption. Proper=
 support
> > > > > > needs to be added before large folio swapins and zswap can work
> > > > > > together.
> > > > > >
> > > > > > Looking at callers of swap_read_folio(), it seems like they are=
 either
> > > > > > allocated from __read_swap_cache_async() or do_swap_page() in t=
he
> > > > > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios,=
 so
> > > > > > everything is fine for now.
> > > > > >
> > > > > > However, there is ongoing work to add to support large folio sw=
apins
> > > > > > [1]. To make sure new development does not break zswap (or get =
broken by
> > > > > > zswap), add minimal handling of incorrect loads of large folios=
 to
> > > > > > zswap.
> > > > > >
> > > > > > First, move the call folio_mark_uptodate() inside zswap_load().
> > > > > >
> > > > > > If a large folio load is attempted, and any page in that folio =
is in
> > > > > > zswap, return 'true' without calling folio_mark_uptodate(). Thi=
s will
> > > > > > prevent the folio from being read from disk, and will emit an I=
O error
> > > > > > because the folio is not uptodate (e.g. do_swap_fault() will re=
turn
> > > > > > VM_FAULT_SIGBUS). It may not be reliable recovery in all cases,=
 but it
> > > > > > is better than nothing.
> > > > > >
> > > > > > This was tested by hacking the allocation in __read_swap_cache_=
async()
> > > > > > to use order 2 and __GFP_COMP.
> > > > > >
> > > > > > In the future, to handle this correctly, the swapin code should=
:
> > > > > > (a) Fallback to order-0 swapins if zswap was ever used on the m=
achine,
> > > > > > because compressed pages remain in zswap after it is disabled.
> > > > > > (b) Add proper support to swapin large folios from zswap (fully=
 or
> > > > > > partially).
> > > > > >
> > > > > > Probably start with (a) then followup with (b).
> > > > > >
> > > > > > [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21c=
nbao@gmail.com/
> > > > > >
> > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > > ---
> > > > > >
> > > > > > v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosry=
ahmed@google.com/
> > > > > >
> > > > > > v1 -> v2:
> > > > > > - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some =
recovery
> > > > > >   handling (David Hildenbrand).
> > > > > >
> > > > > > ---
> > > > > >  mm/page_io.c |  1 -
> > > > > >  mm/zswap.c   | 22 +++++++++++++++++++++-
> > > > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > > > > --- a/mm/page_io.c
> > > > > > +++ b/mm/page_io.c
> > > > > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, s=
truct swap_iocb **plug)
> > > > > >         delayacct_swapin_start();
> > > > > >
> > > > > >         if (zswap_load(folio)) {
> > > > > > -               folio_mark_uptodate(folio);
> > > > > >                 folio_unlock(folio);
> > > > > >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > > > > >                 swap_read_folio_fs(folio, plug);
> > > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > > index b9b35ef86d9be..ebb878d3e7865 100644
> > > > > > --- a/mm/zswap.c
> > > > > > +++ b/mm/zswap.c
> > > > > > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> > > > > >
> > > > > >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > > > >
> > > > > > +       /*
> > > > > > +        * Large folios should not be swapped in while zswap is=
 being used, as
> > > > > > +        * they are not properly handled. Zswap does not proper=
ly load large
> > > > > > +        * folios, and a large folio may only be partially in z=
swap.
> > > > > > +        *
> > > > > > +        * If any of the subpages are in zswap, reading from di=
sk would result
> > > > > > +        * in data corruption, so return true without marking t=
he folio uptodate
> > > > > > +        * so that an IO error is emitted (e.g. do_swap_page() =
will sigfault).
> > > > > > +        *
> > > > > > +        * Otherwise, return false and read the folio from disk=
.
> > > > > > +        */
> > > > > > +       if (folio_test_large(folio)) {
> > > > > > +               if (xa_find(tree, &offset,
> > > > > > +                           offset + folio_nr_pages(folio) - 1,=
 XA_PRESENT)) {
> > > > > > +                       WARN_ON_ONCE(1);
> > > > > > +                       return true;
> > > > > > +               }
> > > > > > +               return false;
> > > > >
> > > > > IMHO, this appears to be over-designed. Personally, I would opt t=
o
> > > > > use
> > > > >
> > > > >  if (folio_test_large(folio))
> > > > >                return true;
> > > >
> > > > I am sure you mean "return false" here. Always returning true means=
 we
> > > > will never read a large folio from either zswap or disk, whether it=
's
> > > > in zswap or not. Basically guaranteeing corrupting data for large
> > > > folio swapin, even if zswap is disabled :)
> > > >
> > > > >
> > > > > Before we address large folio support in zswap, it=E2=80=99s esse=
ntial
> > > > > not to let them coexist. Expecting valid data by lunchtime is
> > > > > not advisable.
> > > >
> > > > The goal here is to enable development for large folio swapin witho=
ut
> > > > breaking zswap or being blocked on adding support in zswap. If we
> > > > always return false for large folios, as you suggest, then even if =
the
> > > > folio is in zswap (or parts of it), we will go read it from disk. T=
his
> > > > will result in silent data corruption.
> > > >
> > > > As you mentioned before, you spent a week debugging problems with y=
our
> > > > large folio swapin series because of a zswap problem, and even afte=
r
> > > > then, the zswap_is_enabled() check you had is not enough to prevent
> > > > problems as I mentioned before (if zswap was enabled before). So we
> > > > need stronger checks to make sure we don't break things when we
> > > > support large folio swapin.
> > > >
> > > > Since we can't just check if zswap is enabled or not, we need to
> > > > rather check if the folio (or any part of it) is in zswap or not. W=
e
> > > > can only WARN in that case, but delivering the error to userspace i=
s a
> > > > couple of extra lines of code (not set uptodate), and will make the
> > > > problem much easier to notice.
> > > >
> > > > I am not sure I understand what you mean. The alternative is to
> > > > introduce a config option (perhaps internal) for large folio swapin=
,
> > > > and make this depend on !CONFIG_ZSWAP, or make zswap refuse to get
> > > > enabled if large folio swapin is enabled (through config or boot
> > > > option). This is until proper handling is added, of course.
> > >
> > > Hi Yosry,
> > > My point is that anybody attempts to do large folios swap-in should
> > > either
> > > 1. always use small folios if zswap has been once enabled before or n=
ow
> > > or
> > > 2. address the large folios swapin issues in zswap
> > >
> > > there is no 3rd way which you are providing.
> > >
> > > it is over-designed to give users true or false based on if data is z=
swap
> > > as there is always a chance data could be in zswap. so before approac=
h
> > > 2 is done, we should always WARN_ON large folios and report data
> > > corruption.
> >
> > We can't always WARN_ON for large folios, as this will fire even if
> > zswap was never enabled. The alternative is tracking whether zswap was
> > ever enabled, and checking that instead of checking if any part of the
> > folio is in zswap.
> >
> > Basically replacing xa_find(..) with zswap_was_enabled(..) or something=
.
>
> My point is that mm core should always fallback
>
> if (zswap_was_or_is_enabled())
>      goto fallback;
>
> till zswap fixes the issue. This is the only way to enable large folios s=
wap-in
> development before we fix zswap.

I agree with this, I just want an extra fallback in zswap itself in
case something was missed during large folio swapin development (which
can evidently happen).

