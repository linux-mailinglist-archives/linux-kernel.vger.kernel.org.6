Return-Path: <linux-kernel+bounces-395773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA99BC2BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D19C1C216D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C21D6AA;
	Tue,  5 Nov 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViWwAEFJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C41288DA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771097; cv=none; b=W8M0BnBuJa7wQ83NuOeAEhgnMBS5053Q/Oi1GuAJU1JLpkwQ3uI890WTOgA9u1WGAiOoevtMZ7Q1Dvisnz8NK5zC9nHR2j40ZDCvg29hkO+Hvll0CQnPsvI0qGRpAlm2YPKvmRIUvKEtWLcgTgxQa2PIQ7hJ2WBz1Rs3qtPFkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771097; c=relaxed/simple;
	bh=601r3QiK97UotA1IcFgllJRt19fzap5qMYMAijX2K5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIelkiRxAfLGAeuK4SkpXIpIt+iUtpvgbl5to47FbMUDh4+Wi1MyaON7sqG9Rs3St9eoi9jm7RMb3jnbpQQo2dqwIEMu8dTyOg7qelQOpvK1AYWYe2XiG/Xq9sf0dcimQccCleHqVgYb85IcVziSd3caHM6tFV79elDEQdT/WP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViWwAEFJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730771095; x=1762307095;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=601r3QiK97UotA1IcFgllJRt19fzap5qMYMAijX2K5I=;
  b=ViWwAEFJoUIbZB5O2EUOmH9z5vEBXRJFb1o7bCEPRLWmTqg/rJ8O9a/d
   oGPAF23l6inZjhokGTVy3ByGXp5iOYdU0nKAnAvfzml5wYy0DC8xhi6pl
   h1ar+wTfBsIfMmXpBv+yFjiT44hfDzyKkaKW8VtGm0bbpO/YaWWkinjdl
   oMm6fTehJc3K87aKmorGb/2fnThg9RNrp45P8Ac41KCBXkGP+JajG1FTD
   wN4no55GG5X+Ngpe9ngl5vBjLl9LbBD9hukhi8MyfLZM2qjRO8ehNQ+RM
   oNFYwgL9vZPJLfBZIczacOSzNvyshpGh0Gzal7FdjS7iyLreBW6FOl470
   Q==;
X-CSE-ConnectionGUID: RNiPUaF7SIWVDh9cngzryA==
X-CSE-MsgGUID: DUOHLoPGSI6Dm1SHSrnMxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30711932"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="30711932"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:44:55 -0800
X-CSE-ConnectionGUID: HxPc0ynESoiXdCN0qR/xYA==
X-CSE-MsgGUID: AtbssF/1Ske4Hvr7Jh4JcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83362727"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:44:50 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Yosry Ahmed <yosryahmed@google.com>,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,  David Hildenbrand
 <david@redhat.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Chris
 Li <chrisl@kernel.org>,  Kairui Song <kasong@tencent.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
