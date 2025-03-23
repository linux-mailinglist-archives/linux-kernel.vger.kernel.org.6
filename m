Return-Path: <linux-kernel+bounces-573041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B0A6D224
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14EC1696AF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5F1D7995;
	Sun, 23 Mar 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdIo1ocr"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204691DF721
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769587; cv=none; b=k2B40UCt60NAg3Zrujl5QSjtM/vg+2K9DVetjY24YyjwUfuS90n71ATjmR225RH2H3JnrjRfjTTpqg8CQHdGY6x1kiTEQhdB87oKiHEiG273V9kbMjLtuzDw5wwVdB7QYXG1RDECOzE8M0C+xSzqrUrH46GjM2ZLaM2GlTBm6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769587; c=relaxed/simple;
	bh=2SEWJHOQRVHtm1hZDIQV8G5h9Ihj/ZSId7FCsdh0cUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gD+YxBqZLYL1LPigyMvL9x5Bud1sUWBJvmE0qPEOJmYmHf+16oNA89HlCXKIUA8LbkSlHHOkpsLpxCVwv7EMm7zHWszUWJmFvno3/8PZu0zsMt5qzXBnCow6zACJt5Vrg1BQbYE6m1HnKBY7Du9Dxx3syXgQf3M846WdwXkKjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdIo1ocr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso689706966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769580; x=1743374380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFi/wIa2zliLVLaoNCXevujk62BEru73nW/QKRcDHsY=;
        b=DdIo1ocr6oN1WklNPRlM4v5d7MVDSh5ol+XMGFqEPShgIb3z9VDnKq7j64GpehYkeo
         V7Q5zwbhXHjozJGe31PomdnLA9V3GY3+tRPOhlJ+Qq0YjXtmb0jS/i+9iiPblgToXjk7
         CwspOU3w2RNjPAhm2uf1eMc4CN1t1vlgIZHXsuh1N5QqHqQrZJklXZZXj+OrdnAXHR32
         Tv3qChqTcYXJeUhcyLBcu4syBqo+0hEupi7kPld0J4sMva324Fg8HBJcZrA7zj3hyqwM
         qRqNrvtOvb0RTJ+RXY1S6zSzrzSimFoKBSn4Ld1lIRcRIJOyKX161RHBMqlC7QsR3yt3
         8LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769580; x=1743374380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFi/wIa2zliLVLaoNCXevujk62BEru73nW/QKRcDHsY=;
        b=HMjmRlbMu5169F502tAfC49kbQuP+/BAg9jlBpecJ9LXb/IWIohn9kLR0FMmkRgtZ2
         63ofPJSJXF5Hy3nwg/ia3eVH6dqzEncFFwJ6gSakSPW+5DmKiEUgyrRxgNYe+SbFR2iP
         5hZ2jFNjpBeDMh0zetqcse4z2FSaPcFpp6NR86vw38YCRLVRB8ludnofHRcNlDrqsX9f
         fXEwi76s7M5E79gTeiYZ0hQKj114ehlaB2uiRY8OtS+bT+C5ZT9Qi6FE1CA1owCcCPdu
         kpfyKVxFJOPjb9f1eZ+om/952MyTf24RuFvmjjttB4thR+748SO13d2D7jKNwD7TqNFT
         8GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUma/prmoabCdyT3MvBqab6XLo0LTd225u4ZJH3ZhV9hkjhxdRh5pqHTSPtuG3sov8vLbWZcT5coBs8zrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJx3mxqKqpUiyAE49KQyB0KwHFTcc69GZKhOA+tdpz3tHJgTM
	Z+D4WaBbSE5Gpt+ONF9AP6JFDt6Mp8Nw2wDZSp7+YjcrpPwJsl7nlDVrtDlz6Fc=
X-Gm-Gg: ASbGncsHhbM1scxKQz47x6eYo0/B32ymEo7q9jwBVqf+BTFs3IkL2iaTmE/E4ThKi7M
	BV530yckSW/RnCbZ0QhWlhGyj5QYa32suYsdleXVNrFQ1KjAGbVOeQpgQCw+J95M6AUQBDr5EOP
	rKORcS2LHFsAetFzl4kNKs1Hnon9NlArsBitYuZOtwEeti7B1N9OmFocoXY/gAMdWHtko/jncNq
	ysABBxCb5eJRwfnGB8qgdhnfP6NzyR3xugKHIF+P5oyS9nwIRhs4GNYt3QS3vSoUqNWgSlASRWZ
	iHu2JU0wbbPCDnIDnoti09SuSyNXl2pRxQGY0g7zTZfB+X+fWjEG8KQl55btQG8hjXLYSQojOgY
	Ibq52naSE9bStcOqYVqM3WCL0Y1no
X-Google-Smtp-Source: AGHT+IExdWMeq50KMSeL2g8X5YzwdCsnSfpgrljF2A0N/7BkwT1ZoOB/F1xNUkswffcMZkq5HeqMZw==
X-Received: by 2002:a17:907:86a7:b0:ac3:c6a2:a02d with SMTP id a640c23a62f3a-ac3cdb95075mr1563087566b.7.1742769579644;
        Sun, 23 Mar 2025 15:39:39 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:39 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:43 +0000
Subject: [PATCH 27/34] rtc: s5m: cache value of platform_get_device_id()
 during probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-27-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

platform_get_device_id() is called mulitple times during probe. This
makes the code harder to read than necessary.

Just get the ID once, which also trims the lengths of the lines
involved.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index db5c9b641277213aa1371776c63e2eda3f223465..31bdceac7aa245175a30eb13eaaf1f52f70e22c2 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -637,6 +637,8 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 static int s5m_rtc_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *s5m87xx = dev_get_drvdata(pdev->dev.parent);
+	const struct platform_device_id	* const id =
+		platform_get_device_id(pdev);
 	struct s5m_rtc_info *info;
 	struct i2c_client *i2c;
 	const struct regmap_config *regmap_cfg;
@@ -646,7 +648,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	switch (platform_get_device_id(pdev)->driver_data) {
+	switch (id->driver_data) {
 	case S2MPS15X:
 		regmap_cfg = &s2mps14_rtc_regmap_config;
 		info->regs = &s2mps15_rtc_regs;
@@ -670,7 +672,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	default:
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "Device type %lu is not supported by RTC driver\n",
-				     platform_get_device_id(pdev)->driver_data);
+				     id_entry->driver_data);
 	}
 
 	i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
@@ -686,7 +688,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	info->dev = &pdev->dev;
 	info->s5m87xx = s5m87xx;
-	info->device_type = platform_get_device_id(pdev)->driver_data;
+	info->device_type = id->driver_data;
 
 	if (s5m87xx->irq_data) {
 		info->irq = regmap_irq_get_virq(s5m87xx->irq_data, alarm_irq);

-- 
2.49.0.395.g12beb8f557-goog


