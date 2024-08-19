Return-Path: <linux-kernel+bounces-291725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FBC9565F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D5E1F254E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79115B561;
	Mon, 19 Aug 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU359H0Y"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF63158543
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057286; cv=none; b=oRJbLGD/8zjm0Ft52+bJqdb+1eXv20VJXZbFqlL+3J/mrC+sdc4MeCAe+Yo0VxShMZMfveVm4wJlTMUahMSEnXeUVMTq+/kaRT09/M0Q52e1MM42CJS+rlWeHZFZG2IHl47ouzevOlrFIrrSnKNdIBrrjowAGcYa72BWoXOwkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057286; c=relaxed/simple;
	bh=YeBehtJBmCTDjxbZbdt4/e3Q+i7AbLX3EKnDYQCBiiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4n6P/r81xLO5zqGNt5RZf3SLYxFJCol93OTIoqaq3aRJ/4c6v6GBvqShtMwvwq9zoOAmF6O9hSBX6y4yGyjeMmqfMVLv74MtTdh1GbtN52gM1zH7kVtvDYDqHLG6cBWiSAT7S2vvf/JiGogX5BlHeuZGOR9vm96LtyJJRtaSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU359H0Y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f15790b472so50968591fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724057283; x=1724662083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbT3/kIlvm/gUEqKPpTSt037obF1J4e0zImRwZ8l9d8=;
        b=YU359H0Y+E6I3rodxoY/ZWduZxW9uJ63DkmXDDjjhp8FREWUKaIQFF773ExNe+YEdQ
         oEt2/dRdkAaWj6A5AySKxVbKYGyXL0dbzk+z2Ax6RqLYrcUwn6ZYFNDQRtLmbC4sk7eQ
         TPeT3ll2xsKFk/OTN0COGaiaXgs6PoiTGqIDOFC1R2/hkH0SuuLU6rQP7dMehaCeOJhN
         NJLFhjGYGFU3y9j3zJ3x+NKHIKn/aI59cE9u3ztGioXfvIAO5ZK1mSQAypSjvmfglwdF
         R9/qIYj5yJ+7paxi+72snc+mHEoQCRkTFSlTfOQ3M8tnjyiL4GxN7pkqD56cmFKy0eiw
         r3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724057283; x=1724662083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbT3/kIlvm/gUEqKPpTSt037obF1J4e0zImRwZ8l9d8=;
        b=F0PUF+VdUCZxF51f9dOJFxu+2bIkl6hJgkiE5GPa1qZljEGFM72foTVX3eF0aN4A08
         yYEgq6lzRVPzLOtBeUaTSlLd7De8P0RUVWry4aUM+d0WaFPL9szNtUq0062g0V9ySGRG
         fyG1mJ/r4Lh8jnsUfNAGXRXxpqzEIsOkeyp7S94rOI32W22cMIt49XZqPxBmEuiDZgmF
         0LiGLcPIogth2uSsuviHhu3OcV7tp88w2VJmPfHIcyT9qQsFmgbA3xa8LbKApsr+e1v4
         /Xy5OOCTtDLTmgObBAIRVM32UP/mNB4TVXptQLurNaTSrjFICOIZv4W+g46BGQjIknm6
         FdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXfa4rVVyGPLkvi58W0IPmc4wJNqNrdt8I4r3/GN8haMrMdESnNK7ZCKBQwpZMm7DJLwSfRLrBoKfVRfdBgyveJ1ScerIQpB7u65JB
X-Gm-Message-State: AOJu0YwjgKWwrrXEorCd3+M1hIjfGuMkWRAVEPQbiY02nR7knsIUSiih
	IfnDhKphZytqi/8lWiZl7yMxLJFTwdghKsK36Nmf7QCNRPUoUDygXVVidaVjEITHqy2731kLrjl
	7iXpqX63fG06yadvhthqVQhnKJHKn4H5X
X-Google-Smtp-Source: AGHT+IF5iFUMltUIQoMrdmu+7EkXfJ4wgIOcUBPgssm1i1mxjTRbux+3hjjIIMIEAUhJPI+Dy+3XwyXn854sS7IzhG8=
X-Received: by 2002:a2e:6101:0:b0:2ef:28ee:944 with SMTP id
 38308e7fff4ca-2f3be60812fmr59530831fa.45.1724057282704; Mon, 19 Aug 2024
 01:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
 <87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
 <CAMgjq7DJwF+kwxJkDKnH-cnp-36xdEObrNpKGrH_GvNKQtqjSw@mail.gmail.com> <87ttfghq7o.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ttfghq7o.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Aug 2024 16:47:45 +0800
