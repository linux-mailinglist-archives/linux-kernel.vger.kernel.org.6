Return-Path: <linux-kernel+bounces-371071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC69A35FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050A21C2181A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBE18756D;
	Fri, 18 Oct 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4T+rFNu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E7185B58
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234090; cv=none; b=a6rXGlQdQ4QTH1tcvbza+fHGHUFa6+NaXosQOu6R2GvVQz/YSuKnhHs4tstggQgkt/IdLNtviFwGZEldi/lDpyMbMI7KoOPdd6lBW3g7nXlTLNvV+arU89CaOclehibqz8sP1nEY685Xifzea8JkWXYLMl+KlCgzvoVmqf4y7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234090; c=relaxed/simple;
	bh=P5YmUHNDsLVTxHgOPfbd+OD7xV6wYV2W56CRIEJNZRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dPXCWqZQpno0Z5AoShmfDe8cT5Pd+0acrryKKos197zxjh3jn8c3qDNCHC6QCCSKiK3tQ7rlzFaZFAl1SlZaqBJek9EkoHO/zaqVWO7tC/WxV0NJMUkqYN3Ay0a5jKNk4xzy2wdfbatb83sCzcZ9LV/bguxuuCZlyIlDgel8AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4T+rFNu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234088; x=1760770088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P5YmUHNDsLVTxHgOPfbd+OD7xV6wYV2W56CRIEJNZRQ=;
  b=n4T+rFNuImFpcT9k/b6ierlLfUFGzepr7fmovfWianHiiElnfUHwiabi
   ElfFARcFQoiuEVGx1w8etk497XN4uEd9lYebhU+oZRSQUGzc4dpfVrZMa
   uM/8pK862k1vFdOvVqK2CKyysu1RypVTgkE3Q1VuUeDksDYaUpmeVV3jt
   PgCQ3tV3wxh405+Wt+h0d3terjwZabndfEyKQlKVLwHopdatfJRx6+keQ
   JTYQF5JGXHbKygXmEtY0ITMUfiIZtMd7RJliHw4TJ3mrrM0vEDLvWEZGo
   hZPFBu3RRSF8IP43/nJUqwHSTvoM5A/3CuojzNIB2OsT6rAn1uV4L/PlX
   A==;
X-CSE-ConnectionGUID: MSxvXe+cQsacjEpfulfWkA==
X-CSE-MsgGUID: gnyLym0rQtOAV+DJ4RfnDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963304"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963304"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:07 -0700
X-CSE-ConnectionGUID: Ez4wzGzKTX64mz+kEGfpGw==
X-CSE-MsgGUID: lZ3leNrJSveplhtGKbaCUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744491"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:05 -0700
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
	hughd@google.com,
	willy@infradead.org,
	bfoster@redhat.com,
	dchinner@redhat.com,
	chrisl@kernel.org,
	david@redhat.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 0/7] zswap IAA decompress batching
Date: Thu, 17 Oct 2024 23:47:58 -0700
Message-Id: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


IAA Decompression Batching:
===========================

This patch-series applies over [1], the IAA compress batching patch-series.

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=900537

This RFC patch-series introduces the use of the Intel Analytics Accelerator
(IAA) for parallel decompression of 4K folios prefetched by
swapin_readahead(). We have developed zswap batched loading of these
prefetched folios, that deploys the use of parallel decompressions by IAA.

swapin_readahead() provides a natural batching interface because it adapts
to the usefulness of prior prefetches, to adjust the readahead
window. Hence, it allows the page-cluster to be set based on workload
characteristics. For workloads that are prefetching friendly, this can form
the basis for reading ahead up to 32 folios with zswap load batching to
significantly reduce swap in latency, major page-faults and systime;
thereby improving workload performance.

The patch-series builds upon the IAA compress batching patch-series [1],
and is organized as follows:

 1) A centralized batch decompression API that can be used by swap modules.
 2) "struct folio_batch" modifications, e.g., PAGEVEC_SIZE is increased to
    2^5. 
 3) Addition of "zswap_batch" and "non_zswap_batch" folio_batches in
    swap_read_folio() to serve the purposes of a plug.
 4) swap_read_zswap_batch_unplug() API in page_io.c to process a read
    batch of entries found in zswap.
 5) zswap API to add a swap entry to a load batch, init/reinit the batch,
    process the batch using the batch decompression API. 
 6) Modifications to the swapin_readahead() functions,
    swap_vma_readahead() and swap_cluster_readahead() to:
    a) Call swap_read_folio() to add prefetch swap entries to "zswap_batch"
       and "non_zswap_batch" folio_batches.
    b) Process the two readahead folio batches: "non_zswap_batch" folios
       will be read sequentially; "zswap_batch" folios will be batch
       decompressed with IAA.
 7) Modifications to do_swap_page() to invoke swapin_readahead() from both,
    the single-mapped SWP_SYNCHRONOUS_IO and shared/non-SWP_SYNCHRONOUS_IO
    branches. In the former path, we call swapin_readahead() only in the
    !zswap_never_enabled() case.
    a) This causes folios to be read into the swapcache in both paths. This
       design choice was motivated by stability: to handle race conditions
       with say, process 1 faulting in a single-mapped folio; however,
       process 2 could be simultaneously prefetching it as a "readahead"
       folio.
    b) If the single-mapped folio was successfully read and the race did
       not occur, there are checks added to free the swapcache entry for
       the folio, before do_swap_page() returns.
 8) Finally, for IAA batching, we reduce SWAP_BATCH to 16 and modify the
    swap slots cache thresholds to alleviate lock contention on the
    swap_info_struct lock due to reduced swap page-fault latencies.

