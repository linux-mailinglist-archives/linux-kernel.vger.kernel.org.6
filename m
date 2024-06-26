Return-Path: <linux-kernel+bounces-231455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DC9198F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA5BB23058
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59363192B9C;
	Wed, 26 Jun 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnMZeaAD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA219306D;
	Wed, 26 Jun 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433482; cv=none; b=lKz6RBwdRTuoSjDNMaxpf/why1CfGJ4ASaLWTJQFOvMaC1rYqOv0UZy6Kx8KPPOfA+eritDRRTaAk7Wzb3GyHnulfD+uDlbbI0hekdOOeBqgYA0TO0yv6h7gnh/Rhe/WJ4tu8ScXMsoF7jx5TnFJNueJf3RdtOWX9PFIjEG28UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433482; c=relaxed/simple;
	bh=jmnC9QTOvfs6JiTs/taz7FWgvS2dqnm1Xcdvg9TA/bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPRgKODX7iQvPrJvPX3jQSHiyq+pvaqUoajKT5t4CRwU3jTU83eT05YJ4QgRvMTtX6wClhBie2q8XYo7YQjEEzFeCJj3IgjSfK4gHn5X6emtcELh/Wbr0p9ai4DkBqGpeGiSQt1cEhi9R+ekmKdSSz3APxLZ4ZFCydEUhntFjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnMZeaAD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42138eadf64so60455525e9.3;
        Wed, 26 Jun 2024 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719433478; x=1720038278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRHl3xf1M9JLKGPW39grm5f9kzbjOTJ/o8Y55TLXsAU=;
        b=lnMZeaADBor14e85R9e23wEAyDmAfqeNqi5yc+BMC9tGuk9ZEJxaEZEwQm/GxzWDDA
         diEwn39lz57YczCveHi8vm9VdP0a7L9Ud7h0pJYZWft6Ia4kdoC9adDfK4BK/3gaUB9K
         LZ9LIhK0D4hlMeymgJqsNP8dR1rrB6esmyMZLlkpSxQJzpyVOjrR0bQmUYVVSOik630P
         yFSCsn7E6qToU+nQ8Q/nILg/4Q7kuBHqgKlHozdhbuCZmOWwbgTEoY85i7C5qd72i9xU
         tZrF8ZFcYIQpTXvu1SvVVXyc/5qY7IBSErfkZENxy5GvzMHEcINylLyNZXcFD7Z74QX/
         0t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719433478; x=1720038278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRHl3xf1M9JLKGPW39grm5f9kzbjOTJ/o8Y55TLXsAU=;
        b=sMI9Dxd3wcUD1RkehmRsrU+UACnBFkDn+wH3F2rtwwgBALzJ8+KyNfPO9/rhad4Hk8
         BaSqG+CXT0iCYw95c/9eB3P4mC3HSKAOToQ4GCFFzJm2c1H1RnocpLAY5emD+U1N2qkt
         gGonWzirlxUYdNDsPLxceLsBnhvgsSEcPyHFTFD9Es0mv3qGInNPDUr3OCoobRu9tDu5
         Ic0oLjbMZgdQHPtT9+GUmV/ff+LB64zAh52xlcE4WY6+TcQZJdELQGgh2n3VNKdWVFJa
         UrWt15KrbPeqzdug0rl7aIVc4HP7q0zZjrTgNQ4TuBpqHPICZsl0qFqWwzcqwfhRbw1d
         vEow==
X-Forwarded-Encrypted: i=1; AJvYcCWKhnkw0gRnnZaE5rXtCn73awXzQ1SkrLQegz03nmolX0Kr+SIwUEo/k3MBCs0iLv4Yy56RRKrOT54ZXPPG3MuBbyWwkTAxRECcJ3cHrbyLpVIM12jc88dvI4Oy8e+7a51Zgiu9Z+ZSAhft/Edk4hGsSIYyGmGvbf8BmH+kdmm7ChhtEw==
X-Gm-Message-State: AOJu0YycQcJxx2m1mZCcvQ2xsPezmx6OmXZ3hHKybcuQWR+lWvzknnve
	h9lrMhSQsX4DQWSHCjU7VhXgo6HjL8dWZPMT3e4lVjpeenyKhuh0
