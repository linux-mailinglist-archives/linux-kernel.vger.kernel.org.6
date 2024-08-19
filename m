Return-Path: <linux-kernel+bounces-291501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A995635B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5171F218E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4EA14A4C6;
	Mon, 19 Aug 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/skYaGj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EE322A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724046936; cv=none; b=pNTkL13riYkIzuEyusRh4QKYAUPOjwZ86HN904JEzK8AgxJip2Lx1sSEW7O0PpNz+DVIaHY24gl4bouhpPyTujeYb0y9pRJ2+HC2wkl5Tpm1VNMPritoz7uoyPhtr9szh897ewMmG11KlkeK6y5hk3KKoTSRwEhk9moIS3Ew/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724046936; c=relaxed/simple;
	bh=X02MtRRl0Mo5bfRc8CoEeI7t1dU83VhdLcL35gShkUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8714IpA/n0Hn2uCV+bA4xvkWAhFmrr61QRduYPyMhwiCOu2NQqJ/xqvVQSAx8lvvFAz5QMAjH0wl0guF0J8GOn3cGOZtoN103mmod8Ubxynsl/mAIKoSTJf49AehNcKyWp7ZvL20BE+5p1wn8HIHH6+5Gc6fqR8XiGnd1EKYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/skYaGj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724046934; x=1755582934;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=X02MtRRl0Mo5bfRc8CoEeI7t1dU83VhdLcL35gShkUw=;
  b=Y/skYaGjk5rNtDPiIWxdx1EimDiqRZ+JWtjXjgdiVHFvVLiAHZUjMgkQ
   cX8o8dzaD51GWI2L7NyrQFpLfRbr5UpwtL9++rhHPG+VG5Byrt2qdS7pi
   ZOpdW96eQkN8Tk+qGoBSLq9axqiQT2zcAMHHKxwYRLWo6/hqjxZYEoCnF
   x56h4iPUeNHCglmghc++GZRYcWirHNnWGal9hWRdqETis571fzYAm/z/j
   ubBaQiqEYVoGQlQ3IyUS0CB6+z8z3e0u1p21m6NBe3IoSQpEGg2ilgzGq
   zp7/m5PH6OZ3iR4sMzr/M1KI4nltmec38N3pNin5Hv2pfovvd3c1UkRsw
   g==;
X-CSE-ConnectionGUID: gk+CMP9tQ/iOiRBQWoZm6Q==
X-CSE-MsgGUID: DmRKZsKGSZ+E9ynCP60sSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32845565"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32845565"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 22:55:33 -0700
X-CSE-ConnectionGUID: 9Qvun1AxTjaWvydSp8WOUw==
X-CSE-MsgGUID: kxh3FdgPRo29sRhPMXvKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60426092"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 22:55:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>,  "yosryahmed@google.com" <yosryahmed@google.com>,
  "nphamcs@gmail.com" <nphamcs@gmail.com>,  "ryan.roberts@arm.com"
 <ryan.roberts@arm.com>,  "21cnbao@gmail.com" <21cnbao@gmail.com>,
  "akpm@linux-foundation.org" <akpm@linux-foundation.org>,  "Zou, Nanhai"
 <nanhai.zou@intel.com>,  "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
  "Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
