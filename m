Return-Path: <linux-kernel+bounces-551544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A0A56DDE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D701897892
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8BD24166C;
	Fri,  7 Mar 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmOW17qK"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C74240611
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365253; cv=none; b=bPSG12+sRfWsKr72Z/vOYlhqijUKxe66qagSudJbfYeEq4kigjkBFvJ68RVNp1fFIIVTiQKSmXukktRlYRsaJceive+pTUGSRJadVhpRhPylNowNlvm80UBSpxnn9y39X9gP39EG1E0umfx11/cqKVck/JCJhRA8GjNT5rQg9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365253; c=relaxed/simple;
	bh=yiuFHxMBg5iIkLll8tlleCLfSuKQMthO0tHG6AiBgjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aThyQSy8JxPAikkRcMwekYqYcR+1hwHWn371M+1ptAcvN4OWnYtIIeu6gE3UZT5zTf8Hcq9FEaFG11hL8lQGMYe5X/QCN5QrKMQCvvUAoFWtv9ImY8Z3OWo76QOhXRtbdBf31DjkH8wkncThln78sDCi322ntmktTe8G7bL887w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmOW17qK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3911748893aso1494680f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365250; x=1741970050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oQHAhb9mjt4fInrJwzIGdl9Ptg528EudUlnjp2MNA8=;
        b=EmOW17qK6epmywL0bb/NHCd60xfZ9WWnINMyTP6rIliDTWameBBbQ1ICF5z6FwrBax
         Wa9XA5vr9zpSGMOdCz8mNcLwE7FnLm9Zp1o9L8cgL485rtlXIcPGBiP6Ix9RFgLyQ3WR
         IqZC9MWpLcG+6L6hNS7+4BGDsaBe+yaJJTRu/YzdIynx94C8djriR0/+slLvslmb0i47
         0tL/0WRJq3eMrzwp3PgIIXrXNIYJGPN53VRakdxJc31AZH43W55QeRqt50HqFKfzUxEa
         ZQHbWUOoS0KNghcoWvOeUmFXupWqkF+MTniaS826h0gEtpJFPRnxNx9UzFMpCZg+AhW7
         nO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365250; x=1741970050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oQHAhb9mjt4fInrJwzIGdl9Ptg528EudUlnjp2MNA8=;
        b=XLCl5IZZtPa0evjG6yB5Yb61FpJIROXTBGByB3zMNj++gOoSdokYMKOf3EA35zD4kI
         AZuHBYw/Dt+LU3SAwKuLdsKhtpkUkAffQLX483oEpqzykfcslgKamsrWoBtu/nxX2sKS
         qiakkKPYmCz20cBNvnpXHh9omaXrdMvvRFWcKd/pDZeaVytx+icOStiGGhytF3VObkix
         OIsnBgUJfNKowCDDBYPOJluBjspbfkHPBZvAnlUB+Bfv1ZWH8tdBM0RnHiEs/VUg4VfK
         m3976bXmr5xAFwsAH7aqTvKhtW9QPY30E9351YPYFu7uJMd1UGN+ETZuXWyR2gZAr8M+
         M+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0io9/YNXoua3oZVz+oE3jdsv1ViTg5HVy3QMKLZO4YdwB8sHfI/1hFZn8pADoYQ2FAleBHh7cSwE6v5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJRtR7NlYhVxY7QdK4Df4N7nzdnaH2qVzDBRbllAxCTJDnVH2T
	aBucdvTdpxj+nMe6AQ2NF1+ObEtF5kfpFXsus2NmxbPP2WURaSbE
X-Gm-Gg: ASbGncto+jSDnREyjFqZZykbFnHkXNCf1SOS2BryjyUMoRjJ52bT8ZXWkjUXpfsap8I
	NHk8d6TgKxCMQF/gUpUV4XWk0YTMXBLLu/HfrIwjYMss0uRKLh8dZcyLD8PaW76FCQYglUekMRp
	cOayc6BQ1DcH5fju93cMjuscKuPiSF02orEVYIOm8zQioX66U1t03J+f/CZO4nDAUypqxpuoL9E
	yIdlrN+WSy+3hsjxfRfmuhCJjRbeoAop0vzEe5onYgUDtQn68uVza1d8N/Om6X7tL12zk5FBM4M
	0xsmDXChUSP9tIupIa/mkMfgAqdteSbZReJBXmmX2CqdRwA=
