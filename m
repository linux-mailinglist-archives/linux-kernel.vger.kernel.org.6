Return-Path: <linux-kernel+bounces-517950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35924A387E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10E53B4584
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1422253A7;
	Mon, 17 Feb 2025 15:39:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B81227581
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806788; cv=none; b=f0ZPzpboiqcT/xWP7CVDvaf8IWZeJsF/1wRjmxjcl4seiiQkzVW9PxeD8KHPluSDN5HwZQ5cxO0rHSHJUQUnmsfAc04tNGRkhCh3sCRHOumVISsYtmETN4gegTU7EdVfvW+1+u8Sl6zrR5V7mkKR1b/qcknU19/QbBq1qIpHI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806788; c=relaxed/simple;
	bh=zUw9jpCCHwbKRiqx7Z32FGOQBWRbtxyOOD74emf44tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=DXCcNNa5NmDHHZbm0lLd40Gpm1lv+dqlQeKrgWSC8qYFLi+rtsr1el12BIGFefLfqwVR+Ev+kAnyGOYdLfQI/Ar6RhBSo88zEOpXrmg46FfBeLNV8YWy16vSMwWZxjbsWGkxkV8dy+IPxY4F8mDDxKgBn2LW7PduyzDTsP+QDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73ED11063;
	Mon, 17 Feb 2025 07:40:05 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FE583F6A8;
	Mon, 17 Feb 2025 07:39:45 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:58 +0000
Subject: [PATCH v3 17/19] firmware: arm_ffa: Add support for handling
 framework notifications
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-ffa_updates-v3-17-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=zUw9jpCCHwbKRiqx7Z32FGOQBWRbtxyOOD74emf44tE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gvyqk55MtjEByyz9lgsEdQeQbM/lstIDQKH
 0JT4Odm8y2JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mDBRD/9ssBXMIPSl1evsnV27zqqtXe4QKXj8oq8NX8NxhTw8Wrgryq1vFwuaZb9NPEVHIHtorKn
 vBfs8KvUJHWMxQVYMkdFLPI2aoyCOWxsyQiJyImDEUJIs1VHexZ0ajDEexVYoY9n6LILCQVnoFA
 CpWr1oeqfzxY6Sb6C26FoHCOOGZcNmzkm0iEzz/mipzD1215FUYBdobgpP8kFqZkhypR87bllDi
 vciz18P6cz92e6R6iQ6/5oDcbRTmiubNAEG+ktRTIl8oH4OvMPCOpYad3/Qs7R2sZiJrXxlYrWj
 eL6ppsFXYf+3GUEnruKb3MFXOFi2fk9AYlEYitVLssK605uiFm2ASMjyKktwPPKxjD407RQPQwQ
 9O6jLsP5q3HVSK2GvnzeOzEoz3dwG86qdpDqVJGYAlELz6qeL1c8Ks9F7Q9V/s+Ebfb3fRlbyXM
 sNBbaOxXiXiKw0+x8WlfQXkm0CGSzLdse/x12/e22ciNs09nkW6PL8eX9I60TeGuaesrrYFPKU+
 9GPm8WoBBZJhmQwmZQoOz9cY7jr0lRaCVWCCyad4mpcviqU/K3sthyshyAJr3ydmBpJETviOrxs
 ojpL0y486OUPwhvgZZ3mLafTCpGZKcLO1igt2e67jvLIpSVJ5jt/xnHc8uGnzAPV3quTdq1xTsC
 GMV2NtyvUdzaaPQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently FF-A specification defines only one framework notification:
RX buffer full notification. This notification is signaled by the
partition manager during transmission of a partition message through
indirect messaging to,

1. Notify an endpoint that it has a pending message in its Rx buffer.
2. Inform the message receiver’s scheduler via the schedule receiver
   interrupt that the receiver must be run.

