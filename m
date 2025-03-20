Return-Path: <linux-kernel+bounces-569729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C5A6A6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4AA19C1402
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0BC215078;
	Thu, 20 Mar 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4FLI1S9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9E221579;
	Thu, 20 Mar 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475703; cv=none; b=We6hc6LUDTqygWi3YLT/b3ethRKep+pnjdZnCPJMGP5RfqeyMPckeIqtmpz63gsFF/1ceOS0zi3Ito8x+sJlKEjMeUqZyktmmygYQ+ZV9LDmzR1m7lGQgV/lRXUv7ahVImAcpky9gCuXbWAfSUF0RWZS7Nze7sQcQyTjda7sutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475703; c=relaxed/simple;
	bh=d0tHzSSFj28HQip87onzpIuXRBqASmUnGwfA6/BzQCw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnS2Ee+dCnzqESjLpwnJbLpEXGHSQaeALqtiFPVZR8QMuWZnsQ4AT7NemnmChGvMWOBJkuG31bjWAXx+wknIje2MVgbcuNP0e72wexHdRiY/YwboR3hyJq/5XfvhR+Ksdi8kH+HPScU54oqQSCPoCol/jkemwMTDg/NiQv8tb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4FLI1S9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc148so442343f8f.2;
        Thu, 20 Mar 2025 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475699; x=1743080499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjXZXNCMR7AMS8CMSFsXOaQrfC4KYnxI7xnrEz3bVbs=;
        b=F4FLI1S9/pD2+yxcgFPI8olC4ABnTbxO/gxcUnhy7vbdoujW0q8qV1MsRwkrl7jq9J
         EcBj2hP0x1/6m8AcG7VfjaIoTT3NvUTccu8zU1atP7SnEyRzx/e4ukgBUb1ShJXcmsMJ
         YNArmJ0uziqhO2zgQCAbaGVLHB+D0ljRKATddX+L09QEN9sYfaJBxXM9Ra7u2mGZWvhN
         2itjDVegxIcd70JbWo4dabLcLbGIt6l5Y5CfkjgBSTWI4h39xDW65Aib9CQe5KB0gG90
         /ofRuzbwJF85rMUMrnqH2lK4i+oVshsS+T7nwxzOgI72/bfD1aUNvhm/OW9eQXIkzYlg
         T7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475699; x=1743080499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjXZXNCMR7AMS8CMSFsXOaQrfC4KYnxI7xnrEz3bVbs=;
        b=kzYupTkSr/+PTxVhGDKsgdfB8plZgJomWgtJ0hPS0hFhBzFbvCDMDrJwxKKGNdPReM
         AZqgZoZMfEtu4V8rn96iLY//ZWT0KvuV2i6TVXzmhvfy3FMBBcbVg+sgPLiprwlZOyvD
         Q4r/ApTzqDklhWRhF9kWZ6zKOW+xFtfNtyLC/jfFg+xyKcqpIEvFdGuiM1Zz65TE4RAF
         hO2+ol2iszgLwRjU/1UDBqvgO+xVh1sNwDjcLU/OvS96zmYIlySReNZKJB8kD2WBsj6D
         qZRBHIvEgvrE+Dk4mcEmZaa0ksn1Sl98Ktg7L42AU35w5D2/nIgBetxy3tHwsUhoGwzP
         w1vw==
X-Forwarded-Encrypted: i=1; AJvYcCVCV2RyudyEPCdzZNE+NOo7bqbT7eTIyKf+VwHE9IMKXk2dqnAKVHiprbTGNyHpBPFbXIW33eJmD5hq@vger.kernel.org, AJvYcCWrxvpduNsITsn+kb4K3P0+fqDNbyA+zUlwuMa0uN8eTDYH0n6Xc1TTZZu62D0CZO1ws59PSx7IXmg/@vger.kernel.org, AJvYcCX1QVnqwnX3jbc956PPAdEzCJ4UHTDuAPC1/WgbSgYSvOayq6S5F/5B3tlMoMdXV6AXUtxfC91vu0nP@vger.kernel.org, AJvYcCXHq7QxSKoo2aR4XkWJsxrRurHRo8EwBixz3qufWVR+4xzABTNdB0ONSij5pPosQWXSIU+m8JQB4aGAweYw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29WmpNojPi000usUDyeDqbCcckDmG641PTe9PqB8m0+sPEdky
	Or56PXM7wfP+XXVnpS9XUDz+LAgTswYhSwadeZ3fF/c2iBoKCphx
