Return-Path: <linux-kernel+bounces-245953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570692BBCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010C128242C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CE17C234;
	Tue,  9 Jul 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="yCD8a2NC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A546180A84
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532922; cv=none; b=f+JaJe5T0GowCskKJSmkGVRwkfszl4KfnHr5kvn//mLx+jjd0/KRcWCm7WzSKjf382iXvHtuzEVw1+s4Xd48YVjNLyBnjGQ9xgeZ0c410zO06s+L1CkeDeFS9Elfdv+1mgZN8xBWY7kpkbvg/6O8+NMgL9t4oZ+y7MRgj0zyN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532922; c=relaxed/simple;
	bh=pUuFfAxFZ8ZLgyyqmvA5GwMs340NtJBbp8mYHg/taqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BFc2nym1iF5qds4Kfd0tJdrejBCUgpjiixrSQhA3vE4+TWXUEHIOPapebjxfY5Thsd77Lj6VA5Q19WVQbmQb3VDx57e4KpP9VI4O36eE3RkV3UVUMPnFRgZFTe3XQic+IBB1OJm11VF+l+g5PodGNPbo7cJmEjPIdNQeEuUeCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=yCD8a2NC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb1c918860so40847825ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720532911; x=1721137711; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uMEcoi4kfATq1PQH6tKRvYV7e4/pW6GOXmmHjAZqR4A=;
        b=yCD8a2NCAy4CDsX7qJ7TNVopFhBxXF55gQO7MqLJVyfzwexQV7+r1pjU48rz1y7hZ/
         v0QNEdA5FSs+prvdVe+3s4vd4FH11QOHg9aiPtZa7mTkYRZHZldUWgFo+mySlSRUAA60
         0dan5sjPdAvzsl3jz31PEX/bpMlaDIO3av8m8r4RJ0YSTtis2Es0amdhUWMpsfzr7wzk
         o9tQNz2hBk5GpGuwGdEy1tn1oL7yEQoOrQ7J8ZB4dVWTt8nxfIco+DDwUHOB4WGGL/eK
         dSXUQqyEz1ifkH8qUshWzootdISh4RS77R1ZKYk9iRlOe2bb3JU/B1n77aWcbuTLpXeZ
         UvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532911; x=1721137711;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMEcoi4kfATq1PQH6tKRvYV7e4/pW6GOXmmHjAZqR4A=;
        b=mKRVYobWdvBM4q3Av1TlzSc/+p5WKGtbxk7x1cDJh4bkccdGxUI5htARiK4Go94pg8
         4gBk/33acc3DoR25Fxuv7GrR57mSGqPHzqZjcz2GNfiK5xmfhbHdjWfzyrfV7+cuL0Am
         kd+9qRmyU1xuRUZ2eL7fgDHj208VqE/qglrYhaDuaKSEIGXNIHyvDMWRMmU1bdqoxhat
         kUL49QvVzg317c24SJ/FZyuJ9sZ6dCyJbbSH+m4Y25oT3tVl0QBVKbKjZGKq7JrRZVVc
         tDTcLgpMoxgnpdMtfiTZhJEzzjhleA2GsEZMCwZ8GRtzMqa6DUqg9Wky91If67vIfx8T
         Ktcw==
X-Forwarded-Encrypted: i=1; AJvYcCUBC9WLebl9JzxpznzOOTuFsCIo8cAJVFGZWz/CLrZrxSpoGz5n0iW+JWjXAbp1lO93iICTdDiqBFwR+q/EurDKNdeGe96OuIfRoMN2
X-Gm-Message-State: AOJu0Yxjz2D2de+AsXGCZUzAE4sm1vXNIgOgf1f+COXS9PYLhiOgbbCq
	A9aSx+eVtqMIckBNf4t9jItPisK+MiK8CqyH1fruZ7U7vaCfMsy7ObjIeSAmidc=
