Return-Path: <linux-kernel+bounces-243560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3F9297B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB25B2102F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D711CAA2;
	Sun,  7 Jul 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzQdD2NU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240F182B9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720352911; cv=none; b=lMiGMWzJBaz08usrfcv+shJbn9czaMeg5VluIURNEusSUI1zqeQQDBg2qrryfBCw8U234ez0ylsDOtTZK4vId0n2tc8wVSjMlFecxP5oE1Q0gkafLHXPCmnN6WDzjXiPOaXVQWup4uu/qtdBuFQxxwB/x76i2LwcARBdXpJt+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720352911; c=relaxed/simple;
	bh=7eU8XTYpAySaDWihgO7C8HhhZ+TbK38DEC+5Qtw+YuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIWSv65dE/bDTdFa/u0zKDB4t4ABNUS9Hws3/W14dxQzUfw4YwwctoeenAly2SW/NyKNpzgWdjeoy6OknVtBg4r7UaQKEZZcW7mffV7RYddPv3INoXu0BporOSQCGDvbLr/LbVoDx8xc/QoEEZBQbk/KFOu9hbFS6g73WGZFHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzQdD2NU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42662c21289so4334645e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720352908; x=1720957708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ4/E9J4xI4cimYcWsERwrFehVb+qxmPhq/NewCkOwc=;
        b=fzQdD2NUB7HwP2w80HQ9u6vsWgkrDVd37zDC3OfoCXyGxLxWY7OFZ1MGWgCfTnSSgH
         jwVfaUMb4QwYA6lioIWegXSIl0QXTs5/X+S4oJ1rVsLUOUUJtHm4QTupU1+1x6u5HJEG
         5ZEtSNalFxDugo8OuB6v+J26DopZNhrb4C1MJKkmqgwMy5DWuu2hRg9OGkKOqomebZth
         2HNJFUZ/wabiATzwlTAQJgRfsL/+XNdMft2Vqi1gXAY248wpU5+R4MboGRRDy9Kz3o83
         enTjxDlF5LpAshjC+HM+RjyICZcinrQmy7URCyJMvZBxnqr2PWaZymr61zhVnOepBOnl
         SNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720352908; x=1720957708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJ4/E9J4xI4cimYcWsERwrFehVb+qxmPhq/NewCkOwc=;
        b=lWRASzVncwTQHFHRO7lsWXmdJlcUn14GJKmWu2iR+Hznip+Q09YRU+YL4jxyiJEEpa
         QXTUJx3KGTpk3l4Z7GFrgWgsQRc8pmJoaSTNyeHTknX//D0ma0ducBSOY0/7zC4acyYI
         TMETNOH10pco7cEIsrbqnu/03duYZOiADwXhKI+v8MFb0/P3J7wjRMCmUpt9JAj6ratt
         9KqH2QAM00vRqnvV0yrgUhNlQTecHd2cski8OuAIyt7JEgwnM3mILhkcooEaQlz6mTmm
         k6thLu3hrqmYDWF+G2jYn7jy0SELcNyfSrJuux0oPpgVbnHXv/tuqEboVRMBVkkx9dPQ
         HPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlBK97QLFHMW97CM80MyHVAELBP+txSSU5p5zIJ1cCebo2reGnZt9RtndPLkzAkcat6itsUY6XW76RKzQUE5cJ7Pp+oww6bXXMI8ID
X-Gm-Message-State: AOJu0YxO+MZDgY9bNWDZYlaMD9IHUMGFFzpfgaG7L14ZmgVC/YFF+JYu
	W5jFfDbG6nQ+10ZvQuc4/3WogPM0OnY7+gFY48bVC38vcts3UagaqFIoBWQ7kaE=
X-Google-Smtp-Source: AGHT+IEI6lDV64Hl12cyK3t6agUGUkDoFIW2n3pq5pOaxd9XBSBXy4giAuXzNO3Rsklt90kI7V0pLw==
X-Received: by 2002:a05:600c:1d90:b0:426:6960:34ac with SMTP id 5b1f17b1804b1-4266960362emr1276995e9.36.1720352907837;
        Sun, 07 Jul 2024 04:48:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367b09401d3sm4926279f8f.28.2024.07.07.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 04:48:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] mfd: mt6360: Simplify with cleanup.h
Date: Sun,  7 Jul 2024 13:48:22 +0200
Message-ID: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/mt6360-core.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 2685efa5c9e2..b9b1036c8ff4 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,6 +5,7 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -404,7 +405,6 @@ static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
 	u8 reg_addr = *(u8 *)(reg + 1);
 	struct i2c_client *i2c;
 	bool crc_needed = false;
-	u8 *buf;
 	int buf_len = MT6360_ALLOC_READ_SIZE(val_size);
 	int read_size = val_size;
 	u8 crc;
@@ -423,7 +423,7 @@ static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
 		read_size += MT6360_CRC_CRC8_SIZE;
 	}
 
-	buf = kzalloc(buf_len, GFP_KERNEL);
+	u8 *buf __free(kfree) = kzalloc(buf_len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -433,24 +433,19 @@ static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
 	ret = i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size,
 					    buf + MT6360_CRC_PREDATA_OFFSET);
 	if (ret < 0)
-		goto out;
-	else if (ret != read_size) {
-		ret = -EIO;
-		goto out;
-	}
+		return ret;
+	else if (ret != read_size)
+		return -EIO;
 
 	if (crc_needed) {
 		crc = crc8(ddata->crc8_tbl, buf, val_size + MT6360_CRC_PREDATA_OFFSET, 0);
-		if (crc != buf[val_size + MT6360_CRC_PREDATA_OFFSET]) {
-			ret = -EIO;
-			goto out;
-		}
+		if (crc != buf[val_size + MT6360_CRC_PREDATA_OFFSET])
+			return -EIO;
 	}
 
 	memcpy(val, buf + MT6360_CRC_PREDATA_OFFSET, val_size);
-out:
-	kfree(buf);
-	return (ret < 0) ? ret : 0;
+
+	return 0;
 }
 
 static int mt6360_regmap_write(void *context, const void *val, size_t val_size)
-- 
2.43.0


