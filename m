Return-Path: <linux-kernel+bounces-286274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59579518FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0A282EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7061B1435;
	Wed, 14 Aug 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgjeW3ec"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39E1B013D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631770; cv=none; b=iQ7x0WE5+P4TgidsGvHWKmDw6EgZmrKaVRrmf8lNIA3pbVVnRgJgIN8hfPHxEG6dHzDpCXKnTUQG8zBL4wzZtjl9X9hoEPi8MD/qSLxkLaKFC+3eqW6wq4Ojb7+zyoI6cH0s9WVjEzIocZOnEIrYLKZ3CerMrWTs0S6v0bLxykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631770; c=relaxed/simple;
	bh=j0zfRj/X2/+6dKjlOQj6O9cChXLgLEzhiSFx4m6Tnsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYI6wMJALeP7ymwgvz6tdzY0WLVeeav1EJZ4aDu0XtvoQAsyhiePzmtDHW+r7wsPAZuxqY/jsM9J39GFOmR/tLnJSG9O3C3FIWeEqxtgyK8KQWO1vGQoh1fWIMLc82woi/CPtwYpYBkJ30QfH4UhyFCX3zhzTMaXlc8QAkv+04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KgjeW3ec; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso63569285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631767; x=1724236567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0yZZkiVGAHvG3Uhgdq+Szhl2P4CMWl0ZOslSqiIH2k=;
        b=KgjeW3ecre+28O7zyAPxoU9Z81/fToFQrec3Zy6vR7lDSe1B2SLC4rsQIRhwW3gy9c
         pH8vAIzcdFvfHGDqV0shZCEgXJGyod1/+9GETTZi4Qd2ouFwe5CCVo79rLGoPhfvizwv
         xjyHhEdt3Z7M5LzFS01fa5PKm74EELyQXkJGBsNl9rlrt438VzbQOUYJToYo/KxZkWtj
         7OqqJvxaj5/CwpNKrMJyg/GQH8g6lOLrmGRtnGZWyHlnoMIRmq1EqpA0UNXLmN3smTFg
         v+cYak0gUZrdiUAUWhX0+3xk56EXhgY0FFE0hsER50tdxdBHt7W89/XWQdAJdU7eSy2Y
         xUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631767; x=1724236567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0yZZkiVGAHvG3Uhgdq+Szhl2P4CMWl0ZOslSqiIH2k=;
        b=o84q3jRYjZmTrD2lIrfCOtXxVvFVVxzpjkJ7enFjVh5yOLddKTkHBL8k8ZjXixjm12
         PCRnATcP8zGEGUbJxexJKilxkYCFVjJ5VJPC6wLKr5R3T991nQAafhkrN01C+ApC3era
         ZsGWfFxAjdJyQ5sTK0UVSEKHefpLCW0/sSpGdQ5OWLBwp+cNrz2jalg+77AfHR6wBY5y
         bdbmQsV3Blr3HMFJ+qwKnB94bjVY//3zB1Gf3N8gNu9UxkVSyTXdRwF0jMRU9zmTijAX
         OqEJsSi/suxBIdYW2uFy3wKoAU6CGR9aH22mV27mbM/9fIVWjz3RcSGLZOglpwVm2+BR
         21qA==
X-Forwarded-Encrypted: i=1; AJvYcCVXAfUSQupoY8SCjKdl5RvvJ4YTpxPWGi5Pag5j/3vGdUiKXmiuvtIqGdXFI6LU10pkmR0GeQTe5x7nJVL6MUvbbcqovcOjAx+AhQ/h
X-Gm-Message-State: AOJu0Yzn3htJznXhfqGgyiqEEYlAX5Awd9RS1RlUWpftjoUKfH/tFdG/
	oI6i9KEphZenwutpFux+mzJyrnc8EiOPA6oUYBQQZMNcDubiUOdvmNtyb0Ektk8=
X-Google-Smtp-Source: AGHT+IECnrLkSvOLU967Ixqt58KlZw4LUJ2Sr4a2EN9+MC8iCPO7lC7hHWn2v/AOmllSOJgLdpmVeQ==
X-Received: by 2002:a05:600c:4fd1:b0:428:111a:193 with SMTP id 5b1f17b1804b1-429dd267dbdmr18605055e9.37.1723631767485;
        Wed, 14 Aug 2024 03:36:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3dd4dsm15501835e9.29.2024.08.14.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:36:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 12:35:42 +0200
