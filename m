Return-Path: <linux-kernel+bounces-518010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FAA3888C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F2D175615
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC791223705;
	Mon, 17 Feb 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LBPrxHv0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900922E3FF;
	Mon, 17 Feb 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807420; cv=none; b=WfnzLr9i4E/Mv8q91JCQLLjB3BFzCnLSouPr8aGBrHMz0UQsoeBxg2kBqBecj4Wozm+dNWGi3uPc//pdAB4vHdCVgiGJ3Ho6QrV6Ygus5xgFFpqTCzGk/KR4dvWi5mX9LDYqnfWevPAnOjyT5xgt1JnrN1ZloheHB4p45Q8kWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807420; c=relaxed/simple;
	bh=2kGGFknm7SGbXS6+W/lC33q7YoMyaUdMj64RaqU2meA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq5WXClpgz6uNnzVOYdjD3Km97CQvSeaNdwQIoBXksZmW1EhsRMtR0kDT1uaJdQkWpr256kLSohh30p49et9Y98B/Y8M2ppZ9PkEI72dvftzYugmnRVib0fRlcH6MRS+vMY8gQyD4SJ6nxUdRp8o8pWQgSm/MNg5b7lAdRbkVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LBPrxHv0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807417;
	bh=2kGGFknm7SGbXS6+W/lC33q7YoMyaUdMj64RaqU2meA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBPrxHv01qMi0IZGO0REMt3oT1KjOb2u9bw5Ik2FrY/4bG4XEfzZBbkDNYAgKjUij
	 viIVjGLZRMTj4oHV3f3ofqjKC5pKg1vhOl9/zszayKB4eOL1O0UFgMZzS7/xHbnEWY
	 Zrn7wwJevr0hCsJnB3xORNZCbxO2XjPfkKQ1KorsyHDsD7Kh10rxG1gqPmFuB0Uq3g
	 vn7aBf4XXnsktCXpm1vYoh3mgdIG7e9Lzvilq9e0AnZcj0sDSfhSFZMdBD5FO4C1o/
	 +lWdtZCWdYNmqU5MXHH8XEqU36Hl6kZG8O38cPv19aV8HFzrCFh4dpddQX73qY4LTg
	 wyYxUw+pP2eRQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CBA1717E1554;
	Mon, 17 Feb 2025 16:50:15 +0100 (CET)
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
Subject: [PATCH v7 40/43] drm/mediatek: mtk_hdmi_common: Add var to enable interlaced modes
Date: Mon, 17 Feb 2025 16:48:33 +0100
Message-ID: <20250217154836.108895-41-angelogioacchino.delregno@collabora.com>
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

Add an interlace_allowed bool member to struct mtk_hdmi_ver_conf
which will be used to signal whether interlaced modes are supported
by the bridge (in our case, the HDMI IP), and enable it for HDMIv2.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 1 +
 drivers/gpu/drm/mediatek/mtk_hdmi_common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index d58752b772e8..9d1b29ddfb8d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -419,6 +419,7 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
 	hdmi->bridge.ddc = hdmi->ddc_adpt;
 	hdmi->bridge.vendor = "MediaTek";
 	hdmi->bridge.product = "On-Chip HDMI";
+	hdmi->bridge.interlace_allowed = ver_conf->interlace_allowed;
 
 	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
 	if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
index d3de8afff40f..38d1bdf4c77e 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
@@ -131,6 +131,7 @@ struct mtk_hdmi_ver_conf {
 	const struct hdmi_codec_ops *codec_ops;
 	const char * const *mtk_hdmi_clock_names;
 	int num_clocks;
+	bool interlace_allowed;
 };
 
 struct mtk_hdmi_conf {
-- 
2.48.1


