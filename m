Return-Path: <linux-kernel+bounces-206126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42CE9004A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B103D1C252B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6691946AB;
	Fri,  7 Jun 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3W92sGj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93F1940B5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766591; cv=none; b=ofhFUBWNJpoc7z1PcTxdblhhmNIAkAlbXSbX6lhsB48BXENzmUgJ4ufwUV4opfrAJK9xIPd/gnVKp7jw64ma790yaBI2ueVLqIraz5XFVOh7GuGHZC+D9uiBSiO0xAqERTXUlBmZ/Y3ZF0bIMCprvGZ4C+tko7+ugIH6EddHpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766591; c=relaxed/simple;
	bh=i/2yIs1AdOvvM+2mppaUjbCiiJz4VcgBioSXic+a3mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJqWi47xciaxDcFBeLvf4/dhevqIkozqlsVsHOs4VdaboMNcR5N7rZdZFLrpaB/kJl5rppAZkddTbQQZnlI6ZSIpe3NrQde3WxYuRT0lGNhd22gRAbPcaMioBROMX0xXIDFY7p7oiV9U2MpbfN37ySVUqrzSppv+noc3I6Sp/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w3W92sGj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b78ef397bso3028188e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766587; x=1718371387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXEZKqUKoBMCQKnZq6TzlKjW+xiy9xWzZdm1gobWSpw=;
        b=w3W92sGjanVdLJpMP7T4QjXZdfwKPd9Hr/OVLV0NQVZo1AAmZkqTZaolLqMrnreaUo
         3kT5OcB6epioMmY4N4jnzoK0kuncfaxl4oD8tRGJ4nu8mH6jel01hieO50kNTXFGjvcW
         GVv42bHfU3L1MDU//VsNTHqEVoqgZVfpZHcHjipZ3/HuCix0hM2qXtlQpaVe1Svl1zYc
         kXsa0GtqUwIfaqZrt6EMyyPCzh2kg8rkEbUetjCuF7dIxcLZTqil8nL3CGjDR9y8E1o/
         +xNCl08kP7V6GGz2yN1AZITumivJqn6ajp12AU/GTFEqEVcs1g43ETJawUwJyiz8cnC/
         6Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766587; x=1718371387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXEZKqUKoBMCQKnZq6TzlKjW+xiy9xWzZdm1gobWSpw=;
        b=kNuaK7Ctmuouo9dcbaWQj99ietRN7ZAjeAg+COBQWwTxcQnL95Qb/JIXnBGS9zu5IC
         4Uvp30a0e+PzWjfLx22MyI18leNZ/48A2cCkzQhhDPgJ/k97crYIAKGoYKNKRWAARZKX
         7uJfVAAFTwTWAQ1w0E2qKlW4fO0kEDNwhZh2nF5nXJwKvoK8DKDdJgo59GMIzZfQad3H
         oEy8QbJMi1qYzrzD7UfJHfIOM7DeoGh9+LIjnI1tuj7UZU+NWnFSYFsbMtJFRy2s+z7n
         C5fS+1D9KyFaV3UNXQBU5UZB1LUbKJhGGnEFL3BAuWkqwjZ5vbwZ5xJsNOuccaRLdu41
         RCVA==
X-Forwarded-Encrypted: i=1; AJvYcCXwtL8zFNR7Vpx41tKCCAem39qExOR5PnSqMAxHmQ8++Nl2VY7N/r1TIUWFszhRYhyL5r+e+3kwLCZAo8zptzGEMrF0UKKP54Jo85bL
X-Gm-Message-State: AOJu0Yzd1uG2ZtjaM0wk5FDsq7x08QtMbE23Xmel5as9h0XDCaW6RpDE
	/bvp1sWNg+/pV3z/VqjqVVNkLgFOgEh/YlUetBn8WC5l1u0b0AxaeMCmKth50wI=
X-Google-Smtp-Source: AGHT+IE70bMyZfo973nu62FGErfXyJHvF2x2gemOL+luUZ5+oRkTiw1Ku8GDFRZd2jWC/ALQz72KzA==
X-Received: by 2002:a19:5f44:0:b0:52b:2b11:a574 with SMTP id 2adb3069b0e04-52bb9df3844mr721652e87.15.1717766587014;
        Fri, 07 Jun 2024 06:23:07 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 16:23:00 +0300
