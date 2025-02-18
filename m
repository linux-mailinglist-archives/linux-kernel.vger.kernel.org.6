Return-Path: <linux-kernel+bounces-519929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAF8A3A3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A71C1727DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84D272914;
	Tue, 18 Feb 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMWNTHm8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4027128D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898509; cv=none; b=hwDBAWmUSb139NNkQFZLYKM4/EEt3XC5ToZcF2XoOKHjm668EqFE+/jJI/kMW2KBZblsBmSH3acuPqdJjDqu3pvovPKCBuq+QiPxFoGXOYI/fbde+gcsYTLYUDlaYRF0yJFSlQXzW1ZCCzgdruK9Da39Bw9McV5nkjOhgi/BMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898509; c=relaxed/simple;
	bh=JBwCjJfnIIBAwOswG8u5BqWTr2aTuoJehl8qwiIRm2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDvDdsdy+Ife+fE2mak9UA7qk+C+DTKF2A4EGC8eD2ycK/V5tR3bLC1Mnn5biPVq6FTkxYEuVAnDUMH3rehdjiS15CY4ttNHgr4U+PSZrwS4nnlF9bWh/RLinYHXDFarXAQocPjKW9vI4Ok7uzd59oZcqTdq4iKdW3+ORUnWfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMWNTHm8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439946a49e1so6934535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898505; x=1740503305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve8gYYXgy7/64VPreNjA6gL3Ezxa0nJl8754eZoTxPM=;
        b=LMWNTHm8O9aY0NWkxRFvxd0jPXmX+DAVg6YQ/KOfcToHqTfIIByvwCz9lHmpjbG1Pt
         mrPY0CxdXYgVrNdGu4RpZ9e8h13VlpnKA5Tx/1apU5XY6PhW3AniFwZnQaj9ySpYWd0f
         IijgsL9ywIGAmbwGuaFEpwWb399XtVBCu/fhh9Lfp7howE822xraOS989is5qZFS1tB2
         nANKDYd9eWOT/KU+ueOEu54t0Bq3GLRWsA9tjJPYHkhRhoavOdbC6BYs0M9QiQ38/NAf
         4m67msLHPDgmRYy0MMtO6oyDqkAC+hu+Odc6O0tVSoFUzwYShva8tU12SqdVtwsqlJWR
         tujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898505; x=1740503305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve8gYYXgy7/64VPreNjA6gL3Ezxa0nJl8754eZoTxPM=;
        b=DXJVqKUSDkxq+wk1y6rmTHnurLOiS65qCV1nPlRME5W0+6oB9IYYBUdY76/bsbj5B4
         KsXHoL10VuUYzp4ON3NFAnkuBMJfxsgd+u8iV2qLG+/8Hv711Nr8kLtCvp8tAL2q1Td+
         qRuhymVkx335XhvJgFXVLb0HwCDf20wEqI0sqrnOOtwRPbhS74R5K1oG7703OfXOoSv6
         wLLvWtiXVOIVxuq7MiGEHKgble+x9kTascu7fHHgNovI7IQn/PTFrHRlfGktM3cqEG05
         ugkMJ9FtqLRnooufJnYuvjox6ZrZ+nCrXkMbebRxP94d1rl7kLDB/VeDQ98fjKUCIoPu
         qaBw==
X-Forwarded-Encrypted: i=1; AJvYcCU22IhOm7tUxEBqf0vQLx+QEvdCIiwUVEuHHtuX+ztFEB19rH0ZT28JeJWgrCxpT2TJg7W2uhAcFCUSN0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDrYOU9PkxQbqzN/BFbvhtvNcPVBuz9iNM2pJpgzqy2QfRx8X
	b9ZFj7sgTNGMjy6sau63MRhqz5xBp00lEJKH/s8IK6uZK1e1+5x+OfE+YLez
X-Gm-Gg: ASbGncvROr/qoBXiYpm9npDGbuleeMzc8fbSZz/PElcXlLmaepOIvbnP8bmskBrMqPT
	sdyNJ2CEJ/lzZhRjXwpku/Bzk/Np9c4hRAicxfIn05AIsX48D3EGoyptR4RnG1aK8GiMCKy91kd
	ORFh4jDFOeTSuZDvUnrSx3F3cRcaEj6zMrdQF9QNA65dgBgBOePQ1NzZ10vI7mKo0dhCzLKWPhB
	sfgFLIccyI3OvdgKE5Uifi1p20uU6M3d1yCaoOIAP6hy0P58ylpA/lgEP7go+VI3+Ex+/J8EEtW
	2GAh0tIm/NrfNKOVgg==
