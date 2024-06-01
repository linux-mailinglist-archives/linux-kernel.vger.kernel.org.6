Return-Path: <linux-kernel+bounces-197853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA08D7014
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C096B22460
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DE1527A1;
	Sat,  1 Jun 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vxS8ToKO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F21514F4;
	Sat,  1 Jun 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247591; cv=none; b=XgVE9273pNjnhBhBArR4J1qtiB1AsHOkPWpxaI78TyblNutuBfs7OqkFgTl8QIhVw8rSMTj+82ShX3tAT+ryReUPi33Xh0AyQdTebW5KXCIaT7oh8z/NSwPtpsmTR6T8uq+7/cw1wrc/PVS4N+NrhCeiZeQ1T+W2lUo1s3TIwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247591; c=relaxed/simple;
	bh=8uRhqLiAdkGIlh3VTlM1cQofy1gF9s+TKt0ENoIYejs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qf8SVN67gG+W7V2JGF2ZH7xpuMNxnKi6Ch8fIDLEC0YTYUHUgI05ZMdlePGz+nzrWIEMn7SlsCGc4KCxTIK5uQqXCuYF8UFDr2f30aXVvXFlb+E6nCqR9lKYpUCkxDG6FMhnWz6UM/8R2uOa3rl7+BoNRLnZtWRtKatXLTGb0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vxS8ToKO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717247583;
	bh=8uRhqLiAdkGIlh3VTlM1cQofy1gF9s+TKt0ENoIYejs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vxS8ToKOD9x3MfJOagpxmnjgKb8QkJVEMjq8Yp1mb9bT9G4vI3KqyMYSI+RgexhR0
	 8hcEbfOui1Vw7mVe2TyqPTmaNYv/IIqpz2xojZi43z0JFPqDps+UkVzI1mXyXSSiJH
	 mL02UnET/FOs/KM4964Go8HIaFMApo6OHaleu3WZUDS0JGYHdmUwxs91i3rLmmXg7p
	 RGyy9gCMJ3n8CeQaaeyiqi1sbSa8DSl4RFcNgb9xxzNx9XxHNuydG4zIFyCwSDcSRY
	 Acu1l0Pn839x+gELe/eqLGbnmKRVyxw92PlnfJpT7PluyB+nRO/hGsCjrrhRwOX0DM
	 uj2zZB4GVzJIw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3039437821EB;
	Sat,  1 Jun 2024 13:13:03 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 01 Jun 2024 16:12:26 +0300
Subject: [PATCH 04/14] drm/bridge: dw-hdmi: Factor out AVI infoframe setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240601-b4-rk3588-bridge-upstream-v1-4-f6203753232b@collabora.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14-dev-f7c49

In preparation to add support for the HDMI 2.1 Quad-Pixel TX Controller
and minimize code duplication, factor out the AVI infoframe setup from
hdmi_config_AVI() into a common dw_hdmi_prep_avi_infoframe() helper.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h |  4 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c        | 57 ++++++++++++++----------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
index ffd2ee16466c..0569196bbe3b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
@@ -150,6 +150,10 @@ struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi,
 					const struct i2c_algorithm *algo);
 bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi,
 			  const struct drm_display_info *display);
+void dw_hdmi_prep_avi_infoframe(struct hdmi_avi_infoframe *frame,
+				struct dw_hdmi *hdmi,
+				const struct drm_connector *connector,
+				const struct drm_display_mode *mode);
 
 enum drm_connector_status
 dw_hdmi_connector_detect(struct drm_connector *connector, bool force);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 5dd0e2bc080d..81d73fbcb2e6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1638,66 +1638,75 @@ static void hdmi_tx_hdcp_config(struct dw_hdmi *hdmi)
 		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK, HDMI_A_HDCPCFG1);
 }
 
-static void hdmi_config_AVI(struct dw_hdmi *hdmi,
-			    const struct drm_connector *connector,
-			    const struct drm_display_mode *mode)
+void dw_hdmi_prep_avi_infoframe(struct hdmi_avi_infoframe *frame,
+				struct dw_hdmi *hdmi,
+				const struct drm_connector *connector,
+				const struct drm_display_mode *mode)
 {
-	struct hdmi_avi_infoframe frame;
-	u8 val;
-
 	/* Initialise info frame from DRM mode */
-	drm_hdmi_avi_infoframe_from_display_mode(&frame, connector, mode);
+	drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
 
 	if (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
-		drm_hdmi_avi_infoframe_quant_range(&frame, connector, mode,
+		drm_hdmi_avi_infoframe_quant_range(frame, connector, mode,
 						   hdmi->hdmi_data.rgb_limited_range ?
 						   HDMI_QUANTIZATION_RANGE_LIMITED :
 						   HDMI_QUANTIZATION_RANGE_FULL);
 	} else {
-		frame.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
-		frame.ycc_quantization_range =
+		frame->quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
+		frame->ycc_quantization_range =
 			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
 	}
 
 	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
-		frame.colorspace = HDMI_COLORSPACE_YUV444;
+		frame->colorspace = HDMI_COLORSPACE_YUV444;
 	else if (hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format))
-		frame.colorspace = HDMI_COLORSPACE_YUV422;
+		frame->colorspace = HDMI_COLORSPACE_YUV422;
 	else if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
-		frame.colorspace = HDMI_COLORSPACE_YUV420;
+		frame->colorspace = HDMI_COLORSPACE_YUV420;
 	else
-		frame.colorspace = HDMI_COLORSPACE_RGB;
+		frame->colorspace = HDMI_COLORSPACE_RGB;
 
 	/* Set up colorimetry */
 	if (!hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
 		switch (hdmi->hdmi_data.enc_out_encoding) {
 		case V4L2_YCBCR_ENC_601:
 			if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV601)
-				frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
+				frame->colorimetry = HDMI_COLORIMETRY_EXTENDED;
 			else
-				frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
-			frame.extended_colorimetry =
+				frame->colorimetry = HDMI_COLORIMETRY_ITU_601;
+			frame->extended_colorimetry =
 					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 			break;
 		case V4L2_YCBCR_ENC_709:
 			if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV709)
-				frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
+				frame->colorimetry = HDMI_COLORIMETRY_EXTENDED;
 			else
-				frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
-			frame.extended_colorimetry =
+				frame->colorimetry = HDMI_COLORIMETRY_ITU_709;
+			frame->extended_colorimetry =
 					HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
 			break;
 		default: /* Carries no data */
-			frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
-			frame.extended_colorimetry =
+			frame->colorimetry = HDMI_COLORIMETRY_ITU_601;
+			frame->extended_colorimetry =
 					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 			break;
 		}
 	} else {
-		frame.colorimetry = HDMI_COLORIMETRY_NONE;
-		frame.extended_colorimetry =
+		frame->colorimetry = HDMI_COLORIMETRY_NONE;
+		frame->extended_colorimetry =
 			HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 	}
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_prep_avi_infoframe);
+
+static void hdmi_config_AVI(struct dw_hdmi *hdmi,
+			    const struct drm_connector *connector,
+			    const struct drm_display_mode *mode)
+{
+	struct hdmi_avi_infoframe frame;
+	u8 val;
+
+	dw_hdmi_prep_avi_infoframe(&frame, hdmi, connector, mode);
 
 	/*
 	 * The Designware IP uses a different byte format from standard

-- 
2.45.0


