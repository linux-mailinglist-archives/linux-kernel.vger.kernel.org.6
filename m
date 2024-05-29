Return-Path: <linux-kernel+bounces-193808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B753F8D3266
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0A41C22804
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB41168C25;
	Wed, 29 May 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/RgnOoQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAC8828
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973037; cv=none; b=pJmbijdX9c1Tx3TdoGi9JbCqDgCjw5wmLz0x8emo5tG3TNBHMIZL0Ztx2uq6gh2EbC0M/ZH2wILgesuELw/+314zuYkkBTb4/+2bbzZVsWky7NGWk4vUyYSXO+CrR7r/2FyY5FhSAp2yp08AKjLCeRbOP7iySvSRsCHFRHznGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973037; c=relaxed/simple;
	bh=9/uaxa/woxU5qbYNPehRwZbjzzi4VwJVgZ6Aq5w5LAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKh2j8T+OVW87dn9oAYKHd1tGBIXv3J64OaJnoTNUZYMf1VhFcueGx3hUufAwS+nnwEI6eueSzllFzPNQNL9UAo0rF9ksoc+O0TW68HXKw+VHF7q/cbdHRa0o8tphfZa9PSlPyK/my6IaDC78kNcwCEv9J2tgaAIYDqgG6CmvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/RgnOoQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716973036; x=1748509036;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9/uaxa/woxU5qbYNPehRwZbjzzi4VwJVgZ6Aq5w5LAU=;
  b=R/RgnOoQm/oOGSfYIA4a/DqP5O4aFy0UpPgmzHbbgfKipEGR8yzuctGI
   uCoD0dne5vsslKfg1sn7n0tjxl/3oMUZjhq5RIxD9+zje7Qi5jqBB6z1k
   ThIukEmj0Uzql0vJIylVnJmTGiXRqUUT+99OgQziGDrs6Nyx+L1Lmxo9T
   UqYV7oUm6CuRd2H2iLh+bOoIuBqkZLvPIBXbdsRllK04qwzBxUdIEsKCq
   F3z55pmW/mnvkZAsXfy+tmNCqEA294vQHjIPHmLh7KR1vpDbjU8b42Xoh
   qqru+a81I9QRSbL9X0N4o79cLUlnWpQnvhy4GV0a/eq6fcTa42fSVHiY1
   g==;
X-CSE-ConnectionGUID: wGhAGX5xRJiHPP+E27cq5A==
X-CSE-MsgGUID: bwSaS8uyRW6VWXbE3FhzYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23972419"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="23972419"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:57:15 -0700
X-CSE-ConnectionGUID: Nr9ueaw+QIqmwXKC4WNsYg==
X-CSE-MsgGUID: eZtLlAMJQxi5LZe95BHp6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39798318"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:57:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
	(Chris Li's message of "Tue, 28 May 2024 14:04:34 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
Date: Wed, 29 May 2024 16:55:21 +0800
Message-ID: <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> I am spinning a new version for this series to address two issues
> found in this series:
>
> 1) Oppo discovered a bug in the following line:
> +               ci =3D si->cluster_info + tmp;
> Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> That is a serious bug but trivial to fix.
>
> 2) order 0 allocation currently blindly scans swap_map disregarding
> the cluster->order.

IIUC, now, we only scan swap_map[] only if
!list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters[order]=
).
That is, if you doesn't run low swap free space, you will not do that.

> Given enough order 0 swap allocations(close to the
> swap file size) the order 0 allocation head will eventually sweep
> across the whole swapfile and destroy other cluster order allocations.
>
> The short term fix is just skipping clusters that are already assigned
> to higher orders.

Better to do any further optimization on top of the simpler one.  Need
to evaluate whether it's necessary to add more complexity.

> In the long term, I want to unify the non-SSD to use clusters for
> locking and allocations as well, just try to follow the last
> allocation (less seeking) as much as possible.

I have thought about that too.  Personally, I think that it's good to
remove swap_map[] scanning.  The implementation can be simplified too.
I don't know whether do we need to consider the performance of HDD swap
now.

--
Best Regards,
Huang, Ying

