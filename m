Return-Path: <linux-kernel+bounces-279115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4394B920
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E991C2338C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C81891C3;
	Thu,  8 Aug 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA/YII6h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44211465B3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106285; cv=none; b=apltTOI042+rX0W0iWhMmxF6efQWWAzCMJTF8Z/rC17sOJncEr0j+yVMez58039iUroNjzfKDlG5qdOxnb3KDfyC/vZl+g/ml/pq5Q9+yqPEey4S2is3M4YI4xy8BRmR7KQQV0vr0HIsyczATln638HpkMNFHFXVfLWcLBDx4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106285; c=relaxed/simple;
	bh=ez3phI6BBa0eNuW0PpXznPWLOTIj96ikhsWv7XGF8dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WbtQpehRaPZFpBOXOT0mYdIWfeYuKLyKEH3Ys8dUJWV+NHzYBRs9Aylqfv2P5bY/gWOmMRR7jZ8CEporuIJJIirbXBOlayAGRUPJQCzJ6eQtCV6u7dWm+kx6CuP8fZocwOn+QQwanQB79E5zpFNnETHCwaR3Jek6zGiJzJEbv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA/YII6h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723106284; x=1754642284;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ez3phI6BBa0eNuW0PpXznPWLOTIj96ikhsWv7XGF8dI=;
  b=EA/YII6hkFnqBly4Gt5NWpbNNuVya/oOgAoBXMN79dtqGz8G5om5XhQW
   A4cNkL6zlAwWr+T7tcwYScWUsrGmcSah/bxZauGzN2w+8pAu5KSjKBe5f
   slJLNyxN8T01wIpb1CK0ffpdyQkA6Q2nP5S8CV8lEDnii9L5m83pf6ogk
   5XKhtUG7LQtEGD/hKS9m0jXvCeBw7qgU45AM9FrEFHIcBlLy6N4sZ8Mkq
   s33iKw31ANSzS+hPCck3rSk1BxpEp2NGoPlpCdL9qrh2z9vs3zdk8vdFf
   UhLpscQPyhde3XUqfo/AX4bvev4MIAQMWU3pOSwyNEk+BSZg5oMiglTRv
   g==;
X-CSE-ConnectionGUID: xEJ9XIHXRSqRlZPrO+IBPw==
X-CSE-MsgGUID: 2PQCaPx1T/mnyBVlohSxQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24980099"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="24980099"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:38:03 -0700
X-CSE-ConnectionGUID: /Wyuo3tcSRK4+9UytqicGw==
X-CSE-MsgGUID: 4Jx1yeNdRDurVQsKh8JbRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61541546"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:38:00 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
	(Chris Li's message of "Wed, 7 Aug 2024 13:42:20 -0700")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
Date: Thu, 08 Aug 2024 16:34:27 +0800
Message-ID: <87sevfza3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Hi, Chris,
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > This is the short term solutions "swap cluster order" listed
>> > in my "Swap Abstraction" discussion slice 8 in the recent
>> > LSF/MM conference.
>> >
>> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>> > orders" is introduced, it only allocates the mTHP swap entries
>> > from the new empty cluster list.  It has a fragmentation issue
>> > reported by Barry.
>> >
>> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp=
+Ah+NSgNQ@mail.gmail.com/
>> >
>> > The reason is that all the empty clusters have been exhausted while
>> > there are plenty of free swap entries in the cluster that are
>> > not 100% free.
>> >
>> > Remember the swap allocation order in the cluster.
>> > Keep track of the per order non full cluster list for later allocation.
>> >
>> > This series gives the swap SSD allocation a new separate code path
>> > from the HDD allocation. The new allocator use cluster list only
>> > and do not global scan swap_map[] without lock any more.
>>
>> This sounds good.  Can we use SSD allocation method for HDD too?
>> We may not need a swap entry allocator optimized for HDD.
>
> Yes, that is the plan as well. That way we can completely get rid of
> the old scan_swap_map_slots() code.

Good!

> However, considering the size of the series, let's focus on the
> cluster allocation path first, get it tested and reviewed.

OK.

> For HDD optimization, mostly just the new block allocations portion
> need some separate code path from the new cluster allocator to not do
> the per cpu allocation.  Allocating from the non free list doesn't
> need to change too

I suggest not consider HDD optimization at all.  Just use SSD algorithm
to simplify.

>>
>> Hi, Hugh,
>>
>> What do you think about this?
>>
>> > This streamline the swap allocation for SSD. The code matches the
>> > execution flow much better.
>> >
>> > User impact: For users that allocate and free mix order mTHP swapping,
>> > It greatly improves the success rate of the mTHP swap allocation after=
 the
>> > initial phase.
>> >
>> > It also performs faster when the swapfile is close to full, because the
>> > allocator can get the non full cluster from a list rather than scanning
>> > a lot of swap_map entries.
>>
>> Do you have some test results to prove this?  Or which test below can
>> prove this?
>
> The two zram tests are already proving this. The system time
> improvement is about 2% on my low CPU count machine.
> Kairui has a higher core count machine and the difference is higher
> there. The theory is that higher CPU count has higher contentions.

I will interpret this as the performance is better in theory.  But
there's almost no measurable results so far.

> The 2% system time number does not sound like much. But consider this
> two factors:
> 1) swap allocator only takes a small percentage of the overall workload.
> 2) The new allocator does more work.
> The old allocator has a time tick budget. It will abort and fail to
> find an entry when it runs out of time budget, even though there are
> still some free entries on the swapfile.

What is the time tick budget you mentioned?

> The new allocator can get to the last few free swap entries if it is
> available. If not then, the new swap allocator will work harder on
> swap cache reclaim.
>
> From the swap cache reclaim aspect, it is very hard to optimize the
> swap cache reclaim in the old allocation path because the scan
> position is randomized.
> The full list and frag list both design to help reduce the repeat
> reclaim attempt of the swap cache.

[snip]

--
Best Regards,
Huang, Ying

