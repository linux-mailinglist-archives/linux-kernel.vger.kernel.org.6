Return-Path: <linux-kernel+bounces-342314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92E988D84
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD68E1C2144D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9C43AB0;
	Sat, 28 Sep 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjWfNBAy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58614277
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489787; cv=none; b=bC4SWFF8+vaemHQg/PzkOQEyYOksDe6EQbNX/OVIExbBBAw1FQLTSxWMc6zux4fe2N1KgMsTiPnYF5SV0/WLMnhxlSa3igRM1zAVle+cHsqRMhFETYE+3Y1Zu/plFJg1QA2+lNyXIRmb2DgFnA15cWUMlxU2exV8G2ZVNlWnQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489787; c=relaxed/simple;
	bh=R/apKszlrXtPXiFpyrfrmUn+eperkzJ9x7hxHsxU1DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBH9cSC48AQIvqYfNzdSPrbme+nwmaSj1YyhatAMqmHGw7yed6TO1jyspJ60dLYkzfS8gIigcp17RRs5kv3dHvlldZo7TXTz2Y5IYonjk3DOm5cFP5qQ2Ax4oB/a4y9oVGO3Cz0AtNXSyUPUT/fmVm7e+u+v2IasX3cFqsv9PNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjWfNBAy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489784; x=1759025784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R/apKszlrXtPXiFpyrfrmUn+eperkzJ9x7hxHsxU1DQ=;
  b=GjWfNBAyHDRWz/mPmEGXBXExDp/KDEJ+qAd4/J3WjuqVbo1rV3TaocaK
   Tre8uRLfT2P/8awz3KhfenzuGcpzwlKkktZsfXukKobCGLuTXGs/lntWK
   nFQCH6uf4bOF9W/mJlm2iMKlyvgbuwUhaTYg3Pi/QV6cxkvBVMg6NI+n3
   P5wanT99yPCAwAO+NA9lAB06jc998/g+JmonAhtyksRnkiVLpGnVgELo0
   keV00hiZzhQ3Okm/Ai06ZNGyPI1NIu023jplU0FKsP0m2zs0xMihXTWZx
   /k17ISMcuW6wnaDkugH+t6U+uhoIv9dYFpW7dggsYTLIk1h70S+BL9FIj
   Q==;
X-CSE-ConnectionGUID: klTQHfxcRq+0PIh/r2amKw==
X-CSE-MsgGUID: Subg9wTlSgODw1VQgZc+Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526855"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526855"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:20 -0700
X-CSE-ConnectionGUID: VjgpWolIR/mVt6Lr2uo/fA==
X-CSE-MsgGUID: CQnoh3h8RHmNrkReJbBIEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507107"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:21 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 0/8] mm: zswap swap-out of large folios
Date: Fri, 27 Sep 2024 19:16:12 -0700
Message-Id: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This patch-series enables zswap_store() to accept and store large
folios. The most significant contribution in this series is from the 
earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
migrated to mm-unstable as of 9-27-2024 in patch 6 of this series, and
adapted based on code review comments received for v7 of the current
patch-series.

