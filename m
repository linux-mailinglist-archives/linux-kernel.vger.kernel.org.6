Return-Path: <linux-kernel+bounces-220123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9D90DCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EEF1F24369
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E11741D0;
	Tue, 18 Jun 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivmLDKNa"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DE16EB58;
	Tue, 18 Jun 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740439; cv=none; b=suVY9f/PJnajThOzZSsR/XGiD702kjMVqr9c34OQkBOVOYD6IhVYNQd0AcmBPk9Y7uwMwM/+O38YbaBZBw47lBxW8cOkCggzrQBuuWlo2InCR6WgW/cklah4tRtPoC909hfLJz2MvDPrQzsVjjhn0i0EzCYXLds59InxFQ4JWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740439; c=relaxed/simple;
	bh=XkpZEMXaJWJ+1VF4LA+imV+crtqchhcJeUMjkZlQX0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ww4SYw+qhEJkjv/P0CFdFEIgDtBditrs6of0zFvktVA4SgbtmpHvApsTTTnUzbwwYoHCt+3nRRXUreM3lamArm+Tg/LSqq2xyJHWjy1wbcofLWy5XSLXWFASLII1lAlvS4zdrFb5R6m2DLaAfjIgAgKgCfhgQxOhm8kSZhZDEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivmLDKNa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f700e4cb92so50956855ad.2;
        Tue, 18 Jun 2024 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740436; x=1719345236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45FkWHWTnI7wDlZNwvZj68CZUnQTmaeCkeuNifaEhvg=;
        b=ivmLDKNaGXVQF6aloRFQJeIw1qAkXKD08IjYTJtSTER3+HLLFNmkRHeTcvqnnCtCir
         rZ0GxNW7e+kZNm8CX7X3FbP1N9ypY/l2z4t84nwW4pYOVat//9FDK4FSHuRdtpdwITgU
         PE0Eibup7gDNpPmsaC89tfv5FblHZVRHB6nwxC0aPnHAu7RCOt+G/HyogSfI0QzFE/ZT
         PpiGUZrS63y9sEIEkCWNFjwnsAPr+DiZsU/dtoZg98Ym+Y7Tg2YcNUpkPY945E6ZRIkV
         UNR7Jm7+Jss3okqsVtiVyTSRa7rFn2LA5+GVHPqA0zH/aBFWu4VoHwxSA8UG2Fjtk87F
         WbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740436; x=1719345236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45FkWHWTnI7wDlZNwvZj68CZUnQTmaeCkeuNifaEhvg=;
        b=W0I10I+fDb7E/SVAV4QIENZglPCG8K2Xt37YR3jK3FKJ+mBR384m9SoI+6ZLYWePS0
         VaxAqrg1Du0s7hONlMbX56xMvnFSH8lMXstIKkJJefWiGcGvxocqIBa3SauDlDu+YDJa
         eymgPkdsGfK17DvryjDb+HHEj/tYuadrifeBFSH9Hk7312/xGP8zT/RyUd/aVGDWFbZg
         YpHlqOIoz/fD7+iVsAyF/0cCAXhdL1pNfvZE5KBVIHsqL4NzKgF51vjXWNaobUVAcNpj
         WImpwRbYcx4otB7Zjp67VCdglNwKdO97qrUyus+YFr0I/bKhn3HrsTIM7Jyna8//RN5k
         1cnQ==
X-Gm-Message-State: AOJu0YxdY6NYtgasp6T+pJyBT1mI9oRJ5MK1qYlYpP+xO4Zs3wEXx/je
	uTeV5sduaVtGKEf5Fu0hIAcYt/NXd4JIapoHgzpy2SrPmdm+pB9Rnhio7g==
