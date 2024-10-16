Return-Path: <linux-kernel+bounces-367123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D481C99FEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C36286F38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA989154C08;
	Wed, 16 Oct 2024 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVgEl/DK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869C41C7F;
	Wed, 16 Oct 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046148; cv=none; b=h8kLNCqJKBS82d5E0wnr+K8fOle6zeskxiWGZftKuTnoPxHEKerjMyt00WrgFgWz9a8yyvG+jJIcW2l0CRAwame+NRnmtrTN19FsL6FViMQ3AHWSoJmH3j79gh0hJHaLjEgBPWaHiybddNKYJFCpU/7ZEAReSek9/FgT3u9Q/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046148; c=relaxed/simple;
	bh=4i45m0E5Md/BqdOPGnv922GKH5fqFH45gBgmbAGqKuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1PsURa318ImSWnHQjJxTLVT2yUwggNCSPyKfpMX3SYBq+/yFFqa/qB3UFnPazIh2rxTyOM5l76zaoVQQUeRat4Pfl81toU4ppBwU4kwTzOOnuN67FS3g12FLgviZ7vSV4PJOzkBXC7/pXDU9HiReBAvmNzm9lFtmnRPe1ochKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVgEl/DK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c7b9087c4so3172815ad.1;
        Tue, 15 Oct 2024 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729046146; x=1729650946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+eZjyOKKkxcB5kFjfH/tpWc3YXuDUDSQBcQb8F8X2o=;
        b=bVgEl/DKRwxJsK5YhCCHAmHnFWkUGM+a5dtwkhNBDBPc08gy7OUnxLhl3bSeT3XIf9
         h/4VA8mpIwhkuzA84bePf6/Dk+laK6eEER9aj05SBpCaPru4py7nG0JMegJp2R2mX6sE
         YAJOVXhPF63LrtIaZUnUxNy+jPJX+2iuiXsLxlEziZc54+VeWTnu44VXD8V50gZqsSMr
         sQEqe3RUCLNMVN85lw5MICcQCzWc7TwJaelr+1Bik1ddrGRwCvEEzCcnSzAz1o7yjxmb
         A1bMtMCZEx5gx+8EPT32Wrzi8AAQAdoPv4A6iy0f/KDgyGt2EI/X9orDc6nHxJvec+Pk
         F9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729046146; x=1729650946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+eZjyOKKkxcB5kFjfH/tpWc3YXuDUDSQBcQb8F8X2o=;
        b=d84ZAvf2qZFsJAz4KIuBjGGwU6cjSH1NUaiMxcL5p7hqMjhbqwyC9QWAGaeZX0NwFd
         WNTuWmxuIy9iiyd7FDOxLgQ++sRn2gHn8PYlmZv23GYoq7tNQoFYNMBfGdc+itRMFjnQ
         9vrzfD0x4GDKZ5ZRT61oxuwl34dMksUXVNjSWp2ffB7OKexICAN2ArI77N5ax1CULOBg
         9OpbZ90+pOhw+otfZ8qsW6JVbrIkX0BjmloXdfKdsxRbfFXdNhW7iPZsLU91dYp4oIeV
         tsXA/0IiOUlKpXP3CZJBmNcixzpE6sM1ThAHUF0cA1/bclnUYKZC5UJQ/nBN6NMvIYyj
         E0ug==
X-Forwarded-Encrypted: i=1; AJvYcCWKpItg2ARP10ZGBoW3BjC2QChhr2G3UoATAKfW7hNOLZVaM7u7tYmO0LJlz2FUVN94kTHvOCkqebKReqdQ@vger.kernel.org, AJvYcCWM1+ZpECvN0uvmo1QgCs6fzgSqtFsLlPA/E5l7ZLoEgTKfml1Y+/5LpxU7cECefO0omr+DnCeWV50a@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxLlnoMKEyNU140UQkWCGG4CM+UfnP4TR4f9ct/AyLaA5RtdY
	UH/aVihl4RS9e08+vovJ4RdCWQJjSYqcXCFxZHMYpZ15ToD2255PvO/5fQ==
X-Google-Smtp-Source: AGHT+IFUSCA+856XxllXr8S41u0AiwTY1UzOBDoOMc2Sw36VwRzcUTSdKPjiXTfUWzoK5H/0EfTW9g==
X-Received: by 2002:a17:902:e892:b0:20c:df08:9a78 with SMTP id d9443c01a7336-20d2fe41addmr5778945ad.13.1729046146127;
        Tue, 15 Oct 2024 19:35:46 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c70587asm2192920a12.72.2024.10.15.19.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:35:45 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Kever Yang <kever.yang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 2/2] phy: rockchip-naneng-combo: Support rk3576
