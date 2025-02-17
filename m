Return-Path: <linux-kernel+bounces-517949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935AEA387E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DC33B6797
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF53227B87;
	Mon, 17 Feb 2025 15:39:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05C227569
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806787; cv=none; b=OkqD71bfHeMDnMPZcUdy+HCzBA23JMi5SKCfhpxsPyNrpgnLXnFfAblToqHZ9WfrAlC/NTVgMU211/Z/vsmmJzgqlbsf2VR3CIwqv3+ooDVZx9kC1fR8FJdbeAdw7RKMwTc/DkdkgjTFli2HSiyg0QZaG6ggSTtgxhpViCaEWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806787; c=relaxed/simple;
	bh=WEGGckQePLXCqge512Wc1aWYVvJZWoS08KOioG13gpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=nI+qqA9Knr1XqTnCEn8vTqZbq3+oYnBc+hgtYlNa40k0evZ5X6DhwWGq8rqQPchUK+DXBnND0VlcOnXuymVorXh9kABf7dLHO7BOfGbDd901d/0fLtgOaX5R8xe1FZTI8kCdpvsGVFH9loNvdsszHc1RHV6k2D2RHKwgQJwSn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D81A152B;
	Mon, 17 Feb 2025 07:40:04 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8993F3F6A8;
	Mon, 17 Feb 2025 07:39:44 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:57 +0000
Subject: [PATCH v3 16/19] firmware: arm_ffa: Add support for
 {un,}registration of framework notifications
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-16-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8743; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=WEGGckQePLXCqge512Wc1aWYVvJZWoS08KOioG13gpw=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gvdf2CmAUAPAUZs+JR7a1ajOQc2zyTwWOwq
 Ipl6qBs7OiJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mNDQEADVhP1zm04F73AeyXIyhiDBHA07Xvtm8OT8Uc4fMCE3qQdp7ou3tv4sIudOWEI9OrPSBvb
 cIyGrZeKUOaSqXgCr0tmRED3BsFLqX/bEDyBeBthK4WqbiLlGa9i7G0deimcCnpiQSuuQGNQvL0
 hag5buHQ6TX6hPok3/FgyuvXjQkfov+J6Z+tNcltVLkpKpPo6tqRoEg1kEeFC1HWRGMc8hLiR5h
 +VwjQLZb243IVOl+9WArYS9QpjNU2ZAqu/HGT+cBG9j5ePicojJSl26+Sdqbe/jGso05ylo9XwN
 Q4rmqYlB93iVHwFOIxOTxm0P8dBqf5tWzYsYuGRRDpJSV40+NCMLCaXXGguNxNeG2bsWY6+/qr/
 HLp7aVlpAQCYRQAMgr1LK3YCy9tGcmCMxQlB7DYM5OFcxFqedzOdIsjxQw+izm33rFViWPnIRcw
 2iwP+IyQcEkKIACxpDHuFf6WY+/UHHeaBJ3XtH3OK5fPYZvsx35RYQhrM+GewhFl7uj/FDcNhMx
 Zn16gL/w40u12/RZ/NrbwqKVaoOv6pUyP0mG7NVAgl4o1gBt8s26RN4FO/xtEMmTWFQVkSum0vL
 cG8qbzIHqmFcCfiUy/ErPq22UGAq8dOTYxXbRkZFxjczMtODfnssqVKzUQtXTuAXq885EtAr5JY
 AYq+UgwBLjOSOhQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Framework notifications are doorbells that are rung by the partition
managers to signal common events to an endpoint. These doorbells cannot
be rung by an endpoint directly. A partition manager can signal a
Framework notification in response to an FF-A ABI invocation by an
endpoint.

Two additional notify_ops interface is being added for any FF-A device/
driver to register and unregister for such a framework notifications.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 113 +++++++++++++++++++++++++++++++-------
 include/linux/arm_ffa.h           |   5 ++
 2 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 5863272f45d9c075d8e86d45a90ac6b1fb743c98..a889ad6d94ac499cff869a138970c9dc7ae0a1f9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1117,6 +1117,7 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 struct notifier_cb_info {
 	struct hlist_node hnode;
 	struct ffa_device *dev;
+	ffa_fwk_notifier_cb fwk_cb;
 	ffa_notifier_cb cb;
 	void *cb_data;
 };
