Return-Path: <linux-kernel+bounces-214989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB264908CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7E1F230C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840BFBFD;
	Fri, 14 Jun 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2wzp2Bm"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB4BA37
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373872; cv=none; b=c1OODZ7Qw2jdDg1ZHAbo6i4MgyWbfrBK4VOLXckh4K4zshUDm9D2qpWZBKveX9YleJPKy8PECm3KwYjVLRDrP8M7EU3ppT6eGpwKIVTa8RmCECafnJp0xdr9TjKsus62+V0EgYQhcR6KV025QRDEMFsqwzV27APj6WSLbt7/QGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373872; c=relaxed/simple;
	bh=45+7DJ3Zi1zWTvH/h2mVbRQtLebXojIZJISifInGfi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSo0kfTb4ThENR667meoQam0m7acOb+cHl+b8sRq+YbU/88iX1mChTj9unrObJuFlKZYYQ//EJhJ3zh/JEvmkRmNVpX4xhk7ehBn6A4k2kfVzqsB6yPfeaOOfn4RC/78w6Fxe9yCln7eeNyeA+/EuuAv2jHyUZ/dl/Hu0qNBbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a2wzp2Bm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso22865471fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718373867; x=1718978667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl9kqcfGBwFy5H6BJGB/GnGPra5NWoxJWzdEPKFSvgU=;
        b=a2wzp2BmnQYvYGGhfrwoFvuBKlCiu/Ps2GMI3fq/xU+Kghph5lzN5XU5ebs6YqsfTH
         0EnfaCq8aF/rESGLivbKrI1BK4euPsjpdhuHL++J68MdVIimngXk4eTmkxS2ScHpeDqn
         Oy8kWBqnr/3fOgpfJcmHl6dscjWaVXgZnhiX/hUImPhj6bg4CTl8RV0x+nBlYj0yYve6
         Mlh9KdSfuFJB4Rg8Whu6vE7CzL/z2Mdk/QlZUGUid4VRfoEudD/MDHQnbuYXleCJ9ieL
         OzdEGaKb/nDzZ5X1WGzLyz5PxM8GM4+ewDkYHLWe75d1mjt7UsBM5ZPqdOui15Q6oJ4Y
         nOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718373867; x=1718978667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl9kqcfGBwFy5H6BJGB/GnGPra5NWoxJWzdEPKFSvgU=;
        b=ONo2AETV1J6soH9oOHHh+i63N9FdiRROab1Kxgo6l/IQKEWBBuzhpNyy/rm0YrZcF7
         fPI6un1NTXji0etL4UMdMUwYkT5VaqHlXBdOCgDIEtXhSTFBqI3kw1TkIP8eL8z6hRQ0
         Q7YIPEx8vbqv+/fck9yF3X4Mc2zxzSj7lO6myVfbHnuplL3CdpzeeEOfwGKivIdu3fn8
         Uy1i9iOXwdIzlsH1xxV7tsLGQTRjUqDeGtsdypM7D1GftxMn7a2TtMYUg0BwbFPbS51n
         sFn06LPDLUqZxxYg9JCGU67+xCqhMNpMa6ajjvaPnaq6UP5GdSCxQr0QoCKWL0b4xEOw
         4vag==
X-Forwarded-Encrypted: i=1; AJvYcCV2Vl3GELJa1ZPBWp737Gb5NIPdcrMPIX4NbOKDh8AoGhgXNvjYnns2oFiVEX0mJLKjx45JIwLB7cGr4Et79rURo2q2KrDXq61Og6vM
X-Gm-Message-State: AOJu0YwA7TwCyUHUUS75jvkZZ0JONyRzrowzvqZEjZACaTeWpYq4viqq
	s4gpLByaP8zbkwFyA7EKwPejv+m6w0vXUlotjZv27NACpYJkeelRGfFRDPbT+70=
X-Google-Smtp-Source: AGHT+IEQOuPOYPaM8o3aNWyvd8/zbnKHujN2cBZJn554KZZftzu74XY5xkUakXzxKrF6TPEHis8wFg==
X-Received: by 2002:a2e:2e0f:0:b0:2eb:f5ce:a0fa with SMTP id 38308e7fff4ca-2ec0e60cb34mr18675991fa.46.1718373867299;
        Fri, 14 Jun 2024 07:04:27 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33ccesm61310525e9.3.2024.06.14.07.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:04:26 -0700 (PDT)
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
Subject: [PATCH 2/2] soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()
Date: Fri, 14 Jun 2024 15:04:21 +0100
Message-ID: <20240614140421.3172674-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240614140421.3172674-1-peter.griffin@linaro.org>
References: <20240614140421.3172674-1-peter.griffin@linaro.org>
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
---
 drivers/soc/samsung/exynos-pmu.c | 38 ++++++++++++--------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index fd8b6ac06656..91d7f4121a72 100644
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
+	return syscon_node_to_regmap(np);
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