X-Google-Smtp-Source: AGHT+IFsrm3QntpbyPuP4HXlK5m2E23x9fnNTDWBthJFYTPmQuedXlywOAqGxiFsqYouDrx4t6NaqA==
X-Received: by 2002:a5d:6d04:0:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-39132d77194mr2387021f8f.2.1741365249931;
        Fri, 07 Mar 2025 08:34:09 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:09 -0800 (PST)
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
Subject: [PATCH v3 08/16] drm/vkms: Allow to configure multiple encoders via configfs
Date: Fri,  7 Mar 2025 17:33:45 +0100
Message-ID: <20250307163353.5896-9-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a default subgroup at /config/vkms/encoders to allow to create as
many encoders as required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 87 ++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 13b96837a266..e24767448775 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -76,6 +76,7 @@ And directories are created for each configurable item of the display pipeline::
   tree /config/vkms/my-vkms
   ├── crtcs
   ├── enabled
+  ├── encoders
   └── planes
 
 To add items to the display pipeline, create one or more directories under the
@@ -98,6 +99,10 @@ CRTCs have 1 configurable attribute:
 
 - writeback: Enable or disable writeback connector support by writing 1 or 0
 
+Next, create one or more encoders::
+
+  sudo mkdir /config/vkms/my-vkms/encoders/encoder0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -119,6 +124,7 @@ And removing the top level directory and its subdirectories::
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
+  sudo rmdir /config/vkms/my-vkms/encoders/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 2cf97c2b6203..0df86e63570a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -18,6 +18,7 @@ static bool is_configfs_registered;
  * Initialized when a new directory is created under "/config/vkms/"
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
+ * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -27,6 +28,7 @@ struct vkms_configfs_device {
 	struct config_group group;
 	struct config_group planes_group;
 	struct config_group crtcs_group;
+	struct config_group encoders_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -63,6 +65,20 @@ struct vkms_configfs_crtc {
 	struct vkms_config_crtc *config;
 };
 
+/**
+ * struct vkms_configfs_encoder - Configfs representation of a encoder
+ *
+ * @group: Top level configuration group that represents a encoder.
+ * Initialized when a new directory is created under "/config/vkms/encoders"
+ * @dev: The vkms_configfs_device this encoder belongs to
+ * @config: Configuration of the VKMS encoder
+ */
+struct vkms_configfs_encoder {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_encoder *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -80,6 +96,10 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+#define encoder_item_to_vkms_configfs_encoder(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -344,6 +364,69 @@ static const struct config_item_type plane_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void encoder_release(struct config_item *item)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct mutex *lock;
+
+	encoder = encoder_item_to_vkms_configfs_encoder(item);
+	lock = &encoder->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_encoder(encoder->dev->config, encoder->config);
+		kfree(encoder);
+	}
+}
+
+static struct configfs_item_operations encoder_item_operations = {
+	.release	= &encoder_release,
+};
+
+static const struct config_item_type encoder_item_type = {
+	.ct_item_ops	= &encoder_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_encoder_group(struct config_group *group,
+					       const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_encoder *encoder;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
+		if (!encoder)
+			return ERR_PTR(-ENOMEM);
+
+		encoder->dev = dev;
+
+		encoder->config = vkms_config_create_encoder(dev->config);
+		if (IS_ERR(encoder->config)) {
+			kfree(encoder);
+			return ERR_CAST(encoder->config);
+		}
+
+		config_group_init_type_name(&encoder->group, name,
+					    &encoder_item_type);
+	}
+
+	return &encoder->group;
+}
+
+static struct configfs_group_operations encoders_group_operations = {
+	.make_group	= &make_encoder_group,
+};
+
+static const struct config_item_type encoder_group_type = {
+	.ct_group_ops	= &encoders_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -447,6 +530,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &crtc_group_type);
 	configfs_add_default_group(&dev->crtcs_group, &dev->group);
 
+	config_group_init_type_name(&dev->encoders_group, "encoders",
+				    &encoder_group_type);
+	configfs_add_default_group(&dev->encoders_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


