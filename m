Return-Path: <linux-kernel+bounces-569728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A36A6A6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20F2468809
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36F22333B;
	Thu, 20 Mar 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObNATAyA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDA1EF394;
	Thu, 20 Mar 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475699; cv=none; b=hYQItSsEffN3H/YdvNsdZk7RQnsV53ArsHt7kTYLZlBHadSF78fM5LSyT8GPR6Nrfr1ezbmBrHVikAG26drJQe5/ppfOD2O1MLBJ7D2hJenkswnbBnTqF0t/76T5zKGjFlnFNJFvhZX33f8IximTB6xJ7q/Q9QerU93O2iqskFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475699; c=relaxed/simple;
	bh=0EZqnwaI95aFbRnl2/HUehmQ5Ei/YcL3ym12ODksvCg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6KJjwrFFF599SrqHH7U7REtuiveLz/DFfOWu+ncheEBs1ElHT7mzqawM6x3MJEqoZ/46wwq+22lJL1yuagCzBFeYk9pGi7bkuxE+kdfH05l7I/Xzrv4MAkORPgueb36tQfMNzvPhBx3AhztZJbGpQyRADSnMPwPZTXOmRpSR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObNATAyA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0782d787so5289735e9.0;
        Thu, 20 Mar 2025 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475695; x=1743080495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn2/hmuc3pnGhw1oNI9gcjxThAXzwvaMI5eUiGxYDOA=;
        b=ObNATAyAA+M7fSkttXcM1IRpcTrBRzxJOhicNwQ/S7hy0E+3Cllj0acqbloJEutXUH
         cKkbaRzli7PemZ0Wa3c0hnrD7j00HPm6zqWwNWxW8pFw8ge61qX8C2yxadxzUuizTk77
         D09rqmwHAWSI5JVGmINW3T9HSemjMHpmNyNO7zgYCz1DDNsHG3xDP/JtbppfKBnFWWjg
         tCD5Y5jEnUHx0Ryacntiwud+mBY+dH7PVPfwUqXMNNhhm+0r4ZpAyb5hs4AGjLFGFt1T
         pXVVFvSn/FM4y62ZEHjBpOF6yDaZ3AbuKpIhgjtKcQRwqOHVNggAyNsdPvMcOZCre0U8
         e/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475695; x=1743080495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn2/hmuc3pnGhw1oNI9gcjxThAXzwvaMI5eUiGxYDOA=;
        b=nm649JGZPS1RgoBi/K5ORaGG0Rz/GKscEFBgWQ2s2I1JzlwGlWPUHZdYxBgNPk/srp
         JKEoO6KCe7Yw+9bVgDATnD+oUpUl9c2UfKz8X60lgSoRuEwAjH8fJBfPmaZsQj2XtCH3
         GYOJ4tgM8mveaXz9EN3bAiBeGkzmJqKt+xopxLgw8+mz8ukKFs4OIsYtQObx/Eb7szzR
         BlcuUkkYQKv2EpovuxncVxltUFiHwODHwjYuaXirIdqyipX9JiD9VI+DtWWjuiJT6KKw
         BMRUquiiu6Q2nYY2U8ZQ7aaD2hugTL7rFWD95YuMTkjvsYOjwLObDZukTB6xaomgZYW1
         lWgw==
X-Forwarded-Encrypted: i=1; AJvYcCWwBtMYeiYTPedMSJj8XnKUjY/UQZlKJ+Gs4Xh8uCe9KaZhUJJIe0cebMFisz4GU2uiJXZY07PhO35M@vger.kernel.org, AJvYcCX00tOcynDWADYvL4T1s4xzIWw7O6GPR7orJhgnKNMOGwV7y8OkN1yX2U8igyVYJ8xf2fRDgMces6sPvsCR@vger.kernel.org, AJvYcCXuwkPSLeY0GlzcXNisA2EAGf3/blolFsSg4cBhEPuMvQdu2NoItKPTqiMr6uc/pqjIry6UK6P+PDgm@vger.kernel.org, AJvYcCXydeNOMGHXQd94Sq/npgVdjpvuWzjJ6pNmR9mPPYaozt1sS2Z7TRE2Ik/cy/4zGBsoCpeGkjzRf+Qu@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYZ/9n+HZTBMR2YujzXZ2+0837tjC5idfArX1xXOlX63GdHKg
	RF/ih3vz+RF7qStEfbpcYvwWMMLlHLIlEZShHMcF4jy5eLjFNG5h
