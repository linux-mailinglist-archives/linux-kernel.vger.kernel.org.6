Return-Path: <linux-kernel+bounces-206716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F20900CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D21F21A97
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC415532C;
	Fri,  7 Jun 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNcY58s/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8E1552FE;
	Fri,  7 Jun 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792327; cv=none; b=jcN5oPkVksvNjAePAH9uY0VG141SX75rwvjQ1bdcgnhYCdaYtuS5N3aN/lg0xLaYwek+ZcHhtVvarIXq+uCBaQ5iCkk+IpAnV/LYWLRSUtCN7KxbfwuFG8kjC0WNtYPwkmYG3ak2nrUHV2yfUA9SkmwBkIhtBG92xnz3l6Df948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792327; c=relaxed/simple;
	bh=Kh3hE+1Gs+zXanDUXgcZshpNG3gFdrLfk06vy2eXTqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJRckcFzv2jzvgtefI+hbOhNBUEs87qreMFrGIx4Fyd9CyeFPFXKzo9tg2E9LVwxdfavQhPr3Ck05z2KpaELRrGzUPMa3rDulI6H9GfjxoQLX4lCNU1JISrMiMbf9KXeK1RrA6+ONLVgxTRNVLjmcxUUrPh4k/+BO4+RRdU7lG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNcY58s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDD7C2BBFC;
	Fri,  7 Jun 2024 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792327;
	bh=Kh3hE+1Gs+zXanDUXgcZshpNG3gFdrLfk06vy2eXTqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lNcY58s/uDW/WxxDrRVPAGaP3/klN9jQ4olwzRdIQ6s8JkboXuf7ssp/WU0NTmKZs
	 cV2tAAbDJjm7flpE85JsszWpa0mnprEC3oxXkX/Ra4Uw2tYTXGodu2gPfPAz47y2IE
	 FEEu71K2DjIQqtWFrLxZIFNXapAH9nLGODuLyKf3XxY6YtCOWtW3XlkMWRAoCVy0c0
	 wlJNSbQQt6naBeOgZaSa3Hxbdgfcx62+dB/8XR+XrX8fCnO/4b871TdZ27RqoeappS
	 UYl4osRKMmr96JYirBqcIZaCe/yhpd+WxnJrCfcatjuThwco95kjP3NzKS/QV73rG6
	 ekFzRycTEl4Og==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 07 Jun 2024 14:31:28 -0600
Subject: [PATCH 3/9] perf: arm_pmu: Remove event index to counter remapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-arm-pmu-3-9-icntr-v1-3-c7bd2dceff3b@kernel.org>
References: <20240607-arm-pmu-3-9-icntr-v1-0-c7bd2dceff3b@kernel.org>
In-Reply-To: <20240607-arm-pmu-3-9-icntr-v1-0-c7bd2dceff3b@kernel.org>
To: Russell King <linux@armlinux.org.uk>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14-dev

Xscale and Armv6 PMUs defined the cycle counter at 0 and event counters
starting at 1 and had 1:1 event index to counter numbering. On Armv7 and
later, this changed the cycle counter to 31 and event counters start at
0. The drivers for Armv7 and PMUv3 kept the old event index numbering
and introduced an event index to counter conversion. The conversion uses
masking to convert from event index to a counter number. This operation
relies on having at most 32 counters so that the cycle counter index 0
can be transformed to counter number 31.

Armv9.4 adds support for an additional fixed function counter
(instructions) which increases possible counters to more than 32, and
the conversion won't work anymore as a simple subtract and mask. The
primary reason for the translation (other than history) seems to be to
have a contiguous mask of counters 0-N. Keeping that would result in
more complicated index to counter conversions. Instead, store a mask of
available counters rather than just number of events. That provides more
information in addition to the number of events.