@@ -1180,28 +1181,61 @@ static enum notify_type ffa_notify_type_get(u16 vm_id)
 		return NON_SECURE_VM;
 }
 
-/* Should be called while the notify_lock is taken */
+/* notifier_hnode_get* should be called with notify_lock held */
 static struct notifier_cb_info *
-notifier_hash_node_get(u16 notify_id, enum notify_type type)
+notifier_hnode_get_by_vmid(u16 notify_id, int vmid)
 {
 	struct notifier_cb_info *node;
 
 	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
-		if (type == ffa_notify_type_get(node->dev->vm_id))
+		if (node->fwk_cb && vmid == node->dev->vm_id)
+			return node;
+
+	return NULL;
+}
+
+static struct notifier_cb_info *
+notifier_hnode_get_by_vmid_uuid(u16 notify_id, int vmid, const uuid_t *uuid)
+{
+	struct notifier_cb_info *node;
+
+	if (uuid_is_null(uuid))
+		return notifier_hnode_get_by_vmid(notify_id, vmid);
+
+	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
+		if (node->fwk_cb && vmid == node->dev->vm_id &&
+		    uuid_equal(&node->dev->uuid, uuid))
+			return node;
+
+	return NULL;
+}
+
+static struct notifier_cb_info *
+notifier_hnode_get_by_type(u16 notify_id, enum notify_type type)
+{
+	struct notifier_cb_info *node;
+
+	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
+		if (node->cb && type == ffa_notify_type_get(node->dev->vm_id))
 			return node;
 
 	return NULL;
 }
 
 static int
