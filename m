Return-Path: <linux-kernel+bounces-276365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEEA949282
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2841F24098
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A620FAB4;
	Tue,  6 Aug 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPc4Dhpf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188920FA9B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952822; cv=none; b=j/H77x7Xxhcfky1wRkeJVAi8vBsQDazaptVJIWuEmFRTwyvqmsdE9UUO6ohQ2s1Gbd+QdQVVN+kLrE7ekAFvLMbe3Go3PPJKyIUSkACmwIfP3BvKeW/6DNJMk67KJE1Wy0aSIpp6hQq3I+QzfWYCWplvfS89mf54lUEte6qTnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952822; c=relaxed/simple;
	bh=a4pOxli9XW7+v4k6zJrj2UiwKJCQToCB+MB9KHECXIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtNE3oMTBZPiCduCndjkTFhIje3syL2BzHCOqNMldG50qBQUjmIRQ9xHWy2NBC8n6qinPmVAY8T/z410TSyEdW4fJ9iZ7M1jwsQMwlQ6y8bfCFXyUaEifIw98oJoC1ZUz6km2Mh9U8vBwoAonkcX/6waqAx9qXNHYYOd+f3dy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPc4Dhpf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710afa8d1dfso487074b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952820; x=1723557620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHlnE4b+EF1jE+6OxMeMiJgfIbEWX1SJndOm5es4WF8=;
        b=fPc4DhpfuxZeuo3xU2+VCPU4qoH/V10IoBzF9jGJoSvMPRbgFyRRDb2XChO4vgKMkP
         fcSExvHb2V4RAVkxowWWzpNCVnDZwylW9EMDTKmohulGTdLgFI0JskqQQKeLpPFtlybD
         YP7dKW6YYoqpLI1w3qwGUgJaYzen9kiL+WjZ50VKJctCTDkPptYEPC2mFNL+crvRDr/m
         f9xTZ754I3mUdQAfwv+Mz39zSumJfpFZTI2d6SfOuPZoZLT155dSrsyo7jau3eXGcYWW
         JiMYwOvzwPed7/c+0ybdeKRrkRn0TB+Oasi4K3jrJLOvyK5FHehtd5oLTPyKMtgVZFum
         djvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952820; x=1723557620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHlnE4b+EF1jE+6OxMeMiJgfIbEWX1SJndOm5es4WF8=;
        b=sz59BuDAFB8RIG2Em1wsty9rliv4OP+FWAqYDjhk1mijDevdsQgtF0CUqfKwqWtb+w
         B9lKzVvvY2gTi1O6W9CWEqRaUplNM/JdhvdWdu5rmjzveHbmTiODXFN7TbMsSVf01Z3F
         UPtR23nahMe3PjeuGnnWkKmvnGProZrsrtDklXspUJkfyRkjMjxFt4bcuP+cHP0kS/TN
         XtLJ/PfYY/Uwrxu9/lHGzyPjtzkbKpbVyJfsNapiVsl7ZveDSVCrqI0FvLNg1uw7nGpy
         FoxB8fyhChx0xrOZbd73+x9J9mRaix90W0SyimblCZ+LonHs6fVU79TcDFe4sKKs5rOg
         ThfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpuYUA1doivV6u72aKLyscP7rp5aD8dg+3o2vA1AMbJBpt1hiK5G0ewZ6yK3uqsMFXX6lYoquMBjzdwRZIaKjyib7rEoP/Cn7Zp5yX
X-Gm-Message-State: AOJu0Ywj68dzX9zVVqVT1+HL36wvzr3mRqWTAj1blvZsnEWQVi2vQoKM
	CRobuBVbOkX/7Xe6Z/6mh1HYi861Lk1RZ+l7js3ULSki06V/snVW
X-Google-Smtp-Source: AGHT+IHcJGI37zJWjKZY/3gSGyIlz/mnFiRHe73rgoXzvjKXK3FoUkz2I0fJ9saNOFAKAI5XOa+Prw==
X-Received: by 2002:a05:6a20:c990:b0:1c2:8904:14c2 with SMTP id adf61e73a8af0-1c69961543emr14209508637.37.1722952819962;
        Tue, 06 Aug 2024 07:00:19 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b8a7453e92sm4415203a12.41.2024.08.06.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:00:19 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v3 1/2] drm/mipi-dsi: add more multi functions for better error handling
