Return-Path: <linux-kernel+bounces-333192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8797C53F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361111C21BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE011953BE;
	Thu, 19 Sep 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eR1IKZag"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7A194C95
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732111; cv=none; b=PPVTWuEDl+REaGWP4TS71r+cm8GHD/Stv04zRu4111GG/lV8L3Yc4q0QR0M8RjS10vbV4wuSQz9rYwGgNP/gyHCCiz7xl8//N0vFh4O1ks1IVJ2udMBbVQktzPZGy8VRJiF7BHGM1rKZrXpSEEi20dGq3wqoGRO0PZMS+feslEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732111; c=relaxed/simple;
	bh=hR5viATnQMNf+Gc41v1mlpE5H8U0riYZ56AKkLDNy1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVhufhwyBQrYQ+/OtCLXjBWuzAUXtBM/WI4l6u3R0AZLYG7OUbHmlHfp3uY8ExH4ZK+vt9n1Xwf9Hq4BzcUTxeqk7GDYOuRlbu4QUSa9pSdoS7knJf9DfIJySUdRhbIHATc+lM2aEe1ecDx6wtGFS4veb3T57zeUvigRa7o2aVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eR1IKZag; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J6KQ2V031184;
	Thu, 19 Sep 2024 00:48:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	+5tDUt/Gwbuh3YnkRORAVssXlDTivKeHK5uU1tRuRQ=; b=eR1IKZagIyZMXUa/i
	/Clpr24gmkJSuv99AEyUuD2P/eHbgYSJxRklMZfvOlKkR+nWx8G6/rN+vxNe3eQP
	Qv1Vjlyzzda5laz1bLqc6uPxYm4Bm96xaNvRR/sXaoQpxOV8eUBd71q6huBBHXgH
	wTnrW0MmFFU4SzIcE9FLLSCwUz2VWmHWbcBLt1YoXwIp+RA9f22vtvrHM6PtcNCx
	3IVcW6cPr2s6wROED+YQ4kyJ4hkJlXWcuxSNfz/CoShaQiCZbYH3F0zog6FHwnKi
	jOiASyZGof+9T2XRg22QCqLexbyNz2xB5TK0pfeel3QLVz6V0luc7/YCLO+iq+wH
	bji0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41qdwgg7xw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 00:48:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Sep 2024 00:47:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Sep 2024 00:47:46 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 520E73F7087;
	Thu, 19 Sep 2024 00:47:44 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v8 6/6] perf/marvell : Odyssey LLC-TAD performance monitor support
Date: Thu, 19 Sep 2024 13:17:17 +0530
Message-ID: <20240919074717.3276854-7-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919074717.3276854-1-gthiagarajan@marvell.com>
References: <20240919074717.3276854-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x5zJedZ2KxFnQt18dqwElIkz9YYyBbmd
X-Proofpoint-ORIG-GUID: x5zJedZ2KxFnQt18dqwElIkz9YYyBbmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Each TAD provides eight 64-bit counters for monitoring
cache behavior.The driver always configures the same counter for
all the TADs. The user would end up effectively reserving one of
eight counters in every TAD to look across all TADs.
The occurrences of events are aggregated and presented to the user
at the end of running the workload. The driver does not provide a
way for the user to partition TADs so that different TADs are used for
different applications.

The performance events reflect various internal or interface activities.
By combining the values from multiple performance counters, cache
performance can be measured in terms such as: cache miss rate, cache
allocations, interface retry rate, internal resource occupancy, etc.

Each supported counter's event and formatting information is exposed
to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
the pmu events. For instance:

perf stat -e tad_hit_ltg,tad_hit_dtg <workload>

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 Documentation/admin-guide/perf/index.rst      |  1 +
 .../admin-guide/perf/mrvl-odyssey-tad-pmu.rst | 37 +++++++++++++++++++
 drivers/perf/marvell_cn10k_tad_pmu.c          | 35 ++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index d673ccfea903..d8e983e33ca7 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -15,6 +15,7 @@ Performance monitor support
    qcom_l3_pmu
    starfive_starlink_pmu
    mrvl-odyssey-ddr-pmu
