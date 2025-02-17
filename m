Return-Path: <linux-kernel+bounces-517951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64EA387E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82E63B6E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8591227EB8;
	Mon, 17 Feb 2025 15:39:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE59226865
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806789; cv=none; b=PEMjuY3Dr9L1yZWyPTWwHFz3WIiol+8V7cUGtS8cUXVBShqv0dyqnpMtI8lenBR02aW2s2ZoVC1uOWIpqVuis0wYdWwmPHAcx1HKUAphocXhsiE5vdHwEL7pFGdyT/su2R/HTKUwmv5jzJjY9rGIRHc4r89NZSRGTHof2oTYWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806789; c=relaxed/simple;
	bh=u6lcDDwGq+4Z1B/VCc7uTlwjRc2gb5kTQ9pVpMg+eP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pc+Xgee7h9KRZIfVND8ixOMtFxfeo28RdIYSZyY3rlyoBkZAhCFsjuam8HoBnw5y2aFxalTaWXMO6EO2c233p/vYtCVU3n7jGSsXEp7Wf0OIKVHg8LWnYQmaSplO++2MwyJtBj0V2HvSs8LSSUYjZkOju4SDxYQ3wuKxj27Ec64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E9A1692;
	Mon, 17 Feb 2025 07:40:06 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9636E3F6A8;
	Mon, 17 Feb 2025 07:39:46 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:59 +0000
Subject: [PATCH v3 18/19] firmware: arm_ffa: Allow multiple UUIDs per
 partition to register SRI callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-18-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8280; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=u6lcDDwGq+4Z1B/VCc7uTlwjRc2gb5kTQ9pVpMg+eP8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gvUT+CyjK120FZSB/TCAZ/EELkP9V3xvgPe
 nJmJyXEEzqJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mGnhEAC69hZaIx2JOfex0oN31tTLZFebu5sTS9bubNRzatou/H9RgGd+RtPeeD98hu/5qplge/X
 uj/YFQ5SdsGmvTxIyNi3FyBeSzV3K97mr7NLYh0VxRrRuuH3Sfe+ptPqWdhuTL785cGvIvuZNc9
 DD1Bf4W3bFX7QhmA5uoIChXTfGrN8n8RibGVIvbbIQp/NOo0oZu+ifC3kvsZREUuG9TEF90VChf
 Pg0Z/u162kC+R+MvaElDImPrYvHCyFMG5rA7QJVP/BvWhBGKroNgHwOb83PsOToqTJeMTzuueB+
 MXpMQqdO7KtR045zGu+8YJs6VgaV5qKhUQlw4A94OCiYiq+MvbaGflU9VkFOP+YAgbWezg3Mpz2
 eVErP6e5Am5iyN3H/uc1BjUeutGHF+raQMPqrQjjZsfCu6H6mvXI0F3gG4tsrsx099gtQqVJNCx
 SEGOjLYMfY03fDxENVVpOEq0emwMoo3oWl4NLCfdNbkDvoRrGYtRFXtdWF2FdD2kfHcRLuUjPpT
 cO91hW6jcUX+j2d+MfZ6/rQDT7oggLf3nGRbfTJ6nBpk+gGD1PyN+aQJ1RVW5nSOwf77P5WvOjR
 kOKYZD0vZlInulnjoCcbjJGYRmHhyhZQ+F/A7IIKjOfd95Lf3uAhOmGjc8z/yGGrNwQhQIx4s8l
 qRN8h4dvWAf2f8A==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

A partition can implement multiple UUIDs and currently we successfully
register each UUID service as a FF-A device. However when adding the
same partition info to the XArray which tracks the SRI callbacks more
than once, it fails.

In order to allow multiple UUIDs per partition to register SRI callbacks
the partition information stored in the XArray needs to be extended to
a listed list.

