Return-Path: <linux-kernel+bounces-215817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5A909752
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5F5284666
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9E28DC7;
	Sat, 15 Jun 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GugoI4tj"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FD22064
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718444406; cv=none; b=M8ZcbPL232AeKXG1YQfeAdB710cS/zR0nzc7WDE+kOwx8EW0WbM5fYVdk+YT9EJ8Js1bz+saR6VDpJ+1EGmNXMrbCWPk/XOKjhGE4uXoSIVLq79eU/HOe+iZQ2w3lT/90Rz8qI0PKKbaTZlJ8z3WJcnNJvkieyJ51HDtJhvxNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718444406; c=relaxed/simple;
	bh=pA5bhE7vJDE9wouKyN+oygs3QgtUS27NsOY3LjDlQ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUBN5dY2dEo7RUJCZ5WGdngPzpm3TOlt7hc5/3pyP9G6zwWfzgA4s13HGDrzc6fV/T3FdjrQYZKAziZ1ZRs4gVgh7LJwG98PxJzwDzcLXGwiv6qeqvPC+xyMeB8xXGvWuu048YrUthUVVcN4SC6Ax9CFZoiIpIM+2RUnXUNu22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GugoI4tj; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375e96f5fddso3623245ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718444404; x=1719049204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiLdP+9sA6oR0kZo4KdguH/da0qxBYn83tZMB/WiZQQ=;
        b=GugoI4tj01Vrtp60xY24J+Yy97PFa2lohiZoZ3+cOUDYXS9fdsfy1lM6sbAPdrQb7U
         /iJeC4BnSYmROtwB9G+FhR7pWKmIUReHHbCxIa1bDorOXgsHX5EHptPRH6SDN6McWqZL
         3/yMLJQD+XhzBaQ93LBSlVSKd2aJ4Ooy3aOKZeLJMwD7X8TwJcNAtE5mWGgvRlnV/FaX
         T0iExxMsP1jigls1zH27FVXhVHnqbw1A9vhvvknVPdltZ3HXxg5WdC7XKJHHSz02b+X+
         iPXojTvAyxWumhQeA42S92esZpcJs1FZQ5/x2r/NpBpJB/Pt1oKIqCgibrpMYNsYsS5z
         9/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718444404; x=1719049204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiLdP+9sA6oR0kZo4KdguH/da0qxBYn83tZMB/WiZQQ=;
        b=DcHD+gE2kvt6byXrJi76pmYCwyOAXE7esGpOU26cbdux+X6bza5hqbMQngmCi/phTj
         HfSj/fwxqyWz+R2n3gIpwWNw+prFO8c2Jw8MCyBxswyVUXLwkQtAkx4Ubn+S/enkRnEp
         YlKsP8841I98+ETiPpI0N1uNeWF9O6zAdZJmODYaGunWZ7ngo0CrhlFqysFq1Sb4u/Mw
         FF47gBwkCQe4MXXfvGlqJ2LYxD7CdWOdXCDkoa6Uji4DG4toexAmSbVcnJ864o8esAFn
         mxwtU+Q4ysM07WGN6VID3dv8eCV7+09NmTLCw33so6ojSCXFpZaO6iLutrveBL5I/VKX
         hA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDfrEEqSKtx8ngPuhPNShAmul8oa11CbFek3mwSfV4DpC0IxfvtxzuCcSxA9psruIVDJhDi0Fvhq6J2e/Z2zKdV57jlo/uebondRfF
X-Gm-Message-State: AOJu0YwFpkqu0JGDxtcvT61C48K4V4MXbODrCb6I6LYa5V/dUsiYkrPg
	7dCoFWDThdnlR8SB00WDIm+fw7VK6d4RtPGo0xnt4Dwots1P1puf
X-Google-Smtp-Source: AGHT+IFqkpQeldL/9iCr7r6/3b7xn076LxgQ9fqnhd1/Ju9STe0r2sWeiLC02bJUVM8893IE8Cqr+g==
X-Received: by 2002:a05:6e02:1c29:b0:375:8740:4560 with SMTP id e9e14a558f8ab-375e0e1306amr55727355ab.1.1718444403752;
        Sat, 15 Jun 2024 02:40:03 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.82.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc925ffdsm4361143b3a.22.2024.06.15.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 02:40:03 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: Tejas Vipin <tejasvipin76@gmail.com>,
	dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: raydium-rm692e5: transition to mipi_dsi wrapped functions
Date: Sat, 15 Jun 2024 15:07:55 +0530
Message-ID: <20240615093758.65431-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling") for the
raydium rm692e5 panel.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 227 ++++++++----------
 1 file changed, 98 insertions(+), 129 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
index 21d97f6b8a2f..3ddbedeac077 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
@@ -43,124 +43,103 @@ static void rm692e5_reset(struct rm692e5_panel *ctx)
 static int rm692e5_on(struct rm692e5_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x41);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x16);
