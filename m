Return-Path: <linux-kernel+bounces-222499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03A910279
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B011C2121C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EDC1ABCAD;
	Thu, 20 Jun 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5vT/r8o"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6E1AB34D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882695; cv=none; b=MMZFEwsANYoHE6jf13SMS31sNHxW0glD2l7JfNvHtHURmdRtVyRh3bhOs8V3ZCaxlc4Cj90Cl0x3ybd01FYe8j/8HKFFQJ2WLVp01QNkuAbW2WuJ1E/C2HAP8GnoTV4xDGF70mpu2kdpGk2tw2MNXlt/LmMqPginlrZEo87uCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882695; c=relaxed/simple;
	bh=Xq7Y5OxTOhqlbSsF4ClvHT17sw2kze9goC5POMsbHvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGPcA2HfOcEtdSIkW8VzeVzTq+JOAFjnh6IXFI+2zhwOBxygN6H9p4rtjdmedZKc/rje541lH8ygMjzT+V1iGq06rpSDWJbU0L5dzqlAsnUz9dj7RR/r6l5//Lp+jDIwfZgP0C7tPrG7DTDqJp8OsIBh+c9W+KIOrrgzHuFg92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5vT/r8o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4218180a122so6040855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718882692; x=1719487492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTdnj0h4hO88f5E9a81SRTfb2IoRwa/RVBQI7iSQd1U=;
        b=E5vT/r8oLipiL+q35t4z3mjIDird5oNvwqko1UUwxd6NDfZgMUYNyGcCuMy5Yb9/lY
         TX7hAISu8Xpql0uilLrAJvJA5Acodttck+aDlniBjaSasLEjh71V38Gr4HDfVAFKpfie
         dVaUvheFCZvBlx47MWnziF+UZd9CtuK+bE8p9oP2neJez4q72IfIphD7dB+CS8TMxgwB
         pkTOhXHWgDxXE7ZC+Ify6EQo6FygGXyzlLy2hCv2nNllyGqhIYtDexhFH5LKvuEs3rOg
         uJk4AVkVSUeqdW8RJUoIslHHCF71cgGdQlii9lGn50oWU1yfwDjxumLTXIMGF11UkddP
         vHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718882692; x=1719487492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTdnj0h4hO88f5E9a81SRTfb2IoRwa/RVBQI7iSQd1U=;
        b=EuZgjDPpjwFdo+0knuQRLd4ASjau8i3CDz4XVx/llUlt6brSBZG+WtjcqdJ0E5drU0
         hBNMMaYTNMzVpBk0NvcgYZ/OjQkDXJWYlFJKefbLMZeJ3aN3LpcMSMjYVuwB+gaDTfUo
         YnVP7o9kbR8wWVUrJusk2cbBH2GUrl2KUqp52V7r3G5G86zHynLWPcvGE+uOo/gcSkrx
         VzJNLd0SkB6bfNLcyybr1/u6xlzueoefEi5R7XL1txN6Qd9qZ4p5t2PZY23SCbQ+QraD
         3DGUy2M49FUKZiRkb8s9m9nH/qSsrhA9mCvOX2n1mQhCEjHKtZB79jjwUJ3u1aLyfIDF
         DhUw==
X-Forwarded-Encrypted: i=1; AJvYcCXzZBoL58ihUfpdYQFyVMrgUs4bewKmVPuLuetOP1wmDcIg70E+KcWVzeZJHgpCde51jWny7iFCBAXDcaINR3BiS7CPoXn2zICT+tH4
X-Gm-Message-State: AOJu0YziQfrCZh2d+b64mrIoyg0FnzmBAPUAfM840G+agXE29FOavmLE
	47EZj2Ru+ibLZUu33fvPM4eyRI0kqvcD+bMxpqEst4jAJaBMdJw49OXz3j5panQ=
X-Google-Smtp-Source: AGHT+IG0bmj/clv7a657zIPzp9MmvrFRbSd49FscT10OF1XmC+kRwLR3I33eOqChc4j25jNWe1YVvw==
X-Received: by 2002:a5d:4687:0:b0:360:7c63:53cf with SMTP id ffacd0b85a97d-363177a1dcamr3799891f8f.19.1718882692152;
        Thu, 20 Jun 2024 04:24:52 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3647bf3092csm2025371f8f.97.2024.06.20.04.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:24:51 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: lee@kernel.org,
	arnd@arndb.de,
	krzk@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 2/2] soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()
Date: Thu, 20 Jun 2024 12:24:46 +0100
Message-ID: <20240620112446.1286223-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240620112446.1286223-1-peter.griffin@linaro.org>
References: <20240620112446.1286223-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For SoCs like gs101 that need a special regmap, register this with
of_syscon_register_regmap api, so it can be returned by
syscon_regmap_lookup_by_phandle() and friends.

For SoCs that don't require a custom regmap, revert back to syscon
creating the mmio regmap rather than duplicating the logic here.

exynos_get_pmu_regmap_by_phandle() api is also updated to retrieve
the regmap via syscon. The exynos_get_pmu_regmap_by_phandle() api
is kept around until fw_devlink support for syscon property is added
for the pinctrl-samsung driver that also runs at postcore_initcall
level.

All other exynos client drivers can revert back to
syscon_regmap_lookup_by_phandle().

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes since v1:
 - pass pmu_np (not np) to syscon_node_to_regmap() (reported by William)
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240614140421.3172674-3-peter.griffin@linaro.org/
---
 drivers/soc/samsung/exynos-pmu.c | 38 ++++++++++++--------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index fd8b6ac06656..624324f4001c 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -204,16 +204,6 @@ static const struct regmap_config regmap_smccfg = {
 	.reg_update_bits = tensor_sec_update_bits,
 };
 
-static const struct regmap_config regmap_mmiocfg = {
-	.name = "pmu_regs",
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.fast_io = true,
-	.use_single_read = true,
-	.use_single_write = true,
-};
-
 static const struct exynos_pmu_data gs101_pmu_data = {
 	.pmu_secure = true
 };
@@ -290,7 +280,6 @@ EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
 struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
 						const char *propname)
 {
-	struct exynos_pmu_context *ctx;
 	struct device_node *pmu_np;
 	struct device *dev;
 
@@ -316,9 +305,7 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	ctx = dev_get_drvdata(dev);
-
-	return ctx->pmureg;
+	return syscon_node_to_regmap(pmu_np);
 }
 EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
 
@@ -355,19 +342,22 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 		regmap = devm_regmap_init(dev, NULL,
 					  (void *)(uintptr_t)res->start,
 					  &pmu_regmcfg);
+
+		if (IS_ERR(regmap))
+			return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+					     "regmap init failed\n");
+
+		ret = of_syscon_register_regmap(dev->of_node, regmap);
+		if (ret)
+			return ret;
 	} else {
-		/* All other SoCs use a MMIO regmap */
-		pmu_regmcfg = regmap_mmiocfg;
-		pmu_regmcfg.max_register = resource_size(res) -
-					   pmu_regmcfg.reg_stride;
-		regmap = devm_regmap_init_mmio(dev, pmu_base_addr,
-					       &pmu_regmcfg);
+		/* let syscon create mmio regmap */
+		regmap = syscon_node_to_regmap(dev->of_node);
+		if (IS_ERR(regmap))
+			return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+					     "syscon_node_to_regmap failed\n");
 	}
 
-	if (IS_ERR(regmap))
-		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
-				     "regmap init failed\n");
-
 	pmu_context->pmureg = regmap;
 	pmu_context->dev = dev;
 
-- 
2.45.2.627.g7a2c4fd464-goog


