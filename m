Return-Path: <linux-kernel+bounces-346890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E298CA54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E93AB22BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11ACD529;
	Wed,  2 Oct 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pakbrvts"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCEB677;
	Wed,  2 Oct 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831304; cv=none; b=oOCD08SO5vA4a7sp3K32mR5eiLIJzmAcUnEs3p5W6GvgS2aox2wt4ikGAh43BUQvcsKGHhPMuHAb5YT/x2kVgOhBvaNMxfjPznrVR8Vp2eR36KWmRgh4gHvF0nPRskCfdojlQbNn6xM4BA/ba3PUAeFeWHzGu685YORYM35DlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831304; c=relaxed/simple;
	bh=BvROhLzUVg2jOrnHXF58T+Rexo3k+ZnokgA77rIFalI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHZGGGqF2oXhD0ttktq8IrtrGv0ku3TyoBalDX1+YPM4oskRjujOy75NuU9nclJOSVV5DpVh8YizHYabQ5GmxF8j2KERxJe6VDwMBZx2+ALJSzJH1G7OSaEo04ApdjbOIxlTmWzWNZp/QilVtWxMdq+xnqggr2Z17jrTurl093I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pakbrvts; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso67050395e9.1;
        Tue, 01 Oct 2024 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727831301; x=1728436101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCyX2sJF90BSkHkRY4Uogc8nbVCgXYScm+wjyOe8uGg=;
        b=PakbrvtszbBr+WYmBwoTYXLTCa1+NFdFEfHgowgjLC2zNMzwL05EmyjmAYoXJr8Ca3
         9Srh3zfvPkLkCRGGzHT+is3DJyVlSvh8IcMLX40zNVSx+tIrq3TOXy+2ksvQ5+mRBaxI
         jUd8jnpGW+HtShFSUzNtV6vHpSR4ECLsJ3e+fiz+2+C8AR6SrLlU2MWecNF6vvb9+Caw
         kXdaDchegEuFoAB3/t5Wtkv3nlkFtSaoeWOd+XgQ3xgLkGtubcibGcq/eC1hk1XmnFOK
         w71nlBHdbVJytdPZSfYDyFebc7vtQcPUwHmfRc+fVR5zs67QirKa92UzblPron/56sRw
         FNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727831301; x=1728436101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCyX2sJF90BSkHkRY4Uogc8nbVCgXYScm+wjyOe8uGg=;
        b=SyeUYXar3iN6FB3U6Rng7mvi7wzsWG9id/pbNGyBpDYtPDp4rbiSapqr4XODoZs2xH
         VekQxTtNL1WZQNCHzdI/wGqEbsH/S7n088SbEaBUOvElORcQgg6G63H3bbZdHeXosJVT
         ngcmpaOOnCCYD/8KaXqTgiqMv2i69Xx4C+DSy+0jG0WYANfDVBcswmhw0YJQwtrJfsHn
         BkMU9PERo2dWYzuFlITf2sldoBHHtgy/7It1T7G7/OZ7nNAG4fEYmRMpOT1zkRYAKaLe
         LA+y24ElPbPCEYMqJfl4GphL5QnX10+e0oWuBVxGfn4X4ntEZwc1LqdFUZ4kG1ESvqyP
         uYBA==
X-Forwarded-Encrypted: i=1; AJvYcCUbxz+CWgBo0wGvQ+Mipr3p5bs9ygf5q8QDTUdLe60+HJcwXTUkfWc8oxN/3wF/DJsSK9rtVR136clfh6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYx6mvZnfciP6PNyoC0EK8vSgFnUdg1t9AkxOkHxBBh6VdZlu1
	46b8FXzHfZeikFATZ3RYlK1UWm3fEkc8gCGsuBXfCwpQWNxeJnNK8kzz+QTw
X-Google-Smtp-Source: AGHT+IEuCRPS3pFb15G/xAaJf93n15oZWqmxzwqLLonm14y5FDJh9MrW+bcW0+f3E7+AFiHVZTgMIQ==
X-Received: by 2002:adf:9bdd:0:b0:37c:d123:f3bf with SMTP id ffacd0b85a97d-37cfb8b5697mr1284572f8f.3.1727831300848;
        Tue, 01 Oct 2024 18:08:20 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-325d-7a87-742c-96fa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:325d:7a87:742c:96fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e89b4sm12881345f8f.53.2024.10.01.18.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:08:19 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 02 Oct 2024 03:08:10 +0200
Subject: [PATCH 3/4] hwmon: (ltc2991) Add missing dependency on REGMAP_I2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-hwmon-select-regmap-v1-3-548d03268934@gmail.com>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
In-Reply-To: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727831289; l=802;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BvROhLzUVg2jOrnHXF58T+Rexo3k+ZnokgA77rIFalI=;
 b=3RwUsQh+HkU5fxHSLjlZb5EraOmhz9vQDHDDT1Qdv89W44x01eT8HVH8bebfADh2iOhE/pbMY
 qbLH/8sxzSNDrma5w8dxbsUVNieVfROYQbwxpXyNu/LusGzBp7QMzo3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver requires REGMAP_I2C to be selected in order to get access to
regmap_config and devm_regmap_init_i2c. Add the missing dependency.

Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d4a9440a5fca..5152c71402ca 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1001,6 +1001,7 @@ config SENSORS_LTC2990
 config SENSORS_LTC2991
 	tristate "Analog Devices LTC2991"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Analog Devices LTC2991
 	  Octal I2C Voltage, Current, and Temperature Monitor. The LTC2991

-- 
2.43.0


