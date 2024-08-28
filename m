Return-Path: <linux-kernel+bounces-304687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBD96238F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D01C23F38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8F16BE3A;
	Wed, 28 Aug 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0/TsXjW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868716B3AB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837723; cv=none; b=li+9YKYKGet8mLaaydPr8mpPmwk1C4L79lQ/saXZM4cmAbrehNFVJqP4u5zG1WtSKrD/wyjSpDu+G4GZw875fv/+t9Cn4XeoMeHN/jAw5A34i0o+cFxQhDSKF5UkS8oI1ETQpVfxHoQ8sXhDg1W4CGGNwSHDubGSblORuzEOqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837723; c=relaxed/simple;
	bh=NiF62iqrn+9n4WBSVLYPTR6s9rULH31+2PcD1JYr8j0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+gOLd3CStgZ8JojmCsCisWi29PKrsRC+/Yj860pseq+JqkM3ciHSKzUYBrxuKZ8YJIGXRxxbTU3BwdJIrhHBSBJ/eWbY5rhLXd/n52/kt+j7rlmS23f+M1kuOUbeNs9sBvhkq3A4bm82hNcXAkcy4HIa+Zg0qBvUGPkfpt1PnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0/TsXjW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837721; x=1756373721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NiF62iqrn+9n4WBSVLYPTR6s9rULH31+2PcD1JYr8j0=;
  b=J0/TsXjWpc1RtUU7f8lKrYCseMI9Q4IvV42dKoJ/MtQYokaGOJrI7AFk
   uk9uDzJIzsQG9FdnmnqyQd/v7jbSQBy3WhY96tzCZ/w6wwIrXm5QfJsJV
   ioUTPo3qqqZ1ghW9T+YlCErt4Y2LHsBU8t0VmapFfMxKgOPa3DOZ4vdSr
   +L/LCdYZ6fPHlNef+TpDbcnWZWTiLQrxsWU8Cv0IpDleHhFnuaHq+Ypg4
   4jTb1HpoXrMEo/YW+Ff1qi11CMbmzuZhulBnOv7rVd++SHDVA9XLxHUvo
   JGTlX8dI0hfIswEYt8vgvm1kwwLTvXBd/NXXRDRPvDK/0b1OWX1cCXDAK
   Q==;
X-CSE-ConnectionGUID: JexJT43iTOKXp5um13htFQ==
X-CSE-MsgGUID: os6wI5WbRSmPxm5cV8MzmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34763861"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34763861"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:16 -0700
X-CSE-ConnectionGUID: qGeCW/dXRRi/EhNod2q4Yw==
X-CSE-MsgGUID: +12GoNPsS9aMVov/G3DhiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="100678968"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2024 02:35:16 -0700
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
Subject: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Date: Wed, 28 Aug 2024 02:35:13 -0700
Message-Id: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
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
mTHPs. For instance, the function zswap_store_entry() stores a zswap_entry
in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
delete all offsets corresponding to a higher order folio stored in zswap.

For accounting purposes, the patch-series adds per-order mTHP sysfs
"zswpout" counters that get incremented upon successful zswap_store of
an mTHP folio:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

This patch-series is a precursor to ZSWAP compress batching of mTHP
swap-out and decompress batching of swap-ins based on swapin_readahead(),
using Intel IAA hardware acceleration, which we would like to submit in
subsequent RFC patch-series, with performance improvement data.

Thanks to Ying Huang for pre-posting review feedback and suggestions!

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

Performance Testing:
====================
Testing of this patch-series was done with the v6.11-rc3 mainline, without
and with this patch-series, on an Intel Sapphire Rapids server,
dual-socket 56 cores per socket, 4 IAA devices per socket.

The system has 503 GiB RAM, with 176GiB ZRAM (35% of available RAM) as the
backing swap device for ZSWAP. zstd is configured as the ZRAM compressor.
Core frequency was fixed at 2500MHz.

