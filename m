Return-Path: <linux-kernel+bounces-333198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DD97C54B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D691C21C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EAC198A30;
	Thu, 19 Sep 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vgu6X2jb"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3A194C78
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732132; cv=none; b=HDUrQaVbmx7Od8VpOJyA1By2IDCDryOf4lQrgvQt+bWJhKRh6mdYa5iF9oWlTQlySdENW2gU0swDSlhCAtkTa65loqAGfc36KmyeP7L5QmI/I1gcbhn75gFgxSp9vNaeV/+98BygWpiJqXtM2Lgsif3j7NA8iAv/MIzKpHunONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732132; c=relaxed/simple;
	bh=LcUais+ue6t9XDQb5n7m1dd1ynxd7RPiYgRl12l85Ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHKf74iZtOgZouKpa+BbNDzXGuWP0WSirZgwM5QfEK6SsMpvwWEgASCZYZTjQwuut8l9oOamr/b6GHHiws/1k5z656ABjG5mVP5BC8lXp9ZEjRPRN7Jf/TdE9aMjmyfr4FviK40ce0Z1578AEhPWdcWspU2Vi7jc/0jDggoWlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vgu6X2jb; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J6KVN3031226;
	Thu, 19 Sep 2024 00:47:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	XqZhA025IHL2HVMPEpBFcxBfY6x7g+sY9PLbhMupHg=; b=Vgu6X2jbcDKPO9LKG
	SDASrEdD5CSc2pCv2Tw99LtctVV3Zd4fqoDxtfhrJaVHEDgdvtaSq0NhbCmwUutG
	pclhcIxCGUizO6EBQCiwkE3y6LeVkms7tOIIXHsvG/ZW6s0cUmN26NNUj40bvXde
	O6hMkHChfiVsoBFpcgJ/WtHeonG9xpN7Bk9SiBeudgJhMgxJwI29qurFqOH18a6z
	IRqG5cBPmqnXztO0qA12xlP43ZOqco+bxmQZiv6tOwzElc2e0TBk0MbXfdz/W+uD
	tzy1kEAocfXWIKFZy6Fk3kb1sKEEpN7GrTMWDrwqk18TkPcTv9i1skCHUCK2xFyF
	ZQe/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41qdwgg7um-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 00:47:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Sep 2024 00:47:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Sep 2024 00:47:34 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 0CD133F7082;
	Thu, 19 Sep 2024 00:47:31 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v8 3/6] perf/marvell: Refactor to add version - no functional change
Date: Thu, 19 Sep 2024 13:17:14 +0530
Message-ID: <20240919074717.3276854-4-gthiagarajan@marvell.com>
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
X-Proofpoint-GUID: j3sEfGz4t-otLrDzBAgS8uRF4eQp5anT
X-Proofpoint-ORIG-GUID: j3sEfGz4t-otLrDzBAgS8uRF4eQp5anT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This change is aimed at improving the maintainability of the code and
laying the groundwork for versioning within the driver.

No functional changes are introduced in this commit; the driver's
behavior and performance remain unchanged.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 63 ++++++++++++++++++----------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 648ad3a740bf..65422fd5ddd2 100644
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
@@ -738,12 +747,19 @@ static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
 	.ops = &ddr_pmu_ops,
 };
 
+#if defined(CONFIG_ACPI) || defined(CONFIG_OF)
+static const struct ddr_pmu_data ddr_pmu_data = {
+	.id   = DDR_PMU_V1,
+};
+#endif
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
 
@@ -760,31 +776,36 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
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
@@ -827,7 +848,7 @@ static void cn10k_ddr_perf_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ .compatible = "marvell,cn10k-ddr-pmu", .data = &ddr_pmu_data},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -835,7 +856,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
-	{"MRVL000A", 0},
+	{"MRVL000A", (kernel_ulong_t)&ddr_pmu_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1


