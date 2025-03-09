Return-Path: <linux-kernel+bounces-553141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF73A58470
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E04E189053B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED11F0991;
	Sun,  9 Mar 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3gZYpxu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B921F0982;
	Sun,  9 Mar 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527055; cv=none; b=bgZdZKniD2Z636PGMtM3/zIcROEMBDVZJAxaaKFNfhl+gOqyUU7Zd9YspS3nJ8s7Ar5prIfr56iUQf4oa6j0g9sNU7wutCj8yN3HQhxNEViDGQ7Ow/6fyIxCx7KW9X0BgwDZ/xPxFM4HEsA4SJAYsL2udFtpUgod+FeHKUUn57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527055; c=relaxed/simple;
	bh=hYsedMTN8nxZjUC3f95QGmrYzey1mMu49s0lZKgIfK4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9FrsPo1mwANyeiUcMVG+S/PQaTyxdBn04ig0j1Fw3wtPTO9TjR9kX7pzBZj3MoBDUVjNCg+ejllNJrMUNMCi2QVsghd2RvrmDy7eeERuPZiCg59XyWOfQ0VHdU5x8ZT7Nfu9sL3mLPbh08WT2ZPXxI5mAWDjhSNQiulYE0N1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3gZYpxu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913d45a148so777850f8f.3;
        Sun, 09 Mar 2025 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527051; x=1742131851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaDdHrFfN/cuId2Cj+ZtZ5wegXqwq61TDynErdHq3Vs=;
        b=e3gZYpxuVSH5LRGY90gT1/8UYn/twgldZedLJtXK4rhzKpcVPjaMMAdWQI91Z2fUNy
         nY4BJahRvdqcaW34xHxhXF7HhwEFeneNVUQ8BXFvR5wkh0zKlC16V3dM0TaBUQympZSL
         LzPqAfiC+Iwj8mhv1eevzkr/cumqIeAPA8F9Uu8XvRyeqXz04Y9/57ydVEzkSCDoagbH
         7wjn6o1I8HsHXBYNcqf9PssmK5VrwknQVp32ZEUupdQgsH7iYqRXw5W9JoPbwVFCSl0h
         YFBtEI/cVdEApwKpXFmSqOXWkr40JEPJHbd2Dxaqm+kOt8Tdf90dddgPztidQlExLf4k
         4Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527051; x=1742131851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaDdHrFfN/cuId2Cj+ZtZ5wegXqwq61TDynErdHq3Vs=;
        b=k/x5PkdIj4DmxUQQlF2kVDipKc87eVm89jrmMLcLmh5DhJJagy+uCqqfy64ynEoPZu
         Lp7xH/wRtJ63vfU1Poo0/P0AkggOl4MOwduuusU1WGEnnXfE5w2fUwaJWOJJuJcB/7Be
         zkQffB7ZHmlKfi6FhbTUCaoMH+EvnUxJXd5K+GHAlHOjRP1PxJfgyXTHIlc0GlxQGzUN
         nQ3YUn+whhjvSF9hFaaLX1vw9vdSG5i7yB6i6IMpifgPyY5kMtdddufDFiU3TPI9FZZX
         Fn8coI/CDaWy9UNeDR1DDRwZvwbIFCj9yMo44Fuc1UOgrnZPlln1vRYcYJLvkyinDwXG
         CeWg==
