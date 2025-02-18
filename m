Return-Path: <linux-kernel+bounces-519931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCEA3A3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9309F3B19DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738B26FA60;
	Tue, 18 Feb 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAt8edWQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62927129C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898510; cv=none; b=dIkdLI4Rsac7a/a6e5y2OWtQRdqUPnMDQoTSnliJ1TZHyxSAW0/5zqZDVAxVcQW/o83HIPyzAS+XQaRdjaFHPOXUB1idKFXUFm5xoDSeUS/a22K4ZrDm2SJ759KpuLCU1w2lvsR5RQm2tDr2W8MAJ7ZsrsR+btVjy9epSmJGeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898510; c=relaxed/simple;
	bh=qgDaNlR3toGwf4PKOUuHn0mQ4R1n5ygtIL9zeLSt4qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FszK6kJLMx6Jhe3QF5PJsfyvbtPoTUFbBNXwIJvjlrN2RH40g8m8NoX25WyJfQ85+0ssMrxH0rehcmhNGqNM8Dfd/GPZ7UGMRF420x516eJhAWzFaMA0I+knJUL4oEKdls3fT9LIQMKBG9XuNusu+XsZwwq++SM9ZEP86lW1YkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAt8edWQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so2360626f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898506; x=1740503306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMh+KUfn1etWGOIGMQruCkQ1YBGyd1feerZxvX24mUE=;
        b=LAt8edWQeiP1rHrTxJ0VWoU1xEv5X3+DwphDMRHYVtpXmZnjv2Gr/x1AFcDdzkAcxZ
         4AYvPrwJTzDrrhi7pXnN040SfDoZq363zDdUgKa25jYWVWpJoZvS6U9pCwbGSLRtTayj
         2FGRhXPG3BEimDTYiMcNkrIV3uCHoJXVul+/hREuYH2KACG2bNLaxrCZevkVMXTk3Blb
         Z7hVoj0WCmyVy78tK5s25qmMywW6aBuw+/qsWe7MRSGzZdpgLzrHw0SV+MOQVpTCf2nx
         tOEdn+nILDgRpy+gh6SjkktCeHYxJCqLlgs/AebJJqanDWVRKm3bxC5mcOrOIyhdKmNm
         fbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898506; x=1740503306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMh+KUfn1etWGOIGMQruCkQ1YBGyd1feerZxvX24mUE=;
        b=RPtBVAplMbRqKaztmOVwvICWxeoYEXP8c6+ei/HBfh6iy7lYxfM9BJxQ4BrbW+fypa
         dZnkw1nYeA9yG/dWDZ4ZpTwzUs58NzO1mk2Z+PKDLKK8s8umgzsN38djOcw4sTvINpLi
         zcdw4SvBXs8e+LB5aPM/dHYlZSZjeGs24LbS9Ql2DCVTybzURFncmmbTUhjpGicvJ6wP
         15DaHoUsqQsnUWJRewTdUTon06IR7fjZ9YiQa/4jJCgKNt4EgW1oN9kNOKry6Bm0Pha/
         pzNyGv9JPJ32lKGJcGV3jXlWONV6J3MoW88QM37Yn6ZTeWn5HSCvjCFiqHGAgVfwln2M
         AjmA==
X-Forwarded-Encrypted: i=1; AJvYcCXHPLC5zjTZotztV89v3U3K1Q1mAJoGqe01PhDMl58uttiN2t4AFzcVRdqMHQbie0NLGAuQuL55QivLNUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1zeSVH/Y1PeHGh8gLTLv8nJ5cpJhFlBMRdWolemOCpB/GFIp
	2n/rFc7K0ZodhuIk7Q+/qp/40HFJOsLbniygXH3kcFgskreqZpeW
