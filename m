Return-Path: <linux-kernel+bounces-229489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF50917018
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FAD1F24205
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092C17C7D8;
	Tue, 25 Jun 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nB5x4Zoz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9C17A930
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339762; cv=none; b=cSP65ztrIWbuxuK1NeLgiCVYEkhGUW2OhINlDIPSk4g4c4kd1b40AL4IAtdCIeDXrKlzftXXNoZPjcPi+6IWoV4K+j3nXReO7BUWiIgxHOyzxA7NO3F552m7wSUsu1X2KUrEnc/Bs/DWsedNUD7yhqaudTe1xSpNCOe0kWHOHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339762; c=relaxed/simple;
	bh=oyliGb9SJBroaFCNoK5ImTzKTS8q76GZV+Ze6fVUPMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fbl4N4RcHIjwHqB0wFEMvzZedB1jjwUB0dTpC5OWVhOwKosp3bpENrL8IWytrRRXFosXMQfULXq6YdJx0Ek0+pPVe+FSJZgW9HhIHPiETtgxr3zpS4zTOZTihFZ91PzlN0WOBRYuR939HVuBnFnQpCaxHaGfx63RcH2rY3/klUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nB5x4Zoz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339760; x=1750875760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyliGb9SJBroaFCNoK5ImTzKTS8q76GZV+Ze6fVUPMc=;
  b=nB5x4Zoz3F6rqLEm9+dRRBrDXWhOSeqn3gkjN40O2I8Yl7jtlvVc1tQs
   J65QKSDMF8VFcGZVwxwdsVoICQIrXfStcEpUn0W6yLIJWSTyLJzaHnpQD
   Y4oqsopbY+VtaXdfWleYlcRbknD10BuP9bSSLI66Yjtvn2mP+A0cZ6kQj
   +XivfH0ujFSw7MLp4dqRq2kN18gw8MAsruL3jjz4vR+99Mt5YPVVJIjKp
   kJmVRY3ANa6CdVoitilbBMwd38sB8tTrO+tcL3dG1LbpMr8Lf/x6r+Lie
   p82Inr5TI4SuQYghnplgcDgAwo0lUrND9vim4wSerExjUmzatxIbpGuiZ
   w==;
X-CSE-ConnectionGUID: wkGB+b7bS0COdVWL0FXRLA==
X-CSE-MsgGUID: AM29JG5IRd2eSOPqKj654w==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16204014"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16204014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:22 -0700
X-CSE-ConnectionGUID: G7uVnQQSQ0Oewrqy9XZ6TQ==
X-CSE-MsgGUID: Fg2u0HKhRsihYB/OzT3vew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913350"
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH V2 06/13] perf/x86: Add config_mask to represent EVENTSEL bitmask
Date: Tue, 25 Jun 2024 11:22:49 -0700
Message-Id: <20240625182256.291914-7-kan.liang@linux.intel.com>
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

Different vendors may support different fields in EVENTSEL MSR, such as
Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
used to filter the attr.config.

Introduce a new config_mask to record the real supported EVENTSEL
bitmask.
Only apply it to the existing code now. No functional change.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 5 ++++-
 arch/x86/events/intel/core.c | 1 +
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 848dbe9cbd0e..8ea1c988e19b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -624,7 +624,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_OS;
 
 	if (event->attr.type == event->pmu->type)
-		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
+		event->hw.config |= x86_pmu_get_event_config(event);
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
@@ -2098,6 +2098,9 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.intel_ctrl)
 		x86_pmu.intel_ctrl = x86_pmu.cntr_mask64;
 
+	if (!x86_pmu.config_mask)
+		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
+
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ab61b9ef677a..23e074fd25e1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6144,6 +6144,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 		pmu->cntr_mask64 = x86_pmu.cntr_mask64;
 		pmu->fixed_cntr_mask64 = x86_pmu.fixed_cntr_mask64;
 		pmu->pebs_events_mask = intel_pmu_pebs_mask(pmu->cntr_mask64);
+		pmu->config_mask = X86_RAW_EVENT_MASK;
 		pmu->unconstrained = (struct event_constraint)
 				     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0d333bb9c8f4..a226565a9333 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -695,6 +695,7 @@ struct x86_hybrid_pmu {
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	u64				pebs_events_mask;
+	u64				config_mask;
 	union {
 			u64		cntr_mask64;
 			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -790,6 +791,7 @@ struct x86_pmu {
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
 	int		max_events;
+	u64		config_mask;
 	union {
 			u64		cntr_mask64;
 			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -1241,6 +1243,11 @@ static inline int x86_pmu_max_num_counters_fixed(struct pmu *pmu)
 	return find_last_bit(hybrid(pmu, fixed_cntr_mask), INTEL_PMC_MAX_FIXED) + 1;
 }
 
+static inline u64 x86_pmu_get_event_config(struct perf_event *event)
+{
+	return event->attr.config & hybrid(event->pmu, config_mask);
+}
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.35.1


