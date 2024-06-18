Return-Path: <linux-kernel+bounces-220159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C410690DDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54094283A74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5A1891A0;
	Tue, 18 Jun 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqixCpVU"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F717E8FB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743532; cv=none; b=c2gxTWU1qWcA9JWHmrq4xGh2oVXOQxWhhuOZqnpXyw7LIC78Keiugez+QVV7wro5Z0YoTogqwKVaQAzmrZ/zlZMTrwwoA3yaZxFAD/sOfUczSXWgOzSYRXgGmlc6T92V1db2dTON9bxIVTXKah3YWgQgvzkrxM+JkQWxShzqMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743532; c=relaxed/simple;
	bh=Be3QsddRFn1tQun0Ci4OnCg1bFvG6cNdgpu2xdZl3FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaAZSjhLqH91PRB6i4VNT2l6Q9FG3AKqmED/mkF5bKdKEeo0POqKPPe5kbNwGlr32czJjTpubheUG1YGbbASuqk7gZ69F5RF9W1u9IJ8R5hvXAsA3AlGTJdi7qEIHuyTuXQjiTbevUu1pS0RtwpyMDAK5G6PxMvR77wD2OPjyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqixCpVU; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9cc681ee0so2804565b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718743529; x=1719348329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1tGGKDb/pzoSYKfOaGs32qG7utZGs+QUbR9RohPaQI=;
        b=mqixCpVU95F4MYRCLDLa8EL5Fr/aymZzwZHyp0ILdQhE573bMXiuQV5mdhWhJNNkG9
         O5iZQIReBCp16BpFeT8bDFjryUw8fy6K1WURHYFJtLoHP95CyeL4wx9KOrwQHUIn1asn
         NOSyaDoaUnsC7k5Wg1wlImXrlDaiuj3TL3hJ6L4vLEzww8RCk3pTlCgsMJlNSiRUlY9M
         jad2CV8qpw6ioA2/qa3L8ttYB15KQ/HE7IcI/joJYTet0MdldF8S1vbU3BU0DiLCEJ3Z
         H5NeMcwoKNzPG7++BmagC4xdTzX/uNAJ+LEZC2WMwajo/9G+40Kdkx3iQRJzu91d97Vk
         o7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718743529; x=1719348329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1tGGKDb/pzoSYKfOaGs32qG7utZGs+QUbR9RohPaQI=;
        b=IPUMV91X1X/IqKtt9p+DNXg52wDezMsbCaaYy3PmbSfp/GDYi8TT9/SOqMnr26XYii
         vcDNVRz8m8qocFtYqSrdHue64DjS8ZjT0ubwPUbQqC7VXFs22uCMXwoP+dHUXruQv+Io
         htIr9aFhsLC1mJzYjW2PkgurFjCj/dfNlwwxWXKoX60sYaNgf58tsLX+u5H3Q0qpqXNi
         RuNbdQby9VXAG+oEvxdfwxmKNRlU+3XYKqg5+YbY5LKuyw1bdxfnjG05quKr2fkwcZLQ
         igaF45qhCQ9pUM8780b+0WJdlNgW55Z8drJhDzJGQzKKBn8h1sP3ijagTkL8siKjWzb4
         6Qgw==
X-Forwarded-Encrypted: i=1; AJvYcCXYxxhKDTVL1wUGn1dnnze1v6i90mEBJZa4+U6NxUKrZDO3aspshB/hvS+ID4UVnzXaS2cQcpKwHKT+o8z8lDOsnRqlOnN2YBgdSYq9
X-Gm-Message-State: AOJu0YxSxQTHG+SvkKLGCR/mPjY80cJ1jVmaYCZPhX7obklwhCW+Ibx4
	rrIm0GGL6TbW0pJ4d7r/qxmouSnT2Ilg9ngvsGy5BOTmD7ZVuFcgaCq5cxHszTM=
