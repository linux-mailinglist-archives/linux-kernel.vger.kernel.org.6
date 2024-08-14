Return-Path: <linux-kernel+bounces-286273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78449518F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CA91C212B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C31B1404;
	Wed, 14 Aug 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8mPtlUR"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2711B0119
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631768; cv=none; b=BeiKxjNNV5h0DzFKOsJsAX9Ykr3yDCnuauY+dq1teH863eDmfevfK6fx7tMJNJKr7K7oHWKTxaqqlSyP0V5a+LBjWj7XttwF6Vd2jRV02iJi/Iz9kvxxFt7fJ4B9HpPwpdyZn4BEZngBd/I1Q8H0XAu9JaHON9OsVO+tuNxXR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631768; c=relaxed/simple;
	bh=VJma9HGhkE1TDrQ1OhGJk9qHK29VLxq1nCdewcEacTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/1i2ZW/YqPrhCKF9n2V7b1zL8dceL6ojHvF0fB9CXzTI7EL50WloUvOVL4k/4R4TbJR1g9XJNKNi+ZMiGr5YCOrjc3oS9FuLPtlh/4flORuz2I0gTOBSAQvO83Uypy9r/zqvGKgMXPFr1HEUwk5CqkDZUv1TfKW2JRJBAwK3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w8mPtlUR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso45053285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631765; x=1724236565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1XB3SobLk7VZ//KTQh7GEC/+D2L+CRxij+/IGHYnPA=;
        b=w8mPtlURxtRtJO+WWaeRVchA9VeITd0+NtY2+2bk2oFF/dpmyAXt+DL9U6u0XDi4BM
         RITGc1A3lUe55Qj/RW2JvXvfcm8MBQwH607P6it1ektqZc9BkaALt1lxXuZdq7M1AM2n
         W6o/tq/VobR3+N2QvKy7MQUTxk626EVKGmitDC0DYTF0+NP7Ox1g5zcNTBgnxQn2ZJqU
         aclWBXOzoQINRrXODewQnk2rxBwmXS93q/Bw0d/ABiU/AU0Fe7xA8V5Ud2jcGgOEG7co
         gNQq0gLxu+37AN2iVRo0fKpby8TeqGw9D2Jb5LLnA+CrmTUcdx9V3eeZQi62u4C7oaEO
         Ahgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631765; x=1724236565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1XB3SobLk7VZ//KTQh7GEC/+D2L+CRxij+/IGHYnPA=;
        b=Bs5SrfZ+RCbeedDkQdEfDYP0U+lKJetT3MwD2t0Lgg6jW49IFOgUrevvIKXGYqIBWC
         /3dNM/uGHz0/M7ZDLhfRCLMIm9nJIoW/XC5EaEjX9pA/A7J6pauHijdtSJYGjKuoxPTK
         AnO3B6cBeGgt6bJ7dT0zSasopXNDou06/NmQZF2xylMlaDPL4yZrKLnTBRgwQbXrCzkg
         3jZDUU4IqMSNo57QWEEBaO9+mVdgD+W68IPWkQ46yZb8xSvIbFb+Jqlvl0k5/6TDcmC0
         GWWsFxOmui6mNmTeEWYOIPGYn8trXxUyPYl4V2w3J6KxAS4k721+JlM3wcydn/C8H/p6
         9YzA==
X-Forwarded-Encrypted: i=1; AJvYcCVHwJeF4GZfZXohNUgpp2PLt9xPFG6wLG+W5ZlLDRQ6WvX8AFFw3S+c0GxqhRiQkLAwcI6CCaW79Z/t0OBUV/zygjlcdC40Ah/yu0av
X-Gm-Message-State: AOJu0YwYsr385lzQksNjOEPGBGUJbAPviBPAPO8aVJyWkJVHzY4JuXTy
	Wy71LAv4sLBblsso0/g/cedkKnyiKnz3//3D0iqNNpQD0vMefzEM0vPs7BWFtCo=
