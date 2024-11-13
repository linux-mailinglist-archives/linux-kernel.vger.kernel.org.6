Return-Path: <linux-kernel+bounces-407866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A479C7600
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734C228BB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D314B06C;
	Wed, 13 Nov 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RugPbtW/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281E13B29B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510825; cv=none; b=D40tvrXNMoavQq5qapKkABNyOk/PUd3ukz5Y0PVZjuetBrfJW5OA6/UnbLJPTloA2Ma6ujwxd//weysO0KV7/qwZ1yGEbhbUJv0xaVVvdli4C0ALQ0A3+uXtRbPJt1lZjKp2NNKf8sz+x2LlH118WlbgnFcwhCZ2vBrTtwfqGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510825; c=relaxed/simple;
	bh=RcPq4OPLrw8WjWEWkJqIlu0JtQWOxIH72lmj1/A5lnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fH0RUcs+zm0Uyai22uIZ78wimaeDREp8gZ9XvVKRKZVjj/tbNwFWYja1/kQegcBDYwURHjmLBGSAVd+vL6978UisI2oqf8EOZLKMBcj6m+KklpOGH90tOeAFg8bOSzTtHeAgI5d7ZjhrRQsogzYAx+Z5xeOqFG4HdnADs05Ate0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RugPbtW/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731510823; x=1763046823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RcPq4OPLrw8WjWEWkJqIlu0JtQWOxIH72lmj1/A5lnE=;
  b=RugPbtW/Vhjk+/V3ZNJfWluNXTJ/pjL15sY9obNj71ujzj8CTR2QAnIy
   tDM6scYxh0RYdQUHcA01aR+y5mLWQFYLgOniWBgHhySIRSnL58ooEgAUy
   s+BAuHP8VQv+TMebxa/ERTAf9kWOlwYx/KEWCxTreap4NTok926sCg/K3
   7U83xjR3xTlLNHC3q7STw8+yHBJzv9ZwVGZSHUp4+ezx35XqFrFMYnCqB
   KN0umQi2RmxVCEY61pA5RIfNFY2gu7NyEmEZzYo1Sd7UI+LtktXXRcaPp
   jAYLyT38wPKI5tfh58xZ957CdkTwtqts5qLrdR8gGCtZweEBIDMpHxTbU
   w==;
X-CSE-ConnectionGUID: vnuj5SEMSGGlBPvOQsfYzg==
X-CSE-MsgGUID: 3viZPKbIQAixHVRh6GxOZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42797835"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42797835"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:13:42 -0800
X-CSE-ConnectionGUID: UrWXF7gpSaepiQoG9oPzNw==
X-CSE-MsgGUID: 7jnTXe9/RcKHwjO8XN2Q6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118724880"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:13:42 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel/ds: Clarify adaptive PEBS processing
Date: Wed, 13 Nov 2024 07:14:26 -0800
Message-Id: <20241113151427.677169-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Modify the pebs_basic and pebs_meminfo structs to make the bitfields
more explicit to ease readability of the code.

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c        | 43 ++++++++++++++-----------------
 arch/x86/include/asm/perf_event.h | 16 ++++++++++--
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8afc4ad3cd16..4d0f7c49295a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1917,8 +1917,6 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 }
 
 #define PEBS_LATENCY_MASK			0xffff
-#define PEBS_CACHE_LATENCY_OFFSET		32
-#define PEBS_RETIRE_LATENCY_OFFSET		32
 
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
@@ -1932,8 +1930,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct pebs_basic *basic = __pebs;
 	void *next_record = basic + 1;
-	u64 sample_type;
-	u64 format_size;
+	u64 sample_type, format_group;
 	struct pebs_meminfo *meminfo = NULL;
 	struct pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
@@ -1945,7 +1942,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_regs->xmm_regs = NULL;
 
 	sample_type = event->attr.sample_type;
-	format_size = basic->format_size;
+	format_group = basic->format_group;
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;
 
