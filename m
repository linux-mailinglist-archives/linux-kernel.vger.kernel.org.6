Return-Path: <linux-kernel+bounces-315739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C262A96C65D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019C21C2528D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276881E4935;
	Wed,  4 Sep 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aF2u8rTZ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F81E2026
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474415; cv=none; b=EaA+DLaJ2R1iJDiEHRlNaIfsezyPTXV4kFLqnye0ySrbM5IEOtvBHI8quHOh/U1x7qJy9G4jFnx/a/PAC4dSIos8NHJkKS6aCwwngV/S66wcGELbr43fCpLd8gzfQ+UJhnHdewGTHxMCrbdXaOBAGu3CJrvmmse2YUwyh6CrEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474415; c=relaxed/simple;
	bh=MJyHgPPd/wjGZ3tiKzDqqqplfT19M+mdXcR2gOceW2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMY9M9g7bJ4iShWJFAs1LsmcKRnyRJ6IHJq+TksTeF+pVic3Ob0Df8msfAqxL7UA2S/RO4FvN6M7iYVX/UJBgzahleZDEWe78BjYb5lKnBO+FWJ3F88VP16zc51XzCX6HcdCC60Ko7pz9hI4IAydoaUPgHAElW5LfxxQa3Woh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aF2u8rTZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484HabO0000383;
	Wed, 4 Sep 2024 11:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	p78n+b6k2d5MDNfJaWsTjrFl1pMA438IW72EystjvU=; b=aF2u8rTZPshhPbCeq
	iwvuGWt5BvCz3l6zUtudDbpPLNLPnv9k8mNeCSpRUP0GvAFIG1CeqtQ0CEnvPAJp
	ZD0zVSk91GrJJDyVG9dVZ78XRKBKLbc76j6osyoLI5Si3OInHR6JgWaxy4BTZcrT
	JpP2ATiCo+wLUv8YgoeVb7Xdo22luf5BQ6JSiZDFIWyjy9UOcEROrrmSyDnxyAus
	utC/qVrkLZf5X+Zt4Qt9kLo7nsIgUgS2p9SwAPY9OmbKart339lf4oMhVpp0VEB1
	/WL9+vTW20HH5px+HZFbbzMbK1eDvmN7GnG9xazZ99AafUy1aE8+S2ZbFH3StS91
	EfCZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ev31r6gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:26:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 11:26:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 11:26:44 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 30B133F704F;
	Wed,  4 Sep 2024 11:26:41 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v7 5/6] perf/marvell : Refactor to extract platform data - no functional change
Date: Wed, 4 Sep 2024 23:56:04 +0530
Message-ID: <20240904182605.953927-6-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904182605.953927-1-gthiagarajan@marvell.com>
References: <20240904182605.953927-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: c2QlUyA3Po9ztrFq2HKDy7khOAw_mYuP
X-Proofpoint-GUID: c2QlUyA3Po9ztrFq2HKDy7khOAw_mYuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01

This commit introduces a refactor to the Marvell TAD PMU driver
specifically to add versioning to the existing driver.

No functional changes are introduced; the behavior and performance
of the driver remain unchanged.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 9e635f355470..15f9f67cb3bd 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -37,6 +37,14 @@ struct tad_pmu {
 	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
 };
 
+enum mrvl_tad_pmu_version {
+	TAD_PMU_V1 = 1,
+};
+
+struct tad_pmu_data {
+	int id;
+};
+
 static int tad_pmu_cpuhp_state;
 
 static void tad_pmu_event_counter_read(struct perf_event *event)
@@ -254,6 +262,7 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 
 static int tad_pmu_probe(struct platform_device *pdev)
 {
+	const struct tad_pmu_data *dev_data;
 	struct device *dev = &pdev->dev;
 	struct tad_region *regions;
 	struct tad_pmu *tad_pmu;
@@ -261,6 +270,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	u32 tad_pmu_page_size;
 	u32 tad_page_size;
 	u32 tad_cnt;
+	int version;
 	int i, ret;
 	char *name;
 
@@ -270,6 +280,13 @@ static int tad_pmu_probe(struct platform_device *pdev)
 
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
@@ -319,7 +336,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	tad_pmu->pmu = (struct pmu) {
 
 		.module		= THIS_MODULE,
-		.attr_groups	= tad_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
 				  PERF_PMU_CAP_NO_INTERRUPT,
 		.task_ctx_nr	= perf_invalid_context,
@@ -332,6 +348,9 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
+	if (version == TAD_PMU_V1)
+		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
+
 	tad_pmu->cpu = raw_smp_processor_id();
 
 	/* Register pmu instance for cpu hotplug */
@@ -360,16 +379,22 @@ static void tad_pmu_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&pmu->pmu);
 }
 
+#if defined(CONFIG_OF) || defined(CONFIG_ACPI)
+static const struct tad_pmu_data tad_pmu_data = {
+	.id   = TAD_PMU_V1,
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
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
-- 
2.25.1


