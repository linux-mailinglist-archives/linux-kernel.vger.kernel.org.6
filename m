Return-Path: <linux-kernel+bounces-289227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A095435D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECCE285064
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F6144D20;
	Fri, 16 Aug 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0oCmpQi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DC144D10
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794470; cv=none; b=bdp21Ms2oJc37WVXKb/QnLp3w98Xl6s7min5fwoFtzhamwAx1zq+egLh6yZ/MvBZfomoH4xIjWsiFj2C72xyYbav/Pl5MzfjivvXf1nqP8y1OhsKALvYygqWbDvKeoEHH+81+fwkvKJqr0tboy/1P2HQLGXIIiD+LtY36Vh4lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794470; c=relaxed/simple;
	bh=JHKKZBy7vNeUhEayQtEzd+i+b2SH1IXhnsnWiZ13YP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKiP3/z28Qq0Gkj6NIBIk6O6Pa9PqI8E2DwEgyQ5FGbpLKSXMYbmIR/jC0HayvlzpMv0oZnj6aSha72VPAhTqIfZ0qoVRkWX7cg8qg4V5MvxRzCBkpIoXIhMvTuI9R6WcUbGkQxnWf4zsf9/jj6ScQA12jpmWDfkMoY9Ykk3Lyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0oCmpQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F337DC4AF11
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723794470;
	bh=JHKKZBy7vNeUhEayQtEzd+i+b2SH1IXhnsnWiZ13YP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0oCmpQiZBsQCNaPOq6HCmRtG7wSHWjpvkl2C4xs1kUoNz4bTFq3HeQ58ER7k8B34
	 uagvi+jV4d14jhldDndlcsfm4WgEuYprJXeB9/3YMsWT7dCSzTvGc9gXQPaQx2xyGI
	 478wvTsr8dALrcwE7zLHQ3YHx/il+FQfEIbTm7I0LNa2SnnQfFerEuWLzxZYmCGcKw
	 3miAuAvztIVYj6rxxruAAnedRIhZ5R8j7RRBHD1MDtxAgFgV0BEmMUkx3yUa0DpRVF
	 4hwsiXkdEtxKZzNOiX/EjPzG/zW8xJUwDNSrujWdi4mtgi6LFjlwFL0UlSN1QsA4Br
	 E9Lh0reoZbm6A==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-69483a97848so17464377b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:47:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVivpNcItqTXZ3P7EmbODeOICXi4ERttPZfphTb5QEJxNp9vNFHkz88HuMHYYfhh+0CGXPHJzgNPW4cMWpiLxMhu+z93wgzehpECZY
X-Gm-Message-State: AOJu0YxMktzkjIFjXojIbidWtKBHSGsvECktTsG416YSotsiITsOImho
	7I1kr1U+NWkFtJIZ3WEbJGwCWThZ9Pv7Iu8h8uEwjSz0cf8/VD2+AUnBmBEBgbb/AsUm1tLs5JA
	TfpL7mWsBS7CP4TWCR4gLpWAdQMfTMAX1umGS+Q==
X-Google-Smtp-Source: AGHT+IEQd3AlU0NiE+7VfRAc2+iGypr+DriGLoAKlGDaOwMv/aID0+ljHMf+DIaSus8DKYdtbQWQZiZtP6bDRC0dF40=
X-Received: by 2002:a05:690c:7684:b0:687:e11:8c34 with SMTP id
 00721157ae682-6b1bb75e76emr20434097b3.30.1723794469227; Fri, 16 Aug 2024
 00:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
 <87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 16 Aug 2024 00:47:37 -0700
X-Gmail-Original-Message-ID: <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
Message-ID: <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:38=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Hi, Chris,
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > This is the short term solutions "swap cluster order" listed
> >> > in my "Swap Abstraction" discussion slice 8 in the recent
> >> > LSF/MM conference.
> >> >
> >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> >> > orders" is introduced, it only allocates the mTHP swap entries
> >> > from the new empty cluster list.  It has a fragmentation issue
> >> > reported by Barry.
> >> >
> >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdS=
Mp+Ah+NSgNQ@mail.gmail.com/
> >> >
> >> > The reason is that all the empty clusters have been exhausted while
> >> > there are plenty of free swap entries in the cluster that are
> >> > not 100% free.
> >> >
> >> > Remember the swap allocation order in the cluster.
> >> > Keep track of the per order non full cluster list for later allocati=
on.
> >> >
> >> > This series gives the swap SSD allocation a new separate code path
> >> > from the HDD allocation. The new allocator use cluster list only
> >> > and do not global scan swap_map[] without lock any more.
> >>
> >> This sounds good.  Can we use SSD allocation method for HDD too?
> >> We may not need a swap entry allocator optimized for HDD.
> >
> > Yes, that is the plan as well. That way we can completely get rid of
> > the old scan_swap_map_slots() code.
>
> Good!
>
> > However, considering the size of the series, let's focus on the
> > cluster allocation path first, get it tested and reviewed.
>
> OK.
>
> > For HDD optimization, mostly just the new block allocations portion
> > need some separate code path from the new cluster allocator to not do
> > the per cpu allocation.  Allocating from the non free list doesn't
> > need to change too
>
> I suggest not consider HDD optimization at all.  Just use SSD algorithm
> to simplify.

Adding a global next allocating CI rather than the per CPU next CI
pointer is pretty trivial as well. It is just a different way to fetch
the next cluster pointer.

>
> >>
> >> Hi, Hugh,
> >>
> >> What do you think about this?
> >>
> >> > This streamline the swap allocation for SSD. The code matches the
> >> > execution flow much better.
> >> >
> >> > User impact: For users that allocate and free mix order mTHP swappin=
g,
> >> > It greatly improves the success rate of the mTHP swap allocation aft=
er the
> >> > initial phase.
> >> >
> >> > It also performs faster when the swapfile is close to full, because =
the
> >> > allocator can get the non full cluster from a list rather than scann=
ing
> >> > a lot of swap_map entries.
> >>
> >> Do you have some test results to prove this?  Or which test below can
> >> prove this?
> >
> > The two zram tests are already proving this. The system time
> > improvement is about 2% on my low CPU count machine.
> > Kairui has a higher core count machine and the difference is higher
> > there. The theory is that higher CPU count has higher contentions.
>
> I will interpret this as the performance is better in theory.  But
> there's almost no measurable results so far.

I am trying to understand why don't see the performance improvement in
the zram setup in my cover letter as a measurable result?

>
> > The 2% system time number does not sound like much. But consider this
> > two factors:
> > 1) swap allocator only takes a small percentage of the overall workload=
.
> > 2) The new allocator does more work.
> > The old allocator has a time tick budget. It will abort and fail to
> > find an entry when it runs out of time budget, even though there are
> > still some free entries on the swapfile.
>
> What is the time tick budget you mentioned?

I was under the impression that the previous swap entry allocation
code will not scan 100% of the swapfile if there is only one entry
left.
Please let me know if my understanding is not correct.

        /* time to take a break? */
        if (unlikely(--latency_ration < 0)) {
                if (n_ret)
                        goto done;
                spin_unlock(&si->lock);
                cond_resched();
                spin_lock(&si->lock);
                latency_ration =3D LATENCY_LIMIT;
        }


>
> > The new allocator can get to the last few free swap entries if it is
> > available. If not then, the new swap allocator will work harder on
> > swap cache reclaim.
> >
> > From the swap cache reclaim aspect, it is very hard to optimize the
> > swap cache reclaim in the old allocation path because the scan
> > position is randomized.
> > The full list and frag list both design to help reduce the repeat
> > reclaim attempt of the swap cache.
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

