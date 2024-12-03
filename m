Return-Path: <linux-kernel+bounces-429658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CE9E1F33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B34163289
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDA1F6671;
	Tue,  3 Dec 2024 14:31:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249811DDC3D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236276; cv=none; b=r1zV4Npkx73cmypjQLC/sIBD0JuF+Uli+e+/AkCEVHP6BvFYj5nIKcaGUcOvqMM8FxRZw9Ymi2ZgnORYBlqXNCQmaaENt2FpLJN2bFviqgDk1qte/PwkiGm43QjITKqKCeEyTtcID6m3fmRUxh52bpLw2bm6KvAIDDNYAEmUlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236276; c=relaxed/simple;
	bh=aewdzpB1HHpbJtnu4nozNpYKGui4Tsj7YW3CwLDw6+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkDUziuMgJ//fsE1z8TF4oUV9EQlLCXgqqR3iP/mGxKStCX/4M4ZefOZC9Hve9F6a9NuqP5WXxKH3QGP9ByMkf7LoPAzco3agrDfbuH9eTGRkFh5quagmtEosMF3q6sx8Uoxrt4AkIqJdDV1hTGohunEx1YaFVsCcl6EbiGK/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65FF7143D;
	Tue,  3 Dec 2024 06:31:41 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BA433F71E;
	Tue,  3 Dec 2024 06:31:12 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 1/2] firmware/arm_ffa: change ffa_device_register()'s parameters and return
Date: Tue,  3 Dec 2024 14:31:08 +0000
Message-Id: <20241203143109.1030514-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203143109.1030514-1-yeoreum.yun@arm.com>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

Currently, ffa_dev->properties is set after ffa_device_register() in
ffa_setup_partitions().
This means it couldn't validate partition's properties
while probing ffa_device.

Change parameter of ffa_device_register() to receive ffa_partition_info
so that before device_register(), ffa_device->properties can be setup
and any other data.

Also, change return value of ffa_device_register() from NULL to ERR_PTR
so that it passes error code.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    | 15 +++++++++++----
 drivers/firmware/arm_ffa/driver.c |  7 +------
 include/linux/arm_ffa.h           | 12 ++++++++----
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index eb17d03b66fe..a4ab6d14afef 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -187,13 +187,18 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 	return valid;
 }
 
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_ops *ops)
+struct ffa_device *ffa_device_register(
+		const struct ffa_partition_info *part_info,
+		const struct ffa_ops *ops)
 {
 	int id, ret;
+	uuid_t uuid;
 	struct device *dev;
 	struct ffa_device *ffa_dev;
 
+	if (!part_info)
+		return NULL;
+
 	id = ida_alloc_min(&ffa_bus_id, 1, GFP_KERNEL);
 	if (id < 0)
 		return NULL;
@@ -210,9 +215,11 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-	ffa_dev->vm_id = vm_id;
+	ffa_dev->vm_id = part_info->id;
+	ffa_dev->properties = part_info->properties;
 	ffa_dev->ops = ops;
-	uuid_copy(&ffa_dev->uuid, uuid);
+	import_uuid(&uuid, (u8 *)part_info->uuid);
+	uuid_copy(&ffa_dev->uuid, &uuid);
 
 	ret = device_register(&ffa_dev->dev);
 	if (ret) {
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b14cbdae94e8..2c2ec3c35f15 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1387,7 +1387,6 @@ static struct notifier_block ffa_bus_nb = {
 static int ffa_setup_partitions(void)
 {
 	int count, idx, ret;
-	uuid_t uuid;
 	struct ffa_device *ffa_dev;
 	struct ffa_dev_part_info *info;
 	struct ffa_partition_info *pbuf, *tpbuf;
@@ -1406,23 +1405,19 @@ static int ffa_setup_partitions(void)
 
 	xa_init(&drv_info->partition_info);
 	for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
-		import_uuid(&uuid, (u8 *)tpbuf->uuid);
-
 		/* Note that if the UUID will be uuid_null, that will require
 		 * ffa_bus_notifier() to find the UUID of this partition id
 		 * with help of ffa_device_match_uuid(). FF-A v1.1 and above
 		 * provides UUID here for each partition as part of the
 		 * discovery API and the same is passed.
 		 */
-		ffa_dev = ffa_device_register(&uuid, tpbuf->id, &ffa_drv_ops);
+		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops);
 		if (!ffa_dev) {
 			pr_err("%s: failed to register partition ID 0x%x\n",
 			       __func__, tpbuf->id);
 			continue;
 		}
 
-		ffa_dev->properties = tpbuf->properties;
-
 		if (drv_info->version > FFA_VERSION_1_0 &&
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
 			ffa_mode_32bit_set(ffa_dev);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index a28e2a6a13d0..3fb9c7a3453b 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -166,9 +166,12 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *fdev)
 	return dev_get_drvdata(&fdev->dev);
 }
 
+struct ffa_partition_info;
+
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_ops *ops);
+struct ffa_device *ffa_device_register(
+		const struct ffa_partition_info *part_info,
+		const struct ffa_ops *ops);
 void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
@@ -177,8 +180,9 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 
 #else
 static inline
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_ops *ops)
+struct ffa_device *ffa_device_register(
+		const struct ffa_partition_info *part_info,
+		const struct ffa_ops *ops)
 {
 	return NULL;
 }
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


