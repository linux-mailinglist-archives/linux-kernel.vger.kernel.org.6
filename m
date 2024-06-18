Return-Path: <linux-kernel+bounces-219720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF790D6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749B31F24103
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6915382F;
	Tue, 18 Jun 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4GeYIQD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AE414BF85
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723544; cv=none; b=WHQI+ct+SoFZJOfCDIUUYwEIHTa7iobFFL7eNpfPn2Jw9zNWOxvvTt+X5wz6QR0HCZpOFTpJxi9drkGxS77iCgWsHdsiYGHtGzFPLVlTA3l7Hmxjz03mlLkQXJrkw1nkdrAwP0naIqJuz4HyFsFd7S5/XfroEQRBuiiOH6Ossm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723544; c=relaxed/simple;
	bh=Pv0cIStppgQKaq5A49x19wpkVaKbymytiEnK8x/SLsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNMEZQmI1u3ye9ClS5h2fMnGSeYjyWiUQZeQx1WbnRqf5TX09gHNFpkQfDvUsJ5T0R2V0+gba3Ryw2GC7Nij7UZLdzXCBVeMsKu8EW64tVRzeP4ymWJiLqByWo9oQ0uLojQdwfUeIILNbH3Qo29Ze19jMoTRzKmAeaaLtp5VfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4GeYIQD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718723542; x=1750259542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pv0cIStppgQKaq5A49x19wpkVaKbymytiEnK8x/SLsc=;
  b=D4GeYIQDogJvuyGbAVW57Nd7maaWPyKgslcqVriER5YenyK0CwXTOdDV
   KDPeWIHrokxOgC0wW/j7JuEy0ZDEWHkOpcrzIW2V9j+Dc0/i/nUMoDfSQ
   s2c1f7EP5aEL4cahPMVDZCNHzNiJNvRI+MB6hg1NK9v/9zci9ZNGro6Xh
   JnGa/fsQsLkjTkFflSAIVeV2zo2TdjjF2udjkVsjhKc1kV2GNy7xdeYCA
   fBrkzyX2UyQ1dqe5LttL27VrgywEtvCpEoCdHHc3PdVw02nI8gQ6cs0FK
   jRVLbutwjLM2Ti6LS9HJE0pvSjpq1Y2gnN381LoCI27Ypj5iUnbUNWx7U
   A==;
X-CSE-ConnectionGUID: 2T92VkJIRrSJhDjMBj9NiA==
X-CSE-MsgGUID: G5h8M2GkSOyYg9Jt1w7g7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15374237"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15374237"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:12:18 -0700
X-CSE-ConnectionGUID: 7hzzOa+AQQCpd5eyxgyObw==
X-CSE-MsgGUID: ERYChZYdQ/KWQTjJQkbjAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41426958"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jun 2024 08:12:18 -0700
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
Subject: [RESEND PATCH 10/12] perf/x86/intel: Move PEBS event update after the sample output
Date: Tue, 18 Jun 2024 08:10:42 -0700
Message-Id: <20240618151044.1318612-11-kan.liang@linux.intel.com>
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
index abf2b1991bc0..583fed8891b6 100644
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


