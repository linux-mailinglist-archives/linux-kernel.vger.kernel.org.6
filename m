Return-Path: <linux-kernel+bounces-230972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D191847C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141F1286EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F561188CA5;
	Wed, 26 Jun 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etpHW/0C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3200187348
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412510; cv=none; b=j7Ow5aW9fev5hG5CVxQheWggjX02bTqt3vP6ZZ5amXKeDthuL7rMboVJj3zmErfCbIOH2NzsajJgHuJ0fV4wyDYf9KWf2x0BOOOj6dimOViRZdDq/kmrAu2X0orjtkMO+XVlobUzYf0nODejxaWacTzv8VR4Y86DS2ce4hN0WsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412510; c=relaxed/simple;
	bh=zqZgH4e0sqHbo9E3DyRRsVtlWPUMegwerPATYmVgHm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pL70z8cNuJZ73eaPu/49M2df+EO5Zqs2jcCgNsfbMV0IWhF2+hH2UNDRs4R81Y2UlSCIHVlPsPApVp5niuchFAcaMIoM9ObxWBcGl4EYSzd8bkndxLjAsmp1NHPb7gkiAnCGyX/q9j26//MR+Ju0PX4V+y4HW1lXp18AQZgRx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etpHW/0C; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412509; x=1750948509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqZgH4e0sqHbo9E3DyRRsVtlWPUMegwerPATYmVgHm0=;
  b=etpHW/0CNsjU6rDlblrWJGgmsno7mvQuxNjDgnySR1hfuB2ZlF+n+6ua
   mxke7zhVG3GzcG2NgrqGxbyFh2I4eN0Da5RfCI181uDI2nJPYpAabdY+y
   K2NbpSfoY8nQLkXZGFqBcOlfYz/PJRrcWsBfYGyB1LKhM1GWkA1mwl484
   CdR9PBQyXZ9GsQeIWGzdS2P4N1JEghDRQeTz/7rDDl6WKTUB3LDV9/X93
   GC9CVVTVLDZxNbJtA3ik4W60DGwmehmaeDzdO09jElh6JVP/IRzVQyX2f
   uR/K/MjGBA77Idv3tvc0mOZ+ItOR4jsAFdmufKimYp6saNFfOXdxj6zI8
   w==;
X-CSE-ConnectionGUID: 0N8Ht90oRJWXJYt4nlpRmw==
X-CSE-MsgGUID: aeqgVxjcQc25r3qhLyGaPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375542"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375542"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:46 -0700
X-CSE-ConnectionGUID: e7jGv4OATT6CsKDM+F1TFw==
X-CSE-MsgGUID: kEqgDjLHR6K6t9pSZXvrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911968"
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH V3 06/13] perf/x86: Add config_mask to represent EVENTSEL bitmask
Date: Wed, 26 Jun 2024 07:35:38 -0700
Message-Id: <20240626143545.480761-7-kan.liang@linux.intel.com>
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

Different vendors may support different fields in EVENTSEL MSR, such as
Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
used to filter the attr.config.

Introduce a new config_mask to record the real supported EVENTSEL
bitmask.
Only apply it to the existing code now. No functional change.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 5 ++++-
 arch/x86/events/intel/core.c | 1 +
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0c51cfdf7609..842dbf1d706c 100644
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
index 3bf3d6b619ed..12b78febcd09 100644
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
2.38.1


