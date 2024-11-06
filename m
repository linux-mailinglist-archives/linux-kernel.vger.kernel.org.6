Return-Path: <linux-kernel+bounces-398803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8361F9BF648
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CFC284E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374A20ADDC;
	Wed,  6 Nov 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mge1sD3W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD120A5DB;
	Wed,  6 Nov 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920869; cv=none; b=GyKyVMP6BLurQ8NJ9AqNzD91IljIEkCASSlCSpDwYYGD8DWg+pxR3/aGjLfnaJlay0VH7TBycp1IVS858t+7RhChkdhhA52nF2MOb0O7lZ+c99fnay0TLt1SSmpxoQuAy9v5DhhpYl0amtbhQ4JT6a8EMpkyseRPYaU6OGdRTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920869; c=relaxed/simple;
	bh=wIrpR5YAyy3QIoGBaNieENM1Y9tWXgBWCSDzt5zecc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwR6sbshCE3e5u1DOuYu/B3zQHtNIXbfD9QafTOBBQ9xqwS+KqffHI3NTECx3PKiImbHT7rh4n4sj7F2ZbUoajNRtt7fVN4CEFhcDsQtFHZfg1117KKS0h0KDXk0vwrb8F7Qd1cpIVIZ79dB/FiU1WMwGmOBZ/8Tv9MlXRDzjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mge1sD3W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730920868; x=1762456868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wIrpR5YAyy3QIoGBaNieENM1Y9tWXgBWCSDzt5zecc4=;
  b=Mge1sD3Wl5agFaETz/RBff9SwCGxE6xqULAamoPdmd8qHueoY36Fz5dd
   qUacvefmvYezGjXegni/YIEqmyVDqAgJ3IjUK2OVHHZFH1jLQGHkYA+Z6
   mnRx7b2/88meyDQ2tVVVudsKdb8aBuuSH6SHRBZBYigp2oIEoTkCIwpx0
   INS3dFC+m4xpfDkiOff8t6anNbd9Jqv6aHgo7mTNcVOEy6qz3IVZe8wzg
   irOaFGZXmUZJrHW/XPkjEvyncJd5TYulAdaSlWZF6BMlE85YLUBD78oZw
   ef7psSDIVD1awvd8DLCe0GTDokS4bRQerE+S5Xw8o2hSe0EPB+NIzMU4H
   Q==;
X-CSE-ConnectionGUID: oblapvTpQZKAWh6ErYBzYQ==
X-CSE-MsgGUID: bAFk2x0dQZmHgMZR6hLKdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41291925"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41291925"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 11:21:07 -0800
X-CSE-ConnectionGUID: z9GP202VRF2qphOG35jxtQ==
X-CSE-MsgGUID: jvQYQgdUSzi+k/IX0MxJFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="88695346"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2024 11:21:05 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v3 00/13] zswap IAA compress batching
Date: Wed,  6 Nov 2024 11:20:52 -0800
Message-Id: <20241106192105.6731-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


IAA Compression Batching:
=========================

This patch-series introduces the use of the Intel Analytics Accelerator
(IAA) for parallel compression of pages in large folios.

The patch-series is organized as follows:

 1) crypto acomp & iaa_crypto driver enablers for batching: Relevant
    patches are tagged with "crypto:" in the subject:

    Patch 1) New acomp_alg/crypto_acomp batch_compress() and batch_decompress()
             interfaces, that swap modules can invoke using the new
             batching API crypto_acomp_batch_compress() and
             crypto_acomp_batch_decompress().
    Patch 2) New CRYPTO_ACOMP_REQ_POLL acomp_req flag to act as a gate for
             async poll mode in iaa_crypto.
    Patch 3) iaa-crypto driver implementations for async polling,
             crypto_acomp_batch_compress() and crypto_acomp_batch_decompress().
    Patch 4) Modifying the default iaa_crypto driver mode to async.
    Patch 5) Disabling verify_compress by default, to facilitate users to
             run IAA easily for comparison with software compressors.
    Patch 6) Changing the cpu-to-iaa mappings to more evenly balance cores
             to IAA devices.
    Patch 7) Addition of a "global_wq" per IAA, which can be used as a
             global resource for compress jobs for the socket. If the user
             configures 2WQs per IAA device, the driver will distribute
             compress jobs from all cores on the socket to the "global_wqs"
             of all the IAA devices on that socket, in a round-robin
             manner. This can be used to improve compression throughput for
             workloads that see a lot of swapout activity.

 2) zswap modifications to enable compress batching in zswap_store() of
    large folios (including pmd-mappable folios):

    Patch 8) acomp_ctx mutex lock acquire/release once optimizations in
             zswap_store() and a minor change in releasing the lock in
             zswap_decompress().
    Patch 9) Change the "struct crypto_acomp_ctx" to contain a configurable
             number of acomp_reqs and buffers.
    Patch 10) Introduce a separate per-cpu "acomp_batch_ctx" member in
              "struct zswap_pool" to be able to allocate multiple
              acomp_reqs/buffers for use in batching, as needed, per core.
    Patch 11) Allocation of the per-cpu "acomp_batch_ctx" for a
              zswap_pool.
    Patch 12) Add a new "sysctl vm.compress-batching" 0/1 switch to
              enable/disable compress batching dynamically at runtime.
    Patch 13) zswap_store() IAA compress batching implementation with
              minimal memory footprint cost per-cpu, and using the new
              crypto_acomp_batch_compress() iaa_crypto driver API.

