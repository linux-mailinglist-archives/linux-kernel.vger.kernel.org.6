Return-Path: <linux-kernel+bounces-538650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C3A49B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E91899586
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0626E643;
	Fri, 28 Feb 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oK3XLD2i"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A026FDBD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751653; cv=none; b=PEH3mYIpSVP+EW0QPi0UZlJtj45N+zW/JZC8B4DgolCeufqEJZ6B8bg4qp+yWXa4AFBswQRJViFlfqNxtBN+UCs7VAGCCAMKLsROEw60aCKRaXnLCfTHgoZV/V5AgmYZ6WeWis3uavqysm2UJvBuhk9glxrZejH1FO/5erRkGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751653; c=relaxed/simple;
	bh=+Kph84gyNH2FaYt3N+VrOHuKaKCtB8nOyu2qKHWEIWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btAaHT4sFTEE9wZXmbGmS1+Yn9BiBNcR+dwDFyOvTL3kX3ldHR+WU4dls1QdixwAp17YFSE7g7LGXf+gOOxkZIys+k2bgh3Ki12mUBwjd16bHccUpnGkJKtwyuIYkrs8SEWCKuQmsNsBeEhVDvYUvu6pFWAa1g5cskpaUU7QyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oK3XLD2i; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so4075427a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751648; x=1741356448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nzHwlkUM09BG0CuM/bA+EpIQxILewT/ffWeXrAz77U=;
        b=oK3XLD2iq0t/+2Il/MmrTMKGJKRoLUsVfpyx4Ng+GxLv/Kkq4myvUMgB8L2ilRRl6b
         W5jpg2Q68WdTg68Pxw+Bj66o9d8GG4ybSYTDUAuEexBQbY6M40SdW9l3Xgr+ncoj8i21
         8dgJk4ir8sqj19cIxHLJ1+ISGioytOnl/G0SrhbyCWc5FRABkTdyeBRhTic5Zu0FQHwd
         ABZs3zK64OEWUdJQXww7lz7gSTlPHWmMmRTENgZJ+FjZOTxZEPiRKwiiQeWpH1pV4fRc
         jKVcA3EJaxILEAlKvouxyPPdRrbdlGSnakdV8rfUzrUlBKKu0yLFJMH2pxde+RnEx8F/
         5cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751648; x=1741356448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nzHwlkUM09BG0CuM/bA+EpIQxILewT/ffWeXrAz77U=;
        b=aPBa1GI/kNJeezn5MZhrE5wvWkTNcOCxb6ydj2lQWyyQC9cQGZSrsgaJYc7IrAphGj
         zWfvQsEXdHRDGqQFi7iA/YB/fXjTOnF4NaUbvgms8FUSPCXFZgtRzmXCqHtr1AbEb6yI
         W9HalWz7XHcbwSljiNieV6ecdgBJDjCJl7RQMXfTdnI+r5higF8bMlL6OI1YlsCnugAK
         1PLYJL76fRSjy7kpYbhO1gTniAtGFkOJFCWB2opJakYwyzuVBs+KQjZ8yc/MkMS/sRE2
         2a/8EekUQP3qwXpYYwAjk+W3TQKkildAviScphdTTMe/QYXA6SJCJjVmOlO5IFX/3oSd
         lXrw==
X-Gm-Message-State: AOJu0Yz1AQmxCcEwsqViZh68olCVR9f1hJuVWp8asc5xKrE7oBb6oDhg
	UwQWpj2fYTcOPUCdbnwfqkHj2BZhSbMFbiCb7icuPT9N7G8l6sL0wiuLPkC9R14=
X-Gm-Gg: ASbGncvxzN4b17GeaDAvhpT5NhE3zxNrNtnxxqWaXPNmS9FmJGIKQ55nRB1zDb8UwwW
	urYSRcKeeY3OzjK5xQKd8LG9XZSIQZXV02zrdJHyri+hFHZ2n9PsgVHGe72fzL1hs9Zlc8yIOMP
	kqHESqXoCfshLhFRWjL279MZQ2KMjzsnFIYF6ddBLzmbwPjolMbSDrp4AewWQbP8UMezLv7RL90
	7q0az4+pZIgh7Z3EfT5g/7YgEu6x+myKmBsoQagmXJuVRZtVCZfmUFXsS3FlmgdHJfEKvJs9Q2o
	jz8cdtqLTFNPsC6buePGVcI+Tj1p7uLUC0yJh4DpoPI+N16hkN74W8e3n2lTBvX4/rS70p0ndeI
	jhn51NfBMvQ==
X-Google-Smtp-Source: AGHT+IGquByOTAI+pOBsMihZmYnZaIy5p2XitRnKkTWDJg07k5RO868wRYsHEejBUavy8mEmWjqo9Q==
X-Received: by 2002:a05:6402:13d4:b0:5e0:8a27:cd36 with SMTP id 4fb4d7f45d1cf-5e4bfacb0a8mr8959084a12.8.1740751648271;
        Fri, 28 Feb 2025 06:07:28 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:27 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:24 +0000
Subject: [PATCH 11/18] rtc: rx8581: drop needless struct rx8581::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-11-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-rx8581.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index b18c12887bdc3705ea4cee9b8d75086a05b24e71..785ebaca07ac971eee34559f8d1e0a8a872cbba9 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -54,7 +54,6 @@
 
 struct rx8581 {
 	struct regmap		*regmap;
-	struct rtc_device	*rtc;
 };
 
 struct rx85x1_config {
@@ -252,6 +251,7 @@ static int rx8581_probe(struct i2c_client *client)
 	struct rx8581 *rx8581;
 	const struct rx85x1_config *config = &rx8581_config;
 	const void *data = of_device_get_match_data(&client->dev);
+	struct rtc_device *rtc;
 	static struct nvmem_config nvmem_cfg[] = {
 		{
 			.name = "rx85x1-",
@@ -286,21 +286,21 @@ static int rx8581_probe(struct i2c_client *client)
 	if (IS_ERR(rx8581->regmap))
 		return PTR_ERR(rx8581->regmap);
 
-	rx8581->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rx8581->rtc))
-		return PTR_ERR(rx8581->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	rx8581->rtc->ops = &rx8581_rtc_ops;
-	rx8581->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	rx8581->rtc->range_max = RTC_TIMESTAMP_END_2099;
-	rx8581->rtc->start_secs = 0;
-	rx8581->rtc->set_start_time = true;
+	rtc->ops = &rx8581_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->start_secs = 0;
+	rtc->set_start_time = true;
 
-	ret = devm_rtc_register_device(rx8581->rtc);
+	ret = devm_rtc_register_device(rtc);
 
 	for (i = 0; i < config->num_nvram; i++) {
 		nvmem_cfg[i].priv = rx8581;
-		devm_rtc_nvmem_register(rx8581->rtc, &nvmem_cfg[i]);
+		devm_rtc_nvmem_register(rtc, &nvmem_cfg[i]);
 	}
 
 	return ret;

-- 
2.48.1.711.g2feabab25a-goog


