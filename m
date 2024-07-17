Return-Path: <linux-kernel+bounces-254812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD7933804
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27EC1F22706
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A578210E4;
	Wed, 17 Jul 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fwXbrQDS"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924F1BF2A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201466; cv=none; b=cKFyZXGviXl9IEe0ylyL4AIsiX1n9fa9vksw45uXEwifM1JHGPZCJPTp208Hn8gX2EXbU29Y1wZuEqSh67s0pRbu7lx2o/gW0kgY2gcMBFDVmk/wL0YpRtY+EXTVLTeYa+2OaNWDJ1DZdl/6KkvvbBOxxxOCTl4e8AzvMCcQBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201466; c=relaxed/simple;
	bh=ELszuHUI2Sho29pe1aUjUExSj0Jd1K3H1CrC966SsaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6M9zShrAREARHQsv9UJ8W08gi3gPhHb9i0iE1eGNP2qNrr3mYYjsB/RrCUgTUb+GQYhL3tXvW1la8hhXWEa4s6UxZxHGp65dJU7VsAS7qi6XyOr45uNTCjYSwHMCD0svbrDHAkW1sXkKYw9UhrBF6HcdQ3Xu2nqhuQhClceHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fwXbrQDS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eede876fccso54206481fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1721201463; x=1721806263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rte73YBhPAaVfekdORAEqN2cWG8+g6DnTMOK+KE3CVI=;
        b=fwXbrQDSEGiOwxfFTBw2DqFOwfxEILLIo5DvmLSCz734XTgzCcaqtLfghcmdN2eO3+
         CJze897THNwKmyRHUtTRsZcGBauxd8YF9D8iqri1H5iZZ+F8iaUWf7Kwu7wERIZBLoAO
         VthGjm6EcG1bsxG7oTVwvyHXp707CB4TZVHN/9SkvLQxN+p8TBebbXYNTvTCDXozjZhA
         mt5qXBXDAUc5sjIwWHsGbdGO39nCI5GQqDP0NW3kMXCs0m5jIjqbSBhuYmDQvXvoRJAy
         EgGW8pCV2anAY95bTxNLoOtWz816Gb7adbBcnb1vGo/yIOHJJUUqqAAoqLQo9RZ5QZCW
         wjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201463; x=1721806263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rte73YBhPAaVfekdORAEqN2cWG8+g6DnTMOK+KE3CVI=;
        b=okZhz74THA3m6icklspdEqckctCtZThEUOeKcipzilVAdMQNed9K6LOjM+Bp+nsga6
         Ly7ivjK3Xs6aa5I9r9x1hB3Ag9YbIBxH1+eQzvrySadRacWHWLXKLLTp1zbwwVoQdbT2
         TmDC4rdQQNNvGqB3hFphDILjdyY7wqBOxw9gdZi3ng5hOxaqBtyA8lJwbey4KTtcxhHo
         c8GOLqHjsi3o+B/yufbe6PaJ8znKRl30FE2fJbPEKBOdbnLDcZrDTTuu3ICkAc47Vpks
         9q6HUo5UFNBj/QGrdJZ4JrBYMqXWerbGSl7wfsKSKGy2jT38BFzXK5ifrAUlGKWuIB5f
         ahrQ==
X-Gm-Message-State: AOJu0YwyzcKXhTJdKB088K8MxSxC3NFYN175ZCtgwmuVxXVsP688r4nJ
	KvMBtWdgiQ24yH1lna06XAnihbOeWH5JIs0FmSVN8vOlrfI9igy7shdURnca9Nm4B2tfAuBMhyf
	s
X-Google-Smtp-Source: AGHT+IHAUxKWsN2wQo1Ub0U+chlJcOfcRk9v2hgilyZNE4e2HyBhCJ8wilT9OSwStcmENs7MUDIr9w==
X-Received: by 2002:a2e:918f:0:b0:2ee:80f0:c220 with SMTP id 38308e7fff4ca-2eefd1d60b8mr5551501fa.40.1721201462589;
        Wed, 17 Jul 2024 00:31:02 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59edba561e0sm2766841a12.50.2024.07.17.00.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:31:02 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 3/5] hwmon: pmbus: ucd9000: Use generic code
Date: Wed, 17 Jul 2024 09:29:54 +0200
Message-ID: <20240717073000.786228-3-patrick.rudolph@9elements.com>
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

Use generic pmbus bus write access delay.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
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


