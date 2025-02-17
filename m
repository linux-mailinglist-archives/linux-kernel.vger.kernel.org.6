Return-Path: <linux-kernel+bounces-517947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B395BA387DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E23B5D28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622822756A;
	Mon, 17 Feb 2025 15:39:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EC226865
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806785; cv=none; b=RDd7U3FYsz0UTLsHDPxvSOlU1SWFzlqTzbGIhvyy6ngH2SUzrNZegeWH8pvKGqdqzHRQk5w8edPNl05PIxD9AS/fyryRnUMBjnjESVXpwaPPnu3hRr9Xj82MFoIsxirqyIvASjVTuXFTEyeK7cHxjAEDEgzHC0HvVRWVCTGmAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806785; c=relaxed/simple;
	bh=uPUgv0mLk6mKXfHHZQoNabuM20DP7Tz7q35RqzDweLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=HXM6VA+GrY8gYpH+e2iMb+a9ufYAxe8bFYza33fF4m71KccOFWA/SMjs7lh2V6GEby2PtJoEU/ohgmzexGWeLAUsNtTkfC1RLEIy1AD9rXE4GDzTe9++N1OYAvyMwEXvGJvkV7ADcUxZ6zntqpPYAi2tVNI/utYSvxQkq7b2P2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D17152B;
	Mon, 17 Feb 2025 07:40:02 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CADB3F6A8;
	Mon, 17 Feb 2025 07:39:42 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:55 +0000
Subject: [PATCH v3 14/19] firmware: arm_ffa: Refactoring to prepare for
 framework notification support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-14-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4846; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=uPUgv0mLk6mKXfHHZQoNabuM20DP7Tz7q35RqzDweLQ=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gvD8PSV3+oN/oLts63Djl+9M8FM/+AD4Tm4
 RUvVdWfSM+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mCZzEAC11Ij+667T8JKp6Kyu6monTKkZrfb3AWWtDbtEje5z0cOlnp1MZsCtbCv2VCOuS1BFr8z
 3QAstRQ9c9sxuqufHmJi8qzAk5qvGVpyBi7V3fE6yc7vqWhw27AkLxTaQ2EabDhSJ4vv8lr6jbh
 DB2Xu771Vfxc6gzOsKA3yfbuZsNubgCHiGAcEzmaI5OHqRzhXtsuxTnPMVNKRczfAn06WC3iMQX
 EXxfrVu7A0h1ZH0Dn35iUbw+Ik1uUFU1srjbYjRL9XLQAlQXEC1/BcqAcDZ8UJGjRsvGFRhspFP
 ggWvcJw1h09vJMlcEsOef+r1tLoQA6T8YjmOqrK3YeWCWGhjoDBznZuO6kA/fBEWuSSh660uk02
 oqFiEDVUYWTnDAutSnCtbKeULjeFKhXEF3+F9e2+SFEAGHEdrVTERpsLE8xxLMFhlAEMnH87KiS
 3bJn+DVRQVQeqzBAs2TbAFWihsv864XltAXLYhe4ahxfjsyuQWuqtL6N7lhMF18D/Gnwn8Ph2Hm
 r7FXMVd7nuv7CqxUolOOtmvF+q7SeUHn+RjB4JimCxs9LE9eH9UrGeES94HhntMKc243wjUkIfE
 lRepaxWUjglAtzPqHavoU3nALbJXR/t0/e9rY07oaWL/PbM4PHCbougw/UF3B3dr9dvGGJTLLll
 kvDIxl0L4JOkhqw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently, the framework notifications are not supported at all.
handle_notif_callbacks() doesn't handle them though it is called with
framework bitmap. Make that explicit by adding checks for the same.

Also, we need to further classify the framework notifications as Secure
Partition Manager(SPM) and NonSecure Hypervisor(NS_HYP). Extend/change
notify_type enumeration to accommodate all the 4 type and rejig the
values so that it can be reused in the bitmap enable mask macros.

While at this, move ffa_notify_type_get() so that it can be used in
notifier_hash_node_get() in the future.

No functional change.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 57 +++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 43e033edd6c7cd16322c204e882a84cfe45abbba..0abbf08bc8d39c701947366bdf9c8fac8e64cf64 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -807,6 +807,13 @@ static int ffa_notification_bitmap_destroy(void)
 	return 0;
 }
 
+enum notify_type {
+	SECURE_PARTITION,
+	NON_SECURE_VM,
+	SPM_FRAMEWORK,
+	NS_HYP_FRAMEWORK,
+};
+
 #define NOTIFICATION_LOW_MASK		GENMASK(31, 0)
 #define NOTIFICATION_HIGH_MASK		GENMASK(63, 32)
 #define NOTIFICATION_BITMAP_HIGH(x)	\
