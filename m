Return-Path: <linux-kernel+bounces-394898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9509BB582
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EA2282B78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376E1BBBDD;
	Mon,  4 Nov 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBPW9Ela"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623B1BAEDC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725969; cv=none; b=S/JGHK5fpFYngOaas0jfOX3GJBIFDa9gGlhsr8+AwrOnpkkYESHU9S3X52R6OlwfP5BqSdF8RAO/4TmSYOYmu/OdpEwZ2ZaDY5X0bbsy8Qz1p/f2RUcfLqNSELLjirPsqr1IchqUIWPu1Uf7zgE8DfcnCAVR2fJe1EkMFK36OHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725969; c=relaxed/simple;
	bh=OHqRIXhhgYXeFheeoDwpeP8qBgK0WapujvgW1kroUZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fob08D/xLr1F92TR7YSiB3QmcYtkxM0bs7BYY0sCjluz/A2C/IhpUFStKhigFY7fhV9MKJ8hkHy62fCaADId8qaB9ujSMzWUKTwhFJTDTf3lXNfhsKPXCp4dsuLBU7ssP5oz/gaBBclhdH73X1IrCw9OoSRvq8qDCAdAtgXDxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBPW9Ela; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730725967; x=1762261967;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=OHqRIXhhgYXeFheeoDwpeP8qBgK0WapujvgW1kroUZc=;
  b=bBPW9ElaPLYLVoscc9JTbW4yGCe8w4fa8/TgBosXzMifWXyCcgI2+sVS
   kB1fzZXzDu/8zDB2GFiB8aPuYQ7euVhjhoWCzI0/k9R7Rs9S33hoiz83Z
   di+5It0jipnTxd0s5q1iyVtGVtQ4X4iBKG9OcYdOA3Vm0R8C9F2Ozz8vl
   hP4azCGndVlo3piWb5y77VxBuFVFfdxl0BorEGY3VHTpudYTve4tCcpcE
   TO5yBFBS/dULLXDvHfKiH/6kroJ1a0Jc0CmIIar4l6z49BjsmkG8GHceQ
   X57W+WZJsLBLnzv7PsruyiGLDld1GVXwVtff7fOL8XVRbYy4QiksOO8ME
   Q==;
X-CSE-ConnectionGUID: eWWX30L4TtCeYgtG1Evh2g==
X-CSE-MsgGUID: gCi4BRbxQrCAnIhvgS19Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30274059"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30274059"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:12:47 -0800
X-CSE-ConnectionGUID: w+6orqxHTL2wDVxuQn9LxQ==
X-CSE-MsgGUID: Dl7LuxZTRAup44iZGNs7/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="114438131"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:12:41 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,  Yosry Ahmed
 <yosryahmed@google.com>,  Usama Arif <usamaarif642@gmail.com>,
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
In-Reply-To: <CAGsJ_4yALxTVuHOf_y00DbYp=kjEZuL3q6sWfn2Wf-Y+_G5RjA@mail.gmail.com>
	(Barry Song's message of "Mon, 4 Nov 2024 21:06:46 +1300")
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
	<CAGsJ_4yALxTVuHOf_y00DbYp=kjEZuL3q6sWfn2Wf-Y+_G5RjA@mail.gmail.com>
Date: Mon, 04 Nov 2024 21:09:09 +0800
Message-ID: <871pzr87t6.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon, Nov 4, 2024 at 7:46=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>>
>> > On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
>> >> On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gmai=
l.com> wrote:
>> >> > On 30/10/2024 21:01, Yosry Ahmed wrote:
>> >> > > On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@=
gmail.com> wrote:
>> >> > >>>> I am not sure that the approach we are trying in this patch is=
 the right way:
>> >> > >>>> - This patch makes it a memcg issue, but you could have memcg =
disabled and
>> >> > >>>> then the mitigation being tried here wont apply.
>> >> > >>>
>> >> > >>> Is the problem reproducible without memcg? I imagine only if the
>> >> > >>> entire system is under memory pressure. I guess we would want t=
he same
>> >> > >>> "mitigation" either way.
>> >> > >>>
>> >> > >> What would be a good open source benchmark/workload to test with=
out limiting memory
>> >> > >> in memcg?
>> >> > >> For the kernel build test, I can only get zswap activity to happ=
en if I build
>> >> > >> in cgroup and limit memory.max.
>> >> > >
>> >> > > You mean a benchmark that puts the entire system under memory
>> >> > > pressure? I am not sure, it ultimately depends on the size of mem=
ory
>> >> > > you have, among other factors.
>> >> > >
>> >> > > What if you run the kernel build test in a VM? Then you can limit=
 is
>> >> > > size like a memcg, although you'd probably need to leave more room
>> >> > > because the entire guest OS will also subject to the same limit.
>> >> > >
>> >> >
>> >> > I had tried this, but the variance in time/zswap numbers was very h=
igh.
>> >> > Much higher than the AMD numbers I posted in reply to Barry. So fou=
nd
>> >> > it very difficult to make comparison.
>> >>
>> >> Hmm yeah maybe more factors come into play with global memory
>> >> pressure. I am honestly not sure how to test this scenario, and I
>> >> suspect variance will be high anyway.
>> >>
>> >> We can just try to use whatever technique we use for the memcg limit
>> >> though, if possible, right?
>> >
>> > You can boot a physical machine with mem=3D1G on the commandline, which
>> > restricts the physical range of memory that will be initialized.
>> > Double check /proc/meminfo after boot, because part of that physical
>> > range might not be usable RAM.
>> >
>> > I do this quite often to test physical memory pressure with workloads
>> > that don't scale up easily, like kernel builds.
>> >
>> >> > >>>> - Instead of this being a large folio swapin issue, is it more=
 of a readahead
>> >> > >>>> issue? If we zswap (without the large folio swapin series) and=
 change the window
>> >> > >>>> to 1 in swap_vma_readahead, we might see an improvement in lin=
ux kernel build time
>> >> > >>>> when cgroup memory is limited as readahead would probably caus=
e swap thrashing as
>> >> > >>>> well.
>> >
>> > +1
>> >
>> > I also think there is too much focus on cgroup alone. The bigger issue
>> > seems to be how much optimistic volume we swap in when we're under
>> > pressure already. This applies to large folios and readahead; global
>> > memory availability and cgroup limits.
>>
>> The current swap readahead logic is something like,
>>
>> 1. try readahead some pages for sequential access pattern, mark them as
>>    readahead
>>
>> 2. if these readahead pages get accessed before swapped out again,
>>    increase 'hits' counter
>>
>> 3. for next swap in, try readahead 'hits' pages and clear 'hits'.
>>
>> So, if there's heavy memory pressure, the readaheaded pages will not be
>> accessed before being swapped out again (in 2 above), the readahead
>> pages will be minimal.
>>
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
> This might help reduce memory reclamation thrashing for kernel build
> workload running in a memory limited memcg which might not benefit
> from mTHP that much. But this mechanism has clear disadvantages:
>
> 1. Loss of large folios: For example, if you're using app A and then swit=
ch
> to app B, a significant portion (around 60%) of A's memory might be swapp=
ed
> out as it moves to the background. When you switch back to app A, a large
> portion of the memory originally in mTHP could be lost while swapping
> in small folios.

Why?  Most app A pages could be swapped in as mTHP if all readahead
pages are accessed before being swapped out again.

> Essentially, systems with a user interface operate quite differently from=
 kernel
> build workloads running under a memory-limited memcg, as they switch
> applications between the foreground and background.
>
> 2. Fragmentation of swap slots: This fragmentation increases the likeliho=
od of
> mTHP swapout failures, as it makes it harder to maintain contiguous memory
> blocks in swap.
>
> 3. Prevent the implementation of large block compression and decompression
> to achieve higher compression ratios and significantly lower CPU consumpt=
ion,
> as small folio swap-ins may still remain the predominant approach.
>
> Memory-limited systems often face challenges with larger page sizes. Even=
 on
> systems that support various base page sizes, such as 4KB, 16KB, and 64KB
> on ARM64, using 16KB or 64KB as the base page size is not always the best
> choice.  With mTHP, we have already enabled per-size settings. For this k=
ernel
> build workload operating within a limited memcg, enabling only 16kB is li=
kely
> the best option for optimizing performance and minimizing thrashing.
> /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
>
> We could focus on mTHP and seek strategies to minimize thrashing when free
> memory is severely limited :-)

