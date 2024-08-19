Return-Path: <linux-kernel+bounces-291381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DC956169
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE4B1C214A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04142A8B;
	Mon, 19 Aug 2024 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr43xLy0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9B1804E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724037637; cv=none; b=mrPl5UTkGMB5jYdrekLAfpOxBKPLfbxfSoA/axM7qHAFVssz51JPL0lhxO8uceACOXMvBgTd3cz2vUnefB1CGzAB3wGKqYxY06UTtCSlT5UjvUUmE3KZgvaaqr/D7Q8Rqs74CDgjdgjL0dteLqJsDFk3p3zv4qdzCiiQ/l0txQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724037637; c=relaxed/simple;
	bh=iMSdCfe90roZCySYWjTtZqKWjVx15CpcGY5MMofjvRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhv0jxEq9OFWQSEmEZLAmGBXGvY0xLFbTSIiMJJLyUUgSiwXN0B/3vx8KhvVs1wEIMnL6IhXDBL9koaJUsoRRGZmeuzjFmhJSObHodCrWBf6CXL84u16/oQXye1p1VW+l/ucr2MK4882qw6I+HKVBf12hVo86mts29Rgwd536mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr43xLy0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724037635; x=1755573635;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=iMSdCfe90roZCySYWjTtZqKWjVx15CpcGY5MMofjvRY=;
  b=kr43xLy0k2XgFeMY/50dm2yicitDQ+tYvEaaGqEzttfvcCywgym8d+dE
   Xf5A5ulzFOQy8mUKkRNpQd+DseMuB81n33iahUm1J1dqn2UWA8VVtqjnH
   VCw1cb/W1Egt3A2krg/b3tAOM7Hb0YH4OQJAxFQBd1lXbjhSeRier6Hq2
   EQitDLoFVE3FFTKn5wZXqJOJkHJTBriFJxgl8e1bOATIbr7pnp/HVFoGV
   eSoXBGMWaPDsy1JusDvUXDOjapMF78EmdIVge67+Jkcw9NyCUwVQiIIw5
   5SrHQF5cjyfs9lUYI+qpkxeCfKJk2IAfWVFPqQIhLHMrrJv4XG4IJzJl4
   Q==;
X-CSE-ConnectionGUID: 9yDvBPLjTWy5RVNsulsx3A==
X-CSE-MsgGUID: 0xe2RyTxRrOUg/w3RzARIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22417294"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22417294"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:20:35 -0700
X-CSE-ConnectionGUID: 8TXaih5eQ8WqL/3reE8QsQ==
X-CSE-MsgGUID: ZcS1nmkfQcOwH7kesMDSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60519339"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:20:32 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <hannes@cmpxchg.org>,  <yosryahmed@google.com>,  <nphamcs@gmail.com>,
  <ryan.roberts@arm.com>,  <21cnbao@gmail.com>,
  <akpm@linux-foundation.org>,  <nanhai.zou@intel.com>,
  <wajdi.k.feghali@intel.com>,  <vinodh.gopal@intel.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
In-Reply-To: <20240819021621.29125-1-kanchana.p.sridhar@intel.com> (Kanchana
	P. Sridhar's message of "Sun, 18 Aug 2024 19:16:17 -0700")
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
Date: Mon, 19 Aug 2024 11:16:59 +0800
Message-ID: <87msl9i4lw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:

[snip]

>
> Performance Testing:
> ====================
> Testing of this patch-series was done with the v6.11-rc3 mainline, without
> and with this patch-series, on an Intel Sapphire Rapids server,
> dual-socket 56 cores per socket, 4 IAA devices per socket.
>
> The system has 503 GiB RAM, with a 4G SSD as the backing swap device for
> ZSWAP. Core frequency was fixed at 2500MHz.
>
> The vm-scalability "usemem" test was run in a cgroup whose memory.high
> was fixed. Following a similar methodology as in Ryan Roberts'
> "Swap-out mTHP without splitting" series [2], 70 usemem processes were
> run, each allocating and writing 1G of memory:
>
>     usemem --init-time -w -O -n 70 1g
>
> Since I was constrained to get the 70 usemem processes to generate
> swapout activity with the 4G SSD, I ended up using different cgroup
> memory.high fixed limits for the experiments with 64K mTHP and 2M THP:
>
> 64K mTHP experiments: cgroup memory fixed at 60G
> 2M THP experiments  : cgroup memory fixed at 55G
>
> The vm/sysfs stats included after the performance data provide details
> on the swapout activity to SSD/ZSWAP.
>
> Other kernel configuration parameters:
>
>     ZSWAP Compressor  : LZ4, DEFLATE-IAA
>     ZSWAP Allocator   : ZSMALLOC
>     SWAP page-cluster : 2
>
> In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
> IAA "compression verification" is enabled. Hence each IAA compression
> will be decompressed internally by the "iaa_crypto" driver, the crc-s
> returned by the hardware will be compared and errors reported in case of
> mismatches. Thus "deflate-iaa" helps ensure better data integrity as
> compared to the software compressors.
>
> Throughput reported by usemem and perf sys time for running the test
> are as follows, averaged across 3 runs:
>
>  64KB mTHP (cgroup memory.high set to 60G):
>  ==========================================
>   ------------------------------------------------------------------
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
>  |                    |                   |       KB/s |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |    335,346 |   Baseline |
>  |zswap-mTHP-Store    | ZSWAP lz4         |    271,558 |       -19% |

zswap throughput is worse than ssd swap?  This doesn't look right.

>  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    388,154 |        16% |
>  |------------------------------------------------------------------|
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
>  |                    |                   |        sec |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |      91.37 |   Baseline |
>  |zswap-mTHP=Store    | ZSWAP lz4         |     265.43 |      -191% |
>  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     235.60 |      -158% |
>   ------------------------------------------------------------------
>
>   -----------------------------------------------------------------------
>  | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP |
>  |                              |   mainline |       Store |       Store |
>  |                              |            |         lz4 | deflate-iaa |
>  |-----------------------------------------------------------------------|
>  | pswpin                       |          0 |           0 |           0 |
>  | pswpout                      |    174,432 |           0 |           0 |
>  | zswpin                       |        703 |         534 |         721 |
>  | zswpout                      |      1,501 |   1,491,654 |   1,398,805 |

It appears that the number of swapped pages for zswap is much larger
than that of SSD swap.  Why?  I guess this is why zswap throughput is
worse.

>  |-----------------------------------------------------------------------|
>  | thp_swpout                   |          0 |           0 |           0 |
>  | thp_swpout_fallback          |          0 |           0 |           0 |
>  | pgmajfault                   |      3,364 |       3,650 |       3,431 |
>  |-----------------------------------------------------------------------|
>  | hugepages-64kB/stats/zswpout |            |      63,200 |      63,244 |
>  |-----------------------------------------------------------------------|
>  | hugepages-64kB/stats/swpout  |     10,902 |           0 |           0 |
>   -----------------------------------------------------------------------
>

[snip]

--
Best Regards,
Huang, Ying

