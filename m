Return-Path: <linux-kernel+bounces-551539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02FA56DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE1C1899D10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97123ED6A;
	Fri,  7 Mar 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H46CP+4X"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435F23E22B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365245; cv=none; b=u4v6dwVeiUCLKuSyDjrccRrIFcsl9qmZn17YL8kzkfpBFVxebLAeecUHtzGeDdUD0K0/F2siWvvghweRBXyNDzZt4wcZbKvQ41igr04TpHen6gflISgkicTBOjgIJblN8G1+4V7kwN19XtgoEerF/NWca8GtCY7gzFhJorrwhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365245; c=relaxed/simple;
	bh=plwNemilP6KuLq1qbr2CIkiTrDCudwoTizzJD/aTFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzyAK9jukAEqoggh0l9NMwuFwN8Tje5hUGR+xVTep9nMEmfoXVkTkg1soI0hgO2v+NWdYiVlMUmbopVnFRnN5yaMqeduOo8/oHW90FxyTYCZnc4cWsjAjBFpyULPNuUgxqucDNDxWrxX66JVV48MawLQVTcqY+XyEOhjbAvqhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H46CP+4X; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39129fc51f8so1807207f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365242; x=1741970042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYVCtKALM7tRTxTIBs5CBqjqnZ0ufRMiomzRADReB1Y=;
        b=H46CP+4XiU3jdY5bEXz7r68FGnSn6mRdXIIaYiUmj//H3fRrW36yVY7blrjx9bLiQc
         ofCmOsqve7XBErKN2PM0kSgZTb4t6ej5CBcS8VK0qbDQVHb4O18RJUaiSmfDCHklJn5T
         x0V4LHsBdqLR3JCRfkGGB2Xpj1p6gebvCVsiJ47MJDHTfE+NDCnlCThkrAUytEfFiMbw
         VpIbSxaPTgq1115Bff9aanXeFSCzYEHpCflgqutKxD0awJOXz747kUDDfEWnZx3mTSbq
         GApTC9AO/fqESgShMCzTysYTJvy/jcIMypMnjrwLWyDq0MsU4r41xECUtKIHMgI3Nxsq
         HMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365242; x=1741970042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYVCtKALM7tRTxTIBs5CBqjqnZ0ufRMiomzRADReB1Y=;
        b=dvWEVnoBvbowCJ9dTUQo9VS6b9vnXpAo+gKblwRfiFHX39Nr5bv6OC17lhk6kfD9k+
         P8Rn5ONkJgvbv+QeBmA4AkWNLtnXXIgZ5Dqk+fKf14qW3Xf8FJ24n0rJTG+eCzdSoOon
         2Ms9HIhqNs3eotsGxwE0AaQMDZPyIyyD4SRHaPyHWsG5jTR58rzySkruE6Aq+zlBA81o
         tO6x4CIL544QygUTIc7Sb2FxMXJp58KiQxIiUvgCKNrEpTgqizSFbFPtOCgNn6+gIAP8
         L9UeQKYz1EGhjjxlFhQGJ/S/fojViN2aGzH+QdNaSZFrqH2Jyr1U0W2iWciYvKmO1st5
         Qrog==
X-Forwarded-Encrypted: i=1; AJvYcCW3yyYsOrVwH5KNvY0a8g4RpHYYZS7TP0XedK5w7PNWLqJoXeGStgTZPn+03nA6N6hzAQR1+roQEibr9iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxXPRjFyWPLNHVbMiP+HtGu7dqn/xYW0Kp5eZecdCZhhOPxjX
	fdVFWp+tnBjUF1uvq3U8PXFYsn/VoPen8PkSzp8bHW99eA5EPtM2
X-Gm-Gg: ASbGncsWnPgJpl0Z6SceZnv740WnszfTKfV/g1JHbQe20WdAt+e8ZzZcWKDLHJMRrtB
	/taSUGUD3XnSIvIdM1ukWAxQoy/p8uqKAvt4W9MmNk7vV3Zqm8oVATh2rTNoOoZ9IXXBbhoH5nC
	udtrE1D3BgeJ6NkdmNRitDNQcZ/nJGCLsv4zmXlcUsWuqYIAxsIgdvng8BsqfQD7TfeypG+RpHs
	4s0kwc2u+I3TB+Un4ITkWTWbW/HqlSS9sqzzIcMtKAdbAnWpCoMYXFal/PhNKAX4F1Y18kgISIT
	7Ip2EItl3/Y68nrQiCQCHtLMM8gb+LyAyYB1tYiVTE20YIs=