IAA decompress batching can be enabled only on platforms that have IAA, by
setting this config variable:

 CONFIG_ZSWAP_LOAD_BATCHING_ENABLED="y"

A new swap parameter "singlemapped_ra_enabled" (false by default) is added
for use on platforms that have IAA. If zswap_load_batching_enabled() is
true, this is intended to give the user the option to run experiments with
IAA and with software compressors for zswap.

These are the recommended settings for "singlemapped_ra_enabled", which
takes effect only in the do_swap_page() single-mapped SWP_SYNCHRONOUS_IO
path:

 For IAA:
   echo true > /sys/kernel/mm/swap/singlemapped_ra_enabled

 For software compressors:
   echo false > /sys/kernel/mm/swap/singlemapped_ra_enabled

If "singlemapped_ra_enabled" is set to false, swapin_readahead() will skip
prefetching folios in the "single-mapped SWP_SYNCHRONOUS_IO" do_swap_page()
path.

IAA decompress batching performance testing was done using the kernel
compilation test "allmodconfig" run in tmpfs, which demonstrates a
significant amount of readahead activity. vm-scalability usemem is not
ideal for decompress batching because there is very little readahead
activity even with page-cluster of 5 (swap_ra is < 150 with 4k/16k/32k/64k
folios).

The kernel compilation experiments with decompress batching demonstrate
significant latency reductions with kernel compilation: up to 4% lower
elapsed time, 14% lower sys time than mm-unstable/zstd. When combined with
compress batching, we see a reduction of 5% in elapsed time and 20% in sys
time as compared to mm-unstable commit 817952b8be34 with zstd.

Our internal validation of IAA compress/decompress batching in highly
contended Sapphire Rapids server setups with workloads running on 72 cores
for ~25 minutes under stringent memory limit constraints have shown up to
50% reduction in sys time and 3.5% reduction in workload run time as
compared to software compressors.


