Return-Path: <linux-kernel+bounces-284596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96E9502F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7849B1C2218F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DD19D880;
	Tue, 13 Aug 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQGCS6Od"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1CD19CD11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546313; cv=none; b=QCJMjGRI5+HnbkWqtXq9pF9rzKsgW5uV1EIx204frFG+/1Q9Bd2QvUVDB7H4cTCjClHfAt1nVzGnYjKs4B73mrXwEa01XwH6eXw4TGug0vVrww7GTqJGu50jeEbmow7iWKI6+Rz69p3QFPDzaU/tJ2ezgIXoJBKJVtyv4fUwf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546313; c=relaxed/simple;
	bh=y8C3C2ZCJMCiMbmIKhokCQgGEDGU78NAvmVul8hoE0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryKLGs6WzkBZnlOYaSI0289w3eiMpRqwh00v4/HKn0AtUBwKkaZCil+NH08zCCOg0Lfjkj5z5o0M+ktO2SoNbSCVJDjdRPFIqjRFwJp0EB0T+oVt1LiR9Uk0ae4jKo0aLsXud8izPiEp7SU25XlxMCCvot/8u+4ipe3ktra/0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQGCS6Od; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e3129851so39287905e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546310; x=1724151110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMbXv874dHtsCrZeML3BpyopJo288L3/apBZJHbVOhk=;
        b=HQGCS6OduYqYD+z33BsjozuhsvmfHxRGYK/Hyspu7hEViDAPDTgU6bHNczypuhyaD4
         w/tfMUUmka/KOK8RMYlzpDP2CGyHDTFll+/lQ5M/TCdiuiyZmZAj2+UsSYxDWgJcPjwm
         qFKNBAZTwQ5sSSeSHQ9f0WaMDtT/kabsFLfgO2WEiI3jHVnUmRD1Xw21ctGgU+n+aIF9
         53CaeO0kZz/P9KZnvs8h0wWtRtJd+ARw02eQZE0TGWoTfrFK0VRkxXQFOPIAHBV+sMuc
         EQ/aPVKPCx9RxEI8JH/tF9+gm9sZE8Ub6DCpawEi+Os7ckEXLOSZlrJ3cb2KlxNIhuLl
         S5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546310; x=1724151110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMbXv874dHtsCrZeML3BpyopJo288L3/apBZJHbVOhk=;
        b=wOb8n/cTR63vCrop1WDDgJFsZhUjS9zhBefDLmE8EQq66Z7JeRfIZMjeuxVRoFVHHe
         FbMl0uF9B5CQy+8fpTA5EjsKjjlD/vf2NEf2hnoJmhew55r1zvxh1hROQAHBvXRahVlM
         Z3jwg+bpu7edCVZ+oYF+uhByQm2Vem8SX4zgm8YYs9/uYJpcc1RSJdmx4BPBr6KsfjRk
         CcWp7cRAc/EFNBeCubRIfUe2XSWHCTXbA/n0GWdYhUpriCM9YrFftNMuJ4GqwIqyahw9
         vYfmy8DQGnE79uxDvS7jRYJrs15petG6ZardpieiLGkQNipqv3kUw4UP27Dw+UBRVnpH
         grxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrKLkhnTay5tFBisW01Qe5DQv8d6yZZynHCCgqrRCcVpA9WJ1WSfonAdSAWBwzsG9TJGhd39A6ybSiyQocAVKpQr7ZyjKNTKuseTw3
X-Gm-Message-State: AOJu0YxIvUe62ebNvjdJOBKtWMznjyDD77rYqOMns7sI2XDN1HgVdnow
	7kk5NM1KzJnMuJecRrtc7KEzwsbb7/l9smSRdhhaMgeB33uAv9gL
X-Google-Smtp-Source: AGHT+IFOCeWvoZuGjI44xpEIh5rro/qgNHo4B3FX450VGqDCj0qY+tfMZ7moOEUZum//780E8hV+lw==
X-Received: by 2002:a05:600c:4f53:b0:426:6d1a:d497 with SMTP id 5b1f17b1804b1-429d480dcb2mr19574965e9.12.1723546309738;
        Tue, 13 Aug 2024 03:51:49 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:49 -0700 (PDT)
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
Subject: [RFC PATCH 09/17] drm/vkms: Allow to configure multiple overlay planes
Date: Tue, 13 Aug 2024 12:44:20 +0200
Message-ID: <20240813105134.17439-10-jose.exposito89@gmail.com>
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

Add a list of overlay planes to vkms_config and add as many overlay
planes as configured during output initialization.

For backwards compatibility, add NUM_OVERLAY_PLANES to the default
configuration.

