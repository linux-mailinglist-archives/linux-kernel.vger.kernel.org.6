Return-Path: <linux-kernel+bounces-215971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDC909974
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E161C20EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14B61FEA;
	Sat, 15 Jun 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUxEfXd9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345752F6D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474020; cv=none; b=H6y/iiCvKAOcoysbM4b0dRMk0TBoJxaHrm0QnTAw05fLDjuWlPXgBtEM2XyijShavQ/LwQQBECJnRHci00fsu26YXT9HB7Tr8KwcuUaoBFvDMLwJ9l99Azl6J6L+0sAxF+4RtRG//Hoi707/SBo9jNeKZjX0/FvXDI/1nRbEUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474020; c=relaxed/simple;
	bh=K5vgL0vhPRPxQ6eViVsHTJN1OF+8i3TQQsnaweS4L10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAgN3n7NHEGavDk9Jh05ytOEwerDbQebAm6p2C+XQdLkRYw4EYChrrtIJeN7X/KfwovvtTtGi1AUBm0dayG5SPxF/fHmQPvA9f28Ui1gW3eSWzy7RsYCHPcYLq/Ly2Uc7yt7U1k+9bwWO3tGkBFWJcnWSRpIOJmv3VnuQhwcCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUxEfXd9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso4514968e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718474016; x=1719078816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZP8ZmJRcZfMC764WUCJRbq634rGYP2EZWnL5wb9EkY=;
        b=EUxEfXd95M8idFdPeq31v/+VQXwoAmvPeyJ+jmi4hc34ZxgvL7fE43XTBt0FpvuD2D
         I/25qi7fZbxQMuXXCuaP1GL5AG8kmcYbzLcDZrWrVqagbQJmES8G1zwzBfzA+0lFzZNg
         cyuwEf7bhStM++Pz9yhP8mJdQktmjL12oSv2gvMKc+4tnnPRJ0+1jCs5APAC6AhPzpAF
         /tJ31Z1T7hcr1axhPW5lMaNO3BjUPui2RTCNWDvOH3aXK0wcB7lSROX8guok2CbHONAM
         KNgixLrcCOvjAg13F0n173kz8pWrafUSJjYykJzEpOHBUczoxTBv2MjSkHuO6o93r/bO
         B2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718474016; x=1719078816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZP8ZmJRcZfMC764WUCJRbq634rGYP2EZWnL5wb9EkY=;
        b=Sm2coNiuvdQbDfGz0aeicbQmOsRvIYzsX8I1Rgl61zUaiJ58RMRs79hzNmdbld5+Dl
         aD52jxMovWqb+IV7DAVdWDN/uZ5sKPKvnuZU2Xn/kBz+zdaD+F2Q/cHR6/Jg6v7gfWHr
         E29SwGsHntz0p/dp1zAdIpj8dIomsHLjXOcZVopyclFwGm8cD7Yj9z1wKvf04dV5VRfR
         IXVn/XeXp5T5gzToaIzWQ/1QyQjbFrlmWsRbsEMiVifAPs3TQ33VNMuFLYpApEvleYsJ
         8t5P6eG13yBEeaEuL8aFKEZVK+/IbuKdugGzGbLYgnntHiwUXekQx72nHmS5wvHEfQEx
         lvMg==
X-Forwarded-Encrypted: i=1; AJvYcCVjgij8wONPsNJtZ5NDmmdiohq26ZhSJcEq/bbD/GUjs58Su26YnNF7yNRToXNnJBb6AIVbZJSqb3sJOob+59y87ARNNoG3rNBHWQyV
X-Gm-Message-State: AOJu0YxGCtE8w7RyRpsi5RUypjjkdFSGKQesE3KUcb6swZkZtHE3Aom9
	SbJQGR0rjbt3u/mK/AxQ2nEdLpkJBR36+Mo/jmTO6CZ45a3QXrnRGGKLeTHmgjg=
