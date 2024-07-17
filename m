Return-Path: <linux-kernel+bounces-254810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38505933800
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D71C225E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393A14F6C;
	Wed, 17 Jul 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fi3UzSJc"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3E4C8D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201464; cv=none; b=o40Mnz3/04kLXBRmHEf4p1y+gGnldnKzCKf7UPNOpE9wxUpv+hJByNs0IHIBPq5fya0G8HRadduNNaZ3ALKMvNH5ZTMn73l3MbNkqE3DhXTchn6F0YHpQVK0ih8uR+aB3IL0aFcyMKZBdeXfoW0hA3tmV67tB0Z7nLZ2h549QOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201464; c=relaxed/simple;
	bh=2AWDJ29/eZpQrMGz6us27l4ySjmwawxPrVQH8M1RMmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tS7ZQ18m0PmRZCTpTaY7bAuVLrBZ7gytUiFTXGd9yih6zI7IO1F8ciIpeI/z0haQcdJJ9XTjpJ5nEn7jhErTl/lRum5kF4wKJLbskHD1DSET8ZGdzRzqije2CxQEZmK4/rH3KtO0BNNMRvsdRypM7gq6jBwH7TgJqfvzeU7a578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fi3UzSJc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e96d4986bso6738397e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1721201460; x=1721806260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjY2uYBPwkskN4yFFi5h7tCJfakT+MBEBO8/3c4UXEs=;
        b=fi3UzSJcl3c2mTwR1d8Rs98MVUp6ax8zqKQVbD9ncrsVb0YwjfwtkisJcy/VkthA38
         KY54IzGmgVy66wV+/QNybgoo0yaivcPjuuMz2FMi4vQaJKcYzLfT6Y8MkM26X2Za5Fl4
         Uw1/qUn4avOQcS3uDw5opmyS8uebL0D9Hd2kD7PLTKj3mimG6CIRAk+BKrIE7UUahStw
         VGyeLJ9wx7Hsl1ekg+1OabNmnWKzBU4j53eLDnVRtwU6EMKCpupNqZTi/JVQBA0P/6Ak
         ZLruXn9/fWsFlDXlVEF1DDJeuUBh6S3dDA3BkySgfa9J61OXmuJrtYNV1+m8mRi7HSdg
         E8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201460; x=1721806260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjY2uYBPwkskN4yFFi5h7tCJfakT+MBEBO8/3c4UXEs=;
        b=wyxBs5nnjxNTnaiU4HVLgynaATlo0Xmd5OP0Pf5cdfW2z6M1WXxdsOe6oVRziwfD83
         WgGg9YhdLghE7m20oWiRu318cOBs+j24SmimMh2bjdDcJqP9yXB5eF10WNHdwYM4Gfud
         4eTIhF+DtudT8mOtN/v9Bjx3qQ27kMbl2e/FuJGdXH2Fgo/5XkzprV3e/vt6P+X/IL85
         SBLm5NSV9vLAmryeo+jD3LdG76Fmpqvqh/Cvr1XIoGaVHm4+yjBqlZ11i4pX4/JnVxqg
         hZsy1/7Jpez/fWDbGzPzzHNgBXa6mzR+5d+rSJtqAX8SNIdAhL8nTm1q3ElsUji+XDht
         fsLA==
X-Gm-Message-State: AOJu0Yzx+stNvAStW7qAhKoUq58eJtf8TOem1mzDuxqtXsmGOmLghOnQ
	JloVfPIQfGI2DHGG7VI5A8AaCxeoQ2eVKxamlrnRa9utbGKQOHNFUv7iifr7NOQO6RpoaXNTiIx
	X
X-Google-Smtp-Source: AGHT+IHeWtuGurVPdRGB70Fs9fzMflS8oagvjjxtdPigXpGltmnMTFk5PIPxKdHX/IEiLs1pWrYupg==
X-Received: by 2002:a05:6512:32c5:b0:52e:9acf:b698 with SMTP id 2adb3069b0e04-52ee53f7c0emr569256e87.36.1721201459793;
        Wed, 17 Jul 2024 00:30:59 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59edba561e0sm2766841a12.50.2024.07.17.00.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:30:59 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 1/5] hwmon: pmbus: Implement generic bus access delay