Date: Tue,  6 Aug 2024 19:29:48 +0530
Message-ID: <20240806135949.468636-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806135949.468636-1-tejasvipin76@gmail.com>
References: <20240806135949.468636-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more functions that can benefit from being multi style and mark
older variants as deprecated to eventually convert all mipi_dsi functions
to multi style.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 194 +++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  10 ++
 2 files changed, 204 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..8d0a866cf1e0 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -603,6 +603,8 @@ EXPORT_SYMBOL(mipi_dsi_shutdown_peripheral);
  * mipi_dsi_turn_on_peripheral() - sends a Turn On Peripheral command
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_turn_on_peripheral_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi)
@@ -652,6 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
  * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
  *
  * Enable or disable Display Stream Compression on the peripheral.
+ * This function is deprecated. Use mipi_dsi_compression_mode_ext_multi() instead.
  *
  * Return: 0 on success or a negative error code on failure.
  */
@@ -703,6 +706,7 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
  * @pps: VESA DSC 1.1 Picture Parameter Set
  *
  * Transmit the VESA DSC 1.1 Picture Parameter Set to the peripheral.
+ * This function is deprecated. Use mipi_dsi_picture_parameter_set_multi() instead.
  *
  * Return: 0 on success or a negative error code on failure.
  */
@@ -1037,6 +1041,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_read);
  * mipi_dsi_dcs_nop() - send DCS nop packet
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_dcs_nop_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi)
@@ -1055,6 +1061,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_nop);
  * mipi_dsi_dcs_soft_reset() - perform a software reset of the display module
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_dcs_soft_reset_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi)
@@ -1124,6 +1132,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_get_pixel_format);
  *    display module except interface communication
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_dcs_enter_sleep_mode_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_enter_sleep_mode(struct mipi_dsi_device *dsi)
@@ -1143,6 +1153,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_enter_sleep_mode);
  *    module
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_dcs_exit_sleep_mode_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_exit_sleep_mode(struct mipi_dsi_device *dsi)
@@ -1162,6 +1174,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_exit_sleep_mode);
  *    display device
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_display_off_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_set_display_off(struct mipi_dsi_device *dsi)
@@ -1181,6 +1195,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_off);
  *    display device
  * @dsi: DSI peripheral device
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_display_on_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure
  */
 int mipi_dsi_dcs_set_display_on(struct mipi_dsi_device *dsi)
@@ -1202,6 +1218,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_on);
  * @start: first column of frame memory
  * @end: last column of frame memory
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_column_address_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
@@ -1226,6 +1245,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address);
  * @start: first page of frame memory
  * @end: last page of frame memory
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_page_address_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
@@ -1268,6 +1290,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off);
  * @dsi: DSI peripheral device
  * @mode: the Tearing Effect Output Line mode
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_tear_on_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure
  */
 int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
@@ -1291,6 +1315,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on);
  * @dsi: DSI peripheral device
  * @format: pixel format
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_pixel_format_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format)
@@ -1334,6 +1361,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline);
  * @dsi: DSI peripheral device
  * @brightness: brightness value
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_display_brightness_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
@@ -1639,6 +1669,170 @@ void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
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
+	int ret;
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
+	int ret;
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
+	int ret;
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
+	int ret;
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
+	int ret;
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
+ * mipi_dsi_dcs_set_page_address_multi() - define the page extent of the
+ *	frame memory accessed by the host processor
+ * @ctx: Context for multiple DSI transactions
+ * @start: first page of frame memory
+ * @end: last page of frame memory
+ *
+ * Like mipi_dsi_dcs_set_page_address() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
+					 u16 start, u16 end)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
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
index 0f520eeeaa8e..602be6ce081a 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -365,6 +365,16 @@ void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
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
2.46.0


