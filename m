Return-Path: <linux-kernel+bounces-359028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA39998690
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E71C23593
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF901C6882;
	Thu, 10 Oct 2024 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlUszk21"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326001C6F4D;
	Thu, 10 Oct 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564435; cv=none; b=V5GRC7F06Yiqpg/Wvnbpo1nb07dnR04ub4UWCin1dd5g/q2stVrEOEFwRqSfySSmFHFQR5MJR5A32Ny7QlolM8uM7/ycyDpgx8TILIdfelQXSvJzAoKAEiNJAooElNPOGOuYiL/80iv2AnG5xOhtILWmXW/F1vCyMJZaCutlqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564435; c=relaxed/simple;
	bh=ipze95y//YmTLgIWeLWU1lgUKaQgG+HzuUoe8iq00WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kroJxeSYafJGZ9GrA7qKSo3P4Nh4XoETy+O4HgrSlpxQYqbaPJK0kLCdLMJT9Zzd8XMWbm/2FzB+2z0Q+hOF+vmsfl1/Mlawdi3mmHoEwmjXoqkvb5VuY6JApvI+6R8EOelPJyUMphJKafMyGS+t6IRJKEpfHQ0MMgbMHi2JFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlUszk21; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99b1f43aceso2220866b.0;
        Thu, 10 Oct 2024 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728564430; x=1729169230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKIQL1682shmY5MtpmqU3GtLOQrZqLxx3TBVel3Fu74=;
        b=SlUszk21HaAWqDMFiC7yis9tg9Koenv/a5s+WV9HXgr6t7F2W/zPlULDdDJ4NL/BiT
         QxtnFt/aBlt14nAavt3ojdJW/B1DvGCeG2J8Mc9faDDGrLvkKT4igU2qSwj20xoAvRHZ
         cZtXW8kd+KtSpOVSLDYHDMGduFitKLlQbEZACuQ5IUm6/ai8hWuTe06zsq/FaaC7mMa/
         U217fE9BWuDWIBKvHVpLr/GWep2QHVqrdtzrvTqHE0M3NVffFeCQ5ksA7kIUHUQQPYyT
         XtWZhhb3vdKFgO+DbRUz6mulX1qLenNXg5rV5bJjQAqRIZeM6cFyn4oP0GcuYK0BBRrf
         hdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564430; x=1729169230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKIQL1682shmY5MtpmqU3GtLOQrZqLxx3TBVel3Fu74=;
        b=if5geMO6kJ7ozXejp9nG7F22rmzPcvVHFFE/LCY0c/rRncBGwKv364W6t1AWy3opbv
         5obX5dNctMc3s6k4Th5rF3pNIZAx/bRGRd3GPux9pY1C/qcA9Pz6u6WSpxwe/vToY5sf
         rS62eiwVS38qSzU1Cttc294kEDfY0+6DxEPgsflPWYBcvBdV7BF2I2WBxaILv53+ELtj
         6+rA7MQf6QfWRze2k5fo1EBvwMR0vLtHvDqhE2c9rZ4vNtDoe1sTykAq7H7OEZ7VJ/mS
         LMyu091bMqseBE7BJ+eHefYkBRmUj9DQX+mk/zO6XsiRzx9mYvEphvQrVD9EesWOgbEm
         6MKg==
X-Forwarded-Encrypted: i=1; AJvYcCV+j5/QFbvASj27inq1fVXhDfHWg++cHAfJyjqeRhZFYmizJ9Hzee/U3rT2EOyph/e2oqHqHKOTyO4Xt2sa@vger.kernel.org, AJvYcCXZ28D3Kbj8OO1OKcvuRhfAT5vVeXUE4gYt/zvdrK7aBCllZDb4+dvny463HLyz7WKLlLgHNdxD0L3m@vger.kernel.org, AJvYcCXooF1GJVY2iKga7CO55Jgqly2BmtOZEt3VD9FsnGI+IR6BMpU9wd0MJEFGsM9Ra0pmnIkDOLLnJ7+f@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCJ56hbJ/tKNc6Xc4kE3jAkFcr4/pAMlMy7H4IzpHjeQ6Dr1g
	GKvj/lBDkYbsapBHvnIsc+fjAY5YeVfR8yISV2lv0TCOaZcqXA65
X-Google-Smtp-Source: AGHT+IFlsZZYAvIwRs+bXDPAIR8WgG8ezqFEc+vg9tOFwFhUfrt5YY7d7v1AxNb/GlmLz5Y30WMARw==
X-Received: by 2002:a17:907:d0c:b0:a98:f44d:a198 with SMTP id a640c23a62f3a-a99a0ebe7eemr315543566b.1.1728564429894;
        Thu, 10 Oct 2024 05:47:09 -0700 (PDT)