Date: Wed, 17 Jul 2024 09:29:52 +0200
Message-ID: <20240717073000.786228-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers, like the max15301 or zl6100, are intentionally delaying
SMBus communications, to prevent transmission errors. As this is necessary
on additional PMBus compatible devices, implement a generic delay mechanism
in the pmbus core.

Introduces two delay settings in the pmbus_driver_info struct, one applies
to every SMBus transaction and the other is for write transaction only.
Once set by the driver the SMBus traffic, using the generic pmbus access
helpers, is automatically delayed when necessary.

The two settings are:
access_delay:
  - Unit in microseconds
  - Stores the accessed timestamp after every SMBus access
  - Delays when necessary before the next SMBus access

write_delay:
  - Unit in microseconds
  - Stores the written timestamp after a write SMBus access
  - Delays when necessary before the next SMBus access

This allows to drop the custom delay code from the drivers and easily
introduce this feature in additional pmbus drivers.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h      | 10 ++++
 drivers/hwmon/pmbus/pmbus_core.c | 92 +++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index fb442fae7b3e..5d5dc774187b 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -466,6 +466,16 @@ struct pmbus_driver_info {
 
 	/* custom attributes */
 	const struct attribute_group **groups;
+
+	/*
+	 * Some chips need a little delay between SMBus communication. When
+	 * set, the generic PMBus helper functions will wait if necessary
+	 * to meet this requirement. The access delay is honored after
+	 * every SMBus operation. The write delay is only honored after
+	 * SMBus write operations.
+	 */
+	int access_delay;		/* in microseconds */
+	int write_delay;		/* in microseconds */
 };
 
 /* Regulator ops */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb4c65a7f288..0ea6fe7eb17c 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -108,6 +109,8 @@ struct pmbus_data {
 
 	int vout_low[PMBUS_PAGES];	/* voltage low margin */
 	int vout_high[PMBUS_PAGES];	/* voltage high margin */
+	ktime_t write_time;		/* Last SMBUS write timestamp */
+	ktime_t access_time;		/* Last SMBUS access timestamp */
 };
 
 struct pmbus_debugfs_entry {
@@ -158,6 +161,39 @@ void pmbus_set_update(struct i2c_client *client, u8 reg, bool update)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_set_update, PMBUS);
 
+/* Some chips need a delay between accesses. */
+static void pmbus_wait(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+	s64 delta;
+
+	if (info->access_delay) {
+		delta = ktime_us_delta(ktime_get(), data->access_time);
+
+		if (delta < info->access_delay)
+			fsleep(info->access_delay - delta);
+	} else if (info->write_delay) {
+		delta = ktime_us_delta(ktime_get(), data->write_time);
+
+		if (delta < info->write_delay)
+			fsleep(info->write_delay - delta);
+	}
+}
+
+/* Sets the last accessed timestamp for pmbus_wait */
+static void pmbus_update_ts(struct i2c_client *client, bool write_op)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+
+	if (info->access_delay) {
+		data->access_time = ktime_get();
+	} else if (info->write_delay && write_op) {
+		data->write_time = ktime_get();
+	}
+}
+
 int pmbus_set_page(struct i2c_client *client, int page, int phase)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -168,11 +204,15 @@ int pmbus_set_page(struct i2c_client *client, int page, int phase)
 
 	if (!(data->info->func[page] & PMBUS_PAGE_VIRTUAL) &&
 	    data->info->pages > 1 && page != data->currpage) {
+		pmbus_wait(client);
 		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+		pmbus_update_ts(client, true);
 		if (rv < 0)
 			return rv;
 
+		pmbus_wait(client);
 		rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
+		pmbus_update_ts(client, false);
 		if (rv < 0)
 			return rv;
 
@@ -183,8 +223,10 @@ int pmbus_set_page(struct i2c_client *client, int page, int phase)
 
 	if (data->info->phases[page] && data->currphase != phase &&
 	    !(data->info->func[page] & PMBUS_PHASE_VIRTUAL)) {
+		pmbus_wait(client);
 		rv = i2c_smbus_write_byte_data(client, PMBUS_PHASE,
 					       phase);
+		pmbus_update_ts(client, true);
 		if (rv)
 			return rv;
 	}
@@ -202,7 +244,11 @@ int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_write_byte(client, value);
+	pmbus_wait(client);
+	rv = i2c_smbus_write_byte(client, value);
+	pmbus_update_ts(client, true);
+
+	return rv;
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_write_byte, PMBUS);
 
