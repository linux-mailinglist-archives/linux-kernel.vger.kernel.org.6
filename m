Return-Path: <linux-kernel+bounces-430879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF99E36CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBB3169428
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB97BE5E;
	Wed,  4 Dec 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m8S/85sh"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2113AA2E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305191; cv=none; b=BUEADfeg02W0cnBikY+fHGuqsZ9K362+zHoUTjDUz9yVCOwxPrpRlWQtzrgcUtD7X/TP8YZtsm8EaMPtT/7tWM/FHYArVtISIP31156wiQo73MRhgX9Am/rGq57RK6sVyNqyG/OUfcVAO2qlE3wrvsJTDXaI8re8sUTJ9h/swm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305191; c=relaxed/simple;
	bh=/iIljwrvnL8U+w7cXQ38QKEArA8EUUyDef/DJpx53R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxcbVnz7QpIUccf7Qhba+Ylt2DILlV2f6n/WYMVRLkpPQjxBJzsuBwLMRW9Ih+XKmt/CiKwf6fAVp9WAzpeWHvsZBBENMl5MwEJoAcX+XBgDhDN8h4WAaTA/FUrPuTCrnZfCIJxBzzJ+oatBBiKHeIksrX1ve3YCBp8WYrEUxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m8S/85sh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so4948649a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733305189; x=1733909989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmKQFaFDxD0Y+gWKKpkjZY/jkt1D47sAd7yQDFNQk7s=;
        b=m8S/85shWBpWFjaTgDyvRXo5kzBgsXGP/bW20Q0cmDz6BPqvRsJ5c1MLU6wB94Z/du
         S/NciOzXTEASyihNAqTCWrrOmM5aX6NbAVqY1YZ4O2qaQmQf6ws6Gv71qwBDH5iLgBcq
         0XCO5wnoFNhbHdczxsklaMIk58vHiuNCoHkQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305189; x=1733909989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmKQFaFDxD0Y+gWKKpkjZY/jkt1D47sAd7yQDFNQk7s=;
        b=nUIbkkNjjrTtjVrc8suhZ8RzlXgXkaYXhbXNFSPBikzpUP9yWJOpSj6+1pl6NlrwzL
         0Nu4JvEDkyeKTbQLjCGzr+8yNuk2wUZJ50YFzDdern580LMUtYQlnu/21FYQxR0Tsieu
         GAYSw5JyPpNhcRpUDFB2sKtH0RrYYWXIVCiFR884JBePK8LM/Q2oYJuGo7qMlfpLvg3i
         SH1NldvdeZJYFXi8DQE2tb5K+JZ+G1ufDGLd8HFV+8ivNqeZxYj/oFjS45LRYGC6dUm/
         l2l2V+SwQNNUQliUL7r+NSht3hhZ2Ta9hDPA2JNi7zmCgIBrdCKn15+bskCLHH62+zIT
         ObOg==
X-Forwarded-Encrypted: i=1; AJvYcCVKuV7I++8xy/qopAPSTrnzt9+rCJzinmy61ItMN4xka1YVpsDyzZxHV8BM6z47g3YOIUS1oqRXSJKgaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2J1nRD+1WSuDWqFW2eDUROwUcM3jqCJwLh9x9TfGyOl/8Im3
	16GtlGAvEQ/AqoT0TZUWLT54s8TCRnnB7wiWYb5e6Kkk3pN/UqRmPaBeILZAKGcUQnb1lMHBWH4
	=
X-Gm-Gg: ASbGnct3L3MeCQkw4GXPUdo7Cv5qodoByPTiuDQ8JIdabLjdKZkYkZ+jVoNC9cfbZzC
	135CKFvGfZosSl3sqoHJi9l6bfSEqvHIY2kXf7S/3HuuaSr1IpcFTgGhUG4c7m+Q/AlxDuUIHtt
	hRnpLaDFhWWxKr1hz16sT22PQFyI/BJnwl1JOoPohYRnmT2NYj/gDZPJf4mO00pO3yp8sWTKJ+w
	STTtRw5XFywJcGHynfVM4vX8QFSXc/KW0HvDMn8rdatNCAmxq1m1p0yQnEof9YooBWn
X-Google-Smtp-Source: AGHT+IEXmsp2Cw7/pay6uwf+WDn2jkrMrMPX/IyvfyMp5biRmOor0cpwmgHeDuThnXWYu9lRSdyKkQ==
X-Received: by 2002:a05:6a20:6a28:b0:1e0:d0ac:133b with SMTP id adf61e73a8af0-1e1653f2f2fmr7945090637.33.1733305189083;
        Wed, 04 Dec 2024 01:39:49 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2eb1:a68a:2625:b944])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814a57sm11910814b3a.167.2024.12.04.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:39:48 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel: visionox-rm69299: Remove redundant assignments of panel fields
Date: Wed,  4 Dec 2024 17:39:41 +0800
Message-ID: <20241204093942.1374693-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_panel_init() was made to initialize the fields in |struct drm_panel|.
There is no need to separately initialize them again.

Drop the separate assignments that are redundant. Also fix up any uses
of `ctx->panel.dev` to use `dev` directly.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Also fix uses of `ctx->panel.dev`

 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 272490b9565b..be3a9797fbce 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -193,7 +193,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	ctx->panel.dev = dev;
 	ctx->dsi = dsi;
 
 	ctx->supplies[0].supply = "vdda";
@@ -201,13 +200,11 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 	ctx->supplies[1].supply = "vdd3p3";
 	ctx->supplies[1].init_load_uA = 13200;
 
-	ret = devm_regulator_bulk_get(ctx->panel.dev, ARRAY_SIZE(ctx->supplies),
-				      ctx->supplies);
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret < 0)
 		return ret;
 
-	ctx->reset_gpio = devm_gpiod_get(ctx->panel.dev,
-					 "reset", GPIOD_OUT_LOW);
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
 		dev_err(dev, "cannot get reset gpio %ld\n", PTR_ERR(ctx->reset_gpio));
 		return PTR_ERR(ctx->reset_gpio);
@@ -215,8 +212,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_init(&ctx->panel, dev, &visionox_rm69299_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &visionox_rm69299_drm_funcs;
 	drm_panel_add(&ctx->panel);
 
 	dsi->lanes = 4;
-- 
2.47.0.338.g60cca15819-goog


