Return-Path: <linux-kernel+bounces-189842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C68CF585
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E17B20CA3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D112C472;
	Sun, 26 May 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV4j0RmS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE11DA5F;
	Sun, 26 May 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749140; cv=none; b=YKHySNcHW9LBCecFKtXn0mxYkVAocmwNsV8xbZLUa6YpAVGcJpr6cu79DJ5T2c4wOcK4D4HOu/0J0Yu6QwkZkOW1lAg3yHt+4pfQsnlSsBJ8RRp9rnuKQvVpiGkte+Y1UgO10Q5TOFi5tHvxgoSHBprE0yeWjpVtBCOR8RnMlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749140; c=relaxed/simple;
	bh=DYn2aSysUxjoJXWq3Kj3csOOiFlPojw8oWHmMl9rv6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpZaI4TVbNtKbV2Mf1JEg8xQqaTcwbdhxva6162Pnpu8ix7RavwfL7CxdEHd8BBIP2/iotnRJBI1tsNwdFfcBp+j2dkMp4W4Gr4SFKLn4ygi/a/TYpfP/pWImK3MHaujeNW/LMRZF2rzZnJgI3mUxw7fdvDyqHyUCEL7GejH6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV4j0RmS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso81870081fa.2;
        Sun, 26 May 2024 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716749137; x=1717353937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5IL9WVaL+MRAvoehS1X61pU+AcxiSLj6714R/XAATo=;
        b=gV4j0RmS4M2R2vQdAtIfzWJxMMYTnzBFEzKJKRllk8nuiDIXVfCvug6sNyqhDYj5Kz
         tciCJP6UxTvmOS8QluI5qBFBFF8GMviO9HmGovCa8TfteBIdtn9P6EcA6SFRqd01RUDO
         NOWfto6EgaeBB3zAjbjK7hMaQnSAoetwtYn4dRwO75n3NIUh7dfdu/oEDn9s3vgP6y4b
         eN4cdDHWwhQGSvyj2vnZCpPLg6C7yz3UchRoFUdh0eDB6fhWXKKCT1X9MJGH3ovcxoNe
         nuqDH0nnWwlLcmyiFrHsnDT1vwp6JBv+zN1aMrd7dgNyrec/9dWluKGqnL76yzhsjykP
         r+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716749137; x=1717353937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5IL9WVaL+MRAvoehS1X61pU+AcxiSLj6714R/XAATo=;
        b=hgvXCFgleU6cycBL5zfFLHalZnqN1SkabFNH7gzQU2PhMfwcMv1alz973zbmCfJ846
         ldRp796r5aYohVvt/3IFWWGcadFYtxgQ4yiE8Yl+Z99RHEzqfuG5VKXRjoMh+TstdrBP
         9ZyL45qWFxOTBzKsuSIrGh8wtIRz3Jvs5ySsCEhd+gNaC/r+4SEaN1f5vNyto+xezRDD
         ONhqK6XqJb50hbjBiCNyVt5Rm/zf/qVwAdYXDleJIp94ZyRPipg1AH5lXkDu1uvaLU4J
         dwFVc6MzSFourtCwtHVs2cHshrmech8wb9raeT8JWCjiLg9EB3DlLeleTBo3hmrfrSSb
         4tOA==
X-Forwarded-Encrypted: i=1; AJvYcCXn3bUF4qTmIdS2iUVHpNcXcgSaToiP0hevWDOdBrFxgPOKf3uZ7q8+gO1T2Vto8U7RdMFFosdyEWsAlZMIDh4CFYXA/bOuMk1vsL+Aj4Pia++/X1bFAHEnZOrT5jcC90fsJIu/lmOzsrspRdplBWK4FcH75KKWOEawPu2Sh9USWvpM5pHz
X-Gm-Message-State: AOJu0YyMVTFCCyC8YU1fiN696OZmWry5ZFjeNJufi2QTN2OrgSi2sYIr
	ePMJCqP0YwAkrllGQVqCZEzsQUSui/llPP56FEG5AEMVi8YoxTaM