X-Google-Smtp-Source: AGHT+IExMUu5uMoYHOz6Ly2rBBDwUiHBtNbETwIOmMglcoTYhcR+mi7mM6Kezl435MsKYs2EFya3dg==
X-Received: by 2002:a05:6808:1522:b0:3d2:16c8:64f4 with SMTP id 5614622812f47-3d51b9e3769mr981490b6e.24.1718743527969;
        Tue, 18 Jun 2024 13:45:27 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476bb609sm1898298b6e.44.2024.06.18.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:45:27 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] hwrng: exynos: Add SMC based TRNG operation
Date: Tue, 18 Jun 2024 15:45:21 -0500
Message-Id: <20240618204523.9563-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618204523.9563-1-semen.protsenko@linaro.org>
References: <20240618204523.9563-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some Exynos chips like Exynos850 the access to Security Sub System
(SSS) registers is protected with TrustZone, and therefore only possible
from EL3 monitor software. The Linux kernel is running in EL1, so the
only way for the driver to obtain TRNG data is via SMC calls to EL3
monitor. Implement such SMC operation and use it when EXYNOS_SMC flag is
set in the corresponding chip driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
  - Used the "reversed Christmas tree" style in the variable declaration
    block in exynos_trng_do_read_smc()
  - Renamed .quirks to .flags in the driver structure
  - Added Krzysztof's R-b tag

 drivers/char/hw_random/exynos-trng.c | 133 +++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 99a0b271ffb7..497d6018c6ba 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -10,6 +10,7 @@
  * Krzysztof Kozłowski <krzk@kernel.org>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
 #include <linux/delay.h>
@@ -22,6 +23,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 
 #define EXYNOS_TRNG_CLKDIV		0x0
 
@@ -44,16 +46,41 @@
 #define EXYNOS_TRNG_FIFO_LEN		8
 #define EXYNOS_TRNG_CLOCK_RATE		500000
 
+/* Driver feature flags */
+#define EXYNOS_SMC			BIT(0)
+
+#define EXYNOS_SMC_CALL_VAL(func_num)			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   func_num)
+
+/* SMC command for DTRNG access */
+#define SMC_CMD_RANDOM			EXYNOS_SMC_CALL_VAL(0x1012)
+
+/* SMC_CMD_RANDOM: arguments */
+#define HWRNG_INIT			0x0
+#define HWRNG_EXIT			0x1
+#define HWRNG_GET_DATA			0x2
+#define HWRNG_RESUME			0x3
+
+/* SMC_CMD_RANDOM: return values */
+#define HWRNG_RET_OK			0x0
+#define HWRNG_RET_RETRY_ERROR		0x2
+
+#define HWRNG_MAX_TRIES			100
+
 struct exynos_trng_dev {
 	struct device	*dev;
 	void __iomem	*mem;
 	struct clk	*clk;	/* operating clock */
 	struct clk	*pclk;	/* bus clock */
 	struct hwrng	rng;
+	unsigned long	flags;
 };
 
-static int exynos_trng_do_read(struct hwrng *rng, void *data, size_t max,
-			       bool wait)
+static int exynos_trng_do_read_reg(struct hwrng *rng, void *data, size_t max,
+				   bool wait)
 {
 	struct exynos_trng_dev *trng = (struct exynos_trng_dev *)rng->priv;
 	int val;
@@ -70,7 +97,40 @@ static int exynos_trng_do_read(struct hwrng *rng, void *data, size_t max,
 	return max;
 }
 
-static int exynos_trng_init(struct hwrng *rng)
+static int exynos_trng_do_read_smc(struct hwrng *rng, void *data, size_t max,
+				   bool wait)
+{
+	struct arm_smccc_res res;
+	unsigned int copied = 0;
+	u32 *buf = data;
+	int tries = 0;
+
+	while (copied < max) {
+		arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_GET_DATA, 0, 0, 0, 0, 0, 0,
+			      &res);
+		switch (res.a0) {
+		case HWRNG_RET_OK:
+			*buf++ = res.a2;
+			*buf++ = res.a3;
+			copied += 8;
+			tries = 0;
+			break;
+		case HWRNG_RET_RETRY_ERROR:
+			if (!wait)
+				return copied;
+			if (++tries >= HWRNG_MAX_TRIES)
+				return copied;
+			cond_resched();
+			break;
+		default:
+			return -EIO;
+		}
+	}
+
+	return copied;
+}
+
+static int exynos_trng_init_reg(struct hwrng *rng)
 {
 	struct exynos_trng_dev *trng = (struct exynos_trng_dev *)rng->priv;
 	unsigned long sss_rate;
@@ -103,6 +163,17 @@ static int exynos_trng_init(struct hwrng *rng)
 	return 0;
 }
 
