Return-Path: <linux-kernel+bounces-228207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD57915C53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F99B1C2149A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6847F69;
	Tue, 25 Jun 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXv5YCY4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B84437A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282998; cv=none; b=dXIGNBNXvpFL2RgxTVgl601rN7LYZMGmC3/4Gj+2IMDWHTdtNagcKq9D3IVB0+SCpDB5du+K/frEXhseHl31tV4yZWi6Eg9wLSgwxQdkAtmObL2rqFlMo6vHjseqmGSsYzroRB86ZTDZYwRJo/S1elTu2kEiF9ZPugxUXUg/s+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282998; c=relaxed/simple;
	bh=yfMDkDJE50I6Vmpl7pq+8RLmVoJW1UQor4UEjx+wuxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSC7uiwc7aDF1pVG4PLp6K4Igi0RQZFrux//kAK9XouD/DI0x92ult2FF1oCFdcHuOZz4TnDKgPPQOgfBCShRUIe4VeO1ciaM7mTPPHWMzRd1+dJCQqtLZjfAdcUoL5/0kz0KPL5pZJWC4FxR7GGnPTR7rJtNN9zQ8XKtM+GaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXv5YCY4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719282996; x=1750818996;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yfMDkDJE50I6Vmpl7pq+8RLmVoJW1UQor4UEjx+wuxs=;
  b=FXv5YCY4LMsYxv92N32lq6tdwpSBmY3jUgGkbOFO3tio14/RUCg8BLBt
   zji6bPKWtPcp2J3QYaU1vGZU+E05VBgEzNSLRol/HYBZij8C5E5nOKTHA
   ZQ5vekYmuVw3H4KBzV0FK6Lcg9jNUAA53rnWYC0Ia7lwW8OCO8xH3WdXu
   0IVpLfgpjY4ujvYWHq2uA7r/BSgRE5EAZZUfxUZ4AYQECsmBa22lN7pV6
   /DsRShaSFusTV/QN7g3Ku+tqIcPcXpP1YIU11laQK9LmduUNPx3tVZA+Q
   sq8533GSsEm89AISOb9z9e7kAh218KW/usegW3I8Acl8fZm9YtQI4djL0
   Q==;