X-Gm-Gg: ASbGncvsrmzK2m+dHc0vWWhH8aAnqRm8EJsufDrbKfl5zkujEqdRpy++2Ba+vIc69tl
	23ySDyDTDgg+HIP8LYP1KrIeUHskSfSAzP+rnPg1D30c0RTtvnH9EMJ5WvWKEQQ1a2Fn2jOqNrJ
	ZohdfXHsZUP9PoudTkiii1ZLxfxKtXrLd3MTSATKlJ9If0aVPUlNv1/F5nqLyZ6Hu6ejYLxMgfK
	hKzzr543J4sy9C5fESuQUUoJMi/ZihrEgfuOipnlVXeHVpV4ach/ZkBRiJPCZNYI4LuY5+pTKOG
	4fd7gnw4/pKKl8/z0z6+hWM6GA1Ojd/+iRiUhcfr4PF+715EWJNLelO8mtKiHW8JGZdvq3aoXLu
	3c/Mo7+kFIn49czI4QonrEjvk
X-Google-Smtp-Source: AGHT+IGmkDnnkoASLNKc7beCB36KTynfhE5+lNlk/tMYqhdW/dQRvuIWvPUsIp9fafc4LTtsm02Xxg==
X-Received: by 2002:a05:6000:186b:b0:391:2a9f:2fcb with SMTP id ffacd0b85a97d-39973b028a9mr4710707f8f.36.1742475697214;
        Thu, 20 Mar 2025 06:01:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:36 -0700 (PDT)
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
Subject: [PATCH v2 05/11] clk: en7523: define and register SoC SCU SSR driver for EN7581
Date: Thu, 20 Mar 2025 14:00:28 +0100
Message-ID: <20250320130054.4804-6-ansuelsmth@gmail.com>
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

Define all the possible interface modes and register the SoC SCU SSR
platform driver for EN7581.

Failing to register the SCU SSR driver is not a critical error (example
the SoC driver is not enable) but will prevent PCIe or USB port to
function correctly.

Reference to the SSR pdev are stored in the new en7523 priv struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c       | 99 ++++++++++++++++++++++++++++++++--
 include/linux/clk/clk-en7523.h | 10 ++++
 2 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/clk/clk-en7523.h

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 2a74bc8fed24..1f11fa769090 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -3,14 +3,17 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/clk-en7523.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
+#include <linux/soc/airoha/airoha-scu-ssr.h>
 #include <dt-bindings/clock/en7523-clk.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
+#include <dt-bindings/soc/airoha,scu-ssr.h>
 
 #define RST_NR_PER_BANK			32
 
@@ -81,6 +84,7 @@ struct en_clk_soc_data {
 	const struct en_clk_desc *base_clks;
 	const struct clk_ops pcie_ops;
 	int (*hw_init)(struct platform_device *pdev,
+		       struct en_clk_priv *priv,
 		       const struct en_clk_soc_data *soc_data,
 		       struct clk_hw_onecell_data *clk_data);
 };
