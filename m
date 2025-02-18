Return-Path: <linux-kernel+bounces-519925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C71AA3A3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D3D17200A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A09228CA5;
	Tue, 18 Feb 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac/OEvMb"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD526FD9D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898503; cv=none; b=K+57ThPTQ/5yAs2rirp1Zqi8uOmG7j2SJ3XeLxzB+S271vOXFyaIgM0UOUnc/dI/BG2xII7k+aQlEAR1uvuYo6oWkvsJy1yGI2Xxce2fRTPboiz6fmXu43JtgZQ0TmJ8f0PJjkSOFmjJcA8N5P/bnjlSCp454rlVoaiJPzKbzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898503; c=relaxed/simple;
	bh=15Z9PezUwicqW9NL6pJPQ9JdwXGYW40aTptsqa3QCBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igsM8iiozvgDJgQVYjKbRYdVFSujYHTrHjugMrDxHbDy78O8u28mUqXiFml/SY6bIOEd2zCM2emcKOL5jm9IobQ9JuB2/brE+075QAro9kIUZmBiiZyTgaR6Ga+hi8K6CcNbd2JzDvaCqnW107w5NWFrOW8O0PVHwRb5EaCF6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac/OEvMb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a39e659cso39943325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898500; x=1740503300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2duRuE/yZVXOXN/jBplEXsWwBrq6X3padZ2YIHFcxIY=;
        b=ac/OEvMb5s5UWAzIzDTGfse0ffsEOIz4hMl4SZyOqavD+fITzWQSwQ9TCggbP+6JbC
         59OasSKaKqDXL5KueZTLTtqOVtwKoeKW85SJn6HQ0PL2QKvG78g6OnL5FZIpvEVWZlrS
         SlqK/2yBZxUv1k+A0Sv8kt02J8yX6WbpGnxEjuh+NSHkifD3Vska3/OevoLmIlYnCCXp
         fwh3YRNXc+DAkglbFgydtx9RIdfshLnUlD2NkezG56T69LtLyD9Fnkz/d+NqBNgo1ote
         XJvwVyRoWxJIP+04Yi1C7KlVhGTB1OSP8JR2raKppCcDgYF1sWgsjpZ7V/hnHcdwHT1k
         RHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898500; x=1740503300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2duRuE/yZVXOXN/jBplEXsWwBrq6X3padZ2YIHFcxIY=;
        b=vvpvvYl/OGp225iCJP5C3T1YGco//nCn/z6+WNzQeHZWlzDpHS9NbdUDjLaHrZoIUE
         IqN5159mAmpdL6QTYQ0xNjrv7j+h4dkwtkyEOo3RRUQzrhRVk1l1rB8rMbIOy4FcYXcp
         fVTUVLMLAIVa5fouNIuPGbmbnhwbMF64j6sVjqKHfxHnio2WLnmqcjE0Uc0hW2oNYJ/K
         B0MNEODUuIMcqlCbQVivbSqfL5xSsDmlF3ovr72WJADlUlZ+z6v8SYybENHvNCGlrK37
         aWjvRVT6lT5BADXWL9snyn4prdvtUsv4cQooL4DEfrAWpFMx+8X6S9RL1jjQhFEfeyUJ
         b3lg==
X-Forwarded-Encrypted: i=1; AJvYcCVcfSKLmsDa0oCOWBZZDQkJ38+Q8H7IkLhpQk4o5M4x8U5twBX5Ty8BjYJJb6KqfR9wVEjB6v/FE7buiQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWLh/56/IBs7R13pe5DPd6ZvyThALt+oDelRDAT30jgUhi07Y
	Qxl62cVTvQGy9o4bt+ZOSXCiXbOg+uJI0Pzvc82jf36XzFtSL1ah
X-Gm-Gg: ASbGncvm86xNCYDsnvrfEp1+gqkoov/r6Ec3dZyKcPncF96VyKmT6LsYjqWKIY3f8Qx
	n/HPvU05ahVuhEy6yrboJ4ZrS34Dx/vy2vhZimBIFWgH20uG9QGFb+OeZ29FgKqhkBlGovfHnAI
	r95p4A+Gmwnpy7uYlyXr/TxBw5VAeOTxzP5ZRI6hxtyXYoa64d4Oe15w/L37JWs9EVguDGfMuJD
	PtBltiBycDgN7mVG94ZOgtC2UfiQXT0ushThDGIdsWwr9WTg9qzyf1wvWLgC+/8y3cFJe9Kbt42
	VvBHxHd/RdD+92mZrw==
X-Google-Smtp-Source: AGHT+IExW6UuaTDCAVrVvvER/ec1B5FRhWSiJKQBV1MNTPXbV9fjpuD31Qx9KXMPB/93kGDF8ru3hQ==
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr127330165e9.17.1739898499450;
        Tue, 18 Feb 2025 09:08:19 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:18 -0800 (PST)
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
Subject: [PATCH 05/16] drm/vkms: Allow to configure multiple CRTCs via configfs
Date: Tue, 18 Feb 2025 18:07:57 +0100
Message-ID: <20250218170808.9507-6-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/crtcs to allow to create as
many CRTCs as required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 98 ++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index d95f228de05b..da5157adfd79 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── crtcs
   ├── enabled
   └── planes
 
@@ -88,6 +89,10 @@ Planes have 1 configurable attribute:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor
 
+Continue by creating one or more CRTCs::
+
+  sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -99,6 +104,7 @@ Finally, you can remove the VKMS instance disabling it::
 And removing the top level directory and its subdirectories::
 
   sudo rmdir /config/vkms/my-vkms/planes/*
+  sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 093735f47858..52205a8a9cb4 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -16,6 +16,7 @@ static bool is_configfs_registered;
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
+ * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -24,6 +25,7 @@ static bool is_configfs_registered;
 struct vkms_configfs_device {
 	struct config_group group;
 	struct config_group planes_group;
+	struct config_group crtcs_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -44,6 +46,20 @@ struct vkms_configfs_plane {
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
@@ -54,6 +70,84 @@ struct vkms_configfs_plane {
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
+	mutex_lock(lock);
+	vkms_config_destroy_crtc(crtc->dev->config, crtc->config);
+	kfree(crtc);
+	mutex_unlock(lock);
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
+	crtc = kzalloc(sizeof(*crtc), GFP_KERNEL);
+	if (!crtc) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	crtc->dev = dev;
+
+	crtc->config = vkms_config_create_crtc(dev->config);
+	if (IS_ERR(crtc->config)) {
+		ret = PTR_ERR(crtc->config);
+		goto err_free;
+	}
+
+	config_group_init_type_name(&crtc->group, name, &crtc_item_type);
+
+	mutex_unlock(&dev->lock);
+
+	return &crtc->group;
+
+err_free:
+	kfree(crtc);
+err_unlock:
+	mutex_unlock(&dev->lock);
+	return ERR_PTR(ret);
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
@@ -289,6 +383,10 @@ static struct config_group *make_device_group(struct config_group *group,
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