X-Google-Smtp-Source: AGHT+IHUuKO6qRQ3oA5vpJ7m+Un5BJ2C/6O9k5CT+//v2AYCHfRgiVqmxqLuZIOxa0Icg/nj8Yx3UQ==
X-Received: by 2002:a05:6000:1867:b0:390:f9f9:3e9c with SMTP id ffacd0b85a97d-39132d7a804mr2826550f8f.25.1741365241768;
        Fri, 07 Mar 2025 08:34:01 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:01 -0800 (PST)
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
Subject: [PATCH v3 03/16] drm/vkms: Allow to configure multiple planes via configfs
Date: Fri,  7 Mar 2025 17:33:40 +0100
Message-ID: <20250307163353.5896-4-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes to allow to create as
many planes as required.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           | 16 ++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 88 ++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 423bdf86b5b1..bf23d0da33fe 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -71,6 +71,19 @@ By default, the instance is disabled::
   cat /config/vkms/my-vkms/enabled
   0
 
+And directories are created for each configurable item of the display pipeline::
+
+  tree /config/vkms/my-vkms
+  ├── enabled
+  └── planes
+
+To add items to the display pipeline, create one or more directories under the
+available paths.
+
+Start by creating one or more planes::
+
+  sudo mkdir /config/vkms/my-vkms/planes/plane0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -79,8 +92,9 @@ Finally, you can remove the VKMS instance disabling it::
 
   echo "0" | sudo tee /config/vkms/my-vkms/enabled
 
-And removing the top level directory::
+And removing the top level directory and its subdirectories::
 
+  sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index ee186952971b..a7c705e00e4c 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -16,6 +16,7 @@ static bool is_configfs_registered;
  *
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
+ * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -23,16 +24,99 @@ static bool is_configfs_registered;
  */
 struct vkms_configfs_device {
 	struct config_group group;
+	struct config_group planes_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
 	bool enabled;
 };
 
+/**
+ * struct vkms_configfs_plane - Configfs representation of a plane
+ *
+ * @group: Top level configuration group that represents a plane.
+ * Initialized when a new directory is created under "/config/vkms/planes"
+ * @dev: The vkms_configfs_device this plane belongs to
+ * @config: Configuration of the VKMS plane
+ */
+struct vkms_configfs_plane {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_plane *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
 
+#define child_group_to_vkms_configfs_device(group) \
+	device_item_to_vkms_configfs_device((&(group)->cg_item)->ci_parent)
+
+#define plane_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
+
+static void plane_release(struct config_item *item)
+{
+	struct vkms_configfs_plane *plane;
+	struct mutex *lock;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+	lock = &plane->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_plane(plane->config);
+		kfree(plane);
+	}
+}
+
+static struct configfs_item_operations plane_item_operations = {
+	.release	= &plane_release,
+};
+
+static const struct config_item_type plane_item_type = {
+	.ct_item_ops	= &plane_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_plane_group(struct config_group *group,
+					     const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_plane *plane;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		plane = kzalloc(sizeof(*plane), GFP_KERNEL);
+		if (!plane)
+			return ERR_PTR(-ENOMEM);
+
+		plane->dev = dev;
+
+		plane->config = vkms_config_create_plane(dev->config);
+		if (IS_ERR(plane->config)) {
+			kfree(plane);
+			return ERR_CAST(plane->config);
+		}
+
+		config_group_init_type_name(&plane->group, name, &plane_item_type);
+	}
+
+	return &plane->group;
+}
+
+static struct configfs_group_operations planes_group_operations = {
+	.make_group	= &make_plane_group,
+};
+
+static const struct config_item_type plane_group_type = {
+	.ct_group_ops	= &planes_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -128,6 +212,10 @@ static struct config_group *make_device_group(struct config_group *group,
 	config_group_init_type_name(&dev->group, name, &device_item_type);
 	mutex_init(&dev->lock);
 
+	config_group_init_type_name(&dev->planes_group, "planes",
+				    &plane_group_type);
+	configfs_add_default_group(&dev->planes_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


