Return-Path: <linux-kernel+bounces-415748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78F9D3AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38DD2812FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45081A3BC3;
	Wed, 20 Nov 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OdDtjyWS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076915853A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106558; cv=none; b=Dq5IYsxuWRVE1c0ntNx5CcFnq3giuNVlH0fnvL5rVttRVCwpbA6l0D3vmajqoYHh1mkSioysdaoW7jb1ajJSc5pseaXJdp3UfX5wPCfmx7Vk3qh+vuO/Ong3dnmPjsVAHmNUvCsjecixyosH44F8luNuJRknIfHXwpG90CJRPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106558; c=relaxed/simple;
	bh=X6Vm3LbhTsKjq12wJ9i8bHP6qgWeslNJ7NDL3Hegox8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVsh49FKecBudeDgrVrIN7vjKmZOyW30vQCic7d/uVjIZR1k6cszIMBbTs7qZpbK83tkofU41/GeBR1OsqVR9JrhHXNP4trLiikOBChPn9HmTGD5TOH62ri7pPJDTpocB1HC71Ai5IoXygTeYhx++MwiKhx+9XeO91988iB4li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OdDtjyWS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732106553;
	bh=X6Vm3LbhTsKjq12wJ9i8bHP6qgWeslNJ7NDL3Hegox8=;
	h=From:To:Cc:Subject:Date:From;
	b=OdDtjyWSfEWPYZfn20vNe03opNz9HuPAm+BUkkT5+zS4QD1Y7eogL8TG/iVVUG8Rq
	 1qX5U4qqIIpvdF1szZjtSPAuvIay/yJQFmlGL2Mw3VgcupaEV+lYRjh5xFZIbAIH6g
	 RJLkr2T/LVjvHrJQaV1F6Px9kwOZIhq7Rq70+GAucWxzIoLxE5Kq1L/IYubuyVW+ws
	 GM7E83aQGuszkLDj8eDLHMYD8H1nDWFssGyCHA/w5yrcYDs41WSG4Z8oWM/jNrBhR8
	 1PibaFFibJvErdY3GXFBynq3TZVOV7Tpn3YoIpDE9hmYVvSZWz/gKr7L6WZ0SkN9B1
	 dUaSeJXTSVytA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF41417E365E;
	Wed, 20 Nov 2024 13:42:32 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	chunfeng.yun@mediatek.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] phy: mediatek: phy-mtk-hdmi: Register PHY provided regulator
Date: Wed, 20 Nov 2024 13:41:43 +0100
Message-ID: <20241120124143.132637-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least version 2 of the HDMI PHY, found in MediaTek MT8195 and
MT8188 SoCs, does provide hardware support to switch on/off the
HDMI 5V pins (which are also used for DDC), and this translates
to this being a fixed regulator.

Register this PHY-provided regulator so that it can be fed to the
hdmi-connector driver to manage the HDMI +5V PWR rail.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 44 ++++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h |  3 ++
 drivers/phy/mediatek/phy-mtk-hdmi.c        | 28 ++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi.h        |  4 ++
 4 files changed, 79 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index bbfe11d6a69d..b38f3ae26b3f 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -9,6 +9,8 @@
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/types.h>
 #include <linux/units.h>
 #include <linux/nvmem-consumer.h>
@@ -478,8 +480,50 @@ static int mtk_hdmi_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	return ret;
 }
 
