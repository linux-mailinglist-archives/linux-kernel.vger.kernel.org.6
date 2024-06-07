Return-Path: <linux-kernel+bounces-206604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AECD900BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF17B23C39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FD13E41D;
	Fri,  7 Jun 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7wA6vyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13821DFEB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785631; cv=none; b=fJDzIOE5Vn3rlYZsbLICCfyfyyvF03UGcGU3VdfQB6TGfv5zcBerqOzdMbvxIggpksVWGza16JqFf1Vt8IsgVzlwcGC6ntPeo6dxpJrExz7Krp07vyX1Z+wbM9d0NIn/ptwI0F8vyDxCmhJhommgleGI8R2KxYHej8YYns6RVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785631; c=relaxed/simple;
	bh=0VGMyVNSj6KxFWF6MZL8xDNyRDYgj1eKlZc5d9+jXaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/oRbnc17/AI+BFWX8E2UIdKmrAAxkmXWG7IvMZv8bHeekzas4zA1MppqCPgKwqSixhidHuzrGP5mKl5Ae1gLmVxA3TVQZ4aoSXYpn7KLKxeynXqYTj0GV1XuvaJyCK1ooZfeYyQGfv3sV+2Ncdjd/nQbwSoxtWtGm7yXWCGgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7wA6vyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA4FC4AF07
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717785630;
	bh=0VGMyVNSj6KxFWF6MZL8xDNyRDYgj1eKlZc5d9+jXaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j7wA6vyEUu0o2WHsX8GesKIQfqQVHiog/00Xr4WZkNvOmsjNh9WBlfJCh0q1sMGUh
	 xN0Vs7REQ0P/sKz/olAz5e1t6WdcLkxb5I/SB+e2EaLpta6/+QP+Ly+8/+UvD8aqub
	 ZrbHpTaN5saeim/NHQ/tZxtY5lJyGp1oGkHJywfZbc+nSRJROEELT5GJqLLrSINU/f
	 NpQSkIOcPsKsVpV3C9XNfLYFbhLGb/IvESnEGGOb7ii88i2sh7pKTB1jkLj4VAKjJZ
	 Mv01OuLDSJ/hp4/3BZN3MhDyiglYiXu45XlcjHNiLheAKBHZnlnV9TIJAwfxmp4DSH
	 aiJAIjk+UlcHw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eae2d4da7bso10136861fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:40:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUaWdZDkgGmuZf8Socj33p3jKyfq2KnqAh+ZwJh5G9HbMhyOw6ln8efwqPbp5Fa5lPcbarmEWxTzQO/UbNCLQ8uRoAByTRjUqRnTpe
X-Gm-Message-State: AOJu0Yz9syWRpuKS90muYkQNCYngX4WlKX+EKIDDQvNKr7c/apguGGHY
	MJ4zEfj3wZDmzzRnZWcz1GH39sYkPJlz4yWWjawDhX4Qe53N1Xf3J3ZTEAXVpNpQIIG0UuIQkVL
	B/lT4KpLvBP4uKfLimAzqPJG2Xw==
X-Google-Smtp-Source: AGHT+IH3Mj0rBmt24jJEhgNeHBeaFPgCrN61UZj6ZDZI4WEKYulSo7N7av/cjitES6BoB//uHLwboVIPQPgneDPRotY=
X-Received: by 2002:a2e:8242:0:b0:2ea:eb0d:512 with SMTP id
 38308e7fff4ca-2eaeb0d0ca7mr11560051fa.30.1717785629281; Fri, 07 Jun 2024
 11:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
 <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuPLhmJqMi-unDOm820c8_kRnQVA_dnSfgRzMXaHKnDHAQ@mail.gmail.com>
 <875xum96nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875xum96nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 7 Jun 2024 11:40:16 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=iYzyjDwgMRLtSZwKv414JqtZK8w=XWDd6bWZ7Ah-8jA@mail.gmail.com>
Message-ID: <CANeU7Q=iYzyjDwgMRLtSZwKv414JqtZK8w=XWDd6bWZ7Ah-8jA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Chris Li <chrisl@kernel.org> writes:
>

> > In the page allocation side, we have the hugetlbfs which reserve some
> > memory for high order pages.
> > We should have similar things to allow reserve some high order swap
> > entries without getting polluted by low order one.
>
> TBH, I don't like the idea of high order swap entries reservation.
May I know more if you don't like the idea? I understand this can be
controversial, because previously we like to take the THP as the best
effort approach. If there is some reason we can't make THP, we use the
order 0 as fall back.

For discussion purpose, I want break it down to smaller steps:

First, can we agree that the following usage case is reasonable:
The usage case is that, as Barry has shown, zsmalloc compresses bigger
size than 4K and can have both better compress ratio and CPU
performance gain.
https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/

So the goal is to make THP/mTHP have some reasonable success rate
running in the mix size swap allocation, after either low order or
high order swap requests can overflow the swap file size. The allocate
can still recover from that, after some swap entries got free.

Please let me know if you think the above usage case and goal are not
reasonable for the kernel.

> that's really important for you, I think that it's better to design
> something like hugetlbfs vs core mm, that is, be separated from the
> normal swap subsystem as much as possible.

I am giving hugetlbfs just to make the point using reservation, or
isolation of the resource to prevent mixing fragmentation existing in
core mm.
I am not suggesting copying the hugetlbfs implementation to the swap
system. Unlike hugetlbfs, the swap allocation is typically done from
the kernel, it is transparent from the application. I don't think
separate from the swap subsystem is a good way to go.

This comes down to why you don't like the reservation. e.g. if we use
two swapfile, one swapfile is purely allocate for high order, would
that be better?
>
> >>
> >> > Do you see another way to protect the high order cluster polluted by
> >> > lower order one?
> >>
> >> If we use high-order page allocation as reference, we need something
> >> like compaction to guarantee high-order allocation finally.  But we ar=
e
> >> too far from that.
> >
> > We should consider reservation for high-order swap entry allocation
> > similar to hugetlbfs for memory.
> > Swap compaction will be very complicated because it needs to scan the
> > PTE to migrate the swap entry. It might be easier to support folio
> > write out compound discontiguous swap entries. That is another way to
> > address the fragmentation issue. We are also too far from that as
> > right now.
>
> That's not easy to write out compound discontiguous swap entries too.
> For example, how to put folios in swap cache?

I propose the idea in the recent LSF/MM discussion, the last few
slides are for the discontiguous swap and it has the discontiguous
entries in swap cache.
https://drive.google.com/file/d/10wN4WgEekaiTDiAx2AND97CYLgfDJXAD/view

Agree it is not an easy change. The cache cache would have to change
the assumption all offset are contiguous.
For swap, we kind of have some in memory data associated with per
offset already, so it might provide an opportunity to combine the
offset related data structure for swap together. Another alternative
might be using xarray without the multi entry property. , just treat
each offset like a single entry. I haven't dug deep into this
direction yet.

We can have more discussion, maybe arrange an upstream alignment
meeting if there is interest.

Chris

