Return-Path: <linux-kernel+bounces-414409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278BE9D2782
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9711F237E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216351CCEF7;
	Tue, 19 Nov 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXG+1iiY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB51CDA0D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024699; cv=none; b=GzqYBZB+Zgn95U6o8YqkKEZVnK13TK7EDPt0+Nb8Mic0gcz/wPl1TddOCU+ufw38LhCWaAr6UlmoREqTXzjpExWQPhPlOgD8z9qcY9Izjx0OzAFNZ1r489aioYtZ2ERR1UE2J8JXKUF7Sx6yb/m3iGUKh98my10iCkTgcNSufy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024699; c=relaxed/simple;
	bh=N2IMcpIEmJnBpeHQLOTmNKrMXtM6xbHUMg301MPnLh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ho3MGkYwAQ0Z/mBkt9p0RRsLkDl544p5cpmK5uHV2GtVwOTb21E/tSiBAXo5X4yy0nSGkMyDl9nImp0MyvyLLEaayYNgpcprRhXr37UNWJpgGEIJ/3qwqCrx0Lp15siDiS2vc/I8fiG3kRoeHVXKpVqE/U359prdqIhHnnjStg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXG+1iiY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732024698; x=1763560698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N2IMcpIEmJnBpeHQLOTmNKrMXtM6xbHUMg301MPnLh0=;
  b=jXG+1iiYJiEgLvFKRlaQGuxfn15tGav64IQmRD1C9yeAhen94SubklqP
   xFaRov0I2BfO1j6gUGmIHSpocmRfVEk77dd4IowbsqPczDfeUsHpUCJAy
   FsLt14mT+IRoUttR09fl9Q459D/mdNGUvP8hkLsWF/yg0BQOOom4bHoco
   SkFOcndbfqBXsSAwVu7YZm9Sl7WusVEHIXO5aHlgmFfVsNAhp8iJVACXT
   UCInMXBsz6e6K1XdlkZ2E3bEDggV8s39ktU1r0TqqX5CeeSm0gebUirIA
   3TzZBmvpWqTsDCwZISDJsJuGbUI67kQMrLGy5BdSMnz6K//XunsVmq+Bn
   g==;
X-CSE-ConnectionGUID: TSwbPJ9ISautXR1JPY+cKw==
X-CSE-MsgGUID: O2qofScTTOWV7M1L0mOHoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31435331"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31435331"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 05:58:15 -0800
X-CSE-ConnectionGUID: RIFaB2jYTVafEYJhWd1caA==
X-CSE-MsgGUID: rnis8KGLRRi+ypJ1mY4w6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89956371"
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
Subject: [PATCH V2 3/4] perf/x86/intel/ds: Factor out functions for PEBS records processing
Date: Tue, 19 Nov 2024 05:55:03 -0800
Message-Id: <20241119135504.1463839-4-kan.liang@linux.intel.com>
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

Factor out functions to process normal and the last PEBS records, which
can be shared with the later patch.

Move the event updating related codes (intel_pmu_save_and_restart())
to the end, where all samples have been processed.
For the current usage, it doesn't matter when perf updates event counts
and reset the counter. Because all counters are stopped when the PEBS
buffer is drained.
Drop the return of the !intel_pmu_save_and_restart(event) check. Because
it never happen. The intel_pmu_save_and_restart(event) only returns 0,
when !hwc->event_base or the period_left > 0.
- The !hwc->event_base is impossible for the PEBS event, since the PEBS
  event is only available on GP and fixed counters, which always have
  a valid hwc->event_base.
- The check only happens for the case of non-AUTO_RELOAD and single
  PEBS, which implies that the event must be overflowed. The period_left
  must be always <= 0 for an overflowed event after the
  x86_pmu_update().

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 109 +++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 35926d0d2341..bf624499f3b4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2167,46 +2167,33 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	return 0;
 }
 