X-Forwarded-Encrypted: i=1; AJvYcCUa6xtfK69WMbOC4vKGnd9g8ryFPxd4MbLZdw2qH92OKolCspGrK/nBcEgk1dz61wHJAYhfQ6EhcBCq@vger.kernel.org, AJvYcCVxyJ9e9HtHDaFQzdAVg2qqkdGg3t7FFWfApGQBfn36ORM40rnmT30K/4/L+RWnlf8/G50VtlwKMb2Dron4@vger.kernel.org, AJvYcCX73Bk1GAdd0htXK9BnPyMDM8qvAWegMsa2hSD0SONhRDfkkhkUjNKIp5OzFghDZ+WkXR0vh/CJnF4K@vger.kernel.org, AJvYcCXCJ5Vy1AdrXgehUWqri7QEnYRDhqJpO+CIlZbxQc2LNUc1DuvKL4TtzmUBrlGaKF6BuIcOYFknIvvC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyf/a8nlK0un8azea0peND0aglQwH1uG3u/hIUupG+aWfixpow
	FDvTXqEIc9O2VQTvgEeJ4MDoTRS6EsX00RaibLqkKDn8YLa+kfMA
X-Gm-Gg: ASbGncsAItEjl/vdkg9VRHQxmaFbru7GbKWcnvmrozL3NyX9vrheU9vsZRk/1tm11VY
	1EIEDFvhyecCY+au7XGj3T9yDzrbJL9Er23qXs3ixwIxi7A+WXew1JO3L5jquPBlfZNCYSeQdx+
	PS3+3ew2sx3qtnFwQuX+XD2yeCuqANnLcT2a7tA1i6Udt2qS24xLYZ89onga95GW8buI4yrU9Pl
	qe4EiEacf+0o+Q8zlAV4PA/eY8cg0sdekwaQihp2dKb6JapccBoKtQuLrKH2MdIwzUE9Ki8nWq6
	JUiBo1bU7l+liqpNuXZH9WTLj73RsddxWKQCXgCL1XoJfCyfZNEe3a6gCba0UpgppTnghGv1kJ7
	WUcwH8nYm9ZD/Rg==
X-Google-Smtp-Source: AGHT+IEiSIK5016GDeMsMvzWNTkzBaWLO48BvAc2SsYBWNmLkvti3ZmfcW0CvOCphh/orfbgClUAaw==
X-Received: by 2002:a05:6000:1867:b0:390:f987:26a1 with SMTP id ffacd0b85a97d-39132d885bcmr5325580f8f.29.1741527051346;
        Sun, 09 Mar 2025 06:30:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 08/13] soc: airoha: add support for configuring SCU SSR Serdes port
Date: Sun,  9 Mar 2025 14:29:39 +0100
Message-ID: <20250309132959.19045-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring SCU SSR Serdes port. Airoha AN7581 SoC can
configure the different Serdes port by toggling bits in the SCU register
space.

Port Serdes mode are mutually exclusive, force example the USB2 Serdes port
can either used for USB 3.0 or PCIe 2 port. Enabling USB 3.0 makes the
PCIe 2 to not work.

The current supported Serdes port are:
- WiFi 1 and defaults to PCIe0 1 line mode
- Wifi 2 and defaults to PCIe1 1 line mode
- USB 1 and defaults to USB 3.0 mode
- USB 2 and defaults to USB 3.0 mode

WiFi 1, WiFi 2 and USB 1 also support a particular Ethernet mode that
can toggle between USXGMII or HSGMII mode (USB 1 only to HSGMII)
Such mode doesn't configure bits as specific Ethernet PCS driver will
take care of configuring the Serdes mode based on what is required.

This driver is to correctly setup these bits and provide an API to read
the current status of the Serdes port. Single driver can't independently
set the Serdes port mode as that would cause a conflict if someone
declare, for example, in DT (and enable) PCIe 2 port and USB2 3.0 port.

Drivers will use the airoha_scu_ssr_get_serdes_mode function and will
validate the Serdes port is the expected one and fail if it's not.