X-Google-Smtp-Source: AGHT+IFeY+DPFBdoClSgAlOqZo+Z5AKnX0cbUgFQyPiSnm2Mh4+flIRnbeMwzJIJb8B/uipjI9owZQ==
X-Received: by 2002:a2e:9f0a:0:b0:2da:a3ff:5254 with SMTP id 38308e7fff4ca-2e95b042cd4mr65305581fa.1.1716749136562;
        Sun, 26 May 2024 11:45:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421089cc504sm84960075e9.40.2024.05.26.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:45:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: g672: add support for g761
Date: Sun, 26 May 2024 20:45:25 +0200
Message-ID: <20240526184526.21010-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526184526.21010-1-ansuelsmth@gmail.com>
References: <20240526184526.21010-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for g761 PWM Fan Controller.

The g761 is a copy of the g763 with the only difference of supporting
and internal clock. The internal clock is used if no clocks property is
defined in device node and in such case the required bit is enabled and
clock handling is skipped.

The internal clock oscillator runs at 31KHz.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Rework handling of internal clock

 drivers/hwmon/g762.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index af1228708e25..a00cf3245eec 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -69,6 +69,7 @@ enum g762_regs {
 #define G762_REG_FAN_CMD1_PWM_POLARITY  0x02 /* PWM polarity */
 #define G762_REG_FAN_CMD1_PULSE_PER_REV 0x01 /* pulse per fan revolution */
 
+#define G761_REG_FAN_CMD2_FAN_CLOCK     0x20 /* choose internal clock*/
 #define G762_REG_FAN_CMD2_GEAR_MODE_1   0x08 /* fan gear mode */
 #define G762_REG_FAN_CMD2_GEAR_MODE_0   0x04
 #define G762_REG_FAN_CMD2_FAN_STARTV_1  0x02 /* fan startup voltage */
@@ -115,6 +116,7 @@ enum g762_regs {
 
 struct g762_data {
 	struct i2c_client *client;
+	bool internal_clock;
 	struct clk *clk;
 
 	/* update mutex */
@@ -566,6 +568,7 @@ static int do_set_fan_startv(struct device *dev, unsigned long val)
 
 #ifdef CONFIG_OF
 static const struct of_device_id g762_dt_match[] = {
+	{ .compatible = "gmt,g761" },
 	{ .compatible = "gmt,g762" },
 	{ .compatible = "gmt,g763" },
 	{ },
@@ -597,6 +600,21 @@ static int g762_of_clock_enable(struct i2c_client *client)
 	if (!client->dev.of_node)
 		return 0;
 
+	data = i2c_get_clientdata(client);
+
+	/*
+	 * Skip CLK detection and handling if we use internal clock.
+	 * This is only valid for g761.
+	 */
+	data->internal_clock = of_device_is_compatible(client->dev.of_node,
+						       "gmt,g761") &&
+			       !of_property_present(client->dev.of_node,
+						    "clocks");
+	if (data->internal_clock) {
+		do_set_clk_freq(&client->dev, 32768);
+		return 0;
+	}
+
 	clk = of_clk_get(client->dev.of_node, 0);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "failed to get clock\n");
@@ -616,7 +634,6 @@ static int g762_of_clock_enable(struct i2c_client *client)
 		goto clk_unprep;
 	}
 
-	data = i2c_get_clientdata(client);
 	data->clk = clk;
 
 	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
@@ -1025,16 +1042,26 @@ ATTRIBUTE_GROUPS(g762);
 static inline int g762_fan_init(struct device *dev)
 {
 	struct g762_data *data = g762_update_client(dev);
+	int ret;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* internal_clock can only be set with compatible g761 */
+	if (data->internal_clock)
+		data->fan_cmd2 |= G761_REG_FAN_CMD2_FAN_CLOCK;
+
 	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_FAIL;
 	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_OOC;
 	data->valid = false;
 
-	return i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
-					 data->fan_cmd1);
+	ret = i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD2,
+					 data->fan_cmd2);
 }
 
 static int g762_probe(struct i2c_client *client)
-- 
2.43.0


