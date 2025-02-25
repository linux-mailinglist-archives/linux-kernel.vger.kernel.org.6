Return-Path: <linux-kernel+bounces-532161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC9A4496A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E11189A88C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419F18C035;
	Tue, 25 Feb 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvALjABw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE43210F5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506403; cv=none; b=qtmV6Joxm+36tVnRz5QlNJGof3PYr4dmFv/CWY2kTDquKjTWvpa1irWURxibE2WM8DYzb9+dRB4HJh4UHH3/ZTNHrYhuPptheUL2Pplry2IUNwp21gIpAZhdHxnQEgJxJ0RfIRAHTfkGJFPW4gkgXMNgi9dE2SHS1NgJhUg76aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506403; c=relaxed/simple;
	bh=ap0abf7pYKvLuYyghIBsdol1SAK7DKp7h/sxPesUTKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phL916LHeMan3c3WaSz98muxNcMOSs5XJjgv9vrQ3dGVp3hI3gkLixmm/BLsevxgsWCFjPg0bKRIv6vdVyNu5chE/WVeZLOrCB7VItUWiNg+GPbEhsaQHWOO5Ah8wTlp3RgoqZ6tHo7+9XbdUIUffOO9EO1yFwQqFKmvP8dw8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvALjABw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399deda38cso36717545e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506399; x=1741111199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGxwG+6bGnNIthEQL+F1Y0qNbK+3kLrCEEdzMCdmayU=;
        b=AvALjABw+isMGaS9lGQqlkoBlrxI7lA5aiHyS4B0PKLqpRWpSKa+D/7H8qAkq1FpDL
         xVbURyy0OdnpzBb2zfmiKLqe4Qi7OJuQsy0l9IRGPMkLiplH9yg3IT3H283NGqrKMSkI
         BgNb1tub4btT90rTw1EWQqRASERKa+YvivcHtnepEad0fBz6UdyGODZ9XDN0MuOyI8Di
         hjadgq6T6y1bFCNmkaPwYntMh9QgihP9E61lGfZZzLGhaYxJj7NazFxhA3r7Sy+0J4C+
         Ad4osfygQuAnLa3rvMueC8zGkeYJ+UH1pZAiu+sI2U3ymkn8VcdLc+1Qe+RjYVSxOQ1n
         6rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506399; x=1741111199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGxwG+6bGnNIthEQL+F1Y0qNbK+3kLrCEEdzMCdmayU=;
        b=qj54j1jTnlNhN8Qv3ThUP+yyrdcCZKNUmEkPouyf/Xg4tx8/ibPpbAu6IHR5/sWuUJ
         WIwodzE+0UAg/HF0+beUWjWsZMepUJhtLc2taHqZueiM52S5toUj6I5S7WkEfQp3VylV
         bj5e39eClnpbGLGB3NAoT97Dzuzo+g+Ef3kAfx6D4LG4wpURZjKQDEFxi8/gB0zEriGV
         Pxs30PTQcXmnFC3YIPxRpWdgWkPQRIY1Q+Pgxgzyxv3YLsCwyU+23C+6U4BmDeiVzk+7
         +FZVJGiiCDGVEawVDehOS+eTJy4giqxnfB7AsrQ2AAWEJWWDYcAskYZsRrCnYHgfhx99
         jjiw==
X-Forwarded-Encrypted: i=1; AJvYcCW1DomXhAvaea++daTyboDCPb+DzXVeggHNnO4s0yBXPJQSHo54FLgosbzrmknCzOIcoYyf/SAnpbtHoNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRcUt/9R8Q0e/rmjJu2iKN6yxdg+OPUMt2PBk8+lfIRpPJ2ci1
	ypdKQaVkoIIDXB+6Ic6WacYUH72mpVCMU3GmQ/75v/fswGHuBwco
