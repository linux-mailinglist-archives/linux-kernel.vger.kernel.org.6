Return-Path: <linux-kernel+bounces-518007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCC3A3887B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBD7A18DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DA22DFBF;
	Mon, 17 Feb 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DemkJgz+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201422DF8E;
	Mon, 17 Feb 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807415; cv=none; b=R9jI8RlNpYwl8fqVAaP3t3DQdH7cb1LS+0s5+36YHItA9MCVNRDmds6ikwH0g8Qn5GfzAyxSX2nt7I7EL8I9EIuZnGD+UQyYFPFx1i+eVU4O/EEvW5FhlcfbG8ihEV5AsNBKy3vyTe1UTalIVO3U6Xr3MRz+Ru80/2k54uRk1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807415; c=relaxed/simple;
	bh=GlRo2d9gRmKBrBOrnvp140vj1D84iqKz9NDaGXUI7Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX/tdjZ8Oj/WiXpi5nKh/qYDgErP6k73pi+Z9nhUUaQTAFeaDFu6P/vudjFHBlLm2m63xyD/XWzeMNh1KShHbBHa/8Pp84u23qgsMACPsggArNaqjlgwX+2l/nG5ekUwKQ3UgAnM/Y1sdEGEOtt3/Oi3AUJ5aUWtamdzDXfcgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DemkJgz+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807412;
	bh=GlRo2d9gRmKBrBOrnvp140vj1D84iqKz9NDaGXUI7Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DemkJgz+NXwiEuhMEccCZbYgAFZYpUCJLdms2GurCUVMTmeQi+uQ7MsmbKJbj1n8I
	 F+zITU4A187Q/KXPiERjArXJpKY7zLmF9hRQ2+2qxFDfeMCWs2esJN0TJmr8TvMIPT
	 lsUWoywDxY17naU8lv31LoEsaYCPvwkGWiHcxCKVPe2T8SUFyXS+UyyeXwOlH+OavP
	 s0YTk/k4e5gB8rDHq2iat4t08YBj7R5e9ihU8VdZWfWYcxCqB+8OdMz8CWJUrJFzWX
	 pr0E72a0b8DFsDsszQ2YiekQuEuxqz72gZOhju4dDXcw9CTEZouN+2pDTNqXlVpdqm
	 8NnYnjhoqMe6w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4AA6E17E1564;
	Mon, 17 Feb 2025 16:50:11 +0100 (CET)
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
Subject: [PATCH v7 37/43] drm/mediatek: mtk_hdmi_common: Make CEC support optional
Date: Mon, 17 Feb 2025 16:48:30 +0100
Message-ID: <20250217154836.108895-38-angelogioacchino.delregno@collabora.com>
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

In preparation for adding a new driver for HDMIv2, for which CEC
is not strictly required, change the of_get_compatible_child()
failure error to -ENOTSUPP to be able to differentiate between
error conditions in mtk_hdmi_dt_parse_pdata().

In that case, if -ENOTSUPP is returned, this driver will print
an informative message saying that CEC support is unavailable,
as the devicetree node for that was not found, but after that,
function mtk_hdmi_dt_parse_pdata() will not return error to
the caller.

This will not change functionality of the mtk_hdmi (v1) driver
as that is still checking whether CEC is present and, if not,
will fail probing with an error saying that CEC is required
by HDMIv1.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 3dfde63198e5..5ea45608921c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -254,12 +254,11 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 	/* The CEC module handles HDMI hotplug detection */
 	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np)
-		return dev_err_probe(dev, -EINVAL, "Failed to find CEC node\n");
+		return dev_err_probe(dev, -ENOTSUPP, "Failed to find CEC node\n");
 
 	cec_pdev = of_find_device_by_node(cec_np);
 	if (!cec_pdev) {
-		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
-			cec_np);
+		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n", cec_np);
 		of_node_put(cec_np);
 		return -EPROBE_DEFER;
 	}
@@ -323,7 +322,9 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device
 		return dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c adapter by node\n");
 
 	ret = mtk_hdmi_get_cec_dev(hdmi, dev, np);
-	if (ret)
+	if (ret == -ENOTSUPP)
+		dev_info(dev, "CEC support unavailable: node not found\n");
+	else if (ret)
 		return ret;
 
 	return 0;
-- 
2.48.1


