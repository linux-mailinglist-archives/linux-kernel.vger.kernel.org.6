Return-Path: <linux-kernel+bounces-513930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44838A35065
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B4E3AB815
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50466269817;
	Thu, 13 Feb 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSvcAtUh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE932661BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481423; cv=none; b=eeJ6X+EFOpWeUipNSZSUxzKFGfWAe/yZa9IbwgGNkxT8zrf9nn/CKAG9Dxv3tupJfB3kUSRew1Y7BUnjahtWDEBbB8OBh9joQqDXC25v19XD28wfCciRLEDM0iGnadI4KMtVrpdzFr6cIAi0ojOWq2tKP1k6wWPBUJLjoshoQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481423; c=relaxed/simple;
	bh=q6xirUQpd71kWY89SAbH/i2BweBjkOmcnzd5GSWXRMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdeIdkErk7Rgh4wBIqRMEMZ4Nf4j6fJsc31pu16By6Q/q/SbVFrJSZ1NFOosYcTWsAciiwZoLKGkPQ+SuZ8cum3w8BEL6G8L7cFPy5keGPDtU1i7u1sVBJDNMG2TunYsqINVef6xAi8zx+tms6xe/SbJkfN4c6WhtXskBgEbFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSvcAtUh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739481422; x=1771017422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6xirUQpd71kWY89SAbH/i2BweBjkOmcnzd5GSWXRMw=;
  b=QSvcAtUhb6qUWTSUv7pTFFFClatzNSA4LIePGww/8M84ffp2SKULNQ8X
   aYs6fOA6sQxwWDQNsd1FuAWCFlFJDh9rTuMPG5bH266HDytJSkaYf7BNY
   x/MsXBYCG1k+6zdZoJyRis8r1uqd0ZTx/NxgJ9ZzZxY+uc5bHtXMG7LXG
   46mxs9BeA1A1IEuIsVlxJO+5bdWOfjCjipaoPNnWncKdPv3i6AbzS5/nZ
   z8iKWgm120TLejVoFno28C4NbKBzD3OMmOla9DIDBuh1FhQZ7muLu2hRa
   boHpNJ6Q2YMnIz/Hv5Qu9JvtxqkBT4SlWNIll3ONrT+gpv3y48ZpejwgD
   g==;
X-CSE-ConnectionGUID: 2e0TahSaST63MJ9YcOY5ng==
X-CSE-MsgGUID: yKdoZFryTQ2gN+8ZJX/Raw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44142402"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44142402"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:16:58 -0800
X-CSE-ConnectionGUID: hfksfB61TJSid+JI0LSqEQ==
X-CSE-MsgGUID: LiCYH3NvTBi2BIq6EHTHCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118469494"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2025 13:16:59 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/5] perf/x86/intel: Track the num of events needs late setup
Date: Thu, 13 Feb 2025 13:17:15 -0800
Message-Id: <20250213211718.2406744-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250213211718.2406744-1-kan.liang@linux.intel.com>
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

When a machine supports PEBS v6, perf unconditionally searches the
cpuc->event_list[] for every event and check if the late setup is
required, which is unnecessary.

The late setup is only required for special events, e.g., events support
counters snapshotting feature. Add n_late_setup to track the num of
events that needs the late setup.

Other features, e.g., auto counter reload feature, require the late
setup as well. Add a wrapper, intel_pmu_pebs_late_setup, for the events
that support counters snapshotting feature.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 14 ++++++++++++++
 arch/x86/events/intel/ds.c   |  3 +--
 arch/x86/events/perf_event.h |  5 +++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2df05b18ff04..ce04553910ab 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2609,6 +2609,8 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_lbr_del(event);
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_del(event);
+	if (is_pebs_counter_event_group(event))
+		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
 }
 
 static int icl_set_topdown_event_period(struct perf_event *event)
@@ -2920,12 +2922,24 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	}
 }
 
+void intel_pmu_late_setup(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!cpuc->n_late_setup)
+		return;
+
+	intel_pmu_pebs_late_setup(cpuc);
+}
+
 static void intel_pmu_add_event(struct perf_event *event)
 {
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_add(event);
 	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
+	if (is_pebs_counter_event_group(event))
+		this_cpu_ptr(&cpu_hw_events)->n_late_setup++;
 }
 
 /*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e8f808905871..df9499d6e4dc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1355,9 +1355,8 @@ static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
 }
 
 
-static void intel_pmu_late_setup(void)
+void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
 	u64 pebs_data_cfg = 0;
 	int i;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f4693409e191..5bf9c117e9ef 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -261,6 +261,7 @@ struct cpu_hw_events {
 	struct event_constraint	*event_constraint[X86_PMC_IDX_MAX];
 
 	int			n_excl; /* the number of exclusive events */
+	int			n_late_setup; /* the num of events needs late setup */
 
 	unsigned int		txn_flags;
 	int			is_fake;
@@ -1602,6 +1603,8 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
+void intel_pmu_late_setup(void);
+
 u64 grt_latency_data(struct perf_event *event, u64 status);
 
 u64 cmt_latency_data(struct perf_event *event, u64 status);
@@ -1658,6 +1661,8 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
+void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc);
+
 void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
-- 
2.38.1


