Return-Path: <linux-kernel+bounces-547825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD2A50E05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F52164A64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8C26138D;
	Wed,  5 Mar 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epWn5zrP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67C260362
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211065; cv=none; b=kCxOoz6jZ+y5F/tjzETwSIA2A9tYNCL12IFA+/GA7zREszBfz3rdFtjJYRRbwzw8JNKoXO47HRpkc69+p1E1hJuDOSzGQl+WiXma3w1HX+kMcDVVINZxngu6Gc3EQqcntJt/j6IaD98exHYiRuDwD61g0gkKYxKiBpXuo6Rgp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211065; c=relaxed/simple;
	bh=ThT1SH0NwFD4VGWTWx3zrPyEMtbDm+ytz//9/ZQ8nUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyhrza1NoeERNxvMgeLiJD3DGWUgDmffV2qxOtOotXgYTAubpxwAilRW2YCNmqoNmAqJmwjTSwb3gf17cUcmcC+TUompaLjGvdQUL+ZjYdxKfSnE+9ghL+odbIvqGiVprZt3njynf7nSQ1XeP1rgTse7RzNPKubnjJGnqS+qFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=epWn5zrP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bd4ccc4c8so972135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741211062; x=1741815862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqaqIA6DIiM40dv1MbN8TWQBwcTqK6nYU+kVVFGzqC0=;
        b=epWn5zrP6mXj6odttAGu/YpUTuwvBGerNEqvB8dMmwpv3b83R+WP83gaFbG9CqKmrV
         Z46MM5HtTReQ1cOwCedMJLu8gWO7ey2WVXqFaSn71OOrzde+QLqG8iHLbL2o8bs/yt5c
         9abdxg+yd0Pyurpyt63r0/hOHVVTZ3eoWhOAJu1aVZT8x4bnShuM9e/FG/wHZtBKiFHS
         eJ2/65dhAioNla9/A+ptlEyweES1vYCghTcdfUTTh+iS6mro3D0DbC2O1CoUtw1fYI7x
         GnuyXpZLcJThMIm7arrIwrSage5QatMnscSauO8DaQsbYrp6iEEPThroPzospLu8yM57
         slPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211062; x=1741815862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqaqIA6DIiM40dv1MbN8TWQBwcTqK6nYU+kVVFGzqC0=;
        b=BThQZdFwG4FGLEJbUKD5GGrWscHgKfbL6dDlpXHd4FnyvxWwYOYmR8LExxOfq8xe7d
         mgeF0ia1GeIb0GK08o2MQ93r0LSOeEBvBm5af8CrXkZdbA14jm1vMPEJhGJKpbRi9djw
         E+L1TrMzmpwFC4sNC4ZlxcqbgXK2XOCltfG0hO2A91RG+4jMSU2Lxtw3Fcjo4SYtFA0q
         cLPeQxepSWIs+YeYkZGmZ16gBf1mTlLLEVbhFcN6/FwhMKToqlRIiy7yL1es401mtvKY
         U0NFL/vEWt7bQtlLqyOZ6YI/XKyu1Mju0C7iOPtnKzAbppsgOV+ZmaGRItota3VTVwcm
         qEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQH/TIoWLnyx2FFIBZrBu2TDQd8EN+3UKX3nvziNbgfy5ZeZBtzOiYGECLwa5UiKP9ZVeAZ+kqDu9UXew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyfucaUQADJ5iPKsPekLXB+de9nhihvBaSsl/mf0arxxUnQ01
	Afs+pyub0TR0IbI3GZt5d7qxo8Wn92nUVCj/o7ifOyfPLzo12GEWKXk0wY9F84c=
X-Gm-Gg: ASbGnctWHn24LZfjcjkO6BR/q9/xGkmaKDGefg++95Res1vCfNhBpoOasDJPXzsiUjJ
	KOpilQcJXKCEDxp+FA6Us1tho7YU8P3xHsDklc199UvhxoLzvlZMnG/mq0bAXdkWpWCOg3tbC4Z
	xgbLc2XLRBvE0YXhzKwlgI4i4bNQguU7AwRybsz0aLQGUNCvpCEo7Qjnt6uxURh/Bw6VxbDFLke
	z5d/RbOuhhmfHeaziwFkoaQdnJWU5aMNurDo/QsCMmWhDN7Gg1e3dtMaJs6gJCHjR0CxLtCyQtC
	vEVKn+bqzjiitI0qnTWhZNKADPPCkKZQNGiZawiHFSrHzoO6CbtYcM5a+m9M
