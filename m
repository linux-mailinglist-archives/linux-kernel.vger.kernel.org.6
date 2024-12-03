Return-Path: <linux-kernel+bounces-429374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5D9E1B46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4540E1641BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46651E4938;
	Tue,  3 Dec 2024 11:49:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E01E47A6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226594; cv=none; b=XouE/x0FaIqQUhEX320cVz4Yn53AcOtVWuUKUyBre12rAxzXHwJwS003bzi1s5RFjA6qDsBV2GQkuLqQSKyIFAKVhQOfxVZZqYwJ8PgDp4U7YY8hwvqgwXuLBf4FWkuyNW+eYusgj8u0PE87BwyraD+EDMiRIEmBjXH2hNqnKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226594; c=relaxed/simple;
	bh=Bb++mKdq8inl0cVkR5vxQ17falPfsDPqL3TOjRCxl2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zo6EuFCC3q20zj89oCnuOMFdozgXAmQe0IG4huTGlBVJ33NW65JQGN7tIRZkpUvDPtjvwtgLhyHBU6aHUaphd6Nq33is7rms7wH6nUmXIPvFvjeoual/vNJNRMQi2+8ljEaijeBoKVRHBu3WFFX+mL/LEbsyYdhRI3fYA516Cn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E36C9143D;
	Tue,  3 Dec 2024 03:50:18 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 128003F58B;
	Tue,  3 Dec 2024 03:49:48 -0800 (PST)
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
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 1/9] coresight: change coresight_device lock type to  raw_spinlock_t
Date: Tue,  3 Dec 2024 11:49:34 +0000
Message-Id: <20241203114942.697188-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203114942.697188-1-yeoreum.yun@arm.com>
References: <20241203114942.697188-1-yeoreum.yun@arm.com>
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
index c13342594278..924b58c343b3 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -296,7 +296,7 @@ struct coresight_device {
 	/* system configuration and feature lists */
 	struct list_head feature_csdev_list;
 	struct list_head config_csdev_list;
-	spinlock_t cscfg_csdev_lock;
+	raw_spinlock_t cscfg_csdev_lock;
 	void *active_cscfg_ctxt;
 };
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


