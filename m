Return-Path: <linux-kernel+bounces-315735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A29596C659
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E5A2832C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AE1CC8A2;
	Wed,  4 Sep 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="krn6zqqT"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB81E4128
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474406; cv=none; b=NG7uuzv149U18toby0Nh8BwaqBBwFeye7R2ngebNWkF3AVhpX6X0i4Pi0j6cFCHxnVVh60wp3JA6kfoZx+7U7idEl7PhmKbhE3sqajlswQyTKNs6v6mR4f0AJzJNQrOicCqyB15fZjZGBAuP+CDNoPc9vBKTxBY+hTS/yLfvrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474406; c=relaxed/simple;
	bh=rRk741S3MwZtXCXG6ZQJgpfyrfk1ISD1p0Hml4Jv2y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3myz1nbPJkUrmEsS0QWUxM/r1vIU0HBvw1XoJrc7ecN/JYrxYtjXtLC7RBYemKYl1U8CB2NXb75KIL79QMBI8Bkg3rSLBZWp48ZI1G21HkHCnSyBtH/sYZnmASMxfwD2YQTXntC6snZz0PVnQNzdOPo8y1q/Xyp+PhstrrQ5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=krn6zqqT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484HabNu000383;
	Wed, 4 Sep 2024 11:26:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	ciDPeALtUxlyouw/DQtMs9+ZudZyBWNEmXaMQsmprU=; b=krn6zqqTOWYtMMpCD
	mLqZKVhTQjdKVji3CIHcZAS+LLYcwSCPch08Ch52BPeB4JYtEV+pSDQUPDGDr5Tr
	4CdgMqGWm9w+oBR+4CDGJ3g5tGI9JPDXcOltCmq2bQyKjVlGj6c815TymhfpFA2W
	fuNGhoR/yqNoGYI1nFQK8hKzcs7BStgSWomJwuFpGlcse1K5ZJNy+klDhwZbUSXG
	8RU8G+R193vweQuQ70FnwddOLeo7sHFdub3+NKA6c3rNyJ1rMr+HV8MiV5BvmJBu
	rUA+wV/aMRQTkU+5f4W6aRpVUM8tivY56iE0SUp+6GL5W316HJFq1+MNHDMs/Fyo
	fySIA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ev31r6fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:26:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 11:26:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 11:26:32 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 103713F7044;
	Wed,  4 Sep 2024 11:26:29 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v7 2/6] perf/marvell: Refactor to extract platform specific ops - no functional change
Date: Wed, 4 Sep 2024 23:56:01 +0530
Message-ID: <20240904182605.953927-3-gthiagarajan@marvell.com>
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
X-Proofpoint-ORIG-GUID: R2BWzE2-2tJ72FGliC7jnN-8LUUOLtXA
X-Proofpoint-GUID: R2BWzE2-2tJ72FGliC7jnN-8LUUOLtXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01

This commit introduces a refactor to the Marvell DDR pmu driver,
specifically targeting the extraction of ops
(referred to as "pmu ops") from the existing driver.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 106 +++++++++++++++++++++------
 1 file changed, 83 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index e33d383aa6d2..648ad3a740bf 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -136,6 +136,16 @@ struct cn10k_ddr_pmu {
 	struct hlist_node node;
 };
 