X-Google-Smtp-Source: AGHT+IEVp6P3XNQLXM9Hx/K3uZ+HnS9dPsCoQK9L1YtJ5wzYA+CRMMsBsg9ueYhyVV77oKnbD55vCA==
X-Received: by 2002:a05:6000:1562:b0:391:1319:9007 with SMTP id ffacd0b85a97d-3911f74bddemr1659044f8f.5.1741211062229;
        Wed, 05 Mar 2025 13:44:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm21954802f8f.5.2025.03.05.13.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:44:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Mar 2025 22:43:42 +0100
Subject: [PATCH RFC/RFT 07/12] clk: samsung: exynos8895: Use
 platform_driver_probe() to avoid __refdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-clk-samsung-ref-init-data-v1-7-a4e03a019306@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ThT1SH0NwFD4VGWTWx3zrPyEMtbDm+ytz//9/ZQ8nUk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnyMWcznuiVaZj5D5PkbxaSqlYTXI6VdUv5dQr3
 3jWHqptK+uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8jFnAAKCRDBN2bmhouD
 1wb1D/4sp79hXYVSfV8BQMsYsRJU3nTGmpey/905/X3p67OR94ygRIo10cvnrFQo3N9tB2mLH+w
 2xvHb4FPpONotoITcu6fvz7SEsLPxI4tLEncYuSARGtUV039v9lix15mkB7qOVvQQn2NIbOi9mH
 Yu4aD23/ZMSMtBiOfZ4YzAuyHMAA1CK6glkpx+ysjIHFaMpdzn1NupBhCm+9PMA6qLcZFwlfJfx
 XUf4zWqubHHwP5h/bqH629lX5IT/TwlXSvkSAgNMQ0vZn125aw2cJ22TURiHYYUYnozi4yphJZ4
 WDkSMEXbJlvglud4K1ozSdRYv+uEFUTeLAhjZ31DtsjiDSGzXjinLXAg/eIpyDFqFWKoeq9cPCu
 mXx4gsLucE8+lMlYjiJ/ZFwvsoQC/8lh3KiENQYhs8O7scIfvEKwq7jcwqP1OMdzxz6dnJbpnA/
 2yTGzdqYwWWQCPReBJE0jpiHnnE2w5z/OG5AXpbCpQ5aszUlE9w2jmxaBTwCzS2Hd19OOyWKrIq
 PW2sTrZviRz+XUAt+o2KC60Yihxaf1vBgG+sYFDq6dC4wBsP7eI1MQwkHiZR75SDKZsA7bcmwcd
 aGtseMM5BbhCajXkwq6UiCAGQbRB56Ln0fB65AQcQrs5upLx7KTncMVvN3kGBucEsQstZHO15IC
 7hMZyEQzN6OFiWg==
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
 drivers/clk/samsung/clk-exynos8895.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos8895.c b/drivers/clk/samsung/clk-exynos8895.c
index 29ec0c4a863524fe3fc5c223d762da87e5f13013..6b85d917871d20fd3a3f6768937eb5694760ffd2 100644
--- a/drivers/clk/samsung/clk-exynos8895.c
+++ b/drivers/clk/samsung/clk-exynos8895.c
@@ -2787,17 +2787,16 @@ static const struct of_device_id exynos8895_cmu_of_match[] = {
 	{ }
 };
 
-static struct platform_driver exynos8895_cmu_driver __refdata = {
+static struct platform_driver exynos8895_cmu_driver __initdata = {
 	.driver = {
 		.name = "exynos8895-cmu",
 		.of_match_table = exynos8895_cmu_of_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe = exynos8895_cmu_probe,
 };
 
 static int __init exynos8895_cmu_init(void)
 {
-	return platform_driver_register(&exynos8895_cmu_driver);
+	return platform_driver_probe(&exynos8895_cmu_driver, exynos8895_cmu_probe);
 }
-core_initcall(exynos8895_cmu_init);
+subsys_initcall(exynos8895_cmu_init);

-- 
2.43.0


