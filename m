Return-Path: <linux-kernel+bounces-542069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C1A4C53D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C9A16AEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48F23E32F;
	Mon,  3 Mar 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HNbZdXi5"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAC215793
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015525; cv=none; b=pkdTR3vzeC5gzG1dCxJ1OwIQOUivYT94OPre+0ET40I/xH/A7StsTxx4H4E5GjPxXvcfaHJ4mbEJLZYIMEf8LUd9cLB6y0y8Nq95IcL3ks8gnMsOmmKRiPpjorG1KU6Cv6gm7SwRR1I98St4VQ4m5ft7uY02uAY+LSTDSUat2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015525; c=relaxed/simple;
	bh=b1plolZA6iwD6CVq7oze/ekvDaU9zsdYmy85kqI28to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=gyIo3fnR4ot7u8iRsEoh5yG9QLBtXbQE5Y9kJQ4d2OvAUYOFdG9V1SNICcjn57gbzGqkL6wZigwRTchZYNrdgv66AoiE8kakQUBKRLfulZEOCqHprmpMI2QN8a6KKxssOe0QM6GDll40K3l+Dl0xkshYk507XiUqFM4Yt4q17hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HNbZdXi5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250303152522euoutp022af5ca22ecc5ce3b1d2939c15808f991~pVGSvEhkA1852418524euoutp02s
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:25:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250303152522euoutp022af5ca22ecc5ce3b1d2939c15808f991~pVGSvEhkA1852418524euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741015522;
	bh=ANz8D/VpNY0MVaFHX53+xkCV78An0pUG8ELJjmjm7w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNbZdXi5PO2uLLINFTJ43HM7qx5x7np8BRX1QogCUEz6d5LJTNh201E+PHcdYskQm
	 +iyIJ2RCet2/Ke3eKcwYB5o3RKEAK8fmSDCHPu2kwjyh/VjCgSM5mzQzd25t1SGYeS
	 KWfK7hKF+EJmzGbUxzoI5JAAEuesx9EBdYW9RxcM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250303152522eucas1p1a063bfe20e72f45fcfe6934309822fbc~pVGSerqu70413104131eucas1p19;
	Mon,  3 Mar 2025 15:25:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.67.20409.1E9C5C76; Mon,  3
	Mar 2025 15:25:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250303152521eucas1p20128508eb79e20c1e124155beaf8fb4d~pVGSKIY6g2156121561eucas1p2T;
	Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303152521eusmtrp11cec5cf50ae69be4c7374f5795e1bf0a~pVGSJRS__0903609036eusmtrp1O;
	Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-b6-67c5c9e15fb0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.E0.19654.1E9C5C76; Mon,  3
	Mar 2025 15:25:21 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250303152521eusmtip1bab26c8c74d66ee7cf334e80346130f7~pVGRl100Z0673406734eusmtip1T;
	Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 2/2] reset: thead: Add TH1520 reset controller driver
