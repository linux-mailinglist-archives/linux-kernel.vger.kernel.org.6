Return-Path: <linux-kernel+bounces-288694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434D953DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF7F28A57E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807215852F;
	Thu, 15 Aug 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VTudQKPO"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0915B995
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762702; cv=none; b=MICOXxd4Cs4+FmTm7XZsgJ74ZyYXZbjiFe+xUUSblIRYpxasFPDjNeJAWK1awTYH0N7fIJbAvOO6A3/SHfUVGlt8vIZGy5PXc2/XDDSFDBTrNFnSvOitgJ72XIkZ0CnJeGPzi7Z7L3ci+gzk5BiPrZZr2n6XKL78g42DCSTQ+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762702; c=relaxed/simple;
	bh=VNcihovKROhtyMaTRSzxzoHj4K+NEdPtohEA0tkoim0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VgoznYuXwe+AP4bSl4E4Vgsm/cj+9hUcZwG4c31ZGYiT3SgCQI0AtrKXcIHHMTG3RuFjCybcSMxAKFQSxMlxEHWNG43umrscPEzEUMcPQyuWDV8tj/2L51uC/uWAeY+ZkFQ9kKLrYGRP0VoJC+wZnw0MG7nfZKrKW2OozY1KJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VTudQKPO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1137065a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762700; x=1724367500; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3zLMqycN4rXeFsBYmKp14DrtBnvb0YcnBAmaGiLI0z8=;
        b=VTudQKPODjgFqo4qY9EPEjUHxDpJIuqASE6bkG1QSDGLdPVEX4CPc8DnbpvHQn4pQr
         273biNzd1VYTE5P2VxKKQblznKqR/usMrJN0v4LW5DCGQboHDIf1kgF4sWN2U91DsL0I
         BO80zX3wyPRRz8XfT4xevSi5vMrNHTfhfkwjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762700; x=1724367500;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zLMqycN4rXeFsBYmKp14DrtBnvb0YcnBAmaGiLI0z8=;
        b=LbXTQFFpdFAnnZr6V2heQDExNK/5sqeDfSPAhP6LF8sDo6gLvL90LHL5mPIiAqLMhb
         iEDKtov3mSFWlg1T4x/dqsmaDifIkx3f9R5554Da0xVXP/LXa0flmpXR5mzRMdOAkNYs
         sIpil3DvcGOtGc+nK8ZYAM5ugF6G9Qu5CaJSWNNz6fsgSeg9hCWOuWfu+HvAvBVm6gjG
         qw4Gek6fKvHBd55DjB1JsRs6U8GftuXjzikHKfHu8VKjfFAWIdnHWXcljW/ElxIWfQQ5
         T/4c30djTOET3kWJKjLZUaV9EMFDQBuH8pTekJMsd2Lu1jJ5faqMkRUozVaXzGAwiB3h
         yhRg==
X-Forwarded-Encrypted: i=1; AJvYcCUJQ9zEAX5Bcnl3MPugbfIjJZj2mxUJxXldS/C7nSlciG0QKQhhKqYLI2HK8uImbpbkC+6dIHbPJjoDNDAcYIv/TlvvqqGzTG2/ABJO
X-Gm-Message-State: AOJu0YySc9N1804CRkpney3rRBp2vKkZ6afhUtWXa3TO8YdL16msMWgt
	A2VEP4Mh8Dt8KDHGYL0fYmioq6CZoiOvhHRe0BLkX1xkpaMcRjZMcvyCL6n/2A==
X-Google-Smtp-Source: AGHT+IEDvdcuI7l/vZfd6lvZe/bqB12psvJxA01sGcQavX1gG8G5RM8r3Y/TruP93glM2KRB+3hQ4w==
X-Received: by 2002:a17:90a:f001:b0:2ca:8b71:21f4 with SMTP id 98e67ed59e1d1-2d3dfc61aa6mr1371386a91.18.1723762699965;
        Thu, 15 Aug 2024 15:58:19 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:19 -0700 (PDT)
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
Subject: [PATCH v6 11/13] PCI: brcmstb: Check return value of all reset_control_xxx calls
Date: Thu, 15 Aug 2024 18:57:24 -0400
Message-Id: <20240815225731.40276-12-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Always check the return value for invocations of reset_control_xxx() and
propagate the error to the next level.  Although the current functions
in reset-brcmstb.c cannot fail, this may someday change.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 102 ++++++++++++++++++--------
 1 file changed, 73 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c5d3a5e9e0fc..d19eeeed623b 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -239,8 +239,8 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	const bool has_phy;
 	u8 num_inbound_wins;
