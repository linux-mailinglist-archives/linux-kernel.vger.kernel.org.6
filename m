Return-Path: <linux-kernel+bounces-311745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A10968CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CBBB22C61
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413721C18A;
	Mon,  2 Sep 2024 17:52:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147E62139A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299540; cv=none; b=tGKNsAJJlRx4Pd8b928uMBJjUE3fe1z3BFvczoE9sPpERPGmqWH16YooiCSLgM6WXJ3Kf3ZCxblURiv8M1F7HdzV6D6YuHhNjIbam99EHJT2pSdRfwq/wK+e0DRstKN4g2fhf0/VFRzbgQsT8c+6kou/6oAR/kr9UL7s3nEHS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299540; c=relaxed/simple;
	bh=U6P/WM3enBmBShcQtqn6MpRIbH6tfJVCZb5J+YHAeHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmOT3f3HB0BZ3x+QadQEkcXEtdonsbwpJeN0YroMbddBQbZ4dPYsFnEJtbV8i2roC7R4LqxsMfH/N6dVk3htz+gn3XT5bzVA8oSBvmXYZhBJPylZFQnaVrT9mjKptqDhcVEY02VWU99Xd6ZvV7Cwn+8zSWpyNc/weq+zZf4MmLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D7581424;
	Mon,  2 Sep 2024 10:52:45 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FC0C3F73B;
	Mon,  2 Sep 2024 10:52:18 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2 6/8] perf/arm-cmn: Refactor DTC PMU register access
Date: Mon,  2 Sep 2024 18:52:02 +0100
Message-Id: <fc677576fae7b5b55780e5b245a4ef6ea1b30daf.1725296395.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
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
making a big mess all over. As a bonus, we can repack the arm_cmn_dtc
structure to accommodate the new pointer without growing any larger,
since irq_friend only encodes a range of +/-3.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Mention deliberate struct repack
---
 drivers/perf/arm-cmn.c | 64 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 2205c183ec1b..ac7dd4c352e8 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -123,24 +123,24 @@
 
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
@@ -307,8 +307,9 @@ struct arm_cmn_dtm {
 
 struct arm_cmn_dtc {
 	void __iomem *base;
+	void __iomem *pmu_base;
 	int irq;
-	int irq_friend;
+	s8 irq_friend;
 	bool cc_active;
 
 	struct perf_event *counters[CMN_DT_NUM_COUNTERS];
@@ -412,10 +413,15 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
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
@@ -428,7 +434,7 @@ static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
 			offset += CI700_CONNECT_INFO_P2_5_OFFSET;
 	}
 
-	return readl_relaxed(xp->pmu_base - CMN_PMU_OFFSET + offset);
+	return readl_relaxed(xp->pmu_base + offset);
 }
 
 static struct dentry *arm_cmn_debugfs;
@@ -1398,7 +1404,7 @@ static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 static void arm_cmn_set_state(struct arm_cmn *cmn, u32 state)
 {
 	if (!cmn->state)
-		writel_relaxed(0, cmn->dtc[0].base + CMN_DT_PMCR);
+		writel_relaxed(0, CMN_DT_PMCR(&cmn->dtc[0]));
 	cmn->state |= state;
 }
 
@@ -1407,7 +1413,7 @@ static void arm_cmn_clear_state(struct arm_cmn *cmn, u32 state)
 	cmn->state &= ~state;
 	if (!cmn->state)
 		writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN,
-			       cmn->dtc[0].base + CMN_DT_PMCR);
+			       CMN_DT_PMCR(&cmn->dtc[0]));
 }
 
 static void arm_cmn_pmu_enable(struct pmu *pmu)
@@ -1442,18 +1448,19 @@ static u64 arm_cmn_read_dtm(struct arm_cmn *cmn, struct arm_cmn_hw_event *hw,
 
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
 
@@ -1464,7 +1471,7 @@ static void arm_cmn_init_counter(struct perf_event *event)
 	u64 count;
 
 	for_each_hw_dtc_idx(hw, i, idx) {
-		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + CMN_DT_PMEVCNT(idx));
+		writel_relaxed(CMN_COUNTER_INIT, CMN_DT_PMEVCNT(&cmn->dtc[i], idx));
 		cmn->dtc[i].counters[idx] = event;
 	}
 
@@ -1551,7 +1558,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 
 		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
 			       dtc->base + CMN_DT_DTC_CTL);
-		writeq_relaxed(CMN_CC_INIT, dtc->base + CMN_DT_PMCCNTR);
+		writeq_relaxed(CMN_CC_INIT, CMN_DT_PMCCNTR(dtc));
 		dtc->cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
 		u64 val = CMN_EVENT_WP_VAL(event);
@@ -2028,7 +2035,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 
 	for (;;) {
-		u32 status = readl_relaxed(dtc->base + CMN_DT_PMOVSR);
+		u32 status = readl_relaxed(CMN_DT_PMOVSR(dtc));
 		u64 delta;
 		int i;
 
@@ -2050,7 +2057,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 			}
 		}
 
-		writel_relaxed(status, dtc->base + CMN_DT_PMOVSR_CLR);
+		writel_relaxed(status, CMN_DT_PMOVSR_CLR(dtc));
 
 		if (!dtc->irq_friend)
 			return ret;
@@ -2104,15 +2111,16 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
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
@@ -2200,7 +2208,7 @@ static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_c
 	node->id = FIELD_GET(CMN_NI_NODE_ID, reg);
 	node->logid = FIELD_GET(CMN_NI_LOGICAL_ID, reg);
 
-	node->pmu_base = cmn->base + offset + CMN_PMU_OFFSET;
+	node->pmu_base = cmn->base + offset + arm_cmn_pmu_offset(cmn, node);
 
 	if (node->type == CMN_TYPE_CFG)
 		level = 0;
-- 
2.39.2.101.g768bb238c484.dirty


