Return-Path: <linux-kernel+bounces-197447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0A8D6AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD71F1F26292
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E817F4EB;
	Fri, 31 May 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl+LqKy7"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC517D8AE;
	Fri, 31 May 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187635; cv=none; b=LzCbZ26qAMGLLX/Ts39Z5lQA4Ld7pxkPn+oAJ7nlTgrQcx6a2mM7gFAgsITsUrjwFQbd7l2ACucxYHMSEUejnxe0ghKdgyfhiUjuW8o4WsQHoNg+OPsXL0ya2DknlmlSk+AGeXGcm6cGbt9aoF9J+QSnBVCXXqPOAwZL0527Cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187635; c=relaxed/simple;
	bh=8H8iBgbnUJm2MptHOfBNeK/vM1c4z/PIxkyGyD1N3CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZtXgp2xxUzUq5G4TCtKVKjXsvdJ0/aT2bWMQS7HLlkObrJE5Ren47vZW3fwmzujq7dznURKQKhOgQXuOlcPFXVwq6nAig+TGc/DTWMnOkg3nmGpXCdqup4pHZdkuy3BRk3+swT/9vZ+eRjjwnAYujF/bpXFKfiYmcKU6gsjoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl+LqKy7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-701b0b0be38so2339851b3a.0;
        Fri, 31 May 2024 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717187633; x=1717792433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5Grp2Xo+fRfhlHYw5Ol3vAKXKQ8LaGg1PnXTB0LzEw=;
        b=nl+LqKy7Nav1fXUH8Vf6hdykj99uzCwFt/1WbnF6PSvXivXKzpXswpXiQG4oqmLD6G
         JpeVPQJNzUnWqAd7inpTG3E6cvDgskV3kxISEbOdfrfkw+RgIYJr+bs4mtiakY6oGGoK
         kB1+fd91x9qUxW15kJnUgCqGRPR9UkTH69eWWAcI5xrP6/1j4gvh4fxvuAmhgw0EMJ9R
         uz+FLeDR5ec1OWQ1XS+C2dXhKUFB/YjEEaH4cVjBZIGAIaefZE4h9kWaup8W/F5WSGMd
         3wy6QBAvx1N1vYmnX7nbImqR79IIc1StNo5ZFKOC6Jo509QVZUy8PdTHuQcC7lNdF9yF
         4Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187633; x=1717792433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5Grp2Xo+fRfhlHYw5Ol3vAKXKQ8LaGg1PnXTB0LzEw=;
        b=TkW7FQNJt1ZYg1Pxwr5V5LAdBOJOWRvUhfSzaDEoKehUASUMynJcPYBt9lhnwpJNrz
         wlhGFkF8mooCe0isD+ejRU7tfWHo9cQYPUKfiTQmPLlpcAatXY3MC9RuNQXMcP15/qMu
         vkSCd5q509h2LXnMWrFdVY6t6XEW9Wqx12Yq9PugscvA2yHO0mL95wvSbRawYloW+rGE
         kCeSwdemxowJD1OBwF46AWxtr3aC1p2BFqMEhMmKjHVbxpYrepU2svb5UYDAshY1+wO9
         zHFH6Nntsq7oMEGEIHEOlDNWfGXTQx2CznGNe4QLe993Qh6bVsXvMK8oSYnw5yD+rhEK
         jxpQ==
X-Gm-Message-State: AOJu0YzFpgqwYlx0dgPA9vovLdts1ba7YnDrb5w7DjI3GEkdWdpoqdHg
	KoDBgCI7X7kEY0nyUFxu51AQOpe44MhOHDfs6eg9vyxkWcGs6eAcpC95JA==
X-Google-Smtp-Source: AGHT+IGrNIEyUpxhfZzem4pYK42rYSSakn8fKKAaAe0SMU5rfYiiU6lN84VfruVqhz5yPxxv+kd3vQ==
X-Received: by 2002:a05:6a21:8190:b0:1b0:66d:1596 with SMTP id adf61e73a8af0-1b26f30daa7mr2624145637.57.1717187632960;
        Fri, 31 May 2024 13:33:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423dbf54sm1773811b3a.57.2024.05.31.13.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:33:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/2] hwmon: (lm90) Convert to use PEC support from hwmon core
Date: Fri, 31 May 2024 13:33:46 -0700
Message-Id: <20240531203346.1396055-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531203346.1396055-1-linux@roeck-us.net>
References: <20240531203346.1396055-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace driver specific PEC handling code with hardware monitoring core
functionality.

Cc: Radu Sabau <radu.sabau@analog.com>
Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Nuno's Acked-by: tag
 drivers/hwmon/lm90.c | 56 ++------------------------------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index e0d7454a301c..40d9e21b528c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1270,42 +1270,6 @@ static int lm90_update_device(struct device *dev)
 	return 0;
 }
 
-/* pec used for devices with PEC support */
-static ssize_t pec_show(struct device *dev, struct device_attribute *dummy,
-			char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	return sprintf(buf, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
-}
-
-static ssize_t pec_store(struct device *dev, struct device_attribute *dummy,
-			 const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err < 0)
-		return err;
-
-	switch (val) {
-	case 0:
-		client->flags &= ~I2C_CLIENT_PEC;
-		break;
-	case 1:
-		client->flags |= I2C_CLIENT_PEC;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(pec);
-
 static int lm90_temp_get_resolution(struct lm90_data *data, int index)
 {
 	switch (index) {
@@ -2659,11 +2623,6 @@ static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
-static void lm90_remove_pec(void *dev)
-{
-	device_remove_file(dev, &dev_attr_pec);
-}
-
 static int lm90_probe_channel_from_dt(struct i2c_client *client,
 				      struct device_node *child,
 				      struct lm90_data *data)
@@ -2802,6 +2761,8 @@ static int lm90_probe(struct i2c_client *client)
 		data->chip_config[0] |= HWMON_C_UPDATE_INTERVAL;
 	if (data->flags & LM90_HAVE_FAULTQUEUE)
 		data->chip_config[0] |= HWMON_C_TEMP_SAMPLES;
+	if (data->flags & (LM90_HAVE_PEC | LM90_HAVE_PARTIAL_PEC))
+		data->chip_config[0] |= HWMON_C_PEC;
 	data->info[1] = &data->temp_info;
 
 	info = &data->temp_info;
@@ -2878,19 +2839,6 @@ static int lm90_probe(struct i2c_client *client)
 		return err;
 	}
 
-	/*
-	 * The 'pec' attribute is attached to the i2c device and thus created
-	 * separately.
-	 */
-	if (data->flags & (LM90_HAVE_PEC | LM90_HAVE_PARTIAL_PEC)) {
-		err = device_create_file(dev, &dev_attr_pec);
-		if (err)
-			return err;
-		err = devm_add_action_or_reset(dev, lm90_remove_pec, dev);
-		if (err)
-			return err;
-	}
-
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data, &data->chip,
 							 NULL);
-- 
2.39.2


