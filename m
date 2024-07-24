Return-Path: <linux-kernel+bounces-260958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1493B0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D111F24DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B5158D89;
	Wed, 24 Jul 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtFzprJ4"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559E158D6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823910; cv=none; b=b9lf3LiUPL9UP76aRw0FP89XG/yNKgAra0ob/t1I6hyzKnkUlidDwA6JZjKUiFOKqBWYDO+tQn+n08amk/Fd3CoNY4mVxel5Cy7kr8mOXH2kw/Criof1t5nqI3blVVHNBs9FMB0SFvdnr1mDDZylfVGZViqWGcopgXjbNCHG/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823910; c=relaxed/simple;
	bh=AMwPaWwQYmwRPQJWKu2P4Rn1Jd5ntWvC9iS2rFrtpDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xjoxrov3MYqLzfj7Y6ExheA+VDYDNNW2XDFB0T1YNUf5ilWm31qXUA4D5D7wTMPPD9Cjh71VKhx5cydVbB8INdUCGuNQWmMUfokhRRZ/sybZdgytyfNQ3iQ8zXFOERXTPws2XxTD9+ut2rd13Uh/xhLX/b0J+LQVkzHo5udpe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtFzprJ4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so2144779a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721823908; x=1722428708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FanJFk8N4d+FovkzKkK+yK0pgkmnrsP9b5F0k2uR1QM=;
        b=JtFzprJ4GEI4vvNEaKgA8vChoZR06aXlAvdsSzCN3NBAf2OTalGl1/jgkgPbQhEoY+
         rQxeRrIOJIPZ0FlCzuSRiaBA7hq18c2hPC9bPl26E+5uBEx92bWtSB+SbCXwRddyqolT
         bsm9foU34Y0bD01W8XHr3yFbHNibt13hzMkSEN3e9VzUP5FpalLoHQEkSXggEzRgACcO
         XiuWRmnrBTOZSbgqEZcnJAlV67J6LjhSEAahFzYWA/4sQxMEh3xxHTzxqlYZkEqGWuj3
         avSoSNa/CClcmwsl/u0+j5AbRm4biJl4V6J7pj5IoScxrN+3ZwwoxAbq+VaAQDGCiEF7
         ChUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823908; x=1722428708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FanJFk8N4d+FovkzKkK+yK0pgkmnrsP9b5F0k2uR1QM=;
        b=oe7oQ/W4EjjCHOxic8GRrshlIkkYOVnL1p7b42xCXAW5lsiswBzbOnFlxZZYffLR8W
         4yZcGxrQWV4Szh0IJlgu+8qHCQnpWdoB7r9l3Eb34jD3IZfqeAYaYkiC81njMLZoUaV5
         06JScwnzV48vT14wLLfUNIdzG+AfgGUejbrSu1Ns06aI9zU6ELbVfEuYCyBDndjG9hIH
         dlFksWCH3MZQ+hfRTKQwa6ZqUAl5Z9bnQ2fZW3khEOGsRs9iUf0ivqHyfHjbgl4uLOa2
         Uhg2fHR44rnpPIP7PYL+5wzkbrt8V/W0oRbQ2OOruCHIfQmoFjArT4VFT36bdhKyBN+L
         H6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjwjowuz9b1401e00EQDqCtjUNtNTW1MRR/8kIcskVc3XpaXpiLmxphcIizefujJRaYRK/pgcCwI4jfewbMZqc7FuSdFZZcVLDvLNO
X-Gm-Message-State: AOJu0Ywknri34CkbfmfhoDXE5tvEqNJei+AnFi/xVfd1NhvRX2S6Brw2
	rUz8FCwmFHWRBBeD12ZP4D3fmVHnl3DURklqJq/yBpkm5hp8nHSr
X-Google-Smtp-Source: AGHT+IESuRKDCEItHRopfV2JwMH2VW29QebUq9NYg/izyx5v/vt6IyizXedg4Aqf+pfc0frWsfVHKg==
X-Received: by 2002:a17:90b:3143:b0:2c9:7e9e:70b3 with SMTP id 98e67ed59e1d1-2cd161ae448mr10189550a91.33.1721823907823;
        Wed, 24 Jul 2024 05:25:07 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb76001d6sm1481454a91.48.2024.07.24.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:25:07 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/mipi-dsi: Change multi functions to use quiet member of mipi_dsi_multi_context
Date: Wed, 24 Jul 2024 17:54:47 +0530
Message-ID: <20240724122447.284165-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724122447.284165-1-tejasvipin76@gmail.com>
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes all the multi functions to check if the current context requires
errors to be printed or not using the quiet member.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..cbb77342d201 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -814,6 +814,8 @@ void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_generic_write(dsi, payload, size);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending generic data %*ph failed: %d\n",
 			(int)size, payload, ctx->accum_err);
 	}
@@ -958,6 +960,8 @@ void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending dcs data %*ph failed: %d\n",
 			(int)len, data, ctx->accum_err);
 	}
@@ -1450,6 +1454,8 @@ void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_picture_parameter_set(dsi, pps);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending PPS failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1481,6 +1487,8 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_compression_mode_ext(dsi, enable, algo, pps_selector);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending COMPRESSION_MODE failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1506,6 +1514,8 @@ void mipi_dsi_dcs_nop_multi(struct mipi_dsi_multi_context *ctx)
 	ret = mipi_dsi_dcs_nop(dsi);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending DCS NOP failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1531,6 +1541,8 @@ void mipi_dsi_dcs_enter_sleep_mode_multi(struct mipi_dsi_multi_context *ctx)
 	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending DCS ENTER_SLEEP_MODE failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1556,6 +1568,8 @@ void mipi_dsi_dcs_exit_sleep_mode_multi(struct mipi_dsi_multi_context *ctx)
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending DCS EXIT_SLEEP_MODE failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1581,6 +1595,8 @@ void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx)
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending DCS SET_DISPLAY_OFF failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1606,6 +1622,8 @@ void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx)
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending DCS SET_DISPLAY_ON failed: %d\n",
 			ctx->accum_err);
 	}
@@ -1633,6 +1651,8 @@ void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_dcs_set_tear_on(dsi, mode);
 	if (ret < 0) {
 		ctx->accum_err = ret;
+		if (ctx->quiet)
+			return;
 		dev_err(dev, "sending DCS SET_TEAR_ON failed: %d\n",
 			ctx->accum_err);
 	}
-- 
2.45.2


