Return-Path: <linux-kernel+bounces-401021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293879C1515
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C101F23CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672F1A2564;
	Fri,  8 Nov 2024 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MkczBdxh"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262C3BBEA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038869; cv=none; b=LiWvL86vEQa78qOiSdZ+IrBnh1TNf0gpdYKEWuaq5jv8dKuDM8eCXcemkkIkZ0Ryg2KERYNFCj8Pt6BbWsU4x+mU+Uo2AK4iYQhXNHFp7luj6f8DyVYIkYJQroX1JvD5gqmgnTzpQXZq7wRnSvnlII6c+RxQW0PiK6FXYtVYvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038869; c=relaxed/simple;
	bh=E4KcD6sj5fX2nQMQbXYww0kcWWe1VrmTl1dUMbkqiE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaLxshtFoywM2dKF3GcF1Zr9eWVzG680LGgh5r4OrZ1Au8YRxevc0m3CfyGoaAQTeP7naD1jkO+Lhvx6dIxwR2KrF8LkLFzogAI6hxS/+Ne+vBRplllLpp2JsRlewadm6QFpDvsu7h/tboSaQL76rfRLVocJx2miyX7euWRYRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MkczBdxh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbeZC022679;
	Thu, 7 Nov 2024 20:07:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	V9fg5QbZH9KY2cVOi3dNLkO7JfK17uh2ZE8AgYK5wU=; b=MkczBdxhigXHZbdmF
	ml+7Iv2VpDReouMbkwSC/dat277pA5pNRgOxdll/0NRVJHizsJCeIOVdBvMXIFWP
	prMR7quL/gDPBd8TJnhe/qWPW5F8zdtBVNsjeefKDxtu0ZUHr3fxsdcwTMfnJ1TY
	hd/t5JNifIE2tr6vAAsbfF7qLu6Jf5tpn82fzhwJC0OENNqOIz9DyIgWdxmcnrH0
	Pv0EQFcYT68nzKryUAySk1I6paQvr5qqqnZVjcVvr1lxzCmvJrhlP/1PWEr3DWuR
	C6Am7jcczJZv2/bJW262nmgECPvXJTCC3HXzDuLuYmaw1ysgp/COo1QtDxT6LjsN
	i691w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu8m30-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:07:33 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:06:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:06:33 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id D47F85B6926;
	Thu,  7 Nov 2024 20:06:30 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <bbhushan2@marvell.com>, <gcherian@marvell.com>, <sgoutham@marvell.com>,
        <jonathan.cameron@huawei.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v10 2/5] perf/marvell: Refactor to extract PMU operations
Date: Fri, 8 Nov 2024 09:36:16 +0530
Message-ID: <20241108040619.753343-3-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108040619.753343-1-gthiagarajan@marvell.com>
References: <20241108040619.753343-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R-2qhBaiz9FH0SJBfb2QkEE3Xwqvix_V
X-Proofpoint-GUID: R-2qhBaiz9FH0SJBfb2QkEE3Xwqvix_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Introduce a refactor to the Marvell DDR PMU driver to extract
PMU operations ("pmu ops") from the existing driver.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 105 +++++++++++++++++++++------
 1 file changed, 83 insertions(+), 22 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index efac4cef4050..45da37e702a2 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -127,6 +127,7 @@ struct cn10k_ddr_pmu {
 	struct pmu pmu;
 	void __iomem *base;
 	const struct ddr_pmu_platform_data *p_data;
+	const struct ddr_pmu_ops *ops;
 	unsigned int cpu;
 	struct	device *dev;
 	int active_events;
@@ -135,6 +136,16 @@ struct cn10k_ddr_pmu {
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
@@ -375,6 +386,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 					  int counter, bool enable)
 {
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = pmu->ops;
 	u32 reg;
 	u64 val;
 
@@ -394,21 +406,10 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base +
-				    p_data->cnt_freerun_en);
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
-			       p_data->cnt_freerun_en);
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
+	const struct ddr_pmu_ops *ops = pmu->ops;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
 	int counter, ret;
@@ -492,11 +494,9 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	} else {
 		/* fixed event counter, clear counter value */
 		if (counter == DDRC_PERF_READ_COUNTER_IDX)
-			val = DDRC_FREERUN_READ_CNT_CLR;
+			ops->clear_read_freerun_counter(pmu);
 		else
-			val = DDRC_FREERUN_WRITE_CNT_CLR;
-
-		writeq_relaxed(val, pmu->base + p_data->cnt_freerun_ctrl);
+			ops->clear_write_freerun_counter(pmu);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -578,9 +578,63 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 	}
 }
 
+static void ddr_pmu_enable_read_freerun(struct cn10k_ddr_pmu *pmu, bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->cnt_freerun_en);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_READ_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_READ_EN;
+
+	writeq_relaxed(val, pmu->base + p_data->cnt_freerun_en);
+}
+
+static void ddr_pmu_enable_write_freerun(struct cn10k_ddr_pmu *pmu, bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->cnt_freerun_en);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_WRITE_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_WRITE_EN;
+
+	writeq_relaxed(val, pmu->base + p_data->cnt_freerun_en);
+}
+
+static void ddr_pmu_read_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_READ_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_write_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_WRITE_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->cnt_freerun_ctrl);
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
+	const struct ddr_pmu_ops *ops = pmu->ops;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -620,9 +674,7 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 		value = cn10k_ddr_perf_read_counter(pmu, i);
 		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
-			cn10k_ddr_perf_event_update_all(pmu);
-			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
-			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			ops->pmu_overflow_handler(pmu, i);
 		}
 	}
 
@@ -661,6 +713,14 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
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
 #if defined(CONFIG_ACPI) || defined(CONFIG_OF)
 static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
 	.counter_overflow_val =  BIT_ULL(48),
@@ -713,6 +773,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	is_cn10k = ddr_pmu->p_data->is_cn10k;
 
 	if (is_cn10k) {
+		ddr_pmu->ops = &ddr_pmu_ops;
 		/* Setup the PMU counter to work in manual mode */
 		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
 			       ddr_pmu->p_data->cnt_op_mode_ctrl);
-- 
2.25.1


