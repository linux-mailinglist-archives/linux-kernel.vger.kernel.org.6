Return-Path: <linux-kernel+bounces-275047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E57947FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A128604B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5008161924;
	Mon,  5 Aug 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXvogQH5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CEF15EFC6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877702; cv=none; b=j9DyidqECjb6l5GGV6Wtk8eb2W868C/Ty5m+oXiiKBenQ0x6P1zYbSSrRD8N+/qA8sdMdbbAr3ZkDUV8oD68YXVkBQEQt7sUKq0tJCig4Kla4dmt42eGRRh425oAuU/DGUgmfRxjNLBymGSa0hcrozErOww0ptqgbe2/P4PDgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877702; c=relaxed/simple;
	bh=q4MsCYVZFW7SK0EntHFkZbM8gcPYNlk2hiKlP7RWzKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGHpd72MmxL3ZOu0XxXQmTHdsZRkPDMkgoIFJd9naE04oUH9l2IT+s1SvA/HBGZrKJa2WsxbTQioVtjOXpPgax4LH5YBkUNBUJasLYzMgVlqsSMW+9jnJkI3HAKdJgRgozLPCg7DPMrs+CHhrjo5mi8zzk+Ldd/5sDesKJz0kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXvogQH5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722877701; x=1754413701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q4MsCYVZFW7SK0EntHFkZbM8gcPYNlk2hiKlP7RWzKc=;
  b=LXvogQH5jjY7m0OAm3Thw3lA9V5a8TtkqtaD1Djc9Z2q77Vjz7eXXnB/
   D+41NyCKq6T29nLh0Oc8AGlr+MSz/2jq0aLKCJYk5/e49uHLthJRpjWvK
   pHL6nc5I11wBX1SwTlmtCrE8xYgH1CNyKHaU0HjPl4nnogmR2qGsJCyJS
   zJfQTgghH8XlGGdytNdsc7C4KrhjA5H1wg5GFs7a+79NhA6B1uM0pQ5Ph
   nUWOv6a3eM8BxtmwSaKk2gRrzb8/SESt3GCWtUmmtSW1+Wimw2usvxr59
   B0ojJ+Ybibcsib7INRMH9jJzyu1CQpTjFB6ORAK9SvIPBQG9r6ycXkFzJ
   g==;
X-CSE-ConnectionGUID: gM5T5spgRKKCk+wYIqQoxQ==
X-CSE-MsgGUID: RS45mp52TRKwqIykVWyNUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980081"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20980081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:08:20 -0700
X-CSE-ConnectionGUID: 9Si0DcDeTJqn72Tyrwgy+Q==
X-CSE-MsgGUID: FZZWwduyQBSB8CwBPkhKqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="56794864"
Received: from colinkin-mobl.ger.corp.intel.com ([10.246.147.18])
  by orviesa007.jf.intel.com with ESMTP; 05 Aug 2024 10:08:19 -0700
From: Colin Ian King <colin.king@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	rppt@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] md/raid6 algorithms: scale test duration for speedier boots
Date: Mon,  5 Aug 2024 18:08:15 +0100
Message-ID: <20240805170816.6025-1-colin.king@intel.com>
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
Measure 2500 loops, which works out to be accurate enough for
benchmarking the raid algo data rates. Also add division by zero
checking in case timing measurements are bogus.

Speeds up raid benchmarkingm, reduces calibration time from
48,000 usecs to 4000 usecs on a i9-19200.

Signed-off-by: Colin Ian King <colin.king@intel.com>
---
 lib/raid6/algos.c | 56 ++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index cd2e88ee1..5d974ae8d 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -18,6 +18,8 @@
 #else
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/sched/clock.h>
+
 /* In .bss so it's zeroed */
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(256)));
 EXPORT_SYMBOL(raid6_empty_zero_page);
@@ -155,12 +157,15 @@ static inline const struct raid6_recov_calls *raid6_choose_recov(void)
 static inline const struct raid6_calls *raid6_choose_gen(
 	void *(*const dptrs)[RAID6_TEST_DISKS], const int disks)
 {
-	unsigned long perf, bestgenperf, j0, j1;
+	unsigned long perf;
+	const unsigned long max_perf = 2500;
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
@@ -170,26 +175,20 @@ static inline const struct raid6_calls *raid6_choose_gen(
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
+				(ns > 0) ? n / ns : 0, ns);
 		}
 	}
 
@@ -206,31 +205,24 @@ static inline const struct raid6_calls *raid6_choose_gen(
 		goto out;
 	}
 
-	pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
-		best->name,
-		(bestgenperf * HZ * (disks - 2)) >>
-		(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
+	n = max_perf * PAGE_SIZE * ns_per_mb * (disks - 2);
+	pr_info("raid6: using algorithm %s gen() %llu MB/s (%llu ns)\n",
+		best->name, (ns_best > 0) ? n / ns_best : 0, ns_best);
 
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
+			(ns > 0) ? n / ns : 0, ns);
 	}
-
 out:
 	return best;
 }
-- 
2.45.2


