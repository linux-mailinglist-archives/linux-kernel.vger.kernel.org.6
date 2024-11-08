Return-Path: <linux-kernel+bounces-401025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF53B9C151A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D285F1C2222B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4101C1C8FB9;
	Fri,  8 Nov 2024 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XcopX1zj"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C523BBEA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038988; cv=none; b=iVsDMrFo6Qq3Z0bwydrKUtGaPfvHf6z27cvic7da07jxDqMaRNq8sYTW4kF4wZ6PVAt0qIFtLa0UoiwI38R+IK5v8zfF7ogYZu+EZVKCkxf+YM0FfyIyMIR6ZPFihrOcbIqf436ukhOrbmt/BncTbQ5VWbxHEpJcgrWYQNmKwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038988; c=relaxed/simple;
	bh=CzpaGIoLqAXKYgtuG87044g0qnQbh0onVsDAmLaAVQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQunGu3PjpTZ/pxbhxL80FmbDX7zvBIeS/iypkihqGGFRC+DWLZLiEwwt6GUEq2HmCRInEiGFeDY6DBoY+OiK8y8TH2kLErmrqPT1w0L121LdlhBkBepI/SXdyZBsUDs9h/9hMdo+rp5MvWpZX1beI1EBIWxCqpfJoPdQvatoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XcopX1zj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbeZ6022679;
	Thu, 7 Nov 2024 20:07:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	fkcuWOh8PDxhCG8cbcHxtId4AQt8wG85bsA35KSDpI=; b=XcopX1zj8wy7Rq6Yj
	DPr95MFLn1tfBSVMWtM6ZKADowAbOX0+2WZdKApE/6LeafzRQUEC/WsRhI/iYmJF
	3HlHKyvHLA+PsR/D01YhR3ve5/XMqMmgkUCXw2t9staeyP+6glLxUoKT7sirwBYB
	53Qk+ypa1AxX2yed2ZCrx7kIcnp91wcp1OVWZUJ103AMBb4aXpol9HrwF4WavLdB
	WwjF2wfg3nv8qvqfWxrPjxGrb9u4lVtkaBxLBO4anhhuhWutXHJbNUEyK0puhFqf
	Ve0i6TcO4JTkWf8kR2FckhF/LzbGNHjzkSW0xsENxeux6qOhS/ysWtC4Ugen89S3
	YY67g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu8m30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:07:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:06:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:06:29 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id D7B525B6926;
	Thu,  7 Nov 2024 20:06:26 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <bbhushan2@marvell.com>, <gcherian@marvell.com>, <sgoutham@marvell.com>,
        <jonathan.cameron@huawei.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>
Subject: [PATCH v10 1/5] perf/marvell: Refactor to extract platform data - no functional change
Date: Fri, 8 Nov 2024 09:36:15 +0530
Message-ID: <20241108040619.753343-2-gthiagarajan@marvell.com>
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
X-Proofpoint-ORIG-GUID: zJ3fjDKT7iVRG8VWeo3HHqGmaN3cmjFt
X-Proofpoint-GUID: zJ3fjDKT7iVRG8VWeo3HHqGmaN3cmjFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Introduce a refactor to the Marvell DDR pmu driver to extract platform
data ("pdata") from the existing driver. Prepare for the upcoming
support of the next version of the Performance Monitoring Unit (PMU) in
this driver.

Make no functional changes, this refactor solely improves code
organization and prepares for future enhancements.

While at it, fix a typo.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 162 +++++++++++++++++++--------
 1 file changed, 113 insertions(+), 49 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 94f1ebcd2a27..efac4cef4050 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
+/*
+ * Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
  *
- * Copyright (C) 2021 Marvell.
+ * Copyright (C) 2021-2024 Marvell.
  */
 
 #include <linux/init.h>
@@ -14,24 +15,24 @@
 #include <linux/platform_device.h>
 
 /* Performance Counters Operating Mode Control Registers */
-#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
-#define OP_MODE_CTRL_VAL_MANNUAL	0x1
+#define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
+#define OP_MODE_CTRL_VAL_MANUAL	0x1
 
 /* Performance Counters Start Operation Control Registers */
-#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
+#define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
 #define START_OP_CTRL_VAL_START		0x1ULL
 #define START_OP_CTRL_VAL_ACTIVE	0x2
 
 /* Performance Counters End Operation Control Registers */
