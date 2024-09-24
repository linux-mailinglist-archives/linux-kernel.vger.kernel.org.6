Return-Path: <linux-kernel+bounces-336431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D9983AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B881F1C219D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E36946C;
	Tue, 24 Sep 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUcgN14W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAB38C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140634; cv=none; b=pCbcOkJn04ST1lzpJpUXVJn5i/tRtBvi4xSLx5gjpupKBDU8ZXvn8NN93rWbVQyVFeg0nk6ISTP6NjRll0gsf+QhJ5500lvn4bDSnlnovVfyvoqjuRwhOyPHVdE+8MCoDR4+Z/e+qwxdhrK2xFcOJg6JhlO0HyvOvIq4rAjrmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140634; c=relaxed/simple;
	bh=xuPiXRmN7lNY2KvnBdwZsBMKRrcRmfXTg/aP8xIbMIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FD+dDK6wUD8BprfHcJAi2u8aL49+S+9i1DX/gdBbeUAWC1SxHSj1fidwrtyxyd7roan0ZrPkRALm3Br6pLbi0HeHJQLvSCQO5P5vocKh0ptwSCIx6jj8Z0dVpX74FKB1Z2kNUePtO/YTbIQDdT6uIdSHj1pJrvix7SvHxM2T6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUcgN14W; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140631; x=1758676631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xuPiXRmN7lNY2KvnBdwZsBMKRrcRmfXTg/aP8xIbMIg=;
  b=JUcgN14W7bCORHa2M9D6hRsfa3CPmEy/Vl+a45m1ZEG1wZjl6h+KhfTP
   ngCikSiVHhYspCY+tCb9IF6aVMN2hampeg06oCXRmX9U387iu0f+lzVT0
   3W8NkRODkQ+vT/hiFZkogMU3XaHux5n8xACOXaSldVTN2byDTkydhZIiI
   zVByvzFHlDS08gCAxeLGQpzQ+u/+2fjq2qMgFpKm+s4f6WiAn85C997Ft
   jWChSICphgobVFDnr2UOzB0UDqVtQZZRE5Nll+sItrP7c8opTVUtdiPvH
   +2lMRj3ECtmVhVOXkDEwVnbKjrsbGfQqeFDZoN3dD+mUKHRd8GRfKomsc
   w==;
X-CSE-ConnectionGUID: UeSqugXCQSGFrr5DsrGgJw==
X-CSE-MsgGUID: IiZi5AuXQECltJiBV+H6aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30001989"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30001989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:10 -0700
X-CSE-ConnectionGUID: 0sdpxtJfTmOgsliSSEHm9Q==
X-CSE-MsgGUID: Kbelyp9MQTKvb+YMnfOy1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688440"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:09 -0700
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
Subject: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Date: Mon, 23 Sep 2024 18:17:01 -0700
Message-Id: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
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
migrated to mm-unstable as of 9-23-2024 in patches 5,6 of this series.