X-Google-Smtp-Source: AGHT+IGalHFRTk5JzgC88jneVxcnEBmoMwicPViGEXJcMRsNpluW+cYTymQtSatFrURdnioNfsBXfg==
X-Received: by 2002:a05:6000:184d:b0:366:ebc4:2574 with SMTP id ffacd0b85a97d-366ebc425fdmr8349918f8f.33.1719433477955;
        Wed, 26 Jun 2024 13:24:37 -0700 (PDT)
Received: from localhost.localdomain ([105.235.128.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f8268sm16630315f8f.79.2024.06.26.13.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:24:37 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset drivers
Date: Wed, 26 Jun 2024 21:24:05 +0100
Message-ID: <20240626202406.846961-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626202406.846961-1-y.oudjana@protonmail.com>
References: <20240626202406.846961-1-y.oudjana@protonmail.com>
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
 drivers/clk/mediatek/clk-mt6735-infracfg.c   |  79 ++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c    |  92 +++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c   | 394 +++++++++++++++++++
 7 files changed, 717 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a62cc391eab9..0f14b2fb0b917 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14222,6 +14222,10 @@ M:	Yassine Oudjana <y.oudjana@protonmail.com>
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
index 0000000000000..9310f6d9b3033
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
+	PLL(ARMPLL, "armpll", ARMPLL_CON0, ARMPLL_PWR_CON0, 0x00000001, 0, ARMPLL_CON1, 24, 0, 0, 0, ARMPLL_CON1, 21, PLL_AO),
+	PLL(MAINPLL, "mainpll", MAINPLL_CON0, MAINPLL_PWR_CON0, 0xf0000101, CON0_RST_BAR, MAINPLL_CON1, 24, 0, 0, 0, MAINPLL_CON1, 21, HAVE_RST_BAR),
+	PLL(UNIVPLL, "univpll", UNIVPLL_CON0, UNIVPLL_PWR_CON0, 0xfc000001, CON0_RST_BAR, UNIVPLL_CON1, 24, 0, 0, 0, UNIVPLL_CON1, 21, HAVE_RST_BAR),
+	PLL(MMPLL, "mmpll", MMPLL_CON0, MMPLL_PWR_CON0, 0x00000001, 0, MMPLL_CON1, 24, 0, 0, 0, MMPLL_CON1, 21, 0),
+	PLL(MSDCPLL, "msdcpll", MSDCPLL_CON0, MSDCPLL_PWR_CON0, 0x00000001, 0, MSDCPLL_CON1, 24, 0, 0, 0, MSDCPLL_CON1, 21, 0),
+	PLL(VENCPLL, "vencpll", VENCPLL_CON0, VENCPLL_PWR_CON0, 0x00000001, CON0_RST_BAR, VENCPLL_CON1, 24, 0, 0, 0, VENCPLL_CON1, 21, HAVE_RST_BAR),
+	PLL(TVDPLL, "tvdpll", TVDPLL_CON0, TVDPLL_PWR_CON0, 0x00000001, 0, TVDPLL_CON1, 24, 0, 0, 0, TVDPLL_CON1, 21, 0),
+	PLL(APLL1, "apll1", APLL1_CON0, APLL1_PWR_CON0, 0x00000001, 0, APLL1_CON0, 4, APLL1_CON2, AP_PLL_CON_5, 0, APLL1_CON1, 31, 0),
+	PLL(APLL2, "apll2", APLL2_CON0, APLL2_PWR_CON0, 0x00000001, 0, APLL2_CON0, 4, APLL2_CON2, AP_PLL_CON_5, 1, APLL2_CON1, 31, 0)
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
index 0000000000000..855a7538d64ea
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-infracfg.c
@@ -0,0 +1,79 @@
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
+
+#define INFRA_RST0			0x30
+#define INFRA_GLOBALCON_PDN0		0x40
+#define INFRA_PDN1			0x44
+#define	INFRA_PDN_STA			0x48
+
+static struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = INFRA_GLOBALCON_PDN0,
+	.clr_ofs = INFRA_PDN1,
+	.sta_ofs = INFRA_PDN_STA,
+};
+
+static const struct mtk_gate infracfg_gates[] = {
+	GATE_MTK(CLK_DBG, "dbg", "axi_sel", &infra_cg_regs, 0, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_GCE, "gce", "axi_sel", &infra_cg_regs, 1, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_TRBG, "trbg", "axi_sel", &infra_cg_regs, 2, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_CPUM, "cpum", "axi_sel", &infra_cg_regs, 3, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_DEVAPC, "devapc", "axi_sel", &infra_cg_regs, 4, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_AUDIO, "audio", "aud_intbus_sel", &infra_cg_regs, 5, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_GCPU, "gcpu", "axi_sel", &infra_cg_regs, 6, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_L2C_SRAM, "l2csram", "axi_sel", &infra_cg_regs, 7, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_M4U, "m4u", "axi_sel", &infra_cg_regs, 8, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_CLDMA, "cldma", "axi_sel", &infra_cg_regs, 12, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_CONNMCU_BUS, "connmcu_bus", "axi_sel", &infra_cg_regs, 15, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_KP, "kp", "axi_sel", &infra_cg_regs, 16, &mtk_clk_gate_ops_setclr),
+	GATE_MTK_FLAGS(CLK_APXGPT, "apxgpt", "axi_sel", &infra_cg_regs, 18, &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL),
+	GATE_MTK(CLK_SEJ, "sej", "axi_sel", &infra_cg_regs, 19, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_CCIF0_AP, "ccif0ap", "axi_sel", &infra_cg_regs, 20, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_CCIF1_AP, "ccif1ap", "axi_sel", &infra_cg_regs, 21, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PMIC_SPI, "pmicspi", "pmicspi_sel", &infra_cg_regs, 22, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PMIC_WRAP, "pmicwrap", "axi_sel", &infra_cg_regs, 23, &mtk_clk_gate_ops_setclr)
+};
+
+static u16 infracfg_rst_ofs[] = { INFRA_RST0 };
+
+static const struct mtk_clk_rst_desc infracfg_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = infracfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infracfg_rst_ofs)
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
index 0000000000000..59ae2fd61b9f8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
@@ -0,0 +1,92 @@
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
+
+#define PERI_GLOBALCON_RST0		0x00
+#define PERI_GLOBALCON_RST1		0x04
+#define PERI_GLOBALCON_PDN0_SET		0x08
+#define PERI_GLOBALCON_PDN0_CLR		0x10
+#define	PERI_GLOBALCON_PDN0_STA		0x18
+
+static struct mtk_gate_regs peri_cg_regs = {
+	.set_ofs = PERI_GLOBALCON_PDN0_SET,
+	.clr_ofs = PERI_GLOBALCON_PDN0_CLR,
+	.sta_ofs = PERI_GLOBALCON_PDN0_STA,
+};
+
+static const struct mtk_gate pericfg_gates[] = {
+	GATE_MTK(CLK_DISP_PWM, "disp_pwm", "disppwm_sel", &peri_cg_regs, 0, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_THERM, "therm", "axi_sel", &peri_cg_regs, 1, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM1, "pwm1", "axi_sel", &peri_cg_regs, 2, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM2, "pwm2", "axi_sel", &peri_cg_regs, 3, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM3, "pwm3", "axi_sel", &peri_cg_regs, 4, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM4, "pwm4", "axi_sel", &peri_cg_regs, 5, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM5, "pwm5", "axi_sel", &peri_cg_regs, 6, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM6, "pwm6", "axi_sel", &peri_cg_regs, 7, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM7, "pwm7", "axi_sel", &peri_cg_regs, 8, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_PWM, "pwm", "axi_sel", &peri_cg_regs, 9, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_USB0, "usb0", "usb20_sel", &peri_cg_regs, 10, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IRDA, "irda", "irda_sel", &peri_cg_regs, 11, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_APDMA, "apdma", "axi_sel", &peri_cg_regs, 12, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_MSDC30_0, "msdc30_0", "msdc30_0_sel", &peri_cg_regs, 13, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_MSDC30_1, "msdc30_1", "msdc30_1_sel", &peri_cg_regs, 14, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_MSDC30_2, "msdc30_2", "msdc30_2_sel", &peri_cg_regs, 15, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_MSDC30_3, "msdc30_3", "msdc30_3_sel", &peri_cg_regs, 16, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_UART0, "uart0", "uart_sel", &peri_cg_regs, 17, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_UART1, "uart1", "uart_sel", &peri_cg_regs, 18, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_UART2, "uart2", "uart_sel", &peri_cg_regs, 19, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_UART3, "uart3", "uart_sel", &peri_cg_regs, 20, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_UART4, "uart4", "uart_sel", &peri_cg_regs, 21, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_BTIF, "btif", "axi_sel", &peri_cg_regs, 22, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_I2C0, "i2c0", "axi_sel", &peri_cg_regs, 23, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_I2C1, "i2c1", "axi_sel", &peri_cg_regs, 24, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_I2C2, "i2c2", "axi_sel", &peri_cg_regs, 25, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_I2C3, "i2c3", "axi_sel", &peri_cg_regs, 26, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_AUXADC, "auxadc", "axi_sel", &peri_cg_regs, 27, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_SPI0, "spi0", "spi_sel", &peri_cg_regs, 28, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IRTX, "irtx", "irtx_sel", &peri_cg_regs, 29, &mtk_clk_gate_ops_setclr)
+};
+
+static u16 pericfg_rst_ofs[] = { PERI_GLOBALCON_RST0, PERI_GLOBALCON_RST1 };
+
+static const struct mtk_clk_rst_desc pericfg_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs)
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
index 0000000000000..2ff765ae3944c
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
+	FIXED_CLK(AD_SYS_26M_CK, "ad_sys_26m_ck", "clk26m", 26 * MHZ),
+	/*
+	 * This clock is the parent of DMPLL divisors. It might be MEMPLL
+	 * or its parent, as DMPLL appears to be an alternative name for
+	 * MEMPLL.
+	 */
+	FIXED_CLK(CLKPH_MCK_O, "clkph_mck_o", NULL, 0),
+	/*
+	 * DMPLL clock (dmpll_ck), controlled by DDRPHY.
+	 */
+	FIXED_CLK(DMPLL, "dmpll", "clkph_mck_o", 0),
+	/*
+	 * MIPI DPI clock. Parent option for dpi0_sel. Unknown parent.
+	 */
+	FIXED_CLK(DPI_CK, "dpi_ck", NULL, 0),
+	/*
+	 * This clock is a child of WHPLL which is controlled by
+	 * the modem.
+	 */
+	FIXED_CLK(WHPLL_AUDIO_CK, "whpll_audio_ck", NULL, 0)
+};
+
+static const struct mtk_fixed_factor topckgen_factors[] = {
+	FACTOR(SYSPLL_D2, "syspll_d2", "mainpll", 1, 2),
+	FACTOR(SYSPLL_D3, "syspll_d3", "mainpll", 1, 3),
+	FACTOR(SYSPLL_D5, "syspll_d5", "mainpll", 1, 5),
+	FACTOR(SYSPLL1_D2, "syspll1_d2", "mainpll", 1, 2),
+	FACTOR(SYSPLL1_D4, "syspll1_d4", "mainpll", 1, 4),
+	FACTOR(SYSPLL1_D8, "syspll1_d8", "mainpll", 1, 8),
+	FACTOR(SYSPLL1_D16, "syspll1_d16", "mainpll", 1, 16),
+	FACTOR(SYSPLL2_D2, "syspll2_d2", "mainpll", 1, 2),
+	FACTOR(SYSPLL2_D4, "syspll2_d4", "mainpll", 1, 4),
+	FACTOR(SYSPLL3_D2, "syspll3_d2", "mainpll", 1, 2),
+	FACTOR(SYSPLL3_D4, "syspll3_d4", "mainpll", 1, 4),
+	FACTOR(SYSPLL4_D2, "syspll4_d2", "mainpll", 1, 2),
+	FACTOR(SYSPLL4_D4, "syspll4_d4", "mainpll", 1, 4),
+	FACTOR(UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
+	FACTOR(UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
+	FACTOR(UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(UNIVPLL_D26, "univpll_d26", "univpll", 1, 26),
+	FACTOR(UNIVPLL1_D2, "univpll1_d2", "univpll", 1, 2),
+	FACTOR(UNIVPLL1_D4, "univpll1_d4", "univpll", 1, 4),
+	FACTOR(UNIVPLL1_D8, "univpll1_d8", "univpll", 1, 8),
+	FACTOR(UNIVPLL2_D2, "univpll2_d2", "univpll", 1, 2),
+	FACTOR(UNIVPLL2_D4, "univpll2_d4", "univpll", 1, 4),
+	FACTOR(UNIVPLL2_D8, "univpll2_d8", "univpll", 1, 8),
+	FACTOR(UNIVPLL3_D2, "univpll3_d2", "univpll", 1, 2),
+	FACTOR(UNIVPLL3_D4, "univpll3_d4", "univpll", 1, 4),
+	FACTOR(MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(MSDCPLL_D8, "msdcpll_d8", "msdcpll", 1, 8),
+	FACTOR(MSDCPLL_D16, "msdcpll_d16", "msdcpll", 1, 16),
+	FACTOR(VENCPLL_D3, "vencpll_d3", "vencpll", 1, 3),
+	FACTOR(TVDPLL_D2, "tvdpll_d2", "tvdpll", 1, 2),
+	FACTOR(TVDPLL_D4, "tvdpll_d4", "tvdpll", 1, 4),
+	FACTOR(DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
+	FACTOR(DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
+	FACTOR(DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
+	FACTOR(AD_SYS_26M_D2, "ad_sys_26m_d2", "clk26m", 1, 2)
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
+	MUX_CLR_SET_UPD(AXI_SEL, "axi_sel", axi_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 0, 3, 0, 0),
+	MUX_CLR_SET_UPD(MEM_SEL, "mem_sel", mem_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 8, 1, 0, 0),
+	MUX_CLR_SET_UPD(DDRPHY_SEL, "ddrphycfg_sel", ddrphycfg_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 1, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MM_SEL, "mm_sel", mm_sel_parents, CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR, 24, 3, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(PWM_SEL, "pwm_sel", pwm_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 0, 2, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(VDEC_SEL, "vdec_sel", vdec_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MFG_SEL, "mfg_sel", mfg_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 16, 4, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(CAMTG_SEL, "camtg_sel", camtg_sel_parents, CLK_CFG_1, CLK_CFG_1_SET, CLK_CFG_1_CLR, 24, 3, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(UART_SEL, "uart_sel", uart_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 0, 1, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(SPI_SEL, "spi_sel", spi_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(USB20_SEL, "usb20_sel", usb20_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 16, 2, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_sel_parents, CLK_CFG_2, CLK_CFG_2_SET, CLK_CFG_2_CLR, 24, 3, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MSDC30_0_SEL, "msdc30_0_sel", msdc30_0_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 0, 4, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_2_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MSDC30_2_SEL, "msdc30_2_sel", msdc30_1_2_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 16, 3, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_sel_parents, CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 24, 4, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(AUDIO_SEL, "audio_sel", audio_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 0, 2, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(AUDINTBUS_SEL, "aud_intbus_sel", aud_intbus_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 8, 2, 15, 0, 0),
+	MUX_CLR_SET_UPD(PMICSPI_SEL, "pmicspi_sel", pmicspi_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 16, 3, 0, 0),
+	MUX_GATE_CLR_SET_UPD(SCP_SEL, "scp_sel", scp_sel_parents, CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 24, 2, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(ATB_SEL, "atb_sel", atb_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 0, 2, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(DPI0_SEL, "dpi0_sel", dpi0_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 8, 3, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(SCAM_SEL, "scam_sel", scam_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 16, 2, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(MFG13M_SEL, "mfg13m_sel", mfg13m_sel_parents, CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 24, 1, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(AUD1_SEL, "aud_1_sel", aud_1_2_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 0, 1, 7, 0, 0),
+	MUX_GATE_CLR_SET_UPD(AUD2_SEL, "aud_2_sel", aud_1_2_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 8, 1, 15, 0, 0),
+	MUX_GATE_CLR_SET_UPD(IRDA_SEL, "irda_sel", irda_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 16, 1, 23, 0, 0),
+	MUX_GATE_CLR_SET_UPD(IRTX_SEL, "irtx_sel", irtx_sel_parents, CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 24, 1, 31, 0, 0),
+	MUX_GATE_CLR_SET_UPD(DISPPWM_SEL, "disppwm_sel", disppwm_sel_parents, CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 0, 2, 7, 0, 0),
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
2.45.1


