Return-Path: <linux-kernel+bounces-532151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B3A44955
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A118920F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D120764C;
	Tue, 25 Feb 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/48DLp5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298A1A01BF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506393; cv=none; b=jyljcdAX6GRlmRjXmBg84NfUjJ8B9DiJnrJy5KkoswRYTO1c9KetMioBQcJs5VLuVcdNeTyzwcpe8ubtZ2drWzVrxjZVvOSiXir6ZstvmRRUgTAuKMIKk/noIsiV+HXn3PzKptaXwpqIvGJtDXVZbg4Na8eYGWCgsIvJFXqYDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506393; c=relaxed/simple;
	bh=pt799dBa5K0FYqdOUVImd8ZBje4L2TgoHsYfI0sL7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDXd/R+taJs6gnZ8x2z+M70tV9SU7MtYkNmdbvBQsVcX9kyEqXYnYSe6cjdpBWpu0l3Jc0NzW/pDBBAovV+NwounzAgiSbDq8ia4SMh3MXvb7ImM03uwfepFh4GXjfTfOm1wXGp6gZuRjkPb0CYt+SjZ+9uz86IzR1Zk6H9i/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/48DLp5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so39570855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506389; x=1741111189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ3qzmV/GwODyLkEBydltNTBiPP7GsnM7FoOeuRwhyU=;
        b=f/48DLp5G2ruDZ9k8eTRmlR6axtL7JqIuPey59XOdGCRGB96BWVQBztRCGoRGxMO/K
         tSWpV2fQNHtHqWNmW4Gmx1sktwRpLVOeMFyrgqnkbQ85clrhR8MB1GUd8r836Jzkmzat
         2PDY2+xEZ/Xj3j27/KLMRLziqj3sfnRYaz9rjGlyR94XwYMnrxrBaaNAZZzJv7sH8jTd
         BWbNK8LAyqur9AEBt0uyCXAKXJm96kZMW5xrtjwbFqepmRNdYTbk+yV6I4Z4Un3cMC8b
         MaAyNFga6+JoyHLFEdhBnHG0qoHYSdMg9XDPD+6jzt9m36uT5nhc9DQjG0YE/T3Qfu2X
         04vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506389; x=1741111189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ3qzmV/GwODyLkEBydltNTBiPP7GsnM7FoOeuRwhyU=;
        b=Tiu/3Q5TR9w2+9aPBn90wWVFX86d2HtiXLZR9NZ4fu1L9fIfyGjQP7GV7Q9oXOYf95
         DMWZ6wyJIEdwQyxZKGY/LMLsXMyMqp/zyOj85VCdpx4TDbxC0lRmmnk/nVAeWo5YXmYn
         IGOhsviWAP9xtGGC8MbLVzbRohNqbrXY2HKdooHL+qjs/XgUvFw7b8WIUrQqOWysxE6D
         sX/jcUkeH6NmpLYynHg3amRZRet25lwtwStZKmnnLjJjANejhXSGxernPEutPa8QhC9S
         tKAqz7UxvyR6IbG9rj2zblHeEG6a20elANRyMgGs9vOCOgEBLJHy/AMZgSEX4x6DlEm4
         lBnA==
X-Forwarded-Encrypted: i=1; AJvYcCVAIRnIzY8Ed0unHIAK4wf/UQNHULq+Hd7bjKxDQzO8PYJDy62gC7Uvex7t0XFYaEiDUZSncudu+zb9Sco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvcaTmNCBIivi65n2fn7K9Vwn4KAb6bMn+OSKVn3Iz6XQ0iWt
	/kLE3GINFqiu1Vaf6NX7feLwIo8jloTdgpOt3SlyYTTZ++rtxdNx
X-Gm-Gg: ASbGncvTeGOV6yqB+8565z9gJS+b4bpWe78KF+vTIWXCtfAzlNeMY+NPtq2xa3H4+l3
	nNbj6o5Dhe4+Rgzleaj+wiVgJQ/vsG25ZuCk0/JyLLD19E/gIqIObAiI2nZRukMsKYs2oHLNZtu
	Cq1vqKvwe7yCMLRaMmZwnLVVAEY1rk5zOmE/9tEjbsOKQsuGH/xWYWUwPEh7TmOyUvIb5C8m1I5
	TyEsGxxvqkMiPvAz3BldY6PvLB6C1PA3kZ46dmPJRSe0AgIl3V1LJZUcPIm3YrZZZ4734Em9jCD
	1gFVcraM5I+GGAYGpwkjhRO2958n
X-Google-Smtp-Source: AGHT+IEy+IL/4SACMuAp4ri5486dK+aWSMx2NkyH5sRE4U8G0AbrFzsBBuGGPkYXj/bg5UH5g8T4Iw==
X-Received: by 2002:a05:6000:154a:b0:38d:e3da:8b50 with SMTP id ffacd0b85a97d-38f7082821bmr17517108f8f.39.1740506389035;
        Tue, 25 Feb 2025 09:59:49 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:48 -0800 (PST)
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
Subject: [PATCH v2 07/16] drm/vkms: Allow to attach planes and CRTCs via configfs
Date: Tue, 25 Feb 2025 18:59:27 +0100
Message-ID: <20250225175936.7223-8-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes/plane/possible_crtcs
that will contain symbolic links to the possible CRTCs for the plane.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  9 +++++
 drivers/gpu/drm/vkms/vkms_configfs.c | 54 ++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index 233a3d4ad75c..09d1f2224d01 100644
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
 
@@ -175,6 +181,49 @@ static const struct config_item_type crtc_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int plane_possible_crtcs_allow_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_configfs_plane *plane;
+	struct vkms_configfs_crtc *crtc;
+
+	if (target->ci_type != &crtc_item_type)
+		return -EINVAL;
+
+	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	guard(mutex)(&plane->dev->lock);
+
+	if (plane->dev->enabled)
+		return -EBUSY;
+
+	return vkms_config_plane_attach_crtc(plane->config, crtc->config);
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
+	guard(mutex)(&plane->dev->lock);
+	vkms_config_plane_detach_crtc(plane->config, crtc->config);
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
@@ -267,6 +316,11 @@ static struct config_group *make_plane_group(struct config_group *group,
 
 	config_group_init_type_name(&plane->group, name, &plane_item_type);
 
+	config_group_init_type_name(&plane->possible_crtcs_group,
+				    "possible_crtcs",
+				    &plane_possible_crtcs_group_type);
+	configfs_add_default_group(&plane->possible_crtcs_group, &plane->group);
+
 	return &plane->group;
 }
 
-- 
2.48.1


