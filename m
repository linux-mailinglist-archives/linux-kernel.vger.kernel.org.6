Return-Path: <linux-kernel+bounces-367534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82A9A037F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B17B279B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9661D1E6A;
	Wed, 16 Oct 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZC3ClbR/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177C1D1724
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065767; cv=none; b=lgL2dlOhjMbDiGEm6Z8+YeexfriVmaFOOIxnhdTtFjxFErO4m2/YSaxRF9IFR+4ZIvous7txg5PyxJxN2Y3/6ErFtekFfUWOHB0PRkWxlSeUB/Q4niTSNYJDZHOBfNqLmEgaEPWXJwR8P0a9ZRhcNPt5HTLC3CMwYmdcKLJuH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065767; c=relaxed/simple;
	bh=f73UcqI1xsrlchW3YDLrpd6COuVe4LITVXYvhFaylEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDYX8OI63+n1jvqFqSzcViV8Swk5OfMp6so1sRBPTQmP4CGTogSu2KN+FOKQ75gbHS23sfAqYvU+xFOVlVTgFEJpVStBZz0DU1CObHMLk2qZ0qyxa0jfJvhj4raR5wr63x666laz/BbX45lx5yBcbLdUCRGIY40CXndeam8VBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZC3ClbR/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G2fiNS021631;
	Wed, 16 Oct 2024 01:02:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	1xhiLDxda/rr99yyZNzRLZh8vxDZpgamSPq1Ju3iIQ=; b=ZC3ClbR/8fsJe4TyJ
	6BCflVOfCCZnZCfj/b7PZc/h6HMSm2sa0Jjrom5Yeh4zwmpgmlCYANiEDyl6mFWH
	zhERf0zEzNTnboCpxZA12/8jmo8ZUPZBKCJdYaNEUpSlhXDqcoSMixlql6bMCUP0
	kSFg6RmXPUlKOJV4rk/dwGWoz2a2RXNdfsf3lYee026hZn+O2yO5PRtSxVCHhpOt
	e+to9OsoPXXBA7by3lEL3nM7U6ruviYTnW0AhbHXhuPp1d7saA/70KxIeGoBq/e7
	8URtdfTq2aYkUr24Ueidzw0WSxCwTPdpWNq1sBnF/Waie6chdmeZ4VZf/2vTQjSC
	j6RnA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42a4x4gfut-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 01:02:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 01:02:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 01:02:18 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id CC09D3F7074;
	Wed, 16 Oct 2024 01:02:15 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <bbhushan2@marvell.com>, <gcherian@marvell.com>, <sgoutham@marvell.com>,
        <jonathan.cameron@huawei.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>
Subject: [PATCH v9 2/5] perf/marvell: Refactor to extract platform specific ops - no functional change
Date: Wed, 16 Oct 2024 13:31:50 +0530
Message-ID: <20241016080153.3546353-3-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016080153.3546353-1-gthiagarajan@marvell.com>
References: <20241016080153.3546353-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pk-r2ySu9QoIMJ6PXiKZsMy-7FviW9Ux
X-Proofpoint-ORIG-GUID: pk-r2ySu9QoIMJ6PXiKZsMy-7FviW9Ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This commit introduces a refactor to the Marvell DDR pmu driver,
specifically targeting the extraction of ops
(referred to as "pmu ops") from the existing driver.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 105 +++++++++++++++++++++------
 1 file changed, 83 insertions(+), 22 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index ed929102b53d..0b340540e175 100644
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
 		writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
 			       ddr_pmu->p_data->cnt_op_mode_ctrl);
-- 
2.25.1


