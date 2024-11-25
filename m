Return-Path: <linux-kernel+bounces-420764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633A9D82E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA88B288708
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC11426C;
	Mon, 25 Nov 2024 09:52:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1319149E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528378; cv=none; b=rDYOHCqyMrkiCnx7yrKSSuwRIAHVWgsit8Yr59cwaZL5A5S6rW6eMy4H71ZB9F+hcads80chqiNxLFSuGk3Nqa/NxU39WuguXZfkPcVsywsjU3hQjaK4OMYX4DqavtOmmxkt3dcgPPQnUclMnC/aNRfERbsuvrU9IkuThkPgTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528378; c=relaxed/simple;
	bh=53WojTmwlVZojvgsSuYNAmnO1TsOYQrHWcOQ5A51A6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpzGU/4ejc/qD2cxx9RM8fXnpsO5YLKf8IeUfXjAw3SGNk7Gsknpq6b55pBoYAQqortmz69R7xQuIcVPD7xDIVMhNaHpzSx+J7VHiUwvzuKR2FsBv8EKdeTH4KBEZc2s5AZRd9uV9dz/fCRGffTs3en3ChxYZUkCabgzdKXdkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D0E1756;
	Mon, 25 Nov 2024 01:53:26 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 462103F5A1;
	Mon, 25 Nov 2024 01:52:55 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/3] firmware/arm_ffa: change ffa_device_register()'s parameters and return
Date: Mon, 25 Nov 2024 09:52:49 +0000
Message-Id: <20241125095251.366866-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125095251.366866-1-yeoreum.yun@arm.com>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
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
 drivers/firmware/arm_ffa/bus.c    | 22 +++++++++++++++-------
 drivers/firmware/arm_ffa/driver.c | 12 ++++--------
 include/linux/arm_ffa.h           | 12 ++++++++----
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index eb17d03b66fe..95c0e9518556 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -38,6 +38,7 @@ static int ffa_device_match(struct device *dev, const struct device_driver *drv)
 
 		if (uuid_equal(&ffa_dev->uuid, &id_table->uuid))
 			return 1;
+
 		id_table++;
 	}
 
@@ -187,21 +188,26 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
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
+		return ERR_PTR(-EINVAL);
+
 	id = ida_alloc_min(&ffa_bus_id, 1, GFP_KERNEL);
 	if (id < 0)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ffa_dev = kzalloc(sizeof(*ffa_dev), GFP_KERNEL);
 	if (!ffa_dev) {
 		ida_free(&ffa_bus_id, id);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	dev = &ffa_dev->dev;
@@ -210,16 +216,18 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
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
 		dev_err(dev, "unable to register device %s err=%d\n",
 			dev_name(dev), ret);
 		put_device(dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return ffa_dev;
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b14cbdae94e8..a3a9cdec7389 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1406,23 +1406,19 @@ static int ffa_setup_partitions(void)
 
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
-		if (!ffa_dev) {
-			pr_err("%s: failed to register partition ID 0x%x\n",
-			       __func__, tpbuf->id);
+		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops);
+		if (IS_ERR_OR_NULL(ffa_dev)) {
+			pr_err("%s: failed to register partition ID 0x%x, error %ld\n",
+			       __func__, tpbuf->id, PTR_ERR(ffa_dev));
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


