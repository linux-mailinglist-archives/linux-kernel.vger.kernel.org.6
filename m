Return-Path: <linux-kernel+bounces-293605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDD9581E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6D1C244B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698018C340;
	Tue, 20 Aug 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NayiYrfY"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9118C32E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145369; cv=none; b=GRLozD2dpbodZo5m9JoJ8yN0Hdf8JamQOErAjMtR9RNLzWUegeNAuhQhTGXiXVP6NjCC7F+MlwnYG36bc2vS4uuXBuktHf59Podp948w/dj8YDv2Widn45wdCyf8iceBZ60/Pt3S+cJSsZ2Pb2A/udno8npIG8z4WgmBCHiAvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145369; c=relaxed/simple;
	bh=8Adq4j8o3HUE7W4337mpMqyVEjaqILuHq29TBpJU3Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClUnuLQlhEL/SqxgTc4NUoikOxWSJGFxDznUBhDE73S5tbDCoaPkm0PLFgl3t6Fq2F/jhK/dX2iRi8Fo2kGJZSSTpOsiuxukQCQ/Q5Ip1jQxGWcNBe6cbJqcMEI5q6lZL5SD0L7KHRbRPr88eS6yB/36X+iSj2YIgWYHQLrFI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NayiYrfY; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70943b07c2cso2971124a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145367; x=1724750167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCBslt5gB3nUXvXHwuQOQFRpSOaNMZ/Utr1g4nHpxtg=;
        b=NayiYrfYoU9B/9KUSYJPqz/2DPOTf4cMA1uIJ+xQGHuUvNKNYgN4eINjI7DYQuNn6T
         TubVcTTVVa2vFHFB3bG3+TL3D5g90JeEIS4mbEs3vo6Y1XgV9aUhG6Zw5eHF7oe/p9Lu
         t/nPSOzbP5fbsPxa92fadC67nJ7pcKInmwrvVgUVpwTOYHBmmcyJp9p+tZGSzMYWKmm/
         lacWdEjUHlfRvGeWSDJgNcMzYwPQg3YV3s0MbN2IHbayCnjQHiSQRKUsqKiZ0dqlmXmO
         MvStA+JrVGR5IsP3JErPyU9Wcf7BuZDRcnIexff28AnWUeAk+AoAYoGTc0hJ9ivdnuSA
         M0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145367; x=1724750167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCBslt5gB3nUXvXHwuQOQFRpSOaNMZ/Utr1g4nHpxtg=;
        b=NK7bTCLcIgGSmbOijjJP8bfJ3toFpFVFMNCUcNWBFGbvpDnDz96ozprGL7ApqTsAtC
         5RAylztIcRtFCUzVvueedjnH6zXdkrKnA5QpIH/ieA9eW3hjw0+vuit505UfjH/BBP9K
         mrmSjAlRD8oPgAUYPRalBPmuI8hh3IW3SBFbBJBy2vSlqlP9cUwur+tP0yo57DH/jGKB
         IImOnRf/mujubz6nail1FJJvXreGGoz8UFlnRkLWBaJmC/4hUx+DXFzFKH33UOUndzde
         5nXC4A5e1lZ63jb4soAJTtYj5jnT0b/UdygwwhN3N+W+mEAQQnroZWBB4swGh4vLltdw
         XMUA==
X-Forwarded-Encrypted: i=1; AJvYcCV8KgzY394isWO8ZFxp2mSMuyfWlN5PEZVnCSUvQdCIX8T1Mr0/OwRZtJ8cuiOXDo9tcQvtq8GPKFwmgOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwLc4b3h7o/EP1ZlylCO12M39ONeFSwz++uIH5cb3WUVmyOuK
	fGZ4tPvZX5SUcS6LocYq+Bx3xlhkGUt5ouoov/vCsx+VyETOrEPS
X-Google-Smtp-Source: AGHT+IFTHbQP2i+11NODPc5ivc3dGCL2Qv/b7ATn9hndWNG81Yc7BxFDpJm/MjT/LMk7E9O51oBAJA==
X-Received: by 2002:a05:6830:6388:b0:704:4abf:c0d6 with SMTP id 46e09a7af769-70cac86e087mr16684504a34.20.1724145366764;
        Tue, 20 Aug 2024 02:16:06 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6f12sm8998575a12.35.2024.08.20.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:16:06 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: agx@sigxcpu.org,
	kernel@puri.sm,
	neil.armstrong@linaro.org
Cc: dianders@chromium.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 1/2] drm/panel: mantix-mlaf057we51: transition to mipi_dsi wrapped functions
Date: Tue, 20 Aug 2024 14:45:53 +0530
Message-ID: <20240820091556.1032726-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820091556.1032726-1-tejasvipin76@gmail.com>
References: <20240820091556.1032726-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes the mantix-mlaf057we51 panel to use multi style functions for
improved error handling.

Reviewed-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 77 +++++++------------
 1 file changed, 26 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index ea4a6bf6d35b..2a365eaa4ad4 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -45,82 +45,57 @@ static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
 	return container_of(panel, struct mantix, panel);
 }
 
-static int mantix_init_sequence(struct mantix *ctx)
+static void mantix_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	struct device *dev = ctx->dev;
-
 	/*
 	 * Init sequence was supplied by the panel vendor.
 	 */
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
-
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
 
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
-	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
-	msleep(20);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xA9, 0x00);
 
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
-	msleep(20);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
+	mipi_dsi_msleep(dsi_ctx, 20);
 
-	dev_dbg(dev, "Panel init sequence done\n");
-	return 0;
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
+	mipi_dsi_msleep(dsi_ctx, 20);
 }
 
 static int mantix_enable(struct drm_panel *panel)
 {
 	struct mantix *ctx = panel_to_mantix(panel);
-	struct device *dev = ctx->dev;
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
-	int ret;
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mantix_init_sequence(ctx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
-		return ret;
-	}
+	mantix_init_sequence(&dsi_ctx);
+	if (!dsi_ctx.accum_err)
+		dev_dbg(ctx->dev, "Panel init sequence done\n");
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode\n");
-		return ret;
-	}
-	msleep(20);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret)
-		return ret;
-	usleep_range(10000, 12000);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 12000);
 
-	ret = mipi_dsi_turn_on_peripheral(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to turn on peripheral\n");
-		return ret;
-	}
+	mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int mantix_disable(struct drm_panel *panel)
 {
 	struct mantix *ctx = panel_to_mantix(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "Failed to turn off the display: %d\n", ret);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int mantix_unprepare(struct drm_panel *panel)
-- 
2.46.0


