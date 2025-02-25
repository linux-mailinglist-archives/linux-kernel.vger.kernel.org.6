Return-Path: <linux-kernel+bounces-532154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D174A44962
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B717AFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60E20E020;
	Tue, 25 Feb 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWY6ms8q"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC6207DE0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506396; cv=none; b=IINqqDcZkDsyraxm9IsATHQDsv1eIvO2JbZi8MLJb+7+lDI/gAD/d4N2xaKcm7pQApjwZD+3r0Gglq6w5zFfJe/txTfRN38XAsZ16GiklTokbDA4WJrxXFD3jswKfNFwngsS56uEpTgdaZYKIr0P/6nc5iwojAzobjBNWLq0lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506396; c=relaxed/simple;
	bh=IxXEAtaGp3S8bSB/nGS/X5TdcH91rxq4SWWZGWuEYP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4Onl8sKsfljQPeO+aGsgb51O0ibdgi07TjRyXElHSaM7YX45KPshQwmn+kR7tNyklLEuPBvCZg3ur5+JIBshPImI98AQvrBL3fvmCvWZkCnm4mHqrC0nfXnawZVN+0nreRqXyDih6LKFVWXSiE6d5U+4F87pYMrXycXMuLGPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWY6ms8q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4399d14334aso52020675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506391; x=1741111191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ERnhTJ83jS9HrIxUIwFbH0bG0W+iXLYtduz4GOdzo4=;
        b=PWY6ms8qJqbr7rZ8GKSnhzGV5YZ/CUZowblPWliFu7W0qloyBqpeSakJZfDst/+J+H
         nfJvEqFMbi9Ul3iVXY2XKp87UiFMFbXhVbv5tleLKErTpTTME7PpM0qbacZ4Z05kNN6H
         TJpFYVc5OniKqerODZZk1HcnBcUIwBMSpm+DmaxXMXoGa0dXI5SamlSBCFHon6v7A0Z9
         DFxDiuXst2J65yI1vGxxGeJkrQHDgJ4gQPy9R90QWxIQvF89StuSTr9lYu71qfD21A8m
         M7GujiFyS7G7J8VH11NwcyvQ5GfOS3E9Npsi4rmSgUy+jJMPwLvGw9syFmZj9WdOThNf
         Dx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506391; x=1741111191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ERnhTJ83jS9HrIxUIwFbH0bG0W+iXLYtduz4GOdzo4=;
        b=oBpScQQmDwxms5ASVuWKM9YkstMg+V0kVPIplzBE46ix8ZZp8mIF6sggBQlsZqw/qg
         njNxrictr9UDK0ELevTFR4lzGHEjEjUAvDpcN0eJllQh4uTpVKuifar8VM/o8P7lMSCj
         Plvf3hjfE0jQS2YzDMYx7Eww0kY3uxb6Gd4aogQuolqIzhU8fAmSQMOWy0aXcWEYyG6u
         3iIyM91+/BV0kWEgvHt1CJ+7INBuOJRRca/LKMwJbvwiSiqUqLbHHhdm3zWYG4JObWiP
         gxqcvw6ahORRqFJZr+VTwLMUm0KNeUmyeIFZO2AY6nixiIfiOg26tJFytYFbwvx1sKNY
         YBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWu9iMeZCYpu7m/mAf2CL4qL7HaB+dA1y64EU4X01UMoak3TcfAIQlTylN6E6M4H/G8wOGYxHrKJx0XtL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVVYFVMxwN6oYMeqx2H7dWE2pxkLFF31ASeSM6Hi51wXmtQL1
	R3KKGulomRGlVZ2l1G0WQj4X4LUcfRjyjQUI9f4B83Hq6VwFzMEI
