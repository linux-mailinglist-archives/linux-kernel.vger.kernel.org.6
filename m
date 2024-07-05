Return-Path: <linux-kernel+bounces-242916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFDF928ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2EDB22588
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051AA15D5C1;
	Fri,  5 Jul 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFkntxOv"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8F13B783;
	Fri,  5 Jul 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215356; cv=none; b=crBBbydt+3S28u0UfGJiftEjuoS3Wl+v8wTawr7wGPxfMGG/PQR/Ytuo2oOW8o7SpJicNUN7+0XkDwCesPavpSpyNV6EE7FFd/8BI/XUpEpv7MOTicIHxmRRPnDOvvY6eWzaDSFb7icGLoi24Yj61kFQsNWLjTee57rY6RwREDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215356; c=relaxed/simple;
	bh=nMmGCkFkawD3qpcgT+kAZqHgBnG04XtKQCOIPlWxfJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojBf0wy3VjfHuDw0e8lS3m68QyETAtWy9I7yLYxONgtPIcOSsHs4WfjBtuCYH+K9WJ5S0FoAbE+wL/MjaZg3B0Z7v5mzMPpaWc0N4o3yGP71jr5kPqGZcVGqkYfcxEZnAV+zqWEfYLBRfGPyrnuQ/DsiYMTGaoYY03Ys9idbcXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFkntxOv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-75a6c290528so1248045a12.1;
        Fri, 05 Jul 2024 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215353; x=1720820153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhGA4b3HBsESI2DmdUEadllBxv4uzhGArQdW7Mp+9Hc=;
        b=CFkntxOvZ7vvDriYZRR/zhK4Wicj+IBnaA+z6G2IEwfqSgHBKtYvUeJ5giqS6dRIHe
         B0gihYVHh4MVrMDyEM+rSzf3vxAjSCAIOT1OP+R87Nff8pKBuU6X5uNVs7F5WnzIUTf5
         KJXmCO7BgOJQSjuBZ4iNnoBVSBi9BrlyRhz4h4M2AfJQPrzIPPUrKwXxUd6UCSuPh6rQ
         lQxEAkWd5AMbq6f7e5gREtl4wMeFjHxwPj3rpkI27L4R13Ge5RpTcxsTO7IoJwK41ctR
         qlceKTMrWSIMzu4xMDoch45+2RZ1LQ/GJGniUKdqXzuJjd4LecrklVggj7fqQ0Fe91Fq
         1Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215353; x=1720820153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xhGA4b3HBsESI2DmdUEadllBxv4uzhGArQdW7Mp+9Hc=;
        b=q+IEni8RIiyQqdyblF4XCMRiqJZ0V0pXprGVcNz9pM/wfCO6YUXmnoSBMrBjina/hG
         H7PNmc7qB/b6UmXyJCqa1ZaQNv8tcPsCS+fn43dfQ4BnvpyJyenQrsW5YjNS9zIPWhr6
         4LUd9v3K40tRZEwyUjdRWTyBVVU1BKfbOQr0v8/ii8/76CmtVD5+N+tEaO33DHJc69By
         9oJq0b3rUbWwymkkXDfgBKV6Kw4YSt9JROl96zoYLU5z7Rrzk0mPyJ43gNZqU8HGVnoh
         vKYbdu/WZqWMeOqQgkTAoJR7EDhzyq4RqX8zI4PtqMNd5Bxkbu/kmfh6JS79SsanWynj
         q4MQ==
X-Gm-Message-State: AOJu0Yxq0e/iWGp+MEjfmGb1/T7i8IZGZYs71zhoi1/R1oECmtyKbeA9
	YrzVECJsbbtWqLh60UF7AGSaYzo0wB7hYY3vG/urDbbL1/2CB8o4S0Fcfw==
X-Google-Smtp-Source: AGHT+IEcgAmqlqEFwCNAN9kXhM5qUyNO0DhBNWHwsOQv4Ads/EZNgfOAfQKl7uN9RbM4WjXv4ie5IQ==
X-Received: by 2002:a05:6a21:2c15:b0:1bd:2214:e92f with SMTP id adf61e73a8af0-1c0cc746bffmr5289362637.14.1720215353275;
        Fri, 05 Jul 2024 14:35:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3827724a91.19.2024.07.05.14.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:35:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 01/11] hwmon: (amc6821) Stop accepting invalid pwm values
Date: Fri,  5 Jul 2024 14:35:37 -0700
Message-Id: <20240705213547.1155690-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705213547.1155690-1-linux@roeck-us.net>
References: <20240705213547.1155690-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pwm value range is well defined from 0..255. Don't accept any values
outside this range.

This changes the valid range of pwm1_auto_point2_pwm from 0..254 to 0..255,
meaning it can now be equivalent to not only pwm1_auto_point1_pwm (which is
always 0) but also to pwm1_auto_point3_pwm (which is always 255). While
that may not be practical, there seems to be no technical reason for
preventing a user from doing it.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: No change

v3: Change valid range of  pwm1_auto_point2_pwm from [0..254] to
    [0, 255]
    Add Quentin's Reviewed-by: tag

v2: Use kstrtou8() instead of kstrtol() where possible.
    Limit range of pwm1_auto_point_pwm to 0..254 in patch 1
    instead of limiting it later, and do not accept invalid
    values for the attribute.

 drivers/hwmon/amc6821.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 9b02b304c2f5..dc35e9b21f91 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -355,13 +355,13 @@ static ssize_t pwm1_store(struct device *dev,
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
-	long val;
-	int ret = kstrtol(buf, 10, &val);
+	u8 val;
+	int ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->pwm1 = clamp_val(val , 0, 255);
+	data->pwm1 = val;
 	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -558,13 +558,15 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int dpwm;
-	long val;
-	int ret = kstrtol(buf, 10, &val);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		return ret;
 
 	mutex_lock(&data->update_lock);
-	data->pwm1_auto_point_pwm[1] = clamp_val(val, 0, 254);
+	data->pwm1_auto_point_pwm[1] = val;
 	if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
 			data->pwm1_auto_point_pwm[1])) {
 		dev_err(&client->dev, "Register write error, aborting.\n");
-- 
2.39.2


