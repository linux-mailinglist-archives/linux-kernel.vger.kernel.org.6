Return-Path: <linux-kernel+bounces-286270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE29518EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C740FB21B26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777881AED20;
	Wed, 14 Aug 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfifJvhF"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109C91AE847
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631762; cv=none; b=TTLCe1rVs7TtGKqb1NRgOeKcww/9rwtIkmCy9dLTOOCQMxiovGiehKQdxEPyNYPJ4aNcUFZDxpfbsdt+ztoBaBxe0GPtp+5SpqAoGBjUwphk1o2osKVuNJFZRThXjc5BJFT+gDJnuFVgHdm96U8I0gd/01/zfXJIasVmA6vnY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631762; c=relaxed/simple;
	bh=vskeAuKrhfXrsp2ZcFFQuCibXtmv9qVHOZR6L6FnN20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1m01m/IFqbVO9LlXSQejzQ/zRBoBkKkBvaO5WWqktkTDWnLuUwVnHhVbprMGE3xY5u4kMfIVzZl3m9WPZ0ukA0pJ5eEHXLTbkmJlD4/snUK1mZcVcJs7R52kOKL0PiwWxhYfuIgMWnuGXbnu2CRDRLXL9glq0/hTqkHNf1bzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfifJvhF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so86983571fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631759; x=1724236559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYbj97TWkeN06uXs3dFmCbhWF9ptmDF/h8TBQ2K7IzM=;
        b=TfifJvhF1nuRybadPImGjcTPhaJnvXLKpa4XRHxBlKaWEerakQccE9LS8Wf/GsC0Er
         AJK6pQ5nxBwQ8xlbZ95J+G5DZyv3N/3x7ql3BgMtsNIOK8+Wfzb/cpFm9pg9H4DU0D0P
         Ijj8OBUOD0cbnC1dvCwyZZMfuSYKXp+fad3bLgJ3GazTG+QnwsD/PG8/LEFve49AhSEz
         BzOf+Hj0pVGFAsKL5QMSizgc7HTCdsBXUxXVwLcDV5jRIvj2CqDEhdlQCnZ8a+3e4T1B
         yo+Oyf+wNjpjPFNXeY/FFZRpATo4yMR3o+5GkzHFq2gfGk7AjSuWSGRW/4AL9PG0fqED
         K92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631759; x=1724236559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYbj97TWkeN06uXs3dFmCbhWF9ptmDF/h8TBQ2K7IzM=;
        b=j6aDBnMYZIcSMqZD2irdJ8MmdirAoaRSl7KWqCl25k8Qs0MMvQ61KVm3fpCt1yx9HP
         JFHpf2oH1WW782t4X6nXgzGVF9gCjKrmByPiQMetOyf1Fa37GdDQVTNQuuKKdr/mpcYd
         3+KUWLEjdXUoktsl9y7cGXn8FD+MpUyKUqE9QYPrOtJeva4rqO6vBidNzE94vl/oXCCT
         Xn2+UFKZKDYonMHV88VyQkq6jpdHy6AjG3oR8vIDqeQcyDwnhtnwDojlvp8kIgB+Q4PW
         OmB2c8+V4CE3Ez8GdpwsiIWctBMCbvccXu5biMccQgUErU9uNaABQQoc9ROx+uhV4i1+
         6tpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZJVSRafIAqlm+CppAy29P4SZ6BQ084cDvp8X5b8o6srUO9igJSGfy21dL9lcjlzbA/ibi31d/rB+TBXR7oo+Anl/eyW8+3HlRxBvW
X-Gm-Message-State: AOJu0YzMN1HbDW/mli9UBOajxfnL5jpCT8v4sUYjXYBp0ulxiFEECOQ6
	4bRicr1z/jxC+Obs2sVWT6DpsiYFh5vOrcPTqDZQcAgkwXGNscquNWEQ9XxB8IE=