@@ -830,10 +837,17 @@ static int ffa_notification_bitmap_destroy(void)
 #define MAX_IDS_32				10
 
 #define PER_VCPU_NOTIFICATION_FLAG		BIT(0)
-#define SECURE_PARTITION_BITMAP			BIT(0)
-#define NON_SECURE_VM_BITMAP			BIT(1)
-#define SPM_FRAMEWORK_BITMAP			BIT(2)
-#define NS_HYP_FRAMEWORK_BITMAP			BIT(3)
+#define SECURE_PARTITION_BITMAP_ENABLE		BIT(SECURE_PARTITION)
+#define NON_SECURE_VM_BITMAP_ENABLE		BIT(NON_SECURE_VM)
+#define SPM_FRAMEWORK_BITMAP_ENABLE		BIT(SPM_FRAMEWORK)
+#define NS_HYP_FRAMEWORK_BITMAP_ENABLE		BIT(NS_HYP_FRAMEWORK)
+#define FFA_BITMAP_ENABLE_MASK			\
+	(SECURE_PARTITION_BITMAP_ENABLE | SPM_FRAMEWORK_BITMAP_ENABLE)
+
+#define FFA_SECURE_PARTITION_ID_FLAG		BIT(15)
+
+#define SPM_FRAMEWORK_BITMAP(x)			NOTIFICATION_BITMAP_LOW(x)
+#define NS_HYP_FRAMEWORK_BITMAP(x)		NOTIFICATION_BITMAP_HIGH(x)
 
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
@@ -1098,16 +1112,8 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
-#define FFA_SECURE_PARTITION_ID_FLAG	BIT(15)
-
 #define ffa_notifications_disabled()	(!drv_info->notif_enabled)
 
-enum notify_type {
-	NON_SECURE_VM,
-	SECURE_PARTITION,
-	FRAMEWORK,
-};
-
 struct notifier_cb_info {
 	struct hlist_node hnode;
 	ffa_notifier_cb cb;
@@ -1166,6 +1172,14 @@ static int ffa_notification_unbind(u16 dst_id, u64 bitmap)
 	return ffa_notification_bind_common(dst_id, bitmap, 0, false);
 }
 
+static enum notify_type ffa_notify_type_get(u16 vm_id)
+{
+	if (vm_id & FFA_SECURE_PARTITION_ID_FLAG)
+		return SECURE_PARTITION;
+	else
+		return NON_SECURE_VM;
+}
+
 /* Should be called while the notify_lock is taken */
 static struct notifier_cb_info *
 notifier_hash_node_get(u16 notify_id, enum notify_type type)
@@ -1209,14 +1223,6 @@ update_notifier_cb(int notify_id, enum notify_type type, ffa_notifier_cb cb,
 	return 0;
 }
 
-static enum notify_type ffa_notify_type_get(u16 vm_id)
-{
-	if (vm_id & FFA_SECURE_PARTITION_ID_FLAG)
-		return SECURE_PARTITION;
-	else
-		return NON_SECURE_VM;
-}
-
 static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 {
 	int rc;
@@ -1299,6 +1305,9 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 	int notify_id;
 	struct notifier_cb_info *cb_info = NULL;
 
+	if (type == SPM_FRAMEWORK || type == NS_HYP_FRAMEWORK)
+		return;
+
 	for (notify_id = 0; notify_id <= FFA_MAX_NOTIFICATIONS && bitmap;
 	     notify_id++, bitmap >>= 1) {
 		if (!(bitmap & 1))
@@ -1318,16 +1327,18 @@ static void notif_get_and_handle(void *unused)
 	int rc;
 	struct ffa_notify_bitmaps bitmaps;
 
-	rc = ffa_notification_get(SECURE_PARTITION_BITMAP |
-				  SPM_FRAMEWORK_BITMAP, &bitmaps);
+	rc = ffa_notification_get(FFA_BITMAP_ENABLE_MASK, &bitmaps);
 	if (rc) {
 		pr_err("Failed to retrieve notifications with %d!\n", rc);
 		return;
 	}
 
+	handle_notif_callbacks(SPM_FRAMEWORK_BITMAP(bitmaps.arch_map),
+			       SPM_FRAMEWORK);
+	handle_notif_callbacks(NS_HYP_FRAMEWORK_BITMAP(bitmaps.arch_map),
+			       NS_HYP_FRAMEWORK);
 	handle_notif_callbacks(bitmaps.vm_map, NON_SECURE_VM);
 	handle_notif_callbacks(bitmaps.sp_map, SECURE_PARTITION);
-	handle_notif_callbacks(bitmaps.arch_map, FRAMEWORK);
 }
 
 static void

-- 
2.34.1


