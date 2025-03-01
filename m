Return-Path: <linux-kernel+bounces-539915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC3A4AACA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D937166363
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78B1DF960;
	Sat,  1 Mar 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrk8K8/q"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68021DF253
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829433; cv=none; b=eSrqmVGvE3WlPszxZofPGw1DZLOub9h6c8Hn0aLorbUCzYduNkEmSZQz8huEo5fh2ZkyZN4BzrxruiEfCIBK40pZh0/ezv9vnXM7jO3H+EdeYpFUu8wUqG7FifntS5dz3uExXLbGs9fEOn+Vo1ss8TZjEZ90sfLibkONgKp8e70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829433; c=relaxed/simple;
	bh=Rt0hCQ7EEJnbniMu4u2x1+6fzo/ekNqUHhKZTA6KCkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGN69yC1aX0Sm0HRdzmMms3zR3wsvqN59GUPkh1B8OCH7gAWgg5cFBYclKVauG+xQfAOnYu3FN7SvWbm/wu5h8JDXtSouTZUfZ9Wnkr4vYxu/z9P4t82BXDqsOAdTMPG437BQWCtp7u5KnyTLUhfzhloBIU6wr0uYhBg8vZBzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrk8K8/q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390effd3e85so1543080f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740829430; x=1741434230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1NBXJidkBGm2njw6LIa5Omst8pPNRb+XaVquPbX31s=;
        b=nrk8K8/qryHUWywi8ZVnKR16sHUnyHa3EVSdEacCuqZ2ruh94k6z4NFEsrrP42krpI
         Ldx3KG1VRHI0cI2wuBasL/z6pnRwX9OABv5V/Mzr2Sv73NEWPb1SUelP6Ne4E4ksrv5r
         nozxKRUEt/n9vrGs2YB+Jd7DD7iGhqbwCirtND4Yunbh43hz3KTl99Zi3Kou6ZgkhvDI
         hnGsCrKOkWIzCPYu9hkWhuzFrL5WumabcR5lHeM+P9byhaFuOUYpq0CEW60Pj8gvzVQe
         EKznZNGj3in4LMOt6i6AKBE8fateC2CG7aDdU7ffeLlVw1zaLPwGgBIWhIdW7LTbpgY1
         YMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829430; x=1741434230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1NBXJidkBGm2njw6LIa5Omst8pPNRb+XaVquPbX31s=;
        b=rS01cFI8SM+0kscRJQ1OemIT1Qk3NZ1XfVaoP6ESvFVpZKTdeRlUEJx9dR6Fa33jzC
         3fFy4L9zpJJe/y7YTjinePXg9rxe4AWERuzqnv/pqfkaqnhIPvjynBVMhtlFIXrNq3MO
         mJbSICryWaFOzjo/cPvs24Jj9byej+IoTWHPUM8NKN+EKUv9x1zWijlNZKWTgz0SqboX
         3PMWNgJwU1D7Mq41M2FOgJcsVuWgdllHKyrF5dZLhtZ4qHBe6VbBOvY8XYGGtywS8MBT
         +6EFJbVWvRoRSc3x0imMO5RByhrAlYTkquWGBSR7dYYqcMwfjQCMGWQMArpidang6NyK
         m+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG4pkEC23Wp7FNl1kyQqskhuyXZprMUqERVm1QfVMZ2cNUp7CGuX2OA0nyh2KqK//pMPoHsuMFKQ1hQDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+Vj4mfvFp5K56nVFmNMDRdzhCUfJnZfMCcS9ZPy/RAe06O3K
	B5YuOBNVmMq185BHPBNUFj1GS46XnYnMKf3fUJ/EKXgpjcm4J2AHqpOdAk1l/QE=
X-Gm-Gg: ASbGncvsnJG+2B11okDpKAaGKx+gKtQbcO3hNHlcRq+IDfket34fTFFMRgvOsKgm3F+
	feALz1tm13GttamxSD0LmFuaxthZaTxpU5JJPGO4AxxkxpJd8k5BmWzudCgcAc1Te+vwIxv9Haa
	qn5ZBWwzMBA65LnzytbP8rbiaVInSX2zCmz1lbODxItMxdg5uyduHNPnz2CInWmnYwnwGmoUzML
	NHn4UJlx+ge/NR6i9wlU9EB8/6XC8+fL4+TiUovW5X72xHVriK8EhBF8ww/nS27zJc5X8L23YcS
	lBydlvRVPcl56ayWXu/zJ5zMIjrE1S0q0qGTz+ITmC9BOTgJuINJgDf1d18njx+EF3QrtJuuCRk
	=
