Return-Path: <linux-kernel+bounces-519930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6EA3A3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B8D1896E31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86C27291A;
	Tue, 18 Feb 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVi6Wz7l"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476026FA57
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898509; cv=none; b=Uo9WK+OqtFbvkMS177si845tghFg0f+Y7+/EEc2ax83o0Xi2WQjmSlrSs8+pbWb8+wS3zPYI2vza2MBgt+PVXDQQitGjsFgpVWF+XGurxXSCpy335z5pwEshqDIcsJ8O7h7HacedeIo9uIJjdHkQf+TGDF/J05mePW48LFtAhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898509; c=relaxed/simple;
	bh=10qJz4DfL30OvLuBYfai46DKiU2YhgUqLkSq4zK5/SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIaffGD89el7D5bU02+Mu677ZNFCLYHUjoULUcz/CyfhO/kJepnHWuKefCFAxIoogiv7MRSb6ZKtEV3jDXCKDT/gVe0/SgzcwxWoRlzFZ97pD34e44YyPPHNLl8jDmz11Y+foGEseKfIxci23a3DbWHqrPYK5unra5eCxY2deJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVi6Wz7l; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso64224775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898506; x=1740503306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxl4nD/rAmawJnGv7wGWIydakUQ3xQq8ck/CP82D2ZE=;
        b=VVi6Wz7lee2w9IQ08OgQF5/rNnuPB3fRbBz65sfFNg55RbzYBH8cfAFar8DWizH479
         iV57dp7ennQMYO+WcjGEJ3ufQn8KznnJUYx6BZorg+DDPBioJIX/uVe+Gw46LmaS61Ve
         ml+KTgH2TaOdXjTAoNNyGfXs6uS5BocbcotVr2B/gXQ+EmV7QAvsdvC01fGEla6Wf6kP
         3V7PqhAblndpS40kmghk1wdeTJttBML2eHg8YjU0SNDnRvZPCM7PnBxSa46LqoIlfQeN
         LGMmgadbqGUWgS1MdHMoJnjX+B1MWG70VGuUQe3W5bwkyc5gNMFsoG4w3lPMyjSKecYj
         4NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898506; x=1740503306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxl4nD/rAmawJnGv7wGWIydakUQ3xQq8ck/CP82D2ZE=;
        b=MIy/iFKMZuncXVE57wJPBwmoBI1VEfn8YiWgViOLcvQmdazvrDgmt7F7LGxFXudrLN
         d0YOJ9ZVeVT9cUb6gEq//YAP7JTKip03N6FHfyB4Uc37dWXje4+SwFNArYrjSNyw+PWo
         sRbC4/2BKoIDtT83jUY908+zzWdCT0zne5Lk1eA9SBM2PWbyT9l68nUJxB4nh/ywRG0X
         Nva4mo2wI+mw8tnA4Z3E4YrZXe5oiz41SlLgJ8Y7DV18rC0jwIM73NWRCYm1dwj/gRqY
         O59//dzKj/0r/eK/EzOk+1hVSK/oKnk0p3W176uG9O8fnYFbyl3r8VcNBxccaDyawwDR
         6Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCWYfuTglCP11WJ/tnZojXBl1w59qqelwuMezXDhf6eNQBS9cqn6bnvqjH2uRatpWnVSYUGtjU/V+PWQULI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUJCD1CmY3fXbiLzpaxC9dOgzTXCM1X5NgllkuXlh/mNDzRHT
	D9jfCJ1exfLTLI0RaYsKW6UuRSoI4ZNSTIRhs/6MP8jl2dVIJ4TW
X-Gm-Gg: ASbGncvKBpr1/yrRLbDSOoaM+pcfNDFDZns5rHQl7QG23xiSESHSrkeoTn4yMfp8k0R
	/VWGIJeVLwyaXH6KejruZ4GIzBpyxkeu4MJWbWrHTKeZzzSBYtN/cXyosMIqxAEJ0qZkIt9AYwK
	0zyiUitGXtmtGi00Ip4CH29PC9AeqGSwZhbfjkXr9adrp+493oEt/9nGxK2Az2R3O9aPVYD/Vj5
	Aqcm00kLTbDivlvO/LJwJMuXjMog5TWRWdyr2KWURZe5ffetORZuVLD4A22+kI9iPnV8UgtxjLq
	2yqn/f0yAfHTTKjakw==
X-Google-Smtp-Source: AGHT+IFOp5iSe+2jxXvP5iADRB2bGk089MQxVl+L+ViO/4h4dBkCGWhr8Swc12hrEHrxNb5s4GEhDQ==
X-Received: by 2002:a05:600c:3b8c:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-4396e716f3dmr134120115e9.21.1739898504233;
        Tue, 18 Feb 2025 09:08:24 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:23 -0800 (PST)
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
Subject: [PATCH 09/16] drm/vkms: Allow to attach encoders and CRTCs via configfs
Date: Tue, 18 Feb 2025 18:08:01 +0100
Message-ID: <20250218170808.9507-10-jose.exposito89@gmail.com>
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

Create a default subgroup at
/config/vkms/encoders/encoder/possible_crtcs that will contain symbolic
links to the possible CRTCs for the encoder.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 63 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 24f40128e8f3..6a15af0b7317 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -105,6 +105,7 @@ Next, create one or more encoders::
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -121,6 +122,7 @@ Finally, you can remove the VKMS instance disabling it::
 And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index d7efa50a3fba..66c8a66f7b2b 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -69,11 +69,13 @@ struct vkms_configfs_crtc {
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
@@ -99,6 +101,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     group)
 
+#define encoder_possible_crtcs_item_to_vkms_configfs_encoder(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
+		     possible_crtcs_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -402,6 +408,57 @@ static const struct config_item_type plane_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int encoder_possible_crtcs_allow_link(struct config_item *src,
+					     struct config_item *target)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct vkms_configfs_crtc *crtc;
+	int ret;
+
+	if (target->ci_type != &crtc_item_type)
+		return -EINVAL;
+
+	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	mutex_lock(&encoder->dev->lock);
+
+	if (encoder->dev->enabled) {
+		mutex_unlock(&encoder->dev->lock);
+		return -EPERM;
+	}
+
+	ret = vkms_config_encoder_attach_crtc(encoder->config, crtc->config);
+
+	mutex_unlock(&encoder->dev->lock);
+
+	return ret;
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
+	mutex_lock(&encoder->dev->lock);
+	vkms_config_encoder_detach_crtc(encoder->config, crtc->config);
+	mutex_unlock(&encoder->dev->lock);
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
@@ -457,6 +514,12 @@ static struct config_group *make_encoder_group(struct config_group *group,
 
 	config_group_init_type_name(&encoder->group, name, &encoder_item_type);
 
+	config_group_init_type_name(&encoder->possible_crtcs_group,
+				    "possible_crtcs",
+				    &encoder_possible_crtcs_group_type);
+	configfs_add_default_group(&encoder->possible_crtcs_group,
+				   &encoder->group);
+
 	mutex_unlock(&dev->lock);
 
 	return &encoder->group;
-- 
2.48.1


