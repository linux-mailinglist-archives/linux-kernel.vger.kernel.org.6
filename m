Return-Path: <linux-kernel+bounces-547822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC6A50DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A5C1886906
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7798825F961;
	Wed,  5 Mar 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1iQraO1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EE25E812
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211059; cv=none; b=XLZ1cAk3uCsutMtIg3nUlTcnqHEmmkYki0D8bFurOSlC0gsaOOabVhycopyKZ6WBGl/JLHcmh9zKrn0NsndoEHyg4+eYWvHTxpph6cABIqBV5+bcIwYkUmYEcceO7Pe57kjeryHfErtIBJLPYkvPl2OStc65F262vULyrFJ0QB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211059; c=relaxed/simple;
	bh=d9JTlndrDcTjpU46BcEr+6DtMEAruhkkVJ+Tehlx/b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dgg1AVeFttI0Bm+aZjG+Iey2GryS1PW73SoA29nkb6OCOwWJsYrD7wH2cg6gtlM/P7NE+s8j5OGrz9scyrRyILCS9YTrREGQM8D8JF+T0cNhueuE30dU1xC7+EPU3GrzAuWk1FxflDNmYFlUt6OnoUi8pKNnKM7ViXTaysU8oiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c1iQraO1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43938828d02so8806905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741211054; x=1741815854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2s2FRzqyd1/ZQ/o1NHnLvTWcDUtW15BuFTomhPZd8o=;
        b=c1iQraO1lGJYVj0jbqUubgNfH8sLE4eSlI6Z09FrdPC1cR30etmTuFPTCv4hIdoUyZ
         J8uvBlJa7/ePkqlEuCluJMSTl5wC0rp2lI9d+lt4YvV2m6LbEppvVvtFRzNlEkgyg7NM
         9OyMBHzN4d0+nr9R4CuHgBRTOHFa5SrckK7zuDw28wYVcQY5AD87ReB5AW9XTM4DZO/f
         tpFuDEfbE92kRNo/HkaE2BmIa7RL42epsWCak03Kg1BOLvhsH5OGht3AaC7l9gp/egCz
         mbB1Ax83YR399WC18ALL0RdsblTc6z1zEPkX6osoelBPCWOElcv51ofCGvIAXDdQh/of
         kVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211054; x=1741815854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2s2FRzqyd1/ZQ/o1NHnLvTWcDUtW15BuFTomhPZd8o=;
        b=eRqTHE0n7SsPAdr8re3qcKwxdLSScyw6VF2BRWeEtJ8HZtvQUNVigbous7QmjvLaBN
         QjuCbFiw1v/Kme1WkKkjtt/97dTJUYejYjWjc4ts7UV+/QrNniaWmmKkaMOq29kJoKv0
         hX8VI6RA8+ktGqSAzftRpo4L1fBKWJTNLFOdg0kmGArkilEbLhNKMj1OVfzK7iGZkrE/
         zpiMz10Q4UfCgOpyKNxtmrLVDu0Gz9SluqMlN2YeK2GSzrMj+NRIc/pR7F8ejN/KhY/w
         f80sBVw2RMRoSXkSSqe0oGSHrueCdxWd/fwbtDA9MrOIMsPM9EahxSyh3imEeuyE47oG
         UaJA==
X-Forwarded-Encrypted: i=1; AJvYcCUmkkkIiwPBvJ1pqsPq+MGrAWQ6O0m2NNBx9paXL5G6qvWS4mObxHyH2oKiCjdgyTQ5DSouzPuAQpTL3fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAUah/oHeOR/c59gewbg6U7GRokL/KIVI2972BIEZSmEcxanr
	n7qYzQZ02NFZixGuAjdQmd4UlwdnkPIhNRxZmYAqFdDzJZWYhMdWFHNzijPCZh8=
X-Gm-Gg: ASbGncvW1cHgqkof40Vz0tr+8be/C4CpbkJJeBTWAFe1kkYf2fMuiWHHqdpy3n+2g0p
	9Qc1Z5zn5dtG61jhK2rYncTKkdc4DyyOtn+inki005grS9VTb2Q9pPwA+qtoivBRlA4idS1PTX0
	H21XUPGqHuJXwr41FZcnm/TJ9EIUbQv6H6XV0HSdh0rjOrJVifn382vcHEq1kkVz7bpiVbvG/fI
	NZphCnsuK3puAmGzPb+YQAh4obcmTRUFyMgFbBbyiecvLfVGzl+RQuOraYaJPcHf7kk6lugvTJz
	tHtYzF457i4UL43y1EQ3/iasLC/H50aF5Ai2X2ppDpehLMuZfseSj3AzSpMl
