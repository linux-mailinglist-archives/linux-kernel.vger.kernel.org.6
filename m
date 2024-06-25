Return-Path: <linux-kernel+bounces-229493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5891701C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45451F248A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658A17D896;
	Tue, 25 Jun 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+aVW/QD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4217CA13
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339764; cv=none; b=lscu842NK3sgnbSukrNm7OchUlm6UDHmlhaHBwMIrOrV43WGVAWnBcKHOQo8MGo9dUbMXDF54Saty+FrxQRrTIm9zuSAjhWn2zkQwnNJb+yUfGmv4RwiFMobur7pEQdZ0EMCTbI6pe/G+PgiaVhkQjbaaiX2y3rDQKFxzs8eWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339764; c=relaxed/simple;
	bh=aAnI62zH+6QngDV+jskU/yPVEijHGCG7ivpJaO16TRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TY0TZ/r3JIwUfBvSrwlAKQz0SL1AiBjutTN/4LrKjXmv4DkEomfJfKhS7J4t2RPtjC3l3MJk7+lZIvW8vFUzUq50SknQX4MvI0FW13HFp3dtLRX7omc8WIsp9fz64Ql6e02aMK4AWnQ+mdTmg5ez80KzjCjvc6Z5bjikpYFc1o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+aVW/QD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339763; x=1750875763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAnI62zH+6QngDV+jskU/yPVEijHGCG7ivpJaO16TRc=;
  b=W+aVW/QD6wu0aG6e9jwga4uZcn8vx436S2dFeW++L1VC/hmWeZDhwTm1
   8mtUQguR0CYed5KXbnZ+20n32jNw3Ok/4CPQAYXoDu3qIZU8z4AF80Uvf
   Tj1HTYkcMktjf3gogUqepTujwo8+I+wIg++69feXX6fg8Br0iCW3QpdOw
   vgiwXeRrZSbAFtZoS7/NSWyY0h8PwIDHl+pjSLbQ83y6Fw2K0astEowLZ
   2p1wA1LYrx9YKFSOmBYvcQc1UwLrXLMGNzfsq3R5H0dlv36v8M71+TSdQ
   40SJnSa+aI63qfDByUEh0b/x9FG5shnYpyLAjewB0kRkM1v6aEyf8W0WA
   w==;
X-CSE-ConnectionGUID: TixRUIcqTJCewy2s/H3SbA==
X-CSE-MsgGUID: zCN0FyF6QCeelQxyBKDUrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16204035"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16204035"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:22 -0700
X-CSE-ConnectionGUID: ekYt1c3IQCWro0dXKeAdlg==
X-CSE-MsgGUID: 6mBpSykhThu+iVG4hwS6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913356"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2024 11:22:07 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH V2 09/13] perf/x86: Extend event update interface
Date: Tue, 25 Jun 2024 11:22:52 -0700
Message-Id: <20240625182256.291914-10-kan.liang@linux.intel.com>
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

The current event update interface directly reads the values from the
counter, but the values may not be the accurate ones users require. For
example, the sample read feature wants the counter value of the member
events when the leader event is overflow. But with the current
implementation, the read (event update) actually happens in the NMI
handler. There may be a small gap between the overflow and the NMI
handler. The new Intel PEBS counters snapshotting feature can provide
the accurate counter value in the overflow. The event update interface
has to be updated to apply the given accurate values.

Pass the accurate values via the event update interface. If the value is
not available, still directly read the counter.

Using u64 * rather than u64 as the new parameter. Because 0 might be a
valid rdpmc() value. The !val cannot be used to distinguish between
there begin an argument and there not being one. Also, for some cases,
e.g., intel_update_topdown_event, there could be more than one
counter/register are read.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: silviazhao <silviazhao-oc@zhaoxin.com>
Cc: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/amd/core.c     |  2 +-
 arch/x86/events/core.c         | 13 ++++++-----
 arch/x86/events/intel/core.c   | 40 +++++++++++++++++++---------------
 arch/x86/events/intel/p4.c     |  2 +-
 arch/x86/events/perf_event.h   |  4 ++--
 arch/x86/events/zhaoxin/core.c |  2 +-
 6 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 42a9f97a9aed..7e017474ddb5 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -984,7 +984,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		event = cpuc->events[idx];
 		hwc = &event->hw;
-		x86_perf_event_update(event);
+		x86_perf_event_update(event, NULL);
 		mask = BIT_ULL(idx);
 
 		if (!(status & mask))
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 975b0f8a0b00..38754136ef82 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -112,7 +112,7 @@ u64 __read_mostly hw_cache_extra_regs
  * Can only be executed on the CPU where the event is active.
  * Returns the delta events processed.
  */
-u64 x86_perf_event_update(struct perf_event *event)
+u64 x86_perf_event_update(struct perf_event *event, u64 *val)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int shift = 64 - x86_pmu.cntval_bits;
@@ -131,7 +131,10 @@ u64 x86_perf_event_update(struct perf_event *event)
 	 */
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+		if (!val)
+			rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+		else
+			new_raw_count = *val;
 	} while (!local64_try_cmpxchg(&hwc->prev_count,
 				      &prev_raw_count, new_raw_count));
 
