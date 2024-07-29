Return-Path: <linux-kernel+bounces-265141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE293ED45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4D71C203F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5C86277;
	Mon, 29 Jul 2024 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE8316Ti"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936A84E0D;
	Mon, 29 Jul 2024 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233721; cv=none; b=NPjMbzZe8045NjGxE156FN+3NuLGAPxklmukebftC9Zf0I1sRMEf505h3GPEYa8TiKajOFWJUU8jWuFNI6eWjw3kXVqteM4iE+7U3XCSnqVDy8Zd1l2syavAYAxPPBl/kAipwJHxHlV0bBH6FvGBo2zCcr/9+J1NcJ59FbkuJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233721; c=relaxed/simple;
	bh=NUy+jTEJyqsig85RtzFjSm8Zl7cV2dfMtpTiYVvlfDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6UepbXugiFBMdZ+gcK9yXtUiWoQuqqG8RunVAb3eA4orXdRJB3p/a9Kl4mNJEKs5SnZhGgqXmmzFfTYpgkF3CsS4s8f7Pu0s86B44of+fl4Wz9mNb5WqG+ome5wjAZkC/5LxgmK0ZppIomXAWeBVb6Hjf/UnQ1qiEOEnGl6egY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE8316Ti; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso2291389a91.1;
        Sun, 28 Jul 2024 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722233719; x=1722838519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH/fsCRbVakN7gixYJYo8VOqiSpDvYW3fwUrp/KNGUI=;
        b=PE8316TihkkkAymWxKWWiarFVTpkah2ZGj6/nn5TYdTZvZKEJUtUzpgeiApsatFHDe
         gAXTxxMywGWfasdSilvA0qjyl0nBRbFHY6th3fgb0C8imvf4pNJah/0a7c0pkPAzJJAy
         hMDDbUSGAaYgWYkWfGFR3izKYQ97zZfJJwubIjsn4OWORFGsttT3lwV9npsqWqndncoX
         huEBxitdF2BE04hUage0cYuBwJNgloLf0+3ddn8onCFDGRKacF8MDLDzYXXhbjxPDVRy
         hMm7exX9+DfWo8rC4J5hzwftRjOkuLnILGE8hoEdczOz+LXIh7qMob6ZjO3Apfl4aQsI
         /Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722233719; x=1722838519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xH/fsCRbVakN7gixYJYo8VOqiSpDvYW3fwUrp/KNGUI=;
        b=CxFvx60t7JYUNaOVhEPVicDGcaNOaEGUVD7qlTaTS+Z/ggBbjH7bEH+c6s8MWp1hrl
         oulkySPoQrAhEAjlMSay1yjXPnsNEIdF2aeGVlWZQKTGW82zetYdZtOrk93Zgw/6ZITa
         uGpG6BzikliIHns7i2KT0Ku9fW5abQPEVtgFGcPED2ZRZrNgxzKJSqdLVFYwxSHtxzq2
         2C8OZsAQKuXbgzpF0iSvu2ISiyQYlq1LPhDcbHb0wGTnJzPOn2/Cd07/ccWO6f82OS2x
         fXCa1eOsxliMXj/fGMv4HSxkREtUOIBFLCUW6T7eNKiUtCrDg2YWlKTwAxU6w9KPNnbI
         Rgmw==
X-Forwarded-Encrypted: i=1; AJvYcCWGN59A3+QYQswntNLPlHWeT0C4tSQePpdguYDlVtdnKD0Rb2JTjmjdi690Lxfzt/IMaGKSUjKkWYlNCnKCbLPtbz6aCKgjuFonmov0tK+nDTH2dse7AI8/KAr9vZ8npz4qOWmywOVaQA==
X-Gm-Message-State: AOJu0YwMULtR+0ikUttFNIVLsQA0sITD0A87Ozfi0siCmPKqblQTwCco
	kankhAynXfBDhQhfuWa/YAUQxHBA+yyQvF/YPUUlJvCw6MYXq80n