+static int mtk_hdmi_phy_pwr5v_enable(struct regulator_dev *rdev)
+{
+	struct mtk_hdmi_phy *hdmi_phy = rdev_get_drvdata(rdev);
+
+	mtk_phy_set_bits(hdmi_phy->regs + HDMI_CTL_1, RG_HDMITX_PWR5V_O);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_pwr5v_disable(struct regulator_dev *rdev)
+{
+	struct mtk_hdmi_phy *hdmi_phy = rdev_get_drvdata(rdev);
+
+	mtk_phy_clear_bits(hdmi_phy->regs + HDMI_CTL_1, RG_HDMITX_PWR5V_O);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_pwr5v_is_enabled(struct regulator_dev *rdev)
+{
+	struct mtk_hdmi_phy *hdmi_phy = rdev_get_drvdata(rdev);
+
+	return !!(readl(hdmi_phy->regs + HDMI_CTL_1) & RG_HDMITX_PWR5V_O);
+}
+
+static const struct regulator_ops mtk_hdmi_pwr5v_regulator_ops = {
+	.enable = mtk_hdmi_phy_pwr5v_enable,
+	.disable = mtk_hdmi_phy_pwr5v_disable,
+	.is_enabled = mtk_hdmi_phy_pwr5v_is_enabled
+};
+
+static const struct regulator_desc mtk_hdmi_phy_pwr5v_desc = {
+	.name = "hdmi-pwr5v",
+	.id = -1,
+	.n_voltages = 1,
+	.fixed_uV = 5000000,
+	.ops = &mtk_hdmi_pwr5v_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf = {
 	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+	.hdmi_phy_regulator_desc = &mtk_hdmi_phy_pwr5v_desc,
 	.hdmi_phy_clk_ops = &mtk_hdmi_pll_ops,
 	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
index 22a68dc9550c..e26caaf4d104 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
@@ -103,6 +103,9 @@
 #define HDMI_ANA_CTL 0x7c
 #define REG_ANA_HDMI20_FIFO_EN BIT(16)
 
+#define HDMI_CTL_1 0xc4
+#define RG_HDMITX_PWR5V_O BIT(9)
+
 #define HDMI_CTL_3 0xcc
 #define REG_HDMITXPLL_DIV GENMASK(4, 0)
 #define REG_HDMITX_REF_XTAL_SEL BIT(7)
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index d2e824771f9d..52a7d525ff9b 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -75,6 +75,28 @@ static void mtk_hdmi_phy_clk_get_data(struct mtk_hdmi_phy *hdmi_phy,
 	clk_init->ops = hdmi_phy->conf->hdmi_phy_clk_ops;
 }
 
+static int mtk_hdmi_phy_register_regulators(struct mtk_hdmi_phy *hdmi_phy)
+{
+	const struct regulator_desc *vreg_desc = hdmi_phy->conf->hdmi_phy_regulator_desc;
+	const struct regulator_init_data vreg_init_data = {
+		.constraints = {
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		}
+	};
+	struct regulator_config vreg_config = {
+		.dev = hdmi_phy->dev,
+		.driver_data = hdmi_phy,
+		.init_data = &vreg_init_data,
+		.of_node = hdmi_phy->dev->of_node
+	};
+
+	hdmi_phy->rdev = devm_regulator_register(hdmi_phy->dev, vreg_desc, &vreg_config);
+	if (IS_ERR(hdmi_phy->rdev))
+		return PTR_ERR(hdmi_phy->rdev);
+
+	return 0;
+}
+
 static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -150,6 +172,12 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	if (hdmi_phy->conf->pll_default_off)
 		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
 
+	if (hdmi_phy->conf->hdmi_phy_regulator_desc) {
+		ret = mtk_hdmi_phy_register_regulators(hdmi_phy);
+		if (ret)
+			return ret;
+	}
+
 	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
 				   hdmi_phy->pll);
 }
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
index 71c02d043485..99d917e0036a 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/types.h>
 
 struct mtk_hdmi_phy;
@@ -20,6 +22,7 @@ struct mtk_hdmi_phy;
 struct mtk_hdmi_phy_conf {
 	unsigned long flags;
 	bool pll_default_off;
+	const struct regulator_desc *hdmi_phy_regulator_desc;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
@@ -32,6 +35,7 @@ struct mtk_hdmi_phy {
 	struct mtk_hdmi_phy_conf *conf;
 	struct clk *pll;
 	struct clk_hw pll_hw;
+	struct regulator_dev *rdev;
 	unsigned long pll_rate;
 	unsigned char drv_imp_clk;
 	unsigned char drv_imp_d2;
-- 
2.47.0


