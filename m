Return-Path: <linux-kernel+bounces-284597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37299502F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809AD1F22F54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D519D89E;
	Tue, 13 Aug 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS/UqUa0"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640819CCF7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546315; cv=none; b=P6nvGlKeys+cSfuYBxKLjmZCLwW8fQ8TsUGZ/huamDerCKTc52ok2drFn0MOT6Xi2lvy7dZXIwjwRoD/nedMsX5Es8WsakP1Iir8sb4NFOIJIvdAmuqS2sGx1eC74xxVoHGitYY2l6M2ZLXLTdOBJZHxN6bBj6bq9dIYQLjv+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546315; c=relaxed/simple;
	bh=+ErXRFhQq6+0n0HTh/n2Xlvncgf68Nk9s6WH+laThEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUVN2NZByVmpLtN4/mOYwezC3LwWdCa3tjY0UqOWS+46XWoWZm6X0S0OzhyhHRSUkHKvxwKmWOjQnV91BFUJajShdon9mM/swD3mtI3XWd5kmdeEzD/XxSCVMn5BZeChaRmeycgE7oM+e0Jl+HQTtN3Lj07cl2IZxkzNiD7onSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS/UqUa0; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so67866721fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546312; x=1724151112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqQI2pSvN1r3euYPp2vCyWNVjuvi3Z3cQv0iU7vYqtw=;
        b=iS/UqUa0beTSA7xdj5lUtVJk4RRU51wQXkKwIXzbro+1dA1P/AYcot54kmQDNRKoJk
         OhPdFgtciihicGTMyH7LpUDgcR5HxcmTxDrvJFOH0Ke48aiozhfwQUPdwMhLwPpZZRbB
         fz3MAbRB+kRIbdmuF5H/P2H1ldKnalu+HfIGehLFQUDjN1nFw10HfVibrJ9F43BMFXbO
         SA7cc1dSDJwvanDI33H9PUUfEWRR7s3iyf46LoeW0oeXZHVjYTcjJWYI8HCpUT2sMble
         9ebszxWdYZJqVdfCadkg8gbvz1Erojy2/1Rdb0CV4PTmd+9Qi66yKZb2uZpydQjbpMLc
         2KVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546312; x=1724151112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqQI2pSvN1r3euYPp2vCyWNVjuvi3Z3cQv0iU7vYqtw=;
        b=Pk4mSfiRdOUY6BNYqEmLbQya5e9rpuJkuYqVkL0XBkvdASJ+i87V1N0iMeAolPUJOz
         nkwevPlblO3hy9lGXM6tXacyYhDIfLZuO6dOyxIXHaFyMIb9VslngexRUZDU3ET73cTJ
         SG+zJJ8EqveuDpcV40uORx52WXRIHbgt+GwRuMsVFqdBcNNjGIR2geclnZhuxDbRDw47
         jEM88U91jp0i+g//4cfo6uHoxK+MHcc+uWD2DygYwbXIGvsaDvdUOL3uZ61Pl2hG63GL
         0iAOIN0jTlIe1xEUx3OqFL7kTuwoJd1t3kxqwJlWYJKs32fLBdGZHd6WXVegEjDpW+vU
         YuNw==
X-Forwarded-Encrypted: i=1; AJvYcCVG0ZXNjULLqtBcpn6PcSrSflRTQWGDTs5fXT+k7/hYHRxq0DsRBbSgVfF3NP13MkF66BbBR1VXwweuuawwW2+mYJ8C3gmWiSTvNl6h
X-Gm-Message-State: AOJu0YwaiPRRfpVAaJkDs/os1UHtg4QJAYQwrTItb6rrCZ7eqiJltX0E
	lnkNRrqkeo8nrXoZ5p+ele0bl0bsBD3S8Xgirvfjid/CO3Pk5hjF
X-Google-Smtp-Source: AGHT+IEE/5oIBKt+yDiQMW0HbZMqJpQ32z2JEVYHvnsw69984l4lJ/4s/IJTZ5H3jFbn7gTtOtW3Rw==
X-Received: by 2002:a05:6512:114c:b0:52c:d80e:55a5 with SMTP id 2adb3069b0e04-53213693ec2mr2061169e87.41.1723546311208;
        Tue, 13 Aug 2024 03:51:51 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:50 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 10/17] drm/vkms: Allow to change connector status
