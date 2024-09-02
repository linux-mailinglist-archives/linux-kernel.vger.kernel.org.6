Return-Path: <linux-kernel+bounces-310770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB996810C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EED1C21FF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E317E017;
	Mon,  2 Sep 2024 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="KfEq8Pvu"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3F1552FC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263727; cv=none; b=NSvobgvZjQ1Zz9m616trg2RDiQnV4FtYpVjz4Y3CFZGW+mtVbkhq4Hx1hwJb41sHrXqs5nbr7fTRdJRwBvU0jpg1gys47xTzjop/0vzdFYX7LPS839ph9xIeNiaCt2FCUsM+tqjCwpur0D75/KSAAUODDvBtRs6+HsONORFLJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263727; c=relaxed/simple;
	bh=CHTREiAcEZMsJXs1E2EV/u8Fu6chAqB+ClVn1Vb70uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnQygi4CMaqbVEjfPARwbbigjKtTEolVkn008RaSy8A0UWGhIA2sBlkoWu4lSUrXwGwHrCXGGYXB4jPYKoTLIJ9kDhSOKIn8BwJP9KdErP064PnBEcxtEj8rQBgvpSdDL2wp2mCqtD1PWobJQFokkMa4HMn29SlOKvd4UN6yD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=KfEq8Pvu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86984e035aso476740466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1725263724; x=1725868524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wJu6eSYrIH+jWqR93bP7w6T/N0xlGC/9JkjmC8TAO0=;
        b=KfEq8PvuWfudjCQkPag4TGwYWcvDqpWqQCVULjWDsHsQ2HEoYHF+1gYal0//NdI1HM
         Jizs+lCv7F6eX+tZF76cCVfJyUjnYph2OV+Dq6+Qd9V8G6Hm7bVWmCQg+I00+TsSo08W
         7+lRPxE0/jfk+FvnEWg5ONUglQZW8pv9FWTYn8N2C8XsKE7b0Gj7/TvdTIWRE2b1QgZ0
         1khzzzRGDpqtfQWsa2TDwKQqKOmL9kxy3SaQ0byn3CeKS558v7fDzk0X+6LvRdof8e0V
         XREucuZKNqOntfgLUTCh+cN4xls7Lf6krqhw2J6X+gE/dEmHNOyIj3oC4WcSr71HXdeT
         vZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725263724; x=1725868524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wJu6eSYrIH+jWqR93bP7w6T/N0xlGC/9JkjmC8TAO0=;
        b=PSBMRn0Y8F8I3LCzkqXTqNiUoHk/Zsib9/3qF/HKBOqgD/3GXTbsfCwiM6utISuL6f
         6QXntkksHKlQ0glrMco8ualXJ6yQpNfZk/q913OCTc0HXHZAJLtmpCg6Tw5LiCKtbDWg
         5G7F8iZPssOUVDamD0BTIGRlMq06uQcNfNbNWzsGbE6GE/uOMSeyV9FhSwqGk47GM79R
         2zwLX+O3A2EStTEuq4H6xd9XLVDOZJWMtrsu+els/+gziCQU+892NM4FnQ4OLfcAftPW
         x8+v63Vhu7XLDm3Jjqe2kGQO05YG3++fs4aQ6gGIadaJATy3i1TirNSgGjhBAw3UpKrf
         hEqA==
X-Forwarded-Encrypted: i=1; AJvYcCUIMbUM0voRYP66OoCHWqJmK5oAaAXgvx2+uZJ93IWAZsa3EW7AVpPGWXaptjnP4SqgKlqtWb1q7lbbsqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Mw3psQ9qg6z4MPURrGWI+Dwb269yc3bc4+oOiyY6fkGVIsGE
	YIc7rqhVHLUWwGd6HzageQ+9HuoL53M9qViF/nr/sDg+fg2mwm882+AmaGfessw=
