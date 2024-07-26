Return-Path: <linux-kernel+bounces-262884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1E93CE44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF031F219F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B0157E7D;
	Fri, 26 Jul 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhPPgWeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C62C9A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976430; cv=none; b=b9UOma5R5qssD7h8NemEPdd4QX8xLPcQxzIsAHPtrJaV/pj/wG+G6XzR6kavpWhhseQffBojlmhvkY5SU1yHxcNoQ3agBA1yIpFEG0h5Dvwv6NbxwSowmqiVDpqvtx8izCAsKCRxg7vO9D60ihyaEEdPygqBvpJ3bHR1jF8vmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976430; c=relaxed/simple;
	bh=9pXYPaOveSQt7Odg0mAmxCf3mC1BuqHy2sAFcm+ZhGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovFNA4KSOe8GN/IA4CfVRWHFveccZ0zlHoAvb3iKxsqnAtxqCY2fagYoRB3QkcJ48J1TwvOnNgF4EOgYZ/9npxjmnS582JQzYC2KAbv/5RO/OpnKrTryYUbFHa6IcLmiYQAXbugbU95KDWXM9036l2fWlOLGNPYFVveQv0tSlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhPPgWeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232A9C4AF0B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721976430;
	bh=9pXYPaOveSQt7Odg0mAmxCf3mC1BuqHy2sAFcm+ZhGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mhPPgWeJ+z5vdItQCKyK0EvxkSbxzeWoebci+neP736B7g7uPnmJoyQcjg6aAwuij
	 x+M/d0AHbs2g8cV0TddtUe3Dp0kxNDYT7pa86oanK4kbMwvkSxW2qnrSVI0vh9/zpF
	 dT1Mbjxcaf/k3M0yTZE/hpKf2KCq1QlqTwvcozG0G8yYcY6HZjGHNtHxvwe1+ufk3m
	 +0ws2VEoY7XieYyScdb7FGPN9lL7Kq8jLNsptd/uVOJT6ZnSSuvtkpqFlCJ8npyogs
	 VvCOHhz6nKCDBU6ZLeWNuDWljsTUOiVwXrKRBHWf12aHXkMdaE35yBVGNyILHPUV6n
	 UiZEV5mmtcqeg==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66493332ebfso15399097b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:47:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyRxS3vMKXy/dK2PukSep3r3+bYjwBgbOTw7YAlz74eK/sKDK+ldCz5TyuNZkYiuzzKv34L2wXan0j+eJ/Tegst1KTA7ywRfKTT73Z
X-Gm-Message-State: AOJu0YxWPL1JxryU7BrXtI9b1hlDT5tXMjt8R5BjE54Rc4cyK9O5b7yx
	7MQadFn845h6eajWnfkLB4pGoZRxMzcn64IuGSDX0Ubeju2ZdxvIUYzfa+saNK4XdtXQI7HpAhj
	TKHt9LhWQvVXGtO2TsDb5UaUeuFi8i4i7qWQsbg==
X-Google-Smtp-Source: AGHT+IFWA2OVNxnIvFOlSfx4eVyaM3NAVZ1dMpqErLlVWjyyv5VJaMFRMVu4v3TeFiBHQ/tOHu/K6fRIC8hzmIzgG+c=
X-Received: by 2002:a0d:fc05:0:b0:63c:416f:182d with SMTP id
 00721157ae682-675b43ae3b8mr51802387b3.12.1721976429296; Thu, 25 Jul 2024
 23:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
 <87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com> <CANeU7Qno3o-nDjYP7Pf5ZTB9Oh_zOGU0Sv_kV+aT=Z0j_tdKjg@mail.gmail.com>
 <87bk3pzr5p.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk3pzr5p.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jul 2024 23:46:57 -0700
