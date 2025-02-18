Return-Path: <linux-kernel+bounces-518999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138EA396E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CF61894657
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947922FF40;
	Tue, 18 Feb 2025 09:20:09 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A022FE19
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870408; cv=none; b=q0fyHFQiylABoRKwWjPyK5d5cIz2ieVIO7U0vBV88bSTLXd3Fy766+TAd/zL+sXzHazF/26/2TeA8f1rv8FFJEbyhI0bb2v4eJ60cQ+AivufYpqr2o9+UacseXj/2t5oqbuQdluxTQRgVNUJYysi1nl+eiAGDl7NzeDL4uvQGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870408; c=relaxed/simple;
	bh=bCFKpOyz68tq3iRvdaR+mtMSHl0KZp8GsePWUd7j8C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBT6Qe8dQ3KODdY2svq22srvtgDxIDPjXRVA2mr+a4W62b8pRXW5ynP5geqrXY8YR1S40xM5IFJEGgNKDr/fE+PPfGBbgeDz+UxB/CuVWpBO/93iIg/GJ0Ikuv7fzm3nyzSyGwIpGGdPkO1T0/zdRGJW/uc6dSRlY2J19DN0yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yxv6T6bbZzTjWK;
	Tue, 18 Feb 2025 17:16:49 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D1ED1800DB;
	Tue, 18 Feb 2025 17:19:49 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:48 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 4/9] drivers/perf: hisi: Use ACPI driver_data to retrieve SLLC PMU information
Date: Tue, 18 Feb 2025 17:19:55 +0800
Message-ID: <20250218092000.41641-5-yangyicong@huawei.com>
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

Make use of struct acpi_device_id::driver_data for version specific
information rather than judge the version register. This will help
to simplify the probe process and also a bit easier for extension.

Factor out SLLC register definition to struct hisi_sllc_pmu_regs.
No functional changes intended.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 191 ++++++++++++------
 1 file changed, 125 insertions(+), 66 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index dbd079016fc4..c1fd60d397c3 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -36,11 +36,14 @@
 #define SLLC_SRCID_NONE			0x0
 #define SLLC_TGTID_EN			BIT(5)
 #define SLLC_TGTID_NONE			0x0
-#define SLLC_TGTID_MIN_SHIFT		1
-#define SLLC_TGTID_MAX_SHIFT		12
-#define SLLC_SRCID_CMD_SHIFT		1
-#define SLLC_SRCID_MSK_SHIFT		12
+#define SLLC_TGTID_MIN_MSK		GENMASK(11, 1)
+#define SLLC_TGTID_MAX_MSK		GENMASK(22, 12)
+#define SLLC_SRCID_CMD_MSK		GENMASK(11, 1)
+#define SLLC_SRCID_MSK_MSK		GENMASK(22, 12)
 #define SLLC_NR_EVENTS			0x80
+#define SLLC_EVENT_CNTn(cnt0, n)	((cnt0) + (n) * 8)
+#define SLLC_FIRST_BIT(_mask)		(find_first_bit((const unsigned long *)&(_mask), 32))
+#define SLLC_FIELD_PREP(_mask, _val)	(_mask & (_val << SLLC_FIRST_BIT(_mask)))
 
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tgtid_min, config1, 10, 0);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tgtid_max, config1, 21, 11);
@@ -48,6 +51,23 @@ HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_cmd, config1, 32, 22);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_msk, config1, 43, 33);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tracetag_en, config1, 44, 44);
 
