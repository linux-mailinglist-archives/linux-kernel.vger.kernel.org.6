Return-Path: <linux-kernel+bounces-284599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D59502F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A332875C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10C19DF5B;
	Tue, 13 Aug 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He8OWeEC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89E19D09B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546316; cv=none; b=BxE3D2lT36lRge+zfVGjEz1yLIO40YYXjf/1JyjszrDKRJwK3WPDJdbl20q/SE9HpQfGR799C4g4wT23aSC0rmJGRhAp4jXDUn9Cm5zlFUmXrjr/oGqWFbn/PJjbE1whZ7r0IX2QoXBu8p0cg2WKQdhwJFJ17xQG6VRGtocARsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546316; c=relaxed/simple;
	bh=YtSIWGW8LIFIsjcCZmIZ8UbzAbnVZGqRMTNplMa0an8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI54KmqG/Xiiul0ChrwrX9/Yh1TmgkLT+wOTJDxF3IY1fVpeOJIZ1wn54TCYDlxyJDAaFHN2QaQvYWEeZ/i8ZyWkK7s4ZTepg1x3hEIYQ8DHQZpLGceY+HhLuP5i05YYXMuMWOieUYWfKu9fyXUIYnMeT3dcKLQIjSeI/a0/V4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He8OWeEC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca797fso39301575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546313; x=1724151113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVBRH0DnuLVDwokIb7HrZrE7ZLWioaYtKcu7A5ZTgas=;
        b=He8OWeECEXbJ5WOASkrPMSnJx7fH8zP+dw3B4njcXehYhgMmbdU9eeTn5KofDseSdk
         HGsJ+zVm//tiimOlyDa3slG4gY2nBqJvx2c6DL5nDkI/1fpCjDSibVmum/Uzxg/xoBXF
         xpU53Ndq0yb2b5S3kqtEkXHqxfxdxsH7BCFRw3rJ6GWU7I9ostbvesTExAw9CjQr4jwW
         Lh/N5UaabKRZ1hnuPZ2NflHrWph5ucOdG7ZHzdf48AgajlJCkRABkILrWEz/mLx4XnNj
         pmlzcFYvWB6opYN7zqSZz0Ba6pu6O0khMzycRudSBiMpAoWhBrhVvI7K3nhuXzSU28rF
         U6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546313; x=1724151113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVBRH0DnuLVDwokIb7HrZrE7ZLWioaYtKcu7A5ZTgas=;
        b=nyqrhpUQ4zCLR6FDTZUnjaRpH5PKC1SfSnMwVgagwspvb9m13s+32HyYNZA31f23S0
         GtcsHkh/npHTAWjsFGE4QddzeBUfeAVhcp4gJXDzyAJgOBYQWy5+gcJoBwZtjC4qnodN
         zvSOKsdkaLEWG4dPfV63zZbv/n1vqJOHhgqpLy4GzQx/GYh/euitjqR12JeUNq9aRFBS
         4k3FF/iz8jH/XLHU3EavYsQS43USCBL/MyPLn9v3fdfLqPEq3okumXs+Kn/RhoPRBso3
         7HcYNd+vAPA7JlZN+nBUKhjXSg7bbfgy5DrwW7Cvps15xDd2606Wdky5D3NHSRmbmDbW
         CC9g==
X-Forwarded-Encrypted: i=1; AJvYcCX3XDvAObVzpunHsPLSuszENSIrcH1Um+F8q2FbsHJW34+byjT76UVmU24Rc5qmq3gYuYVEpHxs3s6/8DJw0ElqWkZ2Lu6ZMnHtC9Lj
X-Gm-Message-State: AOJu0YykzMfT5QjMIaJ4C3TKUEOaUDPaqpmllLF9Xba0kaEtssh/6KFI
	yN1dLpHfSustOJrMB1/UqcLYC4S6BRtvHlIAe0pubg8/HfCARIwZ
X-Google-Smtp-Source: AGHT+IGx0zK/ifNLLcqjgImibQLg2NAxwokcq14IJSh6ZqPBkiUD5RKQjid95Vj2DBXdcE20rEuz4A==
X-Received: by 2002:a05:600c:3b1f:b0:427:ffa4:32d0 with SMTP id 5b1f17b1804b1-429d48711f6mr24333315e9.28.1723546313053;
        Tue, 13 Aug 2024 03:51:53 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:52 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 12/17] drm/vkms: Allow to configure multiple CRTCs via configfs
