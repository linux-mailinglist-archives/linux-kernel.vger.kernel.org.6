Return-Path: <linux-kernel+bounces-423364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DAE9DA680
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FD9B25CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC581E2317;
	Wed, 27 Nov 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6SEZ68F"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8E1E1045
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705100; cv=none; b=V8NUJSHgNk8C9tmiHCaybBIU3R5E5DHR6qtPix1jdCkMS7vGfmZ+UXuVLbsHFYKL56Nq0ladeAevX/4TuHBynpsPoPDz0mg/Anpow2Lu7IxFM/tV20ZAo6mtGGXAJfgsUU0RSiBYYlPeevqrGSbsF0gSClsKQuCj92d8f74oJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705100; c=relaxed/simple;
	bh=DEjXbk2ZL7RN6klD/z2w1DAkclajULASsORJFiQ9lKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEmNWu/cKGjQa5Xd067wjIvI/PSZomw7VeergOXnfa8DjmB49AClKEWcUdq8UpsA3haaVLtEJUa/IyBjeAYej/QpkN8Kn8yOaFX5yTZA4UPmvVawQmAMiw64WIRh9ZFGmFQv5geIz1nr7qsL5gLWTpmOqB6KPL6xysQFQBXT20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6SEZ68F; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa535eed875so633852166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705097; x=1733309897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqGYeTvXa+CcRrauQewHltxn0fZOtsvS5bEzws0xGp0=;
        b=G6SEZ68FWhwqE154WNWR4XmEMmHzJLSNNL4p2xDZTTPqI/2j48w3mpJlw2HVxjY6mm
         /qH/5JF86T+Diio/fV0XKhiap7w8trM/YQ/sdozacIqcT8J7IBz/wOhIarbYo1qUITxP
         FilVFRIvNmyp4LGdPelTj6u+cEEPWn5bGdfaylkoU9aFTgyLdNxQJFWPwRCPs0oLekE1
         ShBRDE0iJdd2aB5m8PpU6ByTgVbHzm9xFOQeZ9wqiMcLB2S83Z5EdAgCAxGiiF3+C7RB
         BHnS2jWYmLDiQuiJsNQqUE4lsOgnjn+PDq65M6YnE7wHmQ2FH5ygObqv20O0IJhdqaEs
         IkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705097; x=1733309897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqGYeTvXa+CcRrauQewHltxn0fZOtsvS5bEzws0xGp0=;
        b=aSbAXiP7lhuJbeDjq0XalORXx1AbQwR2ybZuow8ll6nteY4GXVgVyVBGkt/8Le4auA
         I6U6jyK7b9yVPKpS791TLDoBoUdjESBb+LjHtm48GoRKkP//2Slv/c1PPCs8qY1OCeDu
         7paB3bh+MBxKVCqOcKKEXrswTph+01Aj5MweKTs4nF9KToyDBCPOxOcTt94Aprdxht+j
         W1QJ9yXetEz8IWFAfAkWz54vZr+D0DxsiAcPXuxbFhVBarQM1Ruj/UOcCnlAjS+AVJTJ
         qerNss6AlIfjUMx52Jfq9PiaQX/GDLnB+0mL5BcZBe88tXr39j/lJ14wlZZsaWojxagk
         3WvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVA23lI0xeTa1WVugpuoL7XpkROcI6RDAB4zh7s+AZ6Ah5zCjuYYJM/VwO1MD1zV2DcKDI3ErnFKRdxWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3iiSdYcgBhj6NcF29ke4ugsUpe8lvvuHUWAFDGnaThQci37GW
	ZrPOr+AXsBwtgAMWxVCeUEpfAwyWvltZccz18/Pv0AMd3g2TM2EybZtytLczD1s=
X-Gm-Gg: ASbGncsQ/hQZmzMe6rPEbhYuaqAYArzcxfUKBBRCphOfggmP5o2wRkVcdXz5UmDHYcO
	sdDcCkC/4Xwz/VMt2bYm45l/SWQ3E3W3N2TELQLruhR6jH0hc72ff6jlnT3rbcPP+enU1WR4nBK
	GMM0v6QVAQoyVio/xsCWJDTBPcIXvxsRFk4bQ9sZQCU8R4QqJbvJE6dV//d3et/G3yCupD/HI4Z
	OAYmmmEEnbxnJaz4Z718L1GIKrykQLTduACi5Pj23r7oHUUdPO0X8KrXoj3irWRsCZeYRxU4DMO
	OGKd+pdP56spKZpJOkirZyf/eIVPseNWzQ==
