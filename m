Return-Path: <linux-kernel+bounces-532149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28AA44952
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E2518961D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD91D7E54;
	Tue, 25 Feb 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfY50dhx"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255721A315D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506391; cv=none; b=hHqnh0t3ZN0Jo0wc73LnHQeCSc/f1rTdjVGzkOKBm2zteZy9+qGW3LLBlnNBIdggEzP8lrq4yHqSgMPbxlylr6sCoieHEshUoNnqZWKO6EUnBJPXVVwyOf5LthkAq8AuCh4VGQ6+sjDaluP8NlIZ56ysw9St9Uv8rZPaUOnuqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506391; c=relaxed/simple;
	bh=CXStM0MpaoYF2y5eKz61lbiPghGgrcct2Nt3+5mBiEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTYb7GrH1H58GU37XZQU/loVVuBstl3gsy/oIowF/KmmwG2uD6tbPDR9lhRPb0xbuz3j8Vhb0VHI3liq+ZHV3/Qr8cjuPyJ4Mx65NqIXNrQqPRW1ZyxZtnI9Gsrpu5fL58F1gjzTdOCM9OUqQRRWrp3ECksgpXkzKflJJRMUJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfY50dhx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so56574775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506387; x=1741111187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC1+hzLjpAD0CpG9te0z8ab5IM3YNOmmBls2ySCSckA=;
        b=XfY50dhxAj+EHebRvnO9VFsdUGY4DbswQQ1rOS5qXG2hoE35NcYObp0fDdHtl81mom
         nknViV17rmvIe2RpFo8SsIXgwmwGfSE44Sm5XWrU0dEOFHv+FaULR5LjL46MAmyTDAbj
         1PoO0ddqUTApZXCstyHcYIqv0lOkq522DjG6/YlBxZHIlL/Tssc5gN88qQRcaNqOOvtv
         7w+zn6fIC64fSO9LveQIYMNs8BZq9i1kco/snMu0P5WHRDlUa3Dk5CCAChjQUVMadesk
         YDAHGNdbyH3KEX17vbsKUDIQVBi1P1Xnt6Ln9QIP0lHhmQqVOlbd3ojnb00uWDlCLXLp
         FdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506387; x=1741111187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC1+hzLjpAD0CpG9te0z8ab5IM3YNOmmBls2ySCSckA=;
        b=i0KwwkzAtcUEYgmon7zI4HCFRlvnShv/kHWVqfuYKXb9WfmYu3//GCyJwsTd0KmJJv
         RvLSahYLcUMnc8qheXbQab4p6t6a/TIzzZmEVJUfJ8eKjTKR+bKaozrQG40EjMaJRMYO
         tG5w0m5d8doBRQyElVkJ9HWu9gWeRM5MDcO0PnStFoenIoidP8FyPdVfEVXvYguevNCV
         fmZl8jJKlZfII/XWQHHtDNOu5huTolMjWic9WzfEeL9hdjSOnRc9FMWn5oGh5GK7yCr7
         MqYo1sycpH3pzm355B9S24BaePD/b1hgz5vcjqEHvRH/uF+0G+9/wLFQjIh9FJn8ZFU+
         WdkA==
X-Forwarded-Encrypted: i=1; AJvYcCVz66Z/k8oujhC60v3nGsr8vlUKNPUInQ6ENDEHgE9KC38O6tjSGwQgMpo45pdKQrIRJ5KKQ8UWiXKPiBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8UqPZ/V1mZuTplTD0/idsMKvJfQ3rM9scxAsVAoN/+cGcURQ
	YV+eri7d6hx9LcsvTNgkJCmk5vA3ClEv665P40TzL3OxrYv+JJXD
X-Gm-Gg: ASbGncv6rwO184zYgrVD9mmCaHnftDcfFcbWm0LsIx9ZnZYTp3K7XqDub50amQncOUT
	TEUar+kjUkd571E07XkVvwj1hfZ/B2Sqt1Lk5R0H8cNgqkt3wr4dYG7wntPauPIMP6JGL8fiitn
	Rc9hNqDZDtpdorNAYf1THcNtcV/XKx/k5cLHGtdpMZioCy2ZMono50aYnhXs4cASJ757XFYOdWv
	yz2+d0dufQN0gOH8BiOx7s7CVygdkVtEdohhJke/nWyT/0UZxbAs+vMcvuwZPdQ8leZQv7no5g9
	3IbI9J0cH7zxIZ+kBHHOrmUpwV0S
X-Google-Smtp-Source: AGHT+IGyYnb11gZgclvRVsL9ItAF6/JENZwu39j6igcuRB0HwP1x3A2vZbkH/rqQYAL9dpUt1LRpVg==
X-Received: by 2002:a05:600c:450d:b0:439:9a43:dd62 with SMTP id 5b1f17b1804b1-439aebb2d6fmr119679735e9.24.1740506386934;
        Tue, 25 Feb 2025 09:59:46 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:46 -0800 (PST)
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
Subject: [PATCH v2 05/16] drm/vkms: Allow to configure multiple CRTCs via configfs
Date: Tue, 25 Feb 2025 18:59:25 +0100
Message-ID: <20250225175936.7223-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/vkms/vkms_configfs.c | 84 ++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

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
index c2e1eef75906..1483f47244e6 100644
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
@@ -55,6 +71,70 @@ struct vkms_configfs_plane {
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
+	guard(mutex)(lock);
+	vkms_config_destroy_crtc(crtc->dev->config, crtc->config);
+	kfree(crtc);
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
+	guard(mutex)(&dev->lock);
+
+	if (dev->enabled)
+		return ERR_PTR(-EBUSY);
+
+	crtc = kzalloc(sizeof(*crtc), GFP_KERNEL);
+	if (!crtc)
+		return ERR_PTR(-ENOMEM);
+
+	crtc->dev = dev;
+
+	crtc->config = vkms_config_create_crtc(dev->config);
+	if (IS_ERR(crtc->config)) {
+		kfree(crtc);
+		return ERR_CAST(crtc->config);
+	}
+
+	config_group_init_type_name(&crtc->group, name, &crtc_item_type);
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
@@ -255,6 +335,10 @@ static struct config_group *make_device_group(struct config_group *group,
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


