Return-Path: <linux-kernel+bounces-171553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A548BE5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C431C220C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44716F82F;
	Tue,  7 May 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwz6PqYh"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DC16F0DF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091291; cv=none; b=tlj84JtPhcjkjtnIkjL9BgL8LIsrd/w6vPk8f7VEAY4xFKN5eg6faS5ZXnoTi7JgmyssYt8Tu6OWjoSpTuRhyc5W0dFG2B3vfLlLdaC+qxRKZuQy+UM171job3MRS4OLubyT25aGiePwxx9o+IXfhPQeSxOpgOLoDHLbHwHUlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091291; c=relaxed/simple;
	bh=nNkzepDc1fooDRMrZKnyw8mRCNAwIUztgx5zJ3NkPpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCNi7rjUajYV4O0MHdz0cs4TI/zSfYo8oalq/EVNQhZ/3QtQigW6xKyLo1EqGBycFm4QA7sqvGdvj2rPUy9ZcTU5L3oWFd71SP9TK+ZqtM6wOzCjWG+3xCJl5IoqAqXOkXeSr7K6nE0g1qbyo5mapLx4Z8GH1DUMs5r3zvDtmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwz6PqYh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so5053062a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715091288; x=1715696088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AhGxPfO0jxLeMCNC4W84i2OQnqDzy87o4JACQM4lhg=;
        b=rwz6PqYh12EfdzpbqGaIhigcNlzEMv20hALD5YwidYNpOkQ3mZFfYllao27HnUysO2
         vD+jZIm8N6iESTx92EzUgXnsFqlzTOzrpIYHCIDsIGUzppEOnfJ4BBDniDzEW5invIfb
         we7pa6HsMUsQ6WQRl9zi4WJ95rkFjxLitmNVoRCkeJxjJrFBLDbWG9UeUo0DYBnFTfh6
         tukubdeWu9zbAfVhJfV3+ZqvhXuimZWzPknW33ThWF5zVWP7qVunTF9+Ucb2/o9J/e+G
         HXV5By8Mp5E1KaT2m8w+60jow6Gc81pF3Jjr/11Be2ScV3cGTHNAU7b6Ryi9roAN90eq
         fQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091288; x=1715696088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AhGxPfO0jxLeMCNC4W84i2OQnqDzy87o4JACQM4lhg=;
        b=iQD9LDMD/zOw6Japgh+lJQE2BCtuu4c0W6kwphxBCEr22bbxKqCjqI5CTKl0cyjZVz
         QR7Q2QoDrZFnlqmOtU4AXPRxTlVlIhNDM+doUucecJiCAL+WtHwpfAeAgMGSzsd+WHaS
         o2mo/rtjDsRuJYEMVysnrvoJY7yw/gtTpPUwl8l8YqJnxwan7msWJbtZMbKEh+aJ0XTK
         PAh3f6ijCghYbI9e8PLAQb95YbmOygCzIFjcLuIAb6f9SB0Ply4sOUpzi9qQyJlvZYoD
         TC7XrGfrhvjYdOql92OdS1uOebGE2lTgPjoGCLvRZdDG5duFFVTFRf9TjFj8j+3qR5fg
         TWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhb76fxNgduqF/f3Ssy6Ou1MteCnuJMNDcAemXH00/oggNq1i4RzNN1OJgkmodZFymFv0zTFas+8MMd1duXYPf3xcZfO5/Srf6TAN+
X-Gm-Message-State: AOJu0YynCNRbEJkJA5NItvMoElpbvsB7mpKm3ngQW40scJkcQeeiw8/d
	TmgEIAn2GsVOW9+JAHT02nvxYYuSjbFPleXto4EOe5zoxmg2hpejZYPxa/yBpog=
X-Google-Smtp-Source: AGHT+IF93U5EbjSwxazXGCgRUoQpkJwYIG6vkvVms1C680kr/QzgHDatBvsRnvscl1lkUzBabOX3fA==
X-Received: by 2002:a50:f683:0:b0:572:a158:8a7b with SMTP id d3-20020a50f683000000b00572a1588a7bmr2479836edn.8.1715091287917;
        Tue, 07 May 2024 07:14:47 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm5621928eda.23.2024.05.07.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:14:47 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 May 2024 15:14:48 +0100
Subject: [PATCH 5/5] phy: exynos5-usbdrd: set ref clk freq in
 exynos850_usbdrd_utmi_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-samsung-usb-phy-fixes-v1-5-4ccba5afa7cc@linaro.org>
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org>
In-Reply-To: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

While commit 255ec3879dd4 ("phy: exynos5-usbdrd: Add 26MHz ref clk
support") correctly states that CLKRSTCTRL[7:5] doesn't need to be set
on modern Exynos platforms, SSPPLLCTL[2:0] should be programmed with
the frequency of the reference clock for the USB2.0 phy instead.

I stumbled across this while adding support for the Google Tensor
gs101, but this should apply to E850 just the same.

Do so.

Fixes: 691525074db9 ("phy: exynos5-usbdrd: Add Exynos850 support")
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Feel free to drop the Fixes: if you think that is unwarranted here.

v2: add missing bitfield.h include (seems this is implied on some
    platforms, but not on others)
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 1da7a4881f72..15be966b50ae 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -8,6 +8,7 @@
  * Author: Vivek Gautam <gautam.vivek@samsung.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -141,6 +142,9 @@
 #define CLKRST_PORT_RST				BIT(1)
 #define CLKRST_LINK_SW_RST			BIT(0)
 
+#define EXYNOS850_DRD_SSPPLLCTL			0x30
+#define SSPPLLCTL_FSEL				GENMASK(2, 0)
+
 #define EXYNOS850_DRD_UTMI			0x50
 #define UTMI_FORCE_VBUSVALID			BIT(5)
 #define UTMI_FORCE_BVALID			BIT(4)
@@ -773,6 +777,31 @@ static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 	reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
 	writel(reg, regs_base + EXYNOS850_DRD_HSP);
 
+	reg = readl(regs_base + EXYNOS850_DRD_SSPPLLCTL);
+	reg &= ~SSPPLLCTL_FSEL;
+	switch (phy_drd->extrefclk) {
+	case EXYNOS5_FSEL_50MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
+		break;
+	case EXYNOS5_FSEL_26MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 6);
+		break;
+	case EXYNOS5_FSEL_24MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 2);
+		break;
+	case EXYNOS5_FSEL_20MHZ:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 1);
+		break;
+	case EXYNOS5_FSEL_19MHZ2:
+		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 0);
+		break;
+	default:
+		dev_warn(phy_drd->dev, "unsupported ref clk: %#.2x\n",
+			 phy_drd->extrefclk);
+		break;
+	}
+	writel(reg, regs_base + EXYNOS850_DRD_SSPPLLCTL);
+
 	/* Power up PHY analog blocks */
 	reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
 	reg &= ~HSP_TEST_SIDDQ;

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