Each driver will have to define in DT the phandle airoha,scu-ssr
pointing to the SCU SSR node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/soc/Kconfig                       |   1 +
 drivers/soc/Makefile                      |   1 +
 drivers/soc/airoha/Kconfig                |  18 ++
 drivers/soc/airoha/Makefile               |   3 +
 drivers/soc/airoha/airoha-scu-ssr.c       | 195 ++++++++++++++++++++++
 include/linux/soc/airoha/airoha-scu-ssr.h |  17 ++
 include/linux/soc/soc/airoha-scu-ssr.h    |  17 ++
 8 files changed, 253 insertions(+)
 create mode 100644 drivers/soc/airoha/Kconfig
 create mode 100644 drivers/soc/airoha/Makefile
 create mode 100644 drivers/soc/airoha/airoha-scu-ssr.c
 create mode 100644 include/linux/soc/airoha/airoha-scu-ssr.h
 create mode 100644 include/linux/soc/soc/airoha-scu-ssr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9944845ae9f5..fe34c80b8d52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -741,6 +741,7 @@ M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
+F:	drivers/soc/airoha/airoha-scu-ssr.c
 F:	include/dt-bindings/soc/airoha,scu-ssr.h
 
 AIROHA SPI SNFI DRIVER
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 6a8daeb8c4b9..21bacefd2e06 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/airoha/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2037a8695cb2..4338730af0aa 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_ARCH_AIROHA)	+= airoha/
 obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
