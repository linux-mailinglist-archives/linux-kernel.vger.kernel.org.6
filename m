Return-Path: <linux-kernel+bounces-279065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A094B880
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5571F26D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC05188CDE;
	Thu,  8 Aug 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnbXmwEE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03C13CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104275; cv=none; b=HxOhct22/2ZNeLbddDoLWdfyCmlZgtH/UhiyGJX9FT9JIOyRBrycC3kwdL8Ilms3IjOWknEId1gr4JWxI0KEEvlnUG9/Sv8hp4VSmnHXJddec3uHkfB+mLiJH7Fxl/CqJFWGA1eyW5K3cYvcvZnN2BvOSR0igW0cRFbmuZWifGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104275; c=relaxed/simple;
	bh=7BWbiyQ64rSYmkiuNFI/XLPzEAQYwliWF5+rWqVPwA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwuEfeQbzsiD/oCYl2SrNOlJEmweLeh6jcSZmMhFKBi0bHVd4CjUwwpI74lz49E1NfbErX0vDQCSz4X1rwIilDS3aGyqFseWGGG9Zs2n9T7iajnRHQ/unFNpYw20+vi5hwyoomQhGmc0tfuVALyXiXP4OV/4oulXyskx1F7Eueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnbXmwEE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723104274; x=1754640274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7BWbiyQ64rSYmkiuNFI/XLPzEAQYwliWF5+rWqVPwA8=;
  b=HnbXmwEEtlvgYwawgbPSsyjppl8QI2NrqyDrtgFTq1GfNDe9N8NdtQ9I
   v5ltQ9dTCorDWqjQFpKjhgj/YN1/GVJjOYH9+88mIzSoFJUl061S5CSHo
   pn5gsPhUVL+KjABawxKLB7sDdjF9JwSEwElrjV1RvbUOx8XxBC38Jd53o
   pB3PXzk3qmKAcUBicsiwc2pO9QJMeTKbV2bvzdDIXqIrgYX82BVh6g9ce
   ge+oG+uhWFgTPcJ8mLc3utsWTUS4o6h8iI+yUCAFg4YClIbZ+FVRTiown
   DMbDUNJL0o4dtMjfg5X/Gwuclw/q8qxUgQQ3gB2f4bu5FU8E4IKO3W8Td
   g==;
X-CSE-ConnectionGUID: 8+WTZd+uT0iQQnVhVL9dWQ==
X-CSE-MsgGUID: VrMLJcLqQ6yM59og472ZpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20877197"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="20877197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:04:33 -0700
X-CSE-ConnectionGUID: iVEdjo6OQYSRPJyd1zFL4A==
X-CSE-MsgGUID: yvJfBYVsTXWT3+1q4zW7hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57094376"
Received: from hshannan-mobl.ger.corp.intel.com (HELO colinkin-mobl.ger.corp.intel.com) ([10.245.129.129])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2024 01:04:31 -0700
From: Colin Ian King <colin.king@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	rppt@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] md/raid6 algorithms: scale test duration for speedier boots
Date: Thu,  8 Aug 2024 09:04:27 +0100
Message-ID: <20240808080428.7382-1-colin.king@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using jiffies and waiting for jiffies to wrap before
measuring use the higher precision local_time for benchmarking.
Measure 10,000 loops, which works out to be accurate enough for
benchmarking the raid algo data rates. Also add division by zero
checking in case timing measurements are bogus.

Speeds up raid benchmarkingm, reduces calibration time from
48,000 usecs to 21,000 usecs on a i9-19200.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---

V2: Increase max_perf loops to 10,000 for more stable benchmarking on
    slower devices and use div64_u64 for 64 bit unsigned int divisions
    to fix build problems on 32 bit systems.

---
 lib/raid6/algos.c | 57 +++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index cd2e88ee1f14..141931563dd1 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -18,6 +18,9 @@
 #else
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/sched/clock.h>
+#include <linux/math64.h>
+
 /* In .bss so it's zeroed */
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(256)));
 EXPORT_SYMBOL(raid6_empty_zero_page);
@@ -155,12 +158,15 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 static inline const struct raid6_calls *raid6_choose_gen(
 	void *(*const dptrs)[RAID6_TEST_DISKS], const int disks)
 {
-	unsigned long perf, bestgenperf, j0, j1;
+	unsigned long perf;
+	const unsigned long max_perf = 10000;
 	int start = (disks>>1)-1, stop = disks-3;	/* work on the second half of the disks */
 	const struct raid6_calls *const *algo;
 	const struct raid6_calls *best;
+	const u64 ns_per_mb = 1000000000 >> 20;
+	u64 n, ns, t, ns_best = ~0ULL;
 
-	for (bestgenperf = 0, best = NULL, algo = raid6_algos; *algo; algo++) {
+	for (best = NULL, algo = raid6_algos; *algo; algo++) {
 		if (!best || (*algo)->priority >= best->priority) {
 			if ((*algo)->valid && !(*algo)->valid())
 				continue;
@@ -170,26 +176,20 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				break;
 			}
 
-			perf = 0;
-
 			preempt_disable();
-			j0 = jiffies;
-			while ((j1 = jiffies) == j0)
-				cpu_relax();
-			while (time_before(jiffies,
-					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
+			t = local_clock();
+			for (perf = 0; perf < max_perf; perf++)
 				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
-				perf++;
-			}
+			ns = local_clock() - t;
 			preempt_enable();
 
-			if (perf > bestgenperf) {
-				bestgenperf = perf;
+			if (ns < ns_best) {
+				ns_best = ns;
 				best = *algo;
 			}
-			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
-				(perf * HZ * (disks-2)) >>
-				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
+			n = max_perf * PAGE_SIZE * ns_per_mb * (disks - 2);
+			pr_info("raid6: %-8s gen() %5llu MB/s (%llu ns)\n", (*algo)->name,
+				(ns > 0) ? div64_u64(n, ns) : 0, ns);
 		}
 	}
 
@@ -206,31 +206,24 @@ static inline const struct raid6_calls *raid6_choose_gen(
 		goto out;
 	}
 
-	pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
-		best->name,
-		(bestgenperf * HZ * (disks - 2)) >>
-		(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
+	n = max_perf * PAGE_SIZE * ns_per_mb * (disks - 2);
+	pr_info("raid6: using algorithm %s gen() %llu MB/s (%llu ns)\n",
+		best->name, (ns_best > 0) ? div64_u64(n, ns_best) : 0, ns_best);
 
 	if (best->xor_syndrome) {
-		perf = 0;
-
 		preempt_disable();
-		j0 = jiffies;
-		while ((j1 = jiffies) == j0)
-			cpu_relax();
-		while (time_before(jiffies,
-				   j1 + (1 << RAID6_TIME_JIFFIES_LG2))) {
+		t = local_clock();
+		for (perf = 0; perf < max_perf; perf++) {
 			best->xor_syndrome(disks, start, stop,
 					   PAGE_SIZE, *dptrs);
-			perf++;
 		}
+		ns = local_clock() - t;
 		preempt_enable();
 
-		pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
-			(perf * HZ * (disks - 2)) >>
-			(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
+		n = max_perf * PAGE_SIZE * ns_per_mb * (disks - 2);
+		pr_info("raid6: .... xor() %llu MB/s, rmw enabled (%llu ns)\n",
+			(ns > 0) ? div64_u64(n, ns) : 0, ns);
 	}
-
 out:
 	return best;
 }
-- 
2.43.0


