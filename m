Return-Path: <linux-kernel+bounces-176991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197B8C3844
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B341C21353
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5355C36;
	Sun, 12 May 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnT+ejCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE254777;
	Sun, 12 May 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542624; cv=none; b=lOFVyusxDUqgD+HRJBx3Z+6ilYfEhVQqlbNpK1UG3vGcsfTMVid6ET++277aWdaZAFHv21mSkCRMs5JSNc+622FP4LJNCVJebxEKum3v2pXsfkefEVgwZPa2LGClTYNmnIBIXmy7xcdlLh4tSmxkOF9Ax6vaGePn8GOaoRH39vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542624; c=relaxed/simple;
	bh=tWKq7K6XmSUSldcREZ1dFiZ70aiSWF0Pc/jUVnK6YyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+01yCnWy9tZH5VfU+k4HxNQFiE7hA1NOFEAYxVNGuMXXRpAyOf4lU27Goi2a6ppfsFu7Jz8XY/Gwa4XvcdiByZ4ACR7fWSNvyD1UmvXlIuX2Pcz3d/OInSBh1l+A1mv7zMIbNyGfU12UHtDHNtOvlr652RNmkvQoxiYdJFR3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnT+ejCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08855C4AF0B;
	Sun, 12 May 2024 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715542624;
	bh=tWKq7K6XmSUSldcREZ1dFiZ70aiSWF0Pc/jUVnK6YyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnT+ejCW/rIvYMQFgfYDh/RgVbKdYfxAURsgsZMDmHalrJ0Yth5mnC1e+08nyM6hf
	 0fEbQnHb7Kv6iXI/YIiPXkXlIuTvt+Wh0XgYG6uQyLUl8kv4XAV6voDMIIUDOlM8+t
	 tz+cjrWmCiWVJin0IHHRkzBTx3ih/uBG8HEgYtsy4odEvm47bgDSbAWdNF8+hVsT5Y
	 fgFLwwlbWYnbw5PhmnH+lSrTlZAGkYz80u0gsp5i1Ks0fqvvtJj4QP8HKMuS/qsdAy
	 gqP6loR91ecl68XNi7JsjXq4sqW7hqLY/pU3z2qnCiYIdhq1Hex8UKCKLBWsyt2Pw2
	 mFszbSNsaWI1Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC IDEA v2 4/6] mm/damon/acma: implement scale down feature
Date: Sun, 12 May 2024 12:36:55 -0700
Message-Id: <20240512193657.79298-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512193657.79298-1-sj@kernel.org>
References: <20240512193657.79298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the memory scale down feature of Access/Contiguity-aware
Memory Auto-scaling module.  It runs DMAOS_ALLOC action scheme with
user-acceptable level of memory pressure stall as its target, in 512
contig pages base granularity, and report the 512 contig successfully
DAMOS_ALLOC-ed regions to the host for reuse.  For minimizing
DAMON-internal DAMOS_ALLOC-ed region management overhead, the scheme is
applied to only 128 MiB not-completely-allocated contiguous memory
region of highest address.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/acma.c | 137 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 6 deletions(-)

diff --git a/mm/damon/acma.c b/mm/damon/acma.c
index 276b61fd4e26..b093b90471dd 100644
--- a/mm/damon/acma.c
+++ b/mm/damon/acma.c
@@ -8,9 +8,6 @@
  * and report it to the host when the system is having memory pressure level
  * under the threshold, and vice versa, respectively.
  *
- * At this moment, the scaling is not implemented, hence this is just a memory
- * pressure-aware proactive reclamation module.
- *
  * Author: SeongJae Park <sj@kernel.org>
  */
 
@@ -50,6 +47,13 @@ static bool enabled __read_mostly;
 static bool commit_inputs __read_mostly;
 module_param(commit_inputs, bool, 0600);
 
+/*
+ * Minimum amount of memory to be guaranteed to the system.  In other words,
+ * the lower limit of the scaling.
+ */
+static unsigned long min_mem_kb __read_mostly;
+module_param(min_mem, ulong, 0600);
+
 /*
  * Desired level of memory pressure-stall time in microseconds.
  *
@@ -66,6 +70,18 @@ module_param(commit_inputs, bool, 0600);
 static unsigned long quota_mem_pressure_us __read_mostly = 1000;
 module_param(quota_mem_pressure_us, ulong, 0600);
 
+/*
+ * Basic scale down/up granularity.  ACMA will allocate and report contiguous
+ * pages of this size at once.  512 pages (2 MiB for 4 KiB page setup) by
+ * default.
+ *
+ * To minimize DAMON-internal ALLOC-ed memory management overhead, we further
+ * apply SCALE_WINDOW.  Refer to damon_acma_set_scale_down_region_filter() for
+ * more detail about it.
+ */
+static unsigned int scale_pg_order __read_mostly = 9;
+module_param(scale_pg_order, uint, 0600);
+
 static struct damos_quota damon_acma_quota = {
 	/* Use up to 15 ms per 1 sec for scaling, by default */
 	.ms = 15,
@@ -123,6 +139,11 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_acma_reclaim_stat,
 		acma_reclaim_tried_regions, acma_reclaim_succ_regions,
 		acma_reclaim_quota_exceeds);
 
