Return-Path: <linux-kernel+bounces-218943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB7890C803
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C960B1C208C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78808157A5A;
	Tue, 18 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxq++0DV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED413E8A0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703133; cv=none; b=IRPY+4yp3aQHN7zTCPLRPGChqDRkzFmGvPG7imD1vuOoTs3ETquNMPOyoUXAbjlOHpMImTWmyL32ZRuhALyU4AVN7lkulBnONCkmtk9ldg3qH67LdrQtrxVlBEYNT/otIj5ebMs2vv4FXFO5/bG9CMTLYWVdyWhSaiSMDwpf/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703133; c=relaxed/simple;
	bh=RzTXPSvJC6aaqPPKMMURA/I5IDh2yNcBeKoMyc5LG+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScXQLfeS/OVj0JEdCL9WdVyq1TvWliwLgeStuOQ72RpBfrFlkzvOKvt0mJ0gVHj5p4uPWTtbYxKdcq49w22AUGopLWCUj+9ilWdEiAQX7CcbSqqahSRKbN+6kxlSOIGGCzjOPHYYh1Sf45IjCE6VgXR17qRfbONm2EgJzV13gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxq++0DV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5BBC4AF1D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718703133;
	bh=RzTXPSvJC6aaqPPKMMURA/I5IDh2yNcBeKoMyc5LG+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rxq++0DV9Ix4+tP32p1L6JUdEvyGHxzMuTSe12D3h3NW81rUPsp6pU/BQtnn/+ZWi
	 C3nyjjRcW0eDm57my7GDH9sF7hZ2lwh3Ymy50qSJUSbGjNgrPNc3PZmxsp6QGE5+q8
	 ojm5xZFihZBXP52O/LhfDSK76upPo/zLxMddMu6HUG6r95MSTUb/IpxieUnV14FQ2K
	 qz9SlFaLk4hvRMmNDjr9M8rvOFs99VUoZ5+mT3BdSDg9/HIEHZjmA00CDard5A9xKM
	 oJOiL8QQamPc1wqQ0ox2Fio0PJOOlP5Jaj/Fdrx5kRdvXv63PNcLmNXMfoZ0xV1kUL
	 ZVHjBunukEefQ==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375af3538f2so20870475ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxC53IjBmtXQsbVj35qLcT3m/1N6iEScazNf2Pq5f4Vmbpwte+QkM1++Ch8odf/vemPY7yQzOeRYn7sVELRSD+JPAZ+4xMVK1X9B8U
X-Gm-Message-State: AOJu0Yxwov8HiF/61pPrC5Ja+1feDnxr1iV9wPS+dBR7QXHO2WdSsAb6
	AKCj2YuyR1o7knND7Z1BF5xALi5LeCfdZ3WeP+JfNto6j6n4kN8Bf9PS/As2HxYczwHaZvrFOvc
	Ok7rLYm+aXfuv3nipo5GJk3loaqsBq/WlgwGe
X-Google-Smtp-Source: AGHT+IGDT2gwYsBDsjs6Av3g2E8Dt0OuIpMrasTGPHmQmFzO4gRxDWFVNW8c3dBisJ0mlor+iFUQwGnf6dV0EonZ7N4=
X-Received: by 2002:a05:6e02:17c9:b0:36c:4688:85aa with SMTP id
 e9e14a558f8ab-375e0e44edbmr147995195ab.10.1718703131415; Tue, 18 Jun 2024
 02:32:11 -0700 (PDT)
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
 <87a5jp6xuo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuMi198++-OHqE5pG1y3BnvRBPepG59zpq-wqjbgrrLdHw@mail.gmail.com>
 <8734pa68rl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734pa68rl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 18 Jun 2024 02:31:58 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOfYMiD-aEhLa9i+oxAtasDcPhFb6__i6QRB2dGO1Lhcg@mail.gmail.com>
Message-ID: <CAF8kJuOfYMiD-aEhLa9i+oxAtasDcPhFb6__i6QRB2dGO1Lhcg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:56=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > That is in general true with all kernel development regardless of
> > using options or not. If there is a bug in my patch, I will need to
> > debug and fix it or the patch might be reverted.
> >
> > I don't see that as a reason to take the option path or not. The
> > option just means the user taking this option will need to understand
> > the trade off and accept the defined behavior of that option.
>
> User configuration knobs are not forbidden for Linux kernel.  But we are
> more careful about them because they will introduce ABI which we need to
> maintain forever.  And they are hard to be used for users.  Optimizing
> automatically is generally the better solution.  So, I suggest you to
> think more about the automatically solution before diving into a new
> option.

I did, see my reply. Right now there are just no other options.

