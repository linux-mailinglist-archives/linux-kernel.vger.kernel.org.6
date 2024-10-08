Return-Path: <linux-kernel+bounces-355558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA4E995407
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ED71C2494B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6601E0DBD;
	Tue,  8 Oct 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h56sa1Ts"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92764A8F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403667; cv=none; b=RfHBrzXS83mB7LiUeqygDic1z1M5VNFphXTo6dVS2QYI77+QyKiBOIgR/UcQIpyFORW9jBLWwVJYBtWXC3IdA0F1jdLFQ5YDEfwcRwzro+F29oRXDKWoJB74/0sD+yHRsxbCmlMiBKKOvTNIw/64Oz6G+3uVHnSFGnannTdK5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403667; c=relaxed/simple;
	bh=Q02JvgZpEw0CKuh5bAD1hiL/2cF0mICLfBLjEWGs5gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C79+PzYl7UfOS2PpLNVyAI5l9l+E3xn3zApi7KuFC0DLuRokHwYKukEMqA/6EP/7qCJo0ibZgx5311aZFZlgkaULOWWcEtL09PN5oKjCxUPfEfjAmgdSddIyLm3Y/MWXNbiDj4PdMLy784mnW+CG9p6U5+pYZsHBd7CvKvj1DWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h56sa1Ts; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso5866575e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728403663; x=1729008463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iY6njGfqCiqj2LmxQwsaHq5nfhgm8YldXS56w+mUoc=;
        b=h56sa1Tskxg5I3S6Fy4HQpTHJg8yN4Yqhr8yhawzctt+Hou7joCBgiZOH9midx0iNB
         zgFLVNYTjw7oqZjK+14lflFyFruv1UlXaOW7CAjGEkvNqmCsC27ijWCjgqEO7D2WN+Ra
         bkVIRzyGmh9tZxIVtaU3g59W79ZDez0Pz0VbJS2eion4QHbEWrzPxBoKeBo/glfTO05N
         c3ilkThHcUJwId6rF6PLglnR2TiZjzqM6eLcuQTM3Vd7WPjFZpIO1hTMqqPM9n2f/TFB
         D/pFrsfhxZZcDRFwVXYpbXWB4+odKTjASdKaREk0ciGDVYj+Filmb+8ThdAcm7L/w0sh
         pqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403663; x=1729008463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iY6njGfqCiqj2LmxQwsaHq5nfhgm8YldXS56w+mUoc=;
        b=KjDhkWK1MkfZjNkKWNH2FgXFWtpN0xpf9xax3tWmVR0NOQvNdicyqhG0fR72NUctI2
         G6TTk0TSFY9uwFtUF8KwAJ+ZhY908YhnkkwONKcVuSLXqHeQwp3NtxWhPax5eVapyrh5
         cr1GJrkOsGjciClBQCMzFOu6ZeY63Mvaole4AGsM66smkzOrM//tZlxhyG1Oa2zUgaTG
         nQXK0mF0EtOv+b6D2c/nfUO9KQ8vTd9Vyfc0QNFf9wYfRS3TQ7aVnWtmzvMTrsLm+ON1
         ljmmVJyOy33foq/03tIE4WaI1nsEBxhdZBREzWsog3ykuJhFXDvpfbLjMHRYMAGCRma/
         3ppA==
X-Gm-Message-State: AOJu0Yw0jDlMLlZKwIztrDe1QFb8mJY7wFeI5zhK16qoXF6rWL6AfuqG
	aVf87rEF19dAVXgHC54kcNkypuBOghg+fb2vpmFEJBp2VfiCsrdU+rinsRrjAYg=
X-Google-Smtp-Source: AGHT+IEK+i7AarbSnC/AqQomD1+MfurzcjNVvb8QbEYHSrEJIyP77gYrO3OXePZiXZs9A7BSH5Dh0Q==
X-Received: by 2002:a05:6512:6c6:b0:539:94e2:a0ce with SMTP id 2adb3069b0e04-539ab9e7f85mr9040976e87.59.1728403663364;
        Tue, 08 Oct 2024 09:07:43 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86a20537sm131509375e9.15.2024.10.08.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:07:42 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Oct 2024 18:07:01 +0200
Subject: [PATCH v2 1/3] regulator: core: do not silently ignore provided
 init_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-regulator-ignored-data-v2-1-d1251e0ee507@baylibre.com>
