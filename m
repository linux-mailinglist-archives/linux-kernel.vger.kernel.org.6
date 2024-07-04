Return-Path: <linux-kernel+bounces-240794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D09272DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54862B23E12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445C1AB505;
	Thu,  4 Jul 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OYoAGWJ5"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB631A4F3D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084849; cv=none; b=NT0GOhglYnVzb8XMe5M2vqKLLYZhQTL8T1DVmfSW3ei0q5Uf5Tq8Jjdy63jIqqDZhhJQBNq0dRHL2VkDPIE4TEv6aGWedlKUuulavAY1MfjN//ynX0jbPA2AYWihYm1wqrfM8EBuEguJyEadVHpVYxcSiorA+fAhEBMbYBep/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084849; c=relaxed/simple;
	bh=8iemnVt/v8lo6oKHuispsmxBJMg2zqeJz5e6DemUIiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePDIFu9p8z1D5qTfBFfx10iGgxs4xV/TVTWRSM4OSG5/KdArRVuIhJMpNU2XjwKA6ZrS3yZw8eqLWMNC87y2Nk9iw6O837gkQ7FVoF2hhjM3pqHGeYdNODVZVVftUVsfxyd4NpZYJ91qa2zhxGH1td/L+piOuHKeRAmRTQgzPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OYoAGWJ5; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4649IgSb007482;
	Thu, 4 Jul 2024 02:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	bwIaqtBjUpPywTvNT+A//Z9OMD6EnrC9WX/QZHN0JA=; b=OYoAGWJ568YbeX3wd
	vK5dG8Eb41uo/dnZZktlta0QT6OfLbnUwN/MKqyZqw1feOAk6lBTfDCeqrdhJohX
	VQtmnbU0CaDPxOIKo2enLPZvBGNxPjmtIeDvXdR/IxDeJ5epSa35lbbddk2xGrJO
	4ms7J3kZnJmKW/TZLGEdbyAnM51MLsP2xYatM+5+LL9MmY0FSl3912O8ua7PRnXp
	pK2ORBweUvTPW8ClgO53gtzj3/FaYdfayEE4rCSLieYV9YCUaj8YB33COKnZJMUZ
	pN7YUaC3KxAePr57lwsxQrHiP7o2qB0xBn/kFmcPP+mvspHsfxYGn0NcgHCsI6TL
	w1oXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 405s01r08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 02:20:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Jul 2024 02:20:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Jul 2024 02:20:39 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id DD43B5B692F;
	Thu,  4 Jul 2024 02:20:36 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v6 3/3] perf/marvell : Odyssey LLC-TAD performance monitor support
Date: Thu, 4 Jul 2024 14:50:22 +0530
Message-ID: <20240704092022.1136805-4-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704092022.1136805-1-gthiagarajan@marvell.com>
References: <20240704092022.1136805-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: v6Q8rPVmjsl-emAtKI3wQJh-cia3WzcA
X-Proofpoint-ORIG-GUID: v6Q8rPVmjsl-emAtKI3wQJh-cia3WzcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01

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
 drivers/perf/marvell_cn10k_tad_pmu.c | 66 ++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 9e635f355470..29976b435417 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -37,6 +37,15 @@ struct tad_pmu {
 	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
 };
 
+enum mrvl_tad_pmu_version {
+	TAD_PMU_V1 = 1,
+	TAD_PMU_V2,
+};
+
+struct tad_pmu_data {
+	int id;
+};
+
 static int tad_pmu_cpuhp_state;
 
 static void tad_pmu_event_counter_read(struct perf_event *event)
@@ -214,6 +223,24 @@ static const struct attribute_group tad_pmu_events_attr_group = {
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
@@ -252,8 +279,16 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
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
+	const struct tad_pmu_data *dev_data;
 	struct device *dev = &pdev->dev;
 	struct tad_region *regions;
 	struct tad_pmu *tad_pmu;
@@ -261,6 +296,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	u32 tad_pmu_page_size;
 	u32 tad_page_size;
 	u32 tad_cnt;
+	int version;
 	int i, ret;
 	char *name;
 
@@ -270,6 +306,13 @@ static int tad_pmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tad_pmu);
 
+	dev_data = device_get_match_data(&pdev->dev);
+	if (!dev_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+	version = dev_data->id;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "Mem resource not found\n");
@@ -319,7 +362,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	tad_pmu->pmu = (struct pmu) {
 
 		.module		= THIS_MODULE,
-		.attr_groups	= tad_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
 				  PERF_PMU_CAP_NO_INTERRUPT,
 		.task_ctx_nr	= perf_invalid_context,
@@ -332,6 +374,11 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
+	if (version == TAD_PMU_V1)
+		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
+	else
+		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
+
 	tad_pmu->cpu = raw_smp_processor_id();
 
 	/* Register pmu instance for cpu hotplug */
@@ -360,16 +407,29 @@ static void tad_pmu_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&pmu->pmu);
 }
 
+#if defined(CONFIG_OF) || defined(CONFIG_ACPI)
+static const struct tad_pmu_data tad_pmu_data = {
+	.id   = TAD_PMU_V1,
+};
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct tad_pmu_data tad_pmu_v2_data = {
+	.id   = TAD_PMU_V2,
+};
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-tad-pmu", },
+	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
 	{},
 };
 #endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
-	{"MRVL000B", 0},
+	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
+	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
-- 
2.25.1