+struct hisi_sllc_pmu_regs {
+	u32 int_mask;
+	u32 int_clear;
+	u32 int_status;
+	u32 perf_ctrl;
+	u32 srcid_ctrl;
+	u32 srcid_mask_msk;
+	u32 srcid_cmd_msk;
+	u32 tgtid_ctrl;
+	u32 tgtid_max_msk;
+	u32 tgtid_min_msk;
+	u32 event_ctrl;
+	u32 event_type0;
+	u32 version;
+	u32 event_cnt0;
+};
+
 static bool tgtid_is_valid(u32 max, u32 min)
 {
 	return max > 0 && max >= min;
@@ -56,96 +76,103 @@ static bool tgtid_is_valid(u32 max, u32 min)
 static void hisi_sllc_pmu_enable_tracetag(struct perf_event *event)
 {
 	struct hisi_pmu *sllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 tt_en = hisi_get_tracetag_en(event);
 
 	if (tt_en) {
 		u32 val;
 
-		val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+		val = readl(sllc_pmu->base + regs->perf_ctrl);
 		val |= SLLC_TRACETAG_EN | SLLC_FILT_EN;
-		writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+		writel(val, sllc_pmu->base + regs->perf_ctrl);
 	}
 }
 
 static void hisi_sllc_pmu_disable_tracetag(struct perf_event *event)
 {
 	struct hisi_pmu *sllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 tt_en = hisi_get_tracetag_en(event);
 
 	if (tt_en) {
 		u32 val;
 
-		val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+		val = readl(sllc_pmu->base + regs->perf_ctrl);
 		val &= ~(SLLC_TRACETAG_EN | SLLC_FILT_EN);
-		writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+		writel(val, sllc_pmu->base + regs->perf_ctrl);
 	}
 }
 
 static void hisi_sllc_pmu_config_tgtid(struct perf_event *event)
 {
 	struct hisi_pmu *sllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 min = hisi_get_tgtid_min(event);
 	u32 max = hisi_get_tgtid_max(event);
 
 	if (tgtid_is_valid(max, min)) {
-		u32 val = (max << SLLC_TGTID_MAX_SHIFT) | (min << SLLC_TGTID_MIN_SHIFT);
+		u32 val = SLLC_FIELD_PREP(regs->tgtid_max_msk, max) |
+			  SLLC_FIELD_PREP(regs->tgtid_min_msk, min);
 
-		writel(val, sllc_pmu->base + SLLC_TGTID_CTRL);
+		writel(val, sllc_pmu->base + regs->tgtid_ctrl);
 		/* Enable the tgtid */
-		val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+		val = readl(sllc_pmu->base + regs->perf_ctrl);
 		val |= SLLC_TGTID_EN | SLLC_FILT_EN;
-		writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+		writel(val, sllc_pmu->base + regs->perf_ctrl);
 	}
 }
 
 static void hisi_sllc_pmu_clear_tgtid(struct perf_event *event)
 {
 	struct hisi_pmu *sllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 min = hisi_get_tgtid_min(event);
 	u32 max = hisi_get_tgtid_max(event);
 
 	if (tgtid_is_valid(max, min)) {
 		u32 val;
 
-		writel(SLLC_TGTID_NONE, sllc_pmu->base + SLLC_TGTID_CTRL);
+		writel(SLLC_TGTID_NONE, sllc_pmu->base + regs->tgtid_ctrl);
 		/* Disable the tgtid */
-		val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+		val = readl(sllc_pmu->base + regs->perf_ctrl);
 		val &= ~(SLLC_TGTID_EN | SLLC_FILT_EN);
-		writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+		writel(val, sllc_pmu->base + regs->perf_ctrl);
 	}
 }
 
 static void hisi_sllc_pmu_config_srcid(struct perf_event *event)
 {
 	struct hisi_pmu *sllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 cmd = hisi_get_srcid_cmd(event);
 
 	if (cmd) {
-		u32 val, msk;
+		u32 msk = hisi_get_srcid_msk(event);
+		u32 val = SLLC_FIELD_PREP(regs->srcid_mask_msk, msk) |
+			  SLLC_FIELD_PREP(regs->srcid_cmd_msk, cmd);
 
-		msk = hisi_get_srcid_msk(event);
-		val = (cmd << SLLC_SRCID_CMD_SHIFT) | (msk << SLLC_SRCID_MSK_SHIFT);
-		writel(val, sllc_pmu->base + SLLC_SRCID_CTRL);
+		writel(val, sllc_pmu->base + regs->srcid_ctrl);
 		/* Enable the srcid */
-		val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+		val = readl(sllc_pmu->base + regs->perf_ctrl);
 		val |= SLLC_SRCID_EN | SLLC_FILT_EN;
-		writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+		writel(val, sllc_pmu->base + regs->perf_ctrl);
 	}
 }
 
 static void hisi_sllc_pmu_clear_srcid(struct perf_event *event)
 {
 	struct hisi_pmu *sllc_pmu = to_hisi_pmu(event->pmu);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 cmd = hisi_get_srcid_cmd(event);
 
 	if (cmd) {
 		u32 val;
 
-		writel(SLLC_SRCID_NONE, sllc_pmu->base + SLLC_SRCID_CTRL);
+		writel(SLLC_SRCID_NONE, sllc_pmu->base + regs->srcid_ctrl);
 		/* Disable the srcid */
-		val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+		val = readl(sllc_pmu->base + regs->perf_ctrl);
 		val &= ~(SLLC_SRCID_EN | SLLC_FILT_EN);
-		writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+		writel(val, sllc_pmu->base + regs->perf_ctrl);
 	}
 }
 
@@ -167,29 +194,27 @@ static void hisi_sllc_pmu_clear_filter(struct perf_event *event)
 	}
 }
 