-	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
 struct subdev_regulators {
@@ -285,8 +285,8 @@ struct brcm_pcie {
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	bool			has_phy;
@@ -749,12 +749,18 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 	return base + DATA_ADDR(pcie);
 }
 
-static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
+	int ret = 0;
+
 	if (val)
-		reset_control_assert(pcie->bridge_reset);
+		ret = reset_control_assert(pcie->bridge_reset);
 	else
-		reset_control_deassert(pcie->bridge_reset);
+		ret = reset_control_deassert(pcie->bridge_reset);
+
+	if (ret)
+		dev_err(pcie->dev, "failed to %s 'bridge' reset, err=%d\n",
+			val ? "assert" : "deassert", ret);
 
 	if (!pcie->bridge_reset) {
 		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
@@ -764,9 +770,11 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
 		tmp = (tmp & ~mask) | ((val << shift) & mask);
 		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	}
+
+	return ret;
 }
 
-static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_7278_MASK;
 	u32 shift = RGR1_SW_INIT_1_INIT_7278_SHIFT;
@@ -774,20 +782,29 @@ static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	tmp = (tmp & ~mask) | ((val << shift) & mask);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+
+	return 0;
 }
 
-static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
+	int ret;
+
 	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
-		return;
+		return -EINVAL;
 
 	if (val)
-		reset_control_assert(pcie->perst_reset);
+		ret = reset_control_assert(pcie->perst_reset);
 	else
-		reset_control_deassert(pcie->perst_reset);
+		ret = reset_control_deassert(pcie->perst_reset);
+
+	if (ret)
+		dev_err(pcie->dev, "failed to %s 'perst' reset, err=%d\n",
+			val ? "assert" : "deassert", ret);
+	return ret;
 }
 
-static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
@@ -795,15 +812,19 @@ static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
 	u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
 	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+
+	return 0;
 }
 
-static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+
+	return 0;
 }
 
 static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
@@ -1017,19 +1038,28 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
 	u8 num_out_wins = 0, num_inbound_wins = 0;
-	int memc;
+	int memc, ret;
 
 	/* Reset the bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+	if (ret)
+		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711)
-		pcie->perst_set(pcie, 1);
+	if (pcie->type == BCM2711) {
+		ret = pcie->perst_set(pcie, 1);
+		if (ret) {
+			pcie->bridge_sw_init_set(pcie, 0);
+			return ret;
+		}
+	}
 
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	pcie->bridge_sw_init_set(pcie, 0);
+	ret = pcie->bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	tmp = readl(base + HARD_DEBUG(pcie));
 	if (is_bmips(pcie))
@@ -1248,7 +1278,9 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	pcie->perst_set(pcie, 0);
+	ret = pcie->perst_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -1440,15 +1472,17 @@ static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
-static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
+static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 {
 	void __iomem *base = pcie->base;
-	int tmp;
+	int tmp, ret;
 
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	pcie->perst_set(pcie, 1);
+	ret = pcie->perst_set(pcie, 1);
+	if (ret)
+		return ret;
 
 	/* Deassert request for L23 in case it was asserted */
 	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
@@ -1461,7 +1495,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* Shutdown PCIe bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+
+	return ret;
 }
 
 static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
@@ -1479,9 +1515,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	int ret;
+	int ret, rret;
+
+	ret = brcm_pcie_turn_off(pcie);
+	if (ret)
+		return ret;
 
-	brcm_pcie_turn_off(pcie);
 	/*
 	 * If brcm_phy_stop() returns an error, just dev_err(). If we
 	 * return the error it will cause the suspend to fail and this is a
@@ -1510,7 +1549,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 						     pcie->sr->supplies);
 			if (ret) {
 				dev_err(dev, "Could not turn off regulators\n");
-				reset_control_reset(pcie->rescal);
+				rret = reset_control_reset(pcie->rescal);
+				if (rret)
+					dev_err(dev, "failed to reset 'rascal' controller ret=%d\n",
+						rret);
 				return ret;
 			}
 		}
@@ -1525,7 +1567,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	void __iomem *base;
 	u32 tmp;
-	int ret;
+	int ret, rret;
 
 	base = pcie->base;
 	ret = clk_prepare_enable(pcie->clk);
@@ -1587,7 +1629,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	if (pcie->sr)
 		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_reset:
-	reset_control_rearm(pcie->rescal);
+	rret = reset_control_rearm(pcie->rescal);
+	if (rret)
+		dev_err(pcie->dev, "failed to rearm 'rescal' reset, err=%d\n", rret);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
-- 
2.17.1


