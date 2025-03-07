Return-Path: <linux-kernel+bounces-551543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AB9A56DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932907A8230
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8B24113E;
	Fri,  7 Mar 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG17TsXa"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753C2405EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365253; cv=none; b=D6mIE/hfEkEB5iEDW+AeDq8HXUzin5pwk3ddsq6/RXLy3VBLQkkOBvrA6igxaOhQ9GVtcY6KaxjFwbsaOWUPrfNvUFNkPQFPyI8yF/8JrFhpJiBRw6LNMIAUJ10pDut7TiueMunn5t8WPXZFyJ8vZTB91JQPSE2o+Aju8M7YF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365253; c=relaxed/simple;
	bh=JVgTnIcYPlhqvVuMt+rGxEebARTXyB9Nrkey64pA5gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWvB8NDenYL1f2YCmTOJcIxK9ihXcQ2L6+IQrvsGtZxiHRUDjkyXkcZk2gvi3macMGAP+MDKe58Ysmhi1rkDan5sbyH5sKjNFwErSbqj1v9oue1R60KQA+Vf0irQcb4eTF5Ktp25YSRS/BRslLnT4WhVwKKVSRSMC2XeI5Xsjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG17TsXa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso24148045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365249; x=1741970049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdvTo+glOxdqzKi9x0MlR4nPEnMDWOMdVsZOru5+zTg=;
        b=gG17TsXaz92iW5gLT+qxVBOLwW8YsN0kzYLPHB/fbfvCpd2k4K59saOfN3y/+Sn1nu
         /7Joww6+AEs0Lpxx9S13NizjjewmuJYdA0zp9MxVKnD4BKchISIgxXYgZU+ilHUtH7jL
         KgmDqcPUIdAoPGKbb5v61gYXF3ZYDdDkzH8wd4oct2yr/JJ5xPAdnfKyV9B60Qx5UXuS
         lAfC9IGZ3Xwac3ErdlQuzkWwlUnOBgmV13TiQHLXPrDTeifdfV9H2v+ctZht2AQvJSqu
         PK0vAPijElqCwji2P6hEVAXhBIVLwBpLatUlKxpEfyY8PPFHMRhUOfveZQJqblHZdihZ
         aZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365249; x=1741970049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdvTo+glOxdqzKi9x0MlR4nPEnMDWOMdVsZOru5+zTg=;
        b=UZTfVUSikVGgsIkazPWJNc3G241C7HP2a40gVqkqpeZcdbKYUojHnNN9Qu4CwUa4f4
         SzjTOxZz3SkVKQQ3d+p42FEmkJW+RrXO6ynBvmhqaaYc1c8e/kw3Z7E9Vo106zrj0gw0
         dtX0NS+B7hjD52b6GNf6lWwidbmbtOrrO9Ow2+etoYp9PkU9VCiGbimVbtoQ1mkiP1Su
         N6hFKh089pUKiqkXrKTYIMegTF5I27yf5cE3mjAy1vxXuaBcA2GTOyd2ibnK208Ko42f
         HpSpklhYd74gJkC74gY6rwz+S9YonbgoQqb6rmBMJSJB8LTfRmE56Dvtm3diWDDOWnLm
         H77g==
X-Forwarded-Encrypted: i=1; AJvYcCVqDkaGzhluPFHpfgfsUiymX+tXACkW3LC+3RvCDSllJsUIw7O8wAk6Nz2gTyRKSVARPfORa7nO2XE06VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUq+ZyJ+sWtUf8F5S8v95Ulsewq7Eqm6OQPsKgwPyPY5Ybpzg
	3LXyDS245KzfdymrdDngvIaCMuoln4hNVYyHItsABuhEoqFQ8Yv1E7OiFrQE
X-Gm-Gg: ASbGncuU2igrOmAKX9WNZJW0ijr5VcU8euFuzVayCrC//8hAA397J4OhmqFX10Gv5WQ
	YmNsUf2vvn/U7+mp+gafUbI+AB/rpRM/VPLxRObB7XDfRyBSHv7Qn3fv+dPY+7XpgZVxQ4kyAH3
	MSdpkjZv4XMAiweBEG6UjdyN0HMUuggEyP+lAWZzVajrQ7gGb8uahkB0cwBMx/NvEeYrz2IE512
	HYIlUByTYOZzf+klBhrSJgQqnytWKyGyXjD/YYtOyuq9zjnM4d6cXpi+rdAKfwncOp2RAoS1SY3
	kPqm0MGZMNIqbC0q/AIzXDlmcZXY0U+xQrLHwoqC0qzRCb4=
