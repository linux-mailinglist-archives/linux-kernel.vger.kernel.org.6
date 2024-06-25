Return-Path: <linux-kernel+bounces-229496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13391701E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079091F25434
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3D17DE2A;
	Tue, 25 Jun 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rpy9PLpE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102E17D379
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339767; cv=none; b=YHkPeEulJUNX3uToJPdcurRpqc/34AR9179s5UEOeDf8L5estPJTdUMLfQUiYIZ7PBBipRsPizmZ6cFYBUJNiCtlsfwLSTMxSw41zViDZi8aM20unXZDIKTNAdCDrh82HCph3hIsUrxlTNWRqGbxu2fHlxwzvFX6x2Bicsbyktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339767; c=relaxed/simple;
	bh=WXvQp2+cBf5CqWqIQPFS71Mktms2GeqCF2RD57nwt6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DuIXtM9hhoND1qsJr3o//qZxCYz+iCKUKtU1n8N5BbIpcV0eEtur/xHUdyS4rO4hg59q5Z6d6wUP+326iQR8/+cRxx/EPEAPz/nAo6esWGHAqRu/pCNvg/rCtWOEoL7wAdoyeVEFP9EWragrMPPOkF9SX94E2Oa9E8+/KQzkdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rpy9PLpE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339765; x=1750875765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXvQp2+cBf5CqWqIQPFS71Mktms2GeqCF2RD57nwt6I=;
  b=Rpy9PLpEeRlJLJ2eSj6UNpHQFjDYRMeacPiZLmchlpOKNBia83IzoDIZ
   O3XpaxXn92xXiP7CfQ/+KHHtA1kvTrECQEoDO36w3pRxeFR6xr4aH1JBK
   gBIfTuA1TRTKz9nHLxIsIssp79m+XQlQGCuSpSwWdCHKyM3BHYTwWtRaY
   7nSOF156+IEasQ8tYiy2KbAFOdWZ9sbMxv8XDltHw2Xc1oxSADPs1AIa2
   td0oXSpSBvlJq9VOmb22rIyGO0XoYJ9hrLomTgt3ejCLE1yKhlL8nVtSs
   9vO6BoL5rL6Sg9GmA674AfMnTyZIuqpFUJ4lHk3kE+nHkTRMIYwqJNT9W
   g==;
X-CSE-ConnectionGUID: Tu9V7dmJRI2eTRTU/KyiDw==
X-CSE-MsgGUID: okC9OdMHQG+4Q+Hj6FCRZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16204049"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16204049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:22 -0700
X-CSE-ConnectionGUID: 9+dqGGxWQcGYA0O9OYuG1g==
X-CSE-MsgGUID: 3mLNBZDaSSa5of+P5ZCedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913371"
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
Subject: [PATCH V2 13/13] perf/x86/intel: Support RDPMC metrics clear mode
Date: Tue, 25 Jun 2024 11:22:56 -0700
Message-Id: <20240625182256.291914-14-kan.liang@linux.intel.com>
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

The new RDPMC enhancement, metrics clear mode, is to clear the
PERF_METRICS-related resources as well as the fixed-function performance
monitoring counter 3 after the read is performed. It is available for
ring 3. The feature is enumerated by the
IA32_PERF_CAPABILITIES.RDPMC_CLEAR_METRICS[bit 19]. To enable the
feature, the IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14] must be set.

Two ways were considered to enable the feature.
- Expose a knob in the sysfs globally. One user may affect the
  measurement of other users when changing the knob. The solution is
  dropped.
- Introduce a new event format, metrics_clear, for the slots event to
  disable/enable the feature only for the current process. Users can
  utilize the feature as needed.
The latter solution is implemented in the patch.

The current KVM doesn't support the perf metrics yet. For
virtualization, the feature can be enabled later separately.

Update the document of perf metrics.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c         | 20 +++++++++++++++++++-
 arch/x86/events/perf_event.h         |  1 +
 arch/x86/include/asm/perf_event.h    |  4 ++++
 tools/perf/Documentation/topdown.txt |  9 +++++++--
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 33e189710073..5868ba8e2167 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,6 +2822,9 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 			return;
 
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
+		if (event->attr.config1 & INTEL_TD_CFG_METRIC_CLEAR)
+			bits |= INTEL_FIXED_3_METRICS_CLEAR;
 	}
 
 	intel_set_masks(event, idx);
@@ -4086,7 +4089,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
 	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
-		if (event->attr.config1 || event->attr.config2)
+		/* The metrics_clear can only be set for the slots event */
+		if (event->attr.config1 &&
+		    (!is_slots_event(event) || (event->attr.config1 & ~INTEL_TD_CFG_METRIC_CLEAR)))
+			return -EINVAL;
+
+		if (event->attr.config2)
 			return -EINVAL;
 
 		/*
@@ -4673,6 +4681,8 @@ PMU_FORMAT_ATTR(in_tx,  "config:32"	);
 PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
 PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
 
+PMU_FORMAT_ATTR(metrics_clear,	"config1:0"); /* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+
 static ssize_t umask2_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *page)
@@ -4692,6 +4702,7 @@ static struct device_attribute format_attr_umask2  =
 static struct attribute *format_evtsel_ext_attrs[] = {
 	&format_attr_umask2.attr,
 	&format_attr_eq.attr,
+	&format_attr_metrics_clear.attr,
 	NULL
 };
 
@@ -4716,6 +4727,13 @@ evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	if (i == 1)
 		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
 
+	/* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+	if (i == 2) {
+		union perf_capabilities intel_cap = hybrid(dev_get_drvdata(dev), intel_cap);
+
+		return intel_cap.rdpmc_metrics_clear ? attr->mode : 0;
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3d64ed240e91..9d1d5adec0ad 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -624,6 +624,7 @@ union perf_capabilities {
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
 		u64	anythread_deprecated:1;
+		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 709746cd7c19..21e1d1fe5972 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -41,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
@@ -378,6 +379,9 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
+#define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
+#define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
+
 static inline bool is_metric_idx(int idx)
 {
 	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;
diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index ae0aee86844f..f36c8ca1dc53 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -280,8 +280,13 @@ with no longer interval than a few seconds
 
 	perf stat -I 1000 --topdown ...
 
-For user programs using RDPMC directly the counter can
-be reset explicitly using ioctl:
+Starting from the Lunar Lake p-core, a RDPMC metrics clear mode is
+introduced. The metrics and the fixed counter 3 are automatically
+cleared after the read is performed. It is recommended to always enable
+the mode. To enable the mode, the config1 of slots event is set to 1.
+
+On the previous platforms, for user programs using RDPMC directly, the
+counter has to be reset explicitly using ioctl:
 
 	ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
 
-- 
2.35.1


