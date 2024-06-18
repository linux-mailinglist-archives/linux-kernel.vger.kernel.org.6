Return-Path: <linux-kernel+bounces-218630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09090C2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DCE1F226CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A8763F8;
	Tue, 18 Jun 2024 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc0lNpts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE51C01
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685346; cv=none; b=Zz06tpD42wkjNuG4BHA0hVrkHGiFIShyAKueWF9qKnR58Tov0lr+/RVebke8rWsVx2eQelQmwwJgPSF88KZfvx3GQXrUEE9UCgg8vEdAULsOBK+FqvO4ka8CKyFrVCJaQfWxl0FtEAqMyMldNnnNOpAJkWnxY+ZgJrzeGZZ+ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685346; c=relaxed/simple;
	bh=wmS4Z1+zhk8g7L1BEZPd9G1cB+ga3g+3sjeUdv7+wgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZZw5eh49bwdgrs/I9fyawR/WQvvO4TuouFHMeZPl+DbRWOeBEQFaAFgMnuNsCqen2a4VYAEWwvLEXXDR8AaDDpHhUqZLd4IavJteYerTZxI499x9AsDA2+3y2e4KcPWFQCToPcPx6LuaBz0en8j99Ew9R4VuxVJ+h0V/L1x7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc0lNpts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5ECC3277B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718685345;
	bh=wmS4Z1+zhk8g7L1BEZPd9G1cB+ga3g+3sjeUdv7+wgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qc0lNptsa9UY/gUGrVoVtY5q387bLfBAd0l9lFcI3TuXr2ZCo2vaVqQOEPT4Ph4Hj
	 DB1FSwyTrFgQ/u8ckwO/ldff9QmesCgUion2Z4FqjD7Z/hi1HAeo+7aAWuBbo4+q5J
	 rCvsmybiqnYuyRrenuUv8qCDwhuTIRpkBGzwySkLbKaIuCY7GHIRTYhdFnSyFgGKE3
	 Q9Um0eCrwaUl837ydGKoXH/MqjlMU87YEuYp7bxyudeDE4gC9s5DP0jqTfI8nJGJQc
	 PSbmPvH5gcENf7hjiP9cESjSH/YcnXHZ+tSJEkmr7qDgzSUO+1TozdvYtj9QIS8X9H
	 Wz6WaLh7uqpoA==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375858224adso21183525ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:35:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuDguiHA1AKOe9Lch6526DoqYmyJDN+kxUWi5tcFD96Sef6Qtxf00lVWUtK6cflgYl+KYsdvrbmBR9a7dxKs1pum0HZh6m6VsUFzf3
X-Gm-Message-State: AOJu0YxcqrRyTZaYv5JTQ/kFP+YlfHHtPUvII3kAipX9w6M9g0DE30qp
	oDq02wdwbjhXS745VrycC5WWmOxNdCqZWkQZxQ8XLOHQAnmHcEGmCBBc/HZmlEclR1afidroIF/
	AV1wMdWLLmDZXly0tpriqolvsnQ3ZkuVM2ANy
X-Google-Smtp-Source: AGHT+IHvmKrB915v6FRz7bPfsZfQz4tFqOemII0BXgoR9p/8al1ZbEhHjkD3DfYmJlPv05+n45QagUhoUU2doZ5I9aY=
X-Received: by 2002:a05:6e02:1582:b0:375:b4a3:9bc4 with SMTP id
 e9e14a558f8ab-375e108ae6emr128605685ab.28.1718685345040; Mon, 17 Jun 2024
 21:35:45 -0700 (PDT)
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
 <875xum96nn.fsf@yhuang6-desk2.ccr.corp.intel.com> <CANeU7Q=iYzyjDwgMRLtSZwKv414JqtZK8w=XWDd6bWZ7Ah-8jA@mail.gmail.com>
 <87wmmw6w9e.fsf@yhuang6-desk2.ccr.corp.intel.com> <CANeU7Q=Epa438LXEX4WEccxLt6WOziLg2sp_=RA3C4PxtHD5uw@mail.gmail.com>
 <87a5jp6xuo.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5jp6xuo.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 17 Jun 2024 21:35:32 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMi198++-OHqE5pG1y3BnvRBPepG59zpq-wqjbgrrLdHw@mail.gmail.com>
