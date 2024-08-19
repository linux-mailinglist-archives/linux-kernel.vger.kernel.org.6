Return-Path: <linux-kernel+bounces-292929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44B957694
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F042A28789E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A641DD3A0;
	Mon, 19 Aug 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRIvyYtC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1151DD392
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102843; cv=none; b=SEvjp6975U2HaJbUJqpSRliEBEGu/VwUmhXIExxTzLC+Ju1bzl755jbKie2QQD8v5qOMV27CXZmZ6cbE+R/CV9tQp6MJ3WXpGhGP5+w6lY/SjLHURbW4p+3Q5y8CIJLyf+vwt9wK7+Rba9f2I1n+mQTPie1L2UBT3GEo0Bikazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102843; c=relaxed/simple;
	bh=S4kh0/Eh3K6kZK8lvHik8ZeQrONg9hM17fHH8RMuyIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzh3/gHslx0w+swDX7hVsQLWEFQiNWEXvGq6G+CAfrWnLRm+iSaI0TNb+cByHXBkOoskuQgdVZNare5ODDbGjTBjz2P9v9wgHKd6p8U+qdZwqpDix3UKn1yVKDY1ljojiA4vAc/+wZZCb/qOLvlunL2gQXUW5lOVKBgNbT184DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRIvyYtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B028C4AF0E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724102842;
	bh=S4kh0/Eh3K6kZK8lvHik8ZeQrONg9hM17fHH8RMuyIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NRIvyYtC7JAYcGE1zDeYx4Asg2lKrE26OIhnR/6N5Pxg5vyy0v/Kqp1o8oHvIGoc+
	 MvYz4QXfe9gh7Iea5vRAmUmffDte7Nhyys21Nd5VowmIQ5e6BV8WPNg6w48yDhRLy5
	 AF0CLLRz7p+mRB8jri5cGNF67wkzLwfNI43dLFrKUSPwdPXBXs/Md7OBh0CTeInZ0n
	 z+ZrjAxvMW93uR5kZ66eIxakDpT4hDqZNAcd4AfO2KIiE6vmeUw0W5tJlsWhiMN0mV
	 5FZ2AfwQn0qFyhtyvbLAO/A8+BRqx7wz4AElQDAtKLf0fpdKHahPmuJO9GvoOxu2OM
	 Bqt6vzp6b9VRA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-690e9001e01so46416977b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:27:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcq1ZBmdH/sqYktVP6AVNI0PmQbNSK4a/6wgT70yNHtA83F+45oiWjj8AsuDoHL/50cWbNPByKmkcB4aeA3XM//3MrKMI5Ucmk5WIo
X-Gm-Message-State: AOJu0Yxxc2T5G+jCIO9EUsIoKxNLJkXc+EMuZ7+XewPVSOC/oh3bd7iL
	8UzgCGuPM1jvxtDcPnEsKu/MjRbTI28+C6lqlgeBKIlxdpRadParbApAecsOsLFxHWEUgdW4c4X
	bgbGk9Tv7CR0KMNpDair8yI8yeoiAj5WFEQtprw==
X-Google-Smtp-Source: AGHT+IHkY0Mt5ULs8jpDmsWONACCBqFATj6UWmYPvOOtw9yfwIeD2mNjPJbkHH9yAqZjMYom0C9vVWp+DT1R2ef8y1I=
X-Received: by 2002:a05:690c:670f:b0:6b1:8d2:8819 with SMTP id
 00721157ae682-6b1ba7e665fmr149331347b3.15.1724102841886; Mon, 19 Aug 2024
 14:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
 <87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
 <CAMgjq7DJwF+kwxJkDKnH-cnp-36xdEObrNpKGrH_GvNKQtqjSw@mail.gmail.com>
 <87ttfghq7o.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7AOBvE7cfhxh8VGTqVWvYJqL3wKH7K-Qi0ZCU_h2nGHAA@mail.gmail.com>
In-Reply-To: <CAMgjq7AOBvE7cfhxh8VGTqVWvYJqL3wKH7K-Qi0ZCU_h2nGHAA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 19 Aug 2024 14:27:11 -0700
X-Gmail-Original-Message-ID: <CACePvbW9scoOJzA_O2fPBCvZBwa0yQumFnXuhdtO0pkutD2P+Q@mail.gmail.com>
Message-ID: <CACePvbW9scoOJzA_O2fPBCvZBwa0yQumFnXuhdtO0pkutD2P+Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

On Mon, Aug 19, 2024 at 1:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Aug 19, 2024 at 4:31=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> > > On Fri, Aug 16, 2024 at 3:53=E2=80=AFPM Chris Li <chrisl@kernel.org> =
wrote:
> > >>
> > >> On Thu, Aug 8, 2024 at 1:38=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
> > >> >
> > >> > Chris Li <chrisl@kernel.org> writes:
> > >> >
> > >> > > On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@=
intel.com> wrote:
> > >> > >>
> > >> > >> Hi, Chris,
> > >> > >>
> > >> > >> Chris Li <chrisl@kernel.org> writes:
> > >> > >>
> > >> > >> > This is the short term solutions "swap cluster order" listed
> > >> > >> > in my "Swap Abstraction" discussion slice 8 in the recent
> > >> > >> > LSF/MM conference.
> > >> > >> >
> > >> > >> > When commit 845982eb264bc "mm: swap: allow storage of all mTH=
P
> > >> > >> > orders" is introduced, it only allocates the mTHP swap entrie=
s
> > >> > >> > from the new empty cluster list.  It has a fragmentation issu=
e
> > >> > >> > reported by Barry.
> > >> > >> >
> > >> > >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJ=
JhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
> > >> > >> >
> > >> > >> > The reason is that all the empty clusters have been exhausted=
 while