X-Google-Smtp-Source: AGHT+IFPRccxnoFktNFSGhc7+pjS3ePButwIioS5C1b+Nw+vSpBYT06wzWLbIJFKik54mEQ9Ap2++w==
X-Received: by 2002:a05:600c:8581:b0:43c:e409:b8a7 with SMTP id 5b1f17b1804b1-43ce409bb17mr4439105e9.9.1741365248662;
        Fri, 07 Mar 2025 08:34:08 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:07 -0800 (PST)
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
Subject: [PATCH v3 07/16] drm/vkms: Allow to attach planes and CRTCs via configfs
Date: Fri,  7 Mar 2025 17:33:44 +0100
Message-ID: <20250307163353.5896-8-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes/plane/possible_crtcs
that will contain symbolic links to the possible CRTCs for the plane.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  9 +++++
 drivers/gpu/drm/vkms/vkms_configfs.c | 58 ++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index abe7a0f5a4ab..13b96837a266 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -98,6 +98,14 @@ CRTCs have 1 configurable attribute:
 
 - writeback: Enable or disable writeback connector support by writing 1 or 0
 
+To finish the configuration, link the different pipeline items::
+
+  sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
+
+Since at least one primary plane is required, make sure to set the right type::
+
+  echo "1" | sudo tee /config/vkms/my-vkms/planes/plane0/type
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -108,6 +116,7 @@ Finally, you can remove the VKMS instance disabling it::
 
 And removing the top level directory and its subdirectories::
 
+  sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index e9f445043268..2cf97c2b6203 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -38,11 +38,13 @@ struct vkms_configfs_device {
  *
  * @group: Top level configuration group that represents a plane.
  * Initialized when a new directory is created under "/config/vkms/planes"
+ * @possible_crtcs_group: Default subgroup of @group at "plane/possible_crtcs"
  * @dev: The vkms_configfs_device this plane belongs to
  * @config: Configuration of the VKMS plane
  */
 struct vkms_configfs_plane {
 	struct config_group group;
+	struct config_group possible_crtcs_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_plane *config;
 };
@@ -71,6 +73,10 @@ struct vkms_configfs_crtc {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+#define plane_possible_crtcs_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, \
+		     possible_crtcs_group)
+
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
@@ -178,6 +184,52 @@ static const struct config_item_type crtc_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int plane_possible_crtcs_allow_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_configfs_plane *plane;
+	struct vkms_configfs_crtc *crtc;
+	int ret;
+
+	if (target->ci_type != &crtc_item_type)
+		return -EINVAL;
+
+	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_plane_attach_crtc(plane->config, crtc->config);
+	}
+
+	return ret;
+}
+
+static void plane_possible_crtcs_drop_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_configfs_plane *plane;
+	struct vkms_configfs_crtc *crtc;
+
+	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		vkms_config_plane_detach_crtc(plane->config, crtc->config);
+}
+
+static struct configfs_item_operations plane_possible_crtcs_item_operations = {
+	.allow_link	= plane_possible_crtcs_allow_link,
+	.drop_link	= plane_possible_crtcs_drop_link,
+};
+
+static const struct config_item_type plane_possible_crtcs_group_type = {
+	.ct_item_ops	= &plane_possible_crtcs_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t plane_type_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_plane *plane;
@@ -272,6 +324,12 @@ static struct config_group *make_plane_group(struct config_group *group,
 		}
 
 		config_group_init_type_name(&plane->group, name, &plane_item_type);
+
+		config_group_init_type_name(&plane->possible_crtcs_group,
+					    "possible_crtcs",
+					    &plane_possible_crtcs_group_type);
+		configfs_add_default_group(&plane->possible_crtcs_group,
+					   &plane->group);
 	}
 
 	return &plane->group;
-- 
2.48.1


