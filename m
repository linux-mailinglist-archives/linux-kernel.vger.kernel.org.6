Return-Path: <linux-kernel+bounces-539913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F21A4AAC5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED73D1899591
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE811DF728;
	Sat,  1 Mar 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnA9Sypw"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045F1DED4A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829431; cv=none; b=i8Qx9QT+4FgAjIre93uH52g6Eg33sa7XVRd6dyqEmiUNLtHxXaqnmhlsiK1K6/q4m4VTXt7BDSIT/r7pKEC+q2w4+xnBUNmTvqELBbfz6zcvOmY2sHScYyUKZTsXtfUC7IJTA9q3Fv0emQ4xT0fE9F16AdrrBcji4TuJTQYsWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829431; c=relaxed/simple;
	bh=SXg8uc9RN8oGMNLf9fgTHgfRJFosyoWk23ZDrH2XV0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZLVX+H4X/FuDek/zNTzQjMCKkCYsQ8Xi3UmeBIL0FDnqTZzCiLgVlK+WfhYsjuZWnG8K/VEKmcNbUhUSaoEOvg82XTdA2uwWkkP45R+o+NWfNEOKXxKCr2dEf/smiPDiQLLnwijXfgm8Xbg4mFoRECP+E1btnVhYZOEXiz6J9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cnA9Sypw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1811877f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740829428; x=1741434228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEalY0ECFbrm/yO6z0ef8lDq/5fB/ZQ7LJFfteTHd60=;
        b=cnA9Sypw+A61uZNLl6V5+qltUS37WfoZZ3r5Hqu8MQBsiPVvd+0qbiM7BABqNFn+Ve
         wE8YVW3XolNDXqvvJGqTwVZWJdqhG606T77tkJURAdOaoLjG0PAU9KAIpX93LYFHp7/i
         L//qnl7FqaEGOoy2ag33BCyYqZzcRcuBqL9xQpZwYEsjWcSaw4bWtsSgwq+6jEYDVrdU
         GbZXKH0v5cyMjJhnrYKZ5CWZX6TOzBYt6v/R9t3m+faeMx0A+s9jcLInGe9p9+fwngzj
         TBqJo02A7gwhBkRt1TrjquUIyMnZn1i1M0Y/gidm6QhhVp+KCGi60RY6C0uqwmMscs/g
         /t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829428; x=1741434228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEalY0ECFbrm/yO6z0ef8lDq/5fB/ZQ7LJFfteTHd60=;
        b=j+Rvwuywmla74OamXIKKEg8xI1+4hxcn+PZpu3Z0uceeF34HVZ6Q3UHv51J5YEXr8e
         0sz9bYCEB5zjuS75Qwz/8fp4L2sp0JU56V9vInoSoIl07u5ge0ZHRZEH2iWE7WjhgpKR
         +Q7R5yGFC0EXcQd1AmAmxvFxHmkjKr5fPDUyMFhmkFyBkW+qu9UA04uZiMkV2FP1wVS4
         7+Iqme5qPPp7OBaCfHDF2LV2Y818QTRlIZtuu6fLLck10GdehPnlKK0AHD7k/pe7P18b
         gd4398dQeyT0JDoNMxoMyYOv5modSvxOt1MuejwdH48aAkm8Zn9J9R8pKmUcM3uD+6h9
         m8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWMmhagEaJVSQlQQ0mco+BKDmz6z9NXcBnw49G7DnGQSStcsAa6QKh4eeCkamNwabP2ftr/I/Dj8RisqD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnNJaC5Il3IZMUK6o+Ot95JAo5QobHCI5MqID77P6t2hCz8Lt
	wiZNEsWJNSvBPMxVfg73/J4d2n/2/M60MdXQ9moXnYanKgpCM5zbMNqZiH+rb0k=
X-Gm-Gg: ASbGncsAOrQea6/+ftkXeK/JHL8fjy5fKxBEm5vSKW9sz6nkpZGt8plpRVvpU2PBiYK
	O36ZMrSS+nUwZIwqnHFzXkaR3KLsotuYISiWhPPpIwgbxZN/vEmQ6OvOa1nfrV/OIwDmY5s7GjW
	PvVR7CcqRseVSZeToeroDBQp/BZjcpp/t5mfljKhzSpO5cOVHvGFNNmfpoJ/pmWaisSa8sxHUGs
	WuSQOgt188wXbU3GlpOhtUeE3bn+9DXLhDo2e1MAL+RTm1vR275GHPgY6lU9R5xohjsC2ZgtIOR
	rzrL25OEOa6dx5jIsipZ8mFzCQmDloBdjbcA+4M9+9SUQ0HD5yjJjs3XLntix9eBu91j5ZStQQU
	=