[1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
     https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

The first few patches do the prep work for supporting large folios in
zswap_store. Patch 6 provides the main functionality to swap-out large
folios in zswap. Patch 7 adds sysfs per-order hugepages "zswpout" counters
that get incremented upon successful zswap_store of large folios:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

Patch 8 updates the documentation for the new sysfs "zswpout" counters.

This patch-series is a pre-requisite for zswap compress batching of large
folio swap-out and decompress batching of swap-ins based on
swapin_readahead(), using Intel IAA hardware acceleration, which we would
like to submit in subsequent patch-series, with performance improvement
data.

Thanks to Ying Huang for pre-posting review feedback and suggestions!

Thanks also to Nhat, Yosry, Johannes, Barry, Chengming, Usama and Ying for
their helpful feedback, data reviews and suggestions!

Co-development signoff request:
===============================
I would like to thank Ryan Roberts for his original RFC [1] and request
his co-developer signoff on patch 6 in this series. Thanks Ryan!


System setup for testing:
=========================
Testing of this patch-series was done with mm-unstable as of 9-27-2024,
commit de2fbaa6d9c3576ec7133ed02a370ec9376bf000. Data was gathered
without/with this patch-series, on an Intel Sapphire Rapids server,
dual-socket 56 cores per socket, 4 IAA devices per socket, 503 GiB RAM and
525G SSD disk partition swap. Core frequency was fixed at 2500MHz.

The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 150G. The is no swap limit set for the cgroup. 30 usemem
processes were run, each allocating and writing 10G of memory, and sleeping
for 10 sec before exiting:

usemem --init-time -w -O -s 10 -n 30 10g

Other kernel configuration parameters:

    zswap compressors : zstd, deflate-iaa
    zswap allocator   : zsmalloc
    vm.page-cluster   : 2

In the experiments where "deflate-iaa" is used as the zswap compressor,
IAA "compression verification" is enabled by default
(cat /sys/bus/dsa/drivers/crypto/verify_compress). Hence each IAA
compression will be decompressed internally by the "iaa_crypto" driver, the
crc-s returned by the hardware will be compared and errors reported in case
of mismatches. Thus "deflate-iaa" helps ensure better data integrity as
compared to the software compressors, and the experimental data listed
below is with verify_compress set to "1".

Total and average throughput are derived from the individual 30 processes'
throughputs reported by usemem. elapsed/sys times are measured with perf.

The vm stats and sysfs hugepages stats included with the performance data
provide details on the swapout activity to zswap/swap device.


Testing labels used in data summaries:
======================================
The data refers to these test configurations and the before/after
comparisons that they do:

 before-case1:
 -------------
 mm-unstable 9-27-2024, CONFIG_THP_SWAP=N (compares zswap 4K vs. zswap 64K)

 In this scenario, CONFIG_THP_SWAP=N results in 64K/2M folios to be split
 into 4K folios that get processed by zswap.

 before-case2:
 -------------
 mm-unstable 9-27-2024, CONFIG_THP_SWAP=Y (compares SSD swap large folios vs. zswap large folios)

 In this scenario, CONFIG_THP_SWAP=Y results in zswap rejecting large
 folios, which will then be stored by the SSD swap device.

 after:
 ------
 v8 of this patch-series, CONFIG_THP_SWAP=Y

 The "after" is CONFIG_THP_SWAP=Y and v8 of this patch-series, that results
 in 64K/2M folios to not be split, and to be processed by zswap_store.


Regression Testing:
===================
I ran vm-scalability usemem without large folios, i.e., only 4K folios with
mm-unstable and this patch-series. The main goal was to make sure that
there is no functional or performance regression wrt the earlier zswap
behavior for 4K folios, now that 4K folios will be processed by the new
zswap_store() code.

The data indicates there is no significant regression.

 -------------------------------------------------------------------------------
 4K folios:
 ==========

 zswap compressor                zstd          zstd        zstd  zstd v8 zstd v8
                         before-case1  before-case2       after      vs.     vs.
                                                                   case1   case2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)    4,793,363     4,880,978   4,813,151       0%     -1%
 Average throughput (KB/s)    159,778       162,699     160,438       0%     -1%
 elapsed time (sec)            130.14        123.17      127.21       2%     -3%
 sys time (sec)              3,135.53      2,985.64    3,110.53       1%     -4%
 memcg_high                   446,826       444,626     448,231        
 memcg_swap_fail                    0             0           0              
 pswpout                            0             0           0              
 pswpin                             0             0           0              
 zswpout                   48,932,107    48,931,971  48,931,584             
 zswpin                           383           386         388            
 thp_swpout                         0             0           0              
 thp_swpout_fallback                0             0           0              
 64kB-mthp_swpout_fallback          0             0           0              
 pgmajfault                     3,063         3,077       3,082          
 swap_ra                           93            94          93             
 swap_ra_hit                       47            47          47             
 ZSWPOUT-64kB                     n/a           n/a           0              
 SWPOUT-64kB                        0             0           0              
 -------------------------------------------------------------------------------