X-Gm-Gg: ASbGncsNkJhd485Co/UcpvFxEr3sySNYdC6ocqXgzGRKGBsAjSU0iUBeAhbU0YsvF25
	B/oGfAFLGTf2FEQbqWrLTS5nP6T3KtMRm1hOVBsuc97KJFXvDvflcRalEu+KF38NiiBtCVvZOGI
	zmVVb8JvSGwzixAqTZGizTnX4RbMFElVfo+Fqy3epFquB6uxsF5vcmrTe4VyWya/jZwPPbSPAmR
	D5A9g++8V3pC92dYjBj76sl3dy3oZLEMRFSQ+/49dIjYZDTRRNjgKzBe9G4mAQHUq3N/L8X8+Ym
	1PZomTvRMR1EOZ3Gq0QYB0d16e8M
X-Google-Smtp-Source: AGHT+IHCWQpZfQj2ZmqqchJwQSTf4iypFQkgwB0Olxc8jlH2dpN0x4GiKPXIgyo4G4hwCub03XS22A==
X-Received: by 2002:a05:600c:4f86:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43ab8fd73f2mr4044375e9.8.1740506391126;
        Tue, 25 Feb 2025 09:59:51 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:50 -0800 (PST)
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
Subject: [PATCH v2 09/16] drm/vkms: Allow to attach encoders and CRTCs via configfs
Date: Tue, 25 Feb 2025 18:59:29 +0100
Message-ID: <20250225175936.7223-10-jose.exposito89@gmail.com>
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

Create a default subgroup at
/config/vkms/encoders/encoder/possible_crtcs that will contain symbolic
links to the possible CRTCs for the encoder.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 55 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index e24767448775..650dbfa76f59 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -106,6 +106,7 @@ Next, create one or more encoders::
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -122,6 +123,7 @@ Finally, you can remove the VKMS instance disabling it::
 And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index cf865728abc2..64aa10cd3156 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -70,11 +70,13 @@ struct vkms_configfs_crtc {
  *
  * @group: Top level configuration group that represents a encoder.
  * Initialized when a new directory is created under "/config/vkms/encoders"
+ * @possible_crtcs_group: Default subgroup of @group at "encoder/possible_crtcs"
  * @dev: The vkms_configfs_device this encoder belongs to
  * @config: Configuration of the VKMS encoder
  */
 struct vkms_configfs_encoder {
 	struct config_group group;
+	struct config_group possible_crtcs_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_encoder *config;
 };
@@ -100,6 +102,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     group)
 
+#define encoder_possible_crtcs_item_to_vkms_configfs_encoder(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
+		     possible_crtcs_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -353,6 +359,49 @@ static const struct config_item_type plane_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int encoder_possible_crtcs_allow_link(struct config_item *src,
+					     struct config_item *target)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct vkms_configfs_crtc *crtc;
+
+	if (target->ci_type != &crtc_item_type)
+		return -EINVAL;
+
+	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	guard(mutex)(&encoder->dev->lock);
+
+	if (encoder->dev->enabled)
+		return -EBUSY;
+
+	return vkms_config_encoder_attach_crtc(encoder->config, crtc->config);
+}
+
+static void encoder_possible_crtcs_drop_link(struct config_item *src,
+					     struct config_item *target)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct vkms_configfs_crtc *crtc;
+
+	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	guard(mutex)(&encoder->dev->lock);
+	vkms_config_encoder_detach_crtc(encoder->config, crtc->config);
+}
+
+static struct configfs_item_operations encoder_possible_crtcs_item_operations = {
+	.allow_link	= encoder_possible_crtcs_allow_link,
+	.drop_link	= encoder_possible_crtcs_drop_link,
+};
+
+static const struct config_item_type encoder_possible_crtcs_group_type = {
+	.ct_item_ops	= &encoder_possible_crtcs_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static void encoder_release(struct config_item *item)
 {
 	struct vkms_configfs_encoder *encoder;
@@ -402,6 +451,12 @@ static struct config_group *make_encoder_group(struct config_group *group,
 
 	config_group_init_type_name(&encoder->group, name, &encoder_item_type);
 
+	config_group_init_type_name(&encoder->possible_crtcs_group,
+				    "possible_crtcs",
+				    &encoder_possible_crtcs_group_type);
+	configfs_add_default_group(&encoder->possible_crtcs_group,
+				   &encoder->group);
+
 	return &encoder->group;
 }
 
-- 
2.48.1