> On Fri, May 24, 2024 at 10:17=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
>>
>> This is the short term solutiolns "swap cluster order" listed
>> in my "Swap Abstraction" discussion slice 8 in the recent
>> LSF/MM conference.
>>
>> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>> orders" is introduced, it only allocates the mTHP swap entries
>> from new empty cluster list. That works well for PMD size THP,
>> but it has a serius fragmentation issue reported by Barry.
>>
>> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+A=
h+NSgNQ@mail.gmail.com/
>>
>> The mTHP allocation failure rate raises to almost 100% after a few
>> hours in Barry's test run.
>>
>> The reason is that all the empty cluster has been exhausted while
>> there are planty of free swap entries to in the cluster that is
>> not 100% free.
>>
>> Address this by remember the swap allocation order in the cluster.
>> Keep track of the per order non full cluster list for later allocation.
>>
>> This greatly improve the sucess rate of the mTHP swap allocation.
>> While I am still waiting for Barry's test result. I paste Kairui's test
>> result here:
>>
>> I'm able to reproduce such an issue with a simple script (enabling all o=
rder of mthp):
>>
>> modprobe brd rd_nr=3D1 rd_size=3D$(( 10 * 1024 * 1024))
>> swapoff -a
>> mkswap /dev/ram0
>> swapon /dev/ram0
>>
>> rmdir /sys/fs/cgroup/benchmark
>> mkdir -p /sys/fs/cgroup/benchmark
>> cd /sys/fs/cgroup/benchmark
>> echo 8G > memory.max
>> echo $$ > cgroup.procs
>>
>> memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B b=
inary &
>>
>> /usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
>>         -P memcache_binary -n allkeys --key-minimum=3D1 \
>>         --key-maximum=3D18000000 --key-pattern=3DP:P -c 1 -t 32 \
>>         --ratio 1:0 --pipeline 8 -d 1024
>>
>> Before:
>> Totals      48805.63         0.00         0.00         5.26045         1=
19100        38.91100        59.64700     51063.98
>> After:
>> Totals      71098.84         0.00         0.00         3.60585         0=
71100        26.36700        39.16700     74388.74
>>
>> And the fallback ratio dropped by a lot:
>> Before:
>> hugepages-32kB/stats/anon_swpout_fallback:15997
>> hugepages-32kB/stats/anon_swpout:18712
>> hugepages-512kB/stats/anon_swpout_fallback:192
>> hugepages-512kB/stats/anon_swpout:0
>> hugepages-2048kB/stats/anon_swpout_fallback:2
>> hugepages-2048kB/stats/anon_swpout:0
>> hugepages-1024kB/stats/anon_swpout_fallback:0
>> hugepages-1024kB/stats/anon_swpout:0
>> hugepages-64kB/stats/anon_swpout_fallback:18246
>> hugepages-64kB/stats/anon_swpout:17644
>> hugepages-16kB/stats/anon_swpout_fallback:13701
>> hugepages-16kB/stats/anon_swpout:18234
>> hugepages-256kB/stats/anon_swpout_fallback:8642
>> hugepages-256kB/stats/anon_swpout:93
>> hugepages-128kB/stats/anon_swpout_fallback:21497
>> hugepages-128kB/stats/anon_swpout:7596
>>
>> (Still collecting more data, the success swpout was mostly done early, t=
hen the fallback began to increase, nearly 100% failure rate)
>>
>> After:
>> hugepages-32kB/stats/swpout:34445
>> hugepages-32kB/stats/swpout_fallback:0
>> hugepages-512kB/stats/swpout:1
>> hugepages-512kB/stats/swpout_fallback:134
>> hugepages-2048kB/stats/swpout:1
>> hugepages-2048kB/stats/swpout_fallback:1
>> hugepages-1024kB/stats/swpout:6
>> hugepages-1024kB/stats/swpout_fallback:0
>> hugepages-64kB/stats/swpout:35495
>> hugepages-64kB/stats/swpout_fallback:0
>> hugepages-16kB/stats/swpout:32441
>> hugepages-16kB/stats/swpout_fallback:0
>> hugepages-256kB/stats/swpout:2223
>> hugepages-256kB/stats/swpout_fallback:6278
>> hugepages-128kB/stats/swpout:29136
>> hugepages-128kB/stats/swpout_fallback:52
>>
>> Reported-by: Barry Song <21cnbao@gmail.com>
>> Tested-by: Kairui Song <kasong@tencent.com>
>> Signed-off-by: Chris Li <chrisl@kernel.org>
>> ---
>> Chris Li (2):
>>       mm: swap: swap cluster switch to double link list
>>       mm: swap: mTHP allocate swap entries from nonfull list
>>
>>  include/linux/swap.h |  18 ++--
>>  mm/swapfile.c        | 252 +++++++++++++++++---------------------------=
-------
>>  2 files changed, 93 insertions(+), 177 deletions(-)
>> ---
>> base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
>> change-id: 20240523-swap-allocator-1534c480ece4
>>
>> Best regards,
>> --
>> Chris Li <chrisl@kernel.org>
>>

