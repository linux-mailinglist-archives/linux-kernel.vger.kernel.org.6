Return-Path: <linux-kernel+bounces-414410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0409A9D2783
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F811F2377C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D91CF295;
	Tue, 19 Nov 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le+lCHpy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0361CDA3C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024700; cv=none; b=cf+q4F2QZXnbHvt5YSCXVwPxssFMgAwifjehBZpxXZZ5hYp6hZy0+V5ompc4JCxUolIOt9TL6Ld7TVETFVcPMhDGWVKgnGPkcQMuiodyoks+uwy+1L9x4d7SECc7TsCERr++smG7KT9Aw8U6pB4TiMbJq6vDpKVweCb+Tx0yX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024700; c=relaxed/simple;
	bh=JR/nwAP48AuhxV09njiBOtwRlN9cYWqv0/thXMn4tuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QaGmH7cU96Bg16gFxfyfHXY2gAXvyTFe8oW2cS82RQkyBR42KipOe+wEADQVOsZxie7KPIsiTlIEOPYvDoyhVsbnA3zON5W5uzwKS9reUGoq3i0gaqMtACqmIKWbnuWsSeebAZUro5ZpjXPMRX6G4diJqdi+NoateeNi2oT3lUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le+lCHpy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732024698; x=1763560698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JR/nwAP48AuhxV09njiBOtwRlN9cYWqv0/thXMn4tuA=;
  b=Le+lCHpyBc2fV86wokHuEcjL5OIsf3zTTX3RxQc6JsOla7i1bS2lZCps
   UoNrWZFxwTWiJ0vYuzxHjToqCfDz140GxxsRDucyDSj9v1wDEk05RM21x
   bVOPQiu92T+51A2Dgdit54JCxY2xP/7S1p+R7/NbVl4/fqQMkJwKJ0OYw
   4yaHiRwAD6CT4wSnRm6GXQIbdGirlBwJ+ytUSw2t+fGr+Yrekw9hKSF5T
   qIyIy2S7AxZFKkfnJ7ya8jCoESL4vdZaVSUd5k4wKkpuPSQ02/xLLG29z
   9XOQybWC3/T8zuHdZTgiByphDlCjc4LQCaJcXa97ZwW4itbgnojXbIS61
   w==;
X-CSE-ConnectionGUID: LWDkfalXRtCt6dtDK4xEBg==
X-CSE-MsgGUID: 6fMpCtfdTgeeFfC2/Oc4uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31435334"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31435334"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 05:58:15 -0800
X-CSE-ConnectionGUID: esUkFrnSTQSfo8eBdaCnSg==
X-CSE-MsgGUID: h3i/B5CVSYKCRv+tov+tUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89956372"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 19 Nov 2024 05:58:15 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/4] perf/x86/intel/ds: Simplify the PEBS records processing for adaptive PEBS
Date: Tue, 19 Nov 2024 05:55:04 -0800
Message-Id: <20241119135504.1463839-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241119135504.1463839-1-kan.liang@linux.intel.com>
References: <20241119135504.1463839-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current code may iterate all the PEBS records in the DS area several
times. The first loop is to find all active events and calculate the
available records for each event. Then iterate the whole buffer again
and again to process available records until all active events are
processed.

The algorithm is inherited from the old generations. The old PEBS
hardware does not deal well with the situation when events happen near
each other. SW has to drop the error records. Multiple iterations are
required.

The hardware limit has been addressed on newer platforms with adaptive
PEBS. A simple one-iteration algorithm is introduced.

The samples are output by record order with the patch, rather than the
event order. It doesn't impact the post-processing. The perf tool always
sorts the records by time before presenting them to the end user.

In an NMI, the last record has to be specially handled. Add a last[]
variable to track the last unprocessed record of each event.

Test:

11 PEBS events are used in the perf test. Only the basic information is
collected.
perf record -e instructions:up,...,instructions:up -c 2000003 benchmark

The ftrace is used to record the duration of the
intel_pmu_drain_pebs_icl().

The average duration reduced from 62.04us to 57.94us.

A small improvement can be observed with the new algorithm.
Also, the implementation becomes simpler and more straightforward.

Suggested-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 43 +++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index bf624499f3b4..dc9fe45df297 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2428,8 +2428,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	struct pebs_basic *basic;
 	struct perf_event *event;
 	void *base, *at, *top;
 	int bit;
@@ -2451,30 +2455,41 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		return;
 	}
 
-	for (at = base; at < top; at += cpuc->pebs_record_size) {
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	/* Process all but the last event for each counter. */
+	for (at = base; at < top; at += basic->format_size) {
 		u64 pebs_status;
 
-		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
-		pebs_status &= mask;
+		basic = at;
+		if (basic->format_size != cpuc->pebs_record_size)
+			continue;
+
+		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
+		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+			event = cpuc->events[bit];
 
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX)
-			counts[bit]++;
+			if (WARN_ON_ONCE(!event) ||
+			    WARN_ON_ONCE(!event->attr.precise_ip))
+				continue;
+
+			if (counts[bit]++) {
+				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
+						       setup_pebs_adaptive_sample_data);
+			}
+			last[bit] = at;
+		}
 	}
 
 	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (counts[bit] == 0)
+		if (!counts[bit])
 			continue;
 
 		event = cpuc->events[bit];
-		if (WARN_ON_ONCE(!event))
-			continue;
-
-		if (WARN_ON_ONCE(!event->attr.precise_ip))
-			continue;
 
-		__intel_pmu_pebs_events(event, iregs, data, base,
-					top, bit, counts[bit],
-					setup_pebs_adaptive_sample_data);
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_pebs_adaptive_sample_data);
 	}
 }
 
-- 
2.38.1


