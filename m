Return-Path: <linux-kernel+bounces-268628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44995942720
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F372D283E11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A81A4B38;
	Wed, 31 Jul 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhwaXpfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D749282F0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408561; cv=none; b=Z6Me4w5mORgP0xHvkMi8vrQ8c/hOkU6ZIdKLnFK7PQJdP62nWXwHXU+uBjBgUKX1nLmzWJ2Xw5VcimRD0q3LVMpH4eEcchQ+1lE5GijZBmp15ii4jG1njw01Gp1LoRdej+UvhxX8xotyQDd+7aIATtRJSKQ9TfRDYLUXsJpNe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408561; c=relaxed/simple;
	bh=lomILYpvPKm/NS0cDcgC+VgOu47pIcIw0Zfb9DiRd4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LiujKczBr2ua2aLEO85x/C6xDOrC4BgYO3MCkjsyNipZsTPT2PkE26NtJRQ2xx2ypSozVWwBDGwvRaPUAIeUNyZT5GJaZbFvy9alEmGWtkaHfUIFw7vE3nYpEAbOosHnLSHz36jxw++oYIKKy5jBuTXtqcx78tC3nIv/5uJn0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhwaXpfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EFDC116B1;
	Wed, 31 Jul 2024 06:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408560;
	bh=lomILYpvPKm/NS0cDcgC+VgOu47pIcIw0Zfb9DiRd4M=;
	h=From:Subject:Date:To:Cc:From;
	b=DhwaXpfL3QtP8RxnqVuk/olvugDtbGOsQLE9Ve8u6zmn+DI1VZxOAgHseFnZuLyQy
	 Pa1CC610wgWlfggmRJWf8QmYrRqVX4u8J+tHYvA6yrzQ8rYEJrIHwNnJ0gq5uHbIgs
	 th59NxNjrxpbkfGjAkbcjHbSqCjgGwoFqAWrisGTkOAwOSP/q41j2ElJXV9D8+FiMF
	 bulkzFIf9ExYjrIWE++A1+vZGsP+N7q8BIeHh8T6Y+ITIQlwuw5hYTUtNLnmiTyA27
	 1DrR+/azUxeh6h5vtsRT1Lb/RUOJmzGpDdeIHSkxwwtGgaesIRK9ovAoJY0RUnyNtH
	 O1WH/eukAn4Aw==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster
 order
Date: Tue, 30 Jul 2024 23:49:12 -0700
Message-Id: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGjeqWYC/2XMwU7DMAzG8VeZciYodpxm5cR7IA5u5m4RVTslq
 ICmvjveJDQgx8/y738xVUqWap52F1NkzTUvs47wsDPpxPNRbD7oNuiQXEBv6wefLU/Tkvh9KRa
 Cp0R7J0nIKDoXGfPnLfjyqvuUq7593forXK8/KfqfWsE6S3HfwUDoB+ye36TMMj0u5WiurRXvv
 oPWo3rkAH4gjiOOjfe/fd94r1766NmDvhA1nu4+AjSe1DvsA9OBUmT+47dt+wZdePL9bQEAAA=
 =
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

This is the short term solutions "swap cluster order" listed
in my "Swap Abstraction" discussion slice 8 in the recent
LSF/MM conference.

When commit 845982eb264bc "mm: swap: allow storage of all mTHP
orders" is introduced, it only allocates the mTHP swap entries
from the new empty cluster list.  It has a fragmentation issue
reported by Barry.

https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/

The reason is that all the empty clusters have been exhausted while
there are plenty of free swap entries in the cluster that are
not 100% free.

Remember the swap allocation order in the cluster.
Keep track of the per order non full cluster list for later allocation.

This series gives the swap SSD allocation a new separate code path
from the HDD allocation. The new allocator use cluster list only
and do not global scan swap_map[] without lock any more.

This streamline the swap allocation for SSD. The code matches the
execution flow much better.

User impact: For users that allocate and free mix order mTHP swapping,
It greatly improves the success rate of the mTHP swap allocation after the
initial phase.

It also performs faster when the swapfile is close to full, because the
allocator can get the non full cluster from a list rather than scanning
a lot of swap_map entries. 

With Barry's mthp test program V2:

Without:
$ ./thp_swap_allocator_test -a
Iteration 1: swpout inc: 32, swpout fallback inc: 192, Fallback percentage: 85.71%
Iteration 2: swpout inc: 0, swpout fallback inc: 231, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 227, Fallback percentage: 100.00%
...
Iteration 98: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 215, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%

$ ./thp_swap_allocator_test -a -s
Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
..
Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%

