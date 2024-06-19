Return-Path: <linux-kernel+bounces-220456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E190E1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1984B1C2241B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D74D8C4;
	Wed, 19 Jun 2024 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEyxFxGQ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292422139C7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768055; cv=none; b=tP4kTP6DOcTXuyPP1QXxXuVuqm3qFSY/mkowHQKLW3r00c8gYDRpLihqmifmezhvgjt6sjZyht1SE75C6exbPn4yeF6D/ZaHSDX2fO2BhTrIaijbAOuSDm310yLLKhDze/gUIIFQGD0FpJSe6mB/96KSFSHQc0V8S5UKBhRr0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768055; c=relaxed/simple;
	bh=oVhEZNJ8z8+JDLNdJ+ylEgpCocqp3mDnV4z8SnX2vQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJBMd2/2WISwB+tHH78T+s7WtKapvMtb4qUTNJ/cRN54QqIdqZdrOg/mcB/Ykv8cGMTeMz2lTHhlG2z/tuUjYrTYFP+sup0wX2++gDa/kzBxeamAokVuIuNHdqdrsf3RBBqnCcYhkkFHa7S6h1TEv0ElvPw20WKT9cNNSWuB1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEyxFxGQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e54287a719so4239712a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718768053; x=1719372853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLDNCkNUZbU0ff6KwiabU+VVrftnpsyFvZzShk1aAYw=;
        b=LEyxFxGQXVdMJrUfdP6UtThCJZqZCEef2OlpKRs7Ti+wwE8f9ZmdC2ayKXmAf70EBZ
         1F+n8VeOg29TcsWLf+1WbknPe81UFFDbk227J8eX++C1q47KLj8ADrAeE7APIgkITv/K
         W2fByrdCQM+8Ia/qAdF8cEjktDr2WulAySg+r/1tKn0/+sL9ooYxenr4YERRBhBDMe/p
         uCIK7qbd3KSxyJwTNWKpie9U02gl/ueCyK9jxbBW72dPp3amlOh/0VGv95MhjrY7LHDx
         +5GtrzIPJ8q2RTrA03olmH3e/6wRdeYmRPa9tdSFSRCVDFb5ISZWGnJdpe1+ikMktZv2
         mWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718768053; x=1719372853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLDNCkNUZbU0ff6KwiabU+VVrftnpsyFvZzShk1aAYw=;
        b=p+5hCUCPafZzhnlNhKpdv1B0Cp6oOFIN+1CR/xQNe89gm0YC2wwCbqMG3fv4X+r3pF
         GaMDhVsUGJusIPyJQW4g1mc8FnbqXtnLZ1jN7JdVU65GHKdOe92xo/3dsnMzfrwYl/gj
         jv0BECCMLS0vh8UDCsLvNqXTXRJC6eH+sxdjq9d/yeyEPcglbxdhdD4KqvX03JI6IWzr
         AFezEioDgs5OrE2/EJ5mDXTTCMxh1mATh+HBeQe4e8atiIAM5jx0nCjNQK15uj48/XmZ
         o5uEXd5AgcD9nULNV3iQ8XHzHYQqm9a/lUp+lUpBXHHgm0Iub8Xo8c/EeROkQjPu3z7H
         CVvA==
X-Forwarded-Encrypted: i=1; AJvYcCXI6mdAt5RUp5CQLEPBg3fhwO6nNX4kj0+Pk8eokicaUhh+bNeC2bJiGnfAbEHTvmyIYLLBHuWgGkh7Gnnv2uh9TcMPdYA7sIWlTzry
X-Gm-Message-State: AOJu0YzO7sB7GtWxic97TeFj2Fv+zb1T0YvDCP7ppM8AJG+2uBQI2mpy
	mZ2NEqdYB5gi3YQMQ5QF8ZSnnrah2PzupGF0Im2dsCxAJcFyICxt
X-Google-Smtp-Source: AGHT+IH9RyZS6wiKAxOIz9L7UcugZlZuzxuZGlSD9Nxk4GAcazyad1IQzi316Lcd1aBqc4me2lxVww==
X-Received: by 2002:a05:6a20:a891:b0:1b8:1be8:8014 with SMTP id adf61e73a8af0-1bcbb6415b7mr1163002637.39.1718768053205;
        Tue, 18 Jun 2024 20:34:13 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.85.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769beb8sm13909083a91.41.2024.06.18.20.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:34:12 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel: raydium-rm692e5: transition to mipi_dsi wrapped functions
Date: Wed, 19 Jun 2024 09:03:49 +0530
Message-ID: <20240619033351.230929-1-tejasvipin76@gmail.com>
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
Changes in v2:
    - Change rm692e5_on to return void and take mipi_dsi_multi_context
      as an argument.
    - Remove unnecessary warnings.
    - More efficient error handling in rm692e5_prepare

v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 237 ++++++++----------
 1 file changed, 99 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
index 21d97f6b8a2f..9936bda61af2 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
@@ -40,176 +40,137 @@ static void rm692e5_reset(struct rm692e5_panel *ctx)
 	usleep_range(10000, 11000);
 }
 
-static int rm692e5_on(struct rm692e5_panel *ctx)
+static void rm692e5_on(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	dsi_ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x41);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd6, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x16);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8a, 0x87);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x71);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x82, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc6, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc7, 0x2c);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc8, 0x64);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc9, 0x3c);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xca, 0x80);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xcb, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xcc, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x38);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x13);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf4);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x00, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x01, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x02, 0xcf);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x03, 0xbc);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x04, 0xb9);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x05, 0x99);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x06, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x07, 0x0a);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x08, 0xe0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x09, 0x4c);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0a, 0xeb);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0b, 0xe8);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0c, 0x32);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0x07);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf4);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0xc0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0e, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0f, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x10, 0x33);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x6f);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x12, 0x6e);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x13, 0xa6);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x14, 0x80);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x15, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x16, 0x38);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x17, 0xd3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x3a);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x19, 0xba);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1a, 0xcc);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1b, 0x01);
+
+	mipi_dsi_dcs_nop_multi(dsi_ctx);
+
+	mipi_dsi_msleep(dsi_ctx, 32);
+
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x38);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x13);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xd1);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd3, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd0, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd2, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd4, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xb4, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf9);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x00, 0xaf);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1d, 0x37);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x44, 0x0a, 0x7b);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfa, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc2, 0x08);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x35, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x51, 0x05, 0x42);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 100);
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
 
-	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
-
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
 {
 	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
 	struct drm_dsc_picture_parameter_set pps;
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
-		return ret;
-	}
+	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	rm692e5_reset(ctx);
 
-	ret = rm692e5_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
-		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-		return ret;
-	}
+	rm692e5_on(&dsi_ctx);
 
 	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
 
-	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_compression_mode(ctx->dsi, true);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable compression mode: %d\n", ret);
-		return ret;
-	}
-
-	msleep(28);
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_compression_mode_ext_multi(&dsi_ctx, true, MIPI_DSI_COMPRESSION_DSC, 0);
+	mipi_dsi_msleep(&dsi_ctx, 28);
 
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x40);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
 
 	/* 0x05 -> 90Hz, 0x00 -> 60Hz */
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xbd, 0x05);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x05);
 
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
 
-	return 0;
+	if (dsi_ctx.accum_err) {
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	}
+
+	return dsi_ctx.accum_err;
 }
 
 static int rm692e5_unprepare(struct drm_panel *panel)
-- 
2.45.2