-#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
+#define CN10K_DDRC_PERF_CNT_END_OP_CTRL	0x8030
 #define END_OP_CTRL_VAL_END		0x1ULL
 
 /* Performance Counters End Status Registers */
-#define DDRC_PERF_CNT_END_STATUS		0x8038
+#define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
 #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
 
 /* Performance Counters Configuration Registers */
-#define DDRC_PERF_CFG_BASE		0x8040
+#define CN10K_DDRC_PERF_CFG_BASE		0x8040
 
 /* 8 Generic event counter + 2 fixed event counters */
 #define DDRC_PERF_NUM_GEN_COUNTERS	8
@@ -42,13 +43,14 @@
 					 DDRC_PERF_NUM_FIX_COUNTERS)
 
 /* Generic event counter registers */
-#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
+#define DDRC_PERF_CFG(base, n)		((base) + 8 * (n))
 #define EVENT_ENABLE			BIT_ULL(63)
 
 /* Two dedicated event counters for DDR reads and writes */
 #define EVENT_DDR_READS			101
 #define EVENT_DDR_WRITES		100
 
+#define DDRC_PERF_REG(base, n)		((base) + 8 * (n))
 /*
  * programmable events IDs in programmable event counters.
  * DO NOT change these event-id numbers, they are used to
@@ -102,28 +104,29 @@
 #define EVENT_HIF_RD_OR_WR			1
 
 /* Event counter value registers */
-#define DDRC_PERF_CNT_VALUE_BASE		0x8080
-#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
+#define CN10K_DDRC_PERF_CNT_VALUE_BASE	0x8080
 
 /* Fixed event counter enable/disable register */
-#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
+#define CN10K_DDRC_PERF_CNT_FREERUN_EN		0x80C0
 #define DDRC_PERF_FREERUN_WRITE_EN	0x1
 #define DDRC_PERF_FREERUN_READ_EN	0x2
 
 /* Fixed event counter control register */
-#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
+#define CN10K_DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
 #define DDRC_FREERUN_WRITE_CNT_CLR	0x1
 #define DDRC_FREERUN_READ_CNT_CLR	0x2
 
-/* Fixed event counter value register */
-#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
-#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
 #define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
 #define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
 
+/* Fixed event counter value register */
+#define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
+#define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
+
 struct cn10k_ddr_pmu {
 	struct pmu pmu;
 	void __iomem *base;
+	const struct ddr_pmu_platform_data *p_data;
 	unsigned int cpu;
 	struct	device *dev;
 	int active_events;
@@ -134,6 +137,23 @@ struct cn10k_ddr_pmu {
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
 
+struct ddr_pmu_platform_data {
+	u64 counter_overflow_val;
+	u64 counter_max_val;
+	u64 cnt_base;
+	u64 cfg_base;
+	u64 cnt_op_mode_ctrl;
+	u64 cnt_start_op_ctrl;
+	u64 cnt_end_op_ctrl;
+	u64 cnt_end_status;
+	u64 cnt_freerun_en;
+	u64 cnt_freerun_ctrl;
+	u64 cnt_freerun_clr;
+	u64 cnt_value_wr_op;
+	u64 cnt_value_rd_op;
+	bool is_cn10k;
+};
+
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -354,6 +374,7 @@ static int cn10k_ddr_perf_event_init(struct perf_event *event)
 static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 					  int counter, bool enable)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	u32 reg;
 	u64 val;
 
@@ -363,7 +384,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 	}
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
-		reg = DDRC_PERF_CFG(counter);
+		reg = DDRC_PERF_CFG(p_data->cfg_base, counter);
 		val = readq_relaxed(pmu->base + reg);
 
 		if (enable)
@@ -373,7 +394,8 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		val = readq_relaxed(pmu->base +
+				    p_data->cnt_freerun_en);
 		if (enable) {
 			if (counter == DDRC_PERF_READ_COUNTER_IDX)
 				val |= DDRC_PERF_FREERUN_READ_EN;
@@ -385,27 +407,33 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 			else
 				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
 		}
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		writeq_relaxed(val, pmu->base +
+			       p_data->cnt_freerun_en);
 	}
 }
 
 static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	u64 val;
 
 	if (counter == DDRC_PERF_READ_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->cnt_value_rd_op);
 
 	if (counter == DDRC_PERF_WRITE_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_WR_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->cnt_value_wr_op);
 