@@ -1967,7 +1964,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
-			data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+			data->weight.var3_w = basic->retire_latency;
 		else
 			data->weight.var3_w = 0;
 	}
@@ -1977,12 +1974,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
 	 * Save the pointer here but process later.
 	 */
-	if (format_size & PEBS_DATACFG_MEMINFO) {
+	if (format_group & PEBS_DATACFG_MEMINFO) {
 		meminfo = next_record;
 		next_record = meminfo + 1;
 	}
 
-	if (format_size & PEBS_DATACFG_GP) {
+	if (format_group & PEBS_DATACFG_GP) {
 		gprs = next_record;
 		next_record = gprs + 1;
 
@@ -1995,14 +1992,13 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 
-	if (format_size & PEBS_DATACFG_MEMINFO) {
+	if (format_group & PEBS_DATACFG_MEMINFO) {
 		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
-			u64 weight = meminfo->latency;
+			u64 latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+					meminfo->cache_latency : meminfo->mem_latency;
 
-			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY) {
-				data->weight.var2_w = weight & PEBS_LATENCY_MASK;
-				weight >>= PEBS_CACHE_LATENCY_OFFSET;
-			}
+			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
+				data->weight.var2_w = meminfo->instr_latency;
 
 			/*
 			 * Although meminfo::latency is defined as a u64,
@@ -2010,12 +2006,13 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			 * in practice on Ice Lake and earlier platforms.
 			 */
 			if (sample_type & PERF_SAMPLE_WEIGHT) {
-				data->weight.full = weight ?:
+				data->weight.full = latency ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			} else {
-				data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
+				data->weight.var1_dw = (u32)latency ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			}
+
 			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
@@ -2036,16 +2033,16 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
-	if (format_size & PEBS_DATACFG_XMMS) {
+	if (format_group & PEBS_DATACFG_XMMS) {
 		struct pebs_xmm *xmm = next_record;
 
 		next_record = xmm + 1;
 		perf_regs->xmm_regs = xmm->xmm;
 	}
 
-	if (format_size & PEBS_DATACFG_LBRS) {
+	if (format_group & PEBS_DATACFG_LBRS) {
 		struct lbr_entry *lbr = next_record;
-		int num_lbr = ((format_size >> PEBS_DATACFG_LBR_SHIFT)
+		int num_lbr = ((format_group >> PEBS_DATACFG_LBR_SHIFT)
 					& 0xff) + 1;
 		next_record = next_record + num_lbr * sizeof(struct lbr_entry);
 
@@ -2055,11 +2052,11 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
-	WARN_ONCE(next_record != __pebs + (format_size >> 48),
-			"PEBS record size %llu, expected %llu, config %llx\n",
-			format_size >> 48,
+	WARN_ONCE(next_record != __pebs + basic->format_size,
+			"PEBS record size %u, expected %llu, config %llx\n",
+			basic->format_size,
 			(u64)(next_record - __pebs),
-			basic->format_size);
+			format_group);
 }
 
 static inline void *
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 91b73571412f..cd8023d5ea46 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -422,7 +422,9 @@ static inline bool is_topdown_idx(int idx)
  */
 
 struct pebs_basic {
-	u64 format_size;
+	u64 format_group:32,
+	    retire_latency:16,
+	    format_size:16;
 	u64 ip;
 	u64 applicable_counters;
 	u64 tsc;
@@ -431,7 +433,17 @@ struct pebs_basic {
 struct pebs_meminfo {
 	u64 address;
 	u64 aux;
-	u64 latency;
+	union {
+		/* pre Alder Lake */
+		u64 mem_latency;
+		/* Alder Lake and later */
+		struct {
+			u64 instr_latency:16;
+			u64 pad2:16;
+			u64 cache_latency:16;
+			u64 pad3:16;
+		};
+	};
 	u64 tsx_tuning;
 };
 
-- 
2.38.1


