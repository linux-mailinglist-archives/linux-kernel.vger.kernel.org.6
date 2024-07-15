Return-Path: <linux-kernel+bounces-252136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77258930EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B405BB20EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B39184125;
	Mon, 15 Jul 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bXFgKJ9T"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768113A884
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028676; cv=none; b=dACvadTvgpzzY14xzy4kAM3LczAO1sHOE0fAI3rfwZZ2eowF5F04whk1vWAP4Cq4dObPO1t8z2ryGqF/AeAOjW0lS1cucVJ309b09fsY/c++Lm6cz8spFf72RmNcJ9zib5VYZ3gfannJqRPZG6kYQn30J70Sc5S//wKgMHu6CF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028676; c=relaxed/simple;
	bh=tWz44zz6lM29PayvcPvj0KkLvjaLEEv6fqqBbA3P+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHAveWh3lsAIg8tWMECPek3lQeDp5RnjAahb+m2cChzJE2Yc+jvEqbTppv/XJ1WLC/V64Wv/B02CqMfpeZD11J1ed2thY7+t6aDhqIVDWlsVaCLWvFThZARRJIH/Y/6KwhoR1DdZUHAd2bFPrCAYXqYhtL2HbrRiik/6lubvgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bXFgKJ9T; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso4949392a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1721028672; x=1721633472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwpJFValDdiHcvaMz/RllZFXslcWnajiskOco8CbPLY=;
        b=bXFgKJ9Tw7dbb1Rtaibo7K0Dc9LDufu1kDLEaG92czLv7DIu9UD+hSV0/nT0txT6V7
         lmU+9b3YtYyPRJn0s0IaR7CgaEM9Wy/Dnk/aSoipg7ScGFgvXsPkFG9g6U/xj8b/66s5
         E7jHIbVEaxCPa4CCAaF/4Sm8ZpF/MZHZkQ1qCenLfUf9/TMI63buJlafmv3H3Ij8MzhR
         Tc8iO1SQUxPgysRWfvll+B2Gy10C45BK66N7EnW4ys6UUmf034/NwVe5KMxniD098SaR
         vnpzHQWEijqMeKA8qzdjXeC3iIC8T0PAyeVqZRa44IcQDvu8xfiIPOB+YBo0MBKVUNXG
         qiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028672; x=1721633472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwpJFValDdiHcvaMz/RllZFXslcWnajiskOco8CbPLY=;
        b=BDJmc0ycm5jhrnN2e6ls+fqcz1I/pDi2Wf1wGxqT/ekqNOM6dy+e3kkm3wqaaccbJR
         Gjcrw3BUgwn0wyg4qTXHFBzeM7lwfv/C0/RZ2sU4O1SyhlCgD0X9RrwP3bSB590FGxTI
         gene9xdeaK9NJ1E/BkgmsN8FMvd3Oamyh8wTI0n9cSo96TZ5Atr06Mvm4kFASHcPoMsB
         1fF8P6HxVKVbmYUT2CKjSCkjsS4mCNeaNQbYtFi6XTZpnFVExfV3fiK9BppyUUhRRZy5
         37SfegiCko6BALQUxhY1C5YUNxkXVE/X6siDDgogFwJe86jILi1nAxr3vVr8ScnR3wqX
         Hcaw==
X-Forwarded-Encrypted: i=1; AJvYcCXu8Scw3B7GZa8ntJ6RIL4x1BY8XA8XH/t1WK8X954QiASLty/F0eyN3lq9fh75oksUGlmzlvg1F5LZuVyD4MVIXJ1lPNeFF+p8U1PW
X-Gm-Message-State: AOJu0YzgORgn3vyf5gXNNr6m2/XzNKeLcZ+ZSzkPUT5KFAI1dLB9IH3z
	tipon7HAEgcXhNBfwkQ2Lt6Zj7j0zt++uelHMwZNhjZ1jG3e16hwakEu+cB2bec=
X-Google-Smtp-Source: AGHT+IET9GugG9iq4Mjb01d+J2K+BOGdM7/WmeU/m7MyvFbZXnE0EoCj2FgfZMlYfbxYupY5KPnECg==
X-Received: by 2002:a05:6402:1ecf:b0:586:12f6:c0fe with SMTP id 4fb4d7f45d1cf-594ba99755cmr14477598a12.5.1721028672463;
        Mon, 15 Jul 2024 00:31:12 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59cf7763236sm1274023a12.12.2024.07.15.00.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:31:12 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Daniel Nilsson <daniel.nilsson@flex.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] hwmon: pmbus: max15301: Use generic code
Date: Mon, 15 Jul 2024 09:30:59 +0200
Message-ID: <20240715073105.594221-2-patrick.rudolph@9elements.com>
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