@@ -1598,7 +1601,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:
 		 */
-		static_call(x86_pmu_update)(event);
+		static_call(x86_pmu_update)(event, NULL);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -1689,7 +1692,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		event = cpuc->events[idx];
 
-		val = static_call(x86_pmu_update)(event);
+		val = static_call(x86_pmu_update)(event, NULL);
 		if (val & (1ULL << (x86_pmu.cntval_bits - 1)))
 			continue;
 
@@ -2036,7 +2039,7 @@ static void x86_pmu_static_call_update(void)
 
 static void _x86_pmu_read(struct perf_event *event)
 {
-	static_call(x86_pmu_update)(event);
+	static_call(x86_pmu_update)(event, NULL);
 }
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4810ff269b9a..8e9f2813eeea 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2418,7 +2418,7 @@ static void intel_pmu_nhm_workaround(void)
 	for (i = 0; i < 4; i++) {
 		event = cpuc->events[i];
 		if (event)
-			static_call(x86_pmu_update)(event);
+			static_call(x86_pmu_update)(event, NULL);
 	}
 
 	for (i = 0; i < 4; i++) {
@@ -2710,7 +2710,7 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
  * modify by a NMI. PMU has to be disabled before calling this function.
  */
 
-static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
+static u64 intel_update_topdown_event(struct perf_event *event, int metric_end, u64 *val)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2718,13 +2718,18 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	bool reset = true;
 	int idx;
 
-	/* read Fixed counter 3 */
-	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
-	if (!slots)
-		return 0;
+	if (!val) {
+		/* read Fixed counter 3 */
+		rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+		if (!slots)
+			return 0;
 
-	/* read PERF_METRICS */
-	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+		/* read PERF_METRICS */
+		rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+	} else {
+		slots = val[0];
+		metrics = val[1];
+	}
 
 	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
@@ -2767,10 +2772,11 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	return slots;
 }
 
-static u64 icl_update_topdown_event(struct perf_event *event)
+static u64 icl_update_topdown_event(struct perf_event *event, u64 *val)
 {
 	return intel_update_topdown_event(event, INTEL_PMC_IDX_METRIC_BASE +
-						 x86_pmu.num_topdown_events - 1);
+						 x86_pmu.num_topdown_events - 1,
+					  val);
 }
 
 DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
@@ -2785,7 +2791,7 @@ static void intel_pmu_read_topdown_event(struct perf_event *event)
 		return;
 
 	perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
+	static_call(intel_pmu_update_topdown_event)(event, NULL);
 	perf_pmu_enable(event->pmu);
 }
 
@@ -2796,7 +2802,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
 	else
-		x86_perf_event_update(event);
+		x86_perf_event_update(event, NULL);
 }
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
@@ -2899,7 +2905,7 @@ static void intel_pmu_add_event(struct perf_event *event)
  */
 int intel_pmu_save_and_restart(struct perf_event *event)
 {
-	static_call(x86_pmu_update)(event);
+	static_call(x86_pmu_update)(event, NULL);
 	/*
 	 * For a checkpointed counter always reset back to 0.  This
 	 * avoids a situation where the counter overflows, aborts the
@@ -2922,12 +2928,12 @@ static int intel_pmu_set_period(struct perf_event *event)
 	return x86_perf_event_set_period(event);
 }
 
-static u64 intel_pmu_update(struct perf_event *event)
+static u64 intel_pmu_update(struct perf_event *event, u64 *val)
 {
 	if (unlikely(is_topdown_count(event)))
-		return static_call(intel_pmu_update_topdown_event)(event);
+		return static_call(intel_pmu_update_topdown_event)(event, val);
 
-	return x86_perf_event_update(event);
+	return x86_perf_event_update(event, val);
 }
 
 static void intel_pmu_reset(void)
@@ -3091,7 +3097,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		static_call(intel_pmu_update_topdown_event)(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
 	/*
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 844bc4fc4724..3177be0dedd1 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1058,7 +1058,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 		/* it might be unflagged overflow */
 		overflow = p4_pmu_clear_cccr_ovf(hwc);
 
-		val = x86_perf_event_update(event);
+		val = x86_perf_event_update(event, NULL);
 		if (!overflow && (val & (1ULL << (x86_pmu.cntval_bits - 1))))
 			continue;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8e3f2644a1a3..f6b57f0b2787 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -782,7 +782,7 @@ struct x86_pmu {
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
 	int		(*set_period)(struct perf_event *event);
-	u64		(*update)(struct perf_event *event);
+	u64		(*update)(struct perf_event *event, u64 *val);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
@@ -1131,7 +1131,7 @@ extern u64 __read_mostly hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX];
 
-u64 x86_perf_event_update(struct perf_event *event);
+u64 x86_perf_event_update(struct perf_event *event, u64 *cntr);
 
 static inline unsigned int x86_pmu_config_addr(int index)
 {
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0cf9a5e..5fe3a9eed650 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -391,7 +391,7 @@ static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
 
-		x86_perf_event_update(event);
+		x86_perf_event_update(event, NULL);
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (!x86_perf_event_set_period(event))
-- 
2.35.1