X-Gm-Gg: ASbGncstMxvON8V8PAN6dDxLVMPAvc3Cks9ai94ygIuB3HvDGaJpghrLLhQ3521whyz
	KM8IROUaSPqlc7xUOJ4IgzLa0zS3MbfJzjv8wWUq4nuIae7V+XPZ2paAPB8S/x37sxhdNJ0utY6
	kJhSZI4tFGjjrnaXWTbE8i+LM0WBkdgdy7sWS6xaJTtOFHsLIun1fd/m5IFPDp8DXw6nDvQfM0j
	LaMGbis63DRT4n6jXa/kl1FrIx2tyHAANee9C2mQ4RbdBVyLForhvrOEkdzu8MaOhVzBX/oUVJp
	FfHbXELlMuy90SST8Y5QIyjpu9K0d6cBDdByT9GkV95D9KGjIYMw1ji+l7IekMT0ow8grF23T69
	n662sGPOFbuYpE1z/M0vh9Cx2
X-Google-Smtp-Source: AGHT+IGi5vCdtEa2LCRHJP2raJyvd24trrbEgKD5KtNz8cQAFgw+tCXFVtwNUxD1X7czDtnEosU6xQ==
X-Received: by 2002:a5d:5f4b:0:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-399795a4fc2mr2851317f8f.3.1742475694722;
        Thu, 20 Mar 2025 06:01:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
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
Subject: [PATCH v2 04/11] soc: airoha: add support for configuring SCU SSR Serdes port
Date: Thu, 20 Mar 2025 14:00:27 +0100
Message-ID: <20250320130054.4804-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
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

This driver is to correctly setup these bits.
Single driver can't independently set the Serdes port mode as that
would cause a conflict if someone declare, for example, in DT
(and enable) PCIe 2 port and USB2 3.0 port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                               |   2 +
 drivers/soc/Kconfig                       |   1 +
 drivers/soc/Makefile                      |   1 +
 drivers/soc/airoha/Kconfig                |  18 ++
 drivers/soc/airoha/Makefile               |   3 +
 drivers/soc/airoha/airoha-scu-ssr.c       | 221 ++++++++++++++++++++++
 include/linux/soc/airoha/airoha-scu-ssr.h |  23 +++
 7 files changed, 269 insertions(+)
 create mode 100644 drivers/soc/airoha/Kconfig
 create mode 100644 drivers/soc/airoha/Makefile
 create mode 100644 drivers/soc/airoha/airoha-scu-ssr.c
 create mode 100644 include/linux/soc/airoha/airoha-scu-ssr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9944845ae9f5..7cd54c70aeed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -741,7 +741,9 @@ M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
+F:	drivers/soc/airoha/airoha-scu-ssr.c
 F:	include/dt-bindings/soc/airoha,scu-ssr.h
