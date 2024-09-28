Return-Path: <linux-kernel+bounces-342451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036E988F40
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9781C20CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6B1DFF7;
	Sat, 28 Sep 2024 12:48:31 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F1185E50;
	Sat, 28 Sep 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527711; cv=none; b=VXLs4iAO5FUpQyzS2s2XFwwg2WpY9BCnuJu8a05rHMDJ2ZGq30qOuypUl6+AQvk5ZKFP6wtmrC12H62tr+1Sns+8EjJOTjpBFFXWY6cDxTdf+It69lVzwENDCOMNiGLOvEJ4XTXaBCcrsA/9XivIkIPzbpCaus2t0c+Q9cAZSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527711; c=relaxed/simple;
	bh=epCBAMsrS+4nyms5pTA1WPFA1BEMtZwZjL0fQGfZv0s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQe4CRKFk77PK9Wzh1tF8F1Q9Zxt0TpS7UeS0QPXyIEMwrBVRHbGEnlWtY/SwPTNEuV3ZLkBmH39p3CXHSlZnXX0Z5J1z9FylQUx/qDe+PVWdU/uUn5xjWXUfXOOs0yQXiLjues82i2s2ydGT0tmuStkszSHlg61k2LzFGa1g1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1suWrr-000000004VK-3Rm6;
	Sat, 28 Sep 2024 12:48:11 +0000
Date: Sat, 28 Sep 2024 13:48:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Daniel Golle <daniel@makrotopia.org>,
	John Crispin <john@phrozen.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] mtd: ubi: add support for protecting critical volumes
Message-ID: <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>

Allow the boot firmware to define volumes which are critical for the
system to boot, such as the bootloader itself if stored inside a UBI
volume. Protect critical volumes by preventing the user from removing,
resizing or writing to them, and also prevent the UBI device from
being detached if a critical volume is present.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/build.c | 29 +++++++++++++++++++++++++++++
 drivers/mtd/ubi/cdev.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/mtd/ubi/ubi.h   |  1 +
 drivers/mtd/ubi/vmt.c   | 27 ++++++++++++++++++++++++++-
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 30be4ed68fad..7a96329c5fd9 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -314,6 +314,30 @@ struct ubi_device *ubi_get_by_major(int major)
 	return NULL;
 }
 
+/**
+ * ubi_device_got_critical_volume - check if device contains critical volume
+ * @ubi: UBI device description object
+ *
+ * This function checks if any volume on a given UBI device is critical.
+ *
+ * Context: Expects ubi_devices_lock to be held by caller.
+ * Returns: True if there is a critical volume, false otherwise.
+ */
+static bool ubi_device_got_critical_volume(struct ubi_device *ubi)
+{
+	int i;
+
+	for (i = 0; i < ubi->vtbl_slots; i++) {
+		if (!ubi->volumes[i])
+			continue;
+
+		if (ubi->volumes[i]->critical)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ubi_major2num - get UBI device number by character device major number.
  * @major: major number
@@ -1102,6 +1126,11 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 		return -EINVAL;
 
 	spin_lock(&ubi_devices_lock);
+	if (ubi_device_got_critical_volume(ubi)) {
+		spin_unlock(&ubi_devices_lock);
+		return -EPERM;
+	}
+
 	ubi->ref_count -= 1;
 	if (ubi->ref_count) {
 		if (!anyway) {
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index 0d8f04cf03c5..897791ebb71c 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -328,6 +328,9 @@ static ssize_t vol_cdev_write(struct file *file, const char __user *buf,
 	struct ubi_volume *vol = desc->vol;
 	struct ubi_device *ubi = vol->ubi;
 
+	if (vol->critical)
+		return -EPERM;
+
 	if (!vol->updating && !vol->changing_leb)
 		return vol_cdev_direct_write(file, buf, count, offp);
 
@@ -390,6 +393,11 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 	{
 		int64_t bytes, rsvd_bytes;
 
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+
 		if (!capable(CAP_SYS_RESOURCE)) {
 			err = -EPERM;
 			break;
@@ -430,6 +438,11 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 	{
 		struct ubi_leb_change_req req;
 
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+
 		err = copy_from_user(&req, argp,
 				     sizeof(struct ubi_leb_change_req));
 		if (err) {
@@ -464,6 +477,11 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 	{
 		int32_t lnum;
 
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+
 		err = get_user(lnum, (__user int32_t *)argp);
 		if (err) {
 			err = -EFAULT;
@@ -495,6 +513,11 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 	{
 		struct ubi_map_req req;
 
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+
 		err = copy_from_user(&req, argp, sizeof(struct ubi_map_req));
 		if (err) {
 			err = -EFAULT;
@@ -509,6 +532,11 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 	{
 		int32_t lnum;
 
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+
 		err = get_user(lnum, (__user int32_t *)argp);
 		if (err) {
 			err = -EFAULT;
@@ -537,6 +565,11 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 	{
 		struct ubi_set_vol_prop_req req;
 
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+
 		err = copy_from_user(&req, argp,
 				     sizeof(struct ubi_set_vol_prop_req));
 		if (err) {
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 1c9e874e8ede..21b8ce77426b 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -364,6 +364,7 @@ struct ubi_volume {
 	unsigned int updating:1;
 	unsigned int changing_leb:1;
 	unsigned int direct_writes:1;
+	unsigned int critical:1;
 
 #ifdef CONFIG_MTD_UBI_FASTMAP
 	unsigned long *checkmap;
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 5a3558bbb903..a16b84e009a1 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -370,6 +370,11 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
 		return -EROFS;
 
 	spin_lock(&ubi->volumes_lock);
+	if (vol->critical) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+
 	if (vol->ref_count > 1) {
 		/*
 		 * The volume is busy, probably someone is reading one of its
@@ -472,6 +477,12 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
 		return PTR_ERR(new_eba_tbl);
 
 	spin_lock(&ubi->volumes_lock);
+	if (vol->critical) {
+		spin_unlock(&ubi->volumes_lock);
+		err = -EPERM;
+		goto out_free;
+	}
+
 	if (vol->ref_count > 1) {
 		spin_unlock(&ubi->volumes_lock);
 		err = -EBUSY;
@@ -578,9 +589,22 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
  */
 int ubi_rename_volumes(struct ubi_device *ubi, struct list_head *rename_list)
 {
-	int err;
+	int err = 0;
 	struct ubi_rename_entry *re;
 
+	spin_lock(&ubi->volumes_lock);
+	list_for_each_entry(re, rename_list, list) {
+		struct ubi_volume *vol = re->desc->vol;
+
+		if (vol->critical) {
+			err = -EPERM;
+			break;
+		}
+	}
+	spin_unlock(&ubi->volumes_lock);
+	if (err)
+		return err;
+
 	err = ubi_vtbl_rename_volumes(ubi, rename_list);
 	if (err)
 		return err;
@@ -641,6 +665,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
 	vol->dev.groups = volume_dev_groups;
 	dev_set_name(&vol->dev, "%s_%d", ubi->ubi_name, vol->vol_id);
 	device_set_node(&vol->dev, find_volume_fwnode(vol));
+	vol->critical = device_property_read_bool(&vol->dev, "volume-is-critical");
 	err = device_register(&vol->dev);
 	if (err) {
 		cdev_del(&vol->cdev);
-- 
2.46.2

