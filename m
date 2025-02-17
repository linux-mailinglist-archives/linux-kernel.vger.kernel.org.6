Return-Path: <linux-kernel+bounces-517985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5FA3885D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715BC17457C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D92288CD;
	Mon, 17 Feb 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iV0Kvdw8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C03227B82;
	Mon, 17 Feb 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807383; cv=none; b=U5EDQbYwyJqoPU9KopCayq4EdQt22uNv2QTYaqveAuPfGITShIwgrOKxpVIrRgjNi9ycFxUJG8kl7HS6+8RRKulhJIUmxLdwgl7WYgGcSk5ZXY7tD5YbiDhrcn4n1tu6xEPhdnsuqEtKG9sv5IH7qb1hKj1QFj4nyDhNjVuCAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807383; c=relaxed/simple;
	bh=Cv0bXcM/taqhtNmiF78XSEZ+Bw83rSraKNb4fd2DnLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1u1l2XXt232OzPOHMwRbVnd1fLItnNTYItSbwKQSZOP/uHm4SPD/b9dfhRcpf+IhgG0EP3q2VLpuNrr3o2iW9reWRseg739qQiDmMYVBLHKgH8xob/Vitfy7c5LfqN2bdqAAkmiAFobwS25ewiyEzNjLdfnqNadDDWClfFp0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iV0Kvdw8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807380;
	bh=Cv0bXcM/taqhtNmiF78XSEZ+Bw83rSraKNb4fd2DnLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV0Kvdw8mHu651sroOfHZnd0ovtj8L9JCoMBD5k2X3HyXaUHrf3RJSOa98LChyWw2
	 y5k4OmLMHfifiRET/OCa+b77firSlb85BeHCT9yYsZqLAFzTuNdg7ksiSiX+3zgumf
	 oD0g55xkiH+3EfSaj2mjhBybYC88Lk2b5SHXCgUzi36q/T4cFbVNosg43HrO5ipl1G
	 x5B2vlfg+cw8YK6bSdQHRt5GT5TnJeVJq5zWAj2MCBk+9yYsPnK2OY8A17hYPF7eDn
	 tIPP/6vwLjjGxe71LwI70MR02T9J2JWelTjXQaps/GPuIqp7w0eiQUUFPCa6MIvNK5
	 Ho8VXRyGyrA9w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8446517E14E7;
	Mon, 17 Feb 2025 16:49:39 +0100 (CET)
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
Subject: [PATCH v7 16/43] drm/mediatek: mtk_hdmi: Compress of_device_id array entries
Date: Mon, 17 Feb 2025 16:48:09 +0100
Message-ID: <20250217154836.108895-17-angelogioacchino.delregno@collabora.com>
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

Compress the entries found in the of_device_id array to improve
readability of this file and to make that consistent with other
kernel drivers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 1e50b3918069..be71105ba81d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1780,15 +1780,10 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 = {
 };
 
 static const struct of_device_id mtk_hdmi_of_ids[] = {
-	{ .compatible = "mediatek,mt2701-hdmi",
-	  .data = &mtk_hdmi_conf_mt2701,
-	},
-	{ .compatible = "mediatek,mt8167-hdmi",
-	  .data = &mtk_hdmi_conf_mt8167,
-	},
-	{ .compatible = "mediatek,mt8173-hdmi",
-	},
-	{}
+	{ .compatible = "mediatek,mt2701-hdmi", .data = &mtk_hdmi_conf_mt2701 },
+	{ .compatible = "mediatek,mt8167-hdmi", .data = &mtk_hdmi_conf_mt8167 },
+	{ .compatible = "mediatek,mt8173-hdmi" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_hdmi_of_ids);
 
-- 
2.48.1


