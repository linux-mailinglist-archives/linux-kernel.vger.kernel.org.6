Return-Path: <linux-kernel+bounces-569354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E45A6A1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4359916F526
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CA22156B;
	Thu, 20 Mar 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bUBZki2q"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82F21E0AA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460561; cv=none; b=EspBQlcfEWKW4rlvKAyE0cDpfHm9D7iw+I2hv59xU0J0XWoTh4Vxoe1yPf9YVOkMHVRbhYGfXlyoLrFKMzUkGcWuyTDVOIqmXCEP2rBm/9xJxNhKnE67fuHP2SF9au5OB3fkjlhh6ovh3swK8f693UM6tT8mfya9XTiaOV7L614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460561; c=relaxed/simple;
	bh=TX7OcGVRtr1P2pPXrsvbTSXIwOoVwPaz45DKWAiAmLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tu5BJWnb2A2iHhcLH5yNySaZthmimStfcSs0CskGFuty0MtgOwfq/zBdsaiCQvwhUhMR+/KWvitkPbUjJ4iG8CPFrYcl3Ktma1yicyTDDbRRh6FjFUhiqeCk0dFuC1mkY5phvGMhTaHTbQXghFkFTqp8pLPHSkd08NV+mCbGnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bUBZki2q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso3265345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742460556; x=1743065356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZKjyFb8BZx79o9w3IcZRsKDUkbzPE3rt8zz+Ry3hx0=;
        b=bUBZki2qcU8zT/jJrdvQdKVw7ze3pB4Y2Q0aNAxmUarJqj/eNH6ZV8OjpKqWrRZMrX
         8RBqMBsgygb8Sh80/PTQhhWQscrV6tw1JtqTw5HnVXDMetdvsqjqKZn6zFbSLI9PwBDH
         nZS5sNNlXtV1diREt/K/n0W7oxKPWpBGYR2Qpx8q3qZBKbNIvEHH9sNeM0Cv+sbKIxTT
         /oBuMb8y/v920M3pJkDqazChG/1V0x9WcpXDfwVL3L0ha+dymxaj1mxdpRmk7p7Jpo/7
         E2KjsRtt5vAC4L7keGm3QOPFtX7BCKRehwMKQAEZbIP/C2ceaZwWYA2ZyT/7IsMTlCqe
         ArlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460556; x=1743065356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZKjyFb8BZx79o9w3IcZRsKDUkbzPE3rt8zz+Ry3hx0=;
        b=bQnuRjBAFZeYxcIMDoI5nlnY54M5Y3oi5eHreDtI0Zfh6ot5LSdrBz9m9PKZBsKk/s
         qYPfKmGKpR1cDnBNlhddwW/bBH/nLTxlLLlKUPZnULrd5D0+icJ1gK8T7aT1yZ37f8Yw
         I8NeVHfZ13/JbVh1nDONAzM0SFBzw+KKgwwS4YsfdNJmpqsNorbG9jcDOSsSBLv9M5Lf
         OZbhwRrD99UPcN2XV5CDjQzQiUQd6bf/Sa1LqY/7z46uzQrEl2urn5Z1i/5SMR3PvEhK
         0mniKk+MCz2nsKX5wsEzlnZ3h/Wwvx3FXdSraSE+M43tWQ48a/w41YSrmzc2KLk+ySxc
         QGng==
X-Forwarded-Encrypted: i=1; AJvYcCUcBaYQkAPQ36gttBL7grXSgqv9UNeBwwTaJkX+dgJD5mbruufb7apFcQYBrD7WM2xen8A7WIlQNUZ/tWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEW1W6ND+uC5BjMyyPl8/YrhJYSqH3TsviKgu3qenzLFEEoVW7
	ozJMudCBjcI8qdPuqjAo1QgcS0tvNAb5CiM8TCJTNskiLmFlqoXJMUsZlJJ4Vq0=
X-Gm-Gg: ASbGncutxv4ycK05ggNtfGL8UqGzpi28Fmm/jf2V/L0jZJvAX/EIv9US4jlx2S14IuZ
	Il5YQPDbcrwczR/CdY3QSc7k1ktIpDwXxC1UAxkqq1eNxjxXrJxwyZwEDDmdtcO/elLNdIRKgQb
	NxxpDYk3NynnWZMLI3PxyCLDpLZZG8HSWeWgzHQnGH36mbLCsgjqzdOiGRJ+60Kcdxdi9Y0/jg9
	sAFA43NqyGrdU8GHl8KUrHWBJ7/eKJDd5h+aDtlOPaDCQdZmvDHRfQgcPtLLiStpBTt7fMrufpy
	sPBOJsxt9ZbdkUqba3ajSnqF2Qtljt6nc2oJQUE1dpsUZrrT
