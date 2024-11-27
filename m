Return-Path: <linux-kernel+bounces-424012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A279DAF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7379166DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CFD20371B;
	Wed, 27 Nov 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laaNiZmh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788E13BC35
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748008; cv=none; b=rqUxB9IUxesC8h4GFv5KgPM3V22LsJEr4MoMGzvLgEoP3ysHSsV/8zsvAvCQ0dixD6SdP1q4uj6jFjER9HV1VJvGEwvUsmU3NnjhSzugmkZuSj6YH0FV5m87yA2lJPvm8nwT50fgJ1N2D5oLOIiJsTVaI7hoNfpeuiu3VqJbPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748008; c=relaxed/simple;
	bh=MOFzkYBW/Ki5ah1cgeyMDJ8kp4C3I0R5Dk0rK0QZL14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dO85xG7hXLkUQq9Vp9d581+kgokZhluw2426qIgdi1SSmBWHIqogj12y3hDAQ0KYdKxGO9GKCJ6klSid7wPHlaTt3tuLrKg0nmGxY2ZnFC7v7HkWyMbqTjtLh8F5Si6AjlbQviWSPBG5U0HW5o7R6o7TIL2kt2aI96wwcIVRwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laaNiZmh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732748007; x=1764284007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MOFzkYBW/Ki5ah1cgeyMDJ8kp4C3I0R5Dk0rK0QZL14=;
  b=laaNiZmhEYvzm+XG7wekrQSNOQy+78r68ZmfglYihO/FRzLf0OWB7OIp
   bcmw5orWdmcGXBGxapsK0gkFD1610QrX6hbnFD2/rGDCH3EpzLXN4syDU
   EkwpJnV4AjVcMxhsyszpxC2xuLBvsIplBz3WQmpcAGXNt8OYHjsW6wiy0
   6COEinoqy2+dy5lUDlJi28g0PBkxOhsLlQtEm96uj5Xi30pf1NgqEI7FL
   6yxFIFCZFJVTrSc3N1FQZFXueTr3PxJ0QPtHI76hsNJaksdLn6uehBBUj
   oZGCZOQg4zb71vw31WFTyDnv6JMViGf9OSzC7B+NXFSQFFx15Qo2H1nLi
   g==;
X-CSE-ConnectionGUID: YU8oqMZeS3eQJjP1Rfftlg==
X-CSE-MsgGUID: BwTa4TGkQpiPlDTQ4yKx1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33022401"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="33022401"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 14:53:26 -0800
X-CSE-ConnectionGUID: uniqWpHBTgayP9h/t1aeDw==
X-CSE-MsgGUID: 9iL0Ibz0ROKNkzjjcEukcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="92235431"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by fmviesa008.fm.intel.com with ESMTP; 27 Nov 2024 14:53:25 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1 0/2] Vectorize and simplify zswap_store_page().
Date: Wed, 27 Nov 2024 14:53:22 -0800
Message-Id: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series vectorizes and simplifies the existing
zswap_store()/zswap_store_page() implementation so that the IAA compress
batching functionality in [1] can be developed seamlessly with minimal
impact to zswap_store() code; while still having a single consolidated
implementation of zswap_store() for batching/non-batching compression
algorithms, which will make the code easier to maintain.

These changes have been developed based on code review comments in [2].

I would greatly appreciate suggestions for further improving the patches in
this series.

Once this patch series is reviewed, I intend to incorporate these patches
in the IAA compress batching series [1], to develop a v5 of that series.

The main focus of testing this specific series was to make sure there are no
performance regressions. usemem 30 processes was run for three folio
configurations, with zstd and with deflate-iaa:

1) 4k folios
2) 16k/32k/64k folios
3) 2M folios


System setup for testing:
=========================
Testing of this patch-series was done with mm-unstable as of 11-18-2024,
commit 5a7056135bb6, without and with this patch-series.
Data was gathered on an Intel Sapphire Rapids server, dual-socket 56 cores
per socket, 4 IAA devices per socket, 503 GiB RAM and 525G SSD disk
partition swap. Core frequency was fixed at 2500MHz.

Other kernel configuration parameters:

    zswap compressor  : zstd, deflate-iaa
    zswap allocator   : zsmalloc
    vm.page-cluster   : 2

IAA "compression verification" is enabled and IAA is run in the sync mode.
1WQ is configured per IAA device, and handles both, compressions and
decompressions.


Regression testing (usemem30):
==============================
The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 150G. The is no swap limit set for the cgroup. 30 usemem
processes were run, each allocating and writing 10G of memory, and sleeping
for 10 sec before exiting:

usemem --init-time -w -O -s 10 -n 30 10g


 4k folios: zstd:
 ================

 -------------------------------------------------------------------------------
                       mm-unstable-11-18-2024   v1 of this patch-series
                                                 Patch 1       Patch 2 
 -------------------------------------------------------------------------------
 zswap compressor               zstd                zstd          zstd         
 vm.page-cluster                   2                   2             2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   4,783,479           4,755,909     4,868,751     
 Avg throughput (KB/s)       159,449             158,530       162,291     
 elapsed time (sec)           127.46              129.70        125.70     
 sys time (sec)             3,088.65            3,143.92      3,071.41     
                                                                              
 -------------------------------------------------------------------------------
 memcg_high                  437,178             428,090       451,918        
 memcg_swap_fail                   0                   0             0        
 zswpout                  48,931,290          48,931,325    48,932,080       
 zswpin                          390                 398           380        
 pswpout                           0                   0             0        
 pswpin                            0                   0             0        
 thp_swpout                        0                   0             0        
 thp_swpout_fallback               0                   0             0        
 pgmajfault                    3,231               3,636         3,627        
 swap_ra                          93                  90            91        
 swap_ra_hit                      48                  43            48        
 -------------------------------------------------------------------------------


 4k folios: deflate-iaa:
 =======================

 -------------------------------------------------------------------------------
                       mm-unstable-11-18-2024   v1 of this patch-series
                                                 Patch 1       Patch 2 
 -------------------------------------------------------------------------------
 zswap compressor        deflate-iaa         deflate-iaa   deflate-iaa         
 vm.page-cluster                   2                   2             2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   5,155,471           5,397,318     5,231,233     
 Avg throughput (KB/s)       171,849             179,910       174,374     
 elapsed time (sec)           108.35              104.93        107.81     
 sys time (sec)             2,400.32            2,293.43      2,395.95     
                                                                              
 -------------------------------------------------------------------------------
 memcg_high                  670,635             634,770       632,160        
 memcg_swap_fail                   0                   0             0        
 zswpout                  62,098,929          57,334,719    58,221,779       
 zswpin                          425                 402           392        
 pswpout                           0                   0             0        
 pswpin                            0                   0             0        
 thp_swpout                        0                   0             0        
 thp_swpout_fallback               0                   0             0        
 pgmajfault                    3,271               3,641         3,632        
 swap_ra                         103                 101            93        
 swap_ra_hit                      47                  48            45        
 -------------------------------------------------------------------------------


 16k/32/64k folios: zstd:
 ========================

 -------------------------------------------------------------------------------
                       mm-unstable-11-18-2024   v1 of this patch-series
                                                 Patch 1       Patch 2 
 -------------------------------------------------------------------------------
 zswap compressor               zstd                zstd          zstd         
 vm.page-cluster                   2                   2             2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   6,284,634           6,227,125     6,221,686
 Avg throughput (KB/s)       209,487             207,570       207,389
 elapsed time (sec)           107.64              110.57        109.96
 sys time (sec)             2,566.69            2,636.39      2,615.76
                                                                      
 -------------------------------------------------------------------------------
 memcg_high                  477,219             476,572       477,768
 memcg_swap_fail               1,040               1,089         1,088
 zswpout                  48,931,670          48,931,991    48,931,829
 zswpin                          384                 400           397
 pswpout                           0                   0             0
 pswpin                            0                   0             0
 thp_swpout                        0                   0             0
 thp_swpout_fallback               0                   0             0
 16kB-swpout_fallback              0                   0             0                                    
 32kB_swpout_fallback              0                   0             0
 64kB_swpout_fallback          1,040               1,089         1,088
 pgmajfault                    3,258               3,271         3,265
 swap_ra                          95                 106           101
 swap_ra_hit                      46                  56            54
 ZSWPOUT-16kB                      2                   3             5
 ZSWPOUT-32kB                      0                   1             1
 ZSWPOUT-64kB              3,057,203           3,057,162     3,057,147
 SWPOUT-16kB                       0                   0             0
 SWPOUT-32kB                       0                   0             0
 SWPOUT-64kB                       0                   0             0
 -------------------------------------------------------------------------------


 16k/32/64k folios: deflate-iaa:
 ===============================

 -------------------------------------------------------------------------------
                       mm-unstable-11-18-2024   v1 of this patch-series
                                                 Patch 1       Patch 2 
 -------------------------------------------------------------------------------
 zswap compressor        deflate-iaa         deflate-iaa   deflate-iaa         
 vm.page-cluster                   2                   2             2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   7,149,906           7,268,900     7,126,761
 Avg throughput (KB/s)       238,330             242,296       237,558
 elapsed time (sec)            84.38               87.44         84.18
 sys time (sec)             1,844.32            1,847.65      1,741.97
                                                                      
 -------------------------------------------------------------------------------
 memcg_high                  616,897             704,278       585,911
 memcg_swap_fail               2,734               1,858         1,708
 zswpout                  55,520,017          60,188,111    52,639,745
 zswpin                          491                 393           444
 pswpout                           0                   0             0
 pswpin                            0                   0             0
 thp_swpout                        0                   0             0
 thp_swpout_fallback               0                   0             0
 16kB-swpout_fallback              0                   0             0                      
 32kB_swpout_fallback              0                   0             0
 64kB_swpout_fallback          2,734               1,858         1,708
 pgmajfault                    3,314               3,266         3,277
 swap_ra                         128                 103           154
 swap_ra_hit                      49                  46            90
 ZSWPOUT-16kB                      4                   4             3
 ZSWPOUT-32kB                      2                   1             1
 ZSWPOUT-64kB              3,467,400           3,759,882     3,288,260
 SWPOUT-16kB                       0                   0             0
 SWPOUT-32kB                       0                   0             0
 SWPOUT-64kB                       0                   0             0
 -------------------------------------------------------------------------------


 2M folios: zstd:
 ================

 -------------------------------------------------------------------------------
                       mm-unstable-11-18-2024   v1 of this patch-series
                                                 Patch 1       Patch 2 
 -------------------------------------------------------------------------------
 zswap compressor               zstd                zstd          zstd         
 vm.page-cluster                   2                   2             2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   6,466,700           6,544,384     6,532,820 
 Avg throughput (KB/s)       215,556             218,146       217,760
 elapsed time (sec)           106.80              106.29        105.45
 sys time (sec)             2,420.88            2,462.67      2,380.86
                                                                      
 -------------------------------------------------------------------------------
 memcg_high                   60,926              58,746        62,680
 memcg_swap_fail                  44                  62            60
 zswpout                  48,892,828          48,936,840    48,934,265
 zswpin                          391                 406           391
 pswpout                           0                   0             0
 pswpin                            0                   0             0
 thp_swpout                        0                   0             0
 thp_swpout_fallback              44                  62            60
 pgmajfault                    4,907               4,793         5,461
 swap_ra                       5,070               4,693         6,605
 swap_ra_hit                   5,024               4,639         6,556
 ZSWPOUT-2048kB               95,442              95,509        95,506
 SWPOUT-2048kB                     0                   0             0
 -------------------------------------------------------------------------------


 2M folios: deflate-iaa:
 =======================

 -------------------------------------------------------------------------------
                       mm-unstable-11-18-2024   v1 of this patch-series
                                                 Patch 1       Patch 2 
 -------------------------------------------------------------------------------
 zswap compressor        deflate-iaa         deflate-iaa   deflate-iaa         
 vm.page-cluster                   2                   2             2
 -------------------------------------------------------------------------------
 Total throughput (KB/s)   7,245,936           7,589,698     7,470,639
 Avg throughput (KB/s)       241,531             252,989       249,021
 elapsed time (sec)            84.44               82.77         82.54
 sys time (sec)             1,753.41            1,681.53      1,674.63
                                                                      
 -------------------------------------------------------------------------------
 memcg_high                   79,259              85,642        84,382
 memcg_swap_fail                 139               1,429         2,163
 zswpout                  57,701,156          59,347,201    58,657,587
 zswpin                          419                 467           469
 pswpout                           0                   0             0
 pswpin                            0                   0             0
 thp_swpout                        0                   0             0
 thp_swpout_fallback             139               1,429         2,163
 pgmajfault                   11,542              19,689        28,301
 swap_ra                      24,613              47,622        73,288
 swap_ra_hit                  24,555              47,535        73,203
 ZSWPOUT-2048kB              112,515             114,659       112,860
 SWPOUT-2048kB                     0                   0             0
 -------------------------------------------------------------------------------


Summary:
========
There are no noticeable performance regressions with this patch series.


Changes in v1:
==============
1) Addressed code review comments from Yosry and Johannes in [2]. Thanks
   both!

 [1]: https://patchwork.kernel.org/project/linux-mm/list/?series=911935
 [2]: https://patchwork.kernel.org/project/linux-mm/patch/20241123070127.332773-11-kanchana.p.sridhar@intel.com/


Thanks,
Kanchana



Kanchana P Sridhar (2):
  mm: zswap: Modified zswap_store_page() to process multiple pages in a
    folio.
  mm: zswap: zswap_store_pages() simplifications for batching.

 include/linux/zswap.h |   1 +
 mm/zswap.c            | 199 ++++++++++++++++++++++++++++--------------
 2 files changed, 135 insertions(+), 65 deletions(-)


base-commit: 5a7056135bb69da2ce0a42eb8c07968c1331777b
-- 
2.27.0