Date: Tue, 13 Aug 2024 12:44:21 +0200
Message-ID: <20240813105134.17439-11-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813105134.17439-1-jose.exposito89@gmail.com>
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Store the connector status in vkms_config_connector and use the stored
value to update the connector status in the drm_connector_funcs.detect()
function.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 18 ++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_config.h | 12 +++++++++++-
 drivers/gpu/drm/vkms/vkms_output.c | 20 ++++++++++++++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index d95a42a6745a..e8e5c02c9d43 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_debugfs.h>
 
 #include "vkms_config.h"
@@ -56,7 +57,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	if (IS_ERR(encoder_cfg))
 		return ERR_CAST(encoder_cfg);
 
-	connector_cfg = vkms_config_add_connector(config, BIT(0));
+	connector_cfg = vkms_config_add_connector(config, BIT(0), connector_status_connected);
 	if (IS_ERR(connector_cfg))
 		return ERR_CAST(connector_cfg);
 
@@ -124,6 +125,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	list_for_each_entry(connector_cfg, &vkmsdev->config->connectors, list) {
 		seq_printf(m, "connector(%d).possible_encoders=%d\n", n,
 			   connector_cfg->possible_encoders);
+		seq_printf(m, "connector(%d).status=%d\n", n,
+			   connector_cfg->status);
 		n++;
 	}
 
@@ -229,7 +232,8 @@ void vkms_config_destroy_encoder(struct vkms_config *config,
 }
 
 struct vkms_config_connector *vkms_config_add_connector(struct vkms_config *config,
-							uint32_t possible_encoders)
+							uint32_t possible_encoders,
+							enum drm_connector_status status)
 {
 	struct vkms_config_connector *connector_cfg;
 
@@ -238,6 +242,7 @@ struct vkms_config_connector *vkms_config_add_connector(struct vkms_config *conf
 		return ERR_PTR(-ENOMEM);
 
 	connector_cfg->possible_encoders = possible_encoders;
+	connector_cfg->status = status;
 	list_add_tail(&connector_cfg->list, &config->connectors);
 
 	return connector_cfg;
@@ -249,3 +254,12 @@ void vkms_config_destroy_connector(struct vkms_config *config,
 	list_del(&connector_cfg->list);
 	kfree(connector_cfg);
 }
+
+void vkms_update_connector_status(struct vkms_config *config,
+				  struct vkms_config_connector *connector_cfg,
+				  enum drm_connector_status status)
+{
+	connector_cfg->status = status;
+	if (config->dev)
+		drm_kms_helper_hotplug_event(&config->dev->drm);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 25dab63e7ae7..3237406fa3a3 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -6,6 +6,8 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+#include <drm/drm_connector.h>
+
 struct vkms_device;
 
 struct vkms_config_plane {
@@ -29,6 +31,9 @@ struct vkms_config_encoder {
 struct vkms_config_connector {
 	struct list_head list;
 	uint32_t possible_encoders;
+	enum drm_connector_status status;
+	/* only set when instantiated */
+	struct drm_connector *connector;
 };
 
 struct vkms_config {
@@ -72,8 +77,13 @@ void vkms_config_destroy_encoder(struct vkms_config *config,
 
 /* Connectors */
 struct vkms_config_connector *vkms_config_add_connector(struct vkms_config *config,
-							uint32_t possible_encoders);
+							uint32_t possible_encoders,
+							enum drm_connector_status status);
 void vkms_config_destroy_connector(struct vkms_config *config,
 				   struct vkms_config_connector *connector_cfg);
 
+void vkms_update_connector_status(struct vkms_config *config,
+				  struct vkms_config_connector *connector_cfg,
+				  enum drm_connector_status status);
+
 #endif /* _VKMS_CONFIG_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index a5b1ab326cdd..511cc2c14c44 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -7,7 +7,25 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
+static enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
+						       bool force)
+{
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(connector->dev);
+	enum drm_connector_status status = connector->status;
+	struct vkms_config_connector *connector_cfg;
+
+	list_for_each_entry(connector_cfg, &vkmsdev->config->connectors, list) {
+		if (connector_cfg->connector == connector) {
+			status = connector_cfg->status;
+			break;
+		}
+	}
+
+	return status;
+}
+
 static const struct drm_connector_funcs vkms_connector_funcs = {
+	.detect = vkms_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -155,6 +173,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		connector = vkms_connector_init(vkmsdev, connector_cfg->possible_encoders);
 		if (IS_ERR(connector))
 			return PTR_ERR(connector);
+
+		connector_cfg->connector = connector;
 	}
 
 	drm_mode_config_reset(dev);
-- 
2.46.0