In-Reply-To: <CAGsJ_4z-zFESVpK2hDSs3EwHa2Ra3fYJFeQwH74LMHw3wVmB0g@mail.gmail.com>
	(Barry Song's message of "Tue, 5 Nov 2024 14:13:35 +1300")
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
	<87ses67b0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4z-zFESVpK2hDSs3EwHa2Ra3fYJFeQwH74LMHw3wVmB0g@mail.gmail.com>
Date: Tue, 05 Nov 2024 09:41:18 +0800
Message-ID: <87ldxy78zl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Tue, Nov 5, 2024 at 2:01=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Usama Arif <usamaarif642@gmail.com> writes:
>>
>> > On 04/11/2024 06:42, Huang, Ying wrote:
>> >> Johannes Weiner <hannes@cmpxchg.org> writes:
>> >>
>> >>> On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
>> >>>> On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gm=
ail.com> wrote:
>> >>>>> On 30/10/2024 21:01, Yosry Ahmed wrote:
>> >>>>>> On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@=
gmail.com> wrote:
>> >>>>>>>>> I am not sure that the approach we are trying in this patch is=
 the right way:
>> >>>>>>>>> - This patch makes it a memcg issue, but you could have memcg =
disabled and
>> >>>>>>>>> then the mitigation being tried here wont apply.
>> >>>>>>>>
>> >>>>>>>> Is the problem reproducible without memcg? I imagine only if the
>> >>>>>>>> entire system is under memory pressure. I guess we would want t=
he same
>> >>>>>>>> "mitigation" either way.
>> >>>>>>>>
>> >>>>>>> What would be a good open source benchmark/workload to test with=
out limiting memory
>> >>>>>>> in memcg?
>> >>>>>>> For the kernel build test, I can only get zswap activity to happ=
en if I build
>> >>>>>>> in cgroup and limit memory.max.
>> >>>>>>
>> >>>>>> You mean a benchmark that puts the entire system under memory
>> >>>>>> pressure? I am not sure, it ultimately depends on the size of mem=
ory
>> >>>>>> you have, among other factors.
>> >>>>>>
>> >>>>>> What if you run the kernel build test in a VM? Then you can limit=
 is
>> >>>>>> size like a memcg, although you'd probably need to leave more room
>> >>>>>> because the entire guest OS will also subject to the same limit.
>> >>>>>>
>> >>>>>
>> >>>>> I had tried this, but the variance in time/zswap numbers was very =
high.
>> >>>>> Much higher than the AMD numbers I posted in reply to Barry. So fo=
und
>> >>>>> it very difficult to make comparison.
>> >>>>
>> >>>> Hmm yeah maybe more factors come into play with global memory
>> >>>> pressure. I am honestly not sure how to test this scenario, and I
>> >>>> suspect variance will be high anyway.
>> >>>>
>> >>>> We can just try to use whatever technique we use for the memcg limit
>> >>>> though, if possible, right?
>> >>>
>> >>> You can boot a physical machine with mem=3D1G on the commandline, wh=
ich
>> >>> restricts the physical range of memory that will be initialized.
>> >>> Double check /proc/meminfo after boot, because part of that physical
>> >>> range might not be usable RAM.
>> >>>
>> >>> I do this quite often to test physical memory pressure with workloads
>> >>> that don't scale up easily, like kernel builds.
>> >>>
>> >>>>>>>>> - Instead of this being a large folio swapin issue, is it more=
 of a readahead
>> >>>>>>>>> issue? If we zswap (without the large folio swapin series) and=
 change the window
>> >>>>>>>>> to 1 in swap_vma_readahead, we might see an improvement in lin=
ux kernel build time
>> >>>>>>>>> when cgroup memory is limited as readahead would probably caus=
e swap thrashing as
>> >>>>>>>>> well.
>> >>>
>> >>> +1
>> >>>
>> >>> I also think there is too much focus on cgroup alone. The bigger iss=
ue
>> >>> seems to be how much optimistic volume we swap in when we're under
>> >>> pressure already. This applies to large folios and readahead; global
>> >>> memory availability and cgroup limits.
>> >>
>> >> The current swap readahead logic is something like,
>> >>
>> >> 1. try readahead some pages for sequential access pattern, mark them =
as
>> >>    readahead
>> >>
>> >> 2. if these readahead pages get accessed before swapped out again,
>> >>    increase 'hits' counter
>> >>
>> >> 3. for next swap in, try readahead 'hits' pages and clear 'hits'.
>> >>
>> >> So, if there's heavy memory pressure, the readaheaded pages will not =
be
>> >> accessed before being swapped out again (in 2 above), the readahead
>> >> pages will be minimal.
>> >>
>> >> IMHO, mTHP swap-in is kind of swap readahead in effect.  That is, in
>> >> addition to the pages accessed are swapped in, the adjacent pages are
>> >> swapped in (swap readahead) too.  If these readahead pages are not
>> >> accessed before swapped out again, system runs into more severe
>> >> thrashing.  This is because we lack the swap readahead window scaling
>> >> mechanism as above.  And, this is why I suggested to combine the swap
>> >> readahead mechanism and mTHP swap-in by default before.  That is, when
>> >> kernel swaps in a page, it checks current swap readahead window, and
>> >> decides mTHP order according to window size.  So, if there are heavy
>> >> memory pressure, so that the nearby pages will not be accessed before
>> >> being swapped out again, the mTHP swap-in order can be adjusted
>> >> automatically.
>> >
>> > This is a good idea to do, but I think the issue is that readahead
>> > is a folio flag and not a page flag, so only works when folio size is =
1.
>> >
>> > In the swapin_readahead swapcache path, the current implementation dec=
ides
>> > the ra_window based on hits, which is incremented in swap_cache_get_fo=
lio
>> > if it has not been gotten from swapcache before.
>> > The problem would be that we need information on how many distinct pag=
es in
>> > a large folio that has been swapped in have been accessed to decide the
>> > hits/window size, which I don't think is possible. As once the entire =
large
>> > folio has been swapped in, we won't get a fault.
>> >
>>
>> To do that, we need to move readahead flag to per-page from per-folio.
>> And we need to map only the accessed page of the folio in page fault
>> handler.  This may impact performance.  So, we may only do that for
>> sampled folios only, for example, every 100 folios.
>
> I'm not entirely sure there's a chance to gain traction on this, as the c=
urrent
> trend clearly leans toward moving flags from page to folio, not from foli=
o to
> page :-)

