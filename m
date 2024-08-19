Return-Path: <linux-kernel+bounces-291336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE857956105
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACD81F213E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478428379;
	Mon, 19 Aug 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAvx82w1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B21C6A5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033785; cv=none; b=QT/g5s7qANrGw3xNaZTHvmBtryin9a8KiT9KB5hTP5eixr3xtIlVMowevLwzM/IuMRoTJmR2KH/1/jXHPKQ6G+OtfABzlcEwCL2uV+0s7tiqqxoFoP+QW+XUcSYZe7R9btp3CQ+0+oW9GiKOoaTsXWYSaVJ3YGin5f1FMnQpRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033785; c=relaxed/simple;
	bh=YYKgEK7DwekBv83kdHiuHbvSZBpldfHgcCbNkNaCKyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7Qj/9owmhivkwv2cKaOH8l6jpcmK/vEhpW4TWBCNpZfAD/nDiq0uzPQflk6If4h7e5/9MEIYBkPJO63a2RnmyXaI/kB1JqGIKSh4Ic+KnX44JcZg9tyxi5spPtTB6SdBfhL1UHHXHTzLve4ccMbmkfBTjttyk8XtH+RZWcvwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAvx82w1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724033783; x=1755569783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YYKgEK7DwekBv83kdHiuHbvSZBpldfHgcCbNkNaCKyE=;
  b=cAvx82w1W5ta7Wxopz76lB+YkU06yCPKEDr7gDn3eeIya4u5UhUf0pIL
   o1Qf0GY2Zf6By7q2Ky9YgGYIU0wb1FYCw+Z7gNo8sLpXiXB1hDbfjNk8G
   5XBAwZ0u9CVCwLX3MpT/xpaCwcPCtlFAmiTbSoBb2LtYe9Jrkdeo/4gUB
   Hj+E9jHALbUUXpkiXPIodOJ28SKysDps79u9mMi80tpDjbtUBneCBvIEn
   qMusCgGTF77zzJ7g2gPz1D1It+eVmRulO5OfLbJE85+DsKSSMOjLtNsse
   0L8qSmTs2nVddaZ2e3aKKAzvM03TWmR7uREUI8EtcmubmK4MJ/AmmegQN
   g==;
X-CSE-ConnectionGUID: 07QZmjqxT36GQuH0AItlFw==
X-CSE-MsgGUID: hvQAXIVeSMu1kQRwRXtONA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="44782952"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="44782952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:16:22 -0700
X-CSE-ConnectionGUID: tZ7WcHE7RLGHoiCIHZz/Lw==
X-CSE-MsgGUID: zEj854CYToq1VnzNLIRwXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64610267"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2024 19:16:21 -0700
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
Subject: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Date: Sun, 18 Aug 2024 19:16:17 -0700
Message-Id: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
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

Changes since v3:
=================
1) Rebased to mm-unstable commit 8c0b4f7b65fd1ca7af01267f491e815a40d77444.
   Thanks to Barry for suggesting aligning with Ryan Roberts' latest
   changes to count_mthp_stat() so that it's always defined, even when THP
   is disabled. Barry, I have also made one other change in page_io.c
   where count_mthp_stat() is called by count_swpout_vm_event(). I would
   appreciate it if you can review this. Thanks!
   Hopefully this should resolve the kernel robot build errors.

Changes since v2:
=================
1) Gathered usemem data using SSD as the backing swap device for zswap,
   as suggested by Ying Huang. Ying, I would appreciate it if you can
   review the latest data. Thanks!
2) Generated the base commit info in the patches to attempt to address
   the kernel test robot build errors.
3) No code changes to the individual patches themselves.

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

The system has 503 GiB RAM, with a 4G SSD as the backing swap device for
ZSWAP. Core frequency was fixed at 2500MHz.

The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed. Following a similar methodology as in Ryan Roberts'
"Swap-out mTHP without splitting" series [2], 70 usemem processes were
run, each allocating and writing 1G of memory:

    usemem --init-time -w -O -n 70 1g

Since I was constrained to get the 70 usemem processes to generate
swapout activity with the 4G SSD, I ended up using different cgroup
memory.high fixed limits for the experiments with 64K mTHP and 2M THP:

64K mTHP experiments: cgroup memory fixed at 60G
2M THP experiments  : cgroup memory fixed at 55G

The vm/sysfs stats included after the performance data provide details
on the swapout activity to SSD/ZSWAP.

Other kernel configuration parameters:

    ZSWAP Compressor  : LZ4, DEFLATE-IAA
    ZSWAP Allocator   : ZSMALLOC
    SWAP page-cluster : 2

In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
IAA "compression verification" is enabled. Hence each IAA compression
will be decompressed internally by the "iaa_crypto" driver, the crc-s
returned by the hardware will be compared and errors reported in case of
mismatches. Thus "deflate-iaa" helps ensure better data integrity as
compared to the software compressors.

