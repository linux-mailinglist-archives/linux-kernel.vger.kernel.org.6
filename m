Return-Path: <linux-kernel+bounces-235347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA5A91D460
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133431F2117D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0715CDE9;
	Sun, 30 Jun 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na0Fkpdp"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355022AE68
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719785980; cv=none; b=CRD/wOr9elZC6DCyCENSQsUyTwZrCh9gOgP6WLgownVm7UgJjWyc7r63YyrxMVeN1irFfVa4+LIRveLz+RV3fd9xmgvBOdpPyoDMbR9LBT7GuwAYcWO8TEnsXj1qEs2nQQlIhkplP1Vv2nYMZcTBOqt7phbPHWc8E+fHtzHhz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719785980; c=relaxed/simple;
	bh=7t/hvLfnp3ulwwuGa0R3lXO/+NS/TEqQ4pUEyuE9iY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMuWotIHpRfRWEsrcZXkSu4VNb1j/Em1CzR12kdmoGjcgrEJL50iUgXQTj2CGW6MvGeq6RaNvVnsbIQMIPVdrYgpwTd4WFufx1/a3R4j0k3dBFtYNJFLIQ8jCi9S3DCbAf2ZXunQfXhorRr6mziTq3VfVnXidxqoXNF/J81m7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na0Fkpdp; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eeea388a8eso95847539f.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719785978; x=1720390778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xBwqprF3AIyKjWMpWtTgv9XeBi4pK+ZW2WSJxhUHqk=;
        b=na0Fkpdp50z9tEI5d6LR3ofi5mhpHWiPLrKXWpICZpVtc3NaIgn3CgU4ZVEYwQ4xJl
         whUwpzufv8uDA2MD2hL8pdCP0qK/q0/60tnPh8DSEQqNCpIDC92m5Xe2rjUHa4/ViVJ7
         /ZX4HXePue+uL+8dkRTIwp+UzTBDFR6hKAZJu7vWKRF1Ts2AGwfsFlUbpS+s8VgJCPil
         PyTO5HBK4GlYjIt5e/LlrujFkWH1f26SWD5Ps0fzsw1wXsf8jAKrpVGTeWIZhNjbFFVS
         2MrIGAhP0Aq7zB1NTmhNV6SjUeekM/4ombPK+1VlfgOU3T5I7QGWx2rS60rTtTbmVLOJ
         6g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719785978; x=1720390778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xBwqprF3AIyKjWMpWtTgv9XeBi4pK+ZW2WSJxhUHqk=;
        b=lVCivxalHLvrfxGMJPF+OAu+4ch6YmsffN0k1ZYdbblfkjO07+f+vA7s8twWJJpuO/
         qlbMbjJKO/uVskckzBHklv+/K966SR9yo72Gl8cbhFYt76pfW2NvvWgiRNhT9Ut8deyx
         +j2MQOboQIQI8eHLQz+oTipIi+XeCrfArdqg3y4wwxGlZ008qQYY1ebtSvHCXiF8sUQp
         3sx0YvZNaSb56to/Dc5+wQpDIoUJ+uh74FWh0NtDgnW4ksogchLEIWvYSeBN2WC1sJja
         TdZzQ2azeJnOCPewiCdeaGnI2Jq98PFxACsQiBRwORWM6IPUfw+P3oF9GegymOlSLC25
         cvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL9h+0C9TFpXcx7B5oUxwUtWC2+LZWCc6fgJGB1IK/MNEbj6ud7Jyv4bcdQhy3P+fcqWKpEPH7mEQhg3uKwb+2dN11j1/QaEOsPL8d
X-Gm-Message-State: AOJu0YxA3zhLDj8iHEyMs33xJJDEql/dv1AkiGHtxeBsqPIy7hHcoCQ/
	v3T8WHBSQmWOoBknvgtw/Jd5lZ+NiTNxH+orKJp0QfkADeO1nt+g
X-Google-Smtp-Source: AGHT+IFbelENHxw+JrJUzxuU8eqeK32hWjKnOOmc0H3WlPOot9jUlCb8eAKHQjc4ie+sDwHejBlnMg==
X-Received: by 2002:a6b:6106:0:b0:7f6:2e72:e81b with SMTP id ca18e2360f4ac-7f62ee168f6mr439239939f.4.1719785978120;
        Sun, 30 Jun 2024 15:19:38 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:3ec3:787e:965c:8518])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9de0dsm171361839f.20.2024.06.30.15.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 15:19:37 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] drm/bridge: adv7511: Fix Intermittent EDID failures
