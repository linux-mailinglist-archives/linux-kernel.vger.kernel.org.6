Return-Path: <linux-kernel+bounces-518013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA9DA38883
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71A37A35D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E1230268;
	Mon, 17 Feb 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SzvRfy6Z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAC224B1F;
	Mon, 17 Feb 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807425; cv=none; b=dl8/IAR05Cllpx38CWjAm3PfSq0n0wiyvIgrtdqAMrfTWSV0o+1tlBiEA/yLHAjGA2mleOZEhBiW+Ti7nptXUhcCRhT8CkkY2JlUkJ2Vl76KXkA4gc7pQQq7Rrmjrma9lQC1tynFHzUYn8546nhpM+AX+hNuqWjy25paMGy/l0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807425; c=relaxed/simple;
	bh=AQORTGEMJRTeOzgv2ykstrnHNuBXQ26g7MQ0Fgeka9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYgFYfMHoZ99C0s0As0rILUrgadcLKb4MpY6em/w+N/1AQTy8qqEAWTFmED/kVXhrYyZtcJv3UZvugrmikY+K79B7sUbnvTsHD2041j9iw6upC56hpFW5Wpg9pHrmwKSMR3XxjwkJgnbjAtvaVw/ON77ct1IeXJEOV/K9emFZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SzvRfy6Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807421;
	bh=AQORTGEMJRTeOzgv2ykstrnHNuBXQ26g7MQ0Fgeka9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzvRfy6ZQONbwRZseCTd/qCY7RuJC4UB+shUIvg0Khs7nJiydSU1+hJry2rGmR5tw
	 R6D8ddUHGrBllZDZiSpgzoliaVf0HQbZ0GEHAzXEhAxoaIy9ycMovZOI/5Q2oJRTwV
	 c1wShv8q4z+/7EwNYJBb+2qk4J/cWYONbmv4ss3CZylqoVZfeftOg4Oq1B10nPxKx8
	 V8HKzXMfgQWIRDWKckRK3frVokC7eLL3coJUsAnWX66AlRT+bZWe19bfRCBKI9EmhH
	 WigkB6Bj9IrqH2anWw+p9WXO6GIfENJMa2R7yxpYo2IzXmnMDaDu2yXJXecWN+wV5U
	 k8BKruPfNSHqw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 588CB17E155A;
	Mon, 17 Feb 2025 16:50:20 +0100 (CET)
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
	jason-jh.lin@mediatek.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 43/43] drm/mediatek/hdmi: Use syscon_regmap_lookup_by_phandle_args
Date: Mon, 17 Feb 2025 16:48:36 +0100
Message-ID: <20250217154836.108895-44-angelogioacchino.delregno@collabora.com>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[Angelo: Rebased over HDMIv2/DDCv2 series cleanups]
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 784bc05c9541..00a638a3caf4 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -269,12 +269,9 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 	 * MMSYS_CONFIG device and the register offset of the HDMI_SYS_CFG
 	 * registers it contains.
 	 */
-	hdmi->sys_regmap = syscon_regmap_lookup_by_phandle(np, "mediatek,syscon-hdmi");
+	hdmi->sys_regmap = syscon_regmap_lookup_by_phandle_args(np, "mediatek,syscon-hdmi",
+								1, &hdmi->sys_offset);
 	if (IS_ERR(hdmi->sys_regmap))
-		return PTR_ERR(hdmi->sys_regmap);
-
-	ret = of_property_read_u32_index(np, "mediatek,syscon-hdmi", 1, &hdmi->sys_offset);
-	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to get system configuration registers\n");
 
-- 
2.48.1