With the runtime configuration to enable compress batching and the crypto
batching API added in v2, this feature will be enabled only on Intel
platforms that have IAA.
 

System setup for testing:
=========================
Testing of this patch-series was done with mm-unstable as of 10-29-2024,
commit 9fb8e0a1c486, without and with this patch-series.
Data was gathered on an Intel Sapphire Rapids server, dual-socket 56 cores
per socket, 4 IAA devices per socket, 503 GiB RAM and 525G SSD disk
partition swap. Core frequency was fixed at 2500MHz.

Other kernel configuration parameters:

    zswap compressor  : zstd, deflate-iaa
    zswap allocator   : zsmalloc
    vm.page-cluster   : 0, 2

IAA "compression verification" is disabled and IAA is run in the the async
poll mode (the defaults with this series). 2WQs are configured per IAA
device. Compress jobs from all cores on a socket are distributed among all
4 IAA devices on the same socket.

I ran experiments with these workloads:

1) usemem 30 processes with these large folios enabled to "always":
   - 16k/32k/64k
   - 2048k

2) Kernel compilation allmodconfig with 2G max memory, run in tmpfs with
   these large folios enabled to "always":
   - 16k/32k/64k


Performance testing (usemem30):
===============================
The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 150G. The is no swap limit set for the cgroup. 30 usemem
processes were run, each allocating and writing 10G of memory, and sleeping
for 10 sec before exiting:

usemem --init-time -w -O -s 10 -n 30 10g


 16k/32/64k folios: usemem30/deflate-iaa:
 ========================================

 -------------------------------------------------------------------------------
                     mm-unstable-10-29-2024             v2 of this patch-series
 -------------------------------------------------------------------------------
 zswap compressor               deflate-iaa        deflate-iaa      deflate-iaa      
 vm.compress-batching                   n/a                  0                1
 vm.page-cluster                          2                  2                2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)          7,756,632          7,753,984        8,075,817 
 Avg throughput (KB/s)              258,554            258,466          269,193 
 elapsed time (sec)                   87.75              88.71            85.82 
 sys time (sec)                    2,073.04           2,147.47         2,030.52 
                                                                               
 -------------------------------------------------------------------------------
 memcg_high                         715,854            714,238          720,459
 memcg_swap_fail                      1,194              1,175            1,250
 zswpout                         64,510,869         64,510,832       64,511,219
 zswpin                                 458                456              450
 pswpout                                  0                  0                0
 pswpin                                   0                  0                0
 thp_swpout                               0                  0                0
 thp_swpout_fallback                      0                  0                0
 16kB-mthp_swpout_fallback                0                  0                0                                          
 32kB-mthp_swpout_fallback                0                  0                0
 64kB-mthp_swpout_fallback            1,194              1,175            1,250
 pgmajfault                           3,183              3,513            3,116
 swap_ra                                108                125              116
 swap_ra_hit                             45                 65               43
 ZSWPOUT-16kB                             2                  3                3
 ZSWPOUT-32kB                             1                  1                2
 ZSWPOUT-64kB                     4,030,658          4,030,672        4,030,624
 SWPOUT-16kB                              0                  0                0
 SWPOUT-32kB                              0                  0                0
 SWPOUT-64kB                              0                  0                0
 -------------------------------------------------------------------------------


 16k/32/64k folios: usemem30/zstd:
 =================================

 -------------------------------------------------------------------------------
                     mm-unstable-10-29-2024        v2 of this patch-series
 -------------------------------------------------------------------------------
 zswap compressor                      zstd                  zstd
 vm.compress-batching                   n/a                     0 
 vm.page-cluster                          2                     2
 -----------------------------------------------------------------------------
 Total throughput (KB/s)          6,054,147             6,109,360 
 Avg throughput (KB/s)              201,804               203,645 
 elapsed time (sec)                  111.66                111.72 
 sys time (sec)                    2,693.21              2,685.27 
                                                                 
 -----------------------------------------------------------------------------
 memcg_high                         489,133               480,524
 memcg_swap_fail                      1,045                 1,308
 zswpout                         48,931,716            48,931,540
 zswpin                                 407                   394
 pswpout                                  0                     0
 pswpin                                   0                     0
 thp_swpout                               0                     0
 thp_swpout_fallback                      0                     0
 16kB-mthp_swpout_fallback                0                     0                                        
 32kB-mthp_swpout_fallback                0                     0
 64kB-mthp_swpout_fallback            1,045                 1,308
 pgmajfault                           3,095                 3,424
 swap_ra                                136                   101
 swap_ra_hit                             86                    50
 ZSWPOUT-16kB                             2                     4
 ZSWPOUT-32kB                             0                     2
 ZSWPOUT-64kB                     3,057,161             3,056,927
 SWPOUT-16kB                              0                     0
 SWPOUT-32kB                              0                     0
 SWPOUT-64kB                              0                     0
 -----------------------------------------------------------------------------


 2M folios: usemem30/deflate-iaa:
 ================================

 -------------------------------------------------------------------------------
                     mm-unstable-10-29-2024             v2 of this patch-series
 -------------------------------------------------------------------------------
 zswap compressor               deflate-iaa        deflate-iaa      deflate-iaa      
 vm.compress-batching                   n/a                  0                1
 vm.page-cluster                          2                  2                2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)          7,948,345          8,096,440        8,165,171 
 Avg throughput (KB/s)              264,944            269,881          272,172 
 elapsed time (sec)                   88.18              87.13            87.30 
 sys time (sec)                    2,067.56           2,018.08         2,046.79 
                                                                               
 -------------------------------------------------------------------------------
 memcg_high                          91,002             87,243           92,084
 memcg_swap_fail                         39                 56               54
 zswpout                         64,518,833         64,520,439       64,520,116
 zswpin                                 413                452              504
 pswpout                                  0                  0                0
 pswpin                                   0                  0                0
 thp_swpout                               0                  0                0
 thp_swpout_fallback                     39                 56               54
 2048kB-mthp_swpout_fallback             39                 56               54                                          
 pgmajfault                          10,946             15,737            9,645
 swap_ra                             23,456             36,495           19,247
 swap_ra_hit                         23,406             36,431           19,193
 ZSWPOUT-2048kB                     125,915            125,913          125,912
 SWPOUT-2048kB                            0                  0                0
 -------------------------------------------------------------------------------


 2M folios: usemem30/zstd:
 =========================

 -------------------------------------------------------------------------------
                     mm-unstable-10-29-2024        v2 of this patch-series
 -------------------------------------------------------------------------------
 zswap compressor                      zstd                  zstd
 vm.compress-batching                   n/a                     0 
 vm.page-cluster                          2                     2
 -----------------------------------------------------------------------------
 Total throughput (KB/s)          6,300,116             6,278,179 
 Avg throughput (KB/s)              210,003               209,272 
 elapsed time (sec)                  110.21                111.72 
 sys time (sec)                    2,504.45              2,542.59 
                                                                 
 -----------------------------------------------------------------------------
 memcg_high                          57,036                60,090
 memcg_swap_fail                         61                    50
 zswpout                         48,934,256            48,904,582
 zswpin                                 387                   380
 pswpout                                  0                     0
 pswpin                                   0                     0
 thp_swpout                               0                     0
 thp_swpout_fallback                     61                    50
 2048kB-mthp_swpout_fallback             61                    50
 pgmajfault                           3,713                 6,146
 swap_ra                              2,004                 8,133
 swap_ra_hit                          1,960                 8,088
 ZSWPOUT-2048kB                      95,511                95,460
 SWPOUT-2048kB                            0                     0
 -----------------------------------------------------------------------------


