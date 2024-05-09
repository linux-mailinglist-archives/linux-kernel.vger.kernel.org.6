Return-Path: <linux-kernel+bounces-175039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2058C197A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C5282030
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0C12D75A;
	Thu,  9 May 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yM5bU7Mh"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A761292E6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294261; cv=none; b=Qw4d80P9w1kyK2wnYyOwG+5WOYoEBulz3bOA6wqN3Kk39SDSETeDzOsbEZqOGc/pWgyy3rcpRVsUg/djE5neapTHppJvT5ZcRLeT27jpIDt4qnvwFLOn16itvp7MxCcpgswjMel8sGyeCRj/tEd3zz3dE9PD8q7YDgilkaUG2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294261; c=relaxed/simple;
	bh=vRxiLvTGirbB6HN43H6Eoei1WmxE/UqWmb9+hJ19B+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyu6oXxeF0Dz1QyjM1DfIHRz+C8+ZPvko4Np9OmVSC009O/uSMp4o1mF+dwAGKiALm06TcEsG8B1cgCgkj8K2cChfgUoeKpwhLW95XXMonRAIn2L0vl3mv9X3RfQaWdcN9ZsUf+ioqaRw37UL6k9FAoGGqoHl1LkRmNm/AEtN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yM5bU7Mh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5210684cee6so1519097e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294257; x=1715899057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wy0dt4C+2st62hdh4kql6KATuv+sQnVh0BPdtj9s5/U=;
        b=yM5bU7MhbiMtMsIRQrG7p2MuzvC8lVc8DJNR7ijZhpWQc2FSX7diTSReH/BybWtzy5
         2Ayh9lEoWrpRLOIN6EarQ3j9p5nyQeOwpxz/s0GlBEvwfLib4wqjLMC42B22AlSjseU+
         a7iFvYTsSOM7Mj8w1E+CijhGWyzidrQlSyj5UHOP++uLxxVsGUboiUpzqz/RnvxW5Yz7
         FZpuHz77sQrLjjto6NCqzjcoGsNTIbld3VZ+MmTOyhQ4NUEjvUlZ3v94ToAakRoOvZq0
         6NYqeRc76MT/IuqmsRz6VjQGnwaD1PUH26Wxeb1uBd13I8ijx04C6Fio3YdarBsXUH5V
         RefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294257; x=1715899057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy0dt4C+2st62hdh4kql6KATuv+sQnVh0BPdtj9s5/U=;
        b=QvXgtTEBugPMg8y/sjqdaP1j3JJbS1Nhi4mBm7NwzE1mkOxcpdE++pZ90WMRUnojOJ
         D3zLC4kBhs5e7AJk8ouFcEx1YZ4UeHKnEgdTWuaDHbOptsFrABA0uSqh2kWNwbMG89oz
         FK0o/lJQNx7RrvwTG4fVEJUL/SfbqRhXfZTm2JtZMWXqFwxaklmvcYXaUHkes2/NGmwK
         vFW0VABfd3/jghGuU9NCSFqBj17qf9H3OAZMci6RVm0B1Td+wVpBZVfpcxkA0Lozsl8s
         Nwt64WgKKnP6JPR1l8dqPrgkDhZ1dHAaaAmwqKtIEGzdppZU/DRwwtNm6esedd7JJvzL
         0Xmg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZ8jhcSTL7gpNNLwzsFwvN8aRpLmMsF4xRIEE50YnJvJuXFo7Xx/kydsK+QRCGyQpwQhUoTwVcTtzPYUpGE3GdUN1Ijo0AqtH7KI3
X-Gm-Message-State: AOJu0YyXqHdshGT7UFMox6GBjtQPdJ7viuWhcaEfGYSQPCfn43x1UcVH
	JfPdygARJGpuJ4mJLDCS0Z12pMdAxFLkPVlNmmTLBWZB+p/5V4jWH2PRC19J/nE=
X-Google-Smtp-Source: AGHT+IFFYEts9ZdAyO7Nds0YpCPtjBBhbL4QPT1Cngkc5NgAxY7Yoqv1tCL+scNEb/egzkHvDimwRw==
X-Received: by 2002:a19:6449:0:b0:51d:8756:33f3 with SMTP id 2adb3069b0e04-5220fc6d46bmr467761e87.32.1715294256979;
        Thu, 09 May 2024 15:37:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:34 +0300
Subject: [PATCH RFC 1/7] drm/mipi-dsi: wrap more functions for streamline
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-1-317c78a0dcc8@linaro.org>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9046;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=vRxiLvTGirbB6HN43H6Eoei1WmxE/UqWmb9+hJ19B+U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPVAuK86GU8+ebU/1bVmiEBTyjZ+Bg5j7tOlty
 DaCkxLKzTGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj1QLgAKCRCLPIo+Aiko
 1YWoB/9zqwhRLAqs5SU32GE/oZfJ/4r5Ewh0B+3p+KKiFO/MoILG5QBiSBlw09fRoyjCcKxKOqk
 v3SifezXPjC9mSGKE3owHb9fVL2GmsOEVct669hYocAXHvZMkwM3PCqBpm6HmMA9zPyAIZNu5lQ
 ipuTJt0YczcR4Xe/cHHqGtj6iRXM56SxsVYpmRi4IdvzLIfSRAePrgScU4g9D0Qrr/mNqI08bil
 1KvLUlaMIa6vo776VEoCbgMX+BtWIZEZhkF86mTPNt/aSQn8tlcZeWvVs/4mRmkuEo1fMDb9qNG
 KNr6AuQ264YR/sq9E4pl/8hx7G7QO3MlqN3dtZqeKhFsyUQ/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the pattern of mipi_dsi_dcs_*_multi() and wrap several existing
MIPI DSI functions to use the context for processing. This simplifies
and streamlines driver code to use simpler code pattern.

Note, msleep function is also wrapped in this way as it is frequently
called inbetween other mipi_dsi_dcs_*() functions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 209 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  19 ++++
 2 files changed, 228 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index d2957cb692d3..4e5e7ad10b7e 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1429,6 +1429,215 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
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
+ * mipi_dsi_compression_mode_ext() - enable/disable DSC on the peripheral
+ * @ctx: Context for multiple DSI transactions
+ * @enable: Whether to enable or disable the DSC
+ * @algo: Selected compression algorithm
+ * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
+ *
+ * Like mipi_dsi_compression_mode_ext_multi() but deals with errors in a way that
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
index 5e9cad541bd6..b74a89b40f21 100644
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
@@ -338,6 +345,18 @@ int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
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
+#define mipi_dsi_msleep(ctx, delay)	\
+	if (!ctx.accum_err)		\
+		msleep(delay)		\
+
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
  *

-- 
2.39.2