X-Google-Smtp-Source: AGHT+IHbf3C2cKV5VNg4w9HYYGVhTfvb8MGb89lf6+MR83bDnKCZPqk6aJ4AsegYvjQ6Ya45+DM4ng==
X-Received: by 2002:a5d:5f84:0:b0:390:df83:1f5d with SMTP id ffacd0b85a97d-390eca52f6dmr6773296f8f.35.1740829430126;
        Sat, 01 Mar 2025 03:43:50 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796600sm8002871f8f.20.2025.03.01.03.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:43:49 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sat, 01 Mar 2025 11:43:22 +0000
Subject: [PATCH v2 4/4] pinctrl: samsung: Add filter selection support for
 alive bank on gs101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-pinctrl-fltcon-suspend-v2-4-a7eef9bb443b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5244;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=Rt0hCQ7EEJnbniMu4u2x1+6fzo/ekNqUHhKZTA6KCkg=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnwvLtplYOMeVA4pMszyl6HNpGhtya0aSaJnCsl
 /qHoc0BlXOJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8Ly7QAKCRDO6LjWAjRy
 uixWD/9u2iwpTaNDJxSTN50ZLujwgyWgslkzSejWqwBjDft55EN4595kqD1TFeOIenIOoGqK51n
 tcdr7yg+h7irFTgUXFOr6ciSFZmucDgRDxvRC74L1Gl9z1DYbfbmk608rdzn3tbvCOe5wbvGSWu
 mTNnsxkwgzHDIe4+zy7o7jgNW72eEjnMteahdc253vhmM1g/xF/mBSJLPKARTe9+Pg7b86CnaLp
 g3C+uvdvYJtsOrb7V7E3AVKuHgCJXHBatFuGjMpoD6BA1dgU7O6AoHe+wgbciydXJ2gGJSTcVWk
 SMqJoh3T3wcz+mrlqY0iTIer0uhN1GzYFzSXK7vXBDxqCYj0XY6m6+exigoPyXv8+IXrqCGUUfI
 KqFxz4l/qPWo/NnE0KO2WRP1BwyPt9JjSaoiPDl/pn/MkOp0+UNFoFm+uwhWO/6ufF1XlLTi+sa
 w3sKkJ2iyTxviny/mtNkBiswLKBrqtx9Ls+sVx4VMBjBhZyExRvA8t+TpdNhhYpJR5fyJ3Avxhm
 U53AWqIB81ARuYMPHRcw9oJvZtq01IUMQqbgBD9hyoxmeue8IcwfKZ/vDLgB1SmKBIIqNps8YCI
 H6U9qhYmLHXJltgVLLB7QolHluLplzav2oDYi+vjf1cpvDiuvz0t+NyqYiVlyaz8lXAuvQreqPz
 oIwT/UOlTgz1BAg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Newer Exynos based SoCs have a filter selection bitfield in the filter
configuration registers on alive bank pins. This allows the selection of
a digital or analog delay filter for each pin. Add support for selecting
and enabling the filter.

On suspend we set the analog filter to all pins in the bank (as the
digital filter relies on a clock). On resume the digital filter is
reapplied to all pins in the bank. The digital filter is working via
a clock and has an adjustable filter delay flt_width bitfield, whereas
the analog filter uses a fixed delay.

The filter determines to what extent signal fluctuations received through
the pad are considered glitches.

The code path can be exercised using
echo mem > /sys/power/state
And then wake the device using a eint gpio

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---

Changes since v1:
* Remove eint_flt_selectable bool as it can be deduced from EINT_TYPE_WKUP (Peter)
* Move filter config comment to header (Andre)
* Rename EXYNOS_FLTCON_DELAY to EXYNOS_FLTCON_ANALOG (Andre)
* Remove misleading old comment (Andre)
* Refactor exynos_eint_update_flt_reg() into a loop (Andre)

Note: this patch was previously sent as part of the initial gs101/ Pixel 6
series and was dropped in v6. This new version incorporates the review
feedback from Sam Protsenko here in v5.