Performance testing (Kernel compilation, allmodconfig):
=======================================================

The experiments with kernel compilation test in tmpfs use the
"allmodconfig" that takes ~12 minutes, and has considerable swapout
activity. The cgroup's memory.max is set to 2G.


 16k/32k/64k folios: Kernel compilation/allmodconfig/deflate-iaa:
 ================================================================

 -------------------------------------------------------------------------------
                     mm-unstable-10-29-2024             v2 of this patch-series
 -------------------------------------------------------------------------------
 zswap compressor               deflate-iaa        deflate-iaa      deflate-iaa      
 vm.compress-batching                   n/a                  0                1
 vm.page-cluster                          0                  0                0
 -------------------------------------------------------------------------------
 real_sec                            801.25            790.87            768.92
 user_sec                         15,776.31         15,755.97         15,753.89
 sys_sec                           4,250.34          3,877.02          3,892.17
 Max_Res_Set_Size_KB              1,869,428         1,873,376         1,871,600
                                                                                          
 -------------------------------------------------------------------------------
 memcg_high                               0                 0                 0
 memcg_swap_fail                          0                 0                 0
 zswpout                        106,798,327       105,469,307       104,528,841
 zswpin                          31,542,093        30,469,671        30,596,840
 pswpout                                774               290                80
 pswpin                                 370               288                59
 thp_swpout                               0                 0                 0
 thp_swpout_fallback                      0                 0                 0
 16kB-mthp_swpout_fallback                0                 0                 0                                          
 32kB-mthp_swpout_fallback                0                 0                 0
 64kB-mthp_swpout_fallback           16,340            12,633            12,000
 pgmajfault                      33,983,602        32,783,214        32,731,862
 swap_ra                                  0                 0                 0
 swap_ra_hit                          1,467             5,112             3,854
 ZSWPOUT-16kB                     1,475,121         1,435,571         1,426,738
 ZSWPOUT-32kB                       821,119           813,202           790,658
 ZSWPOUT-64kB                     3,483,295         3,490,244         3,435,056
 SWPOUT-16kB                              1                 0                 0
 SWPOUT-32kB                              3                 0                 0
 SWPOUT-64kB                             40                18                 4
 -------------------------------------------------------------------------------


 16k/32k/64k folios: Kernel compilation/allmodconfig/zstd:
 =========================================================

 -------------------------------------------------------------------------------
                   mm-unstable-10-29-2024       v2 of this patch-series
 -------------------------------------------------------------------------------
 zswap compressor                    zstd                   zstd
 vm.compress-batching                 n/a                      0
 vm.page-cluster                        0                      0
 -------------------------------------------------------------------------------
 real_sec                          812.38                 800.09  
 user_sec                       15,774.12              15,771.02
 sys_sec                         5,283.64               5,257.05
 Max_Res_Set_Size_KB            1,872,688              1,873,444
                                                                
 -------------------------------------------------------------------------------
 memcg_high                             0                      0
 memcg_swap_fail                        0                      0
 zswpout                       91,540,018             90,338,507
 zswpin                        26,421,271             26,485,837
 pswpout                               64                    144
 pswpin                                64                    114
 thp_swpout                             0                      0
 thp_swpout_fallback                    0                      0
 16kB-mthp_swpout_fallback              0                      0                         
 32kB-mthp_swpout_fallback              0                      0
 64kB-mthp_swpout_fallback          4,509                    566
 pgmajfault                    28,341,722             28,427,509
 swap_ra                                0                      0
 swap_ra_hit                        3,359                  2,931
 ZSWPOUT-16kB                   1,287,206              1,266,947
 ZSWPOUT-32kB                     707,746                700,270
 ZSWPOUT-64kB                   2,985,002              2,940,288
 SWPOUT-16kB                            0                      0
 SWPOUT-32kB                            0                      0
 SWPOUT-64kB                            4                      9
 -------------------------------------------------------------------------------


Summary:
========
The performance testing data with usemem 30 processes and kernel
compilation test show throughput gains and elapsed/sys time reduction with
zswap_store() large folios using IAA compress batching.

The iaa_crypto wq stats will show almost the same number of compress calls
for wq.1 of all IAA devices. wq.0 will handle decompress calls exclusively.
We see a latency reduction of 2.5% by distributing compress jobs among all
IAA devices on the socket (based on v1 data).

