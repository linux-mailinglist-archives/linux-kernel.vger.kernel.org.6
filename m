Return-Path: <linux-kernel+bounces-346891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E19298CA56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392281F23F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCF4400;
	Wed,  2 Oct 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcofwGvE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A5FC0A;
	Wed,  2 Oct 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831307; cv=none; b=PmtzyJNy9X0gLRm7UEFjhEue8dDzLgOtK0tCR5qRhrqTS6EzvRih4H98jBxvICoXqqqUQ386YysFRu4bZlRi9mHn5MAJrC8ilsovIKwenHlkcHJRi80UUKIlSmzraO1t2hh8frqNesYBNTzMxr+otMPIL3lOBQxS7zSmI/Cn8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831307; c=relaxed/simple;
	bh=snkJ3nSwFJwgGXH0ji1lCUUWy2XEwb+19koyTKj22uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozAzJSuJIdaLeeNbpymLUsZq76Fv9la7BUdBPO6cUclhVtgMwgXjPQrekRIbhZkVo6urv4B36d7Uq7RRIGcVn5QKFZ+uXpW+jJHLDgGet9pGNANlE82qjZavPtrtKdxmpRDUHYblDNAQnIs2sjSt+1y+V4PDM71XF+q6F0S3wL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcofwGvE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so56090645e9.3;
        Tue, 01 Oct 2024 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727831304; x=1728436104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax2FrHt4UFk1dnvLO7sYBILw1D1Td9yJ4ERoVADW/z8=;
        b=XcofwGvES2ZZ6N1T45Q87vq5s9SI8HY4xGLOncjvpwgV0mIrp/+f/tSrCBAsiLnGPu
         cMqsw/3HqYfje06io+qoFpuz66JYXAraVKKuUQdGxocePR6m4zH6sHMGXN5HKUvR/f7z
         0K/DuRL3Z3tkjP0ImHK79sUWwhgInzRps7lnARtUFdcsQKMXhS3K1J6HvHURHKuQhStA
         k8bQWtvFb22PT/FOh5jWHFJ3l7aekrt3loUwbCJu3WC8lRpvRWlzjNnJhByQRkPmywII
         MR7QWeK9n6Y8NNyTM31AydpIg4ml33V/AKTylS6zjAMtD72a7DNRmwjsrVri1qK8pWmC
         819w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727831304; x=1728436104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax2FrHt4UFk1dnvLO7sYBILw1D1Td9yJ4ERoVADW/z8=;
        b=Gp+kKNgqI5jImn5yLXvOPK9WB211aOaP4SHID3k2TrWgMEn0G591cPMO2M4says5BY
         MdRwxb4bNLfR1j+Tecj2GmcF2rzDXWJdRNnjWHqOK1JNUEGpuA5jsVXeX9kZEvAA/dH5
         jiTvLIMqTEBpG9kp3fDf/8ol1U4fCfpmtV5FH6Q+RBWNAt3ePWm9C1fg5XWYSFLy4ic8
         KyTHqw6VZON5EK8Rw078R61AInwBQkUXpOLRp3gqex9WhgUVW9JLirOuq50goNEhvmTI
         5FcfHjuJ21XgJZGx6S57pVcIeUpPnTaXbcKHlWaXXHf0cD9Z2jwc2AeaMSGMf/DdOZW/
         slWw==
X-Forwarded-Encrypted: i=1; AJvYcCUS/1qZBc0VcS5kYuIYfBpVA6+aqTKR4YXSQdqRLFtOaUzsNPvA5qUIEuFGZTWy5QvHctrqPKdDOBsPBLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBuHAEQfGqziZKHI3vN5a8Qn72qTD1yPFkIEpfxDnVSwvC2B2
	3r1z0OqnEoUg7oUsYn5c1ERbrJlsAWeVM7FLm6gYAe8DDsAweZLO+b94ml5g
X-Google-Smtp-Source: AGHT+IFkSYFW3H0yzZpJUoxdGYcYZw5XTH+EB3G6HKRocpBaJ07TW8MdTpHXteUVupjlD0S9jkfXdw==
X-Received: by 2002:a5d:62ce:0:b0:37c:c628:51bc with SMTP id ffacd0b85a97d-37cfba19bf7mr599529f8f.57.1727831303830;
        Tue, 01 Oct 2024 18:08:23 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-325d-7a87-742c-96fa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:325d:7a87:742c:96fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e89b4sm12881345f8f.53.2024.10.01.18.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:08:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 02 Oct 2024 03:08:11 +0200
Subject: [PATCH 4/4] hwmon: (max1668) Add missing dependency on REGMAP_I2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-hwmon-select-regmap-v1-4-548d03268934@gmail.com>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
In-Reply-To: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727831289; l=780;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=snkJ3nSwFJwgGXH0ji1lCUUWy2XEwb+19koyTKj22uc=;
 b=3uLw60XOrMtCFa39EYNDnfeUWu6WnAW/sQ5G0AGgSD1sEq9eoBNZtGZkdfFRuryuG5IAExJdY
 ipFcpS4vNinCnTK4OXcpkxgCRTtaC4WICAQqaLRePjXVoYuP31kPGvi
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver requires REGMAP_I2C to be selected in order to get access to
regmap_config, regmap_bus, and devm_regmap_init_i2c.
Add the missing dependency.

Fixes: 021730acbca6 ("hwmon: (max1668) Convert to use regmap")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5152c71402ca..92d051dba52f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1149,6 +1149,7 @@ config SENSORS_MAX1619
 config SENSORS_MAX1668
 	tristate "Maxim MAX1668 and compatibles"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for MAX1668, MAX1989 and
 	  MAX1805 chips.

-- 
2.43.0