[1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
     https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

Additionally, there is an attempt to modularize some of the functionality
in zswap_store(), to make it more amenable to supporting any-order
mTHPs. For instance, the function zswap_store_entry() stores a zswap_entry
in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
delete all offsets corresponding to a higher order folio stored in zswap.

For accounting purposes, the patch-series adds per-order mTHP sysfs
"zswpout" counters that get incremented upon successful zswap_store of
an mTHP folio:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
will enable/disable zswap storing of (m)THP. When disabled, zswap will
fallback to rejecting the mTHP folio, to be processed by the backing
swap device.

This patch-series is a pre-requisite for ZSWAP compress batching of mTHP
swap-out and decompress batching of swap-ins based on swapin_readahead(),
using Intel IAA hardware acceleration, which we would like to submit in
subsequent patch-series, with performance improvement data.

Thanks to Ying Huang for pre-posting review feedback and suggestions!

Thanks also to Nhat, Yosry, Barry, Chengming, Usama and Ying for their
helpful feedback, data reviews and suggestions!

Co-development signoff request:
===============================
I would like to request Ryan Roberts' co-developer signoff on patches
5 and 6 in this series. Thanks Ryan!

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


Regression Testing:
===================
I ran vm-scalability usemem 70 processes without mTHP, i.e., only 4K
folios with mm-unstable and with this patch-series. The main goal was
to make sure that there is no functional or performance regression
wrt the earlier zswap behavior for 4K folios,
CONFIG_ZSWAP_STORE_THP_DEFAULT_ON is not set, and zswap_store() of 4K
pages goes through the newly added code path [zswap_store(),
zswap_store_page()].

The data indicates there is no regression.

 ------------------------------------------------------------------------------
                     mm-unstable 8-28-2024                        zswap-mTHP v6
                                              CONFIG_ZSWAP_STORE_THP_DEFAULT_ON
                                                                     is not set
 ------------------------------------------------------------------------------
 ZSWAP compressor        zstd     deflate-                     zstd    deflate-
                                       iaa                                  iaa
 ------------------------------------------------------------------------------
 Throughput (KB/s)    110,775      113,010               111,550        121,937
 sys time (sec)      1,141.72       954.87              1,131.95         828.47
 memcg_high           140,500      153,737               139,772        134,129
 memcg_swap_high            0            0                     0              0
 memcg_swap_fail            0            0                     0              0
 pswpin                     0            0                     0              0
 pswpout                    0            0                     0              0
 zswpin                   675          690                   682            684
 zswpout            9,552,298   10,603,271             9,566,392      9,267,213
 thp_swpout                 0            0                     0              0
 thp_swpout_                0            0                     0              0
  fallback                                                                     
 pgmajfault             3,453        3,468                 3,841          3,487
 ZSWPOUT-64kB-mTHP        n/a          n/a                     0              0
 SWPOUT-64kB-mTHP           0            0                     0              0
 ------------------------------------------------------------------------------
                                                 

Performance Testing:
====================
Testing of this patch-series was done with mm-unstable as of 9-23-2024,
commit acfabf7e197f7a5bedf4749dac1f39551417b049. Data was gathered
without/with this patch-series, on an Intel Sapphire Rapids server,
dual-socket 56 cores per socket, 4 IAA devices per socket, 503 GiB RAM and
823G SSD disk partition swap. Core frequency was fixed at 2500MHz.

The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 40G. The is no swap limit set for the cgroup. Following a
similar methodology as in Ryan Roberts' "Swap-out mTHP without splitting"
series [2], 70 usemem processes were run, each allocating and writing 1G of
memory, and sleeping for 10 sec before exiting:

    usemem --init-time -w -O -s 10 -n 70 1g

The vm/sysfs mTHP stats included with the performance data provide details
on the swapout activity to ZSWAP/swap.

Other kernel configuration parameters:

    ZSWAP Compressors : zstd, deflate-iaa
    ZSWAP Allocator   : zsmalloc
    SWAP page-cluster : 2

In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
IAA "compression verification" is enabled. Hence each IAA compression
will be decompressed internally by the "iaa_crypto" driver, the crc-s
returned by the hardware will be compared and errors reported in case of
mismatches. Thus "deflate-iaa" helps ensure better data integrity as
compared to the software compressors.

Throughput is derived by averaging the individual 70 processes' throughputs
reported by usemem. elapsed/sys times are measured with perf. All data
points per compressor/kernel/mTHP configuration are averaged across 3 runs.

Case 1: Comparing zswap 4K vs. zswap mTHP
=========================================

In this scenario, the "before" is CONFIG_THP_SWAP set to off, that results in
64K/2M (m)THP to be split into 4K folios that get processed by zswap.

The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that results
in 64K/2M (m)THP to not be split, and processed by zswap.

 64KB mTHP (cgroup memory.high set to 40G):
 ==========================================

 -------------------------------------------------------------------------------
                    mm-unstable 9-23-2024              zswap-mTHP     Change wrt
                        CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y       Baseline
                                 Baseline
 -------------------------------------------------------------------------------
 ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
                                      iaa                     iaa            iaa
 -------------------------------------------------------------------------------
 Throughput (KB/s)   143,323      125,485     153,550     129,609    7%       3%
 elapsed time (sec)    24.97        25.42       23.90       25.19    4%       1%
 sys time (sec)       822.72       750.96      757.70      731.13    8%       3%
 memcg_high          132,743      169,825     148,075     192,744
 memcg_swap_fail     639,067      841,553       2,204       2,215
 pswpin                    0            0           0           0
 pswpout                   0            0           0           0
 zswpin                  795          873         760         902
 zswpout          10,011,266   13,195,137  10,010,017  13,193,554
 thp_swpout                0            0           0           0
 thp_swpout_               0            0           0           0
  fallback
 64kB-mthp_          639,065      841,553       2,204       2,215
  swpout_fallback
 pgmajfault            2,861        2,924       3,054       3,259
 ZSWPOUT-64kB            n/a          n/a     623,451     822,268
 SWPOUT-64kB               0            0           0           0
 -------------------------------------------------------------------------------


 2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
 =======================================================

 -------------------------------------------------------------------------------
                    mm-unstable 9-23-2024              zswap-mTHP     Change wrt
                        CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y       Baseline
                                 Baseline
 -------------------------------------------------------------------------------
 ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
                                      iaa                     iaa            iaa
 -------------------------------------------------------------------------------
 Throughput (KB/s)   145,616      139,640     169,404     141,168   16%       1%
 elapsed time (sec)    25.05        23.85       23.02       23.37    8%       2%
 sys time (sec)       790.53       676.34      613.26      677.83   22%    -0.2%
 memcg_high           16,702       25,197      17,374      23,890
 memcg_swap_fail      21,485       27,814         114         144
 pswpin                    0            0           0           0
 pswpout                   0            0           0           0
 zswpin                  793          852         778         922
 zswpout          10,011,709   13,186,882  10,010,893  13,195,600
 thp_swpout                0            0           0           0
 thp_swpout_          21,485       27,814         114         144
  fallback
 2048kB-mthp_            n/a          n/a           0           0
  swpout_fallback
 pgmajfault            2,701        2,822       4,151       5,066
 ZSWPOUT-2048kB          n/a          n/a      19,442      25,615
 SWPOUT-2048kB             0            0           0           0
 -------------------------------------------------------------------------------

We mostly see improvements in throughput, elapsed and sys time for zstd and
deflate-iaa, when comparing before (THP_SWAP=N) vs. after (THP_SWAP=Y).


Case 2: Comparing SSD swap mTHP vs. zswap mTHP
==============================================

In this scenario, CONFIG_THP_SWAP is enabled in "before" and "after"
experiments. The "before" represents zswap rejecting mTHP, and the mTHP
being stored by the 823G SSD swap. The "after" represents data with this
patch-series, that results in 64K/2M (m)THP being processed and stored by
zswap.

 64KB mTHP (cgroup memory.high set to 40G):
 ==========================================

 -------------------------------------------------------------------------------
                    mm-unstable 9-23-2024              zswap-mTHP     Change wrt
                        CONFIG_THP_SWAP=Y       CONFIG_THP_SWAP=Y       Baseline
                                 Baseline
 -------------------------------------------------------------------------------
 ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
                                      iaa                     iaa            iaa
 -------------------------------------------------------------------------------
 Throughput (KB/s)    20,265       20,696     153,550     129,609   658%    526%
 elapsed time (sec)    72.44        70.86       23.90       25.19    67%     64%
 sys time (sec)        77.95        77.99      757.70      731.13  -872%   -837%
 memcg_high          115,811      113,277     148,075     192,744
 memcg_swap_fail       2,386        2,425       2,204       2,215
 pswpin                   16           16           0           0
 pswpout           7,774,235    7,616,069           0           0
 zswpin                  728          749         760         902
 zswpout              38,424       39,022  10,010,017  13,193,554
 thp_swpout                0            0           0           0
 thp_swpout_               0            0           0           0
  fallback	                                                 
 64kB-mthp_            2,386        2,425       2,204       2,215
  swpout_fallback                                                
 pgmajfault            2,757        2,860       3,054       3,259
 ZSWPOUT-64kB            n/a          n/a     623,451     822,268
 SWPOUT-64kB         485,890      476,004           0           0
 -------------------------------------------------------------------------------


 2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
 =======================================================

 -------------------------------------------------------------------------------
                    mm-unstable 9-23-2024              zswap-mTHP     Change wrt
                        CONFIG_THP_SWAP=Y       CONFIG_THP_SWAP=Y       Baseline
                                 Baseline
 -------------------------------------------------------------------------------
 ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
                                      iaa                     iaa            iaa
 -------------------------------------------------------------------------------
 Throughput (KB/s)    24,347       35,971     169,404     141,168    596%   292%
 elapsed time (sec)    63.52        64.59       23.02       23.37     64%    64%
 sys time (sec)        27.91        27.01      613.26      677.83  -2098% -2410%
 memcg_high           13,576       13,467      17,374      23,890
 memcg_swap_fail         162          124         114         144
 pswpin                    0            0           0           0
 pswpout           7,003,307    7,168,853           0           0
 zswpin                  741          722         778         922
 zswpout              84,429       65,315  10,010,893  13,195,600
 thp_swpout           13,678       14,002           0           0
 thp_swpout_             162          124         114         144
  fallback	                                                 
 2048kB-mthp_            n/a          n/a           0           0
  swpout_fallback                                                
 pgmajfault            3,345        2,903       4,151       5,066
 ZSWPOUT-2048kB          n/a          n/a      19,442      25,615
 SWPOUT-2048kB        13,678       14,002           0           0
 -------------------------------------------------------------------------------

We see significant improvements in throughput and elapsed time for zstd and
deflate-iaa, when comparing before (mTHP-SSD) vs. after (mTHP-ZSWAP). The
sys time increases with mTHP-ZSWAP as expected, due to the CPU compression
time vs. asynchronous disk write times, as pointed out by Ying and Yosry.

In the "Before" scenario, when zswap does not store mTHP, only allocations
count towards the cgroup memory limit. However, in the "After" scenario,
with the introduction of zswap_store() mTHP, both, allocations as well as
the zswap compressed pool usage from all 70 processes are counted towards
the memory limit. As a result, we see higher swapout activity in the
"After" data. Hence, more time is spent doing reclaim as the zswap cgroup
charge leads to more frequent memory.high breaches.

Summary:
========
The v7 data presented above comparing zswap-mTHP with a conventional 823G
SSD swap demonstrates good performance improvements with zswap-mTHP. Hence,
it seems reasonable for zswap_store to support (m)THP, so that further
performance improvements can be implemented.

Some of the ideas that have shown promise in our experiments are:

1) IAA compress/decompress batching.
2) Distributing compress jobs across all IAA devices on the socket.

