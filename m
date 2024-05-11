Return-Path: <linux-kernel+bounces-176769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA788C34A9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6425281EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555844D5B0;
	Sat, 11 May 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oytTqnv0"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06F2A8C1
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468432; cv=none; b=c2dp8j8D30Zfr/6ezXhn2rEexSVqLYiieXTPwzx85uCxPm7L4xb+QLgypZrTNHGMRz66yX9BcEv8AgTZK106ZXycul1QorpwbNkHLP6aG6qKAmLaHHXSuBOy/2R/cq+LypvQjru98OjP9Tpg3a50liYhWeUhmgWhPb12vl1+rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468432; c=relaxed/simple;
	bh=xi5U71kz8T87h4VViIeLZOLRoolhq+/AdfXL3EWovWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2Vb2xJGYudyxSPMKQkJlfIvHbH3Xd739pSOjfNg4Kco0SFbicQPOTy24j/2jzlvQeuz/PcWnz6ziOqif9vemu0NU0cPj+rzHiBjI31Dr4lWSQP9dMbmCGJIb59sZw6PjkHEFGhsPW6zug1fRInKIapro8fgZVG+t/e5sM1V2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oytTqnv0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so3245806e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468428; x=1716073228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BS3LNsIzlA8pD9hWWnKhxqZdHat5J4SEHWcVJTYiOg=;
        b=oytTqnv0oeV3cvtk91AgPEpWJCgmLqPC+4CFEQl7/yVZn5ebJPbzlpzIpYbhm5EQ+D
         94dnQ0vcp38oc6rcaSKmVvt5LKRYTQpLKMiPgnBaeSRveC5oAOJAEkyjQHp0BmEIm0F/
         6fb8XC3e4ADuzp6Vfd59frAef4wkTMM7qh86/Yxy6s5sL6P05Ab8Z5tYcjT4SWr8wAEd
         V+qIB9mnvRK+bRhDisSVqQH99mB5/NiMPSYK2DrcksztNJ3sTJXxG1jfGDMFgxXFd9NI
         KXcPOq4FlMvFNG/NQ/J3LzkF3mHfQd9rljJHzrKaCYW3ne1FkGa+emDqa3cc2kmpiJuk
         nqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468428; x=1716073228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BS3LNsIzlA8pD9hWWnKhxqZdHat5J4SEHWcVJTYiOg=;
        b=Dp6r3pkTMvHYXoaliOAbBSv+NAk6OiU16SGiV21rY/ZPJNi1B/2EIKZMztjFMgHr6c
         0KamnGWdz8ROc1r+kunGxYr3lqobWQ84R/qRpH8RwAaB5xsi7HVLv8yZveSetkRtnFT/
         KuJU/+WETdshNEec7XAVS7bRshETTSt+16lMdF21a4tov0ltF/yxur3SgRgXVBhhrWD7
         +/87jyERsl5wkT/36EanXna5PVgt3tT5uzhovIPEpvhD+ElTipcz4O/+vrGrCM89kyRV
         lhfj0iVF1pQLvM9ujEDpN/gCIBwq/aTHahYkZPSYM9ChqAmlCgXZXouzftgsNyqVgTj0
         XhvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXsC//oMfP8dmTraZM3rbwbvZ76Jthuljyr/NQqnm1JLuBAlYIJY/qMpNuOvF+LxAcoLiGAK07J5LmemNJVnpJHTg8tJodmMmmNmhS
X-Gm-Message-State: AOJu0YyNOT+QdXqpHWQ682Bw/11fXVGPFOwjCz4FpDRsdAeUi5Oy3TUe
	f/fFPk9yt+tgIwVRTNEF8Wlr+9d+zLZgzCfRWcRDyAzCNPzjvac4E5jN+wVBDso=
X-Google-Smtp-Source: AGHT+IGq3Q77PQC8pmuzZ6UbAb6S/DSxzj2GbGKSeMaal6d2Z8qeLT1e0EII0XLJJoahQXmtJxYm6w==
X-Received: by 2002:a05:6512:33c5:b0:522:2a2c:759e with SMTP id 2adb3069b0e04-5222a2c76c2mr3462466e87.6.1715468428300;
        Sat, 11 May 2024 16:00:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 02:00:19 +0300
