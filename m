Return-Path: <linux-kernel+bounces-518994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C955A396DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C65116D714
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C9233D69;
	Tue, 18 Feb 2025 09:19:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D122F15E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870394; cv=none; b=kL/FGutXAytI72C/PBAzqTWv6XnW/rBS79zDrNuRUVGx5Jn3TkGIij79Gya8tFof1+YkMxcaffabZIbnHdA8KZW52jslecP/M9LB506x2Nj+F6/W2ZIwsBTIr0ecvh8eQFXMDoe2/KcTCGduQpIz5xdfqyGNzCDY4myCmJLjHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870394; c=relaxed/simple;
	bh=qeRTdXkl6zNx0/tUBJ1BnWkyrjL2OSMyfnZZBK/6VIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YScRMK7BJdUM3EVtR/GU+cxlZZbRNgji2PVEnbHE8VzLQ5XNQMxRxiDFn50eAilNJ3y4OvE1/teaYaxSz/n+39V+O4rt198k42B6WrguJD5Bn/ktNFdSUFaM4gbpTsrQ/NF3YnJMDfk/f3HsgVeqDIgj2LkGYuSdKMlmVs0X+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yxv5R1qrmz1ltc0;
	Tue, 18 Feb 2025 17:15:55 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AA521400DD;
	Tue, 18 Feb 2025 17:19:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:47 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 2/9] drivers/perf: hisi: Simplify the probe process for each DDRC version
Date: Tue, 18 Feb 2025 17:19:53 +0800
Message-ID: <20250218092000.41641-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250218092000.41641-1-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Junhao He <hejunhao3@huawei.com>

Version 1 and 2 of DDRC PMU also use different HID. Make use of
struct acpi_device_id::driver_data for version specific information
rather than judge the version register. This will help to
simplify the probe process and also a bit easier for extension.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 328 ++++++++----------
 1 file changed, 140 insertions(+), 188 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 7e490f8868f2..7e3c2436e96b 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -50,6 +50,10 @@
 #define DDRC_V1_NR_EVENTS	0x7
 #define DDRC_V2_NR_EVENTS	0x90
 
+#define DDRC_EVENT_CNTn(base, n)	((base) + (n) * 8)
+#define DDRC_EVENT_TYPEn(base, n)	((base) + (n) * 4)
+#define DDRC_UNIMPLEMENTED_REG		GENMASK(31, 0)
+
 /*
  * For PMU v1, there are eight-events and every event has been mapped
  * to fixed-purpose counters which register offset is not consistent.
@@ -63,47 +67,37 @@ static const u32 ddrc_reg_off[] = {
 	DDRC_PRE_CMD, DDRC_ACT_CMD, DDRC_RNK_CHG, DDRC_RW_CHG
 };
 
-/*
- * Select the counter register offset using the counter index.
- * In PMU v1, there are no programmable counter, the count
- * is read form the statistics counter register itself.
- */
-static u32 hisi_ddrc_pmu_v1_get_counter_offset(int cntr_idx)
-{
-	return ddrc_reg_off[cntr_idx];
-}
-
-static u32 hisi_ddrc_pmu_v2_get_counter_offset(int cntr_idx)
-{
-	return DDRC_V2_EVENT_CNT + cntr_idx * 8;
-}
+struct hisi_ddrc_pmu_regs {
+	u32 event_cnt;
+	u32 event_ctrl;
+	u32 event_type;
+	u32 perf_ctrl;
+	u32 perf_ctrl_en;
+	u32 int_mask;
+	u32 int_clear;
+	u32 int_status;
+};
 
