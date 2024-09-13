Return-Path: <linux-kernel+bounces-327588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95CE977816
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF0E2872D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B913D245;
	Fri, 13 Sep 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BREDj6+f"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9B1D54C9;
	Fri, 13 Sep 2024 04:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202769; cv=none; b=NveCfQZlFAnUx8bg0LmvZYOp6FyoDVa9MJTcZh05XltiZuETKYfwE2uhbutedmjnXjPE1j4ny5UIFJOiy442ruUZMef22ksBbRBNn/1TayoW3lhbGsc4bd03O0plx+nxgJs+plEJtRqtdtodAg6Y98X2E0LB0si08nz8AL6LugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202769; c=relaxed/simple;
	bh=X3KlgtXHgexwXS0B4cwdvFH0XY8ZItddpY8RzLuW6m4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8JFsfEHMmm3tSxWGM2ySUwKbeSPFtNkH+0TBCvpJldezSLtTtxRxA8kqHd6De+KrvdVXPreyceJOaIWNymNr0GqYQyQHgDorH83KeqcAgb6ftEWo6gzyo4bmIfg/udiUCAtNUBeLZknWzAFgbCo+Mah07Iben06v1gdkduSdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BREDj6+f; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so4239908a12.1;
        Thu, 12 Sep 2024 21:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726202766; x=1726807566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etW/iub89JqiLphBAHzvsoo9XIPyzDTt8mamtwnIl7s=;
        b=BREDj6+fGscZdD6A6x3BIbkeKJ9tOQXea2zKyCclvHclN1MGaahC8BynKztmp5EJsA
         0afNkp1nwu3xMEEqQTQiwNRDVz8sJTgiTrcaC4/CSXvTwKNT/jad0/F1ocYDg/sQnT5Y
         K9yKwxaZANWFvAA7cfxrh8kk4MD+KUeviQLcMvz1fa+1cJ9lgmMMCMf3U2eZgpV6x+Fr
         V8lvCSjdCBsNj5NWEuPqu4jk8vgUjuHOVkNsa56qU/zGDCSwUJhkSTtaedwrVVxSxMX6
         vLULPcHT08i+FE3V5QAItI6ddOKr3BATuOEsZBMLZfBYF2nixwQ6J+Ls+ndbeanexHJx
         R/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726202766; x=1726807566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etW/iub89JqiLphBAHzvsoo9XIPyzDTt8mamtwnIl7s=;
        b=a+rb37cQy6k8Xc66Gm1YymfkynWrAch3SaQYkp73txtqjXBcsnGdNUXKIo/k2jFZ/V
         xccxj0pXvbw0eQ1tgH4mqvLpmgfrKL7RUOQ0XIysdT/VDQ09aOzrrmrqpkpfmzaY96oI
         n24tTOjXXEUbCjM3yth15OZR29xlnsNuP/uc/wGP4gOX94C4dOVsOd91LbT/U9LU0BgE
         aznWsRp6lASmJeSqB8RvNalBoODF7EtgTDeMAeOI+Sq+/l+5A9i+QT7+RjTKR0ZfVsNq
         iuoqPQ2S8U8/H75+TsC5LHPoPPkksShQ81IlqU8rc3k8FcXYa4hwPOiYIMf5bdezkk2M
         qLQA==
X-Forwarded-Encrypted: i=1; AJvYcCVGg0dSdni4n+ecS6d3rkNh15icIFj8nOMOJyhNAhdtLeQzHMvUNhmQ3bhk6fq60MhOh7z5HPuhyT9ZB/eq@vger.kernel.org, AJvYcCVL5UKdTHf+UgMCDMGmXFPkkSAhS7a7QxIhrYzyyHqEmn2RWmfNO/CV6iFpC7M4IYgnuH+556CICNND@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkyvhcod4roUbODUjdxKgZ/l6wpnONrfKJad+3M4z4D1JEYVaG
	WnpsGyrVO4th2fAM/0WFlLNKhZdlV3G3TGF6T2bnOkq6EgCmBXls