X-Gm-Gg: ASbGncvCRFim+7UiT9NaqoGtzj2ABewf6VCpDlK0vzSXWLFv0JOvEmZpT7J58W40z0e
	Tw94QQpXZYNhMu28TdtE/3W/31J0CseAbPCHgRyKej0apPWrNMd25wafTgc8X+KeitGTOz0rRVU
	8bEOUD5i5DEekMiaNlwCwK61fKI8O2yWFkXavquLBI5v0qpHrcIN9lWUc8Ns8+qY/d0Zv69hMan
	nCCrwff5UwLM4oF8EawogDXs1YTuDyxBo2TTHI17JcC0jzXGONfRlFx1I5rRzMm1Ytr25hX3pgh
	8boM1YCL1lD2KOBVeKAXgZ5mYDHM
X-Google-Smtp-Source: AGHT+IGqBZvURkcaxlMPmAxOYXrBfupjLCf9BWOro848BGonvQQbFRhIpMLdNCyILndFVpqQPjDTTQ==
X-Received: by 2002:a5d:53cf:0:b0:38d:a90c:d489 with SMTP id ffacd0b85a97d-390cc6384a1mr3115400f8f.45.1740506399191;
        Tue, 25 Feb 2025 09:59:59 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:58 -0800 (PST)
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
Subject: [PATCH v2 16/16] drm/vkms: Allow to configure connector status via configfs
Date: Tue, 25 Feb 2025 18:59:36 +0100
Message-ID: <20250225175936.7223-17-jose.exposito89@gmail.com>
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

When a connector is created, add a `status` file to allow to update the
connector status to:

 - 1 connector_status_connected
 - 2 connector_status_disconnected
 - 3 connector_status_unknown

If the device is enabled, updating the status hot-plug or unplugs the
connector.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst            |  5 +++
 drivers/gpu/drm/vkms/vkms_configfs.c  | 46 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c |  7 ++++
 drivers/gpu/drm/vkms/vkms_connector.h |  6 ++++
 4 files changed, 64 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index c551241fe873..7c54099b1dc6 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -108,6 +108,11 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
+Connectors have 1 configurable attribute:
+
+- status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
+  as those exposed by the "status" property of a connector)
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index d4d36d2c8f3d..76afb0245388 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -7,6 +7,7 @@
 #include "vkms_drv.h"
 #include "vkms_config.h"
 #include "vkms_configfs.h"
+#include "vkms_connector.h"
 
 /* To avoid registering configfs more than once or unregistering on error */
 static bool is_configfs_registered;
@@ -496,6 +497,50 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static ssize_t connector_status_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	guard(mutex)(&connector->dev->lock);
+	return sprintf(page, "%u",
+		       vkms_config_connector_get_status(connector->config));
+}
+
+static ssize_t connector_status_store(struct config_item *item,
+				      const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	enum drm_connector_status status;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	if (kstrtouint(page, 10, &status))
+		return -EINVAL;
+
+	if (status != connector_status_connected &&
+	    status != connector_status_disconnected &&
+	    status != connector_status_unknown)
+		return -EINVAL;
+
+	guard(mutex)(&connector->dev->lock);
+
+	vkms_config_connector_set_status(connector->config, status);
+
+	if (connector->dev->enabled)
+		vkms_trigger_connector_hotplug(connector->dev->config->dev);
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(connector_, status);
+
+static struct configfs_attribute *connector_item_attrs[] = {
+	&connector_attr_status,
+	NULL,
+};
+
 static void connector_release(struct config_item *item)
 {
 	struct vkms_configfs_connector *connector;
@@ -514,6 +559,7 @@ static struct configfs_item_operations connector_item_operations = {
 };
 
 static const struct config_item_type connector_item_type = {
+	.ct_attrs	= connector_item_attrs,
 	.ct_item_ops	= &connector_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b03a00b5803a..ed99270c590f 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -76,3 +76,10 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
 
 	return connector;
 }
+
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev)
+{
+	struct drm_device *dev = &vkmsdev->drm;
+
+	drm_kms_helper_hotplug_event(dev);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 5ab8a6d65182..7865f54a313c 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -33,4 +33,10 @@ struct vkms_connector {
 struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
 					   struct vkms_config_connector *connector_cfg);
 
+/**
+ * struct vkms_device *vkmsdev() - Update the device's connectors status
+ * @vkmsdev: VKMS device to update
+ */
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_CONNECTOR_H_ */
-- 
2.48.1