We can expect to see even more significant performance and throughput
improvements if we use the parallelism offered by IAA to batch compress the
pages comprising a batch of 4K (really any-order) folios, not just batching
within large folios. This is the reclaim batching patch 13 in v1,
which will be submitted in a separate patch-series.

Our internal validation of IAA compress/decompress batching in highly
contended Sapphire Rapids server setups with workloads running on 72 cores
for ~25 minutes under stringent memory limit constraints have shown up to
50% reduction in sys time and 3.5% reduction in workload run time as
compared to software compressors.


Changes since v2:
=================
1) Rebased to mm-unstable as of 11-5-2024, commit 7994b7ea6ac8.
2) Fixed an issue in zswap_create_acomp_ctx() with checking for NULL
   returned by kmalloc_node() for acomp_ctx->buffers and for
   acomp_ctx->reqs.
3) Fixed a bug in zswap_pool_can_batch() for returning true if
   pool->can_batch_comp is found to be equal to BATCH_COMP_ENABLED, and if
   the per-cpu acomp_batch_ctx tests true for batching resources having
   been allocated on this cpu. Also, changed from per_cpu_ptr() to
   raw_cpu_ptr().
4) Incorporated the zswap_store_propagate_errors() compilation warning fix
   suggested by Dan Carpenter. Thanks Dan!
5) Replaced the references to SWAP_CRYPTO_SUB_BATCH_SIZE in comments in
   zswap.h, with SWAP_CRYPTO_BATCH_SIZE.

Changes since v1:
=================
1) Rebased to mm-unstable as of 11-1-2024, commit 5c4cf96cd702.
2) Incorporated Herbert's suggestions to use an acomp_req flag to indicate
   async/poll mode, and to encapsulate the polling functionality in the
   iaa_crypto driver. Thanks Herbert!
3) Incorporated Herbert's and Yosry's suggestions to implement the batching
   API in iaa_crypto and to make its use seamless from zswap's
   perspective. Thanks Herbert and Yosry!
4) Incorporated Yosry's suggestion to make it more convenient for the user
   to enable compress batching, while minimizing the memory footprint
   cost. Thanks Yosry!
5) Incorporated Yosry's suggestion to de-couple the shrink_folio_list()
   reclaim batching patch from this series, since it requires a broader
   discussion.


Requesting the maintainers & reviewers to kindly review v3 of this
patch-series instead of v2.

I would greatly appreciate code review comments for the iaa_crypto driver
and mm patches included in this series!

Thanks,
Kanchana



Kanchana P Sridhar (13):
  crypto: acomp - Define two new interfaces for compress/decompress
    batching.
  crypto: iaa - Add an acomp_req flag CRYPTO_ACOMP_REQ_POLL to enable
    async mode.
  crypto: iaa - Implement compress/decompress batching API in
    iaa_crypto.
  crypto: iaa - Make async mode the default.
  crypto: iaa - Disable iaa_verify_compress by default.
  crypto: iaa - Change cpu-to-iaa mappings to evenly balance cores to
    IAAs.
  crypto: iaa - Distribute compress jobs to all IAA devices on a NUMA
    node.
  mm: zswap: acomp_ctx mutex lock/unlock optimizations.
  mm: zswap: Modify struct crypto_acomp_ctx to be configurable in nr of
    acomp_reqs.
  mm: zswap: Add a per-cpu "acomp_batch_ctx" to struct zswap_pool.
  mm: zswap: Allocate acomp_batch_ctx resources for a given zswap_pool.
  mm: Add sysctl vm.compress-batching switch for compress batching
    during swapout.
  mm: zswap: Compress batching with Intel IAA in zswap_store() of large
    folios.

 crypto/acompress.c                         |   2 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 717 +++++++++++++++--
 include/crypto/acompress.h                 |  87 +++
 include/crypto/internal/acompress.h        |  16 +
 include/linux/mm.h                         |   2 +
 include/linux/zswap.h                      |  91 +++
 kernel/sysctl.c                            |   9 +
 mm/swap.c                                  |   6 +
 mm/zswap.c                                 | 865 +++++++++++++++++++--
 9 files changed, 1701 insertions(+), 94 deletions(-)


base-commit: 7994b7ea6ac880efd0c38fedfbffd5ab8b1b7b2b
-- 
2.27.0


