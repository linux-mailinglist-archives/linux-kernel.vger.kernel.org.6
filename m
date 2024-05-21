Return-Path: <linux-kernel+bounces-184339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E58CA5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D37282061
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB5848A;
	Tue, 21 May 2024 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX0fdidG"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFB18D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716254182; cv=none; b=L6GU3kLBW9p4vLXhPZooCyEfhnDxZl2LgsZARqRv05734ftlUg0mma8gq182RKkH3puAeB1ZKfIUA9td3aRzQtp4VBZ7S2HlQhn1//7CcXUxw8gcwOmyafBxBcnp8epl6qpIRsiRkUD3YKGqYbt+LiLrCg9oUnD61dDSK+4C1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716254182; c=relaxed/simple;
	bh=dukpbWNzAlcN2jaV7rI9bwvnAZKyHZFuZ/DpsZSvscc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBO+iDAiNg6X2qhWnadEhVkmKE6SHBtSiWrtOSV6XOj4+Zb/pbyizv9JCV6Tc+56q0gFIBKLYA67DIkSM6zWvFR58ZysIljQ2fMaDqGgA2LP0lC7ekdSTICkkxL7b66K5fj/Hhb77WwXoUoo21HuYdjZonYg25JH4TN3MNqQMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX0fdidG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36c826d6edeso15017845ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716254180; x=1716858980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wk1PVGEUqYUMHx3xjwbIQevWry9UO/Bto1LV6ZupLw4=;
        b=cX0fdidGGLMaWu8rAbofjjRlA+ocKTa2CEhUJKrfDXqfXJrV+xrxuE7uLppI1ZMu5a
         Zl5D5VEc3ZS7DcrZ5+x13/iWoJjvH49lXMohIoV38elhW3lvXbp9ie88jgYEkRN9VWid
         NnRgG3kCyzgAUlZK2TvqtZK+59p1//xV/DcvMsvhsNmRzvfDWwjkmFIcStGE5zWnCZuE
         ITeSxTcC9oAyewxeqiBoRnCGJVpO6nMqnmU4Uh9PhLit00F0ZRdzNyNXsVgNn16eC4xX
         9c06MuAaiESOdF0+n9vauqj6fE2dYDNuvKRkL/KEJonTxSRenqCQgC6ACTVTn8J132pO
         XGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716254180; x=1716858980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk1PVGEUqYUMHx3xjwbIQevWry9UO/Bto1LV6ZupLw4=;
        b=H28eiYt2PobElYrXNXLXZB5nIvrJ0ZWppUIstYQSe6FuJEKSi1bBgrpfRcCTjvsAIU
         NaDBq/MfbMLFsD8sLLiqy0KLoFhxr6ob9HPcY7U3H6zqbR2Ht5iHoqMhU+8c6rBg/IZw
         hTuB4OpIHeClxxU/FmG96DLvaEmUxDA7F1D86aNd12CZ+je+lNaOLBbpXLQ3nZps08Ke
         bvr5LRZrrDWnpt16Xh4tdTS2EPBiSDISCSi3Xy8rRUZlImNQ0ICwZ9XvxVLn+KvccLin
         2Tm7H8qFbBkOV1RKJVLgc1a3HxgAiVmtB/d0YA3tKcJzi0Agy9CAH3S3m0aVWSWBucx4
         n+ew==
X-Forwarded-Encrypted: i=1; AJvYcCWzT7H7U2KefqnyyfJFucoF/ycjUHa6ryvWroPFun5SM5mWQm5MJUFkgZA2tOf6R1HT0tHK0f6qmYlMMukIGcUcGT+NSoLqYeeZS79V
X-Gm-Message-State: AOJu0YwxKHIhwZCfST7ZN12yJVlpAlQtwxYDBsSqcNxaPti/GiMasQkm
	VMVLIzKhXf6nlmphY300gfxqVIMhTQ/EXLRki4Rq+yjjgKVLDkW9
X-Google-Smtp-Source: AGHT+IEJiw0554sm+YCYgsX80AUBApa7ps6YI9bAy/tOYNreoqOPuVjaxcu+geidy7Fe5pe8Z3rLfQ==
X-Received: by 2002:a05:6e02:1607:b0:36b:2438:8805 with SMTP id e9e14a558f8ab-36cc1488a5fmr410004665ab.12.1716254179699;
        Mon, 20 May 2024 18:16:19 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:7221:2803:58e7:1e5f])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376dc92bsm6510089173.134.2024.05.20.18.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 18:16:19 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: dmitry.baryshkov@linaro.org,
	ictor.liu@nxp.com,
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
Subject: [PATCH] drm/bridge: adv7511:  Fix Intermittent EDID failures
Date: Mon, 20 May 2024 20:16:14 -0500
Message-ID: <20240521011614.496421-1-aford173@gmail.com>
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

Reported by: Liu Ying <victor.liu@nxp.com>
Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
Signed-off-by: Adam Ford <aford173@gmail.com>

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
index 44451a9658a3..4efb2cabf1b5 100644
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
+		return ret;
 
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
index 66ccb61e2a66..56dd2d5a0376 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
 {
 	unsigned int irq0, irq1;
 	int ret;
+	int cec_status;
+	int irq_status = IRQ_NONE;
 
 	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
 	if (ret < 0)
@@ -478,38 +480,41 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
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
+
+	if (cec_status < 0)
+		return cec_status;
 #endif
 
-	return 0;
+	/* If there is no IRQ to handle, exit indicating no IRQ data */
+	if (irq_status == IRQ_HANDLED || cec_status == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
 }
 
 static irqreturn_t adv7511_irq_handler(int irq, void *devid)
 {
 	struct adv7511 *adv7511 = devid;
-	int ret;
 
-	ret = adv7511_irq_process(adv7511, true);
-	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
+	return adv7511_irq_process(adv7511, true);
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.43.0