X-Google-Smtp-Source: AGHT+IHxgF432i43pDnIe5jmxrG9h7pU58o/7t/3GD8MSHv7ETteVuY0BK3UNxdrJtKC2Ox0T0rmDw==
X-Received: by 2002:a05:6402:520e:b0:5c2:5248:a929 with SMTP id 4fb4d7f45d1cf-5c41435c3d2mr6267297a12.7.1726202766355;
        Thu, 12 Sep 2024 21:46:06 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76fc4sm7303468a12.78.2024.09.12.21.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 21:46:05 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] phy: bcm-ns-usb2: drop support for old binding variant
Date: Fri, 13 Sep 2024 06:45:57 +0200
Message-Id: <20240913044557.28315-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240913044557.28315-1-zajec5@gmail.com>
References: <20240913044557.28315-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

The old binding was incorrectly designed and ended up being deprecated 3
years ago. Finally it has been dropped so relevant code it not needed
anymore.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/phy-bcm-ns-usb2.c | 54 +++++++-------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 5213c75b6da6..c5d35031b398 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -24,9 +24,6 @@ struct bcm_ns_usb2 {
 	struct phy *phy;
 	struct regmap *clkset;
 	void __iomem *base;
-
-	/* Deprecated binding */
-	void __iomem *dmu;
 };
 
 static int bcm_ns_usb2_phy_init(struct phy *phy)
@@ -49,10 +46,7 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 		goto err_clk_off;
 	}
 
-	if (usb2->base)
-		usb2ctl = readl(usb2->base);
-	else
-		usb2ctl = readl(usb2->dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	usb2ctl = readl(usb2->base);
 
 	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
 		usb_pll_pdiv = usb2ctl;
@@ -66,24 +60,16 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
 
 	/* Unlock DMU PLL settings with some magic value */
-	if (usb2->clkset)
-		regmap_write(usb2->clkset, 0, 0x0000ea68);
-	else
-		writel(0x0000ea68, usb2->dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	regmap_write(usb2->clkset, 0, 0x0000ea68);
 
 	/* Write USB 2.0 PLL control setting */
 	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
 	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
-	if (usb2->base)
-		writel(usb2ctl, usb2->base);
-	else
-		writel(usb2ctl, usb2->dmu + BCMA_DMU_CRU_USB2_CONTROL);
+
+	writel(usb2ctl, usb2->base);
 
 	/* Lock DMU PLL settings */
-	if (usb2->clkset)
-		regmap_write(usb2->clkset, 0, 0x00000000);
-	else
-		writel(0x00000000, usb2->dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	regmap_write(usb2->clkset, 0, 0x00000000);
 
 err_clk_off:
 	clk_disable_unprepare(usb2->ref_clk);
@@ -107,27 +93,17 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	usb2->dev = dev;
 
-	if (of_property_present(dev->of_node, "brcm,syscon-clkset")) {
-		usb2->base = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(usb2->base)) {
-			dev_err(dev, "Failed to map control reg\n");
-			return PTR_ERR(usb2->base);
-		}
-
-		usb2->clkset = syscon_regmap_lookup_by_phandle(dev->of_node,
-							       "brcm,syscon-clkset");
-		if (IS_ERR(usb2->clkset)) {
-			dev_err(dev, "Failed to lookup clkset regmap\n");
-			return PTR_ERR(usb2->clkset);
-		}
-	} else {
-		usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
-		if (IS_ERR(usb2->dmu)) {
-			dev_err(dev, "Failed to map DMU regs\n");
-			return PTR_ERR(usb2->dmu);
-		}
+	usb2->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(usb2->base)) {
+		dev_err(dev, "Failed to map control reg\n");
+		return PTR_ERR(usb2->base);
+	}
 
-		dev_warn(dev, "using deprecated DT binding\n");
+	usb2->clkset = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "brcm,syscon-clkset");
+	if (IS_ERR(usb2->clkset)) {
+		dev_err(dev, "Failed to lookup clkset regmap\n");
+		return PTR_ERR(usb2->clkset);
 	}
 
 	usb2->ref_clk = devm_clk_get(dev, "phy-ref-clk");
-- 
2.35.3