A function to remove the list of partition information in the XArray
is not added as there are no users at the time. All the partitions are
added at probe/initialisation and removed at cleanup stage.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 159 ++++++++++++++++++++++++++++----------
 1 file changed, 117 insertions(+), 42 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 5441c4d8878023ad9107b185b711fd7b04224bb4..db6334f0c532566565246173373d8f0a42c836af 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -925,27 +925,32 @@ struct ffa_dev_part_info {
 	ffa_sched_recv_cb callback;
 	void *cb_data;
 	rwlock_t rw_lock;
+	struct ffa_device *dev;
+	struct list_head node;
 };
 
 static void __do_sched_recv_cb(u16 part_id, u16 vcpu, bool is_per_vcpu)
 {
-	struct ffa_dev_part_info *partition;
+	struct ffa_dev_part_info *partition = NULL, *tmp;
 	ffa_sched_recv_cb callback;
+	struct list_head *phead;
 	void *cb_data;
 
-	partition = xa_load(&drv_info->partition_info, part_id);
-	if (!partition) {
+	phead = xa_load(&drv_info->partition_info, part_id);
+	if (!phead) {
 		pr_err("%s: Invalid partition ID 0x%x\n", __func__, part_id);
 		return;
 	}
 
-	read_lock(&partition->rw_lock);
-	callback = partition->callback;
-	cb_data = partition->cb_data;
-	read_unlock(&partition->rw_lock);
+	list_for_each_entry_safe(partition, tmp, phead, node) {
+		read_lock(&partition->rw_lock);
+		callback = partition->callback;
+		cb_data = partition->cb_data;
+		read_unlock(&partition->rw_lock);
 
-	if (callback)
-		callback(vcpu, is_per_vcpu, cb_data);
+		if (callback)
+			callback(vcpu, is_per_vcpu, cb_data);
+	}
 }
 
 static void ffa_notification_info_get(void)
@@ -1123,18 +1128,29 @@ struct notifier_cb_info {
 	void *cb_data;
 };
 
-static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
-				    void *cb_data, bool is_registration)
+static int
+ffa_sched_recv_cb_update(struct ffa_device *dev, ffa_sched_recv_cb callback,
+			 void *cb_data, bool is_registration)
 {
-	struct ffa_dev_part_info *partition;
+	struct ffa_dev_part_info *partition = NULL, *tmp;
+	struct list_head *phead;
 	bool cb_valid;
 
 	if (ffa_notifications_disabled())
 		return -EOPNOTSUPP;
 
-	partition = xa_load(&drv_info->partition_info, part_id);
+	phead = xa_load(&drv_info->partition_info, dev->vm_id);
+	if (!phead) {
+		pr_err("%s: Invalid partition ID 0x%x\n", __func__, dev->vm_id);
+		return -EINVAL;
+	}
+
+	list_for_each_entry_safe(partition, tmp, phead, node)
+		if (partition->dev == dev)
+			break;
+
 	if (!partition) {
-		pr_err("%s: Invalid partition ID 0x%x\n", __func__, part_id);
+		pr_err("%s: No such partition ID 0x%x\n", __func__, dev->vm_id);
 		return -EINVAL;
 	}
 
@@ -1156,12 +1172,12 @@ static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
 static int ffa_sched_recv_cb_register(struct ffa_device *dev,
 				      ffa_sched_recv_cb cb, void *cb_data)
 {
-	return ffa_sched_recv_cb_update(dev->vm_id, cb, cb_data, true);
+	return ffa_sched_recv_cb_update(dev, cb, cb_data, true);
 }
 
 static int ffa_sched_recv_cb_unregister(struct ffa_device *dev)
 {
-	return ffa_sched_recv_cb_update(dev->vm_id, NULL, NULL, false);
+	return ffa_sched_recv_cb_update(dev, NULL, NULL, false);
 }
 
 static int ffa_notification_bind(u16 dst_id, u64 bitmap, u32 flags)
@@ -1548,37 +1564,101 @@ static struct notifier_block ffa_bus_nb = {
 	.notifier_call = ffa_bus_notifier,
 };
 
-static int ffa_xa_add_partition_info(int vm_id)
+static int ffa_xa_add_partition_info(struct ffa_device *dev)
 {
 	struct ffa_dev_part_info *info;
-	int ret;
+	struct list_head *head, *phead;
+	int ret = -ENOMEM;
+
+	phead = xa_load(&drv_info->partition_info, dev->vm_id);
+	if (phead) {
+		head = phead;
+		list_for_each_entry(info, head, node) {
+			if (info->dev == dev) {
+				pr_err("%s: duplicate dev %p part ID 0x%x\n",
+				       __func__, dev, dev->vm_id);
+				return -EEXIST;
+			}
+		}
+	}
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
-		return -ENOMEM;
+		return ret;
 
 	rwlock_init(&info->rw_lock);
-	ret = xa_insert(&drv_info->partition_info, vm_id, info, GFP_KERNEL);
-	if (ret) {
-		pr_err("%s: failed to save partition ID 0x%x - ret:%d. Abort.\n",
-		       __func__, vm_id, ret);
-		kfree(info);
+	info->dev = dev;
+
+	if (!phead) {
+		phead = kzalloc(sizeof(*phead), GFP_KERNEL);
+		if (!phead)
+			goto free_out;
+
+		INIT_LIST_HEAD(phead);
+
+		ret = xa_insert(&drv_info->partition_info, dev->vm_id, phead,
+				GFP_KERNEL);
+		if (ret) {
+			pr_err("%s: failed to save part ID 0x%x Ret:%d\n",
+			       __func__, dev->vm_id, ret);
+			goto free_out;
+		}
+	}
+	list_add(&info->node, phead);
+	return 0;
+
+free_out:
+	kfree(phead);
+	kfree(info);
+	return ret;
+}
+
+static int ffa_setup_host_partition(int vm_id)
+{
+	struct ffa_partition_info buf = { 0 };
+	struct ffa_device *ffa_dev;
+	int ret;
+
+	buf.id = vm_id;
+	ffa_dev = ffa_device_register(&buf, &ffa_drv_ops);
+	if (!ffa_dev) {
+		pr_err("%s: failed to register host partition ID 0x%x\n",
+		       __func__, vm_id);
+		return -EINVAL;
 	}
 
+	ret = ffa_xa_add_partition_info(ffa_dev);
+	if (ret)
+		return ret;
+
+	if (ffa_notifications_disabled())
+		return 0;
+
+	ret = ffa_sched_recv_cb_update(ffa_dev, ffa_self_notif_handle,
+				       drv_info, true);
+	if (ret)
+		pr_info("Failed to register driver sched callback %d\n", ret);
+
 	return ret;
 }
 
 static void ffa_partitions_cleanup(void)
 {
-	struct ffa_dev_part_info *info;
+	struct list_head *phead;
 	unsigned long idx;
 
 	/* Clean up/free all registered devices */
 	ffa_devices_unregister();
 
-	xa_for_each(&drv_info->partition_info, idx, info) {
+	xa_for_each(&drv_info->partition_info, idx, phead) {
+		struct ffa_dev_part_info *info, *tmp;
+
 		xa_erase(&drv_info->partition_info, idx);
-		kfree(info);
+		list_for_each_entry_safe(info, tmp, phead, node) {
+			list_del(&info->node);
+			kfree(info);
+		}
+		kfree(phead);
 	}
 
 	xa_destroy(&drv_info->partition_info);
@@ -1621,7 +1701,7 @@ static int ffa_setup_partitions(void)
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
 			ffa_mode_32bit_set(ffa_dev);
 
-		if (ffa_xa_add_partition_info(ffa_dev->vm_id)) {
+		if (ffa_xa_add_partition_info(ffa_dev)) {
 			ffa_device_unregister(ffa_dev);
 			continue;
 		}
@@ -1629,12 +1709,16 @@ static int ffa_setup_partitions(void)
 
 	kfree(pbuf);
 
-	/* Check if the host is already added as part of partition info */
+	/*
+	 * Check if the host is already added as part of partition info
+	 * No multiple UUID possible for the host, so just checking if
+	 * there is an entry will suffice
+	 */
 	if (xa_load(&drv_info->partition_info, drv_info->vm_id))
 		return 0;
 
 	/* Allocate for the host */
-	ret = ffa_xa_add_partition_info(drv_info->vm_id);
+	ret = ffa_setup_host_partition(drv_info->vm_id);
 	if (ret)
 		ffa_partitions_cleanup();
 
@@ -1943,19 +2027,10 @@ static int __init ffa_init(void)
 	ffa_notifications_setup();
 
 	ret = ffa_setup_partitions();
-	if (ret) {
-		pr_err("failed to setup partitions\n");
-		goto cleanup_notifs;
-	}
-
-	ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
-				       drv_info, true);
-	if (ret)
-		pr_info("Failed to register driver sched callback %d\n", ret);
-
-	return 0;
+	if (!ret)
+		return ret;
 
-cleanup_notifs:
+	pr_err("failed to setup partitions\n");
 	ffa_notifications_cleanup();
 free_pages:
 	if (drv_info->tx_buffer)

-- 
2.34.1