$ ./thp_swap_allocator_test -s
Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
..
Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%

$ ./thp_swap_allocator_test
Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
..
Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%

With: # with all 0.00% filter out
$ ./thp_swap_allocator_test -a | grep -v "0.00%"
$ # all result are 0.00%

$ ./thp_swap_allocator_test -a -s | grep -v "0.00%"
./thp_swap_allocator_test -a -s | grep -v "0.00%" 
Iteration 14: swpout inc: 223, swpout fallback inc: 3, Fallback percentage: 1.33%
Iteration 19: swpout inc: 219, swpout fallback inc: 7, Fallback percentage: 3.10%
Iteration 28: swpout inc: 225, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 29: swpout inc: 227, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 34: swpout inc: 220, swpout fallback inc: 8, Fallback percentage: 3.51%
Iteration 35: swpout inc: 222, swpout fallback inc: 11, Fallback percentage: 4.72%
Iteration 38: swpout inc: 217, swpout fallback inc: 4, Fallback percentage: 1.81%
Iteration 40: swpout inc: 222, swpout fallback inc: 6, Fallback percentage: 2.63%
Iteration 42: swpout inc: 221, swpout fallback inc: 2, Fallback percentage: 0.90%
Iteration 43: swpout inc: 215, swpout fallback inc: 7, Fallback percentage: 3.15%
Iteration 47: swpout inc: 226, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 49: swpout inc: 217, swpout fallback inc: 1, Fallback percentage: 0.46%
Iteration 52: swpout inc: 221, swpout fallback inc: 8, Fallback percentage: 3.49%
Iteration 56: swpout inc: 224, swpout fallback inc: 4, Fallback percentage: 1.75%
Iteration 58: swpout inc: 214, swpout fallback inc: 5, Fallback percentage: 2.28%
Iteration 62: swpout inc: 220, swpout fallback inc: 3, Fallback percentage: 1.35%
Iteration 64: swpout inc: 224, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 67: swpout inc: 221, swpout fallback inc: 1, Fallback percentage: 0.45%
Iteration 75: swpout inc: 220, swpout fallback inc: 9, Fallback percentage: 3.93%
Iteration 82: swpout inc: 227, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 86: swpout inc: 211, swpout fallback inc: 12, Fallback percentage: 5.38%
Iteration 89: swpout inc: 226, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 93: swpout inc: 220, swpout fallback inc: 1, Fallback percentage: 0.45%
Iteration 94: swpout inc: 224, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 96: swpout inc: 221, swpout fallback inc: 6, Fallback percentage: 2.64%
Iteration 98: swpout inc: 227, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 99: swpout inc: 227, swpout fallback inc: 3, Fallback percentage: 1.30%

$ ./thp_swap_allocator_test      
./thp_swap_allocator_test 
Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 131, swpout fallback inc: 101, Fallback percentage: 43.53%
Iteration 3: swpout inc: 71, swpout fallback inc: 155, Fallback percentage: 68.58%
Iteration 4: swpout inc: 55, swpout fallback inc: 168, Fallback percentage: 75.34%
Iteration 5: swpout inc: 35, swpout fallback inc: 191, Fallback percentage: 84.51%
Iteration 6: swpout inc: 25, swpout fallback inc: 199, Fallback percentage: 88.84%
Iteration 7: swpout inc: 23, swpout fallback inc: 205, Fallback percentage: 89.91%
Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percentage: 96.05%
Iteration 9: swpout inc: 13, swpout fallback inc: 213, Fallback percentage: 94.25%
Iteration 10: swpout inc: 12, swpout fallback inc: 216, Fallback percentage: 94.74%
Iteration 11: swpout inc: 16, swpout fallback inc: 213, Fallback percentage: 93.01%
Iteration 12: swpout inc: 10, swpout fallback inc: 210, Fallback percentage: 95.45%
Iteration 13: swpout inc: 16, swpout fallback inc: 212, Fallback percentage: 92.98%
Iteration 14: swpout inc: 12, swpout fallback inc: 212, Fallback percentage: 94.64%
Iteration 15: swpout inc: 15, swpout fallback inc: 211, Fallback percentage: 93.36%
Iteration 16: swpout inc: 15, swpout fallback inc: 200, Fallback percentage: 93.02%
Iteration 17: swpout inc: 9, swpout fallback inc: 220, Fallback percentage: 96.07%