X-Google-Smtp-Source: AGHT+IErsldRGCVjJQNp++bdJGJi0KJOcV/dPRZo0OLh77MLEfFqBsbmHn5CVGSnCvabvweP9duUog==
X-Received: by 2002:a17:902:f687:b0:1f9:f3aa:fa86 with SMTP id d9443c01a7336-1fbb80b31d9mr35884485ad.33.1720532911116;
        Tue, 09 Jul 2024 06:48:31 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6b9fsm16211685ad.138.2024.07.09.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:30 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v6 3/5] drm/panel: boe-th101mb31ig002: use wrapped MIPI DCS functions
Date: Tue,  9 Jul 2024 21:47:52 +0800
Message-Id: <20240709134754.28013-4-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/enable/exit code.

Convert the hex in init_code from UPPERCASE to lowercase.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes between V6 and V5:
-  1. No changes.
v5: https://lore.kernel.org/all/20240704072958.27876-4-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 143 ++++++++----------
 1 file changed, 63 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index b92082bfc932..5993e6c0cc4a 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -17,11 +17,13 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+struct boe_th101mb31ig002;
+
 struct panel_desc {
 	const struct drm_display_mode *modes;
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
-	int (*init)(struct drm_panel *panel);
+	int (*init)(struct boe_th101mb31ig002 *ctx);
 	unsigned int lanes;
 };
 
@@ -49,74 +51,61 @@ static void boe_th101mb31ig002_reset(struct boe_th101mb31ig002 *ctx)
 	usleep_range(5000, 6000);
 }
 
