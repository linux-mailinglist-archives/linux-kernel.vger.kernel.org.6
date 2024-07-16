Return-Path: <linux-kernel+bounces-253828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02693278B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0285A281019
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48619AD78;
	Tue, 16 Jul 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhbC9hU+"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26C17C9FC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136721; cv=none; b=NUmmiUXEKZiFVjcWcY56vhjqeME2/r9MlFrWn+fK7kT1leGMAssaihcE4tuFXOl/RWsZ4FshNUxqTsPz6XT1sIqK3bSWGJmv+idIjsc4ot2bkpsuTfR54yljaw7NmKbnhXt+GRL1wJF/KqFro0hFCr2fynxkDKZW5n84KEGdPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136721; c=relaxed/simple;
	bh=a5W2OMC2Zebm3hyIdeqLu4cLlnk0dhrUoHYoP91KpG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJh70asNB3Um2T4r6CZ3CU9JfMfVt4PcQ00gjE8Pe+zVY3mGcUa20yMZfqcnttroZgURlXonnEOyda0XDLp+Okc55gP3odrUFWPzKhdHLcdmkbBR0jHcUzoNKSVSUTvwZnC2qd6QXbJWBo9rPBk7w4yRraEyN6PvUfAkt1NyyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhbC9hU+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so5205752b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721136719; x=1721741519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFRa+gyk0+Wb2cW/t0w5uYAjjmEn+HI1ogQknR97FUM=;
        b=OhbC9hU+lZisTmd6t+sTcj8HyPBlDW8iYzWh07Gbg9xt7WwbvFVEl34XZdzz+XhWo8
         W0qsVqPXaLyT8pdJ0DLBg6gT+3sJkjRNeaXP5YMOqtQWqlsMvvXHMZ4wFr7n8/SfOQHY
         Q72gwG63VR0sKu2wG+FfR0SoIoUnJywqvySL6O+TCkJg54EicJ616K9mV3MBS1t//t1H
         SIfcUCziMfSWH4H51wvpANcdE7S0ggo0LgvP1LtW4wYFhr5vTzXu435bxfAyDP4bW1Oo
         M/ji2N9bcuxyPwsQzMTunk450InIvdMqt3ZTUqcDuw+UXOXQlO/cXdC+2EuOlknw09f+
         GjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136719; x=1721741519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFRa+gyk0+Wb2cW/t0w5uYAjjmEn+HI1ogQknR97FUM=;
        b=ih/IHKoNoydp6n6DTOHMmc1i8LIRkE3c9IeQUgZz+6WSxtz1oj2uTNN8PscFANyCDE
         nQraYaMbMkloWUcdX2Zn9nGMXXN1sxsmgKep+KJGetzUbXib+qPU/49AklcBXt1JqZ0f
         r4ueFFc7diWHZVWqWeE63Nh9CpMRCdXoRzaHGw+dYyfraYCpduxp/P5v320pTxBFTryk
         w7gV1w162gNucL/kdW8rJVqJwoqyJyoZmJED/akRyXo81XDFpMwbnd7w/MxpgD0TsYpg
         HYz3IS+cNPywyaYoo7ZysOCU1Ct6pSwDatZ/ENWfscu4st3j1fUNgqRrgAnWMMYzSxpV
         NrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX66dRq9PhHTfjgALBy5X2Ahf0VCcqEWYhRIKtMcN8aCFMXSnQbht4Fx+Jrw2ISeK5j//2NrFvSMafiq2t+g4b8tG7e5zkZMm3xUfgz
X-Gm-Message-State: AOJu0YwRfSJffk48jzX2Wd3AFSJ860XUQNhlySFlnGQlZ//A1eGLjd7L
	orJYztMnR69W2fKPljiKwS2Ab2xp4cxp5wdWNT83slcUyHDT3gqT
X-Google-Smtp-Source: AGHT+IHTj7zY/KPUAV9SBLb534DACqmlDWpXtSyY9C02UqQ8tbFXYPCD8B8+QKQ+UPlb9DfFGoj3Hw==
X-Received: by 2002:a05:6a21:398f:b0:1c2:9208:3421 with SMTP id adf61e73a8af0-1c3f122f5e1mr2401132637.28.1721136718804;
        Tue, 16 Jul 2024 06:31:58 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6340:1ec9:d5f:aa00:a86b:ee8f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2733asm58400015ad.162.2024.07.16.06.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:31:58 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/mipi-dsi: Introduce macros to create mipi_dsi_*_multi functions
