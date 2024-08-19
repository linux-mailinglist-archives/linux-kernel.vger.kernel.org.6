Return-Path: <linux-kernel+bounces-291695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628B69565A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2CDB20EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30D15820F;
	Mon, 19 Aug 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC58/J0V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68DC125
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056296; cv=none; b=sM3TBWD0NOJ3aRLct73RZPN1hcXCO9a2b0ipkX6Sys4UilDFy09IF5p3QFF2GYeZrMxyMQv1MZsMfOpvpz/FqIJ8CPXKpvNjPI7R0dOrGn/kFdFRpgbBXX0xVOHYumricJmWXJjRSxJ6T+qbg293Jy6xOPjG28PFI47p10uA0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056296; c=relaxed/simple;
	bh=DPL/TQRgsVVMVIwduDS8nxKOG8CATSsg8N7iUL3mjhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTyD4VjhGviJBgEvXTfVL0f4P77GLbV413WOjR3A7FZRgPpTBMoTn4YcLxyoTsVeYzpW+WbYnM22j6hv1+FrTobM6IMrkLAZilWp6FHXH+C44vtzSWoAj9Esy5i0Ua9Ct2KXx+Wln87RSGUwBbNjBEn46r4Ldns3EQjYlHliCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC58/J0V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724056294; x=1755592294;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DPL/TQRgsVVMVIwduDS8nxKOG8CATSsg8N7iUL3mjhw=;
  b=bC58/J0VMo+Df94/T58b2d+b5MLmzxNHqHD+2nAxZ44ok3kDX5ak0/mQ
   OwXGokjpbQJmiZCTjrUqyVpmFisWUaK98X+9+1KNsNCh6g2dq1zIw99mG
   tUb11+u4fFTwoSoiM8nLsBEDJZ1btGeNskXg2eOMw2FXDh+4Fk19gtxTb
   JNNPbC2/9CbIe3oT9QGLmvgJwRkcImBWGqzAHdoOjXW6QdxFhhFbFBGa+
   6Sqdi8FsoYp5aDKLOOBwT0oocOASwlIAl023pcf+Cff6W6/MdKZF7pDvB
   F1Rm92EQkAC0W1WYLiuqoU6O28yevtxjq7KcKxXv1nfAUksx5hZMX6DXF
   Q==;