No (intended) functional changes.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/kvm/pmu-emul.c     |  6 ++--
 drivers/perf/arm_pmu.c        | 11 ++++---
 drivers/perf/arm_pmuv3.c      | 57 ++++++++++----------------------
 drivers/perf/arm_v6_pmu.c     |  6 ++--
 drivers/perf/arm_v7_pmu.c     | 77 ++++++++++++++++---------------------------
 drivers/perf/arm_xscale_pmu.c | 12 ++++---
 include/linux/perf/arm_pmu.h  |  2 +-
 7 files changed, 69 insertions(+), 102 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a35ce10e0a9f..da5ba9d061e8 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -911,10 +911,10 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
 
 	/*
-	 * The arm_pmu->num_events considers the cycle counter as well.
-	 * Ignore that and return only the general-purpose counters.
+	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
+	 * Ignore those and return only the general-purpose counters.
 	 */
-	return arm_pmu->num_events - 1;
+	return bitmap_weight(arm_pmu->cntr_mask, 31);
 }
 
 static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8458fe2cebb4..398cce3d76fc 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -522,7 +522,7 @@ static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
-	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
+	bool enabled = !bitmap_empty(hw_events->used_mask, ARMPMU_MAX_HWEVENTS);
 
 	/* For task-bound events we may be called on other CPUs */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
@@ -742,7 +742,7 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 	struct perf_event *event;
 	int idx;
 
