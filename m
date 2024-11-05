Return-Path: <linux-kernel+bounces-395738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F99BC240
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D48A1C22644
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B717583;
	Tue,  5 Nov 2024 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E16od+dL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25954C97
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768479; cv=none; b=MJalGuhrvqNAijURqPejZf9srGzcRr20EuajZuFG5Mew2RqS6kXKDGTC6BRG+VXCoONxMQFqA3h3ZBkCWVRMPt3Vzi8W9BSDM04sH6WfuIDgZSe6OIfPYb/Ww00rhZS1mj0QxIICOM+3fyOBjzr4AQimhLp22LXUAwGxgO5bhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768479; c=relaxed/simple;
	bh=6Smu2+pVyEdVlPhPaVJ8lO8x4GnQZiyiM07wNVergK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ql3/xd4Zb4WGc6WKfZaehkUApnOqbmE7ClgksqxYMv9h6QHHhWNLpLfMsoFi2psgfSsEw5aaZwgwEp7nfh9lc+Gygmc21Y2N7J9aCveSBLuxrxiIlpXmQTEmB2JKNkNPt6s188+4ZkvPJpUy0HmDWqZhPGcFq2zBNPW2rLkfVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E16od+dL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730768478; x=1762304478;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=6Smu2+pVyEdVlPhPaVJ8lO8x4GnQZiyiM07wNVergK8=;
  b=E16od+dLrJuaJSazUGP5mSnoTYl7sqYmqe2R+KLPmyzIJCUEM51SjYc0
   VsO7QAGTX3km+GXrwUOSKYaksM/XG8ZEIdqPbfI07LSJtUtQE819rE0NV
   bcRs2aMsur4Mj3mZCra0/N/m4Ihxqmr0+iRkXfp0Zqo60qBkKSpjMR/sc
   /MKZZT8Ua1mYi21e37XntLT7w9/4d3z3JftB+f/UeE64GCGIwu02r579J
   QJCncCciZUmrJwzSA4IHhG80/NooYctI+H4YbTT3Uqfrru7TJ0iukm+PW
   WUsSAV43qqpOkMjbb1pVXuE1xa2AC627bJWRiH5NgqAB3zClvBnKmQaOt
   A==;
X-CSE-ConnectionGUID: ioZBJYGKTNin70SfS6BGuA==
X-CSE-MsgGUID: DO4iF+yYTFemuqNieJou2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30442044"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30442044"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:01:17 -0800
X-CSE-ConnectionGUID: f3PogGT+TbOvp2DAvmUk/Q==
X-CSE-MsgGUID: BEiD0mGXTNyRCFv3B3Pkng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="87754317"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:01:13 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,  Barry Song <21cnbao@gmail.com>,
  Yosry Ahmed <yosryahmed@google.com>,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Barry Song
 <v-songbaohua@oppo.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  David Hildenbrand <david@redhat.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  Chris Li
 <chrisl@kernel.org>,  Kairui Song <kasong@tencent.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
In-Reply-To: <3f684183-c6df-4f2f-9e33-91ce43c791eb@gmail.com> (Usama Arif's
	message of "Mon, 4 Nov 2024 12:13:22 +0000")
References: <20241027001444.3233-1-21cnbao@gmail.com>
	<33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
	<CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
	<e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
	<CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
	<852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
	<CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
	<c76635d7-f382-433a-8900-72bca644cdaa@gmail.com>
	<CAJD7tkYSRCjtEwP=o_n_ZhdfO8nga-z-a=RirvcKL7AYO76XJw@mail.gmail.com>
	<20241031153830.GA799903@cmpxchg.org>
	<87a5ef8ppq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<3f684183-c6df-4f2f-9e33-91ce43c791eb@gmail.com>
Date: Tue, 05 Nov 2024 08:57:40 +0800
Message-ID: <87ses67b0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Usama Arif <usamaarif642@gmail.com> writes:

> On 04/11/2024 06:42, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>>=20
>>> On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
>>>> On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gmail=
.com> wrote:
>>>>> On 30/10/2024 21:01, Yosry Ahmed wrote:
>>>>>> On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@gma=
il.com> wrote:
>>>>>>>>> I am not sure that the approach we are trying in this patch is th=
e right way:
>>>>>>>>> - This patch makes it a memcg issue, but you could have memcg dis=
abled and
>>>>>>>>> then the mitigation being tried here wont apply.
>>>>>>>>
>>>>>>>> Is the problem reproducible without memcg? I imagine only if the
>>>>>>>> entire system is under memory pressure. I guess we would want the =
same
>>>>>>>> "mitigation" either way.
>>>>>>>>
>>>>>>> What would be a good open source benchmark/workload to test without=
 limiting memory