+   mrvl-odyssey-tad-pmu
    arm-ccn
    arm-cmn
    xgene-pmu
diff --git a/Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst b/Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst
new file mode 100644
index 000000000000..ad1975b14087
--- /dev/null
+++ b/Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst
@@ -0,0 +1,37 @@
+====================================================================
+Marvell Odyssey LLC-TAD Performance Monitoring Unit (PMU UNCORE)
+====================================================================
+
+Each TAD provides eight 64-bit counters for monitoring
+cache behavior.The driver always configures the same counter for
+all the TADs. The user would end up effectively reserving one of
+eight counters in every TAD to look across all TADs.
+The occurrences of events are aggregated and presented to the user
+at the end of running the workload. The driver does not provide a
+way for the user to partition TADs so that different TADs are used for
+different applications.
+
+The performance events reflect various internal or interface activities.
+By combining the values from multiple performance counters, cache
+performance can be measured in terms such as: cache miss rate, cache
+allocations, interface retry rate, internal resource occupancy, etc.
+
+The PMU driver exposes the available events and format options under sysfs::
+
+        /sys/bus/event_source/devices/tad/events/
+        /sys/bus/event_source/devices/tad/format/
+
+Examples::
+
+   $ perf list | grep tad
+        tad/tad_alloc_any/                                 [Kernel PMU event]
+        tad/tad_alloc_dtg/                                 [Kernel PMU event]
+        tad/tad_alloc_ltg/                                 [Kernel PMU event]
+        tad/tad_hit_any/                                   [Kernel PMU event]
+        tad/tad_hit_dtg/                                   [Kernel PMU event]
+        tad/tad_hit_ltg/                                   [Kernel PMU event]
+        tad/tad_req_msh_in_exlmn/                          [Kernel PMU event]
+        tad/tad_tag_rd/                                    [Kernel PMU event]
+        tad/tad_tot_cycle/                                 [Kernel PMU event]
+
+   $ perf stat -e tad_alloc_dtg,tad_alloc_ltg,tad_alloc_any,tad_hit_dtg,tad_hit_ltg,tad_hit_any,tad_tag_rd <workload>
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 15f9f67cb3bd..29976b435417 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -39,6 +39,7 @@ struct tad_pmu {
 
 enum mrvl_tad_pmu_version {
 	TAD_PMU_V1 = 1,
+	TAD_PMU_V2,
 };
 
 struct tad_pmu_data {
@@ -222,6 +223,24 @@ static const struct attribute_group tad_pmu_events_attr_group = {
 	.attrs = tad_pmu_event_attrs,
 };
 
+static struct attribute *ody_tad_pmu_event_attrs[] = {
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
+	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
+	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
+	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
+	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
+	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
+	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
+	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	NULL
+};
+
+static const struct attribute_group ody_tad_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = ody_tad_pmu_event_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 
 static struct attribute *tad_pmu_format_attrs[] = {
@@ -260,6 +279,13 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 	NULL
 };
 
+static const struct attribute_group *ody_tad_pmu_attr_groups[] = {
+	&ody_tad_pmu_events_attr_group,
+	&tad_pmu_format_attr_group,
+	&tad_pmu_cpumask_attr_group,
+	NULL
+};
+
 static int tad_pmu_probe(struct platform_device *pdev)
 {
 	const struct tad_pmu_data *dev_data;
@@ -350,6 +376,8 @@ static int tad_pmu_probe(struct platform_device *pdev)
 
 	if (version == TAD_PMU_V1)
 		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
+	else
+		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
 
 	tad_pmu->cpu = raw_smp_processor_id();
 
@@ -385,6 +413,12 @@ static const struct tad_pmu_data tad_pmu_data = {
 };
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct tad_pmu_data tad_pmu_v2_data = {
+	.id   = TAD_PMU_V2,
+};
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
@@ -395,6 +429,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
 	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
+	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
-- 
2.25.1