-static int boe_th101mb31ig002_enable(struct drm_panel *panel)
+static int boe_th101mb31ig002_enable(struct boe_th101mb31ig002 *ctx)
 {
-	struct boe_th101mb31ig002 *ctx = container_of(panel,
-						      struct boe_th101mb31ig002,
-						      panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	mipi_dsi_dcs_write_seq(dsi, 0xE0, 0xAB, 0xBA);
-	mipi_dsi_dcs_write_seq(dsi, 0xE1, 0xBA, 0xAB);
-	mipi_dsi_dcs_write_seq(dsi, 0xB1, 0x10, 0x01, 0x47, 0xFF);
-	mipi_dsi_dcs_write_seq(dsi, 0xB2, 0x0C, 0x14, 0x04, 0x50, 0x50, 0x14);
-	mipi_dsi_dcs_write_seq(dsi, 0xB3, 0x56, 0x53, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xB4, 0x33, 0x30, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0xB6, 0xB0, 0x00, 0x00, 0x10, 0x00, 0x10,
-				    0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xB8, 0x05, 0x12, 0x29, 0x49, 0x48, 0x00,
-				    0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xB9, 0x7C, 0x65, 0x55, 0x49, 0x46, 0x36,
-				    0x3B, 0x24, 0x3D, 0x3C, 0x3D, 0x5C, 0x4C,
-				    0x55, 0x47, 0x46, 0x39, 0x26, 0x06, 0x7C,
-				    0x65, 0x55, 0x49, 0x46, 0x36, 0x3B, 0x24,
-				    0x3D, 0x3C, 0x3D, 0x5C, 0x4C, 0x55, 0x47,
-				    0x46, 0x39, 0x26, 0x06);
-	mipi_dsi_dcs_write_seq(dsi, 0x00, 0xFF, 0x87, 0x12, 0x34, 0x44, 0x44,
-				    0x44, 0x44, 0x98, 0x04, 0x98, 0x04, 0x0F,
-				    0x00, 0x00, 0xC1);
-	mipi_dsi_dcs_write_seq(dsi, 0xC1, 0x54, 0x94, 0x02, 0x85, 0x9F, 0x00,
-				    0x7F, 0x00, 0x54, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11,
-				    0x22, 0x20, 0x44, 0xFF, 0x18, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC3, 0x86, 0x46, 0x05, 0x05, 0x1C, 0x1C,
-				    0x1D, 0x1D, 0x02, 0x1F, 0x1F, 0x1E, 0x1E,
-				    0x0F, 0x0F, 0x0D, 0x0D, 0x13, 0x13, 0x11,
-				    0x11, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC4, 0x07, 0x07, 0x04, 0x04, 0x1C, 0x1C,
-				    0x1D, 0x1D, 0x02, 0x1F, 0x1F, 0x1E, 0x1E,
-				    0x0E, 0x0E, 0x0C, 0x0C, 0x12, 0x12, 0x10,
-				    0x10, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC6, 0x2A, 0x2A);
-	mipi_dsi_dcs_write_seq(dsi, 0xC8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
-	mipi_dsi_dcs_write_seq(dsi, 0xCA, 0xCB, 0x43);
-	mipi_dsi_dcs_write_seq(dsi, 0xCD, 0x0E, 0x4B, 0x4B, 0x20, 0x19, 0x6B,
-				    0x06, 0xB3);
-	mipi_dsi_dcs_write_seq(dsi, 0xD2, 0xE3, 0x2B, 0x38, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xD4, 0x00, 0x01, 0x00, 0x0E, 0x04, 0x44,
-				    0x08, 0x10, 0x00, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xE6, 0x80, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
-				    0xFF, 0xFF);
-	mipi_dsi_dcs_write_seq(dsi, 0xF0, 0x12, 0x03, 0x20, 0x00, 0xFF);
-	mipi_dsi_dcs_write_seq(dsi, 0xF3, 0x00);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-
-	msleep(120);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set panel on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10,
+					       0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x48, 0x00,
+					       0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x65, 0x55, 0x49, 0x46, 0x36,
+					       0x3b, 0x24, 0x3d, 0x3c, 0x3d, 0x5c, 0x4c,
+					       0x55, 0x47, 0x46, 0x39, 0x26, 0x06, 0x7c,
+					       0x65, 0x55, 0x49, 0x46, 0x36, 0x3b, 0x24,
+					       0x3d, 0x3c, 0x3d, 0x5c, 0x4c, 0x55, 0x47,
+					       0x46, 0x39, 0x26, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0xff, 0x87, 0x12, 0x34, 0x44, 0x44,
+					       0x44, 0x44, 0x98, 0x04, 0x98, 0x04, 0x0f,
+					       0x00, 0x00, 0xc1);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00,
+					       0x7f, 0x00, 0x54, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11,
+					       0x22, 0x20, 0x44, 0xff, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x86, 0x46, 0x05, 0x05, 0x1c, 0x1c,
+					       0x1d, 0x1d, 0x02, 0x1f, 0x1f, 0x1e, 0x1e,
+					       0x0f, 0x0f, 0x0d, 0x0d, 0x13, 0x13, 0x11,
+					       0x11, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x07, 0x07, 0x04, 0x04, 0x1c, 0x1c,
+					       0x1d, 0x1d, 0x02, 0x1f, 0x1f, 0x1e, 0x1e,
+					       0x0e, 0x0e, 0x0c, 0x0c, 0x12, 0x12, 0x10,
+					       0x10, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc6, 0x2a, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b,
+					       0x06, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44,
+					       0x08, 0x10, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x01, 0xff, 0xff, 0xff, 0xff,
+					       0xff, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
 }
 
 static int boe_th101mb31ig002_disable(struct drm_panel *panel)
@@ -124,21 +113,15 @@ static int boe_th101mb31ig002_disable(struct drm_panel *panel)
 	struct boe_th101mb31ig002 *ctx = container_of(panel,
 						      struct boe_th101mb31ig002,
 						      panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(dev, "Failed to set panel off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int boe_th101mb31ig002_unprepare(struct drm_panel *panel)
@@ -172,7 +155,7 @@ static int boe_th101mb31ig002_prepare(struct drm_panel *panel)
 	msleep(50);
 	boe_th101mb31ig002_reset(ctx);
 
-	ret = ctx->desc->init(panel);
+	ret = ctx->desc->init(ctx);
 	if (ret)
 		return ret;
 
-- 
2.17.1