> > >> > >> > there are plenty of free swap entries in the cluster that are
> > >> > >> > not 100% free.
> > >> > >> >
> > >> > >> > Remember the swap allocation order in the cluster.
> > >> > >> > Keep track of the per order non full cluster list for later a=
llocation.
> > >> > >> >
> > >> > >> > This series gives the swap SSD allocation a new separate code=
 path
> > >> > >> > from the HDD allocation. The new allocator use cluster list o=
nly
> > >> > >> > and do not global scan swap_map[] without lock any more.
> > >> > >>
> > >> > >> This sounds good.  Can we use SSD allocation method for HDD too=
?
> > >> > >> We may not need a swap entry allocator optimized for HDD.
> > >> > >
> > >> > > Yes, that is the plan as well. That way we can completely get ri=
d of
> > >> > > the old scan_swap_map_slots() code.
> > >> >
> > >> > Good!
> > >> >
> > >> > > However, considering the size of the series, let's focus on the
> > >> > > cluster allocation path first, get it tested and reviewed.
> > >> >
> > >> > OK.
> > >> >
> > >> > > For HDD optimization, mostly just the new block allocations port=
ion
> > >> > > need some separate code path from the new cluster allocator to n=
ot do
> > >> > > the per cpu allocation.  Allocating from the non free list doesn=
't
> > >> > > need to change too
> > >> >
> > >> > I suggest not consider HDD optimization at all.  Just use SSD algo=
rithm
> > >> > to simplify.
> > >>
> > >> Adding a global next allocating CI rather than the per CPU next CI
> > >> pointer is pretty trivial as well. It is just a different way to fet=
ch
> > >> the next cluster pointer.
> > >
> > > Yes, if we enable the new cluster based allocator for HDD, we can
> > > enable THP and mTHP for HDD too, and use a global cluster_next instea=
d
> > > of Per-CPU for it.
> > > It's easy to do with minimal changes, and should actually boost
> > > performance for HDD SWAP. Currently testing this locally.
> >
> > I think that it's better to start with SSD algorithm.  Then, you can ad=
d
> > HDD specific optimization on top of it with supporting data.
>
> Yes, we are having the same idea.
>
> >
> > BTW, I don't know why HDD shouldn't use per-CPU cluster.  Sequential
> > writing is more important for HDD.
> > >> > >>
> > >> > >> Hi, Hugh,
> > >> > >>
> > >> > >> What do you think about this?
> > >> > >>
> > >> > >> > This streamline the swap allocation for SSD. The code matches=
 the
> > >> > >> > execution flow much better.
> > >> > >> >
> > >> > >> > User impact: For users that allocate and free mix order mTHP =
swapping,
> > >> > >> > It greatly improves the success rate of the mTHP swap allocat=
ion after the
> > >> > >> > initial phase.
> > >> > >> >
> > >> > >> > It also performs faster when the swapfile is close to full, b=
ecause the
> > >> > >> > allocator can get the non full cluster from a list rather tha=
n scanning
> > >> > >> > a lot of swap_map entries.
> > >> > >>
> > >> > >> Do you have some test results to prove this?  Or which test bel=
ow can
> > >> > >> prove this?
> > >> > >
> > >> > > The two zram tests are already proving this. The system time
> > >> > > improvement is about 2% on my low CPU count machine.
> > >> > > Kairui has a higher core count machine and the difference is hig=
her
> > >> > > there. The theory is that higher CPU count has higher contention=
s.
> > >> >
> > >> > I will interpret this as the performance is better in theory.  But
> > >> > there's almost no measurable results so far.
> > >>
> > >> I am trying to understand why don't see the performance improvement =
in
> > >> the zram setup in my cover letter as a measurable result?
> > >
> > > Hi Ying, you can check the test with the 32 cores AMD machine in the
> > > cover letter, as Chris pointed out the performance gain is higher as
> > > core number grows. The performance gain is still not much (*yet, base=
d
> > > on this design thing can go much faster after HDD codes are
> > > dropped which enables many other optimizations, this series
> > > is mainly focusing on the fragmentation issue), but I think a
> > > stable ~4 - 8% improvement with a build linux kernel test
> > > could be considered measurable?
> >
> > Is this the test result for "when the swapfile is close to full"?
>
> Yes, it's about 60% to 90% full during the whole test process. If ZRAM
> is completely full the workload will go OOM, but testing with madvice

BTW, one trick to avoid ZRAM completely full causing OOM is to have
two zram devices and assign different priorities. Let the first zram
get 100% full then the swap overflow to the second ZRAM device, which
has more swap entries to avoid the OOM.

Chris

> showed no performance drop.

