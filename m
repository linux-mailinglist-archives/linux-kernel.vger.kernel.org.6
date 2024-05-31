Return-Path: <linux-kernel+bounces-197422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160928D6A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F8C1F2ACD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020A1822CC;
	Fri, 31 May 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY9sxDS6"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8C17D8B2
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186057; cv=none; b=AduGJKDR4qB79G2kGJk/N876L38QZWxBKnETseK2V2JfkAcFiGfoum7luA9tSwcON9isEUeDUtEfKzaiBnVPfs9zt1pSN/szV98wBJz9gW4z79O2wG94ytUX6i3wCUl8BJFSebjvaPd0FU8S7h8Nkt3K2/w0QkKubWHsa/B7ukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186057; c=relaxed/simple;
	bh=cqCdor0KJlbsJ87CXjTFhRdAs763FYhaLzSStx5DE/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlnR3HwhV/u/U/ZalwdEK4hEhdyLk+QigGSO0AGNJzJQtS/d7HXOZzFi4hzbP414xqGrFVH+vMBkA1Of6W5nE9W7L4A/t+dpyfJPNy8Npx2ye5oAjQBsZkVhPGiFHXxwuMcHSFdTHx0izCquca7iKFHAnlSld1+m2DHktY0Tcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bY9sxDS6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e96f29884dso27960461fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717186052; x=1717790852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foy6JQDzCRlndu2wDkMW+/KfxEQHtUuSgLRAcEoN4C0=;
        b=bY9sxDS6hep6+aCJ+wRdofBVZ18JqqouKkjxvuElx8vlAaprq9nTBzXLIQWrmGNtd9
         zQfbaR+/BZHliEBAukIrdKZjn0z0L0UYyjRn5vhl9dADKUXK/MMN3wQ5EpPFlbqcQnuO
         Bx2Yp30oWhSS8s9DsUVPWivh9Dusrn4Ves1+VgDVORXfCvac8YlW4Ni6ETzKCtdFm/+a
         6+2sjO7/UDT7gPpTwXT/1XX14EDn5Z3E6CWAosqI1jqvbu1k3NqsqsmeU2JgHoDDLa00
         gMJNIap2WwZ/uXIEbXG81oyUM3fQD7SOHvvcBFRyJxj0+vkAR4pt6lzY2yWyyMTLkgg3
         BB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717186052; x=1717790852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foy6JQDzCRlndu2wDkMW+/KfxEQHtUuSgLRAcEoN4C0=;
        b=XVG9RoWtAlb70PoR1P9mLVIUtqpoMXpnoBRDFjhIZmrfAnypqaK5N7JlIotzFEmUOT
         Hbsy9t44ahjgloKWsCeK0D7mKNGFHn75IQv8tyIu5GchHUT7dktBYBjutbmqIaSKRmq1
         I8oiKFwARKNF40w9MJBfCTqVZaVjlDpVvDsaA5ovGzejZ121bUFrp/JHmzawIX0Hfk6i
         IanWOTgS0nbY7EnX99/i6X7cgJJzc6dgprDNdlqQc6pAq2+9x930L81hKu3qfHE5D6Nq
         8GdDbX0jz0DxYB8wdbj6wTev7mod7QvZIicxbB0u3DKlg+VWaXhgqZpytMnPA0Y7Oycz
         sT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjbuiejKalbygKhDVTMkNB5UromFAqkiaw1r30lT5FfdazRdM3fpu9IqUAgVe4W/aO8u45PJfcC1I81iazfcX21y9tiky1ZeI7GMU7
X-Gm-Message-State: AOJu0Yz/to45g69XnEx5RHuZMS18GdSjCqj6PRIxuHyZ1S0/n8MrEbTT
	HauILOyENFz3+T7SP+NkfbfQ9vbUjBkEatyCzZsfl5z+4yD33UJUtFQkO5wmDnM=
X-Google-Smtp-Source: AGHT+IHe08TPzRwu8QJpB+XlF9UFkX4BM6/WRN6Xrq2DzKyEX+hm+4hCpcrc/wdSno18d3D2NGT4xw==
X-Received: by 2002:a2e:a99b:0:b0:2e0:37be:b70f with SMTP id 38308e7fff4ca-2ea95160333mr22535721fa.26.1717186052632;
        Fri, 31 May 2024 13:07:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0b83sm4022111fa.116.2024.05.31.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:07:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 31 May 2024 23:07:26 +0300
Subject: [PATCH v4 3/9] drm/bridge-connector: implement glue code for HDMI
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-bridge-hdmi-connector-v4-3-5110f7943622@linaro.org>
References: <20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org>
In-Reply-To: <20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9637;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=cqCdor0KJlbsJ87CXjTFhRdAs763FYhaLzSStx5DE/w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmWi4AlEFNoNujj5XVYXq2skTWjPqicVVG7XXx7
 DFHgfkY++mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlouAAAKCRCLPIo+Aiko
 1ZynCACJC6aYfwTMqIXQVEPf/+vDvVuJvSFIKAKY9BsMpSSF0aHRQqoZfgfOPwNuHDtVDJrImNF
 WeycDKKG3J4huOXpcWnVVzCUqQ6Rq7WX3QBE+Aj/HQdvn6bl8WiwDU72wS0Lx4icdt9u5/6u/VE
 MClLhBpcVl3QPDFF3Ozg8UFF1k1mXs1ZTPMGqDGJ1/2NDTCRISzU+KzGUR3QC49Rxh/EMzb57rB
 CqCIbWIqBHbnhYMas+wj6uuvkn4QyaCmp6uOKtTibuN7iEDZTjr8ARGEHuTdBz03bdhTBgYtmBT
 l1dRUhj9kwHsrLTLcePFMmOo1LQchQMGFZL7I6azopuE48fv
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 96 ++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_debugfs.c          |  2 +
 include/drm/drm_bridge.h               | 83 +++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index e093fc8928dc..95af857b271d 100644
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
@@ -287,6 +295,63 @@ static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs
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
+	if (bridge->funcs->hdmi_clear_infoframe)
+		return bridge->funcs->hdmi_clear_infoframe(bridge, type);
+	else
+		return 0;
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
@@ -312,6 +377,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *bridge, *panel_bridge = NULL;
+	unsigned int supported_formats = BIT(HDMI_COLORSPACE_RGB);
+	unsigned int max_bpc = 8;
 	int connector_type;
 	int ret;
 
@@ -348,6 +415,19 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->bridge_detect = bridge;
 		if (bridge->ops & DRM_BRIDGE_OP_MODES)
 			bridge_connector->bridge_modes = bridge;
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
+			if (bridge_connector->bridge_hdmi)
+				return ERR_PTR(-EBUSY);
+			if (!bridge->funcs->hdmi_write_infoframe)
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
@@ -370,9 +450,19 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
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
index 4baca0d9107b..3e86bb07eaa7 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -630,6 +630,54 @@ struct drm_bridge_funcs {
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
+	 * This callback is optional and should only be implemented by the
+	 * bridges that take part in the HDMI connector implementation. Bridges
+	 * that implement it shall set set the DRM_BRIDGE_OP_HDMI flag in their
+	 * &drm_bridge->ops.
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
@@ -705,6 +753,16 @@ enum drm_bridge_ops {
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
@@ -773,6 +831,31 @@ struct drm_bridge {
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