X-Google-Smtp-Source: AGHT+IHuc6RANhB2GFUELent8s8Fr0cwtTYQacm2gMM6HYRleWFgZr0ofL5/w80YH5dqa6wZI+h+Ag==
X-Received: by 2002:a17:907:948b:b0:a86:c252:aaa2 with SMTP id a640c23a62f3a-a89a379d069mr706616766b.51.1725263724106;
        Mon, 02 Sep 2024 00:55:24 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989022481sm521076066b.86.2024.09.02.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:55:23 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Daniel Nilsson <daniel.nilsson@flex.com>
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] hwmon: pmbus: max15301: Use generic code
Date: Mon,  2 Sep 2024 09:53:13 +0200
Message-ID: <20240902075319.585656-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240902075319.585656-1-patrick.rudolph@9elements.com>
References: <20240902075319.585656-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic pmbus bus access delay.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
Changelog v2:
- No change

Changelog v3:
- Added changelog

 drivers/hwmon/pmbus/max15301.c | 92 +---------------------------------
 1 file changed, 1 insertion(+), 91 deletions(-)

diff --git a/drivers/hwmon/pmbus/max15301.c b/drivers/hwmon/pmbus/max15301.c
index 986404fe6a31..f5367a7bc0f5 100644
--- a/drivers/hwmon/pmbus/max15301.c
+++ b/drivers/hwmon/pmbus/max15301.c
@@ -31,8 +31,6 @@ MODULE_DEVICE_TABLE(i2c, max15301_id);
 
 struct max15301_data {
 	int id;
-	ktime_t access;		/* Chip access time */
-	int delay;		/* Delay between chip accesses in us */
 	struct pmbus_driver_info info;
 };
 
@@ -55,89 +53,6 @@ static struct max15301_data max15301_data = {
 	}
 };
 
-/* This chip needs a delay between accesses */
-static inline void max15301_wait(const struct max15301_data *data)
-{
-	if (data->delay) {
-		s64 delta = ktime_us_delta(ktime_get(), data->access);
-
-		if (delta < data->delay)
-			udelay(data->delay - delta);
-	}
-}
-
-static int max15301_read_word_data(struct i2c_client *client, int page,
-				   int phase, int reg)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct max15301_data *data = to_max15301_data(info);
-	int ret;
-
-	if (page > 0)
-		return -ENXIO;
-
-	if (reg >= PMBUS_VIRT_BASE)
-		return -ENXIO;
-
-	max15301_wait(data);
-	ret = pmbus_read_word_data(client, page, phase, reg);
-	data->access = ktime_get();
-
-	return ret;
-}
-
-static int max15301_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct max15301_data *data = to_max15301_data(info);
-	int ret;
-
-	if (page > 0)
-		return -ENXIO;
-
-	max15301_wait(data);
-	ret = pmbus_read_byte_data(client, page, reg);
-	data->access = ktime_get();
-
-	return ret;
-}
-
-static int max15301_write_word_data(struct i2c_client *client, int page, int reg,
-				    u16 word)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct max15301_data *data = to_max15301_data(info);
-	int ret;
-
-	if (page > 0)
-		return -ENXIO;
-
-	if (reg >= PMBUS_VIRT_BASE)
-		return -ENXIO;
-
-	max15301_wait(data);
-	ret = pmbus_write_word_data(client, page, reg, word);
-	data->access = ktime_get();
-
-	return ret;
-}
-
-static int max15301_write_byte(struct i2c_client *client, int page, u8 value)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct max15301_data *data = to_max15301_data(info);
-	int ret;
-
-	if (page > 0)
-		return -ENXIO;
-
-	max15301_wait(data);
-	ret = pmbus_write_byte(client, page, value);
-	data->access = ktime_get();
-
-	return ret;
-}
-
 static int max15301_probe(struct i2c_client *client)
 {
 	int status;
@@ -164,12 +79,7 @@ static int max15301_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	max15301_data.delay = delay;
-
-	info->read_byte_data = max15301_read_byte_data;
-	info->read_word_data = max15301_read_word_data;
-	info->write_byte = max15301_write_byte;
-	info->write_word_data = max15301_write_word_data;
+	info->access_delay = delay;
 
 	return pmbus_do_probe(client, info);
 }
-- 
2.45.2


