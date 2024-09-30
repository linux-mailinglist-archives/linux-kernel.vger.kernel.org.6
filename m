Return-Path: <linux-kernel+bounces-344381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3F98A8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22838B2386A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA28192B66;
	Mon, 30 Sep 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxxHyVqy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B2192D63
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710879; cv=none; b=GImUDDRP21dXPLAiWByUj+EDHuAJNQvZhFS74crlhdBueVRcruB0gHj5ngnM54XE8fBqic8h2Ln1t6Ext0jnmLsFhlFocLCNkfGhV8dbb0R+tao4gCZOKkYYoos2mUN4MwEt9pcH+4Z24Hrx+9Ssg80zyU5J5iy/20tBwB/1EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710879; c=relaxed/simple;
	bh=Hf0gQl7FqEmYbKbq/BqGKZ9vk+i0JlafNCp2PN5zJNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPxSNHHfYMbvnWM0Z5+8wGuYJtOqH756DjaWpsvzfeYwsJpoVIudUNffLFuluyq06PI4S4fM4ECTdPDCPXHqkQSkJXUvHFCl1J5KnuBLtthVVnUnxbed2a6NO1GWd1OtdBrViMgOIzhDWp+qrLXDNFQdrKuk5B+8AmaxKEPsBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxxHyVqy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727710877; x=1759246877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hf0gQl7FqEmYbKbq/BqGKZ9vk+i0JlafNCp2PN5zJNo=;
  b=WxxHyVqy9ekoWzuVi3BXfVeQGhOIoCYLoV8sLgVqffHuukloChSQ0GgM
   leMtzNqAwTMt3paRN43RJ528Nr/9iYfrMBe6LyYd9oJeQSyJfzpZeVEDh
   Gz5jRh2ChYTtklTxI+iSkniPyrPEuqb7sWEiIgqM/gQwHg14iPpb9VoaW
   09bbZVWhqKWKiO2M/7I+hYsrZVICFSfzooFTjy9aH+UO/sN/LK1oRQ8aj
   TYwH2CMcpDxMV142u18uaHpkXZlNJqgQTuxYa2W7BpRNIx64wKdrjrw63
   c6KQKD9bGNYDrFR5qPW3RUcu86Am2Cj9CbcyXB1jZDQH1G31xUTZ2gUS1
   A==;
X-CSE-ConnectionGUID: LiFfm4n8Q9GMgL7gj8qPwg==
X-CSE-MsgGUID: NJoug97FQcChaB101soQbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26272164"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26272164"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 08:41:13 -0700
X-CSE-ConnectionGUID: iQwy09IPTFO/0gyYINNLTw==
X-CSE-MsgGUID: 0lsQUraUQ4uVylX60P+DaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78172484"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 30 Sep 2024 08:41:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	ak@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/intel: Support auto counter reload
Date: Mon, 30 Sep 2024 08:41:22 -0700
Message-Id: <20240930154122.578924-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240930154122.578924-1-kan.liang@linux.intel.com>
References: <20240930154122.578924-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The relative rates among two or more events are useful for performance
analysis, e.g., a high branch miss rate may indicate a performance
issue. Usually, the samples with a relative rate that exceeds some
threshold are more useful. However, the traditional sampling takes
samples of events separately. To get the relative rates among two or
more events, a high sample rate is required, which can bring high
overhead. Many samples taken in the non-hotspot area are also dropped
(useless) in the post-process.

The auto counter reload (ACR) feature takes samples when the relative
rate of two or more events exceeds some threshold, which provides the
fine-grained information at a low cost.
To support the feature, two sets of MSRs are introduced. For a given
counter IA32_PMC_GPn_CTR/IA32_PMC_FXm_CTR, bit fields in the
IA32_PMC_GPn_CFG_B/IA32_PMC_FXm_CFG_B MSR indicate which counter(s)
can cause a reload of that counter. The reload value is stored in the
IA32_PMC_GPn_CFG_C/IA32_PMC_FXm_CFG_C.
The details can be found at Intel Architecture Instruction Set
Extensions and Future Features (053) 8.7 AUTO COUNTER RELOAD.