X-Google-Smtp-Source: AGHT+IHa8fs4DYvwjHxRGyKeDtJ0GQg9KFQnWvSFPwToS3LXMDqMAhg7ocLF67H+iIUSg/VAS5DoCQ==
X-Received: by 2002:a05:6512:2255:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-52ca6e91af8mr5845407e87.50.1718474016331;
        Sat, 15 Jun 2024 10:53:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287affcsm799209e87.232.2024.06.15.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 10:53:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 15 Jun 2024 20:53:32 +0300
Subject: [PATCH RFC 3/5] drm/connector: implement generic HDMI codec
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240615-drm-bridge-hdmi-connector-v1-3-d59fc7865ab2@linaro.org>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
In-Reply-To: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10304;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=K5vgL0vhPRPxQ6eViVsHTJN1OF+8i3TQQsnaweS4L10=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbdUccz+HSNoVnSr42Tp+fFI4KjEGOXkgx4ODh
 ETmC2gqoM6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZm3VHAAKCRCLPIo+Aiko
 1d6UB/9tFOqKTD7wciyiUTwx6S8CIOsT77Re4jFxGQXDqa9oYP9IGx3yewxbxc5xowSI8FUnfAv
 OVg+IuK52MuBViqn5928WdDWTxiU2F8m0t7mUYZV65EqTkzR3PUv57NMeJoJE3y3TuOyXlIng5p
 pyLqhwnzbPHqies3C4QHcrOdiBlQobWfktvm5q1CwGBeX8e0i3EDUK8SaVdfIIjM88fVFBIaZlB
 Q7FXKM90U7bi5Dw9ardLbuU9MFDIMsxRxHBFnV5kYIVp+yJg9kovyoOjUNyLYgQec95X9FCbCBH
 sgGinR58x5ueD3dilzFZznoqaa0DRYpi4KyA/J3wAtIWpRir
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Several DRM drivers implement HDMI codec support (despite its name it
applies to both HDMI and DisplayPort drivers). Implement generic
framework to be used by these drivers. This removes a requirement to
implement get_eld() callback and provides default implementation for
codec's plug handling.

The framework is integrated with the DRM HDMI Connector framework, but
can be used by DisplayPort drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/Makefile                   |   1 +
 drivers/gpu/drm/drm_connector.c            |   8 ++
 drivers/gpu/drm/drm_connector_hdmi_codec.c | 157 +++++++++++++++++++++++++++++
 include/drm/drm_connector.h                |  33 ++++++
 4 files changed, 199 insertions(+)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 68cc9258ffc4..e113a6eade23 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -45,6 +45,7 @@ drm-y := \
 	drm_client_modeset.o \
 	drm_color_mgmt.o \
 	drm_connector.o \
