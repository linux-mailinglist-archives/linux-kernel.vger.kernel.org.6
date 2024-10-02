Return-Path: <linux-kernel+bounces-346870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752798CA0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE241C234A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD51C27;
	Wed,  2 Oct 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNZaPenW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60F1FA4;
	Wed,  2 Oct 2024 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829094; cv=none; b=ghM8NfTnKPyuVd0SJOlklZgTy1ehqFYB5rDjZO/H0S1pKb1LiHY0qqbwahoS0gqjmcRCYqeI+Ju24k4sRaf/X/6b8bvNx6g3FhTh1uClsR8rKVIrA6DGY6VvV9uD7Go2jmTPOXSfrJBLiBi38W2MdNvqOM3D5Xl4yeghsbJ/D6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829094; c=relaxed/simple;
	bh=JB4d9QpqOVuAVtei3L6EtIsV9pyuYrlIUMt3NFfmuUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A0IfO7v3kTnJ/VT59m/56n3hetO6F0k/gmOtZwZRtDRvBBBsWj71asFno+KkmfllJjRbXiIkCekuycvnPch33ijd+6g2DTFLNc+8NIIGcYkiyT4TwR2gaYTgN0oGQyFnAarzUV2ynhcJqmUItsflPx76hNzWRmiBz3prpT5UNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNZaPenW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cea34cb57so1656264f8f.0;
        Tue, 01 Oct 2024 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727829089; x=1728433889; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZaRtC1LRF0TOFIoLk9DwquzMa0BVTM/kQCQmKZxpW0=;
        b=ZNZaPenWkM9siX1VAcWlkLGQdt3NQPMDmIZO3HGcwraoNKxH1M9gv9x2OkrhgtJDXO
         pg8j9QSgw2gWKBIwwsa0hNYqDmFJhQHUT84Is86hPX1szkY9xwnaHrUkKHwE4vb6c3S3
         FXCUHgfyw1OrVHCdUG1yrjnZWSeDHgmUQkCIokXjN3fJYK16lq55ehhaO4Q5GliBnazq
         NV59x0P98JBzeR/w83xrJ3lf2v/KPZxCyrYSkAhXVHLlu1p1+NeBCxXlSy9rVEXcs/S/
         yH0SoLvXDrbGBvpbsDdd/0B5+G5KgPRfXw/0J3r624HOo3vB5Kj563doeGbZ4IRvAPTF
         ui7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829089; x=1728433889;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZaRtC1LRF0TOFIoLk9DwquzMa0BVTM/kQCQmKZxpW0=;
        b=PhnrhykgbZfvXPTVU1iWMiAKLAYPxTVDGT4w5f1KgsDSE8aoABsRjcUIDnZLCZBngD
         sCPCO9oFrkOMReqYu0xY6dpEvDcuCsxeYLg6GFBKFBNcyAfhWN33ema8OCSs5Be4tqZJ
         56UKkbIGUmIacws1If17lAkeSSHh/0bdYz+kGrN9uAKg40PsT5ATX47bEigOuZWvRt0t
         jXj1znnIZZo+/mESQ9W0S5zfh6HkTXPw3s+dn8xPtHdavqkeyQTAQp2P34c7O7hM3b1V
         QhHyt5CsemZchBvwMBO3AFQogUxcc3PfKqQ3V0Xw2TA+ay1ZBiiZYBhKRt9d2NXHvYrb
         7xhw==
X-Forwarded-Encrypted: i=1; AJvYcCVL44Sq7yCGLve9SeJdWnYqy9mU+ny6MAX1NrZD0ZZYY3hkKisUwGjQ+tbQyBB+v5tdWorwuAqlYTT7T+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymvK2aFSYHBYknSHoRmuYT5Ero0lvL6FljpD/ltX1AjU3ckram
	Y16Fz0zDgQ9AJLb6kTXChjdQbgHlJQovD1FedNXJTSf+jI2ZgAPzzSuCRl6S
X-Google-Smtp-Source: AGHT+IHUO5IahAekWISY1E/QRmLKBkleYQ3iRLNiLk1ShuM71oM3429WPctQaf4ZwSjz7egCSqfoIQ==
X-Received: by 2002:a05:6000:50f:b0:367:9881:7d66 with SMTP id ffacd0b85a97d-37cfba041f8mr941557f8f.41.1727829089151;
        Tue, 01 Oct 2024 17:31:29 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-325d-7a87-742c-96fa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:325d:7a87:742c:96fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79fc9032sm3715055e9.25.2024.10.01.17.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:31:28 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 02 Oct 2024 02:31:25 +0200
Subject: [PATCH] hwmon: (mc34vr500) Add missing dependency on REGMAP_I2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mc34vr500-select-regmap_i2c-v1-1-a01875d0a2e5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFyU/GYC/x3MUQqDMAwA0KtIvheIqWXgVWSM2qYuMJ2kIoJ4d
 8s+3887oYipFOibE0x2LfpbKtpHA/ETlklQUzUwcdcSMc7Rdbt5IizylbihyTSH9a0cMQUenfO
 Zn8lBHVaTrMd/H17XdQMmHdh6bQAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Mario Kicherer <dev@kicherer.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727829087; l=1141;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=JB4d9QpqOVuAVtei3L6EtIsV9pyuYrlIUMt3NFfmuUQ=;
 b=OePtApOXiqFLmH6Cqq9icj8X3w3BzRQuW7mqLvun9bgiCFbRJszVrCygjOEfl9O8SkR2E5s8h
 JSlAKM1vmQzB9VJD/TYx73GMS74xT0kJru5iec31XNBag4O+RuhVyVh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver requires REGMAP_I2C to be selected in order to get access to
regmap_config and devm_regmap_init_i2c. Add the missing dependency.

Fixes: 07830d9ab34c ("hwmon: add initial NXP MC34VR500 PMIC monitoring support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This issue can be easily reproduced with a simple config that includes
I2C, HWMON and the affected driver, but not REGMAP_I2C.
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ecf09cd2510c..0e7029d0176e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1275,6 +1275,7 @@ config SENSORS_MAX31790
 config SENSORS_MC34VR500
 	tristate "NXP MC34VR500 hardware monitoring driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the temperature and input
 	  voltage sensors of the NXP MC34VR500.

---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241002-mc34vr500-select-regmap_i2c-da2b335f27d3

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


