Return-Path: <linux-kernel+bounces-291716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD589565D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620E41F23E16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2E15B561;
	Mon, 19 Aug 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTao8IhI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34315820F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056967; cv=none; b=YNS6TG/C1ZRnIf8LNqIT0iqpE/LroYxfH6N5zww0UE+6iz7wNEqqtWIkLnzbYo3YXPM4vU1flciSYbeUcpNXIsRTUoZCNvPm+CpLikUuMjohsPrqwX6E9nM+sQJzhLwnbtCrUzR96arLWOjVVb5EV0UnYtx/WJgV1ClYSAcB7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056967; c=relaxed/simple;
	bh=C7CX1eVpEgJh9Du2mCHC2zACyBnXeWvRXR+fomLra7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nGOpiWrsWDMi0sTy6Nw8zTPrHW+nc3SRpVG/mNu/nKdSS6ALwmvkK3ojFAF+uC7BzEuQSTRtiuUeoUEf+Hftr5XdLaibzM5HDgStqq6zm1aRy5mW6AHHL8taUdp9GufgJ3AmpbJsqGMgt3bC7hBZrVq9NYgiqLhi6yrhWPKWL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTao8IhI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724056966; x=1755592966;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=C7CX1eVpEgJh9Du2mCHC2zACyBnXeWvRXR+fomLra7k=;
  b=fTao8IhIRAK2FXcI0FPIxjHVFuaqXpRYDxrgdT4KLCzaHyXuHtVEl4gN
   6H6CLJG5JxeM2xd3Rhwgukre9vYZTMqL3+0H3xoqaWxtMbCmsHrbsPzOr
   oCtQl1//U+WtNNfLLVPC73VfVsZq//co2g/lDM1766xRd3beh15vAT875
   FXVtYe4dB+zC/6Ly1v6cuwRF3tjhCatQTxwwXkLdtrJKUDW63dAbH2kjo
   vrlkVTLefaM08RvNRozXnCDKhHwZs20miwDJe4kNeIf6ZJc8v92DUpXay
   M9V3QSjzCDinnkkCY7KIBXuUDU/NWuhEV1cKwZ7noWkBMfNZJnQHfFzEJ
   Q==;
