Return-Path: <linux-kernel+bounces-407867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B99C7601
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D484328BD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A83158DC0;
	Wed, 13 Nov 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do2Nbdg6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B51442F2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510827; cv=none; b=YO6r6cLCr7XT96j5mRmi7M5pzMiTqYAQaonjh0UFtLeNWL+JvOu+wjSqt+p/E7eNiL7NMZ6fNjanv0nk/SaNXjuGBIgMldIKbKgUet6DEv+kZVgLTgIHR+NlWWpVaW2oeC9mXMbtDRy1dTThezfJrqvu9jXpt2JS+6xJoWeTXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510827; c=relaxed/simple;
	bh=usdzNiFuQYD3GtShTFTYj5WC52AOIrx9dZ+KVumNTFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LumDAxE1Pe0FDDtNpEzCWe2ZbikROhYsb42fOvnu6VvLPvilIAh4XdbuoZyrRHqhTGrRtK2qTHxDoZTu7CEGqacMPeYFEBXZUVoGl09fpxE3NBP8UUSURqGUIMvS16TCFdC9vm4UhnjbwQMJlDK/hhmzTPMyvavne8VjhzZj8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do2Nbdg6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731510825; x=1763046825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usdzNiFuQYD3GtShTFTYj5WC52AOIrx9dZ+KVumNTFY=;
  b=Do2Nbdg6j2B5ffcm0QoWyvQg0cwcAg1Q8M4kjEJ9MbR417+CHPb6JbYf
   fr4jmzAR6F7iAiwOLLG1PhDwOlAhhCtu2xSgLOzfD727tONqnzZ6x40ZS
   /ZELSTd5zpALezuSi3XWhjkvYj2ttkWn8bJwHFoJj8v47SaUqIQHV4iTd
   g9TwNhRLNoJqVPZYYy0EeE6+o1XzEbmX3AZZUqAKewTcylKrnL20GFXQs
   UBxCFN1RjUGNziuC5QhZMsjd+vwAMvwu0uVzwRlTIqMie0UrakrgS9znv
   lYCYdq6WIyq/VRlbZR0d44S5q7RB6QHgaTcOAhKv4A+GlCsRPJSPhmwSS
   g==;
X-CSE-ConnectionGUID: m1GEziyzSp2/wmUWnlYOvQ==
X-CSE-MsgGUID: KMFisSjVT9mVTqj9wUCIaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42797840"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42797840"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:13:42 -0800
X-CSE-ConnectionGUID: UdHFwOvnScW5PD12YGv0dQ==
X-CSE-MsgGUID: uXUsrs2LSvWX06lZV1lGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118724883"
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/ds: Simplify the PEBS records processing for adaptive PEBS
Date: Wed, 13 Nov 2024 07:14:27 -0800
Message-Id: <20241113151427.677169-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241113151427.677169-1-kan.liang@linux.intel.com>
References: <20241113151427.677169-1-kan.liang@linux.intel.com>
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

In an NMI, the last record has to be specially handled. Add a
unprocessed[] variable to track the last unprocessed record of each
event.

Save and restart the event after all records are processed.

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
 arch/x86/events/intel/ds.c | 85 ++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4d0f7c49295a..cbf2ab9ed4c8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2400,12 +2400,38 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	}
 }
 
+static inline void __intel_pmu_pebs_event_output(struct perf_event *event,
+						 struct pt_regs *iregs,
+						 void *record, bool last,
+						 struct perf_sample_data *data)
+{
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	static struct pt_regs dummy_iregs;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	setup_pebs_adaptive_sample_data(event, iregs, record, data, regs);
+	if (last) {
+		/*
+		 * All but the last records are processed.
+		 * The last one is left to be able to call the overflow handler.
+		 */
+		if (perf_event_overflow(event, data, regs))
+			x86_pmu_stop(event, 0);
+	} else
+		perf_event_output(event, data, regs);
+}
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	void *unprocessed[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
+	struct pebs_basic *basic;
 	void *base, *at, *top;
 	int bit;
 	u64 mask;
@@ -2426,30 +2452,63 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		return;
 	}
 
-	for (at = base; at < top; at += cpuc->pebs_record_size) {
+	for (at = base; at < top; at += basic->format_size) {
 		u64 pebs_status;
 
-		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
-		pebs_status &= mask;
+		basic = at;
+		if (WARN_ON_ONCE(basic->format_size != cpuc->pebs_record_size))
+			continue;
+
+		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
+		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+			event = cpuc->events[bit];
+
+			if (WARN_ON_ONCE(!event) ||
+			    WARN_ON_ONCE(!event->attr.precise_ip))
+				continue;
+
+			/*
+			 * Need at least one record to call the overflow handler later.
+			 * Initialize the unprocessed[] variable with the first record.
+			 */
+			if (!counts[bit]++) {
+				unprocessed[bit] = at;
+				continue;
+			}
+
+			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
 
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX)
-			counts[bit]++;
+			unprocessed[bit] = at;
+		}
 	}
 
 	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (counts[bit] == 0)
+		if (!counts[bit])
 			continue;
 
 		event = cpuc->events[bit];
-		if (WARN_ON_ONCE(!event))
-			continue;
 
-		if (WARN_ON_ONCE(!event->attr.precise_ip))
-			continue;
+		if (!iregs) {
+			/*
+			 * The PEBS records may be drained in the non-overflow context,
+			 * e.g., large PEBS + context switch. Perf should treat the
+			 * last record the same as other PEBS records, and doesn't
+			 * invoke the generic overflow handler.
+			 */
+			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
+		} else
+			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], true, data);
 
-		__intel_pmu_pebs_event(event, iregs, data, base,
-				       top, bit, counts[bit],
-				       setup_pebs_adaptive_sample_data);
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) {
+			/*
+			 * Now, auto-reload is only enabled in fixed period mode.
+			 * The reload value is always hwc->sample_period.
+			 * May need to change it, if auto-reload is enabled in
+			 * freq mode later.
+			 */
+			intel_pmu_save_and_restart_reload(event, counts[bit]);
+		} else
+			intel_pmu_save_and_restart(event);
 	}
 }
 
-- 
2.38.1


