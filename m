Return-Path: <linux-kernel+bounces-319270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4496F9E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CBDB23952
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41641D54E1;
	Fri,  6 Sep 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ao1ZHieF"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78381CFEC9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643707; cv=none; b=D2ssMUC54bQH3d6mDmGuJVA7+ceZS0SeYmmCElrmQdwfq/YlpLbDM7l39yebKfA1XOXyoWwmPr4O3wqhOhHQ93B0i4OAWmQLQd02Pp1zMX80wUVdFI3lQ8awn2E4iNKH91rr2WVvHAMdwwTRhTGg/PcSmLgTlEIaS6nxxf/INIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643707; c=relaxed/simple;
	bh=X02PdsGRwN0Xt4CRQJHfTXUpYBeHZjF9LA/tiFRLaj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FLMgp6z2iRgUgRIpQ554rqCQGsGHJGHUDPzIMilhndyxPVaNCL+HZQPnGYla+qjpVNx0LUFMeh9+V+SQpK1olxfS/GH14KzJd5mmfEKdufOE+98IU0EvHZcBYPq3Wk1IoTCKsPXG81iBsyqqLtddhUazH9Mqaa7IOlav2w0jGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ao1ZHieF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79A9420002;
	Fri,  6 Sep 2024 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725643702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YSMv/7OdJ6EZQxyck8/mOm0fHTErLrIcmMsknWGUyeI=;
	b=Ao1ZHieFOhfiSnD5EuaTZp/v6nju/W6TVFBt2xYh5JJ+9IvffWCqczNZ/dUKw7628i3w+0
	FoCwqDamqHNZpI2a0CpnmART3lAIi4aEaBqmn/rhqL+3IjEAx0YPAR1CTGljNYhq+3KLNF
	OEzu25e0t2kwLMV9GhKIrMdAwjR+aA7NmbMxl4FJtqwn99fi/m0NbVpSF5Ti9jAHK2ldTw
	oM0ytr1vYPcKg6UiMNIoGgyXmzM792G0IWtOif23+RKrj0V47xTva+VEqX6hTay+Kg17Ct
	8VIi/6j0roT5M414CEuURW4FjrUbjPmNXfGIWKa24j8DLABlIuGi0/Vmnbi8nw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 06 Sep 2024 19:28:17 +0200
Subject: [PATCH] drm: writeback: Introduce drm managed helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALA722YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3fKizJLUpMTkbN2Uotxc3STLJAvTlOSUxDTzJCWgpoKi1LTMCrC
 B0bG1tQA8kwBgYAAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 jani.nikula@linux.intel.com
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11994;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=X02PdsGRwN0Xt4CRQJHfTXUpYBeHZjF9LA/tiFRLaj4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm2zu1Z9ULrKBF7SDivY4TdzvsiqkdWlUzHyhOh
 AWEfeqhX3SJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZts7tQAKCRAgrS7GWxAs
 4rECD/0VZjIt+uFcKgliIOKcMoHSX31AhHteh7R5acbZRyXOLilZBGP5EcvFK2rKY64DbHzvNKm
 j5UDvmqqM8FFykbGn8llVnWG2v5ZaZwCM5+KEwY5pSGfCKZs1fP0joblO7/MsBTnaOC06186tcI
 2Dxgl0yvrClioQdE+SEGop5Z94V+6pp+OymFhnZDBse16UZG7cU1Tnf3xSwSStCtILSzus4rPPx
 hd/CaDNB/dnRHJzzQfAGb2G0CKNLTKD3dsq1R0GATuDF+SHgmpaa31XHQQVTFuOvCbWmh2F+L4Z
 CIpxZ1Frmp2rsI1UDzN+HlVcx31JA0j04Ge0rut2d1w0FKVw88Uw+585P9Yb3vnh/SmXaqHBQ3N
 tYK+hu9lYGlLZmE1+ZjOmk4dPpDCOpb/8D7L/7yL89ujoLzcKSf/4urlgDqETJfivnTdpeg1XjH
 JVbl8yO2AfkYasgNWt51WjXWvCB8H3vFapDIp+Qp5FGwbLJOhH/oo1LlryA3SEWcJB8jgnyJQmq
 VVIBO7kYHsB4dquFhFSKWkNXAq+H7UKmdLA96TSzbjIkuPBMaGACqNqWTEN96Q5v7o2wlkvdd73
 RE2pZKLAa/4JiJKjTXWHk/W/khJ6iWLPbygJ6ODf7KCwL5+x1HKMBiaYDSLkcDGSj3ghDov52Tb
 2qiEgXGQsjfdkKQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Currently drm_writeback_connector are created by
drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
Both of the function uses drm_connector_init and drm_encoder_init, but
there is no way to properly clean those structure from outside. By using
drm managed variants, we can ensure that the writeback connector is
properly cleaned.

This patch introduce drmm_writeback_connector_init, an helper to initialize
a writeback connector using drm managed helpers. This function allows the
caller to use its own encoder.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Hi Maxime, Jani,

