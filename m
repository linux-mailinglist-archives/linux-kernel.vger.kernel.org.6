Return-Path: <linux-kernel+bounces-410801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861A9CE123
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9531F21F64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF931CEEB6;
	Fri, 15 Nov 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y3Ot+vuR"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAF1B6D04
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680438; cv=none; b=ofpLa+oCARrJRqb+0HES6FgdaOdSSKnuul9KfrrMA7otNeLNlAeiZtVc4HETr855LtzHBMUr44yf7gH9tHEEX+f/RETP6gIi+ipRjUSDimIp6F71JK2KLiqQFDRkEn+fodt2+2C4O929B3iwoLfokrr6LCZde/ToYxtiJ5amC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680438; c=relaxed/simple;
	bh=IRY4TKgYIngjwiomEX5pc4yFOPLHntpa9jNskIceRCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfaOYpZjhyokCs8KvTu8uKZ4d9FBHxnCYYV6SsVnaaX38qi/waC1ukYTHyfEGS3skuJyQBJhH2GqjuOblqATCc3f5CRAOsgvV19kH5PxBjV8xVx+VB6TqXXR/xHS6YWRguSwdCGG/WL7Gr5sWJzfLmhWxOg5mM+VQoS2+Zx6Krs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y3Ot+vuR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316cce103dso19939825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731680433; x=1732285233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PC6ojwcKypt78PEVjf5QTEeMWWwDjNFd5KxCzoy0bYI=;
        b=Y3Ot+vuRWQbtTLHCkGFwLZWzyk6MCaX8pC172EkcZitD6EzudplafconIcAJwL28yG
         38Bv9sXnPN+/hsXEZbxNyOWT+PncrTfNlI2AUb9J+v9uW5tmMC/g4Bkr1f7GL9rFJs5Y
         pqdsaRzYapGHfdEnMSLzoPjAGCIgbP5JIeouDH5omhgscux1YawOmhP3ASr4rIsrG0Vo
         14U8q2SPh91SyGiQfAbG5E/aHMrZNfjhOUM8OUahDg01F2jy+gT7vNOYPaWxCQbl/ArQ
         1KIRnZq9W0I5Q8xM3XjSPG5qtHDeOHQHfTu/l+A6zfX9H4jrczRwOnVQ7XPrswCbxTcP
         KpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680433; x=1732285233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PC6ojwcKypt78PEVjf5QTEeMWWwDjNFd5KxCzoy0bYI=;
        b=pDOvsEsAMtp6Eh/RAgL8+8yzBlrPSO7lya/mn4ixNd7ZZNUFAIMHNh/Vq9hQY6DFTZ
         bvETquKsMwvvPRn67bbUVrrpWjsklNT4V00YsTEr0+JJia+qBobtrn25yS1BmL2tLFFK
         2/YEj7YqJONpkIJsLxDUkQxVxV8ewJU6v28h8X3VxJRoKqFeSySbSl0k361ONfyB6cpu
         fpHm8m0PsNnik+sDfSr3yXlZzkZhpPmXqKltlntOYObxC58c12E/92Jw4sEzgA75zDzw
         zgGMcEU4TEa1G5sNzdN6KHDACZ/PDf4ckZ8lwMVc22EKlPKmJDJb6XrlHyv2BGP39kze
         PHew==
X-Gm-Message-State: AOJu0Yx8Kl27xl4kpNe1G6qRMSHEiVvSWDkkDgTB224apZhwGze/cVZ8
	T1wH2Xx/t0h9Ztzj8+rKwjcWJer9abqCO38ysThAtNDMLKf4CLvodhDQVcUzSAUdbGF4djCJZ4d
	Y
X-Google-Smtp-Source: AGHT+IHqz3B3rbSjsLJHK1tkocPEUyscZ7eHb+Kl+ZNxGPst/8bolXxZdFoa23wULqg80uGvnYinzg==
X-Received: by 2002:a5d:5f43:0:b0:37d:2ea4:bfcc with SMTP id ffacd0b85a97d-38225a40809mr3084086f8f.13.1731680432107;
        Fri, 15 Nov 2024 06:20:32 -0800 (PST)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3102asm4509686f8f.93.2024.11.15.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:20:31 -0800 (PST)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	manivannan.sadhasivam@linaro.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	Alexandru Ardelean <alex@shruggie.ro>,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH] media: i2c: imx296: Implement simple retry for model identification
Date: Fri, 15 Nov 2024 16:20:21 +0200
Message-ID: <20241115142021.574402-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Ardelean <alex@shruggie.ro>

On a cold boot of the device (and sensor), and when using the 'sony,imx296'
compatible string, it often seems that I get 'invalid device model 0x0000'.
After doing a soft reboot, it seems to work fine.

After applying this change (to do several retries), the sensor is
identified on the first cold boot. The assumption here would be that the
wake-up from standby takes too long. But even trying a 'udelay(100)' after
writing register IMX296_CTRL00 doesn't seem to help (100 microseconds
should be a reasonable fixed time).

However, after implementing the retry loop (as this patch does it), seems
to resolve the issue on the cold boot, and the device is identified.

When using the 'sony,imx296ll' and 'sony,imx296lq' compatible strings, the
device identification process isn't happening, and the sensor works fine.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/media/i2c/imx296.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
index 83149fa729c4..9c3641c005a4 100644
--- a/drivers/media/i2c/imx296.c
+++ b/drivers/media/i2c/imx296.c
@@ -931,7 +931,7 @@ static int imx296_read_temperature(struct imx296 *sensor, int *temp)
 static int imx296_identify_model(struct imx296 *sensor)
 {
 	unsigned int model;
-	int temp = 0;
+	int temp = 0, retries;
 	int ret;
 
 	model = (uintptr_t)of_device_get_match_data(sensor->dev);
@@ -943,25 +943,33 @@ static int imx296_identify_model(struct imx296 *sensor)
 		return 0;
 	}
 
-	/*
-	 * While most registers can be read when the sensor is in standby, this
-	 * is not the case of the sensor info register :-(
-	 */
-	ret = imx296_write(sensor, IMX296_CTRL00, 0, NULL);
-	if (ret < 0) {
-		dev_err(sensor->dev,
-			"failed to get sensor out of standby (%d)\n", ret);
-		return ret;
-	}
+	retries = 0;
+	do {
+		/*
+		 * While most registers can be read when the sensor is in
+		 * standby, this is not the case of the sensor info register :-(
+		 */
+		ret = imx296_write(sensor, IMX296_CTRL00, 0, NULL);
+		if (ret < 0) {
+			dev_err(sensor->dev,
+				"failed to get sensor out of standby (%d)\n",
+				ret);
+			return ret;
+		}
 
-	ret = imx296_read(sensor, IMX296_SENSOR_INFO);
-	if (ret < 0) {
-		dev_err(sensor->dev, "failed to read sensor information (%d)\n",
-			ret);
-		goto done;
-	}
+		udelay(10);
+
+		ret = imx296_read(sensor, IMX296_SENSOR_INFO);
+		if (ret < 0) {
+			dev_err(sensor->dev,
+				"failed to read sensor information (%d)\n",
+				ret);
+			goto done;
+		}
+
+		model = (ret >> 6) & 0x1ff;
+	} while (model == 0 && retries++ < 3);
 
-	model = (ret >> 6) & 0x1ff;
 
 	switch (model) {
 	case 296:
-- 
2.46.1