X-Google-Smtp-Source: AGHT+IGNnEvKYgHjOlM+F8zslJoez+32u1bT6xmeFHQ2/ZeUJOaLf7dk5BPLnJuHX9IuZgxjc9jlDA==
X-Received: by 2002:a2e:3003:0:b0:2ef:2685:177d with SMTP id 38308e7fff4ca-2f3aa1f1bb2mr14654091fa.20.1723631758721;
        Wed, 14 Aug 2024 03:35:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3dd4dsm15501835e9.29.2024.08.14.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:35:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 12:35:38 +0200
Subject: [PATCH 02/11] usb: dwc3: st: simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-usb-v1-2-95481b9682bc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vskeAuKrhfXrsp2ZcFFQuCibXtmv9qVHOZR6L6FnN20=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvIiApf/404hSWCwrTIbqTV+JJM3N30EgD7ku7
 Zsz1Z4gWiqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZryIgAAKCRDBN2bmhouD
 18wpD/4m8mmVOueU/GuhjZB2g27J7VlVXkK0jkGm7TFlyRFyiF2XYlGnZqaXOpmN0ESdexzXM3d
 slE+ElE1ppbQkvNFg4aDQFGuxXKY5IWMAv5FJuXs0kohxCvZTGEvIfpymJ+4pTxjS23v8AGhCxW
 bdN783ZthKaw+vTytIyOKbW5fA3V6XB0fssYWKvgmB926my9VU2zj1hB2Ww2uLaDUN7rdxInGZy
 o44duqg10/m+duq+7L5UhVy2yL1VHdqea4/1L+C3s3r42BeDQeEnLjfjv8wg/RPF6VOj0mgjktr
 SOEZIc7ui6Rj18eXhhyl2TWGfyv0pLmtzy1dqbiiJzKaNRyuIcsN3TwCURpYL3AjLGILkaf+8M9
 j0MDj697885SoSa0Fn33q9oscQEKDYIwew3dzxTSrftVIKM279oy3uUAHYV2Td5IwxhxlWxJ045
 x0KM/mgjF9SSI623mjdZ+Xnr85ZjSix/n0Frwzt18U2CtpgyzHfoT9pvtNGcTwWmCysOHxK21EM
 2CK7iNGaZDhuKbff2tKDpcxPOeXa+V+WISeWC5Cd1UrD7Oz3zWACUeBfYxcUTsSr8wjpWnmfPZd
 uYeQxAeN1KZO/G1CwTfshZ15a/I+ku52qqz0t0YHnKo4SomBpymirVhv/RSgnsUW1Ld9Pxbhs0w
 xtXyrU6Q4UlpCtg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make the error paths a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-st.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 98f43d7082d7..7a0b1821768a 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -237,10 +237,9 @@ static int st_dwc3_probe(struct platform_device *pdev)
 
 	dwc3_data->rstc_pwrdn =
 		devm_reset_control_get_exclusive(dev, "powerdown");
-	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
-		dev_err(&pdev->dev, "could not get power controller\n");
-		return PTR_ERR(dwc3_data->rstc_pwrdn);
-	}
+	if (IS_ERR(dwc3_data->rstc_pwrdn))
+		return dev_err_probe(dev, PTR_ERR(dwc3_data->rstc_pwrdn),
+				     "could not get power controller\n");
 
 	/* Manage PowerDown */
 	reset_control_deassert(dwc3_data->rstc_pwrdn);
@@ -248,8 +247,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	dwc3_data->rstc_rst =
 		devm_reset_control_get_shared(dev, "softreset");
 	if (IS_ERR(dwc3_data->rstc_rst)) {
-		dev_err(&pdev->dev, "could not get reset controller\n");
-		ret = PTR_ERR(dwc3_data->rstc_rst);
+		ret = dev_err_probe(dev, PTR_ERR(dwc3_data->rstc_rst),
+				    "could not get reset controller\n");
 		goto undo_powerdown;
 	}
 

-- 
2.43.0


