Return-Path: <linux-kernel+bounces-194681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B98D3FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FBAB24111
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5051CB30B;
	Wed, 29 May 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtGLHg4Y"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645B1C9EB2;
	Wed, 29 May 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015936; cv=none; b=Fg8oDR5Pk+mIJuiHmGV06tQsvuV96LCPJoS8T1WTURI3o7iIszTeAwgCgNRlru/3C4bBFX20MoXa9Ba2nOmBJddIaN8JidjelooN9hchZ9vZ0BCbKv97xBycxsduBiiWsIBl7ZTz/RVAoM/+CidjsBQDt6yncCIxgf41mIcKcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015936; c=relaxed/simple;
	bh=u0Z77xfMGXhs2XExzinZRsH5K/fdyJeqGlVMGm0jhRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QELU5an/fkZHMjbFFwR2Cvfy25jhTi8fmOhJsfuDMPGmdPIbv7WoDNu6IhsGFEFJYuReZfBP+Mu8xeNgSz6eBft/jpYLA1HQJOvWQVu8e/MBvjmJruCM4Sy9crDNKoF9flH+aoMFlgURPf8wwEPCiHGHq9PWSDsR5dupEqgz9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtGLHg4Y; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7022c8418d9so200134b3a.1;
        Wed, 29 May 2024 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717015933; x=1717620733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muFhBvZKYg7NYQtZst6SGV6fQcMf41edf97IkKuvcJY=;
        b=MtGLHg4YhGDqDpPsooxcVoMyx/C9w3m4AM6BOjjfk0apjKMrSomwxqcn7e5wNYheV8
         6uUwPxkIMhtrIROtK7uociVMuMaoGWwsiIkMi3F+IzO6z5AULxHdxSGRd8pqNyxjmDvq
         c2ij5GUM0kc3PjbAP+fksggm95tbq9Fc92A7jjNXc6Eg7jc0/jk51WakbEUKoqqefgq1
         /CPPHba/sAEDCk2DHMtHIR4l1UqrfvW1WudqWs7i2//SEgSnr5Py42fAiGlV5mPG+fQv
         kHzfTNRpjvCN7+/26NNKikkFZloCnaM2l1YHvKQu+EntrcgBJY+m0sTqQrGtz3zGbRbN
         l0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015933; x=1717620733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muFhBvZKYg7NYQtZst6SGV6fQcMf41edf97IkKuvcJY=;
        b=UhA+c5CgjI6nfb0DNf4GmJWGHQzKhsNN7ySSEuC0zRBUqNUn4tESw4yQqwyNr2Mbj/
         mZ9TvayTyaZKicyxU0sRPlAuyQhF76xBilz4ORdH78chByricJaVbTpcTpPLArpmpGv8
         M2/CtqBU3lniQM7lphsxLOzZeebJEW1FuzUWMQTVn8eLkZjeAu0ZrCKiOp5U3zgD3Gxf
         BVhP5lzdc5ZrwkbZC2fni3EoHbGR3ICcv08P5dVUND2k6HJtC8hU8DK2eMCFdMNBrwZI
         ziD8I+6pcxg5x7qUcXJZH3LhNU1HjZX7R7e2Wuq3jWuWYW+0FAGrs6OiBTqhrS8Pn13H
         I3sw==
X-Forwarded-Encrypted: i=1; AJvYcCUw0rHmaPHn+Qdm6llljg9371EeOmTjIR+J3UFmitE3E60rWcCDNBwkYQqgZbhQ8LjxFZjkayA5WVnaKBJpNyXVaG+uSd60BTt5EmIurAK0iSkR1wq/XvWjBQhL9CaSN6gocEmLoEEpww==
X-Gm-Message-State: AOJu0YwVwhSVEO2pkew83se1DiqZ4XhwLcvlDj42ykMc0jXLL261hKc4
	P+LpT5VDuT9+GsmSXC5YU5aQoPNwMdsscORmAJTwpL6S9C8vu0TOhnZqIQ==
X-Google-Smtp-Source: AGHT+IEGw7SKmVfRKHHfGkPtZqhcVJCau2k3RAJwV9pre0e0lLMkTjLvp9o+37saOzteGSRdroXc5w==
X-Received: by 2002:a05:6a00:301b:b0:702:2f9d:ee84 with SMTP id d2e1a72fcca58-702311dc653mr172234b3a.25.1717015933385;
        Wed, 29 May 2024 13:52:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70227b3007dsm851859b3a.106.2024.05.29.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:52:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 3/3] hwmon: (spd5118) Add PEC support
Date: Wed, 29 May 2024 13:52:04 -0700
Message-Id: <20240529205204.81208-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529205204.81208-1-linux@roeck-us.net>
References: <20240529205204.81208-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring PEC (Packet Error Checking).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch depends on the patch series at
https://patchwork.kernel.org/project/linux-hwmon/list/?series=857097

 drivers/hwmon/spd5118.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index 440503d09d13..eb21bf3dffd7 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -33,6 +33,7 @@ static const unsigned short normal_i2c[] = {
 #define SPD5118_REG_VENDOR		0x03	/* MR3:MR4 */
 #define SPD5118_REG_CAPABILITY		0x05	/* MR5 */
 #define SPD5118_REG_I2C_LEGACY_MODE	0x0B	/* MR11 */
+#define SPD5118_REG_DEV_CONFIG		0x12	/* MR18 */
 #define SPD5118_REG_TEMP_CLR		0x13	/* MR19 */
 #define SPD5118_REG_ERROR_CLR		0x14	/* MR20 */
 #define SPD5118_REG_TEMP_CONFIG		0x1A	/* MR26 */
@@ -50,6 +51,8 @@ static const unsigned short normal_i2c[] = {
 
 #define SPD5118_CAP_TS_SUPPORT		BIT(1)	/* temperature sensor support */
 
+#define SPD5118_PEC_ENABLE		BIT(7)	/* PEC enable */
+
 #define SPD5118_TS_DISABLE		BIT(0)	/* temperature sensor disable */
 
 /* Temperature unit in millicelsius */
@@ -217,6 +220,18 @@ static int spd5118_write_enable(struct regmap *regmap, u32 attr, long val)
 				  val ? 0 : SPD5118_TS_DISABLE);
 }
 
+static int spd5118_chip_write(struct regmap *regmap, u32 attr, long val)
+{
+	switch (attr) {
+	case hwmon_chip_pec:
+		return regmap_update_bits(regmap, SPD5118_REG_DEV_CONFIG,
+					  SPD5118_PEC_ENABLE,
+					  val ? SPD5118_PEC_ENABLE : 0);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int spd5118_temp_write(struct regmap *regmap, u32 attr, long val)
 {
 	switch (attr) {
@@ -238,6 +253,8 @@ static int spd5118_write(struct device *dev, enum hwmon_sensor_types type,
 	struct regmap *regmap = dev_get_drvdata(dev);
 
 	switch (type) {
+	case hwmon_chip:
+		return spd5118_chip_write(regmap, attr, val);
 	case hwmon_temp:
 		return spd5118_temp_write(regmap, attr, val);
 	default:
@@ -338,7 +355,7 @@ static int spd5118_detect(struct i2c_client *client, struct i2c_board_info *info
 
 static const struct hwmon_channel_info *spd5118_info[] = {
 	HWMON_CHANNEL_INFO(chip,
-			   HWMON_C_REGISTER_TZ),
+			   HWMON_C_REGISTER_TZ | HWMON_C_PEC),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT |
 			   HWMON_T_LCRIT | HWMON_T_LCRIT_ALARM |
-- 
2.39.2


