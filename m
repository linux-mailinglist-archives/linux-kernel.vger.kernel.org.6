Return-Path: <linux-kernel+bounces-257225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A29376FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E494CB21DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB182D72;
	Fri, 19 Jul 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5VYx55F"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AF1B86D2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387192; cv=none; b=Glr/DTbAVf6eEg/DbhQnkJjFcrcWXd2+ngsXGmB8i3yYOFifZWNWnlhtRZq3bkIPn051Jh/tEDC0gizjsbrACPr1wK2oZiHY9ekMy2oLtAd5mONf3OjA70Rc5brZdBu2qrdStkw+OIjkwIejZIxg4sxT8HHP2ny7CwX1RvXs4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387192; c=relaxed/simple;
	bh=8IXhrHSuZ6feZ9c3PR2cWeLaSe6LydMjKfjOI4vRvLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c19cNFLhxMSlDXEAjeYFQT8xe8IIpgN136l0e9ytZtVyPx6lUN5/nDzKYQweWcfPgdQPrFkQQ3xTprgY9C6s+lde6Vse+9kAEwhxQy/yDiqN+lZuikg0q7ecZwe9EtojdY5YTC0kIdwJyJQXxIp0pV/dk4cybqV7IycxyW1bFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L5VYx55F; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc424901dbso16873125ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721387190; x=1721991990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvBFlpbYXm8DRw134Gwy2tFTrnf08dD4R+UNnPp1igc=;
        b=L5VYx55FzADxn5V1wqxoMk1RtQp8ksySGG4kKVvtkEIpbpbcAzF/MJeK/NN//+L1KM
         q14ggjdAIISa3ciCJdEeOUVohEsynMfGff27Thz2pP3uF4dHpWJTixqCVMdojfPcQCvc
         RIfDiy403QQ7Qo8vhnIR/pEFfmcYcxhN2bExs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721387190; x=1721991990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvBFlpbYXm8DRw134Gwy2tFTrnf08dD4R+UNnPp1igc=;
        b=iG5O8bQPp83lXTZ9eYsKgvsUbhCdyS00Lap6ulDMqT9B/tH2YVANORvD9CMneTW0Om
         Uq85e7OY02O99TgaFBH9nUAkoV75xyS46h2jVWCYDTtP1F1K75zknD6ZkuR+kCRze77G
         XoiqHxW0bWWGiDt5fjVe+GeYNbRhVZK0N8mB30rPEtDupymIrVODaEw16o4tVbnUyGot
         cgZlM8QYpn5Z4zcuvyitigNGLs/+LA64P3UKvYTbyYHHMyXlEHlgYiVdm6v1YetpCfn4
         7+ohg1VzO0WqaszFzdJgVgb+NggnkwLN6xzlTp90sr/fYyoHS9OBsKDzUrwGhYmOnk80
         PiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4BN1xhW1dcTXCfAXGUAv4VxvlqwrXBJUBw2vj3PMd26XVLVVAH0AqeVH2h0YfQ6i8UH8J6p9jc+liv9JlYvUcvko8TntZ4DvU2RKF
X-Gm-Message-State: AOJu0YyOhEQwboP4GDstIjzm377UZ5sD4f4/5eqeVcvfm4mmNTZVOWeO
	G502JPNpltS9pvsH++6a7SEd5C4vNe8wN51zq6SuIdDOytCZ5H5FZJA63pmH2w==
X-Google-Smtp-Source: AGHT+IFk5azqwBo31OImo8c8UJI5EX9rWaEosQnZRF79smxG3gHpMq/Sp6tvKC9bRIB55rbQcwEegg==
X-Received: by 2002:a17:902:ebc6:b0:1fb:247b:aa2a with SMTP id d9443c01a7336-1fc4e7049c6mr65879635ad.59.1721387190107;
        Fri, 19 Jul 2024 04:06:30 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:28a4:97a8:4541:cf90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f3181ffsm2136795ad.155.2024.07.19.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:06:29 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Kuro Chung <kuro.chung@ite.com.tw>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/bridge: it6505: Disable IRQ when powered off
Date: Fri, 19 Jul 2024 19:05:36 +0800
Message-ID: <20240719110623.1850021-1-treapking@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the bridge is powered off, disable the IRQ until the next power on
to workaround an interrupt storm on some badly-designed hardware.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/ite-it6505.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 1e1c06fdf206..87b8545fccc0 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -460,6 +460,8 @@ struct it6505 {
 	bool enable_drv_hold;
 
 	const struct drm_edid *cached_edid;
+
+	int irq;
 };
 
 struct it6505_step_train_para {
@@ -2624,6 +2626,8 @@ static int it6505_poweron(struct it6505 *it6505)
 	it6505_init(it6505);
 	it6505_lane_off(it6505);
 
+	enable_irq(it6505->irq);
+
 	return 0;
 }
 
@@ -2640,6 +2644,8 @@ static int it6505_poweroff(struct it6505 *it6505)
 		return 0;
 	}
 
+	disable_irq_nosync(it6505->irq);
+
 	if (pdata->gpiod_reset)
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 
@@ -3389,7 +3395,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	struct it6505 *it6505;
 	struct device *dev = &client->dev;
 	struct extcon_dev *extcon;
-	int err, intp_irq;
+	int err;
 
 	it6505 = devm_kzalloc(&client->dev, sizeof(*it6505), GFP_KERNEL);
 	if (!it6505)
@@ -3430,17 +3436,18 @@ static int it6505_i2c_probe(struct i2c_client *client)
 
 	it6505_parse_dt(it6505);
 
-	intp_irq = client->irq;
+	it6505->irq = client->irq;
 
-	if (!intp_irq) {
+	if (!it6505->irq) {
 		dev_err(dev, "Failed to get INTP IRQ");
 		err = -ENODEV;
 		return err;
 	}
 
-	err = devm_request_threaded_irq(&client->dev, intp_irq, NULL,
+	err = devm_request_threaded_irq(&client->dev, it6505->irq, NULL,
 					it6505_int_threaded_handler,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT |
+					IRQF_NO_AUTOEN,
 					"it6505-intp", it6505);
 	if (err) {
 		dev_err(dev, "Failed to request INTP threaded IRQ: %d", err);
-- 
2.45.2.1089.g2a221341d9-goog