X-Google-Smtp-Source: AGHT+IHu+Ec7SMXK44CW15aI6wvbF/SSdZgsQigQTDfjf8g51hhj14oMtIh5VGN/FNCI7LDZHb/OkA==
X-Received: by 2002:a05:600c:310b:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-429dd23ce9dmr18887445e9.20.1723631765087;
        Wed, 14 Aug 2024 03:36:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3dd4dsm15501835e9.29.2024.08.14.03.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:36:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 12:35:41 +0200
Subject: [PATCH 05/11] usb: dwc3: imx8mp: simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-usb-v1-5-95481b9682bc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VJma9HGhkE1TDrQ1OhGJk9qHK29VLxq1nCdewcEacTo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvIiDZ4bAv7tVf6yyVs5Q8BDE0c30I/4lsc928
 qm+fK7AL+6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZryIgwAKCRDBN2bmhouD
 10D4D/oDgQvQBKScmFFH4ftXAiif3buhyX1tYwq/1dglDmk1dpS2Uom5hsUFuODAKTVkrgvS8I9
 9ZBDxcK8lwLHgJsGEvv7wnENJ1ayzimyIU0FehRqrXwrvNKSkqVQUeJCECcCtIjs6mIbjSA49+n
 r+CKLXBd83EI5dLRl6jKhXrdyOSaZFAETUaHs2oZEf5vSG5js1KedY3wHxpRz/vbtkJaM5o1VK2
 rP7MGvnPiaGhY6B7mEHEprCBBbNEPTqejUKyZUIwzg12xUfWw2x9RdMHURMyQrMJlrBiZIzlKGw
 bOW2gDzy2qWW9Q5/u/RBds4vyXhp47ojbXo11hHockv6+sHDUKg3wsMqQeDWC5uw8Vwo8VgPFZi
 N5BuVPl7VNp6CC0jCtVFpQqsumutnnByaPeMLryUa6ooemCfTAZ9OT/qIftpGHI3MCjKWsWgWP8
 bKPy00IeGa7lFrjxYTtmDXmU27lo+tenGJyMdkO0NKuokFBi+4MgN9qo0cgmq8kQHNgGJAiTTXr
 A8qNtA04wUCvA7LBJYNyKQ1shog4fKrmVFGCZC8BdJNppG+sv0cNfDqAyq/idx6WHUL10VgRpRV
 +ax2dAU4fStY6PNV3LDjgL9lJjsoZC7ezHq+HxOJ+OHph0VyuqOSvKxXRxf3+Z+iyPpQRNCrm5W
 NR5sGcdIZ1Dozow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make the error paths a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 8c91e595d3b9..869b5e7c15ed 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -179,18 +179,14 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	}
 
 	dwc3_imx->hsio_clk = devm_clk_get_enabled(dev, "hsio");
-	if (IS_ERR(dwc3_imx->hsio_clk)) {
-		err = PTR_ERR(dwc3_imx->hsio_clk);
-		dev_err(dev, "Failed to get hsio clk, err=%d\n", err);
-		return err;
-	}
+	if (IS_ERR(dwc3_imx->hsio_clk))
+		return dev_err_probe(dev, PTR_ERR(dwc3_imx->hsio_clk),
+				     "Failed to get hsio clk\n");
 
 	dwc3_imx->suspend_clk = devm_clk_get_enabled(dev, "suspend");
-	if (IS_ERR(dwc3_imx->suspend_clk)) {
-		err = PTR_ERR(dwc3_imx->suspend_clk);
-		dev_err(dev, "Failed to get suspend clk, err=%d\n", err);
-		return err;
-	}
+	if (IS_ERR(dwc3_imx->suspend_clk))
+		return dev_err_probe(dev, PTR_ERR(dwc3_imx->suspend_clk),
+				     "Failed to get suspend clk\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)

-- 
2.43.0


