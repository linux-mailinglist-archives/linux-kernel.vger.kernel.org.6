Return-Path: <linux-kernel+bounces-519927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F14A3A3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956CE18928E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4DB271274;
	Tue, 18 Feb 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hILAVs+z"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA973270EB2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898505; cv=none; b=EwnbFG0512wO5lNz3QPbglX7wptSGSdSsMRdbrqcg5p0GtHs7Kr6Qbdw6LV/HQr/3fGb7C8UjEyk3Ea+NvJHXANTHbD8ADnC1KVEfMPsN2vgWhLJ23ZBCpcRThMEToTe2qrVCs/jKnpsbY0kvpmEY9lYTBRa+SUDL5rjPskbyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898505; c=relaxed/simple;
	bh=7RGTdc8lk7mir7hsMeUENMX2iLD/M/D7x2QjNKZL1Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AD51ueoX2bLvzpw0v7BMC59n4SwZfXPKpdlbMQ//CwhWXz+d0Hp4gd02MX52ICCDCVMUj+Ck3CxJpO6U8c0PkyzuPhkERjEzB/0RX0IvNEGbZrrkyTiU5YiVHsOEDVvupOtB+hjVNy3/2aL1VRCLFlq0GjGxMMxst9NRnhAtTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hILAVs+z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so2360580f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898502; x=1740503302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hQRUblb+vO7RJ4YMQbXRW++SdGt5uub9rk+BJCkK/4=;
        b=hILAVs+zprRE9/+v3GqxrRfXvt87lClFs4t3NWMEkURnS5J5RRSLfo+pjV2gW/tIzS
         T7aYzQ4Vb69Zx6LrlEhpG6tqkcJgJaIKZlzOf7uVVrx6E+kK4O7OIeY0NHn8KI0OHGpe
         fRAx5xe78Xety7jkUN3J40+2IjX27kGSHvcuTKXikPyyxMIsDw7ZmyEcKPeT0iE5Ry2u
         CN4JfPd/8Kc/9kSd6TIDM6689N4mSN4xpGAxxZqjI/CxWiVT0QMAJ7CkgtkcHgZCOZ09
         qKoFkZraYVM8RXDcduFbT6RQ1OOnjq5M1o4ps5+qso+HYmu8IBjjX4yZT0I3LAP0C/CT
         Uc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898502; x=1740503302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hQRUblb+vO7RJ4YMQbXRW++SdGt5uub9rk+BJCkK/4=;
        b=N89iX1MGXE5tFwEamqM4o4kWQMqmCOBN3fCrTRw2lucqIVRfelI6zh9h112R13Z0Sm
         z3HZOSPNUwLHJbj3bVALxKFqYIWkxiQhVpXvu3WQxpDwQBO4qC2HGqCs/NPsXkT365UJ
         T6elmJczsz1ULtjLubkrqv5DIoecmHq9mBrPmgk2O1RbxG0jV4NARQCqh60yICzn+AlJ
         vKa8W3eUk5KsagVz7jS4f+PA+aaRQsI20qGG3rABsE9SxbZoTz+oVi6qjPqFUeExsfs+
         Zu6r99fuU30nnLd5Z2hfEMGReGXvjEfeXtEVCCB36yxZBOibQp3kbGMs1KmGZ6MPGNWu
         bl0w==
X-Forwarded-Encrypted: i=1; AJvYcCVDSmpR8narm9gKiCrBinln5NXN1DHW+om2WUDaquWokgm731K/EimJG2qdxmHjG2XscWihLZtUmAifcWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbzyP/qP9T+2y5SseqUfGIqiq+pXigz7MAbqTdMY+41cPg4Yd
	sIK0F7WBwtubckuP4mF5mdn4lE7n7pr48E675IJKs9nnWDO/ga6j
X-Gm-Gg: ASbGncsiUHLj1BMNTdtFDPr5eWXNM8WFDd6SesfLpd5OFPFmPudiETLY6Gb4kTeZEC3
	ZKENCmiI/ZseAcIsstzOiJl5tlRrAd6umkq4yD8Bw1ubaxWvnhn+UyadVoqKMFhGAg1fvns56pE
	DyzapQcVDovb+4hcnFOD+eHIQmbfWNSbISjLlMTud3nI+HszgdTC6tH3grcSUAOMisJB/y6cCVc
	B1XlXeQN4o8RNzyo3DOfdRFpbBhDeJEuAjKF+lGs4xydUxkgbkL4tGPULyBpUK9Q5yv4n+S3yJh
	Eb8U20hvrWWuYg2fqw==
X-Google-Smtp-Source: AGHT+IFcWb1Y+wG/0Wid8Odg/wbxw6fNIMjnOHVTs78p5eZGd+zacraSrMvuQdfCFFp6AbRWpnHw+A==
X-Received: by 2002:a5d:47a9:0:b0:38f:4531:3973 with SMTP id ffacd0b85a97d-38f45313bccmr6180267f8f.4.1739898501833;
        Tue, 18 Feb 2025 09:08:21 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:21 -0800 (PST)
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
Subject: [PATCH 07/16] drm/vkms: Allow to attach planes and CRTCs via configfs
Date: Tue, 18 Feb 2025 18:07:59 +0100
Message-ID: <20250218170808.9507-8-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes/plane/possible_crtcs
that will contain symbolic links to the possible CRTCs for the plane.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  9 ++++
 drivers/gpu/drm/vkms/vkms_configfs.c | 61 ++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 4e87d8a81844..3c9d72bdb65a 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -97,6 +97,14 @@ CRTCs have 1 configurable attribute:
 
 - writeback: Enable or disable writeback connector support
 
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
@@ -107,6 +115,7 @@ Finally, you can remove the VKMS instance disabling it::
 
 And removing the top level directory and its subdirectories::
 
+  sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 88037a57a138..7d5ebdd45d53 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -37,11 +37,13 @@ struct vkms_configfs_device {
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
@@ -70,6 +72,10 @@ struct vkms_configfs_crtc {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+#define plane_possible_crtcs_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, \
+		     possible_crtcs_group)
+
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
@@ -195,6 +201,56 @@ static const struct config_item_type crtc_group_type = {
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
+	mutex_lock(&plane->dev->lock);
+
+	if (plane->dev->enabled) {
+		mutex_unlock(&plane->dev->lock);
+		return -EPERM;
+	}
+
+	ret = vkms_config_plane_attach_crtc(plane->config, crtc->config);
+	mutex_unlock(&plane->dev->lock);
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
+	mutex_lock(&plane->dev->lock);
+	vkms_config_plane_detach_crtc(plane->config, crtc->config);
+	mutex_unlock(&plane->dev->lock);
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
@@ -301,6 +357,11 @@ static struct config_group *make_plane_group(struct config_group *group,
 
 	config_group_init_type_name(&plane->group, name, &plane_item_type);
 
+	config_group_init_type_name(&plane->possible_crtcs_group,
+				    "possible_crtcs",
+				    &plane_possible_crtcs_group_type);
+	configfs_add_default_group(&plane->possible_crtcs_group, &plane->group);
+
 	mutex_unlock(&dev->lock);
 
 	return &plane->group;
-- 
2.48.1


