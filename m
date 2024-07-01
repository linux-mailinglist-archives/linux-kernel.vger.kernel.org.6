Return-Path: <linux-kernel+bounces-237039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9891EA31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8285B21A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1A17107F;
	Mon,  1 Jul 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoWR6OSM"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137B171670;
	Mon,  1 Jul 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869036; cv=none; b=Urs5ofjO5zSiafzRRZXiztqG2jSH0VlwYZseJ28UPs1+n5HxEnIaAHNQey4/FeHZqaNNJY8Ar5Oj4KN+VTVtSyHndnlScXTPKx1493l0mi/Hsn7/KTWOtJLRFrAODtYdjmIscQg6X/9e6tuuqtb4N9ncFODUY6OQsur2C/Ziuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869036; c=relaxed/simple;
	bh=ehlx/cZHs4t9IhkDGvLqftJNB8rDqbZBSV12nsZHxMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDjlHiL9QVEYiLvOeDyl1fFItDwwtk7MTh2miqshONXO+ul9zuh836kL+ajH8xlnMuMuJZPW6/mBZk5GkA/PFf8vh2ChWlw8e9v3+b6lHNo609il58v4msB/dThiXPM1+RhS/EpUYXVAZcSYdGiNLi3IcPcK88hDfqI3atisgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoWR6OSM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-701b0b0be38so2840413b3a.0;
        Mon, 01 Jul 2024 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869034; x=1720473834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkigCce3AAryLns4lvvimzCkFqi+WzN5f1sxehWDswI=;
        b=VoWR6OSMr2afAoeuZvpzEECkM+cJI42HeR6bFUfcPenp7rgvX9I/pdJuvw/9C4tysH
         Z/NlA/nZzMEPsiYwh791BZv7CCjBavzW9q3acxc6APkx28+he5FmCfPr3BHNX2vtFtoh
         XTRk12sokfbdaAURC5ItxNnDgpHXzGigfRZVUwRF8KCUydLlQDYouVfnhh5uEuMs/tnY
         +SRCupk225/mjl3ohV1xzwqIQOs4h7SNvH3rO0d6iU43aGKRl7mIfarmUp6GSTSzkU3p
         7XiUdwFjCQc+b6TSID6RTud6fUk9EkdciNx3DMf4Htd5rwA4kzhOOuIEqGn6xMrwTBUV
         S2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869034; x=1720473834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkigCce3AAryLns4lvvimzCkFqi+WzN5f1sxehWDswI=;
        b=chdDUSuUHAnj/SOk8VzZKnevb7SAfY0c6OnpGVy6g6qtwyEd7yW/Q9rL4a/LZ4HALV
         w5YAlFF6UShEGYGYvpeRQEQqCB3w0iiuU5qYjfgsiO8xL7YMKZNTNkAKDxOCbsTo5iOb
         zl878PeYt2q6t762l7FVvIrxfAVQoJxMyAYFArjcDEQK7OADm89bjEfvMoID+j0ywMJM
         Tn8mthjobXvrldDrDtGQHiLr3o9YSEPHqN48nLftDcafKbBgVqTniJ/X8u9QFcppybuD
         lFeDh8e3QdE/E39ZG8gygEqsVK0NEIO4+rR0XI2c6brC+R3aB8/0kQ/LBKkJhEqyR30k
         BMIg==
X-Gm-Message-State: AOJu0Yy6RZurAlbT7MBZSnNOffEzeqo2GOGrECGtcsPTrBaKPI7lOphX
	lp53T15xjDBQilk4XO0xoe/u6nmKW2zzWzoamKkqgbC+e+C4islI0o6b9Q==
X-Google-Smtp-Source: AGHT+IHYBIqjXnL3dv5bJjy8amNn6eCgXMt9GWN9UcOZxbPLmLAdF0Sr+UTHzNEmWwdC1uzKGRDcMg==
X-Received: by 2002:a05:6a20:3949:b0:1be:c967:311d with SMTP id adf61e73a8af0-1bef613f997mr11628600637.35.1719869034095;
        Mon, 01 Jul 2024 14:23:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205ebbcsm7000549b3a.40.2024.07.01.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 02/11] hwmon: (amc6821) Make reading and writing fan speed limits consistent
Date: Mon,  1 Jul 2024 14:23:39 -0700
Message-Id: <20240701212348.1670617-3-linux@roeck-us.net>
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

The default value of the maximum fan speed limit register is 0,
essentially translating to an unlimited fan speed. When reading
the limit, a value of 0 is reported in this case. However, writing
a value of 0 results in writing a value of 0xffff into the register,
which is inconsistent.

To solve the problem, permit writing a limit of 0 for the maximim fan
speed, effectively translating to "no limit". Write 0 into the register
if a limit value of 0 is written. Otherwise limit the range to
<1..6000000> and write 1..0xffff into the register. This ensures that
reading and writing from and to a limit register return the same value
while at the same time not changing reported values when reading the
speed or limits.

While at it, restrict fan limit writes to non-negative numbers; writing
a negative limit does not make sense and should be reported instead of
being corrected.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Do not accept negative fan speed values
    Display fan speed and speed limit as 0 if register value is 0
    (instead of 6000000), as in original code.
    Only permit writing 0 (unlimited) for the maximum fan speed.

 drivers/hwmon/amc6821.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index eb2d5592a41a..9c19d4d278ec 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -617,15 +617,20 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
-	long val;
+	unsigned long val;
 	int ix = to_sensor_dev_attr(attr)->index;
-	int ret = kstrtol(buf, 10, &val);
+	int ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
-	val = 1 > val ? 0xFFFF : 6000000/val;
+
+	/* The minimum fan speed must not be unlimited (0) */
+	if (ix == IDX_FAN1_MIN && !val)
+		return -EINVAL;
+
+	val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
 
 	mutex_lock(&data->update_lock);
-	data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
+	data->fan[ix] = clamp_val(val, 0, 0xFFFF);
 	if (i2c_smbus_write_byte_data(client, fan_reg_low[ix],
 			data->fan[ix] & 0xFF)) {
 		dev_err(&client->dev, "Register write error, aborting.\n");
-- 
2.39.2