Note that a primary plane is created for each CRTC and it is not
possible to configure it.
A cursor plane is added conditionally if it is enabled in the CRTC
configuration.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 53 +++++++++++++++++++++++++++---
 drivers/gpu/drm/vkms/vkms_config.h | 16 +++++++--
 drivers/gpu/drm/vkms/vkms_drv.c    |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.h    |  5 +--
 drivers/gpu/drm/vkms/vkms_output.c | 43 ++++++++++++------------
 drivers/gpu/drm/vkms/vkms_plane.c  |  6 ++--
 6 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index a456f9db3c66..d95a42a6745a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -17,6 +17,7 @@ struct vkms_config *vkms_config_create(char *dev_name)
 		return ERR_PTR(-ENOMEM);
 
 	config->dev_name = dev_name;
+	config->planes = (struct list_head)LIST_HEAD_INIT(config->planes);
 	config->crtcs = (struct list_head)LIST_HEAD_INIT(config->crtcs);
 	config->encoders = (struct list_head)LIST_HEAD_INIT(config->encoders);
 	config->connectors = (struct list_head)LIST_HEAD_INIT(config->connectors);
@@ -32,15 +33,22 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
 	struct vkms_config_connector *connector_cfg;
+	struct vkms_config_plane *plane_cfg;
+	int n;
 
 	config = vkms_config_create(DEFAULT_DEVICE_NAME);
 	if (IS_ERR(config))
 		return config;
 
-	config->cursor = enable_cursor;
-	config->overlay = enable_overlay;
+	if (enable_overlay) {
+		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
+			plane_cfg = vkms_config_add_overlay_plane(config, BIT(0));
+			if (IS_ERR(plane_cfg))
+				return ERR_CAST(plane_cfg);
+		}
+	}
 
-	crtc_cfg = vkms_config_add_crtc(config, enable_writeback);
+	crtc_cfg = vkms_config_add_crtc(config, enable_cursor, enable_writeback);
 	if (IS_ERR(crtc_cfg))
 		return ERR_CAST(crtc_cfg);
 
@@ -57,10 +65,14 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 
 void vkms_config_destroy(struct vkms_config *config)
 {
+	struct vkms_config_plane *plane_cfg, *plane_tmp;
 	struct vkms_config_crtc *crtc_cfg, *crtc_tmp;
 	struct vkms_config_encoder *encoder_cfg, *encoder_tmp;
 	struct vkms_config_connector *connector_cfg, *connector_tmp;
 
+	list_for_each_entry_safe(plane_cfg, plane_tmp, &config->planes, list)
+		vkms_config_destroy_overlay_plane(config, plane_cfg);
+
 	list_for_each_entry_safe(crtc_cfg, crtc_tmp, &config->crtcs, list)
 		vkms_config_destroy_crtc(config, crtc_cfg);
 
@@ -78,17 +90,24 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_debugfs_entry *entry = m->private;
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
 	struct vkms_config_connector *connector_cfg;
 	int n;
 
 	seq_printf(m, "dev_name=%s\n", vkmsdev->config->dev_name);
-	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
-	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+
+	n = 0;
+	list_for_each_entry(plane_cfg, &vkmsdev->config->planes, list) {
+		seq_printf(m, "plane(%d).possible_crtcs=%d\n", n,
+			   plane_cfg->possible_crtcs);
+		n++;
+	}
 
 	n = 0;
 	list_for_each_entry(crtc_cfg, &vkmsdev->config->crtcs, list) {
+		seq_printf(m, "crtc(%d).cursor=%d\n", n, crtc_cfg->cursor);
 		seq_printf(m, "crtc(%d).writeback=%d\n", n,
 			   crtc_cfg->writeback);
 		n++;
@@ -121,7 +140,30 @@ void vkms_config_debugfs_init(struct vkms_device *vkms_device)
 			      ARRAY_SIZE(vkms_config_debugfs_list));
 }
 