+static int exynos_trng_init_smc(struct hwrng *rng)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_INIT, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != HWRNG_RET_OK)
+		return -EIO;
+
+	return 0;
+}
+
 static int exynos_trng_probe(struct platform_device *pdev)
 {
 	struct exynos_trng_dev *trng;
@@ -112,21 +183,29 @@ static int exynos_trng_probe(struct platform_device *pdev)
 	if (!trng)
 		return ret;
 
+	platform_set_drvdata(pdev, trng);
+	trng->dev = &pdev->dev;
+
+	trng->flags = (unsigned long)device_get_match_data(&pdev->dev);
+
 	trng->rng.name = devm_kstrdup(&pdev->dev, dev_name(&pdev->dev),
 				      GFP_KERNEL);
 	if (!trng->rng.name)
 		return ret;
 
-	trng->rng.init = exynos_trng_init;
-	trng->rng.read = exynos_trng_do_read;
 	trng->rng.priv = (unsigned long)trng;
 
-	platform_set_drvdata(pdev, trng);
-	trng->dev = &pdev->dev;
+	if (trng->flags & EXYNOS_SMC) {
+		trng->rng.init = exynos_trng_init_smc;
+		trng->rng.read = exynos_trng_do_read_smc;
+	} else {
+		trng->rng.init = exynos_trng_init_reg;
+		trng->rng.read = exynos_trng_do_read_reg;
 
-	trng->mem = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(trng->mem))
-		return PTR_ERR(trng->mem);
+		trng->mem = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(trng->mem))
+			return PTR_ERR(trng->mem);
+	}
 
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -170,12 +249,31 @@ static int exynos_trng_probe(struct platform_device *pdev)
 
 static void exynos_trng_remove(struct platform_device *pdev)
 {
+	struct exynos_trng_dev *trng = platform_get_drvdata(pdev);
+
+	if (trng->flags & EXYNOS_SMC) {
+		struct arm_smccc_res res;
+
+		arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_EXIT, 0, 0, 0, 0, 0, 0,
+			      &res);
+	}
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 
 static int exynos_trng_suspend(struct device *dev)
 {
+	struct exynos_trng_dev *trng = dev_get_drvdata(dev);
+	struct arm_smccc_res res;
+
+	if (trng->flags & EXYNOS_SMC) {
+		arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_EXIT, 0, 0, 0, 0, 0, 0,
+			      &res);
+		if (res.a0 != HWRNG_RET_OK)
+			return -EIO;
+	}
+
 	pm_runtime_put_sync(dev);
 
 	return 0;
@@ -183,6 +281,7 @@ static int exynos_trng_suspend(struct device *dev)
 
 static int exynos_trng_resume(struct device *dev)
 {
+	struct exynos_trng_dev *trng = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -191,6 +290,20 @@ static int exynos_trng_resume(struct device *dev)
 		return ret;
 	}
 
+	if (trng->flags & EXYNOS_SMC) {
+		struct arm_smccc_res res;
+
+		arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_RESUME, 0, 0, 0, 0, 0, 0,
+			      &res);
+		if (res.a0 != HWRNG_RET_OK)
+			return -EIO;
+
+		arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_INIT, 0, 0, 0, 0, 0, 0,
+			      &res);
+		if (res.a0 != HWRNG_RET_OK)
+			return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.39.2