Throughput reported by usemem and perf sys time for running the test
are as follows, averaged across 3 runs:

 64KB mTHP (cgroup memory.high set to 60G):
 ==========================================
  ------------------------------------------------------------------
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
 |                    |                   |       KB/s |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | SSD               |    335,346 |   Baseline |
 |zswap-mTHP-Store    | ZSWAP lz4         |    271,558 |       -19% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |    388,154 |        16% |
 |------------------------------------------------------------------|
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
 |                    |                   |        sec |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | SSD               |      91.37 |   Baseline |
 |zswap-mTHP=Store    | ZSWAP lz4         |     265.43 |      -191% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |     235.60 |      -158% |
  ------------------------------------------------------------------

  -----------------------------------------------------------------------
 | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP |
 |                              |   mainline |       Store |       Store |
 |                              |            |         lz4 | deflate-iaa |
 |-----------------------------------------------------------------------|
 | pswpin                       |          0 |           0 |           0 |
 | pswpout                      |    174,432 |           0 |           0 |
 | zswpin                       |        703 |         534 |         721 |
 | zswpout                      |      1,501 |   1,491,654 |   1,398,805 |
 |-----------------------------------------------------------------------|
 | thp_swpout                   |          0 |           0 |           0 |
 | thp_swpout_fallback          |          0 |           0 |           0 |
 | pgmajfault                   |      3,364 |       3,650 |       3,431 |
 |-----------------------------------------------------------------------|
 | hugepages-64kB/stats/zswpout |            |      63,200 |      63,244 |
 |-----------------------------------------------------------------------|
 | hugepages-64kB/stats/swpout  |     10,902 |           0 |           0 |
  -----------------------------------------------------------------------


 2MB PMD-THP/2048K mTHP (cgroup memory.high set to 55G):
 =======================================================
  ------------------------------------------------------------------
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
 |                    |                   |       KB/s |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | SSD               |    190,827 |   Baseline |
 |zswap-mTHP-Store    | ZSWAP lz4         |     32,026 |       -83% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |    203,772 |         7% |
 |------------------------------------------------------------------|
 |                    |                   |            |            |
 |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
 |                    |                   |        sec |            |
 |--------------------|-------------------|------------|------------|
 |v6.11-rc3 mainline  | SSD               |      27.23 |   Baseline |
 |zswap-mTHP-Store    | ZSWAP lz4         |     156.52 |      -475% |
 |zswap-mTHP-Store    | ZSWAP deflate-iaa |     171.45 |      -530% |
  ------------------------------------------------------------------

  ------------------------------------------------------------------------- 
 | VMSTATS, mTHP ZSWAP/SSD stats  |  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP |
 |                                |   mainline |       Store |       Store |
 |                                |            |         lz4 | deflate-iaa |
 |-------------------------------------------------------------------------|
 | pswpin                         |          0 |           0 |           0 |
 | pswpout                        |    797,184 |           0 |           0 |
 | zswpin                         |        690 |         649 |         669 |
 | zswpout                        |      1,465 |   1,596,382 |   1,540,766 |
 |-------------------------------------------------------------------------|
 | thp_swpout                     |      1,557 |           0 |           0 |
 | thp_swpout_fallback            |          0 |       3,248 |       3,752 |
 | pgmajfault                     |      3,726 |       6,470 |       5,691 |
 |-------------------------------------------------------------------------|
 | hugepages-2048kB/stats/zswpout |            |       2,416 |       2,261 |
 |-------------------------------------------------------------------------|
 | hugepages-2048kB/stats/swpout  |      1,557 |           0 |           0 |
  -------------------------------------------------------------------------

In the "Before" scenario, when zswap does not store mTHP, only allocations
count towards the cgroup memory limit, as against in the "After" scenario
with the introduction of zswap_store mTHP, that causes both allocations
and the zswap usage count towards the memory limit. As a result, we see
higher swapout activity in the "After" data, and consequent sys time
degradation.

We do observe considerable throughput improvement in the "After" data
when DEFLATE-IAA is the zswap compressor. This observation holds for
64K mTHP and 2MB THP experiments. This can be attributed to IAA's better
compress/decompress latency and compression ratio as compared to
software compressors.

In my opinion, even though the test set up does not provide an accurate
way for a direct before/after comparison (because of zswap usage being
counted in cgroup, hence towards the memory.high), it still seems
reasonable for zswap_store to support mTHP, so that further performance
improvements can be implemented.

One of the ideas that has shown promise in our experiments is to improve
ZSWAP mTHP store performance using batching. With IAA compress/decompress
batching used in ZSWAP, we are able to demonstrate significant
performance improvements and memory savings with IAA in scalability
experiments, as compared to software compressors. We hope to submit
this work as subsequent RFCs.

cgroup zswap kselftest with 4G SSD as zswap's backing device:
=============================================================
mTHP 64K set to 'always'
zswap compressor set to 'lz4'
page-cluster = 3

"Before":
=========
  Test run with v6.11-rc3 and no code changes:

  zswap shrinker_enabled = Y:
  ---------------------------
  not ok 1 test_zswap_usage
  not ok 2 test_swapin_nozswap
  not ok 3 test_zswapin
  # Failed to reclaim all of the requested memory
  not ok 4 test_zswap_writeback_enabled
  # Failed to reclaim all of the requested memory
  not ok 5 test_zswap_writeback_disabled
  ok 6 # SKIP test_no_kmem_bypass
  not ok 7 test_no_invasive_cgroup_shrink

"After":
========
  Test run with this patch-series and v6.11-rc3:

  zswap shrinker_enabled = Y:
  ---------------------------
  ok 1 test_zswap_usage
  not ok 2 test_swapin_nozswap
  ok 3 test_zswapin
  ok 4 test_zswap_writeback_enabled
  ok 5 test_zswap_writeback_disabled
  ok 6 # SKIP test_no_kmem_bypass
  not ok 7 test_no_invasive_cgroup_shrink

I haven't taken an in-depth look into the cgroup zswap tests, but it
looks like the results with the patch-series are no worse than without,
and in some cases better (this needs more analysis).

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
 mm/huge_memory.c        |   3 +
 mm/page_io.c            |   3 +-
 mm/zswap.c              | 238 +++++++++++++++++++++++++++++-----------
 4 files changed, 180 insertions(+), 65 deletions(-)


base-commit: 8c0b4f7b65fd1ca7af01267f491e815a40d77444
-- 
2.27.0


