Return-Path: <linux-kernel+bounces-219716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF290D6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D4F2861D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3114BF92;
	Tue, 18 Jun 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtGzwXMd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867C13E3FF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723541; cv=none; b=QIgv/baxbEsCEyFCvHHQSxahLlYKPJt719zo5XsTBsJUlZ4mB82tNbmoN2rnGHbYHqi65mQHsRew+tMKhzDoTXK5/kTbKmJ7XNeca/x0/bhSMOzXXX7yD05SFBOrFdp9Gps/wwIzlk95PHw4ufEZPwrkE/Rmdo9jhiaVnWKYvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723541; c=relaxed/simple;
	bh=O2EqyA/E870ke0slbg7jxsPjgOyWOPpc5e6J5TXzF5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVG+2x+4/OewSJFur3QhseFW4oK/6YzGzyxOmoWz34yBEXvnfoX79A8CBp5Ip/GVclWoWfrf46kFtx4fuojrbtJXRFApH5rCH1Xu8RBvTRWEFjdWcinV4Jk48xxyS2g3YiCfX/AIY66fZ234tqXug8e+FWaF9CxLeOnjqcemLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtGzwXMd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718723539; x=1750259539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O2EqyA/E870ke0slbg7jxsPjgOyWOPpc5e6J5TXzF5Q=;
  b=XtGzwXMdLZhravpyvvVe1s1s6nUIgCWuJf0TYMUZmI7Z5jIK8B25Mm9c
   G+NGNcgBO5dLnzvyCYsizwMnpnODYcm0S41AQhZ5tukgeYcXuLdvwI5y+
   Fcu4yOLJn8ePA/NN7NUSajpCGXmvs1RkWKreFY4uuIDmcjcxxkvALaHgU
   OKc0PPrim28CFJ6PFcRgMGSAgQItmarb38t35pStsPnak5QZyQX+kofY8
   SMyUYrcuannQGq6ZOGN8jIzj1rplAiEeEI8tAQinxS+c7WDZZSfNkDBl+
   W4+AC60exsQ96DD5tcJG3qi0Apko28ujB8e1hoxnPzU+rwq8h3pKuyonR
   Q==;
X-CSE-ConnectionGUID: 3ehiSXx0RuCI392afPSOXQ==
X-CSE-MsgGUID: gdKPA+otSMuBtTYEPqvdLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15374209"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15374209"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:12:16 -0700
X-CSE-ConnectionGUID: X06WttvjRpmBZnQBPOpsOw==
X-CSE-MsgGUID: ga7uZ/ElRYm5J3pldel+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41426939"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jun 2024 08:12:16 -0700
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
Subject: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent EVENTSEL bitmask
Date: Tue, 18 Jun 2024 08:10:37 -0700
Message-Id: <20240618151044.1318612-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240618151044.1318612-1-kan.liang@linux.intel.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
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
index d31a8cc7b626..80da99fcae6d 100644
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
index 60806f373226..626e9a5e50d2 100644
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
index 66209bb2ba77..4fc72da7a7c4 100644
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
@@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
 	return hweight64(hybrid(pmu, fixed_cntr_mask64));
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