X-Gmail-Original-Message-ID: <CACePvbXGBNC9WzzL4s2uB2UciOkV6nb4bKKkc5TBZP6QuHS_aQ@mail.gmail.com>
Message-ID: <CACePvbXGBNC9WzzL4s2uB2UciOkV6nb4bKKkc5TBZP6QuHS_aQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Wed, Jun 19, 2024 at 7:32=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > This is the short term solutiolns "swap cluster order" listed
> >> > in my "Swap Abstraction" discussion slice 8 in the recent
> >> > LSF/MM conference.
> >> >
> >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> >> > orders" is introduced, it only allocates the mTHP swap entries
> >> > from new empty cluster list.  It has a fragmentation issue
> >> > reported by Barry.
> >> >
> >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdS=
Mp+Ah+NSgNQ@mail.gmail.com/
> >> >
> >> > The reason is that all the empty cluster has been exhausted while
> >> > there are planty of free swap entries to in the cluster that is
> >> > not 100% free.
> >> >
> >> > Remember the swap allocation order in the cluster.
> >> > Keep track of the per order non full cluster list for later allocati=
on.
> >> >
> >> > User impact: For users that allocate and free mix order mTHP swappin=
g,
> >> > It greatly improves the success rate of the mTHP swap allocation aft=
er the
> >> > initial phase.
> >> >
> >> > Barry provides a test program to show the effect:
> >> > https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmai=
l.com/
> >> >
> >> > Without:
> >> > $ mthp-swapout
> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 5: swpout inc: 110, swpout fallback inc: 117, Fallback per=
centage: 51.54%
> >> > Iteration 6: swpout inc: 0, swpout fallback inc: 230, Fallback perce=
ntage: 100.00%
> >> > Iteration 7: swpout inc: 0, swpout fallback inc: 229, Fallback perce=
ntage: 100.00%
> >> > Iteration 8: swpout inc: 0, swpout fallback inc: 223, Fallback perce=
ntage: 100.00%
> >> > Iteration 9: swpout inc: 0, swpout fallback inc: 224, Fallback perce=
ntage: 100.00%
> >> > Iteration 10: swpout inc: 0, swpout fallback inc: 216, Fallback perc=
entage: 100.00%
> >> > Iteration 11: swpout inc: 0, swpout fallback inc: 212, Fallback perc=
entage: 100.00%
> >> > Iteration 12: swpout inc: 0, swpout fallback inc: 224, Fallback perc=
entage: 100.00%
> >> > Iteration 13: swpout inc: 0, swpout fallback inc: 214, Fallback perc=
entage: 100.00%
> >> >
> >> > $ mthp-swapout -s
> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 5: swpout inc: 33, swpout fallback inc: 197, Fallback perc=
entage: 85.65%
> >> > Iteration 6: swpout inc: 0, swpout fallback inc: 229, Fallback perce=
ntage: 100.00%
> >> > Iteration 7: swpout inc: 0, swpout fallback inc: 223, Fallback perce=
ntage: 100.00%
> >> > Iteration 8: swpout inc: 0, swpout fallback inc: 219, Fallback perce=
ntage: 100.00%
> >> > Iteration 9: swpout inc: 0, swpout fallback inc: 212, Fallback perce=
ntage: 100.00%
> >> >
> >> > With:
> >> > $ mthp-swapout
> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 6: swpout inc: 230, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > ...
> >> > Iteration 94: swpout inc: 224, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 95: swpout inc: 221, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 96: swpout inc: 229, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 97: swpout inc: 219, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 98: swpout inc: 222, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 100: swpout inc: 224, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >> >
> >> > $ mthp-swapout -s
> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 5: swpout inc: 230, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 6: swpout inc: 229, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 7: swpout inc: 223, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > Iteration 8: swpout inc: 219, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >> > ...
> >> > Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 95: swpout inc: 212, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 96: swpout inc: 220, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 97: swpout inc: 220, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 98: swpout inc: 216, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >> > Iteration 100: swpout inc: 225, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >>
> >> Unfortunately, the data is gotten using a special designed test progra=
m
> >> which always swap-in pages with swapped-out size.  I don't know whethe=
r
> >> such workloads exist in reality.  Otherwise, you need to wait for mTHP
> >
> > The test program is designed to simulate mTHP swap behavior using
> > zsmalloc and 64KB buffer.
> > If we insist on only designing for existing workloads, then zsmalloc
> > using 64KB buffer usage will never be able to run, exactly due the
> > kernel has high failure rate allocating swap entries for 64KB. There
> > is a bit of a chick and egg problem there, such a usage can not exist
> > because the kernel can't support it yet. Kernel can't add patches to
> > support it because such simulation tests are not "real".
> >
> > We need to break this cycle to support something new.
> >
> >> swap-in to be merged firstly, and people reach consensus that we shoul=
d
> >> always swap-in pages with swapped-out size.
> >
> > We don't have to be always. We can identify the situation that makes
> > sense. For the zram/zsmalloc 64K buffer usage case, swap out as the
> > same swap in size makes sense.
> > I think we have agreement on such zsmalloc 64K usage cases we do want
> > to support.
> >
> >>
> >> Alternately, we can make some design adjustment to make the patchset
> >> work in current situation (mTHP swap-out, normal page swap-in).
> >>
> >> - One non-full cluster list for each order (same as current design)
> >>
> >> - When one swap entry is freed, check whether one "order+1" swap entry
> >>   becomes free, if so, move the cluster to "order+1" non-full cluster
> >>   list.
> >
> > In the intended zsmalloc usage case, there is no order+1 swap entry
> > request.
>
> This my main concern about this series.  Only the Android use cases are
> considered.  The general use cases are just ignored.  Is it hard to
> consider or test a normal swap partition on your development machine?