Performance Testing:
====================

We list the data for 64K folios with before/after data per-compressor,
followed by the same for 2M pmd-mappable folios.


 -------------------------------------------------------------------------------
 64K folios: zstd:
 =================

 zswap compressor                zstd          zstd         zstd      zstd v8
                         before-case1  before-case2        after     vs.    vs.
                                                                   case1  case2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)    5,222,213     1,076,611    6,227,367     19%    478%
 Average throughput (KB/s)    174,073        35,887      207,578     19%    478%
 elapsed time (sec)            120.50        347.16       109.21      9%     69%
 sys time (sec)              2,930.33        248.16     2,609.22     11%   -951%
 memcg_high                   416,773       552,200      482,703                  
 memcg_swap_fail            3,192,906         1,293          944                  
 pswpout                            0    40,778,448            0                  
 pswpin                             0            16            0                  
 zswpout                   48,931,583        20,903   48,931,271                  
 zswpin                           384           363          392                  
 thp_swpout                         0             0            0                  
 thp_swpout_fallback                0             0            0                  
 64kB-mthp_swpout_fallback  3,192,906         1,293          944                  
 pgmajfault                     3,452         3,072        3,095                  
 swap_ra                           90            87          100                  
 swap_ra_hit                       42            43           56                  
 ZSWPOUT-64kB                     n/a           n/a    3,057,260                  
 SWPOUT-64kB                        0     2,548,653            0                  
 -------------------------------------------------------------------------------


 -------------------------------------------------------------------------------
 64K folios: deflate-iaa:
 ========================

 zswap compressor         deflate-iaa   deflate-iaa  deflate-iaa  deflate-iaa v8
                         before-case1  before-case2        after      vs.    vs.
                                                                   case1   case2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)    5,652,608     1,089,180    6,315,000     12%    480%  
 Average throughput (KB/s)    188,420        36,306      210,500     12%    480%  
 elapsed time (sec)            102.90        343.35        91.11     11%     73%  
 sys time (sec)              2,246.86        213.53     1,939.31     14%   -808%  
 memcg_high                   576,104       502,907      612,505                   
 memcg_swap_fail            4,016,117         1,407        1,660                   
 pswpout                            0    40,862,080            0                   
 pswpin                             0            20            0                   
 zswpout                   61,163,423        22,444   57,317,607                   
 zswpin                           401           368          449                   
 thp_swpout                         0             0            0                   
 thp_swpout_fallback                0             0            0                   
 64kB-mthp_swpout_fallback  4,016,117         1,407        1,660                   
 pgmajfault                     3,063         3,153        3,167                   
 swap_ra                           96            93          149                   
 swap_ra_hit                       46            45           89                   
 ZSWPOUT-64kB                     n/a           n/a    3,580,673                   
 SWPOUT-64kB                        0     2,553,880            0                 
 -------------------------------------------------------------------------------


 -------------------------------------------------------------------------------
 2M folios: zstd:
 ================

 zswap compressor                zstd          zstd         zstd      zstd v8
                         before-case1  before-case2        after     vs.    vs.
                                                                   case1  case2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)    5,895,500     1,109,694     6,460,111    10%    482% 
 Average throughput (KB/s)    196,516        36,989       215,337    10%    482% 
 elapsed time (sec)            108.77        334.28        105.92     3%     68% 
 sys time (sec)              2,657.14         94.88      2,436.24     8%  -2468% 
 memcg_high                    64,200        66,316        60,300                 
 memcg_swap_fail              101,182            70            30                 
 pswpout                            0    40,166,400             0                 
 pswpin                             0             0             0                 
 zswpout                   48,931,499        36,507    48,869,236                 
 zswpin                           380           379           397                 
 thp_swpout                         0        78,450             0                 
 thp_swpout_fallback          101,182            70            30                 
 2MB-mthp_swpout_fallback           0             0             0                 
 pgmajfault                     3,067         3,417         4,765                 
 swap_ra                           91            90         5,073                 
 swap_ra_hit                       45            45         5,024                 
 ZSWPOUT-2MB                      n/a           n/a        95,408                 
 SWPOUT-2MB                         0        78,450             0                
 -------------------------------------------------------------------------------


 -------------------------------------------------------------------------------
 2M folios: deflate-iaa:
 =======================

 zswap compressor         deflate-iaa   deflate-iaa  deflate-iaa  deflate-iaa v8
                         before-case1  before-case2        after      vs.    vs.
                                                                   case1   case2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   6,286,587      1,126,785     7,569,560    20%    572%   
 Average throughput (KB/s)   209,552         37,559       252,318    20%    572%   
 elapsed time (sec)            96.19         333.03         81.96    15%     75%   
 sys time (sec)             2,141.44          99.96      1,768.41    17%  -1669%   
 memcg_high                   99,253         64,666        75,139                   
 memcg_swap_fail             129,074             53            73                   
 pswpout                           0     40,048,128             0                   
 pswpin                            0              0             0                   
 zswpout                  61,312,794         28,321    57,083,119                   
 zswpin                          383            406           447                   
 thp_swpout                        0         78,219             0                   
 thp_swpout_fallback         129,074             53            73                   
 2MB-mthp_swpout_fallback          0              0             0                   
 pgmajfault                    3,430          3,077         7,133                   
 swap_ra                          91            103        11,978                   
 swap_ra_hit                      47             46        11,920                   
 ZSWPOUT-2MB                     n/a            n/a       111,390                   
 SWPOUT-2MB                        0         78,219             0               
 -------------------------------------------------------------------------------

