Return-Path: <linux-kernel+bounces-289018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F1954152
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C871C2169A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450E8288C;
	Fri, 16 Aug 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9pBPI5V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D356F077
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787291; cv=none; b=PNneo5A3WBbzSssIPxUEI8yLPZaZ2F+si29SVwZavurQJ7JInMEWLINCkYZlfB3JO4NkNPJaxcgI6sa0YfceYB3M38VF7UBaG4t5+O5Xc4lKgknvy/ECA/Vv8VpsWiqZXRBqGEcoWB0zVKbWt3AQSwo+XIgp9MHHNf1VTmos6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787291; c=relaxed/simple;
	bh=LFpwvDhSygIqWB9BT6DTyRBU8CQ8pkjs5xW0cmQsxus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eyECEWt8mcJVEZsssygYtyUaW6FPj0ZoPttg/IElapS8MkFV8p14lfdWFD2o312niMdRXsK/g0MSLh2EkeYRLXSHZFHRkAzn4JHgcDLPgN5WkgjWn9D40aGkl450VArRvaNwqFsArBW/jck+0b2jjysVc69eMVenY69IByhV0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9pBPI5V; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723787290; x=1755323290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LFpwvDhSygIqWB9BT6DTyRBU8CQ8pkjs5xW0cmQsxus=;
  b=E9pBPI5V+SWAAFBuWpr1QDDRsPhCVchipE4UzzTq0heQYSrHyfD7nOe4
   jNoctJOuo8XNIWzPfkILR33kJvyNl4UG9cMe5eQ2X8LWj5CfK0uHnGTgY
   LFspN50FbB4Q0viKtXmOd2S1jjRQ7H1y0V3cFdQVmplPNvLcIwqdLn/0R
   4fS8PC+739FTvtH+i58lP8q4PUwQVKGdrCbuLhbhloS9I6faDfNtRwTgH
   duhomTs4TUPkWsz/Kh9HqajzI1T39RcoizkEaafr7API2szgSj7Ok8K1v
   RvXsWln0bhxiTNa1zEpiC7AmEsG5n7ydVFT7oQwKEcQ/ri7LecXnLDzF9
   Q==;
X-CSE-ConnectionGUID: Yj0+L1tmQDyXhKX95auayg==
X-CSE-MsgGUID: nIgviDGOQbCkybntJllezQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32648105"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32648105"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:48:06 -0700
X-CSE-ConnectionGUID: OVEi59FfSIi7onj7Z6STLA==
X-CSE-MsgGUID: d/jQSrliTQ+EpZ1z0fiu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59415330"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2024 22:48:06 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v2 0/4] mm: ZSWAP swap-out of mTHP folios
Date: Thu, 15 Aug 2024 22:48:01 -0700
Message-Id: <20240816054805.5201-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This patch-series enables zswap_store() to accept and store mTHP
folios. The most significant contribution in this series is from the 
earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
migrated to v6.11-rc3 in patch 2/4 of this series.

[1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
     https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

Additionally, there is an attempt to modularize some of the functionality
in zswap_store(), to make it more amenable to supporting any-order
mTHPs.

For instance, the determination of whether a folio is same-filled is
based on mapping an index into the folio to derive the page. Likewise,
there is a function "zswap_store_entry" added to store a zswap_entry in
the xarray.

For accounting purposes, the patch-series adds per-order mTHP sysfs
"zswpout" counters that get incremented upon successful zswap_store of
an mTHP folio:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

This patch-series is a precursor to ZSWAP compress batching of mTHP
swap-out and decompress batching of swap-ins based on swapin_readahead(),
using Intel IAA hardware acceleration, which we would like to submit in
subsequent RFC patch-series, with performance improvement data.

Thanks to Ying Huang for pre-posting review feedback and suggestions!

Changes since RFC v1:
=====================

1) Use sysfs for zswpout mTHP stats, as per Barry Song's suggestion.
   Thanks Barry!
2) Addressed some of the code review comments that Nhat Pham provided in
   Ryan's initial RFC [1]:
   - Added a comment about the cgroup zswap limit checks occuring once per
     folio at the beginning of zswap_store().
     Nhat, Ryan, please do let me know if the comments convey the summary
     from the RFC discussion. Thanks!
   - Posted data on running the cgroup suite's zswap kselftest.