-	for (idx = 0; idx < armpmu->num_events; idx++) {
+	for_each_set_bit(idx, armpmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		event = hw_events->events[idx];
 		if (!event)
 			continue;
@@ -772,7 +772,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 {
 	struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
-	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
+	bool enabled = !bitmap_empty(hw_events->used_mask, ARMPMU_MAX_HWEVENTS);
 
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return NOTIFY_DONE;
@@ -924,8 +924,9 @@ int armpmu_register(struct arm_pmu *pmu)
 	if (ret)
 		goto out_destroy;
 
-	pr_info("enabled with %s PMU driver, %d counters available%s\n",
-		pmu->name, pmu->num_events,
+	pr_info("enabled with %s PMU driver, %d (%*pb) counters available%s\n",
+		pmu->name, bitmap_weight(pmu->cntr_mask, ARMPMU_MAX_HWEVENTS),
+		ARMPMU_MAX_HWEVENTS, &pmu->cntr_mask,
 		has_nmi ? ", using NMIs" : "");
 
 	kvm_host_pmu_init(pmu);
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..80202346fc7a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -451,9 +451,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
 /*
  * Perf Events' indices
  */
-#define	ARMV8_IDX_CYCLE_COUNTER	0
-#define	ARMV8_IDX_COUNTER0	1
-#define	ARMV8_IDX_CYCLE_COUNTER_USER	32
+#define	ARMV8_IDX_CYCLE_COUNTER	31
 
 /*
  * We unconditionally enable ARMv8.5-PMU long event counter support
@@ -492,13 +490,6 @@ static bool armv8pmu_event_is_chained(struct perf_event *event)
 /*
  * ARMv8 low level PMU access
  */
-
-/*
- * Perf Event to low level counters mapping
- */
-#define	ARMV8_IDX_TO_COUNTER(x)	\
-	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
-
 static u64 armv8pmu_pmcr_read(void)
 {
 	return read_pmcr();
@@ -518,14 +509,12 @@ static int armv8pmu_has_overflowed(u32 pmovsr)
 
 static int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 {
-	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
+	return pmnc & BIT(idx);
 }
 
 static u64 armv8pmu_read_evcntr(int idx)
 {
-	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-
-	return read_pmevcntrn(counter);
+	return read_pmevcntrn(idx);
 }
 
 static u64 armv8pmu_read_hw_counter(struct perf_event *event)
@@ -592,9 +581,7 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
 
 static void armv8pmu_write_evcntr(int idx, u64 value)
 {
-	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-
-	write_pmevcntrn(counter, value);
+	write_pmevcntrn(idx, value);
 }
 
 static void armv8pmu_write_hw_counter(struct perf_event *event,
@@ -625,7 +612,6 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 
 static void armv8pmu_write_evtype(int idx, unsigned long val)
 {
-	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
 			     ARMV8_PMU_INCLUDE_EL2 |
 			     ARMV8_PMU_EXCLUDE_EL0 |
@@ -635,7 +621,7 @@ static void armv8pmu_write_evtype(int idx, unsigned long val)
 		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
 
 	val &= mask;
-	write_pmevtypern(counter, val);
+	write_pmevtypern(idx, val);
 }
 
 static void armv8pmu_write_event_type(struct perf_event *event)
@@ -664,7 +650,7 @@ static void armv8pmu_write_event_type(struct perf_event *event)
 
 static u32 armv8pmu_event_cnten_mask(struct perf_event *event)
 {
-	int counter = ARMV8_IDX_TO_COUNTER(event->hw.idx);
+	int counter = event->hw.idx;
 	u32 mask = BIT(counter);
 
 	if (armv8pmu_event_is_chained(event))
@@ -723,8 +709,7 @@ static void armv8pmu_enable_intens(u32 mask)
 
 static void armv8pmu_enable_event_irq(struct perf_event *event)
 {
-	u32 counter = ARMV8_IDX_TO_COUNTER(event->hw.idx);
-	armv8pmu_enable_intens(BIT(counter));
+	armv8pmu_enable_intens(BIT(event->hw.idx));
 }
 
 static void armv8pmu_disable_intens(u32 mask)
@@ -738,8 +723,7 @@ static void armv8pmu_disable_intens(u32 mask)
 
 static void armv8pmu_disable_event_irq(struct perf_event *event)
 {
-	u32 counter = ARMV8_IDX_TO_COUNTER(event->hw.idx);
-	armv8pmu_disable_intens(BIT(counter));
+	armv8pmu_disable_intens(BIT(event->hw.idx));
 }
 
 static u32 armv8pmu_getreset_flags(void)
@@ -783,7 +767,7 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/* Clear any unused counters to avoid leaking their contents */
-	for_each_clear_bit(i, cpuc->used_mask, cpu_pmu->num_events) {
+	for_each_clear_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
 		if (i == ARMV8_IDX_CYCLE_COUNTER)
 			write_pmccntr(0);
 		else
@@ -866,7 +850,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 * to prevent skews in group events.
 	 */
 	armv8pmu_stop(cpu_pmu);
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -905,7 +889,7 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 {
 	int idx;
 
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, 31) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -921,7 +905,9 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
 	 * Chaining requires two consecutive event counters, where
 	 * the lower idx must be even.
 	 */
-	for (idx = ARMV8_IDX_COUNTER0 + 1; idx < cpu_pmu->num_events; idx += 2) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, 31) {
+		if (!(idx & 0x1))
+			continue;
 		if (!test_and_set_bit(idx, cpuc->used_mask)) {
 			/* Check if the preceding even counter is available */
 			if (!test_and_set_bit(idx - 1, cpuc->used_mask))
@@ -974,15 +960,7 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 	if (!sysctl_perf_user_access || !armv8pmu_event_has_user_read(event))
 		return 0;
 
-	/*
-	 * We remap the cycle counter index to 32 to
-	 * match the offset applied to the rest of
-	 * the counter indices.
-	 */
-	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
-		return ARMV8_IDX_CYCLE_COUNTER_USER;
-
-	return event->hw.idx;
+	return event->hw.idx + 1;
 }
 
 /*
@@ -1207,10 +1185,11 @@ static void __armv8pmu_probe_pmu(void *info)
 	probe->present = true;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	cpu_pmu->num_events = FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
+	bitmap_set(cpu_pmu->cntr_mask,
+		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
 
 	/* Add the CPU cycles counter */
-	cpu_pmu->num_events += 1;
+	bitmap_set(cpu_pmu->cntr_mask, ARMV8_IDX_CYCLE_COUNTER, 1);
 
 	pmceid[0] = pmceid_raw[0] = read_pmceid0();
 	pmceid[1] = pmceid_raw[1] = read_pmceid1();
diff --git a/drivers/perf/arm_v6_pmu.c b/drivers/perf/arm_v6_pmu.c
index 0bb685b4bac5..b09615bb2bb2 100644
--- a/drivers/perf/arm_v6_pmu.c
+++ b/drivers/perf/arm_v6_pmu.c
@@ -64,6 +64,7 @@ enum armv6_counters {
 	ARMV6_CYCLE_COUNTER = 0,
 	ARMV6_COUNTER0,
 	ARMV6_COUNTER1,
+	ARMV6_NUM_COUNTERS
 };
 
 /*
@@ -254,7 +255,7 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 */
 	armv6_pmcr_write(pmcr);
 
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV6_NUM_COUNTERS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -391,7 +392,8 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->start		= armv6pmu_start;
 	cpu_pmu->stop		= armv6pmu_stop;
 	cpu_pmu->map_event	= armv6_map_event;
-	cpu_pmu->num_events	= 3;
+
+	bitmap_set(cpu_pmu->cntr_mask, 0, ARMV6_NUM_COUNTERS);
 }
 
 static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
index 928ac3d626ed..d815fcde7d84 100644
--- a/drivers/perf/arm_v7_pmu.c
+++ b/drivers/perf/arm_v7_pmu.c
@@ -649,24 +649,12 @@ static struct attribute_group armv7_pmuv2_events_attr_group = {
 /*
  * Perf Events' indices
  */
-#define	ARMV7_IDX_CYCLE_COUNTER	0
-#define	ARMV7_IDX_COUNTER0	1
-#define	ARMV7_IDX_COUNTER_LAST(cpu_pmu) \
-	(ARMV7_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
-
-#define	ARMV7_MAX_COUNTERS	32
-#define	ARMV7_COUNTER_MASK	(ARMV7_MAX_COUNTERS - 1)
-
+#define	ARMV7_IDX_CYCLE_COUNTER	31
+#define	ARMV7_IDX_COUNTER_MAX	31
 /*
  * ARMv7 low level PMNC access
  */
 
-/*
- * Perf Event to low level counters mapping
- */
-#define	ARMV7_IDX_TO_COUNTER(x)	\
-	(((x) - ARMV7_IDX_COUNTER0) & ARMV7_COUNTER_MASK)
-
 /*
  * Per-CPU PMNC: config reg
  */
@@ -725,19 +713,17 @@ static inline int armv7_pmnc_has_overflowed(u32 pmnc)
 
 static inline int armv7_pmnc_counter_valid(struct arm_pmu *cpu_pmu, int idx)
 {
-	return idx >= ARMV7_IDX_CYCLE_COUNTER &&
-		idx <= ARMV7_IDX_COUNTER_LAST(cpu_pmu);
+	return test_bit(idx, cpu_pmu->cntr_mask);
 }
 
 static inline int armv7_pmnc_counter_has_overflowed(u32 pmnc, int idx)
 {
-	return pmnc & BIT(ARMV7_IDX_TO_COUNTER(idx));
+	return pmnc & BIT(idx);
 }
 
 static inline void armv7_pmnc_select_counter(int idx)
 {
-	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
-	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (counter));
+	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (idx));
 	isb();
 }
 
@@ -787,29 +773,25 @@ static inline void armv7_pmnc_write_evtsel(int idx, u32 val)
 
 static inline void armv7_pmnc_enable_counter(int idx)
 {
-	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
-	asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (BIT(counter)));
+	asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (BIT(idx)));
 }
 
 static inline void armv7_pmnc_disable_counter(int idx)
 {
-	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
-	asm volatile("mcr p15, 0, %0, c9, c12, 2" : : "r" (BIT(counter)));
+	asm volatile("mcr p15, 0, %0, c9, c12, 2" : : "r" (BIT(idx)));
 }
 
 static inline void armv7_pmnc_enable_intens(int idx)
 {
-	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
-	asm volatile("mcr p15, 0, %0, c9, c14, 1" : : "r" (BIT(counter)));
+	asm volatile("mcr p15, 0, %0, c9, c14, 1" : : "r" (BIT(idx)));
 }
 
 static inline void armv7_pmnc_disable_intens(int idx)
 {
-	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
-	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (BIT(counter)));
+	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (BIT(idx)));
 	isb();
 	/* Clear the overflow flag in case an interrupt is pending. */
-	asm volatile("mcr p15, 0, %0, c9, c12, 3" : : "r" (BIT(counter)));
+	asm volatile("mcr p15, 0, %0, c9, c12, 3" : : "r" (BIT(idx)));
 	isb();
 }
 
@@ -853,15 +835,12 @@ static void armv7_pmnc_dump_regs(struct arm_pmu *cpu_pmu)
 	asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (val));
 	pr_info("CCNT  =0x%08x\n", val);
 
-	for (cnt = ARMV7_IDX_COUNTER0;
-			cnt <= ARMV7_IDX_COUNTER_LAST(cpu_pmu); cnt++) {
+	for_each_set_bit(cnt, cpu_pmu->cntr_mask, ARMV7_IDX_COUNTER_MAX) {
 		armv7_pmnc_select_counter(cnt);
 		asm volatile("mrc p15, 0, %0, c9, c13, 2" : "=r" (val));
-		pr_info("CNT[%d] count =0x%08x\n",
-			ARMV7_IDX_TO_COUNTER(cnt), val);
+		pr_info("CNT[%d] count =0x%08x\n", cnt, val);
 		asm volatile("mrc p15, 0, %0, c9, c13, 1" : "=r" (val));
-		pr_info("CNT[%d] evtsel=0x%08x\n",
-			ARMV7_IDX_TO_COUNTER(cnt), val);
+		pr_info("CNT[%d] evtsel=0x%08x\n", cnt, val);
 	}
 }
 #endif
@@ -958,7 +937,7 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 */
 	regs = get_irq_regs();
 
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -1027,7 +1006,7 @@ static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * For anything other than a cycle counter, try and use
 	 * the events counters
 	 */
-	for (idx = ARMV7_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV7_IDX_COUNTER_MAX) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -1073,7 +1052,7 @@ static int armv7pmu_set_event_filter(struct hw_perf_event *event,
 static void armv7pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
-	u32 idx, nb_cnt = cpu_pmu->num_events, val;
+	u32 idx, val;
 
 	if (cpu_pmu->secure_access) {
 		asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (val));
@@ -1082,7 +1061,7 @@ static void armv7pmu_reset(void *info)
 	}
 
 	/* The counter and interrupt enable registers are unknown at reset. */
-	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		armv7_pmnc_disable_counter(idx);
 		armv7_pmnc_disable_intens(idx);
 	}
@@ -1161,20 +1140,22 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
 
 static void armv7_read_num_pmnc_events(void *info)
 {
-	int *nb_cnt = info;
+	int nb_cnt;
+	struct arm_pmu *cpu_pmu = info;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	*nb_cnt = (armv7_pmnc_read() >> ARMV7_PMNC_N_SHIFT) & ARMV7_PMNC_N_MASK;
+	nb_cnt = (armv7_pmnc_read() >> ARMV7_PMNC_N_SHIFT) & ARMV7_PMNC_N_MASK;
+	bitmap_set(cpu_pmu->cntr_mask, 0, nb_cnt);
 
 	/* Add the CPU cycles counter */
-	*nb_cnt += 1;
+	bitmap_set(cpu_pmu->cntr_mask, ARMV7_IDX_CYCLE_COUNTER, 1);
 }
 
 static int armv7_probe_num_events(struct arm_pmu *arm_pmu)
 {
 	return smp_call_function_any(&arm_pmu->supported_cpus,
 				     armv7_read_num_pmnc_events,
-				     &arm_pmu->num_events, 1);
+				     arm_pmu, 1);
 }
 
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1524,7 +1505,7 @@ static void krait_pmu_reset(void *info)
 {
 	u32 vval, fval;
 	struct arm_pmu *cpu_pmu = info;
-	u32 idx, nb_cnt = cpu_pmu->num_events;
+	u32 idx;
 
 	armv7pmu_reset(info);
 
@@ -1538,7 +1519,7 @@ static void krait_pmu_reset(void *info)
 	venum_post_pmresr(vval, fval);
 
 	/* Reset PMxEVNCTCR to sane default */
-	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV7_IDX_COUNTER_MAX) {
 		armv7_pmnc_select_counter(idx);
 		asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
 	}
