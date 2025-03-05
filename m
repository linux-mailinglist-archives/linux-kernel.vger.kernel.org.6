Return-Path: <linux-kernel+bounces-547830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78968A50E13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F451885147
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62F2638B0;
	Wed,  5 Mar 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mY8+n/DE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80B25DAFB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211073; cv=none; b=uoJzW4PUbC+oQvMgYZdCade/ONuj0hRxkyFHZ0PttZJm7S2yFXUFoXoTZsor4OEV2ySRm2iwTHLuSkTYHOJIBgI9nXGpDQKYYntLG/5IV3DP3SRKfULm+i601roQi8mOxBL2Td6Glb1r15s/gvQcK+RssDZS/H304RUwK+ObEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211073; c=relaxed/simple;
	bh=vp6W7iHQ9HDX8dPuiHrwQP51NV/6Z9WgxoY+8xbF4+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bl6E5ZeWUDIX8EQOjNZvy9+iSS5thcRATUittF72h3oFTXA0YqZ/QMyM3AL68Q9jipehgrF427PGPrXPgfrIMeqdRYAhPMmm2EcoeyFF98d15is3YDJFPHVCRlyyW/iNIV6nCcRbyWZlddsyT8xTluV6Lj+w0FkT2mwjeDYVmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mY8+n/DE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390e9e44807so484721f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741211070; x=1741815870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXkIs54qm6LUI4kgzEJJnI1sUBwA7+zCVW8PggSja/s=;
        b=mY8+n/DEzDGY3XCzPOSX9ZJIA/K72LniBoV36quIt75CFEgNJ2c5RN92HSGF2p1coV
         UjGtooC7t7QxLqjAujlJQ4tjQrAdf8/2+6E3N25OQCqluCDmtU9/hN93927B9IMf/XEY
         sqdTdbnvH1FRkoznwCMji6AhDkTb/7tHL4CvAAxBnir0embXDGZpUNT/VQpDOozi7bUg
         ZJK5sTtII0KQjJkjAZGQAMQlkNcCJpW9jzCEgqVeEwDIbrHsUDSOhCHYQg77f7/AsO7u
         vRzn7iGAAKko9oIRND97nIBLgOOK2JVayev4yodk8P3rzpt7HFqkQMjDmLnqSM+OXz81
         3gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211070; x=1741815870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXkIs54qm6LUI4kgzEJJnI1sUBwA7+zCVW8PggSja/s=;
        b=EJt1w1ONzLc+MsWgctB7Dwa+rzX0+c9d1uJD1/D4t/wMHPYuN73o6/qDFePDKQdzTR
         nbq2mTPWxaLpgfxnZDgkfZ11VIgqOZ51MIgcvG77OjjwVgatgokQyFx8+T943iLwwmSA
         13NxbnUiGQbQ7uzrMfJZJwXRDPNxdx2X9XQaodIzxJmbRuxXWq8LN3/3aYoj1Zqkx5Mg
         MiBYCI6ZxR9WYbVYk1yqXUdUv8qBoIwVCPQz29s+3KcUWJeDTiN4zQWnH42XzTNfugmN
         5ve1rTt7QVQ3EodyEvzY2FRDTwHubolNvV7TolV82bAdOguqsb3AtFi0SQOZfNfzy8vd
         UDrw==
X-Forwarded-Encrypted: i=1; AJvYcCXK9jHRtR8ODCb1WB0hWbUEcFgFLVsfpg01Oou+mUJTA00eraWkk46FIjj/TJYsqy6ZIGzVVuWCnlaI0Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcj67vcK5QGItq6Mr1bTS9OpUCb1bl2Wdn75sSQVbNcfE1HZz
	PqATVmT36/BSRdNLKBl/s4BIqqmhr+O3nKX241z8YSxCnVwcKmHjx72BXM/lcQdnxZGWcfCX1ui
	B5jU=
X-Gm-Gg: ASbGncvuZVtUZr2Q6hKM+Bjk3rwHF+Zn4mxwXAlSzVN1DKuYqIamtv1lNg2DgZA0oBQ
	XeK6los45NEuWvfbCa5yo8ZRydgAUutT7JvoxItI1lwiFzrjQ0xdf3A7FP2CZ4l+weFoDrjQqfz
	RRBJD+QoNqveYeSHKmM9wKPNCbUc+S1FNtzKkCqFLwobqlW48Z2HtnMy5m+B5os9M8c+qtTJZxT
	3XtqstoTwlYrssvg8cK/f0/inBJn+LbfQeF9Qgg29qO0eewF+9y6lFNwR5ttQSiyBXw0gZ8rs95
	2qhpVZeZtU/pztQkgVduxADXWLBqXtY5pK/NGhvXtVURoTBD6y5CohilCq0X