X-Gm-Gg: ASbGncuh/vaNL+AaDjUFBc/HPtMtFxptjDmlUZLbmjhIXhrRmte5+e04HriUhRglhed
	gEOQRN//QJDTPYNjFQ6FV0yzvVSvmNvjBf1tlRujyLxuTkrMj5h5lbZtYnJaOPhVQlpEq3gMXeQ
	wgcAfY1LFPDxluTr4mLyQD8C5yq0yPa4I21cUoJi6w63tvJ9p0sP1phQiIymOc7pY5YwDHBs2aO
	lnxNvYy3PbX4ac4xkeFiVr7IPgYotHIZ5dkgFQLkUeOf2nivu+E1ZWblUMiRY1doaOh9XNPcrw/
	S4OpcxUbqZZPEdXXdw==
X-Google-Smtp-Source: AGHT+IFyFS3GiZT59tCTqcUuta/dOVRknOAV/MGyTCdLGGBN9rKzilnjOpZ3GrgUo/1tmo6lnG8kkg==
X-Received: by 2002:a5d:47c6:0:b0:38f:3ea6:1b98 with SMTP id ffacd0b85a97d-38f3ea62215mr10025877f8f.31.1739898506471;
        Tue, 18 Feb 2025 09:08:26 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:26 -0800 (PST)
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
Subject: [PATCH 11/16] drm/vkms: Allow to attach connectors and encoders via configfs
Date: Tue, 18 Feb 2025 18:08:03 +0100
Message-ID: <20250218170808.9507-12-jose.exposito89@gmail.com>
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
/config/vkms/connectors/connector/possible_encoders that will contain
symbolic links to the possible encoders for the connector.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 66 ++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 3dd55c3e8900..0212e99e12dd 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -111,6 +111,7 @@ To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -128,6 +129,7 @@ And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/connectors/*/possible_encoders/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index cd8a164bda3d..9036d9983078 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -87,11 +87,14 @@ struct vkms_configfs_encoder {
  *
  * @group: Top level configuration group that represents a connector.
  * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @possible_encoders_group: Default subgroup of @group at
+ * "connector/possible_encoders"
  * @dev: The vkms_configfs_device this connector belongs to
  * @config: Configuration of the VKMS connector
  */
 struct vkms_configfs_connector {
 	struct config_group group;
+	struct config_group possible_encoders_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_connector *config;
 };
@@ -125,6 +128,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     group)
 
+#define connector_possible_encoders_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     possible_encoders_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -583,6 +590,59 @@ static const struct config_item_type connector_item_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_possible_encoders_allow_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+	int ret;
+
+	if (target->ci_type != &encoder_item_type)
+		return -EINVAL;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	mutex_lock(&connector->dev->lock);
+
+	if (connector->dev->enabled) {
+		mutex_unlock(&connector->dev->lock);
+		return -EPERM;
+	}
+
+	ret = vkms_config_connector_attach_encoder(connector->config,
+						   encoder->config);
+
+	mutex_unlock(&connector->dev->lock);
+
+	return ret;
+}
+
+static void connector_possible_encoders_drop_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	mutex_lock(&connector->dev->lock);
+	vkms_config_connector_detach_encoder(connector->config,
+					     encoder->config);
+	mutex_unlock(&connector->dev->lock);
+}
+
+static struct configfs_item_operations connector_possible_encoders_item_operations = {
+	.allow_link	= connector_possible_encoders_allow_link,
+	.drop_link	= connector_possible_encoders_drop_link,
+};
+
+static const struct config_item_type connector_possible_encoders_group_type = {
+	.ct_item_ops	= &connector_possible_encoders_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static struct config_group *make_connector_group(struct config_group *group,
 						 const char *name)
 {
@@ -616,6 +676,12 @@ static struct config_group *make_connector_group(struct config_group *group,
 	config_group_init_type_name(&connector->group, name,
 				    &connector_item_type);
 
+	config_group_init_type_name(&connector->possible_encoders_group,
+				    "possible_encoders",
+				    &connector_possible_encoders_group_type);
+	configfs_add_default_group(&connector->possible_encoders_group,
+				   &connector->group);
+
 	mutex_unlock(&dev->lock);
 
 	return &connector->group;
-- 
2.48.1