-static u32 hisi_sllc_pmu_get_counter_offset(int idx)
-{
-	return (SLLC_EVENT_CNT0_L + idx * 8);
-}
-
 static u64 hisi_sllc_pmu_read_counter(struct hisi_pmu *sllc_pmu,
 				      struct hw_perf_event *hwc)
 {
-	return readq(sllc_pmu->base +
-		     hisi_sllc_pmu_get_counter_offset(hwc->idx));
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
+
+	return readq(sllc_pmu->base + SLLC_EVENT_CNTn(regs->event_cnt0, hwc->idx));
 }
 
 static void hisi_sllc_pmu_write_counter(struct hisi_pmu *sllc_pmu,
 					struct hw_perf_event *hwc, u64 val)
 {
-	writeq(val, sllc_pmu->base +
-	       hisi_sllc_pmu_get_counter_offset(hwc->idx));
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
+
+	writeq(val, sllc_pmu->base + SLLC_EVENT_CNTn(regs->event_cnt0, hwc->idx));
 }
 
 static void hisi_sllc_pmu_write_evtype(struct hisi_pmu *sllc_pmu, int idx,
 				       u32 type)
 {
-	u32 reg, reg_idx, shift, val;
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
+	u32 reg, val;
 
 	/*
 	 * Select the appropriate event select register(SLLC_EVENT_TYPE0/1).
@@ -198,96 +223,98 @@ static void hisi_sllc_pmu_write_evtype(struct hisi_pmu *sllc_pmu, int idx,
 	 * SLLC_EVENT_TYPE0 is chosen. For the latter 4 hardware counters,
 	 * SLLC_EVENT_TYPE1 is chosen.
 	 */
-	reg = SLLC_EVENT_TYPE0 + (idx / 4) * 4;
-	reg_idx = idx % 4;
-	shift = 8 * reg_idx;
+	reg = regs->event_type0 + (idx / 4) * 4;
 
 	/* Write event code to SLLC_EVENT_TYPEx Register */
 	val = readl(sllc_pmu->base + reg);
-	val &= ~(SLLC_EVTYPE_MASK << shift);
-	val |= (type << shift);
+	val &= ~(SLLC_EVTYPE_MASK << HISI_PMU_EVTYPE_SHIFT(idx));
+	val |= (type << HISI_PMU_EVTYPE_SHIFT(idx));
 	writel(val, sllc_pmu->base + reg);
 }
 
 static void hisi_sllc_pmu_start_counters(struct hisi_pmu *sllc_pmu)
 {
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+	val = readl(sllc_pmu->base + regs->perf_ctrl);
 	val |= SLLC_PERF_CTRL_EN;
-	writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+	writel(val, sllc_pmu->base + regs->perf_ctrl);
 }
 
 static void hisi_sllc_pmu_stop_counters(struct hisi_pmu *sllc_pmu)
 {
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(sllc_pmu->base + SLLC_PERF_CTRL);
+	val = readl(sllc_pmu->base + regs->perf_ctrl);
 	val &= ~(SLLC_PERF_CTRL_EN);
-	writel(val, sllc_pmu->base + SLLC_PERF_CTRL);
+	writel(val, sllc_pmu->base + regs->perf_ctrl);
 }
 
 static void hisi_sllc_pmu_enable_counter(struct hisi_pmu *sllc_pmu,
 					 struct hw_perf_event *hwc)
 {
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(sllc_pmu->base + SLLC_EVENT_CTRL);
-	val |= 1 << hwc->idx;
-	writel(val, sllc_pmu->base + SLLC_EVENT_CTRL);
+	val = readl(sllc_pmu->base + regs->event_ctrl);
+	val |= BIT_ULL(hwc->idx);
+	writel(val, sllc_pmu->base + regs->event_ctrl);
 }
 
 static void hisi_sllc_pmu_disable_counter(struct hisi_pmu *sllc_pmu,
 					  struct hw_perf_event *hwc)
 {
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(sllc_pmu->base + SLLC_EVENT_CTRL);
-	val &= ~(1 << hwc->idx);
-	writel(val, sllc_pmu->base + SLLC_EVENT_CTRL);
+	val = readl(sllc_pmu->base + regs->event_ctrl);
+	val &= ~BIT_ULL(hwc->idx);
+	writel(val, sllc_pmu->base + regs->event_ctrl);
 }
 
 static void hisi_sllc_pmu_enable_counter_int(struct hisi_pmu *sllc_pmu,
 					     struct hw_perf_event *hwc)
 {
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(sllc_pmu->base + SLLC_INT_MASK);
-	/* Write 0 to enable interrupt */
-	val &= ~(1 << hwc->idx);
-	writel(val, sllc_pmu->base + SLLC_INT_MASK);
+	val = readl(sllc_pmu->base + regs->int_mask);
+	val &= ~BIT_ULL(hwc->idx);
+	writel(val, sllc_pmu->base + regs->int_mask);
 }
 
 static void hisi_sllc_pmu_disable_counter_int(struct hisi_pmu *sllc_pmu,
 					      struct hw_perf_event *hwc)
 {
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 	u32 val;
 
-	val = readl(sllc_pmu->base + SLLC_INT_MASK);
-	/* Write 1 to mask interrupt */
-	val |= 1 << hwc->idx;
-	writel(val, sllc_pmu->base + SLLC_INT_MASK);
+	val = readl(sllc_pmu->base + regs->int_mask);
+	val |= BIT_ULL(hwc->idx);
+	writel(val, sllc_pmu->base + regs->int_mask);
 }
 
 static u32 hisi_sllc_pmu_get_int_status(struct hisi_pmu *sllc_pmu)
 {
-	return readl(sllc_pmu->base + SLLC_INT_STATUS);
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
+
+	return readl(sllc_pmu->base + regs->int_status);
 }
 
 static void hisi_sllc_pmu_clear_int_status(struct hisi_pmu *sllc_pmu, int idx)
 {
-	writel(1 << idx, sllc_pmu->base + SLLC_INT_CLEAR);
-}
+	struct hisi_sllc_pmu_regs *regs = sllc_pmu->dev_info->private;
 
