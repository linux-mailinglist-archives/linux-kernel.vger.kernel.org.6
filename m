Return-Path: <linux-kernel+bounces-285941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F2951483
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBEBDB21D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAB13AA20;
	Wed, 14 Aug 2024 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0k/GgGT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0C7D401
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616917; cv=none; b=M3RSyANgAq6Lwryi9HiX6kc7xSCTxCDabGkiygsZ4ma5M1VgM3u5RmxTVAw5HlIOxpNARgtAjgJZyJdMllW89/0UPDyIT4BJTwnY9/zmWYyhReqo5kgGaYPkFTMyOKzdzhxmFtRsLxLlKcAeZG/Y9XQv3MtcBC8FZc/6I5ymkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616917; c=relaxed/simple;
	bh=zeIHT1v0vvZei3h9UO8HLpf7B6l7GDDoXoIp3RPT/1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXKHbW9+T9cpl770/Ng/24DpdsC0bhY0Ye5SCncahnNOeESgWpdK6piF1b4/biqFKjlxhw2ul4he6WFBMEUpHsbnF2Gq2bTucjTsQquufjtogSb5PzjXUEem9+BIZPKXwENAP1KAmxNigMXFr9oZFYLIVKvew652B7KlAfMHQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0k/GgGT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723616916; x=1755152916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zeIHT1v0vvZei3h9UO8HLpf7B6l7GDDoXoIp3RPT/1c=;
  b=I0k/GgGTjO5BEO6U+3xPXuYUMptQdBezkXOvmLrd1gQnGHuVqdtV4z9S
   wZpJI4wTpHcfJkyrypG7uDoI7S1BJ+BPZsyJ2FLub6VUSciLVYFyABhVG
   uXXAu1J0A1lz6a183tE0ok34estDYy4+588UiylVncaCpUM9hOrGuiKU4
   GfHwS3IDPtzxbVAyCHrkNSFap3fhLfYlLoL17tJVFrjmrNw4el6LZGp5y
   fdI9XLvXUpYR5U/PewHctP6mk487jQvrVCZwh5MiL3is0hEeWnmWzqAm9
   ZH9pnfTOttQGeNvZyFr0wDNodSqu1t6rJP7s6/PAUawwkDpqu/OzdN0fn
   w==;
X-CSE-ConnectionGUID: 2hoq/RAHQcerz6aZDDPN/w==
X-CSE-MsgGUID: Aha128rRQkWYWxt43rmc4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44332989"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="44332989"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:28:32 -0700
X-CSE-ConnectionGUID: TfxPtTF9RICevaroIFKQDQ==
X-CSE-MsgGUID: a5V/pDQOSNaduiZnBMkimA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63568744"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2024 23:28:32 -0700
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
Subject: [RFC PATCH v1 0/4] mm: ZSWAP swap-out of mTHP folios
Date: Tue, 13 Aug 2024 23:28:26 -0700
Message-Id: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch-series enables zswap_store() to accept and store mTHP
folios. The most significant contribution in this series is from the 
earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
migrated to v6.10 in patch [3] of this series.

