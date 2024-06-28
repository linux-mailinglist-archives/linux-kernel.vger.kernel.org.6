Return-Path: <linux-kernel+bounces-234358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE791C5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BB286BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B61CE088;
	Fri, 28 Jun 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMPke/Ii"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFC1CD5D2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599118; cv=none; b=Ll6GOQa/yIZTelu9f/7jrsNtQCFEbwggL19BOcru42Yigqa4prrbwEo8kL/lOmk6gA6qvEzXXqoKimxE337avGiLLCsQDDcASuT23n8WQ4eqN8TjXXqfJ/oUTebaKurRCVKKhsKhoOArEANisOs9B5El28VTlNaypuQI84E2cys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599118; c=relaxed/simple;
	bh=9HzQRUxArmfCRKcKAxBIIo8OnEWX1WShUk7sdHwZEZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4vaePwdJ7Ojk8QryBG4GI+dPAxXV8tuG6WQ8WbtuXLtfJjqNul5HS9zPhPkgRm8sLxqNzrPy/IJdf5yyfB6/IAXC9CyVU72tvCboaWplzoLDWTnt+lvPUnSfbxZAsKp2P+2CwlD+1qE2PtznoXyegowvjrUwYLnCeOtRi6w2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMPke/Ii; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e3741519d7so624024a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719599116; x=1720203916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY2P1E432InDtUHAxbRlDlnKMwO9s6Lbp9JbCU+YOkk=;
        b=HMPke/IiSnBzugOsui1UZ2ED4NCOZHahdQmxBShU9+Ipzg14ndpcx/tjkduc/FpxY6
         eqIfp0RfPL0zLl3fxAHX0Eub+wD8xnWsS6rx8wiVjsDCleUFlEvjrQD0CJ4M8vzoX7ED
         2iu4OWL8+98e8aTKL09rhlKJUON4vadxBLwpCtw333PxwoAgEeNtZBifDbQpNxR9o2vR
         0eGC/c+rCzDmFQN3Mk8jjjxlRpNTKv0v9i8dDWL+ZamvLlB52dHgmyoqMsJI2q+T1dBK
         cvuJwvIrjA7imKIGjJQP4j1cLKu82Edt+IsVh1sKzGO/7l4MzTmnc7s1cMi0xbmu5HMD
         605w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599116; x=1720203916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZY2P1E432InDtUHAxbRlDlnKMwO9s6Lbp9JbCU+YOkk=;
        b=pcHVJxQ/kMVEZqm/3J3uPBRljANjVg6MQrsZE/+y5vIWljp+dV9rm8Y4N6tln4DwXu
         qjZuPzsJyIG450dwU83Mx6Wc1Bxi1oKqZqt1C9UGF7gguXDUd3pIIBcEowuyl9iOjpKE
         stXCLNFineXJqp+zz/VgLa3H6AwgRoyzkyozdSN4/pslyGY8aC2PF9bDuAJwBKDY6BOn
         t7h/GnkKwrwj/WPXun9yCF8tMWUgXAAccb6ukUNKwtQMV5eCxSSK5VUdoe3DLT0KPwfN
         zJutByCqgjXmUttEI9hs2kwK0YTRMpU4ACIBs+XohJmIqLVLWMqVkKsNbP+2ES72twyF
         ymHw==
X-Forwarded-Encrypted: i=1; AJvYcCX2TJyFx7ieBg64OpB5F6nt1qPt1D4RgD/QhSG/GI7eOp5ZPUlZ+ZzPD/YqbFxmFcpUrkQxSOx7l+nDrn2W8Fvqgs13GL/yo5ZFjQjb
X-Gm-Message-State: AOJu0YwSmXpL0yGS90s8Sxt4AAyAsv7MxnrfU96Z1dXJHsB+7AlE78ui
	45hUGT5HSHp02SYQCpCBLnbagyalTwr0I8nUnVEr7QALoKda9PNB
X-Google-Smtp-Source: AGHT+IFd227CU4NsKhgIV1ptlu36fNPRaWha69js3+JNj18Wns8bvFJngeFgg2rvQ4Dg5Ge6fu0USQ==
X-Received: by 2002:a05:6a21:99a8:b0:1be:c641:de2a with SMTP id adf61e73a8af0-1bec641df45mr9487173637.47.1719599115903;
        Fri, 28 Jun 2024 11:25:15 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e21aesm18557465ad.64.2024.06.28.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:25:15 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 1/2] drm/mipi-dsi: add more multi functions for better error handling
Date: Fri, 28 Jun 2024 23:54:27 +0530
Message-ID: <20240628182428.171031-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628182428.171031-1-tejasvipin76@gmail.com>
References: <20240628182428.171031-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more functions that can benefit from being multi style, which
reduces code size in panels where they appear.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 164 +++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  10 ++
 2 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..3f7fe734b684 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1639,6 +1639,170 @@ void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
 
+/**
+ * mipi_dsi_turn_on_peripheral_multi() - sends a Turn On Peripheral command
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_turn_on_peripheral() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_turn_on_peripheral(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to turn on peripheral: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral_multi);
+
+/**
+ * mipi_dsi_dcs_soft_reset_multi() - perform a software reset of the display module
+ * @ctx: Context for multiple DSI transactions
+ *
+ * Like mipi_dsi_dcs_soft_reset() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_soft_reset_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_soft_reset(dsi);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to mipi_dsi_dcs_soft_reset: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_soft_reset_multi);
+
+/**
+ * mipi_dsi_dcs_set_display_brightness_multi() - sets the brightness value of
+ *	the display
+ * @ctx: Context for multiple DSI transactions
+ * @brightness: brightness value
+ *
+ * Like mipi_dsi_dcs_set_display_brightness() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
+					       u16 brightness)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to write display brightness: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness_multi);
+
+/**
+ * mipi_dsi_dcs_set_pixel_format_multi() - sets the pixel format for the RGB image
+ *	data used by the interface
+ * @ctx: Context for multiple DSI transactions
+ * @format: pixel format
+ *
+ * Like mipi_dsi_dcs_set_pixel_format() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_pixel_format_multi(struct mipi_dsi_multi_context *ctx,
+					 u8 format)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_pixel_format(dsi, format);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to set pixel format: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format_multi);
+
+/**
+ * mipi_dsi_dcs_set_column_address_multi() - define the column extent of the
+ *	frame memory accessed by the host processor
+ * @ctx: Context for multiple DSI transactions
+ * @start: first column of frame memory
+ * @end: last column of frame memory
+ *
+ * Like mipi_dsi_dcs_set_column_address() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
+					   u16 start, u16 end)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_column_address(dsi, start, end);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to set column address: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address_multi);
+
+/**
+ * mipi_dsi_dcs_set_page_address_multi() - define the column extent of the
+ *	frame memory accessed by the host processor
+ * @ctx: Context for multiple DSI transactions
+ * @start: first column of frame memory
+ * @end: last column of frame memory
+ *
+ * Like mipi_dsi_dcs_set_page_address() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
+					   u16 start, u16 end)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_page_address(dsi, start, end);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to set page address: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address_multi);
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 71d121aeef24..203b5d53d58f 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -358,6 +358,16 @@ void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
 void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx);
 void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
 				    enum mipi_dsi_dcs_tear_mode mode);
+void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_soft_reset_multi(struct mipi_dsi_multi_context *ctx);
+void mipi_dsi_dcs_set_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
+					       u16 brightness);
+void mipi_dsi_dcs_set_pixel_format_multi(struct mipi_dsi_multi_context *ctx,
+					 u8 format);
+void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
+					   u16 start, u16 end);
+void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
+					   u16 start, u16 end);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.45.2