Please see the V4 cover letter. The V4 already has the SSD, zram and
HDD stress testing.
Of course I want to make sure the allocator works well with Barry's
mthp test case as well.

> > Moving the cluster to "order+1" will make less cluster available for "o=
rder".
> > For that usage case it is negative gain.
>
> The "order+1" cluster can be used to allocate "order" cluster when
> existing "order" cluster is used up.
>
> And in this way, we can protect clusters with more free spaces so that
> they may become free.
>
> >> - When allocate swap entry with "order", get cluster from free, "order=
",
> >>   "order+1", ... non-full cluster list.  If all are empty, fallback to
> >
> > I don't see that it is useful for the zsmalloc 64K buffer usage case.
> > There will be order 0 and order 4 and nothing else.
> >
> > How about let's keep it simple for now. If we identify some workload
> > this algorithm can help. We can do that as a follow up step.
>
> The simple design isn't flexible enough for your workloads too.  For
> example,
>
> - Initially, almost only order-0 pages are swapped out, most non-full
>   clusters are order-0.
>
> - Later, quite some order-0 swap entries are freed so that there are
>   quite some order-4 swap entries available.
>
> - Order-4 pages need to be swapped out, but no enough order-4 non-full
>   clusters available.
>
> So, we need a way to migrate non-full clusters among orders to adjust to
> the situations automatically.

Depends on how lucky it is to form the order-4 cluster naturally. The
odds of forming the order-4 cluster naturally in random swap
allocation/ free case is very low. I have the number in my other email
thread.
Anyway, if we convince this payout for the complexity it introduces,
we can do that as follow up steps. Try to keep things simple at first
for the review benefit.

>
> >>   order 0.
> >>
> >> Do you think that this works?
> >>
> >> > Reported-by: Barry Song <21cnbao@gmail.com>
> >> > Signed-off-by: Chris Li <chrisl@kernel.org>
> >> > ---
> >> > Changes in v3:
> >> > - Using V1 as base.
> >> > - Rename "next" to "list" for the list field, suggested by Ying.
> >> > - Update comment for the locking rules for cluster fields and list,
> >> >   suggested by Ying.
> >> > - Allocate from the nonfull list before attempting free list, sugges=
ted
> >> >   by Kairui.
> >>
> >> Haven't looked into this.  It appears that this breaks the original
> >> discard behavior which helps performance of some SSD, please refer to
> >
> > Can you clarify by "discard" you mean SSD discard command or just the
> > way swap allocator recycles free clusters?
>
> The SSD discard command, like in the following URL,
>
> https://en.wikipedia.org/wiki/Trim_(computing)