System setup for testing:
=========================
Testing of this patch-series was done with mm-unstable as of 10-16-2024,
commit 817952b8be34, without and with this patch-series ("this
patch-series" includes [1]). Data was gathered on an Intel Sapphire Rapids
server, dual-socket 56 cores per socket, 4 IAA devices per socket, 503 GiB
RAM and 525G SSD disk partition swap. Core frequency was fixed at 2500MHz.

The kernel compilation test with run in tmpfs, using the "allmodconfig", so
that significant swapout and readahead activity can be observed to quantify
decompress batching.

Other kernel configuration parameters:

    zswap compressor : deflate-iaa
    zswap allocator   : zsmalloc
    vm.page-cluster   : 3,4

IAA "compression verification" is disabled and the async poll acomp
interface is used in the iaa_crypto driver (the defaults with this
series).


Performance testing (Kernel compilation):
=========================================

As mentioned earlier, for workloads that see a lot of swapout activity, we
can benefit from configuring 2 WQs per IAA device, with compress jobs from
all same-socket cores being distributed toothe wq.1 of all IAAs on the
socket, with the "global_wq" developed in this patch-series.

Although this data includes IAA decompress batching, which will be
submitted as a separate RFC patch-series, I am listing it here to quantify
the benefit of distributing compress jobs among all IAAs. The kernel
compilation test with "allmodconfig" is able to quantify this well:


 4K folios: deflate-iaa: kernel compilation
 ==========================================

 ------------------------------------------------------------------------------
                   mm-unstable-10-16-2024       zswap_load_batch with
                                              IAA decompress batching
 ------------------------------------------------------------------------------
 zswap compressor                    zstd         deflate-iaa
 vm.compress-batchsize                n/a                   1
 vm.page-cluster                        3                   3
 ------------------------------------------------------------------------------
 real_sec                          783.87              752.99
 user_sec                       15,750.07           15,746.37
 sys_sec                         6,522.32            5,638.16
 Max_Res_Set_Size_KB            1,872,640           1,872,640

 ------------------------------------------------------------------------------
 zswpout                       82,364,991         105,190,461
 zswpin                        21,303,393          29,684,653
 pswpout                               13                   1
 pswpin                                12                   1
 pgmajfault                    17,114,339          24,034,146
 swap_ra                        4,596,035           6,219,484
 swap_ra_hit                    2,903,249           3,876,195
 ------------------------------------------------------------------------------


 Progression of kernel compilation latency improvements with
 compress/decompress batching:
 ============================================================

 -------------------------------------------------------------------------------
               mm-unstable-10-16-2024   shrink_folio_       zswap_load_batch
                                        list()              w/ IAA decompress
                                        batching            batching 
                                        of folios           
 -------------------------------------------------------------------------------
 zswap compr       zstd   deflate-iaa   deflate-iaa    deflate-iaa   deflate-iaa
 vm.compress-       n/a           n/a            32              1            32
 batchsize
 vm.page-             3             3             3              3             3
  cluster
 -------------------------------------------------------------------------------
 real_sec        783.87        761.69        747.32         752.99        749.25
 user_sec     15,750.07     15,716.69     15,728.39      15,746.37     15,741.71
 sys_sec       6,522.32      5,725.28      5,399.44       5,638.16      5,482.12
 Max_RSS_KB   1,872,640     1,870,848     1,874,432      1,872,640     1,872,640
                                                                                       
 zswpout     82,364,991    97,739,600   102,780,612    105,190,461   106,729,372
 zswpin      21,303,393    27,684,166    29,016,252     29,684,653    30,717,819
 pswpout             13           222           213              1            12
 pswpin              12           209           202              1             8
 pgmajfault  17,114,339    22,421,211    23,378,161     24,034,146    24,852,985
 swap_ra      4,596,035     5,840,082     6,231,646      6,219,484     6,504,878
 swap_ra_hit  2,903,249     3,682,444     3,940,420      3,876,195     4,092,852
 -------------------------------------------------------------------------------


The last 2 columns of the latency reduction progression are as follows:


 IAA decompress batching combined with distributing compress jobs to all
 same-socket IAA devices: 
 =======================================================================

 ------------------------------------------------------------------------------
                   IAA shrink_folio_list() compress batching and
                       swapin_readahead() decompress batching

                                      1WQ      2WQ (distribute compress jobs)

                        1 local WQ (wq.0)    1 local WQ (wq.0) +
                                  per IAA    1 global WQ (wq.1) per IAA
                        
 ------------------------------------------------------------------------------
 zswap compressor             deflate-iaa         deflate-iaa
 vm.compress-batchsize                 32                  32
 vm.page-cluster                        4                   4
 ------------------------------------------------------------------------------
 real_sec                          746.77              745.42  
 user_sec                       15,732.66           15,738.85
 sys_sec                         5,384.14            5,247.86
 Max_Res_Set_Size_KB            1,874,432           1,872,640

 ------------------------------------------------------------------------------
 zswpout                      101,648,460         104,882,982
 zswpin                        27,418,319          29,428,515
 pswpout                              213                  22
 pswpin                               207                   6
 pgmajfault                    21,896,616          23,629,768
 swap_ra                        6,054,409           6,385,080
 swap_ra_hit                    3,791,628           3,985,141
 ------------------------------------------------------------------------------


I would greatly appreciate code review comments for this RFC series!

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=900537


Thanks,
Kanchana



Kanchana P Sridhar (7):
  mm: zswap: Config variable to enable zswap loads with decompress
    batching.
  mm: swap: Add IAA batch decompression API
    swap_crypto_acomp_decompress_batch().
  pagevec: struct folio_batch changes for decompress batching interface.
  mm: swap: swap_read_folio() can add a folio to a folio_batch if it is
    in zswap.
  mm: swap, zswap: zswap folio_batch processing with IAA decompression
    batching.
  mm: do_swap_page() calls swapin_readahead() zswap load batching
    interface.
  mm: For IAA batching, reduce SWAP_BATCH and modify swap slot cache
    thresholds.

 include/linux/pagevec.h    |  13 +-
 include/linux/swap.h       |   7 +
 include/linux/swap_slots.h |   7 +
 include/linux/zswap.h      |  65 +++++++++
 mm/Kconfig                 |  13 ++
 mm/memory.c                | 187 +++++++++++++++++++------
 mm/page_io.c               |  61 ++++++++-
 mm/shmem.c                 |   2 +-
 mm/swap.h                  | 102 ++++++++++++--
 mm/swap_state.c            | 272 ++++++++++++++++++++++++++++++++++---
 mm/swapfile.c              |   2 +-
 mm/zswap.c                 | 272 +++++++++++++++++++++++++++++++++++++
 12 files changed, 927 insertions(+), 76 deletions(-)

-- 
2.27.0