Subject: [PATCH v5 3/9] drm/bridge-connector: implement glue code for HDMI
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-bridge-hdmi-connector-v5-3-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9561;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=i/2yIs1AdOvvM+2mppaUjbCiiJz4VcgBioSXic+a3mk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm2AMr/CqZ+NInuyx2FRGZEcnZoyWMdc2Qga
 YrC9pZzfEKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtgAKCRCLPIo+Aiko
 1e1WB/9Q5WznuZBbUZwaufEZA2KwhiM01x4YOKyzx93MLrObfdLX51leDb+iAZaDb3Y1tgx0m98
 79mlac4u1uTiePt/wzZyyG3PBz16gQdh3aV/cUgEMS8m25IogP09VOZpTdNKiReYvMhw2x0nfjf
 yH7fZ58eXGpVc1+TfcvmTPfb9HIuzjHTHcvOjyyX/g3mE+oTikBpa6ZO/OenTVpp+LAVwo1JHeG
 EJtx1v3/0k/cIGVoCg3fbXw1sn8czHBzTVPAkLip7SYqNTpcbd4R5oWFt6SjuxYDeZnrdCmMD98
 rOBaXAXIdER6bhb0XdRU4OovrCfjdZNNKo6jhpAgzXRArxMV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In order to let bridge chains implement HDMI connector infrastructure,
add necessary glue code to the drm_bridge_connector. In case there is a
bridge that sets DRM_BRIDGE_OP_HDMI, drm_bridge_connector will register
itself as a HDMI connector and provide proxy drm_connector_hdmi_funcs
implementation.

Note, to simplify implementation, there can be only one bridge in a
chain that sets DRM_BRIDGE_OP_HDMI. Setting more than one is considered
an error. This limitation can be lifted later, if the need arises.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 94 ++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_debugfs.c          |  2 +
 include/drm/drm_bridge.h               | 81 +++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index e093fc8928dc..0869b663f17e 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -18,6 +18,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/display/drm_hdmi_state_helper.h>
 
 /**
  * DOC: overview
@@ -87,6 +88,13 @@ struct drm_bridge_connector {
 	 * connector modes detection, if any (see &DRM_BRIDGE_OP_MODES).
 	 */
 	struct drm_bridge *bridge_modes;
+	/**
+	 * @bridge_hdmi:
+	 *
+	 * The bridge in the chain that implements necessary support for the
+	 * HDMI connector infrastructure, if any (see &DRM_BRIDGE_OP_HDMI).
+	 */
+	struct drm_bridge *bridge_hdmi;
 };
 
 #define to_drm_bridge_connector(x) \
@@ -287,6 +295,60 @@ static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs
 	.disable_hpd = drm_bridge_connector_disable_hpd,
 };
 
+static enum drm_mode_status
+drm_bridge_connector_tmds_char_rate_valid(const struct drm_connector *connector,
+					  const struct drm_display_mode *mode,
+					  unsigned long long tmds_rate)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return MODE_ERROR;
+
+	if (bridge->funcs->hdmi_tmds_char_rate_valid)
+		return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, tmds_rate);
+	else
+		return MODE_OK;
+}
+
+static int drm_bridge_connector_clear_infoframe(struct drm_connector *connector,
+						enum hdmi_infoframe_type type)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_clear_infoframe(bridge, type);
+}
+
+static int drm_bridge_connector_write_infoframe(struct drm_connector *connector,
+						enum hdmi_infoframe_type type,
+						const u8 *buffer, size_t len)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_write_infoframe(bridge, type, buffer, len);
+}
+
+static const struct drm_connector_hdmi_funcs drm_bridge_connector_hdmi_funcs = {
+	.tmds_char_rate_valid = drm_bridge_connector_tmds_char_rate_valid,
+	.clear_infoframe = drm_bridge_connector_clear_infoframe,
+	.write_infoframe = drm_bridge_connector_write_infoframe,
+};
+
 /* -----------------------------------------------------------------------------
  * Bridge Connector Initialisation
  */
@@ -312,6 +374,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *bridge, *panel_bridge = NULL;
+	unsigned int supported_formats = BIT(HDMI_COLORSPACE_RGB);
+	unsigned int max_bpc = 8;
 	int connector_type;
 	int ret;
 
@@ -348,6 +412,20 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->bridge_detect = bridge;
 		if (bridge->ops & DRM_BRIDGE_OP_MODES)
 			bridge_connector->bridge_modes = bridge;
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
+			if (bridge_connector->bridge_hdmi)
+				return ERR_PTR(-EBUSY);
+			if (!bridge->funcs->hdmi_write_infoframe ||
+			    !bridge->funcs->hdmi_clear_infoframe)
+				return ERR_PTR(-EINVAL);
+
+			bridge_connector->bridge_hdmi = bridge;
+
+			if (bridge->supported_formats)
+				supported_formats = bridge->supported_formats;
+			if (bridge->max_bpc)
+				max_bpc = bridge->max_bpc;
+		}
 
 		if (!drm_bridge_get_next_bridge(bridge))
 			connector_type = bridge->type;
