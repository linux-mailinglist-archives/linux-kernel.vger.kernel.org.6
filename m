Return-Path: <linux-kernel+bounces-517313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3196A37F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F5A18920B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E219CC3E;
	Mon, 17 Feb 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5RJcK+H"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8E216394
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786489; cv=none; b=M5KjAhtys05BAhGRWn2rQ8GGfe5xLTkRpRGPSLRWIlVcYVA+BZ+96s0ChAPqgQsMXauNE3nb5Bq9ItV/E46Yc5I5LD4CusvBqyQp6dyfGaYPJCWfG9b2hHfeAW0oxsVPA2IvIWmLpFF4QW4FKxQKY9yUvVa/dvWu8sH0DeZXuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786489; c=relaxed/simple;
	bh=sC9Zaw3ndAVo+oHrEyc64S6eUMv2Ld/tFQLViNUAGL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/cwbO3k6F9JY8kFC/Wht4ifZoRp1zeNSiob09wGKXo9XJH3RStnUCYSXrCgV81L9v8vSJggAUgQ6iSlhQ47vJ082LWgc8vOpIEhSXUSKrfPVa6hWT+8ul4/pPuMKeF+H8sOm+RCQVUd1siCPy6oXB39Yw0ellGLZUOuQYCnkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5RJcK+H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f32c1c787so1577742f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786485; x=1740391285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6WlJ6G+D4bbUKndbktll+9YSW21OZOtswUdeB6r15c=;
        b=d5RJcK+HYPrz3tyvr0AmHa7thWR7IAo7OPAePSbqOFG8nocdX8VfRY3iclhczai+9b
         kbmmY/pRRKsUmZHsMfJ3CxbLoYLV5wy6VPdxMnKuQhhfdrPqk2foNHxRLY12jwL+qYtJ
         aDPhvtp1C+UhkPV36TBov/AaRcaHoswnbrzT9MO2dn7oHO+gY3i7URaaQ0X+srHpJLMm
         14DxjThJAeO+3R8Ysd5Pj1rssYKSMrsnOhLp3mUHcRhssdvGceXFrV/1I/5dO1RHxvlT
         2lhL1pgx9BUmmwDreyMl7sbOPM+pxhFy7M+ljpQZXODFCNXneuvmClCozl3sxhklIHJZ
         ww2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786485; x=1740391285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6WlJ6G+D4bbUKndbktll+9YSW21OZOtswUdeB6r15c=;
        b=ns/T8DB7cxZkjtAEgxgTl3/Bf7kpZvgxUTKG1e+mVMO44MT7eHoxj28DuxXmUILhmd
         gV1aJv66VmrAxV/zC7uPX67L8Ixg8dgz1tIhlQUgcAVjKDuH0tttjCreTi7OgkK1ho87
         XnGrsLoKFn/u1c+msPpCM2HmV7hDDTcSXduft40B2ucoQ9qz1zCTGWeODLEjwFrTF/24
         KWlx29FiXN1krf10gbLu7jVA61m/CDzxUIwFoy5EaP6jiPdbdgqLT3WsCt1BUxxdNcYd
         9d4aX+WKaUfDWuHCaoeJi+xVylkenyGQOXFuxMDtkY5Gw+jFLCTcxK+xSGwqTYRbLGvU
         LyDw==
X-Forwarded-Encrypted: i=1; AJvYcCXxWgOcy9zgIr72IHx5/wEpP814wggwACSud8VGYz1d+VwAHbA6wV92OwLVy3ZBodk9UGkq7W82YsSgwuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNlgR0lcchgyS34kmKGGh88kbAtmQlr3HUJdgR2t/cHvLvikA
	H8CVizXhNcmmYNW7S3oa465zAml3KZp3iETpyixLL+uhOvQc4NDy
X-Gm-Gg: ASbGncthcgwrpnvldXmeszYZi9CRD0RHgKzx70qMXwGKJG8qaNtRFKgBlVdyEGvNX1T
	JU2bYO47BxEKT8ILtUhqDAerB2rlvxZ8JPV7ODbSpDO5A5xnqtdg0YASSCa1LrTZKvqoEgCZ6er
	PREZnRpteW/IpIkiXjmVMX/6k/PCOi8uWRzLNRxQAKvDHWsIYwPRPtgilTsRVos+U5eR9OhDAAu
	oanZlkr/DdKKSXAL+3Up2E7uvmncMv0Y+aAuvKev0gSPQewBWBlbrwUj+P5r/cPi53Fn/+lWHJL
	qhNTYfPPrE0YQWvV0g==
