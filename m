Return-Path: <linux-kernel+bounces-209362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812C90333B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC021F2814A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF41172764;
	Tue, 11 Jun 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnvNjcZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0527171660
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718089917; cv=none; b=E6ZWNVSFuo6+kbIR2PRidpKF2NaYx0M/7D0f4lIMY3SZKzb+116MZDzzs3uae1Ozl29qsHPuPWzLiq25vHmAqjt4rxSvV8g5sNFrqp+cKOvN7cD6lFaUEgjmmu8LAPUjbzmpzqWlFh9SF3mI3l0WbvOWh5ETxzXXf9y/bDrOtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718089917; c=relaxed/simple;
	bh=8U9f/wpNHk+Ymt9D7j6PaQUzgqA77GXh/cv3gXGFh70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oi5/dg08TZtgxUtYiH0PE9YcZVWbHHfPaB/XmlodCcq2ZzdOEcFBB2OlU1WJZzz41iWd42b6UXB5y7R+sYN07vhI8ljbtEuGw8PU9wPZ4wswmUCtyl8O8mu4amUjuhxSNA9RzLBKOHxV95TliN2qeYJHYm4uml5pKch+3EP1eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnvNjcZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B011C4AF49
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718089917;
	bh=8U9f/wpNHk+Ymt9D7j6PaQUzgqA77GXh/cv3gXGFh70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JnvNjcZiGFiLU2xBjgYaqNRE9xUF3uwH5aNPZ8flXmtg1YjrULLBf6l/jUta6er+F
	 dEVbJtcHpmNvziQ9j6cmKtiCpjyWwvk763nGGT1SpZQSq9GaLv3lG5KMTnKhvWkOdp
	 u3gERBmh7Vfcya/S16j1tp8E+bRzAtu+RgwAS2wz+1W5ASqzADXVN9oY4aV1BTDwFe
	 uIKzPQvigd6y/NxP3X5zH9cgtbIReM1dLACKPmz3IUyb7yZU2ORUXuDe65T/hhcVum
	 Qq3mavkK+iQ7H3ltIooobz1E+4VwZ0CyGHKyT3+tQsQpsu5gaPd79zVcVOdlFV1ffc
	 gSv0+cGi7ELoA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso7525221fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOn+GqskazdGhE3WJkJp1EnxbqnG7XwqHV7/kH/d+PgUs1GiVlKrMGetNdhCpvpG22o7sVLwl1XJLhwRzUvlvsv2sxIodQxisQAbBQ
X-Gm-Message-State: AOJu0YxbL0fPKNp1ZJoBSucVHiH+mzwA3GWKxoqtoZ1DNQUSpLXwRgki
	SHRfUUEB5RLMM7PzI+9krAAgWBHaMYTHt8iIIMSyNu7PsQvAGrZWVdPOQKGKoQJ6tVg8mFJnuXl
	Ls3LiVRrJ1isQQnmcyjGwz5Qofw==
X-Google-Smtp-Source: AGHT+IGs0LCFr6P0yHaSVN2vPSgxfoTSQXlYhz8BsxdEDy3GaE+89+V+MGAzlT142m16MpBNfg7E3FhFkHblzzD8Qc0=
X-Received: by 2002:a2e:9bd4:0:b0:2eb:dabb:f2b4 with SMTP id
 38308e7fff4ca-2ebdabbf60fmr38121021fa.32.1718089915508; Tue, 11 Jun 2024
 00:11:55 -0700 (PDT)
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
 <87wmmw6w9e.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmmw6w9e.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 11 Jun 2024 00:11:42 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=Epa438LXEX4WEccxLt6WOziLg2sp_=RA3C4PxtHD5uw@mail.gmail.com>
Message-ID: <CANeU7Q=Epa438LXEX4WEccxLt6WOziLg2sp_=RA3C4PxtHD5uw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 7:38=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >
> >> > In the page allocation side, we have the hugetlbfs which reserve som=
e
> >> > memory for high order pages.
> >> > We should have similar things to allow reserve some high order swap
> >> > entries without getting polluted by low order one.
> >>
> >> TBH, I don't like the idea of high order swap entries reservation.
> > May I know more if you don't like the idea? I understand this can be
> > controversial, because previously we like to take the THP as the best
> > effort approach. If there is some reason we can't make THP, we use the
> > order 0 as fall back.
> >
> > For discussion purpose, I want break it down to smaller steps:
> >
> > First, can we agree that the following usage case is reasonable:
> > The usage case is that, as Barry has shown, zsmalloc compresses bigger
> > size than 4K and can have both better compress ratio and CPU
> > performance gain.
> > https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.c=
om/
> >
> > So the goal is to make THP/mTHP have some reasonable success rate
> > running in the mix size swap allocation, after either low order or
> > high order swap requests can overflow the swap file size. The allocate
> > can still recover from that, after some swap entries got free.
> >
> > Please let me know if you think the above usage case and goal are not
> > reasonable for the kernel.
>
> I think that it's reasonable to improve the success rate of high-order