In the experimental setup used in this patchset, we have enabled
IAA compress verification to ensure additional hardware data integrity CRC
checks not currently done by the software compressors. The tests run for
this patchset are also using only 1 IAA device per core, that avails of 2
compress engines on the device. In our experiments with IAA batching, we
distribute compress jobs from all cores to the 8 compress engines available
per socket. We further compress the pages in each mTHP in parallel in the
accelerator. As a result, we improve compress latency and reclaim
throughput.

The following compares the same usemem workload characteristics between:

1) zstd (v7 experiments)
2) deflate-iaa "Fixed mode" (v7 experiments)
3) deflate-iaa with batching
4) deflate-iaa-canned "Canned mode" [3] with batching

vm.page-cluster is set to "2" for all runs.

64K mTHP ZSWAP:
===============

 -------------------------------------------------------------------------------
 ZSWAP            zstd   IAA Fixed   IAA Fixed  IAA Canned     IAA    IAA    IAA
 compressor       (v7)        (v7)  + Batching  + Batching   Batch Canned Canned
                                                               vs.    vs.  Batch
 64K mTHP                                                    Seqtl  Fixed    vs.
                                                                            ZSTD
 ------------------------------------------------------------------------------- 
 Throughput    153,550     129,609     156,215     166,975   21%     7%       9%
     (KB/s)
 elapsed time    23.90       25.19       22.46       21.38   11%     5%      11%
        (sec)
 sys time       757.70      731.13      715.62      648.83    2%     9%      14%
    (sec)
 memcg_high    148,075     192,744     197,548     181,734
 memcg_swap_     2,204       2,215       2,293       2,263
  fail
 pswpin              0           0           0           0 
 pswpout             0           0           0           0 
 zswpin            760         902         774         833
 zswpout    10,010,017  13,193,554  13,193,176  12,125,616
 thp_swpout          0           0           0           0 
 thp_swpout_         0           0           0           0 
  fallback
 64kB-mthp_      2,204       2,215       2,293       2,263
  swpout_
  fallback
 pgmajfault      3,054       3,259       3,545       3,516
 ZSWPOUT-64kB  623,451     822,268     822,176     755,480
 SWPOUT-64kB         0           0           0           0 
 swap_ra           146         161         152         159
 swap_ra_hit        64         121          68          88
 -------------------------------------------------------------------------------
				   

