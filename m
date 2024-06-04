Return-Path: <linux-kernel+bounces-201105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8598FB991
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEC6B260AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4D149C65;
	Tue,  4 Jun 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXKp+a5w"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21311149009;
	Tue,  4 Jun 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519933; cv=none; b=rKOIB3R82yN1xriTe09W53kKOvW4GrsER2K7qEsKBY2hbn1uwOv9eYsS4RjJIG15tYaSIUkMzZmDCNJIPbwTdh54wKryC/BNiIpJ/oPj08wu4QIJn0aA0pOX6HJz31GzVgRe0m4kh0vq/ihL1/IoDygCorXHjuOlXYkZ5IfmLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519933; c=relaxed/simple;
	bh=DYn2aSysUxjoJXWq3Kj3csOOiFlPojw8oWHmMl9rv6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkdNwona/sSMFbACi6RQQ269o3GEdNvMOZRXwdUd+rcCQklLUytJmzreMUmAZxhbTheG0X4ehexGcINblwKkjyzU/KK2whQSiuLVJ6uDqbFpm1SwuIGS8lLQXqx3cmlUMQjLo1ME1vwqL0e7guIbiC6bf4M2ilms04Ucnp7oq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXKp+a5w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421140314d5so52484875e9.0;
        Tue, 04 Jun 2024 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717519930; x=1718124730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5IL9WVaL+MRAvoehS1X61pU+AcxiSLj6714R/XAATo=;
        b=lXKp+a5whA8Sio5gNO8RcCByikYgqwLhIru7ZqoFGNqe7DglvZ2H3pZfNvpPgC901n
         ExQpR+Fo8BArdjerWryurMlig9MEdOn40RM21Kkprh2YdRg2XAutcSascGqr6QAul9PG
         /siWJnTb99dRCHVHasZaXDKVI5suGbNeXdx1DYI+uYBa4+BbOYVYT9OKHEnbMWt8xaoo
         7T1d4pwyMZ6suMwRODVIlZfo8xoE35WqKMkPFXVQ2ol1vt17FbgYARPgoLjMGulC2ev5
         8H+l6T1RDb75mV48cyyY/KZjtj7rYpf5HEpeWv2o54ruJ+OHN6QKqk3ZoLNHVNnTxHiL
         Ls0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519930; x=1718124730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5IL9WVaL+MRAvoehS1X61pU+AcxiSLj6714R/XAATo=;
        b=qI1pbGeYac5Ozy3XOK4JmKLgz2uNaeD8h9xsiRxLEv9JcKWY7URshMM88ZeH/AqaiH
         tSTWDYQFaJQuoNATzIO9WPrCAIAcQqE2ABRAUN8eMORHvEmRh5V2mIPXRFs+2RyXtyZ+
         DMk5h72Afa2qjEiwPfpyw6QsGv1xlMlNA5PvAPhQjaMd0uq2rnxE2lqgQgExgZYQC6uB
         N58+24wIp2EO2CqCV5R5nJBjX6o2u+fA+pyOTZnNVNZQqhLDTGuHoTPI2lnV3ogoiyHg
         xXLVXCFcDmJyZDAOrbGggC6MNyP/1MPQP6I6GbzbTuEjsaoTWra78ft8etuwnGnseiPM
         MPFA==
X-Forwarded-Encrypted: i=1; AJvYcCWdV3x2bI316p07XnlHOYWVCFrpp/NNI4GAn3m3vySM3W/FjDlrVH+yB7J+uvArstoj1BPCcSQjDNqSg7A+dtXPgdNf1Wyjj87rkLFxrGH+6ZjWNn8/Y9BhATCUmz1+KgApBpeQxDPikwhs+tzYdrZvI5iJnoJJ9A50XdtvuxnFfRzGe0zV
X-Gm-Message-State: AOJu0YwjvAHgb4gfSh6JpIvortSWqpBFBxyauntQbYWXveGtRdN4AcAl
	tm1ATuT6wYebnBsW0nyL59cXMe5VUDfE3JpnBsp+9R5so1bSFkfMaDnSMw==
X-Google-Smtp-Source: AGHT+IF9Dlsi8yW1wizOitucEDQ8VMvlSc2U3VWBwZlW2fFGnLHyj5BCWvkqDtr++D/4Sx0b/7s2/g==
X-Received: by 2002:a05:600c:3550:b0:420:1078:a74c with SMTP id 5b1f17b1804b1-421562f2126mr1437715e9.20.1717519930303;
        Tue, 04 Jun 2024 09:52:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212b85c61dsm162465555e9.28.2024.06.04.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:52:10 -0700 (PDT)
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
Subject: [PATCH v4 3/3] hwmon: g672: add support for g761
Date: Tue,  4 Jun 2024 18:43:43 +0200
Message-ID: <20240604164348.542-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604164348.542-1-ansuelsmth@gmail.com>
References: <20240604164348.542-1-ansuelsmth@gmail.com>
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