Message-ID: <CAF8kJuMi198++-OHqE5pG1y3BnvRBPepG59zpq-wqjbgrrLdHw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:40=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Mon, Jun 10, 2024 at 7:38=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Huang, Ying <ying.huang@intel=
.com> wrote:
> >> >>
> >> >> Chris Li <chrisl@kernel.org> writes:
> >> >>
> >> >
> >> >> > In the page allocation side, we have the hugetlbfs which reserve =
some
> >> >> > memory for high order pages.
> >> >> > We should have similar things to allow reserve some high order sw=
ap
> >> >> > entries without getting polluted by low order one.
> >> >>
> >> >> TBH, I don't like the idea of high order swap entries reservation.
> >> > May I know more if you don't like the idea? I understand this can be
> >> > controversial, because previously we like to take the THP as the bes=
t
> >> > effort approach. If there is some reason we can't make THP, we use t=
he
> >> > order 0 as fall back.
> >> >
> >> > For discussion purpose, I want break it down to smaller steps:
> >> >
> >> > First, can we agree that the following usage case is reasonable:
> >> > The usage case is that, as Barry has shown, zsmalloc compresses bigg=
er
> >> > size than 4K and can have both better compress ratio and CPU
> >> > performance gain.
> >> > https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmai=
l.com/
> >> >
> >> > So the goal is to make THP/mTHP have some reasonable success rate
> >> > running in the mix size swap allocation, after either low order or
> >> > high order swap requests can overflow the swap file size. The alloca=
te
> >> > can still recover from that, after some swap entries got free.
> >> >
> >> > Please let me know if you think the above usage case and goal are no=
t
> >> > reasonable for the kernel.
> >>
> >> I think that it's reasonable to improve the success rate of high-order
> >
> > Glad to hear that.
> >
> >> swap entries allocation.  I just think that it's hard to use the
> >> reservation based method.  For example, how much should be reserved?
> >
> > Understand, it is harder to use than a fully transparent method, but
> > still better than no solution at all. The alternative right now is we
> > can't do it.
> >
> > Regarding how much we should reserve. Similarly, how much should you
> > choose your swap file size? If you choose N, why not N*120% or N*80%?
> > That did not stop us from having a swapfile, right?
> >
> >> Why system OOM when there's still swap space available?  And so forth.
> >
> > Keep in mind that the reservation is an option. If you prefer the old
> > behavior, you don't have to use the reservation. That shouldn't be a
> > reason to stop others who want to use it. We don't have an alternative
> > solution for the long run mix size allocation yet. If there is, I like
> > to hear it.
>
> It's not enough to make it optional.  When you run into issue, you need
> to debug it.  And you may debug an issue on a system that is configured
> by someone else.

That is in general true with all kernel development regardless of
using options or not. If there is a bug in my patch, I will need to
debug and fix it or the patch might be reverted.

I don't see that as a reason to take the option path or not. The
option just means the user taking this option will need to understand
the trade off and accept the defined behavior of that option.

>
> >> So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.
> >
> > Me too. I prefer transparent over reservation if it can achieve the
> > same goal. Do we have a fully transparent method spec out? How to
> > achieve fully transparent and also avoid fragmentation caused by mix
> > order allocation/free?
> >
> > Keep in mind that we are still in the early stage of the mTHP swap
> > development, I can have the reservation patch relatively easily. If
> > you come up with a better transparent method patch which can achieve
> > the same goal later, we can use it instead.
>
> Because we are still in the early stage, I think that we should try to
> improve transparent solution firstly.  Personally, what I don't like is
> that we don't work on the transparent solution because we have the
> reservation solution.

Do you have a road map or the design for the transparent solution you can s=
hare?
I am interested to know what is the short term step(e.g. a month)  in
this transparent solution you have in mind, so we can compare the
different approaches. I can't reason much just by the name
"transparent solution" itself. Need more technical details.

Right now we have a clear usage case we want to support, the swap
in/out mTHP with bigger zsmalloc buffers. We can start with the
limited usage case first then move to more general ones.

> >> >> that's really important for you, I think that it's better to design
> >> >> something like hugetlbfs vs core mm, that is, be separated from the
> >> >> normal swap subsystem as much as possible.
> >> >
> >> > I am giving hugetlbfs just to make the point using reservation, or
> >> > isolation of the resource to prevent mixing fragmentation existing i=
n
> >> > core mm.
> >> > I am not suggesting copying the hugetlbfs implementation to the swap
> >> > system. Unlike hugetlbfs, the swap allocation is typically done from
> >> > the kernel, it is transparent from the application. I don't think
> >> > separate from the swap subsystem is a good way to go.
> >> >
> >> > This comes down to why you don't like the reservation. e.g. if we us=
e
> >> > two swapfile, one swapfile is purely allocate for high order, would
> >> > that be better?
> >>
> >> Sorry, my words weren't accurate.  Personally, I just think that it's
> >> better to make reservation related code not too intrusive.
> >
> > Yes. I will try to make it not too intrusive.
> >
> >> And, before reservation, we need to consider something else firstly.
> >> Whether is it generally good to swap-in with swap-out order?  Should w=
e
> >
> > When we have the reservation patch (or other means to sustain mix size
> > swap allocation/free), we can test it out to get more data to reason
> > about it.
> > I consider the swap in size policy an orthogonal issue.
>
> No.  I don't think so.  If you swap-out in higher order, but swap-in in
> lower order, you make the swap clusters fragmented.

Sounds like that is the reason to apply swap-in the same order of the swap =
out.
In any case, my original point still stands. We need to have the
ability to allocate high order swap entries with reasonable success
rate *before* we have the option to choose which size to swap in. If
allocating a high order swap always fails, we will be forced to use
the low order one, there is no option to choose from. We can't evalute
"is it generally good to swap-in with swap-out order?" by actual runs.

Chris