2M THP ZSWAP:
=============

 -------------------------------------------------------------------------------
 ZSWAP            zstd   IAA Fixed   IAA Fixed  IAA Canned     IAA    IAA    IAA
 compressor       (v7)        (v7)  + Batching  + Batching   Batch Canned Canned
                                                               vs.    vs.  Batch
 2M THP                                                      Seqtl  Fixed    vs.
                                                                            ZSTD
 ------------------------------------------------------------------------------- 
 Throughput    169,404     141,168     175,089     193,407     24%    10%    14%
     (KB/s)
 elapsed time    23.02       23.37       21.13       19.97     10%     5%    13%
        (sec)
 sys time       613.26      677.83      630.51      533.80      7%    15%    13%
    (sec)
 memcg_high     17,374      23,890      24,349      22,374
 memcg_swap_       114         144         102          88
  fail
 pswpin              0           0           0           0
 pswpout             0           0           0           0
 zswpin            778         922       6,492       6,642
 zswpout    10,010,893  13,195,600  13,199,907  12,132,265
 thp_swpout          0           0           0           0
 thp_swpout_       114         144         102          88
  fallback
 pgmajfault      4,151       5,066       5,032       4,999
 ZSWPOUT-2MB    19,442      25,615      25,666      23,594
 SWPOUT-2MB          0           0           0           0
 swap_ra             3           9       4,383       4,494
 swap_ra_hit         2           6       4,298       4,412
 -------------------------------------------------------------------------------


