Return-Path: <linux-kernel+bounces-511862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C693A330B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25CC3A602F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE96202C25;
	Wed, 12 Feb 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2kS0uB6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C12010EF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391805; cv=none; b=kUAf1UjkZfd17t0i2tCxhMI+tYDWPQF1EBvlbv8aR4KyKRXrYN6d4S5t3LVsdvqvqLQi8QQwGB5IluSOG5TsIUfN6FGl2dCSjl5qQlut2jVDwvL2KIQ37hGdnDNdGw++EpDIeFafbczmLl0c16zSEY8nlgAP2VOMbOR5vz3ujoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391805; c=relaxed/simple;
	bh=BJr7Fun8ATHBkMDr6CDcYQMi5sV579CbQ0ida1QdEuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXLj8fcAnAQvN9kK1yP1O3m3PQqu+FmpUDQ30RqJdo0mUK+WC9n7bVWkC2xTMqeImMvOo/U579OzJEL4+oY7BcIq2q3IlTOHq97bhCamh6Ocdy+5JSJBHabYc/yXkHy/XSms6cFoTtXvxpYc/SlkfFMDu7gQmuVWPtZdv9OZGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2kS0uB6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7bc87197bso4363866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391801; x=1739996601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jp4nnMqVM+wmvakBBSoNXcZew9pqFP31o7lF0iT/704=;
        b=t2kS0uB6xLGuA/p8frpYHGBarucKGiZmhVu0WbYBCfW5ioYo8ffH8iHv1zK0Fs8Mu1
         3Jw2+HgDVNxHdhFMn4yalapYxWk0baB/X0pidavuBUv2UhR0J8K2l9Gro+NKn0LGbUPf
         /1U/VmOWLVyDetKwVLmHwikN4Pj1goRrRKfR1w2TSkWoyCXWmq6CmBEK8sPxN9yYvxZq
         mScu2E0a07ioxR26kJpqMUACc4sJWAb1JtXACu+WGjZaTRA4vi92LmzMx+M9K+5DbYYN
         pnjXeP+WKa3BoooW/F0uMXuk7y3ZhsYuM4GK0y0PN9uzAMAIz11E/okdF/Ih9Noze9or
         CLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391801; x=1739996601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp4nnMqVM+wmvakBBSoNXcZew9pqFP31o7lF0iT/704=;
        b=lKwBctgFX7nqHrvV/2Kh19eWS5FXRFvmeGah1x/vMM/jIF9Yb+0LK1Acu+jEsOc5zZ
         UorpLQg/1u7OpZVcBZRZs4CKUgKxJgX0NnnfAnnnxAzDdGqMY+fKdSbAIzCLqL87Qt8M
         NwIQnlXpCFxC7LyvLm0YOydTOsFYkq80oqzHk1seLRavyfQ1FVXxIoTBENkcgg04WU/F
         hR++IU4zoCeptjqo+xz+fEUCKjbr51ue6x6EPYclblHe5Un1eHAA6EWa7aRbuCAR9m3I
         90CHKj0LRa1Ljpuw6T9Afb4fPqWsuJ2xY5NqgCA+lcnGsJZ1lM9wBnGOjO2tC3BP+bG0
         rooA==
X-Forwarded-Encrypted: i=1; AJvYcCWguAuOxzzG33x+Ny7t2Kx6dW3xoKgPwVPXNUehLjuv0D/7C33I6+k/DuWc/u4f7e7/7xvMxt2e68FS1V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxcjnx8Tr7u5h7+v9D+N30WmlbMC3IKiNBvGRTAVs0Hf+K6LIP
	Va9R9sKFnqvaj1zMFB1lFid5e0FKZrOCXiDQAOuiMtLlpR+T6pQNW+J5Dwff8tU=
