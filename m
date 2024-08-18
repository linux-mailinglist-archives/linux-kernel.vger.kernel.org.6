Return-Path: <linux-kernel+bounces-291123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7E955D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187A71F21635
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F9638DE4;
	Sun, 18 Aug 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjlwIHaY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF614A4F5
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000402; cv=none; b=UhAjeOhoE1rEpw60zmdidlJ8vrCX8ARLQyT2+KuTGCWRD1ZVl+NPgx8cGZ4an3vj9YhM+K2YCxwddDAaBwPM7UAPxKBIHGw4bqmBG0UnIAg2tJ98LnP4IIVxopRW8QJ55YMrxLD3URSVwRFduuzQQsclucSeN/KKeus/kAzz8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000402; c=relaxed/simple;
	bh=f/LHB/QOl4EFh3mcXyNCug/9XvcPsuuL1Kq0Y2e3NJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhQMbhbJhwA0IL1aghBSXzBI6wzBmAkdsfjXKXdSsKiKDmdJ30CZylpRTuqbepVEAqElJb3Ztt7TcE0Bm5l0zKkwih5f59XjTAWeZ8i1JiHFBRNLNSlcgDumRlxKcGP/x5/FAN3FBJsh28rscAx6M9o8AROVDeeL2Fk8k61H05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjlwIHaY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so2676871fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724000399; x=1724605199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1Vm8+96GMI1FNFk6AbvT7rBGApi2ofDmhSHbmdVImo=;
        b=DjlwIHaYd7DkKaM3aOio4GafiJ38A+gScqtYEquFDKEGtJhU4D57/6rMLxwi8b901c
         ZmErilSs4kiBTJsqTCdN2LaEfyKNbx/oxSy5ozeqvYUPaEmuTlYimNNl778RWgT9/MZB
         K/SHTxISydtyy2fBppniOcC44oQEg0N3SsaHhpeLW4ZmG2EiVrpNTzJtg9x8gBTpYdCw
         Y+DldKJCuK+2oYjYIcV5ILYxX5uPjb89ZC99R29VrlUTw3ITuInV733WBxi9KUitYx80
         LmWHfr/57XRY0IXXSfdHC3fXnsR4pyhOQRX95OiXMyY40nMpNt4GI615EpTqWd93z5N0
         n27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724000399; x=1724605199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1Vm8+96GMI1FNFk6AbvT7rBGApi2ofDmhSHbmdVImo=;
        b=jUrJUE8mjOdvRegLY6Wv43TfeJPTwXk1HVgNEHRQN0LLIg4SCbFzNVPiylM+GPcjw8
         ytPG+sUeOUkNErlj/XXQwJ/XHBi71f+N0GPJtZTUgn/Y2VY1chTww+/4FMGePaWnusnB
         LS+pdtH2eckqYRYOP7BejitaG4bU0VQPA4NkUr7sz8KTQIeGJCJ1jK2aH1fckY3hi6i4
         Oat/COqqTluhgdxn3VJDr+ylJoLS9PsKzVjHgxdN9ISBv+VgKgUVUEcMICFAuvAZvML/
         ewmxi1ApqreVTNVDQCd0db4k/KF4uzSYHRiXM1tGY5dsqzuh4C27Vf7dHHugerEmU0w7
         Hi5w==
X-Forwarded-Encrypted: i=1; AJvYcCXLHJaJbiadr1jZ8sM5De53n4Vm15RLZVDOjmR/lJ7Pn62r1iodJBAYb/Ugpxelh1hky+laN1bEDdRj5Q1Q9JBe9450Y9mX/yrDjldx
X-Gm-Message-State: AOJu0YyeL2/zn+VnIIb2bNEK72+EnFuKUrvOjj2/QhuQdzzb6R7kiAxp
	Ad+RMfVgMO+Bs3mB9c88ydOHfL9V0Cj/Z9z0pMvwG0WZix4aa4L39JJpsWmEkLyjed1iYnnjR67
	bLHHXyWyjtwwSKVh0VHULCKGLlzk=
X-Google-Smtp-Source: AGHT+IFWkdktNIAelch9T0/8VhMrXRkjqTjTUPAFrskolyViGom3cW+o6CzbRHE1IufVHbsW12reJH+l6E/AIR7hb3w=
X-Received: by 2002:a2e:a7ca:0:b0:2f3:c384:71ee with SMTP id
 38308e7fff4ca-2f3c384724dmr63014221fa.33.1724000398411; Sun, 18 Aug 2024
 09:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
 <87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
