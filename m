Return-Path: <linux-kernel+bounces-229487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D522F917015
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C19285AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6A17C7BC;
	Tue, 25 Jun 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfXzZFT8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3C17920C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339756; cv=none; b=nw2kIMYw47NpUC8pFxlBgcNotd/JnHaShkd9aijfPJ0tbNO6LIX7qil9E6xA0N95TchNXgMhEdkejVKeaE+FdIR3CP0bFit58qn99ZwUtPsapoTg1IJx828HMVfmCCGNtL/zyaHyOFAMVOZoM8wrFNHNeh2AL2BollwDGHsWQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339756; c=relaxed/simple;
	bh=LrGl4EOfxR+3PLrm5aPGX1YqUdIgSEjDNNzwzRmDqc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnQ/yxWFC9iuFLnzDXXheKx+0WWcx7in/tiuj5ql0PEJOk45pbEnoN+JIU4MQfo016o4DTz6LEH8mSWzqVKwTSKZu+2j5p3jaTJZmkmu1aAJRqWGVpaY+cWJTPCgPApeMnc1QPn+CASu46HPuQc6Pq2Tt5DEOqCDWIOPJsVSnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfXzZFT8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339755; x=1750875755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LrGl4EOfxR+3PLrm5aPGX1YqUdIgSEjDNNzwzRmDqc4=;
  b=nfXzZFT8JYFk7fB73e98k3g27Pw6jCwFjw/TE4K7mGuqEHA03L3otfu4
   CsOFTbeSVjx0uo2J7VqHsx+qXEFHId3jI+yfpX8mrUvgCQQObeehMH/Gb
   ufHU1aqDuQe8xZT6xiB04L1eIqo9hIN6+6kYhVWutkzOiZ802/tkW79zf
   xwlJprW+zdNg6Z19Z0b8gGMCK0hp8ZPjLKLsmrYzERClXkz3Pdij5RNk4
   5qSrjOFTxvYSoW77BFmnhzj09QT/lNpXQaE2jiSTjZ9BnEbYzjatTos8A
   d0wDV05MRAhhmPJV+kPZf/sHq1iDKzS4ss2LFZUnx4RgEMEsJBaUVkRRd
   g==;
X-CSE-ConnectionGUID: OeJ8obIlQG+J9X7iyWcfcw==
X-CSE-MsgGUID: KyMU9tCnTxSlXCk2ttAP2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16204006"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16204006"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:21 -0700
X-CSE-ConnectionGUID: Nj7bymj0SX24SIm8wT3JGA==
X-CSE-MsgGUID: tpOy3ZJLT6a2C/umwyvQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913352"
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH V2 07/13] perf/x86/intel: Support PERFEVTSEL extension
Date: Tue, 25 Jun 2024 11:22:50 -0700
Message-Id: <20240625182256.291914-8-kan.liang@linux.intel.com>
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

Two new fields (the unit mask2, and the equal flag) are added in the
IA32_PERFEVTSELx MSRs. They can be enumerated by the CPUID.23H.0.EBX.

Update the config_mask in x86_pmu and x86_hybrid_pmu for the true layout
of the PERFEVTSEL.
Expose the new formats into sysfs if they are available. The umask
extension reuses the same format attr name "umask" as the previous
umask. Add umask2_show to determine/display the correct format
for the current machine.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 69 +++++++++++++++++++++++++++++--
 arch/x86/include/asm/perf_event.h |  4 ++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 23e074fd25e1..9d50e1049e30 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4632,8 +4632,55 @@ PMU_FORMAT_ATTR(pc,	"config:19"	);
 PMU_FORMAT_ATTR(any,	"config:21"	); /* v3 + */
 PMU_FORMAT_ATTR(inv,	"config:23"	);
 PMU_FORMAT_ATTR(cmask,	"config:24-31"	);
-PMU_FORMAT_ATTR(in_tx,  "config:32");
-PMU_FORMAT_ATTR(in_tx_cp, "config:33");
+PMU_FORMAT_ATTR(in_tx,  "config:32"	);
+PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
+PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
+
+static ssize_t umask2_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *page)
+{
+	u64 mask = hybrid(dev_get_drvdata(dev), config_mask) & ARCH_PERFMON_EVENTSEL_UMASK2;
+
+	if (mask == ARCH_PERFMON_EVENTSEL_UMASK2)
+		return sprintf(page, "config:8-15,40-47\n");
+
+	/* Roll back to the old format if umask2 is not supported. */
+	return sprintf(page, "config:8-15\n");
+}
+
+static struct device_attribute format_attr_umask2  =
+		__ATTR(umask, 0444, umask2_show, NULL);
+
+static struct attribute *format_evtsel_ext_attrs[] = {
+	&format_attr_umask2.attr,
+	&format_attr_eq.attr,
+	NULL
+};
+
+static umode_t
+evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	u64 mask;
+
+	/*
+	 * The umask and umask2 have different formats but share the
+	 * same attr name. In update mode, the previous value of the
+	 * umask is unconditionally removed before is_visible. If
+	 * umask2 format is not enumerated, it's impossible to roll
+	 * back to the old format.
+	 * Does the check in umask2_show rather than is_visible.
+	 */
+	if (i == 0)
+		return attr->mode;
+
+	mask = hybrid(dev_get_drvdata(dev), config_mask);
+	if (i == 1)
+		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
+
+	return 0;
+}
 
 static struct attribute *intel_arch_formats_attr[] = {
 	&format_attr_event.attr,
@@ -4786,8 +4833,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
-	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
+
+	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
+
+	if (ebx & ARCH_PERFMON_EXT_UMASK2)
+		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
+	if (ebx & ARCH_PERFMON_EXT_EQ)
+		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
 
 	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
@@ -5810,6 +5863,12 @@ static struct attribute_group group_format_extra_skl = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_format_evtsel_ext = {
+	.name       = "format",
+	.attrs      = format_evtsel_ext_attrs,
+	.is_visible = evtsel_ext_is_visible,
+};
+
 static struct attribute_group group_default = {
 	.attrs      = intel_pmu_attrs,
 	.is_visible = default_is_visible,
@@ -5823,6 +5882,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_lbr,
 	&group_format_extra,
 	&group_format_extra_skl,
+	&group_format_evtsel_ext,
 	&group_default,
 	NULL,
 };
@@ -6042,6 +6102,7 @@ static const struct attribute_group *hybrid_attr_update[] = {
 	&group_caps_gen,
 	&group_caps_lbr,
 	&hybrid_group_format_extra,
+	&group_format_evtsel_ext,
 	&group_default,
 	&hybrid_group_cpus,
 	NULL,
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 400c909b8658..91b73571412f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -32,6 +32,8 @@
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 #define ARCH_PERFMON_EVENTSEL_BR_CNTR			(1ULL << 35)
+#define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
+#define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
 
 #define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -185,6 +187,8 @@ union cpuid10_edx {
  * detection/enumeration details:
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
+#define ARCH_PERFMON_EXT_UMASK2			0x1
+#define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 
-- 
2.35.1


