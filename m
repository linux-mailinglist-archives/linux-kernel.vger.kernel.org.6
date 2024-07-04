Return-Path: <linux-kernel+bounces-241560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2E927C8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5921F23E87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298F135A53;
	Thu,  4 Jul 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+xMLNSp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FC6DD0D;
	Thu,  4 Jul 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115536; cv=none; b=Cw9gydIBYlrArXgaJvh/jlXz+YJVyRXY8A5ueOb2qVO/Vzfd+uayJv7VsE1QBms0YhXXmHGK12u3IhZE29szIji8W0f8LS8McgJJ9NJqURq63cHfdr1VOaQHgmtuCsEqUkl8lTEfrPjGctssdAi+j0fGLvNRfNC5pWBLfftLU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115536; c=relaxed/simple;
	bh=EGRfO56RsRvvKsPD08qTMW/a5iWTPsoKBm78VPABofI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laocUkBgZt228Yc6nNXFvxkmFv9ztuYdJ8Qq3h7HT132tmDuqsGOijfiOqK9omjJztdx48gRkbEerhf2P/NlN48Xrh+rZl7H5eW3KHYtknFloxVXFeU164v5husMvJUhZMpeMJiXnrwrRzy72HOJpYq7Gx+B7uDpFBciWnVai+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+xMLNSp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso3380075ad.2;
        Thu, 04 Jul 2024 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115533; x=1720720333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ8o688nbt8MwKkBx4y/8xdDeF6ixL5Yy2GlEEEH3Xo=;
        b=M+xMLNSpbpArLC+/fNSjfQAqB9uQef/64JNOBbBQX1GSk3xg4W9WpmUcCs7iJuB10y
         sv/VKnuwM9q8ZtlEJSx91Xa7pDyyxI+/wfHLJCHFgFjUcQZh0sh0FLCk2FpgtLbP3JQu
         r7QOmpKpWaPDiwKByQ9UAh4+WugltrlI+isNNLbnmY7+Aorzj21d5Csa3/etvcjnbZIs
         yev9mGWFt7aDDLU/o8SBk4bmFW2Pszc5oubMChSNqWgrRMg3+yydVfHwekxCrrjWbnPq
         7wGkU29AVwE9yWhEpHKC/KuWz42lrCDzYZMaeGXagHkxXVFXmw8jT2dWEC3vzx6hYFAx
         z9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115533; x=1720720333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQ8o688nbt8MwKkBx4y/8xdDeF6ixL5Yy2GlEEEH3Xo=;
        b=PYl8Kyu2xmvyPpLgjwmO+ZTrjzm6EEaQFFmyOD9zkogdIIJOWPSrM5ojTI1OkDJRHx
         /Xu/lHr6OmSlwd348lAp14J0Qz0W5mqSnOeFIe89/7Kl3i1+6lF6sJ/Tqcxvj3SDpChu
         sa4Wu0CGc6NS21V2OZBkkwl7EbdDAY8P7bLDvIhIMFo0H8tfsdb3lwKtsng56UuHE4K/
         2YBeairDyRd68V9W1i6M+qUtx47XdeSOc3yrhD1bS40sIceK6UV9DPCCHn+MyxpWXHQ6
         e1KqfQtpDfqwgReFBrLGQGmYLPbOXpovInzf/DNwdSbdWSLwiENxvqPPCXvT0qWLpmsN
         uIdw==
X-Gm-Message-State: AOJu0YxwAxGzXrQp1gYdCvLi6p7uqxLW9pdm3PVfuvJRS6UNBHE0nVSZ
	iCW8fLj73reqtEaOsb9ZswCW3TKV2JgzcSmHYNB5UPE+Wss6sss3BOzhDg==
X-Google-Smtp-Source: AGHT+IEqQngq8ANTHVmCaBj0wds43ChLjLvZYYBk6PYaxdOjf75wEe1btfGZv+eWswHRzEtv09xtjA==
X-Received: by 2002:a17:902:ea02:b0:1fb:1e7c:eb35 with SMTP id d9443c01a7336-1fb33f0eaa6mr20825645ad.61.1720115533478;
        Thu, 04 Jul 2024 10:52:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1c63dbe8sm33499445ad.195.2024.07.04.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 01/11] hwmon: (amc6821) Stop accepting invalid pwm values
Date: Thu,  4 Jul 2024 10:51:57 -0700
Message-Id: <20240704175207.2684012-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704175207.2684012-1-linux@roeck-us.net>
References: <20240704175207.2684012-1-linux@roeck-us.net>
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