+typedef void (*setup_fn)(struct perf_event *, struct pt_regs *, void *,
+			 struct perf_sample_data *, struct pt_regs *);
+
+static struct pt_regs dummy_iregs;
+
 static __always_inline void
 __intel_pmu_pebs_event(struct perf_event *event,
 		       struct pt_regs *iregs,
+		       struct pt_regs *regs,
 		       struct perf_sample_data *data,
-		       void *base, void *top,
-		       int bit, int count,
-		       void (*setup_sample)(struct perf_event *,
-					    struct pt_regs *,
-					    void *,
-					    struct perf_sample_data *,
-					    struct pt_regs *))
+		       void *at,
+		       setup_fn setup_sample)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct hw_perf_event *hwc = &event->hw;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
-	void *at = get_next_pebs_record_by_bit(base, top, bit);
-	static struct pt_regs dummy_iregs;
-
-	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
-	} else if (!intel_pmu_save_and_restart(event))
-		return;
-
-	if (!iregs)
-		iregs = &dummy_iregs;
+	setup_sample(event, iregs, at, data, regs);
+	perf_event_output(event, data, regs);
+}
 
-	while (count > 1) {
-		setup_sample(event, iregs, at, data, regs);
-		perf_event_output(event, data, regs);
-		at += cpuc->pebs_record_size;
-		at = get_next_pebs_record_by_bit(at, top, bit);
-		count--;
-	}
+static __always_inline void
+__intel_pmu_pebs_last_event(struct perf_event *event,
+			    struct pt_regs *iregs,
+			    struct pt_regs *regs,
+			    struct perf_sample_data *data,
+			    void *at,
+			    int count,
+			    setup_fn setup_sample)
+{
+	struct hw_perf_event *hwc = &event->hw;
 
 	setup_sample(event, iregs, at, data, regs);
 	if (iregs == &dummy_iregs) {
@@ -2225,6 +2212,44 @@ __intel_pmu_pebs_event(struct perf_event *event,
 		if (perf_event_overflow(event, data, regs))
 			x86_pmu_stop(event, 0);
 	}
+
+	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
+		/*
+		 * Now, auto-reload is only enabled in fixed period mode.
+		 * The reload value is always hwc->sample_period.
+		 * May need to change it, if auto-reload is enabled in
+		 * freq mode later.
+		 */
+		intel_pmu_save_and_restart_reload(event, count);
+	} else
+		intel_pmu_save_and_restart(event);
+}
+
+static __always_inline void
+__intel_pmu_pebs_events(struct perf_event *event,
+			struct pt_regs *iregs,
+			struct perf_sample_data *data,
+			void *base, void *top,
+			int bit, int count,
+			setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	void *at = get_next_pebs_record_by_bit(base, top, bit);
+	int cnt = count;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	while (cnt > 1) {
+		__intel_pmu_pebs_event(event, iregs, regs, data, at, setup_sample);
+		at += cpuc->pebs_record_size;
+		at = get_next_pebs_record_by_bit(at, top, bit);
+		cnt--;
+	}
+
+	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
@@ -2261,8 +2286,8 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 		return;
 	}
 
-	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
-			       setup_pebs_fixed_sample_data);
+	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
+				setup_pebs_fixed_sample_data);
 }
 
 static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
@@ -2393,9 +2418,9 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		}
 
 		if (counts[bit]) {
-			__intel_pmu_pebs_event(event, iregs, data, base,
-					       top, bit, counts[bit],
-					       setup_pebs_fixed_sample_data);
+			__intel_pmu_pebs_events(event, iregs, data, base,
+						top, bit, counts[bit],
+						setup_pebs_fixed_sample_data);
 		}
 	}
 }
@@ -2447,9 +2472,9 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		if (WARN_ON_ONCE(!event->attr.precise_ip))
 			continue;
 
-		__intel_pmu_pebs_event(event, iregs, data, base,
-				       top, bit, counts[bit],
-				       setup_pebs_adaptive_sample_data);
+		__intel_pmu_pebs_events(event, iregs, data, base,
+					top, bit, counts[bit],
+					setup_pebs_adaptive_sample_data);
 	}
 }
 
-- 
2.38.1