@@ -233,7 +279,11 @@ int pmbus_write_word_data(struct i2c_client *client, int page, u8 reg,
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_write_word_data(client, reg, word);
+	pmbus_wait(client);
+	rv = i2c_smbus_write_word_data(client, reg, word);
+	pmbus_update_ts(client, true);
+
+	return rv;
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_write_word_data, PMBUS);
 
@@ -351,7 +401,11 @@ int pmbus_read_word_data(struct i2c_client *client, int page, int phase, u8 reg)
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_read_word_data(client, reg);
+	pmbus_wait(client);
+	rv = i2c_smbus_read_word_data(client, reg);
+	pmbus_update_ts(client, false);
+
+	return rv;
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_read_word_data, PMBUS);
 
@@ -410,7 +464,11 @@ int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg)
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_read_byte_data(client, reg);
+	pmbus_wait(client);
+	rv = i2c_smbus_read_byte_data(client, reg);
+	pmbus_update_ts(client, false);
+
+	return rv;
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_read_byte_data, PMBUS);
 
@@ -422,7 +480,11 @@ int pmbus_write_byte_data(struct i2c_client *client, int page, u8 reg, u8 value)
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_write_byte_data(client, reg, value);
+	pmbus_wait(client);
+	rv = i2c_smbus_write_byte_data(client, reg, value);
+	pmbus_update_ts(client, true);
+
+	return rv;
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_write_byte_data, PMBUS);
 
@@ -454,7 +516,11 @@ static int pmbus_read_block_data(struct i2c_client *client, int page, u8 reg,
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_read_block_data(client, reg, data_buf);
+	pmbus_wait(client);
+	rv = i2c_smbus_read_block_data(client, reg, data_buf);
+	pmbus_update_ts(client, false);
+
+	return rv;
 }
 
 static struct pmbus_sensor *pmbus_find_sensor(struct pmbus_data *data, int page,
@@ -2450,9 +2516,11 @@ static int pmbus_read_coefficients(struct i2c_client *client,
 	data.block[1] = attr->reg;
 	data.block[2] = 0x01;
 
+	pmbus_wait(client);
 	rv = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
 			    I2C_SMBUS_WRITE, PMBUS_COEFFICIENTS,
 			    I2C_SMBUS_BLOCK_PROC_CALL, &data);
+	pmbus_update_ts(client, true);
 
 	if (rv < 0)
 		return rv;
@@ -2604,7 +2672,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 
 	/* Enable PEC if the controller and bus supports it */
 	if (!(data->flags & PMBUS_NO_CAPABILITY)) {
+		pmbus_wait(client);
 		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+		pmbus_update_ts(client, false);
+
 		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
 			if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC))
 				client->flags |= I2C_CLIENT_PEC;
@@ -2617,10 +2688,16 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	 * Bail out if both registers are not supported.
 	 */
 	data->read_status = pmbus_read_status_word;
+	pmbus_wait(client);
 	ret = i2c_smbus_read_word_data(client, PMBUS_STATUS_WORD);
+	pmbus_update_ts(client, false);
+
 	if (ret < 0 || ret == 0xffff) {
 		data->read_status = pmbus_read_status_byte;
+		pmbus_wait(client);
 		ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
+		pmbus_update_ts(client, false);
+
 		if (ret < 0 || ret == 0xff) {
 			dev_err(dev, "PMBus status register not found\n");
 			return -ENODEV;
@@ -2635,7 +2712,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	 * limit registers need to be disabled.
 	 */
 	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
+		pmbus_wait(client);
 		ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
+		pmbus_update_ts(client, false);
+
 		if (ret > 0 && (ret & PB_WP_ANY))
 			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
 	}
-- 
2.45.2


