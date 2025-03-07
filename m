Return-Path: <linux-kernel+bounces-551546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED81A56E0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CAC163C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578723E259;
	Fri,  7 Mar 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhSEDFeM"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09C24166F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365256; cv=none; b=pjeYn7+F2Lfp4q6OguMsVMn4lncPfpz+gmMMFP0kIOh09E29S5TPkc6/A10qTdq2zsw/cqvEkp7kI5lJc0lMimV3FxJWzmht7tNTvnTdbBI8VuJbyq1ngGqoGSSLP8JwQrk1Mj4Clxshzfrs0vnVYKygdAHpBO19U11LdHG7V7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365256; c=relaxed/simple;
	bh=caAdIgUrFdoGShqcfq2/jSWtE9eD++2gWRNE62pSbGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4xaZPOVA0smG0Q2I4WOZnjtme5PlvDUbHPLlXb5kiyXuh5re68ZXEK2XkmnGpbBspGvBa5UzoV40xYAS8QoZID0d3bgRV36dykG0k+whht2paWdJSLCcpahSO4XG9VKcFCJ8qxH9/cX7DwpweXUugrmp4bzkYHw+e6bblZQ8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhSEDFeM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3912baafc58so1394645f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365253; x=1741970053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPglBRQzm3PeNfTp1IXfadGrcc/1PZ/sWQxkyGuh1Hg=;
        b=VhSEDFeMy980f090w2U6UvIoKtL4NupVvkdLi+kxykMxk4nuEuCvStNb6crYzh3uCY
         nFccYd46atjmTiMP97FSRxPELBw03XGdeDt0jKLLqunhNq2x3Y7jJTy6Vc5UKKVuLksh
         A9zTSOY+9tUml5J8p+DDPmw74vctzR8kWES5R09VP6wUt1l8WnR/4ZPNzECGnL9yR8ZO
         9id5JceSuDbkEmVcw0l8KFwsHBD6xTzcg7Cw1MB/M81Wz45uD+XNWpo7T+w0yOvGor+4
         uIB4b8LEQ5vUhJULThaGkcoB8gvuwA9pVBFQfxL6q/b53dldklGJy80wal9AU/GkFDY0
         B+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365253; x=1741970053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPglBRQzm3PeNfTp1IXfadGrcc/1PZ/sWQxkyGuh1Hg=;
        b=BDHbcZYE+XmkoXuXotbbYUK3l6DmBM5emWqOoH1bWHowsNAffTP75qRs5iQTKIm47L
         xlcQT/XMvijUnQKzO/tYSBKlrH8pt5dy/9hY0NYntq/xNOnZuMMOfDqzj9vBQ+qax1kq
         bZPcc5jzgfwO89syI2HzJUyDq0eeMVPkz3TsIxNDEBMpsXwzYVIpZ2QAl9Rh/kXpx6vd
         7Ii51CR4wz2HFhUCkzjsYHz6ym6Yb9WFREDgnAW2fKTcOCkYVUqtOCOypUU2u++Oy0ZM
         xanwDw/vv3jB3YJwegqvWKCydqcBZlIqybOC6cEK3QVUEgTvUSItJ3ftxOt38sMpj/bE
         Wl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1MTbOEl7JS4TctmoJyQ8QISCY0/4UDj3V4GJaHQti2T7OjrLrwZBK+O0GQtOyoz/z7lF4230qVWhkJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXuddhrJW54qKqV1rhisVP6pZHOTWuaRwCA7ElFHBxz3i022g
	4ytrz3k9zaFdDBZnsAVSuouEaGeTtWziEXmt9L6rDLgnj9NaQ3MA
X-Gm-Gg: ASbGncvT49+/RaHNp5ugx85QWkI1WzizOhxjzApizn0XoIHYQEyYeUH1WPw/5WjTzBH
	CY71fooJLPE29jZpCK/XdOKVlxTWshTpgfzXCVI047l2ca8TZdm8PclZwUOpria4kx9yh4ujV8y
	2pU7UAMycB0eRMcN7nnvkC9XIIsxVn77t6+NRwJXkxhvmhl+A6dJx+3JOuFsQ+3IfiyLdjC0Quz
	gdjAqSL5oIYh1aGG031dFshMbmbOvpdgoaacufW1hyZIXpESSPVMHdoG2ISOnXM6cF0G8OYI5fS
	ER5kvEWOt62MSwVqx47js9AoshEO6G+s9VjX37HPhqeofUE=
