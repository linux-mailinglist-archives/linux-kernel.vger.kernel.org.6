Return-Path: <linux-kernel+bounces-189332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7F68CEE85
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D91B1F214DD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6C3B18D;
	Sat, 25 May 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USbCDJ+/"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EAF2C1B8;
	Sat, 25 May 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632968; cv=none; b=Vc0sFRegKaSsVzjXATi5YcN30gpCz6rE0vFcEVHzx+vxc+3L+HUP1f8PG3ZFmWlKYRA+MZxWmrhiaVPyIBYOxm3KxTWlsgT+mdbGtRjg8XPB4BIt2A3cbg9hKpBI9G8MRBCZS7aArKM81lXRwIviJscayjoDtXKUCqCftbRxF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632968; c=relaxed/simple;
	bh=6OojyHEHyztqo2TUt1lhXyVgSsQ0TBRoUiEL7+DxBTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcBZOXnXYlw1tD9CLmr7Dct8ojuM87YDyFZWpNnKJvA42Xa6rV4i8ciEe4KDRLRp4Fwd0pv+PuHQfHXFNJc3ck2CmmZNAn7haDoCkCnW8I4QPIGcJh2t+YAbiC5YMcRUX0gO5LG+pbN+0tXTdCMSL6qJ1LfzCOqA0t30dFF40YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USbCDJ+/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so20686391fa.0;
        Sat, 25 May 2024 03:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716632965; x=1717237765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GaCh38jQb1O6dHYQUFwk+JyFUXEH9RZyCvXnxsDzbE=;
        b=USbCDJ+/hE39Mc55BxD6AKLSwX800hquXHyiFtjtl5rRenevZK6f2SOEgowsDvzMv9
         cgC+zd+UQtK2WNpnZS68NSJnMBimXcS71STdSoAHhLrXDyW38J9F74iKyhsjsJ5UvQJN
         ATFJ7VgAmVqmuu4AimMMuGAipFut0lGHxFSFMrG7eiLGsFjN0Xbjlzhulye/cMqMUjl9
         LKun2U+FY6Ougq5OgLrS+Ub2lCnjOb1TiMU4Hfo6lFaHG+klpgtxeQ5sIr6gKxcuBdSm
         3zEolFNRQ3QQZzWc1p0JFWM1yx5CNuAhScMJ+Pf4D8hhIGLd7ws/psSxsSjJahpDLvAJ
         Ogtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716632965; x=1717237765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GaCh38jQb1O6dHYQUFwk+JyFUXEH9RZyCvXnxsDzbE=;
        b=oLhvC3SYKZ0/9HgRm5sQPu+GG8cW3FWnV4isoFZhBmyZd5woVMLDTAMm5syYKYA4Fc
         r5vzAQiSxzlLS+8KnNovJJ1s6MxQJdDB0xt0Wef25MXsRrUbEKUsf7tSlG9rmmB48od+
         qYur+qzelct5xVb+drxSPrIaegDua74QBOINvP5jmIgehFJt/SG9t7MpofOoNHkZmbko
         LPtGarFY7D1A6Qmji0GQUfEALY4iJTL+s4eAzOWZb0Kkt4UzWqt/uigvBhGJFlgcqO3F
         OARowg623c8nRp7/6UwbZiTuWYsYndklBX4t7ycKi4gxxwLviVpDLuPhzTjz6ZVJTdSS
         4+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXg1ZhM5+Nd4SompA/EiMJ5M+V54BANll1EL9Borouox6LBcj3CDl9eU19N/HDPfgov1c2J55w3L0czHjqaLHbJaFfDD0K2cl0VC367ksKRtmWpAaFzuNxJzGWbYS+xFC1nCvY1OgY0LJqSfy7KH7tD5SeNXAxBHdFjTUrdfFXPEPCfZd
X-Gm-Message-State: AOJu0YxFvi6Q583jgau4gOiBnBArZVq7FzeEBJzwXLv1Ct5FQ0g7RCzr
	TEfZaPQEkIExnDEFmDumOYsOcy417E/pQ8vmceuHI5OZSbLwDBGr
X-Google-Smtp-Source: AGHT+IGMLzoCtvXN3m/fC+vUzmwyk+kFSoszTXTjtj7MW+NybH+4NmTDB2f1Knzfzc8OQwrwz5QaUw==
X-Received: by 2002:a2e:998b:0:b0:2e1:18d:5b4f with SMTP id 38308e7fff4ca-2e95b2823e1mr28804791fa.42.1716632965244;
        Sat, 25 May 2024 03:29:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3557a1c918csm3674651f8f.77.2024.05.25.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 03:29:24 -0700 (PDT)
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
Subject: [PATCH 3/3] hwmon: g672: add support for g761
Date: Sat, 25 May 2024 12:29:12 +0200
Message-ID: <20240525102914.22634-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525102914.22634-1-ansuelsmth@gmail.com>
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for g761 PWM Fan Controller.

The g761 is a copy of the g763 with the only difference of supporting
and internal clock. This can be configured with the gmt,internal-clock
property and in such case clock handling is skipped.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/hwmon/g762.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index af1228708e25..1629a3141c11 100644
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
@@ -597,6 +600,16 @@ static int g762_of_clock_enable(struct i2c_client *client)
 	if (!client->dev.of_node)
 		return 0;
 
+	data = i2c_get_clientdata(client);
+
+	/* Skip CLK detection and handling if we use internal clock */
+	data->internal_clock = of_property_read_bool(client->dev.of_node,
+						     "gmt,internal-clock");
+	if (data->internal_clock) {
+		do_set_clk_freq(&client->dev, 32768);
+		return 0;
+	}
+
 	clk = of_clk_get(client->dev.of_node, 0);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "failed to get clock\n");
@@ -616,7 +629,6 @@ static int g762_of_clock_enable(struct i2c_client *client)
 		goto clk_unprep;
 	}
 
-	data = i2c_get_clientdata(client);
 	data->clk = clk;
 
 	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
@@ -1029,12 +1041,17 @@ static inline int g762_fan_init(struct device *dev)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	if (data->internal_clock)
+		data->fan_cmd2 |= G761_REG_FAN_CMD2_FAN_CLOCK;
+
 	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_FAIL;
 	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_OOC;
 	data->valid = false;
 
-	return i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
-					 data->fan_cmd1);
+	return (i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
+					  data->fan_cmd1) |
+		i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD2,
+					  data->fan_cmd2));
 }
 
 static int g762_probe(struct i2c_client *client)
-- 
2.43.0