References: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
In-Reply-To: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3322; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Q02JvgZpEw0CKuh5bAD1hiL/2cF0mICLfBLjEWGs5gQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnBVjKhV/lugejOqzcQ69eCAtrcHGHIGd7GNR+b
 wGYCNiHpVeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZwVYygAKCRDm/A8cN/La
 hdFoEACGy2v2KWidDFR5bxRYY2ju/lOgqS22utl6spsvCDY5CrhC7/lm4z5giUf/r+0o/5qN+uT
 DbggD8QDO9/qnYHTvDHAQ76dDkqlOC0EbCeeRLmvuOQ9qrKKGs8GNoXxVrAmIV+85essvqUut+m
 eaQUdn10DaixWmxe7uSdmOmLCyY/rzHI3vamJg5BQnp+gIm+9tT8rTU3YrxJuvodMeUahE1hN+L
 sjutF/KdIL+4PjdkIC7vqw27hFydjHSOYikmQWPhmPBkhUxf74jzsiFjn+d3xuPqRwQKDYJFBH6
 xxjS683z1VYcXgJrE5EVwOcZF6KbLxP9+3BTmD3zzSrwTkoM1H2AdrVDk0s9TplK/ey8TwH1fEj
 pVJGMg0Cf6p6dNkz8NLYRot5cQJxklh+vkf8ZE4V44nXmayla7Ckn/xxv4+ABzkVi3VkdNiRp+i
 udqTqeiBdxjmpU1hdrcVAgzYcaLChhJAoek6LdVuHRJfNN9tDjzj5tWMeO0BNF3pMKgtT4e0AoK
 h7Zh8+jXcwQd0x8DiR67UKxj1i/7v9ip60fJPtloQcxsZayNGX1Ya9PIS6deEqnA5/Ljsd3f51c
 ehhVyD6RUu17IbclnppLbAKopZv0itYgNNVf9p4NGTcsNKVOSMevwrH3wK81w8u4B42oZdjZmW+
 zhIZUnVtDVuUMSw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On DT platforms, if a regulator init_data is provided in config, it is
silently ignored in favor of the DT parsing done by the framework, if
of_match is set.

of_match is an indication that init_data is expected to be set based on DT
and the parsing should be done by the regulator framework.

If the regulator provider passed init_data it must be because it is useful
somehow, in such case of_match should be clear.

If the driver expects the framework to initialize this data on its
own, it should leave init_data clear.

Warn if both init_data and of_match are set, then default to the provided
init_data.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/regulator/core.c | 57 +++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d0b3879f2746..a58a9db3d9c7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5681,32 +5681,43 @@ regulator_register(struct device *dev,
 		goto clean;
 	}
 
-	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
-					       &rdev->dev.of_node);
-
-	/*
-	 * Sometimes not all resources are probed already so we need to take
-	 * that into account. This happens most the time if the ena_gpiod comes
-	 * from a gpio extender or something else.
-	 */
-	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto clean;
-	}
+	if (config->init_data) {
+		/*
+		 * Providing of_match means the framework is expected to parse
+		 * DT to get the init_data. This would conflict with provided
+		 * init_data, if set. Warn if it happens.
+		 */
+		if (regulator_desc->of_match)
+			dev_warn(dev, "Using provided init data - OF match ignored\n");
 
-	/*
-	 * We need to keep track of any GPIO descriptor coming from the
-	 * device tree until we have handled it over to the core. If the
-	 * config that was passed in to this function DOES NOT contain
-	 * a descriptor, and the config after this call DOES contain
-	 * a descriptor, we definitely got one from parsing the device
-	 * tree.
-	 */
-	if (!cfg->ena_gpiod && config->ena_gpiod)
-		dangling_of_gpiod = true;
-	if (!init_data) {
 		init_data = config->init_data;
 		rdev->dev.of_node = of_node_get(config->of_node);
+
+	} else {
+		init_data = regulator_of_get_init_data(dev, regulator_desc,
+						       config,
+						       &rdev->dev.of_node);
+
+		/*
+		 * Sometimes not all resources are probed already so we need to
+		 * take that into account. This happens most the time if the
+		 * ena_gpiod comes from a gpio extender or something else.
+		 */
+		if (PTR_ERR(init_data) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto clean;
+		}
+
+		/*
+		 * We need to keep track of any GPIO descriptor coming from the
+		 * device tree until we have handled it over to the core. If the
+		 * config that was passed in to this function DOES NOT contain a
+		 * descriptor, and the config after this call DOES contain a
+		 * descriptor, we definitely got one from parsing the device
+		 * tree.
+		 */
+		if (!cfg->ena_gpiod && config->ena_gpiod)
+			dangling_of_gpiod = true;
 	}
 
 	ww_mutex_init(&rdev->mutex, &regulator_ww_class);

-- 
2.45.2