@@ -1562,7 +1543,7 @@ static int krait_event_to_bit(struct perf_event *event, unsigned int region,
 	 * Lower bits are reserved for use by the counters (see
 	 * armv7pmu_get_event_idx() for more info)
 	 */
-	bit += ARMV7_IDX_COUNTER_LAST(cpu_pmu) + 1;
+	bit += bitmap_weight(cpu_pmu->cntr_mask, ARMV7_IDX_COUNTER_MAX);
 
 	return bit;
 }
@@ -1845,7 +1826,7 @@ static void scorpion_pmu_reset(void *info)
 {
 	u32 vval, fval;
 	struct arm_pmu *cpu_pmu = info;
-	u32 idx, nb_cnt = cpu_pmu->num_events;
+	u32 idx;
 
 	armv7pmu_reset(info);
 
@@ -1860,7 +1841,7 @@ static void scorpion_pmu_reset(void *info)
 	venum_post_pmresr(vval, fval);
 
 	/* Reset PMxEVNCTCR to sane default */
-	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV7_IDX_COUNTER_MAX) {
 		armv7_pmnc_select_counter(idx);
 		asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
 	}
@@ -1883,7 +1864,7 @@ static int scorpion_event_to_bit(struct perf_event *event, unsigned int region,
 	 * Lower bits are reserved for use by the counters (see
 	 * armv7pmu_get_event_idx() for more info)
 	 */
-	bit += ARMV7_IDX_COUNTER_LAST(cpu_pmu) + 1;
+	bit += bitmap_weight(cpu_pmu->cntr_mask, ARMV7_IDX_COUNTER_MAX);
 
 	return bit;
 }
