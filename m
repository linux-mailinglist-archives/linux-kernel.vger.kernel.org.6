Return-Path: <linux-kernel+bounces-536243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A70A47D72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805B47ABFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873B2356D6;
	Thu, 27 Feb 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxX+lXIS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D02356B7;
	Thu, 27 Feb 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658220; cv=none; b=ZB6XezA+5peetxSmIYFoErjJimqYDb8i4LSRgQJmzVOY2DhOIPAvBGrSKQHsvQbXjTbhZAS+nOsXL53f+5ddZTqgOinVoEDUOayXaG5s3VXsl8e0TQ9Eaq9F1jhLjeLHBW2HSuq8DdNvQZ0z0O4VjqJQjL4pHjzciyNz6Iabkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658220; c=relaxed/simple;
	bh=7xShCpFQdJUb4D7S2QF+bNsOJUNFCjq4IHatgwNnvKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6++9Y1GftfjaWwPQgyzIqMpUg9tds7y77hRLmBwViHoxVQCbzNwbakIFRmR9F+SPelCk/gmkFTT5zWXjvo3uflPjdEz1Yd9lUBa09r/U2qnA4mi0Re2Q4jDEg8oJw8LSzS24WDzEljOs4/yxVtbnkchAj1Eo2bp/nMklaIbqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxX+lXIS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f4dd756eso15506945ad.3;
        Thu, 27 Feb 2025 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658218; x=1741263018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGdcVF1u/KwGvbpKlJDcqGwRXZF3lOCOPum24pRSoFs=;
        b=NxX+lXISp/knMe6uvGLtjD2ZFg9T2euil2C3JcRTvel6y+Io7vf80nszh5ZxsCkCIK
         aSVf5P7C2/g5AQyiTS8p9wtMd4j4MEiMFec6BkUKefRyG75b9sdqJ8bbefSIpQg3UMox
         XW4UXP4pHqfRoDtpzSB3SnbtCZ6GAmQKavFl4M8herGknuIXLVvDaiROLWvS+yx/8VP6
         gD/zJwWjD3VFCnTGaSkS2FchawARGGeatmo1sioxVJMIRf/zq+MGeS/2q3JXg843hEHr
         hICLv/RwpqO7Isbkf0uwMWVPxVBRpZo4hubDTPwDLMTV3WzZE/t8iXFB3wPEWzTnDosO
         nvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658218; x=1741263018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGdcVF1u/KwGvbpKlJDcqGwRXZF3lOCOPum24pRSoFs=;
        b=TVw+nnuxLn+IiKvsE+QVnYQrCx6ivJHHRqaI6l1xrLuqn7p2Yg5K+TZgSH5OU13xTU
         aIQxlehlIzcZBitl6IC2kkapndVbMOnoJ0nwIoXF0qG1kKWqUBkwrKR1+7vGE30Td0md
         N5J2+C34dHc2PI1yycorClqbRhP79GKDUuuwkvD2cs/f8goCwaP5i2it1YWKRF6dZY1p
         heGBZ9HptXeyRh4WbtFMkCrU15CcLPM5pD1KrQdL4HaIs2rthJMC+DgrSPvQnbJ5RImz
         /J8qFiMjavUAkSes2URVJn5qnw2pV3npjBpp4p7NwjgWNDrmxU19VW2LAeLFkbAbLUUL
         nGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH2I9cq/o83IPG6ea5FP31Gch5UNX5ZeTchQ0voxbLCfBhrSjCp7bxcf5phBHm7O5f3vPEHVaSbOXrPKU=@vger.kernel.org, AJvYcCUkc5GLL7X7tctGMP1aUySqCro98bHujzuWZuWz/QgeAxxOwBwAZJa5FMrUAfaIK7TWizLM5WUAZm8M@vger.kernel.org, AJvYcCXBkhjNTxYL+5KD0Ib7JfGz+wFwwe+kOE2FSYNbuDGVQDZN4+640Oh4UrfoEkYwOjJ91KwIvGIacMqefLzK@vger.kernel.org, AJvYcCXDEq6r9sq83cx8JvBixNTCnKefNElKM+VSzhnXcnV7v/JNPXB7Wd2ODM2e0k56svzUxaeuVNF4MRMRXzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknihfdD/baKlB0n34gXJIKUtbGCAt3XQBX6N7JpiNQatuYQKJ
	uMTMeAJNUziLeIN5O2peVjB+ekQ8Y8b/TwU59xxBZL5so8g5RiKz
X-Gm-Gg: ASbGnculmOhFKNilVh+RnYKJHv+hTA4cTidz2MALyaq8nYWOMVtadzYPtMT/IfpQfE6
	y/pyV4o5eu9H1BTdGXSKLdlWDD4g3U2hZxDkdbq9hqAtPNEsdRt6bgzCwyapZWdKxHY84GuZQ3H
	oFvj3Xb6lI+eXogPAEYS/okHkMcJ9hhpf3a4dLLFRk161apEYVcpEWOZFjjkf/lttC+JOXpA4CM
	voKpJZ/8VYmsYiMktHt/sSEFbPMATR+hvLUTdqueJZQMihQjnsm32CmhGtuPMr9cbLrhqTF0Ph2
	vgaZbqTDkUVsuRPv0lfDr6nFwbZo2d71Cq04A86nhXsi70WGIuWfmVpqkwHBHpoGeX4apca+0hQ
	8Q4OZl56Tw4yLYH2YTeQD
X-Google-Smtp-Source: AGHT+IGaBznkzCiy9+ZSp/fE8RNqDYHrZCwjqbYYIAhATUT6oQrn/URzvxi0fsxxWKWSl1lxT66lTg==
X-Received: by 2002:a05:6a20:6a0d:b0:1ee:e808:732c with SMTP id adf61e73a8af0-1f0fc1394c6mr17968725637.14.1740658218202;
        Thu, 27 Feb 2025 04:10:18 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:17 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:38 +1000
Subject: [PATCH v3 11/20] ASoC: tas2764: Raise regmap range maximum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-11-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=xW12XaRnHT2CTg6ocY0zQAjiDxm2L8AJgzbe75kjokE=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk8l7RVX/dEQfX/+Y9l8nU//U5k26mpeWejeWvv2x
 xQlN+8lHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEzk+ypGhr6CfgPVD5t2V5ZI
 mk+ydfol7qlgK/HsDq/vVia1t4Zh6xn+2X05fjBSYeGf6qTsKSYTWXZIqu+taSr+WPeGUVbK4Lk
 MEwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

TAS2764 has a number of undocumented registers between
page 0xf0 and 0xff. These are used to apply in-silicon
quirks and workarounds at runtime.

Raise the regmap max register to 0xffff to cover any
quirks registers.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d21ad23f59ee1b393a27014d403dab1d99836012..0234a41deecd62e860c9d54a7a3206abc0bdac54 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -739,7 +739,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 	{
 		.range_min = 0,
-		.range_max = 1 * 128,
+		.range_max = 0xffff,
 		.selector_reg = TAS2764_PAGE,
 		.selector_mask = 0xff,
 		.selector_shift = 0,
@@ -772,7 +772,7 @@ static const struct regmap_config tas2764_i2c_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.ranges = tas2764_regmap_ranges,
 	.num_ranges = ARRAY_SIZE(tas2764_regmap_ranges),
-	.max_register = 1 * 128,
+	.max_register = 0xffff,
 };
 
 static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)

-- 
2.48.1