X-Gm-Gg: ASbGnctmtB5AcKENp3IkpOkUzyAz5TjU5+iN9uK9lSwvo7buUC6UA2rCHrrGTunE8OY
	qHd7I62OAGRwpVzMz/f8zbGnAUW/gZtjtOi7nf0L+gUMsMEPHJPT7C89ZXB/I9ZP7H6IGzNcIrh
	15/7PbcVOjt21hroTSrTYTrRF/msD/9P8HvAsSk+qirqQLRqeO+/+3za1AD6CvlLof/ta7bM4Ai
	QVbzsQ7iqRe3J1MlTYFTBR4wINcn8bwicmDxS4SPNxQ6Co3t6+3866JJR6YF0KG0Ipsp+EFRvRy
	J0ugaPW5CyLchUziTrhVjyDUNy33CJ0=
X-Google-Smtp-Source: AGHT+IGQJ9R7CIT5x3093vwonD8YEj39Kd/ZWuTNcCN7XQT8vdv7abwIts4VbTQ/FqMWvt2O2bFGIQ==
X-Received: by 2002:a17:906:c114:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-ab7f33913bemr165092666b.5.1739391801417;
        Wed, 12 Feb 2025 12:23:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7db5ef658sm419660066b.42.2025.02.12.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:23:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:23:12 +0100
Subject: [PATCH RESEND v2 1/4] can: c_can: Drop useless final probe failure
 message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-can-v2-1-ac9a1253396b@linaro.org>
References: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BJr7Fun8ATHBkMDr6CDcYQMi5sV579CbQ0ida1QdEuA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQMzVVee2VvtYLCQ8TcF9n9l+uWUCkEB7tQtX
 pA9vh97AeKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60DMwAKCRDBN2bmhouD
 1xBlD/9PZgZyvy8Z5xZxQ2bSvwLsLyGD480nJYSr+27pVp0dCjgzz4yFMdehT55PlcD+VK9yOm9
 XcFGuwj55a7Ima53N2FboZR3Jc6jEtDjWH3nF7pycjhjOXw4zKe+bDsAZK0fqHmM7CwzlRpirek
 Iqb2XtNb/VLe6NyxNq4938yfN1Fgw+HsZ+Poyl1hJyX6pz2ld9MB3XEs4Lk65YA8P/ZeGlkXZcF
 ktYRJWMqUymuzikUBbrr+73esZgYHMJ1szhKDUPV4x5iwVLpoh71q3aI1VuPdIDE05rXHkoskqp
 ryVSU9OYUddyMfct7p8epWv7ATNOkhEgKfO+Atos42K7mOn1bsw5jHmVCYC8DvuNH0H98b8FT2y
 /vf3CN1863cfZJAjRZ9ADL7wqLnZf1Y+7kVpzLWgjdhEkntluk3arOvjhXzDpHAy+sxdz5IfORe
 rpq8PXymq51jP6tMJHONwG/uhxtGkEwtyVBLOuh+8KMZ5z17yHxekdr7Yi3G6HDE4M4t+r8UVSb
 KAZ+6H1Xq4tCCenVGUq/kGDHbocrAWVl0+ZCTVBJPG5Wsvx7+IAxpiUZ6UJbSig7PjRJ572Tb/X
 X3kaV2MRf7o2bXUIGKiN23HPPutffuMxwFH8Ex6o7kMN6lG9UxbTQfC57v/DTAEN60SXlG46/Uj
 upqogOc16T7ZgbA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Generic probe failure message is useless: does not give information what
failed and it duplicates messages provided by the core, e.g. from memory
allocation or platform_get_irq().  It also floods dmesg in case of
deferred probe, e.g. resulting from devm_clk_get().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 399844809bbeaad42e19b4003b85fc487b01d336..8968b6288ac7adc54894f09efbd869c950cce4bf 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -269,30 +269,22 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto exit;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* get the platform data */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto exit;
-	}
+	if (irq < 0)
+		return irq;
 
 	addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(addr)) {
-		ret =  PTR_ERR(addr);
-		goto exit;
-	}
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
 	/* allocate the c_can device */
 	dev = alloc_c_can_dev(drvdata->msg_obj_num);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	priv = netdev_priv(dev);
 	switch (drvdata->id) {
@@ -396,8 +388,6 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	pm_runtime_disable(priv->device);
 exit_free_device:
 	free_c_can_dev(dev);
-exit:
-	dev_err(&pdev->dev, "probe failed\n");
 
 	return ret;
 }

-- 
2.43.0


