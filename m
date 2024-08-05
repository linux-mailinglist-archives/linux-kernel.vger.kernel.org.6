Return-Path: <linux-kernel+bounces-274126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352899473B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1781F215D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540613D52A;
	Mon,  5 Aug 2024 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6esfkkW"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984E1420B6;
	Mon,  5 Aug 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827048; cv=none; b=cgQ92UOOqxxqeY7La8wp+M/dIvZiUAQrE8lvFvjXbz1hVXJZt1EpFjUshIvQeFskl1lb58cT+PSTuTlYAHu8zANxKs5wfagq0uILxERcK0RWwimbqWXFdu0LPjdP5hQU03CqEr5khKEO0ic+xj2WCkkNLLlU6JqJ9CEK49zTrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827048; c=relaxed/simple;
	bh=W9UOOtLySbVo/NEkp2CMUFee0Fco2apR9akamOFnJEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7GvAA8sSdxy2tubOdw7exBk5XbqPHBhGmTJPibKI9xbVxa+XjgG4onHKERcnLFL+UKFMg5P3ENbVZtpt+VmzWOHFUnnlas74iJEi6x9sXZ+E1c9XwlsGOKXApjPFvDBx/viZdmXXvnawCwHXhhPbOkC1Ne6pU44u4ExOLz+2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6esfkkW; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5cbe88f70so5209011eaf.0;
        Sun, 04 Aug 2024 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722827046; x=1723431846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAbPwKJdQGrXjaHrRhnCDIdQ5p2U56KnZGlBziPC/Bg=;
        b=C6esfkkWk/kv4lnfIFz2FoCGqVplTuoHYRoREk/3WYt6Y7ctGBCgRZJHlisRi3BD23
         gxjcnL1lDbL1iPEpEkiC2SWamdfofUZATuSfNN8RcAsxQRBPGuuDV3koV4autmDqiRXJ
         jZeSaRVrKMtKW+GgpDqYlPH/f9dQbnLN1H8TLjhA1atOCLCLEe4g54H7WX5nF2VZ5kHv
         q72Dbr8gCt8L48+iGsPsRSHWDyFJaoipUYh+l91Vh+F/5flPhAko+NCp854cFh/QCMZT
         ueQt8h9G8yVIBd8LXJ30vCK3yhVrouWQ9AA5ohprG8uL0R3Cmd4dlrA6pm0nXHwBuY62
         Fvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722827046; x=1723431846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAbPwKJdQGrXjaHrRhnCDIdQ5p2U56KnZGlBziPC/Bg=;
        b=TfwTr1U44ZWhxbhs0ZTxdKWXE5go91oNp3MRQOWlfBbs4ZABucYVB5ECYedzNl+lPi
         VZfWW4WqEjbXcfCRTflpKELlpkYVnr9OARtRkWCNTpQCmqypO27Q8HrFireM8xbvxGrd
         z/PLrUFyxNyMbTvKo5YlRr33W8lKp6gDl0qtdr4uk+pAZlxabjtV5WZxmwMwxj9DTgud
         y2uTQWIsc3zwe9cT4OlCDecZs3mOt47zx1BPPPer/fCcrhJKMbvjhD1Yd1PhZuaw7MG1
         pI9xYsvYIgNGKbf4cCAY9yVKpz3/YAN3Ji/rmsT+CO8/zqq9AKIqqHWGmuvVwaA4JUR4
         I+3w==
X-Forwarded-Encrypted: i=1; AJvYcCUy1eiGVgCTcdbFxNuKkobdRD4OGt22/GpQ8TzWTIhd4TsjsLShJxcRlX0T7H9OuU64i7tTE7QQx/fubg7r1w5CVOgt5QAokP/i3nAuQaCtTIbzWAgrSzJJt2xbCo+yEbJ3MojVRdD6Og==
X-Gm-Message-State: AOJu0Yzh66M7rFLdrARcpeV9oLIAjW7gS0/OBCD/pt7Ft+R7TSwEdwIW
	3GIYbOmg0uZ9xIOc99oMpFjjqNsCKBzyq+2XPZ5WxVvlX78FGrCT
X-Google-Smtp-Source: AGHT+IGG1gxEm3Dz4wQsDDUZdXL2OCBe7HuFHYG2eHs7DJ1elGfTIfqPztENr68cPDQNq6IA+Qj1zA==
X-Received: by 2002:a05:6358:418f:b0:19f:4c24:d9ad with SMTP id e5c5f4694b2df-1af3baa43cfmr1130804255d.24.1722827045718;
        Sun, 04 Aug 2024 20:04:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c2dasm3823210a12.8.2024.08.04.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 20:04:05 -0700 (PDT)
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
Subject: [PATCH v4 2/2] phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY
Date: Mon,  5 Aug 2024 03:03:56 +0000
Message-Id: <20240805030356.14565-3-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805030356.14565-1-hpchen0nvt@gmail.com>
References: <20240805030356.14565-1-hpchen0nvt@gmail.com>
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
 drivers/phy/nuvoton/phy-ma35d1-usb2.c | 143 ++++++++++++++++++++++++++
 5 files changed, 161 insertions(+)
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
index 000000000000..9a459b700ed4
--- /dev/null
+++ b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
@@ -0,0 +1,143 @@
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
+		ret = regmap_read_poll_timeout(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, val,
+						val & PHY0DEVCKSTB, 10, 1000);
+		if (ret == 0)
+			return 0;
+	}
+
+	/*
+	 * reset USB PHY0.
+	 * wait until USB PHY0 60 MHz UTMI Interface Clock ready
+	 */
+	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, (PHY0POR | PHY0SUSPEND));
+	udelay(20);
+
+	/* make USB PHY0 enter operation mode */
+	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, PHY0SUSPEND);
+
+	/* make sure USB PHY 60 MHz UTMI Interface Clock ready */
+	ret = regmap_read_poll_timeout(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, val,
+					val & PHY0DEVCKSTB, 10, 1000);
+	if (ret == -ETIMEDOUT) {
+		dev_err(p_phy->dev, "Check PHY clock, Timeout: %d\n", ret);
+		clk_disable_unprepare(p_phy->clk);
+		return ret;
+	}
+
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
+MODULE_AUTHOR("Hui-Ping Chen <hpchen0nvt@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1


