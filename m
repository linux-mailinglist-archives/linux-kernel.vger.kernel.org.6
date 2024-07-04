Return-Path: <linux-kernel+bounces-241333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA89279DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0279EB26B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D61AED21;
	Thu,  4 Jul 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQMDHXhm"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646381B011C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106377; cv=none; b=eERhQiw67WB0p7T7r/yTTg1H6kZVRZgqTrCrjnqU1clkjxmxkUiirEWbxGZFJoiSbJ/9FV7A0Btm/BLE0aW9aU2FASTiT1G9dbZdioZBDP66iEKCyp6nmyZ+FeNJ6SQyvr1Sxf8g1PZ+wpLzK6m2s2cw+sUYmtMeFCChYp9VReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106377; c=relaxed/simple;
	bh=NLb6Q+ANHQ06rpfkujhFNjqrqimEb0WH08jhVQZ/wu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IKONBU2rTUsyL4H7PVSLYCcbixWjV95XLMi+w0F+IAHIH7lLOKOHbpP40GegOl7gn5/aNOgVbIr0jOWO2A4dsbTYn8beh4ZbyKl2AYk6lNzfwFzZnSYs9PWHcds1r3goAPi6AtlSt04jG7RV/YxCQn94mGAr80o3nu+o+/34ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQMDHXhm; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-700cc388839so495666a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106375; x=1720711175; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBnMvG37dKuOC06S9766u4IZ2Y8qnimBTz3yQ0fqYFs=;
        b=xQMDHXhm0ZN/5JPM6OySB8Vz5K6qNztm+FpCV9WPEkfP5xlUqig4JNkIAuxFMMziIu
         igdjOGhw297xPnix49EX00tgvf9rpZyNC8Ioap+9kAuemFA0HPYqZXaCfiM13MI2iaaz
         uzUSIwsJltogYSPWxoa4z5VSgm2PyYFEmhZQE5yNNaZOT9dgZiGi20ow89dMl0YH8PLy
         zSdwRPAW1ZRPjAbz9LI1/5AYO6/dhei0nBFT4Bmfd1N/ZwADncLlQdEbcADt9SVjUOvA
         SmwOjjFCfQTgAlTLnkTMhwSOXLE6S/kJGiX7WVDVOzB72IHNs/g+30aG0j2NyYy5J3ik
         /lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106375; x=1720711175;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBnMvG37dKuOC06S9766u4IZ2Y8qnimBTz3yQ0fqYFs=;
        b=YnpyfRUH0SNSRJOxW6ygJPTlqksvYQntA/ahvb8vMdAPf8KUTL/jwwgUlxe+S3hdqV
         OIIU4L6HFXQOr5ID1M+c4Lsrgo5Ed/lkvMDaYCbICo8cEHqI09LGY0TdWy9UVHKQok6K
         2gRDmlG9qVMeIFznBC6LwpJ//O2QbCv16Dhyo8Y4HXVgpj65PIF+8vMCWO3QrX+tWfDv
         CfAVgWEnYrlLOjKAplchTGYdIhWB8VCa+vY4l9BtbfIbtYPIf8hfwzICf1BYIzverXGP
         krMuZT4e9LQdWnaUbui4BQ2rf/LRhv4k0QkHjTvU671O6Ju4Xh9TOkSZGf+GGlKSBj3c
         KaZA==
X-Forwarded-Encrypted: i=1; AJvYcCV6bBU23qt6j0csLphX+QPF7UnlBqbzEHBp4Kqaj10wSy2qgkvSuMIK42M3Rlycx2KF0kF1kxjTBDfL6QOnyhtPDItxa3RhqScYPhkJ
X-Gm-Message-State: AOJu0Yw1SGPQCQNm8HNLQxPbQf0dh4KYtRYjeoMJlP/kh0GJU/AMrIrs
	dI6W8o/+U3USNjor2ox73I+DrP4bZgwel4e3WOM4rtTL19vXSctLpLapKw6T+Nc=
X-Google-Smtp-Source: AGHT+IGELc1XlTyU7hBE3KqfD3MGbDcxlgY/gdOmWK9vwGIPWbgvvPgc53z9nomGTso73+WzVnHE1Q==
X-Received: by 2002:a9d:684b:0:b0:700:cf81:3d75 with SMTP id 46e09a7af769-7034a737ef9mr2275095a34.4.1720106375459;
        Thu, 04 Jul 2024 08:19:35 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7ad93c4sm2426120a34.46.2024.07.04.08.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:19:34 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:19:32 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavel Machek <pavel@ucw.cz>, Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] leds: flash: leds-qcom-flash: Test the correct variable in
 init
Message-ID: <ZoWJS_epjIMCYITg@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code was passing the incorrect pointer to PTR_ERR_OR_ZERO() so it
always returned success.  It should have been checking the array element
instead of the array itself.

Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/leds/flash/leds-qcom-flash.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 7c99a3039171..bf70bf6fb0d5 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -505,6 +505,7 @@ qcom_flash_v4l2_init(struct device *dev, struct qcom_flash_led *led, struct fwno
 	struct qcom_flash_data *flash_data = led->flash_data;
 	struct v4l2_flash_config v4l2_cfg = { 0 };
 	struct led_flash_setting *intensity = &v4l2_cfg.intensity;
+	struct v4l2_flash *v4l2_flash;
 
 	if (!(led->flash.led_cdev.flags & LED_DEV_CAP_FLASH))
 		return 0;
@@ -523,9 +524,12 @@ qcom_flash_v4l2_init(struct device *dev, struct qcom_flash_led *led, struct fwno
 				LED_FAULT_OVER_TEMPERATURE |
 				LED_FAULT_TIMEOUT;
 
-	flash_data->v4l2_flash[flash_data->leds_count] =
-		v4l2_flash_init(dev, fwnode, &led->flash, &qcom_v4l2_flash_ops, &v4l2_cfg);
-	return PTR_ERR_OR_ZERO(flash_data->v4l2_flash);
+	v4l2_flash = v4l2_flash_init(dev, fwnode, &led->flash, &qcom_v4l2_flash_ops, &v4l2_cfg);
+	if (IS_ERR(v4l2_flash))
+		return PTR_ERR(v4l2_flash);
+
+	flash_data->v4l2_flash[flash_data->leds_count] = v4l2_flash;
+	return 0;
 }
 # else
 static int
-- 
2.43.0


