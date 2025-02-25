Return-Path: <linux-kernel+bounces-532156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E1A44965
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7F117BEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97F1F4185;
	Tue, 25 Feb 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQpai2FC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EB19FA93
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506398; cv=none; b=Kb7gG0Myldp47/d+C3brMRPIxXWu7oW1ub03H+Qsit1E7QU77VS/HOvfhiiQ0RewVf0Eh9bMKYBZsfZnT4foYm0n2cxqirxcsNZn7jSZnI6Og3394sE/W8J7gPlJMywmWPI2+I5MJA1eQvXXQJRvB0kUUkXeNgwukoE+8MqdtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506398; c=relaxed/simple;
	bh=mzLIWMk7O20DcPe67ZEoV9B5XSC7ARjIIHpYInnHe/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeFPaiVobbYUruDHFlJFAAsjLv5gjtaOy0L+thnHLlmaKKZQUhPpzatPAXrjjJfLW2I+RZ72fT1+Z4FIbqbwFNn2g1oXkS4C6VZfDCPLYHVd5j1xlxQwsJiMX4XJqdZ60JbuzPDJ2SOPTW0Ir3FwaAsppayah5yshKf9d224Prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQpai2FC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso35284675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506393; x=1741111193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWiThvun9v9oBFVV2WdtDnI+lemWxWkbnKGuQol7/Nk=;
        b=lQpai2FCSQVEEAKp0/nielHySbUdvIN2lbI+2gU7SE2IzqH3eWju74Z1Y2aEOavRvt
         QVSV6W1btx+XiIPnJrpl4TV/d1yIdqQJNCveZdlzX98ehYxsPKtoaBSsaK4X0t2s6KJB
         LZUKlidAHnpNBWMDOBI2sMjTfsHJPeqs/mcK9eXno0D/o7J/aFcjem1dddAOzWa4/gor
         FZRBVMkg3LCN7kcA3PpQbvabBhj5T+1TN/V9O4WX3Y0mitATiffro9ORAnWKf4/Awn5q
         Y3mqz63n09E5U7pnrcR47u3flAsIvjQ4dLFk5duEBBetnLnimLERBPT6Hc/L1NlGQ2Nl
         +Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506393; x=1741111193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWiThvun9v9oBFVV2WdtDnI+lemWxWkbnKGuQol7/Nk=;
        b=d7gWAwbsQzUwHG3nkQ6ByzpGpFrii/EBLWce4nk+OwavLKkk4L75oezG5peEVZeU08
         0VSvolLOESw6fUuLQEiMOdWpKpJepLiGPwHKkoxLkVp8Amk8JXGSMFH3wrT7xgV9yL0Y
         tE09EHuvGhnwCfOY7WgrebW0DUW6iiQMm1q2oOpArxjhheXkjfMYoGOHlvWILGp9/Noy
         OsO/85rc5s9wNCJ7CJBJ43pLE3riv9mGwGoavRSIP9lUzLL2pd+QWZ1p033M6bbq5Bnu
         L0bkoovJSjKXdcGI0nd3lFLHakkX3yhldLQkD+wPV5qI4r2vMi+CiXMHeiMmF0wWaB5a
         aq8g==
X-Forwarded-Encrypted: i=1; AJvYcCVxdOjgWgisElj6z4f8Ru/+5KVBX8SwZ+QPtjhPQu7DTplLp74SutyMgMXKus735zNiRvzdI5tVGUcIoQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRmZcvnOXTQinWWBHrVxZ/YxDFtvY0OcIF0AZdeI9UMqYyl0dl
	cBmUe5tHtiB5MxpaktihQs4bn8pWdV0u0ZjNhHAXBrsQbGSiMKlN
X-Gm-Gg: ASbGncsAKGJ2K/dFU97eDjahfwPqgw7yepNJVS3FRrLPZazV3lEXHyGQ8LXzYmtkIkM
	Asbbei82gOVvVCrtANBuWQclJKh8nsJ9O1Olf81pZrT3aPl0jluQ9vqRFCubZUMSIWFtZpVI5FD
	ktOGpt4XzJf+R7RRaYT2EzVMqp3WaoW44GVmdaaCHBy2wlN+IKYiLLFWK485MyheFrFXA4Psb+G
	Gmmr4YwKNAmIA48AWDkpHu+S69RGNGfKlCw9wAPBUmSfnSq3xTDoCcKtFzuG6R7dsz9CmhuZu9r
	vMQCn64niQiRYOF3GI4u8DsbMI0l
X-Google-Smtp-Source: AGHT+IG/QEmeDgGP8pEbID7bpFqeuH4nVI6f0hc07wTpQeF5+mhgQ8WHTlsm2+zkpyEBsYCIYCDp0w==
X-Received: by 2002:a05:600c:19ce:b0:439:94ef:3766 with SMTP id 5b1f17b1804b1-439aebc3138mr147139015e9.19.1740506393230;
        Tue, 25 Feb 2025 09:59:53 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:52 -0800 (PST)
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
Subject: [PATCH v2 11/16] drm/vkms: Allow to attach connectors and encoders via configfs
Date: Tue, 25 Feb 2025 18:59:31 +0100
Message-ID: <20250225175936.7223-12-jose.exposito89@gmail.com>
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
/config/vkms/connectors/connector/possible_encoders that will contain
symbolic links to the possible encoders for the connector.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 58 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 744e2355db23..74126d2e32e4 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -112,6 +112,7 @@ To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -129,6 +130,7 @@ And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/connectors/*/possible_encoders/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index bcbf91fbcd44..d4d36d2c8f3d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -88,11 +88,14 @@ struct vkms_configfs_encoder {
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
@@ -126,6 +129,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     group)
 
+#define connector_possible_encoders_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     possible_encoders_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -511,6 +518,51 @@ static const struct config_item_type connector_item_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_possible_encoders_allow_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+
+	if (target->ci_type != &encoder_item_type)
+		return -EINVAL;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	guard(mutex)(&connector->dev->lock);
+
+	if (connector->dev->enabled)
+		return -EBUSY;
+
+	return vkms_config_connector_attach_encoder(connector->config,
+						    encoder->config);
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
+	guard(mutex)(&connector->dev->lock);
+	vkms_config_connector_detach_encoder(connector->config,
+					     encoder->config);
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
@@ -539,6 +591,12 @@ static struct config_group *make_connector_group(struct config_group *group,
 	config_group_init_type_name(&connector->group, name,
 				    &connector_item_type);
 
+	config_group_init_type_name(&connector->possible_encoders_group,
+				    "possible_encoders",
+				    &connector_possible_encoders_group_type);
+	configfs_add_default_group(&connector->possible_encoders_group,
+				   &connector->group);
+
 	return &connector->group;
 }
 
-- 
2.48.1


