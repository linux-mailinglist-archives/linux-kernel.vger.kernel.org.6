Return-Path: <linux-kernel+bounces-230978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5214918486
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E405F1C213F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321E18FDBD;
	Wed, 26 Jun 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5Ggk6OB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADD18FC6B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412514; cv=none; b=Y8oBvjKZ5b8vqZaBfCxxD7twMzHx1G5o8eplmfh6INYgjqL9zrkNwWuy/qJitJ0xC+z1c1gJz/8IiZS6X84HU3Xl0PZjDq6VaOeRJERtXqk12EjguctxZuPx+13i3SEtTXZP7H4yq6qLZJ3xJ8yOC9XrBJlfyiRfJDjRS+e95yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412514; c=relaxed/simple;
	bh=XSKNicck/aA83lyPZSNV6kcwl32TrSKkF3d1JDFdPxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cm8rdJVaHTKD1jfX7ymnl2N4mn6XpiBzsesZRTOOjDB7vBmpc/LCyTo3ILr5eIAagooWLv6jbmjzzPVV0L0CO8qzIlUdgiZEn33hjNbD8HJVsTIEvUiehNWQhluCUwbsExQP+zv2QNbKMw3QcyO4PzvtVqe4dgcDykEdOOiEPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5Ggk6OB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412513; x=1750948513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XSKNicck/aA83lyPZSNV6kcwl32TrSKkF3d1JDFdPxg=;
  b=N5Ggk6OBHoNCarZKeGe36rqaBi4Qz2wuDuQI7RI16lm4f6OHyAAgPyPe
   KKOxJJh4w4G50BHKlJdFXq6kz9LIq2QSwzeZaWn/gDPy2CURf1iFrYLwB
   JfBAird6afve25sZ6xf7yjQqDZyEi/6F7ubtUtp3Zi1dPi/YJkOmuCyQW
   7IVaThi2ieV5JOV1hYSH00YQq3p5eV/69mgwF5JSqgEwX8+IrYkiaLyWU
   BuvQI3QRKrO1oh3IvO/7Bjrq0tKCjkjIDjjNWdxGK2IvfktU+u0fXnScV
   ZkBKHshwGqqUGEAyT92xO6jp5qAhRkAzr5Hpvr90vJ/TdjPkPv+YIsSDW
   A==;
X-CSE-ConnectionGUID: UVPIg2DFS8a9ln9f11pSKw==
X-CSE-MsgGUID: wep8qzHjQw20AeOp5D78rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375567"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:46 -0700
X-CSE-ConnectionGUID: WN9GQNEXQHG6D7mk2yzjiQ==
X-CSE-MsgGUID: xovKC9EGRA+d2gwSAQRusQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911983"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2024 07:34:46 -0700
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
Subject: [PATCH V3 11/13] perf/x86/intel: Move PEBS event update after the sample output
Date: Wed, 26 Jun 2024 07:35:43 -0700
Message-Id: <20240626143545.480761-12-kan.liang@linux.intel.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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
2.38.1