X-Google-Smtp-Source: AGHT+IGrfptGh2oqKNwjoju5jcZ833IP58nBTOtC0kImA1tMF8jS9CFcYX7dHyHVQvdhzbGQlFlgAQ==
X-Received: by 2002:a05:6000:1f88:b0:390:dba1:9589 with SMTP id ffacd0b85a97d-3911f7b2c38mr1483805f8f.8.1741211054280;
        Wed, 05 Mar 2025 13:44:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm21954802f8f.5.2025.03.05.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:44:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Mar 2025 22:43:39 +0100
Subject: [PATCH RFC/RFT 04/12] clk: samsung: exynos7870: Use
 platform_driver_probe() to avoid __refdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-clk-samsung-ref-init-data-v1-4-a4e03a019306@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=d9JTlndrDcTjpU46BcEr+6DtMEAruhkkVJ+Tehlx/b4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnyMWZXZ+MDoZuAIim26MjaX2wbo5pHyJx2aGP7
 +7n3QYxF1qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8jFmQAKCRDBN2bmhouD
 1yluD/4zpqkFYSPfgklTIdAU4mducTvJkw4WZ9iKGe3BouxOxS4r9q6CPrsB+b6AuIA8AaamNUl
 K8KM9/wKHiXEWw8el32x1OvGj8RaKC8ka7nsN3cGI5jIA45N5p32ja9U+rsSVlSIoimUfZnwASS
 0GzxT8ezrVQSE4YBqHAEA6ZjZbQq2cFxfEgbGnZ1zq2Pd2wnb5SOgAwTnpAwShY1H19v8SJHATV
 GuGACEnZyVlDPT9oA/8R87oo0ri9hbxmK6n49xUCVVRuqyCBBosf9ZQUr7X21OxgOXR64ssjD0L
 gjg+DCgkJx1xMqGqU3Xi5OvoeCNp+VztXV/SUnQN1pukrBy4XNtFyuTfn9agLPN+RdiKHYBB0QT
 w1Z5teFwdFPP8HZul+jiOI0UHR/kZ5AnxdkbD4XML4YexmQiI0YjVk1NmDcZEgu6M5RyQgbmsT4
 veIx7tCTwfOrJWJ7eHO1Rd5b6mSna0v3u/XGNHXzaPyyD+v4T34w5vCvFCrEVq4rFyUEbpefqKg
 t/2xIenKXNew3xIhpSrailWBO4QFhwInECmBDoCsXH100k9CzbX6CdEf7LH6WwmNAwYMxhNwWou
 8d4mimDkv6jcxTd4LUx6QoZSjNKGZih2NfU5oeFxpw9GXCoIqWnsnb4ABL1umYPPt5EgdnczdN2
 HB5xAcPjXReV/DQ==
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
 drivers/clk/samsung/clk-exynos7870.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7870.c b/drivers/clk/samsung/clk-exynos7870.c
index 2ec4a4e489be30bd1cd2e6deac006bb8ac5bdc57..c3d7d816cab673518c7b01ce35b0faf249692835 100644
--- a/drivers/clk/samsung/clk-exynos7870.c
+++ b/drivers/clk/samsung/clk-exynos7870.c
@@ -1814,17 +1814,16 @@ static const struct of_device_id exynos7870_cmu_of_match[] = {
 	},
 };
 
-static struct platform_driver exynos7870_cmu_driver __refdata = {
+static struct platform_driver exynos7870_cmu_driver __initdata = {
 	.driver = {
 		.name = "exynos7870-cmu",
 		.of_match_table = exynos7870_cmu_of_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe = exynos7870_cmu_probe,
 };
 
 static int __init exynos7870_cmu_init(void)
 {
-	return platform_driver_register(&exynos7870_cmu_driver);
+	return platform_driver_probe(&exynos7870_cmu_driver, exynos7870_cmu_probe);
 }
-core_initcall(exynos7870_cmu_init);
+subsys_initcall(exynos7870_cmu_init);

-- 
2.43.0


