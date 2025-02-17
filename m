Return-Path: <linux-kernel+bounces-517996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156ABA38876
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E316347B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57B22AE68;
	Mon, 17 Feb 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y/LzyE4V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A522ACC5;
	Mon, 17 Feb 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807399; cv=none; b=kZwq1qAbc0x3CxqYtRyyCTprdJp+AbOyTRzn8pi/qvVDi+cYwuC0u4FhwfBST82oT6y5vNdiT+PzDJ2KCE5F+/WJhKMsDdPoKti0LN8Biu1TSD59uRh982YLYjOjaAhgg0AoveJXqStlAkHJrYCXQsCLCiMy28OyC4MJI0vtbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807399; c=relaxed/simple;
	bh=7KIrdPlS46LgPwdeG0b/fb9kc5jCE6vTHbUKhxg08dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj+cUGw4p/5lfdO49TkSVj/a+KHYH8mPr9mT/IOSbaOOVg8myPdtGqk+cc0APZznV7LYb54dd913jc5wQ2KvXzLHdRt5fHp9T5hXN1gPXqxEv0egca6ZGsd6z3FTv2nhAm4cpTWGa5iQmJJPcmFZjC1kT7gTKKmLxCXRVM7NXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y/LzyE4V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807395;
	bh=7KIrdPlS46LgPwdeG0b/fb9kc5jCE6vTHbUKhxg08dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/LzyE4Vame8pDsespMnZIAtC/ctYkh00+pZ5N/vcfIJLcn5znMZtkIVpiTebOpOJ
	 x5uZxfvodJJ5B+U9rQ4i4ilc1bFQ2lb1MAvxaab/jVCByl8WV0i3TELQQqkHI6uvbc
	 rG12ShMlJrBx13k3NLUZ3o2tUIAysiUkXX9Z2lCTEvNB4H0m6Kbq3aGGQMwqLMnN45
	 1pM7BWnfnSiAjbZRl6CVXOZrlZjUh61WzSa4kyqnGyoa9iZHrupWuvROAsUL8XKR+2
	 JC68TyEYZIyUmn5/82/JIleDcku8CktQBKX1VPFLnxNbIuAsXUbdFyAD4iJyk1NPSQ
	 edUJtRT7m/IJA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EBE817E154F;
	Mon, 17 Feb 2025 16:49:54 +0100 (CET)
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
	dmitry.baryshkov@linaro.org,
	lewis.liao@mediatek.com,
	ives.chenjh@mediatek.com,
	tommyyl.chen@mediatek.com,
	jason-jh.lin@mediatek.com
Subject: [PATCH v7 26/43] drm/mediatek: mtk_hdmi: Move CEC device parsing in new function
Date: Mon, 17 Feb 2025 16:48:19 +0100
Message-ID: <20250217154836.108895-27-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
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

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 82 ++++++++++++++---------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 61e521430b48..eb3b1009c305 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1367,20 +1367,12 @@ static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
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
@@ -1394,65 +1386,69 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
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
2.48.1