Date: Tue, 16 Jul 2024 19:01:17 +0530
Message-ID: <20240716133117.483514-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce 2 new macros, DSI_CTX_NO_OP and MIPI_DSI_ADD_MULTI_VARIANT.

DSI_CTX_NO_OP calls a function only if the context passed to it hasn't
encountered any errors. It is a generic form of what mipi_dsi_msleep
does.

MIPI_DSI_ADD_MULTI_VARIANT defines a multi style function of any
mipi_dsi function that follows a certain style. This allows us to
greatly reduce the amount of redundant code written for each multi
function. It reduces the overhead for a developer introducing new
mipi_dsi_*_multi functions.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 286 ++++++++++-----------------------
 1 file changed, 83 insertions(+), 203 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..53880b486f22 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1430,214 +1430,94 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_large);
 
 /**
- * mipi_dsi_picture_parameter_set_multi() - transmit the DSC PPS to the peripheral
- * @ctx: Context for multiple DSI transactions
- * @pps: VESA DSC 1.1 Picture Parameter Set
- *
- * Like mipi_dsi_picture_parameter_set() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
-void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
-				   const struct drm_dsc_picture_parameter_set *pps)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_picture_parameter_set(dsi, pps);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending PPS failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_picture_parameter_set_multi);
-
-/**
- * mipi_dsi_compression_mode_ext_multi() - enable/disable DSC on the peripheral
- * @ctx: Context for multiple DSI transactions
- * @enable: Whether to enable or disable the DSC
- * @algo: Selected compression algorithm
- * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
- *
- * Like mipi_dsi_compression_mode_ext() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
-void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
-					 bool enable,
-					 enum mipi_dsi_compression_algo algo,
-					 unsigned int pps_selector)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_compression_mode_ext(dsi, enable, algo, pps_selector);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending COMPRESSION_MODE failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
-
-/**
- * mipi_dsi_dcs_nop_multi() - send DCS NOP packet
- * @ctx: Context for multiple DSI transactions
- *
- * Like mipi_dsi_dcs_nop() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
+ * DSI_CTX_NO_OP() - Calls a function only if no previous errors have
+ *	occurred.
+ * @func: The function call that needs to happen.
+ * @ctx: Context whose accum_err is checked to decide if the function
+ *	should run.
  */
-void mipi_dsi_dcs_nop_multi(struct mipi_dsi_multi_context *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_dcs_nop(dsi);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending DCS NOP failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_nop_multi);
+#define DSI_CTX_NO_OP(func, ctx)	\
+	do {				\
+		if (!(ctx)->accum_err)	\
+			func;		\
+	} while (0)
 
 /**
- * mipi_dsi_dcs_enter_sleep_mode_multi() - send DCS ENTER_SLEEP_MODE  packet
- * @ctx: Context for multiple DSI transactions
+ * MIPI_DSI_ADD_MULTI_VARIANT() - Define the multi variant of
+ *	an existing MIPI DSI function.
+ * @proto: The prototype of the desired multi variant
+ * @err: The error string used by dev_err on an error occurring.
+ * @inner_func: Identifier of the function being wrapped
+ * @...: Any arguments that need to be passed to inner_func
  *
- * Like mipi_dsi_dcs_enter_sleep_mode() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
  */
