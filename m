Return-Path: <linux-kernel+bounces-344275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C667598A7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C05284CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120891991DD;
	Mon, 30 Sep 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TJ+LHRQT"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F381991A3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707696; cv=none; b=FWkjdfpeybtJP3yl3eP1EgFsjjl+ofllGkXscElLDdWvxtCrWcEBEXBAobZSj3ai1d6rUKn6xT4fs0twZ6Dx1K/1Fk2obFwz0FOpuw4ZIzY0xNy35ouL79D2eHZnbq+/CSwWU3nSwyC7DfJHbtRkYces1gDfYiy4kysvyPm2V2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707696; c=relaxed/simple;
	bh=EY3F+m5wtnL1iuaa2UQuujSwU3tmQznVQ28Ti6ey858=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9EYnZ6eFTvDvlwha6ONKZfE/rJyChS8p4p251LGGDuC0JPT5jR2DbNyEeVRSqrqUIRg98iDQnRLk0qJH0TbJBbpkE/qKTckb2sGj16qP0JJ8Ys0YbiBCVhyi9QJrcRKroJww4XVPzBezjYvbdhUSB8W9BnUx2d26eKcs0n0t6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TJ+LHRQT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccfba5df5so2917475f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727707692; x=1728312492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKBnQ9A5YYf2FUXo4R11RKTG90nbTdsrzyW+p16FTYQ=;
        b=TJ+LHRQT19Db/FZNlZ1Y4CoU31ZjS2xDoqps69TSvyun/i1hTHGirAnJ4s7sKlw4h8
         Ci7mkOsGpmRwwGvqspvuNj25cqjDLlken8vlVoFvJlAnA+/ElXE5iLKk2MRg1mw4+5KN
         rCcV0qw7gReIkoP9+34swToZHZgFA+dABMo0+9kSAFEG4h/Il7zrMX7u+Z/rACOW+8HV
         wRQdvNojK9G9x2P4QEx1AJdEqxElNTVJcGq6C2wy6sreq2krQb/za9J9H9+J9cATa1Ch
         mn9GxDQk83/85Em5DA1nvACr+DKTqwwQDJHySThhnP+6Hk6TcQZMwCkl7/+C/tByWUtd
         NMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707692; x=1728312492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKBnQ9A5YYf2FUXo4R11RKTG90nbTdsrzyW+p16FTYQ=;
        b=fDsPnSbO25x6u+acUhFSUAAXTWwIAwCJnwc8a7KN+u2HaYshTkYS3qdeZGR0Sl94Pg
         dYjnY9SFm6nAjQDJ8aiL/bb9JIDdCgTwwawumr/PWGg07bak9FcmbFjmg0EsqLE3lzMj
         m+0OTQQ8eYq5N8kdFjaiEzyAVDih+tJTgxZlPKn8q8aC6UOSIsbAasbVhXhVRbw1S3ku
         in++nKtY0t8N0QGY1wWvNyelqvzM4hYZuM1ZzmoOOZD6fOyJAIu9N287QZGZ/yCa6Ian
         EAK9lnK3VVAP/SwzdWPIypBZ7swxoRS+K/DATh8Aw87Xw8RP7W/j47zL8b93S64FEF3W
         IW8g==
X-Forwarded-Encrypted: i=1; AJvYcCUVLCQYsinEXpXzKn9thH+p4SQ2lFE6zNiwh3v8jJPPwwZ0/2wZr6Iv93k29a4CO7cUQQRpl6r78urEjBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdF3Fg296si/2pCwjsdpwGbJ9fshJyfZjuMmRWCi0hB5TCcLAF
	oam7wE4Q5ZUhSDWqaqglIns54MqSvKd5RYMaubpCjqW7u4zShOXaLqMUzK+9rps=
X-Google-Smtp-Source: AGHT+IH4juMB4VpfWquIbAxYYFepSx6InHOYaJpHPC7iDAq1R8QsT1e8M8xtsnfnrYxRu0Q9od2aPg==
X-Received: by 2002:a05:6000:d46:b0:374:c64d:5379 with SMTP id ffacd0b85a97d-37cd5acbd4cmr7667839f8f.27.1727707692023;
        Mon, 30 Sep 2024 07:48:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd566a41fsm9241505f8f.45.2024.09.30.07.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:48:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] gpio: xilinx: use helper variable to store the address of pdev->dev
Date: Mon, 30 Sep 2024 16:48:03 +0200
Message-ID: <20240930144804.75068-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930144804.75068-1-brgl@bgdev.pl>
References: <20240930144804.75068-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability don't repeatedly dereference pdev->dev but
instead store the address of the embedded struct device in a local
variable in probe().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xilinx.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index afcf432a1573..d99824d42c77 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -561,9 +561,10 @@ static const struct irq_chip xgpio_irq_chip = {
  */
 static int xgpio_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xgpio_instance *chip;
 	int status = 0;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	u32 is_dual = 0;
 	u32 width[2];
 	u32 state[2];
@@ -571,7 +572,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *girq;
 	u32 temp;
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -624,7 +625,7 @@ static int xgpio_probe(struct platform_device *pdev)
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = bitmap_weight(chip->hw_map, 64);
-	chip->gc.parent = &pdev->dev;
+	chip->gc.parent = dev;
 	chip->gc.direction_input = xgpio_dir_in;
 	chip->gc.direction_output = xgpio_dir_out;
 	chip->gc.get = xgpio_get;
@@ -633,21 +634,21 @@ static int xgpio_probe(struct platform_device *pdev)
 	chip->gc.free = xgpio_free;
 	chip->gc.set_multiple = xgpio_set_multiple;
 
-	chip->gc.label = dev_name(&pdev->dev);
+	chip->gc.label = dev_name(dev);
 
 	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs)) {
-		dev_err(&pdev->dev, "failed to ioremap memory resource\n");
+		dev_err(dev, "failed to ioremap memory resource\n");
 		return PTR_ERR(chip->regs);
 	}
 
-	chip->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	chip->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(chip->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk), "input clock not found.\n");
+		return dev_err_probe(dev, PTR_ERR(chip->clk), "input clock not found.\n");
 
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	xgpio_save_regs(chip);
 
@@ -667,8 +668,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	gpio_irq_chip_set_chip(girq, &xgpio_irq_chip);
 	girq->parent_handler = xgpio_irqhandler;
 	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(&pdev->dev, 1,
-				     sizeof(*girq->parents),
+	girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
 				     GFP_KERNEL);
 	if (!girq->parents) {
 		status = -ENOMEM;
@@ -679,18 +679,18 @@ static int xgpio_probe(struct platform_device *pdev)
 	girq->handler = handle_bad_irq;
 
 skip_irq:
-	status = devm_gpiochip_add_data(&pdev->dev, &chip->gc, chip);
+	status = devm_gpiochip_add_data(dev, &chip->gc, chip);
 	if (status) {
-		dev_err(&pdev->dev, "failed to add GPIO chip\n");
+		dev_err(dev, "failed to add GPIO chip\n");
 		goto err_pm_put;
 	}
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 	return 0;
 
 err_pm_put:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 	return status;
 }
 
-- 
2.43.0


