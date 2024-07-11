Return-Path: <linux-kernel+bounces-248952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE092E457
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE4284B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D04158DA0;
	Thu, 11 Jul 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spJ3uAlD"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DD1581F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693205; cv=none; b=ETQQBG5VxsOcWZPpqQYm6copRF6PUI0SQLyHFVF87UKqlvilwRcIhRwQASg6pK8ptZKDCa0n9NDwKdcqyzZG5ESXmc+UerQbjb0ZunIe0HwxcrYHtuwd4wgM+XV+Ip0WKeKP8VMni/s/SatuJi6K7IutV+5CAT31RUh/Zgyqtwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693205; c=relaxed/simple;
	bh=ZDIWCtJoTPpqgSB2DOYJ2lRtvYa0iBWUcVLT0ATuLSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbsBerCyNZUM7Kveq+gYUI+IAcjUzHDkYpgs+olacYHbI6XdwuDUuG6XOHEkIj6q7oY2FQXtgAX+tRH1DU6TaqGNoMxzXMECAjx81m2i0vbkDeewiSUe33Tz+iXT5LNe2VjqVrdwXgx6O2KQdyn7RL1H6V0w5k8HXqJAcNjEEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spJ3uAlD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so9121731fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720693202; x=1721298002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koV68SqPyU3UAlRmC6Mum6YXdK1Ua2t3zfx/aiRtqyk=;
        b=spJ3uAlDKfr4M9oYlQNSaHYLMZHB1Xdc2AsvIOPgiWfFng/4huu1LUDwVE+K1cjlKK
         W/WCVh7wHg7X7sIjrh/nWz4HulHYzEIDDNFbmB10jSsqjUUr7r+vxQNqX0MithqC32Ni
         oebS6IHrRh74MEFwt9GpG/h4hzgphXGB9MSYpKqbMMUxsnOty72r0MBspUhr0vCSYjQN
         TifUQlqEK+JDlrsg2eenKk5uAG/ibIFPLqut244ZK4dHKqA+nOJ34gaHTYNMocXGW0xB
         f8d/T/85HR6vyr/6+pnIw9KIufZzuYN5IjORhuxysqc4UmO7SMy/gW6P3JHGkw2I+Qch
         iKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693202; x=1721298002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koV68SqPyU3UAlRmC6Mum6YXdK1Ua2t3zfx/aiRtqyk=;
        b=jpOFG9ixvDqF6BXsvtbakp9rvmaelALPED00O7okEd2vxAmRHNNidwqFKFA2kLhW2E
         KDR3wcdZmc4nsi8zFVwCjJ2uaTfJRTWYnkyEE1EKZBYwr4x6owE8YqU3v0aogsh3ydi2
         J+Ec/vW8pkS9TEhcuT6k8NgVZ3heW9GWkO+nLMeAWTS2QcmwyYZkiJrQXzM4PtMeWOkp
         SwXv1u6brYgCsdsjovfLa1LxEkf0WArcQCGbDuTgf5sVnuSyLIZkAk7lCtUZhmY3RdQG
         hFSlH4eRaWk8R6rty+e30b5Y5Tk6jAZVCVq2OqF/mLBsBGWUaJEMicUbIKyOchIICIjA
         N2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVidjNiqqL+eR7h6bAawJ/mY2Ovhlj9Rcf2djB5zYO3wy22nZysKsqATZ/7ybHR9QCLDaJObCFthc+7emDh8gHpJWTE2dJiMvWOkYT7
X-Gm-Message-State: AOJu0Yw4RRWxwJHoTi/OZOewKlIX4Km2bapFbTA/e1pKCmErtYsKYywl
	Cy2sINg3ft2eu99OIvM90hCcOV6Aot3cTpEfo5zqkPl4HFfUAP60shJAKj5b8lk=
X-Google-Smtp-Source: AGHT+IG4lGOEP0ObrRCkbO66rKar4kb9gm5MrDgJ4yrSwAmZ7O8Q6KboQB+IJXQ95N9D6jwYagmyoA==
X-Received: by 2002:a05:6512:3b8c:b0:52c:6461:e913 with SMTP id 2adb3069b0e04-52eb999623amr5603923e87.16.1720693202115;
        Thu, 11 Jul 2024 03:20:02 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266e861339sm125270025e9.12.2024.07.11.03.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:20:01 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 11 Jul 2024 11:20:01 +0100
Subject: [PATCH 1/2] media: ov5675: Derive delay cycles from the clock rate
 reported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-linux-next-ov5675-v1-1-69e9b6c62c16@linaro.org>
References: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
In-Reply-To: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-13183

The ov5675 driver expresses its reset delays in terms of XVCLK cycles as
per the ov5675 specification. XVCLK can be anything in the range of 6 MHz
to 24 MHz inclusive.

Upstream we use 19.2 MHz however, since the delays are calculated in terms
of clock cycles as opposed to fixed intervals it makes sense to facilitate
any potential clock we might support.

Do so by reading the XVCLK rate and using the returned rate instead of
operating from a static definition.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov5675.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 3641911bc73f..92bd35133a5d 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -497,6 +497,7 @@ struct ov5675 {
 	struct media_pad pad;
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct clk *xvclk;
+	u32 xvclk_rate;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
 
@@ -973,10 +974,11 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
 static int ov5675_power_off(struct device *dev)
 {
 	/* 512 xvclk cycles after the last SCCB transation or MIPI frame end */
-	u32 delay_us = DIV_ROUND_UP(512, OV5675_XVCLK_19_2 / 1000 / 1000);
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov5675 *ov5675 = to_ov5675(sd);
+	u32 delay_us;
 
+	delay_us = DIV_ROUND_UP(512, ov5675->xvclk_rate / 1000 / 1000);
 	usleep_range(delay_us, delay_us * 2);
 
 	clk_disable_unprepare(ov5675->xvclk);
@@ -988,11 +990,13 @@ static int ov5675_power_off(struct device *dev)
 
 static int ov5675_power_on(struct device *dev)
 {
-	u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov5675 *ov5675 = to_ov5675(sd);
+	u32 delay_us;
 	int ret;
 
+	delay_us = DIV_ROUND_UP(8192, ov5675->xvclk_rate / 1000 / 1000);
+
 	ret = clk_prepare_enable(ov5675->xvclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable xvclk: %d\n", ret);
@@ -1178,7 +1182,6 @@ static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
 	struct v4l2_fwnode_endpoint bus_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY
 	};
-	u32 xvclk_rate;
 	int ret;
 	unsigned int i, j;
 
@@ -1192,10 +1195,10 @@ static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
 				     PTR_ERR(ov5675->xvclk));
 
 	if (ov5675->xvclk) {
-		xvclk_rate = clk_get_rate(ov5675->xvclk);
+		ov5675->xvclk_rate = clk_get_rate(ov5675->xvclk);
 	} else {
 		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
-					       &xvclk_rate);
+					       &ov5675->xvclk_rate);
 
 		if (ret) {
 			dev_err(dev, "can't get clock frequency");
@@ -1203,9 +1206,9 @@ static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
 		}
 	}
 
-	if (xvclk_rate != OV5675_XVCLK_19_2) {
+	if (ov5675->xvclk_rate != OV5675_XVCLK_19_2) {
 		dev_err(dev, "external clock rate %u is unsupported",
-			xvclk_rate);
+			ov5675->xvclk_rate);
 		return -EINVAL;
 	}
 

-- 
2.45.2


