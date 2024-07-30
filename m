Return-Path: <linux-kernel+bounces-266819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEB940818
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951D828445B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4616848F;
	Tue, 30 Jul 2024 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOTzc7/p"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDD624
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319644; cv=none; b=V6DLYXLOyhGWMQLYb2ki4jexN2HGHVccOhrQVp8xVq8LRBE7XR6nkzu22tkxJkc5d7WVwB5iFzWZaNGZ0aG7Rr9aOjA60OB2/Wkq4mRoNtR63HH2/SSxLS7vH9bkjvRAJNW/iA0uCjXsAXB8hjswKZV9OZLgSqHIZVz6aSIfm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319644; c=relaxed/simple;
	bh=Ot2i4JTP6rs0pE6hCNTi9YckcHJoyZ3Com3tk3zJHeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbjhPn8vuoFOeKOvN7zOKvDAeg6xRiz1o13pnlbno/uGbCExhnNZs/yXjwMNznYjNvu7zCT21NCY8EQuIMe+5ZwdJnydIsfpIGNrkGHiinIoL+uzpurArP/iolFHWW6Z5I7GkHHfrSoJ7kc0BOY1OO3MPnTCe3vkPwGp2NVmXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOTzc7/p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc611a0f8cso26224305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722319642; x=1722924442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd9hAjyCQBhloSpV+RDMeaB1mHd7Gugwt3ADGi253Hk=;
        b=VOTzc7/pZN3hogAq7B5K2SYul+7iPEu9uG/pDK7mTzSBzvAQu8IRfIEUtYw3k9uBC5
         ft10+EuwE595HCqVKPktnmoiBOUP8n+oO3xqUfzTZCTjVtPEO4BiuNmuypR6rfDclOfU
         kaMw/MCITBgAd7qfl1fNVkIfvgHCeOaVJAtZVzKW/c3HX3g2vpHLSHCEregfQJ5YOHTf
         5WnbD9kVawzcM3Ho1JBaqCcraUbmBLayQmQmTO2cqnnxokpU7zDcbQ4iuAHJ+rytb2bT
         PaRd+BqlBo4WAchPogEfsEiDxeql8qpvmTIQWLmjIyE76NSWilUL+LP0sMjJ72NeZfaT
         98aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722319642; x=1722924442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd9hAjyCQBhloSpV+RDMeaB1mHd7Gugwt3ADGi253Hk=;
        b=iaKEryC2bbQf8QuC1LqU5T11jqKjtYHeSD7FBk3UoG+w4nh+BBIswVwn6ybhIbN1wg
         Mi85sjUUs3jfebaH3bim8w9eVrcblxGKPq6ftEKIZoV37zsXttcnMesQ+1h7CVrwdxgs
         53pk97BAkzJg6JXiue5kP9FO/dsCYS83LlyOjkJsTjaeFz/pAd6hgyjDY4HnSW7ZpI1v
         H/eyOIFS6LGMNA7nKdaK175J3j4DCWEHt5wv3+ofoWhNaGby0RJ3EobikodQHu4KRDaB
         hSQq04BqadbkmiSgfZEemQAxR3smGFDq0+jsjEuhpLPI3Uy2mgT+de1v5WCbN3lGwsMX
         VQbw==
X-Forwarded-Encrypted: i=1; AJvYcCVDPHYdAmYv55LvQjmH6fSojWSeNRUcD6CBW0M8I3XRoLse9ss6lGcwPWUUxukhrlJiBW7xaHnmksKTWyI21L3/0kx1qD+I9aX2LBMk
X-Gm-Message-State: AOJu0YwiXTH9vG936fTHKzhNi9CFrTqKFmmDl9M/YsdJ7MpoWZgw1toe
	xEh9p94KeH7FrOcE89UmrU13inGoWg90fiIz5Ejhe1ZKLIdMDWFRWCdtJg==
X-Google-Smtp-Source: AGHT+IHHJKGESTzjusjXTWlelC6jOCMHOpDpQ+ColI/hjVJOD7iieFAtQqc0fAJKYgCWr7iv1menIw==
X-Received: by 2002:a17:902:f54b:b0:1fb:1faa:96b7 with SMTP id d9443c01a7336-1ff047ddcf4mr92385015ad.9.1722319642135;
        Mon, 29 Jul 2024 23:07:22 -0700 (PDT)
Received: from distilledx.localdomain ([2401:4900:6320:5c5f:a09c:1e46:e58e:e6c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7eef4f0sm93589375ad.178.2024.07.29.23.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:07:21 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm/mipi-dsi: add more multi functions for better error handling
Date: Tue, 30 Jul 2024 11:36:58 +0530
Message-ID: <20240730060659.455953-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730060659.455953-1-tejasvipin76@gmail.com>
References: <20240730060659.455953-1-tejasvipin76@gmail.com>
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

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 226 +++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  12 ++
 2 files changed, 238 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..05ea7df5dec1 100644
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
@@ -1357,6 +1387,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness);
  * @dsi: DSI peripheral device
  * @brightness: brightness value
  *
+ * This function is deprecated. Use mipi_dsi_dcs_get_display_brightness_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
@@ -1639,6 +1672,199 @@ void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
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
+/**
+ * mipi_dsi_dcs_get_display_brightness_multi() - gets the current brightness value
+ *    of the display
+ * @ctx: Context for multiple DSI transactions
+ * @brightness: brightness value
+ *
+ * Like mipi_dsi_dcs_get_display_brightness() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
+					       u16 *brightness)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_get_display_brightness(dsi, brightness);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to get display brightness: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_multi);
+
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 0f520eeeaa8e..7c6239d7b492 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -365,6 +365,18 @@ void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
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
+void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
+					       u16 *brightness);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.45.2


