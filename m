Return-Path: <linux-kernel+bounces-315734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949E96C658
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2DA1F2619C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7D1E410D;
	Wed,  4 Sep 2024 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kF/j1hda"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8C1E1A04
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474400; cv=none; b=Uavo8CQ70cpfl9GShw8Xhyb6XLKPgdlZmTSzv1o7MGLyD+kUvo0eYjActb4O9F2l+Wuaq03WE+Nc5RJZlK5feSJNeU6UNYYOyhuEphyQIx9q7BXwAQ1RRkPYlvnPOcidfavriDnAbnhO716Af3KskVbfPqW5BX2QNHf31gNvPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474400; c=relaxed/simple;
	bh=Aoh/8y5Lknrp0RPwDNnrveLn3DXPHCRXdW/8xcrokoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9hub2Cbvoa/CeULM9U5jaVJVBc6oGPQw6rkh63iKB3B8ldVQfdPJ1pHnCQpHaMQKFFJvEjSpxb4HioLhfv8Uhu2dIGWaa+iPetM9DfK6h8u/+nRtWX83xfAh7aJ0ssHcspc3K/YkgJba97j/pObc3yPkEs2Cbnqm28bpBmHO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kF/j1hda; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484EHHaI010434;
	Wed, 4 Sep 2024 11:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	vcnGVyI8Dw5pDCMMbupUgw+CsZJKDfzxSi9l4dxRlc=; b=kF/j1hdaXG/R/XWIp
	AGU/IPJMu5hbrK9U43NKjkcpHNlDWqs/7PfAGVDRzShR8ccys5ZoF9Ox5mUZnx0W
	1nq8cbx+hDN5QZSNjpVa5xC4JlImbpKZFmTza/k5NweFsrSAdw+3J5x9h93yzMGO
	ndbDPKgjvUumK6duuHA9KFgJV1mVZpdEkua+0zZCCjP9jnmv/wyN4NwnEykMZbHU
	cgzAL+i/x0AGaHBuKMVQ5SajnHI9aANh9goI0nSKMcTy/1I8oI6l8x4d+WBpFLMq
	nvfhPyRHhn4/xJRxLj4JsbL4AKlDYV+aWd/N0Z3a9b37x4fDnEbdaYPPro0p95RJ
	CAyog==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41es66h578-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:26:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 11:26:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 11:26:28 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 059703F7044;
	Wed,  4 Sep 2024 11:26:25 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v7 1/6] perf/marvell: Refactor to extract platform data - no functional change
Date: Wed, 4 Sep 2024 23:56:00 +0530
Message-ID: <20240904182605.953927-2-gthiagarajan@marvell.com>
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
X-Proofpoint-GUID: CUDi10bky4PcP9bPPkOWO5Hs3MHDVyaR
X-Proofpoint-ORIG-GUID: CUDi10bky4PcP9bPPkOWO5Hs3MHDVyaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01

This commit introduces a refactor to the Marvell DDR pmu driver,
specifically targeting the extraction of platform data
(referred to as "pdata") from the existing driver. The purpose of
this refactor is to prepare for the upcoming support of the next
version of the Performance Monitoring Unit (PMU) in this
driver.

No functional changes are introduced in this refactor. Its sole
purpose is to improve code organization and pave the way for
future enhancements to the driver.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 127 +++++++++++++++++++--------
 1 file changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 94f1ebcd2a27..e33d383aa6d2 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
+/*
+ * Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
  *
- * Copyright (C) 2021 Marvell.
+ * Copyright (C) 2024 Marvell.
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
@@ -42,17 +43,19 @@
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
  * program event bitmap in h/w.
+ *
  */
 #define EVENT_OP_IS_ZQLATCH			55
 #define EVENT_OP_IS_ZQSTART			54
@@ -63,8 +66,8 @@
 #define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
 #define EVENT_BSM_STARVATION			48
 #define EVENT_BSM_ALLOC				47
-#define EVENT_LPR_REQ_WITH_NOCREDIT		46
-#define EVENT_HPR_REQ_WITH_NOCREDIT		45
+#define EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED	46
+#define EVENT_DFI_OR_HPR_REQ_NOCRED		45
 #define EVENT_OP_IS_ZQCS			44
 #define EVENT_OP_IS_ZQCL			43
 #define EVENT_OP_IS_LOAD_MODE			42
