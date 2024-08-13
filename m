Return-Path: <linux-kernel+bounces-284603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA69502FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA84B23C27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8A19ADA6;
	Tue, 13 Aug 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avpbTo0i"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130A19DF61
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546322; cv=none; b=i48dd70wXh7jDJK2nrn73ceeZkskGyL+jwHRIdrdUfom32xRwUOyexvIriLQxgQgFYfkZF9oD7wB78MKnxboi6C8sFaMBPsjgiKTQYFpbiEbmYsfvJ1IMI4ondwhukYeRzdNMM5dJHWc5PeDLm6vRKmrd+1AZaR2IuzEsxmvKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546322; c=relaxed/simple;
	bh=wQ9fK3i1zgDOfY60KeE9Yp2jW98FcB3ewz+H13D5rJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5Ky+ZA52E8cbEeNGMrDeemWJvzTUzhSzCNdCJpbSAk13ddIh++4/QKEQgiIimpBz5SRw/Jk+gqoe5BZfDqkyePnDblsn56Rz0UJGZHIANUIo+E+obFS6iyfYtbEu9cFQfd/qwxUNfRDv0n9r6KRoKTPC6wzhYlX6BcPhoRYGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avpbTo0i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso41139415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546317; x=1724151117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEJ3c0tbXkLCUVM8w2XGUoLlD36QVGf/XlmxenxbwBg=;
        b=avpbTo0i5L1CTNhHEKwn5KL+Mn7cIpQYTBumL0uiR4m3pY/SJs038R55Hl+WcQc2Fk
         ggK9qdILmtqINaYbVv8jmQ3+IYkX1My2Pzd4gtKOiGhLCJuGbmJQHacfef0tj6F4KEjt
         k94+agA0TECyVxIWHtj3gpx9Qj02cnBz+3LuOmga4xwllIfpRCOy884xDI4gx98fqEse
         RhZdYZOjbCnABc4Z2j/oQchLyg7R0+JwhCrlg/epcU2jSnop1AANDp6sgoEBVRe8ecJb
         pY5tqF6xB3UwyYBqcaIapwa2P0vX0yNN7jCg4KE6GWcyYIrG4L9fFwC/i+NRa6O/Iypd
         wXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546317; x=1724151117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEJ3c0tbXkLCUVM8w2XGUoLlD36QVGf/XlmxenxbwBg=;
        b=YHbjb/b78L8U+L3hprb+GDquNPu/EIwwZRBIGID8TS2hG2vhLEixRuZZ8SzHTRFEiO
         H28na9kAwjDuQbfE5irizM/9JguK7Z6JipCXUBCx3Pny8EhuCRg3wSdTuYyeN/r0IoJJ
         mXba8LEEimt6UrdPu0+qzpQOTSgZePXjiCO3o+iTPAI3tZ2yJu3gLzLm79yvSPDq6Ww+
         /2bUox/aYeoLWFHcIiOXXFpjT3OoT2vJqlD8i2nHzMkZGG+dLTARGVi1kf8UHpOdThN0
         MQIK3ExswmTIRbjLxbGRHjbhR1bVtZOJP+FwRingx93YsmGfWrHfNNTpK3WcmvMQGrQ4
         Tt3g==
X-Forwarded-Encrypted: i=1; AJvYcCW9+CH0XvKjCpGN5+AV2SlGWCxQNJ5Rw3tXM91AOZZkErUimfHg6hAFFlFqjGvsOm7uWiClNhEnHjKNc6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EcuEbtXfjTdgyNgkeevYJ0tXkGdYna9AhFrMwbe9W9dITqpJ
	6W/0pzDVHBOmLZShku6F0DmEUKFsf5p1vTqPTYhiVsZR1Fab/ede
X-Google-Smtp-Source: AGHT+IESV+wchjJ2FOAcWUm8UC3C3J1WBcWqWQE0yaBq8D5o1OiKaRZvZx0+aIIqhD8qLLziu5WRdw==
X-Received: by 2002:a05:600c:2909:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-429d4a5a815mr24149465e9.22.1723546316854;
        Tue, 13 Aug 2024 03:51:56 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:56 -0700 (PDT)
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
Subject: [RFC PATCH 15/17] drm/vkms: Allow to configure multiple planes via configfs
Date: Tue, 13 Aug 2024 12:44:26 +0200
Message-ID: <20240813105134.17439-16-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes to allow to create as
many overlay planes as required. When the plane is created the
possible_crtcs subgroup is created allowing to link planes and CRTCs.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  13 ++-
 drivers/gpu/drm/vkms/vkms_config.h   |   3 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 121 +++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index b6ceb8c48310..ee71d1a569dd 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -78,7 +78,8 @@ And directories are created for each configurable item of the display pipeline::
     ├── connectors
     ├── crtcs
     ├── enabled
-    └── encoders
+    ├── encoders
+    └── planes
 
 To add items to the display pipeline, create one or more directories under the
 available paths.
@@ -111,6 +112,14 @@ linked to encoders by creating a symbolic link under ``possible_encoders``::
 
   sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
 