+	drm_connector_hdmi_codec.o \
 	drm_crtc.o \
 	drm_displayid.o \
 	drm_drv.o \
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3d73a981004c..66d6e9487339 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -279,6 +279,7 @@ static int __drm_connector_init(struct drm_device *dev,
 	mutex_init(&connector->mutex);
 	mutex_init(&connector->edid_override_mutex);
 	mutex_init(&connector->hdmi.infoframes.lock);
+	mutex_init(&connector->hdmi_codec.lock);
 	connector->edid_blob_ptr = NULL;
 	connector->epoch_counter = 0;
 	connector->tile_blob_ptr = NULL;
@@ -529,6 +530,12 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 
 	connector->hdmi.funcs = hdmi_funcs;
 
+	if (connector->hdmi_codec.i2s || connector->hdmi_codec.spdif) {
+		ret = drmm_connector_hdmi_codec_alloc(dev, connector, hdmi_funcs->codec_ops);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
@@ -665,6 +672,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
 		connector->funcs->atomic_destroy_state(connector,
 						       connector->state);
 
+	mutex_destroy(&connector->hdmi_codec.lock);
 	mutex_destroy(&connector->hdmi.infoframes.lock);
 	mutex_destroy(&connector->mutex);
 
diff --git a/drivers/gpu/drm/drm_connector_hdmi_codec.c b/drivers/gpu/drm/drm_connector_hdmi_codec.c
new file mode 100644
index 000000000000..a3a7ad117f6f
--- /dev/null
+++ b/drivers/gpu/drm/drm_connector_hdmi_codec.c
@@ -0,0 +1,157 @@
+/*
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * Permission to use, copy, modify, distribute, and sell this software and its
+ * documentation for any purpose is hereby granted without fee, provided that
+ * the above copyright notice appear in all copies and that both that copyright
+ * notice and this permission notice appear in supporting documentation, and
+ * that the name of the copyright holders not be used in advertising or
+ * publicity pertaining to distribution of the software without specific,
+ * written prior permission.  The copyright holders make no representations
+ * about the suitability of this software for any purpose.  It is provided "as
+ * is" without express or implied warranty.
+ *
+ * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
+ * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
+ * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
+ * OF THIS SOFTWARE.
+ */
+
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_managed.h>
+
+#include <sound/hdmi-codec.h>
+
+static int drm_connector_hdmi_codec_get_eld(struct device *dev, void *data,
+					    uint8_t *buf, size_t len)
+{
+	struct drm_connector *connector = data;
+
+	//  FIXME: locking against drm_edid_to_eld ?
+	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+
+	return 0;
+}
+
+static int drm_connector_hdmi_codec_hook_plugged_cb(struct device *dev,
+						    void *data,
+						    hdmi_codec_plugged_cb fn,
+						    struct device *codec_dev)
+{
+	struct drm_connector *connector = data;
+
+	mutex_lock(&connector->hdmi_codec.lock);
+
+	connector->hdmi_codec.plugged_cb = fn;
+	connector->hdmi_codec.plugged_cb_dev = codec_dev;
+
+	fn(codec_dev, connector->hdmi_codec.last_state);
+
+	mutex_unlock(&connector->hdmi_codec.lock);
+
+	return 0;
+}
+
+void drm_connector_hdmi_codec_plugged_notify(struct drm_connector *connector,
+					     bool plugged)
+{
+	mutex_lock(&connector->hdmi_codec.lock);
+
+	connector->hdmi_codec.last_state = plugged;
+
+	if (connector->hdmi_codec.plugged_cb &&
+	    connector->hdmi_codec.plugged_cb_dev)
+		connector->hdmi_codec.plugged_cb(connector->hdmi_codec.plugged_cb_dev,
+						 connector->hdmi_codec.last_state);
+
+	mutex_unlock(&connector->hdmi_codec.lock);
+}
+EXPORT_SYMBOL(drm_connector_hdmi_codec_plugged_notify);
+
+static void drm_connector_hdmi_codec_cleanup_action(struct drm_device *dev,
+						    void *ptr)
+{
+	struct platform_device *pdev = ptr;
+
+	platform_device_unregister(pdev);
+}
+
+/**
+ * drmm_connector_hdmi_alloc - Allocate HDMI Codec device for the DRM connector
+ * @dev: DRM device
+ * @connector: A pointer to the connector to allocate codec for
+ * @ops: callbacks for this connector
+ *
+ * Create a HDMI codec device to be used with the specified connector.
+ *
+ * Cleanup is automatically handled with in a DRM-managed action.
+ *
+ * The connector structure should be allocated with drmm_kzalloc().
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drmm_connector_hdmi_codec_alloc(struct drm_device *dev,
+				    struct drm_connector *connector,
+				    const struct hdmi_codec_ops *base_ops)
+{
+	struct hdmi_codec_pdata codec_pdata = {};
+	struct platform_device *pdev;
+	struct hdmi_codec_ops *ops;
+	int ret;
+
+	ops = drmm_kmalloc(dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	*ops = *base_ops;
+
+	ops->get_eld = drm_connector_hdmi_codec_get_eld;
+	ops->hook_plugged_cb = drm_connector_hdmi_codec_hook_plugged_cb;
+
+	codec_pdata.ops = ops;
+	codec_pdata.i2s = connector->hdmi_codec.i2s,
+	codec_pdata.spdif = connector->hdmi_codec.spdif,
+	codec_pdata.max_i2s_channels = connector->hdmi_codec.max_i2s_channels,
+	codec_pdata.data = connector;
+
+	pdev = platform_device_register_data(connector->hdmi_codec.parent_dev,
+					     HDMI_CODEC_DRV_NAME,
+					     PLATFORM_DEVID_AUTO,
+					     &codec_pdata, sizeof(codec_pdata));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	ret = drmm_add_action_or_reset(dev, drm_connector_hdmi_codec_cleanup_action, pdev);
+	if (ret)
+		return ret;
+
+	connector->hdmi_codec.codec_pdev = pdev;
+
+	return 0;
+}
+EXPORT_SYMBOL(drmm_connector_hdmi_codec_alloc);
+
+/**
+ * drmm_connector_hdmi_codec_free - rollback drmm_connector_hdmi_codec_alloc
+ * @dev: DRM device
+ * @hdmi_codec: A pointer to the HDMI codec data
+ *
+ * Rollback the drmm_connector_hdmi_codec_alloc() and free allocated data.
+ * While this function should not be necessary for a typical driver, DRM bridge
+ * drivers have to call it from the remove callback if the bridge uses
+ * Connector's HDMI Codec interface.
+ */
+void drmm_connector_hdmi_codec_free(struct drm_device *dev,
+				    struct drm_connector_hdmi_codec *hdmi_codec)
+{
+	drmm_release_action(dev, drm_connector_hdmi_codec_cleanup_action,
+			    hdmi_codec->codec_pdev);
+}
+EXPORT_SYMBOL(drmm_connector_hdmi_codec_free);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f750765d8fbc..0eb8d8ed9495 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -46,6 +46,7 @@ struct drm_property_blob;
 struct drm_printer;
 struct drm_privacy_screen;
 struct edid;
+struct hdmi_codec_ops;
 struct i2c_adapter;
 
 enum drm_connector_force {
@@ -1199,6 +1200,8 @@ struct drm_connector_hdmi_funcs {
 	int (*write_infoframe)(struct drm_connector *connector,
 			       enum hdmi_infoframe_type type,
 			       const u8 *buffer, size_t len);
+
+	const struct hdmi_codec_ops *codec_ops;
 };
 
 /**
@@ -1706,6 +1709,22 @@ struct drm_connector_hdmi {
 	} infoframes;
 };
 
+struct drm_connector_hdmi_codec {
+	struct device *parent_dev;
+	struct platform_device *codec_pdev;
+
+	const struct drm_connector_hdmi_codec_funcs *funcs;
+
+	struct mutex lock; /* protects last_state and plugged_cb */
+	void (*plugged_cb)(struct device *dev, bool plugged);
+	struct device *plugged_cb_dev;
+	bool last_state;
+
+	int max_i2s_channels;
+	uint i2s: 1;
+	uint spdif: 1;
+};
+
 /**
  * struct drm_connector - central DRM connector control structure
  *
@@ -2119,6 +2138,12 @@ struct drm_connector {
 	 * @hdmi: HDMI-related variable and properties.
 	 */
 	struct drm_connector_hdmi hdmi;
+
+	/**
+	 * @hdmi_codec: HDMI codec properties and variables. Also might be used
+	 * for DisplayPort audio.
+	 */
+	struct drm_connector_hdmi_codec hdmi_codec;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
@@ -2152,6 +2177,14 @@ void drm_connector_unregister(struct drm_connector *connector);
 int drm_connector_attach_encoder(struct drm_connector *connector,
 				      struct drm_encoder *encoder);
 
+int drmm_connector_hdmi_codec_alloc(struct drm_device *dev,
+				    struct drm_connector *connector,
+				    const struct hdmi_codec_ops *ops);
+void drmm_connector_hdmi_codec_free(struct drm_device *dev,
+				    struct drm_connector_hdmi_codec *codec);
+void drm_connector_hdmi_codec_plugged_notify(struct drm_connector *connector,
+					     bool plugged);
+
 void drm_connector_cleanup(struct drm_connector *connector);
 
 static inline unsigned int drm_connector_index(const struct drm_connector *connector)

-- 
2.39.2