X-CSE-ConnectionGUID: 8eEKmeoZSD6XN6JpxeAnmg==
X-CSE-MsgGUID: S4Z0e0p8SFmUdBEcl4oOLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16104262"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16104262"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:36:36 -0700
X-CSE-ConnectionGUID: /WixksIZTmytyaPaUFYvLA==
X-CSE-MsgGUID: lzspy27TRa+RJWp1U773UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48453078"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:36:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <CANeU7Qno3o-nDjYP7Pf5ZTB9Oh_zOGU0Sv_kV+aT=Z0j_tdKjg@mail.gmail.com>
	(Chris Li's message of "Fri, 21 Jun 2024 01:43:49 -0700")
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
	<87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7Qno3o-nDjYP7Pf5ZTB9Oh_zOGU0Sv_kV+aT=Z0j_tdKjg@mail.gmail.com>
Date: Tue, 25 Jun 2024 10:34:42 +0800
Message-ID: <87bk3pzr5p.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Jun 19, 2024 at 7:32=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > This is the short term solutiolns "swap cluster order" listed
>> > in my "Swap Abstraction" discussion slice 8 in the recent
>> > LSF/MM conference.
>> >
>> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>> > orders" is introduced, it only allocates the mTHP swap entries
>> > from new empty cluster list.  It has a fragmentation issue
>> > reported by Barry.
>> >
>> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp=
+Ah+NSgNQ@mail.gmail.com/
>> >
>> > The reason is that all the empty cluster has been exhausted while
>> > there are planty of free swap entries to in the cluster that is
>> > not 100% free.
>> >
>> > Remember the swap allocation order in the cluster.
>> > Keep track of the per order non full cluster list for later allocation.
>> >
>> > User impact: For users that allocate and free mix order mTHP swapping,
>> > It greatly improves the success rate of the mTHP swap allocation after=
 the
>> > initial phase.
>> >
>> > Barry provides a test program to show the effect:
>> > https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail.=
com/
>> >
>> > Without:
>> > $ mthp-swapout
>> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 5: swpout inc: 110, swpout fallback inc: 117, Fallback perce=
ntage: 51.54%
>> > Iteration 6: swpout inc: 0, swpout fallback inc: 230, Fallback percent=
age: 100.00%
>> > Iteration 7: swpout inc: 0, swpout fallback inc: 229, Fallback percent=
age: 100.00%
>> > Iteration 8: swpout inc: 0, swpout fallback inc: 223, Fallback percent=
age: 100.00%
>> > Iteration 9: swpout inc: 0, swpout fallback inc: 224, Fallback percent=
age: 100.00%
>> > Iteration 10: swpout inc: 0, swpout fallback inc: 216, Fallback percen=
tage: 100.00%
>> > Iteration 11: swpout inc: 0, swpout fallback inc: 212, Fallback percen=
tage: 100.00%
>> > Iteration 12: swpout inc: 0, swpout fallback inc: 224, Fallback percen=
tage: 100.00%
>> > Iteration 13: swpout inc: 0, swpout fallback inc: 214, Fallback percen=
tage: 100.00%
>> >
>> > $ mthp-swapout -s
>> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 5: swpout inc: 33, swpout fallback inc: 197, Fallback percen=
tage: 85.65%
>> > Iteration 6: swpout inc: 0, swpout fallback inc: 229, Fallback percent=
age: 100.00%
>> > Iteration 7: swpout inc: 0, swpout fallback inc: 223, Fallback percent=
age: 100.00%
>> > Iteration 8: swpout inc: 0, swpout fallback inc: 219, Fallback percent=
age: 100.00%
>> > Iteration 9: swpout inc: 0, swpout fallback inc: 212, Fallback percent=
age: 100.00%
>> >
>> > With:
>> > $ mthp-swapout
>> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 6: swpout inc: 230, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > ...
>> > Iteration 94: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 95: swpout inc: 221, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 96: swpout inc: 229, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 97: swpout inc: 219, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 98: swpout inc: 222, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 100: swpout inc: 224, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
>> >
>> > $ mthp-swapout -s
>> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 5: swpout inc: 230, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 6: swpout inc: 229, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 7: swpout inc: 223, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > Iteration 8: swpout inc: 219, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>> > ...
>> > Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 95: swpout inc: 212, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 96: swpout inc: 220, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 97: swpout inc: 220, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 98: swpout inc: 216, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>> > Iteration 100: swpout inc: 225, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
>>
>> Unfortunately, the data is gotten using a special designed test program
>> which always swap-in pages with swapped-out size.  I don't know whether
>> such workloads exist in reality.  Otherwise, you need to wait for mTHP
>
> The test program is designed to simulate mTHP swap behavior using
> zsmalloc and 64KB buffer.
> If we insist on only designing for existing workloads, then zsmalloc
> using 64KB buffer usage will never be able to run, exactly due the
> kernel has high failure rate allocating swap entries for 64KB. There
> is a bit of a chick and egg problem there, such a usage can not exist
> because the kernel can't support it yet. Kernel can't add patches to
> support it because such simulation tests are not "real".
>
> We need to break this cycle to support something new.
>
>> swap-in to be merged firstly, and people reach consensus that we should
>> always swap-in pages with swapped-out size.
>
> We don't have to be always. We can identify the situation that makes
> sense. For the zram/zsmalloc 64K buffer usage case, swap out as the
> same swap in size makes sense.
> I think we have agreement on such zsmalloc 64K usage cases we do want
> to support.
>
>>
>> Alternately, we can make some design adjustment to make the patchset
>> work in current situation (mTHP swap-out, normal page swap-in).
>>
>> - One non-full cluster list for each order (same as current design)
>>
>> - When one swap entry is freed, check whether one "order+1" swap entry
>>   becomes free, if so, move the cluster to "order+1" non-full cluster
>>   list.
>
> In the intended zsmalloc usage case, there is no order+1 swap entry
> request.

This my main concern about this series.  Only the Android use cases are
considered.  The general use cases are just ignored.  Is it hard to
consider or test a normal swap partition on your development machine?

> Moving the cluster to "order+1" will make less cluster available for "ord=
er".
> For that usage case it is negative gain.

The "order+1" cluster can be used to allocate "order" cluster when
existing "order" cluster is used up.

And in this way, we can protect clusters with more free spaces so that
they may become free.

>> - When allocate swap entry with "order", get cluster from free, "order",
>>   "order+1", ... non-full cluster list.  If all are empty, fallback to
>
> I don't see that it is useful for the zsmalloc 64K buffer usage case.
> There will be order 0 and order 4 and nothing else.
>
> How about let's keep it simple for now. If we identify some workload
> this algorithm can help. We can do that as a follow up step.

The simple design isn't flexible enough for your workloads too.  For
example,

- Initially, almost only order-0 pages are swapped out, most non-full
  clusters are order-0.

- Later, quite some order-0 swap entries are freed so that there are
  quite some order-4 swap entries available.

- Order-4 pages need to be swapped out, but no enough order-4 non-full
  clusters available.

So, we need a way to migrate non-full clusters among orders to adjust to
the situations automatically.

>>   order 0.
>>
>> Do you think that this works?
>>
>> > Reported-by: Barry Song <21cnbao@gmail.com>
>> > Signed-off-by: Chris Li <chrisl@kernel.org>
>> > ---
>> > Changes in v3:
>> > - Using V1 as base.
>> > - Rename "next" to "list" for the list field, suggested by Ying.
>> > - Update comment for the locking rules for cluster fields and list,
>> >   suggested by Ying.
>> > - Allocate from the nonfull list before attempting free list, suggested
>> >   by Kairui.
>>
>> Haven't looked into this.  It appears that this breaks the original
>> discard behavior which helps performance of some SSD, please refer to
>
> Can you clarify by "discard" you mean SSD discard command or just the
> way swap allocator recycles free clusters?

The SSD discard command, like in the following URL,

https://en.wikipedia.org/wiki/Trim_(computing)

>> commit 2a8f94493432 ("swap: change block allocation algorithm for SSD").
>
> I did read that change log. Help me understand in more detail which
> discard behavior you have in mind. A lot of low end micro SD cards
> have proper FTL wear leveling now, ssd even better on that.

It's not FTL, it's discard/trim for SSD as above.

>> And as pointed out by Ryan, this may reduce the opportunity of the
>> sequential block device writing during swap-out, which may hurt
>> performance of SSD too.
>
> Only at the initial phase. If the swap IO continues, after the first
> pass fills up the swap file, the write will be random on the swapfile
> anyway. Because the swapfile only issues 2M discards commands when all
> 512 4K pages are free. The discarded area will be much smaller than
> the free area on swapfile. That combined with the random write page on
> the whole swap file. It might produce a worse internal write
> amplification for SSD, compared to only writing a subset of the
> swapfile area. I would love to hear from someone who understands SSD
> internals to confirm or deny my theory.

It depends on workloads.  Some workloads will have more severe
fragmentation than others.  For example, on quite some machines, the
swap devices will be far from being full to avoid possible OOM.

> Even let's assume the SSD wants a free block over a nonfull cluster
> first. Zswap and zram swap are not subject to SSD property. We might
> want to have a kernel option to select using  nonfree clusters over
> the free one for zram and zswap (ghost swapfile). That will help
> contain the fragmented swap area.

I suspect that it will help fragmentation avoidance much.  Please prove
its effectiveness with data firstly.  It can be a further optimization
patch in the series.

Even if we really need it, we can try to do it without a kernel option.
For example, detect whether we are using zram and enable it for zram
automatically (through a general flag).

--
Best Regards,
Huang, Ying