X-Google-Smtp-Source: AGHT+IG9d0zHvYVBGZeQTvhIVWCsf6A6g0jCr9ScG4jPNgIfDG2/CWnu/rHcVKzBU70LkIyFPqwvCA==
X-Received: by 2002:a17:902:cece:b0:1f7:167d:e289 with SMTP id d9443c01a7336-1f9aa466115mr8316035ad.55.1718740436498;
        Tue, 18 Jun 2024 12:53:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee80fesm101342225ad.124.2024.06.18.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:53:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Armin Wolf <W_Armin@gmx.de>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Kozachuk <skozachuk@google.com>,
	John Hamrick <johnham@google.com>,
	Chris Sarra <chrissarra@google.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH v2 3/3] hwmon: (spd5118) Add support for Renesas/ITD SPD5118 hub controllers
Date: Tue, 18 Jun 2024 12:53:48 -0700
Message-Id: <20240618195348.1670547-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618195348.1670547-1-linux@roeck-us.net>
References: <20240618195348.1670547-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPD5118 specification says, in its documentation of the page bits
in the MR11 register:

"
This register only applies to non-volatile memory (1024) Bytes) access of
SPD5 Hub device.
For volatile memory access, this register must be programmed to '000'.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
"

Renesas/ITD SPD5118 hub controllers take this literally and disable access
to volatile memory if the page selected in MR11 is != 0. Since the BIOS or
ROMMON will access the non-volatile memory and likely select a page != 0,
this means that the driver will not instantiate since it can not identify
the chip. Even if the driver instantiates, access to volatile registers
is blocked after a nvram read operation which selects a page other than 0.

To solve the problem, add initialization code to select page 0 during
probe. Before doing that, use basic validation to ensure that this is
really a SPD5118 device and not some random EEPROM.

Cc: Sasha Kozachuk <skozachuk@google.com>
Cc: John Hamrick <johnham@google.com>
Cc: Chris Sarra <chrissarra@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Simplified to use mechanisms introduced in the first two patches
    of the series.

 drivers/hwmon/spd5118.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index 995c45e2a997..80a02dba2ccc 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -538,6 +538,58 @@ static const struct regmap_config spd5118_regmap_config = {
 	.num_ranges = ARRAY_SIZE(spd5118_regmap_range_cfg),
 };
 
+static int spd5118_init(struct i2c_client *client)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int err, regval, mode;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	regval = i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
+	if (regval < 0 || (regval && regval != 0x5118))
+		return -ENODEV;
+
+	/*
+	 * If the device type registers return 0, it is possible that the chip
+	 * has a non-zero page selected and takes the specification literally,
+	 * i.e. disables access to volatile registers besides the page register
+	 * if the page is not 0. Try to identify such chips.
+	 */
+	if (!regval) {
+		/* Vendor ID registers must also be 0 */
+		regval = i2c_smbus_read_word_data(client, SPD5118_REG_VENDOR);
+		if (regval)
+			return -ENODEV;
+
+		/* The selected page in MR11 must not be 0 */
+		mode = i2c_smbus_read_byte_data(client, SPD5118_REG_I2C_LEGACY_MODE);
+		if (mode < 0 || (mode & ~SPD5118_LEGACY_MODE_MASK) ||
+		    !(mode & SPD5118_LEGACY_PAGE_MASK))
+			return -ENODEV;
+
+		err = i2c_smbus_write_byte_data(client, SPD5118_REG_I2C_LEGACY_MODE,
+						mode & SPD5118_LEGACY_MODE_ADDR);
+		if (err)
+			return -ENODEV;
+
+		/*
+		 * If the device type registers are still bad after selecting
+		 * page 0, this is not a SPD5118 device. Restore original
+		 * legacy mode register value and abort.
+		 */
+		regval = i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
+		if (regval != 0x5118) {
+			i2c_smbus_write_byte_data(client, SPD5118_REG_I2C_LEGACY_MODE, mode);
+			return -ENODEV;
+		}
+	}
+
+	/* We are reasonably sure that this is really a SPD5118 hub controller */
+	return 0;
+}
+
 static int spd5118_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -547,6 +599,10 @@ static int spd5118_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	int err;
 
+	err = spd5118_init(client);
+	if (err)
+		return err;
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.39.2