+static struct damos_stat damon_acma_scale_down_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_acma_scale_down_stat,
+		acma_scale_down_tried_regions, acma_scale_down_succ_regions,
+		acma_scale_down_quota_exceeds);
+
 static struct damos_access_pattern damon_acma_stub_pattern = {
 	/* Find regions having PAGE_SIZE or larger size */
 	.min_sz_region = PAGE_SIZE,
@@ -143,6 +164,9 @@ static struct damos *damon_acma_new_scheme(
 {
 	struct damos_quota quota = damon_acma_quota;
 
+	/* Use 1/2 of total quota for hot/cold pages sorting */
+	quota.ms = quota.ms / 2;
+
 	return damon_new_scheme(
 			pattern,
 			action,
@@ -177,6 +201,61 @@ static int damon_acma_set_scheme_quota(struct damos *scheme, struct damos *old,
 	return 0;
 }
 
+/*
+ * scale_pg_order is for basic scaling granularity.  Have a larger granularity
+ * to limit DAMON-internal alloc-ed pages management overhead.
+ */
+#define SCALE_WINDOW	(128 * MB)
+
+/*
+ * Set scale_down scheme's address range type filter to apply scaling down to
+ * only current scaling window.  Scaling window is SCALE_WINDOW size contiguous
+ * memory region of highest address that not yet completely DAMOS_ALLOC-ed and
+ * reported.
+ *
+ * TODO: Apply 'struct page' reduction in SCALE_WINDOW or lower granularity.
+ * E.g., hot-unplug the memory block, or apply vmemmap remapping-based approach
+ * like hugetlb vmemmap optimization
+ * (https://docs.kernel.org/mm/vmemmap_dedup.html).
+ */
+static int damon_acma_set_scale_down_region_filter(struct damos *scheme)
+{
+	struct damos_filter *filter = damos_new_filter(
+			DAMOS_FILTER_TYPE_ADDR, false);
+	unsigned long end;
+	unsigned long start_limit, end_limit;
+
+	if (!filter)
+		return -ENOMEM;
+
+	/* scale down no below min_mem_kb */
+	end_limit = monitor_region_end;
+	start_limit = monitor_region_start + min_mem_kb * KB;
+
+	/* not-completely-alloc-ed SCALE_WINDOW region of highest address */
+	for (end = end_limit; end >= start_limit + SCALE_WINDOW;
+			end -= SCALE_WINDOW) {
+		if (damon_alloced_bytes(end, end - SCALE_WINDOW)
+				!= SCALE_WINDOW)
+			break;
+	}
+	filter->addr_range.start = max(start_limit, end - SCALE_WINDOW);
+	filter->addr_range.end = end;
+
+	damos_add_filter(scheme, filter);
+	return 0;
+}
+
+/*
+ * Called back from DAMOS for every damos->alloc_order contig pages that
+ * just successfully DAMOS_ALLOC-ed.
+ */
+static int damon_acma_alloc_callback(unsigned long start_addr)
+{
+	/* For non-zero return value, DAMOS free the pages. */
+	return page_report(PHYS_PFN(addr), 1 << scale_pg_order);
+}
+
 /*
  * Reclaim cold pages on entire physical address space
  */
@@ -199,10 +278,40 @@ static struct damos *damon_acma_new_reclaim_scheme(struct damos *old)
 	return scheme;
 }
 
+/*
+ * Scale down scheme
+ */
+static struct damos *damon_acma_new_scale_down_scheme(struct damos *old)
+{
+	struct damos_access_pattern pattern = damon_acma_stub_pattern;
+	struct damos *scheme;
+	int err;
+
+	scheme = damon_acma_new_scheme(&pattern, DAMOS_ALLOC);
+	if (!scheme)
+		return NULL;
+	err = damon_acma_set_scheme_quota(scheme, old,
+			DAMOS_QUOTA_SOME_MEM_PSI_US);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	/* alloc in 512 pages granularity */
+	scheme->alloc_order = scale_pg_order;
+	scheme->alloc_callback = damon_acma_alloc_callback;
+	err = damon_acma_set_scale_down_region_filter(scale_down_scheme);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	return scheme;
+}
+
 static int damon_acma_apply_parameters(void)
 {
 	struct damos *scheme, *reclaim_scheme;
-	struct damos *old_reclaim_scheme = NULL;
+	struct damos *scale_down_scheme;
+	struct damos *old_reclaim_scheme = NULL, *old_scale_down_scheme = NULL;
 	struct damos_quota_goal *goal;
 	int err = 0;
 
@@ -210,14 +319,27 @@ static int damon_acma_apply_parameters(void)
 	if (err)
 		return err;
 
-	damon_for_each_scheme(scheme, ctx)
-		old_reclaim_scheme = scheme;
+	damon_for_each_scheme(scheme, ctx) {
+		if (!old_reclaim_scheme) {
+			old_reclaim_scheme = scheme;
+			continue;
+		}
+		old_scale_down_scheme = scheme;
+	}
 
 	reclaim_scheme = damon_acma_new_reclaim_scheme(old_reclaim_scheme);
 	if (!reclaim_scheme)
 		return -ENOMEM;
 	damon_set_schemes(ctx, &reclaim_scheme, 1);
 
+	scale_down_scheme = damon_acma_new_scale_down_scheme(
+			old_scale_down_scheme);
+	if (!scale_down_scheme) {
+		damon_destroy_scheme(reclaim_scheme);
+		return -ENOMEM;
+	}
+	damon_add_scheme(ctx, scale_down_scheme);
+
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
 					&monitor_region_end);
@@ -303,6 +425,9 @@ static int damon_acma_after_aggregation(struct damon_ctx *c)
 		case DAMOS_LRU_RECLAIM:
 			damon_acma_reclaim_stat = s->stat;
 			break;
+		case DAMOS_ALLOC:
+			damon_acma_scale_down_stat = s->stat;
+			break;
 		default:
 			break;
 	}
-- 
2.39.2