In response to an FFA_MSG_SEND2 invocation by a sender endpoint, the
framework performs the following actions after the message is copied
from the Tx buffer of the sender to the Rx buffer of the receiver:

1. The notification is pended in the framework notification bitmap of
   the receiver.
2. The partition manager of the endpoint that contains receiver’s
   scheduler pends the schedule receiver interrupt for this endpoint.

The receiver receives the notification and copies out the message from
its Rx buffer.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 50 +++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index a889ad6d94ac499cff869a138970c9dc7ae0a1f9..5441c4d8878023ad9107b185b711fd7b04224bb4 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -848,6 +848,7 @@ enum notify_type {
 
 #define SPM_FRAMEWORK_BITMAP(x)			NOTIFICATION_BITMAP_LOW(x)
 #define NS_HYP_FRAMEWORK_BITMAP(x)		NOTIFICATION_BITMAP_HIGH(x)
+#define FRAMEWORK_NOTIFY_RX_BUFFER_FULL		BIT(0)
 
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
@@ -1373,9 +1374,6 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 	int notify_id;
 	struct notifier_cb_info *cb_info = NULL;
 
-	if (type == SPM_FRAMEWORK || type == NS_HYP_FRAMEWORK)
-		return;
-
 	for (notify_id = 0; notify_id <= FFA_MAX_NOTIFICATIONS && bitmap;
 	     notify_id++, bitmap >>= 1) {
 		if (!(bitmap & 1))
@@ -1390,6 +1388,46 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 	}
 }
 
+static void handle_fwk_notif_callbacks(u32 bitmap)
+{
+	void *buf;
+	uuid_t uuid;
+	int notify_id = 0, target;
+	struct ffa_indirect_msg_hdr *msg;
+	struct notifier_cb_info *cb_info = NULL;
+
+	/* Only one framework notification defined and supported for now */
+	if (!(bitmap & FRAMEWORK_NOTIFY_RX_BUFFER_FULL))
+		return;
+
+	mutex_lock(&drv_info->rx_lock);
+
+	msg = drv_info->rx_buffer;
+	buf = kmemdup((void *)msg + msg->offset, msg->size, GFP_KERNEL);
+	if (!buf) {
+		mutex_unlock(&drv_info->rx_lock);
+		return;
+	}
+
+	target = SENDER_ID(msg->send_recv_id);
+	if (msg->offset >= sizeof(*msg))
+		uuid_copy(&uuid, &msg->uuid);
+	else
+		uuid_copy(&uuid, &uuid_null);
+
+	mutex_unlock(&drv_info->rx_lock);
+
+	ffa_rx_release();
+
+	mutex_lock(&drv_info->notify_lock);
+	cb_info = notifier_hnode_get_by_vmid_uuid(notify_id, target, &uuid);
+	mutex_unlock(&drv_info->notify_lock);
+
+	if (cb_info && cb_info->fwk_cb)
+		cb_info->fwk_cb(notify_id, cb_info->cb_data, buf);
+	kfree(buf);
+}
+
 static void notif_get_and_handle(void *unused)
 {
 	int rc;
@@ -1401,10 +1439,8 @@ static void notif_get_and_handle(void *unused)
 		return;
 	}
 
-	handle_notif_callbacks(SPM_FRAMEWORK_BITMAP(bitmaps.arch_map),
-			       SPM_FRAMEWORK);
-	handle_notif_callbacks(NS_HYP_FRAMEWORK_BITMAP(bitmaps.arch_map),
-			       NS_HYP_FRAMEWORK);
+	handle_fwk_notif_callbacks(SPM_FRAMEWORK_BITMAP(bitmaps.arch_map));
+	handle_fwk_notif_callbacks(NS_HYP_FRAMEWORK_BITMAP(bitmaps.arch_map));
 	handle_notif_callbacks(bitmaps.vm_map, NON_SECURE_VM);
 	handle_notif_callbacks(bitmaps.sp_map, SECURE_PARTITION);
 }

-- 
2.34.1