IIUC, mTHP can improve performance but may waste memory too.  The best
mTHP order may be different for different workloads and system states
(e.g. high memory pressure).  So, we need a way to identify the best
mTHP order automatically.

Swap readahead window size auto-scaling can be used to design a method
to identify the best mTHP order for swap-in.  I'm open to other possible
methods too.

I admit a fixed mTHP order can be best for some specific workloads or
system states.  However, it may be hard to find one mTHP order that
works well for all workloads and system states.

>> > It happens to manifest with THP in cgroups because that's what you
>> > guys are testing. But IMO, any solution to this problem should
>> > consider the wider scope.
>> >
>> >> > >>> I think large folio swapin would make the problem worse anyway.=
 I am
>> >> > >>> also not sure if the readahead window adjusts on memory pressur=
e or
>> >> > >>> not.
>> >> > >>>
>> >> > >> readahead window doesnt look at memory pressure. So maybe the sa=
me thing is being
>> >> > >> seen here as there would be in swapin_readahead?
>> >> > >
>> >> > > Maybe readahead is not as aggressive in general as large folio
>> >> > > swapins? Looking at swap_vma_ra_win(), it seems like the maximum =
order
>> >> > > of the window is the smaller of page_cluster (2 or 3) and
>> >> > > SWAP_RA_ORDER_CEILING (5).
>> >> > Yes, I was seeing 8 pages swapin (order 3) when testing. So might
>> >> > be similar to enabling 32K mTHP?
>> >>
>> >> Not quite.
>> >
>> > Actually, I would expect it to be...
>>
>> Me too.
>>
>> >> > > Also readahead will swapin 4k folios AFAICT, so we don't need a
>> >> > > contiguous allocation like large folio swapin. So that could be
>> >> > > another factor why readahead may not reproduce the problem.
>> >>
>> >> Because of this ^.
>> >
>> > ...this matters for the physical allocation, which might require more
>> > reclaim and compaction to produce the 32k. But an earlier version of
>> > Barry's patch did the cgroup margin fallback after the THP was already
>> > physically allocated, and it still helped.
>> >
>> > So the issue in this test scenario seems to be mostly about cgroup
>> > volume. And then 8 4k charges should be equivalent to a singular 32k
>> > charge when it comes to cgroup pressure.
>>

--
Best Regards,
Huang, Ying