Received: from zenbook.agu.edu.tr (89-38-97-199.hosted-by-worldstream.net. [89.38.97.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc5easm85654466b.170.2024.10.10.05.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:47:09 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5 2/2] clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset drivers
Date: Thu, 10 Oct 2024 15:45:26 +0300
Message-ID: <20241010124529.78460-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010124529.78460-1-y.oudjana@protonmail.com>
References: <20241010124529.78460-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
clock and reset controllers. These provide the base clocks and resets
on the platform, enough to bring up all essential blocks including
PWRAP, MSDC and peripherals (UART, I2C, SPI).

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                                  |   4 +
 drivers/clk/mediatek/Kconfig                 |   9 +
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 138 +++++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c   | 107 +++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c    | 124 ++++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c   | 394 +++++++++++++++++++
 7 files changed, 777 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5a8f700f06f4..6a183aef63e56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14572,6 +14572,10 @@ M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-clk@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	drivers/clk/mediatek/clk-mt6735-apmixedsys.c
+F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
+F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
+F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 70a005e7e1b18..93f55f75bf381 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -124,6 +124,15 @@ config COMMON_CLK_MT2712_VENCSYS
 	help
 	  This driver supports MediaTek MT2712 vencsys clocks.
 
+config COMMON_CLK_MT6735
+	tristate "Main clock drivers for MediaTek MT6735"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This enables drivers for clocks and resets provided
+	  by apmixedsys, topckgen, infracfg and pericfg on the
+	  MediaTek MT6735 SoC.
+
 config COMMON_CLK_MT6765
        bool "Clock driver for MediaTek MT6765"
        depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index eeccfa039896f..70456ffc6c492 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 obj-$(CONFIG_COMMON_CLK_MEDIATEK_FHCTL) += clk-fhctl.o clk-pllfh.o
 
+obj-$(CONFIG_COMMON_CLK_MT6735) += clk-mt6735-apmixedsys.o clk-mt6735-infracfg.o clk-mt6735-pericfg.o clk-mt6735-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
 obj-$(CONFIG_COMMON_CLK_MT6765_CAMSYS) += clk-mt6765-cam.o
diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
new file mode 100644
index 0000000000000..1ac6a0cd489a6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-apmixedsys.h>
+
+#define AP_PLL_CON_5		0x014
+#define ARMPLL_CON0		0x200
+#define ARMPLL_CON1		0x204
+#define ARMPLL_PWR_CON0		0x20c
+#define MAINPLL_CON0		0x210
+#define MAINPLL_CON1		0x214
+#define MAINPLL_PWR_CON0	0x21c
+#define UNIVPLL_CON0		0x220
+#define UNIVPLL_CON1		0x224
+#define UNIVPLL_PWR_CON0	0x22c
+#define MMPLL_CON0		0x230
+#define MMPLL_CON1		0x234
+#define MMPLL_PWR_CON0		0x23c
+#define MSDCPLL_CON0		0x240
+#define MSDCPLL_CON1		0x244
+#define MSDCPLL_PWR_CON0	0x24c
+#define VENCPLL_CON0		0x250
+#define VENCPLL_CON1		0x254
+#define VENCPLL_PWR_CON0	0x25c
+#define TVDPLL_CON0		0x260
+#define TVDPLL_CON1		0x264
+#define TVDPLL_PWR_CON0		0x26c
+#define APLL1_CON0		0x270
+#define APLL1_CON1		0x274
+#define APLL1_CON2		0x278
+#define APLL1_PWR_CON0		0x280
+#define APLL2_CON0		0x284
+#define APLL2_CON1		0x288
+#define APLL2_CON2		0x28c
+#define APLL2_PWR_CON0		0x294
+
+#define CON0_RST_BAR		BIT(24)
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _rst_bar_mask,	\
+	    _pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,		\
+	    _tuner_en_bit, _pcw_reg, _pcwbits, _flags) {		\
+		.id = _id,						\
+		.name = _name,						\
+		.parent_name = "clk26m",				\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_chg_reg = _pcw_reg,				\
+		.pcwbits = _pcwbits,					\
+		.flags = _flags,					\
+	}
+
+static const struct mtk_pll_data apmixedsys_plls[] = {
+	PLL(CLK_APMIXED_ARMPLL, "armpll", ARMPLL_CON0, ARMPLL_PWR_CON0, 0x00000001, 0, ARMPLL_CON1, 24, 0, 0, 0, ARMPLL_CON1, 21, PLL_AO),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", MAINPLL_CON0, MAINPLL_PWR_CON0, 0xf0000101, CON0_RST_BAR, MAINPLL_CON1, 24, 0, 0, 0, MAINPLL_CON1, 21, HAVE_RST_BAR),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", UNIVPLL_CON0, UNIVPLL_PWR_CON0, 0xfc000001, CON0_RST_BAR, UNIVPLL_CON1, 24, 0, 0, 0, UNIVPLL_CON1, 21, HAVE_RST_BAR),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", MMPLL_CON0, MMPLL_PWR_CON0, 0x00000001, 0, MMPLL_CON1, 24, 0, 0, 0, MMPLL_CON1, 21, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", MSDCPLL_CON0, MSDCPLL_PWR_CON0, 0x00000001, 0, MSDCPLL_CON1, 24, 0, 0, 0, MSDCPLL_CON1, 21, 0),
+	PLL(CLK_APMIXED_VENCPLL, "vencpll", VENCPLL_CON0, VENCPLL_PWR_CON0, 0x00000001, CON0_RST_BAR, VENCPLL_CON1, 24, 0, 0, 0, VENCPLL_CON1, 21, HAVE_RST_BAR),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", TVDPLL_CON0, TVDPLL_PWR_CON0, 0x00000001, 0, TVDPLL_CON1, 24, 0, 0, 0, TVDPLL_CON1, 21, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", APLL1_CON0, APLL1_PWR_CON0, 0x00000001, 0, APLL1_CON0, 4, APLL1_CON2, AP_PLL_CON_5, 0, APLL1_CON1, 31, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", APLL2_CON0, APLL2_PWR_CON0, 0x00000001, 0, APLL2_CON0, 4, APLL2_CON2, AP_PLL_CON_5, 1, APLL2_CON1, 31, 0)
+};
+
+static int clk_mt6735_apmixed_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct clk_hw_onecell_data *clk_data;
+	int ret;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixedsys_plls));
+	if (!clk_data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, clk_data);
+
+	ret = mtk_clk_register_plls(pdev->dev.of_node, apmixedsys_plls,
+				   ARRAY_SIZE(apmixedsys_plls), clk_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register PLLs: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
+					  clk_data);
+	if (ret)
+		dev_err(&pdev->dev,
+			"Failed to register clock provider: %d\n", ret);
+
+	return ret;
+}
+
+static void clk_mt6735_apmixed_remove(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	mtk_clk_unregister_plls(apmixedsys_plls, ARRAY_SIZE(apmixedsys_plls), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static const struct of_device_id of_match_mt6735_apmixedsys[] = {
+	{ .compatible = "mediatek,mt6735-apmixedsys" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_mt6735_apmixedsys);
+
+static struct platform_driver clk_mt6735_apmixedsys = {
+	.probe = clk_mt6735_apmixed_probe,
+	.remove_new = clk_mt6735_apmixed_remove,
+	.driver = {
+		.name = "clk-mt6735-apmixedsys",
+		.of_match_table = of_match_mt6735_apmixedsys,
+	},
+};
+module_platform_driver(clk_mt6735_apmixedsys);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 apmixedsys clock driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-infracfg.c b/drivers/clk/mediatek/clk-mt6735-infracfg.c
new file mode 100644
index 0000000000000..eceb13af3222a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-infracfg.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-infracfg.h>
+#include <dt-bindings/reset/mediatek,mt6735-infracfg.h>
+
+#define INFRA_RST0			0x30
+#define INFRA_GLOBALCON_PDN0		0x40
+#define INFRA_PDN1			0x44
+#define	INFRA_PDN_STA			0x48
+
+#define RST_NR_PER_BANK			32
+
+static struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = INFRA_GLOBALCON_PDN0,
+	.clr_ofs = INFRA_PDN1,
+	.sta_ofs = INFRA_PDN_STA,
+};
+
+static const struct mtk_gate infracfg_gates[] = {
+	GATE_MTK(CLK_INFRA_DBG, "dbg", "axi_sel", &infra_cg_regs, 0, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_GCE, "gce", "axi_sel", &infra_cg_regs, 1, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_TRBG, "trbg", "axi_sel", &infra_cg_regs, 2, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_CPUM, "cpum", "axi_sel", &infra_cg_regs, 3, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_DEVAPC, "devapc", "axi_sel", &infra_cg_regs, 4, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_AUDIO, "audio", "aud_intbus_sel", &infra_cg_regs, 5, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_GCPU, "gcpu", "axi_sel", &infra_cg_regs, 6, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_L2C_SRAM, "l2csram", "axi_sel", &infra_cg_regs, 7, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_M4U, "m4u", "axi_sel", &infra_cg_regs, 8, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_CLDMA, "cldma", "axi_sel", &infra_cg_regs, 12, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_CONNMCU_BUS, "connmcu_bus", "axi_sel", &infra_cg_regs, 15, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_KP, "kp", "axi_sel", &infra_cg_regs, 16, &mtk_clk_gate_ops_setclr),
+	GATE_MTK_FLAGS(CLK_INFRA_APXGPT, "apxgpt", "axi_sel", &infra_cg_regs, 18, &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL),
+	GATE_MTK(CLK_INFRA_SEJ, "sej", "axi_sel", &infra_cg_regs, 19, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_CCIF0_AP, "ccif0ap", "axi_sel", &infra_cg_regs, 20, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_CCIF1_AP, "ccif1ap", "axi_sel", &infra_cg_regs, 21, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_PMIC_SPI, "pmicspi", "pmicspi_sel", &infra_cg_regs, 22, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_INFRA_PMIC_WRAP, "pmicwrap", "axi_sel", &infra_cg_regs, 23, &mtk_clk_gate_ops_setclr)
+};
+
+static u16 infracfg_rst_bank_ofs[] = { INFRA_RST0 };
+
+static u16 infracfg_rst_idx_map[] = {
+	[MT6735_INFRA_RST0_EMI_REG]		= 0 * RST_NR_PER_BANK + 0,
+	[MT6735_INFRA_RST0_DRAMC0_AO]		= 0 * RST_NR_PER_BANK + 1,
+	[MT6735_INFRA_RST0_AP_CIRQ_EINT]	= 0 * RST_NR_PER_BANK + 3,
+	[MT6735_INFRA_RST0_APXGPT]		= 0 * RST_NR_PER_BANK + 4,
+	[MT6735_INFRA_RST0_SCPSYS]		= 0 * RST_NR_PER_BANK + 5,
+	[MT6735_INFRA_RST0_KP]			= 0 * RST_NR_PER_BANK + 6,
+	[MT6735_INFRA_RST0_PMIC_WRAP]		= 0 * RST_NR_PER_BANK + 7,
+	[MT6735_INFRA_RST0_CLDMA_AO_TOP]	= 0 * RST_NR_PER_BANK + 8,
+	[MT6735_INFRA_RST0_USBSIF_TOP]		= 0 * RST_NR_PER_BANK + 9,
+	[MT6735_INFRA_RST0_EMI]			= 0 * RST_NR_PER_BANK + 16,
+	[MT6735_INFRA_RST0_CCIF]		= 0 * RST_NR_PER_BANK + 17,
+	[MT6735_INFRA_RST0_DRAMC0]		= 0 * RST_NR_PER_BANK + 18,
+	[MT6735_INFRA_RST0_EMI_AO_REG]		= 0 * RST_NR_PER_BANK + 19,
+	[MT6735_INFRA_RST0_CCIF_AO]		= 0 * RST_NR_PER_BANK + 20,
+	[MT6735_INFRA_RST0_TRNG]		= 0 * RST_NR_PER_BANK + 21,
+	[MT6735_INFRA_RST0_SYS_CIRQ]		= 0 * RST_NR_PER_BANK + 22,
+	[MT6735_INFRA_RST0_GCE]			= 0 * RST_NR_PER_BANK + 23,
+	[MT6735_INFRA_RST0_M4U]			= 0 * RST_NR_PER_BANK + 24,
+	[MT6735_INFRA_RST0_CCIF1]		= 0 * RST_NR_PER_BANK + 25,
+	[MT6735_INFRA_RST0_CLDMA_TOP_PD]	= 0 * RST_NR_PER_BANK + 26
+};
+
+static const struct mtk_clk_rst_desc infracfg_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = infracfg_rst_bank_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infracfg_rst_bank_ofs),
+	.rst_idx_map = infracfg_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infracfg_rst_idx_map)
+};
+
+static const struct mtk_clk_desc infracfg_clks = {
+	.clks = infracfg_gates,
+	.num_clks = ARRAY_SIZE(infracfg_gates),
+
+	.rst_desc = &infracfg_resets
+};
+
+static const struct of_device_id of_match_mt6735_infracfg[] = {
+	{ .compatible = "mediatek,mt6735-infracfg", .data = &infracfg_clks },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_mt6735_infracfg);
+
+static struct platform_driver clk_mt6735_infracfg = {
+	.probe = mtk_clk_simple_probe,
+	.remove_new = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-infracfg",
+		.of_match_table = of_match_mt6735_infracfg,
+	},
+};
+module_platform_driver(clk_mt6735_infracfg);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 infracfg clock and reset driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-pericfg.c b/drivers/clk/mediatek/clk-mt6735-pericfg.c
new file mode 100644
index 0000000000000..6f298d5538782
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-pericfg.h>
+#include <dt-bindings/reset/mediatek,mt6735-pericfg.h>
+
+#define PERI_GLOBALCON_RST0		0x00
+#define PERI_GLOBALCON_RST1		0x04
+#define PERI_GLOBALCON_PDN0_SET		0x08
+#define PERI_GLOBALCON_PDN0_CLR		0x10
+#define	PERI_GLOBALCON_PDN0_STA		0x18
+
+#define RST_NR_PER_BANK			32
+
+static struct mtk_gate_regs peri_cg_regs = {
+	.set_ofs = PERI_GLOBALCON_PDN0_SET,
+	.clr_ofs = PERI_GLOBALCON_PDN0_CLR,
+	.sta_ofs = PERI_GLOBALCON_PDN0_STA,
+};
+
+static const struct mtk_gate pericfg_gates[] = {
+	GATE_MTK(CLK_PERI_DISP_PWM, "disp_pwm", "disppwm_sel", &peri_cg_regs, 0, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_THERM, "therm", "axi_sel", &peri_cg_regs, 1, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM1, "pwm1", "axi_sel", &peri_cg_regs, 2, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM2, "pwm2", "axi_sel", &peri_cg_regs, 3, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM3, "pwm3", "axi_sel", &peri_cg_regs, 4, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM4, "pwm4", "axi_sel", &peri_cg_regs, 5, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM5, "pwm5", "axi_sel", &peri_cg_regs, 6, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM6, "pwm6", "axi_sel", &peri_cg_regs, 7, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM7, "pwm7", "axi_sel", &peri_cg_regs, 8, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_PWM, "pwm", "axi_sel", &peri_cg_regs, 9, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_USB0, "usb0", "usb20_sel", &peri_cg_regs, 10, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_IRDA, "irda", "irda_sel", &peri_cg_regs, 11, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_APDMA, "apdma", "axi_sel", &peri_cg_regs, 12, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_MSDC30_0, "msdc30_0", "msdc30_0_sel", &peri_cg_regs, 13, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_MSDC30_1, "msdc30_1", "msdc30_1_sel", &peri_cg_regs, 14, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_MSDC30_2, "msdc30_2", "msdc30_2_sel", &peri_cg_regs, 15, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_MSDC30_3, "msdc30_3", "msdc30_3_sel", &peri_cg_regs, 16, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_UART0, "uart0", "uart_sel", &peri_cg_regs, 17, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_UART1, "uart1", "uart_sel", &peri_cg_regs, 18, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_UART2, "uart2", "uart_sel", &peri_cg_regs, 19, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_UART3, "uart3", "uart_sel", &peri_cg_regs, 20, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_UART4, "uart4", "uart_sel", &peri_cg_regs, 21, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_BTIF, "btif", "axi_sel", &peri_cg_regs, 22, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_I2C0, "i2c0", "axi_sel", &peri_cg_regs, 23, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_I2C1, "i2c1", "axi_sel", &peri_cg_regs, 24, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_I2C2, "i2c2", "axi_sel", &peri_cg_regs, 25, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_I2C3, "i2c3", "axi_sel", &peri_cg_regs, 26, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_AUXADC, "auxadc", "axi_sel", &peri_cg_regs, 27, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_SPI0, "spi0", "spi_sel", &peri_cg_regs, 28, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PERI_IRTX, "irtx", "irtx_sel", &peri_cg_regs, 29, &mtk_clk_gate_ops_setclr)
+};
+
+static u16 pericfg_rst_bank_ofs[] = { PERI_GLOBALCON_RST0, PERI_GLOBALCON_RST1 };
+
+static u16 pericfg_rst_idx_map[] = {
+	[MT6735_PERI_RST0_UART0]		= 0 * RST_NR_PER_BANK + 0,
+	[MT6735_PERI_RST0_UART1]		= 0 * RST_NR_PER_BANK + 1,
+	[MT6735_PERI_RST0_UART2]		= 0 * RST_NR_PER_BANK + 2,
+	[MT6735_PERI_RST0_UART3]		= 0 * RST_NR_PER_BANK + 3,
+	[MT6735_PERI_RST0_UART4]		= 0 * RST_NR_PER_BANK + 4,
+	[MT6735_PERI_RST0_BTIF]			= 0 * RST_NR_PER_BANK + 6,
+	[MT6735_PERI_RST0_DISP_PWM_PERI]	= 0 * RST_NR_PER_BANK + 7,
+	[MT6735_PERI_RST0_PWM]			= 0 * RST_NR_PER_BANK + 8,
+	[MT6735_PERI_RST0_AUXADC]		= 0 * RST_NR_PER_BANK + 10,
+	[MT6735_PERI_RST0_DMA]			= 0 * RST_NR_PER_BANK + 11,
+	[MT6735_PERI_RST0_IRDA]			= 0 * RST_NR_PER_BANK + 12,
+	[MT6735_PERI_RST0_IRTX]			= 0 * RST_NR_PER_BANK + 13,
+	[MT6735_PERI_RST0_THERM]		= 0 * RST_NR_PER_BANK + 16,
+	[MT6735_PERI_RST0_MSDC2]		= 0 * RST_NR_PER_BANK + 17,
+	[MT6735_PERI_RST0_MSDC3]		= 0 * RST_NR_PER_BANK + 18,
+	[MT6735_PERI_RST0_MSDC0]		= 0 * RST_NR_PER_BANK + 19,
+	[MT6735_PERI_RST0_MSDC1]		= 0 * RST_NR_PER_BANK + 20,
+	[MT6735_PERI_RST0_I2C0]			= 0 * RST_NR_PER_BANK + 22,
+	[MT6735_PERI_RST0_I2C1]			= 0 * RST_NR_PER_BANK + 23,
+	[MT6735_PERI_RST0_I2C2]			= 0 * RST_NR_PER_BANK + 24,
+	[MT6735_PERI_RST0_I2C3]			= 0 * RST_NR_PER_BANK + 25,
+	[MT6735_PERI_RST0_USB]			= 0 * RST_NR_PER_BANK + 28,
+
+	[MT6735_PERI_RST1_SPI0]			= 1 * RST_NR_PER_BANK + 1,
+};
+
+static const struct mtk_clk_rst_desc pericfg_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = pericfg_rst_bank_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_bank_ofs),
+	.rst_idx_map = pericfg_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(pericfg_rst_idx_map)
+};
+
+static const struct mtk_clk_desc pericfg_clks = {
+	.clks = pericfg_gates,
+	.num_clks = ARRAY_SIZE(pericfg_gates),
+
+	.rst_desc = &pericfg_resets
+};
+
+static const struct of_device_id of_match_mt6735_pericfg[] = {
+	{ .compatible = "mediatek,mt6735-pericfg", .data = &pericfg_clks },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_mt6735_pericfg);
+
+static struct platform_driver clk_mt6735_pericfg = {
+	.probe = mtk_clk_simple_probe,
+	.remove_new = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-pericfg",
+		.of_match_table = of_match_mt6735_pericfg,
+	},
+};
+module_platform_driver(clk_mt6735_pericfg);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 pericfg clock driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-topckgen.c b/drivers/clk/mediatek/clk-mt6735-topckgen.c
new file mode 100644
index 0000000000000..b2bffe9772e69
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-topckgen.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-topckgen.h>
+
+#define CLK_CFG_0		0x40
+#define CLK_CFG_0_SET		0x44
+#define CLK_CFG_0_CLR		0x48
+#define CLK_CFG_1		0x50
+#define CLK_CFG_1_SET		0x54
+#define CLK_CFG_1_CLR		0x58
+#define CLK_CFG_2		0x60
+#define CLK_CFG_2_SET		0x64
+#define CLK_CFG_2_CLR		0x68
+#define CLK_CFG_3		0x70
+#define CLK_CFG_3_SET		0x74
+#define CLK_CFG_3_CLR		0x78
+#define CLK_CFG_4		0x80
+#define CLK_CFG_4_SET		0x84
+#define CLK_CFG_4_CLR		0x88
+#define CLK_CFG_5		0x90
+#define CLK_CFG_5_SET		0x94
+#define CLK_CFG_5_CLR		0x98
+#define CLK_CFG_6		0xa0
+#define CLK_CFG_6_SET		0xa4
+#define CLK_CFG_6_CLR		0xa8
+#define CLK_CFG_7		0xb0
+#define CLK_CFG_7_SET		0xb4
+#define CLK_CFG_7_CLR		0xb8
+
+static DEFINE_SPINLOCK(mt6735_topckgen_lock);
+
+/* Some clocks with unknown details are modeled as fixed clocks */
+static const struct mtk_fixed_clk topckgen_fixed_clks[] = {
+	/*
+	 * This clock is available as a parent option for multiple
+	 * muxes and seems like an alternative name for clk26m at first,
+	 * but it appears alongside it in several muxes which should
+	 * mean it is a separate clock.
+	 */
+	FIXED_CLK(CLK_TOP_AD_SYS_26M_CK, "ad_sys_26m_ck", "clk26m", 26 * MHZ),
+	/*
+	 * This clock is the parent of DMPLL divisors. It might be MEMPLL
+	 * or its parent, as DMPLL appears to be an alternative name for
+	 * MEMPLL.
+	 */
+	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", NULL, 0),
+	/*
+	 * DMPLL clock (dmpll_ck), controlled by DDRPHY.
+	 */
+	FIXED_CLK(CLK_TOP_DMPLL, "dmpll", "clkph_mck_o", 0),
+	/*
+	 * MIPI DPI clock. Parent option for dpi0_sel. Unknown parent.
+	 */
+	FIXED_CLK(CLK_TOP_DPI_CK, "dpi_ck", NULL, 0),
+	/*
+	 * This clock is a child of WHPLL which is controlled by
+	 * the modem.
+	 */
+	FIXED_CLK(CLK_TOP_WHPLL_AUDIO_CK, "whpll_audio_ck", NULL, 0)
+};
+
+static const struct mtk_fixed_factor topckgen_factors[] = {
+	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "mainpll", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "mainpll", 1, 3),
+	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "mainpll", 1, 5),
+	FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "mainpll", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "mainpll", 1, 8),
+	FACTOR(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "mainpll", 1, 16),
+	FACTOR(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "mainpll", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "mainpll", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "mainpll", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL_D26, "univpll_d26", "univpll", 1, 26),
+	FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL1_D8, "univpll1_d8", "univpll", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univpll", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univpll", 1, 4),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(CLK_TOP_MSDCPLL_D8, "msdcpll_d8", "msdcpll", 1, 8),
+	FACTOR(CLK_TOP_MSDCPLL_D16, "msdcpll_d16", "msdcpll", 1, 16),
+	FACTOR(CLK_TOP_VENCPLL_D3, "vencpll_d3", "vencpll", 1, 3),
+	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll", 1, 4),
+	FACTOR(CLK_TOP_DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
+	FACTOR(CLK_TOP_DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
+	FACTOR(CLK_TOP_DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
+	FACTOR(CLK_TOP_AD_SYS_26M_D2, "ad_sys_26m_d2", "clk26m", 1, 2)
+};
+
+static const char * const axi_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll",
+	"dmpll_d2"
+};
+
+static const char * const mem_sel_parents[] = {
+	"clk26m",
+	"dmpll"
+};
+
+static const char * const ddrphycfg_parents[] = {
+	"clk26m",
+	"syspll1_d8"
+};
+
+static const char * const mm_sel_parents[] = {
+	"clk26m",
+	"vencpll",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll"
+};
+
+static const char * const pwm_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4",
+	"univpll3_d2",
+	"univpll1_d4"
+};
+
+static const char * const vdec_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"syspll_d2",
+	"syspll2_d2",
+	"msdcpll_d2"
+};
+
+static const char * const mfg_sel_parents[] = {
+	"clk26m",
+	"mmpll",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"syspll_d3",
+	"syspll1_d2",
+	"syspll_d5",
+	"univpll_d3",
+	"univpll1_d2"
+};
+
+static const char * const camtg_sel_parents[] = {
+	"clk26m",
+	"univpll_d26",
+	"univpll2_d2",
+	"syspll3_d2",
+	"syspll3_d4",
+	"msdcpll_d4"
+};
+
+static const char * const uart_sel_parents[] = {
+	"clk26m",
+	"univpll2_d8"
+};
+
+static const char * const spi_sel_parents[] = {
+	"clk26m",
+	"syspll3_d2",
+	"msdcpll_d8",
+	"syspll2_d4",
+	"syspll4_d2",
+	"univpll2_d4",
+	"univpll1_d8"
+};
+
+static const char * const usb20_sel_parents[] = {
+	"clk26m",
+	"univpll1_d8",
+	"univpll3_d4"
+};
+
+static const char * const msdc50_0_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll2_d2",
+	"syspll4_d2",
+	"univpll_d5",
+	"univpll1_d4"
+};
+
+static const char * const msdc30_0_sel_parents[] = {
+	"clk26m",
+	"msdcpll",
+	"msdcpll_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d3",
+	"univpll_d26",
+	"syspll2_d4",
+	"univpll_d2"
+};
+
+static const char * const msdc30_1_2_sel_parents[] = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d26",
+	"syspll2_d4"
+};
+
+static const char * const msdc30_3_sel_parents[] = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d26",
+	"msdcpll_d16",
+	"syspll2_d4"
+};
+
+static const char * const audio_sel_parents[] = {
+	"clk26m",
+	"syspll3_d4",
+	"syspll4_d4",
+	"syspll1_d16"
+};
+
+static const char * const aud_intbus_sel_parents[] = {
+	"clk26m",
+	"syspll1_d4",
+	"syspll4_d2",
+	"dmpll_d4"
+};
+
+static const char * const pmicspi_sel_parents[] = {
+	"clk26m",
+	"syspll1_d8",
+	"syspll3_d4",
+	"syspll1_d16",
+	"univpll3_d4",
+	"univpll_d26",
+	"dmpll_d4",
+	"dmpll_d8"
+};
+
+static const char * const scp_sel_parents[] = {
+	"clk26m",
+	"syspll1_d8",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char * const atb_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"dmpll"
+};
+
+static const char * const dpi0_sel_parents[] = {
+	"clk26m",
+	"tvdpll",
+	"tvdpll_d2",
+	"tvdpll_d4",
+	"dpi_ck"
+};
+
+static const char * const scam_sel_parents[] = {
+	"clk26m",
+	"syspll3_d2",
+	"univpll2_d4",
+	"vencpll_d3"
+};
+
+static const char * const mfg13m_sel_parents[] = {
+	"clk26m",
+	"ad_sys_26m_d2"
+};
+
+static const char * const aud_1_2_sel_parents[] = {
+	"clk26m",
+	"apll1"
+};
+
+static const char * const irda_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4"
+};
+
+static const char * const irtx_sel_parents[] = {
+	"clk26m",
+	"ad_sys_26m_ck"
+};
+
+static const char * const disppwm_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4",
+	"syspll4_d2_d8",
+	"ad_sys_26m_ck"
+};
+
+static const struct mtk_mux topckgen_muxes[] = {
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, "axi_sel", axi_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 0, 3, 0, 0),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SEL, "mem_sel", mem_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 8, 1, 0, 0),
+	MUX_CLR_SET_UPD(CLK_TOP_DDRPHY_SEL, "ddrphycfg_sel", ddrphycfg_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 1, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM_SEL, "mm_sel", mm_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 24, 3, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel", pwm_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 0, 2, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC_SEL, "vdec_sel", vdec_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG_SEL, "mfg_sel", mfg_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 16, 4, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG_SEL, "camtg_sel", camtg_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 24, 3, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel", uart_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 0, 1, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel", spi_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB20_SEL, "usb20_sel", usb20_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 16, 2, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 24, 3, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_0_SEL, "msdc30_0_sel", msdc30_0_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 0, 4, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_2_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_1_2_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 16, 3, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 24, 4, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel", audio_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 0, 2, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDINTBUS_SEL, "aud_intbus_sel", aud_intbus_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 8, 2, 15, 0, 0),
+	MUX_CLR_SET_UPD(CLK_TOP_PMICSPI_SEL, "pmicspi_sel", pmicspi_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 16, 3, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP_SEL, "scp_sel", scp_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 24, 2, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ATB_SEL, "atb_sel", atb_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 0, 2, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI0_SEL, "dpi0_sel", dpi0_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCAM_SEL, "scam_sel", scam_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 16, 2, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG13M_SEL, "mfg13m_sel", mfg13m_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 24, 1, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD1_SEL, "aud_1_sel", aud_1_2_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 0, 1, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD2_SEL, "aud_2_sel", aud_1_2_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 8, 1, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IRDA_SEL, "irda_sel", irda_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 16, 1, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IRTX_SEL, "irtx_sel", irtx_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 24, 1, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISPPWM_SEL, "disppwm_sel", disppwm_sel_parents, CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 0, 2, 7, 0, 0),
+};
+
+static const struct mtk_clk_desc topckgen_desc = {
+	.fixed_clks = topckgen_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(topckgen_fixed_clks),
+	.factor_clks = topckgen_factors,
+	.num_factor_clks = ARRAY_SIZE(topckgen_factors),
+	.mux_clks = topckgen_muxes,
+	.num_mux_clks = ARRAY_SIZE(topckgen_muxes),
+	.clk_lock = &mt6735_topckgen_lock,
+};
+
+static const struct of_device_id of_match_mt6735_topckgen[] = {
+	{ .compatible = "mediatek,mt6735-topckgen", .data = &topckgen_desc},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_mt6735_topckgen);
+
+static struct platform_driver clk_mt6735_topckgen = {
+	.probe = mtk_clk_simple_probe,
+	.remove_new = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-topckgen",
+		.of_match_table = of_match_mt6735_topckgen,
+	},
+};
+module_platform_driver(clk_mt6735_topckgen);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 topckgen clock driver");
+MODULE_LICENSE("GPL");
-- 
2.46.2


