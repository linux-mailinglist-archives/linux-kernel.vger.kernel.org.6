Return-Path: <linux-kernel+bounces-547819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476EA50DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85ABB7A8041
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4425CC6B;
	Wed,  5 Mar 2025 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbWnQXWA"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655525D54B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211051; cv=none; b=lG0Wb64W3MmIrFlQvQhe4NrdinMdStercjkNSz3fjSYVaGUrUjZV624cNlp1z4IKBkfwSFLEMWCSKhufga0Qyi1+0/DDXqWwTHykZa1oYix0qajlpUXVz5ZLQGv8QHfF2NqjwCVLhMhqjPpgdB8uvIsHaiKQbcdYGz2O1aIEFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211051; c=relaxed/simple;
	bh=oB/IkA/mk9KK64k1ad5Y2mXXIVYOv562vIrDzNjE5zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1ZdWpWLRwkQ4lYXoYsiNH51lB4oZBPoH8UzZ6HeVTpPbrQw91qL6ouYI5MxMcuV/RVSVOuyJcsHiqiHS49k8nqHHxml1d5IhGf+uDcT1d9Rvu2azZEJxhlrve7j8HpOG0KVpITb6+VbgKy8RXQKhBfClqn+54ahjF720Ob/Zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbWnQXWA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bdc0be468so179355e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741211047; x=1741815847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhZ85enSzH8aR2rg2+4xDl0htzylKPW7K0xk6ZPvNY8=;
        b=CbWnQXWAem0BdaNdTv410BhUaSJmXUJdtvPcSoIdeMHJBA8RhqUiax/RVDAuw8EU2u
         P9aAiABK8k4zf/bgsgbfjBDeaUKflSsx0uUVWUzh9Rvq4G00hCTRsQoMTbTuIBis4sYc
         HAHfc+lU5mvQmL5CylflkjUIh9EeqHdHhfm+Mjc0VK6dYje60HncuIBIcxPygStXvfle
         AZSTMwF4HA3mMqNioIgtCuY9kHToW++scb4RaXRjKR4IKwA4nwewEzET7CSITE5pwHLE
         R7pbn9/iSbaa4aYfv5Ui1zrlbrvSPOkUQZENr91M58/fzhMWWnUDa9L7s1V54hMhU5m7
         fuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211047; x=1741815847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhZ85enSzH8aR2rg2+4xDl0htzylKPW7K0xk6ZPvNY8=;
        b=WGMTG4OM42f2REhs6FWp1WJfbXrCk7ehK5OyUh+0cmWD6tWWQQyPKt36ha/5HwQEFe
         F0i6TQ2Ez8a21YYiXEcT/VLHj7bGeILyZWNPiXBeqEYrbio0Zt06adQAyMa5kO5qzX2f
         aQQAhNP5lJLbo9I2yoLuv4JW8PIUweB24FdZEfHkKPu7r4RYADDYqSWBImxZipvjpOG9
         ThCt6smUOS0jKfbFL7yia7JwkHc0pni4DIOu/h5QdB5t33Rh1SWJGiwH1lesqWkOYSSl
         A7Fs/JjxgxoaM7/K3b6KyZXqznvlqye6iQzSN/+xpYAJAFhGLtrHkoVm1t9v9j9kCPER
         F6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCULlBegRs2wUt2mjDKIV/uMMiXaRVhpZJfRTZwR1Pit0e1twsCG5etvGVo3iH2WT48EBBCPSBOpRWyulyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBmC4w8y029wPuGqamO2/1M2iHl1ZuIeJO/vhDz2cb163VHA1
	wdmV+pk1w9Har9qpLdIs2jnLbck1DVTdlgI+wzdRjRWrbckejC+Bm6CyYPGGlNg=
X-Gm-Gg: ASbGncsXgZidu+vUZG8XPn1joD+Fp8gcvEkD2/CF4s5pVBdqLnuFLAIZJMSIVa6fD1Q
	ds3MC7aYrXuYmP4ZeuR8yNa36OduQernWknw3mGBF13dOBfyinjcm92nmkeX/R/aE3NgM3u5yhZ
	XPuBeMLperwRJ0SLDXAjhX9j2ADLXSmG3RRWBo8Thd7N8tXNR1HiOUEZLfHIosf5axu0uj8s/C6
	f4tHXF/Up2CRy3otF/P5Xch05+udcq1ShlHqlt4qQz2EqX1bhN40ie2oIThgc9tnH/7GY9jbbGn
	R7ZUGDzY9h4tiJ+lpa3LrX3Bv8LrODnU7WjmQKzEbtRH1DEEg1o4E15JGXja