X-Google-Smtp-Source: AGHT+IHR0ivBkP8DqlKn6j8a9rbDoM73t+/snjkd1dg3bV48JUhvsPQ/BQ9hOo9BodTzfQDHc3wwJw==
X-Received: by 2002:a5d:47a3:0:b0:38f:3914:c624 with SMTP id ffacd0b85a97d-38f3914cacfmr6018411f8f.7.1739786485181;
        Mon, 17 Feb 2025 02:01:25 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:24 -0800 (PST)
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
Subject: [PATCH v3 01/14] drm/vkms: Extract vkms_connector header
Date: Mon, 17 Feb 2025 11:01:07 +0100
Message-ID: <20250217100120.7620-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217100120.7620-1-jose.exposito89@gmail.com>
References: <20250217100120.7620-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Up until now, the logic to manage connectors was in vkms_output.c.

Since more options will be added to connectors in the future, extract
the code to its own file.

Refactor, no functional changes.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile         |  3 +-
 drivers/gpu/drm/vkms/vkms_connector.c | 50 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.h | 17 +++++++++
 drivers/gpu/drm/vkms/vkms_output.c    | 41 +++-------------------
 4 files changed, 73 insertions(+), 38 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_connector.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_connector.h

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 1b28a6a32948..6b0615c424f2 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -6,6 +6,7 @@ vkms-y := \
 	vkms_formats.o \
 	vkms_crtc.o \
 	vkms_composer.o \
-	vkms_writeback.o
+	vkms_writeback.o \
+	vkms_connector.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
new file mode 100644
index 000000000000..fc97f265dea6
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_probe_helper.h>
+
+#include "vkms_connector.h"
+
+static const struct drm_connector_funcs vkms_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int vkms_conn_get_modes(struct drm_connector *connector)
+{
+	int count;
+
+	/* Use the default modes list from DRM */
+	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
+	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+
+	return count;
+}
+
+static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
+	.get_modes    = vkms_conn_get_modes,
+};
+
+struct drm_connector *vkms_connector_init(struct vkms_device *vkmsdev)
+{
+	struct drm_device *dev = &vkmsdev->drm;
+	struct drm_connector *connector;
+	int ret;
+
+	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
+	if (!connector)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
+
+	return connector;
+}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
new file mode 100644
index 000000000000..beb5ebe09155
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _VKMS_CONNECTOR_H_
+#define _VKMS_CONNECTOR_H_
+
+#include "vkms_drv.h"
+
+/**
+ * vkms_connector_init() - Initialize a connector
+ * @vkmsdev: VKMS device containing the connector
+ *
+ * Returns:
+ * The connector or an error on failure.
+ */
+struct drm_connector *vkms_connector_init(struct vkms_device *vkmsdev);
+
+#endif /* _VKMS_CONNECTOR_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 22f0d678af3a..b01c3e9289d0 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -1,32 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include "vkms_connector.h"
 #include "vkms_drv.h"
-#include <drm/drm_atomic_helper.h>
-#include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
-#include <drm/drm_probe_helper.h>
-
-static const struct drm_connector_funcs vkms_connector_funcs = {
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
-static int vkms_conn_get_modes(struct drm_connector *connector)
-{
-	int count;
-
-	/* Use the default modes list from DRM */
-	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
-	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
-
-	return count;
-}
-
-static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
-	.get_modes    = vkms_conn_get_modes,
-};
 
 int vkms_output_init(struct vkms_device *vkmsdev)
 {
@@ -73,21 +49,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
-	if (!connector) {
-		DRM_ERROR("Failed to allocate connector\n");
-		return -ENOMEM;
-	}
-
-	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
-				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
-	if (ret) {
+	connector = vkms_connector_init(vkmsdev);
+	if (IS_ERR(connector)) {
 		DRM_ERROR("Failed to init connector\n");
-		return ret;
+		return PTR_ERR(connector);
 	}
 
-	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
-
 	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
 	if (!encoder) {
 		DRM_ERROR("Failed to allocate encoder\n");
-- 
2.48.1


