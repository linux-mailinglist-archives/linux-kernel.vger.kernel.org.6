Return-Path: <linux-kernel+bounces-270646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192539442C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4361C2169C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E014A4F1;
	Thu,  1 Aug 2024 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsGBmNfj"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982B14A0A7;
	Thu,  1 Aug 2024 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722490676; cv=none; b=CFEBucovM8lZPoFPIfJtcMdF6qmz4Fcwl4hQkeHYEIwlJnaFTILr8quO1FB2hg+c3nkcx+thrQqPrtLdYG6kyKfwX4bjsUZGqkbxu1ACTnJbVUa4kOHYZryq96aNaxZnZaeXqnKKurpPRBxJ07HEvfRbNlOBjSNPMW0burDfgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722490676; c=relaxed/simple;
	bh=76hAJit1zg4VNyz5kDOBWkpcSIO1vBmc+rCBxJkh0C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isMh/329fgxY3gdv9eWvGWCjWpTU1jSU0mUKwla3wqqFRkKuDPtmt/Xx9hVLMVmavkolVmAn8gOmof2K4BZiCDNM3AzHUcOeOQFzUa+xTsG3gMTnoTqTwi9oGK/K2QWBAgupZbcCQMNSEsHGGeY5watTPjffJWnQQ6QrpVnZHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsGBmNfj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2b921c48so5141319b3a.1;
        Wed, 31 Jul 2024 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722490674; x=1723095474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqzCoAbFqxndP749YKSB5ePQejWzAj5lN8I2yJMHRQg=;
        b=dsGBmNfja9ezssAiHPQ7MOCVnZSuSOWlSlmCKseONZitb9/z1YUvzKCHVXguQPyS+n
         PWRaWvN058va6tjd42/1zVJDx19DYxY8aLWo8NQuetNH+1I2A1imjzfkbZOJbc9f5odH
         qQ5Qw6YwyrYZHiaS366Ewpc4WX/C17+pk7TepyF6RykyMltymhdplI8elhcjFuJ7iCcN
         AwKLVthHzZIaoLjTPxysqaRyOK8ROBQBiu+BMxdm7VdwvZdU+e392wctUHygibZF6ioh
         TLgAAu0MD/30qcJpNbtxEOeEpQRzOzQi1+KlyBIGwOT03D/aqD8ARnljM1kqiMURY9Mp
         VGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722490674; x=1723095474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqzCoAbFqxndP749YKSB5ePQejWzAj5lN8I2yJMHRQg=;
        b=JYRpT/LpKGA15TL4nXfceeL2txPvgHBb8kghHiTHUS4XYVxwsIrctBb936zWBKm5GP
         eloZ0DUWJzkBJWYiO9GGNWqiU0ZlLIX4dE32xMypbWaj+QlhIAvKce1q2nqzqMYQI8f3
         QbWMv7m1n67yhaj8bRpiV6P3eGXbMYvjn0GKu4rTJpiZ72iv/EpcA/Na9u5GsFM9HkIW
         e9BzABkjSEvUcyvIC415DcEk5IcSLG2a6j0c4SgdV6CGlnsiIfbldYCWbSigEh7AS9XM
         aiDl2pOUqpkUkDAoMdMpJA/ZJfMaBwBkY2W7ckxXWGfy7pu6sDSo6SX0ymhFoQheMTM+
         KmFg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8tkE1W2EHF5OTfCT4bTdjzlK3wNWS0VMjcQG63d+4y/9rMk2ol4CypextE0V8Wf4idNkeoLDtaneLLPwGsJn7kokprqafaJVtMOd0yEIIOuAKh2kOf/oTr9av4VG0B3SrP4ODn5R7w==
X-Gm-Message-State: AOJu0YzqJf19sf85SvVA6Ja4GVxqSw3f4futUM80p26np+zWSUgrEq41
	xz5VxnMgH0Ra/RGusG4VNbwVPbFw1zzaFbh9CrZI9VffNDre0Qp2
X-Google-Smtp-Source: AGHT+IFxMA0Y7t88x1vj2vjb2D3KYmjXT888McD9+5ksKpwc9UpwxY/nnkAwoZiGTOjop0aTNn/GdA==
X-Received: by 2002:a05:6a20:8418:b0:1c4:819f:8e0c with SMTP id adf61e73a8af0-1c68ce76a86mr2161740637.6.1722490673852;
        Wed, 31 Jul 2024 22:37:53 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72b89csm11106876b3a.94.2024.07.31.22.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:37:53 -0700 (PDT)
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
Subject: [PATCH v3 2/2] phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY
Date: Thu,  1 Aug 2024 05:37:44 +0000
Message-Id: <20240801053744.807884-3-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801053744.807884-1-hpchen0nvt@gmail.com>
References: <20240801053744.807884-1-hpchen0nvt@gmail.com>
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