X-Google-Smtp-Source: AGHT+IFSxE2T4Kl9u11ZvXGY16Qyk7/rJYMTKzQYuwaXrmBlyY3Q/Mt42wc53P9QSoGPdpSlABjn4w==
X-Received: by 2002:a17:90b:3618:b0:2c2:f2d6:60d4 with SMTP id 98e67ed59e1d1-2cf7e0a6b55mr7605562a91.8.1722233719275;
        Sun, 28 Jul 2024 23:15:19 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8cd2013fsm7951282a91.0.2024.07.28.23.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:15:19 -0700 (PDT)
From: hpchen0 <hpchen0nvt@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hpchen0 <hpchen0nvt@gmail.com>
Subject: [PATCH 2/2] phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY
Date: Mon, 29 Jul 2024 06:15:09 +0000
Message-Id: <20240729061509.83828-3-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729061509.83828-1-hpchen0nvt@gmail.com>
References: <20240729061509.83828-1-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nuvoton MA35 SoCs support DWC2 USB controller.
Add the driver to drive the USB 2.0 PHY transceivers.

Signed-off-by: hpchen0 <hpchen0nvt@gmail.com>
---
 drivers/phy/Kconfig                 |   1 +
 drivers/phy/Makefile                |   1 +
 drivers/phy/nuvoton/Kconfig         |  13 +++
 drivers/phy/nuvoton/Makefile        |   3 +
 drivers/phy/nuvoton/phy-ma35-usb2.c | 160 ++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+)
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35-usb2.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index dfab1c66b3e5..f73abff416be 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -95,6 +95,7 @@ source "drivers/phy/mediatek/Kconfig"
 source "drivers/phy/microchip/Kconfig"
 source "drivers/phy/motorola/Kconfig"
 source "drivers/phy/mscc/Kconfig"