@@ -370,9 +448,19 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = drmm_connector_init(drm, connector,
-				  &drm_bridge_connector_funcs,
-				  connector_type, ddc);
+	if (bridge_connector->bridge_hdmi)
+		ret = drmm_connector_hdmi_init(drm, connector,
+					       bridge_connector->bridge_hdmi->vendor,
+					       bridge_connector->bridge_hdmi->product,
+					       &drm_bridge_connector_funcs,
+					       &drm_bridge_connector_hdmi_funcs,
+					       connector_type, ddc,
+					       supported_formats,
+					       max_bpc);
+	else
+		ret = drmm_connector_init(drm, connector,
+					  &drm_bridge_connector_funcs,
+					  connector_type, ddc);
 	if (ret) {
 		kfree(bridge_connector);
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index dd39a5b7a711..e385d90ef893 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -762,6 +762,8 @@ static int bridges_show(struct seq_file *m, void *data)
 			drm_puts(&p, " hpd");
 		if (bridge->ops & DRM_BRIDGE_OP_MODES)
 			drm_puts(&p, " modes");
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
+			drm_puts(&p, " hdmi");
 		drm_puts(&p, "\n");
 	}
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4baca0d9107b..9f5d7bef41c5 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -630,6 +630,52 @@ struct drm_bridge_funcs {
 	 */
 	void (*hpd_disable)(struct drm_bridge *bridge);
 
+	/**
+	 * @hdmi_tmds_char_rate_valid:
+	 *
+	 * Check whether a particular TMDS character rate is supported by the
+	 * driver.
+	 *
+	 * This callback is optional and should only be implemented by the
+	 * bridges that take part in the HDMI connector implementation. Bridges
+	 * that implement it shall set set the DRM_BRIDGE_OP_HDMI flag in their
+	 * &drm_bridge->ops.
+	 *
+	 * Returns:
+	 *
+	 * Either &drm_mode_status.MODE_OK or one of the failure reasons
+	 * in &enum drm_mode_status.
+	 */
+	enum drm_mode_status
+	(*hdmi_tmds_char_rate_valid)(const struct drm_bridge *bridge,
+				     const struct drm_display_mode *mode,
+				     unsigned long long tmds_rate);
+
+	/**
+	 * @hdmi_clear_infoframe:
+	 *
+	 * This callback clears the infoframes in the hardware during commit.
+	 * It will be called multiple times, once for every disabled infoframe
+	 * type.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI flag in their &drm_bridge->ops.
+	 */
+	int (*hdmi_clear_infoframe)(struct drm_bridge *bridge,
+				    enum hdmi_infoframe_type type);
+	/**
+	 * @hdmi_write_infoframe:
+	 *
+	 * Program the infoframe into the hardware. It will be called multiple
+	 * times, once for every updated infoframe type.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI flag in their &drm_bridge->ops.
+	 */
+	int (*hdmi_write_infoframe)(struct drm_bridge *bridge,
+				    enum hdmi_infoframe_type type,
+				    const u8 *buffer, size_t len);
+
 	/**
 	 * @debugfs_init:
 	 *
@@ -705,6 +751,16 @@ enum drm_bridge_ops {
 	 * this flag shall implement the &drm_bridge_funcs->get_modes callback.
 	 */
 	DRM_BRIDGE_OP_MODES = BIT(3),
+	/**
+	 * @DRM_BRIDGE_OP_HDMI: The bridge provides HDMI connector operations,
+	 * including infoframes support. Bridges that set this flag must
+	 * implement the &drm_bridge_funcs->write_infoframe callback.
+	 *
+	 * Note: currently there can be at most one bridge in a chain that sets
+	 * this bit. This is to simplify corresponding glue code in connector
+	 * drivers.
+	 */
+	DRM_BRIDGE_OP_HDMI = BIT(4),
 };
 
 /**
@@ -773,6 +829,31 @@ struct drm_bridge {
 	 * @hpd_cb.
 	 */
 	void *hpd_data;
+
+	/**
+	 * @vendor: Vendor of the product to be used for the SPD InfoFrame
+	 * generation. This is required if @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	const char *vendor;
+
+	/**
+	 * @product: Name of the product to be used for the SPD InfoFrame
+	 * generation. This is required if @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	const char *product;
+
+	/**
+	 * @supported_formats: Bitmask of @hdmi_colorspace listing supported
+	 * output formats. This is only relevant if @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	unsigned int supported_formats;
+
+	/**
+	 * @max_bpc: Maximum bits per char the HDMI bridge supports. Allowed
+	 * values are 8, 10 and 12. This is only relevant if
+	 * @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	unsigned int max_bpc;
 };
 
 static inline struct drm_bridge *

-- 
2.39.2


