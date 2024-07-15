Return-Path: <linux-kernel+bounces-252138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598E930ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E691C20FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9821849D3;
	Mon, 15 Jul 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FlSG0SxL"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E3184116
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028678; cv=none; b=WxgrAo6Dei359M20tl9QZEPxEz9GjUwCtakVUyiRnB19BRVQQyToGD+hz2/5ZKoZX7TJkWCFGiCF0Z9VlVUGSvS4EqtI8fShUuNpsSCOMyLNl0z1MOUiDg3riCeD+79mypnJElEuXIZbnu8pGmUj53pruKZsSOeMiEI07h57RYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028678; c=relaxed/simple;
	bh=tYZDDZWvBTpejG174O9PndlbXCIw+ayXufXLEKsZNvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSgd7v9YcNrsClHj95V1Dar3/aIJDe03PN2zE+vKXDc5VYKE90s1Q4vVQ0QTrnWaAAGYixu8n7Dxeyfx5ZCws8zi4ZxpMbepLHp/F5IYBNe99Vmy9+8wiKXCiRm9HBMGGQu3cr+8XJopsrCqdBq+yINi/5sSp0qZGdwbGVeL5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FlSG0SxL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso5196348a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1721028675; x=1721633475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPmtYZFgC7tRnIlhBHtUvekj0dLjjVnIqoGBl2RANU0=;
        b=FlSG0SxL1P6X0/xM6WooSp6caeNijUWZxCT9DZCFLVyhoJNgxDwSS+LEydNSV2m1n+
         6sLUkh7iS/lXXm8DjVkCk/XoYfYCV0nWfb/BGThp2Dmbkg5fxEj6GVWIx9iUz4qkOgXi
         eDekbXxm7gGgEBs6g3uUlKpdogelzXN2woodcFA2MO0dmeej28/820MtQBh8qcCytaVN
         lcfF+hip6Hi8Usya0h0vTpsm1J6BkqJ1UBqAPidgMgydimSG7Xn3DFM1ZfLJOHWVdNsa
         j8SdJ/0D0Xes+gBKxPXN4qpn+Ccrk/I8nZh9IM2FqEJldiB/f2H5gKiSamfwP4ifVQbO
         Ptiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028675; x=1721633475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPmtYZFgC7tRnIlhBHtUvekj0dLjjVnIqoGBl2RANU0=;
        b=Mj5Xs/Fxw+csy8AjNvWsOwRbIPNeM5jqs2mVMMigciWsQQ2qu68NhoiJi9lvSuxV/r
         GEOFil3dQbGkopoq8b1Q1NEtjs28815eLJQ1ghNkieEkh2Lmaq610pBzuphi5vDUVQdC
         HElsnTh68j3mmPU8FgcpeSWCi6lW0FvSj77E5wT78vWo06l5E/6kSra4KfiT1hO2nD1b
         KrtBP+gChUA2X3mNGysaxYeFvxrucz0RzFIOIzpylXtlllK+nTotHYUF/E4NkkCPj5Ut
         6zgD1WgRsSfyaX6QUA1qAO2fpjXv5dxh2JU5DutnpAs38KOZ24aNYIL8NuP5rj/sTiZA
         LWdA==
X-Gm-Message-State: AOJu0YwPgLoO7fltFKFSrYSSZjJeHp5DOa2+sa6D3BwXlyHjrVnORLxq
	o50Zj71MTiN+j38OLx1MwJbTQYxG6w9Wmqy6HJ7RC3rpkdvcAU6KOg6Ji/7+DqWxpgeLwLikYmj
	X
X-Google-Smtp-Source: AGHT+IHbwLHHpEgp1M+yBnPEp7huvSBAXcSkrjZ0jnOnstKvKPQTyQUZBkqzrsps3dIIX3VapopV0w==
X-Received: by 2002:a05:6402:1d54:b0:587:2dcd:d930 with SMTP id 4fb4d7f45d1cf-594ba0cbe58mr13813838a12.17.1721028675094;
        Mon, 15 Jul 2024 00:31:15 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59cf7763236sm1274023a12.12.2024.07.15.00.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:31:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 4/5] hwmon: pmbus: zl6100: Use generic code
Date: Mon, 15 Jul 2024 09:31:01 +0200
Message-ID: <20240715073105.594221-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715073105.594221-1-patrick.rudolph@9elements.com>
References: <20240715073105.594221-1-patrick.rudolph@9elements.com>
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
 drivers/hwmon/pmbus/zl6100.c | 62 ++++--------------------------------
 1 file changed, 7 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 83458df0d0cf..a2aff76325fb 100644
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
 
@@ -201,8 +187,6 @@ static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
 	if (page >= info->pages)
 		return -ENXIO;
 
-	zl6100_wait(data);
-
 	switch (reg) {
 	case PMBUS_VIRT_STATUS_VMON:
 		ret = pmbus_read_byte_data(client, 0,
@@ -225,7 +209,6 @@ static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
 		ret = pmbus_read_byte_data(client, page, reg);
 		break;
 	}
-	data->access = ktime_get();
 
 	return ret;
 }
@@ -265,27 +248,7 @@ static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
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
@@ -363,14 +326,7 @@ static int zl6100_probe(struct i2c_client *client)
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
 
@@ -404,8 +360,7 @@ static int zl6100_probe(struct i2c_client *client)
 		if (ret < 0)
 			return ret;
 
-		data->access = ktime_get();
-		zl6100_wait(data);
+		udelay(delay);
 
 		if (ret & ZL8802_MFR_PHASES_MASK)
 			info->func[1] |= PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
@@ -418,8 +373,7 @@ static int zl6100_probe(struct i2c_client *client)
 			if (ret < 0)
 				return ret;
 
-			data->access = ktime_get();
-			zl6100_wait(data);
+			udelay(delay);
 
 			ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_CONFIG);
 			if (ret < 0)
@@ -428,8 +382,7 @@ static int zl6100_probe(struct i2c_client *client)
 			if (ret & ZL8802_MFR_XTEMP_ENABLE_2)
 				info->func[i] |= PMBUS_HAVE_TEMP2;
 
-			data->access = ktime_get();
-			zl6100_wait(data);
+			udelay(delay);
 		}
 		ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_GLOBAL_CONFIG);
 		if (ret < 0)
@@ -446,13 +399,12 @@ static int zl6100_probe(struct i2c_client *client)
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


