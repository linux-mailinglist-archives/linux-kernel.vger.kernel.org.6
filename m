Return-Path: <linux-kernel+bounces-196101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F738D5756
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B65A285ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573CEDF5B;
	Fri, 31 May 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVNSH0L5"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FD4C9D;
	Fri, 31 May 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116425; cv=none; b=p7YTQ3jWL47OMWElgfQ0ygXPGZ/sjIj8QtqNTfKbwMZZFaEIXiGmQJPr+UraC0sjKgMSB/vuJBUNR6WmYflT4b2hf8vB0TJPiyvSZMSNU3y9AN3CHySWcAFn1qPj8g9384EPN8iDV69U7mg1ulyrURxsGL4//0ta9dG6K4CuLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116425; c=relaxed/simple;
	bh=DYn2aSysUxjoJXWq3Kj3csOOiFlPojw8oWHmMl9rv6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwsRoAKR/cd/3mqSDuD+gEfSEeQzIuwGqnsjBDrQSaD61eyQnfQNxn1vcwUOa2RVGKxl/Rs2yUw0Q9TZkLvf8xm05A9IFfE8Ny2BPEPDu3H+BDA3AUG33jXcK0d4BpIiqb6eQq/saORx36yHE0JDlU+bKwZAZaeyckVUzItKU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVNSH0L5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dd0c06577so397562f8f.2;
        Thu, 30 May 2024 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717116422; x=1717721222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5IL9WVaL+MRAvoehS1X61pU+AcxiSLj6714R/XAATo=;
        b=VVNSH0L5vCl4nsknyOLIb2GamWuASx0CwkvOuoQDDJ+z42qaP8RKzJN/Y8WO0XKe0x
         KDVYKcw08lDdmMN4ln3rvMRN2g48bHhUipPrXkp/ZqS+mWkvpfUwPvU408mlVDMQ2YL4
         uYxGYKMVGo9R/jAbOhXX4Jg+8NC6dOu9SlgmyW7LPM0KWqk+XnSV4wqE92dpKBhbUj13
         8LMdmHIYAsgUhV3pG1pL3q5cHWG/7QZiVlfEtV6shnyjYBs2gHXRoRolXgf8xVQm5iQK
         I0g/2/4hIYJht9Zr38xEyGBaBfMN13UZVfC3iMK8LRfwD76OFIQC6AP22nr4zV6J6yjd
         7F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717116422; x=1717721222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5IL9WVaL+MRAvoehS1X61pU+AcxiSLj6714R/XAATo=;
        b=hirggiyuGgnJLVZ2FFV+5K94wmTodrCz8dSHzl+w/6l9NLJa7U/dDD84uNjT1Qbj48
         shRGCxvOknGMXlIGLNyyTFUEzhv0PaeP1kyuj7bj33rN3J5Yzl8xAVwk8oqyFzFcGKTb
         V2Ypqw+29YYIwi13wHti6E/n43DBnFxUZNu4G59vCZ0PyUaJJQfq79GrNYbVUS4Rb4nq
         eKykoM7KnEOqTrrKVmWiF87jLkjkYaHdmxOIxtbmNAMoVTkmCrWcgZAHJj8Jf5PL7Li1
         Gmx3UB+1yBRx3tsAXBmCJppzQOj+rwlTAiHU7pgIAyuvv+q9P6roxP+g1H+Y07CSq/FH
         2rlw==
X-Forwarded-Encrypted: i=1; AJvYcCWb6fNbTAI+NOm04Qxb9fIBWq9hdvQxhIqQo7+deLWoJGDbz4bQdEIevwYB+YfexZxxdK2t3DcNjXaaaqdtJK2NCar9smHbSvAhQUSXknWqQluLLkajUZqzVyOvNw13TjAUBuDXjDp6lRAP95L7TI1wFyOlwll7Uo9k5BKejn0VaClpCn61
X-Gm-Message-State: AOJu0YwZcgu/lK/pMugNo9D8QKxmLfuVwDSNUbX859bYA2TwKKRTiqHy
	U2Npc247AnBPFQojnOpASVXr6SoB53U7cMIsUBaaGn8SSJFRXZB8
X-Google-Smtp-Source: AGHT+IHC6tvIUbG6ljRRlbhhuK8Cm2QRDgcr5rf3NEghDyrm7rlb/TW3ss0Ew3fkoADmXIysg3VqwQ==
X-Received: by 2002:adf:fc4e:0:b0:354:e4e0:21dd with SMTP id ffacd0b85a97d-35e0f3162dcmr138784f8f.50.1717116421903;
        Thu, 30 May 2024 17:47:01 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e84sm608486f8f.13.2024.05.30.17.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:47:01 -0700 (PDT)
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
Subject: [PATCH v3 3/3] hwmon: g672: add support for g761
Date: Thu, 30 May 2024 23:16:52 +0200
Message-ID: <20240530211654.7946-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530211654.7946-1-ansuelsmth@gmail.com>
References: <20240530211654.7946-1-ansuelsmth@gmail.com>
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