X-Google-Smtp-Source: AGHT+IEU3ZT22UFxaoWjU59awt7+7+j30wAzpVUzR3m9HwAf44iR6k5R6f89TuK7z56Epr48VHs04g==
X-Received: by 2002:a05:600c:19c7:b0:439:9a40:aa27 with SMTP id 5b1f17b1804b1-43bd29d2c0dmr16131735e9.5.1741211046721;
        Wed, 05 Mar 2025 13:44:06 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm21954802f8f.5.2025.03.05.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:44:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Mar 2025 22:43:36 +0100
Subject: [PATCH RFC/RFT 01/12] clk: samsung: exynos2200: Use
 platform_driver_probe() to avoid __refdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-clk-samsung-ref-init-data-v1-1-a4e03a019306@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oB/IkA/mk9KK64k1ad5Y2mXXIVYOv562vIrDzNjE5zQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnyMWXDLQrb7Ypdhqnxaj43wd4/VBbmvk+jRJA/
 ++Pc53UcvaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8jFlwAKCRDBN2bmhouD
 14aCD/4k8JYBbnUBAF7FXSWvGemd8WkT6Ut97YBTep96oJfYE3VXHAg+MrwsEe8vOeOGp4huRj6
 /4oiNRNPjGM5xerGSljVc/Jzd7yYOglKaqblHfFi79APLb7A8soHNlAorlBLswm3BAvfKgiybhD
 1F99hwzkv3m6l69at7qbR/IMv2po47d+CWknmsmOT7/EAlU0m3oY4vG99OqFwtfwvvEMYO2/Jld
 gb00Dg8JDRrSL8VitynwAqP4iWf7OE9/K/mz1S47O/dbMYm6yyXtkQ/PQiBq2ri+0p34VIGfulM
 YaK/bCLTXhirKzc9BE7CHm/FlxZDUUQBRlN82eTs7K7OwrXfsBuWiaHZ/5QtG8bUVWuPhL0C0fG
 SdwF86ojfUiQj4kbo6TpGfzcyoA9Tuv5i4TcBPDGtm4jojIzMdj97WT9Z7UwCS0FuRD1rmmyM16
 BwIPA3oMEMG5/HuRptqVdCvIH9b+LPqUfBqcQxpY4RapXVQZbYAdSRGQfswnTA68vudJ/FTeNt6
 whf1m7nfwBY25Rej3RSli7TV/29k4rnxwMkTxweqVtaXfVZt5cYXl77qbu8b3Ealo8/sovSUUHA
 WDpGxXVtuBXygCEy6jhUKeEW6fTQTJtcy9tzY4vFND8eShBHorsGbmcCM04LLp/nlUiL5YtcMgw
 F3bzjzeRvs07DVQ==
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

Testing needed.

My initial tests on Exynos5422 lead to weird, unrelated oopses, probably
because of multiple exynos5-subcmu devices. Not sure if applicable here,
but change of initcal might have actual impact.
---
 drivers/clk/samsung/clk-exynos2200.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos2200.c b/drivers/clk/samsung/clk-exynos2200.c
index 151bdb35a46c42d0b50f48d47974065a892bbb5f..f1251d4f01781fd503f24189cc53b23e627ab5e1 100644
--- a/drivers/clk/samsung/clk-exynos2200.c
+++ b/drivers/clk/samsung/clk-exynos2200.c
@@ -3912,17 +3912,16 @@ static const struct of_device_id exynos2200_cmu_of_match[] = {
 	}, { }
 };
 
-static struct platform_driver exynos2200_cmu_driver __refdata = {
+static struct platform_driver exynos2200_cmu_driver __initdata = {
 	.driver = {
 		.name = "exynos2200-cmu",
 		.of_match_table = exynos2200_cmu_of_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe = exynos2200_cmu_probe,
 };
 
 static int __init exynos2200_cmu_init(void)
 {
-	return platform_driver_register(&exynos2200_cmu_driver);
+	return platform_driver_probe(&exynos2200_cmu_driver, exynos2200_cmu_probe);
 }
-core_initcall(exynos2200_cmu_init);
+subsys_initcall(exynos2200_cmu_init);

-- 
2.43.0