>>>>>>> in memcg?
>>>>>>> For the kernel build test, I can only get zswap activity to happen =
if I build
>>>>>>> in cgroup and limit memory.max.
>>>>>>
>>>>>> You mean a benchmark that puts the entire system under memory
>>>>>> pressure? I am not sure, it ultimately depends on the size of memory
>>>>>> you have, among other factors.
>>>>>>
>>>>>> What if you run the kernel build test in a VM? Then you can limit is
>>>>>> size like a memcg, although you'd probably need to leave more room
>>>>>> because the entire guest OS will also subject to the same limit.
>>>>>>
>>>>>
>>>>> I had tried this, but the variance in time/zswap numbers was very hig=
h.
>>>>> Much higher than the AMD numbers I posted in reply to Barry. So found
>>>>> it very difficult to make comparison.
>>>>
>>>> Hmm yeah maybe more factors come into play with global memory
>>>> pressure. I am honestly not sure how to test this scenario, and I
>>>> suspect variance will be high anyway.
>>>>
>>>> We can just try to use whatever technique we use for the memcg limit
>>>> though, if possible, right?
>>>
>>> You can boot a physical machine with mem=3D1G on the commandline, which
>>> restricts the physical range of memory that will be initialized.
>>> Double check /proc/meminfo after boot, because part of that physical
>>> range might not be usable RAM.
>>>
>>> I do this quite often to test physical memory pressure with workloads
>>> that don't scale up easily, like kernel builds.
>>>
>>>>>>>>> - Instead of this being a large folio swapin issue, is it more of=
 a readahead
>>>>>>>>> issue? If we zswap (without the large folio swapin series) and ch=
ange the window
>>>>>>>>> to 1 in swap_vma_readahead, we might see an improvement in linux =
kernel build time
>>>>>>>>> when cgroup memory is limited as readahead would probably cause s=
wap thrashing as
>>>>>>>>> well.
>>>
>>> +1
>>>
>>> I also think there is too much focus on cgroup alone. The bigger issue
>>> seems to be how much optimistic volume we swap in when we're under
>>> pressure already. This applies to large folios and readahead; global
>>> memory availability and cgroup limits.
>>=20
>> The current swap readahead logic is something like,
>>=20
>> 1. try readahead some pages for sequential access pattern, mark them as
>>    readahead
>>=20
>> 2. if these readahead pages get accessed before swapped out again,
>>    increase 'hits' counter
>>=20
>> 3. for next swap in, try readahead 'hits' pages and clear 'hits'.
>>=20
>> So, if there's heavy memory pressure, the readaheaded pages will not be
>> accessed before being swapped out again (in 2 above), the readahead
>> pages will be minimal.
>>=20
>> IMHO, mTHP swap-in is kind of swap readahead in effect.  That is, in
>> addition to the pages accessed are swapped in, the adjacent pages are
>> swapped in (swap readahead) too.  If these readahead pages are not
>> accessed before swapped out again, system runs into more severe
>> thrashing.  This is because we lack the swap readahead window scaling
>> mechanism as above.  And, this is why I suggested to combine the swap
>> readahead mechanism and mTHP swap-in by default before.  That is, when
>> kernel swaps in a page, it checks current swap readahead window, and
>> decides mTHP order according to window size.  So, if there are heavy
>> memory pressure, so that the nearby pages will not be accessed before
>> being swapped out again, the mTHP swap-in order can be adjusted
>> automatically.
>
> This is a good idea to do, but I think the issue is that readahead
> is a folio flag and not a page flag, so only works when folio size is 1.
>
> In the swapin_readahead swapcache path, the current implementation decides
> the ra_window based on hits, which is incremented in swap_cache_get_folio
> if it has not been gotten from swapcache before.
> The problem would be that we need information on how many distinct pages =
in
> a large folio that has been swapped in have been accessed to decide the
> hits/window size, which I don't think is possible. As once the entire lar=
ge
> folio has been swapped in, we won't get a fault.
>

To do that, we need to move readahead flag to per-page from per-folio.
And we need to map only the accessed page of the folio in page fault
handler.  This may impact performance.  So, we may only do that for
sampled folios only, for example, every 100 folios.

>>=20
>>> It happens to manifest with THP in cgroups because that's what you
>>> guys are testing. But IMO, any solution to this problem should
>>> consider the wider scope.
>>>
>>>>>>>> I think large folio swapin would make the problem worse anyway. I =
am
>>>>>>>> also not sure if the readahead window adjusts on memory pressure or
>>>>>>>> not.
>>>>>>>>
>>>>>>> readahead window doesnt look at memory pressure. So maybe the same =
thing is being
>>>>>>> seen here as there would be in swapin_readahead?
>>>>>>
>>>>>> Maybe readahead is not as aggressive in general as large folio
>>>>>> swapins? Looking at swap_vma_ra_win(), it seems like the maximum ord=
er
>>>>>> of the window is the smaller of page_cluster (2 or 3) and
>>>>>> SWAP_RA_ORDER_CEILING (5).
>>>>> Yes, I was seeing 8 pages swapin (order 3) when testing. So might
>>>>> be similar to enabling 32K mTHP?
>>>>
>>>> Not quite.
>>>
>>> Actually, I would expect it to be...
>>=20
>> Me too.
>>=20
>>>>>> Also readahead will swapin 4k folios AFAICT, so we don't need a
>>>>>> contiguous allocation like large folio swapin. So that could be
>>>>>> another factor why readahead may not reproduce the problem.
>>>>
>>>> Because of this ^.
>>>
>>> ...this matters for the physical allocation, which might require more
>>> reclaim and compaction to produce the 32k. But an earlier version of
>>> Barry's patch did the cgroup margin fallback after the THP was already
>>> physically allocated, and it still helped.
>>>
>>> So the issue in this test scenario seems to be mostly about cgroup
>>> volume. And then 8 4k charges should be equivalent to a singular 32k
>>> charge when it comes to cgroup pressure.

--
Best Regards,
Huang, Ying