3) Rebased to v6.11-rc3.
4) Gathered performance data with usemem and the rebased patch-series.

Performance Testing:
====================
Testing of this patch-series was done with the v6.11-rc3 mainline, without
and with this patch-series, on an Intel Sapphire Rapids server,
dual-socket 56 cores per socket, 4 IAA devices per socket.

The system has 503 GiB RAM, 176 GiB swap/ZSWAP with ZRAM as the backing
swap device. Core frequency was fixed at 2500MHz.

The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 40G. Following a similar methodology as in Ryan Roberts'
"Swap-out mTHP without splitting" series [2], 70 usemem processes were
run, each allocating and writing 1G of memory:

    usemem --init-time -w -O -n 70 1g

Other kernel configuration parameters:

    ZSWAP Compressor  : LZ4, DEFLATE-IAA
    ZSWAP Allocator   : ZSMALLOC
    ZRAM Compressor   : LZO-RLE
    SWAP page-cluster : 2

In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
IAA "compression verification" is enabled. Hence each IAA compression
will be decompressed internally by the "iaa_crypto" driver, the crc-s
returned by the hardware will be compared and errors reported in case of
mismatches. Thus "deflate-iaa" helps ensure better data integrity as
compared to the software compressors.

Throughput reported by usemem and perf sys time for running the test
are as follows:

 64KB mTHP:
 ==========
  ------------------------------------------------------------------
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
 |                    |                   |       KB/s |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | ZRAM lzo-rle      |    118,928 |   Baseline |
 |zswap-mTHP-Store    | ZSWAP lz4         |     82,665 |       -30% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |    176,210 |        48% |
 |------------------------------------------------------------------|
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
 |                    |                   |        sec |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | ZRAM lzo-rle      |   1,032.20 |   Baseline |
 |zswap-mTHP=Store    | ZSWAP lz4         |   1,854.51 |       -80% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |     582.71 |        44% |
  ------------------------------------------------------------------

  -----------------------------------------------------------------------
 | VMSTATS, mTHP ZSWAP stats,   |  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP |
 | mTHP ZRAM stats:             |   mainline |       Store |       Store |
 |                              |            |         lz4 | deflate-iaa |
 |-----------------------------------------------------------------------|
 | pswpin                       |         16 |           0 |           0 |
 | pswpout                      |  7,770,720 |           0 |           0 |
 | zswpin                       |        547 |         695 |         579 |
 | zswpout                      |      1,394 |  15,462,778 |   7,284,554 |
 |-----------------------------------------------------------------------|
 | thp_swpout                   |          0 |           0 |           0 |
 | thp_swpout_fallback          |          0 |           0 |           0 |
 | pgmajfault                   |      3,786 |       3,541 |       3,367 |
 |-----------------------------------------------------------------------|
 | hugepages-64kB/stats/zswpout |            |     966,328 |     455,196 |
 |-----------------------------------------------------------------------|
 | hugepages-64kB/stats/swpout  |    485,670 |           0 |           0 |
  -----------------------------------------------------------------------


 2MB PMD-THP/2048K mTHP:
 =======================
  ------------------------------------------------------------------
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
 |                    |                   |       KB/s |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | ZRAM lzo-rle      |    177,340 |   Baseline |
 |zswap-mTHP-Store    | ZSWAP lz4         |     84,030 |       -53% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |    185,691 |         5% |
 |------------------------------------------------------------------|
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
 |                    |                   |        sec |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | ZRAM lzo-rle      |     876.29 |   Baseline |
 |zswap-mTHP-Store    | ZSWAP lz4         |   1,740.55 |       -99% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |     650.33 |        26% |
  ------------------------------------------------------------------

  ------------------------------------------------------------------------- 
 | VMSTATS, mTHP ZSWAP stats,     |  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP |
 | mTHP ZRAM stats:               |   mainline |       Store |       Store |
 |                                |            |         lz4 | deflate-iaa |
 |-------------------------------------------------------------------------|
 | pswpin                         |          0 |           0 |           0 |
 | pswpout                        |  8,628,224 |           0 |           0 |
 | zswpin                         |        678 |      22,733 |       1,641 |
 | zswpout                        |      1,481 |  14,828,597 |   9,404,937 |
 |-------------------------------------------------------------------------|
 | thp_swpout                     |     16,852 |           0 |           0 |
 | thp_swpout_fallback            |          0 |           0 |           0 |
 | pgmajfault                     |      3,467 |      25,550 |       4,800 |
 |-------------------------------------------------------------------------|
 | hugepages-2048kB/stats/zswpout |            |      28,924 |      18,366 |
 |-------------------------------------------------------------------------|
 | hugepages-2048kB/stats/swpout  |     16,852 |           0 |           0 |
  -------------------------------------------------------------------------