The ACR event/group needs to be specially configured. Because the
counter mask of an event has to be recalculated according to both the
original mask and the reloadable counter mask. The new counter mask is
stored into the new field, dyn_mask, in struct hw_perf_event.
Also, add a new flag PERF_X86_EVENT_ACR to indicate an ACR group, which
is set to the group leader.

The ACR configuration MSRs are only updated in the enable_event().
The disable_event() doesn't clear the ACR CFG register.
Add acr_cfg_b/acr_cfg_c in the struct cpu_hw_events to cache the MSR
values. It can avoid a MSR write if the value is not changed.

Expose a acr_mask to the sysfs. The perf tool can utilize the new format
to configure the relation of events in the group. The bit sequence of
the acr_mask follows the events enabled order of the group. The
kernel will convert it to the real counter order and save the updated
order into the newly added hw.config1 every time the group is scheduled.
The hw.config1 is eventually to be written to the ACR config MSR
(MSR_IA32_PMC_GP/FX_CFG_B) when the event is enabled.

Example:

Here is the snippet of the mispredict.c. Since the array has random
numbers, jumps are random and often mispredicted.
The mispredicted rate depends on the compared value.

For the Loop1, ~11% of all branches are mispredicted.
For the Loop2, ~21% of all branches are mispredicted.

main()
{
...
        for (i = 0; i < N; i++)
                data[i] = rand() % 256;
...
        /* Loop 1 */
        for (k = 0; k < 50; k++)
                for (i = 0; i < N; i++)
                        if (data[i] >= 64)
                                sum += data[i];
...

...
        /* Loop 2 */
        for (k = 0; k < 50; k++)
                for (i = 0; i < N; i++)
                        if (data[i] >= 128)
                                sum += data[i];
...
}

Usually, a code with a high branch miss rate means a bad performance.
To understand the branch miss rate of the codes, the traditional method
usually sample both branches and branch-misses events. E.g.,
perf record -e "{cpu_atom/branch-misses/ppu, cpu_atom/branch-instructions/u}"
               -c 1000000 -- ./mispredict

[ perf record: Woken up 4 times to write data ]
[ perf record: Captured and wrote 0.925 MB perf.data (5106 samples) ]
The 5106 samples are from both events and spread in both Loops.
In the post process stage, a user can know that the Loop 2 has a 21%
branch miss rate. Then they can focus on the samples of branch-misses
events for the Loop 2.

With this patch, the user can generate the samples only when the branch
miss rate > 20%. For example,
perf record -e "{cpu_atom/branch-misses,period=200000,acr_mask=0x2/ppu,
                 cpu_atom/branch-instructions,period=1000000,acr_mask=0x3/u}"
                -- ./mispredict

(Two different periods are applied to branch-misses and
branch-instructions. The ratio is 20%. If the branch-instructions is
overflowed first, the branch miss rate < 20%. No samples should be
generated. All counters should be automatically reloaded. The acr_mask
is set to 0x3. If the branch-misses is overflowed first, the branch miss
rate > 20%. A sample triggered by the branch-misses event should be
generated. The counter of the branch-instructions should be
automatically reloaded. The acr_mask is set to 0x2, since the
branch-misses event is the first event in the group.)

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.098 MB perf.data (2498 samples) ]

 $perf report

Percent       │154:   movl    $0x0,-0x14(%rbp)
              │     ↓ jmp     1af
              │     for (i = j; i < N; i++)
              │15d:   mov     -0x10(%rbp),%eax
              │       mov     %eax,-0x18(%rbp)
              │     ↓ jmp     1a2
              │     if (data[i] >= 128)
              │165:   mov     -0x18(%rbp),%eax
              │       cltq
              │       lea     0x0(,%rax,4),%rdx
              │       mov     -0x8(%rbp),%rax
              │       add     %rdx,%rax
              │       mov     (%rax),%eax
              │    ┌──cmp     $0x7f,%eax