Date: Mon,  3 Mar 2025 16:25:11 +0100
Message-Id: <20250303152511.494405-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303152511.494405-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRTud+/t7m3N6loNh6JpxQxNS8m4BmGEK8zEMIZpsJNra+xWdm3U
	KKlE2eTNVoRBWlZma5PViq2s7bHNUMYkW5PHsBiPEEJsN4//vvN93/l955z5Ubi41HM0FRe/
	lVPFyxQSUkhU3vnaEtxtr5dP6dQj5rLFgTHFdQ5PxnmvAmNeWHYRzMsCJ8ncNxeRjKHusYAp
	+1SMMY+ddwmmv7pKwGTVHCHmDmGN+hySzTLcwdj8H1PYtzfbSHZ/hR6xPcaxUeRa4ayNnCIu
	iVNNDt8gjLWnVwkSe0O2G8p6UTrKnJSLKAroMHj3c1kuElJi+iKCTFMhzhcfETT3XxDwRQ+C
	OscxLBd5DXSY+nQYL5QgaGrIIPniNYKG+mOk20XSodBVUuzpFnzo8wg6c77hbgGnFWB+Y0Bu
	PJxmwZR9fYAn6PHQdyJngBfR4XDf/ALxcf5Qc7t5wONFzwHT836S9wwDu+4pwb/p/3dwoLso
	eNJnEPDNEVCmbyR5PBxctopB3g8aD2sJHidAl+kDzuMdcF1rG8QzocPxjXRfCacnQpl5Mk/P
	A1tmEeKPNxQevhnGjzAUDlUex3laBHuzxbx7AhzV5v0NdVysHDwiC86TRcQBFFDw3zIF/y1T
	8C/3NML1aCSnUSvlnDo0ntsmVcuUak28XBqToDSi37+p8aftYxUqcb2XWhFGISsCCpf4iNr3
	1MvFoo2y5BROlbBepVFwaivypQjJSNHZmt1yMS2XbeU2c1wip/qjYpTX6HTMw3Y4e+X8fMuq
	juPfvxAt0UlvYwNHcUE+qH3Wtt3Ke87YgBWJ3U06S3CoWbs6esZ0X1d4TO/OhZ7Gh9KEUakb
	6j7DiFtRdFykIGjx7Wt5hRfm9/uliDMfZVz1uWENwV1pqZsUYZ19M86k2PWBC2OSr7Q05p3r
	CbC1nlbu9z5YvsBulOp6vZ3IcKrp3LoKDTttfHWeszRCsLOyyffBLUtXw7Pw6EulzX5zHxAh
	cVNrw+YtLVzTrknVudq0Y2ZrgjMaPim27GP905LNh1oDgiNeLXeNyz81e+KTg0n2rKiiV8Vb
	Xi/quNS91xptFO+pOhtZy9YIy9OqPW5+b0u3LmmF2gMSQh0rC5mEq9SyX32RH9y8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7oPTx5NN9h5SdNizd5zTBbzj5xj
	tbh3aQuTxYu9jSwWL2fdY7O4vGsOm8XaI3fZLdZ/nc9kcffeCRaL/3t2sFu07J/C4sDtsWlV
	J5tHy9pjTB79fw083u+7yubRt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
	lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GScbdrAXfDesWLv+O2MDY7NWFyMnh4SAicTW3zOZ
	uhi5OIQEljJKvFzyhBkiISNxrfslC4QtLPHnWhcbRNErRom50x6DFbEJGEk8WD6fFSQhIrCe
	UaLz6iYmkASzQJ7E6w3d7CC2sICHxNa2nWANLAKqEr9ndDKC2LwCdhKXd71ghNggL7H/4Fmw
	Gk4Be4mtz/6zgdhCQDX3Ts9ghagXlDg58wkLxHx5ieats5knMArMQpKahSS1gJFpFaNIamlx
	bnpusZFecWJucWleul5yfu4mRmAcbTv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe6v9aLoQb0pi
	ZVVqUX58UWlOavEhRlOguycyS4km5wMjOa8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU
	7NTUgtQimD4mDk6pBqZdlSIzJp1/23xY5H39Ks2FE+8ccoy+/WDGlQdmH7o3TLtdesI9557E
	1XtqDccu6LRZTWox+FG5PHBebm3Kj61XPJUFvx5ikSlsWV/y33njsY+LvdLvT+u480Kw4Kta
	kcBSzcLy+U6crX1nAxXsY7dGX7RiWRzN3Jk54/ijObKbX9qezNjYukwqVF5F6Nb0iQxqds9E
	i+ZPUz1n/FzH6cbL91t0+AW+/mW3mGe/05HjJaOiy2VlKXGHeXNOFi2ZPoNT3pYl50SqIGOJ
	nfXnszJr5R7rTfjJw6z9b0paYPABMynLC+aRLW9dzY/5P5r5Ls952bEJLzm/lvFYGx24mbPm
	mU/vHovvkhfdWEQm9rkosRRnJBpqMRcVJwIATz68DiwDAAA=
X-CMS-MailID: 20250303152521eucas1p20128508eb79e20c1e124155beaf8fb4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303152521eucas1p20128508eb79e20c1e124155beaf8fb4d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303152521eucas1p20128508eb79e20c1e124155beaf8fb4d
References: <20250303152511.494405-1-m.wilczynski@samsung.com>
	<CGME20250303152521eucas1p20128508eb79e20c1e124155beaf8fb4d@eucas1p2.samsung.com>