Date: Tue, 13 Aug 2024 12:44:23 +0200
Message-ID: <20240813105134.17439-13-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813105134.17439-1-jose.exposito89@gmail.com>
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a default subgroup at /config/vkms/crtcs to allow to create as
many CRTCs as required. When a CRTC is created, allow to configure the
equivalent of the module parameters enable_cursor and enable_writeback.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  22 +++-
 drivers/gpu/drm/vkms/vkms_config.h   |   3 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 149 +++++++++++++++++++++++++--
 3 files changed, 166 insertions(+), 8 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 9895a9ae76f4..0886349ad4a0 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -71,6 +71,25 @@ By default, the instance is disabled::
   cat /config/vkms/my-vkms/enabled
   0
 
+And directories are created for each configurable item of the display pipeline::
+
+  tree /config/vkms/my-vkms
+    /config/vkms/my-vkms
+    ├── crtcs
+    └── enabled
+
+To add items to the display pipeline, create one or more directories under the
+available paths.
+
+Start by creating one or more CRTCs::
+
+  sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
+
+CRTCs have 2 configurable attributes:
+
+- cursor: Enable or disable cursor plane support
+- writeback: Enable or disable writeback connector support
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -79,8 +98,9 @@ Finally, you can remove the VKMS instance disabling it::
 
   echo "0" | sudo tee /config/vkms/my-vkms/enabled
 
-Or removing the top level directory::
+Or removing the top level directory and its subdirectories::
 
+  sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 3237406fa3a3..f96a0456a3d7 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -3,6 +3,7 @@
 #ifndef _VKMS_CONFIG_H_
 #define _VKMS_CONFIG_H_
 
+#include <linux/configfs.h>
 #include <linux/list.h>
 #include <linux/types.h>
 