X-CSE-ConnectionGUID: KSflvUP9QGqDbpqKW/Ps/A==
X-CSE-MsgGUID: obgoznvgSf+WKeGKvRQ58g==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22107687"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22107687"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:31:31 -0700
X-CSE-ConnectionGUID: jhKq1TzgRgGiwkV1rFXzBA==
X-CSE-MsgGUID: VZzVHiKeRLyxkTdcKYl6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91078117"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:31:28 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Ryan Roberts <ryan.roberts@arm.com>,
  Kalesh Singh <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <CAMgjq7DJwF+kwxJkDKnH-cnp-36xdEObrNpKGrH_GvNKQtqjSw@mail.gmail.com>
	(Kairui Song's message of "Mon, 19 Aug 2024 00:59:41 +0800")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
	<87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
	<CAMgjq7DJwF+kwxJkDKnH-cnp-36xdEObrNpKGrH_GvNKQtqjSw@mail.gmail.com>
Date: Mon, 19 Aug 2024 16:27:55 +0800
Message-ID: <87ttfghq7o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Fri, Aug 16, 2024 at 3:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
>>
>> On Thu, Aug 8, 2024 at 1:38=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>> >
>> > Chris Li <chrisl@kernel.org> writes:
>> >
>> > > On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@inte=
l.com> wrote:
>> > >>
>> > >> Hi, Chris,
>> > >>
>> > >> Chris Li <chrisl@kernel.org> writes:
>> > >>
>> > >> > This is the short term solutions "swap cluster order" listed
>> > >> > in my "Swap Abstraction" discussion slice 8 in the recent
>> > >> > LSF/MM conference.
>> > >> >
>> > >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>> > >> > orders" is introduced, it only allocates the mTHP swap entries
>> > >> > from the new empty cluster list.  It has a fragmentation issue
>> > >> > reported by Barry.
>> > >> >
>> > >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgM=
QdSMp+Ah+NSgNQ@mail.gmail.com/
>> > >> >
>> > >> > The reason is that all the empty clusters have been exhausted whi=
le
>> > >> > there are plenty of free swap entries in the cluster that are
>> > >> > not 100% free.
>> > >> >
>> > >> > Remember the swap allocation order in the cluster.
>> > >> > Keep track of the per order non full cluster list for later alloc=
ation.
>> > >> >
>> > >> > This series gives the swap SSD allocation a new separate code path
>> > >> > from the HDD allocation. The new allocator use cluster list only
>> > >> > and do not global scan swap_map[] without lock any more.
>> > >>
>> > >> This sounds good.  Can we use SSD allocation method for HDD too?
>> > >> We may not need a swap entry allocator optimized for HDD.
>> > >
>> > > Yes, that is the plan as well. That way we can completely get rid of
>> > > the old scan_swap_map_slots() code.
>> >
>> > Good!
>> >
>> > > However, considering the size of the series, let's focus on the
>> > > cluster allocation path first, get it tested and reviewed.
>> >
>> > OK.
>> >
>> > > For HDD optimization, mostly just the new block allocations portion
>> > > need some separate code path from the new cluster allocator to not do
>> > > the per cpu allocation.  Allocating from the non free list doesn't
>> > > need to change too
>> >
>> > I suggest not consider HDD optimization at all.  Just use SSD algorithm
>> > to simplify.
>>
>> Adding a global next allocating CI rather than the per CPU next CI
>> pointer is pretty trivial as well. It is just a different way to fetch
>> the next cluster pointer.
>
> Yes, if we enable the new cluster based allocator for HDD, we can
> enable THP and mTHP for HDD too, and use a global cluster_next instead
> of Per-CPU for it.
> It's easy to do with minimal changes, and should actually boost
> performance for HDD SWAP. Currently testing this locally.

I think that it's better to start with SSD algorithm.  Then, you can add
HDD specific optimization on top of it with supporting data.

BTW, I don't know why HDD shouldn't use per-CPU cluster.  Sequential
writing is more important for HDD.

>> > >>
>> > >> Hi, Hugh,
>> > >>
>> > >> What do you think about this?
>> > >>
>> > >> > This streamline the swap allocation for SSD. The code matches the
>> > >> > execution flow much better.
>> > >> >
>> > >> > User impact: For users that allocate and free mix order mTHP swap=
ping,
>> > >> > It greatly improves the success rate of the mTHP swap allocation =
after the
>> > >> > initial phase.
>> > >> >
>> > >> > It also performs faster when the swapfile is close to full, becau=
se the
>> > >> > allocator can get the non full cluster from a list rather than sc=
anning
>> > >> > a lot of swap_map entries.
>> > >>
>> > >> Do you have some test results to prove this?  Or which test below c=
an
>> > >> prove this?
>> > >
>> > > The two zram tests are already proving this. The system time
>> > > improvement is about 2% on my low CPU count machine.
>> > > Kairui has a higher core count machine and the difference is higher
>> > > there. The theory is that higher CPU count has higher contentions.
>> >
>> > I will interpret this as the performance is better in theory.  But
>> > there's almost no measurable results so far.
>>
>> I am trying to understand why don't see the performance improvement in
>> the zram setup in my cover letter as a measurable result?
>
> Hi Ying, you can check the test with the 32 cores AMD machine in the
> cover letter, as Chris pointed out the performance gain is higher as
> core number grows. The performance gain is still not much (*yet, based
> on this design thing can go much faster after HDD codes are
> dropped which enables many other optimizations, this series
> is mainly focusing on the fragmentation issue), but I think a
> stable ~4 - 8% improvement with a build linux kernel test
> could be considered measurable?

Is this the test result for "when the swapfile is close to full"?

--
Best Regards,
Huang, Ying

