Return-Path: <linux-kernel+bounces-532152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A30A44989
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62A13AA4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1A20969D;
	Tue, 25 Feb 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI9Bhxiz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FE1D8DE0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506393; cv=none; b=TkQpP2rEqZfvq0zFuHJy0S5w4LCPh0g/Ug5PLepPv5pH5xX9E0/6mnS6YIiQETjXUjaRoKLSq9oprPtLmd3ZFNHppwNRqH2ECrMtKtAiPP8bkMRddjgOavcDJwqNyzsB1YaHyU48+QvqumCQmtJUUfFcmfatYy0xQJVHsZ5V1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506393; c=relaxed/simple;
	bh=SbQ88RpZIHr9N4mLaj/9ZsQHpWb1Dk4T71SJQ1uaEcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVCdI0Cxml37HJK9ZYaJjvVG2urUvKtFDxpCFZTUj1pJereD2wpQ6MDXGp/nRXrZ0IJ3PN1hc25Nzm9Y1eU4nuAcG9OCout2AOhAAlympyFv5mHPbBw0F1T8h4Q324wIKW66gbjWpso4SG7Uwm+Cvc3FcsuygsE4HldtNErN65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI9Bhxiz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso459265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506390; x=1741111190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTsFuw25JN5p3fGYw8niDWV82fMArp6L/Ntua1mS02k=;
        b=AI9BhxizfAAMmCsow+sifKdCWdfZ3Wk5ratGK40qlCsjef5iLsJzjov0/RXZXEns5E
         C1b/YhN/s/iCZcnQz5YQoDvT2r3I8RHklTxdMBcsTBFqWF7vB+yK4cvdTEj10XbriTOo
         6LGxnLdadMet+3iKN7rdV5ippjM6NahtnTEfedhUmipeI278LSmmIPXi4k3tqYAMxO18
         bucc8QrF8CXA4U6ok0UBeioRp9ulgaEyMl1NZvM1DkBke7IfwORtUxh2GPZmxlGNcSBf
         6YTnjv58hZvE8S2VRbkWMgDotZL64yNXFKZOjYouSLrVNWMkG12YmO2yMGoMiy5kYeRj
         N1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506390; x=1741111190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTsFuw25JN5p3fGYw8niDWV82fMArp6L/Ntua1mS02k=;
        b=Xf8Z2VWqODCvs49ah+ZiclxJbixIhGqyOwPCekQXfkT2+z1B1Hdy4snwYXPDJCY6qj
         BlsOHS/UcCQsEUd8CCZNxF6KK5BtmeTKTJcIsyMlftm15D6WeSlx9Gj74W2hMnQIMDal
         s9PegFcPapeCHpjsjydMqpTrWDAFeyizQm9UB5VgZJzvAlU3klypMfZMrvuq39SqTznM
         74xzj9ch4OIzZXb59jDALB+QCztL/SqnxW6tguehD+J8LA6F23Bzk2wf3/3z6WXRRU7o
         GfJgt7MV3BU7S7/LUVvpaFdJ5BuIL1+qAY95N7mI3dglTb0Fg5SfF+bam1WK4LmDn1XJ
         MezQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIrt06zYm5QgSyu9PrgWNbisJp4pU+CCOfUuJSvxgAs4Qdy6Rz6OT79OB/MqMM3fc8R3b7z3UYpm+BN6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEZUqPSCHbdS4vSGZrFHzSWYszq9XK55ZJTSfns0oKFXRIEPb
	t8gVlFYm3vzq6CDLadtrnbOypeggo+P0sEQRG9jrieS8KogdStwW
X-Gm-Gg: ASbGnct0+e+hpbcJUT6IXhzplSy03hDmgwpD2W2AyPf13TbCl1KEZfNK4sM3QmYNK4j
	T+KiQmrWqS+owqbI8B2ru0MNU1+iM5pfTJXE7/ICoym8ArtSQ8O75LcW13sA0Vq3ZPe+idzr5w8
	ic4xOpBCL7TLZZehqOv8XCQWJihl3nSiBHC8qie18HiNa6AKki4a64qAE5HJaPyTt0e1sEyqj31
	fPSYZnSf0K8psKeAJxT05ihPrUmu0pVumMSKLKlVfG70+vzOMCD6m4C+j/fPBsga8q2H+Z9/CoG
	X28/z/2n8fjrLD2Kb/ZOuf2llm51
X-Google-Smtp-Source: AGHT+IEOazIMO3dYrk+eRsHezFG2wuGzjSRuNjHFFDNYiidmpZhlQQKcv5oVveo+glrBODNV5JWyUg==
X-Received: by 2002:a05:600c:46ca:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-439ae2d1f3fmr145310205e9.3.1740506389953;
        Tue, 25 Feb 2025 09:59:49 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:49 -0800 (PST)
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
Subject: [PATCH v2 08/16] drm/vkms: Allow to configure multiple encoders via configfs
Date: Tue, 25 Feb 2025 18:59:28 +0100
Message-ID: <20250225175936.7223-9-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/encoders to allow to create as
many encoders as required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 85 ++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

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
index 09d1f2224d01..cf865728abc2 100644
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
@@ -333,6 +353,67 @@ static const struct config_item_type plane_group_type = {
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
+	guard(mutex)(lock);
+	vkms_config_destroy_encoder(encoder->dev->config, encoder->config);
+	kfree(encoder);
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
+	guard(mutex)(&dev->lock);
+
+	if (dev->enabled)
+		return ERR_PTR(-EBUSY);
+
+	encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
+	if (!encoder)
+		return ERR_PTR(-ENOMEM);
+
+	encoder->dev = dev;
+
+	encoder->config = vkms_config_create_encoder(dev->config);
+	if (IS_ERR(encoder->config)) {
+		kfree(encoder);
+		return ERR_CAST(encoder->config);
+	}
+
+	config_group_init_type_name(&encoder->group, name, &encoder_item_type);
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
@@ -433,6 +514,10 @@ static struct config_group *make_device_group(struct config_group *group,
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