This may be a problem.  However, I think we can try to find a solution
for this.  Anyway, we need some way to track per-page status in a folio,
regardless how to implement it.

>>
>> >>
>> >>> It happens to manifest with THP in cgroups because that's what you
>> >>> guys are testing. But IMO, any solution to this problem should
>> >>> consider the wider scope.
>> >>>
>> >>>>>>>> I think large folio swapin would make the problem worse anyway.=
 I am
>> >>>>>>>> also not sure if the readahead window adjusts on memory pressur=
e or
>> >>>>>>>> not.
>> >>>>>>>>
>> >>>>>>> readahead window doesnt look at memory pressure. So maybe the sa=
me thing is being
>> >>>>>>> seen here as there would be in swapin_readahead?
>> >>>>>>
>> >>>>>> Maybe readahead is not as aggressive in general as large folio
>> >>>>>> swapins? Looking at swap_vma_ra_win(), it seems like the maximum =
order
>> >>>>>> of the window is the smaller of page_cluster (2 or 3) and
>> >>>>>> SWAP_RA_ORDER_CEILING (5).
>> >>>>> Yes, I was seeing 8 pages swapin (order 3) when testing. So might
>> >>>>> be similar to enabling 32K mTHP?
>> >>>>
>> >>>> Not quite.
>> >>>
>> >>> Actually, I would expect it to be...
>> >>
>> >> Me too.
>> >>
>> >>>>>> Also readahead will swapin 4k folios AFAICT, so we don't need a
>> >>>>>> contiguous allocation like large folio swapin. So that could be
>> >>>>>> another factor why readahead may not reproduce the problem.
>> >>>>
>> >>>> Because of this ^.
>> >>>
>> >>> ...this matters for the physical allocation, which might require more
>> >>> reclaim and compaction to produce the 32k. But an earlier version of
>> >>> Barry's patch did the cgroup margin fallback after the THP was alrea=
dy
>> >>> physically allocated, and it still helped.
>> >>>
>> >>> So the issue in this test scenario seems to be mostly about cgroup
>> >>> volume. And then 8 4k charges should be equivalent to a singular 32k
>> >>> charge when it comes to cgroup pressure.

--
Best Regards,
Huang, Ying

