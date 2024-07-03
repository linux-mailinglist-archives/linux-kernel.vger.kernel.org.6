Return-Path: <linux-kernel+bounces-239143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8D925718
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE8F281339
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C4140366;
	Wed,  3 Jul 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy8AhyVH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61B13D892
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999779; cv=none; b=Ylk2xiW+E3bvcB0uL4VeJj6ayLT0lr7KAFjR3sRZmHP27Hu+n9u7Fxkf0mgHp1WZ1t6r1Vc9VnDbZrQ36T6tJVajI57QdB0PqnfPkwWMEVihtSRWeyC6D+SzSXcxoqj0Sf9bxTrpdd9s82k5fXfeqg6OXfR5LTp8G/SPU27dXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999779; c=relaxed/simple;
	bh=lKPHxJzTfCgHYSDX1B5tpKsTNzm2ZtiK5HSUDsGmOlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FntLc3lrEAxgp46gNh02MSGv7I3KAyO4MER1j+gAmyND3K+lNNnNXVofiUWc32O40QiUlfItbDv+pvY0H7S2vBWbkJS7geRQuCPYlAshkuTtDoYmj4uM2X5kROFyqmZWdumWaaBHvNu4p4fWoF5qEwhSStURwxMoT8ryXD3RABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oy8AhyVH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-425680b1d3aso36232625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719999776; x=1720604576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRPUglwHx6wx9ZA8hR4jlun3U4RFQIJjJ+cyxQAC65s=;
        b=Oy8AhyVHpz4ntn72FSHOJ0F8ZXlwBuZwQE9PocrnKpytHtH6fH8aCApYtzjtK4hmoA
         UZwzlhGbF+Ourtj14sHC3v1ZFa6ZmyDZrKj1haVRa9VG0AS1n3UVHpK9p0BQ+1N5XVOw
         uM/Za3v4x1aaSN9LyhwbVJG64+J9kLao23BwcKUHwXndUxsSHd7CnFTBDTiHnX9/6BSk
         i70/fdpwOFEZcCrUUKO9DhsAbNpWdEM4JedPpLjnWfhwPIsCVK98Tt40n2cxdu13gzZ2
         VM45VdUvdYVBnAlvp+HGnZqApnwXp7R0iuRZ8HaTe2C1JZceRe33mHqp7I+dlmTkOFgk
         OLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999776; x=1720604576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRPUglwHx6wx9ZA8hR4jlun3U4RFQIJjJ+cyxQAC65s=;
        b=OamjHOWSCOxQRpowtWSwt6E0LCV4xPgsauZ7RyWT636dzUiwhQ+kVP7KmuP02UHdxF
         GOObi3BoYl9K3w4rfEd3dKCwB+tAEcEV1N4OrsfuLVn/YUjBrt7zW83GzioglRz2i+0U
         uJeGk70thERfhxd2oKYkmHL87QqCJVftU/eiwmCjlWY4lObUwZNZQMqe+2A6jE4wCWAZ
         FcCBnH7K39M3zm/SMefao1ExkD+5VrX/Vh7U3joLUlspZonrnjUizVGPwFJCX9a00Uos
         ZR9nuNjSyfOLbzaQxZXmLDxH1frd+2M5DGf88iqeX3e/12nDQERtwS75T+RppEvi3ofM
         MEBA==
X-Forwarded-Encrypted: i=1; AJvYcCVsHPw5nvkgC4A1vCG5fqd8jbGhX75DHKpP08pLD52e5aWIfM0RmiTCuh+P0OloIEhwdaWfJVb98JPp+h8nu1gYbSNnK0mn9jiZSLoU
X-Gm-Message-State: AOJu0YwXnwT9SVBMVg9v1+0KMYs3/8Wrxwejn+wGBod6dYn1fi53H58y
	+9O9RLqNgCtO3lAFF+gFmoxx3qJGItfsW2RiL5uA2LDvx2FTun6FxE7sJIZrsTsNAh9a7zGPyTO
	B5vU=
X-Google-Smtp-Source: AGHT+IEcbA6e7/zY8dqMp+pN+4R9NA9nKBH5uQ/Ya/wGE5aHNYG8uaxx5oqrUjLx2nI7UUhdrDqNAQ==
X-Received: by 2002:a05:6000:18a5:b0:366:e991:b9b7 with SMTP id ffacd0b85a97d-367756cf2e8mr9811108f8f.30.1719999776016;
        Wed, 03 Jul 2024 02:42:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1030dfsm15341394f8f.100.2024.07.03.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:42:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 11:42:36 +0200
Subject: [PATCH 1/5] soc: qcom: llcc: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-thermal-const-v1-1-6e59e139c65d@linaro.org>
References: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
In-Reply-To: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lKPHxJzTfCgHYSDX1B5tpKsTNzm2ZtiK5HSUDsGmOlY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhR0X/MScy/ZctVKAegPdD7Al+xg25RBrO3ZpZ
 9cQta4rMNCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUdFwAKCRDBN2bmhouD
 116kEACEYb5vNbZAyBa7igQO4bpGyx/2MWanL+nROyPM+WLhPflDTQSk+7ee4fBrBrd8JohrhQH
 xOtldUKP0b4Jry2QeYRvvpEq2hf7VowY2mr0l+olzyAs6oJs/K3xrrsGzCIs8jbB6MfXJLsDibF
 IUVGaPjiVVFV8wz2zWQzh6EaEMZmNnIBUTrmFBk89vSQoqkMp/SOlBSdZ5Ir2F2d9JpmHbnThWy
 zjjf6nsxFhGPK1+rgEZvYOnv/z1OaN4hJVjTIbggfG+qUftFmwXKGfPQFwMu/Wrt4MvWCnQCoVf
 ZQo8zht+QUcfbdx4vWg/73axZU1iv1GiMW/neU22CNov8PIQof56kchisTRcDlsrsi5CSbkE7MV
 +UFYhcMp3In+mqwv2NtYAEee/IgVM1kbLHsHvPy4TT3OBmek7BAJu8+kOG22HvNstN12SKqXG/U
 e9BEYdQvpxkCq6h4yy8CEdxFfnGv2FwU/VVx1lTz/NFiqjixQaJt9VixKTLOu4DHhPLrYqx4GfW
 iwpONs/mJg21MZJk9TzzShaiIRWblsDPhBsMvmCQHqAxLJiUtQOpOZtLbyBHz01ilE40AUneQiO
 T4XZobCIy0fSdKQ4YxGZhqduP5Vzr+l71Om07ei7x2z+N6MtgY0bWl/E4VQ6MqIhjFG26jO9+5l
 w1xbluR0xizKhtw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 110b1f89aa59..37e11e501728 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -1294,16 +1295,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	/* Initialize rest of LLCC bank regmaps */
 	for (i = 1; i < num_banks; i++) {
-		char *base = kasprintf(GFP_KERNEL, "llcc%d_base", i);
+		char *base __free(kfree) = kasprintf(GFP_KERNEL, "llcc%d_base", i);
 
 		drv_data->regmaps[i] = qcom_llcc_init_mmio(pdev, i, base);
 		if (IS_ERR(drv_data->regmaps[i])) {
 			ret = PTR_ERR(drv_data->regmaps[i]);
-			kfree(base);
 			goto err;
 		}
-
-		kfree(base);
 	}
 
 	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");

-- 
2.43.0