In-Reply-To: <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Aug 2024 00:59:41 +0800
Message-ID: <CAMgjq7DJwF+kwxJkDKnH-cnp-36xdEObrNpKGrH_GvNKQtqjSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Aug 8, 2024 at 1:38=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > Chris Li <chrisl@kernel.org> writes:
> >
> > > On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@intel=
.com> wrote:
> > >>
> > >> Hi, Chris,
> > >>
> > >> Chris Li <chrisl@kernel.org> writes:
> > >>
> > >> > This is the short term solutions "swap cluster order" listed
> > >> > in my "Swap Abstraction" discussion slice 8 in the recent
> > >> > LSF/MM conference.
> > >> >
> > >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> > >> > orders" is introduced, it only allocates the mTHP swap entries
> > >> > from the new empty cluster list.  It has a fragmentation issue
> > >> > reported by Barry.
> > >> >
> > >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQ=
dSMp+Ah+NSgNQ@mail.gmail.com/
> > >> >
> > >> > The reason is that all the empty clusters have been exhausted whil=
e
> > >> > there are plenty of free swap entries in the cluster that are
> > >> > not 100% free.
> > >> >
> > >> > Remember the swap allocation order in the cluster.
> > >> > Keep track of the per order non full cluster list for later alloca=
tion.
> > >> >
> > >> > This series gives the swap SSD allocation a new separate code path
> > >> > from the HDD allocation. The new allocator use cluster list only
> > >> > and do not global scan swap_map[] without lock any more.
> > >>
> > >> This sounds good.  Can we use SSD allocation method for HDD too?
> > >> We may not need a swap entry allocator optimized for HDD.
> > >
> > > Yes, that is the plan as well. That way we can completely get rid of
> > > the old scan_swap_map_slots() code.
> >
> > Good!
> >
> > > However, considering the size of the series, let's focus on the
> > > cluster allocation path first, get it tested and reviewed.
> >
> > OK.
> >
> > > For HDD optimization, mostly just the new block allocations portion
> > > need some separate code path from the new cluster allocator to not do
> > > the per cpu allocation.  Allocating from the non free list doesn't
> > > need to change too
> >
> > I suggest not consider HDD optimization at all.  Just use SSD algorithm
> > to simplify.
>
> Adding a global next allocating CI rather than the per CPU next CI
> pointer is pretty trivial as well. It is just a different way to fetch
> the next cluster pointer.

Yes, if we enable the new cluster based allocator for HDD, we can
enable THP and mTHP for HDD too, and use a global cluster_next instead
of Per-CPU for it.
It's easy to do with minimal changes, and should actually boost
performance for HDD SWAP. Currently testing this locally.

> > >>
> > >> Hi, Hugh,
> > >>
> > >> What do you think about this?
> > >>
> > >> > This streamline the swap allocation for SSD. The code matches the
> > >> > execution flow much better.
> > >> >
> > >> > User impact: For users that allocate and free mix order mTHP swapp=
ing,
> > >> > It greatly improves the success rate of the mTHP swap allocation a=
fter the
> > >> > initial phase.
> > >> >
> > >> > It also performs faster when the swapfile is close to full, becaus=
e the
> > >> > allocator can get the non full cluster from a list rather than sca=
nning
> > >> > a lot of swap_map entries.
> > >>
> > >> Do you have some test results to prove this?  Or which test below ca=
n
> > >> prove this?
> > >
> > > The two zram tests are already proving this. The system time
> > > improvement is about 2% on my low CPU count machine.
> > > Kairui has a higher core count machine and the difference is higher
> > > there. The theory is that higher CPU count has higher contentions.
> >
> > I will interpret this as the performance is better in theory.  But
> > there's almost no measurable results so far.
>
> I am trying to understand why don't see the performance improvement in
> the zram setup in my cover letter as a measurable result?

Hi Ying, you can check the test with the 32 cores AMD machine in the
cover letter, as Chris pointed out the performance gain is higher as
core number grows. The performance gain is still not much (*yet, based
on this design thing can go much faster after HDD codes are
dropped which enables many other optimizations, this series
is mainly focusing on the fragmentation issue), but I think a
stable ~4 - 8% improvement with a build linux kernel test
could be considered measurable?