Date: Sun, 30 Jun 2024 17:19:31 -0500
Message-ID: <20240630221931.1650565-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the process of adding support for shared IRQ pins, a scenario
was accidentally created where adv7511_irq_process returned
prematurely causing the EDID to fail randomly.

Since the interrupt handler is broken up into two main helper functions,
update both of them to treat the helper functions as IRQ handlers. These
IRQ routines process their respective tasks as before, but if they
determine that actual work was done, mark the respective IRQ status
accordingly, and delay the check until everything has been processed.

This should guarantee the helper functions don't return prematurely
while still returning proper values of either IRQ_HANDLED or IRQ_NONE.

Reported-by: Liu Ying <victor.liu@nxp.com>
Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID retrieval w/o IRQ
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
V3:  Remove unnecessary declaration of ret by evaluating the return
     code of regmap_read directly.

V2:  Fix uninitialized cec_status
     Cut back a little on error handling to return either IRQ_NONE or
     IRQ_HANDLED.

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index ea271f62b214..ec0b7f3d889c 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -401,7 +401,7 @@ struct adv7511 {
 
 #ifdef CONFIG_DRM_I2C_ADV7511_CEC
 int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511);
-void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
+int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
 #else
 static inline int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 {
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
index 44451a9658a3..2e9c88a2b5ed 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
@@ -119,7 +119,7 @@ static void adv7511_cec_rx(struct adv7511 *adv7511, int rx_buf)
 	cec_received_msg(adv7511->cec_adap, &msg);
 }
 
-void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
+int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 {
 	unsigned int offset = adv7511->info->reg_cec_offset;
 	const u32 irq_tx_mask = ADV7511_INT1_CEC_TX_READY |
@@ -131,16 +131,19 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 	unsigned int rx_status;
 	int rx_order[3] = { -1, -1, -1 };
 	int i;
+	int irq_status = IRQ_NONE;
 
-	if (irq1 & irq_tx_mask)
+	if (irq1 & irq_tx_mask) {
 		adv_cec_tx_raw_status(adv7511, irq1);
+		irq_status = IRQ_HANDLED;
+	}
 
 	if (!(irq1 & irq_rx_mask))
-		return;
+		return irq_status;
 
 	if (regmap_read(adv7511->regmap_cec,
 			ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
-		return;
+		return irq_status;
 
 	/*
 	 * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of RX
@@ -172,6 +175,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 
 		adv7511_cec_rx(adv7511, rx_buf);
 	}
+
+	return IRQ_HANDLED;
 }
 
 static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 66ccb61e2a66..c8d2c4a157b2 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
 {
 	unsigned int irq0, irq1;
 	int ret;
+	int cec_status = IRQ_NONE;
+	int irq_status = IRQ_NONE;
 
 	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
 	if (ret < 0)
@@ -478,29 +480,31 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
 	if (ret < 0)
 		return ret;
 
-	/* If there is no IRQ to handle, exit indicating no IRQ data */
-	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
-	    !(irq1 & ADV7511_INT1_DDC_ERROR))
-		return -ENODATA;
-
 	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
 	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
 
-	if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder)
+	if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder) {
 		schedule_work(&adv7511->hpd_work);
+		irq_status = IRQ_HANDLED;
+	}
 
 	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
 		adv7511->edid_read = true;
 
 		if (adv7511->i2c_main->irq)
 			wake_up_all(&adv7511->wq);
+		irq_status = IRQ_HANDLED;
 	}
 
 #ifdef CONFIG_DRM_I2C_ADV7511_CEC
-	adv7511_cec_irq_process(adv7511, irq1);
+	cec_status = adv7511_cec_irq_process(adv7511, irq1);
 #endif
 
-	return 0;
+	/* If there is no IRQ to handle, exit indicating no IRQ data */
+	if (irq_status == IRQ_HANDLED || cec_status == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
 }
 
 static irqreturn_t adv7511_irq_handler(int irq, void *devid)
@@ -509,7 +513,7 @@ static irqreturn_t adv7511_irq_handler(int irq, void *devid)
 	int ret;
 
 	ret = adv7511_irq_process(adv7511, true);
-	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
+	return ret < 0 ? IRQ_NONE : ret;
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.43.0