diff --git a/drivers/soc/airoha/Kconfig b/drivers/soc/airoha/Kconfig
new file mode 100644
index 000000000000..56c677f8238d
--- /dev/null
+++ b/drivers/soc/airoha/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config AIROHA_SCU_SSR
+	tristate "Airoha SCU SSR Driver"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
+	help
+	  Say 'Y' here to add support for Airoha SCU SSR driver.
+
+	  Airoha SoC pheriperal (like USB/PCIe/Ethernet port) are
+	  selected by toggling specific bit. Serdes Port line
+	  are mutually exclusive such as selecting PCIe port 2
+	  disable support for USB port 2 3.0 mode.
+
+	  This driver is used to configure such bit and expose
+	  an API to read the current status from a user of such
+	  Serdes lines.
+
diff --git a/drivers/soc/airoha/Makefile b/drivers/soc/airoha/Makefile
new file mode 100644
index 000000000000..530825251ae9
--- /dev/null
+++ b/drivers/soc/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AIROHA_SCU_SSR)		+= airoha-scu-ssr.o
diff --git a/drivers/soc/airoha/airoha-scu-ssr.c b/drivers/soc/airoha/airoha-scu-ssr.c
new file mode 100644
index 000000000000..fe65b5b91146
--- /dev/null
+++ b/drivers/soc/airoha/airoha-scu-ssr.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <dt-bindings/soc/airoha,scu-ssr.h>
+#include <linux/bitfield.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/soc/airoha/airoha-scu-ssr.h>
+
+#define AIROHA_SCU_PCIC			0x88
+#define   AIROHA_SCU_PCIE_2LANE_MODE	BIT(14)
+
+#define AIROHA_SCU_SSR3			0x94
+#define   AIROHA_SCU_SSUSB_HSGMII_SEL	BIT(29)
+
+#define AIROHA_SCU_SSTR			0x9c
+#define   AIROHA_SCU_PCIE_XSI0_SEL	GENMASK(14, 13)
+#define   AIROHA_SCU_PCIE_XSI0_SEL_PCIE	FIELD_PREP_CONST(AIROHA_SCU_PCIE_XSI0_SEL, 0x0)
+#define   AIROHA_SCU_PCIE_XSI1_SEL	GENMASK(12, 11)
+#define   AIROHA_SCU_PCIE_XSI1_SEL_PCIE	FIELD_PREP_CONST(AIROHA_SCU_PCIE_XSI0_SEL, 0x0)
+#define   AIROHA_SCU_USB_PCIE_SEL	BIT(3)
+
+struct airoha_scu_ssr_priv {
+	struct device *dev;
+	struct regmap *regmap;
+
+	u32 serdes_port[AIROHA_SCU_MAX_SERDES_PORT];
+};
+
+int airoha_scu_ssr_get_serdes_mode(struct device *dev,
+				   enum airoha_scu_serdes_port port)
+{
+	struct airoha_scu_ssr_priv *priv;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "airoha,scu-ssr", 0);
+	if (!np)
+		return -ENODEV;
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev || !platform_get_drvdata(pdev)) {
+		if (pdev)
+			put_device(&pdev->dev);
+		return -EPROBE_DEFER;
+	}
+
+	priv = platform_get_drvdata(pdev);
+
+	return priv->serdes_port[port];
+}
+EXPORT_SYMBOL_GPL(airoha_scu_ssr_get_serdes_mode);
+
+static int airoha_scu_ssr_apply_modes(struct airoha_scu_ssr_priv *priv)
+{
+	int ret;
+
+	/*
+	 * This is a very bad scenario and needs to be correctly warned
+	 * as it cause PCIe malfunction
+	 */
+	if ((priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SSR_WIFI1_PCIE0_2LINE &&
+	     priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] != AIROHA_SCU_SSR_WIFI2_PCIE0_2LINE) ||
+	    (priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] != AIROHA_SCU_SSR_WIFI1_PCIE0_2LINE &&
+	     priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] == AIROHA_SCU_SSR_WIFI2_PCIE0_2LINE)) {
+		WARN(true, "Wrong Serdes configuration for PCIe0 2 Line mode. Please check DT.\n");
+		return -EINVAL;
+	}
+
+	/* PCS driver takes case of setting the SCU bit for HSGMII or USXGMII */
+	if (priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SSR_WIFI1_PCIE0_2LINE ||
+	    priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SSR_WIFI1_PCIE0) {
+		ret = regmap_update_bits(priv->regmap, AIROHA_SCU_SSTR,
+					 AIROHA_SCU_PCIE_XSI0_SEL,
+					 AIROHA_SCU_PCIE_XSI0_SEL_PCIE);
+		if (ret)
+			return ret;
+	}
+
+	/* PCS driver takes case of setting the SCU bit for HSGMII or USXGMII */
+	if (priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] == AIROHA_SCU_SSR_WIFI2_PCIE0_2LINE ||
+	    priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] == AIROHA_SCU_SSR_WIFI2_PCIE1) {
+		ret = regmap_update_bits(priv->regmap, AIROHA_SCU_SSTR,
+					 AIROHA_SCU_PCIE_XSI1_SEL,
+					 AIROHA_SCU_PCIE_XSI1_SEL_PCIE);
+		if (ret)
+			return ret;
+	}
+
+	/* Toggle PCIe0 2 Line mode if enabled or not */
+	if (priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SSR_WIFI1_PCIE0_2LINE)
+		ret = regmap_set_bits(priv->regmap, AIROHA_SCU_PCIC,
+				      AIROHA_SCU_PCIE_2LANE_MODE);
+	else
+		ret = regmap_clear_bits(priv->regmap, AIROHA_SCU_PCIC,
+					AIROHA_SCU_PCIE_2LANE_MODE);
+	if (ret)
+		return ret;
+
+	if (priv->serdes_port[AIROHA_SCU_SERDES_USB1] == AIROHA_SCU_SSR_USB1_ETHERNET)
+		ret = regmap_clear_bits(priv->regmap, AIROHA_SCU_SSR3,
+					AIROHA_SCU_SSUSB_HSGMII_SEL);
+	else
+		ret = regmap_set_bits(priv->regmap, AIROHA_SCU_SSR3,
+				      AIROHA_SCU_SSUSB_HSGMII_SEL);
+	if (ret)
+		return ret;
+
+	if (priv->serdes_port[AIROHA_SCU_SERDES_USB2] == AIROHA_SCU_SSR_USB2_PCIE2)
+		ret = regmap_clear_bits(priv->regmap, AIROHA_SCU_SSTR,
+					AIROHA_SCU_USB_PCIE_SEL);
+	else
+		ret = regmap_set_bits(priv->regmap, AIROHA_SCU_SSTR,
+				      AIROHA_SCU_USB_PCIE_SEL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int airoha_scu_ssr_probe(struct platform_device *pdev)
+{
+	struct airoha_scu_ssr_priv *priv;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	/* Get regmap from MFD */
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return -EINVAL;
+
+	/* If not set, default to PCIE0 1 line */
+	if (of_property_read_u32(dev->of_node, "airoha,serdes-wifi1",
+				 &priv->serdes_port[AIROHA_SCU_SERDES_WIFI1]))
+		priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] = AIROHA_SCU_SSR_WIFI1_PCIE0;
+
+	/* If not set, default to PCIE1 1 line */
+	if (of_property_read_u32(dev->of_node, "airoha,serdes-wifi2",
+				 &priv->serdes_port[AIROHA_SCU_SERDES_WIFI2]))
+		priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] = AIROHA_SCU_SSR_WIFI2_PCIE1;
+
+	/* If not set, default to USB1 USB 3.0 */
+	if (of_property_read_u32(dev->of_node, "airoha,serdes-usb1",
+				 &priv->serdes_port[AIROHA_SCU_SERDES_USB1]))
+		priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] = AIROHA_SCU_SSR_USB1_USB;
+
+	/* If not set, default to USB2 USB 3.0 */
+	if (of_property_read_u32(dev->of_node, "airoha,serdes-usb2",
+				 &priv->serdes_port[AIROHA_SCU_SERDES_USB2]))
+		priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] = AIROHA_SCU_SSR_USB2_USB;
+
+	ret = airoha_scu_ssr_apply_modes(priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static const struct of_device_id airoha_phy_id_table[] = {
+	{ .compatible = "airoha,an7581-scu-ssr" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, airoha_phy_id_table);
+
+static struct platform_driver airoha_scu_ssr_driver = {
+	.probe		= airoha_scu_ssr_probe,
+	.driver		= {
+		.name	= "airoha-scu-ssr",
+		.of_match_table = airoha_phy_id_table,
+	},
+};
+
+module_platform_driver(airoha_scu_ssr_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Airoha SCU SSR/STR driver");
diff --git a/include/linux/soc/airoha/airoha-scu-ssr.h b/include/linux/soc/airoha/airoha-scu-ssr.h
new file mode 100644
index 000000000000..d5ff50dc224f
--- /dev/null
+++ b/include/linux/soc/airoha/airoha-scu-ssr.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __AIROHA_SCU_SSR__
+#define __AIROHA_SCU_SSR__
+
+enum airoha_scu_serdes_port {
+	AIROHA_SCU_SERDES_WIFI1 = 0,
+	AIROHA_SCU_SERDES_WIFI2,
+	AIROHA_SCU_SERDES_USB1,
+	AIROHA_SCU_SERDES_USB2,
+
+	AIROHA_SCU_MAX_SERDES_PORT,
+};
+
+int airoha_scu_ssr_get_serdes_mode(struct device *dev,
+				   enum airoha_scu_serdes_port port);
+
+#endif
diff --git a/include/linux/soc/soc/airoha-scu-ssr.h b/include/linux/soc/soc/airoha-scu-ssr.h
new file mode 100644
index 000000000000..d5ff50dc224f
--- /dev/null
+++ b/include/linux/soc/soc/airoha-scu-ssr.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __AIROHA_SCU_SSR__
+#define __AIROHA_SCU_SSR__
+
+enum airoha_scu_serdes_port {
+	AIROHA_SCU_SERDES_WIFI1 = 0,
+	AIROHA_SCU_SERDES_WIFI2,
+	AIROHA_SCU_SERDES_USB1,
+	AIROHA_SCU_SERDES_USB2,
+
+	AIROHA_SCU_MAX_SERDES_PORT,
+};
+
+int airoha_scu_ssr_get_serdes_mode(struct device *dev,
+				   enum airoha_scu_serdes_port port);
+
+#endif
-- 
2.48.1


