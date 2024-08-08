Return-Path: <linux-kernel+bounces-279040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430B94B82D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796321F21D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63A18950B;
	Thu,  8 Aug 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+yQD6Tq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D51891CF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103284; cv=none; b=R+nqf33ELeMLPgouWkX8eLEu32pQ36aKA3lm8IaXW6ezlhmxV8gMhtxRJTUcNhWBdBnIZHZj1zlBldyX1qHTOmM1x6rfQ+bd2/BLqZM8T4A7PAiICqk23/FD6I+MzW2Ryu3owLhLsTqDWcTYZb6bHqOJ6OY39SBHQpsPSIjALKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103284; c=relaxed/simple;
	bh=bL4bd3hB6c834jZTiJuS1dQmxQPodlVUOt9341v//r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcRg+Hboz+EWMG5IxeLmqmHEtXSTXW+9K0JE3W4Ve4DQQ3sW+gkouQZZfkQgNl/q9A7UGLK7sQnwB7dLZjwV71jIuTwcweaBrCGHPmQj5tgbWxu2OtBVFw6oHRyYm43vqrakQHPeIlaqD2FP47HPTeZBOPq/ZC66uFPwkGliojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+yQD6Tq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103282; x=1754639282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bL4bd3hB6c834jZTiJuS1dQmxQPodlVUOt9341v//r4=;
  b=Z+yQD6TqxmJq5Mxg4u15M/VF6NfSRqT5zlPl5vCMQa9JGe/zxsp8Q5Vi
   oHiQQj7tGPQxcNEezC5elykoLtJfciNra4Y6fVj2f9jJmi2NUtXwwtJYk
   Wph82O29LoH5E5QCW4NJ1/ruW/xvLGGP6L69FZI6txlEs+Tah+NQb2ftv
   4vclPhvovix8u6i9TDKFGMzOEcXWEs4ybkmm5GfWTyEiA9p0qeNGOuTad
   yXcD1LWa5FVIszkiJvKPSbZpxbZAg1eaMynmc41rdFkcxrz8RIPPRfk7D
   bVw7EhZHP6ftEr/i30t+dX/gIA7qy2CyXyEKrAcyyIHncGB5fd5VLdSX0
   Q==;
X-CSE-ConnectionGUID: bxc1wd+FTnKQPqIYXksMDA==
X-CSE-MsgGUID: 90MQI0u9Qouz+KmrGFkAcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38720995"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38720995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:48:02 -0700
X-CSE-ConnectionGUID: /FZ7V56wQ++6d21aPVTeJQ==
X-CSE-MsgGUID: /5aDxyKdT4KHVFNrOROyIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57090940"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2024 00:47:59 -0700
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
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 3/4] perf/x86/intel: Support hybrid PMU with multiple atom uarchs
Date: Thu,  8 Aug 2024 14:02:09 +0000
Message-Id: <20240808140210.1666783-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
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

Thus a 3rd hybrid pmu type "hybrid_small2" is defined to mark the 2nd
atom uarch. The helper find_hybrid_pmu_for_cpu() would compare the
hybrid pmu type and dynamically read core native id from cpu to identify
the corresponding hybrid pmu structure.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/events/intel/core.c | 24 +++++++++++++++++-------
 arch/x86/events/perf_event.h | 18 +++++++++++++++++-
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..b6429bc009c0 100644
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
+			if (native_id == cmt_native_id && pmu_type == hybrid_small2)
+				return &x86_pmu.hybrid_pmu[i];
+		}
 	}
 
 	return NULL;
@@ -6218,6 +6227,7 @@ static inline int intel_pmu_v6_addr_offset(int index, bool eventsel)
 static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
 	{ hybrid_small, "cpu_atom" },
 	{ hybrid_big, "cpu_core" },
+	{ hybrid_small2, "cpu_atom2" },
 };
 
 static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
@@ -6250,7 +6260,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		if (pmu->pmu_type & hybrid_small) {
+		if (pmu->pmu_type & hybrid_small_all) {
 			pmu->intel_cap.perf_metrics = 0;
 			pmu->intel_cap.pebs_output_pt_available = 1;
 			pmu->mid_ack = true;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5d1677844e04..f7b55c909eff 100644
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
@@ -676,12 +683,21 @@ enum hybrid_cpu_type {
 
 #define X86_HYBRID_PMU_ATOM_IDX		0
 #define X86_HYBRID_PMU_CORE_IDX		1
+#define X86_HYBRID_PMU_ATOM2_IDX	2
 enum hybrid_pmu_type {
 	not_hybrid,
 	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
 	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
+	hybrid_small2		= BIT(X86_HYBRID_PMU_ATOM2_IDX),
+	/* The belows are only used for matching */
+	hybrid_big_small	= hybrid_big | hybrid_small,
+	hybrid_small_all	= hybrid_small | hybrid_small2,
+	hybrid_big_small_arl_h	= hybrid_big | hybrid_small_all,
+};
 
-	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
+enum atom_native_id {
+	cmt_native_id           = 0x2,  /* Crestmont */
+	skt_native_id           = 0x3,  /* Skymont */
 };
 
 struct x86_hybrid_pmu {
-- 
2.40.1