-update_notifier_cb(struct ffa_device *dev, int notify_id, ffa_notifier_cb cb,
-		   void *cb_data, bool is_registration)
+update_notifier_cb(struct ffa_device *dev, int notify_id, void *cb,
+		   void *cb_data, bool is_registration, bool is_framework)
 {
 	struct notifier_cb_info *cb_info = NULL;
 	enum notify_type type = ffa_notify_type_get(dev->vm_id);
 	bool cb_found;
 
-	cb_info = notifier_hash_node_get(notify_id, type);
+	if (is_framework)
+		cb_info = notifier_hnode_get_by_vmid_uuid(notify_id, dev->vm_id,
+							  &dev->uuid);
+	else
+		cb_info = notifier_hnode_get_by_type(notify_id, type);
+
 	cb_found = !!cb_info;
 
 	if (!(is_registration ^ cb_found))
@@ -1213,8 +1247,11 @@ update_notifier_cb(struct ffa_device *dev, int notify_id, ffa_notifier_cb cb,
 			return -ENOMEM;
 
 		cb_info->dev = dev;
-		cb_info->cb = cb;
 		cb_info->cb_data = cb_data;
+		if (is_framework)
+			cb_info->fwk_cb = cb;
+		else
+			cb_info->cb = cb;
 
 		hash_add(drv_info->notifier_hash, &cb_info->hnode, notify_id);
 	} else {
@@ -1224,7 +1261,8 @@ update_notifier_cb(struct ffa_device *dev, int notify_id, ffa_notifier_cb cb,
 	return 0;
 }
 
-static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
+static int __ffa_notify_relinquish(struct ffa_device *dev, int notify_id,
+				   bool is_framework)
 {
 	int rc;
 
@@ -1236,22 +1274,35 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 
 	mutex_lock(&drv_info->notify_lock);
 
-	rc = update_notifier_cb(dev, notify_id, NULL, NULL, false);
+	rc = update_notifier_cb(dev, notify_id, NULL, NULL, false,
+				is_framework);
 	if (rc) {
 		pr_err("Could not unregister notification callback\n");
 		mutex_unlock(&drv_info->notify_lock);
 		return rc;
 	}
 
-	rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+	if (!is_framework)
+		rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 
 	mutex_unlock(&drv_info->notify_lock);
 
 	return rc;
 }
 
-static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
-			      ffa_notifier_cb cb, void *cb_data, int notify_id)
+static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
+{
+	return __ffa_notify_relinquish(dev, notify_id, false);
+}
+
+static int ffa_fwk_notify_relinquish(struct ffa_device *dev, int notify_id)
+{
+	return __ffa_notify_relinquish(dev, notify_id, true);
+}
+
+static int __ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
+				void *cb, void *cb_data,
+				int notify_id, bool is_framework)
 {
 	int rc;
 	u32 flags = 0;
@@ -1264,26 +1315,44 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 
 	mutex_lock(&drv_info->notify_lock);
 
-	if (is_per_vcpu)
-		flags = PER_VCPU_NOTIFICATION_FLAG;
+	if (!is_framework) {
+		if (is_per_vcpu)
+			flags = PER_VCPU_NOTIFICATION_FLAG;
 
-	rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
-	if (rc) {
-		mutex_unlock(&drv_info->notify_lock);
-		return rc;
+		rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
+		if (rc) {
+			mutex_unlock(&drv_info->notify_lock);
+			return rc;
+		}
 	}
 
-	rc = update_notifier_cb(dev, notify_id, cb, cb_data, true);
+	rc = update_notifier_cb(dev, notify_id, cb, cb_data, true,
+				is_framework);
 	if (rc) {
 		pr_err("Failed to register callback for %d - %d\n",
 		       notify_id, rc);
-		ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+		if (!is_framework)
+			ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 	}
 	mutex_unlock(&drv_info->notify_lock);
 
 	return rc;
 }
 
+static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
+			      ffa_notifier_cb cb, void *cb_data, int notify_id)
+{
+	return __ffa_notify_request(dev, is_per_vcpu, cb, cb_data, notify_id,
+				    false);
+}
+
+static int
+ffa_fwk_notify_request(struct ffa_device *dev, ffa_fwk_notifier_cb cb,
+		       void *cb_data, int notify_id)
+{
+	return __ffa_notify_request(dev, false, cb, cb_data, notify_id, true);
+}
+
 static int ffa_notify_send(struct ffa_device *dev, int notify_id,
 			   bool is_per_vcpu, u16 vcpu)
 {
@@ -1313,7 +1382,7 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 			continue;
 
 		mutex_lock(&drv_info->notify_lock);
-		cb_info = notifier_hash_node_get(notify_id, type);
+		cb_info = notifier_hnode_get_by_type(notify_id, type);
 		mutex_unlock(&drv_info->notify_lock);
 
 		if (cb_info && cb_info->cb)
@@ -1386,6 +1455,8 @@ static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
 	.notify_request = ffa_notify_request,
 	.notify_relinquish = ffa_notify_relinquish,
+	.fwk_notify_request = ffa_fwk_notify_request,
+	.fwk_notify_relinquish = ffa_fwk_notify_relinquish,
 	.notify_send = ffa_notify_send,
 };
 
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 4fcbdc70cbc985eabb90733329c974384d229053..5bded24dc24fea8cdcbe42bf79c7c025c3fa5f4b 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -468,6 +468,7 @@ struct ffa_cpu_ops {
 
 typedef void (*ffa_sched_recv_cb)(u16 vcpu, bool is_per_vcpu, void *cb_data);
 typedef void (*ffa_notifier_cb)(int notify_id, void *cb_data);
+typedef void (*ffa_fwk_notifier_cb)(int notify_id, void *cb_data, void *buf);
 
 struct ffa_notifier_ops {
 	int (*sched_recv_cb_register)(struct ffa_device *dev,
@@ -476,6 +477,10 @@ struct ffa_notifier_ops {
 	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
 			      ffa_notifier_cb cb, void *cb_data, int notify_id);
 	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
+	int (*fwk_notify_request)(struct ffa_device *dev,
+				  ffa_fwk_notifier_cb cb, void *cb_data,
+				  int notify_id);
+	int (*fwk_notify_relinquish)(struct ffa_device *dev, int notify_id);
 	int (*notify_send)(struct ffa_device *dev, int notify_id, bool per_vcpu,
 			   u16 vcpu);
 };

-- 
2.34.1


