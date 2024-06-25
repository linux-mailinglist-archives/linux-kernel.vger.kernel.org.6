Return-Path: <linux-kernel+bounces-229488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7D917016
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E64C1F2256F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C317C7C2;
	Tue, 25 Jun 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP2XCJzN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD417995A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339757; cv=none; b=D29c+hPrY7iZMG5Ymgq20C5yLuqqL8y4XlONXYESKSRpWwEqqc7RMeWaYkwui2j6wyKyFPzhEpprs7QT8+c4e6KmJnQ8d1BiryCvmU3EcXMn5/1SXT2Z7cAA3841GHQH9yRbIrRbEWAJ/d4RfgyaM1yyh+jpJ6dkbunBBtj+0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339757; c=relaxed/simple;
	bh=jioh27lFNyL/U9xa3tsB0eU4SRcLEr+62WXb7dPpRDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCTjN4sUa8ntVPtBMo2QIRTl8uovnnvBg/uHh1ooELf923MZx30lKc5adCU2TX7NbqV7wdShSrbGeqPCeNYMNjPJvMDE6/nHFGG+9ajO0eG8B2SCc52C0DN2OsVTzUQy8a9z1urFwlH3sfU8Ra0gUYOAhrqiQmRT7wAfz3XCM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP2XCJzN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339755; x=1750875755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jioh27lFNyL/U9xa3tsB0eU4SRcLEr+62WXb7dPpRDY=;
  b=YP2XCJzNYlNLBoRjnGqCaUxQ+pM+IeRTcAv+YEFATPTGe47rdYevLDn2
   TdaItbZWI2jBQxC8djwil301XNa5Edu/mMNwSAP+RuKx7psw9qXgOyCpi
   ZIrpsYGqZB64byBvQDE2YetK1lnE0fXnCONW2qAQlMgXS6KWsExE0wemZ
   2MHiaZ2Pc+47ebLjZsh+kevi6u+7ro7owyBikawIEH6dLOnBW6XP8uG/p
   v/I5pDJrAtx6XjwCcxg5uEWmccv1tceh3M9L8UI9lrUc2Vu0Csbn84yFp
   z1WvwCE4rNo8t7RgG2lY+uIRrrtiVVt+GR5Xk9vl71NPR/y5jG7ZM7bSD
   g==;
X-CSE-ConnectionGUID: AQPUvdaKRM6QmN7vXLNLHA==
X-CSE-MsgGUID: kCamQRV6TgS/Pely3BA25A==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16204002"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16204002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:21 -0700
X-CSE-ConnectionGUID: LxwE2yo0S1GkU3vwWbRRuQ==
X-CSE-MsgGUID: kjtdvWdMTDKO3u6UNgYpQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913347"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2024 11:22:06 -0700
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
Subject: [PATCH V2 04/13] perf/x86/intel: Rename model-specific pebs_latency_data functions
Date: Tue, 25 Jun 2024 11:22:47 -0700
Message-Id: <20240625182256.291914-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240625182256.291914-1-kan.liang@linux.intel.com>
References: <20240625182256.291914-1-kan.liang@linux.intel.com>
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
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  8 ++++----
 arch/x86/events/intel/ds.c   | 20 ++++++++++----------
 arch/x86/events/perf_event.h |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e998e3ef8c1c..ca46c5c31f78 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6509,7 +6509,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ATOM_GRACEMONT:
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
 	case INTEL_FAM6_METEORLAKE_L:
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
2.35.1