In-Reply-To: <SJ0PR11MB5678BFAA984BEEBBFC2FC351C98C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
	(Kanchana P. Sridhar's message of "Mon, 19 Aug 2024 13:12:53 +0800")
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
	<87msl9i4lw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678BFAA984BEEBBFC2FC351C98C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Date: Mon, 19 Aug 2024 13:51:57 +0800
Message-ID: <87ikvxhxfm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:

> Hi Ying,
>
>> -----Original Message-----
>> From: Huang, Ying <ying.huang@intel.com>
>> Sent: Sunday, August 18, 2024 8:17 PM
>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
>> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
>> ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
>> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
>> Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
>> 
>> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
>> 
>> [snip]
>> 
>> >
>> > Performance Testing:
>> > ====================
>> > Testing of this patch-series was done with the v6.11-rc3 mainline, without
>> > and with this patch-series, on an Intel Sapphire Rapids server,
>> > dual-socket 56 cores per socket, 4 IAA devices per socket.
>> >
>> > The system has 503 GiB RAM, with a 4G SSD as the backing swap device for
>> > ZSWAP. Core frequency was fixed at 2500MHz.
>> >
>> > The vm-scalability "usemem" test was run in a cgroup whose memory.high
>> > was fixed. Following a similar methodology as in Ryan Roberts'
>> > "Swap-out mTHP without splitting" series [2], 70 usemem processes were
>> > run, each allocating and writing 1G of memory:
>> >
>> >     usemem --init-time -w -O -n 70 1g
>> >
>> > Since I was constrained to get the 70 usemem processes to generate
>> > swapout activity with the 4G SSD, I ended up using different cgroup
>> > memory.high fixed limits for the experiments with 64K mTHP and 2M THP:
>> >
>> > 64K mTHP experiments: cgroup memory fixed at 60G
>> > 2M THP experiments  : cgroup memory fixed at 55G
>> >
>> > The vm/sysfs stats included after the performance data provide details
>> > on the swapout activity to SSD/ZSWAP.
>> >
>> > Other kernel configuration parameters:
>> >
>> >     ZSWAP Compressor  : LZ4, DEFLATE-IAA
>> >     ZSWAP Allocator   : ZSMALLOC
>> >     SWAP page-cluster : 2
>> >
>> > In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
>> > IAA "compression verification" is enabled. Hence each IAA compression
>> > will be decompressed internally by the "iaa_crypto" driver, the crc-s
>> > returned by the hardware will be compared and errors reported in case of
>> > mismatches. Thus "deflate-iaa" helps ensure better data integrity as
>> > compared to the software compressors.
>> >
>> > Throughput reported by usemem and perf sys time for running the test
>> > are as follows, averaged across 3 runs:
>> >
>> >  64KB mTHP (cgroup memory.high set to 60G):
>> >  ==========================================
>> >   ------------------------------------------------------------------
>> >  |                    |                   |            |            |
>> >  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
>> >  |                    |                   |       KB/s |            |
>> >  |--------------------|-------------------|------------|------------|
>> >  |v6.11-rc3 mainline  | SSD               |    335,346 |   Baseline |
>> >  |zswap-mTHP-Store    | ZSWAP lz4         |    271,558 |       -19% |
>> 
>> zswap throughput is worse than ssd swap?  This doesn't look right.
>
> I realize it might look that way, however, this is not an apples-to-apples comparison,
> as explained in the latter part of my analysis (after the 2M THP data tables).
> The primary reason for this is because of running the test under a fixed
> cgroup memory limit.
>
> In the "Before" scenario, mTHP get swapped out to SSD. However, the disk swap
> usage is not accounted towards checking if the cgroup's memory limit has been
> exceeded. Hence there are relatively fewer swap-outs, resulting mainly from the
> 1G allocations from each of the 70 usemem processes working with a 60G memory
> limit on the parent cgroup.
>
> However, the picture changes in the "After" scenario. mTHPs will now get stored in
> zswap, which is accounted for in the cgroup's memory.current and counts
> towards the fixed memory limit in effect for the parent cgroup. As a result, when
> mTHP get stored in zswap, the mTHP compressed data in the zswap zpool now
> count towards the cgroup's active memory and memory limit. This is in addition
> to the 1G allocations from each of the 70 processes.
>
> As you can see, this creates more memory pressure on the cgroup, resulting in
> more swap-outs. With lz4 as the zswap compressor, this results in lesser throughput
> wrt "Before".
>
> However, with IAA as the zswap compressor, the throughout with zswap mTHP is
> better than "Before" because of better hardware compress latencies, which handle
> the higher swap-out activity without compromising on throughput.
>
>> 
>> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    388,154 |        16% |
>> >  |------------------------------------------------------------------|
>> >  |                    |                   |            |            |
>> >  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
>> >  |                    |                   |        sec |            |
>> >  |--------------------|-------------------|------------|------------|
>> >  |v6.11-rc3 mainline  | SSD               |      91.37 |   Baseline |
>> >  |zswap-mTHP=Store    | ZSWAP lz4         |     265.43 |      -191% |
>> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     235.60 |      -158% |
>> >   ------------------------------------------------------------------
>> >
>> >   -----------------------------------------------------------------------
>> >  | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |  zswap-
>> mTHP |
>> >  |                              |   mainline |       Store |       Store |
>> >  |                              |            |         lz4 | deflate-iaa |
>> >  |-----------------------------------------------------------------------|
>> >  | pswpin                       |          0 |           0 |           0 |
>> >  | pswpout                      |    174,432 |           0 |           0 |
>> >  | zswpin                       |        703 |         534 |         721 |
>> >  | zswpout                      |      1,501 |   1,491,654 |   1,398,805 |
>> 
>> It appears that the number of swapped pages for zswap is much larger
>> than that of SSD swap.  Why?  I guess this is why zswap throughput is
>> worse.
>
> Your observation is correct. I hope the above explanation helps as to the
> reasoning behind this.

Before:
(174432 + 1501) * 4 / 1024 = 687.2 MB

After:
1491654 * 4.0 / 1024 = 5826.8 MB

From your previous words, 10GB memory should be swapped out.

Even if the average compression ratio is 0, the swap-out count of zswap
should be about 100% more than that of SSD.  However, the ratio here
appears unreasonable.

--
Best Regards,
Huang, Ying

> Thanks,
> Kanchana
>
>> 
>> >  |-----------------------------------------------------------------------|
>> >  | thp_swpout                   |          0 |           0 |           0 |
>> >  | thp_swpout_fallback          |          0 |           0 |           0 |
>> >  | pgmajfault                   |      3,364 |       3,650 |       3,431 |
>> >  |-----------------------------------------------------------------------|
>> >  | hugepages-64kB/stats/zswpout |            |      63,200 |      63,244 |
>> >  |-----------------------------------------------------------------------|
>> >  | hugepages-64kB/stats/swpout  |     10,902 |           0 |           0 |
>> >   -----------------------------------------------------------------------
>> >
>> 
>> [snip]
>> 
>> --
>> Best Regards,
>> Huang, Ying

