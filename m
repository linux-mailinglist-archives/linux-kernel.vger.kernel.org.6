Return-Path: <linux-kernel+bounces-369760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC789A223E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29B2B25A27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71E1DB548;
	Thu, 17 Oct 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IqpeNyfx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770F1D45F2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168251; cv=none; b=fdH/E67MrI++2RmPDIKf6FZGTR3bo1HhF8ObXE7G6mLQnY2V5S7Dywa1nxGPPg6dghpi63VNsHt2zrKaLwvVXQJCHwiKVl+oiq1X7hgKIoqgfbpOiqOetfkLjf1f1ihmg8Ha+Qq1i0OBUC0bSwjMHvBwpzVO6WBW+C4dmDpF0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168251; c=relaxed/simple;
	bh=UdvLwSkfZ9p4NNUx5rMxw9zV2Cpa0aatuHLhwHXEqEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVljx7y5BZN3furoYqe2IFo7WVVBUkSQjpFSY9NWF6bURu3rIK/5IoZChMjGOMFfTmE8dUn6N0KNjrEeI/RLTgzLHyrKvGR04oQFLW/Xuf8JrWAjS5HxN6chE5I0YRQ1QOWT07OlPEGon5JMx/jwdb2hasWQmHwkGBfFQD8w7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IqpeNyfx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so574468f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729168246; x=1729773046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhzanmcrrqCmOUOIjhfdf9j/E7IJw7OdqnOHDW8wxMs=;
        b=IqpeNyfxRtMhIzdPH2q2t5JOhzMRuW3kmxF5Ak6Etu9alY7lWxrCcoJA2RgfN9Df2N
         kBynfyCbzdG4Di9B2h26qjowzWfNmmdWye1sxmJsLNQ6W+bBv0HF2PmmGLor+0mNOIhU
         VTXEpHqHaMhP3TplgosnlZp291+0g/Zzp7zXI+dtnsNZhul4kl41EgWBMBVnIbxrZTAK
         g15lUrqVnvSFMjMGWhLOGzCBA24mcZ4nXaHaabpPkl1lzqlIkyVDvqFfSthnPK490TKR
         dRROfj5geevZFtA+dY1tkPDUA13B04Frf1mYQl5nmEiqX4kMIADXYGvo4dXjpU7fcFwJ
         MxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729168246; x=1729773046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhzanmcrrqCmOUOIjhfdf9j/E7IJw7OdqnOHDW8wxMs=;
        b=xMQr1PXuDRfCcXoUfJo0vC8UM3UOgjpRk333/24L8jkgt/wGtbjWJBzd4UaCsaL2nX
         EGyE94DyMKiATNF3+ejQ1Qoov6nlZtO51u5gId4eLOM37cHKf4gFGcA0CWBCCoo6CysH
         Nr4OkQXSVklpnqbq43fTH5D5LaOQz2FRinzcu7JOcER5NEGvhI5bW6cpxLrScL9Q6mid
         6bZd5BrwdfW7OTD/ExCZePw2oHRWaaUA+cDfIWbRPRoIKpx+3GMMsiWNphwdAfeKU9nv
         vtrH+IsVlxGGM8Vr9AnUssHbyyLkuSWdIvgfHWroxxbn3dWYOv4h0iv5tLhByCpbhIj+
         C8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjbljL5NVzczKtEWIBQ1EH1zL00aDGzyxCkitAi8I9odT4upL3GxlTLYeC8q1oXhTVatNraA9Ct4FkBug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgxejcI/8FANUtHfvg49H4QKtz7+BRDVWgru3dLXkVCQoyEl2
	ZVbJif210KHQBqI+aYLxBP3x1G6YThawaBb0Qv+ii29/FHIGeXTxaXc1/rcUpAg=
X-Google-Smtp-Source: AGHT+IHl2iz81YfEltEl94AbYNgHsNH8XtOiMOH9EiputxO8ytXKdqEJeRa3kLv9+oRtfO52o+RAqw==
X-Received: by 2002:a05:6000:1104:b0:37c:d1bc:2666 with SMTP id ffacd0b85a97d-37d5fe954e9mr11651391f8f.4.1729168245926;
        Thu, 17 Oct 2024 05:30:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc11ff7sm7105638f8f.92.2024.10.17.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:30:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: ftgpio010: shrink code
Date: Thu, 17 Oct 2024 14:30:44 +0200
Message-ID: <20241017123044.75531-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use devm_clk_get_enabled() to drop the goto label from probe() and the
entire remove() callback. Drop platform_set_drvdata() as it's no longer
needed. Drop log noise on success.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ftgpio010.c | 45 +++++++----------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 5b07749dbdff..c35eaa2851d8 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -253,18 +253,13 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	g->clk = devm_clk_get(dev, NULL);
-	if (!IS_ERR(g->clk)) {
-		ret = clk_prepare_enable(g->clk);
-		if (ret)
-			return ret;
-	} else if (PTR_ERR(g->clk) == -EPROBE_DEFER) {
+	g->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(g->clk) && PTR_ERR(g->clk) == -EPROBE_DEFER)
 		/*
 		 * Percolate deferrals, for anything else,
 		 * just live without the clocking.
 		 */
 		return PTR_ERR(g->clk);
-	}
 
 	ret = bgpio_init(&g->gc, dev, 4,
 			 g->base + GPIO_DATA_IN,
@@ -273,10 +268,9 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 			 g->base + GPIO_DIR,
 			 NULL,
 			 0);
-	if (ret) {
-		dev_err(dev, "unable to init generic GPIO\n");
-		goto dis_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to init generic GPIO\n");
+
 	g->gc.label = dev_name(dev);
 	g->gc.base = -1;
 	g->gc.parent = dev;
@@ -293,10 +287,9 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
 				     GFP_KERNEL);
-	if (!girq->parents) {
-		ret = -ENOMEM;
-		goto dis_clk;
-	}
+	if (!girq->parents)
+		return -ENOMEM;
+
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 	girq->parents[0] = irq;
@@ -309,26 +302,7 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	/* Clear any use of debounce */
 	writel(0x0, g->base + GPIO_DEBOUNCE_EN);
 
-	ret = devm_gpiochip_add_data(dev, &g->gc, g);
-	if (ret)
-		goto dis_clk;
-
-	platform_set_drvdata(pdev, g);
-	dev_info(dev, "FTGPIO010 @%p registered\n", g->base);
-
-	return 0;
-
-dis_clk:
-	clk_disable_unprepare(g->clk);
-
-	return ret;
-}
-
-static void ftgpio_gpio_remove(struct platform_device *pdev)
-{
-	struct ftgpio_gpio *g = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(g->clk);
+	return devm_gpiochip_add_data(dev, &g->gc, g);
 }
 
 static const struct of_device_id ftgpio_gpio_of_match[] = {
@@ -350,6 +324,5 @@ static struct platform_driver ftgpio_gpio_driver = {
 		.of_match_table = ftgpio_gpio_of_match,
 	},
 	.probe = ftgpio_gpio_probe,
-	.remove = ftgpio_gpio_remove,
 };
 builtin_platform_driver(ftgpio_gpio_driver);
-- 
2.43.0