-static u64 hisi_ddrc_pmu_v1_read_counter(struct hisi_pmu *ddrc_pmu,
+static u64 hisi_ddrc_pmu_read_counter(struct hisi_pmu *ddrc_pmu,
 				      struct hw_perf_event *hwc)
 {
-	return readl(ddrc_pmu->base +
-		     hisi_ddrc_pmu_v1_get_counter_offset(hwc->idx));
-}
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 
-static void hisi_ddrc_pmu_v1_write_counter(struct hisi_pmu *ddrc_pmu,
-					struct hw_perf_event *hwc, u64 val)
-{
-	writel((u32)val,
-	       ddrc_pmu->base + hisi_ddrc_pmu_v1_get_counter_offset(hwc->idx));
-}
+	if (regs->event_cnt == DDRC_UNIMPLEMENTED_REG)
+		return readl(ddrc_pmu->base + ddrc_reg_off[hwc->idx]);
 
-static u64 hisi_ddrc_pmu_v2_read_counter(struct hisi_pmu *ddrc_pmu,
-					 struct hw_perf_event *hwc)
-{
-	return readq(ddrc_pmu->base +
-		     hisi_ddrc_pmu_v2_get_counter_offset(hwc->idx));
+	return readq(ddrc_pmu->base + DDRC_EVENT_CNTn(regs->event_cnt, hwc->idx));
 }
 
-static void hisi_ddrc_pmu_v2_write_counter(struct hisi_pmu *ddrc_pmu,
-					   struct hw_perf_event *hwc, u64 val)
+static void hisi_ddrc_pmu_write_counter(struct hisi_pmu *ddrc_pmu,
+					struct hw_perf_event *hwc, u64 val)
 {
-	writeq(val,
-	       ddrc_pmu->base + hisi_ddrc_pmu_v2_get_counter_offset(hwc->idx));
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
+
+	if (regs->event_cnt == DDRC_UNIMPLEMENTED_REG)
+		writel((u32)val, ddrc_pmu->base + ddrc_reg_off[hwc->idx]);
+	else
+		writeq(val, ddrc_pmu->base + DDRC_EVENT_CNTn(regs->event_cnt, hwc->idx));
 }
 
 /*
@@ -114,54 +108,12 @@ static void hisi_ddrc_pmu_v2_write_counter(struct hisi_pmu *ddrc_pmu,
 static void hisi_ddrc_pmu_write_evtype(struct hisi_pmu *ddrc_pmu, int idx,
 				       u32 type)
 {
-	u32 offset;
-
-	if (ddrc_pmu->identifier >= HISI_PMU_V2) {
-		offset = DDRC_V2_EVENT_TYPE + 4 * idx;
-		writel(type, ddrc_pmu->base + offset);
-	}
-}
-
-static void hisi_ddrc_pmu_v1_start_counters(struct hisi_pmu *ddrc_pmu)
-{
-	u32 val;
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 
-	/* Set perf_enable in DDRC_PERF_CTRL to start event counting */
-	val = readl(ddrc_pmu->base + DDRC_PERF_CTRL);
-	val |= DDRC_V1_PERF_CTRL_EN;
-	writel(val, ddrc_pmu->base + DDRC_PERF_CTRL);
-}
+	if (regs->event_type == DDRC_UNIMPLEMENTED_REG)
+		return;
 
-static void hisi_ddrc_pmu_v1_stop_counters(struct hisi_pmu *ddrc_pmu)
-{
-	u32 val;
-
-	/* Clear perf_enable in DDRC_PERF_CTRL to stop event counting */
-	val = readl(ddrc_pmu->base + DDRC_PERF_CTRL);
-	val &= ~DDRC_V1_PERF_CTRL_EN;
-	writel(val, ddrc_pmu->base + DDRC_PERF_CTRL);
-}
-
-static void hisi_ddrc_pmu_v1_enable_counter(struct hisi_pmu *ddrc_pmu,
-					    struct hw_perf_event *hwc)
-{
-	u32 val;
-
-	/* Set counter index(event code) in DDRC_EVENT_CTRL register */
-	val = readl(ddrc_pmu->base + DDRC_EVENT_CTRL);
-	val |= (1 << GET_DDRC_EVENTID(hwc));
-	writel(val, ddrc_pmu->base + DDRC_EVENT_CTRL);
-}
-
-static void hisi_ddrc_pmu_v1_disable_counter(struct hisi_pmu *ddrc_pmu,
-					     struct hw_perf_event *hwc)
-{
-	u32 val;
-
-	/* Clear counter index(event code) in DDRC_EVENT_CTRL register */
-	val = readl(ddrc_pmu->base + DDRC_EVENT_CTRL);
-	val &= ~(1 << GET_DDRC_EVENTID(hwc));
-	writel(val, ddrc_pmu->base + DDRC_EVENT_CTRL);
+	writel(type, ddrc_pmu->base + DDRC_EVENT_TYPEn(regs->event_type, idx));
 }
 
 static int hisi_ddrc_pmu_v1_get_event_idx(struct perf_event *event)