As expected, in the "Before" experiment, there are relatively fewer
swapouts because ZRAM utilization is not accounted in the cgroup.

With the introduction of zswap_store mTHP, the "After" data reflects the
higher swapout activity, and consequent throughput/sys time degradation
when LZ4 is used as the zswap compressor. However, we observe considerable
throughput and sys time improvement in the "After" data when DEFLATE-IAA
is the zswap compressor. This observation holds for 64K mTHP and 2MB THP
experiments. IAA's higher compression ratio and better compress latency
can be attributed to fewer swap-outs and major page-faults, that result
in better throughput and sys time.

Our goal is to improve ZSWAP mTHP store performance using batching. With
Intel IAA compress/decompress batching used in ZSWAP (to be submitted as
additional RFC series), we are able to demonstrate significant
performance improvements and memory savings with IAA as compared to
software compressors.

cgroup zswap kselftest:
=======================

"Before":
=========
  Test run with v6.11-rc3 and no code changes:
    mTHP 64K set to 'always'
    zswap compressor set to 'lz4'
    page-cluster = 3

  zswap shrinker_enabled = N:
  ---------------------------
  ok 1 test_zswap_usage
  ok 2 test_swapin_nozswap
  # at least 24MB should be brought back from zswap
  not ok 3 test_zswapin
  # zswpwb_after is 0 while wb is enablednot ok 4 test_zswap_writeback_enabled
  # Failed to reclaim all of the requested memory
  not ok 5 test_zswap_writeback_disabled
  ok 6 # SKIP test_no_kmem_bypass
  ok 7 test_no_invasive_cgroup_shrink

  zswap shrinker_enabled = Y:
  ---------------------------
  ok 1 test_zswap_usage
  ok 2 test_swapin_nozswap
  # at least 24MB should be brought back from zswap
  not ok 3 test_zswapin
  # zswpwb_after is 0 while wb is enablednot ok 4 test_zswap_writeback_enabled
  # Failed to reclaim all of the requested memory
  not ok 5 test_zswap_writeback_disabled
  ok 6 # SKIP test_no_kmem_bypass
  not ok 7 test_no_invasive_cgroup_shrink

"After":
========
  Test run with this patch-series and v6.11-rc3:
    mTHP 64K set to 'always'
    zswap compressor set to 'deflate-iaa'
    page-cluster = 3

  zswap shrinker_enabled = N:
  ---------------------------
  ok 1 test_zswap_usage
  ok 2 test_swapin_nozswap
  ok 3 test_zswapin
  ok 4 test_zswap_writeback_enabled
  ok 5 test_zswap_writeback_disabled
  ok 6 # SKIP test_no_kmem_bypass
  ok 7 test_no_invasive_cgroup_shrink
  
  zswap shrinker_enabled = Y:
  ---------------------------
  ok 1 test_zswap_usage
  ok 2 test_swapin_nozswap
  # at least 24MB should be brought back from zswap
  not ok 3 test_zswapin
  ok 4 test_zswap_writeback_enabled
  ok 5 test_zswap_writeback_disabled
  ok 6 # SKIP test_no_kmem_bypass
  not ok 7 test_no_invasive_cgroup_shrink

I haven't taken an in-depth look into the cgroup zswap tests, but it
looks like the results with the patch-series are no worse than without,
and in some cases better (not exactly sure why, this needs more
analysis).

I would greatly appreciate your code review comments and suggestions!

Thanks,
Kanchana

[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/


Kanchana P Sridhar (4):
  mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
  mm: zswap: zswap_store() extended to handle mTHP folios.
  mm: Add MTHP_STAT_ZSWPOUT to sysfs per-order mthp stats.
  mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.

 include/linux/huge_mm.h |   1 +
 mm/huge_memory.c        |   2 +
 mm/page_io.c            |   7 ++
 mm/zswap.c              | 238 +++++++++++++++++++++++++++++-----------
 4 files changed, 184 insertions(+), 64 deletions(-)

-- 
2.27.0


