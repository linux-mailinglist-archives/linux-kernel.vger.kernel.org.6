Return-Path: <linux-kernel+bounces-519928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC228A3A3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4036F1894FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7A271296;
	Tue, 18 Feb 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fufn+QG6"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2019270ED0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898507; cv=none; b=iE5lntb+4q3NWIPPZlbj66FZbT94tBBsltdOoUgur+D3PdktlXEJp5hFKdtZuK6APnLcHO86PrM/90BpCbk1zGoXQU8FqJ7iaTw9kq2lInS/i3GCsWbsTNenFWewwOE/639p47t7hFs1L7ZV463448gN0FNpkmZXUtscZ6SbQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898507; c=relaxed/simple;
	bh=VuelZb5gmcF/CrImU1SbT5eRtDQaQemg8yDuGmfzkw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCj4E+nZRlb5nNH3fGBa/6tZLolUZpu2YMQ/Fmyw8dRJm+XWjV+nlL6v0vtX+S48AiaQyHp6Uu7LE1188fbjpmgjc0P8T+jO13Y39G7v2N+dF6x9hSjmq8FHg03D/nciuFU4PJGq4wENgpKXRV09oz5obZdYyrSSq/vLUHECECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fufn+QG6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f31f7731fso2065909f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898503; x=1740503303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGOAV+n91+x7w7PPxVJ9AYuQQLXVm0lW+qAsfnT2Nw4=;
        b=fufn+QG6FF/8+f8rjBFhvt4jDSlAWXn9aI4UHreK9vGdJA7XOgtGwBKzmGhbBw2PEH
         fMqUI3RIai7JVEDVN7yOJ/EBwjYYNNV0BZPqyzvJsA6r0E9WTYzC7DYWDDOEpVVcTO0S
         PBiHLIyeM7klQeor0D3OQsf8nWmxyX0R4VKym2NaYJS0RlaDfCtUlGiGsPSUx58mCXrN
         t1tG93YX/V7MbUdnCA0uvKM0lLNiSQKcWoXODuSPdZxpAWHOj1ZN5JcT9ImTkRj/Hkkh
         TaQRudyL9BhhHnz/XkDjuKFfZKkevPMKe5sijvKLbnldGMFca6WT0nlRC7hVFpPnqZtQ
         oI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898503; x=1740503303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGOAV+n91+x7w7PPxVJ9AYuQQLXVm0lW+qAsfnT2Nw4=;
        b=cnvU3zwuIY0kqFMjQP9XOScbaCfe7sR2W3WRIb+I/Lz67UFVMaiRQdh9ZxTpdKm5WY
         03Fs3gFrEXmWKxYYua7MewojFui4/5iZrLBli30xG8rZMaN8gET1x5JyX3HcaCdrp1V0
         fnJj0iq75E5wjzE4AGbP4a5jwid4uQidMtTr3xAvbCEiSQla9USBhlx14wuNG/7XUGGJ
         ahRx4/3Y+QHJJEZD5mHWsBkVy6cQduNVl4jJfK5wM9dQIxIQEGxq05mXHn8N9Y7JXrx0
         keo2f4VnDmscW70KH3JEPuTBqxXSIztuuzpi7UD6/49fNFrDlP3BFdBwlUGBNCyTUsgn
         t6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIgT94UbtMX/qI8Mcfq2+ro/cxSUFi5S/PEWjKb2YTt7xvNt9NQhOZYn1/f7oIMCzbIXP+ULkXuWt+D2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+IdIYIhkWez9yU6M9hwJwzrkGeT+/QEb2a2kZdibiMQnlGMf
	NJyZrY3q16ngNbTOUT4x6isre0UjOuPuY3yKTg5ZyD/DgbY+3EJFAfHzF3LC
X-Gm-Gg: ASbGncvjXEUQ6x799xcU4Lm3ku7JC1W2glUv/xoUWicBgmWgL5G4NwJXE+ZnIx/7NIU
	jYU8AgRyjHyRMLa/Js6lu5dZdyb+kqtzB4sZD7F6uGhrniHrAxhb3IqBwfM/uaaZgX2qLXPcIoj
	Scm1S6hRvGXEAHUundonKDSIHmUasnqdf3ksnUj0YTelHLsu+akow5KNu6sgZf8jH2zSjGYcyU1
	ZwyBPg28n6rtb6tyO2P05OSP1ERhmd86ZBwYikfQQ36QEwAzdc4UJ0M3wZ4D/1t9Lv2/iu/P26S
	pZ+wxDvJq/YBKrbANQ==
X-Google-Smtp-Source: AGHT+IGVwOCse7i0Rjw0IStrwKsXzhkTTPNQyrA+eVwBPg5ii444ycnjb80RjsHuyBpDCbaSDwenXA==
X-Received: by 2002:a05:6000:2a4:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f587f3ec3mr204987f8f.51.1739898502998;
        Tue, 18 Feb 2025 09:08:22 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:22 -0800 (PST)
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
Subject: [PATCH 08/16] drm/vkms: Allow to configure multiple encoders via configfs
Date: Tue, 18 Feb 2025 18:08:00 +0100
Message-ID: <20250218170808.9507-9-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/encoders to allow to create as
many encoders as required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 99 ++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 3c9d72bdb65a..24f40128e8f3 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -76,6 +76,7 @@ And directories are created for each configurable item of the display pipeline::
   tree /config/vkms/my-vkms
   ├── crtcs
   ├── enabled
+  ├── encoders
   └── planes
 
 To add items to the display pipeline, create one or more directories under the
@@ -97,6 +98,10 @@ CRTCs have 1 configurable attribute:
 
 - writeback: Enable or disable writeback connector support
 
+Next, create one or more encoders::
+
+  sudo mkdir /config/vkms/my-vkms/encoders/encoder0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -118,6 +123,7 @@ And removing the top level directory and its subdirectories::
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
+  sudo rmdir /config/vkms/my-vkms/encoders/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 7d5ebdd45d53..d7efa50a3fba 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -17,6 +17,7 @@ static bool is_configfs_registered;
  * Initialized when a new directory is created under "/config/vkms/"
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
+ * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -26,6 +27,7 @@ struct vkms_configfs_device {
 	struct config_group group;
 	struct config_group planes_group;
 	struct config_group crtcs_group;
+	struct config_group encoders_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -62,6 +64,20 @@ struct vkms_configfs_crtc {
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
@@ -79,6 +95,10 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+#define encoder_item_to_vkms_configfs_encoder(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -382,6 +402,81 @@ static const struct config_item_type plane_group_type = {
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
+	mutex_lock(lock);
+	vkms_config_destroy_encoder(encoder->dev->config, encoder->config);
+	kfree(encoder);
+	mutex_unlock(lock);
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
+	encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
+	if (!encoder) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	encoder->dev = dev;
+
+	encoder->config = vkms_config_create_encoder(dev->config);
+	if (IS_ERR(encoder->config)) {
+		ret = PTR_ERR(encoder->config);
+		goto err_free;
+	}
+
+	config_group_init_type_name(&encoder->group, name, &encoder_item_type);
+
+	mutex_unlock(&dev->lock);
+
+	return &encoder->group;
+
+err_free:
+	kfree(encoder);
+err_unlock:
+	mutex_unlock(&dev->lock);
+	return ERR_PTR(ret);
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
@@ -495,6 +590,10 @@ static struct config_group *make_device_group(struct config_group *group,
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


