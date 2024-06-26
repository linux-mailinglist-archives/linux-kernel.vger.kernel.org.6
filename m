Return-Path: <linux-kernel+bounces-230970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB5F91847B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A05284BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA318754A;
	Wed, 26 Jun 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpKLb3zr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4A186E40
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412508; cv=none; b=bVvFXmefMQumOoJCU0cvviAS2ZECSbwI6U0fkJVM55ZlfNAib5FrYLKv6khPAiHd2J/87etPHlxVAQR1Rgr250+4/E/pSbg/lNRtWwn/PKZ0EI8xI5li4IDqi3EMv1yL5yJhXCYpUUrG2Q2DtWNtgfb+pdAuVdZIq9Ilui6OU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412508; c=relaxed/simple;
	bh=h3+E6xo8m2aoLch1VVSjx1K+YOw6jynYWGWD8Oa2mvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyhHrMImb96g6KwvPx8lMYy8yqJ1UyBqzV/Mc3b9pNzQbu4ghhKQfpbRxhxIH01wvzCd2puXsIUHlQMLqG/bODblZFaSL9HK9wBm1otF679TrCkdx2fTBMGwDkaJ5xTfmWDQZTuuM1qGXNldKyg8HrOgbdK9v61vnH6vjxH7ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpKLb3zr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412507; x=1750948507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3+E6xo8m2aoLch1VVSjx1K+YOw6jynYWGWD8Oa2mvA=;
  b=IpKLb3zrfiSzTeJd2OwzvPK0De1GWpQAzfb7atOGHvcUgP7wfHs3brOl
   qzUvt9OX0q66NbkPxniUTmESB2WW7+xqoWO7sEbQJ6Tv5FjqjYXZF0tDI
   FCiS5p40k344NCu0RFpo2W//EmkNpheyZIri9ktRqZ3k4GWNBGQvjnLe4
   ukK36aKddRiHm7AMteKE51c/ERS4MtAPM6SeNpmwGhzCQeJEHOpdFP+4o
   iD1PfeSxT+EW2tg5LyLlDcJlMPptR/7lnevdsbX4ZtUgWAxaBqlQVFSal
   HE/LEmuUK/P8PJ7VK+R3TrT/cOtaC6jiOhV1rxKRzXJasJElTn9ETmtQc
   g==;
X-CSE-ConnectionGUID: MQk68KxIQIemM1reC6YLWw==
X-CSE-MsgGUID: xKkZQ1JfRpOdNoKBsWDotg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375532"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375532"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:45 -0700
X-CSE-ConnectionGUID: 2SaK/gLXRH6bJa2w8q1b1g==
X-CSE-MsgGUID: IbGnCGuRSKyWdHj0ogCfDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911962"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2024 07:34:45 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 04/13] perf/x86/intel: Rename model-specific pebs_latency_data functions
Date: Wed, 26 Jun 2024 07:35:36 -0700
Message-Id: <20240626143545.480761-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240626143545.480761-1-kan.liang@linux.intel.com>
References: <20240626143545.480761-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The model-specific pebs_latency_data functions of ADL and MTL use the
"small" as a postfix to indicate the e-core. The postfix is too generic
for a model-specific function. It cannot provide useful information that
can directly map it to a specific uarch, which can facilitate the
development and maintenance.
Use the abbr of the uarch to rename the model-specific functions.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  8 ++++----
 arch/x86/events/intel/ds.c   | 20 ++++++++++----------
 arch/x86/events/perf_event.h |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 73dbbbdcc421..50033023125d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6509,7 +6509,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ATOM_GRACEMONT:
 		intel_pmu_init_grt(NULL);
 		intel_pmu_pebs_data_source_grt();
-		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.pebs_latency_data = adl_latency_data_grt;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
 		td_attr = tnt_events_attrs;
 		mem_attr = grt_mem_attrs;
@@ -6523,7 +6523,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_init_grt(NULL);
 		x86_pmu.extra_regs = intel_cmt_extra_regs;
 		intel_pmu_pebs_data_source_cmt();
-		x86_pmu.pebs_latency_data = mtl_latency_data_small;
+		x86_pmu.pebs_latency_data = mtl_latency_data_cmt;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
 		td_attr = cmt_events_attrs;
 		mem_attr = grt_mem_attrs;
@@ -6874,7 +6874,7 @@ __init int intel_pmu_init(void)
 		 */
 		intel_pmu_init_hybrid(hybrid_big_small);
 
-		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.pebs_latency_data = adl_latency_data_grt;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
@@ -6931,7 +6931,7 @@ __init int intel_pmu_init(void)
 	case INTEL_METEORLAKE_L:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
-		x86_pmu.pebs_latency_data = mtl_latency_data_small;
+		x86_pmu.pebs_latency_data = mtl_latency_data_cmt;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 79e23dec6714..8a11f72a22b6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -257,8 +257,8 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 }
 
 /* Retrieve the latency data for e-core of ADL */
-static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
-				     u8 dse, bool tlb, bool lock, bool blk)
+static u64 __adl_latency_data_grt(struct perf_event *event, u64 status,
+				  u8 dse, bool tlb, bool lock, bool blk)
 {
 	u64 val;
 
@@ -277,27 +277,27 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
 	return val;
 }
 
-u64 adl_latency_data_small(struct perf_event *event, u64 status)
+u64 adl_latency_data_grt(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 
 	dse.val = status;
 
-	return __adl_latency_data_small(event, status, dse.ld_dse,
-					dse.ld_locked, dse.ld_stlb_miss,
-					dse.ld_data_blk);
+	return __adl_latency_data_grt(event, status, dse.ld_dse,
+				      dse.ld_locked, dse.ld_stlb_miss,
+				      dse.ld_data_blk);
 }
 
 /* Retrieve the latency data for e-core of MTL */
-u64 mtl_latency_data_small(struct perf_event *event, u64 status)
+u64 mtl_latency_data_cmt(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 
 	dse.val = status;
 
-	return __adl_latency_data_small(event, status, dse.mtl_dse,
-					dse.mtl_stlb_miss, dse.mtl_locked,
-					dse.mtl_fwd_blk);
+	return __adl_latency_data_grt(event, status, dse.mtl_dse,
+				      dse.mtl_stlb_miss, dse.mtl_locked,
+				      dse.mtl_fwd_blk);
 }
 
 static u64 load_latency_data(struct perf_event *event, u64 status)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3c781dabce76..e9374b4360d4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1548,9 +1548,9 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
-u64 adl_latency_data_small(struct perf_event *event, u64 status);
+u64 adl_latency_data_grt(struct perf_event *event, u64 status);
 
-u64 mtl_latency_data_small(struct perf_event *event, u64 status);
+u64 mtl_latency_data_cmt(struct perf_event *event, u64 status);
 
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
-- 
2.38.1