-void mipi_dsi_dcs_enter_sleep_mode_multi(struct mipi_dsi_multi_context *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending DCS ENTER_SLEEP_MODE failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_enter_sleep_mode_multi);
-
-/**
- * mipi_dsi_dcs_exit_sleep_mode_multi() - send DCS EXIT_SLEEP_MODE packet
- * @ctx: Context for multiple DSI transactions
- *
- * Like mipi_dsi_dcs_exit_sleep_mode() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
-void mipi_dsi_dcs_exit_sleep_mode_multi(struct mipi_dsi_multi_context *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending DCS EXIT_SLEEP_MODE failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_exit_sleep_mode_multi);
-
-/**
- * mipi_dsi_dcs_set_display_off_multi() - send DCS SET_DISPLAY_OFF packet
- * @ctx: Context for multiple DSI transactions
- *
- * Like mipi_dsi_dcs_set_display_off() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
-void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending DCS SET_DISPLAY_OFF failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_set_display_off_multi);
-
-/**
- * mipi_dsi_dcs_set_display_on_multi() - send DCS SET_DISPLAY_ON packet
- * @ctx: Context for multiple DSI transactions
- *
- * Like mipi_dsi_dcs_set_display_on() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
-void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending DCS SET_DISPLAY_ON failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_set_display_on_multi);
-
-/**
- * mipi_dsi_dcs_set_tear_on_multi() - send DCS SET_TEAR_ON packet
- * @ctx: Context for multiple DSI transactions
- * @mode: the Tearing Effect Output Line mode
- *
- * Like mipi_dsi_dcs_set_tear_on() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
-void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
-				    enum mipi_dsi_dcs_tear_mode mode)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	if (ctx->accum_err)
-		return;
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, mode);
-	if (ret < 0) {
-		ctx->accum_err = ret;
-		dev_err(dev, "sending DCS SET_TEAR_ON failed: %d\n",
-			ctx->accum_err);
-	}
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
+#define MIPI_DSI_ADD_MULTI_VARIANT(proto, err, inner_func, ...)	\
+proto {								\
+	struct mipi_dsi_device *dsi = ctx->dsi;			\
+	struct device *dev = &dsi->dev;				\
+	int ret;						\
+	\
+	if (ctx->accum_err)					\
+		return;						\
+	\
+	ret = inner_func(dsi, ##__VA_ARGS__);			\
+	if (ret < 0) {						\
+		ctx->accum_err = ret;				\
+		dev_err(dev, err, ctx->accum_err);		\
+	}							\
+}								\
+EXPORT_SYMBOL(inner_func##_multi);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_picture_parameter_set_multi(
+	struct mipi_dsi_multi_context *ctx,
+	const struct drm_dsc_picture_parameter_set *pps),
+	"sending PPS failed: %d\n",
+	mipi_dsi_picture_parameter_set, pps);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_compression_mode_ext_multi(
+	struct mipi_dsi_multi_context *ctx, bool enable,
+	enum mipi_dsi_compression_algo algo, unsigned int pps_selector),
+	"sending COMPRESSION_MODE failed: %d\n",
+	mipi_dsi_compression_mode_ext, enable, algo, pps_selector);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_dcs_nop_multi(
+	struct mipi_dsi_multi_context *ctx),
+	"sending DCS NOP failed: %d\n",
+	mipi_dsi_dcs_nop);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_dcs_enter_sleep_mode_multi(
+	struct mipi_dsi_multi_context *ctx),
+	"sending DCS ENTER_SLEEP_MODE failed: %d\n",
+	mipi_dsi_dcs_enter_sleep_mode);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_dcs_exit_sleep_mode_multi(
+	struct mipi_dsi_multi_context *ctx),
+	"sending DCS EXIT_SLEEP_MODE failed: %d\n",
+	mipi_dsi_dcs_exit_sleep_mode);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_dcs_set_display_off_multi(
+	struct mipi_dsi_multi_context *ctx),
+	"sending DCS SET_DISPLAY_OFF failed: %d\n",
+	mipi_dsi_dcs_set_display_off);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_dcs_set_display_on_multi(
+	struct mipi_dsi_multi_context *ctx),
+	"sending DCS SET_DISPLAY_ON failed: %d\n",
+	mipi_dsi_dcs_set_display_on);
+
+MIPI_DSI_ADD_MULTI_VARIANT(
+	void mipi_dsi_dcs_set_tear_on_multi(
+	struct mipi_dsi_multi_context *ctx,
+	enum mipi_dsi_dcs_tear_mode mode),
+	"sending DCS SET_TEAR_ON failed: %d\n",
+	mipi_dsi_dcs_set_tear_on, mode);
 
 static int mipi_dsi_drv_probe(struct device *dev)
 {
-- 
2.45.2


