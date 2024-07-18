Return-Path: <linux-kernel+bounces-255794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22D93454F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1C0B22076
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E007470;
	Thu, 18 Jul 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r5Ks8ntI"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A003382
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721261385; cv=none; b=VWuK6Y+yHvlhbeV973RlkVnCKt6ftrQy4EYAP9wBr5QIhR14Jh8T/kAzcIfJcbCw/SeFJqYzRsGggVPBAEkZ4PDaymmWv0Z+LjpFAAsz9C4M1Q541FxLf7cpFdTsBSTr+B0n3tiLbf1owlKCC913by9FTyDulBXp7VGvZkZzL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721261385; c=relaxed/simple;
	bh=wt/qzQuv1Oj3EPYIiGGE45EkZB5VMCHunctx/kbTHDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6eG1C+uyzF2O6tYp5Myt8vX/4yoFiTqursgRBP5HOh2QtEMHGuynZlAt9wbZbdLQyF1VoYC9Y318uawV7DnOINwX35se5XN++L2m0MWPo+VfDlqlAX3600tt5uBJqNvGCPYCFxpcMsp7edFLvIR8e1g7KYqB/ZKJG0hlV49wtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r5Ks8ntI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7515437ff16so131760a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721261379; x=1721866179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rJ5m7Fl3sMwVskBOOBufRviDL1o9bXQXCNdGsyOVPo=;
        b=r5Ks8ntIv/VsZHEkEN0l/9vtX0gCAjTa+VtRHWuFEvzkeFPb2HMyUAzcXe9z2D1bEy
         HMxMghkII2CUHvreh+BdYYv2SOg7Ig/Fx/2tD0D3WKpKwpSlcAyFq6sCnO+flrxen3cV
         CqSr48F2tkKPgvykR222j+UXOcXDLS2fBtZpA2MPf9kTZimlzYYL+fp8arvUlcN1Wr0m
         rnZjcGT/x8ZnenMgyXsJgA7LfEuQOOqFuH+Kc3190TiD+im+FkjvBtwRGBYYUOhvCogL
         figybXj/8qOORMQmBne8JsN9x0ZJWcmcn0P/TAfYxSUHMDULw3lcwxTA3QHmUNv3gkmG
         GKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721261379; x=1721866179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rJ5m7Fl3sMwVskBOOBufRviDL1o9bXQXCNdGsyOVPo=;
        b=Y0O3BvOslXoZVq1Xez7P+8/WjBB1/wpSHePRK/dK4J3CYVq0t6zothfgOylUWLfFU0
         m2rOxZ39QCn3j+GkLm6ssfsiE+7uWiI8JHhONYhAon03f2mmimbzXpzsxc6h223alQMQ
         CiFoUQseXvjxVbOhC4ngUx/KArcujN29daCeBsXjGeP0t+m4YCtp6nySatymvHgIJ4em
         Mh0ZPafLsfEuiY+8xayMfPn0DSJgZBqS/M/DO/z8t3xEVrsrmbBiMWheBOAXfQHFzMCD
         //GZopd1Dg0tcNwKd+Hc1+VVwPditInm9Qn4IgSCAr55T32Y2GaVg/BKq9ui6GlKtxKt
         hsQA==
X-Forwarded-Encrypted: i=1; AJvYcCWhf1ExHRTULy/yqMLr5+qW5JxuTMi0ts2R3R5LSxHYL0x/+N41XlnMustCXyht4/DHdTlD3O0RfgOWNzwcOvyBe5NbVJasKCj3jhpl
X-Gm-Message-State: AOJu0Yw2Bhx8AMpUYZypvvybb6mOnILeLifveHuMi9BZASzJYjwyqSo6
	9QA2qRzb0YEspGuk4hzIbhtXKwL6Cf+EeEQ6jLrQSyrbo6QdW8eZMnENKHaPrto=
X-Google-Smtp-Source: AGHT+IF04MR7Smx6T0rGv8pS1Tq8lRD17LTiRDEIUaK4JAMINqysx/UaUEPbq8Zrh0qjpFKGvNNFwQ==
X-Received: by 2002:a05:6a20:4325:b0:1bd:2710:de5c with SMTP id adf61e73a8af0-1c3fdd00c67mr4884982637.22.1721261379404;
        Wed, 17 Jul 2024 17:09:39 -0700 (PDT)
Received: from localhost (75-172-111-187.tukw.qwest.net. [75.172.111.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc73a2sm80870995ad.109.2024.07.17.17.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:09:38 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-gpio@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] gpio: davinci: handle wakeup-source property, detect wake IRQs
Date: Wed, 17 Jul 2024 17:09:33 -0700
Message-ID: <20240718000935.2573288-3-khilman@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718000935.2573288-1-khilman@baylibre.com>
References: <20240718000935.2573288-1-khilman@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the wakeup-source property is used for the GPIO controller, then
mark the controller as wakeup capable.

Further, if there are any GPIO IRQs that are marked as wakeup-enabled,
then mark the GPIO controller as wakeup enabled also.  Since the GPIO
IRQs that are wake-enabled are dynamic, this is (re)calculated during
each suspend (and cleared on resume.)

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/gpio/gpio-davinci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 1d0175d6350b..031aa7c30855 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
@@ -195,6 +196,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 
 	pdata = davinci_gpio_get_pdata(pdev);
 	if (!pdata) {
@@ -274,6 +276,9 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	return 0;
 }
 
@@ -677,7 +682,24 @@ static int davinci_gpio_suspend(struct device *dev)
 	struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
 	struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
 	u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
+	struct gpio_chip *chip = &chips->chip;
+	struct gpio_desc *desc;
+	bool wkup_set;
+	int irq;
 
+	/*
+	 * Check if any GPIO IRQs are wakeup enabled.  If so,
+	 * set the GPIO controller as wakeup enabled also.
+	 */
+	for_each_gpio_desc(chip, desc) {
+		irq = gpiod_to_irq(desc);
+		wkup_set = irqd_is_wakeup_set(irq_get_irq_data(irq));
+		if (wkup_set) {
+			dev_dbg(dev, "%s: IRQ %d wakeup enabled.", __func__, irq);
+			device_wakeup_enable(dev);
+			break;
+		}
+	}
 	davinci_gpio_save_context(chips, nbank);
 
 	return 0;
@@ -691,6 +713,9 @@ static int davinci_gpio_resume(struct device *dev)
 
 	davinci_gpio_restore_context(chips, nbank);
 
+	if (device_may_wakeup(dev))
+		device_wakeup_disable(dev);
+
 	return 0;
 }
 
-- 
2.45.2


