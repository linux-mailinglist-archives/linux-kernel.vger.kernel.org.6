Return-Path: <linux-kernel+bounces-431172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F59E3A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22E3B339B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5931B0F1A;
	Wed,  4 Dec 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="woRovcdm"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EF1F130E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315246; cv=none; b=VJ4Q6sHQOW1xYKo24ROEo7gCXwv4lfj7u8qXwkMan9dh5raYgLOFHLoNNOGT+ENlP3dv2mKfgTeeAHv6j0cL3r25lZ3m0vn/mrEUYHclkYz99rGFIQ0AdW0YRVElCuiMHtepTJPBzCjcmAjj9CNRVK6Y48w8PbT3e0YPGN5WRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315246; c=relaxed/simple;
	bh=vIhMkl0NZPgk3UZYg3Cu3xyqdqxjleMaAj4gQ36m+Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8pNVDuFKYhBplgjO4FnWZY4ez4SfgTD6rW7tFG5018ACszih4nP+mfJTnFQUOlgNGKQ4VjHxl4MqVYiznRT630dLaaHd4LrR158KIs6mmSU9vDE4B3OYZVK/gWl3mOXAfgEHamtQh4ZNS8ssRZcjPmDlWbjUmi6nQnvIuTt57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=woRovcdm; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id DA2B83FEAE;
	Wed,  4 Dec 2024 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733315236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eF41jGmtQ2ePJq8YvI4gtqnFpvR6q54sJaHzjkAkjuQ=;
	b=woRovcdmww3ZzfJaz9SrjOagpgePADSL5orXQoEgclO9zosSSy3X831g7R48VTcBa2cRRS
	y+p7TZ1Wwpw08JlTtafANLQBRPM9wBboY9LuW6xvVC0EAMDrmgL7Jv89qieS5U/McZh5l9
	l2pF5mp7R7eHLGHpzlrDthDUZO0GYUg=
Received: from frank-u24.. (fttx-pool-194.15.87.121.bambit.de [194.15.87.121])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id E962636037C;
	Wed,  4 Dec 2024 12:27:14 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>
Subject: [RFC] phy: mediatek: xsphy: support type switch by pericfg
Date: Wed,  4 Dec 2024 13:27:05 +0100
Message-ID: <20241204122706.25190-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 25c0c98c-cfa9-4aae-ab48-f859e8afd9cd

From: Daniel Golle <daniel@makrotopia.org>

Patch from Sam Shih <sam.shih@mediatek.com> found in MediaTek SDK
released under GPL.

Get syscon and use it to set the PHY type.
Extend support to PCIe and SGMII mode in addition to USB2 and USB3.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
xsphy is needed on mt7988 to get ssusb0 working

current way is using a syscon node like this

	topmisc: topmisc@11d10000 {
		compatible = "mediatek,mt7988-topmisc", "syscon",
			     "mediatek,mt7988-power-controller";
		reg = <0 0x11d10000 0 0x10000>;
		#clock-cells = <1>;
		#power-domain-cells = <1>;
		#address-cells = <1>;
		#size-cells = <0>;
	};

	xs-phy@11e10000 {
		compatible = "mediatek,mt7988-xsphy",
			     "mediatek,xsphy";
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;
		status = "disabled";

		xphyu2port0: usb-phy@11e10000 {
			reg = <0 0x11e10000 0 0x400>;
			clocks = <&infracfg CLK_INFRA_USB_UTMI>;
			clock-names = "ref";
			#phy-cells = <1>;
		};

		xphyu3port0: usb-phy@11e13000 {
			reg = <0 0x11e13400 0 0x500>;
			clocks = <&infracfg CLK_INFRA_USB_PIPE>;
			clock-names = "ref";
			#phy-cells = <1>;
			mediatek,syscon-type = <&topmisc 0x218 0>;
		};
	};

maybe there are ways to avoid syscon without writing a dedicated driver
for the topmisc.
topmisc node itself is also used in ethernet-block mapped to the
mediatek,infracfg property.
---
 drivers/phy/mediatek/phy-mtk-xsphy.c | 85 +++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
index 7c248f5cfca5..3f94d0dee1b9 100644
--- a/drivers/phy/mediatek/phy-mtk-xsphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -11,10 +11,12 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include "phy-mtk-io.h"
 
@@ -81,12 +83,22 @@
 #define XSP_SR_COEF_DIVISOR	1000
 #define XSP_FM_DET_CYCLE_CNT	1024
 