I tried with this commit to implement the drm-managed version of writeback 
connector initialization. I tested with the current vkms driver, and it 
seems to works (at least no crash/warns).

As suggested by Jani, I only created one function, which takes a 
NULL-able pointer for encoder/encoder functions/possible_crtc. What do you 
think about it?

Regarding the documentation, I think I repeated too much, can I simply add 
comments like "see documentation of @... for the details / requirements"?

Good weekend,
Louis Chauvet
---
 drivers/gpu/drm/drm_writeback.c | 224 ++++++++++++++++++++++++++++++++++------
 include/drm/drm_writeback.h     |   7 ++
 2 files changed, 201 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index a031c335bdb9..a161deeea908 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -18,6 +18,7 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_property.h>
 #include <drm/drm_writeback.h>
+#include <drm/drm_managed.h>
 
 /**
  * DOC: overview
@@ -202,13 +203,12 @@ int drm_writeback_connector_init(struct drm_device *dev,
 EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
- * a custom encoder
+ * __drm_writeback_connector_init - Common initialization code for writeback
+ * connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
  * @enc: handle to the already initialized drm encoder
- * @con_funcs: Connector funcs vtable
  * @formats: Array of supported pixel formats for the writeback engine
  * @n_formats: Length of the formats array
  *
@@ -224,41 +224,31 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
  * assigning the encoder helper functions, possible_crtcs and any other encoder
  * specific operation.
  *
- * Drivers should always use this function instead of drm_connector_init() to
- * set up writeback connectors if they want to manage themselves the lifetime of the
- * associated encoder.
- *
  * Returns: 0 on success, or a negative error code
  */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-		struct drm_writeback_connector *wb_connector, struct drm_encoder *enc,
-		const struct drm_connector_funcs *con_funcs, const u32 *formats,
-		int n_formats)
+static int __drm_writeback_connector_init(
+	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
+	struct drm_encoder *enc, const u32 *formats, int n_formats)
 {
-	struct drm_property_blob *blob;
 	struct drm_connector *connector = &wb_connector->base;
 	struct drm_mode_config *config = &dev->mode_config;
-	int ret = create_writeback_properties(dev);
-
-	if (ret != 0)
-		return ret;
-
-	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
-					formats);
-	if (IS_ERR(blob))
-		return PTR_ERR(blob);
-
+	struct drm_property_blob *blob;
+	int ret;
 
 	connector->interlace_allowed = 0;
 
-	ret = drm_connector_init(dev, connector, con_funcs,
-				 DRM_MODE_CONNECTOR_WRITEBACK);
+	ret = create_writeback_properties(dev);
 	if (ret)
-		goto connector_fail;
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, enc);
 	if (ret)
-		goto attach_fail;
+		return ret;
+
+	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
+					formats);
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
 
 	INIT_LIST_HEAD(&wb_connector->job_queue);
 	spin_lock_init(&wb_connector->job_lock);
@@ -281,15 +271,189 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 	wb_connector->pixel_formats_blob_ptr = blob;
 
 	return 0;
+}
+
+/**
+ * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
+ * a custom encoder
+ *
+ * @dev: DRM device
+ * @wb_connector: Writeback connector to initialize
+ * @enc: handle to the already initialized drm encoder
+ * @con_funcs: Connector funcs vtable
+ * @formats: Array of supported pixel formats for the writeback engine
+ * @n_formats: Length of the formats array
+ *
+ * This function creates the writeback-connector-specific properties if they
+ * have not been already created, initializes the connector as
+ * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
+ * values.
+ *
+ * This function assumes that the drm_writeback_connector's encoder has already been
+ * created and initialized before invoking this function.
+ *
+ * In addition, this function also assumes that callers of this API will manage
+ * assigning the encoder helper functions, possible_crtcs and any other encoder
+ * specific operation.
+ *
+ * Drivers should always use this function instead of drm_connector_init() to
+ * set up writeback connectors if they want to manage themselves the lifetime of the
+ * associated encoder.
+ *
+ * Returns: 0 on success, or a negative error code
+ */
+int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
+		struct drm_writeback_connector *wb_connector, struct drm_encoder *enc,
+		const struct drm_connector_funcs *con_funcs, const u32 *formats,
+		int n_formats)
+{
+	struct drm_connector *connector = &wb_connector->base;
+	int ret;
+
+	ret = drm_connector_init(dev, connector, con_funcs,
+				 DRM_MODE_CONNECTOR_WRITEBACK);
+	if (ret)
+		return ret;
+
+	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
+					     n_formats);
+	if (ret)
+		drm_connector_cleanup(connector);
 
-attach_fail:
-	drm_connector_cleanup(connector);
-connector_fail:
-	drm_property_blob_put(blob);
 	return ret;
 }
 EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
 
