Return-Path: <linux-kernel+bounces-229495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF38491701D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890342897A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E217DE03;
	Tue, 25 Jun 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JINe+iaM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A817D37B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339766; cv=none; b=MtmmUjm0LHUPvaSGTfmKU0tTnD6NS6YpxyksTRgjxKaTX9wNA1B/eCaaeS38X5g9WIJdwruPvq513xyuhYwp5fNb9hOO7LtlIW8frc7Sz2fGvk+ZyuKyuCS7wSVGCUsYTKqYsaea6rCNbySUNkEDV4aDNwc+Uje6fe46kG89MHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339766; c=relaxed/simple;
	bh=FHkh/MshJSLY9lqDYo4dzFGcqmMfGB3r24Zwlhzxkno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQMhbnXOnqUu98Cwq1rJQKCvHww4I4NYGkBctD+cTUayGw11jegtyaSyPIUxnr+4GWmUnDPA5JIiWOuDrrasaW6BvpWbkCQhFcJC2GG0XtmNrpqXbsASoBHIrouKXh2X731rcE2OAGu66PcsrbTFFcO8hyFnAkoRl4iewTxHylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JINe+iaM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339765; x=1750875765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHkh/MshJSLY9lqDYo4dzFGcqmMfGB3r24Zwlhzxkno=;
  b=JINe+iaMLD0zSTV1nUXZvt7Gu3dqNLXHtK69zqjnUatLf2DGKo45n8oz
   PJ8jxARqXM88Yddtr19z3r2QwNmui9w4sgBtPvpflTbyrweAAfhYe+ZmP
   lMp4JU9u2BJ05+rOSWXtSUNKSc8qs3qPdIy9+4ieR/YGKIFE3zFUwEHgx
   Bl9KqcH9nLZ9+E78zo9wT6GpRUfQWjsN+vRcY8cSd/SkRbGJKRfDa5jpP
   le7dbGbPWCQLoUqwMebxawWuvxP2njs3u37W+y+gjM9x3FR0IBw0/+xY7
   Su+DL44WrRvlIQdC7KCzS1CgTCHJM1Cn76uRTrPgGmA9Zjth6k893hdmF
   Q==;
X-CSE-ConnectionGUID: YVdauasVTV6sN9RRYIjbdg==
X-CSE-MsgGUID: sgIoOP8VQcOumPCj7vT8Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16204050"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16204050"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:22 -0700
X-CSE-ConnectionGUID: 0mCL1VwrT62s4zUtlqfeyw==
X-CSE-MsgGUID: pIHzsLkIRDenXuc2/kQDEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913363"
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 11/13] perf/x86/intel: Move PEBS event update after the sample output
Date: Tue, 25 Jun 2024 11:22:54 -0700
Message-Id: <20240625182256.291914-12-kan.liang@linux.intel.com>
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

In the drain_pebs(), besides outputting the sample data, the perf needs
to update the PEBS event (e.g., prev_count, event->count, etc.) as well.
Both operations may invoke the perf_event_update(), but the sequence of
the two operations doesn't matter for now. Because the updated event
value is read directly from the counter via rdpmc. The counter stops in
the drain_pebs().

But if the updated event value is from different places (PEBS record VS.
counter), the sequence does matter. For example, with the new Intel PEBS
counters snapshotting feature, the large PEBS can be enabled for the
sample read, since counter values for each sample are recorded in PEBS
records. The current perf does the PEBS event update first, which also
updates the event for all the records altogether. It's impossible for
the later sample read output to dump the value for each sample, since
the prev_count is already the newest one from the current counter.

Move PEBS event update after the sample output. For each sample read
output, it will update and output the value only for this sample
(according to the value in the PEBS record). Once all samples are
output, update the PEBS event again according to the current counter,
and set the left period.

The !intel_pmu_save_and_restart() only happens when !hwc->event_base
or the left > 0. The !hwc->event_base is impossible for the PEBS event
which is only available on GP and fixed counters.
The __intel_pmu_pebs_event() is only to process the overflowed sample.
The left should be always <=0.
It's safe to ignore the return from the !inel_pmu_save_and_restart()
check.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ce7e98409f29..fb04ef307f7b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2158,17 +2158,6 @@ __intel_pmu_pebs_event(struct perf_event *event,
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	static struct pt_regs dummy_iregs;
 
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
 	if (!iregs)
 		iregs = &dummy_iregs;
 
@@ -2197,6 +2186,17 @@ __intel_pmu_pebs_event(struct perf_event *event,
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
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
-- 
2.35.1