-static const struct acpi_device_id hisi_sllc_pmu_acpi_match[] = {
-	{ "HISI0263", },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, hisi_sllc_pmu_acpi_match);
+	writel(BIT_ULL(idx), sllc_pmu->base + regs->int_clear);
+}
 
 static int hisi_sllc_pmu_init_data(struct platform_device *pdev,
 				   struct hisi_pmu *sllc_pmu)
 {
+	struct hisi_sllc_pmu_regs *regs;
+
 	hisi_uncore_pmu_init_topology(sllc_pmu, &pdev->dev);
 
 	/*
@@ -304,13 +331,18 @@ static int hisi_sllc_pmu_init_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	sllc_pmu->dev_info = device_get_match_data(&pdev->dev);
+	if (!sllc_pmu->dev_info)
+		return -ENODEV;
+
 	sllc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sllc_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for sllc_pmu resource.\n");
 		return PTR_ERR(sllc_pmu->base);
 	}
 
-	sllc_pmu->identifier = readl(sllc_pmu->base + SLLC_VERSION);
+	regs = sllc_pmu->dev_info->private;
+	sllc_pmu->identifier = readl(sllc_pmu->base + regs->version);
 
 	return 0;
 }
@@ -352,6 +384,27 @@ static const struct attribute_group *hisi_sllc_pmu_v2_attr_groups[] = {
 	NULL
 };
 
+static struct hisi_sllc_pmu_regs hisi_sllc_v2_pmu_regs = {
+	.int_mask = SLLC_INT_MASK,
+	.int_clear = SLLC_INT_CLEAR,
+	.int_status = SLLC_INT_STATUS,
+	.perf_ctrl = SLLC_PERF_CTRL,
+	.srcid_ctrl = SLLC_SRCID_CTRL,
+	.srcid_mask_msk = SLLC_SRCID_MSK_MSK,
+	.srcid_cmd_msk = SLLC_SRCID_CMD_MSK,
+	.tgtid_ctrl = SLLC_TGTID_CTRL,
+	.tgtid_max_msk = SLLC_TGTID_MAX_MSK,
+	.tgtid_min_msk = SLLC_TGTID_MIN_MSK,
+	.event_ctrl = SLLC_EVENT_CTRL,
+	.event_type0 = SLLC_EVENT_TYPE0,
+	.version = SLLC_VERSION,
+	.event_cnt0 = SLLC_EVENT_CNT0_L,
+};
+
+static const struct hisi_pmu_dev_info hisi_sllc_v2 = {
+	.private = &hisi_sllc_v2_pmu_regs,
+};
+
 static const struct hisi_uncore_ops hisi_uncore_sllc_ops = {
 	.write_evtype		= hisi_sllc_pmu_write_evtype,
 	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
@@ -443,6 +496,12 @@ static void hisi_sllc_pmu_remove(struct platform_device *pdev)
 					    &sllc_pmu->node);
 }
 
+static const struct acpi_device_id hisi_sllc_pmu_acpi_match[] = {
+	{ "HISI0263", (kernel_ulong_t)&hisi_sllc_v2 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_sllc_pmu_acpi_match);
+
 static struct platform_driver hisi_sllc_pmu_driver = {
 	.driver = {
 		.name = "hisi_sllc_pmu",
-- 
2.24.0


