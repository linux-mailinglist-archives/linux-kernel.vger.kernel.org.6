Return-Path: <linux-kernel+bounces-433740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5A9E5C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0D1675C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941521D593;
	Thu,  5 Dec 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c5ZnkAnk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E49224AF0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418068; cv=none; b=kkBqWO7Lpo5xwOuWvsM6f44cbQo7oYbN/FfMarI+Y7V39yMtpRHKUYNOjM89qUHdTLNyn0Z0r1C3n13IGePhRHjv5hBJ7BIRWeMzasBeGZOhSk207Pl4YLnat7B4m+Poop0dflM/BoStcdKkHr0wzZBRDJgBlWqQtrG9G/RskZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418068; c=relaxed/simple;
	bh=McknEERCRE1m1yiNcYR0qOrYhKq6Vg3/7W95O6K/8Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nLFzNE+m+DJ3fco1TkKNqAPupwirAWk+jWK1A+SAHX9GUGfYtiHA3z0DYsuSxWZ5teIaU6H5CzKvuu7v4fc9vd0PizC3Uej80vFJpe85pJX8hzHrfYtnoEknrBv+5CrSh8pb0r7p72u6hJPnmslu4RdmCZcfmyzQdjx6Q9BxfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c5ZnkAnk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733418063;
	bh=McknEERCRE1m1yiNcYR0qOrYhKq6Vg3/7W95O6K/8Bo=;
	h=From:Date:Subject:To:Cc:From;
	b=c5ZnkAnkh12h44cuNyAkWCzV94595DEMgCSUQ7q5i8/YlWvodysVRJVc/b4kFAqxn
	 U4LYbFWotQ4/dapvREVwV/QvD8fjHeNVCql59pO3uqCO874PU+BrdIwrvQitSNPKh/
	 /AZRE/qbT7OUUEYculg1/tFvtveAGYlNTi/Legvo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 18:01:00 +0100
Subject: [PATCH] nvmem: core: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-const-bin_attr-nvmem-v1-1-6e15f8bdc93f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEvcUWcC/x3MwQqDMAwA0F+RnA3Yauf0V0TEdVFzMI6myEbx3
 y07vstLoBSYFPoiQaCTlQ/JMGUBfptlJeR3NtjKNsZWBvWni6I/RCO+WKY5xoBy7rTj09jOtc7
 Xj44gB59AC3//+TBe1w2tUA01bAAAAA==
X-Change-ID: 20241201-sysfs-const-bin_attr-nvmem-8129575c369e
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733418062; l=4736;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=McknEERCRE1m1yiNcYR0qOrYhKq6Vg3/7W95O6K/8Bo=;
 b=aUzictRAtjsBt5SDdlYCuelMIS0MdcXUKgInzPqH337Y1f4M/bEbFCBL7JYR2LwpuEHIr58+G
 l6a3ims+hmWBvmBEDd0ksz6Ww2MVFXRMS92yEBUPOYhQZDYXiGnLvQi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Also adapt the dynamic sysfs cell logic to handle the const attributes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
The usage of read_new/write_new/bin_attrs_new is a transition mechanism
and will be reverted after the transition is complete.
---
 drivers/nvmem/core.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d6494dfc20a7324bde6415776dcabbb0bfdd334b..fd09f1a6917fe8a43cc7b112d3611b1e000c7c16 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -213,7 +213,7 @@ static struct attribute *nvmem_attrs[] = {
 };
 
 static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t pos, size_t count)
 {
 	struct device *dev;
@@ -246,7 +246,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr, char *buf,
+				    const struct bin_attribute *attr, char *buf,
 				    loff_t pos, size_t count)
 {
 	struct device *dev;
@@ -340,7 +340,7 @@ static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
 					    const char *id, int index);
 
 static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr, char *buf,
+				    const struct bin_attribute *attr, char *buf,
 				    loff_t pos, size_t count)
 {
 	struct nvmem_cell_entry *entry;
@@ -374,22 +374,22 @@ static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
 }
 
 /* default read/write permissions */
-static struct bin_attribute bin_attr_rw_nvmem = {
+static const struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
 		.mode	= 0644,
 	},
-	.read	= bin_attr_nvmem_read,
-	.write	= bin_attr_nvmem_write,
+	.read_new	= bin_attr_nvmem_read,
+	.write_new	= bin_attr_nvmem_write,
 };
 
-static struct bin_attribute *nvmem_bin_attributes[] = {
+static const struct bin_attribute *const nvmem_bin_attributes[] = {
 	&bin_attr_rw_nvmem,
 	NULL,
 };
 
 static const struct attribute_group nvmem_bin_group = {
-	.bin_attrs	= nvmem_bin_attributes,
+	.bin_attrs_new	= nvmem_bin_attributes,
 	.attrs		= nvmem_attrs,
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 	.bin_size	= nvmem_bin_attr_size,
@@ -401,12 +401,12 @@ static const struct attribute_group *nvmem_dev_groups[] = {
 	NULL,
 };
 
-static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
+static const struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
 		.name	= "eeprom",
 	},
-	.read	= bin_attr_nvmem_read,
-	.write	= bin_attr_nvmem_write,
+	.read_new	= bin_attr_nvmem_read,
+	.write_new	= bin_attr_nvmem_write,
 };
 
 /*
@@ -461,6 +461,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 		.name	= "cells",
 	};
 	struct nvmem_cell_entry *entry;
+	const struct bin_attribute **pattrs;
 	struct bin_attribute *attrs;
 	unsigned int ncells = 0, i = 0;
 	int ret = 0;
@@ -472,9 +473,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	/* Allocate an array of attributes with a sentinel */
 	ncells = list_count_nodes(&nvmem->cells);
-	group.bin_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
-				       sizeof(struct bin_attribute *), GFP_KERNEL);
-	if (!group.bin_attrs) {
+	pattrs = devm_kcalloc(&nvmem->dev, ncells + 1,
+			      sizeof(struct bin_attribute *), GFP_KERNEL);
+	if (!pattrs) {
 		ret = -ENOMEM;
 		goto unlock_mutex;
 	}
@@ -494,17 +495,19 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 						    entry->bit_offset);
 		attrs[i].attr.mode = 0444 & nvmem_bin_attr_get_umode(nvmem);
 		attrs[i].size = entry->bytes;
-		attrs[i].read = &nvmem_cell_attr_read;
+		attrs[i].read_new = &nvmem_cell_attr_read;
 		attrs[i].private = entry;
 		if (!attrs[i].attr.name) {
 			ret = -ENOMEM;
 			goto unlock_mutex;
 		}
 
-		group.bin_attrs[i] = &attrs[i];
+		pattrs[i] = &attrs[i];
 		i++;
 	}
 
+	group.bin_attrs_new = pattrs;
+
 	ret = device_add_group(&nvmem->dev, &group);
 	if (ret)
 		goto unlock_mutex;

---
base-commit: bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
change-id: 20241201-sysfs-const-bin_attr-nvmem-8129575c369e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