@@ -361,6 +365,51 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static unsigned int an7581_serdes_wifi1_possible_modes[] = {
+	AIROHA_SCU_SERDES_MODE_PCIE0_X1,
+	AIROHA_SCU_SERDES_MODE_PCIE0_X2,
+	AIROHA_SCU_SERDES_MODE_ETHERNET,
+};
+
+static unsigned int an7581_serdes_wifi2_possible_modes[] = {
+	AIROHA_SCU_SERDES_MODE_PCIE1_X1,
+	AIROHA_SCU_SERDES_MODE_PCIE0_X2,
+	AIROHA_SCU_SERDES_MODE_ETHERNET,
+};
+
+static unsigned int an7581_serdes_usb1_possible_modes[] = {
+	AIROHA_SCU_SERDES_MODE_USB3,
+	AIROHA_SCU_SERDES_MODE_ETHERNET,
+};
+
+static unsigned int an7581_serdes_usb2_possible_modes[] = {
+	AIROHA_SCU_SERDES_MODE_PCIE2_X1,
+	AIROHA_SCU_SERDES_MODE_ETHERNET,
+};
+
+static const struct airoha_scu_ssr_serdes_info an7581_ports_info[] = {
+	[AIROHA_SCU_SERDES_WIFI1] = {
+		.possible_modes = an7581_serdes_wifi1_possible_modes,
+		.num_modes = ARRAY_SIZE(an7581_serdes_wifi1_possible_modes),
+	},
+	[AIROHA_SCU_SERDES_WIFI2] = {
+		.possible_modes = an7581_serdes_wifi2_possible_modes,
+		.num_modes = ARRAY_SIZE(an7581_serdes_wifi2_possible_modes),
+	},
+	[AIROHA_SCU_SERDES_USB1] = {
+		.possible_modes = an7581_serdes_usb1_possible_modes,
+		.num_modes = ARRAY_SIZE(an7581_serdes_usb1_possible_modes),
+	},
+	[AIROHA_SCU_SERDES_USB2] = {
+		.possible_modes = an7581_serdes_usb2_possible_modes,
+		.num_modes = ARRAY_SIZE(an7581_serdes_usb2_possible_modes),
+	},
+};
+
+static const struct airoha_scu_ssr_data an7581_scu_ssr_data = {
+	.ports_info = an7581_ports_info,
+};
+
 static u32 en7523_get_base_rate(const struct en_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -557,6 +606,7 @@ static const struct regmap_config en7523_clk_regmap_config = {
 };
 
 static int en7523_clk_hw_init(struct platform_device *pdev,
+			      struct en_clk_priv *priv,
 			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
@@ -661,12 +711,38 @@ static int en7581_reset_register(struct device *dev, struct regmap *map)
 	return devm_reset_controller_register(dev, &rst_data->rcdev);
 }
 
+static void en7581_clk_register_ssr(struct platform_device *pdev,
+				    struct en_clk_priv *priv)
+{
+	struct platform_device_info pinfo = { };
+	struct platform_device *ssr_pdev;
+
+	pinfo.name = "airoha-scu-ssr";
+	pinfo.parent = &pdev->dev;
+	pinfo.id = PLATFORM_DEVID_AUTO;
+	pinfo.fwnode = of_fwnode_handle(pdev->dev.of_node);
+	pinfo.of_node_reused = true;
+	pinfo.data = &an7581_scu_ssr_data;
+	pinfo.size_data = sizeof(an7581_scu_ssr_data);
+
+	ssr_pdev = platform_device_register_data(&pdev->dev, "airoha-scu-ssr",
+						 PLATFORM_DEVID_AUTO,
+						 &an7581_scu_ssr_data,
+						 sizeof(an7581_scu_ssr_data));
+	if (IS_ERR(ssr_pdev))
+		dev_warn_probe(&pdev->dev, PTR_ERR(ssr_pdev), "failed to register SCU SSR driver.\n");
+
+	priv->ssr_pdev = ssr_pdev;
+}
+
 static int en7581_clk_hw_init(struct platform_device *pdev,
+			      struct en_clk_priv *priv,
 			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *map, *clk_map;
 	void __iomem *base;
+	int ret;
 
 	map = syscon_regmap_lookup_by_compatible("airoha,en7581-chip-scu");
 	if (IS_ERR(map))
@@ -687,7 +763,13 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	regmap_update_bits(clk_map, REG_NP_SCU_PCIC, REG_PCIE_CTRL,
 			   FIELD_PREP(REG_PCIE_CTRL, 3));
 
-	return en7581_reset_register(&pdev->dev, clk_map);
+	ret = en7581_reset_register(&pdev->dev, clk_map);
+	if (ret)
+		return ret;
+
+	en7581_clk_register_ssr(pdev, priv);
+
+	return 0;
 }
 
 static int en7523_clk_probe(struct platform_device *pdev)
@@ -695,10 +777,15 @@ static int en7523_clk_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	const struct en_clk_soc_data *soc_data;
 	struct clk_hw_onecell_data *clk_data;
+	struct en_clk_priv *priv;
 	int r;
 
 	soc_data = device_get_match_data(&pdev->dev);
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	clk_data = devm_kzalloc(&pdev->dev,
 				struct_size(clk_data, hws, soc_data->num_clocks),
 				GFP_KERNEL);
@@ -706,11 +793,17 @@ static int en7523_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk_data->num = soc_data->num_clocks;
-	r = soc_data->hw_init(pdev, soc_data, clk_data);
+	r = soc_data->hw_init(pdev, priv, soc_data, clk_data);
 	if (r)
 		return r;
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		return r;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
 }
 
 static const struct en_clk_soc_data en7523_data = {
diff --git a/include/linux/clk/clk-en7523.h b/include/linux/clk/clk-en7523.h
new file mode 100644
index 000000000000..fc3b320dc7e9
--- /dev/null
+++ b/include/linux/clk/clk-en7523.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __LINUX_CLK_EN7523_H_
+#define __LINUX_CLK_EN7523_H_
+
+struct en_clk_priv {
+	struct platform_device *ssr_pdev;
+};
+
+#endif
-- 
2.48.1