+struct vkms_config_plane *vkms_config_add_overlay_plane(struct vkms_config *config,
+							uint32_t possible_crtcs)
+{
+	struct vkms_config_plane *plane_cfg;
+
+	plane_cfg = kzalloc(sizeof(*plane_cfg), GFP_KERNEL);
+	if (!plane_cfg)
+		return ERR_PTR(-ENOMEM);
+
+	plane_cfg->possible_crtcs = possible_crtcs;
+	list_add_tail(&plane_cfg->list, &config->planes);
+
+	return plane_cfg;
+}
+
+void vkms_config_destroy_overlay_plane(struct vkms_config *config,
+				       struct vkms_config_plane *plane_cfg)
+{
+	list_del(&plane_cfg->list);
+	kfree(plane_cfg);
+}
+
 struct vkms_config_crtc *vkms_config_add_crtc(struct vkms_config *config,
+					      bool enable_cursor,
 					      bool enable_writeback)
 {
 	struct vkms_config_crtc *crtc_cfg;
@@ -130,6 +172,7 @@ struct vkms_config_crtc *vkms_config_add_crtc(struct vkms_config *config,
 	if (!crtc_cfg)
 		return ERR_PTR(-ENOMEM);
 
+	crtc_cfg->cursor = enable_cursor;
 	crtc_cfg->writeback = enable_writeback;
 
 	crtc_cfg->index = 0;
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index f1dd59fc6300..25dab63e7ae7 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -8,9 +8,15 @@
 
 struct vkms_device;
 
+struct vkms_config_plane {
+	struct list_head list;
+	uint32_t possible_crtcs;
+};
+
 struct vkms_config_crtc {
 	struct list_head list;
 	unsigned int index;
+	bool cursor;
 	bool writeback;
 };
 
@@ -27,8 +33,7 @@ struct vkms_config_connector {
 
 struct vkms_config {
 	char *dev_name;
-	bool cursor;
-	bool overlay;
+	struct list_head planes;
 	struct list_head crtcs;
 	struct list_head encoders;
 	struct list_head connectors;
@@ -46,8 +51,15 @@ void vkms_config_destroy(struct vkms_config *config);
 /* DebugFS */
 void vkms_config_debugfs_init(struct vkms_device *vkms_device);
 
+/* Planes */
+struct vkms_config_plane *vkms_config_add_overlay_plane(struct vkms_config *config,
+							uint32_t possible_crtcs);
+void vkms_config_destroy_overlay_plane(struct vkms_config *config,
+				       struct vkms_config_plane *plane_cfg);
+
 /* CRTCs */
 struct vkms_config_crtc *vkms_config_add_crtc(struct vkms_config *config,
+					      bool enable_cursor,
 					      bool enable_writeback);
 void vkms_config_destroy_crtc(struct vkms_config *config,
 			      struct vkms_config_crtc *crtc_cfg);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 15a2ba26d190..b0a079eb4598 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -154,7 +154,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
-	return vkms_output_init(vkmsdev, 0);
+	return vkms_output_init(vkmsdev);
 }
 
 static int vkms_create(struct vkms_config *config)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index cac37d21654a..76394285dc68 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -149,10 +149,11 @@ struct vkms_crtc *vkms_crtc_init(struct drm_device *dev,
 				 struct drm_plane *cursor,
 				 unsigned int index);
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index);
+int vkms_output_init(struct vkms_device *vkmsdev);
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type, int index);
+				   enum drm_plane_type type,
+				   uint32_t possible_crtcs);
 
 /* CRC Support */
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 021a491de817..a5b1ab326cdd 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -82,21 +82,22 @@ static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device,
 	return encoder;
 }
 
-static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index)
+static int vkms_add_overlay_plane(struct vkms_device *vkmsdev,
+				  uint32_t possible_crtcs)
 {
 	struct vkms_plane *overlay;
 
-	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
+	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, possible_crtcs);
 	if (IS_ERR(overlay))
 		return PTR_ERR(overlay);
 
 	if (!overlay->base.possible_crtcs)
-		overlay->base.possible_crtcs = BIT(index);
+		overlay->base.possible_crtcs = possible_crtcs;
 
 	return 0;
 }
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index)
+int vkms_output_init(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector;
@@ -106,29 +107,27 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct vkms_crtc *vkms_crtc;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_plane *primary, *cursor = NULL;
+	struct vkms_config_plane *plane_cfg;
 	int ret;
 	int writeback;
-	unsigned int n;
 
-	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
-	if (IS_ERR(primary))
-		return PTR_ERR(primary);
-
-	if (vkmsdev->config->overlay) {
-		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
-			ret = vkms_add_overlay_plane(vkmsdev, index);
-			if (ret)
-				return ret;
-		}
-	}
-
-	if (vkmsdev->config->cursor) {
-		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
-		if (IS_ERR(cursor))
-			return PTR_ERR(cursor);
+	list_for_each_entry(plane_cfg, &vkmsdev->config->planes, list) {
+		ret = vkms_add_overlay_plane(vkmsdev, plane_cfg->possible_crtcs);
+		if (ret)
+			return ret;
 	}
 
 	list_for_each_entry(crtc_cfg, &vkmsdev->config->crtcs, list) {
+		primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, 0);
+		if (IS_ERR(primary))
+			return PTR_ERR(primary);
+
+		if (crtc_cfg->cursor) {
+			cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, 0);
+			if (IS_ERR(cursor))
+				return PTR_ERR(cursor);
+		}
+
 		vkms_crtc = vkms_crtc_init(dev, &primary->base, &cursor->base,
 					   crtc_cfg->index);
 		if (IS_ERR(vkms_crtc))
@@ -141,6 +140,8 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 			if (writeback)
 				DRM_ERROR("Failed to init writeback connector\n");
 		}
+
+		cursor = NULL;
 	}
 
 	list_for_each_entry(encoder_cfg, &vkmsdev->config->encoders, list) {
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e5c625ab8e3e..eb3edf4cb928 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -198,13 +198,13 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
 };
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type, int index)
+				   enum drm_plane_type type, uint32_t possible_crtcs)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
 
-	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
-					   &vkms_plane_funcs,
+	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base,
+					   possible_crtcs, &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
 					   NULL, type, NULL);
 	if (IS_ERR(plane))
-- 
2.46.0


