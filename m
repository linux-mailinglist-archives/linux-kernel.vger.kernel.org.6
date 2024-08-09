Return-Path: <linux-kernel+bounces-281456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D318F94D717
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631EA1F2468A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720316B73E;
	Fri,  9 Aug 2024 19:16:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9C169397
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230961; cv=none; b=N7WW2vjKdLbCCV8ZP8bF6HSud8OIszBJCqG+iezaEL+RwDK1t+dasoY2BkWVLNbyK+EFdH+h5v6yXfw6m2/7F4ruFw3gYttGeKZXKkj5JhE5NaEsnDEdXAX7iffNkLidrdBlzBiIqh1hi0VASFBFC25Rfxs+/fSFr0KRAyDxelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230961; c=relaxed/simple;
	bh=YXFDoakk3zYbMpJtnusBFdoZp4pkL1wlr4XwPRaMeTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPEk7eeiIDGyCy3c58O4oWDiinra6LVeJIcoY377pNK+Pgo75ztnxBbq8tI8+tatWkH7giBWC5r2158IuzSprUeOwnME5q2j//qDNFvnlEWV4G7ZYzRnFw0NVef4XEMTItg+EqjO/MU7qBpGPz5bE+vOGQkpD2PDMzHaFAJ+SZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B714168F;
	Fri,  9 Aug 2024 12:16:25 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88CC33F71E;
	Fri,  9 Aug 2024 12:15:58 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 6/8] perf/arm-cmn: Refactor DTC PMU register access
Date: Fri,  9 Aug 2024 20:15:45 +0100
Message-Id: <e1aac7d482e6f4a75819edcde1fd3198099a658c.1723229941.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1723229941.git.robin.murphy@arm.com>
References: <cover.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annoyingly, we're soon going to have to cope with PMU registers moving
about. This will mostly be straightforward, except for the hard-coding
of CMN_PMU_OFFSET for the DTC PMU registers. As a first step, refactor
those accessors to allow for encapsulating a variable offset without
making a big mess all over.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 64 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 4d128db2040c..12bbb689a1af 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -119,24 +119,24 @@
 
 /* DTC counters are paired in 64-bit registers on a 16-byte stride. Yuck */
 #define _CMN_DT_CNT_REG(n)		((((n) / 2) * 4 + (n) % 2) * 4)
-#define CMN_DT_PMEVCNT(n)		(CMN_PMU_OFFSET + _CMN_DT_CNT_REG(n))
-#define CMN_DT_PMCCNTR			(CMN_PMU_OFFSET + 0x40)
+#define CMN_DT_PMEVCNT(dtc, n)		((dtc)->pmu_base + _CMN_DT_CNT_REG(n))
+#define CMN_DT_PMCCNTR(dtc)		((dtc)->pmu_base + 0x40)
 
-#define CMN_DT_PMEVCNTSR(n)		(CMN_PMU_OFFSET + 0x50 + _CMN_DT_CNT_REG(n))
-#define CMN_DT_PMCCNTRSR		(CMN_PMU_OFFSET + 0x90)
+#define CMN_DT_PMEVCNTSR(dtc, n)	((dtc)->pmu_base + 0x50 + _CMN_DT_CNT_REG(n))
+#define CMN_DT_PMCCNTRSR(dtc)		((dtc)->pmu_base + 0x90)
 
-#define CMN_DT_PMCR			(CMN_PMU_OFFSET + 0x100)
+#define CMN_DT_PMCR(dtc)		((dtc)->pmu_base + 0x100)
 #define CMN_DT_PMCR_PMU_EN		BIT(0)
 #define CMN_DT_PMCR_CNTR_RST		BIT(5)
 #define CMN_DT_PMCR_OVFL_INTR_EN	BIT(6)
 
-#define CMN_DT_PMOVSR			(CMN_PMU_OFFSET + 0x118)
-#define CMN_DT_PMOVSR_CLR		(CMN_PMU_OFFSET + 0x120)
+#define CMN_DT_PMOVSR(dtc)		((dtc)->pmu_base + 0x118)
+#define CMN_DT_PMOVSR_CLR(dtc)		((dtc)->pmu_base + 0x120)
 
-#define CMN_DT_PMSSR			(CMN_PMU_OFFSET + 0x128)
+#define CMN_DT_PMSSR(dtc)		((dtc)->pmu_base + 0x128)
 #define CMN_DT_PMSSR_SS_STATUS(n)	BIT(n)
 
-#define CMN_DT_PMSRR			(CMN_PMU_OFFSET + 0x130)
+#define CMN_DT_PMSRR(dtc)		((dtc)->pmu_base + 0x130)
 #define CMN_DT_PMSRR_SS_REQ		BIT(0)
 
 #define CMN_DT_NUM_COUNTERS		8
@@ -303,8 +303,9 @@ struct arm_cmn_dtm {
 
 struct arm_cmn_dtc {
 	void __iomem *base;
+	void __iomem *pmu_base;
 	int irq;
-	int irq_friend;
+	s8 irq_friend;
 	bool cc_active;
 
 	struct perf_event *counters[CMN_DT_NUM_COUNTERS];
@@ -408,10 +409,15 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
 	};
 }
 
+static int arm_cmn_pmu_offset(const struct arm_cmn *cmn, const struct arm_cmn_node *dn)
+{
+	return CMN_PMU_OFFSET;
+}
+
 static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
 				       const struct arm_cmn_node *xp, int port)
 {
-	int offset = CMN_MXP__CONNECT_INFO(port);
+	int offset = CMN_MXP__CONNECT_INFO(port) - arm_cmn_pmu_offset(cmn, xp);
 
 	if (port >= 2) {
 		if (cmn->part == PART_CMN600 || cmn->part == PART_CMN650)
@@ -424,7 +430,7 @@ static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
 			offset += CI700_CONNECT_INFO_P2_5_OFFSET;
 	}
 
-	return readl_relaxed(xp->pmu_base - CMN_PMU_OFFSET + offset);
+	return readl_relaxed(xp->pmu_base + offset);
 }
 
 static struct dentry *arm_cmn_debugfs;