100.00   0.00 │    ├──jle     19e
              │    │sum += data[i];

The 2498 samples are all from the branch-misses events for the Loop 2.

The number of samples and overhead is significantly reduced without
losing any information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c       | 231 ++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h       |   9 ++
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/msr-index.h   |   4 +
 include/linux/perf_event.h         |   2 +
 5 files changed, 246 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 57e4dc0a7b23..dde50da46441 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2854,6 +2854,54 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	cpuc->fixed_ctrl_val |= bits;
 }
 
+static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int msr_b, msr_c;
+
+	if (!mask && cpuc->acr_cfg_b[idx] == mask)
+		return;
+
+	if (idx < INTEL_PMC_IDX_FIXED) {
+		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
+		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
+	} else {
+		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
+		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
+		idx -= INTEL_PMC_IDX_FIXED;
+	}
+
+	if (cpuc->acr_cfg_b[idx] != mask) {
+		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
+		cpuc->acr_cfg_b[idx] = mask;
+	}
+	/* Only need to update the reload value when there is a valid config value. */
+	if (mask && cpuc->acr_cfg_c[idx] != reload) {
+		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
+		cpuc->acr_cfg_c[idx] = reload;
+	}
+}
+
+static void intel_pmu_enable_acr(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* The PMU doesn't support ACR */
+	if (!hybrid(event->pmu, acr_cntr_mask64))
+		return;
+
+	if (!is_acr_event_group(event) || !event->attr.config2) {
+		/*
+		 * The disable doesn't clear the ACR CFG register.
+		 * Check and clear the ACR CFG register.
+		 */
+		intel_pmu_config_acr(hwc->idx, 0, 0);
+		return;
+	}
+
+	intel_pmu_config_acr(hwc->idx, hwc->config1, -hwc->sample_period);
+}
+
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
@@ -2869,10 +2917,12 @@ static void intel_pmu_enable_event(struct perf_event *event)
 			enable_mask |= ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
 		__x86_pmu_enable_event(hwc, enable_mask);
+		intel_pmu_enable_acr(event);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
+		intel_pmu_enable_acr(event);
 		break;
 	case INTEL_PMC_IDX_FIXED_BTS:
 		if (!__this_cpu_read(cpu_hw_events.enabled))
@@ -3690,6 +3740,12 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		c2->weight = hweight64(c2->idxmsk64);
 	}
 
+	if (is_acr_event_group(event)) {
+		c2 = dyn_constraint(cpuc, c2, idx);
+		c2->idxmsk64 &= event->hw.dyn_mask;
+		c2->weight = hweight64(c2->idxmsk64);
+	}
+
 	return c2;
 }
 