Date: Wed, 16 Oct 2024 10:35:33 +0800
Message-Id: <20241016023533.12018-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016023533.12018-1-frawang.cn@gmail.com>
References: <20241016023533.12018-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kever Yang <kever.yang@rock-chips.com>

phy0: pcie, sata
phy1: pcie, sata, usb3

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v2:
 - using constants macro instead of magic values.
 - add more comments for PHY tuning operations.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20241015013351.4884-2-frawang.cn@gmail.com/

 .../rockchip/phy-rockchip-naneng-combphy.c    | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 0a9989e41237f..25aa8d1981abc 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -37,6 +37,10 @@
 #define PHYREG8				0x1C
 #define PHYREG8_SSC_EN			BIT(4)
 
+#define PHYREG10			0x24
+#define PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
+#define PHYREG10_SSC_PCM_3500PPM	7
+
 #define PHYREG11			0x28
 #define PHYREG11_SU_TRIM_0_7		0xF0
 
@@ -61,12 +65,19 @@
 #define PHYREG16			0x3C
 #define PHYREG16_SSC_CNT_VALUE		0x5f
 
+#define PHYREG17			0x40
+
 #define PHYREG18			0x44
 #define PHYREG18_PLL_LOOP		0x32
 
+#define PHYREG21			0x50
+#define PHYREG21_RX_SQUELCH_VAL		0x0D
+
 #define PHYREG27			0x6C
 #define PHYREG27_RX_TRIM_RK3588		0x4C
 
+#define PHYREG30			0x74
+
 #define PHYREG32			0x7C
 #define PHYREG32_SSC_MASK		GENMASK(7, 4)
 #define PHYREG32_SSC_DIR_SHIFT		4
@@ -79,6 +90,7 @@
 #define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
 #define PHYREG33_PLL_KVCO_SHIFT		2
 #define PHYREG33_PLL_KVCO_VALUE		2
+#define PHYREG33_PLL_KVCO_VALUE_RK3576	4
 
 struct rockchip_combphy_priv;
 
@@ -98,6 +110,7 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_rxterm_set;
 	struct combphy_reg pipe_txelec_set;
 	struct combphy_reg pipe_txcomp_set;
+	struct combphy_reg pipe_clk_24m;
 	struct combphy_reg pipe_clk_25m;
 	struct combphy_reg pipe_clk_100m;
 	struct combphy_reg pipe_phymode_sel;
@@ -584,6 +597,263 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
 	.combphy_cfg	= rk3568_combphy_cfg,
 };
 