+source "drivers/phy/nuvoton/Kconfig"
 source "drivers/phy/qualcomm/Kconfig"
 source "drivers/phy/ralink/Kconfig"
 source "drivers/phy/realtek/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 5fcbce5f9ab1..ebc399560da4 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -25,6 +25,7 @@ obj-y					+= allwinner/	\
 					   microchip/	\
 					   motorola/	\
 					   mscc/	\
+					   nuvoton/	\
 					   qualcomm/	\
 					   ralink/	\
 					   realtek/	\
diff --git a/drivers/phy/nuvoton/Kconfig b/drivers/phy/nuvoton/Kconfig
new file mode 100644
index 000000000000..270ee2943287
--- /dev/null
+++ b/drivers/phy/nuvoton/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# PHY drivers for Nuvoton MA35 platforms
+#
+config PHY_MA35_USB
+	tristate "Nuvoton MA35 USB2.0 PHY driver"
+	depends on ARCH_MA35 || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB2.0 PHY on the Nuvoton MA35
+	  series SoCs.
+
diff --git a/drivers/phy/nuvoton/Makefile b/drivers/phy/nuvoton/Makefile
new file mode 100644
index 000000000000..85785e037d5f
--- /dev/null
+++ b/drivers/phy/nuvoton/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PHY_MA35_USB)		+= phy-ma35-usb2.o
diff --git a/drivers/phy/nuvoton/phy-ma35-usb2.c b/drivers/phy/nuvoton/phy-ma35-usb2.c
new file mode 100644
index 000000000000..061b31fcfbb1
--- /dev/null
+++ b/drivers/phy/nuvoton/phy-ma35-usb2.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Nuvoton Technology Corp.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* USB PHY Miscellaneous Control Register */
+#define MA35_SYS_REG_USBPMISCR	0x60
+#define PHY0POR			BIT(0)  /* PHY Power-On Reset Control Bit */
+#define PHY0SUSPEND			BIT(1)  /* PHY Suspend; 0: suspend, 1: operaion */
+#define PHY0COMN			BIT(2)  /* PHY Common Block Power-Down Control */
+#define PHY0DEVCKSTB			BIT(10) /* PHY 60 MHz UTMI clock stable bit */
+
+struct ma35_usb_phy {
+	struct clk *clk;
+	struct device *dev;
+	struct regmap *sysreg;
+};
+
+static int ma35_usb_phy_power_on(struct phy *phy)
+{
+	struct ma35_usb_phy *p_phy = phy_get_drvdata(phy);
+	unsigned long timeout;
+	unsigned int val;
+	int ret;
+
+	ret = clk_prepare_enable(p_phy->clk);
+	if (ret < 0) {
+		dev_err(p_phy->dev, "Failed to enable PHY clock: %d\n", ret);
+		return ret;
+	}
+
+	regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
+	if (val & PHY0SUSPEND) {
+		/*
+		 * USB PHY0 is in operation mode already
+		 * make sure USB PHY 60 MHz UTMI Interface Clock ready
+		 */
+		timeout = jiffies + msecs_to_jiffies(200);
+		while (time_before(jiffies, timeout)) {
+			regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
+			if (val & PHY0DEVCKSTB)
+				return 0;
+			usleep_range(1000, 1500);
+		}
+	}
+
+	/*
+	 * reset USB PHY0.
+	 * wait until USB PHY0 60 MHz UTMI Interface Clock ready
+	 */
+	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, (PHY0POR | PHY0SUSPEND));
+	timeout = jiffies + msecs_to_jiffies(200);
+	while (time_before(jiffies, timeout)) {
+		regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
+		if (val & PHY0DEVCKSTB)
+			break;
+		usleep_range(1000, 1500);
+	}
+
+	/* make USB PHY0 enter operation mode */
+	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, PHY0SUSPEND);
+
+	/* make sure USB PHY 60 MHz UTMI Interface Clock ready */
+	timeout = jiffies + msecs_to_jiffies(200);
+	while (time_before(jiffies, timeout)) {
+		regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
+		if (val & PHY0DEVCKSTB)
+			return 0;
+		usleep_range(1000, 1500);
+	}
+
+	dev_err(p_phy->dev, "Timed out waiting for PHY to power on\n");
+	ret = -ETIMEDOUT;
+
+	clk_disable_unprepare(p_phy->clk);
+	return ret;
+}
+
+static int ma35_usb_phy_power_off(struct phy *phy)
+{
+	struct ma35_usb_phy *p_phy = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(p_phy->clk);
+	return 0;
+}
+
+static const struct phy_ops ma35_usb_phy_ops = {
+	.power_on = ma35_usb_phy_power_on,
+	.power_off = ma35_usb_phy_power_off,
+	.owner = THIS_MODULE,
+};
+
+static int ma35_usb_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *provider;
+	struct ma35_usb_phy *p_phy;
+	const char *clkgate;
+	struct phy *phy;
+
+	p_phy = devm_kzalloc(&pdev->dev, sizeof(*p_phy), GFP_KERNEL);
+	if (!p_phy)
+		return -ENOMEM;
+
+	p_phy->dev = &pdev->dev;
+	platform_set_drvdata(pdev, p_phy);
+
+	p_phy->sysreg = syscon_regmap_lookup_by_phandle(p_phy->dev->of_node, "nuvoton,sys");
+	if (IS_ERR(p_phy->sysreg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->sysreg),
+				     "Failed to get SYS registers\n");
+
+	/* enable clock */
+	of_property_read_string(p_phy->dev->of_node, "clock-enable", &clkgate);
+	p_phy->clk = devm_clk_get(p_phy->dev, clkgate);
+	if (IS_ERR(p_phy->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->clk),
+				     "Failed to get usb_phy clock\n");
+
+	phy = devm_phy_create(p_phy->dev, NULL, &ma35_usb_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(phy), "Failed to create PHY\n");
+
+	phy_set_drvdata(phy, p_phy);
+
+	provider = devm_of_phy_provider_register(p_phy->dev, of_phy_simple_xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(&pdev->dev, PTR_ERR(provider),
+				     "Failed to register PHY provider\n");
+	return 0;
+}
+
+static const struct of_device_id ma35_usb_phy_of_match[] = {
+	{ .compatible = "nuvoton,ma35-usb2-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ma35_usb_phy_of_match);
+
+static struct platform_driver ma35_usb_phy_driver = {
+	.probe		= ma35_usb_phy_probe,
+	.driver	= {
+		.name	= "ma35-usb2-phy",
+		.of_match_table = ma35_usb_phy_of_match,
+	},
+};
+module_platform_driver(ma35_usb_phy_driver);
+
+MODULE_DESCRIPTION("Nuvoton ma35 USB2.0 PHY driver");
+MODULE_AUTHOR("hpchen0nvt@gmail.com");
+MODULE_LICENSE("GPL");
-- 
2.25.1


