Return-Path: <linux-kernel+bounces-269376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAAB94322A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FCC1F2417D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B211BC08A;
	Wed, 31 Jul 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT+Ia4J0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F21BBBDB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436678; cv=none; b=flEkJo1Knec3sVwZ1clK27tUvUSgKJR7xR2eD11qkHaNBajXpPZaULpXUyA2YFrkPNz6XGUdRvYVPmxvfpn+7duM1m4LSzxpoO6sNALzh0Ij1N6MorJQIbh3t7rZhYXHooXgJSZDXd7pScWbRFTyTtQF4TZ4RQ1xl/nkwLWljhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436678; c=relaxed/simple;
	bh=aYhN7amcu7BIt4RJmvhF4b86s1eS1QylcxjZtEOaLNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWVeDhVTPhltJOH5arnzab/dg7BsMluBP60UO/YTyuX6ZgfqNiyRyDvV2yMIhK7dYs5mcvzhS1xwX/qHaFwEAK6TNIzjnxoJXbydrMRpIOO1/8G8a3hotvWM8+iRYT1WcGoY++7SSIYoIC9VOB8eHFj5x1fCXQP1Zrj9WdarriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT+Ia4J0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436676; x=1753972676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYhN7amcu7BIt4RJmvhF4b86s1eS1QylcxjZtEOaLNQ=;
  b=HT+Ia4J061TnLvHNNx3QQiKchY6zJUBnGx2TFwXF7eXxaAH0chngyC/N
   jMT2u37V0Z2eF0tvC13PymF5qlE/yX4n7hrf5k8jV/QrHIKEfplO+f50N
   C17frMe3g/WkdtCgP/85UoAA7/u2rMqIbAMe1JBItxaqNcvyMDJL8ZAxl
   hSn9PxeH5vywSOVOl/x4Pn8jZmrXrz2NASK0tz1bT96tFODVrzkxudlJA
   2t3vPy4CiyejLSxZtp5IGvrQBhZCOR/YPtv9ow/1KY2LtZYGHRbbVGpKh
   nioodHqn7Q1RmxqMJQ7wJyVJFuBNa6OOKJUO495s9DYpgDG/9k3xElj3T
   Q==;
X-CSE-ConnectionGUID: xUzvW1ggQXym5oA2838QTQ==
X-CSE-MsgGUID: uQ+v1FH7TLmH7ctft0vohw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="37835861"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="37835861"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:37:53 -0700
X-CSE-ConnectionGUID: oWLTsR5SQw2xYoyhh/i4iQ==
X-CSE-MsgGUID: 5IJQA5MEQvqQCzXgDZTN0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54698391"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2024 07:37:53 -0700
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
Subject: [PATCH V4 3/5] perf/x86/intel: Move PEBS event update after the sample output
Date: Wed, 31 Jul 2024 07:38:33 -0700
Message-Id: <20240731143835.771618-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240731143835.771618-1-kan.liang@linux.intel.com>
References: <20240731143835.771618-1-kan.liang@linux.intel.com>
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
index fa5ea65de0d0..9c28c7e34b57 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2168,17 +2168,6 @@ __intel_pmu_pebs_event(struct perf_event *event,
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
 
@@ -2207,6 +2196,17 @@ __intel_pmu_pebs_event(struct perf_event *event,
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