X-CSE-ConnectionGUID: d+u2BuDSRLCKdmXN3JIB0Q==
X-CSE-MsgGUID: ui81SwxcQiCMW74sQpfqqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="39805889"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="39805889"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:42:45 -0700
X-CSE-ConnectionGUID: qAeKlVYSTBesivUcFlpiVA==
X-CSE-MsgGUID: LVD4xajlRMKAvPa+e7r1tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60458060"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:42:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
	(Chris Li's message of "Fri, 16 Aug 2024 00:47:37 -0700")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
	<87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbUenbKM+i5x6xR=2A=8tz4Eu2azDFAV_ksvn2TtrFsVOQ@mail.gmail.com>
Date: Mon, 19 Aug 2024 16:39:10 +0800
Message-ID: <87plq4hpox.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Thu, Aug 8, 2024 at 1:38=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Hi, Chris,
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >> > This is the short term solutions "swap cluster order" listed
>> >> > in my "Swap Abstraction" discussion slice 8 in the recent
>> >> > LSF/MM conference.
>> >> >
>> >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>> >> > orders" is introduced, it only allocates the mTHP swap entries
>> >> > from the new empty cluster list.  It has a fragmentation issue
>> >> > reported by Barry.
>> >> >
>> >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQd=
SMp+Ah+NSgNQ@mail.gmail.com/
>> >> >
>> >> > The reason is that all the empty clusters have been exhausted while
>> >> > there are plenty of free swap entries in the cluster that are
>> >> > not 100% free.
>> >> >
>> >> > Remember the swap allocation order in the cluster.
>> >> > Keep track of the per order non full cluster list for later allocat=
ion.
>> >> >
>> >> > This series gives the swap SSD allocation a new separate code path
>> >> > from the HDD allocation. The new allocator use cluster list only
>> >> > and do not global scan swap_map[] without lock any more.
>> >>
>> >> This sounds good.  Can we use SSD allocation method for HDD too?
>> >> We may not need a swap entry allocator optimized for HDD.
>> >
>> > Yes, that is the plan as well. That way we can completely get rid of
>> > the old scan_swap_map_slots() code.
>>
>> Good!
>>
>> > However, considering the size of the series, let's focus on the
>> > cluster allocation path first, get it tested and reviewed.
>>
>> OK.
>>
>> > For HDD optimization, mostly just the new block allocations portion
>> > need some separate code path from the new cluster allocator to not do
>> > the per cpu allocation.  Allocating from the non free list doesn't
>> > need to change too
>>
>> I suggest not consider HDD optimization at all.  Just use SSD algorithm
>> to simplify.
>
> Adding a global next allocating CI rather than the per CPU next CI
> pointer is pretty trivial as well. It is just a different way to fetch
> the next cluster pointer.

For HDD optimization, I mean original no struct swap_cluster_info etc.

>>
>> >>
>> >> Hi, Hugh,
>> >>
>> >> What do you think about this?
>> >>
>> >> > This streamline the swap allocation for SSD. The code matches the
>> >> > execution flow much better.
>> >> >
>> >> > User impact: For users that allocate and free mix order mTHP swappi=
ng,
>> >> > It greatly improves the success rate of the mTHP swap allocation af=
ter the
>> >> > initial phase.
>> >> >
>> >> > It also performs faster when the swapfile is close to full, because=
 the
>> >> > allocator can get the non full cluster from a list rather than scan=
ning
>> >> > a lot of swap_map entries.
>> >>
>> >> Do you have some test results to prove this?  Or which test below can
>> >> prove this?
>> >
>> > The two zram tests are already proving this. The system time
>> > improvement is about 2% on my low CPU count machine.
>> > Kairui has a higher core count machine and the difference is higher
>> > there. The theory is that higher CPU count has higher contentions.
>>
>> I will interpret this as the performance is better in theory.  But
>> there's almost no measurable results so far.
>
> I am trying to understand why don't see the performance improvement in
> the zram setup in my cover letter as a measurable result?

IIUC, there's no benchmark score difference, just system time.  And the
number is low too.

For Kairui's test, does all performance improvement come from "swapfile
is close to full"?

>>
>> > The 2% system time number does not sound like much. But consider this
>> > two factors:
>> > 1) swap allocator only takes a small percentage of the overall workloa=
d.
>> > 2) The new allocator does more work.
>> > The old allocator has a time tick budget. It will abort and fail to
>> > find an entry when it runs out of time budget, even though there are
>> > still some free entries on the swapfile.
>>
>> What is the time tick budget you mentioned?
>
> I was under the impression that the previous swap entry allocation
> code will not scan 100% of the swapfile if there is only one entry
> left.
> Please let me know if my understanding is not correct.
>
>         /* time to take a break? */
>         if (unlikely(--latency_ration < 0)) {
>                 if (n_ret)
>                         goto done;
>                 spin_unlock(&si->lock);
>                 cond_resched();
>                 spin_lock(&si->lock);
>                 latency_ration =3D LATENCY_LIMIT;
>         }

IIUC, this is to reduce latency via cond_resched().  If n_ret !=3D 0, we
have allocated some swap entries successfully, it's OK to return to
reduce allocation latency.

>
>>
>> > The new allocator can get to the last few free swap entries if it is
>> > available. If not then, the new swap allocator will work harder on
>> > swap cache reclaim.
>> >
>> > From the swap cache reclaim aspect, it is very hard to optimize the
>> > swap cache reclaim in the old allocation path because the scan
>> > position is randomized.
>> > The full list and frag list both design to help reduce the repeat
>> > reclaim attempt of the swap cache.
>>
>> [snip]
>>

--
Best Regards,
Huang, Ying

