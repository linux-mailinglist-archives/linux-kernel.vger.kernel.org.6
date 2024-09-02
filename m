Return-Path: <linux-kernel+bounces-310771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741596810E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C33B22AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FB2185952;
	Mon,  2 Sep 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DydYV0CZ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93D17C22E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263729; cv=none; b=Dkc5HDvvVR9/6PmzE1MjkGshBAAlas0VdpY3NGjUX18RDvZrra4F3xVr1RKeurydhd0c5lsKnF6/lXlBEAMSMlsMYpAirjtuhAJ8rqq2ChO7z2B46IEI9GJ7IUjT/EudTvH9AHRNcTqVaGxJqNfnkAxRmHXP/EMIo9v3DR1aJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263729; c=relaxed/simple;
	bh=aWOWSzyMeRbm3ItC9i35pWQz0CkR9clxZFABoapwEmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fH+BcpmvrSMHUFsVB/viGDy8WvVgm5o83hAO6wMCDKD/eBRIc6iJIrURtGWspif8I1FTempAG1sxyItm6XcdxGU9ejHiRzi5f/K0MYwr2ifsAh6XtM45cOLQ1zNPAU+7ZUN+whqUXKqmtW6YxdY6x9n0TLUDS3yablYgnJks7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DydYV0CZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so4032470a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1725263725; x=1725868525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsVXyLDSs2fFLBUKODkBzg9eUfumfnlE3Ahu+IB1q70=;
        b=DydYV0CZpJDFtWlk/tQhQckBANGBqtVInUku0qwk3b5mvUqajifVbFDcG0JTriIO1X
         Pdy+bdfktZCxi7KLzgJNErbdSeVon2TSCaOcmNfMR87GBZgYOy7EJXhDJzJChdBMTHf1
         nBRToo6slDZnrLGBaE6E3ddh0OsHb4cgQuJXmVKF7K5HfkQ3hVQuDVMlZSLRsP4iQ62j
         q5aKeLWJKkmlW7Nx3AnueOyN3xov9dL6RsKyvxth2MRrXvgkT+rqs9p9cE0Sr2iAiEDz
         04F9TT+6F/Kcaxdusy63ksJ/0YZqa+hHU9wh1WNMk6dwAW4hQ1qLjJ+F292CKGYYgC6S
         ZO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725263725; x=1725868525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsVXyLDSs2fFLBUKODkBzg9eUfumfnlE3Ahu+IB1q70=;
        b=Znx0tHYC/3UiAPdB/GRhxiv0gJecakl9UDl2WXBprp0Fm5+FOFKVkO72ZaV6vPjhD7
         bCiPFkCm8xzweJh+24QBjYwx/MfAXQOyjql3szFij5kVwecNWLKyygqyjhRooBUai7sS
         jS10G5PURAGrD4g+hrN7y6bIACRnkzSFBwFt6JELt/w53FH1twyxEX7DMGzHnL7oom8M
         2A5wTBAYsn0lswhSmVzP3DTx00+axMmaq393FGDKhDRhB1SCQ1pG2DfOmvqFqPoXOw0i
         AmvoYqM1xZt/acUCya9xq/2zqcMBpXsVT1BhZzL707J7EhXZOhdr3pJsMpw0T+4rc62i
         m2YA==
X-Gm-Message-State: AOJu0YzI3WM5wTYsEdJSh7JmV1PV3QzS3Z8W6Bed7s/4gYIKsk6Hu0WO
	PcocP+I9A/SZHb+O/pu01DzBIWYLwWgJG7uf5qs7/dlRymyC9qqOA+j/1zfPzGJgVj3EWxufZdF
	7
X-Google-Smtp-Source: AGHT+IEBRtDc4jtuzw3Cb4zykGMMX4ofSyV73MtXmrgXfWD3fmQiUt5cg2UBsDskc07WY1CLzZzkjw==
X-Received: by 2002:a17:907:72c7:b0:a86:a30f:4aef with SMTP id a640c23a62f3a-a89a35dee4cmr633103266b.22.1725263725486;
        Mon, 02 Sep 2024 00:55:25 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989022481sm521076066b.86.2024.09.02.00.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:55:25 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v3 3/5] hwmon: pmbus: ucd9000: Use generic code
Date: Mon,  2 Sep 2024 09:53:14 +0200
Message-ID: <20240902075319.585656-3-patrick.rudolph@9elements.com>
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

Use generic pmbus bus write access delay.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
Changelog v2:
- No change

Changelog v3:
- Added changelog

 drivers/hwmon/pmbus/ucd9000.c | 64 ++---------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index d817c719b90b..5d3d1773bf52 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -67,7 +67,6 @@ struct ucd9000_data {
 	struct gpio_chip gpio;
 #endif
 	struct dentry *debugfs;
-	ktime_t write_time;
 };
 #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
 
@@ -86,63 +85,6 @@ struct ucd9000_debugfs_entry {
  */
 #define UCD90320_WAIT_DELAY_US 500
 
-static inline void ucd90320_wait(const struct ucd9000_data *data)
-{
-	s64 delta = ktime_us_delta(ktime_get(), data->write_time);
-
-	if (delta < UCD90320_WAIT_DELAY_US)
-		udelay(UCD90320_WAIT_DELAY_US - delta);
-}
-
-static int ucd90320_read_word_data(struct i2c_client *client, int page,
-				   int phase, int reg)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct ucd9000_data *data = to_ucd9000_data(info);
-
-	if (reg >= PMBUS_VIRT_BASE)
-		return -ENXIO;
-
-	ucd90320_wait(data);
-	return pmbus_read_word_data(client, page, phase, reg);
-}
-
-static int ucd90320_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct ucd9000_data *data = to_ucd9000_data(info);
-
-	ucd90320_wait(data);
-	return pmbus_read_byte_data(client, page, reg);
-}
-
-static int ucd90320_write_word_data(struct i2c_client *client, int page,
-				    int reg, u16 word)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct ucd9000_data *data = to_ucd9000_data(info);
-	int ret;
-
-	ucd90320_wait(data);
-	ret = pmbus_write_word_data(client, page, reg, word);
-	data->write_time = ktime_get();
-
-	return ret;
-}
-
-static int ucd90320_write_byte(struct i2c_client *client, int page, u8 value)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	struct ucd9000_data *data = to_ucd9000_data(info);
-	int ret;
-
-	ucd90320_wait(data);
-	ret = pmbus_write_byte(client, page, value);
-	data->write_time = ktime_get();
-
-	return ret;
-}
-
 static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
 {
 	int fan_config = 0;
@@ -667,10 +609,8 @@ static int ucd9000_probe(struct i2c_client *client)
 		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12
 		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
 	} else if (mid->driver_data == ucd90320) {
-		info->read_byte_data = ucd90320_read_byte_data;
-		info->read_word_data = ucd90320_read_word_data;
-		info->write_byte = ucd90320_write_byte;
-		info->write_word_data = ucd90320_write_word_data;
+		/* Delay SMBus operations after a write */
+		info->write_delay = UCD90320_WAIT_DELAY_US;
 	}
 
 	ucd9000_probe_gpio(client, mid, data);
-- 
2.45.2