Subject: [PATCH 06/11] usb: dwc3: imx8mp: use scoped device node handling
 to simplify error paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-usb-v1-6-95481b9682bc@linaro.org>
References: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2672;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=j0zfRj/X2/+6dKjlOQj6O9cChXLgLEzhiSFx4m6Tnsk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvIiEp8GOG3zGFV68+340kx5cIizIXq1eu/fA/
 Ae1uCmz4UyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZryIhAAKCRDBN2bmhouD
 1wlbD/4ivHNZDn9M9PDUIIvFYOW0r0W4Z0SKqhvcAaw/eUZ2z2fJ936yLfVTYB6pVOa9BMxwOhc
 OhhmaMvy51dJWYHcH0n1+QF7HmvWP7jyqwFsIDTyYMCyiqmRgFx/FOVZqXrggccxfRFogPsbPFN
 Bg+BN8NAscSo3kkLxXLbZXXc6LqQnfUytxgdC+kuVb1WA+LfjxvT9O8YJX8xDALIppTCrZgzGfl
 bg+uNPq5sEWtWOTL/bYX75okpi8oI/foj+LgQPKOmPNRYQ0pArhF/9jiz/sN+cMlPokYxdIv9Y2
 2NVBNUjv18YjosVS0yWuQH6CCWvN90hLpDeO2ckhpqITROsvqHTvM/vneMKmNVW4b9WpAmx4XPw
 Y6J1BLGoG/434SflN40hhMbNEHuunX/DdCbXR4ieJK1DaaYsx26DjhuIPbUJovXwUSWH6znBGxv
 qudvdkFNlxukHrclvvQLQmjhzjcScDvAn+/k/hkOhQS1ZdrG28iXyzGQJyVhttcZQ0O0mAMW//X
 k3cEQHM3xAPfSiP9g/zkR5uYYRB2zga3sE4ywH0M8ISBGpKNPe67xhFkGElM++pOmOhYOskCjyF
 Fmwsq6iMzUDuIo+VgKRWRRrPgGx3BtRg2cYjboNf2TWag+DyRLkuYmfkUlZpsSjcY6CBK1wbIaM
 ryjCg1yAvxf6gvw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.  Scoped/cleanup.h coding style
expects variable declaration with initialization, so the
of_get_compatible_child() call has to be moved earlier, before any goto
jumps happen.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 869b5e7c15ed..8b88649b569f 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 NXP.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -147,7 +148,7 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
-	struct device_node	*dwc3_np, *node = dev->of_node;
+	struct device_node	*node = dev->of_node;
 	struct dwc3_imx8mp	*dwc3_imx;
 	struct resource		*res;
 	int			err, irq;
@@ -193,6 +194,11 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 		return irq;
 	dwc3_imx->irq = irq;
 
+	struct device_node *dwc3_np __free(device_node) = of_get_compatible_child(node,
+										  "snps,dwc3");
+	if (!dwc3_np)
+		return dev_err_probe(dev, -ENODEV, "failed to find dwc3 core child\n");
+
 	imx8mp_configure_glue(dwc3_imx);
 
 	pm_runtime_set_active(dev);
@@ -201,17 +207,10 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_rpm;
 
-	dwc3_np = of_get_compatible_child(node, "snps,dwc3");
-	if (!dwc3_np) {
-		err = -ENODEV;
-		dev_err(dev, "failed to find dwc3 core child\n");
-		goto disable_rpm;
-	}
-
 	err = of_platform_populate(node, NULL, NULL, dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
-		goto err_node_put;
+		goto disable_rpm;
 	}
 
 	dwc3_imx->dwc3 = of_find_device_by_node(dwc3_np);
@@ -220,7 +219,6 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto depopulate;
 	}
-	of_node_put(dwc3_np);
 
 	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
@@ -236,8 +234,6 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 depopulate:
 	of_platform_depopulate(dev);
-err_node_put:
-	of_node_put(dwc3_np);
 disable_rpm:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);

-- 
2.43.0


