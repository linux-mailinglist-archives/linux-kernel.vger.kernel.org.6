Return-Path: <linux-kernel+bounces-532160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3717CA4496E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513B816BA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65829211712;
	Tue, 25 Feb 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKp54dS1"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3520F090
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506401; cv=none; b=AjCT9ADKYY8EPo3XumEhC+Sy0V+OoGaL3mQaSZD4BfmxM8B+t5HSBlodpmQIJuZKUB0vYvFC6etCN6z0C35xEeK3jWwCwOYaSIt0GNfVgcuG49zumRciVD8MlAUfmTTpJRLCqg8bVfsgV2UuW9Tgz95sLoONEwX2o5tQMHmSLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506401; c=relaxed/simple;
	bh=bvUa+h9JmV2ml66J/SlTMakEh4TAaYTL3p6zG9eX1wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAeM2Vxmj2LolSajg2CvEN7W3qmtBz/9OSFWDi65/iib+H/uKk2YVxf47XU4qqQEjaq/83XWz6vN+2qthrq93jVCD8fh/IguwSQUZLxPvzTfOo3p8IgKbhjEDmYVhPTeV1hy6tSXQtRMMbn28r6vGR/JzSgKLo3h8PNSRfPVKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKp54dS1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f406e9f80so5446311f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506398; x=1741111198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfdjeoHNn9vAEGMDN9L94Mho5GfMjQgvCgSJKDEGohI=;
        b=EKp54dS1jIpTTAT/gUV0+ToyqHWk57ARi5XenL7tXwqe0iAzoAdwvhCfH9IcceZlZz
         bl72ZP+JFYyXd1fQlZ+850IljFQYm13tQ507QHeDhE3iw6HdRH4RljWJJw9/osIrCk/3
         Nz93TBcwvT4YsLLN5AfwXr/X23HfY9fFICHj2TWU82B5nE/a006SMA7tkKqG3wJRFwHN
         ltq80qpbrmGrx5L+usBNEL/frApFJ69+XN7H+WPwBWGRgGk686kGet3UyTZQ7NPivG6j
         FVHJ+ZoqsYxmqLwrcLOmeJRxJ5LfoSNFXMSR5r9eNhCrS3+ADYpxvwzZ0m6u9IBSlZ0x
         kEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506398; x=1741111198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfdjeoHNn9vAEGMDN9L94Mho5GfMjQgvCgSJKDEGohI=;
        b=LMbJz4i+kE1TG3Ji097TTrLMxaCVHamrFxcrOkBWyrFWirmkhJBMhry8FXkM6m5RBR
         j95/GyMS+gzpsQrtyROA5hWTJ1HyenOPVekVWWmX4bs8vXTux+0klkFsIRCoeJXf2NyJ
         ECvARJQxwvvwuwgYwmM8MA8+kvwITt3LZW5CR+BLRidII5iB4B2GDaQtouwmCazhhkEt
         BSLzzp361R4p/WxsdmxTsUBnxZ8eTGaVnXA0Wx1ahsFxAKRkPF6tVVJEmmmKM4lpY9pP
         WgzOylIQde6rX11yuiRFYiwwzunwTJbYleFFPvJjyYc/3qzku29xYuILYqusmm/EzZzV
         kLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUtEtbAN/pGxonyEK/f9yelilYpz+yu3xeComhmTco3rPM3R4nZaw6H2nfWZIg1ORVbERqZc3elUYkGMVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W/T6JnI0LSkrCqPaYcuomP7P3NIpucWDWe/g/FUqZOvv1j+i
	Cjuq/K+eIqEYRMHk8b8Z9du0US44+g18Zn2vNBGCilBiXmWFHwY+
