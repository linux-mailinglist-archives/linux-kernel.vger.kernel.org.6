Return-Path: <linux-kernel+bounces-517999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5EA38891
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB801891003
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C3022ACDC;
	Mon, 17 Feb 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mILq2Yl3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC522B59D;
	Mon, 17 Feb 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807403; cv=none; b=cBi6aXGfQVU/8NgP3D2N0rAtl49eSVFX0BGpo2DXQev3Jwxx0sgevg42ktdnDhvpKm+B34vRSwYyXvSJjOPpbPkzj3inkzPnUMfkB20vCDlP8PL1sIjcZ/HO95ifoYR+IqJDesDHqRCa3Doffs0iHUB/Vi0uvd3wc+o4sfrLQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807403; c=relaxed/simple;
	bh=k+QIu5zZ/7w2v6aSJjuICT0/5/npfSxX3v7MZDnx9LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZjV8oao7aFOBp58cF2hDddVVtAAQr2C+aljmJ79qSxVXhc06xtHeNBsutsxcF93M5dWWNMtEwl8jPauSGJfNsvWhW5bKOPpmk7V9U6JlFSCCiSA8fimo0XOUYeO5NTSL1dEbXwosx8Y3OvgL5nk/sIExNc3CGETa//cgL8AFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mILq2Yl3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807400;
	bh=k+QIu5zZ/7w2v6aSJjuICT0/5/npfSxX3v7MZDnx9LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mILq2Yl319NLPilJJDbpnDFoZaz8OoAKLv9KnMW2szt5+7ClL/YrjGLoolJJfvapi
	 QS5O1pXnR9LQBA16++YghfmBwmZJ98nZalXQN1zwHcBotvs8zbbBwgto48qYB+82Is
	 Tx1/1//BK1lYPOIrl2xHXkJIDf9WH6XrLffkF6Zvjfv5TBeYm3e3FV/ZGj1WloByic
	 QoPYiPrwEcc5n3wXA3iST9A8uptBEbR5K7X/4JGfmtLT7ZP3oAEtvTWelNH/WzSgmF
	 YZojhIfHsa3U7H+qTyUrMRHLde2X8MrKDxAB7+JSP5KAFbxZ8ftJQCc8Jq5KIoX0rG
	 +a0TN+mkOmnrg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 290BC17E1570;
	Mon, 17 Feb 2025 16:49:59 +0100 (CET)
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
Subject: [PATCH v7 29/43] drm/mediatek: mtk_hdmi: Use devm managed version of drm_bridge_add
Date: Mon, 17 Feb 2025 16:48:22 +0100
Message-ID: <20250217154836.108895-30-angelogioacchino.delregno@collabora.com>
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

Simplify the probe/remove functions by using devm_drm_bridge_add()
as now there is no more need to manually remove the bridge.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index e79ebed21eab..f539472307e2 100644
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
2.48.1


