Return-Path: <linux-kernel+bounces-224603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B6912490
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0301C1C24B36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799117623F;
	Fri, 21 Jun 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V01Hk8jn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784D173342
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970954; cv=none; b=rH1UNT3e94qfcCx8CbXintE4+8X7SgRat8g7ud2A1Hc7ZsPpuj8tKXYDwK4aU7/VIW6FJZF4xQSoFUfNyk/K/1QbH0OiOqLh07C1qeBWHbAa0CIzMT9C7sDMeBNBX2rUsClYxuslJncnGD6UX+y0udfrqFuaF7a+5kpHJXoZhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970954; c=relaxed/simple;
	bh=vKPWK8/0GsBKUW/GP+s7u4nJI5WtPNaGSvLrCRfAjSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su33GHSY/2ui/wWZLIc9KPF8uK8oz1gIWoTCDZfg47KHXG2TK42jgNK82hDtOCqPSmRZVkldh+5bCwK7Kz9V1JTELYkVNTP9xKP4XCNG3dLMz0mLJyGvOCLz+dr4quTj02JP/5WXckpVrDhFoR4oc4LO0FHitkaoPxxn2gQrkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V01Hk8jn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so2354814e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718970950; x=1719575750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsZYfymlFvkNaC7UR+89xyL8YV5RjgSwqJCekyf0v2g=;
        b=V01Hk8jnEF3o7LOCz8OEy3JzHXigQgo/woThlFA2XVxRoO9wmjSyv4Gvn7663/i2F0
         LVlO77LU/Wm4DUpl1dOmYcZYvV0NuDdWMjUimUyYD4Bwkow6RyeBxKvTR/ZE98AXK1pg
         AJ/RirDXTddioo5nxuR2PdmfUOEnfSiwBUPjGUscG/UU2ABYYLOqT5fiL8CUJbjT0O1N
         zxiOZSA8/KaFq7y3rLFkYt1WvEMYSQJFLJR6SVIHGHt2QbSBkBFez8Da/dv6KR7d8zai
         B7pa186oMxBIqdxY8sBVZQakAiXJC/hRj4+u9jHT8Nv/eLmcNkOAmn2K71Bb77DPrWhw
         DQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718970950; x=1719575750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsZYfymlFvkNaC7UR+89xyL8YV5RjgSwqJCekyf0v2g=;
        b=dgOyG7KYdDHwMZxvcD/bBSe+ippfWIIhjTRh1FJ6/e1tG64/HFfF/KGLA3ZLM0sgiB
         uVGnZmePJVAzPVpRFocrzvEC2Wc7X3lgoO6mHAIT+IdccOacMq2KHBd2DeeZ3U36DR+G
         m8rLXkRZr+uYu1ud81gTYFdKukZyPIbOxj99mvuPoBhiA5gzwVSfEywEBPWoeEgXrqn9
         sQnI6ZUwzoxU9axwhb+9+qU90MeybUymB69YXRwqJZ1JzLd6AusD2a91KCnvQyTE+0JT
         /gOyRERx5/RiIRhdCaTxbwwTpZkArDRe+7ntAULfWD1yafw0fY3tUJGqMGier/YRBgA/
         yhqw==
X-Forwarded-Encrypted: i=1; AJvYcCX7pRJBxB4qbYFrooK02co/QzLSQYb6iHBcUbu/X19uoadD/OWqdvDIwyX6VY3s2Rnzu08s14ibEYUmHgdOFt1OCwEP7PiL3Wj+3cBc
X-Gm-Message-State: AOJu0YzTZ6DGuuP1SjRniXc8zBAWZD7kkd+OWEST58C9JJ6lgVcYSmZg
	dLv0Kbzs3ovuMit/rcgZGYHE5cQccBS9tEgyHV0CI3gPyX3zXhSbwNXjMxYBEbA=
X-Google-Smtp-Source: AGHT+IFGgH1vCBp0//n23+QcNNqzHrghhJighi2ENZGyzTBy64LZfl2gFclPwco/HnFbFKAV9o2QbA==
X-Received: by 2002:ac2:52b2:0:b0:52b:796e:66a5 with SMTP id 2adb3069b0e04-52ccaaa2607mr4436785e87.66.1718970950311;
        Fri, 21 Jun 2024 04:55:50 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208dcesm60386725e9.31.2024.06.21.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:55:49 -0700 (PDT)
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
Subject: [PATCH v3 2/2] soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()
Date: Fri, 21 Jun 2024 12:55:44 +0100
Message-ID: <20240621115544.1655458-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621115544.1655458-1-peter.griffin@linaro.org>
References: <20240621115544.1655458-1-peter.griffin@linaro.org>
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
Changes in v2:
 - None
 - Link to v2: https://lore.kernel.org/linux-arm-kernel/20240620112446.1286223-3-peter.griffin@linaro.org/

Changes since v1:
 - pass pmu_np (not np) to syscon_node_to_regmap() (reported by William)
 - Link to v1: https://lore.kernel.org/linux-arm-kernel/20240614140421.3172674-3-peter.griffin@linaro.org/
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
2.45.2.741.gdbec12cfda-goog


