Return-Path: <linux-kernel+bounces-268404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2794243F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2E41C22A71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85916426;
	Wed, 31 Jul 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeFHKRXu"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622C11185;
	Wed, 31 Jul 2024 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390203; cv=none; b=LlD7ke0lVv+e8ssfLEKe6cRqLA+FULKo7Wp3ZJcJlssAmGUlEmTgeoa4bKzvjVkVVFd49BDXfarqmN12+qw6B94p5p7+u23J76XNxePvf2dk21dwnBSbwsJue7rcyP2h3aDkUYWYKnauu1cXL2VnxdMPbZa5fmhkB4+hA2gnMkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390203; c=relaxed/simple;
	bh=76hAJit1zg4VNyz5kDOBWkpcSIO1vBmc+rCBxJkh0C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1LI1OPkVKQObYD+JYsBAkBGn6zoIH/DmloJ1P+A3YDJiWua+n0/JM+SRJR6o/a5yC4WVSmCHBSLfy24k+mVtrY/8ez50AYZAXattKfdnyCvNASmIvS1Az0e0DcaQnIZygzm+guy098+DCVpkVe1SLHjQ8OYbtAE+PAUWLkQ1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeFHKRXu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3580531b3a.1;
        Tue, 30 Jul 2024 18:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722390202; x=1722995002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqzCoAbFqxndP749YKSB5ePQejWzAj5lN8I2yJMHRQg=;
        b=SeFHKRXu3Ds1hOlWt0RMC4iQu1fjoRtoDwSII9WWdDjHwOUOjDVb7F0vvmkcFdj4lW
         kRtVl5v4O8eVDnGbmwyO68Q3LJQznsBibr9hmIo8uiHAxeVHwOBLs0P7Lvzrw1yccHvC
         by+11COMcb9nEhGA+yrjabKZg7j2CDYDj/4s2UbXIuFo7MIVPUiPe8RC+oe3zd7YiLsh
         GsDbV95lk2frx2mnupKyLu7aS2HDi6bbrh10vqXvyNmZohd6NQTuxYSQMlPSDlnRPcaq
         FEhGEzIox7J4edICoXUzhWSjVlvdV4h3bMoRVCtk+RMtqHc8258Ey2qpnftLuEc8/DF/
         HokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722390202; x=1722995002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqzCoAbFqxndP749YKSB5ePQejWzAj5lN8I2yJMHRQg=;
        b=CuDVRX1e3hr4fJ4NlOP4g7ybD/xTolcVNl0mEVxOQKGbipahPAq6u2i2wtJ/ViEiCc
         n0Cachqo1TM0M1hBF5rYldr0mOE3s0JX/qP3Zod73WnjOGp9qQ3VCyNLpEchvkxha/Kf
         CBCb+igL3j62QxJXRQ7CKhPtNPNdapNhgBZUpNKg5CdJE2GlsGodeurY7E9fCViWguJD
         OX8tM9drlmcLOrbNWO9enkTZtg4HxYvlXj6ou3QzTQbNtEgw4cjUrEL5lcuZEebO1tyD
         MSznN5eQ2AswTPug3AcXv3XUmZorlk3aivXRbqLiCnFQBeDQ9CRNDak6lnrq6SvHCys7
         5Qhw==
X-Forwarded-Encrypted: i=1; AJvYcCU0R3pxe4yzv5LSVZdMDY5WHP7+F2WJI3e1e5cNW43huKhD7hLZ8jRc5nluU8GXpr/h4K1npdlzTLYJlGeNPeuH0x2WFPF1nWpAL+5a6qdmKjfZRJKwDPWdXNq3GFu0NB+6ZPnzaI214Q==
X-Gm-Message-State: AOJu0Yy6x4AdXMPNOC4P1LbNMCOzXkGWcHzN4C0h7hwnLS3AD9mwbWG5
	gePObpz0jwgNgZWYHO8ezSrq52wvS9H1YCIB+UOVa8IS3NCHGNwW
X-Google-Smtp-Source: AGHT+IGCSaAyV+DhK5xvZ/jgFrmOMha3FW9C8VO/kHLPEsayQAv5yDUCJ180FVq1VOjQnmpm2pPcEw==
X-Received: by 2002:a05:6a00:23ce:b0:710:4d4b:1af with SMTP id d2e1a72fcca58-7104d4b020cmr588435b3a.7.1722390201589;
        Tue, 30 Jul 2024 18:43:21 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a48aasm9003534b3a.196.2024.07.30.18.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:43:21 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: [PATCH v2 2/2] phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY
Date: Wed, 31 Jul 2024 01:43:13 +0000
Message-Id: <20240731014313.113417-3-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731014313.113417-1-hpchen0nvt@gmail.com>
References: <20240731014313.113417-1-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nuvoton MA35 SoCs support DWC2 USB controller.
Add the driver to drive the USB 2.0 PHY transceivers.

Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
---
 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/nuvoton/Kconfig           |  13 +++
 drivers/phy/nuvoton/Makefile          |   3 +
 drivers/phy/nuvoton/phy-ma35d1-usb2.c | 146 ++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35d1-usb2.c

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
index 000000000000..2937e3921898
--- /dev/null
+++ b/drivers/phy/nuvoton/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PHY_MA35_USB)		+= phy-ma35d1-usb2.o
diff --git a/drivers/phy/nuvoton/phy-ma35d1-usb2.c b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
new file mode 100644
index 000000000000..8922e5da8e3b
--- /dev/null
+++ b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
@@ -0,0 +1,146 @@
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
+		ret = readl_poll_timeout((void __iomem *)p_phy->sysreg + MA35_SYS_REG_USBPMISCR,
+					 val, val & PHY0DEVCKSTB, 1, 100);
+		if (ret == -ETIMEDOUT) {
+			dev_err(p_phy->dev, "1.Check PHY clock, Timeout: %d\n", val);
+			return ret;
+		}
+		return 0;
+	}
+
+	/*
+	 * reset USB PHY0.
+	 * wait until USB PHY0 60 MHz UTMI Interface Clock ready
+	 */
+	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, (PHY0POR | PHY0SUSPEND));
+	udelay(10);
+
+	/* make USB PHY0 enter operation mode */
+	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, PHY0SUSPEND);
+
+	/* make sure USB PHY 60 MHz UTMI Interface Clock ready */
+	ret = readl_poll_timeout((void __iomem *)p_phy->sysreg + MA35_SYS_REG_USBPMISCR,
+				 val, val & PHY0DEVCKSTB, 1, 100);
+	if (ret == -ETIMEDOUT) {
+		dev_err(p_phy->dev, "2.Check PHY clock, Timeout: %d\n", ret);
+		return ret;
+	}
+
+	clk_disable_unprepare(p_phy->clk);
+	return 0;
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
+	struct phy *phy;
+
+	p_phy = devm_kzalloc(&pdev->dev, sizeof(*p_phy), GFP_KERNEL);
+	if (!p_phy)
+		return -ENOMEM;
+
+	p_phy->dev = &pdev->dev;
+	platform_set_drvdata(pdev, p_phy);
+
+	p_phy->sysreg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "nuvoton,sys");
+	if (IS_ERR(p_phy->sysreg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->sysreg),
+				     "Failed to get SYS registers\n");
+
+	p_phy->clk = of_clk_get(pdev->dev.of_node, 0);
+	if (IS_ERR(p_phy->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->clk),
+				     "failed to find usb_phy clock\n");
+
+	phy = devm_phy_create(&pdev->dev, NULL, &ma35_usb_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(phy), "Failed to create PHY\n");
+
+	phy_set_drvdata(phy, p_phy);
+
+	provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(&pdev->dev, PTR_ERR(provider),
+				     "Failed to register PHY provider\n");
+	return 0;
+}
+
+static const struct of_device_id ma35_usb_phy_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-usb2-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ma35_usb_phy_of_match);
+
+static struct platform_driver ma35_usb_phy_driver = {
+	.probe		= ma35_usb_phy_probe,
+	.driver	= {
+		.name	= "ma35d1-usb2-phy",
+		.of_match_table = ma35_usb_phy_of_match,
+	},
+};
+module_platform_driver(ma35_usb_phy_driver);
+
+MODULE_DESCRIPTION("Nuvoton ma35d1 USB2.0 PHY driver");
+MODULE_AUTHOR("hpchen0nvt@gmail.com");
+MODULE_LICENSE("GPL");
-- 
2.25.1


