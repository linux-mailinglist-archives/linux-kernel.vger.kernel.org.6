Return-Path: <linux-kernel+bounces-517952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0FA387E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911933B09A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0F228389;
	Mon, 17 Feb 2025 15:39:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BED227B9D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806790; cv=none; b=oTLvat0JwWqzbBP7LKLXz0/elCVgmS06J8XEodKql/slAciTpnYVIO7DpMMOohw1IzSdOsYXbq/EAE+l3VOSDzvuHepsU5tRvcX1fSEpStWWYgQVDzJjW9ETqkcOXWfa7X0xSt/PC1D31ZAjsdLNj4xYd2TQFO07VVP/OWvVKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806790; c=relaxed/simple;
	bh=glQcibRPZ3LfxkYdcYsdlJeo9DnLI2cUT7CIltYuAok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=aIAW5BkFnU589vf61EQIY6dW98PmZTNN/EI/yrfygMzF5mK8CA8PvVCkN7fVm50xg2nSBhtbiNq9ZTr1JPRcQfb4pN33ACwSfHQaRsU39JijNDYbKHSIm2D4CYkU5kNvMOIz0nIuybD+ixWuMO6iyw18L8qv9k8EMOIc4WD9wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80045152B;
	Mon, 17 Feb 2025 07:40:07 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C5153F6A8;
	Mon, 17 Feb 2025 07:39:47 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:39:00 +0000
Subject: [PATCH v3 19/19] firmware: arm_ffa: Handle ffa_notification_get
 correctly at virtual FF-A instance
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-19-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3134; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=glQcibRPZ3LfxkYdcYsdlJeo9DnLI2cUT7CIltYuAok=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gvLiiYeNuHpZrc1TNX2jkRDa6aSrZvzKVhn
 Z9uHQpPgVaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mLB8D/4jUASnurXChQYVGRrJFk2N+5zQlPN+hwPXF6W7okyL28JUVvKWTGrshQ28N/O2uns8NLM
 RJaSHgSMXPDsVpxbbshCUYUFBnzZ+9IXzIJCkNGzwGVHmM9aLGWGw7wAHo6JEJ74uJhcrJ2xb47
 v3ZsSbyZx5gkxcakkKmXCr1mh/kTvv2m4opFRULoItyeKWrtFJSkTKkmlhNz4sh4kWroV7KGJEV
 CzgsmbHAnofrupMXj402hYBCgEVM+msMEhlPv9bHodefo+Z4VcY5hzHVtdpc8yjDL7JTvAKOPhL
 cQtj4/fzj/vfVRGsHV1I8WzzUWhEisxSPBWkkATj6itSJOMjH6tWx+xc29vYwi/Ro60t7QKv4Yk
 zUdvEx1WThdhKkwLTp+b+z6Sb8xyyNSM1aRO+w2GNvvu1xu3XqOwtp+AhIZz8TtTE6QEpwOsSH5
 KGt3YYu/x0wKZu+Z2w8vmWbOnpKQbt3GT8cp+xAg6sNElC2IsqCWB1nNVMZYWs8bV52I0qGk5Ow
 Lm39R/o9Crxvgz8TNtqLZnGeq3rPgJPpkR/Fx0ZZO1lDtN8+20yBQS3MGNWQz5ujq91tO0Jk74a
 4jfTgLsA4vzWl4bn2ipkWLdh+k2Z4gdichiq5VX8xXVT7Y7miU6WakJiNOoOfJ8yShRUlzF2+CC
 2k4JyvqmWgsjuJQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently it is assumed that the driver always calls ffa_notification_get()
at the NS physical FF-A instance to request the SPMC to return pending
SP or SPM Framework notifications. However, in order to support the driver
invoking ffa_notification_get() at virtual FF-A instance, we need to make
sure correct bits are enabled in the bitmaps enable flag.

It is expected to have hypervisor framework and VM notifications bitmap
to be zero at the non-secure physical FF-A instance.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index db6334f0c532566565246173373d8f0a42c836af..f3ca703a44413b6394559c68b12fda6a75acadf0 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -841,8 +841,12 @@ enum notify_type {
 #define NON_SECURE_VM_BITMAP_ENABLE		BIT(NON_SECURE_VM)
 #define SPM_FRAMEWORK_BITMAP_ENABLE		BIT(SPM_FRAMEWORK)
 #define NS_HYP_FRAMEWORK_BITMAP_ENABLE		BIT(NS_HYP_FRAMEWORK)
-#define FFA_BITMAP_ENABLE_MASK			\
+#define FFA_BITMAP_SECURE_ENABLE_MASK		\
 	(SECURE_PARTITION_BITMAP_ENABLE | SPM_FRAMEWORK_BITMAP_ENABLE)
+#define FFA_BITMAP_NS_ENABLE_MASK		\
+	(NON_SECURE_VM_BITMAP_ENABLE | NS_HYP_FRAMEWORK_BITMAP_ENABLE)
+#define FFA_BITMAP_ALL_ENABLE_MASK		\
+	(FFA_BITMAP_SECURE_ENABLE_MASK | FFA_BITMAP_NS_ENABLE_MASK)
 
 #define FFA_SECURE_PARTITION_ID_FLAG		BIT(15)
 
@@ -914,9 +918,15 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
 	else if (ret.a0 != FFA_SUCCESS)
 		return -EINVAL; /* Something else went wrong. */
 
-	notify->sp_map = PACK_NOTIFICATION_BITMAP(ret.a2, ret.a3);
-	notify->vm_map = PACK_NOTIFICATION_BITMAP(ret.a4, ret.a5);
-	notify->arch_map = PACK_NOTIFICATION_BITMAP(ret.a6, ret.a7);
+	if (flags & SECURE_PARTITION_BITMAP_ENABLE)
+		notify->sp_map = PACK_NOTIFICATION_BITMAP(ret.a2, ret.a3);
+	if (flags & NON_SECURE_VM_BITMAP_ENABLE)
+		notify->vm_map = PACK_NOTIFICATION_BITMAP(ret.a4, ret.a5);
+	if (flags & SPM_FRAMEWORK_BITMAP_ENABLE)
+		notify->arch_map = SPM_FRAMEWORK_BITMAP(ret.a6);
+	if (flags & NS_HYP_FRAMEWORK_BITMAP_ENABLE)
+		notify->arch_map = PACK_NOTIFICATION_BITMAP(notify->arch_map,
+							    ret.a7);
 
 	return 0;
 }
@@ -1444,12 +1454,19 @@ static void handle_fwk_notif_callbacks(u32 bitmap)
 	kfree(buf);
 }
 
-static void notif_get_and_handle(void *unused)
+static void notif_get_and_handle(void *cb_data)
 {
 	int rc;
-	struct ffa_notify_bitmaps bitmaps;
+	u32 flags;
+	struct ffa_drv_info *info = cb_data;
+	struct ffa_notify_bitmaps bitmaps = { 0 };
+
+	if (info->vm_id == 0) /* Non secure physical instance */
+		flags = FFA_BITMAP_SECURE_ENABLE_MASK;
+	else
+		flags = FFA_BITMAP_ALL_ENABLE_MASK;
 
-	rc = ffa_notification_get(FFA_BITMAP_ENABLE_MASK, &bitmaps);
+	rc = ffa_notification_get(flags, &bitmaps);
 	if (rc) {
 		pr_err("Failed to retrieve notifications with %d!\n", rc);
 		return;

-- 
2.34.1


