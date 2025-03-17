Return-Path: <linux-kernel+bounces-563210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF9A63911
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6296D188E49B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FED1714C0;
	Mon, 17 Mar 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOyyBbPI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366B155316
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742171993; cv=none; b=hkq+ro1dUflcW4jAZTsdeVemGRnzkcQwfJGcWEvTQ6HcODbqr99kGp8mYKfp7xCWRIa4jN5xu02SQZEE80Pwit4MFVn0laOooYTpzqI2kRsZwHMBSMAGl7UUeyTkX/VrAdLAQojnpcj5iMcUouO5MmVhnyNMbyrud1uX8ME/qWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742171993; c=relaxed/simple;
	bh=BseOSyrWbC7XsN7Ir+jFiDNzEQWe5FkrG+nPfKJhH3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+DTvs28dlrpqwN+lSer79XSKa4gSg6sJWKuj/fqgVfkjaKqTjTtA5xx34BNTj3vsxdjnb420Kd5unQDIlLeExJci0oVupOKB7/ojbusnd2cQ8Osg6Bmcej61qZV1hdvYSnL8mobmIuijM909MhfYUGLy2M45TS3oe7LcmKq0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOyyBbPI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso739088066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742171990; x=1742776790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CgiISetOnuxy15HQS3MAPprAz1pVNJBASTHqb0R23I=;
        b=eOyyBbPIbg+Fi+qJ0SIKD7AmsuvhuHBn3AktJ6Qkn2l317ppI9xtuSvfjam+RN7l+D
         wZF/a1iqAx4lbHBoFypAN4w5puZbRA5LrIpOsfKKv33CKONov3yRqIAwgaABvoyLuhQT
         FsGUmlYXooLEfuBFrWEWN1Z0NgCdJVfHEJ3SpSqQIXOnaxh6cr6rL1n+MmXbDZycOnPI
         rdtYxkYvWvVei0iPyc0dxQXYIIRw7FGbCYUGm/R9eeymG8hA8SsRfP1ejl4rVMjpqvhA
         9JzHQ19zmJgFdhXcy+JAdy7VkRvI/AOahksdboq+cHPZ0OHzZA4AwhXZ9s9ItwA2YKwm
         ImiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742171990; x=1742776790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CgiISetOnuxy15HQS3MAPprAz1pVNJBASTHqb0R23I=;
        b=t84X+Bebozp69LgaAMXK2S9MBqS3sQ18f6ZYW5SjcmBpIAStORSG/bhWm3j1IfuoA9
         v7pbJAiO772RX36WTBIHtHMBNnM1qdZ1zPLvhJ/nQeh9DeNfVerpirIn3stQ+2+rcvq4
         iouEXBZe4//bb9Rg9jmwxWT2LkkEMilKhWAVM80h92/sHa3hQ1XOatYgEL2umLh55Dit
         sal6Zu0F+a/t54upn+IxWnLrGBfbQz5EvEbaRS0prmwrBgX/PmvgSwFb15pWssUy42PV
         MRfqJFBspRDRc/Q/xlDEDhFtm5Q+a/ul0jMEugxePKo0QXyChCSRERUEOvZ0KrkzTPAA
         wChQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYfrQ5wJKqvkCaF9VnhDNWrs4YpdQKDKI+Ueh2yaIy71qZLMmLIPJT3A1k/IFnbRC6gW/0cCb0QiYSKSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedkmAwqXRAcV8G3geJ6uXaspvmO6Z3CeMsJhWX+ZrDjp7ydUO
	Pn+ZrQEQrDsvuEfgSsjgcj8Ez8iup44i0xqxLXOtRX0O2jQ/Z8pNaI3GFYdR74s=
X-Gm-Gg: ASbGncstMoZnOnRx47yq6mpuD8sHz+tLX1t9TROrUTS8Ex/tLODz+MoajHeWsn5u+rt
	uD+N+GRsHrtTUVy2LScl50668Snj3IJ0nO9MLOIPkRKULeo191SKhMx405EReHiWH9pXo3BCzXQ
	k4u2tYYGSaYUobhCKwj1d9O9oTZ27w5u2yQTiKUiAsBe7QRe3pBtXUzGtWZdBAxtG6AqGq4I+tz
	aLSQjlkZ0KD1x/P50xgBBCsK4/pV1qHy57USUfKYhOyhwMPQmlrXgXVfWdTyqUKRzVBTFRTa6me
	3m+EjsaQTR+66T+zFylv2mMIKAwDFL+SV/w9eoRHWX71/CkypssAAmz7zDqXvjwMMbCkPmjtmzE
	PT+/8NasV1RRW9/+hJddhUUdvhDcTcmVz/k1OrTzqJRXHMnIOEN9NBAC6NbIMSvUtP0Ec
X-Google-Smtp-Source: AGHT+IHN6MpPoVaqeceUTiJ12TLHptJq+aSorclyfov0XAOk0vnOAfc+Ft0TUVap5T6G00OSbPu+0A==
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr1205541966b.42.1742171990333;
        Sun, 16 Mar 2025 17:39:50 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefadsm562407166b.8.2025.03.16.17.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 17:39:49 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 17 Mar 2025 00:39:39 +0000