+struct ddr_pmu_ops {
+	void (*enable_read_freerun_counter)(struct cn10k_ddr_pmu *pmu,
+					    bool enable);
+	void (*enable_write_freerun_counter)(struct cn10k_ddr_pmu *pmu,
+					     bool enable);
+	void (*clear_read_freerun_counter)(struct cn10k_ddr_pmu *pmu);
+	void (*clear_write_freerun_counter)(struct cn10k_ddr_pmu *pmu);
+	void (*pmu_overflow_handler)(struct cn10k_ddr_pmu *pmu, int evt_idx);
+};
+
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
 
 struct ddr_pmu_platform_data {
@@ -152,6 +162,7 @@ struct ddr_pmu_platform_data {
 	u64 ddrc_perf_cnt_freerun_clr;
 	u64 ddrc_perf_cnt_value_wr_op;
 	u64 ddrc_perf_cnt_value_rd_op;
+	const struct ddr_pmu_ops *ops;
 };
 
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
@@ -375,6 +386,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 					  int counter, bool enable)
 {
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = p_data->ops;
 	u32 reg;
 	u64 val;
 
@@ -394,21 +406,10 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base +
-				    p_data->ddrc_perf_cnt_freerun_en);
-		if (enable) {
-			if (counter == DDRC_PERF_READ_COUNTER_IDX)
-				val |= DDRC_PERF_FREERUN_READ_EN;
-			else
-				val |= DDRC_PERF_FREERUN_WRITE_EN;
-		} else {
-			if (counter == DDRC_PERF_READ_COUNTER_IDX)
-				val &= ~DDRC_PERF_FREERUN_READ_EN;
-			else
-				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
-		}
-		writeq_relaxed(val, pmu->base +
-			       p_data->ddrc_perf_cnt_freerun_en);
+		if (counter == DDRC_PERF_READ_COUNTER_IDX)
+			ops->enable_read_freerun_counter(pmu, enable);
+		else
+			ops->enable_write_freerun_counter(pmu, enable);
 	}
 }
 
@@ -464,6 +465,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = p_data->ops;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
 	int counter, ret;
@@ -492,12 +494,9 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	} else {
 		/* fixed event counter, clear counter value */
 		if (counter == DDRC_PERF_READ_COUNTER_IDX)
-			val = DDRC_FREERUN_READ_CNT_CLR;
+			ops->clear_read_freerun_counter(pmu);
 		else
-			val = DDRC_FREERUN_WRITE_CNT_CLR;
-
-		writeq_relaxed(val, pmu->base +
-			       p_data->ddrc_perf_cnt_freerun_ctrl);
+			ops->clear_write_freerun_counter(pmu);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -579,9 +578,63 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 	}
 }
 
+static void ddr_pmu_enable_read_freerun(struct cn10k_ddr_pmu *pmu, bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_en);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_READ_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_READ_EN;
+
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_en);
+}
+
+static void ddr_pmu_enable_write_freerun(struct cn10k_ddr_pmu *pmu, bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_en);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_WRITE_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_WRITE_EN;
+
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_en);
+}
+
+static void ddr_pmu_read_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_READ_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_write_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_WRITE_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
+{
+	cn10k_ddr_perf_event_update_all(pmu);
+	cn10k_ddr_perf_pmu_disable(&pmu->pmu);
+	cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+}
+
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = p_data->ops;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -621,9 +674,7 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 		value = cn10k_ddr_perf_read_counter(pmu, i);
 		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
-			cn10k_ddr_perf_event_update_all(pmu);
-			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
-			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			ops->pmu_overflow_handler(pmu, i);
 		}
 	}
 
@@ -662,6 +713,14 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static const struct ddr_pmu_ops ddr_pmu_ops = {
+	.enable_read_freerun_counter = ddr_pmu_enable_read_freerun,
+	.enable_write_freerun_counter = ddr_pmu_enable_write_freerun,
+	.clear_read_freerun_counter = ddr_pmu_read_clear_freerun,
+	.clear_write_freerun_counter = ddr_pmu_write_clear_freerun,
+	.pmu_overflow_handler = ddr_pmu_overflow_hander,
+};
+
 static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
 	.counter_overflow_val =  BIT_ULL(48),
 	.counter_max_val = GENMASK_ULL(48, 0),
@@ -676,6 +735,7 @@ static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
 	.ddrc_perf_cnt_freerun_clr = 0,
 	.ddrc_perf_cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
 	.ddrc_perf_cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
+	.ops = &ddr_pmu_ops,
 };
 
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
-- 
2.25.1