And finally, this is a comparison of deflate-iaa vs. zstd with v8 of this
patch-series:

 ---------------------------------------------
                   zswap_store large folios v8
                  Impr w/ deflate-iaa vs. zstd

                       64K folios    2M folios
 ---------------------------------------------
 Throughput (KB/s)             1%          17%
 elapsed time (sec)           17%          23%
 sys time (sec)               26%          27%
 ---------------------------------------------


Conclusions based on the performance results:
=============================================

 v8 wrt before-case1:
 --------------------
 We see significant improvements in throughput, elapsed and sys time for
 zstd and deflate-iaa, when comparing before-case1 (THP_SWAP=N) vs. after
 (THP_SWAP=Y) with zswap_store large folios.

 v8 wrt before-case2:
 --------------------
 We see even more significant improvements in throughput and elapsed time
 for zstd and deflate-iaa, when comparing before-case2 (large-folio-SSD)
 vs. after (large-folio-zswap). The sys time increases with
 large-folio-zswap as expected, due to the CPU compression time
 vs. asynchronous disk write times, as pointed out by Ying and Yosry.
 
 In before-case2, when zswap does not store large folios, only allocations
 and cgroup charging due to 4K folio zswap stores count towards the cgroup
 memory limit. However, in the after scenario, with the introduction of
 zswap_store() of large folios, there is an added component of the zswap
 compressed pool usage from large folio stores from potentially all 30
 processes, that gets counted towards the memory limit. As a result, we see
 higher swapout activity in the "after" data.


Summary:
========
The v8 data presented above shows that zswap_store of large folios
demonstrates good throughput/performance improvements compared to
conventional SSD swap of large folios with a sufficiently large 525G SSD
swap device. Hence, it seems reasonable for zswap_store to support large
folios, so that further performance improvements can be implemented.

