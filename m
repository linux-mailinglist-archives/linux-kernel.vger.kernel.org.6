Return-Path: <linux-kernel+bounces-449506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46A9F5003
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58429188EDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4881FBCAF;
	Tue, 17 Dec 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KmJBS7Pw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663721FBC87;
	Tue, 17 Dec 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450267; cv=none; b=BIPjpei9YumvauDEH0wn3Aa0EJhlwrDiAvXebz0oIh3neM9aQq90bJVBXhqghazII0bpFto2xDMtVvamUsaYL88WF/wbQyR6FfT0NMI8rO6Ff8OIA39z9np68xa5P1qX4Yq9cBNcbvq09JIaUQW367whUsK5n28gK0i/GlcGZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450267; c=relaxed/simple;
	bh=0p0IXEd2fkgLDSgY6EoCVjmZxOOmdUnvxWTxBaH6WFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftSnqQD99ng3dhQk3Ab9oikx49BzkiOO6MdLFzrL6WcuLfjd6xxpe3DSYSdF6hSzfeA8vygCGqPP+1VH9ddUV+CYrNkuXuG+IQLGgd2F0F2Tqox0bdvYuDgPs9CcUceZYhGc0gsu17bGzAiy4ZLj1c8zmfsh02X3G8SfQ4qi5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KmJBS7Pw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450263;
	bh=0p0IXEd2fkgLDSgY6EoCVjmZxOOmdUnvxWTxBaH6WFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmJBS7PwWG9TOhb42rJtkBFGP/ahb5CO+A1Z33I/M3WVG55oYZtYGkYllg+wyPG20
	 B8a8oP9jfwvCS7zviPpoK+7cZL5qkouy1Ee9yCrtIdAtt3E1Hm62ww2hFzQTTvY7EI
	 /wtu+X32VFGcdpUfKyI13l0Ce4aHQUtWYjNvnCie22g/i7A6SbBWcgneHfEXo3rxHH
	 Lzq1CHhEpF93+S/gS/6/GyROoAdQxctqjX+KHgSU2BoIA9RgQXYZ79/youjeMpdE54
	 SuxOCoSHnwETfqa3HBfx2+tUmQvtjf2bu7UQ2/pAxH9cYhtwOvhnZuWqoC7KKvFP4h
	 j3BxIUDY2NHWg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D20D17E37AF;
	Tue, 17 Dec 2024 16:44:22 +0100 (CET)
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
Subject: [PATCH v3 23/33] drm/mediatek: mtk_hdmi: Use devm managed version of drm_bridge_add
Date: Tue, 17 Dec 2024 16:43:35 +0100
Message-ID: <20241217154345.276919-24-angelogioacchino.delregno@collabora.com>
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

Simplify the probe/remove functions by using devm_drm_bridge_add()
as now there is no more need to manually remove the bridge.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 2d5cf7352ed2..5d46d486c68f 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1674,14 +1674,15 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "MediaTek";
 	hdmi->bridge.product = "On-Chip HDMI";
-	drm_bridge_add(&hdmi->bridge);
+
+	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add bridge\n");
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-	if (ret) {
-		drm_bridge_remove(&hdmi->bridge);
+	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to enable audio clocks\n");
-	}
 
 	return 0;
 }
@@ -1690,7 +1691,6 @@ static void mtk_hdmi_remove(struct platform_device *pdev)
 {
 	struct mtk_hdmi *hdmi = platform_get_drvdata(pdev);
 
-	drm_bridge_remove(&hdmi->bridge);
 	mtk_hdmi_clk_disable_audio(hdmi);
 }
 
-- 
2.47.0