Message-ID: <CAMgjq7AOBvE7cfhxh8VGTqVWvYJqL3wKH7K-Qi0ZCU_h2nGHAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:31=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Fri, Aug 16, 2024 at 3:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> >>
> >> On Thu, Aug 8, 2024 at 1:38=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >> >
> >> > Chris Li <chrisl@kernel.org> writes:
> >> >
> >> > > On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@in=
tel.com> wrote:
> >> > >>
> >> > >> Hi, Chris,
> >> > >>
> >> > >> Chris Li <chrisl@kernel.org> writes:
> >> > >>
> >> > >> > This is the short term solutions "swap cluster order" listed
> >> > >> > in my "Swap Abstraction" discussion slice 8 in the recent
> >> > >> > LSF/MM conference.
> >> > >> >
> >> > >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> >> > >> > orders" is introduced, it only allocates the mTHP swap entries
> >> > >> > from the new empty cluster list.  It has a fragmentation issue
> >> > >> > reported by Barry.
> >> > >> >
> >> > >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJh=
gMQdSMp+Ah+NSgNQ@mail.gmail.com/
> >> > >> >
> >> > >> > The reason is that all the empty clusters have been exhausted w=
hile
> >> > >> > there are plenty of free swap entries in the cluster that are
> >> > >> > not 100% free.
> >> > >> >
> >> > >> > Remember the swap allocation order in the cluster.
> >> > >> > Keep track of the per order non full cluster list for later all=
ocation.
> >> > >> >
> >> > >> > This series gives the swap SSD allocation a new separate code p=
ath
> >> > >> > from the HDD allocation. The new allocator use cluster list onl=
y
> >> > >> > and do not global scan swap_map[] without lock any more.
> >> > >>
> >> > >> This sounds good.  Can we use SSD allocation method for HDD too?
> >> > >> We may not need a swap entry allocator optimized for HDD.
> >> > >
> >> > > Yes, that is the plan as well. That way we can completely get rid =
of
> >> > > the old scan_swap_map_slots() code.
> >> >
> >> > Good!
> >> >
> >> > > However, considering the size of the series, let's focus on the
> >> > > cluster allocation path first, get it tested and reviewed.
> >> >
> >> > OK.
> >> >
> >> > > For HDD optimization, mostly just the new block allocations portio=
n
> >> > > need some separate code path from the new cluster allocator to not=
 do
> >> > > the per cpu allocation.  Allocating from the non free list doesn't
> >> > > need to change too
> >> >
> >> > I suggest not consider HDD optimization at all.  Just use SSD algori=
thm
> >> > to simplify.
> >>
> >> Adding a global next allocating CI rather than the per CPU next CI
> >> pointer is pretty trivial as well. It is just a different way to fetch
> >> the next cluster pointer.
> >
> > Yes, if we enable the new cluster based allocator for HDD, we can
> > enable THP and mTHP for HDD too, and use a global cluster_next instead
> > of Per-CPU for it.
> > It's easy to do with minimal changes, and should actually boost
> > performance for HDD SWAP. Currently testing this locally.
>
> I think that it's better to start with SSD algorithm.  Then, you can add
> HDD specific optimization on top of it with supporting data.

Yes, we are having the same idea.

>
> BTW, I don't know why HDD shouldn't use per-CPU cluster.  Sequential
> writing is more important for HDD.
> >> > >>
> >> > >> Hi, Hugh,
> >> > >>
> >> > >> What do you think about this?
> >> > >>
> >> > >> > This streamline the swap allocation for SSD. The code matches t=
he
> >> > >> > execution flow much better.
> >> > >> >
> >> > >> > User impact: For users that allocate and free mix order mTHP sw=
apping,
> >> > >> > It greatly improves the success rate of the mTHP swap allocatio=
n after the
> >> > >> > initial phase.
> >> > >> >
> >> > >> > It also performs faster when the swapfile is close to full, bec=
ause the
> >> > >> > allocator can get the non full cluster from a list rather than =
scanning
> >> > >> > a lot of swap_map entries.
> >> > >>
> >> > >> Do you have some test results to prove this?  Or which test below=
 can
> >> > >> prove this?
> >> > >
> >> > > The two zram tests are already proving this. The system time
> >> > > improvement is about 2% on my low CPU count machine.
> >> > > Kairui has a higher core count machine and the difference is highe=
r
> >> > > there. The theory is that higher CPU count has higher contentions.
> >> >
> >> > I will interpret this as the performance is better in theory.  But
> >> > there's almost no measurable results so far.
> >>
> >> I am trying to understand why don't see the performance improvement in
> >> the zram setup in my cover letter as a measurable result?
> >
> > Hi Ying, you can check the test with the 32 cores AMD machine in the
> > cover letter, as Chris pointed out the performance gain is higher as
> > core number grows. The performance gain is still not much (*yet, based
> > on this design thing can go much faster after HDD codes are
> > dropped which enables many other optimizations, this series
> > is mainly focusing on the fragmentation issue), but I think a
> > stable ~4 - 8% improvement with a build linux kernel test
> > could be considered measurable?
>
> Is this the test result for "when the swapfile is close to full"?

Yes, it's about 60% to 90% full during the whole test process. If ZRAM
is completely full the workload will go OOM, but testing with madvice
showed no performance drop.