>
> >>
> >> >> So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.
> >> >
> >> > Me too. I prefer transparent over reservation if it can achieve the
> >> > same goal. Do we have a fully transparent method spec out? How to
> >> > achieve fully transparent and also avoid fragmentation caused by mix
> >> > order allocation/free?
> >> >
> >> > Keep in mind that we are still in the early stage of the mTHP swap
> >> > development, I can have the reservation patch relatively easily. If
> >> > you come up with a better transparent method patch which can achieve
> >> > the same goal later, we can use it instead.
> >>
> >> Because we are still in the early stage, I think that we should try to
> >> improve transparent solution firstly.  Personally, what I don't like i=
s
> >> that we don't work on the transparent solution because we have the
> >> reservation solution.
> >
> > Do you have a road map or the design for the transparent solution you c=
an share?
> > I am interested to know what is the short term step(e.g. a month)  in
> > this transparent solution you have in mind, so we can compare the
> > different approaches. I can't reason much just by the name
> > "transparent solution" itself. Need more technical details.
> >
> > Right now we have a clear usage case we want to support, the swap
> > in/out mTHP with bigger zsmalloc buffers. We can start with the
> > limited usage case first then move to more general ones.
>
> TBH, This is what I don't like.  It appears that you refuse to think
> about the transparent (or automatic) solution.

Actually, that is not true, you make the wrong assumption about what I
have considered. I want to find out what you have in mind to compare
the near term solutions.

In my recent LSF slide I already list 3 options to address this
fragmentation problem.
From easy to hard:
1) Assign cluster an order on allocation and remember the cluster
order. (short term).
That is this patch series
2) Buddy allocation on the swap entry (longer term)
3) Folio write out compound discontinuous swap entry. (ultimate)

I also considered 4), which I did not put into the slide, because it
is less effective than 3)
4) migrating the swap entries, which require scan page table entry.
I briefly mentioned it during the session.

3) should might qualify as your transparent solution. It is just much
harder to implement.
Even when we have 3), having some form of 1) can be beneficial as
well. (less IO count, no indirect layer of swap offset).

>
> I haven't thought about them thoroughly, but at least we may think about
>
> - promoting low order non-full cluster when we find a free high order
>   swap entries.
>
> - stealing a low order non-full cluster with low usage count for
>   high-order allocation.

Now we are talking.
These two above fall well within 2) the buddy allocators
But the buddy allocator will not be able to address all fragmentation
issues, due to the allocator not being controlled the life cycle of
the swap entry.
It will not help Barry's zsmalloc usage case much because android
likes to keep the swapfile full. I can already see that.

> - freeing more swap entries when swap devices become fragmented.

That requires a scan page table to free the swap entry, basically 4).

It is all about investment and return. 1) is relatively easy to
implement and with good improvement and return.

Chris

> >> >> >> that's really important for you, I think that it's better to des=
ign
> >> >> >> something like hugetlbfs vs core mm, that is, be separated from =
the
> >> >> >> normal swap subsystem as much as possible.
> >> >> >
> >> >> > I am giving hugetlbfs just to make the point using reservation, o=
r
> >> >> > isolation of the resource to prevent mixing fragmentation existin=
g in
> >> >> > core mm.
> >> >> > I am not suggesting copying the hugetlbfs implementation to the s=
wap
> >> >> > system. Unlike hugetlbfs, the swap allocation is typically done f=
rom
> >> >> > the kernel, it is transparent from the application. I don't think
> >> >> > separate from the swap subsystem is a good way to go.
> >> >> >
> >> >> > This comes down to why you don't like the reservation. e.g. if we=
 use
> >> >> > two swapfile, one swapfile is purely allocate for high order, wou=
ld
> >> >> > that be better?
> >> >>
> >> >> Sorry, my words weren't accurate.  Personally, I just think that it=
's
> >> >> better to make reservation related code not too intrusive.
> >> >
> >> > Yes. I will try to make it not too intrusive.
> >> >
> >> >> And, before reservation, we need to consider something else firstly=
.
> >> >> Whether is it generally good to swap-in with swap-out order?  Shoul=
d we
> >> >
> >> > When we have the reservation patch (or other means to sustain mix si=
ze
> >> > swap allocation/free), we can test it out to get more data to reason
> >> > about it.
> >> > I consider the swap in size policy an orthogonal issue.
> >>
> >> No.  I don't think so.  If you swap-out in higher order, but swap-in i=
n
> >> lower order, you make the swap clusters fragmented.
> >
> > Sounds like that is the reason to apply swap-in the same order of the s=
wap out.
> > In any case, my original point still stands. We need to have the
> > ability to allocate high order swap entries with reasonable success
> > rate *before* we have the option to choose which size to swap in. If
> > allocating a high order swap always fails, we will be forced to use
> > the low order one, there is no option to choose from. We can't evalute
> > "is it generally good to swap-in with swap-out order?" by actual runs.
>
> I think we don't need to fight for that.  Just prove the value of your
> patchset with reasonable use cases and normal workloads.  Data will
> persuade people.