[1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
     https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

Additionally, there is an attempt to modularize some of the functionality
in zswap_store(), to make it more amenable to supporting any-order
mTHPs.

For instance, the determination of whether a folio is same-filled is
based on mapping an index into the folio to derive the page. Likewise,
there is a function "zswap_store_entry" added to store a zswap_entry in
the xarray.

For testing purposes, per-mTHP size vmstat zswap_store event counters are
added, and incremented upon successful zswap_store of an mTHP.

This patch-series is a precursor to ZSWAP compress batching of mTHP
swap-out and decompress batching of swap-ins based on swapin_readahead(),
using Intel IAA hardware acceleration, which we would like to submit in
subsequent RFC patch-series, with performance improvement data.

Performance Testing:
====================
Testing of this patch-series was done with the v6.10 mainline, without
and with this RFC, on an Intel Sapphire Rapids server, dual-socket 56
cores per socket, 4 IAA devices per socket.

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

Throughput reported by usemem and perf sys time for running the test were
measured and averaged across 3 runs:

 64KB mTHP:
 ==========
  ----------------------------------------------------------
 |                |               |            |            |
 |Kernel          | mTHP SWAP-OUT | Throughput | Improvement|
 |                |               |       KB/s |            |
 |----------------|---------------|------------|------------|
 |v6.10 mainline  | ZRAM lzo-rle  |    111,180 |   Baseline |
 |zswap-mTHP-RFC  | ZSWAP lz4     |    115,996 |         4% |
 |zswap-mTHP-RFC  | ZSWAP         |            |            |
 |                | deflate-iaa   |    166,048 |        49% |
 |----------------------------------------------------------|
 |                |               |            |            |
 |Kernel          | mTHP SWAP-OUT |   Sys time | Improvement|
 |                |               |        sec |            |
 |----------------|---------------|------------|------------|
 |v6.10 mainline  | ZRAM lzo-rle  |   1,049.69 |   Baseline |
 |zswap-mTHP RFC  | ZSWAP lz4     |   1,178.20 |       -12% |
 |zswap-mTHP-RFC  | ZSWAP         |            |            |
 |                | deflate-iaa   |     626.12 |        40% |
  ----------------------------------------------------------

  -------------------------------------------------------
 | VMSTATS, mTHP ZSWAP stats, |      v6.10 |  zswap-mTHP |
 | mTHP ZRAM stats:           |   mainline |         RFC |
 |-------------------------------------------------------|
 | pswpin                     |         16 |           0 |
 | pswpout                    |  7,823,984 |           0 |
 | zswpin                     |        551 |         647 |
 | zswpout                    |      1,410 |  15,175,113 |
 |-------------------------------------------------------|
 | thp_swpout                 |          0 |           0 |
 | thp_swpout_fallback        |          0 |           0 |
 | pgmajfault                 |      2,189 |       2,241 |
 |-------------------------------------------------------|
 | zswpout_4kb_folio          |            |       1,497 |
 | mthp_zswpout_64kb          |            |     948,351 |
 |-------------------------------------------------------|
 | hugepages-64kB/stats/swpout|    488,999 |           0 |
  -------------------------------------------------------


 2MB PMD-THP/2048K mTHP:
 =======================
  ----------------------------------------------------------
 |                |               |            |            |
 |Kernel          | mTHP SWAP-OUT | Throughput | Improvement|
 |                |               |       KB/s |            |
 |----------------|---------------|------------|------------|
 |v6.10 mainline  | ZRAM lzo-rle  |    136,617 |   Baseline |
 |zswap-mTHP-RFC  | ZSWAP lz4     |    137,360 |         1% |
 |zswap-mTHP-RFC  | ZSWAP         |            |            |
 |                | deflate-iaa   |    179,097 |        31% |
 |----------------------------------------------------------|
 |                |               |            |            |
 |Kernel          | mTHP SWAP-OUT |   Sys time | Improvement|
 |                |               |        sec |            |
 |----------------|---------------|------------|------------|
 |v6.10 mainline  | ZRAM lzo-rle  |   1,044.40 |   Baseline |
 |zswap-mTHP RFC  | ZSWAP lz4     |   1,035.79 |         1% |
 |zswap-mTHP-RFC  | ZSWAP         |            |            |
 |                | deflate-iaa   |     571.31 |        45% |
  ----------------------------------------------------------

  ---------------------------------------------------------
 | VMSTATS, mTHP ZSWAP stats,   |      v6.10 |  zswap-mTHP |
 | mTHP ZRAM stats:             |   mainline |         RFC |
 |---------------------------------------------------------|
 | pswpin                       |          0 |           0 |
 | pswpout                      |  8,630,272 |           0 |
 | zswpin                       |        565 |       6,901 |
 | zswpout                      |      1,388 |  15,379,163 |
 |---------------------------------------------------------|
 | thp_swpout                   |     16,856 |           0 |
 | thp_swpout_fallback          |          0 |           0 |
 | pgmajfault                   |      2,184 |       8,532 |
 |---------------------------------------------------------|
 | zswpout_4kb_folio            |            |       5,851 |
 | mthp_zswpout_2048kb          |            |      30,026 |
 | zswpout_pmd_thp_folio        |            |      30,026 |
 |---------------------------------------------------------|
 | hugepages-2048kB/stats/swpout|     16,856 |           0 |
  ---------------------------------------------------------

As expected in the "Before" experiment, there are relatively fewer
swapouts, because ZRAM utilization is not accounted in the cgroup.

With the introduction of zswap_store mTHP, the "After" data reflects the
higher swapout activity, and consequent sys time degradation.

Our goal is to improve ZSWAP mTHP store performance using batching. With
Intel IAA compress/decompress batching used in ZSWAP (to be submitted as
additional RFC series), we are able to demonstrate significant
performance improvements with IAA as compared to software compressors.

For instance, with IAA-Canned compression [3] used with batching of
zswap_stores and of zswap_loads, the usemem experiment's average of 3
runs throughput improves to 170,461 KB/s (64KB mTHP) and 188,325 KB/s
(2MB THP).

[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/
[3] https://patchwork.kernel.org/project/linux-crypto/cover/cover.1710969449.git.andre.glover@linux.intel.com/

Kanchana P Sridhar (4):
  mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
  mm: vmstat: Per mTHP-size zswap_store vmstat event counters.
  mm: zswap: zswap_store() extended to handle mTHP folios.
  mm: page_io: Count successful mTHP zswap stores in vmstat.

 include/linux/vm_event_item.h |  15 +++
 mm/page_io.c                  |  44 +++++++
 mm/vmstat.c                   |  15 +++
 mm/zswap.c                    | 223 ++++++++++++++++++++++++----------
 4 files changed, 233 insertions(+), 64 deletions(-)

-- 
2.27.0


