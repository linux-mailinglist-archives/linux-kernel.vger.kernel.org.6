Return-Path: <linux-kernel+bounces-290911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDF955B19
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22813282561
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592EB125D6;
	Sun, 18 Aug 2024 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCYwOgtu"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B5101DE
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961313; cv=none; b=LUUrJ6gZtHQTdfEcXeaVNI1HN+gOmTZxdC4mpBksoEiuRnnuBYTOrnqfeP3bEKtju3+LZahPOCoaPGwFvKPMEVjo8OE/o9Kk1cb/tUyqZ/5fqPUW2g6U+Q2cPUnhONTatxx0HiAdrkXC8xvq4lX5bzO1/0HXkIf4Ci0hY2e/+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961313; c=relaxed/simple;
	bh=O+dFhSSwMviCycogW/WqcduEniOW27fwihvWs/emkLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLF2aCje1wqXH0wqqCVnIRMWSVk70xbqneaawbQMPaiPgM/lHQ/Asp13XBfmSVhgP8HUXeb4G3epqoznIDhhfEUPTY3tTWu3r+SOxjR5gWnUKQITf2yQT9g9/4v+/x36ctQx/FsdKXERDNW2CEBeLO/URraYK59OeRfFM1PHHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCYwOgtu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2562026a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723961311; x=1724566111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnhRO8oIbYzeyc2+UcIe5cCUCjnBIooF0x4NCKcs5c0=;
        b=bCYwOgtuC86xn5SKZnfbLjEjeeW3uuw0bWd2KT6lq2dvHusijYaZvGDd6DedPw5+ST
         Xx8z08qMRRXBBR2/qC1IGgwxoOcn2sjcyV6sR9nlJ9kttyitxDIZ4Fl9vsc0z+3YZOc4
         GN8OJiJrnfY03kmM6pp4lJjd3DE5QLP8gDv91AmP4JA6sGBd+X4Oj0NQRsTv+6o8S7FG
         z+rbkxwYmF6SCLFGY6nDpEPaIxbffBSYrUoqVAlqLkGRGG2bxa1YWiSvN777N5beLCjh
         TLiJ+30QBu0LFwZQKvs4o72u5zm8Wd1uY+IlaadejR37S0mZGlNUtJUdf3ZYeeC9XXOn
         uENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723961311; x=1724566111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnhRO8oIbYzeyc2+UcIe5cCUCjnBIooF0x4NCKcs5c0=;
        b=YM7d9En7IdLXit6I2nCSRz0IxrGLj4EaDwYHbwYld4T6ekDAUKRElI/sAZ/jldZxMf
         KrCAzjXd8njwE3KionwwSMbEwE1vQBVrSa7PboY5PyzzArQEf9CbtFOP44Y1pn5pv3C9
         WfeSM/oK7UNikAOaKSqvZ/DnIH9grnTK8KtEjVMWwDdvSGUVwnJDkPo3DeD21Z9w9JGE
         Jp3+mJo6Ip8a5VQChibCIFZyM0j37tvVZdxGYAXWe+bOiBHstpVbivQ8gQfAl15YVS4s
         U0XVZc1cTP/SeDKJT8B5WOoLmX18GNYgAk/QxNknVQ2sU9+dkhrTyAda3xsC2IKm795E
         OODw==
X-Forwarded-Encrypted: i=1; AJvYcCWzixAVhYaj6aqtmXKdp1mq1pXzNNUnWjAucKn8H//Hxb+zBKvq8XRdt1sTZBCOrPQiUMzPrq6Wmlr/BIecqvLyXG4FIPK6eSt2YIi5
X-Gm-Message-State: AOJu0YzbWUsl/C3KHc3XSbaUoGd9hVa6dnEVCEuUBNvINgL8t9aaIS0u
	7I7vmNj2Wq7dsj15lv+M9CBV7nwpRk1VIj04dIC9MspyEQ/oSa5/
X-Google-Smtp-Source: AGHT+IFKX+dkBN6/eSiq0VUEAhavDIJd0EypI+SXpKA6+P2rIe7RILckQEXPojZOkD0j1gGj5WjfXA==
X-Received: by 2002:a17:90a:a787:b0:2cb:3306:b2cc with SMTP id 98e67ed59e1d1-2d3dfc2aa4amr8742078a91.1.1723961311044;
        Sat, 17 Aug 2024 23:08:31 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6322:f541:ea23:e535:a48c:3c88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d4394e01b4sm236228a91.46.2024.08.17.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:08:30 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
Date: Sun, 18 Aug 2024 11:38:15 +0530
Message-ID: <20240818060816.848784-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240818060816.848784-1-tejasvipin76@gmail.com>
References: <20240818060816.848784-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mipi_dsi_dcs_set_tear_scanline_multi can heavily benefit from being
converted to a multi style function as it is often called in the context of
similar functions.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 8d0a866cf1e0..b7ad18c148c2 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1339,6 +1339,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format);
  * @dsi: DSI peripheral device
  * @scanline: scanline to use as trigger
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_tear_scanline_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure
  */
 int mipi_dsi_dcs_set_tear_scanline(struct mipi_dsi_device *dsi, u16 scanline)
@@ -1833,6 +1836,34 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address_multi);
 
+/**
+ * mipi_dsi_dcs_set_tear_scanline_multi() - set the scanline to use as trigger for
+ *    the Tearing Effect output signal of the display module
+ * @ctx: Context for multiple DSI transactions
+ * @scanline: scanline to use as trigger
+ *
+ * Like mipi_dsi_dcs_set_tear_scanline() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
+					  u16 scanline)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_tear_scanline(dsi, scanline);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to set tear scanline: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline_multi);
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 602be6ce081a..c823cc13ad1f 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -375,6 +375,8 @@ void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
 					   u16 start, u16 end);
 void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 					   u16 start, u16 end);
+void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
+					u16 scanline);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.46.0


