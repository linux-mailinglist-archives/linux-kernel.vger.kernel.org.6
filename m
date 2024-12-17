Return-Path: <linux-kernel+bounces-449504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A970B9F4FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850A3188ED17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971331FAC40;
	Tue, 17 Dec 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SvNVIkGL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F301FA8E0;
	Tue, 17 Dec 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450263; cv=none; b=P5ZVquDr4vTLrqH3Tr/qwYXHm0GSM5qkof9/NszONrvnqtEzpONAkfyQ3eUPAO4URexEAF8ekEi+VkzsJ8rYn9VjMFgCgwl93HdrR/2w/VA7EB8U5zhkWvAu7BBrRFwRW7yUkAod6t8NY0F6mDkfitOsnqXghfZNOdo1tPgYCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450263; c=relaxed/simple;
	bh=xvqKAlwxZi5qMu/HhzZvjBB2nmVM7/aMNaTJlpT98iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBK3XF7jJMoZmUJM616o1UCJRN3W1aMdxJxTiriSNvlhWxfjcXxS27U1m5nj2kq7kWVkPhWyisWoWXWnUfCyiRTQTUZs6gxPeR5jpb0U05mzLJbU06ud8rTe23ECZ69RhR0ryUwqIn9z9XT60PzvXpW5/OtuILwkGE/jGYG2Do0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SvNVIkGL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450259;
	bh=xvqKAlwxZi5qMu/HhzZvjBB2nmVM7/aMNaTJlpT98iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvNVIkGLkBS5bE7e/Pw4Af1qqvKKE3V0AexhP6DAih7ilYSyGjq9ThGme4gjsRC1g
	 vrME19hUEKWr11FnboIlS3UXfKmbbfRUsU4KN2rwW05hSuUll1GfTS+u2yxZ5u3HLT
	 XbCPSPcykO9kRAX9Gzp3V+bmZkQkRSftW4SwHVBwRQ/hgJ4EuMFtees+9IWLPdhII6
	 H0D3a1Y044hLsyWaNR84n9V2WkZNYSiVGj3andujZYIFal20ekDGuy6TS/PbFvJN9c
	 f3TWxQalODnkcMZEY78mnX9vBKHHYeNapcSvaQAZH6Iylxu1JOHfB+mWXTFBTh2H2r
	 ULRqAA5KQQhmg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 364E917E37CB;
	Tue, 17 Dec 2024 16:44:18 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v3 20/33] drm/mediatek: mtk_hdmi: Move CEC device parsing in new function
Date: Tue, 17 Dec 2024 16:43:32 +0100
Message-ID: <20241217154345.276919-21-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
References: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the CEC device parsing logic to a new function called
mtk_hdmi_get_cec_dev(), and move the parsing action to the end
of mtk_hdmi_dt_parse_pdata(), allowing to remove gotos in this
function, reducing code size and improving readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 84 ++++++++++++++---------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index c20d42ec387a..c95c7b55998c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1367,24 +1367,16 @@ static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
 	.edid_read = mtk_hdmi_bridge_edid_read,
 };
 
-static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
-				   struct platform_device *pdev)
+static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struct device_node *np)
 {
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *remote, *i2c_np;
 	struct platform_device *cec_pdev;
-	struct regmap *regmap;
+	struct device_node *cec_np;
 	int ret;
 
-	ret = mtk_hdmi_get_all_clk(hdmi, np);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get clocks\n");
-
 	/* The CEC module handles HDMI hotplug detection */
 	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np)
-		return dev_err_probe(dev, -EINVAL, "Failed to find CEC node\n");
+		return dev_err_probe(dev, -ENOTSUPP, "Failed to find CEC node\n");
 
 	cec_pdev = of_find_device_by_node(cec_np);
 	if (!cec_pdev) {
@@ -1393,65 +1385,69 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 		return -EPROBE_DEFER;
 	}
 	of_node_put(cec_np);
-	hdmi->cec_dev = &cec_pdev->dev;
 
 	/*
 	 * The mediatek,syscon-hdmi property contains a phandle link to the
 	 * MMSYS_CONFIG device and the register offset of the HDMI_SYS_CFG
 	 * registers it contains.
 	 */
-	regmap = syscon_regmap_lookup_by_phandle(np, "mediatek,syscon-hdmi");
-	ret = of_property_read_u32_index(np, "mediatek,syscon-hdmi", 1,
-					 &hdmi->sys_offset);
-	if (IS_ERR(regmap))
-		ret = PTR_ERR(regmap);
-	if (ret) {
-		dev_err_probe(dev, ret,
-			      "Failed to get system configuration registers\n");
-		goto put_device;
-	}
-	hdmi->sys_regmap = regmap;
+	hdmi->sys_regmap = syscon_regmap_lookup_by_phandle(np, "mediatek,syscon-hdmi");
+	if (IS_ERR(hdmi->sys_regmap))
+		return PTR_ERR(hdmi->sys_regmap);
+
+	ret = of_property_read_u32_index(np, "mediatek,syscon-hdmi", 1, &hdmi->sys_offset);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get system configuration registers\n");
+
+	hdmi->cec_dev = &cec_pdev->dev;
+	return 0;
+}
+
+static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
+				   struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *remote, *i2c_np;
+	int ret;
+
+	ret = mtk_hdmi_get_all_clk(hdmi, np);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
 	hdmi->regs = device_node_to_regmap(dev->of_node);
-	if (IS_ERR(hdmi->regs)) {
-		ret = PTR_ERR(hdmi->regs);
-		goto put_device;
-	}
+	if (IS_ERR(hdmi->regs))
+		return PTR_ERR(hdmi->regs);
 
 	remote = of_graph_get_remote_node(np, 1, 0);
-	if (!remote) {
-		ret = -EINVAL;
-		goto put_device;
-	}
+	if (!remote)
+		return -EINVAL;
 
 	if (!of_device_is_compatible(remote, "hdmi-connector")) {
 		hdmi->next_bridge = of_drm_find_bridge(remote);
 		if (!hdmi->next_bridge) {
 			dev_err(dev, "Waiting for external bridge\n");
 			of_node_put(remote);
-			ret = -EPROBE_DEFER;
-			goto put_device;
+			return -EPROBE_DEFER;
 		}
 	}
 
 	i2c_np = of_parse_phandle(remote, "ddc-i2c-bus", 0);
 	of_node_put(remote);
-	if (!i2c_np) {
-		ret = dev_err_probe(dev, -EINVAL, "No ddc-i2c-bus in connector\n");
-		goto put_device;
-	}
+	if (!i2c_np)
+		return dev_err_probe(dev, -EINVAL, "No ddc-i2c-bus in connector\n");
 
 	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
 	of_node_put(i2c_np);
-	if (!hdmi->ddc_adpt) {
-		ret = dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c adapter by node\n");
-		goto put_device;
-	}
+	if (!hdmi->ddc_adpt)
+		return dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c adapter by node\n");
+
+	ret = mtk_hdmi_get_cec_dev(hdmi, dev, np);
+	if (ret)
+		return ret;
 
 	return 0;
-put_device:
-	put_device(hdmi->cec_dev);
-	return ret;
 }
 
 /*
-- 
2.47.0


