Return-Path: <linux-kernel+bounces-293142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C04957B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A22D1C20EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB54595B;
	Tue, 20 Aug 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5YS5caR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476283D97F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118942; cv=none; b=p6KqkNQgcBbLWB17M1fRDLYsffRVuh1CVoopt2LomazF5PnFvye3l5QvrjbpRlDYUv8lWJkz/z/WUTWlIL2XKFI6V4+uXjgFcXG4qVP5ycP0znKaFlHKlQItqCAcCONUixL7v/n5WdWUXyEjw1XvqSLOicpBdf0plu+AtPRBxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118942; c=relaxed/simple;
	bh=miVL5TDB5KVMoD5br+BJHvjZC5zTTrK19JapEoArU0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRVuw6dC99pD1PMJlxlvAMu8HMXJfP/KuROe3alRH9EGfR+Bahw0xMKZm4hA/azMYtBuFhYkhaOq58S39FL4ai197+YqEsrFedRnG12a3cfQ8NXtIRjdrGH6ntz6RiBxlD68nb4PElfl5/awgJcCB5YQQ2aB6ndmJ4Pi8zb1bDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5YS5caR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724118942; x=1755654942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miVL5TDB5KVMoD5br+BJHvjZC5zTTrK19JapEoArU0k=;
  b=g5YS5caRtPCy0CsuaSvkATmc5trZea/7glGB0PK0aPiLvL5BiQaWWaPM
   /AiPQNBdZoZKH/n0pQX3+WBJ+jDj+kPhYeuoS6vRF0l/yHNnboTd0/8Ks
   /syd/JF3aLEFOehjSX+7pYprvncSpcf5xJkb/YEyVBcy9kT/aDOAUDpBE
   Cxm2ZStQ4jbW93AWnqYtsL9M98MgFWLoNjECcnFM0BITeN0Ugc0+heSME
   PnePjnR/i5kAcsRrTGvcVQM7yd5x3L1j/y6c7D9IXNhPeA1NNREU4p6uO
   6SAtygDP5ITOfxa0FMMw2sPr16lgTiU8UkWQFvP9VRptFpl5DaOzpGhWT
   w==;
X-CSE-ConnectionGUID: htZsfuPPSqiIriEtRxqkVQ==
X-CSE-MsgGUID: UwqiVBfRQ0eB3DmpjAsdrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26191817"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="26191817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:55:42 -0700
X-CSE-ConnectionGUID: 6YktVCC2STiWH21cQxg2LA==
X-CSE-MsgGUID: KXybsi2GQMGsQwvbqmaIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="83759641"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa002.fm.intel.com with ESMTP; 19 Aug 2024 18:55:38 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 3/4] perf/x86/intel: Support hybrid PMU with multiple atom uarchs
Date: Tue, 20 Aug 2024 07:38:52 +0000
Message-Id: <20240820073853.1974746-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upcoming ARL-H hybrid processor contains 2 different atom uarchs
which have different PMU capabilities. To distinguish these atom uarchs,
CPUID.1AH.EAX[23:0] defines a native model ID which can be used to
uniquely identify the uarch of the core by combining with core type.

Thus a 3rd hybrid pmu type "hybrid_tiny" is defined to mark the 2nd
atom uarch. The helper find_hybrid_pmu_for_cpu() would compare the
hybrid pmu type and dynamically read core native id from cpu to identify
the corresponding hybrid pmu structure.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 24 +++++++++++++++++-------
 arch/x86/events/perf_event.h | 22 +++++++++++++++++++---
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..62ef039f461f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4902,17 +4902,26 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 
 	/*
 	 * This essentially just maps between the 'hybrid_cpu_type'
-	 * and 'hybrid_pmu_type' enums:
+	 * and 'hybrid_pmu_type' enums except for ARL-H processor
+	 * which needs to compare atom uarch native id since ARL-H
+	 * contains two different atom uarchs.
 	 */
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
+		u32 native_id;
 
-		if (cpu_type == HYBRID_INTEL_CORE &&
-		    pmu_type == hybrid_big)
-			return &x86_pmu.hybrid_pmu[i];
-		if (cpu_type == HYBRID_INTEL_ATOM &&
-		    pmu_type == hybrid_small)
+		if (cpu_type == HYBRID_INTEL_CORE && pmu_type == hybrid_big)
 			return &x86_pmu.hybrid_pmu[i];
+		if (cpu_type == HYBRID_INTEL_ATOM) {
+			if (x86_pmu.num_hybrid_pmus == 2 && pmu_type == hybrid_small)
+				return &x86_pmu.hybrid_pmu[i];
+
+			native_id = get_this_hybrid_cpu_native_id();
+			if (native_id == skt_native_id && pmu_type == hybrid_small)
+				return &x86_pmu.hybrid_pmu[i];
+			if (native_id == cmt_native_id && pmu_type == hybrid_tiny)
+				return &x86_pmu.hybrid_pmu[i];
+		}
 	}
 
 	return NULL;
@@ -6218,6 +6227,7 @@ static inline int intel_pmu_v6_addr_offset(int index, bool eventsel)
 static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
 	{ hybrid_small, "cpu_atom" },
 	{ hybrid_big, "cpu_core" },
+	{ hybrid_tiny, "cpu_lowpower" },
 };
 
 static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
@@ -6250,7 +6260,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		if (pmu->pmu_type & hybrid_small) {
+		if (pmu->pmu_type & hybrid_small_tiny) {
 			pmu->intel_cap.perf_metrics = 0;
 			pmu->intel_cap.pebs_output_pt_available = 1;
 			pmu->mid_ack = true;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fdd7d0369d42..6b8e098daf2f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -668,6 +668,13 @@ enum {
 #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
 #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
 
+
+/*
+ * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
+ * of the core. Bits 31-24 indicates its core type (Core or Atom)
+ * and Bits [23:0] indicates the native model ID of the core.
+ * Core type and native model ID are defined in below enumerations.
+ */
 enum hybrid_cpu_type {
 	HYBRID_INTEL_NONE,
 	HYBRID_INTEL_ATOM	= 0x20,
@@ -676,13 +683,22 @@ enum hybrid_cpu_type {
 
 #define X86_HYBRID_PMU_ATOM_IDX		0
 #define X86_HYBRID_PMU_CORE_IDX		1
+#define X86_HYBRID_PMU_TINY_IDX		2
 
 enum hybrid_pmu_type {
 	not_hybrid,
-	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
-	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
+	hybrid_small = BIT(X86_HYBRID_PMU_ATOM_IDX),
+	hybrid_big = BIT(X86_HYBRID_PMU_CORE_IDX),
+	hybrid_tiny = BIT(X86_HYBRID_PMU_TINY_IDX),
+	/* The belows are only used for matching */
+	hybrid_big_small = hybrid_big | hybrid_small,
+	hybrid_small_tiny = hybrid_small | hybrid_tiny,
+	hybrid_big_small_tiny = hybrid_big | hybrid_small_tiny,
+};
 
-	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
+enum atom_native_id {
+	cmt_native_id           = 0x2,  /* Crestmont */
+	skt_native_id           = 0x3,  /* Skymont */
 };
 
 struct x86_hybrid_pmu {
-- 
2.40.1