$ ./thp_swap_allocator_test -s
 ./thp_swap_allocator_test -s
Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 97, swpout fallback inc: 135, Fallback percentage: 58.19%
Iteration 3: swpout inc: 42, swpout fallback inc: 192, Fallback percentage: 82.05%
Iteration 4: swpout inc: 19, swpout fallback inc: 214, Fallback percentage: 91.85%
Iteration 5: swpout inc: 12, swpout fallback inc: 213, Fallback percentage: 94.67%
Iteration 6: swpout inc: 11, swpout fallback inc: 217, Fallback percentage: 95.18%
Iteration 7: swpout inc: 9, swpout fallback inc: 214, Fallback percentage: 95.96%
Iteration 8: swpout inc: 8, swpout fallback inc: 213, Fallback percentage: 96.38%
Iteration 9: swpout inc: 2, swpout fallback inc: 223, Fallback percentage: 99.11%
Iteration 10: swpout inc: 2, swpout fallback inc: 228, Fallback percentage: 99.13%
Iteration 11: swpout inc: 4, swpout fallback inc: 214, Fallback percentage: 98.17%
Iteration 12: swpout inc: 5, swpout fallback inc: 226, Fallback percentage: 97.84%
Iteration 13: swpout inc: 3, swpout fallback inc: 212, Fallback percentage: 98.60%
Iteration 14: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
Iteration 15: swpout inc: 3, swpout fallback inc: 222, Fallback percentage: 98.67%
Iteration 16: swpout inc: 4, swpout fallback inc: 223, Fallback percentage: 98.24%

=========
Kernel compile under tmpfs with cgroup memory.max = 470M.
12 core 24 hyperthreading, 32 jobs. 10 Run each group

SSD swap 10 runs average, 20G swap partition:
With:
user    2929.064
system  1479.381 : 1376.89 1398.22 1444.64 1477.39 1479.04 1497.27
1504.47 1531.4 1532.92 1551.57
real    1441.324

Without:
user    2910.872
system  1482.732 : 1440.01 1451.4 1462.01 1467.47 1467.51 1469.3
1470.19 1496.32 1544.1 1559.01
real    1580.822

Two zram swap: zram0 3.0G zram1 20G.

The idea is forcing the zram0 almost full then overflow to zram1:

With:
user    4320.301
system  4272.403 : 4236.24 4262.81 4264.75 4269.13 4269.44 4273.06
4279.85 4285.98 4289.64 4293.13
real    431.759

Without
user    4301.393
system  4387.672 : 4374.47 4378.3 4380.95 4382.84 4383.06 4388.05
4389.76 4397.16 4398.23 4403.9
real    433.979

------ more test result from Kaiui ----------

Test with build linux kernel using a 4G ZRAM, 1G memory.max limit on top of shmem:

System info: 32 Core AMD Zen2, 64G total memory.

Test 3 times using only 4K pages:
=================================

With:
-----
1838.74user 2411.21system 2:37.86elapsed 2692%CPU (0avgtext+0avgdata 847060maxresident)k
1839.86user 2465.77system 2:39.35elapsed 2701%CPU (0avgtext+0avgdata 847060maxresident)k
1840.26user 2454.68system 2:39.43elapsed 2693%CPU (0avgtext+0avgdata 847060maxresident)k

Summary (~4.6% improment of system time):
User: 1839.62
System: 2443.89: 2465.77 2454.68 2411.21
Real: 158.88

Without:
--------
1837.99user 2575.95system 2:43.09elapsed 2706%CPU (0avgtext+0avgdata 846520maxresident)k
1838.32user 2555.15system 2:42.52elapsed 2709%CPU (0avgtext+0avgdata 846520maxresident)k
1843.02user 2561.55system 2:43.35elapsed 2702%CPU (0avgtext+0avgdata 846520maxresident)k

Summary:
User: 1839.78
System: 2564.22: 2575.95 2555.15 2561.55
Real: 162.99

Test 5 times using enabled all mTHP pages:
==========================================

With:
-----
1796.44user 2937.33system 2:59.09elapsed 2643%CPU (0avgtext+0avgdata 846936maxresident)k
1802.55user 3002.32system 2:54.68elapsed 2750%CPU (0avgtext+0avgdata 847072maxresident)k
1806.59user 2986.53system 2:55.17elapsed 2736%CPU (0avgtext+0avgdata 847092maxresident)k
1803.27user 2982.40system 2:54.49elapsed 2742%CPU (0avgtext+0avgdata 846796maxresident)k
1807.43user 3036.08system 2:56.06elapsed 2751%CPU (0avgtext+0avgdata 846488maxresident)k

Summary (~8.4% improvement of system time):
User: 1803.25
System: 2988.93: 2937.33 3002.32 2986.53 2982.40 3036.08
Real: 175.90

