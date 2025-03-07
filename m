Return-Path: <linux-kernel+bounces-551540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B0A56DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41CB17A7ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7023F405;
	Fri,  7 Mar 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKOuOEjI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DD23ED6C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365248; cv=none; b=dKJG7nE07iH5QpdI7qjSNhCGnyoDDMtiP+0B59nMXxo2rUJy1vUNm1QffONMvmvzyS3NBvhUvlBK2RXuNTk9pIXSjWL0mvjZVLbN14AGt1gVC9zEpGf8v+OY5DxRLcuEpmTBqnvOhSlfdjAH0SvHpGE6s7a7BCJyNZLsPIbcIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365248; c=relaxed/simple;
	bh=4ovzOrfYbRN+L8oGVVrRZuVtOudfe9yudJObZVaz6OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sV9nj98DDCgBUNLc+mY2p5jUZDPoUpUvP3EoCE5e0SCE35px6N0qhILEV7tx3TaobDyppHbi1QWiLNPX5hvBcLY2jYiY8f0XPNJ4ftE777gxO9U8o0oVKZKKxyinhpYF++rN8y0P8/0vZ3ykRnScPR4FAdVqvjiaxr2HSwrbWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKOuOEjI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bcad638efso12561675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365245; x=1741970045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQlMQlCFKnmKdpNz3j/9En9DKgH57otLDgNbJI7oEnA=;
        b=lKOuOEjIQxzC9oJbO2yr05l7MpEfz2ajTa2TUAYvCtYKBbNhcYs2JCzbLyaJ3Zy7WI
         cqhpXX2cgWPsmU2EvNzmg2jN7cVRImasPuFr225q423bCOUOBrNtkVYxTItPooMTLSvU
         isG/7TUIDHET/tC599Fyj/tgwemc5GBUhImzERnF4R8ht4Bc+XshQN5qWmwxCYrrht/t
         oIqdausaCj6Y7GIgGQsWQjTYGVwkpZpsFvVNDKiBWUVTXeoeGY5mRYrVE9uine/qoYAK
         Pzwp4zy4EoHs7KAZfJ09J2Q3oaGzcRT3SZzGB0CgJzBSpGhjBOBHnp6kLhw2POzxExan
         PoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365245; x=1741970045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQlMQlCFKnmKdpNz3j/9En9DKgH57otLDgNbJI7oEnA=;
        b=vltK1GHVPYCxV0uTJ+iizY+fBi9Cy1gI3nOqvkamxm+c8EvXNkQsYa2YJJFQK56A+O
         lLJNMY+NEYeKlpRgfVGWPuI3dgdZ8su3jhaPgx/mNil2b8SsNcytCUArSqLpsTzr0Au0
         YwwBX+79lMbzfeUmBoy8j9z/b5mvkygTCDmVNxcPaVyKbWvN4kTFdJKgDI7Ei8yzcWUT
         O23DjkrPY9KptZFBJTEUWe/7zLyum4Ewgf6JEyIqgufKU8JGw8S3v3nlWK+5S/BeyvOd
         L7ZucbCBkQ7IULFZrWg4oOTCuabZgiV0yq3KaYYI0yRHUowh9FgXMvgddf8xHYboMUzT
         ksLg==
X-Forwarded-Encrypted: i=1; AJvYcCVH2t/3HlvfIe2qTafBsGBx41bXrBTD1ap19YviAtY+m01zYwQPAtZzeWSRl9RWt8OjsxU/n7cBzxTS88o=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSVPC7XSWQPx75sGOKhq5iOVd29gLI7RXBZQh3d96m44SEsbn
	4y5o2ZXLJW+l8uXc+xxD5pCSAa3+U9PWBv5yDmDgqym//Kql773q
X-Gm-Gg: ASbGncsea/si+mS7NOSPd/krMsGyElr6IPNZ+Ow6K+W0QcAJxuSd460kDb4YBu/3tDi
	Fon+a4ShjNkDHt6OESAsh8f1uHr8bNYViDvXPkFK+KofpugtcsNfMwZ/Jx9Et6LsZiXesP4Q+gR
	8E2ZK62APEotpWR/fo8gHRI+RUl8HQHKMKVc8z1qyC2705KoR3yb2E19m6m6vyB1eUsdWMSe/1j
	o0mD+/sfkpT0McSwp8XyhrwFofy9qdnEK9W7+jaf10wIVSVvtzf46Dkq9QxHGOQ6KlPm39iesEW
	mGpbczxzygqpn+ic4F59sYXOsH564LBXVT4HmELAphFcunM=