X-Google-Smtp-Source: AGHT+IGmly+ynTiNsVzHpyu5bN60h1mqH3TEwz4cVT9xPOFUwl9vP/Rmkjriv0H/tD9iti+dt9LUDQ==
X-Received: by 2002:a05:600c:354c:b0:439:9951:1220 with SMTP id 5b1f17b1804b1-43999da7d5emr4465085e9.13.1739898505333;
        Tue, 18 Feb 2025 09:08:25 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:24 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 10/16] drm/vkms: Allow to configure multiple connectors via configfs
Date: Tue, 18 Feb 2025 18:08:02 +0100
Message-ID: <20250218170808.9507-11-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a default subgroup at
/config/vkms/connectors to allow to create as many connectors as
required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |   6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 100 +++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 6a15af0b7317..3dd55c3e8900 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── connectors
   ├── crtcs
   ├── enabled
   ├── encoders
@@ -102,6 +103,10 @@ Next, create one or more encoders::
 
   sudo mkdir /config/vkms/my-vkms/encoders/encoder0
 
+Last but not least, create one or more connectors::
+
+  sudo mkdir /config/vkms/my-vkms/connectors/connector0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -126,6 +131,7 @@ And removing the top level directory and its subdirectories::
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
+  sudo rmdir /config/vkms/my-vkms/connectors/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 66c8a66f7b2b..cd8a164bda3d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -18,6 +18,7 @@ static bool is_configfs_registered;
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
+ * @connectors_group: Default subgroup of @group at "/config/vkms/connectors"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -28,6 +29,7 @@ struct vkms_configfs_device {
 	struct config_group planes_group;
 	struct config_group crtcs_group;
 	struct config_group encoders_group;
+	struct config_group connectors_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -80,6 +82,20 @@ struct vkms_configfs_encoder {
 	struct vkms_config_encoder *config;
 };
 
+/**
+ * struct vkms_configfs_connector - Configfs representation of a connector
+ *
+ * @group: Top level configuration group that represents a connector.
+ * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @dev: The vkms_configfs_device this connector belongs to
+ * @config: Configuration of the VKMS connector
+ */
+struct vkms_configfs_connector {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_connector *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -105,6 +121,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     possible_crtcs_group)
 
+#define connector_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -540,6 +560,82 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void connector_release(struct config_item *item)
+{
+	struct vkms_configfs_connector *connector;
+	struct mutex *lock;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	lock = &connector->dev->lock;
+
+	mutex_lock(lock);
+	vkms_config_destroy_connector(connector->config);
+	kfree(connector);
+	mutex_unlock(lock);
+}
+
+static struct configfs_item_operations connector_item_operations = {
+	.release	= &connector_release,
+};
+
+static const struct config_item_type connector_item_type = {
+	.ct_item_ops	= &connector_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_connector_group(struct config_group *group,
+						 const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_connector *connector;
+	int ret;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	mutex_lock(&dev->lock);
+
+	if (dev->enabled) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	connector = kzalloc(sizeof(*connector), GFP_KERNEL);
+	if (!connector) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	connector->dev = dev;
+
+	connector->config = vkms_config_create_connector(dev->config);
+	if (IS_ERR(connector->config)) {
+		ret = PTR_ERR(connector->config);
+		goto err_free;
+	}
+
+	config_group_init_type_name(&connector->group, name,
+				    &connector_item_type);
+
+	mutex_unlock(&dev->lock);
+
+	return &connector->group;
+
+err_free:
+	kfree(connector);
+err_unlock:
+	mutex_unlock(&dev->lock);
+	return ERR_PTR(ret);
+}
+
+static struct configfs_group_operations connectors_group_operations = {
+	.make_group	= &make_connector_group,
+};
+
+static const struct config_item_type connector_group_type = {
+	.ct_group_ops	= &connectors_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -657,6 +753,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &encoder_group_type);
 	configfs_add_default_group(&dev->encoders_group, &dev->group);
 
+	config_group_init_type_name(&dev->connectors_group, "connectors",
+				    &connector_group_type);
+	configfs_add_default_group(&dev->connectors_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