Add reset controller driver for the T-HEAD TH1520 SoC that manages
hardware reset lines for various subsystems. The driver currently
implements support for GPU reset control, with infrastructure in place
to extend support for NPU and Watchdog Timer resets in future updates.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                  |   1 +
 drivers/reset/Kconfig        |  10 +++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-th1520.c | 135 +++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/reset/reset-th1520.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 819686e98214..e4a0a83b4c11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20425,6 +20425,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
 F:	include/dt-bindings/reset/thead,th1520-reset.h
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5b3abb6db248..fa0943c3d1de 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -272,6 +272,16 @@ config RESET_SUNXI
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
+config RESET_TH1520
+	tristate "T-HEAD 1520 reset controller"
+	depends on ARCH_THEAD || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  This driver provides support for the T-HEAD TH1520 SoC reset controller,
+	  which manages hardware reset lines for SoC components such as the GPU.
+	  Enable this option if you need to control hardware resets on TH1520-based
+	  systems.
+
 config RESET_TI_SCI
 	tristate "TI System Control Interface (TI-SCI) reset driver"
 	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 677c4d1e2632..d6c2774407ae 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_RESET_TH1520) += reset-th1520.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_TI_TPS380X) += reset-tps380x.o
diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
new file mode 100644
index 000000000000..7874f0693e1b
--- /dev/null
+++ b/drivers/reset/reset-th1520.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/reset/thead,th1520-reset.h>
+
+ /* register offset in VOSYS_REGMAP */
+#define TH1520_GPU_RST_CFG		0x0
+#define TH1520_GPU_RST_CFG_MASK		GENMASK(1, 0)
+
+/* register values */
+#define TH1520_GPU_SW_GPU_RST		BIT(0)
+#define TH1520_GPU_SW_CLKGEN_RST	BIT(1)
+
+struct th1520_reset_priv {
+	struct reset_controller_dev rcdev;
+	struct regmap *map;
+};
+
+struct th1520_reset_map {
+	u32 bit;
+	u32 reg;
+};
+
+static const struct th1520_reset_map th1520_resets[] = {
+	[TH1520_RESET_ID_GPU] = {
+		.bit = TH1520_GPU_SW_GPU_RST,
+		.reg = TH1520_GPU_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPU_CLKGEN] = {
+		.bit = TH1520_GPU_SW_CLKGEN_RST,
+		.reg = TH1520_GPU_RST_CFG,
+	}
+};
+
+static inline struct th1520_reset_priv *
+to_th1520_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct th1520_reset_priv, rcdev);
+}
+
+static int th1520_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct th1520_reset_priv *priv = to_th1520_reset(rcdev);
+	const struct th1520_reset_map *reset;
+
+	reset = &th1520_resets[id];
+
+	return regmap_update_bits(priv->map, reset->reg, reset->bit, 0);
+}
+
+static int th1520_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct th1520_reset_priv *priv = to_th1520_reset(rcdev);
+	const struct th1520_reset_map *reset;
+
+	reset = &th1520_resets[id];
+
+	return regmap_update_bits(priv->map, reset->reg, reset->bit,
+				  reset->bit);
+}
+
+static const struct reset_control_ops th1520_reset_ops = {
+	.assert	= th1520_reset_assert,
+	.deassert = th1520_reset_deassert,
+};
+
+static const struct regmap_config th1520_reset_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
+static int th1520_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct th1520_reset_priv *priv;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(dev, base,
+					  &th1520_reset_regmap_config);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	/* Initialize GPU resets to asserted state */
+	ret = regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
+				 TH1520_GPU_RST_CFG_MASK, 0);
+	if (ret)
+		return ret;
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.nr_resets = ARRAY_SIZE(th1520_resets);
+	priv->rcdev.ops = &th1520_reset_ops;
+	priv->rcdev.of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, &priv->rcdev);
+}
+
+static const struct of_device_id th1520_reset_match[] = {
+	{ .compatible = "thead,th1520-reset" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, th1520_reset_match);
+
+static struct platform_driver th1520_reset_driver = {
+	.driver = {
+		.name = "th1520-reset",
+		.of_match_table = th1520_reset_match,
+	},
+	.probe = th1520_reset_probe,
+};
+module_platform_driver(th1520_reset_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("T-HEAD TH1520 SoC reset controller");
+MODULE_LICENSE("GPL");
-- 
2.34.1


