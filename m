Return-Path: <linux-kernel+bounces-197869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF878D7030
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F537B2158F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8761509B1;
	Sat,  1 Jun 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlcFstj8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449861D52D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248308; cv=none; b=nt/AsyTR07xKk/r+SRIoX1Z1j6o4iid7JlBdxFdLWc8yU1M5EISoTometeg8XXPXVEN+Id7WhrCfnXz41zlYAnCA7mdi6N5nK0Ct7AfCvnbGpqz1QnFZQdP6ONgBavSFy2maYdA++xts0a9MXyAclT+nl/EtPJoEBTMopbYIBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248308; c=relaxed/simple;
	bh=mhiSakt3e9U8gpS+sOXcjFNsZovQ2j52v7W7Qlr3ZLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMjn95wTldMUQPAuytXBpmZhFffztj69zm4Mj5EYQTR48mqKvvW4bzxkHzNVKRfvFuuk5fMkv5w/uvXGiGKJucl4LP/JVkFxdy0xpOS5lGVKJXlk97I3L61xVu+68mSo98fb8pJxYfcWC5eyByUddQT6CeM8ViDUBxRtXC6u2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlcFstj8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7e201ab539eso123902839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717248306; x=1717853106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w09m5vTOKIMdkXnAvM1fYzDWbROmAa/NqAt2dfCY8Wo=;
        b=XlcFstj8UX11B71yhVwfSH+fCJPJY+Cvnaz6qXDw6JRQAj9p9dqW62AyjuhuG09egF
         rwUANJKuLAiDiQMtm2BX57qPopv7bb0ajLpwVpFzIWT9/5WAqDxTFUnmLkxagaCy9PtU
         gZPWww9oMKpbTnnzOoxX3XWEZ4fjIeGqAzN9V9vTKfcG0Km2K0bJCx4NLH5+4NLckpLU
         lPkeigA8bCb8vOLP/V/uotvMXqfSoGxvv68tsgS4goG88zFt+E1A7GSR1+olfIrNO99V
         dMG017ZqBpp9fcGerXdr5p499IxHiL4GJSQIvgVy9GH/2U9yCJar+REpL7RtumxrpMzd
         VIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717248306; x=1717853106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w09m5vTOKIMdkXnAvM1fYzDWbROmAa/NqAt2dfCY8Wo=;
        b=T8Gp1eJR0oQ4t1HObKRs67Nhuti6hXjbRtQJZ24K5grVUS8AFp++TiCUQUuAgnGafx
         bnas9IctqJ/DZBBK4DuYk7kJ/hAJ170tUF2n6BJe8vrSxo4ZOuJ9/1V9XizFw1WshY+W
         QuvAwf09t70adKbMcfpIb+m2Ahbqdp3FzFfbTxDhrvGYBUjOa7BFIuOsZXVkxQsczOfJ
         ZmSNUEgtXpO9QBYtt9xQV2aWBl1lAatMR8C7lvEyKzcqGzONEVVutAt1NdXmn3HTFzoA
         RaCvdxsCj5A7dTCW6NIJ/z3JtNbT94SSZmhqWdglZhBn6tBWeltpaAUjujY6uG2ePwKt
         fMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYdJ2UoBBiCtc+f2w29mvbhtSeCRLcuDjK2rDTNZMedBp9r1ZU3wshnVSxNDAO6KDW/ol92YQMtCSWnIgvP8MbYn9rrTTWn9ad9rKH
X-Gm-Message-State: AOJu0Ywgw3jcHdEGL/bDufBTp+7VRjqcHr1+4GI5Fcw5ZVcSUxZSabVw
	EbhF7y/FpigoodKGYjqjMfYHj0Qy/3k7Zf+kPwyTETtlenFxCe+e
X-Google-Smtp-Source: AGHT+IFjuqDklUTdiBuZvD8uaoR3QaDup8xZ+XUePhALHNSRX19pnPobhKPmrqYcHcfILKL94r+bJw==
X-Received: by 2002:a05:6602:6d16:b0:7ea:fdc9:ba61 with SMTP id ca18e2360f4ac-7eaffe96fb0mr533246239f.1.1717248306196;
        Sat, 01 Jun 2024 06:25:06 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48764e0ccsm1014646173.13.2024.06.01.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:25:05 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: dmitry.baryshkov@linaro.org,
	victor.liu@nxp.com,
	sui.jingfeng@linux.dev,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH V2] drm/bridge: adv7511:  Fix Intermittent EDID failures
Date: Sat,  1 Jun 2024 08:24:59 -0500
Message-ID: <20240601132459.81123-1-aford173@gmail.com>
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
---
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
index 44451a9658a3..651fb1dde780 100644
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
@@ -130,17 +130,21 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 				ADV7511_INT1_CEC_RX_READY3;
 	unsigned int rx_status;
 	int rx_order[3] = { -1, -1, -1 };
-	int i;
+	int i, ret = 0;
+	int irq_status = IRQ_NONE;
 
-	if (irq1 & irq_tx_mask)
+	if (irq1 & irq_tx_mask) {
 		adv_cec_tx_raw_status(adv7511, irq1);
+		irq_status = IRQ_HANDLED;
+	}
 
 	if (!(irq1 & irq_rx_mask))
-		return;
+		return irq_status;
 
-	if (regmap_read(adv7511->regmap_cec,
-			ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
-		return;
+	ret = regmap_read(adv7511->regmap_cec,
+			ADV7511_REG_CEC_RX_STATUS + offset, &rx_status);
+	if (ret < 0)
+		return irq_status;
 
 	/*
 	 * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of RX
@@ -172,6 +176,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 
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