+/**
+ * drm_writeback_connector_cleanup - Cleanup the writeback connector
+ * @dev: DRM device
+ * @data: Opaque pointer to the writeback connector
+ *
+ * This will decrement the reference counter of blobs and it will clean the
+ * remaining jobs in this writeback connector.
+ */
+static void drm_writeback_connector_cleanup(struct drm_device *dev, void *data)
+{
+	struct drm_writeback_connector *wb_connector = data;
+	unsigned long flags;
+	struct drm_writeback_job *pos, *n;
+
+	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
+
+	spin_lock_irqsave(&wb_connector->job_lock, flags);
+	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
+		drm_writeback_cleanup_job(pos);
+		list_del(&pos->list_entry);
+	}
+	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
+}
+
+/**
+ * __drmm_writeback_connector_init - Initialize a writeback connector with
+ * a custom encoder
+ *
+ * @dev: DRM device
+ * @wb_connector: Writeback connector to initialize
+ * @con_funcs: Connector funcs vtable
+ * @enc: handle to the already initialized drm encoder
+ * @formats: Array of supported pixel formats for the writeback engine
+ * @n_formats: Length of the formats array
+ *
+ * This function initialize a writeback connector and register its cleanup.
+ * It uses the common helper @__drm_writeback_connector_init to do the
+ * general initialization.
+ *
+ * This function assumes that @enc has already been created and initialized
+ * before invoking this function.
+ *
+ * In addition, this function also assumes that callers of this API will manage
+ * assigning the encoder helper functions, possible_crtcs and any other encoder
+ * specific operation.
+ *
+ * Returns: 0 on success, or a negative error code
+ */
+static int __drmm_writeback_connector_init(
+	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
+	const struct drm_connector_funcs *con_funcs, struct drm_encoder *enc,
+	const u32 *formats, int n_formats)
+{
+	struct drm_connector *connector = &wb_connector->base;
+	int ret;
+
+	ret = drmm_connector_init(dev, connector, con_funcs,
+				  DRM_MODE_CONNECTOR_WRITEBACK, NULL);
+	if (ret)
+		return ret;
+
+	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
+					     n_formats);
+	if (ret) {
+		drm_writeback_connector_cleanup(dev, &wb_connector);
+		return ret;
+	}
+
+	ret = drmm_add_action_or_reset(dev, &drm_writeback_connector_cleanup,
+				       wb_connector);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * drmm_writeback_connector_init - Initialize a writeback connector with
+ * a custom encoder
+ *
+ * @dev: DRM device
+ * @wb_connector: Writeback connector to initialize
+ * @con_funcs: Connector funcs vtable
+ * @enc: handle to the already initialized drm encoder, optional
+ * @enc_funcs: Encoder funcs vtable, optional
+ * @formats: Array of supported pixel formats for the writeback engine
+ * @n_formats: Length of the formats array
+ * @possible_crtcs: if @enc is NULL, this will set the possible_crtc for the
+ *		    newly created encoder
+ *
+ * This function initialize a writeback connector and register its cleanup.
+ *
+ * This function creates the writeback-connector-specific properties if they
+ * have not been already created, initializes the connector as
+ * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
+ * values.
+ *
+ * If @enc is NULL, a drm-managed encoder is created and used.
+ * If @enc_funcs is not NULL, this vtable is attached to @enc or this new
+ * encoder.
+ *
+ * Returns: 0 on success, or a negative error code
+ */
+int drmm_writeback_connector_init(
+	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
+	const struct drm_connector_funcs *con_funcs,
+	struct drm_encoder *enc,
+	const struct drm_encoder_helper_funcs *enc_funcs, const u32 *formats,
+	int n_formats, u32 possible_crtcs)
+{
+	int ret;
+
+	if (!enc) {
+		ret = drmm_encoder_init(dev, &wb_connector->encoder,
+					NULL, DRM_MODE_ENCODER_VIRTUAL, NULL);
+		if (ret)
+			return ret;
+
+		enc = &wb_connector->encoder;
+		enc->possible_crtcs |= possible_crtcs;
+		if (enc_funcs)
+			drm_encoder_helper_add(enc, enc_funcs);
+	}
+
+	return __drmm_writeback_connector_init(dev, wb_connector, con_funcs,
+					       &wb_connector->encoder, formats,
+					       n_formats);
+}
+EXPORT_SYMBOL(drmm_writeback_connector_init);
+
 int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 			 struct drm_framebuffer *fb)
 {
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 17e576c80169..88abfd3d4564 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -161,6 +161,13 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 				const struct drm_connector_funcs *con_funcs, const u32 *formats,
 				int n_formats);
 
+int drmm_writeback_connector_init(
+	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
+	const struct drm_connector_funcs *con_funcs,
+	struct drm_encoder *enc,
+	const struct drm_encoder_helper_funcs *enc_funcs, const u32 *formats,
+	int n_formats, u32 possible_crtcs);
+
 int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 			 struct drm_framebuffer *fb);
 

---
base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
change-id: 20240829-writeback-drmm-b9b85dcdaf7b

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


