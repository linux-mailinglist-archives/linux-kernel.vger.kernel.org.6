Return-Path: <linux-kernel+bounces-518879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F58CA3959D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95EB1891753
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BB22C325;
	Tue, 18 Feb 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCranDbh"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C622B8B2;
	Tue, 18 Feb 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867851; cv=none; b=DJ1O/IvEOQf+yI9Y3y1gmodHiSt67u2XFC0pJb2yVRhMcNqvhh9n+Z89QKsBSJe3Xf8eie58tv2XZujBP6PJOTzMshgYDcCnhMzjRFhjMicJDy4RLU1f5v0bHFbcHVjT6DHPvbjGYe2KZLao905O+kyRUAqArXo8wkvBmzyHqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867851; c=relaxed/simple;
	bh=rdgpo4XKxysxQco2x0SFtuaRS11Q5R7MQdDhUx4X5V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J23hVTfZq2VfAy5eKurxhL+Bicb87/ipwOwtOmTsl7SdljFLvr+nLduLwuoH2zFieOiUYGij6vGlR9OaOp8VPOdjPm/YogEoW/3n8XVss/PisOVhP0r3mabycLVSEJFF3XsCCdacpeNX+T8o4Too9XOF0dWRgeZ78RRGspbAdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCranDbh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2210d92292eso68947715ad.1;
        Tue, 18 Feb 2025 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867848; x=1740472648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4W1nmesNsVd9HtjqY1pKAoaSwbEZBLcLQfWZxRu3Wo=;
        b=LCranDbhsiKf+YXMuiZYK0+gOW6u5VttATuDT2hHg+yuW1M5l8TmBS6nFvaxDSLaYq
         T4Mf5EVSZapKM9rEBp2sH1wheAmR9sp9RxYFcwwjvUdEOLjCNBA92HK6k9qgx2ftzd86
         w6KlFptTiHWxVdtXbzdGT5Gy5qYyv6j0oBdF0Pa76Z8kNhTtOV+JJOuunGxAv8yE5pX4
         lnJvm0yRTIOww7AntKiz+AsKxMbMSvXEFACR/tT+bm20pUZow+sWqbL4Jpefo5Wmggsp
         Gg70Hx5z+2+yOQhHefy7Y0v3UEZ5iijCxr/K5EjfBDvL0jjyCTOgMKkWDqgrp+wIlz4l
         8eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867848; x=1740472648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4W1nmesNsVd9HtjqY1pKAoaSwbEZBLcLQfWZxRu3Wo=;
        b=Yr+VTOPeCIz+c+J3Fe7wztiLmQxBHdIHSRdl1O2/8CEejFIXT+IEvnnGCZPVUFbQZ2
         6TRyIigWedexB9XUzQ5JUbEkh+d/H0D/QMjXRwyiRa7mVg8E4rDiKHrWiAL/V6oQN2lS
         GN615WQfU3ltvNf9tY9T78VMYZFg+rOiUufpfHMrwsDxnr4yXal3F8uN1L97UNiyrn67
         gSdD6nS1eBTvtOj3HTIRrjuJvgzxog0q1vhI1rNlm3cAO2jrYkSmN5BB23y+GwrU7wKH
         NeC5hwF+mQWZICohlE8ndE7myJ4zkw8L8u3ep1YuviG5u8UenLPcrlCRruAW5t0wMY7r
         HKmg==
X-Forwarded-Encrypted: i=1; AJvYcCUEg3O/NQhZWahOMXuQVcv2KDdJZG8azHk5to8hBsHx1Lo1wnHa1Rz57EdOdyD6ed1Yn5sYSkzHr51t@vger.kernel.org, AJvYcCVRmvH2ngAWThiuQWBAoQytd3b2T4WqHo09azrhy6nzgTSlt6Xco/DJq+e5FxU+hiRUn/st/DaHq0Kpam0=@vger.kernel.org, AJvYcCWI3BfbEN1XZxVnDZKQhRFRkt7jifxfTZ7i05Q0Eos4A/+6L9FTNeT5V4zDqKLun6ndmZ2uLknKTQraWzE=@vger.kernel.org, AJvYcCXpSH0E847p3JNVXtnl4Nv3cjQ5VeoWGgZY+4Kgq4IQlV4N3KRK5R2bWxiaoaoyRleXZy5qcwJ47Byqcc9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpY7CU5zJw3RYCk5JP3IywrdJkGYBs0pX6fUiCVxSQLBfOa3s
	DWBApEDmgdjKqgzw3DT7epglHg/aeTncqKd5RGM2IwW9ahZajovJPjuamzjW
X-Gm-Gg: ASbGncsLP0C9PNUrS5zLsl5vjWb7t8+DiLjz9o2XNIdzdTYEHllwp++h+tTMXsZuA/Z
	9RfACp0UvSvtvn8iR6D3WO8kUBkYzEXq3e8g2uvaH0gJ4HMfs78YSUM4wgABvFAvf1CgZvhU8C/
	ZjQwYKdJUxFwdn8YYTjCjhw8/n+/7ARQNCLC8bcb8XKHqT9RVKjoBlf7giwUC4RFzcRTAhW85LR
	pzibM6xS2artAh4kMBi/JBPlAqryJtFJ+BUMVkTMHduE6cITGL4sjxJh1GKfXg4ovxoo1nprC+j
	ou2XA+CLuzT7bCvoQN7cVM9dv31l1pJqTfsDdMsGS9k5W+xIomODO24//b7ylA7wIyPt4kHw9o7
	cnNcdl25sOA==
X-Google-Smtp-Source: AGHT+IGxGIIJPewHLSEPggPPN3s8vsAiXTlTsakBOHSx/c9wnfXAS+iDlEn1PMfPO7KvvnaAb3yReg==
X-Received: by 2002:a17:902:dac9:b0:216:48f4:4f3d with SMTP id d9443c01a7336-2210401a706mr166713985ad.13.1739867848565;
        Tue, 18 Feb 2025 00:37:28 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:28 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:46 +1000
Subject: [PATCH v2 12/29] ASoC: tas2764: Raise regmap range maximum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-12-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=E3fgZXeyxHCmx5TkNj8oGEVwOZCR+iEFAFUx25XBj1E=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BIkJHkvlWya/UReSkDm5PuHz9TKtm2b3G+yYcGc1
 CO9u1UmdJSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjCR2V8Y/jupMuUuq7VWu5Tb
 ty/HT372HyFTDrv66NUN+ZNCT2zdnMLIsI494rNGNedruyz1nbdEpsisqu+6/zA3VuXYtvWfxKu
 L+AE=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 898a53f7e033c73b949cc2f6be188f4e32b4f19e..13c7ab7ee1f7a9e1224804de034466ef8bc1bf06 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -726,7 +726,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 	{
 		.range_min = 0,
-		.range_max = 1 * 128,
+		.range_max = 0xffff,
 		.selector_reg = TAS2764_PAGE,
 		.selector_mask = 0xff,
 		.selector_shift = 0,
@@ -758,7 +758,7 @@ static const struct regmap_config tas2764_i2c_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.ranges = tas2764_regmap_ranges,
 	.num_ranges = ARRAY_SIZE(tas2764_regmap_ranges),
-	.max_register = 1 * 128,
+	.max_register = 0xffff,
 };
 
 static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)

-- 
2.48.1