In the experimental setup used in this patchset, we have enabled IAA
compress verification to ensure additional hardware data integrity CRC
checks not currently done by the software compressors. We see good
throughput/latency improvements with deflate-iaa vs. zstd with zswap_store
of large folios.

Some of the ideas for further reducing latency that have shown promise in
our experiments, are:

1) IAA compress/decompress batching.
2) Distributing compress jobs across all IAA devices on the socket.

The tests run for this patchset are using only 1 IAA device per core, that
avails of 2 compress engines on the device. In our experiments with IAA
batching, we distribute compress jobs from all cores to the 8 compress
engines available per socket. We further compress the pages in each folio
in parallel in the accelerator. As a result, we improve compress latency
and reclaim throughput.

In decompress batching, we use swapin_readahead to generate a prefetch
batch of 4K folios that we decompress in parallel in IAA.

 ------------------------------------------------------------------------------
                          IAA compress/decompress batching
              Further improvements wrt v8 zswap_store Sequential
                          subpage store using "deflate-iaa":
                       
                      "deflate-iaa" Batching  "deflate-iaa-canned" [2] Batching
                          Additional Impr               Additional Impr   
                     64K folios    2M folios     64K folios    2M folios
 ------------------------------------------------------------------------------
 Throughput (KB/s)          35%          34%            44%          44%  
 elapsed time (sec)          9%          10%            14%          17%  
 sys time (sec)            0.4%           4%             8%          15%  
 ------------------------------------------------------------------------------


With zswap IAA compress/decompress batching, we are able to demonstrate
significant performance improvements and memory savings in server
scalability experiments in highly contended system scenarios under
significant memory pressure; as compared to software compressors. We hope
to submit this work in subsequent patch series. The current patch-series is
a prequisite for these future submissions.

Thanks,
Kanchana


[1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
[2] https://patchwork.kernel.org/project/linux-crypto/cover/cover.1710969449.git.andre.glover@linux.intel.com/


Changes since v7:
=================
1) Rebased to mm-unstable as of 9-27-2024,
   commit de2fbaa6d9c3576ec7133ed02a370ec9376bf000.
2) Added Nhat's 'Reviewed-by' to patches 1 and 2. Thanks Nhat!
3) Implemented one-time obj_cgroup_may_zswap and zswap_check_limits at the
   start of zswap_store. Implemented one-time batch updates to cgroup zswap
   charging (with total compressed bytes), zswap_stored_pages and the
   memcg/vm zswpout event stats (with folio_nr_pages()) only for successful
   stores at the end of zswap_store. Thanks Yosry and Johannes for guidance
   on this!
4) Changed the existing zswap_pool_get() to zswap_pool_tryget(). Modified
   zswap_pool_current_get() and zswap_pool_find_get() to call
   zswap_pool_tryget(). Furthermore, zswap_store() obtains a reference to a
   valid zswap_pool upfront by calling zswap_pool_tryget(), and errors out
   if the tryget fails. Added a new zswap_pool_get() that calls
   "percpu_ref_get(&pool->ref)" and is called in zswap_store_page(), as
   suggested by Johannes & Yosry. Thanks both!
5) Provided a new count_objcg_events() API for batch event updates.
6) Changed "zswap_stored_pages" to atomic_long_t to support adding
   folio_nr_pages() to it once a large folio is stored successfully.
7) Deleted the refactoring done in v7 for the xarray updates in
   zswap_store_page(); and unwinding of stored offsets in zswap_store() in
   case of errors, as suggested by Johannes.
8) Deleted the CONFIG_ZSWAP_STORE_THP_DEFAULT_ON config option and
   "zswap_mthp_enabled" tunable, as recommended by Yosry, Johannes and
   Nhat.
9) Replaced references to "mTHP" with "large folios"; organized
   before/after data per-compressor for easier visual comparisons;
   incorporated Nhat's feedback in the documentation updates; moved
   changelog to the end. Thanks Johannes, Yosry and Nhat!
