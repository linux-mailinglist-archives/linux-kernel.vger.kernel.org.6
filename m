Return-Path: <linux-kernel+bounces-242350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AE9286F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28C11F22629
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F205414A0BC;
	Fri,  5 Jul 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+B9waix"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D8149C69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176066; cv=none; b=KT8Qza8Qt2x6ZoSscTn1UJd/RV3FhnPEr3kLRSR+gZrmYbc1GbLKCk+BQQf3gBKD0tARbO9EcWB/ZtgQhuMMqPaBvc9i2TF6UT+COpa8KwsLIJUU4U6Etw7YGRF9aYqZh2r/BvmW8THJi8+qWG3zF1eVT4nxYjgHfqmgOEwBXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176066; c=relaxed/simple;
	bh=Q9zojN0lSJs1YYfBNhUpVI/gmwKKpCb9hKgz9Y0tOzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEOznRfrpECqO8c337DNAk+p0HHkXHu1zDGYh+tv1D/yRCSoV6v50nz5kq2AJAiVFgp+I8lYPmNYgYYITwmMBPVrmGod5TSS3cNxkL8XzbpI2qPmVsN+bh7gaYAEFE3OxBC04HhcPG3ytz+W8vBRbD5re3zzeZ9EwtWr4IT5jmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+B9waix; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36740e64749so846881f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176062; x=1720780862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhWBPupwX+ZV/PG2cNtfNm2papiU6MGLdZkiMCHlF1s=;
        b=S+B9waixOtlwy3W2Nfl9Gw3htcDuSzJe0Is25UDUQJmYLAx67pF/b3ow5QtbksHgqH
         9NwFc3VOBmBd5Ln8W/Q+819nQcmoGd5/6l/9/lah5N3z4Id0HibendrmsZBBe/0GvsCz
         LnV9pPcxZkNxyIV0YyIsp7HxwjZOZJ3YvW3BxxW8EYetGTHxq6M3e9Jba3Pq8eTQeYmq
         sVC9NdiY8CY2vinXjerH9Or4pTRsyf1yj13uW8Xv0CVhVb2kYJWn3BSLUgZFTLGChVjT
         ABbcSgxsH8nMHIH6UB13bj/l8RoLTN6o6vfatlm7JFoGYDigKR9vN96gsA3VsCt7y0wz
         761A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176062; x=1720780862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhWBPupwX+ZV/PG2cNtfNm2papiU6MGLdZkiMCHlF1s=;
        b=tgxLQwATSmCKnhJEnNEkMha0HHe7HOYYKcC+xwFPDUD7FFnfv1IvqAWxEksenM+SyC
         kkok++YrS3ietzT8DvRoDTFNQ4MpueKyNJONuCtRtenKWCKn82697niHFib8yRIJQHKL
         EIXOoxFwKoRR0kYLcIHHVxz4KvahbHl7cwF/+GacHvp9GtpMPnnqUstXTJHIpJdO4X4X
         vRktPhGcurrXMvAh6hJjRQoIq4YPgF1u4fKMEdLTg2h7jaJ9s2+ZFbpyv9mqxB5R2V6C
         rqgroEVAP0BjbKRNuhKRCmLbYEAr1d7lv1Xx7vwQA3O6a03m6NIyyBZcxq2aYbVX6LCf
         Zj6g==
X-Forwarded-Encrypted: i=1; AJvYcCVftS8+0gGeOwEAUtuNdWQXtL2BV3a8WsFS4peaJ0NWn8wOtFIJy+dIIPO4x6pcuCqyev+jewL9vX35nXtbi8rcYtZTnJQ3VKFUcNqH
X-Gm-Message-State: AOJu0YzvTs0DioToIu97ZIxl0q2d5hJlPiSyc1oTECkKRIx9DtShZ15r
	v2tVdOG1qCGgze4e+QeCzVd4JOK/QcamULoj+i3uXLEm20kkPdthS22covN5twA=
X-Google-Smtp-Source: AGHT+IGsdaXR6rm0bitoeZHc34IGbosRLdkp7efd1biuK+GLd9lJQp9j0A7j0UvRmz0KfTlDkj8IXw==
X-Received: by 2002:a5d:5045:0:b0:367:437f:177f with SMTP id ffacd0b85a97d-3679dd66ce7mr3019783f8f.55.1720176061775;
        Fri, 05 Jul 2024 03:41:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:41:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:48 +0200
