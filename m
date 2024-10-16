Return-Path: <linux-kernel+bounces-368833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A076B9A1567
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B662F1F21DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F961D63D0;
	Wed, 16 Oct 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLDD3jbJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0131D61B9;
	Wed, 16 Oct 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115898; cv=none; b=PczPXd19AbcMbixALgYqN5h6GNplFls01ABsDC45rE9n0vRz09yYSn53hX1egcjsRL3s4ypyawtTF7mBg4ndrDYmiS5NKDPHc7cJySyU8AHqthQw6/UATFGwdzG6Ws0CEATGj3P47f2X+iA+kFCvSK1+O/3grEPS9zsAlmbCu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115898; c=relaxed/simple;
	bh=GCWSI6H+e7J609h8uqCoIHLZm2S86TshFuKVLxQwepI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ok97IsdWqxNNAXF2pSKBlfnBPnXSvQJsxyZMOOMDoS45J/FyvSk1Df7FbqlwhCER4AQOTo/puEFYnJn7wIqRx6hvAV2Y+yVkZMa/W7F7drXlwZIzgA3kJKgx7nBwe6RAY63kyWpKDQizvJtGrt0ObhDnYhxzctNadL6zG0u5vXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLDD3jbJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a11e7so423859a12.3;
        Wed, 16 Oct 2024 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729115895; x=1729720695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YXjFphjc1IXQr0clE4Kc/JzIAAvDawGyk24jtjb2XPQ=;
        b=kLDD3jbJXumeu1ma5kEKo5wlJvKFP/GQ3nDVehUOey3T8FbMHRSs1e1jLVgNWMPFAE
         te5SAS5SaMDcvqEnLZ8cqGoGN+1Ppi1U0FLgFFmcFhJDl7huu6uftlp7Owbyxni0R1KC
         MfddN8H6Vz/08MJS6LtY2eaGMF50J20rBYHScpuLlAEnxdCmpXuCGOL4dVoKMOGW4jtn
         eswZfqHXtRAJys88VRuPLpb2P/SyTKZTwgQqzkJjXY7QGjbMde5+D7jqPmzgP1A9RBMJ
         l3pxA3PF5tUKG5zm2TQce8r6gnNx+pdqnN0J0MTxfOCT2+nXW3t45VRT7SPpofWWofA/
         nC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115895; x=1729720695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXjFphjc1IXQr0clE4Kc/JzIAAvDawGyk24jtjb2XPQ=;
        b=qGW/xXtjzRCP3X02SjHIxG/ZU99necXg7T8QJU0mH9LnTEVkM4M27MfQ+iLWLIAg32
         YOJQeyrUEncy+PuvE+PzX8qliC3uz/LkSm3VRkWv5G9aibeKlJa0hXj1mpjH2gWCfKJK
         8+fX/F7E0RJI8vOcEwLQ1mTIj9DIa/QhDvSeZcSH/urV/G0E1bJn0qyJnIzIXsFbqDjD
         h241E1D8iAJY/seUBTIWl+Zjkzz86yaGNlasNArfnkMeaizGIzvCdoiJkzWUwwXftMA+
         +KVwOufIrUC+KzgwsoKBwHJWbAvG7YTdDKSmX+aZHa9wtuEbqdHmZTH4kvjUIS3s2Ty1
         tfAg==
X-Forwarded-Encrypted: i=1; AJvYcCW9TXUEEfGsByA48Y1yr3XRH9tzEnpKgV67kZP3oW9AIa9vAbju20knF/3y4mCf5tcGfGWIXVSWE3xLQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIkIa8Cc9coh+GNSomUa186ikYp92JFY/NGuR3X9pTfYmn+6z
	dYEe6t7PsLyNGvZ9PM6dhCNm20XFhXxNw+yl7WwY/pFVs+uYxY91ZZkMMLTg
X-Google-Smtp-Source: AGHT+IFmtx1A/qyl5p7ivfeAnS1HERBrfPYFB3lTRAjM1+C1T1GoJMZdp3Q2fG3znPNHUSxXVUBHQA==
X-Received: by 2002:a05:6402:520f:b0:5c8:9624:326a with SMTP id 4fb4d7f45d1cf-5c95ac15955mr14380946a12.14.1729115894582;
        Wed, 16 Oct 2024 14:58:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3102-4c14-3e00-7de9-2a44-7a4f-6228.310.pool.telefonica.de. [2a02:3102:4c14:3e00:7de9:2a44:7a4f:6228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d779de7sm2052305a12.63.2024.10.16.14.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:58:13 -0700 (PDT)
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Kirill Marinushkin <kmarinushkin@birdec.com>,
	Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH] ASoC: Change my e-mail to gmail
Date: Wed, 16 Oct 2024 23:58:10 +0200
Message-Id: <20241016215810.1544222-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change my contact e-mail in pcm3060 driver and MAINTAINERS

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org
---
 MAINTAINERS                    | 2 +-
 sound/soc/codecs/pcm3060-i2c.c | 4 ++--
 sound/soc/codecs/pcm3060-spi.c | 4 ++--
 sound/soc/codecs/pcm3060.c     | 4 ++--
 sound/soc/codecs/pcm3060.h     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..18b484298f71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23292,7 +23292,7 @@ F:	Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
 F:	drivers/iio/adc/ti-lmp92064.c
 
 TI PCM3060 ASoC CODEC DRIVER
-M:	Kirill Marinushkin <kmarinushkin@birdec.com>
+M:	Kirill Marinushkin <k.marinushkin@gmail.com>
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/pcm3060.txt
diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index 5330cf46b127..3816b25a8ead 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 I2C driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
+// Copyright (C) 2018 Kirill Marinushkin <k.marinushkin@gmail.com>
 
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -55,5 +55,5 @@ static struct i2c_driver pcm3060_i2c_driver = {
 module_i2c_driver(pcm3060_i2c_driver);
 
 MODULE_DESCRIPTION("PCM3060 I2C driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
+MODULE_AUTHOR("Kirill Marinushkin <k.marinushkin@gmail.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
index 3b79734b832b..6095841f2f56 100644
--- a/sound/soc/codecs/pcm3060-spi.c
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 SPI driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
+// Copyright (C) 2018 Kirill Marinushkin <k.marinushkin@gmail.com>
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
@@ -55,5 +55,5 @@ static struct spi_driver pcm3060_spi_driver = {
 module_spi_driver(pcm3060_spi_driver);
 
 MODULE_DESCRIPTION("PCM3060 SPI driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
+MODULE_AUTHOR("Kirill Marinushkin <k.marinushkin@gmail.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 586ec8c7246c..8974200652e7 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 codec driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
+// Copyright (C) 2018 Kirill Marinushkin <k.marinushkin@gmail.com>
 
 #include <linux/module.h>
 #include <sound/pcm_params.h>
@@ -343,5 +343,5 @@ int pcm3060_probe(struct device *dev)
 EXPORT_SYMBOL(pcm3060_probe);
 
 MODULE_DESCRIPTION("PCM3060 codec driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
+MODULE_AUTHOR("Kirill Marinushkin <k.marinushkin@gmail.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 5e1185e7b03d..1b96835600b4 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -2,7 +2,7 @@
 /*
  * PCM3060 codec driver
  *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
+ * Copyright (C) 2018 Kirill Marinushkin <k.marinushkin@gmail.com>
  */
 
 #ifndef _SND_SOC_PCM3060_H
-- 
2.30.2


