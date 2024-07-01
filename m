Return-Path: <linux-kernel+bounces-237038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877D91EA2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0FD1F21BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AF171E47;
	Mon,  1 Jul 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A42fuPkY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC7170849;
	Mon,  1 Jul 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869035; cv=none; b=CRYbLv5X2RJ/vg9gNaf+ZHF7kovwNt8Pj0KaHG6blBclUjdNzGaOQ3qgWj4gy6Mk2Y41ZBfZv8cZbgU/RR5qo3tKs7UcbU9BnBHUwTKV8hoG2NseFtKXqHDIr7v/p/W+CIG7przd593JXoFdLUNH9UD5+CB7GxKRxXR/5YcNCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869035; c=relaxed/simple;
	bh=8cLePAE2uXB/cHC4f7PJI5dtXvetRldVhV9xDT+3JOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzMAdgdBtWp7nYKxh2PAgBnM0PRAghHlziF5DbHtGDywoUCl3X7WJU1Y38W5YfAJ4SwJl6PgK/1xy7nfn58lSNEsMdrRcS84A9VnxabNZ+xRC5ObuRGWCO/pSCFNuuLdliS3SIh7OiucX6l6FaaauBaBXTN/8MUYUlYAoUKrnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A42fuPkY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d0dso27124755ad.1;
        Mon, 01 Jul 2024 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869032; x=1720473832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+f1iaiYwmxi54lhj1FA2zbbeJVXd7etxzvGD4MuT3w=;
        b=A42fuPkYd0aNEkREBHPROrXEF4mfoJ1busbdf5FkJCy0j8FMMCm1QmGUHytxuNdzNu
         gKGE496tfJ3kcvU5HxQm/wFJGpvPiRP8egbS/S7lwrVXU9D7jb8yyTS/4MAimALCCtcf
         tox2m3f5TFZtXnRzLeAGm/KhRZgHI4KdNM1omIm2WYkAU1L6CZfk4BMTxSl+wx1aQETf
         md/47CWyl9GySwzXYD5BTwzBMkF+yrGzJ4N6H1xrNpSzsiqYwTWJ1brOxoDLwDvksLib
         /px4KCJ9a+Fmwp2ZkV5Ak89rpbcNXVREbcvMT/kBVOdAlE3Bi28UEsyH5Ou6yi+eVOoc
         nqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869032; x=1720473832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+f1iaiYwmxi54lhj1FA2zbbeJVXd7etxzvGD4MuT3w=;
        b=QUfCHapWhPquo+2ynVFWPN+xwinfDOTbKd62B6LVlRDu3Z7IXuNCfi3JWnhCnspZag
         m3WRzY4z8dTPFzVKq76nUIzCVP3X4lOzujzHXPwM7p1Lmebcnyn3axt6F7ryWjGAd9nR
         4pAKcUHZiVt+xI5kCACr9RAcdaEi8r60bYN989TCQEqxDZcA1SFojVdhwPm/oNkNCS0P
         SgJrbPYa5K3TYjoxXR4QaOF5EgKvzPRDbwnkDqJNu92tVN3AtF4CEMBv9OaP6ji8uu0q
         7XC2M4btMrzBtukz6l0vUJQIrPb+EvsBB/FZieh4jpr4QzWStuPQ9vl1gTkqh+0tb26v
         S99Q==
X-Gm-Message-State: AOJu0Yyc/NgBzAuR+H/POw9yF8MI4PMxWH6kthT7zYBIujzrP7ANJmVr
	72ts3tYq8VmoMBzEkrpubsaIdvWHDFHwAy4NcgaUaIOMvw1OlZV/nymNnA==
X-Google-Smtp-Source: AGHT+IEu0YcxUZlhoscn58T1HiwaaKjZJtQ2BONoFMxA2Tbq/IKDvcenNc5OCWGA48NbbwOEtE6IPg==
X-Received: by 2002:a17:902:ecc4:b0:1fa:a34e:8806 with SMTP id d9443c01a7336-1fadbca5ba7mr75660805ad.39.1719869032227;
        Mon, 01 Jul 2024 14:23:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1577sm69681445ad.56.2024.07.01.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 01/11] hwmon: (amc6821) Stop accepting invalid pwm values
Date: Mon,  1 Jul 2024 14:23:38 -0700
Message-Id: <20240701212348.1670617-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701212348.1670617-1-linux@roeck-us.net>
References: <20240701212348.1670617-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pwm value range is well defined from 0..255. Don't accept
any values outside this range.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use kstrtou8() instead of kstrtol() where possible.
    Limit range of pwm1_auto_point_pwm to 0..254 in patch 1
    instead of limiting it later, and do not accept invalid
    values for the attribute.

 drivers/hwmon/amc6821.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 9b02b304c2f5..eb2d5592a41a 100644
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
@@ -558,13 +558,16 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int dpwm;
-	long val;
-	int ret = kstrtol(buf, 10, &val);
+	u8 val;
+	int ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		return ret;
 
+	if (val > 254)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
-	data->pwm1_auto_point_pwm[1] = clamp_val(val, 0, 254);
+	data->pwm1_auto_point_pwm[1] = val;
 	if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
 			data->pwm1_auto_point_pwm[1])) {
 		dev_err(&client->dev, "Register write error, aborting.\n");
-- 
2.39.2