+F:	include/linux/soc/airoha/airoha-scu-ssr.h
 
 AIROHA SPI SNFI DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
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
index 2037a8695cb2..2b4027837d60 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-y				+= airoha/
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
index 000000000000..29e17577e9a4
--- /dev/null
+++ b/drivers/soc/airoha/airoha-scu-ssr.c
@@ -0,0 +1,221 @@
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
+#define AIROHA_SCU_MAX_SERDES_PORT	4
+
+struct airoha_scu_ssr_priv {
+	struct device *dev;
+	struct regmap *regmap;
+
+	unsigned int serdes_port[AIROHA_SCU_MAX_SERDES_PORT];
+};
+
+static const char * const airoha_scu_serdes_mode_to_str[] = {
+	[AIROHA_SCU_SERDES_MODE_PCIE0_X1] = "pcie0_x1",
+	[AIROHA_SCU_SERDES_MODE_PCIE0_X2] = "pcie0_x2",
+	[AIROHA_SCU_SERDES_MODE_PCIE1_X1] = "pcie1_x1",
+	[AIROHA_SCU_SERDES_MODE_PCIE2_X1] = "pcie2_x1",
+	[AIROHA_SCU_SERDES_MODE_USB3] = "usb3",
+	[AIROHA_SCU_SERDES_MODE_ETHERNET] = "ethernet",
+};
+
+static int airoha_scu_serdes_str_to_mode(const char *serdes_str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(airoha_scu_serdes_mode_to_str); i++)
+		if (!strncmp(serdes_str, airoha_scu_serdes_mode_to_str[i],
+			     strlen(airoha_scu_serdes_mode_to_str[i])))
+			return i;
+
+	return -EINVAL;
+}
+
+static int airoha_scu_ssr_apply_modes(struct airoha_scu_ssr_priv *priv)
+{
+	int ret;
+
+	/*
+	 * This is a very bad scenario and needs to be correctly warned
+	 * as it cause PCIe malfunction.
+	 */
+	if ((priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SERDES_MODE_PCIE0_X2 &&
+	     priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] != AIROHA_SCU_SERDES_MODE_PCIE0_X2) ||
+	    (priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] != AIROHA_SCU_SERDES_MODE_PCIE0_X2 &&
+	     priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] == AIROHA_SCU_SERDES_MODE_PCIE0_X2)) {
+		WARN(true, "Wrong Serdes configuration for PCIe0 2 Line mode. Please check DT.\n");
+		return -EINVAL;
+	}
+
+	/* PCS driver takes care of setting the SCU bit for HSGMII or USXGMII */
+	if (priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SERDES_MODE_PCIE0_X1 ||
+	    priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SERDES_MODE_PCIE0_X2) {
+		ret = regmap_update_bits(priv->regmap, AIROHA_SCU_SSTR,
+					 AIROHA_SCU_PCIE_XSI0_SEL,
+					 AIROHA_SCU_PCIE_XSI0_SEL_PCIE);
+		if (ret)
+			return ret;
+	}
+
+	/* PCS driver takes care of setting the SCU bit for HSGMII or USXGMII */
+	if (priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] == AIROHA_SCU_SERDES_MODE_PCIE1_X1 ||
+	    priv->serdes_port[AIROHA_SCU_SERDES_WIFI2] == AIROHA_SCU_SERDES_MODE_PCIE0_X2) {
+		ret = regmap_update_bits(priv->regmap, AIROHA_SCU_SSTR,
+					 AIROHA_SCU_PCIE_XSI1_SEL,
+					 AIROHA_SCU_PCIE_XSI1_SEL_PCIE);
+		if (ret)
+			return ret;
+	}
+
+	/* Toggle PCIe0 2 Line mode if enabled or not */
+	if (priv->serdes_port[AIROHA_SCU_SERDES_WIFI1] == AIROHA_SCU_SERDES_MODE_PCIE0_X2)
+		ret = regmap_set_bits(priv->regmap, AIROHA_SCU_PCIC,
+				      AIROHA_SCU_PCIE_2LANE_MODE);
+	else
+		ret = regmap_clear_bits(priv->regmap, AIROHA_SCU_PCIC,
+					AIROHA_SCU_PCIE_2LANE_MODE);
+	if (ret)
+		return ret;
+
+	if (priv->serdes_port[AIROHA_SCU_SERDES_USB1] == AIROHA_SCU_SERDES_MODE_ETHERNET)
+		ret = regmap_clear_bits(priv->regmap, AIROHA_SCU_SSR3,
+					AIROHA_SCU_SSUSB_HSGMII_SEL);
+	else
+		ret = regmap_set_bits(priv->regmap, AIROHA_SCU_SSR3,
+				      AIROHA_SCU_SSUSB_HSGMII_SEL);
+	if (ret)
+		return ret;
+
+	if (priv->serdes_port[AIROHA_SCU_SERDES_USB2] == AIROHA_SCU_SERDES_MODE_PCIE2_X1)
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
+static int airoha_scu_ssr_parse_mode(struct device *dev,
+				     struct airoha_scu_ssr_priv *priv,
+				     const char *property_name, unsigned int port,
+				     unsigned int default_mode)
+{
+	const struct airoha_scu_ssr_serdes_info *port_info;
+	const struct airoha_scu_ssr_data *pdata;
+	const char *serdes_mode;
+	int mode, i;
+
+	pdata = dev->platform_data;
+
+	if (of_property_read_string(dev->of_node, property_name,
+				    &serdes_mode)) {
+		priv->serdes_port[port] = default_mode;
+		return 0;
+	}
+
+	mode = airoha_scu_serdes_str_to_mode(serdes_mode);
+	if (mode) {
+		dev_err(dev, "invalid mode %s for %s\n", serdes_mode, property_name);
+		return mode;
+	}
+
+	port_info = &pdata->ports_info[port];
+	for (i = 0; i < port_info->num_modes; i++) {
+		if (port_info->possible_modes[i] == mode) {
+			priv->serdes_port[port] = mode;
+			return 0;
+		}
+	}
+
+	dev_err(dev, "mode %s not supported for %s", serdes_mode, property_name);
+	return -EINVAL;
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
+	ret = airoha_scu_ssr_parse_mode(dev, priv, "airoha,serdes-wifi1",
+					AIROHA_SCU_SERDES_WIFI1,
+					AIROHA_SCU_SERDES_MODE_PCIE0_X1);
+	if (ret)
+		return ret;
+
+	ret = airoha_scu_ssr_parse_mode(dev, priv, "airoha,serdes-wifi2",
+					AIROHA_SCU_SERDES_WIFI2,
+					AIROHA_SCU_SERDES_MODE_PCIE1_X1);
+	if (ret)
+		return ret;
+
+	ret = airoha_scu_ssr_parse_mode(dev, priv, "airoha,serdes-usb1",
+					AIROHA_SCU_SERDES_USB1,
+					AIROHA_SCU_SERDES_MODE_USB3);
+	if (ret)
+		return ret;
+
+	ret = airoha_scu_ssr_parse_mode(dev, priv, "airoha,serdes-usb2",
+					AIROHA_SCU_SERDES_USB2,
+					AIROHA_SCU_SERDES_MODE_USB3);
+	if (ret)
+		return ret;
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
+static struct platform_driver airoha_scu_ssr_driver = {
+	.probe		= airoha_scu_ssr_probe,
+	.driver		= {
+		.name	= "airoha-scu-ssr",
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
index 000000000000..0224c0340b6d
--- /dev/null
+++ b/include/linux/soc/airoha/airoha-scu-ssr.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __AIROHA_SCU_SSR__
+#define __AIROHA_SCU_SSR__
+
+enum airoha_scu_serdes_modes {
+	AIROHA_SCU_SERDES_MODE_PCIE0_X1,
+	AIROHA_SCU_SERDES_MODE_PCIE0_X2,
+	AIROHA_SCU_SERDES_MODE_PCIE1_X1,
+	AIROHA_SCU_SERDES_MODE_PCIE2_X1,
+	AIROHA_SCU_SERDES_MODE_USB3,
+	AIROHA_SCU_SERDES_MODE_ETHERNET,
+};
+
+struct airoha_scu_ssr_serdes_info {
+	unsigned int *possible_modes;
+	unsigned int num_modes;
+};
+
+struct airoha_scu_ssr_data {
+	const struct airoha_scu_ssr_serdes_info *ports_info;
+};
+
+#endif
-- 
2.48.1