-	mipi_dsi_generic_write_seq(dsi, 0x8a, 0x87);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x71);
-	mipi_dsi_generic_write_seq(dsi, 0x82, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x2c);
-	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x64);
-	mipi_dsi_generic_write_seq(dsi, 0xc9, 0x3c);
-	mipi_dsi_generic_write_seq(dsi, 0xca, 0x80);
-	mipi_dsi_generic_write_seq(dsi, 0xcb, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xcc, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x38);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0x13);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xf4);
-	mipi_dsi_generic_write_seq(dsi, 0x00, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x01, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x02, 0xcf);
-	mipi_dsi_generic_write_seq(dsi, 0x03, 0xbc);
-	mipi_dsi_generic_write_seq(dsi, 0x04, 0xb9);
-	mipi_dsi_generic_write_seq(dsi, 0x05, 0x99);
-	mipi_dsi_generic_write_seq(dsi, 0x06, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0x07, 0x0a);
-	mipi_dsi_generic_write_seq(dsi, 0x08, 0xe0);
-	mipi_dsi_generic_write_seq(dsi, 0x09, 0x4c);
-	mipi_dsi_generic_write_seq(dsi, 0x0a, 0xeb);
-	mipi_dsi_generic_write_seq(dsi, 0x0b, 0xe8);
-	mipi_dsi_generic_write_seq(dsi, 0x0c, 0x32);
-	mipi_dsi_generic_write_seq(dsi, 0x0d, 0x07);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xf4);
-	mipi_dsi_generic_write_seq(dsi, 0x0d, 0xc0);
-	mipi_dsi_generic_write_seq(dsi, 0x0e, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x0f, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x10, 0x33);
-	mipi_dsi_generic_write_seq(dsi, 0x11, 0x6f);
-	mipi_dsi_generic_write_seq(dsi, 0x12, 0x6e);
-	mipi_dsi_generic_write_seq(dsi, 0x13, 0xa6);
-	mipi_dsi_generic_write_seq(dsi, 0x14, 0x80);
-	mipi_dsi_generic_write_seq(dsi, 0x15, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0x16, 0x38);
-	mipi_dsi_generic_write_seq(dsi, 0x17, 0xd3);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0x3a);
-	mipi_dsi_generic_write_seq(dsi, 0x19, 0xba);
-	mipi_dsi_generic_write_seq(dsi, 0x1a, 0xcc);
-	mipi_dsi_generic_write_seq(dsi, 0x1b, 0x01);
-
-	ret = mipi_dsi_dcs_nop(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to nop: %d\n", ret);
-		return ret;
-	}
-	msleep(32);
-
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x38);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0x13);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xd1);
-	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd0, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd2, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xf9);
-	mipi_dsi_generic_write_seq(dsi, 0x00, 0xaf);
-	mipi_dsi_generic_write_seq(dsi, 0x1d, 0x37);
-	mipi_dsi_generic_write_seq(dsi, 0x44, 0x0a, 0x7b);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xfa, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xc2, 0x08);
-	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0x51, 0x05, 0x42);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(100);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x41);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x16);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8a, 0x87);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x71);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x82, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x2c);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x64);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0x3c);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x80);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x38);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x18, 0x13);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xf4);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x00, 0xff);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x01, 0xff);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x02, 0xcf);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x03, 0xbc);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x04, 0xb9);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x05, 0x99);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x06, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x07, 0x0a);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x08, 0xe0);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x09, 0x4c);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0a, 0xeb);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0b, 0xe8);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0c, 0x32);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0d, 0x07);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xf4);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0d, 0xc0);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0e, 0xff);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x0f, 0xff);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x10, 0x33);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x11, 0x6f);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x12, 0x6e);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x13, 0xa6);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x14, 0x80);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x15, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x16, 0x38);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x17, 0xd3);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x18, 0x3a);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x19, 0xba);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x1a, 0xcc);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x1b, 0x01);
+
+	mipi_dsi_dcs_nop_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 32);
+
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x38);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x18, 0x13);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xd1);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0xf9);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x00, 0xaf);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x1d, 0x37);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x44, 0x0a, 0x7b);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfa, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x08);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x35, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x51, 0x05, 0x42);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 100);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
 }
 
 static int rm692e5_disable(struct drm_panel *panel)
 {
 	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(100);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	mipi_dsi_msleep(&dsi_ctx, 100);
+
+	return dsi_ctx.accum_err;
 }
 
 static int rm692e5_prepare(struct drm_panel *panel)
@@ -168,48 +147,38 @@ static int rm692e5_prepare(struct drm_panel *panel)
 	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
 	struct drm_dsc_picture_parameter_set pps;
 	struct device *dev = &ctx->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
-		return ret;
+	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (dsi_ctx.accum_err) {
+		dev_err(dev, "Failed to enable regulators: %d\n", dsi_ctx.accum_err);
+		return dsi_ctx.accum_err;
 	}
 
 	rm692e5_reset(ctx);
 
-	ret = rm692e5_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+	dsi_ctx.accum_err = rm692e5_on(ctx);
+	if (dsi_ctx.accum_err) {
+		dev_err(dev, "Failed to initialize panel: %d\n", dsi_ctx.accum_err);
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-		return ret;
+		return dsi_ctx.accum_err;
 	}
 
 	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
 
-	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_compression_mode_ext_multi(&dsi_ctx, true, MIPI_DSI_COMPRESSION_DSC, 0);
+	mipi_dsi_msleep(&dsi_ctx, 28);
 
-	ret = mipi_dsi_compression_mode(ctx->dsi, true);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable compression mode: %d\n", ret);
-		return ret;
-	}
-
-	msleep(28);
-
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x40);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
 
 	/* 0x05 -> 90Hz, 0x00 -> 60Hz */
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xbd, 0x05);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x05);
 
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int rm692e5_unprepare(struct drm_panel *panel)
-- 
2.45.2