+Finally, create zero or more overlay planes::
+
+  sudo mkdir /config/vkms/my-vkms/planes/plane0
+
+And link them with their ``possible_crtcs``::
+
+  sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -128,6 +137,8 @@ Or removing the top level directory and its subdirectories::
   sudo rmdir /config/vkms/my-vkms/connectors/*
   sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
+  sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
+  sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index cf45e3f6ae92..2ec08bb58ec4 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -14,6 +14,9 @@ struct vkms_device;
 struct vkms_config_plane {
 	struct list_head list;
 	uint32_t possible_crtcs;
+	/* only used if created from configfs */
+	struct config_group plane_group;
+	struct config_group possible_crtcs_group;
 };
 
 struct vkms_config_crtc {
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index d2369f53e2d8..0b5ac0767da0 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -23,6 +23,8 @@ static bool is_configfs_registered;
  * "/config/vkms/encoders". Each of its items represent a encoder
  * @connectors_group: Default subgroup of @device_group at
  * "/config/vkms/connectors". Each of its items represent a connector
+ * @planes_group: Default subgroup of @device_group at "/config/vkms/planes".
+ * Each of its items represent an overlay plane
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @enabled: Protected by @lock. The device is created or destroyed when this
  * option changes
@@ -33,6 +35,7 @@ struct vkms_configfs {
 	struct config_group crtcs_group;
 	struct config_group encoders_group;
 	struct config_group connectors_group;
+	struct config_group planes_group;
 
 	/* protected by @lock */
 	struct mutex lock;
@@ -72,6 +75,15 @@ struct vkms_configfs {
 #define connector_possible_encoders_item_to_vkms_config_connector(item) \
 	container_of(to_config_group(item), struct vkms_config_connector, possible_encoders_group)
 
+#define planes_group_to_vkms_configfs(group) \
+	container_of(group, struct vkms_configfs, planes_group)
+
+#define planes_item_to_vkms_config_plane(item) \
+	container_of(to_config_group(item), struct vkms_config_plane, plane_group)
+
+#define plane_possible_crtcs_item_to_vkms_config_plane(item) \
+	container_of(to_config_group(item), struct vkms_config_plane, possible_crtcs_group)
+
 static ssize_t crtc_cursor_show(struct config_item *item, char *page)
 {
 	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
@@ -450,6 +462,110 @@ static struct config_item_type connectors_group_type = {
 	.ct_owner = THIS_MODULE,
 };
 
+static int plane_possible_crtcs_allow_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+
+	if (target->ci_type != &crtc_group_type)
+		return -EINVAL;
+
+	plane_cfg = plane_possible_crtcs_item_to_vkms_config_plane(src);
+	crtc_cfg = crtcs_item_to_vkms_config_crtc(target);
+
+	if (plane_cfg->possible_crtcs & BIT(crtc_cfg->index))
+		return -EINVAL;
+
+	plane_cfg->possible_crtcs |= BIT(crtc_cfg->index);
+
+	return 0;
+}
+
+static void plane_possible_crtcs_drop_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+
+	plane_cfg = plane_possible_crtcs_item_to_vkms_config_plane(src);
+	crtc_cfg = crtcs_item_to_vkms_config_crtc(target);
+
+	plane_cfg->possible_crtcs &= ~BIT(crtc_cfg->index);
+}
+
+static struct configfs_item_operations plane_possible_crtcs_item_ops = {
+	.allow_link = &plane_possible_crtcs_allow_link,
+	.drop_link = &plane_possible_crtcs_drop_link,
+};
+
+static struct config_item_type plane_possible_crtcs_group_type = {
+	.ct_item_ops = &plane_possible_crtcs_item_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static const struct config_item_type plane_group_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_group *make_planes_group(struct config_group *group,
+					      const char *name)
+{
+	struct vkms_configfs *configfs = planes_group_to_vkms_configfs(group);
+	struct vkms_config_plane *plane_cfg;
+	int ret;
+
+	mutex_lock(&configfs->lock);
+
+	if (configfs->enabled) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	plane_cfg = vkms_config_add_overlay_plane(configfs->vkms_config, 0);
+	if (IS_ERR(plane_cfg)) {
+		ret = PTR_ERR(plane_cfg);
+		goto err_unlock;
+	}
+
+	config_group_init_type_name(&plane_cfg->plane_group, name,
+				    &plane_group_type);
+
+	config_group_init_type_name(&plane_cfg->possible_crtcs_group,
+				    "possible_crtcs",
+				    &plane_possible_crtcs_group_type);
+	configfs_add_default_group(&plane_cfg->possible_crtcs_group,
+				   &plane_cfg->plane_group);
+
+	mutex_unlock(&configfs->lock);
+
+	return &plane_cfg->plane_group;
+
+err_unlock:
+	mutex_unlock(&configfs->lock);
+	return ERR_PTR(ret);
+}
+
+static void drop_planes_group(struct config_group *group,
+			      struct config_item *item)
+{
+	struct vkms_configfs *configfs = planes_group_to_vkms_configfs(group);
+	struct vkms_config_plane *plane_cfg =
+		planes_item_to_vkms_config_plane(item);
+
+	vkms_config_destroy_overlay_plane(configfs->vkms_config, plane_cfg);
+}
+
+static struct configfs_group_operations planes_group_ops = {
+	.make_group = &make_planes_group,
+	.drop_item = &drop_planes_group,
+};
+
+static struct config_item_type planes_group_type = {
+	.ct_group_ops = &planes_group_ops,
+	.ct_owner = THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs *configfs = config_item_to_vkms_configfs(item);
@@ -538,6 +654,11 @@ static struct config_group *make_device_group(struct config_group *group,
 	configfs_add_default_group(&configfs->connectors_group,
 				   &configfs->device_group);
 
+	config_group_init_type_name(&configfs->planes_group, "planes",
+				    &planes_group_type);
+	configfs_add_default_group(&configfs->planes_group,
+				   &configfs->device_group);
+
 	return &configfs->device_group;
 }
 
-- 
2.46.0


