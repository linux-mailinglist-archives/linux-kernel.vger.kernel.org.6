Return-Path: <linux-kernel+bounces-254811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86D933803
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E30E1C223DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF61CFB2;
	Wed, 17 Jul 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="D72nay8j"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470F17577
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201466; cv=none; b=NBcHO9zQxLINEZsFqh0qpqncfkYNjJWe1gI0lUie9ClD4VfQqJVrQiaIVrLRqDRE3sGcNa1OMqLy0zSc+Nhx4td8Dcd5A23uIJAjNewiKZC6eXGDsj8ZJcbQdUM60qvnQXOSXX/EvxSj1xhf/Q5nJbNrkbUXOLISaQuJUoTXIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201466; c=relaxed/simple;
	bh=tWz44zz6lM29PayvcPvj0KkLvjaLEEv6fqqBbA3P+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXuo9SE+FANV3jTFkEeaOVWFqaVfNAF/KDTwxBkziCrj5chGO/lARJ9sWMYMys5bQ45008lRA4doyV3hQQ4WxKXp8itrgJ05/PMoGx0w0UlnCLqWu8YgTxj9kybuOGxs+UBGIzf26Wk6d45mMGEkphE1DqQ2ay4fiY9RvFciEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=D72nay8j; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso9911998a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1721201461; x=1721806261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwpJFValDdiHcvaMz/RllZFXslcWnajiskOco8CbPLY=;
        b=D72nay8jTj6nxfsiitnt6n+lIbU7lk+4KwGipzZqZ1EEJhLhPPOAVxQ1aAuGRPYNI3
         hQI3YAKvZsATLxHQfQ0Svra4UL4pxNywJivFosQk8SZkP7GILs1wmVh4BEbZK3JDCtKL
         khl0x9CF8+/vqRSTxxWqvLBzxWDlVWCiY+GjfUXlTRM/eLGBpz8JKoz08G0duy9GvHmD
         V+W8XWN/wa4SoEsZcRND6qUbnyLo3HcnrHc36bylKDb0f1tiOh9C5yOaqEVnU9PpbrdO
         LMJFTcW06vOfekoWHkzphAHjO31Xy4a4Xj8GMnXvrrlXOcQpoxXlcIbOVBi4ngcTEIdM
         q8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201461; x=1721806261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwpJFValDdiHcvaMz/RllZFXslcWnajiskOco8CbPLY=;
        b=fFeWql3VLozLF3Yd2dQJiSLtyrd1XLM84OY0bM+GPnyZM+0Lo3rGMw72BK+YytLKBM
         x59AkYlHliSn1h646s2SJXHr/75KpTLCz5GNPTKVv2S3nPMWm221AGPoW2NH+k288/Pr
         29U9BnSt1EBAYy65fxjgjrxK7s0yal1QPHRMT6WbMmyJ3vyExe8CSdW2BkzvMyY9pXQu
         CGyJrC7gtO1z+ShNIwNg2YjHSTDiq8eOr3nHVyvQhz+UQlhgShbQyG9dDIBXJUqDDR+R
         ewDtamf28doxyphRJn1g2fcGoqwAhTqBPNY9oT3ZDy1OqAPd6WUqKD9uhh57KUPfU6CJ
         9ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCWb8j3BTV2UXyiv7X5BftZuY+ZcN243DLMf8TUEQ+D8iMdQkZkMHdCMKmisdYwMepDAlTYWCUVHGVn2USiqXpvZxuiZRqOGsShwp0tY
X-Gm-Message-State: AOJu0YzZnZIuN66vKf53FVl7aHemlaWh1pGCyhaGP8IfpuhviHcFuE8A
	wt7woiOYksAZajLfzEzTJBUA0uG26TiL63/FmeqN8RWE8ZeRVHwOLg6zxaGMIWc=
X-Google-Smtp-Source: AGHT+IH8pf4aj4d8HfkV1sMHbhkF9N4nu7s+paZb7qKHHoUKawrXLPwgn9SaTYkP81LhTvL2lFsCbw==
X-Received: by 2002:a05:6402:2792:b0:59e:9e6c:36c2 with SMTP id 4fb4d7f45d1cf-5a05d9a214emr784009a12.34.1721201461223;
        Wed, 17 Jul 2024 00:31:01 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59edba561e0sm2766841a12.50.2024.07.17.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:31:00 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Daniel Nilsson <daniel.nilsson@flex.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] hwmon: pmbus: max15301: Use generic code
Date: Wed, 17 Jul 2024 09:29:53 +0200
Message-ID: <20240717073000.786228-2-patrick.rudolph@9elements.com>
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

Use the generic pmbus bus access delay.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
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