X-Gm-Gg: ASbGncsl9LlD38RE+s/UpM3zzn6BgbLI6+jdxst8n2bGXmZc+Zir2P+ZEBbS7rg+1XE
	q1a+rH+2C4gxjY5iCa4LpALlU6CZ3HJ3EHi50xFi5lN1JTuhPffwgLlFj/xRauiadkV8vsMjkG5
	dY3/QOnNi/00hoZ9OABzjngRKNtrVoE5l2p/2cMJvcS+nLtmfTm11ct1Iiy8/QrdF+Y1a5EWtSE
	4mI6woi08BWwJzVIYk5emvn9EUbLDTud/gKaWuIDANyyNsML0jvH5mSxolJOEv6HBVTQPSE2V0H
	fP1jNb86f7OBCuxWSY+3WiIJn2ym
X-Google-Smtp-Source: AGHT+IFmy3TLi8XjtwOwVQRKla+t9XcozrFfuQ2APFo1NcW327AwNtnvk589f2rdg/oiUJGtDZCmlg==
X-Received: by 2002:a5d:6483:0:b0:38f:465d:fdf5 with SMTP id ffacd0b85a97d-390d4f4310emr170501f8f.26.1740506397599;
        Tue, 25 Feb 2025 09:59:57 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:57 -0800 (PST)
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
Subject: [PATCH v2 15/16] drm/vkms: Allow to update the connector status
Date: Tue, 25 Feb 2025 18:59:35 +0100
Message-ID: <20250225175936.7223-16-jose.exposito89@gmail.com>
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

Implement the drm_connector_funcs.detect() callback to update the
connector status by returning the status stored in the configuration.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_connector.h | 12 +++++++++++-
 drivers/gpu/drm/vkms/vkms_output.c    |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 48b10cba322a..b03a00b5803a 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -5,9 +5,23 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
+#include "vkms_config.h"
 #include "vkms_connector.h"
 
+static enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
+						       bool force)
+{
+	struct vkms_connector *vkms_connector;
+	enum drm_connector_status status;
+
+	vkms_connector = drm_connector_to_vkms_connector(connector);
+	status = vkms_config_connector_get_status(vkms_connector->connector_cfg);
+
+	return status;
+}
+
 static const struct drm_connector_funcs vkms_connector_funcs = {
+	.detect = vkms_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -40,7 +54,8 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
+					   struct vkms_config_connector *connector_cfg)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
@@ -50,6 +65,8 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
 	if (!connector)
 		return ERR_PTR(-ENOMEM);
 
+	connector->connector_cfg = connector_cfg;
+
 	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
 				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret)
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index c9149c1b7af0..5ab8a6d65182 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -5,22 +5,32 @@
 
 #include "vkms_drv.h"
 
+struct vkms_config_connector;
+
+#define drm_connector_to_vkms_connector(target) \
+	container_of(target, struct vkms_connector, base)
+
 /**
  * struct vkms_connector - VKMS custom type wrapping around the DRM connector
  *
  * @drm: Base DRM connector
+ * @connector_cfg: Connector configuration
  */
 struct vkms_connector {
 	struct drm_connector base;
+
+	struct vkms_config_connector *connector_cfg;
 };
 
 /**
  * vkms_connector_init() - Initialize a connector
  * @vkmsdev: VKMS device containing the connector
+ * @connector_cfg: Configuration for the connector
  *
  * Returns:
  * The connector or an error on failure.
  */
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
+					   struct vkms_config_connector *connector_cfg);
 
 #endif /* _VKMS_CONNECTOR_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 8d7ca0cdd79f..3af95983026e 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -87,7 +87,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		struct vkms_config_encoder *possible_encoder;
 		unsigned long idx = 0;
 
-		connector_cfg->connector = vkms_connector_init(vkmsdev);
+		connector_cfg->connector = vkms_connector_init(vkmsdev, connector_cfg);
 		if (IS_ERR(connector_cfg->connector)) {
 			DRM_ERROR("Failed to init connector\n");
 			return PTR_ERR(connector_cfg->connector);
-- 
2.48.1