@@ -1396,7 +1402,7 @@ static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 static void arm_cmn_set_state(struct arm_cmn *cmn, u32 state)
 {
 	if (!cmn->state)
-		writel_relaxed(0, cmn->dtc[0].base + CMN_DT_PMCR);
+		writel_relaxed(0, CMN_DT_PMCR(&cmn->dtc[0]));
 	cmn->state |= state;
 }
 
@@ -1405,7 +1411,7 @@ static void arm_cmn_clear_state(struct arm_cmn *cmn, u32 state)
 	cmn->state &= ~state;
 	if (!cmn->state)
 		writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN,
-			       cmn->dtc[0].base + CMN_DT_PMCR);
+			       CMN_DT_PMCR(&cmn->dtc[0]));
 }
 
 static void arm_cmn_pmu_enable(struct pmu *pmu)
@@ -1440,18 +1446,19 @@ static u64 arm_cmn_read_dtm(struct arm_cmn *cmn, struct arm_cmn_hw_event *hw,
 
 static u64 arm_cmn_read_cc(struct arm_cmn_dtc *dtc)
 {
-	u64 val = readq_relaxed(dtc->base + CMN_DT_PMCCNTR);
+	void __iomem *pmccntr = CMN_DT_PMCCNTR(dtc);
+	u64 val = readq_relaxed(pmccntr);
 
-	writeq_relaxed(CMN_CC_INIT, dtc->base + CMN_DT_PMCCNTR);
+	writeq_relaxed(CMN_CC_INIT, pmccntr);
 	return (val - CMN_CC_INIT) & ((CMN_CC_INIT << 1) - 1);
 }
 
 static u32 arm_cmn_read_counter(struct arm_cmn_dtc *dtc, int idx)
 {
-	u32 val, pmevcnt = CMN_DT_PMEVCNT(idx);
+	void __iomem *pmevcnt = CMN_DT_PMEVCNT(dtc, idx);
+	u32 val = readl_relaxed(pmevcnt);
 
-	val = readl_relaxed(dtc->base + pmevcnt);
-	writel_relaxed(CMN_COUNTER_INIT, dtc->base + pmevcnt);
+	writel_relaxed(CMN_COUNTER_INIT, pmevcnt);
 	return val - CMN_COUNTER_INIT;
 }
 
@@ -1462,7 +1469,7 @@ static void arm_cmn_init_counter(struct perf_event *event)
 	u64 count;
 
 	for_each_hw_dtc_idx(hw, i, idx) {
-		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + CMN_DT_PMEVCNT(idx));
+		writel_relaxed(CMN_COUNTER_INIT, CMN_DT_PMEVCNT(&cmn->dtc[i], idx));
 		cmn->dtc[i].counters[idx] = event;
 	}
 
@@ -1549,7 +1556,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 
 		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
 			       dtc->base + CMN_DT_DTC_CTL);
-		writeq_relaxed(CMN_CC_INIT, dtc->base + CMN_DT_PMCCNTR);
+		writeq_relaxed(CMN_CC_INIT, CMN_DT_PMCCNTR(dtc));
 		dtc->cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
 		u64 val = CMN_EVENT_WP_VAL(event);
@@ -2026,7 +2033,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 
 	for (;;) {
-		u32 status = readl_relaxed(dtc->base + CMN_DT_PMOVSR);
+		u32 status = readl_relaxed(CMN_DT_PMOVSR(dtc));
 		u64 delta;
 		int i;
 
@@ -2048,7 +2055,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 			}
 		}
 
-		writel_relaxed(status, dtc->base + CMN_DT_PMOVSR_CLR);
+		writel_relaxed(status, CMN_DT_PMOVSR_CLR(dtc));
 
 		if (!dtc->irq_friend)
 			return ret;
@@ -2102,15 +2109,16 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 {
 	struct arm_cmn_dtc *dtc = cmn->dtc + idx;
 
-	dtc->base = dn->pmu_base - CMN_PMU_OFFSET;
+	dtc->pmu_base = dn->pmu_base;
+	dtc->base = dtc->pmu_base - arm_cmn_pmu_offset(cmn, dn);
 	dtc->irq = platform_get_irq(to_platform_device(cmn->dev), idx);
 	if (dtc->irq < 0)
 		return dtc->irq;
 
 	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
-	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, dtc->base + CMN_DT_PMCR);
-	writeq_relaxed(0, dtc->base + CMN_DT_PMCCNTR);
-	writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
+	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, CMN_DT_PMCR(dtc));
+	writeq_relaxed(0, CMN_DT_PMCCNTR(dtc));
+	writel_relaxed(0x1ff, CMN_DT_PMOVSR_CLR(dtc));
 
 	return 0;
 }
@@ -2198,7 +2206,7 @@ static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_c
 	node->id = FIELD_GET(CMN_NI_NODE_ID, reg);
 	node->logid = FIELD_GET(CMN_NI_LOGICAL_ID, reg);
 
-	node->pmu_base = cmn->base + offset + CMN_PMU_OFFSET;
+	node->pmu_base = cmn->base + offset + arm_cmn_pmu_offset(cmn, node);
 
 	if (node->type == CMN_TYPE_CFG)
 		level = 0;
-- 
2.39.2.101.g768bb238c484.dirty