+/* PHY switch between pcie/usb3/sgmii */
+#define USB_PHY_SWITCH_CTRL	0x0
+#define RG_PHY_SW_TYPE		GENMASK(3, 0)
+#define RG_PHY_SW_PCIE		0x0
+#define RG_PHY_SW_USB3		0x1
+#define RG_PHY_SW_SGMII		0x2
+
 struct xsphy_instance {
 	struct phy *phy;
 	void __iomem *port_base;
 	struct clk *ref_clk;	/* reference clock of anolog phy */
 	u32 index;
 	u32 type;
+	struct regmap *type_sw;
+	u32 type_sw_reg;
+	u32 type_sw_index;
 	/* only for HQA test */
 	int efuse_intr;
 	int efuse_tx_imp;
@@ -259,6 +271,10 @@ static void phy_parse_property(struct mtk_xsphy *xsphy,
 			inst->efuse_intr, inst->efuse_tx_imp,
 			inst->efuse_rx_imp);
 		break;
+	case PHY_TYPE_PCIE:
+	case PHY_TYPE_SGMII:
+		/* nothing to do */
+		break;
 	default:
 		dev_err(xsphy->dev, "incompatible phy type\n");
 		return;
@@ -305,6 +321,62 @@ static void u3_phy_props_set(struct mtk_xsphy *xsphy,
 				     RG_XTP_LN0_RX_IMPSEL, inst->efuse_rx_imp);
 }
 
+/* type switch for usb3/pcie/sgmii */
+static int phy_type_syscon_get(struct xsphy_instance *instance,
+			       struct device_node *dn)
+{
+	struct of_phandle_args args;
+	int ret;
+
+	/* type switch function is optional */
+	if (!of_property_read_bool(dn, "mediatek,syscon-type"))
+		return 0;
+
+	ret = of_parse_phandle_with_fixed_args(dn, "mediatek,syscon-type",
+					       2, 0, &args);
+	if (ret)
+		return ret;
+
+	instance->type_sw_reg = args.args[0];
+	instance->type_sw_index = args.args[1] & 0x3; /* <=3 */
+	instance->type_sw = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	dev_info(&instance->phy->dev, "type_sw - reg %#x, index %d\n",
+		 instance->type_sw_reg, instance->type_sw_index);
+
+	return PTR_ERR_OR_ZERO(instance->type_sw);
+}
+
+static int phy_type_set(struct xsphy_instance *instance)
+{
+	int type;
+	u32 offset;
+
+	if (!instance->type_sw)
+		return 0;
+
+	switch (instance->type) {
+	case PHY_TYPE_USB3:
+		type = RG_PHY_SW_USB3;
+		break;
+	case PHY_TYPE_PCIE:
+		type = RG_PHY_SW_PCIE;
+		break;
+	case PHY_TYPE_SGMII:
+		type = RG_PHY_SW_SGMII;
+		break;
+	case PHY_TYPE_USB2:
+	default:
+		return 0;
+	}
+
+	offset = instance->type_sw_index * BITS_PER_BYTE;
+	regmap_update_bits(instance->type_sw, instance->type_sw_reg,
+			   RG_PHY_SW_TYPE << offset, type << offset);
+
+	return 0;
+}
+
 static int mtk_phy_init(struct phy *phy)
 {
 	struct xsphy_instance *inst = phy_get_drvdata(phy);
@@ -325,6 +397,10 @@ static int mtk_phy_init(struct phy *phy)
 	case PHY_TYPE_USB3:
 		u3_phy_props_set(xsphy, inst);
 		break;
+	case PHY_TYPE_PCIE:
+	case PHY_TYPE_SGMII:
+		/* nothing to do, only used to set type */
+		break;
 	default:
 		dev_err(xsphy->dev, "incompatible phy type\n");
 		clk_disable_unprepare(inst->ref_clk);
@@ -403,12 +479,15 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 
 	inst->type = args->args[0];
 	if (!(inst->type == PHY_TYPE_USB2 ||
-	      inst->type == PHY_TYPE_USB3)) {
+	      inst->type == PHY_TYPE_USB3 ||
+	      inst->type == PHY_TYPE_PCIE ||
+	      inst->type == PHY_TYPE_SGMII)) {
 		dev_err(dev, "unsupported phy type: %d\n", inst->type);
 		return ERR_PTR(-EINVAL);
 	}
 
 	phy_parse_property(xsphy, inst);
+	phy_type_set(inst);
 
 	return inst->phy;
 }
@@ -510,6 +589,10 @@ static int mtk_xsphy_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
 			return PTR_ERR(inst->ref_clk);
 		}
+
+		retval = phy_type_syscon_get(inst, child_np);
+		if (retval)
+			return retval;
 	}
 
 	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
-- 
2.43.0


