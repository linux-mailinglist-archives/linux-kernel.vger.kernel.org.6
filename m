Return-Path: <linux-kernel+bounces-433151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A59E5476
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32151882862
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D852163B8;
	Thu,  5 Dec 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lrgiSCmU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7388215F57;
	Thu,  5 Dec 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399155; cv=none; b=d/iuEtkSmSGv6SYjlQDqqfdxxCH68GbSW6h2NLk90yTFo/G2SNSAcFl+mrcnd372Xn+S1Dj3eLKwR0pVr0T50X8n3cQyLASzi3InjSiItzZ5WRX7Z9zwuttyzyG0gtuKBLuA2ZoRWcN1MoKO0DsrSkOsIKk00sOknCR2zbySbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399155; c=relaxed/simple;
	bh=Iuw6lKAFVStlEoHokBHUjRYt3DcWkQHIBuWJ0JZ2TFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+VeAhNMRSlrSvGcEfOr/HgYPbMdjSWxMEJA4hHfnvdCcIHXVA1fvUqZFix9OQWrXQOZ571NVMtMMxvopyxm9/EsxZIxcZmhRHrMHtaMIiigW2/xGMKm3F6NlABywskTsXWJAJwQEmRg9873wQEl+BZI6CzXV9G7MPYA0dBXyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lrgiSCmU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733399152;
	bh=Iuw6lKAFVStlEoHokBHUjRYt3DcWkQHIBuWJ0JZ2TFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrgiSCmUP8WsD46KlOPP5b0OaGKpxCuBsOOZfzjM3qQ+FQqOzFv0/QzQfKK6EPkeg
	 vXaFbLU4pGI/D41gAG3ol4THCN5+DU3HHAqu3Mrf1RmDxoi9ZXmoN4DR7Ky4GhhDQF
	 Ta4qcXKwqv4dQgnqhi/qSnf9Cih3cxAqclEa8vtOGwpPRANYouUg6XviSxpTrT1weR
	 wlUnyoQI2DuMaINpXMDkbk8RST170jr1CNogbx/MZr6EeGc5hBK6GH531FlQuP3Wr+
	 i/m68e8p83y8ifKr2dbmahw5t1b1Ba9/ushJOKmv2xiAXJvxbqP7xbnThYQ6Bn3Jx1
	 mJsG1mc6UoUTA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4052817E3633;
	Thu,  5 Dec 2024 12:45:51 +0100 (CET)
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
	kernel@collabora.com
Subject: [PATCH v2 14/15] drm/mediatek: mtk_hdmi_common: Add OP_HDMI, vendor and product strings
Date: Thu,  5 Dec 2024 12:45:16 +0100
Message-ID: <20241205114518.53527-15-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the HDMI TX v2 driver, and to allow
a future modernization of the HDMI v1 one, perform changes
that enable the usage of the HDMI Helpers provided by DRM.

Check if the HDMI driver provides the function pointers to
hdmi_{clear,write}_infoframe used by the HDMI Helper API and,
if present, add DRM_BRIDGE_OP_HDMI to the drm_bridge ops,
enabling the drm API to register the bridge as HDMI and to use
the HDMI Helper functions.

Moreover, as part of data exclusively used (in the context of
HDMI bridges) by the helpers, assign the vendor "MediaTek" and
product "On-Chip HDMI" strings to the drm_bridge struct.

If the hdmi_{write,clear}_infoframe pointers are not assigned,
vendor and product strings and HDMI helpers will not be used,
hence this commit brings no functional changes to drivers that
have not been refactored to use the new helpers.

This also means that, in the current state, there is effectively
no functional change to mtk_hdmi and its other components.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 4f708b04f5e8..0f60842462b0 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -408,9 +408,16 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
 
 	hdmi->bridge.funcs = ver_conf->bridge_funcs;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
+
+	if (ver_conf->bridge_funcs->hdmi_write_infoframe &&
+	    ver_conf->bridge_funcs->hdmi_clear_infoframe)
+		hdmi->bridge.ops |= DRM_BRIDGE_OP_HDMI;
+
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	hdmi->bridge.ddc = hdmi->ddc_adpt;
+	hdmi->bridge.vendor = "MediaTek";
+	hdmi->bridge.product = "On-Chip HDMI";
 
 	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
 	if (ret)
-- 
2.47.0