mTHP swapout status:
/sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout:347721
/sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout_fallback:3110
/sys/kernel/mm/transparent_hugepage/hugepages-512kB/stats/swpout:3365
/sys/kernel/mm/transparent_hugepage/hugepages-512kB/stats/swpout_fallback:8269
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/swpout:24
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/swpout_fallback:3341
/sys/kernel/mm/transparent_hugepage/hugepages-1024kB/stats/swpout:145
/sys/kernel/mm/transparent_hugepage/hugepages-1024kB/stats/swpout_fallback:5038
/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout:322737
/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback:36808
/sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout:380455
/sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout_fallback:1010
/sys/kernel/mm/transparent_hugepage/hugepages-256kB/stats/swpout:24973
/sys/kernel/mm/transparent_hugepage/hugepages-256kB/stats/swpout_fallback:13223
/sys/kernel/mm/transparent_hugepage/hugepages-128kB/stats/swpout:197348
/sys/kernel/mm/transparent_hugepage/hugepages-128kB/stats/swpout_fallback:80541

Without:
--------
1794.41user 3151.29system 3:05.97elapsed 2659%CPU (0avgtext+0avgdata 846704maxresident)k
1810.27user 3304.48system 3:05.38elapsed 2759%CPU (0avgtext+0avgdata 846636maxresident)k
1809.84user 3254.85system 3:03.83elapsed 2755%CPU (0avgtext+0avgdata 846952maxresident)k
1813.54user 3259.56system 3:04.28elapsed 2752%CPU (0avgtext+0avgdata 846848maxresident)k
1829.97user 3338.40system 3:07.32elapsed 2759%CPU (0avgtext+0avgdata 847024maxresident)k

Summary:
User: 1811.61
System: 3261.72 : 3151.29 3304.48 3254.85 3259.56 3338.40
Real: 185.356

mTHP swapout status:
hugepages-32kB/stats/swpout:35630
hugepages-32kB/stats/swpout_fallback:1809908
hugepages-512kB/stats/swpout:523
hugepages-512kB/stats/swpout_fallback:55235
hugepages-2048kB/stats/swpout:53
hugepages-2048kB/stats/swpout_fallback:17264
hugepages-1024kB/stats/swpout:85
hugepages-1024kB/stats/swpout_fallback:24979
hugepages-64kB/stats/swpout:30117
hugepages-64kB/stats/swpout_fallback:1825399
hugepages-16kB/stats/swpout:42775
hugepages-16kB/stats/swpout_fallback:1951123
hugepages-256kB/stats/swpout:2326
hugepages-256kB/stats/swpout_fallback:170165
hugepages-128kB/stats/swpout:17925
hugepages-128kB/stats/swpout_fallback:1309757

Reported-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v5:
- Suggestion and fix up from v4 discussion thread from Yinm and Ryan.
- Adding Kairui's swap cache reclaim patches on top of patch 3.
- Link to v4: https://lore.kernel.org/r/20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org

Changes in v4:
- Remove a warning in patch 2.
- Allocating from the free cluster list before the nonfull list. Revert the v3 behavior.
- Add cluster_index and cluster_offset function.
- Patch 3 has a new allocating path for SSD.
- HDD swap allocation does not need to consider clusters any more.

Changes in v3:
- Using V1 as base.
- Rename "next" to "list" for the list field, suggested by Ying.
- Update comment for the locking rules for cluster fields and list,
  suggested by Ying.
- Allocate from the nonfull list before attempting free list, suggested
  by Kairui.
- Link to v2: https://lore.kernel.org/r/20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org

Changes in v2:
- Abandoned.
- Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org

---
Chris Li (3):
      mm: swap: swap cluster switch to double link list
      mm: swap: mTHP allocate swap entries from nonfull list
      mm: swap: separate SSD allocation from scan_swap_map_slots()

Kairui Song (6):
      mm: swap: clean up initialization helper
      mm: swap: skip slot cache on freeing for mTHP
      mm: swap: allow cache reclaim to skip slot cache
      mm: swap: add a fragment cluster list
      mm: swap: relaim the cached parts that got scanned
      mm: swap: add a adaptive full cluster cache reclaim

 include/linux/swap.h |  34 ++-
 mm/swapfile.c        | 840 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 514 insertions(+), 360 deletions(-)
---
base-commit: ff3a648ecb9409aff1448cf4f6aa41d78c69a3bc
change-id: 20240523-swap-allocator-1534c480ece4

Best regards,
-- 
Chris Li <chrisl@kernel.org>


