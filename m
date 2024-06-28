Return-Path: <linux-kernel+bounces-234098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1AC91C237
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EB5B22AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98511C6899;
	Fri, 28 Jun 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWVZF2Nq"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4A1C232B;
	Fri, 28 Jun 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587637; cv=none; b=ARKDAM1sYEd1w3Z4Yu4BOZK6pU12c/RYydkLpM8KN2r3xncWC8GgMZeEz57z46iRBsBs3COreYBBX0AN8p3+AVpvNKZAfezVb+B6WBZptk8RD4Won7TBHFDgWslQajOSNNi+DJQSHRpAwTMVkzkM+CVdawSkHxJCFh1yMK5qd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587637; c=relaxed/simple;
	bh=3hujbniO9E+7eki3q2BbKuhFLjYti8XPiyEFCjHGHDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmPHB2pKQFhW4DiWtaZlh294EsOpe5nagZue6rwn5Ywv0UcfaFfmAlsOw/h+ij8SJQUnZzfKM+nFh2GN0PZ1ndWDJOm2h2WAhEKs6N2EGdF6HEIqFEGyT1sNBbyh6BqrZO98xNIVVm2Nb8OSjDQZAI183EO72hfYcxQvByGXcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWVZF2Nq; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25d584e9fe6so410628fac.1;
        Fri, 28 Jun 2024 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587634; x=1720192434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxplXSHYof55UO1G/jgJi+L4qN2gtkU5KLIacw8Hjj0=;
        b=PWVZF2Nqut7H3yTgozFPqjXj+M2+RhiMKCRC3P/AHmb6B6umLd5wMbqpX5gFYe3Y1P
         zLEKLDlgBBLSTTA41a/5tpZ6GQFS3VhJP2lNoxvOIcF3gFRHpIKUeb9sP7tWAm6gxymb
         YFi/uxEfn1vRiEo3lLi9Jik6ZrbOEF7wjrxmKoLuppXvrN6cNJOOnMLnzbeAinS0bTN6
         C3WvIwrChA+JBMvJ8RhS+25Jo+3qgnuuyk4658ujYBcgzSiDzuGeWneGBn6B4EAaxhb3
         JAS+D7/oqhBFFa2fM1HA8dL75S69zisZqBGCcyioWwR42w1XKMFunbxggUpY6YzWH5OB
         ZDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587634; x=1720192434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oxplXSHYof55UO1G/jgJi+L4qN2gtkU5KLIacw8Hjj0=;
        b=xVAlkbpyzuWkIIaXYKYiUr1JW0BLjvq3RrOiHkxZAEWRzJ3NRgUH/BAhoX+AuKc56Z
         Rh3ghTaqSBYjdxRy5fYoX/bO0BFhzZHOeCTNtH7L3++2dUuYzzZ7OIZIIDd1iM/63d2m
         WQ+aKTjIoVciIpbgmnodWiv2QbSwrJ94StydIFJ+Jm1FmNQR65xFjqJMoZ1Oa4vlkw/F
         vLDprTcGnNNnqkMGZSy+N5jxszfDM26XcEY1IODCoYQxVcf1ThG430yxpM5e0UTULEyo
         p3lcOJT4o+EUmjYE5h7yjRH9qzEIwiQtlyhmxzlNO39sHdpZ57Jhiqj0HDvNAicMjZpF
         hOAA==
X-Gm-Message-State: AOJu0YxYoCJdG/eCIH4V+TsSuhOwC1bpgV1RRr5oQsMvFk+7zTI1ultJ
	6KoTSUpEYxno/6eZU6ii2J0LPBXErBtSruxSh2eDVc/Oouq0527KRkiVCg==
X-Google-Smtp-Source: AGHT+IG2OMomzezGRUbhXJ8XKQRxHM7sYn+iB6h+hM408aY2K+C2NCXzblw6WdDmmtXdpKIgQm07lQ==
X-Received: by 2002:a05:6871:3429:b0:254:a753:d1cc with SMTP id 586e51a60fabf-25d06b73676mr17322060fac.3.1719587634250;
        Fri, 28 Jun 2024 08:13:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246e1d9sm1720955b3a.71.2024.06.28.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:13:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/10] hwmon: (amc6821) Stop accepting invalid pwm values
Date: Fri, 28 Jun 2024 08:13:37 -0700
Message-Id: <20240628151346.1152838-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628151346.1152838-1-linux@roeck-us.net>
References: <20240628151346.1152838-1-linux@roeck-us.net>
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
 drivers/hwmon/amc6821.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 9b02b304c2f5..3c614a0bd192 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -360,8 +360,11 @@ static ssize_t pwm1_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
-	data->pwm1 = clamp_val(val , 0, 255);
+	data->pwm1 = val;
 	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -558,13 +561,16 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int dpwm;
-	long val;
-	int ret = kstrtol(buf, 10, &val);
+	unsigned long val;
+	int ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
 
+	if (val > 255)
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