With ZSWAP IAA compress/decompress batching, we are able to demonstrate
significant performance improvements and memory savings in scalability
experiments under memory pressure, as compared to software compressors. We
hope to submit this work in subsequent patch series.

Thanks,
Kanchana

[1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/
[3] https://patchwork.kernel.org/project/linux-crypto/cover/cover.1710969449.git.andre.glover@linux.intel.com/


Kanchana P Sridhar (8):
  mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
  mm: zswap: Modify zswap_compress() to accept a page instead of a
    folio.
  mm: zswap: Refactor code to store an entry in zswap xarray.
  mm: zswap: Refactor code to delete stored offsets in case of errors.
  mm: zswap: Compress and store a specific page in a folio.
  mm: zswap: Support mTHP swapout in zswap_store().
  mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP zswpout
    stats.
  mm: Document the newly added mTHP zswpout stats, clarify swpout
    semantics.

 Documentation/admin-guide/mm/transhuge.rst |   8 +-
 include/linux/huge_mm.h                    |   1 +
 include/linux/memcontrol.h                 |   4 +
 mm/Kconfig                                 |   8 +
 mm/huge_memory.c                           |   3 +
 mm/page_io.c                               |   1 +
 mm/zswap.c                                 | 248 ++++++++++++++++-----
 7 files changed, 210 insertions(+), 63 deletions(-)


base-commit: acfabf7e197f7a5bedf4749dac1f39551417b049
-- 
2.27.0