Thanks. I know what an SSD discard command is. Want to understand why
that behavior is preferred.

So the reasoning to prefer a new free block rather than a recent
particle free cluster is to let the previous written cluster have a
higher chance to issue the discard command?

This preferred new block behavior is actually not friendly to SSD from
a wearing point of view.
Take this example:
Let say the data need to allocate and free from swap. At any given
time the swap usage is 1G. The swap SSD drive is 16G.
Let say the allocation and free are at random 4K page locations. There
is totally 64G swap data needed to write to swap, but at any given
time there is only 1G data occupite on swapfile.

a) If you always prefer new free blocks. Then the swap data will
eventually write at all 16G drives then random write to full 16G.
Chance of forming a free cluster so a discard command can be issued is
very low. (15/16)**512 =3D 4.4E-15. From SSD point of view, it does not
know most of the data written to 16G drive is not used. When a page is
free on a swapfile, SSD drive doesn't know about it. It sees 4K random
writes to all 16G of the drive, total 64G data written.

b) If you always prefer a non full cluster first over a new cluster.
The 64G data will concentrate random writing to the first 1G of drive
location. Total 64G data written.

I consider b) are more friendly to SSD than a). Because concentrate
the write into the first 1G location. The SSD can know the data
overwritten in those 1G has internally obsolete, so it can internally
GC the those overwritten data without a discard command. Where a)
random 4K writes to the whole drive without much discard at all. Full
SSD doing random writes is a bad combination from a wearing point of
view.

Just my 2 cents. Anyway I revert the V4 to use free cluster before
nonfull cluster just to behave the same as previously.

> >> commit 2a8f94493432 ("swap: change block allocation algorithm for SSD"=
).
> >
> > I did read that change log. Help me understand in more detail which
> > discard behavior you have in mind. A lot of low end micro SD cards
> > have proper FTL wear leveling now, ssd even better on that.
>
> It's not FTL, it's discard/trim for SSD as above.

Thanks for the clarification.

>
> >> And as pointed out by Ryan, this may reduce the opportunity of the
> >> sequential block device writing during swap-out, which may hurt
> >> performance of SSD too.
> >
> > Only at the initial phase. If the swap IO continues, after the first
> > pass fills up the swap file, the write will be random on the swapfile
> > anyway. Because the swapfile only issues 2M discards commands when all
> > 512 4K pages are free. The discarded area will be much smaller than
> > the free area on swapfile. That combined with the random write page on
> > the whole swap file. It might produce a worse internal write
> > amplification for SSD, compared to only writing a subset of the
> > swapfile area. I would love to hear from someone who understands SSD
> > internals to confirm or deny my theory.
>
> It depends on workloads.  Some workloads will have more severe
> fragmentation than others.  For example, on quite some machines, the
> swap devices will be far from being full to avoid possible OOM.

I suspect most of the SSD swap on client devices nowadays are only as
backup just in case it needs to be swapped.
There is not much SSD swap IO during normal use. The zram and zswap
are more actively used in the data center and Android phone case, from
swap IO ops point of view.

>
> > Even let's assume the SSD wants a free block over a nonfull cluster
> > first. Zswap and zram swap are not subject to SSD property. We might
> > want to have a kernel option to select using  nonfree clusters over
> > the free one for zram and zswap (ghost swapfile). That will help
> > contain the fragmented swap area.
>
> I suspect that it will help fragmentation avoidance much.  Please prove
> its effectiveness with data firstly.  It can be a further optimization
> patch in the series.

Take the above 1GB data written in a 16GB drive example. a) will
fragment the whole 16GB drive.
b) will concentrate on the first 1GB location that was used.

>
> Even if we really need it, we can try to do it without a kernel option.
> For example, detect whether we are using zram and enable it for zram
> automatically (through a general flag).

zswap you need to have an option to choose from because it can write
to the real swappfile as well.
Do you optimize the swap allocator for the zswap or physical swapfile.

Chris