10) Moved the usemem testing configuration to 30 processes, each allocating
    10G within a 150G memory-limit constrained cgroup, maintaining the
    allocated memory for 10 sec before exiting. Thanks Ying for this
    suggestion!

Changes since v6:
=================
1) Rebased to mm-unstable as of 9-23-2024,
   commit acfabf7e197f7a5bedf4749dac1f39551417b049.
2) Refactored into smaller commits, as suggested by Yosry and
   Chengming. Thanks both!
3) Reworded the commit log for patches 5 and 6 as per Yosry's
   suggestion. Thanks Yosry!
4) Gathered data on a Sapphire Rapids server that has 823GiB SSD swap disk
   partition. Also, all experiments are run with usemem --sleep 10, so that
   the memory allocated by the 70 processes remains in memory
   longer. Posted elapsed and sys times. Thanks to Yosry, Nhat and Ying for
   their help with refining the performance characterization methodology.
5) Updated Documentation/admin-guide/mm/transhuge.rst as suggested by
   Nhat. Thanks Nhat!

Changes since v5:
=================
1) Rebased to mm-unstable as of 8/29/2024,
   commit 9287e4adbc6ab8fa04d25eb82e097fed877a4642.
2) Added CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default) to
   enable/disable zswap_store() of mTHP folios. Thanks Nhat for the
   suggestion to add a knob by which users can enable/disable this
   change. Nhat, I hope this is along the lines of what you were
   thinking.
3) Added vm-scalability usemem data with 4K folios with
   CONFIG_ZSWAP_STORE_THP_DEFAULT_ON off, that I gathered to make sure
   there is no regression with this change.
4) Added data with usemem with 64K and 2M THP for an alternate view of
   before/after, as suggested by Yosry, so we can understand the impact
   of when mTHPs are split into 4K folios in shrink_folio_list()
   (CONFIG_THP_SWAP off) vs. not split (CONFIG_THP_SWAP on) and stored
   in zswap. Thanks Yosry for this suggestion.

Changes since v4:
=================
1) Published before/after data with zstd, as suggested by Nhat (Thanks
   Nhat for the data reviews!).
2) Rebased to mm-unstable from 8/27/2024,
   commit b659edec079c90012cf8d05624e312d1062b8b87.
3) Incorporated the change in memcontrol.h that defines obj_cgroup_get() if
   CONFIG_MEMCG is not defined, to resolve build errors reported by kernel
   robot; as per Nhat's and Michal's suggestion to not require a separate
   patch to fix the build errors (thanks both!).
4) Deleted all same-filled folio processing in zswap_store() of mTHP, as
   suggested by Yosry (Thanks Yosry!).
5) Squashed the commits that define new mthp zswpout stat counters, and
   invoke count_mthp_stat() after successful zswap_store()s; into a single
   commit. Thanks Yosry for this suggestion!

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



Kanchana P Sridhar (8):
  mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
  mm: zswap: Modify zswap_compress() to accept a page instead of a
    folio.
  mm: zswap: Rename zswap_pool_get() to zswap_pool_tryget().
  mm: Provide a new count_objcg_events() API for batch event updates.
  mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
  mm: zswap: Support large folios in zswap_store().
  mm: swap: Count successful large folio zswap stores in hugepage
    zswpout stats.
  mm: Document the newly added sysfs large folios zswpout stats.

 Documentation/admin-guide/mm/transhuge.rst |   8 +-
 fs/proc/meminfo.c                          |   2 +-
 include/linux/huge_mm.h                    |   1 +
 include/linux/memcontrol.h                 |  24 ++
 include/linux/zswap.h                      |   2 +-
 mm/huge_memory.c                           |   3 +
 mm/page_io.c                               |   1 +
 mm/zswap.c                                 | 254 +++++++++++++++------
 8 files changed, 219 insertions(+), 76 deletions(-)


base-commit: de2fbaa6d9c3576ec7133ed02a370ec9376bf000
-- 
2.27.0