Subject: [PATCH 5/6] iio: adc: ti-tsc2046: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-5-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Q9zojN0lSJs1YYfBNhUpVI/gmwKKpCb9hKgz9Y0tOzs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82xNTfAtLA3fFZQMr0Dq/c0vYqvqV7SsUlId
 1rAnYusAfCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNsQAKCRDBN2bmhouD
 1+3fD/4sL/hhE1j5QMAxUYCzRGwqWbEQgfb3K7Uxn0NF7P0KlpULd+VsUVPo6hmvCmr24t6u21V
 xyuEaFBs4lFfKmOcJnLwAK+94+RwJ8ovC58O1sy3PGFiK9dNUXg/sMoYdU1LHPxGKSZkMFsZL3H
 XwsH7cCrp2kbN3S7qnpZhNZSsCJ3L7MMrPq3AxlDkc6whTwU30ykFeYBKC0ZgsSMVv6Vcl82N/B
 UpMdwksfdG9cGQ3NSJJngRM66Y653oTBCntzx/v5PJREsi/r7OgumHoWP1quy6zz/5j4JCu+3q3
 8KEcxWohPAYEHyWBQ0oONbSSS++/Lm7C2v1MGer++Smb3MRL8lz8CPo4CmcN2R8aI8Av9GlLyDu
 KUTmN/QPl/pzMbAhdNPcx1d0aWV8Q5OZXwYUWK/cMpxsNAxz+Idogn54oYXUBTusHAZmOpFhnl9
 ZmeydR7PZWiycGVwSygPMl/sI3/zKAOChwqDB/ZxcffM+hQzZe9tbU3RWLcgERasVQ2pwM+wTsq
 rWrakRDR7p9B3zDqWAfcWa5GUrtS6JAMQ2bOaCBkk9467AmSPZL7FCcyoW5uvSsFsd/w77UISWs
 kwp5AaeOy2m12nZ8kbWnf17pxeQPo4NYnRG9rPKq/SWjS+FjyEG/lu5ZL0gicUgObX8+CSljs+p
 N+CmDnovJrdSSbQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/ti-tsc2046.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index edcef8f11522..24b1d4390872 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
@@ -273,7 +274,6 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
 				u32 *effective_speed_hz)
 {
 	struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
-	struct tsc2046_adc_atom *rx_buf, *tx_buf;
 	unsigned int val, val_normalized = 0;
 	int ret, i, count_skip = 0, max_count;
 	struct spi_transfer xfer;
@@ -287,18 +287,20 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
 		max_count = 1;
 	}
 
-	if (sizeof(*tx_buf) * max_count > PAGE_SIZE)
+	if (sizeof(struct tsc2046_adc_atom) * max_count > PAGE_SIZE)
 		return -ENOSPC;
 
-	tx_buf = kcalloc(max_count, sizeof(*tx_buf), GFP_KERNEL);
+	struct tsc2046_adc_atom *tx_buf __free(kfree) = kcalloc(max_count,
+								sizeof(*tx_buf),
+								GFP_KERNEL);
 	if (!tx_buf)
 		return -ENOMEM;
 
-	rx_buf = kcalloc(max_count, sizeof(*rx_buf), GFP_KERNEL);
-	if (!rx_buf) {
-		ret = -ENOMEM;
-		goto free_tx;
-	}
+	struct tsc2046_adc_atom *rx_buf __free(kfree) = kcalloc(max_count,
+								sizeof(*rx_buf),
+								GFP_KERNEL);
+	if (!rx_buf)
+		return -ENOMEM;
 
 	/*
 	 * Do not enable automatic power down on working samples. Otherwise the
@@ -326,7 +328,7 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
 	if (ret) {
 		dev_err_ratelimited(&priv->spi->dev, "SPI transfer failed %pe\n",
 				    ERR_PTR(ret));
-		goto free_bufs;
+		return ret;
 	}
 
 	if (effective_speed_hz)
@@ -337,14 +339,7 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
 		val_normalized += val;
 	}
 
-	ret = DIV_ROUND_UP(val_normalized, max_count - count_skip);
-
-free_bufs:
-	kfree(rx_buf);
-free_tx:
-	kfree(tx_buf);
-
-	return ret;
+	return DIV_ROUND_UP(val_normalized, max_count - count_skip);
 }
 
 static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,

-- 
2.43.0