Subject: [PATCH 7/8] media: i2c: ov02e10: Remove redundant dev_dbg() and
 some extra dev_err()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-7-bd924634b889@linaro.org>
References: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
In-Reply-To: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jingjing Xiong <jingjing.xiong@intel.com>, Hao Yao <hao.yao@intel.com>, 
 Jim Lai <jim.lai@intel.com>, You-Sheng Yang <vicamo.yang@canonical.com>, 
 Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov02e10.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/ov02e10.c b/drivers/media/i2c/ov02e10.c
index 40c4d3ee36e3e2a0bb8be3ff10d016e2bb9bbc9d..2c15df8ca733aa4f37e125ac3bfb51a319e34c6e 100644
--- a/drivers/media/i2c/ov02e10.c
+++ b/drivers/media/i2c/ov02e10.c
@@ -316,7 +316,6 @@ static int ov02e10_set_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_ANALOGUE_GAIN:
-		dev_dbg(&client->dev, "set analog gain\n");
 		cci_write(ov02e10->regmap, OV02E10_REG_PAGE_FLAG,
 			  OV02E10_PAGE_1, &ret);
 		cci_write(ov02e10->regmap, OV02E10_REG_ANALOG_GAIN,
@@ -324,7 +323,6 @@ static int ov02e10_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_DIGITAL_GAIN:
-		dev_dbg(&client->dev, "set digital gain\n");
 		cci_write(ov02e10->regmap, OV02E10_REG_PAGE_FLAG,
 			  OV02E10_PAGE_1, &ret);
 		cci_write(ov02e10->regmap, OV02E10_REG_DIGITAL_GAIN,
@@ -332,7 +330,6 @@ static int ov02e10_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_EXPOSURE:
-		dev_dbg(&client->dev, "set exposure\n");
 		cci_write(ov02e10->regmap, OV02E10_REG_PAGE_FLAG,
 			  OV02E10_PAGE_1, &ret);
 		cci_write(ov02e10->regmap, OV02E10_REG_EXPOSURE,
@@ -340,7 +337,6 @@ static int ov02e10_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_VBLANK:
-		dev_dbg(&client->dev, "set vblank\n");
 		cci_write(ov02e10->regmap, OV02E10_REG_PAGE_FLAG,
 			  OV02E10_PAGE_1, &ret);
 		cci_write(ov02e10->regmap, OV02E10_REG_VTS,
@@ -348,7 +344,6 @@ static int ov02e10_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_TEST_PATTERN:
-		dev_dbg(&client->dev, "set test pattern\n");
 		cci_write(ov02e10->regmap, OV02E10_REG_PAGE_FLAG,
 			  OV02E10_PAGE_1, &ret);
 		ov02e10_test_pattern(ov02e10, ctrl->val, &ret);
@@ -358,7 +353,7 @@ static int ov02e10_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = -EINVAL;
 		break;
 	}
-	dev_dbg(&client->dev, "will update cmd\n");
+
 	cci_write(ov02e10->regmap, OV02E10_REG_COMMAND_UPDATE,
 		  OV02E10_COMMAND_UPDATE, &ret);
 
@@ -510,7 +505,6 @@ static int ov02e10_set_stream(struct v4l2_subdev *sd, int enable)
 
 		ret = ov02e10_start_streaming(ov02e10);
 		if (ret) {
-			dev_dbg(&client->dev, "start streaming failed\n");
 			enable = 0;
 			ov02e10_stop_streaming(ov02e10);
 			pm_runtime_put(&client->dev);
@@ -903,7 +897,6 @@ static int ov02e10_probe(struct i2c_client *client)
 	/* Set default mode to max resolution */
 	ov02e->cur_mode = &supported_modes[0];
 
-	dev_dbg(&client->dev, "will Init controls\n");
 	ret = ov02e10_init_controls(ov02e);
 	if (ret)
 		return ret;
@@ -917,10 +910,8 @@ static int ov02e10_probe(struct i2c_client *client)
 	/* Initialize source pad */
 	ov02e->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&ov02e->sd.entity, 1, &ov02e->pad);
-	if (ret) {
-		dev_err(&client->dev, "%s failed:%d\n", __func__, ret);
+	if (ret)
 		goto error_handler_free;
-	}
 
 	ret = v4l2_async_register_subdev_sensor(&ov02e->sd);
 	if (ret < 0) {
@@ -944,11 +935,10 @@ static int ov02e10_probe(struct i2c_client *client)
 error_handler_free:
 	v4l2_ctrl_handler_free(ov02e->sd.ctrl_handler);
 	mutex_destroy(&ov02e->mutex);
-	dev_err(&client->dev, "%s failed:%d\n", __func__, ret);
+
 error_power_off:
 	ov02e10_power_off(&client->dev);
 
-	dev_dbg(&client->dev, "probe done\n");
 	return ret;
 }
 

-- 
2.48.1


