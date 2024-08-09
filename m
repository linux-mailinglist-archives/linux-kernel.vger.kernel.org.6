Return-Path: <linux-kernel+bounces-281455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91394D714
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D629B21601
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307816A945;
	Fri,  9 Aug 2024 19:16:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92D16130B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230960; cv=none; b=ShW8rXyUfeNA6IIHGJCrC0jS7oZOmq8VKBuQMFzFkOlgKRiNkPWsqJuiUL2580ihp662zOqfEhOihrsPOu7wwfmx0oLVJk7gaOEvOWrUZz19l23YxkVmOxUJNUZkHuiVfJbSiWtmemjy9oC56HDoo81d0D3BYSTMsJQ0Br1hv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230960; c=relaxed/simple;
	bh=TMeoUu8mZPW80ys09DNhX2GMp1kgrl8Hx1diGKUwXcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtS9ddd29hcMHFjwX/45+yJBMKCIwJ3VtjLm+OKRKat1jJTpBJTaVO0I7k1+PJvA2qGy4XCr82WEe4akgykvcOoP0f5HE3ZMvkBfwnFjZ7bSyj7FUosbjht8zpmLzpk52jCW3lcMS7ZO1RZPemNmQc0yGYda7BfYkoDo+B66+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C641684;
	Fri,  9 Aug 2024 12:16:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 934633F71E;
	Fri,  9 Aug 2024 12:15:57 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 5/8] perf/arm-cmn: Make cycle counts less surprising
Date: Fri,  9 Aug 2024 20:15:44 +0100
Message-Id: <570c473134426b8e11bb043aa59e3cde3dab8af3.1723229941.git.robin.murphy@arm.com>
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

By default, CMN has automatic clock-gating with the implication that a
DTC's cycle counter may not increment while the domain is sufficiently
idle. Given that we may have up to 4 DTCs to choose from when scheduling
a cycles event, this may potentially lead to surprising results if
trying to measure metrics based on activity in a different DTC domain
from where cycles end up being counted. Make the reasonable assumption
that if the user wants to count cycles, they almost certainly want to
count all of the cycles, and disable clock gating while a DTC's cycle
counter is in use.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 8f7a1a6f8ab7..4d128db2040c 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -115,6 +115,7 @@
 /* The DTC node is where the magic happens */
 #define CMN_DT_DTC_CTL			0x0a00
 #define CMN_DT_DTC_CTL_DT_EN		BIT(0)
+#define CMN_DT_DTC_CTL_CG_DISABLE	BIT(10)
 
 /* DTC counters are paired in 64-bit registers on a 16-byte stride. Yuck */
 #define _CMN_DT_CNT_REG(n)		((((n) / 2) * 4 + (n) % 2) * 4)
@@ -1544,9 +1545,12 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
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
@@ -1575,8 +1579,10 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
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