@@ -3948,6 +4004,78 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static bool intel_pmu_is_acr_group(struct perf_event *event)
+{
+	if (!hybrid(event->pmu, acr_cntr_mask64))
+		return false;
+
+	/* The group leader has the ACR flag set */
+	if (is_acr_event_group(event))
+		return true;
+
+	/* The acr_mask is set */
+	if (event->attr.config2)
+		return true;
+
+	return false;
+}
+
+static int intel_pmu_acr_check_reloadable_event(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	int num = 0;
+
+	/*
+	 * The acr_mask(config2) indicates the event can be reloaded by
+	 * other events. Apply the acr_cntr_mask.
+	 */
+	if (leader->attr.config2) {
+		leader->hw.dyn_mask = hybrid(leader->pmu, acr_cntr_mask64);
+		num++;
+	} else
+		leader->hw.dyn_mask = ~0ULL;
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->attr.config2) {
+			sibling->hw.dyn_mask = hybrid(sibling->pmu, acr_cntr_mask64);
+			num++;
+		} else
+			sibling->hw.dyn_mask = ~0ULL;
+	}
+
+	if (event->attr.config2) {
+		event->hw.dyn_mask = hybrid(event->pmu, acr_cntr_mask64);
+		num++;
+	} else
+		event->hw.dyn_mask = ~0ULL;
+
+	if (num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Update the dyn_mask of each event to guarantee the event is scheduled
+ * to the counters which be able to cause a reload.
+ */
+static void intel_pmu_set_acr_dyn_mask(struct perf_event *event, int idx,
+				       struct perf_event *last)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	u64 mask = hybrid(event->pmu, acr_cntr_cause_mask);
+
+	/* The event set in the acr_mask(config2) can causes a reload. */
+	if (test_bit(idx, (unsigned long *)&leader->attr.config2))
+		event->hw.dyn_mask &= mask;
+	for_each_sibling_event(sibling, leader) {
+		if (test_bit(idx, (unsigned long *)&sibling->attr.config2))
+			event->hw.dyn_mask &= mask;
+	}
+	if (test_bit(idx, (unsigned long *)&last->attr.config2))
+		event->hw.dyn_mask &= mask;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4055,6 +4183,41 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
+	if (intel_pmu_is_acr_group(event)) {
+		struct perf_event *sibling, *leader = event->group_leader;
+		int event_idx = 0;
+
+		if (is_metric_event(event))
+			return -EINVAL;
+
+		/* Not support freq mode */
+		if (event->attr.freq)
+			return -EINVAL;
+
+		/* PDist is not supported */
+		if (event->attr.config2 && event->attr.precise_ip > 2)
+			return -EINVAL;
+
+		/*
+		 * It's hard to know whether the event is the last one of
+		 * the group. Reconfigure the dyn_mask of each X86 event
+		 * every time when add a new event.
+		 *
+		 * Check whether the reloadable counters is enough and
+		 * initialize the dyn_mask.
+		 */
+		if (intel_pmu_acr_check_reloadable_event(event))
+			return -EINVAL;
+
+		/* Reconfigure the dyn_mask for each event */
+		intel_pmu_set_acr_dyn_mask(leader, event_idx++, event);
+		for_each_sibling_event(sibling, leader)
+			intel_pmu_set_acr_dyn_mask(sibling, event_idx++, event);
+		intel_pmu_set_acr_dyn_mask(event, event_idx, event);
+
+		leader->hw.flags |= PERF_X86_EVENT_ACR;
+	}
+
 	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
 	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
@@ -4163,6 +4326,49 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	return 0;
 }
 