X-Google-Smtp-Source: AGHT+IGUBkK9QoDzDBm2QtTPkor5bRpvw3w5gYuAHtkn8Bz6kT0YwDMv5KIfL0WnGHVsnSW6CvD9Eg==
X-Received: by 2002:a05:6000:381:b0:390:f18f:77a with SMTP id ffacd0b85a97d-390f18f0d14mr3909287f8f.24.1740829427667;
        Sat, 01 Mar 2025 03:43:47 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796600sm8002871f8f.20.2025.03.01.03.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:43:46 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sat, 01 Mar 2025 11:43:20 +0000
Subject: [PATCH v2 2/4] pinctrl: samsung: add dedicated SoC eint
 suspend/resume callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-pinctrl-fltcon-suspend-v2-2-a7eef9bb443b@linaro.org>
References: <20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org>
In-Reply-To: <20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=17160;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=SXg8uc9RN8oGMNLf9fgTHgfRJFosyoWk23ZDrH2XV0Q=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnwvLq3pviSBVOrXAsZFXvZ5ryC9N0MUkLa71Uy
 aJXETTEGZ2JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8Ly6gAKCRDO6LjWAjRy
 uugsEACiJDEGF6wE6WtRynhFvqjb9S2Dq8skEAgZ/CLwQ9fl80G9mSuQQ+MeNkbKFXQIJnxGTW6
 i+xjFCEhAGedu5UypDyDwYZXrf0Xkm817lBsYsRcO+JIPh/XkKSEuFgs1g8A2y1UuWuTRlfSWmg
 my7t3hRBW9tHHM2qjDe5S6OFoa4NJ4i1EBX26ODAwMNxduP+Y0byakPR5RjmyIW5es/s3HOOIFl
 +OaqGSCP/DCrCWqKSjXPKAgKqyJLjQGTivIDFm0DOmxBP+A0oRn41Jzlkm677ze9H3THmirpSN9
 vuF/ykSpRXCy9GWwin4s5vs8eiBE9psRElJICnyQpI3AC12mPNPJaF93Z00CmQPm4e7EEfpGLDF
 lSkNIj5r7M0jWe1R0J4SPMb3lri9xyexR/u+zFOCWm5eVMUdUyesVBiPUD3M52hytlmd99ycRdW
 8118b6AJJPWJ2JFS2LzL39H+BczhFw750P7Vc4IIrp5t0hugcin2za3Lbwb/PVNeyMhnpxqs741
 SiH/Ed/7zUuwoX5vI2FwMg4qH3185UYT7fUp6X8oN/9U5BhGTy523M9qLTbuL5zPPq2aXGGhDv0
 zWTijLbi7bgpaVJKNEvZlMJ+6CyfSmq29dasawj3kuJfNJ+Dy8ts7tx8GnZLQU/HmLYgeLt3eqn
 NJi6/j5DQ91Yz/g==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

gs101 needs it's own suspend/resume callbacks to use the newly
added eint_fltcon_offset for saving & restoring fltcon0 & fltcon1
registers. It also differs to previous SoCs in that fltcon1
register doesn't always exist for each bank.

exynosautov920 also has dedicated logic for using eint_con_offset
and eint_mask_offset for saving & restoring it's registers.

Refactor the existing platform specific suspend/resume callback
so that each SoC variant has their own callback containing the
SoC specific logic.

Additionally we now call drvdata->suspend() & drvdata->resume()
from within the loop that iterates the banks in
samsung_pinctrl_suspend() and samsung_pinctrl_resume().

This simplifies the logic, and allows us to remove the
clk_enable() and clk_disable() from the callbacks.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes since v1:
* Split code refactor & gs101 parts into separate patches (Andre)
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  28 ++--
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 201 ++++++++++---------------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |   6 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c      |  11 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h      |   8 +-
 5 files changed, 111 insertions(+), 143 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index e28fe8177646..57c98d2451b5 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -1112,8 +1112,8 @@ static const struct samsung_pin_ctrl exynosautov920_pin_ctrl[] = {
 		.pin_banks	= exynosautov920_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks0),
 		.eint_wkup_init	= exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 		.retention_data	= &exynosautov920_retention_data,
 	}, {
 		/* pin-controller instance 1 AUD data */
@@ -1124,43 +1124,43 @@ static const struct samsung_pin_ctrl exynosautov920_pin_ctrl[] = {
 		.pin_banks	= exynosautov920_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks2),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 3 HSI1 data */
 		.pin_banks	= exynosautov920_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks3),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 4 HSI2 data */
 		.pin_banks	= exynosautov920_pin_banks4,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks4),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 5 HSI2UFS data */
 		.pin_banks	= exynosautov920_pin_banks5,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks5),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 6 PERIC0 data */
 		.pin_banks	= exynosautov920_pin_banks6,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks6),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 7 PERIC1 data */
 		.pin_banks	= exynosautov920_pin_banks7,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks7),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	},
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index ac6dc22b37c9..d65a9fba0781 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -761,153 +761,118 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	return 0;
 }
 