+static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
+{
+	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
+	unsigned long rate;
+	u32 val;
+
+	switch (priv->type) {
+	case PHY_TYPE_PCIE:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
+					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
+					 PHYREG32);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
+		break;
+	case PHY_TYPE_USB3:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
+					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
+					 PHYREG32);
+
+		/* Enable adaptive CTLE for USB3.0 Rx */
+		val = readl(priv->mmio + PHYREG15);
+		val |= PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + PHYREG15);
+
+		/* Set PLL KVCO fine tuning signals */
+		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
+
+		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
+		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+
+		/* Set PLL input clock divider 1/2 */
+		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
+					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
+					 PHYREG6);
+
+		/* Set PLL loop divider */
+		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+
+		/* Set PLL KVCO to min and set PLL charge pump current to max */
+		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+
+		/* Set Rx squelch input filler bandwidth */
+		writel(PHYREG21_RX_SQUELCH_VAL, priv->mmio + PHYREG21);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		break;
+	case PHY_TYPE_SATA:
+		/* Enable adaptive CTLE for SATA Rx */
+		val = readl(priv->mmio + PHYREG15);
+		val |= PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + PHYREG15);
+
+		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
+		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
+		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + PHYREG7);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
+		break;
+	default:
+		dev_err(priv->dev, "incompatible PHY type\n");
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(priv->refclk);
+
+	switch (rate) {
+	case REF_CLOCK_24MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
+		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
+			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
+			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
+						 val, PHYREG15);
+
+			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+
+		} else if (priv->type == PHY_TYPE_PCIE) {
+			/* PLL KVCO tuning fine */
+			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
+						 val, PHYREG33);
+
+			/* Set up rx_pck invert and rx msb to disable */
+			writel(0x00, priv->mmio + PHYREG27);
+
+			/*
+			 * Set up SU adjust signal:
+			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
+			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b011
+			 * su_trim[31:24], CKDRV adjust
+			 */
+			writel(0x90, priv->mmio + PHYREG11);
+			writel(0x02, priv->mmio + PHYREG12);
+			writel(0x57, priv->mmio + PHYREG14);
+
+			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+		}
+		break;
+	case REF_CLOCK_25MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
+		break;
+	case REF_CLOCK_100MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
+		if (priv->type == PHY_TYPE_PCIE) {
+			/* gate_tx_pck_sel length select work for L1SS */
+			writel(0xc0, priv->mmio + PHYREG30);
+
+			/* PLL KVCO tuning fine */
+			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
+						 val, PHYREG33);
+
+			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
+			writel(0x4c, priv->mmio + PHYREG27);
+
+			/*
+			 * Set up SU adjust signal:
+			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
+			 * su_trim[15:8],  bypass PLL loop divider code, and
+			 *                 PLL LPF R1 adujst bits[9:7]=3'b101
+			 * su_trim[23:16], CKRCV adjust
+			 * su_trim[31:24], CKDRV adjust
+			 */
+			writel(0x90, priv->mmio + PHYREG11);
+			writel(0x43, priv->mmio + PHYREG12);
+			writel(0x88, priv->mmio + PHYREG13);
+			writel(0x56, priv->mmio + PHYREG14);
+		} else if (priv->type == PHY_TYPE_SATA) {
+			/* downward spread spectrum +500ppm */
+			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
+			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+
+			/* ssc ppm adjust to 3500ppm */
+			rockchip_combphy_updatel(priv, PHYREG10_SSC_PCM_MASK,
+						 PHYREG10_SSC_PCM_3500PPM,
+						 PHYREG10);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
+		return -EINVAL;
+	}
+
+	if (priv->ext_refclk) {
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
+		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
+			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
+						 val, PHYREG33);
+
+			/* Set up rx_trim: PLL LPF C1 85pf R1 2.5kohm */
+			writel(0x0c, priv->mmio + PHYREG27);
+
+			/*
+			 * Set up SU adjust signal:
+			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
+			 * su_trim[15:8],  bypass PLL loop divider code, and
+			 *                 PLL LPF R1 adujst bits[9:7]=3'b101.
+			 * su_trim[23:16], CKRCV adjust
+			 * su_trim[31:24], CKDRV adjust
+			 */
+			writel(0x90, priv->mmio + PHYREG11);
+			writel(0x43, priv->mmio + PHYREG12);
+			writel(0x88, priv->mmio + PHYREG13);
+			writel(0x56, priv->mmio + PHYREG14);
+		}
+	}
+
+	if (priv->enable_ssc) {
+		val = readl(priv->mmio + PHYREG8);
+		val |= PHYREG8_SSC_EN;
+		writel(val, priv->mmio + PHYREG8);
+
+		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
+			/* Set PLL loop divider */
+			writel(0x00, priv->mmio + PHYREG17);
+			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+
+			/* Set up rx_pck invert and rx msb to disable */
+			writel(0x00, priv->mmio + PHYREG27);
+
+			/*
+			 * Set up SU adjust signal:
+			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
+			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b101
+			 * su_trim[23:16], CKRCV adjust
+			 * su_trim[31:24], CKDRV adjust
+			 */
+			writel(0x90, priv->mmio + PHYREG11);
+			writel(0x02, priv->mmio + PHYREG12);
+			writel(0x08, priv->mmio + PHYREG13);
+			writel(0x57, priv->mmio + PHYREG14);
+			writel(0x40, priv->mmio + PHYREG15);
+
+			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT,
+			       priv->mmio + PHYREG33);
+		}
+	}
+
+	return 0;
+}
+
+static const struct rockchip_combphy_grfcfg rk3576_combphy_grfcfgs = {
+	/* pipe-phy-grf */
+	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
+	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
+	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
+	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
+	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
+	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
+	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
+	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
+	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
+	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
+	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
+	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
+	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
+	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
+	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
+	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
+	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
+	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
+	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0129 },
+	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c1 },
+	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
+	/* php-grf */
+	.pipe_con0_for_sata	= { 0x001C, 2, 0, 0x00, 0x2 },
+	.pipe_con1_for_sata	= { 0x0020, 2, 0, 0x00, 0x2 },
+};
+
+static const struct rockchip_combphy_cfg rk3576_combphy_cfgs = {
+	.num_phys = 2,
+	.phy_ids = {
+		0x2b050000,
+		0x2b060000
+	},
+	.grfcfg		= &rk3576_combphy_grfcfgs,
+	.combphy_cfg	= rk3576_combphy_cfg,
+};
+
 static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 {
 	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
@@ -775,6 +1045,10 @@ static const struct of_device_id rockchip_combphy_of_match[] = {
 		.compatible = "rockchip,rk3568-naneng-combphy",
 		.data = &rk3568_combphy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3576-naneng-combphy",
+		.data = &rk3576_combphy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3588-naneng-combphy",
 		.data = &rk3588_combphy_cfgs,
-- 
2.25.1