X-Google-Smtp-Source: AGHT+IEghPLDlJPmvq/wiT5I8JEW5bsFoBksc9aRUiGeNRF/3NTsA37xXdz7/FA2hteWHdFBtnqzKA==
X-Received: by 2002:a5d:648f:0:b0:390:fe13:e0ba with SMTP id ffacd0b85a97d-39132d70bc4mr2691197f8f.27.1741365244533;
        Fri, 07 Mar 2025 08:34:04 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:04 -0800 (PST)
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
Subject: [PATCH v3 05/16] drm/vkms: Allow to configure multiple CRTCs via configfs
Date: Fri,  7 Mar 2025 17:33:42 +0100
Message-ID: <20250307163353.5896-6-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/crtcs to allow to create as
many CRTCs as required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 85 ++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index a87e0925bebb..e0699603ef53 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── crtcs
   ├── enabled
   └── planes
 
@@ -89,6 +90,10 @@ Planes have 1 configurable attribute:
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
 
+Continue by creating one or more CRTCs::
+
+  sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -100,6 +105,7 @@ Finally, you can remove the VKMS instance disabling it::
 And removing the top level directory and its subdirectories::
 
   sudo rmdir /config/vkms/my-vkms/planes/*
+  sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 398755127759..62a82366791d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -17,6 +17,7 @@ static bool is_configfs_registered;
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
+ * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -25,6 +26,7 @@ static bool is_configfs_registered;
 struct vkms_configfs_device {
 	struct config_group group;
 	struct config_group planes_group;
+	struct config_group crtcs_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -45,6 +47,20 @@ struct vkms_configfs_plane {
 	struct vkms_config_plane *config;
 };
 
+/**
+ * struct vkms_configfs_crtc - Configfs representation of a CRTC
+ *
+ * @group: Top level configuration group that represents a CRTC.
+ * Initialized when a new directory is created under "/config/vkms/crtcs"
+ * @dev: The vkms_configfs_device this CRTC belongs to
+ * @config: Configuration of the VKMS CRTC
+ */
+struct vkms_configfs_crtc {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_crtc *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -55,6 +71,71 @@ struct vkms_configfs_plane {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+#define crtc_item_to_vkms_configfs_crtc(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
+
+static void crtc_release(struct config_item *item)
+{
+	struct vkms_configfs_crtc *crtc;
+	struct mutex *lock;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+	lock = &crtc->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_crtc(crtc->dev->config, crtc->config);
+		kfree(crtc);
+	}
+}
+
+static struct configfs_item_operations crtc_item_operations = {
+	.release	= &crtc_release,
+};
+
+static const struct config_item_type crtc_item_type = {
+	.ct_item_ops	= &crtc_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_crtc_group(struct config_group *group,
+					    const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_crtc *crtc;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		crtc = kzalloc(sizeof(*crtc), GFP_KERNEL);
+		if (!crtc)
+			return ERR_PTR(-ENOMEM);
+
+		crtc->dev = dev;
+
+		crtc->config = vkms_config_create_crtc(dev->config);
+		if (IS_ERR(crtc->config)) {
+			kfree(crtc);
+			return ERR_CAST(crtc->config);
+		}
+
+		config_group_init_type_name(&crtc->group, name, &crtc_item_type);
+	}
+
+	return &crtc->group;
+}
+
+static struct configfs_group_operations crtcs_group_operations = {
+	.make_group	= &make_crtc_group,
+};
+
+static const struct config_item_type crtc_group_type = {
+	.ct_group_ops	= &crtcs_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t plane_type_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_plane *plane;
@@ -262,6 +343,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &plane_group_type);
 	configfs_add_default_group(&dev->planes_group, &dev->group);
 
+	config_group_init_type_name(&dev->crtcs_group, "crtcs",
+				    &crtc_group_type);
+	configfs_add_default_group(&dev->crtcs_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