The vm-scalability "usemem" test was run in a cgroup whose memory.high
was fixed at 40G. The is no swap limit set for the cgroup. Following a
similar methodology as in Ryan Roberts' "Swap-out mTHP without splitting"
series [2], 70 usemem processes were run, each allocating and writing 1G of
memory:

    usemem --init-time -w -O -n 70 1g

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
reported by usemem. sys time is measured with perf. All data points are
averaged across 3 runs.

 64KB mTHP (cgroup memory.high set to 40G):
 ==========================================

 ------------------------------------------------------------------------------
                     v6.11-rc3 mainline              zswap-mTHP      Change wrt
                               Baseline                                Baseline
 ------------------------------------------------------------------------------
 ZSWAP compressor       zstd   deflate-        zstd    deflate-   zstd deflate-
                                    iaa                     iaa             iaa
 ------------------------------------------------------------------------------
 Throughput (KB/s)   161,496    156,343     140,363     151,938   -13%      -3%
 sys time (sec)       771.68     802.08      954.85      735.47   -24%       8%
 memcg_high          111,223    110,889     138,651     133,884
 memcg_swap_high           0          0           0           0
 memcg_swap_fail           0          0           0           0
 pswpin                   16         16           0           0
 pswpout           7,471,472  7,527,963           0           0
 zswpin                  635        605         624         639
 zswpout               1,509      1,478   9,453,761   9,385,910
 thp_swpout                0          0           0           0
 thp_swpout_               0          0           0           0
  fallback
 pgmajfault            3,616      3,430       4,633       3,611
 ZSWPOUT-64kB            n/a        n/a     590,768     586,521
 SWPOUT-64kB         466,967    470,498           0           0
 ------------------------------------------------------------------------------

 2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
 =======================================================

 ------------------------------------------------------------------------------
                      v6.11-rc3 mainline              zswap-mTHP     Change wrt
                                Baseline                               Baseline
 ------------------------------------------------------------------------------
 ZSWAP compressor       zstd    deflate-        zstd    deflate-  zstd deflate-
                                     iaa                     iaa            iaa
 ------------------------------------------------------------------------------
 Throughput (KB/s)    192,164    194,643     165,005     174,536  -14%     -10%
 sys time (sec)        823.55     830.42      801.72      676.65    3%      19%
 memcg_high            16,054     15,936      14,951      16,096
 memcg_swap_high            0          0           0           0
 memcg_swap_fail            0          0           0           0
 pswpin                     0          0           0           0
 pswpout            8,629,248  8,628,907           0           0
 zswpin                   560        645       5,333         781
 zswpout                1,416      1,503   8,546,895   9,355,760
 thp_swpout            16,854     16,853           0           0
 thp_swpout_                0          0           0           0
  fallback
 pgmajfault             3,341      3,574       8,139       3,582
 ZSWPOUT-2048kB           n/a        n/a      16,684      18,270
 SWPOUT-2048kB         16,854     16,853           0           0
 ------------------------------------------------------------------------------

In the "Before" scenario, when zswap does not store mTHP, only allocations
count towards the cgroup memory limit. However, in the "After" scenario,
with the introduction of zswap_store() mTHP, both, allocations as well as
the zswap compressed pool usage from all 70 processes are counted towards
the memory limit. As a result, we see higher swapout activity in the
"After" data. Hence, more time is spent doing reclaim as the zswap cgroup
charge leads to more frequent memory.high breaches.

This causes degradation in throughput and sys time with zswap mTHP, more so
in case of zstd than deflate-iaa. Compress latency could play a part in
this - when there is more swapout activity happening, a slower compressor
would cause allocations to stall for any/all of the 70 processes.

In my opinion, even though the test set up does not provide an accurate
way for a direct before/after comparison (because of zswap usage being
counted in cgroup, hence towards the memory.high), it still seems
reasonable for zswap_store to support (m)THP, so that further performance
improvements can be implemented.

One of the ideas that has shown promise in our experiments is to improve
ZSWAP mTHP store performance using batching. With IAA compress/decompress
batching used in ZSWAP, we are able to demonstrate significant
performance improvements and memory savings with IAA in scalability
experiments, as compared to software compressors. We hope to submit
this work as subsequent RFCs.

I would greatly appreciate your code review comments and suggestions!

Thanks,
Kanchana

[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/


Kanchana P Sridhar (3):
  mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
  mm: zswap: zswap_store() extended to handle mTHP folios.
  mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP zswpout
    stats.

 include/linux/huge_mm.h    |   1 +
 include/linux/memcontrol.h |   4 +
 mm/huge_memory.c           |   3 +
 mm/page_io.c               |   3 +-
 mm/zswap.c                 | 231 +++++++++++++++++++++++++++----------
 5 files changed, 180 insertions(+), 62 deletions(-)


base-commit: b659edec079c90012cf8d05624e312d1062b8b87
-- 
2.27.0


