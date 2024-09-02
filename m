Return-Path: <linux-kernel+bounces-311744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE8968CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805E31F23613
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4321C165;
	Mon,  2 Sep 2024 17:52:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24F20FA85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299539; cv=none; b=orQbRJNNvaVLMcm8ereq9iK4uAsITeb0/zNnc8HmOMYzi6qkZZYnHEX00At7P68OcKuwoKsmWQt3P3qxIa38hQEiFdZJawTXomY+S8Um0dd/DPfZsTzuB5JcFNWbUqBip6D5CeFRn+hz0nW7qgYoall8JuwyQHlNGfzQXxvPThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299539; c=relaxed/simple;
	bh=cKWWfoJXeBUqUCKhdPnJjCxD6R2WYvJ4o5Fp+GjE21g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5ix8GxCWMObWQg0ujK/xSuwAHOPqyKgHv2VgNw7c2jlpKtPSSAakPXwFwZp7mtK1oasZPphn1VQM3WsEZkE508W4o5qWt1foIA3ynGF1hm2Fzi0UN8bTJGgkcqIj3ve4KXK4JaU2e0Z97VT2JmIefjbIh4qGrqhEX9WXwq312g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B7FFEC;
	Mon,  2 Sep 2024 10:52:44 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39FA93F73B;
	Mon,  2 Sep 2024 10:52:17 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2 5/8] perf/arm-cmn: Make cycle counts less surprising
Date: Mon,  2 Sep 2024 18:52:01 +0100
Message-Id: <c47cfdc09e907b1d7753d142a7e659982cceb246.1725296395.git.robin.murphy@arm.com>
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

By default, CMN has automatic clock-gating with the implication that
a DTC's cycle counter may not increment while the DTC is sufficiently
idle. Given that we may have up to 4 DTCs to choose from when scheduling
a cycles event, this may potentially lead to surprising results if
trying to measure metrics based on activity in a different DTC domain
from where cycles end up being counted. Furthermore, since the details
of internal clock gating are not documented, we can't even reason about
what "active" cycles for a DTC actually mean relative to the activity of
other nodes within the same nominal DTC domain.

Make the reasonable assumption that if the user wants to count cycles,
they almost certainly want to count all of the cycles, and disable clock
gating while a DTC's cycle counter is in use.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Expand commit message

---
 drivers/perf/arm-cmn.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 5b0edeb69394..2205c183ec1b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -119,6 +119,7 @@
 /* The DTC node is where the magic happens */
 #define CMN_DT_DTC_CTL			0x0a00
 #define CMN_DT_DTC_CTL_DT_EN		BIT(0)
+#define CMN_DT_DTC_CTL_CG_DISABLE	BIT(10)
 
 /* DTC counters are paired in 64-bit registers on a 16-byte stride. Yuck */
 #define _CMN_DT_CNT_REG(n)		((((n) / 2) * 4 + (n) % 2) * 4)
@@ -1546,9 +1547,12 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 	int i;
 
 	if (type == CMN_TYPE_DTC) {
-		i = hw->dtc_idx[0];
-		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
-		cmn->dtc[i].cc_active = true;
+		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
+
+		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
+			       dtc->base + CMN_DT_DTC_CTL);
+		writeq_relaxed(CMN_CC_INIT, dtc->base + CMN_DT_PMCCNTR);
+		dtc->cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
 		u64 val = CMN_EVENT_WP_VAL(event);
 		u64 mask = CMN_EVENT_WP_MASK(event);
@@ -1577,8 +1581,10 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
 	int i;
 
 	if (type == CMN_TYPE_DTC) {
-		i = hw->dtc_idx[0];
-		cmn->dtc[i].cc_active = false;
+		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
+
+		dtc->cc_active = false;
+		writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
 	} else if (type == CMN_TYPE_WP) {
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
-- 
2.39.2.101.g768bb238c484.dirty


