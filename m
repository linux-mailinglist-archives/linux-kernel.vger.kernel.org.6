Return-Path: <linux-kernel+bounces-531512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8697A4416A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F1F189D95F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63D26B08D;
	Tue, 25 Feb 2025 13:53:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4626A0F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491612; cv=none; b=L4qNvavlvXzS0PMonA6COTpeSVzvj2JWzKWosCa4W7J9rcv9SkNxo0nBZ3WchmnJ1pNynx+Ft/4qEKaV4xhbjihaQn9u04a6WRY8paKEPyd6MRQ1G9tIpjz9mQiPt+xtPIyJj35tMPx2lD0L3sS60mN9XbCqxkujhvDS2dSsfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491612; c=relaxed/simple;
	bh=WpzEpEUj1XK3RdwYSGN+ZvAnIPZkv2sDoO6W760H0kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu+U5m34d5XwY3gYl0+8Qc01UwU51CUIHhtHouHhVQ4toAwsl1nwXm2th+RZSmSHRAUUGZIj/dftaVmgkMAx+r174f4jH/ZQONDUHxOoJCDscXBqjbD8fnkDQsyWJ7v9LwpQV7DTyTE5Oe0NNOu/wKPH284SOQyp5EapadcQ6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 879781E4D;
	Tue, 25 Feb 2025 05:53:46 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BD733F6A8;
	Tue, 25 Feb 2025 05:53:28 -0800 (PST)
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
Subject: [PATCH v5 1/9] coresight: change coresight_device lock type to raw_spinlock_t
Date: Tue, 25 Feb 2025 13:52:52 +0000
Message-Id: <20250225135300.339976-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225135300.339976-1-yeoreum.yun@arm.com>
References: <20250225135300.339976-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coresight_device->cscfg_csdev_lock can be held during __schedule()
by perf_event_task_sched_out()/in().

Since coresight->cscfg_csdev_lock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type of coresight_device->cscfg_csdev_lock
from spinlock_t to raw_spinlock_t.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 .../hwtracing/coresight/coresight-syscfg.c    | 26 +++++++++----------
 include/linux/coresight.h                     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11138a9762b0..a70c1454b410 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -89,9 +89,9 @@ static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
 	}
 	/* if matched features, add config to device.*/
 	if (config_csdev) {
-		spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+		raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 		list_add(&config_csdev->node, &csdev->config_csdev_list);
-		spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+		raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 	}
 
 	return 0;
@@ -194,9 +194,9 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 
 	/* add to internal csdev feature list & initialise using reset call */
 	cscfg_reset_feat(feat_csdev);
-	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 	list_add(&feat_csdev->node, &csdev->feature_csdev_list);
-	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 
 	return 0;
 }
@@ -765,7 +765,7 @@ static int cscfg_list_add_csdev(struct coresight_device *csdev,
 
 	INIT_LIST_HEAD(&csdev->feature_csdev_list);
 	INIT_LIST_HEAD(&csdev->config_csdev_list);
-	spin_lock_init(&csdev->cscfg_csdev_lock);
+	raw_spin_lock_init(&csdev->cscfg_csdev_lock);
 
 	return 0;
 }
@@ -855,7 +855,7 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
 	struct cscfg_feature_csdev *feat_csdev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 	if (list_empty(&csdev->feature_csdev_list))
 		goto unlock_exit;
 
@@ -863,7 +863,7 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
 		cscfg_reset_feat(feat_csdev);
 
 unlock_exit:
-	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 }
 EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
 
@@ -1059,7 +1059,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 	 * Look for matching configuration - set the active configuration
 	 * context if found.
 	 */
-	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
 		config_desc = config_csdev_item->config_desc;
 		if ((atomic_read(&config_desc->active_cnt)) &&
@@ -1069,7 +1069,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 
 	/*
 	 * If found, attempt to enable
@@ -1090,12 +1090,12 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 			 *
 			 * Set enabled if OK, err if not.
 			 */
-			spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+			raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 			if (csdev->active_cscfg_ctxt)
 				config_csdev_active->enabled = true;
 			else
 				err = -EBUSY;
-			spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+			raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 		}
 	}
 	return err;
@@ -1124,7 +1124,7 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
 	 * If it was not enabled, we have no work to do, otherwise mark as disabled.
 	 * Clear the active config pointer.
 	 */
-	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 	config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
 	if (config_csdev) {
 		if (!config_csdev->enabled)
@@ -1133,7 +1133,7 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
 			config_csdev->enabled = false;
 	}
 	csdev->active_cscfg_ctxt = NULL;
-	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 
 	/* true if there was an enabled active config */
 	if (config_csdev)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 17276965ff1d..a4fe4da335ac 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -301,7 +301,7 @@ struct coresight_device {
 	/* system configuration and feature lists */
 	struct list_head feature_csdev_list;
 	struct list_head config_csdev_list;
-	spinlock_t cscfg_csdev_lock;
+	raw_spinlock_t cscfg_csdev_lock;
 	void *active_cscfg_ctxt;
 };
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