X-Google-Smtp-Source: AGHT+IGfxl8jje43Ziyzp10Eq1Sbw1hY/V6VsB8QGc/5pAdKJlSGGUSbGZ9QxG2adkSeh2QmDqCL0g==
X-Received: by 2002:a17:907:7637:b0:aa5:4adc:5a1f with SMTP id a640c23a62f3a-aa580f58e93mr163841166b.33.1732705096651;
        Wed, 27 Nov 2024 02:58:16 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:16 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 10:58:19 +0000
Subject: [PATCH 9/9] phy: exynos5-usbdrd: allow DWC3 runtime suspend with
 UDC bound (E850+)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-9-1b7fce24960b@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

To make USB runtime suspend work when a UDC has been bound, the phy
needs to inform the USBDRD controller (DWC3) that Vbus and bvalid are
gone, so that it can in turn raise the respective gadget interrupt with
event == DWC3_DEVICE_EVENT_DISCONNECT, which will cause the USB stack
to clean up, allowing DWC3 to enter runtime suspend.

On e850 and gs101 this isn't working, as the respective signals are not
directly connected, and instead this driver uses override bits in the
PHY IP to set those signals. It currently forcefully sets them to 'on',
so the above mentioned interrupt will not be raised, preventing runtime
suspend.

To detect that state, update this driver to act on the TCPC's
orientation signal - when orientation == NONE, Vbus is gone and we can
clear the respective bits. Similarly, for other orientation values we
re-enable them.

This makes runtime suspend work on platforms with a TCPC (like Pixel6),
while keeping compatibility with platforms without (e850-96).

With runtime suspend working, USB-C cable orientation detection now
also fully works on such platforms, and the link comes up as Superspeed
as expected irrespective of the cable orientation and whether UDC /
gadget are configured and active.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 53 +++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 2010d25ee817..4882158df1a5 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1136,13 +1136,15 @@ static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 	reg |= LINKCTRL_BUS_FILTER_BYPASS(0xf);
 	writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
 
-	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
-	reg |= UTMI_FORCE_BVALID | UTMI_FORCE_VBUSVALID;
-	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
-
-	reg = readl(regs_base + EXYNOS850_DRD_HSP);
-	reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
-	writel(reg, regs_base + EXYNOS850_DRD_HSP);
+	if (!phy_drd->sw) {
+		reg = readl(regs_base + EXYNOS850_DRD_UTMI);
+		reg |= UTMI_FORCE_BVALID | UTMI_FORCE_VBUSVALID;
+		writel(reg, regs_base + EXYNOS850_DRD_UTMI);
+
+		reg = readl(regs_base + EXYNOS850_DRD_HSP);
+		reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
+		writel(reg, regs_base + EXYNOS850_DRD_HSP);
+	}
 
 	reg = readl(regs_base + EXYNOS850_DRD_SSPPLLCTL);
 	reg &= ~SSPPLLCTL_FSEL;
@@ -1407,9 +1409,44 @@ static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
 				       enum typec_orientation orientation)
 {
 	struct exynos5_usbdrd_phy *phy_drd = typec_switch_get_drvdata(sw);
+	int ret;
+
+	if (phy_drd->orientation == orientation)
+		return 0;
+
+	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
+	if (ret) {
+		dev_err(phy_drd->dev, "Failed to enable PHY clocks(s)\n");
+		return ret;
+	}
+
+	scoped_guard(mutex, &phy_drd->phy_mutex) {
+		void __iomem * const regs_base = phy_drd->reg_phy;
+		unsigned int reg;
+
+		if (orientation == TYPEC_ORIENTATION_NONE) {
+			reg = readl(regs_base + EXYNOS850_DRD_UTMI);
+			reg &= ~(UTMI_FORCE_VBUSVALID | UTMI_FORCE_BVALID);
+			writel(reg, regs_base +  EXYNOS850_DRD_UTMI);
+
+			reg = readl(regs_base + EXYNOS850_DRD_HSP);
+			reg |= HSP_VBUSVLDEXTSEL;
+			reg &= ~HSP_VBUSVLDEXT;
+			writel(reg, regs_base + EXYNOS850_DRD_HSP);
+		} else {
+			reg = readl(regs_base + EXYNOS850_DRD_UTMI);
+			reg |= UTMI_FORCE_VBUSVALID | UTMI_FORCE_BVALID;
+			writel(reg, regs_base +  EXYNOS850_DRD_UTMI);
+
+			reg = readl(regs_base + EXYNOS850_DRD_HSP);
+			reg |= HSP_VBUSVLDEXTSEL | HSP_VBUSVLDEXT;
+			writel(reg, regs_base + EXYNOS850_DRD_HSP);
+		}
 
-	scoped_guard(mutex, &phy_drd->phy_mutex)
 		phy_drd->orientation = orientation;
+	}
+
+	clk_bulk_disable(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }

-- 
2.47.0.338.g60cca15819-goog