diff --git a/drivers/perf/arm_xscale_pmu.c b/drivers/perf/arm_xscale_pmu.c
index 3d8b72d6b37f..e075df521350 100644
--- a/drivers/perf/arm_xscale_pmu.c
+++ b/drivers/perf/arm_xscale_pmu.c
@@ -52,6 +52,8 @@ enum xscale_counters {
 	XSCALE_COUNTER1,
 	XSCALE_COUNTER2,
 	XSCALE_COUNTER3,
+	XSCALE2_NUM_COUNTERS,
+	XSCALE_NUM_COUNTERS = 3,
 };
 
 static const unsigned xscale_perf_map[PERF_COUNT_HW_MAX] = {
@@ -168,7 +170,7 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 	regs = get_irq_regs();
 
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, XSCALE_NUM_COUNTERS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -364,7 +366,8 @@ static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->start		= xscale1pmu_start;
 	cpu_pmu->stop		= xscale1pmu_stop;
 	cpu_pmu->map_event	= xscale_map_event;
-	cpu_pmu->num_events	= 3;
+
+	bitmap_set(cpu_pmu->cntr_mask, 0, XSCALE_NUM_COUNTERS);
 
 	return 0;
 }
@@ -500,7 +503,7 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 	regs = get_irq_regs();
 
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, XSCALE2_NUM_COUNTERS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -719,7 +722,8 @@ static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->start		= xscale2pmu_start;
 	cpu_pmu->stop		= xscale2pmu_stop;
 	cpu_pmu->map_event	= xscale_map_event;
-	cpu_pmu->num_events	= 5;
+
+	bitmap_set(cpu_pmu->cntr_mask, 0, XSCALE2_NUM_COUNTERS);
 
 	return 0;
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index b3b34f6670cf..e5d6d204beab 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -96,7 +96,7 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
-	int		num_events;
+	DECLARE_BITMAP(cntr_mask, ARMPMU_MAX_HWEVENTS);
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);

-- 
2.43.0