-	val = readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
+	val = readq_relaxed(pmu->base +
+			    DDRC_PERF_REG(p_data->cnt_base, counter));
 	return val;
 }
 
 static void cn10k_ddr_perf_event_update(struct perf_event *event)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct hw_perf_event *hwc = &event->hw;
 	u64 prev_count, new_count, mask;
 
@@ -414,7 +442,7 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
 
-	mask = DDRC_PERF_CNT_MAX_VALUE;
+	mask = p_data->counter_max_val;
 
 	local64_add((new_count - prev_count) & mask, &event->count);
 }
@@ -435,6 +463,7 @@ static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
 	int counter, ret;
@@ -454,7 +483,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
-		reg_offset = DDRC_PERF_CFG(counter);
+		reg_offset = DDRC_PERF_CFG(p_data->cfg_base, counter);
 		ret = ddr_perf_get_event_bitmap(config, &val);
 		if (ret)
 			return ret;
@@ -467,7 +496,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 		else
 			val = DDRC_FREERUN_WRITE_CNT_CLR;
 
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
+		writeq_relaxed(val, pmu->base + p_data->cnt_freerun_ctrl);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -512,17 +541,19 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
-		       DDRC_PERF_CNT_START_OP_CTRL);
+		       p_data->cnt_start_op_ctrl);
 }
 
 static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
-		       DDRC_PERF_CNT_END_OP_CTRL);
+		       p_data->cnt_end_op_ctrl);
 }
 
 static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
@@ -549,6 +580,7 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -586,7 +618,7 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 			continue;
 
 		value = cn10k_ddr_perf_read_counter(pmu, i);
-		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
 			cn10k_ddr_perf_event_update_all(pmu);
 			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
@@ -629,11 +661,32 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI) || defined(CONFIG_OF)
+static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
+	.counter_overflow_val =  BIT_ULL(48),
+	.counter_max_val = GENMASK_ULL(48, 0),
+	.cnt_base = CN10K_DDRC_PERF_CNT_VALUE_BASE,
+	.cfg_base = CN10K_DDRC_PERF_CFG_BASE,
+	.cnt_op_mode_ctrl = CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.cnt_start_op_ctrl = CN10K_DDRC_PERF_CNT_START_OP_CTRL,
+	.cnt_end_op_ctrl = CN10K_DDRC_PERF_CNT_END_OP_CTRL,
+	.cnt_end_status = CN10K_DDRC_PERF_CNT_END_STATUS,
+	.cnt_freerun_en = CN10K_DDRC_PERF_CNT_FREERUN_EN,
+	.cnt_freerun_ctrl = CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
+	.cnt_freerun_clr = 0,
+	.cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
+	.cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
+	.is_cn10k = TRUE,
+};
+#endif
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
+	const struct ddr_pmu_platform_data *dev_data;
 	struct cn10k_ddr_pmu *ddr_pmu;
 	struct resource *res;
 	void __iomem *base;
+	bool is_cn10k;
 	char *name;
 	int ret;
 
@@ -644,30 +697,41 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	ddr_pmu->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ddr_pmu);
 
+	dev_data = device_get_match_data(&pdev->dev);
+	if (!dev_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	ddr_pmu->base = base;
 
-	/* Setup the PMU counter to work in manual mode */
-	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
-		       DDRC_PERF_CNT_OP_MODE_CTRL);
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
+	ddr_pmu->p_data = dev_data;
+	is_cn10k = ddr_pmu->p_data->is_cn10k;
+
+	if (is_cn10k) {
+		/* Setup the PMU counter to work in manual mode */
+		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
+			       ddr_pmu->p_data->cnt_op_mode_ctrl);
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
@@ -688,7 +752,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
+	pr_info("DDR PMU Driver for ddrc@%llx\n", res->start);
 	return 0;
 error:
 	cpuhp_state_remove_instance_nocalls(
@@ -710,7 +774,7 @@ static void cn10k_ddr_perf_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ .compatible = "marvell,cn10k-ddr-pmu", .data = &cn10k_ddr_pmu_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -718,7 +782,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
-	{"MRVL000A", 0},
+	{"MRVL000A", (kernel_ulong_t)&cn10k_ddr_pmu_pdata },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1