Glad to hear that.

> swap entries allocation.  I just think that it's hard to use the
> reservation based method.  For example, how much should be reserved?

Understand, it is harder to use than a fully transparent method, but
still better than no solution at all. The alternative right now is we
can't do it.

Regarding how much we should reserve. Similarly, how much should you
choose your swap file size? If you choose N, why not N*120% or N*80%?
That did not stop us from having a swapfile, right?

> Why system OOM when there's still swap space available?  And so forth.

Keep in mind that the reservation is an option. If you prefer the old
behavior, you don't have to use the reservation. That shouldn't be a
reason to stop others who want to use it. We don't have an alternative
solution for the long run mix size allocation yet. If there is, I like
to hear it.

> So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.

Me too. I prefer transparent over reservation if it can achieve the
same goal. Do we have a fully transparent method spec out? How to
achieve fully transparent and also avoid fragmentation caused by mix
order allocation/free?

Keep in mind that we are still in the early stage of the mTHP swap
development, I can have the reservation patch relatively easily. If
you come up with a better transparent method patch which can achieve
the same goal later, we can use it instead.

>
> >> that's really important for you, I think that it's better to design
> >> something like hugetlbfs vs core mm, that is, be separated from the
> >> normal swap subsystem as much as possible.
> >
> > I am giving hugetlbfs just to make the point using reservation, or
> > isolation of the resource to prevent mixing fragmentation existing in
> > core mm.
> > I am not suggesting copying the hugetlbfs implementation to the swap
> > system. Unlike hugetlbfs, the swap allocation is typically done from
> > the kernel, it is transparent from the application. I don't think
> > separate from the swap subsystem is a good way to go.
> >
> > This comes down to why you don't like the reservation. e.g. if we use
> > two swapfile, one swapfile is purely allocate for high order, would
> > that be better?
>
> Sorry, my words weren't accurate.  Personally, I just think that it's
> better to make reservation related code not too intrusive.

Yes. I will try to make it not too intrusive.

> And, before reservation, we need to consider something else firstly.
> Whether is it generally good to swap-in with swap-out order?  Should we

When we have the reservation patch (or other means to sustain mix size
swap allocation/free), we can test it out to get more data to reason
about it.
I consider the swap in size policy an orthogonal issue.

> consider memory wastage too?  One static policy doesn't fit all, we may
> need either a dynamic policy, or make policy configurable.
> In general, I think that we need to do this step by step.

The core swap layer needs to be able to sustain mix size swap
allocation free in the long run. Without that the swap in size policy
is meaningless.

Yes, that is the step by step approach. Allowing long run mix size
swap allocation as the first step.

> >> >> > Do you see another way to protect the high order cluster polluted=
 by
> >> >> > lower order one?
> >> >>
> >> >> If we use high-order page allocation as reference, we need somethin=
g
> >> >> like compaction to guarantee high-order allocation finally.  But we=
 are
> >> >> too far from that.
> >> >
> >> > We should consider reservation for high-order swap entry allocation
> >> > similar to hugetlbfs for memory.
> >> > Swap compaction will be very complicated because it needs to scan th=
e
> >> > PTE to migrate the swap entry. It might be easier to support folio
> >> > write out compound discontiguous swap entries. That is another way t=
o
> >> > address the fragmentation issue. We are also too far from that as
> >> > right now.
> >>
> >> That's not easy to write out compound discontiguous swap entries too.
> >> For example, how to put folios in swap cache?
> >
> > I propose the idea in the recent LSF/MM discussion, the last few
> > slides are for the discontiguous swap and it has the discontiguous
> > entries in swap cache.
> > https://drive.google.com/file/d/10wN4WgEekaiTDiAx2AND97CYLgfDJXAD/view
> >
> > Agree it is not an easy change. The cache cache would have to change
> > the assumption all offset are contiguous.
> > For swap, we kind of have some in memory data associated with per
> > offset already, so it might provide an opportunity to combine the
> > offset related data structure for swap together. Another alternative
> > might be using xarray without the multi entry property. , just treat
> > each offset like a single entry. I haven't dug deep into this
> > direction yet.
>
> Thanks!  I will study your idea.
>

I am happy to discuss if you have any questions.

> > We can have more discussion, maybe arrange an upstream alignment
> > meeting if there is interest.
>
> Sure.

Ideally, if we can resolve our differences over the mail list then we
don't need to have a separate meeting :-)

Chris