Link: https://lore.kernel.org/all/20231201160925.3136868-1-peter.griffin@linaro.org/T/#m79ced98939e895c840d812c8b4c2b3f33ce604c8

Changes since previous version
* Drop fltcon_type enum and use bool eint_flt_selectable (Sam)
* Refactor and add exynos_eint_update_flt_reg() (Sam)
* Rename function to exynos_eint_set_filter() for easier readability (Sam)
* Remove comments and `if bank->fltcon_type != FLT_DEFAULT)` checks and indentation (Sam)
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 35 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.h | 21 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index ddc7245ec2e5..4c467651b034 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -369,6 +369,39 @@ struct exynos_eint_gpio_save {
 	u32 eint_mask;
 };
 
+static void exynos_eint_update_flt_reg(void __iomem *reg, int cnt, int con)
+{
+	unsigned int val, shift;
+	int i;
+
+	val = readl(reg);
+	for (i = 0; i < cnt; i++) {
+		shift = i * EXYNOS_FLTCON_LEN;
+		val |= con << shift;
+	}
+	writel(val, reg);
+}
+
+/*
+ * Set the desired filter (digital or analog delay) and enable it to
+ * every pin in the bank. Note the filter selection bitfield is only
+ * found on alive banks. The filter determines to what extent signal
+ * fluctuations received through the pad are considered glitches.
+ */
+static void exynos_eint_set_filter(struct samsung_pin_bank *bank, int filter)
+{
+	unsigned int off = EXYNOS_GPIO_EFLTCON_OFFSET + bank->eint_fltcon_offset;
+	void __iomem *reg = bank->drvdata->virt_base + off;
+	unsigned int con = EXYNOS_FLTCON_EN | filter;
+
+	if (bank->eint_type != EINT_TYPE_WKUP)
+		return;
+
+	for (int n = 0; n < bank->nr_pins; n += 4)
+		exynos_eint_update_flt_reg(reg + n,
+					   min(bank->nr_pins - n, 4), con);
+}
+
 /*
  * exynos_eint_gpio_init() - setup handling of external gpio interrupts.
  * @d: driver data of samsung pinctrl driver.
@@ -834,6 +867,7 @@ void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
 		pr_debug("%s: save    mask %#010x\n",
 			 bank->name, save->eint_mask);
 	}
+	exynos_eint_set_filter(bank, EXYNOS_FLTCON_ANALOG);
 }
 
 void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
@@ -889,6 +923,7 @@ void gs101_pinctrl_resume(struct samsung_pin_bank *bank)
 		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
 		       + bank->eint_offset);
 	}
+	exynos_eint_set_filter(bank, EXYNOS_FLTCON_DIGITAL);
 }
 
 void exynos_pinctrl_resume(struct samsung_pin_bank *bank)
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 773f161a82a3..203d4b76a956 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -52,6 +52,27 @@
 #define EXYNOS_EINT_MAX_PER_BANK	8
 #define EXYNOS_EINT_NR_WKUP_EINT
 
+/*
+ * EINT filter configuration register (on alive banks) has
+ * the following layout.
+ *
+ * BitfieldName[PinNum][Bit:Bit]
+ * FLT_EN[3][31] FLT_SEL[3][30] FLT_WIDTH[3][29:24]
+ * FLT_EN[2][23] FLT_SEL[2][22] FLT_WIDTH[2][21:16]
+ * FLT_EN[1][15] FLT_SEL[1][14] FLT_WIDTH[1][13:8]
+ * FLT_EN[0][7]  FLT_SEL[0][6]  FLT_WIDTH[0][5:0]
+ *
+ * FLT_EN	0x0 = Disable, 0x1=Enable
+ * FLT_SEL	0x0 = Analog delay filter, 0x1 Digital filter (clock count)
+ * FLT_WIDTH	Filtering width. Valid when FLT_SEL is 0x1
+ */
+
+#define EXYNOS_FLTCON_EN		BIT(7)
+#define EXYNOS_FLTCON_DIGITAL		BIT(6)
+#define EXYNOS_FLTCON_ANALOG		(0 << 6)
+#define EXYNOS_FLTCON_MASK		GENMASK(7, 0)
+#define EXYNOS_FLTCON_LEN		8
+
 #define EXYNOS_PIN_BANK_EINTN(pins, reg, id)		\
 	{						\
 		.type		= &bank_type_off,	\

-- 
2.48.1.711.g2feabab25a-goog


