Return-Path: <linux-kernel+bounces-340940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A12F987941
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DC11F227D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF7161319;
	Thu, 26 Sep 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPPC6KcD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF51D5ABC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376344; cv=none; b=KU4gWK5BoOjSygjdDjvZvPB0z8ZMtg37f75SnCN51NWn9kEtaL3GxOHVTdxgnZYio/LJ2gAi4z4bcvf7+J/lLuXtdgkmhsqZD/JHp3hxgs0r1MvQKcF3u2W3futLbrYvZPO6txeJrZ18GhYO5vunEEFzwVOudFb4nRg+fRYAvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376344; c=relaxed/simple;
	bh=GisCzJkkjfSQ4Dcog6LbC+uHaylUQ/qPi5EXH2/0yi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+Gm1yrSfsSpfzxmS3QfjQKjatUY63VfQPdxSBmc8KrzMexMdhzd3qGvMBys6MOJg3010Ul/LpdPfWogMxw7KVmz2B9qSyZUS0K0zBGe9q2zsX0nrjpQeLmS3OBWhnFyzQvyx8XH1cSy6uwt3dIW0fCPw5AT6lj2DIyYTtAh/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPPC6KcD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727376342; x=1758912342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GisCzJkkjfSQ4Dcog6LbC+uHaylUQ/qPi5EXH2/0yi8=;
  b=gPPC6KcDKpGBGMpq3fQBVcyHtEP51nAtDBaCn/+BM268qdGA+ezF3IL8
   FflanjWvvPYpK9xHbTzgzahKqcADG5vzFDL5eqpukhy0XD8/hIc58w71V
   gJx/vWXT3TrFZSFxVhrFz8bbSszDLTKA8qrv5xWn7QpKhl9XIOZDGq7My
   PLiFwXb8uh06ta+gfm0JMW/TywsfNHSqZ67P4npLJVvIDe2jUQnV+bqhl
   wD/NhiUfN7uQDNAnAX8Yyk2er2/W1B2+Wcj8B2FbYHfxPeTf1IZdejbCa
   +rMP30J2+WiJ5MNy1zbzOgyyxIaCW/G36KULJicCCjbizwl/c05ebii2J
   A==;
X-CSE-ConnectionGUID: +XiYaMa6See9ocofMNIB6A==
X-CSE-MsgGUID: 5XWe5dvGRNyhu5r34p1QKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14120238"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="14120238"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 11:45:41 -0700
X-CSE-ConnectionGUID: SEFmUsUNShm9lY0Y//yCQw==
X-CSE-MsgGUID: Buns9Vw4TmSQNEICWg4U0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="76338401"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 26 Sep 2024 11:45:40 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [RESEND PATCH V4] perf/x86/intel: Support RDPMC metrics clear mode
Date: Thu, 26 Sep 2024 11:45:58 -0700
Message-Id: <20240926184558.3797290-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
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
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The original V4 can be found at
https://lore.kernel.org/lkml/20240731143835.771618-6-kan.liang@linux.intel.com/

The patch was one of the PMU features in the LNL enabling patch set.
The other feature is now blocked. Send the patch separately.

 arch/x86/events/intel/core.c         | 20 +++++++++++++++++++-
 arch/x86/events/perf_event.h         |  1 +
 arch/x86/include/asm/perf_event.h    |  4 ++++
 tools/perf/Documentation/topdown.txt |  9 +++++++--
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5182075e111b..342f8b1a2f93 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2816,6 +2816,9 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 			return;
 
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
+		if (event->attr.config1 & INTEL_TD_CFG_METRIC_CLEAR)
+			bits |= INTEL_FIXED_3_METRICS_CLEAR;
 	}
 
 	intel_set_masks(event, idx);
@@ -4067,7 +4070,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
@@ -4676,6 +4684,8 @@ PMU_FORMAT_ATTR(in_tx,  "config:32"	);
 PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
 PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
 
+PMU_FORMAT_ATTR(metrics_clear,	"config1:0"); /* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+
 static ssize_t umask2_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *page)
@@ -4695,6 +4705,7 @@ static struct device_attribute format_attr_umask2  =
 static struct attribute *format_evtsel_ext_attrs[] = {
 	&format_attr_umask2.attr,
 	&format_attr_eq.attr,
+	&format_attr_metrics_clear.attr,
 	NULL
 };
 
@@ -4719,6 +4730,13 @@ evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
index 82c6f45ce975..31c2771545a6 100644
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
index 91b73571412f..e3b5e8e96fb3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -41,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
@@ -372,6 +373,9 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
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
2.38.1