@@ -102,28 +105,29 @@
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
@@ -134,6 +138,22 @@ struct cn10k_ddr_pmu {
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
 
+struct ddr_pmu_platform_data {
+	u64 counter_overflow_val;
+	u64 counter_max_val;
+	u64 ddrc_perf_cnt_base;
+	u64 ddrc_perf_cfg_base;
+	u64 ddrc_perf_cnt_op_mode_ctrl;
+	u64 ddrc_perf_cnt_start_op_ctrl;
+	u64 ddrc_perf_cnt_end_op_ctrl;
+	u64 ddrc_perf_cnt_end_status;
+	u64 ddrc_perf_cnt_freerun_en;
+	u64 ddrc_perf_cnt_freerun_ctrl;
+	u64 ddrc_perf_cnt_freerun_clr;
+	u64 ddrc_perf_cnt_value_wr_op;
+	u64 ddrc_perf_cnt_value_rd_op;
+};
+
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -189,9 +209,9 @@ static struct attribute *cn10k_ddr_perf_events_attrs[] = {
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpr_req_with_nocredit,
-					EVENT_HPR_REQ_WITH_NOCREDIT),
+				 EVENT_DFI_OR_HPR_REQ_NOCRED),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpr_req_with_nocredit,
-					EVENT_LPR_REQ_WITH_NOCREDIT),
+				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
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
+		reg = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
 		val = readq_relaxed(pmu->base + reg);
 
 		if (enable)
@@ -373,7 +394,8 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		val = readq_relaxed(pmu->base +
+				    p_data->ddrc_perf_cnt_freerun_en);
 		if (enable) {
 			if (counter == DDRC_PERF_READ_COUNTER_IDX)
 				val |= DDRC_PERF_FREERUN_READ_EN;
@@ -385,27 +407,33 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 			else
 				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
 		}
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		writeq_relaxed(val, pmu->base +
+			       p_data->ddrc_perf_cnt_freerun_en);
 	}
 }
 
 static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	u64 val;
 
 	if (counter == DDRC_PERF_READ_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->ddrc_perf_cnt_value_rd_op);
 
 	if (counter == DDRC_PERF_WRITE_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_WR_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->ddrc_perf_cnt_value_wr_op);
 
-	val = readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
+	val = readq_relaxed(pmu->base +
+			    DDRC_PERF_REG(p_data->ddrc_perf_cnt_base, counter));
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
+		reg_offset = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
 		ret = ddr_perf_get_event_bitmap(config, &val);
 		if (ret)
 			return ret;
@@ -467,7 +496,8 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 		else
 			val = DDRC_FREERUN_WRITE_CNT_CLR;
 
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
+		writeq_relaxed(val, pmu->base +
+			       p_data->ddrc_perf_cnt_freerun_ctrl);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -512,17 +542,19 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
-		       DDRC_PERF_CNT_START_OP_CTRL);
+		       p_data->ddrc_perf_cnt_start_op_ctrl);
 }
 
 static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
-		       DDRC_PERF_CNT_END_OP_CTRL);
+		       p_data->ddrc_perf_cnt_end_op_ctrl);
 }
 
 static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
@@ -549,6 +581,7 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -586,7 +619,7 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 			continue;
 
 		value = cn10k_ddr_perf_read_counter(pmu, i);
-		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
 			cn10k_ddr_perf_event_update_all(pmu);
 			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
@@ -629,8 +662,25 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
+	.counter_overflow_val =  BIT_ULL(48),
+	.counter_max_val = GENMASK_ULL(48, 0),
+	.ddrc_perf_cnt_base = CN10K_DDRC_PERF_CNT_VALUE_BASE,
+	.ddrc_perf_cfg_base = CN10K_DDRC_PERF_CFG_BASE,
+	.ddrc_perf_cnt_op_mode_ctrl = CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.ddrc_perf_cnt_start_op_ctrl = CN10K_DDRC_PERF_CNT_START_OP_CTRL,
+	.ddrc_perf_cnt_end_op_ctrl = CN10K_DDRC_PERF_CNT_END_OP_CTRL,
+	.ddrc_perf_cnt_end_status = CN10K_DDRC_PERF_CNT_END_STATUS,
+	.ddrc_perf_cnt_freerun_en = CN10K_DDRC_PERF_CNT_FREERUN_EN,
+	.ddrc_perf_cnt_freerun_ctrl = CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
+	.ddrc_perf_cnt_freerun_clr = 0,
+	.ddrc_perf_cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
+	.ddrc_perf_cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
+};
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
+	const struct ddr_pmu_data *dev_data;
 	struct cn10k_ddr_pmu *ddr_pmu;
 	struct resource *res;
 	void __iomem *base;
@@ -644,15 +694,22 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
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
 
+	ddr_pmu->p_data = &cn10k_ddr_pmu_pdata;
 	/* Setup the PMU counter to work in manual mode */
-	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
-		       DDRC_PERF_CNT_OP_MODE_CTRL);
+	writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
+		       ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl);
 
 	ddr_pmu->pmu = (struct pmu) {
 		.module	      = THIS_MODULE,
@@ -688,7 +745,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
+	pr_info("DDR PMU Driver for ddrc@%llx\n", res->start);
 	return 0;
 error:
 	cpuhp_state_remove_instance_nocalls(
-- 
2.25.1


