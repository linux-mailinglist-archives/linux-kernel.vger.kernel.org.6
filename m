Return-Path: <linux-kernel+bounces-551545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF8A56DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959EC3B6FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF7241684;
	Fri,  7 Mar 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQdzUPF8"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669924110F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365254; cv=none; b=pG6VSGim/xKN8dSOpl6+j4IUoWpfLapX/RKb1LynXzPPPFa0hJQ1s5JbKGm8k+hjk3FgkZj/2fgAT8nwnC8ndi2DmWDhjmF9UZxPnLANo4Ustnm9oZZN7qOYfwuLNpo70UXuKblIZUrQxE2uKuOPM0VZuEsZ1bfNubCKJJ+n5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365254; c=relaxed/simple;
	bh=DB1jr0Y87rUNdGVZ8SE29fHPbDBw5C0jbdfwYkvJfi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev5/umKuOFHqnexwPqapd59VyJywAjRIFau+9nRW5UWhC5szARTSCNZcJSjrU7bN4FjGuGNNC+o5W6mvyz33vhj0/4mbFfZm2+0F5XE725+7v22dB4z0O3e3lbvfM2n4pyE4nojxqr2AWuhn4/6UX2ptmuu0MrKFhQfjRhEfSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQdzUPF8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so17640995e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365251; x=1741970051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++hf8G4nEk9Bpzh89kQV5A47zc/b6vQ6MPdCQxsR9cg=;
        b=BQdzUPF8sWRGwS+POraZObz1ubkE+PIPKyAyLmtH2fMH7H7I2S7UQ92+BJ39YmBhKw
         ZmRiEgGNu3BIBuqlkS5/NJ44z1wc1BRGjYFatnFQGKCgK35UtAFolJFAVQFBijuQbY0i
         mWvXItSEIfmMCpE54YE9kXkE5/GY76HTTHOiA/xVkgkreYVNpAW05hi1CBvOJhrI9FhX
         yBuqgW+ufHR/cGde+jSE3sOY8HnJXVpVf3LIuyEI9MLVw5lybM3QNJfEnTZ1YOpiW/xB
         qbg1sMofAMZ/2VuPQOpHlfzmGNm5oJavlToju9/j8brQR7tDTwJiY6zEXs45AoaukTkv
         E8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365251; x=1741970051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++hf8G4nEk9Bpzh89kQV5A47zc/b6vQ6MPdCQxsR9cg=;
        b=OspDTwrbAZ7WJoozwUILcLiAp/OkXvYWeRJnnsqAtXH0VZ7bCjP9nfBFdBl7fNEoYw
         sxH+1jjNGsxMvD2h/Cy/SjwmMQKD/64QnqxY7ftFu9t68GqJqpUeSJGrPiXr46vu/LdJ
         XyZNyc7H85mWSXk6Ugkn5XQ+j927sL5Ioy3u4i4VMsm8MB0V1wkU4CK0ggumyr26QCJi
         pyRlAYFKHjUz2cXRkSHQghgOBTJbVF641iDzcIsr0D306obgyXjziBIPmlVyN07OnKRb
         knj6PD2guF16yS/jBKD/iImV707BJtsFuS+uti1T6K3kAhUfByI7T6JdJYofWf8Wc8Db
         /cIA==
X-Forwarded-Encrypted: i=1; AJvYcCVCYFwAh7fXPdMfamYlo0peg8OP/sK1wrv/5/1x2X7Y9InQ6LYDTOKQ2up8SN0FGet1QMY0gFDb1sLycSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNl+KJEAxOa1Gg1nwG279GVmxFgTtZ7oDwjWwO7iFq//trItTT
	zuH2w1/e3pjRKGLuVhXskZclwknuMAr+7wQl8lHprqs54Ysk8OW4
X-Gm-Gg: ASbGncun3EMpxe1htBW3PtVhUYDmadgUfTlWHEpWf74uhyCrNWAclBQFprHPAUPA/Ai
	U4Xypx8lwPUuQUVUcclSHjXQ3fI5SOxaK6JsaT81wS3JCZYBK/QvJ6rM9mgBX6JvP0x8/lGBFNd
	pvetplDcfLJfi372ICbMCGwAy8Zp7NMtvCfQ2PyuHjcDnm8y4poWvuaMOqdRiXWmnMqoz0Egpwb
	n0eWRL1a9Qe9ATiVdTfBbGZU04y4SgvyiqpLT/srsBGv4OYsfXGMq0jsrd7PeRXjYtxMoSV4ImH
	Drbm7tmFphhk/k4VOipfAGLyIYOYpIEX6u529PFw12gPOE8=
X-Google-Smtp-Source: AGHT+IFRCRTbXpFBWuMUYNVgD4erCo26cMvSvBPI4MZCLSewSYGptXR8L/t9TuQLLLKD6G3ia6vuQg==
X-Received: by 2002:a05:600c:3b0e:b0:43b:d04a:3506 with SMTP id 5b1f17b1804b1-43c686f703emr25579665e9.25.1741365251122;
        Fri, 07 Mar 2025 08:34:11 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:10 -0800 (PST)
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
Subject: [PATCH v3 09/16] drm/vkms: Allow to attach encoders and CRTCs via configfs
Date: Fri,  7 Mar 2025 17:33:46 +0100
Message-ID: <20250307163353.5896-10-jose.exposito89@gmail.com>
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

Create a default subgroup at
/config/vkms/encoders/encoder/possible_crtcs that will contain symbolic
links to the possible CRTCs for the encoder.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 58 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 0df86e63570a..7de601e39d2b 100644
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
@@ -364,6 +370,52 @@ static const struct config_item_type plane_group_type = {
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
+	scoped_guard(mutex, &encoder->dev->lock) {
+		if (encoder->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_encoder_attach_crtc(encoder->config, crtc->config);
+	}
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
+	scoped_guard(mutex, &encoder->dev->lock)
+		vkms_config_encoder_detach_crtc(encoder->config, crtc->config);
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
@@ -413,6 +465,12 @@ static struct config_group *make_encoder_group(struct config_group *group,
 
 		config_group_init_type_name(&encoder->group, name,
 					    &encoder_item_type);
+
+		config_group_init_type_name(&encoder->possible_crtcs_group,
+					    "possible_crtcs",
+					    &encoder_possible_crtcs_group_type);
+		configfs_add_default_group(&encoder->possible_crtcs_group,
+					   &encoder->group);
 	}
 
 	return &encoder->group;
-- 
2.48.1


