Return-Path: <linux-kernel+bounces-429083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6AE9E1722
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFB3283C06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB21E04A1;
	Tue,  3 Dec 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WIaEaolD"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B721DFDBF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217596; cv=none; b=hEpeqeq4ec7IawmGeeMmyPu/l46TshtOdufF7I4oeBlBgNW6nPvgz/8eQsVuPOzbwp1eOJEmka01ElkQtrnWRItnC/O7Gq7Nq66XFi9uCxwbL10oqVmNgmMXPUvVZwNsnWFv/Yy5il1Hs0oN3CmRPdaTI+FENIyyjfla93CDyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217596; c=relaxed/simple;
	bh=Z0GfOAYJP0APAwF1wT1qA4iA1Irs0ALfopxV0Gc5vhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYS3rjpdI9ahyqHtll4IDqQGYoD9aA23e3QbrkiwgLpkBh5u5f+PzpJZblzZXqWVnslfpFfpkwHlE88SjWk43HPjOSDRKGbKdmeQZOzmRcsneHPvWvbb/Te0Z6DMq3LaxgWjpq/9LwjnpAAdnL6nBzb0YxWzkppuJkm36mh0FSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WIaEaolD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so54600721fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217593; x=1733822393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEmSL8+sddZC5U8u8rKhuAs5pRnLG1giY8wKLfUZTPU=;
        b=WIaEaolDa75fs0BdG35+jVfiy6QxWkPGdvNRQeBDYhsor3OJDtWoRhIcEv+dZRgDFW
         bmrbbymuJvCDWNeTnjnRhdxKrAJI4KM6yJ5sXWVQAf2QVGOu8Lb8UKkBB2Sb3tunXeL3
         VSRSimFamjVQmSJ6rL26CKyvYa01ZRhl7GMJ0CEfDohbgzstJiv6TH8UHKtrEsm6oP9X
         T07Ni7we6UBS7crXqQueIwJLWcFDDRmmm5x6aIJ7SRFpIAF0rcjskT5qOyGMV36fASJE
         DhLwFxchBoEm75zbFRCUcBS3iP9TcB8Ox2xozLPD9BZE9JCEJsC25m6IPje/IwdfXdbC
         b7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217593; x=1733822393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEmSL8+sddZC5U8u8rKhuAs5pRnLG1giY8wKLfUZTPU=;
        b=KJUvKOhtfGcqx+0RGhk2svwQb0YQgPedgunQFM8AuWaOsGRDN1nPzHD8nIHq4IeeSd
         tHvpj23xvCDFKM79qG5fnfwo7ScY5XCwg2zPFKSqkn7BWATkIlYjsVuh62YnHzYrII2O
         k7kJVykbaXUMHqaOiqieIRxNgKJE6yLLJokl+sihDaJx+Gy+luyhyQp4qa7aISkvQaQP
         njDcTxiRDFBGhreuKBsaz6Da573d/9TolC5qqHg0Glj4VppkQyZNw3WJmWv7jKX9t+lu
         VutGOuazltBU/nCqc7JZSqGoQj/LlR4i8lDOOnlH/V/xrVVVabKNWUKsRoutY7P19vKx
         5ydg==
X-Forwarded-Encrypted: i=1; AJvYcCX13wdfStAIfxWhlM/Nps4xvE+C8djwjSDiRk6OXe85FIqybA+tYU7jzcuIgJhB7OTkfByE23IhIeWLzLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BvM0Q4Zm/LGRKG76Ak9M7bLE1hgYXcmpkrczsKDWzca+UQAd
	PaQajSxSMcZGLKHRN5GoirHinRVVy21PTcqVKG2CiM34A1eL076aIYiX0gJBGFo=
X-Gm-Gg: ASbGncsofVigwXbzTcATj0pHWpfy0mNc23hare+SbJZqFQgCN3SduiXKV4CJuEVMLLY
	124CyDBEpXJ5gXfuOu5UjSte+dSZP815UoYYlnyANRUQOvgFwEe7SsIrmnpKK4bDvRmWSt6Rlfl
	FntiidTWT03jW+SSUbSHhPOiFlv8zMpNfl+yAuYFtULMXctq44AYU42M/TcXw+m+hDL7b5ecjgU
	q7JGcFiQcEHxBiVH9OzM7AXYg7/UWKmU2d6jP/V1hhFw2LSkWqqVCkZTUd+kY+NMHObzMDpXgbI
	YqHicLU=