X-Google-Smtp-Source: AGHT+IF3GZh+J/kzZkiIGp1RO9U18YWRAnLBj1hWD/sq99vtzP9wNUti0rkSiBo9jR1+7MHDit7nDw==
X-Received: by 2002:a05:6000:156e:b0:38d:d743:7d36 with SMTP id ffacd0b85a97d-3911f7bce04mr1468019f8f.10.1741211069847;
        Wed, 05 Mar 2025 13:44:29 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm21954802f8f.5.2025.03.05.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:44:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Mar 2025 22:43:47 +0100
Subject: [PATCH RFC/RFT 12/12] clk: samsung: gs101: Use
 platform_driver_probe() to avoid __refdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-clk-samsung-ref-init-data-v1-12-a4e03a019306@linaro.org>
References: <20250305-clk-samsung-ref-init-data-v1-0-a4e03a019306@linaro.org>
In-Reply-To: <20250305-clk-samsung-ref-init-data-v1-0-a4e03a019306@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vp6W7iHQ9HDX8dPuiHrwQP51NV/6Z9WgxoY+8xbF4+o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnyMWgtf+xtNx1az5n1ge5uKzzuPqzgx3d+Io+p
 36d5Qd9+TeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8jFoAAKCRDBN2bmhouD
 13p0D/9g9PM/WxzSeqBZhZcyDz4cecwCph7JPpVFAx5ZMUxuNrH1+k4jvJr03AlrC7k2bLFjBmZ
 n1CU/XAGCmNkAluP+1Ascyn3qmtbG74Segm+byK1IS8xNgyA3x/Lofb73zklDZgDuCc9koJEEVx
 aUZnWYBejQP45fHdFopm/O9rB250CPHTBf6pLhAACMOXTreScW0KdYM4lBWu/a4Lr+DzPJoHpC2
 rFsA6+/NkhuBnEbWS8ZLriPlacULNqJxzzG39dNrfYfZUGQM7Hhpli+8a7y5mbCi3VEbVk4hfBc
 TdITfRgV+Bb9FpD9P2VAowHqr1Ha7kKlrKOHA6SQV059Fc55rtWcC1juY+JSP1RnBz9dCGf5kyI
 seMUWWBzfDapDwaKYtYbSOu3eytOSzue9EeacncNiNWCSSeWhYRJqaCBhD5Z8pvOaT8y3JI/3MC
 3yTSUea0MDX/alU7xRiXSoIe2zpnhRZdCGhDFyQ0eVt197H8cz6UZh6VydNECw8cBp+RoSOgHht
 1by7Oo0MiSbjdLDfCTUpIGipFnva61aaHrWQYDfAjOOVqXE2a7SX96lxZKIMTKIOJMd5Pmb9A2+
 ycZZ+Srl1jQ1NIGn/HfSQHp4+Lor9ToJX/nKjq2TB1m07Xj9sZUdt1yaX6j5em9GxDaYlYj3I2F
 VNc0i4YZHaH1r6Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Switch registering platform driver to platform_driver_probe(), so the
'struct platform_driver' can be properly discarded after init and there
won't be need of __refdata to silence DEBUG_SECTION_MISMATCH.

The change requires using subsys_initcall instead of core_initcall,
because no device drivers would bound in the latter, as required by
platform_driver_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 86b39edba12276745a124df6a2ea9c22d74b915a..69c121d478f3fec98dcd84e0639e204fe604e91c 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -4412,17 +4412,16 @@ static const struct of_device_id gs101_cmu_of_match[] = {
 	},
 };
 
-static struct platform_driver gs101_cmu_driver __refdata = {
+static struct platform_driver gs101_cmu_driver __initdata = {
 	.driver	= {
 		.name = "gs101-cmu",
 		.of_match_table = gs101_cmu_of_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe = gs101_cmu_probe,
 };
 
 static int __init gs101_cmu_init(void)
 {
-	return platform_driver_register(&gs101_cmu_driver);
+	return platform_driver_probe(&gs101_cmu_driver, gs101_cmu_probe);
 }
-core_initcall(gs101_cmu_init);
+subsys_initcall(gs101_cmu_init);

-- 
2.43.0