-static void exynos_pinctrl_suspend_bank(
-				struct samsung_pinctrl_drv_data *drvdata,
-				struct samsung_pin_bank *bank)
+static void exynos_set_wakeup(struct samsung_pin_bank *bank)
 {
-	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	const void __iomem *regs = bank->eint_base;
+	struct exynos_irq_chip *irq_chip = NULL;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for saving state\n");
-		return;
+	if (bank->eint_type == EINT_TYPE_WKUP) {
+		if (bank->irq_chip) {
+			irq_chip = bank->irq_chip;
+			irq_chip->set_eint_wakeup_mask(bank->drvdata, irq_chip);
+		}
 	}
-
-	save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
-						+ bank->eint_offset);
-	save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset);
-	save->eint_fltcon1 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset + 4);
-	save->eint_mask = readl(regs + bank->irq_chip->eint_mask
-						+ bank->eint_offset);
-
-	clk_disable(bank->drvdata->pclk);
-
-	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
-	pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltcon0);
-	pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
-	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
 
-static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drvdata,
-					    struct samsung_pin_bank *bank)
+void exynos_pinctrl_suspend(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	const void __iomem *regs = bank->eint_base;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for saving state\n");
-		return;
+	exynos_set_wakeup(bank);
+
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
+				       + bank->eint_offset);
+		save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+					   + 2 * bank->eint_offset);
+		save->eint_fltcon1 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+					   + 2 * bank->eint_offset + 4);
+		save->eint_mask = readl(regs + bank->irq_chip->eint_mask
+					+ bank->eint_offset);
+
+		pr_debug("%s: save     con %#010x\n",
+			 bank->name, save->eint_con);
+		pr_debug("%s: save fltcon0 %#010x\n",
+			 bank->name, save->eint_fltcon0);
+		pr_debug("%s: save fltcon1 %#010x\n",
+			 bank->name, save->eint_fltcon1);
+		pr_debug("%s: save    mask %#010x\n",
+			 bank->name, save->eint_mask);
 	}
-
-	save->eint_con = readl(regs + bank->pctl_offset + bank->eint_con_offset);
-	save->eint_mask = readl(regs + bank->pctl_offset + bank->eint_mask_offset);
-
-	clk_disable(bank->drvdata->pclk);
-
-	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
-	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
 
-void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
+void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
 {
-	struct samsung_pin_bank *bank = drvdata->pin_banks;
-	struct exynos_irq_chip *irq_chip = NULL;
-	int i;
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	const void __iomem *regs = bank->eint_base;
 
-	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
-		if (bank->eint_type == EINT_TYPE_GPIO) {
-			if (bank->eint_con_offset)
-				exynosauto_pinctrl_suspend_bank(drvdata, bank);
-			else
-				exynos_pinctrl_suspend_bank(drvdata, bank);
-		}
-		else if (bank->eint_type == EINT_TYPE_WKUP) {
-			if (!irq_chip) {
-				irq_chip = bank->irq_chip;
-				irq_chip->set_eint_wakeup_mask(drvdata,
-							       irq_chip);
-			}
-		}
+	exynos_set_wakeup(bank);
+
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		save->eint_con = readl(regs + bank->pctl_offset +
+				       bank->eint_con_offset);
+		save->eint_mask = readl(regs + bank->pctl_offset +
+					bank->eint_mask_offset);
+		pr_debug("%s: save     con %#010x\n",
+			 bank->name, save->eint_con);
+		pr_debug("%s: save    mask %#010x\n",
+			 bank->name, save->eint_mask);
 	}
 }
 
-static void exynos_pinctrl_resume_bank(
-				struct samsung_pinctrl_drv_data *drvdata,
-				struct samsung_pin_bank *bank)
+void exynos_pinctrl_resume(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	void __iomem *regs = bank->eint_base;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for restoring state\n");
-		return;
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_ECON_OFFSET
+			       + bank->eint_offset), save->eint_con);
+		pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+			       + 2 * bank->eint_offset), save->eint_fltcon0);
+		pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+			       + 2 * bank->eint_offset + 4),
+			       save->eint_fltcon1);
+		pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->irq_chip->eint_mask
+			       + bank->eint_offset), save->eint_mask);
+
+		writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
+		       + bank->eint_offset);
+		writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
+		       + 2 * bank->eint_offset);
+		writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
+		       + 2 * bank->eint_offset + 4);
+		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
+		       + bank->eint_offset);
 	}
