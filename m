Return-Path: <linux-kernel+bounces-343649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB8989DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BAB2822F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFF188015;
	Mon, 30 Sep 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a8kKzjjI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF211865EA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687482; cv=none; b=bS6mW8DWTeBWtuimyiyBcMbIEwQQJJNsEysOddzFuQc5Hf9zZW2mvWrJz1lU6m2XNeV4TZviPO9SuNzIsO+24Hfc1dZgr9GSUpTPNYrcMNsk6X5EMOGaR2qX98iEib7dDUTPexmZjiidcbNeYSt0gBap7NA5DUzb2bsAaSpVeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687482; c=relaxed/simple;
	bh=j9EAIuMKyTrCqRpm9ftCatgw8ZDHQY60UwldKloPxPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpbP90MzP1LzafOpVjX3GjGp6QEP05Gv+P5hpZq/EAPxLbetqt+QCe7upvGjjuSIb7Cxh86ImqWTkc0APzSEs+0lOMnwEHrbGDftAnr1l5bFuc4mcSQ8HZgD2LSZPDdxIWiCkUUmGWFQuOj6pAse6pIrERKU9lJfirlxPm8H3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a8kKzjjI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso32692505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727687479; x=1728292279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8TgzjEbxQmEBqcqNz89bUaMH73B/lho563HHj9DR/A=;
        b=a8kKzjjI7fKQjo9EW+xZjsIhavRzIBuuh1InNdMLOHmtM+Jr0PwUuT8kgTHL7IZ8gn
         4N5emYq6e26922zD09aWFvYXu/hzyTz3BH8o8n7JWjdeMpmGEPmfFU27tMZnBKlyvCpS
         AS66qQe+mj9zLZtULcIIFOlbcofW2N61QUj9LdfpdbF5Z0CsYKTr5ezVAswV2V5vh9X+
         pSeBMPi9QBiznsMuOPZZzNmw8w467QR8o9wwfkM6XGN8MqaU4zjyZMHieWN1HxOWEofP
         MEdEHdv8kmQHaXqnjaRbJP4EqlukSziH7njZZtbI28s2EkYuGnjByBWov++TOk2K/t9d
         aGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687479; x=1728292279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8TgzjEbxQmEBqcqNz89bUaMH73B/lho563HHj9DR/A=;
        b=bnOAjFg3f5NYdLUo53oD3oKg4ZT3JnqB1D5a4TxYuakeG1cuhuNUf5BRQNp1rl90I7
         hZVmVA32v358ObjpMVn3NZJcOJF1+yqaTmQvRTHyQ4EUj4n+9YTqIa9TytJW3KAaz4tZ
         e1XC0SgF4Uf1SgWrXJIssqL1X8QfCcQc1Tb5wuImK1+I8UsatM9ZphMyL0G9jIoAVwvS
         Y0eIWm4PguNS7JlnB5tMyjNGduyUM6IBlJ1JnC9VNDLK+caXimixsUsqh/4sy1u3KOgc
         KSEEu9D78V5h/tTNNyRkdnoJFldiTlKXjHCCEZ4qHZU9cmNmGEfHqIdtsMo1A6L8XegQ
         HbEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5pQXTnuecU/t3KLZAhA7MFZhhR2jxjKV34iLUF2eQAXl+NI+sgaFmoO3NdDjQk5/Qj6aljz5TIENlqQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcuA3XqzsfSDMCbR+kOmKJiHpc7Z+xIDbXnIq+SQypZ7vIqHb
	NsUheKkrtqSACBswIxAbTsA7CgbNVuUtazajvfSwNQnlUB6HwlBjKGk8ycTYfYo=
X-Google-Smtp-Source: AGHT+IEYHlUOLizDws4a1V++OEulQgUTHwux4Adu9sDvknTQxwE7wgb6Uyq6xvXcmx3wSEs7BY9MXg==
X-Received: by 2002:a05:600c:4f84:b0:42c:af06:71b with SMTP id 5b1f17b1804b1-42f6bec79b9mr10394105e9.28.1727687479348;
        Mon, 30 Sep 2024 02:11:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec169sm97231595e9.21.2024.09.30.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:11:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: mvebu: use generic device properties
Date: Mon, 30 Sep 2024 11:11:11 +0200
Message-ID: <20240930091111.32010-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930091111.32010-1-brgl@bgdev.pl>
References: <20240930091111.32010-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

OF-specific routines should not be used unless necessary. Generic device
properties are preferred so switch to using them in the driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 8cfd3a89c018..5ffb332e9849 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -794,8 +794,8 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	u32 set;
 
 	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
-		int ret = of_property_read_u32(dev->of_node,
-					       "marvell,pwm-offset", &offset);
+		int ret = device_property_read_u32(dev, "marvell,pwm-offset",
+						   &offset);
 		if (ret < 0)
 			return 0;
 	} else {
@@ -1106,7 +1106,7 @@ static int mvebu_gpio_probe_syscon(struct platform_device *pdev,
 	if (IS_ERR(mvchip->regs))
 		return PTR_ERR(mvchip->regs);
 
-	if (of_property_read_u32(pdev->dev.of_node, "offset", &mvchip->offset))
+	if (device_property_read_u32(&pdev->dev, "offset", &mvchip->offset))
 		return -EINVAL;
 
 	return 0;
@@ -1147,7 +1147,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mvchip);
 
-	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
+	if (device_property_read_u32(&pdev->dev, "ngpios", &ngpios)) {
 		dev_err(&pdev->dev, "Missing ngpios OF property\n");
 		return -ENODEV;
 	}
-- 
2.43.0


