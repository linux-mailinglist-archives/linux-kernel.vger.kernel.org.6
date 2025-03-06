Return-Path: <linux-kernel+bounces-548879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB358A54A6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826A816C4FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37120B80F;
	Thu,  6 Mar 2025 12:11:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E320B7F1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263099; cv=none; b=ZmPG0Fh/4h32hnTdj8kBj1FLd79todbDkv60fGj2bSx2UblsIKCSTUmkClRcTNXUU1Qd8C5KeZPKPZTxmrD25oPNx2WRiGWw7LfFJ+78fmazDmGmrTUsrABgKK4w4wtzYSylao9hSIrXRs/wky/XpCdBRGU1UpPs0tI3k+uoRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263099; c=relaxed/simple;
	bh=ieA9pLtA9WNvUjQp49ffolMQlebbyMYqVTdOWgft12k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqJgyITiR4QMViUi88znC+ZvUY3w7J/zjGuQeC2jRDXHa9mpaFQW2zyXMBXSfmFppocy/bKr6+nb8/NCcKOZrM9N1ZSkzdJImDHyq2B14GRwOMja0H1f1yQjqpc1rvlPu4V82IExIhsjRp0ImuQW+EWDUxfp0ZczsH2dCA3vibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D5FC1007;
	Thu,  6 Mar 2025 04:11:50 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D4E13F673;
	Thu,  6 Mar 2025 04:11:24 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v6 6/9] coresight-funnel: change funnel_drvdata spinlock's type to raw_spinlock_t
Date: Thu,  6 Mar 2025 12:11:07 +0000
Message-Id: <20250306121110.1647948-7-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306121110.1647948-1-yeoreum.yun@arm.com>
References: <20250306121110.1647948-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In coresight-funnel drivers, cti_drvdata->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since funnel_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type funnel_drvdata->spinlock in
coresight-funnel drivers, which can be called by
perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 8faf51469bb8..0541712b2bcb 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -47,7 +47,7 @@ struct funnel_drvdata {
 	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
-	spinlock_t		spinlock;
+	raw_spinlock_t		spinlock;
 };
 
 static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
@@ -85,7 +85,7 @@ static int funnel_enable(struct coresight_device *csdev,
 	unsigned long flags;
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (in->dest_refcnt == 0) {
 		if (drvdata->base)
 			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
@@ -94,7 +94,7 @@ static int funnel_enable(struct coresight_device *csdev,
 	}
 	if (!rc)
 		in->dest_refcnt++;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
@@ -129,13 +129,13 @@ static void funnel_disable(struct coresight_device *csdev,
 	unsigned long flags;
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (--in->dest_refcnt == 0) {
 		if (drvdata->base)
 			dynamic_funnel_disable_hw(drvdata, in->dest_port);
 		last_disable = true;
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n",
@@ -266,7 +266,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.ops = &funnel_cs_ops;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