@@ -180,120 +132,96 @@ static int hisi_ddrc_pmu_v1_get_event_idx(struct perf_event *event)
 	return idx;
 }
 
-static int hisi_ddrc_pmu_v2_get_event_idx(struct perf_event *event)
+static int hisi_ddrc_pmu_get_event_idx(struct perf_event *event)
 {
+	struct hisi_pmu *ddrc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
+
+	if (regs->event_type == DDRC_UNIMPLEMENTED_REG)
+		return hisi_ddrc_pmu_v1_get_event_idx(event);
+
 	return hisi_uncore_pmu_get_event_idx(event);
 }
 
-static void hisi_ddrc_pmu_v2_start_counters(struct hisi_pmu *ddrc_pmu)
+static void hisi_ddrc_pmu_start_counters(struct hisi_pmu *ddrc_pmu)
 {
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(ddrc_pmu->base + DDRC_V2_PERF_CTRL);
-	val |= DDRC_V2_PERF_CTRL_EN;
-	writel(val, ddrc_pmu->base + DDRC_V2_PERF_CTRL);
+	val = readl(ddrc_pmu->base + regs->perf_ctrl);
+	val |= regs->perf_ctrl_en;
+	writel(val, ddrc_pmu->base + regs->perf_ctrl);
 }
 
-static void hisi_ddrc_pmu_v2_stop_counters(struct hisi_pmu *ddrc_pmu)
+static void hisi_ddrc_pmu_stop_counters(struct hisi_pmu *ddrc_pmu)
 {
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(ddrc_pmu->base + DDRC_V2_PERF_CTRL);
-	val &= ~DDRC_V2_PERF_CTRL_EN;
-	writel(val, ddrc_pmu->base + DDRC_V2_PERF_CTRL);
+	val = readl(ddrc_pmu->base + regs->perf_ctrl);
+	val &= ~regs->perf_ctrl_en;
+	writel(val, ddrc_pmu->base + regs->perf_ctrl);
 }
 