-
-	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
-			readl(regs + EXYNOS_GPIO_ECON_OFFSET
-			+ bank->eint_offset), save->eint_con);
-	pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
-			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-			+ 2 * bank->eint_offset), save->eint_fltcon0);
-	pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
-			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-			+ 2 * bank->eint_offset + 4), save->eint_fltcon1);
-	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
-			readl(regs + bank->irq_chip->eint_mask
-			+ bank->eint_offset), save->eint_mask);
-
-	writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
-						+ bank->eint_offset);
-	writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset);
-	writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset + 4);
-	writel(save->eint_mask, regs + bank->irq_chip->eint_mask
-						+ bank->eint_offset);
-
-	clk_disable(bank->drvdata->pclk);
 }
 
-static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
-					   struct samsung_pin_bank *bank)
+void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	void __iomem *regs = bank->eint_base;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for restoring state\n");
-		return;
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		/* exynosautov920 has eint_con_offset for all but one bank */
+		if (!bank->eint_con_offset)
+			exynos_pinctrl_resume(bank);
+
+		pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->pctl_offset + bank->eint_con_offset),
+			       save->eint_con);
+		pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->pctl_offset +
+			       bank->eint_mask_offset), save->eint_mask);
+
+		writel(save->eint_con,
+		       regs + bank->pctl_offset + bank->eint_con_offset);
+		writel(save->eint_mask,
+		       regs + bank->pctl_offset + bank->eint_mask_offset);
 	}
-
-	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
-		 readl(regs + bank->pctl_offset + bank->eint_con_offset), save->eint_con);
-	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
-		 readl(regs + bank->pctl_offset + bank->eint_mask_offset), save->eint_mask);
-
-	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
-	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
-
-	clk_disable(bank->drvdata->pclk);
-}
-
-void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
-{
-	struct samsung_pin_bank *bank = drvdata->pin_banks;
-	int i;
-
-	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
-		if (bank->eint_type == EINT_TYPE_GPIO) {
-			if (bank->eint_con_offset)
-				exynosauto_pinctrl_resume_bank(drvdata, bank);
-			else
-				exynos_pinctrl_resume_bank(drvdata, bank);
-		}
 }
 
 static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 33df21d5c9d6..35c2bc4ea488 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -221,8 +221,10 @@ struct exynos_muxed_weint_data {
 
 int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d);
 int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d);
-void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata);
-void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata);
+void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank);
+void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank);
+void exynos_pinctrl_suspend(struct samsung_pin_bank *bank);
+void exynos_pinctrl_resume(struct samsung_pin_bank *bank);
 struct samsung_retention_ctrl *
 exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 		      const struct samsung_retention_data *data);
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 963060920301..375634d8cc79 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1349,6 +1349,9 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 		const u8 *widths = bank->type->fld_width;
 		enum pincfg_type type;
 
+		if (drvdata->suspend)
+			drvdata->suspend(bank);
+
 		/* Registers without a powerdown config aren't lost */
 		if (!widths[PINCFG_TYPE_CON_PDN])
 			continue;
@@ -1373,8 +1376,6 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 
 	clk_disable(drvdata->pclk);
 
-	if (drvdata->suspend)
-		drvdata->suspend(drvdata);
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
 		drvdata->retention_ctrl->enable(drvdata);
 
@@ -1406,9 +1407,6 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 		return ret;
 	}
 
-	if (drvdata->resume)
-		drvdata->resume(drvdata);
-
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
 		void __iomem *reg = bank->pctl_base + bank->pctl_offset;
@@ -1416,6 +1414,9 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 		const u8 *widths = bank->type->fld_width;
 		enum pincfg_type type;
 
+		if (drvdata->resume)
+			drvdata->resume(bank);
+
 		/* Registers without a powerdown config aren't lost */
 		if (!widths[PINCFG_TYPE_CON_PDN])
 			continue;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 371e4f02bbfb..e939e5bb0347 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -285,8 +285,8 @@ struct samsung_pin_ctrl {
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
 	void		(*pud_value_init)(struct samsung_pinctrl_drv_data *drvdata);
-	void		(*suspend)(struct samsung_pinctrl_drv_data *);
-	void		(*resume)(struct samsung_pinctrl_drv_data *);
+	void		(*suspend)(struct samsung_pin_bank *bank);
+	void		(*resume)(struct samsung_pin_bank *bank);
 };
 
 /**
@@ -335,8 +335,8 @@ struct samsung_pinctrl_drv_data {
 
 	struct samsung_retention_ctrl	*retention_ctrl;
 
-	void (*suspend)(struct samsung_pinctrl_drv_data *);
-	void (*resume)(struct samsung_pinctrl_drv_data *);
+	void (*suspend)(struct samsung_pin_bank *bank);
+	void (*resume)(struct samsung_pin_bank *bank);
 };
 
 /**

-- 
2.48.1.711.g2feabab25a-goog


