Return-Path: <linux-kernel+bounces-254813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7D933806
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA01C226F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8812261D;
	Wed, 17 Jul 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="c91rt6ml"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6B1CA89
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201467; cv=none; b=NaGEYdmrtZmQ7xuP9kfUfPV5gfrKojo1WQgsMMEP7+dflkCcJU42DEbYqhzpA20YGj9iznZhlXJkPq7kf7x3Rb3UiNKoYPvVafASmXfXD7nsGlmYguW9xwLsP82iLDIZ3IvQbe0WnuLowlTY2f7wvkP66ttuPc48VvxwZ9VzkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201467; c=relaxed/simple;
	bh=C8wpQJj+q1S305oWmbdoLTm9u1iD+4DN701nV5At900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNAI8Rfjo1Oi66vuh8EHo/ShwH8nf2aoznfyJ7SWPq/phk6YTrHQ6B00oklDF2LzobcwJSLCgq1K+Glj01RtzIagjYnk9EuCjo60UOqKpxY/Fc6gY0m53U2gMfLv4pkH43cVGvLuD5Mrj/e8G+wss19PcP1LO91Bew7mv1lFcQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=c91rt6ml; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso8200410a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1721201464; x=1721806264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iBs9G5I72sNRbH81BzberuVmjgumv9UTMOK7dxzACo=;
        b=c91rt6mlQULpFp0k7xD053KGDwjcEMeTuu+0oUyolHnAotm5upUJD5bJQqXg20JxTy
         NpCMYuzOxJOzr8de1dJ8e2iHBcBbhVQHQOHEsRjSbgBXNbBdx0RbAyx37hIggz7gNfCm
         kdDSU49palCLR/R/wDlIConUt6gRCizxgo1SQobS9qHeNXqTZKjK2O1jJVtLnOMpk5h8
         +NpFiTNsyytfxJ5t69YgjDXdVpepIzPyEml0u3m4tUdF/vXaYiR9jnbZYhCk7CtRAbtp
         AxMm8p6KyP9RzdkPah8Xyqt5EskQoSZJOGztDKMkgIhtpwl7T5Bc444O0oOf3/RH/TC5
         jXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201464; x=1721806264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iBs9G5I72sNRbH81BzberuVmjgumv9UTMOK7dxzACo=;
        b=QcUkymxgY5kj8dEAiOzRkfj7BHZiy+cI8KXWx5oIFLuiZR0SbT6Xxumqj7cBMCFDhE
         59JZ/PobumGJYI+rSJhhXoIC0KiIbIWnxnG6oSJ96U6hsjBHc3ceiizqa53ssEn2jcL/
         uKOU667VRWeSO2gLyirB88OAP2oUFLtNUHJgTr0LCG2Zumfyeyy+0SZUqEg+9mdmvosR
         gftFw+2X8E7IzqJqJfBz86gr+WBODs7lvzmNF2uxyFP/FQ0YWecjZyU058pMt9Pa19Vk
         LSfCjLLPLCxBTVm0PsCUpixp5Si5VulWgF1sQgFkyN4FcrBG6c6l/ss6H777mHMEC+To
         FJbg==
X-Gm-Message-State: AOJu0YzNHirqF5iF9YgNx8SE0MiNOl0XsoOlCOV4Jt4+pLMUwH1CvdVw
	4pVzOVROXRkY5ddGowUN5kwlIUHN4l6Z7a1jDWRQvjBVZDVY9orsNXb61/COWFVO+LVD1z6iOaE
	g
X-Google-Smtp-Source: AGHT+IHLWD5CpIFO5o0hwJAI/o+B6rwJN5ayTpaT457fFXE5f6vy/ySpEwczOPkj9mEyD7LpgJDbUw==
X-Received: by 2002:a05:6402:5192:b0:57c:a422:677b with SMTP id 4fb4d7f45d1cf-5a05b22a32bmr895535a12.8.1721201463955;
        Wed, 17 Jul 2024 00:31:03 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59edba561e0sm2766841a12.50.2024.07.17.00.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:31:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 4/5] hwmon: pmbus: zl6100: Use generic code
Date: Wed, 17 Jul 2024 09:29:55 +0200
Message-ID: <20240717073000.786228-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717073000.786228-1-patrick.rudolph@9elements.com>
References: <20240717073000.786228-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use generic pmbus bus access delay.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/pmbus/zl6100.c | 66 +++++-------------------------------
 1 file changed, 8 insertions(+), 58 deletions(-)

diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 83458df0d0cf..7920a16203e1 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -22,8 +22,6 @@ enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105,
 
 struct zl6100_data {
 	int id;
-	ktime_t access;		/* chip access time */
-	int delay;		/* Delay between chip accesses in uS */
 	struct pmbus_driver_info info;
 };
 