-static void hisi_ddrc_pmu_v2_enable_counter(struct hisi_pmu *ddrc_pmu,
+static void hisi_ddrc_pmu_enable_counter(struct hisi_pmu *ddrc_pmu,
 					    struct hw_perf_event *hwc)
 {
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(ddrc_pmu->base + DDRC_V2_EVENT_CTRL);
-	val |= 1 << hwc->idx;
-	writel(val, ddrc_pmu->base + DDRC_V2_EVENT_CTRL);
+	val = readl(ddrc_pmu->base + regs->event_ctrl);
+	val |= BIT_ULL(hwc->idx);
+	writel(val, ddrc_pmu->base + regs->event_ctrl);
 }
 
-static void hisi_ddrc_pmu_v2_disable_counter(struct hisi_pmu *ddrc_pmu,
+static void hisi_ddrc_pmu_disable_counter(struct hisi_pmu *ddrc_pmu,
 					     struct hw_perf_event *hwc)
 {
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(ddrc_pmu->base + DDRC_V2_EVENT_CTRL);
-	val &= ~(1 << hwc->idx);
-	writel(val, ddrc_pmu->base + DDRC_V2_EVENT_CTRL);
-}
-
-static void hisi_ddrc_pmu_v1_enable_counter_int(struct hisi_pmu *ddrc_pmu,
-						struct hw_perf_event *hwc)
-{
-	u32 val;
-
-	/* Write 0 to enable interrupt */
-	val = readl(ddrc_pmu->base + DDRC_INT_MASK);
-	val &= ~(1 << hwc->idx);
-	writel(val, ddrc_pmu->base + DDRC_INT_MASK);
-}
-
-static void hisi_ddrc_pmu_v1_disable_counter_int(struct hisi_pmu *ddrc_pmu,
-						 struct hw_perf_event *hwc)
-{
-	u32 val;
-
-	/* Write 1 to mask interrupt */
-	val = readl(ddrc_pmu->base + DDRC_INT_MASK);
-	val |= 1 << hwc->idx;
-	writel(val, ddrc_pmu->base + DDRC_INT_MASK);
+	val = readl(ddrc_pmu->base + regs->event_ctrl);
+	val &= ~BIT_ULL(hwc->idx);
+	writel(val, ddrc_pmu->base + regs->event_ctrl);
 }
 
-static void hisi_ddrc_pmu_v2_enable_counter_int(struct hisi_pmu *ddrc_pmu,
-						struct hw_perf_event *hwc)
+static void hisi_ddrc_pmu_enable_counter_int(struct hisi_pmu *ddrc_pmu,
+					     struct hw_perf_event *hwc)
 {
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(ddrc_pmu->base + DDRC_V2_INT_MASK);
-	val &= ~(1 << hwc->idx);
-	writel(val, ddrc_pmu->base + DDRC_V2_INT_MASK);
+	val = readl(ddrc_pmu->base + regs->int_mask);
+	val &= ~BIT_ULL(hwc->idx);
+	writel(val, ddrc_pmu->base + regs->int_mask);
 }
 
-static void hisi_ddrc_pmu_v2_disable_counter_int(struct hisi_pmu *ddrc_pmu,
-						struct hw_perf_event *hwc)
+static void hisi_ddrc_pmu_disable_counter_int(struct hisi_pmu *ddrc_pmu,
+					      struct hw_perf_event *hwc)
 {
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(ddrc_pmu->base + DDRC_V2_INT_MASK);
-	val |= 1 << hwc->idx;
-	writel(val, ddrc_pmu->base + DDRC_V2_INT_MASK);
+	val = readl(ddrc_pmu->base + regs->int_mask);
+	val |= BIT_ULL(hwc->idx);
+	writel(val, ddrc_pmu->base + regs->int_mask);
 }
 
-static u32 hisi_ddrc_pmu_v1_get_int_status(struct hisi_pmu *ddrc_pmu)
+static u32 hisi_ddrc_pmu_get_int_status(struct hisi_pmu *ddrc_pmu)
 {
-	return readl(ddrc_pmu->base + DDRC_INT_STATUS);
-}
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 
-static void hisi_ddrc_pmu_v1_clear_int_status(struct hisi_pmu *ddrc_pmu,
-					      int idx)
-{
-	writel(1 << idx, ddrc_pmu->base + DDRC_INT_CLEAR);
+	return readl(ddrc_pmu->base + regs->int_status);
 }
 
-static u32 hisi_ddrc_pmu_v2_get_int_status(struct hisi_pmu *ddrc_pmu)
+static void hisi_ddrc_pmu_clear_int_status(struct hisi_pmu *ddrc_pmu,
+					   int idx)
 {
-	return readl(ddrc_pmu->base + DDRC_V2_INT_STATUS);
-}
+	struct hisi_ddrc_pmu_regs *regs = ddrc_pmu->dev_info->private;
 
-static void hisi_ddrc_pmu_v2_clear_int_status(struct hisi_pmu *ddrc_pmu,
-					      int idx)
-{
-	writel(1 << idx, ddrc_pmu->base + DDRC_V2_INT_CLEAR);
+	writel(1 << idx, ddrc_pmu->base + regs->int_clear);
 }
 
-static const struct acpi_device_id hisi_ddrc_pmu_acpi_match[] = {
-	{ "HISI0233", },
-	{ "HISI0234", },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, hisi_ddrc_pmu_acpi_match);
-
 static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
 				   struct hisi_pmu *ddrc_pmu)
 {
@@ -314,6 +242,10 @@ static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	ddrc_pmu->dev_info = device_get_match_data(&pdev->dev);
+	if (!ddrc_pmu->dev_info)
+		return -ENODEV;
+
 	ddrc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddrc_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for ddrc_pmu resource\n");
@@ -396,34 +328,19 @@ static const struct attribute_group *hisi_ddrc_pmu_v2_attr_groups[] = {
 	NULL
 };
 
-static const struct hisi_uncore_ops hisi_uncore_ddrc_v1_ops = {
+static const struct hisi_uncore_ops hisi_uncore_ddrc_ops = {
 	.write_evtype           = hisi_ddrc_pmu_write_evtype,
-	.get_event_idx		= hisi_ddrc_pmu_v1_get_event_idx,
-	.start_counters		= hisi_ddrc_pmu_v1_start_counters,
-	.stop_counters		= hisi_ddrc_pmu_v1_stop_counters,
-	.enable_counter		= hisi_ddrc_pmu_v1_enable_counter,
-	.disable_counter	= hisi_ddrc_pmu_v1_disable_counter,
-	.enable_counter_int	= hisi_ddrc_pmu_v1_enable_counter_int,
-	.disable_counter_int	= hisi_ddrc_pmu_v1_disable_counter_int,
-	.write_counter		= hisi_ddrc_pmu_v1_write_counter,
-	.read_counter		= hisi_ddrc_pmu_v1_read_counter,
-	.get_int_status		= hisi_ddrc_pmu_v1_get_int_status,
-	.clear_int_status	= hisi_ddrc_pmu_v1_clear_int_status,
-};
-
-static const struct hisi_uncore_ops hisi_uncore_ddrc_v2_ops = {
-	.write_evtype           = hisi_ddrc_pmu_write_evtype,
-	.get_event_idx		= hisi_ddrc_pmu_v2_get_event_idx,
-	.start_counters		= hisi_ddrc_pmu_v2_start_counters,
-	.stop_counters		= hisi_ddrc_pmu_v2_stop_counters,
-	.enable_counter		= hisi_ddrc_pmu_v2_enable_counter,
-	.disable_counter	= hisi_ddrc_pmu_v2_disable_counter,
-	.enable_counter_int	= hisi_ddrc_pmu_v2_enable_counter_int,
-	.disable_counter_int	= hisi_ddrc_pmu_v2_disable_counter_int,
-	.write_counter		= hisi_ddrc_pmu_v2_write_counter,
-	.read_counter		= hisi_ddrc_pmu_v2_read_counter,
-	.get_int_status		= hisi_ddrc_pmu_v2_get_int_status,
-	.clear_int_status	= hisi_ddrc_pmu_v2_clear_int_status,
+	.get_event_idx		= hisi_ddrc_pmu_get_event_idx,
+	.start_counters		= hisi_ddrc_pmu_start_counters,
+	.stop_counters		= hisi_ddrc_pmu_stop_counters,
+	.enable_counter		= hisi_ddrc_pmu_enable_counter,
+	.disable_counter	= hisi_ddrc_pmu_disable_counter,
+	.enable_counter_int	= hisi_ddrc_pmu_enable_counter_int,
+	.disable_counter_int	= hisi_ddrc_pmu_disable_counter_int,
+	.write_counter		= hisi_ddrc_pmu_write_counter,
+	.read_counter		= hisi_ddrc_pmu_read_counter,
+	.get_int_status		= hisi_ddrc_pmu_get_int_status,
+	.clear_int_status	= hisi_ddrc_pmu_clear_int_status,
 };
 
 static int hisi_ddrc_pmu_dev_probe(struct platform_device *pdev,
@@ -439,18 +356,10 @@ static int hisi_ddrc_pmu_dev_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	if (ddrc_pmu->identifier >= HISI_PMU_V2) {
-		ddrc_pmu->counter_bits = 48;
-		ddrc_pmu->check_event = DDRC_V2_NR_EVENTS;
-		ddrc_pmu->pmu_events.attr_groups = hisi_ddrc_pmu_v2_attr_groups;
-		ddrc_pmu->ops = &hisi_uncore_ddrc_v2_ops;
-	} else {
-		ddrc_pmu->counter_bits = 32;
-		ddrc_pmu->check_event = DDRC_V1_NR_EVENTS;
-		ddrc_pmu->pmu_events.attr_groups = hisi_ddrc_pmu_v1_attr_groups;
-		ddrc_pmu->ops = &hisi_uncore_ddrc_v1_ops;
-	}
-
+	ddrc_pmu->pmu_events.attr_groups = ddrc_pmu->dev_info->attr_groups;
+	ddrc_pmu->counter_bits = ddrc_pmu->dev_info->counter_bits;
+	ddrc_pmu->check_event = ddrc_pmu->dev_info->check_event;
+	ddrc_pmu->ops = &hisi_uncore_ddrc_ops;
 	ddrc_pmu->num_counters = DDRC_NR_COUNTERS;
 	ddrc_pmu->dev = &pdev->dev;
 	ddrc_pmu->on_cpu = -1;
@@ -515,6 +424,49 @@ static void hisi_ddrc_pmu_remove(struct platform_device *pdev)
 					    &ddrc_pmu->node);
 }
 
+static struct hisi_ddrc_pmu_regs hisi_ddrc_v1_pmu_regs = {
+	.event_cnt = DDRC_UNIMPLEMENTED_REG,
+	.event_ctrl = DDRC_EVENT_CTRL,
+	.event_type = DDRC_UNIMPLEMENTED_REG,
+	.perf_ctrl = DDRC_PERF_CTRL,
+	.perf_ctrl_en = DDRC_V1_PERF_CTRL_EN,
+	.int_mask = DDRC_INT_MASK,
+	.int_clear = DDRC_INT_CLEAR,
+	.int_status = DDRC_INT_STATUS,
+};
+
+static const struct hisi_pmu_dev_info hisi_ddrc_v1 = {
+	.counter_bits = 32,
+	.check_event = DDRC_V1_NR_EVENTS,
+	.attr_groups = hisi_ddrc_pmu_v1_attr_groups,
+	.private = &hisi_ddrc_v1_pmu_regs,
+};
+
+static struct hisi_ddrc_pmu_regs hisi_ddrc_v2_pmu_regs = {
+	.event_cnt = DDRC_V2_EVENT_CNT,
+	.event_ctrl = DDRC_V2_EVENT_CTRL,
+	.event_type = DDRC_V2_EVENT_TYPE,
+	.perf_ctrl = DDRC_V2_PERF_CTRL,
+	.perf_ctrl_en = DDRC_V2_PERF_CTRL_EN,
+	.int_mask = DDRC_V2_INT_MASK,
+	.int_clear = DDRC_V2_INT_CLEAR,
+	.int_status = DDRC_V2_INT_STATUS,
+};
+
+static const struct hisi_pmu_dev_info hisi_ddrc_v2 = {
+	.counter_bits = 48,
+	.check_event = DDRC_V2_NR_EVENTS,
+	.attr_groups = hisi_ddrc_pmu_v2_attr_groups,
+	.private = &hisi_ddrc_v2_pmu_regs,
+};
+
+static const struct acpi_device_id hisi_ddrc_pmu_acpi_match[] = {
+	{ "HISI0233", (kernel_ulong_t)&hisi_ddrc_v1 },
+	{ "HISI0234", (kernel_ulong_t)&hisi_ddrc_v2 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_ddrc_pmu_acpi_match);
+
 static struct platform_driver hisi_ddrc_pmu_driver = {
 	.driver = {
 		.name = "hisi_ddrc_pmu",
-- 
2.24.0