X-Google-Smtp-Source: AGHT+IF63rOdhDcyNIxc0Af2rMIu3XHsDnVUzLpB/8CyhXcU6KC2Y/tzuWU0AngWy0NaISRGyKp2tQ==
X-Received: by 2002:a5d:5f4e:0:b0:391:fcc:9ee8 with SMTP id ffacd0b85a97d-39132d6bc06mr2454738f8f.23.1741365252797;
        Fri, 07 Mar 2025 08:34:12 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:11 -0800 (PST)
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
Subject: [PATCH v3 10/16] drm/vkms: Allow to configure multiple connectors via configfs
Date: Fri,  7 Mar 2025 17:33:47 +0100
Message-ID: <20250307163353.5896-11-jose.exposito89@gmail.com>
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
/config/vkms/connectors to allow to create as many connectors as
required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 87 ++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 650dbfa76f59..744e2355db23 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── connectors
   ├── crtcs
   ├── enabled
   ├── encoders
@@ -103,6 +104,10 @@ Next, create one or more encoders::
 
   sudo mkdir /config/vkms/my-vkms/encoders/encoder0
 
+Last but not least, create one or more connectors::
+
+  sudo mkdir /config/vkms/my-vkms/connectors/connector0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -127,6 +132,7 @@ And removing the top level directory and its subdirectories::
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
+  sudo rmdir /config/vkms/my-vkms/connectors/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 7de601e39d2b..692e1b708012 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -19,6 +19,7 @@ static bool is_configfs_registered;
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
+ * @connectors_group: Default subgroup of @group at "/config/vkms/connectors"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -29,6 +30,7 @@ struct vkms_configfs_device {
 	struct config_group planes_group;
 	struct config_group crtcs_group;
 	struct config_group encoders_group;
+	struct config_group connectors_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -81,6 +83,20 @@ struct vkms_configfs_encoder {
 	struct vkms_config_encoder *config;
 };
 
+/**
+ * struct vkms_configfs_connector - Configfs representation of a connector
+ *
+ * @group: Top level configuration group that represents a connector.
+ * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @dev: The vkms_configfs_device this connector belongs to
+ * @config: Configuration of the VKMS connector
+ */
+struct vkms_configfs_connector {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_connector *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -106,6 +122,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     possible_crtcs_group)
 
+#define connector_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -485,6 +505,69 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void connector_release(struct config_item *item)
+{
+	struct vkms_configfs_connector *connector;
+	struct mutex *lock;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	lock = &connector->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_connector(connector->config);
+		kfree(connector);
+	}
+}
+
+static struct configfs_item_operations connector_item_operations = {
+	.release	= &connector_release,
+};
+
+static const struct config_item_type connector_item_type = {
+	.ct_item_ops	= &connector_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_connector_group(struct config_group *group,
+						 const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_connector *connector;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		connector = kzalloc(sizeof(*connector), GFP_KERNEL);
+		if (!connector)
+			return ERR_PTR(-ENOMEM);
+
+		connector->dev = dev;
+
+		connector->config = vkms_config_create_connector(dev->config);
+		if (IS_ERR(connector->config)) {
+			kfree(connector);
+			return ERR_CAST(connector->config);
+		}
+
+		config_group_init_type_name(&connector->group, name,
+					    &connector_item_type);
+	}
+
+	return &connector->group;
+}
+
+static struct configfs_group_operations connectors_group_operations = {
+	.make_group	= &make_connector_group,
+};
+
+static const struct config_item_type connector_group_type = {
+	.ct_group_ops	= &connectors_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -592,6 +675,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &encoder_group_type);
 	configfs_add_default_group(&dev->encoders_group, &dev->group);
 
+	config_group_init_type_name(&dev->connectors_group, "connectors",
+				    &connector_group_type);
+	configfs_add_default_group(&dev->connectors_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


