Return-Path: <linux-kernel+bounces-288688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67051953DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5751F26AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9A15688C;
	Thu, 15 Aug 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CAPzZuM7"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C115ADB8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762681; cv=none; b=g5E7RNX1UnlDQf5RLgaqIxYalnWUWjS72r16WTvxnXeRq98fGEI4CsE/Z8v+vd9+8//GiefEMSJafDQri0IhuIu2w2xo8DPhDu2PGOlakZ8L0m72GrRb5FU6PGAlJrSvRD/0YN+C01lDqJCqxhTFwpYS9yD9qb/t7zgQmEv7rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762681; c=relaxed/simple;
	bh=I80zr4ftEwEiCmqjA24CafnKuwOjtgZJg2ZhXxs7254=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Rj2p5oUSea9mPZGJvSeM2nCDZ7vO8pDmj0+05hqpDkdIYabg7AVUdldLcXJHMMtzhMlFLoWV3voM+3psMViMzAQ+zueLkJ/MPZRjdikGeFM3RHNnNBT2i5nP792RGwbbxXfxldgbLC8Yh3oOtOLeOCgAHDIs3bRksoFxJSWUnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CAPzZuM7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso1037369a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762679; x=1724367479; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yepWRpPrn7HuVRjGcYCbpeID1UICJE17S+GyZCTYTS8=;
        b=CAPzZuM7eETNxc9C2xFP89ATNThh0JZPpC1ZC6rInp2xG8Uf7HosRRFTj6Gktf/tpw
         QinTRIBLelu56UmochdDxGZ4lS3+k5QqXb1LfIdESWJlQPyhyYqw4dJk580qjslnD/gl
         N5ftmH6PML3B9xYaNY4jdisNfqGWSuFm5JvHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762679; x=1724367479;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yepWRpPrn7HuVRjGcYCbpeID1UICJE17S+GyZCTYTS8=;
        b=sFxGkBcXYoBCzPEpjJp+PM3zTchuQOq3QoioPCadCK7F3L8nCX75B3h0gsyceCnlCG
         C7/NdpVLEKmxSDCAZegfsVzEHEcQkzESnJ/PPFH6bivQIIfRxkVps/6iWRIOXuHuLxjd
         MUmOg1BDq9jvI1XMzOCZWibQygcEvaYuKgxFhH/RVs4iKpqlAOZxX0kgnycX2CNJ1rfR
         SgO8/gbZ/CQHYxClbUC/DDaP9qFaI25tougBsj4Oyup8Tm4pfV0SJPYtdJtFuhwxaDa5
         +a0UyDNFYuntNqWrfP0Dj+9hcLUhUw5VPIA+7xXG7GY5TmjxWdBrEu8tPj/ZwLODwIpa
         SGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNIypUYZX7cXDGH3q9YZK2MmlhG4igVIJUH1S3Ul3Sg9rK2woaZj75BWO+4eU/fKmz7Oe0UqiXQqqGhIig6vq1At8FXmWdCPgicpzz
X-Gm-Message-State: AOJu0YxFzQmzsWE0rVFwsB/+KZJIvc7fGHlN1snFSA3Na10MIqUIWuFA
	aJgobl7oBJPBXw9uuEQ060N3TOag0HVYQwKZz+T24QIsOh48z+ws2ZPnpzlpIA==
X-Google-Smtp-Source: AGHT+IGxbnG/uJ/U4/fycutE6POjlc+iPF9Zv5jiqIHVnaRSgcMsZaJbzzeuyxOqvw3zYCkzgINdcA==
X-Received: by 2002:a17:90a:1307:b0:2bf:8824:c043 with SMTP id 98e67ed59e1d1-2d3dfc66d3cmr1387247a91.18.1723762678545;
        Thu, 15 Aug 2024 15:57:58 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:58 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Date: Thu, 15 Aug 2024 18:57:18 -0400
Message-Id: <20240815225731.40276-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The 7712 SOC has a bridge reset which can be described in the device tree.
Use it if present.  Otherwise, continue to use the legacy method to reset
the bridge.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 790a149f6581..af14debd81d0 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -265,6 +265,7 @@ struct brcm_pcie {
 	enum pcie_type		type;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
+	struct reset_control	*bridge_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
@@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 
 static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
-	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
-	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
+	if (val)
+		reset_control_assert(pcie->bridge_reset);
+	else
+		reset_control_deassert(pcie->bridge_reset);
 
-	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
-	tmp = (tmp & ~mask) | ((val << shift) & mask);
-	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	if (!pcie->bridge_reset) {
+		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
+		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
+
+		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+		tmp = (tmp & ~mask) | ((val << shift) & mask);
+		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	}
 }
 
 static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
@@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->perst_reset))
 		return PTR_ERR(pcie->perst_reset);
 
+	pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
+	if (IS_ERR(pcie->bridge_reset))
+		return PTR_ERR(pcie->bridge_reset);
+
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
+	pcie->bridge_sw_init_set(pcie, 0);
+
 	ret = reset_control_reset(pcie->rescal);
 	if (ret) {
 		clk_disable_unprepare(pcie->clk);
-- 
2.17.1


