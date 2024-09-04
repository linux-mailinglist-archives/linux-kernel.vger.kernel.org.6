Return-Path: <linux-kernel+bounces-315736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0196C65A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B961C251F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD351E413C;
	Wed,  4 Sep 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Xq6jvANo"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC151E412E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474407; cv=none; b=XiNBpE+OMoquwpWYfb7e0TazTLeZAWO9Q+4GGJA2cpRDWo5jAAmM2PuMOBZvM1HRC36zPA9O+kI4HU8GIMqPX2IGJA/nb4ocHpaVxW8pmNXWgBl/+BfHvJKFKQZ7IAayaWoSF/2Gm/qEBmYy32kGN5DQZJXGQVBUMdQ1DsxxOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474407; c=relaxed/simple;
	bh=Nsc/Ov81UHgdnQynWWoSifpTaJXPqz7CqaQsqehchk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pzw9rvkn78+M68IvJ/mjBRwIJ3VEvBSimQvrCrciXJkEDXSaLcKJUgwaKlZtrapNtjokb5j1ZOwq4xHNylz/F4Fa1png4D3suK5OrTg2c2ym+NshTfYMTUywtXkQaFjFSUVopMbvZFmj+MLtchxkY1dTMzgkndSD0ValHk0zkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Xq6jvANo; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484HZsQa031904;
	Wed, 4 Sep 2024 11:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	/kL6cuJizHe7Bia8eHKEHtVx3MtTcCmYU+ozWWrc2o=; b=Xq6jvANo8jmSqgHZ/
	YzfqJZiuEnl1ivjd0dyJw31v9uUxgAgtRX4NNRHGvlsWWGa2e7FtPXsfziVMGf1J
	z5UlUJg0tCWGcjAtW5+Luqb4TFhVSstUor+CUMjpS0ONauazof+RdS7ZMbfFiOVs
	DSDb77K9v8GbggUOzRWaw8WTSXDjjMlw/Fu73A48XDOWqfXmAfztoQUPJyuqVMot
	zRAEU+Tn1WsyNleOmYVQdwseHFFZ6vNavYHEE7RIZoGhBC/K5e3aIHoR2uZsse1H
	LhsCkpeej5Ms9c5n4BKj4Md8AOXpbdfHXAZf/rXadPIA1rdRBFl8qJILgAzX88QY
	a1R7A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ev31r6fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:26:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 11:26:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 11:26:36 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 244D43F7044;
	Wed,  4 Sep 2024 11:26:33 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v7 3/6] perf/marvell: Refactor to add version - no functional change
Date: Wed, 4 Sep 2024 23:56:02 +0530
Message-ID: <20240904182605.953927-4-gthiagarajan@marvell.com>
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
X-Proofpoint-ORIG-GUID: VaklIAF0pxENqn4E0KwJ-8gzGZuh9zsM
X-Proofpoint-GUID: VaklIAF0pxENqn4E0KwJ-8gzGZuh9zsM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01

This change is aimed at improving the maintainability of the code and
laying the groundwork for versioning within the driver.

No functional changes are introduced in this commit; the driver's
behavior and performance remain unchanged.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 61 ++++++++++++++++++----------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 648ad3a740bf..86e63a2b02d7 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -124,10 +124,19 @@
 #define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
 #define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
 
+enum mrvl_ddr_pmu_version {
+	DDR_PMU_V1 = 1,
+};
+
+struct ddr_pmu_data {
+	int id;
+};
+
 struct cn10k_ddr_pmu {
 	struct pmu pmu;
 	void __iomem *base;
 	const struct ddr_pmu_platform_data *p_data;
+	int version;
 	unsigned int cpu;
 	struct	device *dev;
 	int active_events;
@@ -738,12 +747,17 @@ static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
 	.ops = &ddr_pmu_ops,
 };
 
+static const struct ddr_pmu_data ddr_pmu_data = {
+	.id   = DDR_PMU_V1,
+};
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	const struct ddr_pmu_data *dev_data;
 	struct cn10k_ddr_pmu *ddr_pmu;
 	struct resource *res;
 	void __iomem *base;
+	int version;
 	char *name;
 	int ret;
 
@@ -760,31 +774,36 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	version = dev_data->id;
+	ddr_pmu->version = version;
+
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	ddr_pmu->base = base;
 
-	ddr_pmu->p_data = &cn10k_ddr_pmu_pdata;
-	/* Setup the PMU counter to work in manual mode */
-	writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
-		       ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl);
-
-	ddr_pmu->pmu = (struct pmu) {
-		.module	      = THIS_MODULE,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
-		.task_ctx_nr = perf_invalid_context,
-		.attr_groups = cn10k_attr_groups,
-		.event_init  = cn10k_ddr_perf_event_init,
-		.add	     = cn10k_ddr_perf_event_add,
-		.del	     = cn10k_ddr_perf_event_del,
-		.start	     = cn10k_ddr_perf_event_start,
-		.stop	     = cn10k_ddr_perf_event_stop,
-		.read	     = cn10k_ddr_perf_event_update,
-		.pmu_enable  = cn10k_ddr_perf_pmu_enable,
-		.pmu_disable = cn10k_ddr_perf_pmu_disable,
-	};
+	if (version == DDR_PMU_V1) {
+		ddr_pmu->p_data = &cn10k_ddr_pmu_pdata;
+		/* Setup the PMU counter to work in manual mode */
+		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
+			       ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl);
+
+		ddr_pmu->pmu = (struct pmu) {
+			.module	      = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = cn10k_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add	     = cn10k_ddr_perf_event_add,
+			.del	     = cn10k_ddr_perf_event_del,
+			.start	     = cn10k_ddr_perf_event_start,
+			.stop	     = cn10k_ddr_perf_event_stop,
+			.read	     = cn10k_ddr_perf_event_update,
+			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
+			.pmu_disable = cn10k_ddr_perf_pmu_disable,
+		};
+	}
 
 	/* Choose this cpu to collect perf data */
 	ddr_pmu->cpu = raw_smp_processor_id();
@@ -827,7 +846,7 @@ static void cn10k_ddr_perf_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ .compatible = "marvell,cn10k-ddr-pmu", .data = &ddr_pmu_data},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -835,7 +854,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
-	{"MRVL000A", 0},
+	{"MRVL000A", (kernel_ulong_t)&ddr_pmu_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1


