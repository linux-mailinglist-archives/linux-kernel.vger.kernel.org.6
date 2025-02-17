Return-Path: <linux-kernel+bounces-517978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE7A3884A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035603B4F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A222617A;
	Mon, 17 Feb 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gK63fus5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367022618F;
	Mon, 17 Feb 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807373; cv=none; b=ZHdBe0vnR6nEfHStklWk7MCAYEYZe5M/jsESxGqQfI2M3jVBDCznSK+5hNHmT9B6y5I88tsfqzmg2G6kVa24SW8fo2hD14XiWTzg4hqFzWY74jGHmOLfTPA+E+4qY9AC0ryHgpUrp0kBkp8OLyENZlx3b4YSgnN3Tud/ha2wpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807373; c=relaxed/simple;
	bh=q8QjgMVTJZEFe0IhIhfYlFT2rh4mUpbbyjiEW2CLxBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijCw2GAaboWcvcI5BkO9ZRpfyzXlcpFjNw7Hoi6NptLVr4ckWUko30DHWAytQib6T+z+tIvJZF1air4gPqOm+rFqOmfEhQvmBlmxuxnzX55LBfY81v8TY30RSr+bcHHB28UXArXyb4awLE3jFdn9YwJUZ2DpZWKAObFx8nesSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gK63fus5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807370;
	bh=q8QjgMVTJZEFe0IhIhfYlFT2rh4mUpbbyjiEW2CLxBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK63fus5df5O2husQLVacq7tCzLiRXFP96GxcvOy35wYCTmZvCQYYYLsh6qyx9Vg5
	 zqiVKevj1zXo729kKZYHLuxvWKWtfKrtHSk3fjHI/49byq+RST935T0h8DabynxUNN
	 zgdvkC3SeYvpzFsvr/KhhlovOmqB6JYsZLc0ZA3AzmXGPPtrcqSyW09DqwppZiu1CW
	 dyMX+OnPTtdcZ1FwFIwlJDaQxh2nLeBMt5Zjuv3sNoY7vwVHJCdgATa5r3npT7Oh4E
	 eEc78GcbFJFW3zP+2xBsuAYXrjaXZK2rNnRxzZy8l1nhBSQwIPyv/Pit4wOLjW/pPj
	 2QhzDTVnuL1BQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D766017E1562;
	Mon, 17 Feb 2025 16:49:28 +0100 (CET)
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
Subject: [PATCH v7 09/43] drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off
Date: Mon, 17 Feb 2025 16:48:02 +0100
Message-ID: <20250217154836.108895-10-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for MT8195's HDMI reserved
DPI, add calls to clk_prepare_enable() / clk_disable_unprepare()
for the TVD clock: in this particular case, the aforementioned
clock is not (and cannot be) parented to neither pixel or engine
clocks hence it won't get enabled automatically by the clock
framework.

Please note that on all of the currently supported MediaTek
platforms, the TVD clock is always a parent of either pixel or
engine clocks, and this means that the common clock framework
is already enabling this clock before the children.
On such platforms, this commit will only increase the refcount
of the TVD clock without any functional change.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index e12dc73ed79c..ee952785866c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -499,6 +499,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -515,6 +516,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_engine;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
@@ -524,6 +531,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
-- 
2.48.1


