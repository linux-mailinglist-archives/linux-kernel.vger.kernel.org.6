Return-Path: <linux-kernel+bounces-519145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26ABA3988E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0B3A02D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333FC238D3B;
	Tue, 18 Feb 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnEDtJQi"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773ED23717F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873546; cv=none; b=fCo9i3XCviFX6FCwd5pxBLkuGJYZta2NUp+Saf3gr0SmSiMejzWcinl8x4LSSr2JvwXjJ9xvTgNcD8Uo4WCAOh7WbjtAPduN2QnaXFXbcwEFU/qGTTxxzpwOF0stTAruPaXsFgeb/bBSQ6v0a8pEkl31oGBqht21g6w6soNN1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873546; c=relaxed/simple;
	bh=sC9Zaw3ndAVo+oHrEyc64S6eUMv2Ld/tFQLViNUAGL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdLl7yeyDfOLhdGkvzpyBrg88rDT+srSLQ+4k0NJfGRIvSrGF80ba79SobzIZNQ2/jDDJ4GhyUEE3beSxKO/pcCanvyE4XnGfx//0opV0hG19zm02WumDiu98PRukD2ZdL0iLMRP+TTaKMu+eAKO1Jzdad0R9s7O+C/KGVf60oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnEDtJQi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f31f7732dso2046156f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873543; x=1740478343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6WlJ6G+D4bbUKndbktll+9YSW21OZOtswUdeB6r15c=;
        b=XnEDtJQiCfwK0XSMEHFJ33aO7ptB/DwT6DsqoVJnnfVBxalPInh9M3duFN0gJ7iP5E
         y8mPZj9fPVhyitAOLLvVR3j+9EDAugz17yUGKMaWcSp5xOv9Z2kLeYGMJwqCqpPtqBDO
         e/xIKhu5nvaT8WjNaxiZ9lzc2/NY8zH0eQQFfZ1J3FTUGlSGZ99OUU3W6rTBjUPMpG5H
         vswrHnZmCFOl3G+ViPnFbokqxopTQbEyhYwUSLcXk0+Mly86iIjCJjC4HAyBYvIYgMFy
         uS3Z0qGfv6FQUrl2XZ2rIEVNF66fkVfnXMwbUG8EL3yOoiXbOjKRkZJFtpl9/aoC0BWH
         Gbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873543; x=1740478343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6WlJ6G+D4bbUKndbktll+9YSW21OZOtswUdeB6r15c=;
        b=KViYEYcCYKSqVaIn5LWzaXv2zNh34hiqvHO62hq4UMBaYwfngJLDR/tEVTJYkN/wAr
         ckbQl2gIUoeyGX1uoPGigpCqccdna3O9pLfHagMn0yWbRzdaf3sJ9UBl71u6KM9sII1G
         skAPCMPC+jSwoDEhNKDes0G7Eo//Ww3tCADVWw3pDg8vLtZKPJcbwPZrl2qhbfftudNa
         jfxAQaMAIkVCGp8An1PBoZY6wRMNiwCyUdmW6s0KeiGKAEXCqGyLUYbKs55/PS3MCW/H
         EPhwPTsfiwBlsfA/eHprYxHNMUNAgKDHBIx+xOqEmjPanCnyL8PfxLayWxAeTmwTrxWT
         Cqaw==
X-Forwarded-Encrypted: i=1; AJvYcCUYFhLyTS+uyuRWxOa0chd1cXXvVBN1/iSPbK7GzOgFjrP5bT58GslTw9lRK0XQ1b6ZUqn9Y7rB474r0j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHkHlVApsYJfLz3i6xgrFIB1VSaQKdSKUysNRnRD3LVrEJptI
	Nb7chBsqz3fUSqJJ1oRrLuEX67ckslwwHQZfi03lAcUlwrUpzAxu
X-Gm-Gg: ASbGncve5MIfxuGY3uO4fw1zeTv9dQieQeOkuo2Hok8nOrr+BU70aBS2r9JqF5+PGH1
	o4AISW3x8o0KjhQ4F/isYu+7h7DOm/as0PqkJAU1FvZyR+RKT3456wFUs48zWooujM10Tn/D4qS
	jTXBRnW2HhJ2pQBwyV3MMuvxQ9EyrJyWzQ06u8BOifFpqBeJWtgnmvvS3xpwzPdtltZmDkpDtDi
	dHlt03FG4oN8grftieaLBG9UdF60fPyHGGF9Poqx9BQqhxPKaZf1kl5W26k3oYVbbDN2sWmGU0S
	fhf7V88AWk7t0O/4yA==
X-Google-Smtp-Source: AGHT+IEEW0iAE4qEj9av2UeE33E//jpTafczPlcz+BtPwrsJYFsIUM8ZKgX34LtrMnVDl4nvC1vyPQ==
X-Received: by 2002:adf:b34b:0:b0:38f:3e0a:ca6a with SMTP id ffacd0b85a97d-38f3e0acb08mr5579751f8f.2.1739873542277;
        Tue, 18 Feb 2025 02:12:22 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:21 -0800 (PST)
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
Subject: [PATCH v4 01/14] drm/vkms: Extract vkms_connector header
Date: Tue, 18 Feb 2025 11:12:01 +0100
Message-ID: <20250218101214.5790-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218101214.5790-1-jose.exposito89@gmail.com>
References: <20250218101214.5790-1-jose.exposito89@gmail.com>
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