@@ -122,16 +120,6 @@ static u16 zl6100_d2l(long val)
 	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
 }
 
-/* Some chips need a delay between accesses */
-static inline void zl6100_wait(const struct zl6100_data *data)
-{
-	if (data->delay) {
-		s64 delta = ktime_us_delta(ktime_get(), data->access);
-		if (delta < data->delay)
-			udelay(data->delay - delta);
-	}
-}
-
 static int zl6100_read_word_data(struct i2c_client *client, int page,
 				 int phase, int reg)
 {
@@ -174,9 +162,7 @@ static int zl6100_read_word_data(struct i2c_client *client, int page,
 		break;
 	}
 
-	zl6100_wait(data);
 	ret = pmbus_read_word_data(client, page, phase, vreg);
-	data->access = ktime_get();
 	if (ret < 0)
 		return ret;
 
@@ -195,14 +181,11 @@ static int zl6100_read_word_data(struct i2c_client *client, int page,
 static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct zl6100_data *data = to_zl6100_data(info);
 	int ret, status;
 
 	if (page >= info->pages)
 		return -ENXIO;
 
-	zl6100_wait(data);
-
 	switch (reg) {
 	case PMBUS_VIRT_STATUS_VMON:
 		ret = pmbus_read_byte_data(client, 0,
@@ -225,7 +208,6 @@ static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_byte_data(client, page, reg);
 		break;
 	}
-	data->access = ktime_get();
 
 	return ret;
 }
@@ -234,8 +216,7 @@ static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
 				  u16 word)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct zl6100_data *data = to_zl6100_data(info);
-	int ret, vreg;
+	int vreg;
 
 	if (page >= info->pages)
 		return -ENXIO;
@@ -265,27 +246,7 @@ static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
 		vreg = reg;
 	}
 
-	zl6100_wait(data);
-	ret = pmbus_write_word_data(client, page, vreg, word);
-	data->access = ktime_get();
-
-	return ret;
-}
-
-static int zl6100_write_byte(struct i2c_client *client, int page, u8 value)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct zl6100_data *data = to_zl6100_data(info);
-	int ret;
-
-	if (page >= info->pages)
-		return -ENXIO;
-
-	zl6100_wait(data);
-	ret = pmbus_write_byte(client, page, value);
-	data->access = ktime_get();
-
-	return ret;
+	return pmbus_write_word_data(client, page, vreg, word);
 }
 
 static const struct i2c_device_id zl6100_id[] = {
@@ -363,14 +324,7 @@ static int zl6100_probe(struct i2c_client *client)
 	 * supported chips are known to require a wait time between I2C
 	 * accesses.
 	 */
-	data->delay = delay;
-
-	/*
-	 * Since there was a direct I2C device access above, wait before
-	 * accessing the chip again.
-	 */
-	data->access = ktime_get();
-	zl6100_wait(data);
+	udelay(delay);
 
 	info = &data->info;
 
@@ -404,8 +358,7 @@ static int zl6100_probe(struct i2c_client *client)
 		if (ret < 0)
 			return ret;
 
-		data->access = ktime_get();
-		zl6100_wait(data);
+		udelay(delay);
 
 		if (ret & ZL8802_MFR_PHASES_MASK)
 			info->func[1] |= PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
@@ -418,8 +371,7 @@ static int zl6100_probe(struct i2c_client *client)
 			if (ret < 0)
 				return ret;
 
-			data->access = ktime_get();
-			zl6100_wait(data);
+			udelay(delay);
 
 			ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_CONFIG);
 			if (ret < 0)
@@ -428,8 +380,7 @@ static int zl6100_probe(struct i2c_client *client)
 			if (ret & ZL8802_MFR_XTEMP_ENABLE_2)
 				info->func[i] |= PMBUS_HAVE_TEMP2;
 
-			data->access = ktime_get();
-			zl6100_wait(data);
+			udelay(delay);
 		}
 		ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_GLOBAL_CONFIG);
 		if (ret < 0)
@@ -446,13 +397,12 @@ static int zl6100_probe(struct i2c_client *client)
 			info->func[0] |= PMBUS_HAVE_TEMP2;
 	}
 
-	data->access = ktime_get();
-	zl6100_wait(data);
+	udelay(delay);
 
+	info->access_delay = delay;
 	info->read_word_data = zl6100_read_word_data;
 	info->read_byte_data = zl6100_read_byte_data;
 	info->write_word_data = zl6100_write_word_data;
-	info->write_byte = zl6100_write_byte;
 
 	return pmbus_do_probe(client, info);
 }
-- 
2.45.2