+static void intel_pmu_update_acr_mask(struct cpu_hw_events *cpuc, int n, int *assign)
+{
+	struct perf_event *event;
+	int n0, i, off;
+
+	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
+		n0 = cpuc->n_events - cpuc->n_txn;
+	else
+		n0 = cpuc->n_events;
+
+	for (i = n0; i < n; i++) {
+		event = cpuc->event_list[i];
+		event->hw.config1 = 0;
+
+		/* Convert the group index into the counter index */
+		for_each_set_bit(off, (unsigned long *)&event->attr.config2, n - n0)
+			set_bit(assign[n0 + off], (unsigned long *)&event->hw.config1);
+	}
+}
+
+static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
+{
+	struct perf_event *event;
+	int ret = x86_schedule_events(cpuc, n, assign);
+
+	if (ret)
+		return ret;
+
+	if (cpuc->is_fake)
+		return ret;
+
+	event = cpuc->event_list[n - 1];
+	/*
+	 * The acr_mask(config2) is the event-enabling order.
+	 * Update it to the counter order after the counters are assigned.
+	 */
+	if (event && is_acr_event_group(event))
+		intel_pmu_update_acr_mask(cpuc, n, assign);
+
+	return 0;
+}
+
+
 /*
  * Currently, the only caller of this function is the atomic_switch_perf_msrs().
  * The host perf context helps to prepare the values of the real hardware for
@@ -5319,7 +5525,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.set_period		= intel_pmu_set_period,
 	.update			= intel_pmu_update,
 	.hw_config		= intel_pmu_hw_config,
-	.schedule_events	= x86_schedule_events,
+	.schedule_events	= intel_pmu_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
 	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
@@ -5923,6 +6129,21 @@ td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return attr->mode;
 }
 
+PMU_FORMAT_ATTR(acr_mask,	"config2:0-63");
+
+static struct attribute *format_acr_attrs[] = {
+	&format_attr_acr_mask.attr,
+	NULL
+};
+
+static umode_t
+acr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	return hybrid(dev_get_drvdata(dev), acr_cntr_mask64) ? attr->mode : 0;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
 	.is_visible = td_is_visible,
@@ -5965,6 +6186,12 @@ static struct attribute_group group_format_evtsel_ext = {
 	.is_visible = evtsel_ext_is_visible,
 };
 
+static struct attribute_group group_format_acr = {
+	.name       = "format",
+	.attrs      = format_acr_attrs,
+	.is_visible = acr_is_visible,
+};
+
 static struct attribute_group group_default = {
 	.attrs      = intel_pmu_attrs,
 	.is_visible = default_is_visible,
@@ -5979,6 +6206,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_format_extra,
 	&group_format_extra_skl,
 	&group_format_evtsel_ext,
+	&group_format_acr,
 	&group_default,
 	NULL,
 };
@@ -6263,6 +6491,7 @@ static const struct attribute_group *hybrid_attr_update[] = {
 	&group_caps_lbr,
 	&hybrid_group_format_extra,
 	&group_format_evtsel_ext,
+	&group_format_acr,
 	&group_default,
 	&hybrid_group_cpus,
 	NULL,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c7bde9cee699..6617f23428ae 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,6 +115,11 @@ static inline bool is_branch_counters_group(struct perf_event *event)
 	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
 }
 
+static inline bool is_acr_event_group(struct perf_event *event)
+{
+	return event->group_leader->hw.flags & PERF_X86_EVENT_ACR;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
@@ -281,6 +286,10 @@ struct cpu_hw_events {
 	u64			fixed_ctrl_val;
 	u64			active_fixed_ctrl_val;
 
+	/* Intel ACR configuration */
+	u64			acr_cfg_b[X86_PMC_IDX_MAX];
+	u64			acr_cfg_c[X86_PMC_IDX_MAX];
+
 	/*
 	 * Intel LBR bits
 	 */
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 6c977c19f2cd..f21d00965af6 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -9,7 +9,7 @@ PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
 PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
 PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
 PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
-			/*	0x00080	*/
+PERF_ARCH(ACR,			0x00080) /* Auto counter reload */
 PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
 PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
 PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 82c6a4d350e0..83a86dc3f480 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -569,7 +569,11 @@
 /* V6 PMON MSR range */
 #define MSR_IA32_PMC_V6_GP0_CTR		0x1900
 #define MSR_IA32_PMC_V6_GP0_CFG_A	0x1901
+#define MSR_IA32_PMC_V6_GP0_CFG_B	0x1902
+#define MSR_IA32_PMC_V6_GP0_CFG_C	0x1903
 #define MSR_IA32_PMC_V6_FX0_CTR		0x1980
+#define MSR_IA32_PMC_V6_FX0_CFG_B	0x1982
+#define MSR_IA32_PMC_V6_FX0_CFG_C	0x1983
 #define MSR_IA32_PMC_V6_STEP		4
 
 /* KeyID partitioning between MKTME and TDX */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 794f66057878..5305add82df2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -157,7 +157,9 @@ struct hw_perf_event {
 	union {
 		struct { /* hardware */
 			u64		config;
+			u64		config1;
 			u64		last_tag;
+			u64		dyn_mask;
 			unsigned long	config_base;
 			unsigned long	event_base;
 			int		event_base_rdpmc;
-- 
2.38.1