X-Google-Smtp-Source: AGHT+IF1ShRsZAhXeGcFF/eH1QOBy38lGwVALG8wcA9aWqeTkHgVv4Ae8bUcyD5nie1uQZaBU4zsBA==
X-Received: by 2002:a5d:64c4:0:b0:391:2d97:7d0e with SMTP id ffacd0b85a97d-39973af6beamr5443274f8f.42.1742460556286;
        Thu, 20 Mar 2025 01:49:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:5ee:79d0:c11c:487d:c821:54a0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43fdac9dsm41381655e9.30.2025.03.20.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:49:15 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 20 Mar 2025 09:48:47 +0100
Subject: [PATCH v8 3/3] drm/mediatek: dsi: remove custom init part
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v8-3-c2dd7b0fb2bd@baylibre.com>
References: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
In-Reply-To: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=TX7OcGVRtr1P2pPXrsvbTSXIwOoVwPaz45DKWAiAmLc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBn29aHumqlEtPmW0ArR5jYJL5IvH5lLNSxMmfrFswE
 D6QNUKyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZ9vWhwAKCRArRkmdfjHURTTUD/
 9/d7eGtM1x5wW0jXmYe6IW8fwisk78gewlZv0z4juc7RAlpd2GbJSBerX6VBJY/DL8d0V7/u5WVa90
 P1bZxxvdxm79wEjWsSyJYbCwQWH/Wmn8zyZQvwZXUaOjh1uuoiKmuhNi3oP7o8ikoo/7Yerpza6BoU
 +gKMkpOuW0YAy/jdv8/xCqXCcMGD9z7lU7wbKFgnDi1QD1X0aTCoXoxb4rKmZSJxJ1A7tvGKWA1R8y
 D0MqNsi/HjfA/hNYullag24K50oJOlOCoT9fCeQ0yLvALuNPn6K9jIXfGgHO45KgYsShibM1bRt83M
 UxZrEncVEifz0mKSROkc1yiKmHlushJSeifzd3fe09pGcBc0lTubg4AQ/ysBmKzDuOuqNTOP9tOIMq
 iyNSOj1tdoWtwP0BOSlY+ElUwUdM5mdhUzZRHIDLkHDybrZP9YSCEmb+joNt4IhE8rvoDc+B3q4PpJ
 l88Ls1+kFFuSSpOjoMgvg276mnZ1igr7TmVTxl3n5f/WVT3XKpUDhopnmpc7DroirFG5Bc0xJVSYT1
 x93zcH7j9Yu+1KuQpRU9VBR7lne920Op7uje9MJSB5eFZlRdbHGOlqiXFUB5/jnQqbtO6DUZOTIiKV
 Ry4pSE6S5lwJfZrZoSCAgSky6flyYM5QMBBHyvf2yuZqxL6xz9WxweVYp5JQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

To be aligned with the DRM framework and avoid DSI power being driven
by two different entities, remove the custom function and keep the DRM
API to initialize the DSI.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c |  2 --
 drivers/gpu/drm/mediatek/mtk_disp_drv.h |  2 --
 drivers/gpu/drm/mediatek/mtk_dsi.c      | 16 ----------------
 3 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index edc6417639e64..d86eed0d279d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -317,8 +317,6 @@ static const struct mtk_ddp_comp_funcs ddp_dsc = {
 };
 
 static const struct mtk_ddp_comp_funcs ddp_dsi = {
-	.start = mtk_dsi_ddp_start,
-	.stop = mtk_dsi_ddp_stop,
 	.encoder_index = mtk_dsi_encoder_index,
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 04217a36939cd..5657854fa2f9e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -47,8 +47,6 @@ void mtk_dpi_start(struct device *dev);
 void mtk_dpi_stop(struct device *dev);
 unsigned int mtk_dpi_encoder_index(struct device *dev);
 
-void mtk_dsi_ddp_start(struct device *dev);
-void mtk_dsi_ddp_stop(struct device *dev);
 unsigned int mtk_dsi_encoder_index(struct device *dev);
 
 int mtk_gamma_clk_enable(struct device *dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index e61b9bc68e9a3..b813b49340420 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -787,7 +787,6 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 {
 	if (dsi->enabled)
 		return;
-
 	mtk_dsi_lane_ready(dsi);
 	mtk_dsi_set_mode(dsi);
 	mtk_dsi_clk_hs_mode(dsi, 1);
@@ -893,20 +892,6 @@ static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.mode_set = mtk_dsi_bridge_mode_set,
 };
 
-void mtk_dsi_ddp_start(struct device *dev)
-{
-	struct mtk_dsi *dsi = dev_get_drvdata(dev);
-
-	mtk_dsi_poweron(dsi);
-}
-
-void mtk_dsi_ddp_stop(struct device *dev)
-{
-	struct mtk_dsi *dsi = dev_get_drvdata(dev);
-
-	mtk_dsi_poweroff(dsi);
-}
-
 static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 {
 	int ret;
@@ -1243,7 +1228,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	}
 
 	init_waitqueue_head(&dsi->irq_wait_queue);
-
 	platform_set_drvdata(pdev, dsi);
 
 	dsi->bridge.funcs = &mtk_dsi_bridge_funcs;

-- 
2.25.1