X-Google-Smtp-Source: AGHT+IFaQWa086WdWD9OtF9i2iKTP732rCIE9XHL/J0c9FQlcUMT62QhRdBnv2a/4N1LumlA4FOHtw==
X-Received: by 2002:a05:651c:502:b0:2ff:c7a2:c1d6 with SMTP id 38308e7fff4ca-30009c057c3mr8280531fa.18.1733217592650;
        Tue, 03 Dec 2024 01:19:52 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:32 +0100
Subject: [PATCH 4/9] crypto: qce - shrink code with devres clk helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-4-c5901d2dd45c@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
In-Reply-To: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=jgSsdDqzauWGl9p/3YUK4kLf/M4okM3HyzfRntFUc+A=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0xTaehQqNa27XHs5bjGiXp2naG2ecW3xkgW
 AKW+YPfj5WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMQAKCRARpy6gFHHX
 cl+HEADczNfVm8CvOEoleQLzgRmkmCOt5Nz9PMJkhwwrNkkoJBb10kEy3TIxG7CbRHZA+QzH90E
 z69lQIixv/Xmej+XgRyExKRdd93diL1LROvwefA8e57C4uwW69NAop6lij0cscTo908L4M9BVnA
 ow7vH5SI9oOL/gvvKEuw7l9umaIQlEQZgoiyh+JVfA8MZ7ea/Vqmz/SYMY4nJYEnwejF50Ugg6O
 Yuzo8UfTOu1pqXMLv3eUHYWEq9Ct1PAKvee2zCcQA63+oPbEJPFcTbyBsYhX65cmuUEt6Wpswj5
 xbL41GGzHPWaLUDSfLs9mIbeoc41T2MdxQe/s6HobVEhCEA1XB1cF/dNggaqT2dE8s3cmKsoW75
 bOpe/35/LwUeqbOuSV2/IljVJbWpZKahbY8g/J2Qr8ZU7t9hwaTbPtNcJDk/HOdImkMSxl19nc1
 StWDwLhtkGBNJtv1+RAJ236pIO1O/jqLaXhoc8FM536voiG2l6p1odVsKyWRyKNJOzhwadO6E/b
 Mddk3dl//lHu7ZQ1tMN76wMexck4It5ODrN9iCwf7QS2xCBXuBMIG44xO3wBEDHYDv7sp2SUsQU
 b+2hoD8K3pN+FZuwvPyxLiv7JlUZtdYOFdvcAfrU32Yj3/cblVT62hlkRSwTp6SGeC47YS27SAg
 4T4ZTEytGksdNbg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use devm_clk_get_optional_enabled() to avoid having to enable the clocks
separately as well as putting the clocks in error path and the remove()
callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index f9ff1dfc1defe..cdcddf8f9f02b 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -212,15 +212,15 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	qce->core = devm_clk_get_optional(qce->dev, "core");
+	qce->core = devm_clk_get_optional_enabled(qce->dev, "core");
 	if (IS_ERR(qce->core))
 		return PTR_ERR(qce->core);
 
-	qce->iface = devm_clk_get_optional(qce->dev, "iface");
+	qce->iface = devm_clk_get_optional_enabled(qce->dev, "iface");
 	if (IS_ERR(qce->iface))
 		return PTR_ERR(qce->iface);
 
-	qce->bus = devm_clk_get_optional(qce->dev, "bus");
+	qce->bus = devm_clk_get_optional_enabled(qce->dev, "bus");
 	if (IS_ERR(qce->bus))
 		return PTR_ERR(qce->bus);
 
@@ -232,21 +232,9 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(qce->core);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(qce->iface);
-	if (ret)
-		goto err_clks_core;
-
-	ret = clk_prepare_enable(qce->bus);
-	if (ret)
-		goto err_clks_iface;
-
 	ret = qce_dma_request(qce->dev, &qce->dma);
 	if (ret)
-		goto err_clks;
+		return ret;
 
 	ret = qce_check_version(qce);
 	if (ret)
@@ -268,12 +256,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
 
 err_dma:
 	qce_dma_release(&qce->dma);
-err_clks:
-	clk_disable_unprepare(qce->bus);
-err_clks_iface:
-	clk_disable_unprepare(qce->iface);
-err_clks_core:
-	clk_disable_unprepare(qce->core);
 
 	return ret;
 }
@@ -285,9 +267,6 @@ static void qce_crypto_remove(struct platform_device *pdev)
 	tasklet_kill(&qce->done_tasklet);
 	qce_unregister_algs(qce);
 	qce_dma_release(&qce->dma);
-	clk_disable_unprepare(qce->bus);
-	clk_disable_unprepare(qce->iface);
-	clk_disable_unprepare(qce->core);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {

-- 
2.45.2