@@ -20,6 +21,8 @@ struct vkms_config_crtc {
 	unsigned int index;
 	bool cursor;
 	bool writeback;
+	/* only used if created from configfs */
+	struct config_group crtc_group;
 };
 
 struct vkms_config_encoder {
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 3f25295f7788..04278a39cd3c 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -17,6 +17,8 @@ static bool is_configfs_registered;
  * @vkms_config: Configuration of the VKMS device
  * @device_group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
+ * @crtcs_group: Default subgroup of @device_group at "/config/vkms/crtcs".
+ * Each of its items represent a CRTC
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @enabled: Protected by @lock. The device is created or destroyed when this
  * option changes
@@ -24,6 +26,7 @@ static bool is_configfs_registered;
 struct vkms_configfs {
 	struct vkms_config *vkms_config;
 	struct config_group device_group;
+	struct config_group crtcs_group;
 
 	/* protected by @lock */
 	struct mutex lock;
@@ -33,6 +36,141 @@ struct vkms_configfs {
 #define config_item_to_vkms_configfs(item) \
 	container_of(to_config_group(item), struct vkms_configfs, device_group)
 
+#define crtcs_group_to_vkms_configfs(group) \
+	container_of(group, struct vkms_configfs, crtcs_group)
+
+#define crtcs_item_to_vkms_configfs(item) \
+	container_of(to_config_group(item), struct vkms_configfs, crtcs_group)
+
+#define crtcs_item_to_vkms_config_crtc(item) \
+	container_of(to_config_group(item), struct vkms_config_crtc, crtc_group)
+
+static ssize_t crtc_cursor_show(struct config_item *item, char *page)
+{
+	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
+
+	return sprintf(page, "%d\n", crtc_cfg->cursor);
+}
+
+static ssize_t crtc_cursor_store(struct config_item *item, const char *page,
+				 size_t count)
+{
+	struct vkms_configfs *configfs = crtcs_item_to_vkms_configfs(item->ci_parent);
+	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
+	bool cursor;
+
+	if (kstrtobool(page, &cursor))
+		return -EINVAL;
+
+	mutex_lock(&configfs->lock);
+
+	if (configfs->enabled) {
+		mutex_unlock(&configfs->lock);
+		return -EINVAL;
+	}
+
+	crtc_cfg->cursor = cursor;
+
+	mutex_unlock(&configfs->lock);
+
+	return (ssize_t)count;
+}
+
+static ssize_t crtc_writeback_show(struct config_item *item, char *page)
+{
+	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
+
+	return sprintf(page, "%d\n", crtc_cfg->writeback);
+}
+
+static ssize_t crtc_writeback_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs *configfs = crtcs_item_to_vkms_configfs(item->ci_parent);
+	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
+	bool writeback;
+
+	if (kstrtobool(page, &writeback))
+		return -EINVAL;
+
+	mutex_lock(&configfs->lock);
+
+	if (configfs->enabled) {
+		mutex_unlock(&configfs->lock);
+		return -EINVAL;
+	}
+
+	crtc_cfg->writeback = writeback;
+
+	mutex_unlock(&configfs->lock);
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(crtc_, cursor);
+CONFIGFS_ATTR(crtc_, writeback);
+
+static struct configfs_attribute *crtc_group_attrs[] = {
+	&crtc_attr_cursor,
+	&crtc_attr_writeback,
+	NULL,
+};
+
+static const struct config_item_type crtc_group_type = {
+	.ct_attrs = crtc_group_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_group *make_crtcs_group(struct config_group *group,
+					     const char *name)
+{
+	struct vkms_configfs *configfs = crtcs_group_to_vkms_configfs(group);
+	struct vkms_config_crtc *crtc_cfg;
+	int ret;
+
+	mutex_lock(&configfs->lock);
+
+	if (configfs->enabled) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	crtc_cfg = vkms_config_add_crtc(configfs->vkms_config, false, false);
+	if (IS_ERR(crtc_cfg)) {
+		ret = PTR_ERR(crtc_cfg);
+		goto err_unlock;
+	}
+
+	config_group_init_type_name(&crtc_cfg->crtc_group, name, &crtc_group_type);
+
+	mutex_unlock(&configfs->lock);
+
+	return &crtc_cfg->crtc_group;
+
+err_unlock:
+	mutex_unlock(&configfs->lock);
+	return ERR_PTR(ret);
+}
+
+static void drop_crtcs_group(struct config_group *group,
+			     struct config_item *item)
+{
+	struct vkms_configfs *configfs = crtcs_group_to_vkms_configfs(group);
+	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
+
+	vkms_config_destroy_crtc(configfs->vkms_config, crtc_cfg);
+}
+
+static struct configfs_group_operations crtcs_group_ops = {
+	.make_group = &make_crtcs_group,
+	.drop_item = &drop_crtcs_group,
+};
+
+static struct config_item_type crtcs_group_type = {
+	.ct_group_ops = &crtcs_group_ops,
+	.ct_owner = THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs *configfs = config_item_to_vkms_configfs(item);
@@ -87,7 +225,6 @@ static struct config_group *make_device_group(struct config_group *group,
 					      const char *name)
 {
 	struct vkms_configfs *configfs;
-	struct vkms_config_crtc *crtc_cfg = NULL;
 	struct vkms_config_encoder *encoder_cfg = NULL;
 	struct vkms_config_connector *connector_cfg = NULL;
 	char *config_name;
@@ -110,11 +247,10 @@ static struct config_group *make_device_group(struct config_group *group,
 		goto err_kfree;
 	}
 
-	crtc_cfg = vkms_config_add_crtc(configfs->vkms_config, false, false);
-	if (IS_ERR(crtc_cfg)) {
-		ret = PTR_ERR(crtc_cfg);
-		goto err_kfree;
-	}
+	config_group_init_type_name(&configfs->crtcs_group, "crtcs",
+				    &crtcs_group_type);
+	configfs_add_default_group(&configfs->crtcs_group,
+				   &configfs->device_group);
 
 	encoder_cfg = vkms_config_add_encoder(configfs->vkms_config, BIT(0));
 	if (IS_ERR(encoder_cfg)) {
@@ -133,7 +269,6 @@ static struct config_group *make_device_group(struct config_group *group,
 
 err_kfree:
 	kfree(configfs);
-	kfree(crtc_cfg);
 	kfree(encoder_cfg);
 	kfree(connector_cfg);
 	return ERR_PTR(ret);
-- 
2.46.0