Subject: [PATCH v2 2/7] drm/mipi-dsi: wrap more functions for streamline
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-dsi-panels-upd-api-v2-2-e31ca14d102e@linaro.org>
References: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
In-Reply-To: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9508;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xi5U71kz8T87h4VViIeLZOLRoolhq+/AdfXL3EWovWo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iILRHsslbO7N+jkxp9j4cFntTv96XBqLvLi
 sJVcR2kvcaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iAAKCRCLPIo+Aiko
 1Z9DB/0SiooYtozFy/Si/1cRF+TFzLyCUNPoKFTkvKu71M6eLqaVvGWGYZRJ5Djj2A2Wr6dh5OJ
 04lXqSIRYYlGMZJn0TZ4gByg2Ta3ZQafWiYOCAQSt92HyF8sk0JMCDHrSDOVwgnxElRgrwpC+vm
 QhGAijjacI42OHeCidtyTb+1exey8sb5eYYkve013ZUe1uzDA2EUgSp+Os/rRoVCpv++MsBdT7R
 9GJ18MvwTzNpQUC7EL/i8aTAXUgccXL1laDgdkFu7QN9xG3HSj1h901jpKDsCBdFVPZi810GmwF
 6JonyQp5VKjq0WcXTE1IZyH7DpnkaXVeUZeYzASgXZYNbB+y
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the pattern of mipi_dsi_dcs_*_multi() and wrap several existing
MIPI DSI functions to use the context for processing. This simplifies
and streamlines driver code to use simpler code pattern.

Note, msleep function is also wrapped in this way as it is frequently
called inbetween other mipi_dsi_dcs_*() functions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 210 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  21 +++++
 2 files changed, 231 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index d2957cb692d3..8721edd06c06 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1429,6 +1429,216 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_large);
 
+/**
+ * mipi_dsi_picture_parameter_set_multi() - transmit the DSC PPS to the peripheral
+ * @ctx: Context for multiple DSI transactions
+ * @pps: VESA DSC 1.1 Picture Parameter Set
+ *
+ * Like mipi_dsi_picture_parameter_set() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
+				   const struct drm_dsc_picture_parameter_set *pps)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_picture_parameter_set(dsi, pps);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending PPS failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_picture_parameter_set_multi);
+
+/**
+ * mipi_dsi_compression_mode_ext_multi() - enable/disable DSC on the peripheral
+ * @ctx: Context for multiple DSI transactions
+ * @enable: Whether to enable or disable the DSC
+ * @algo: Selected compression algorithm
+ * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
+ *
+ * Like mipi_dsi_compression_mode_ext() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
+					 bool enable,
+					 enum mipi_dsi_compression_algo algo,
+					 unsigned int pps_selector)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_compression_mode_ext(dsi, enable, algo, pps_selector);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending COMPRESSION_MODE failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
+
+/**
+ * mipi_dsi_dcs_nop_multi() - send DCS NOP packet
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_dcs_nop() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_nop_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_nop(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending DCS NOP failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_nop_multi);
+
+/**
+ * mipi_dsi_dcs_enter_sleep_mode_multi() - send DCS ENTER_SLEEP_MODE  packet
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_dcs_enter_sleep_mode() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_enter_sleep_mode_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending DCS ENTER_SLEEP_MODE failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_enter_sleep_mode_multi);
+
+/**
+ * mipi_dsi_dcs_exit_sleep_mode_multi() - send DCS EXIT_SLEEP_MODE packet
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_dcs_exit_sleep_mode() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_exit_sleep_mode_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending DCS EXIT_SLEEP_MODE failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_exit_sleep_mode_multi);
+
+/**
+ * mipi_dsi_dcs_set_display_off_multi() - send DCS SET_DISPLAY_OFF packet
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_dcs_set_display_off() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending DCS SET_DISPLAY_OFF failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_off_multi);
+
+/**
+ * mipi_dsi_dcs_set_display_on_multi() - send DCS SET_DISPLAY_ON packet
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_dcs_set_display_on() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending DCS SET_DISPLAY_ON failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_on_multi);
+
+/**
+ * mipi_dsi_dcs_set_tear_on_multi() - send DCS SET_TEAR_ON packet
+ * @ctx: Context for multiple DSI transactions
+ * @mode: the Tearing Effect Output Line mode
+ *
+ * Like mipi_dsi_dcs_set_tear_on() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
+				    enum mipi_dsi_dcs_tear_mode mode)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_tear_on(dsi, mode);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending DCS SET_TEAR_ON failed: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 5e9cad541bd6..bd5a0b6d0711 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -275,6 +275,13 @@ int mipi_dsi_compression_mode_ext(struct mipi_dsi_device *dsi, bool enable,
 int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
 				   const struct drm_dsc_picture_parameter_set *pps);
 
+void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
+					 bool enable,
+					 enum mipi_dsi_compression_algo algo,
+					 unsigned int pps_selector);
+void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
+					  const struct drm_dsc_picture_parameter_set *pps);
+
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
 int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
@@ -284,6 +291,12 @@ void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
+#define mipi_dsi_msleep(ctx, delay)	\
+	do {				\
+		if (!ctx.accum_err)	\
+			msleep(delay);	\
+	} while (0)
+
 /**
  * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
  * @MIPI_DSI_DCS_TEAR_MODE_VBLANK: the TE output line consists of V-Blanking
@@ -338,6 +351,14 @@ int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
 int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 					     u16 *brightness);
 
+void mipi_dsi_dcs_nop_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_enter_sleep_mode_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_exit_sleep_mode_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
+				    enum mipi_dsi_dcs_tear_mode mode);
+
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
  *

-- 
2.39.2


