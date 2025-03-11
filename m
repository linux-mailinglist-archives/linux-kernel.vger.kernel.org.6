Return-Path: <linux-kernel+bounces-555528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FBA5B91D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259117A1908
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C3215F49;
	Tue, 11 Mar 2025 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hlqCPBvZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD951EEA5E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741673840; cv=none; b=EB7C4EPU2TUXYvOKxRO//fvjnSML6fbO3+TCmY7j4EgU5F96t9vp54fAO9YMhQwxp6jHqpet84PlEoabk+taAO8hyfy+VVYFDlz7VzvFF9GM49xtJci9Y25u6NZTaDyCS3y2R+pYyolVHRq5ymZh8PZ3+uKNEVnNTEYcA1he8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741673840; c=relaxed/simple;
	bh=+c3rP9l5bYRgyQgzqdBiyBHNs0Vnao3tQSZD7Jt0tYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6RgX8EGBZB0y1StKK2//pZ0DxoKZ/7L715xCVatws+HZEVoJA42ANaZPzY2qhrsqnkNHsJ0GRmkfblU0eZeMh2/ids5IeEhzfY6ElIYVcM7Wds7hcpLL6d3kbZX7XY8mIPz/RpFuAwRbQm3jDXde73r4AU/ctFEWhDJZTgqOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hlqCPBvZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741673834;
	bh=+c3rP9l5bYRgyQgzqdBiyBHNs0Vnao3tQSZD7Jt0tYs=;
	h=From:To:Cc:Subject:Date:From;
	b=hlqCPBvZMIIR/XIcU/pmYxeSrxXNRMeqE9xR9QTJ4wXTEUxs3Y5jTim9sw3HRYpoo
	 G9Cn9/HfnD3xKt+3i25/+u69Cp8WQdO2kILlNGOm0ZQQzj2WZiCegRAcj3h4BfjBgo
	 VaEMtjKwNyMgXHqC/wI4Gi0ru52KWtdJYM2pMqESWC7BDS+FL1uGabefiNeANI4YDQ
	 meYujK8q04Tv57hsOWrV2qC21mWV9/qEC7fYfV0Z/6oRhzSUIglMjB9katfKwnTNME
	 0x5hVGViqbiWqg/agYeAKgAPkvrxm8tXPrzRFGCaEh+7Y5ZI+BbWGjm/RbKMKfQtvT
	 dh/bFTY9YsGpw==
Received: from localhost.localdomain (unknown [103.163.65.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1F9617E05C1;
	Tue, 11 Mar 2025 07:17:12 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	nfraprado@collabora.com,
	angelogioacchino.delregno@collabora.com,
	daniels@collabora.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: defconfig: mediatek: enable PHY drivers
Date: Tue, 11 Mar 2025 11:46:59 +0530
Message-ID: <20250311061703.16850-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mediatek display driver fails to probe on mt8173 and mt8183 in
v6.14-rc4, with the following errors:

mt8173:
platform 1401b000.dsi: deferred probe pending: mtk-dsi: Failed to get hs clock
platform 14025000.hdmi: deferred probe pending: (reason unknown)
i2c 1-0008: deferred probe pending: (reason unknown)

mt8183:
platform 14014000.dsi: deferred probe pending: mtk-dsi: Failed to get hs clock
i2c 4-0058: deferred probe pending: anx7625: fail to find dsi host.

Enabling CONFIG_PHY_MTK_MIPI_DSI=y in drm-ci resolves this error,
but mt8173 still fails with,

[drm:mtk_dsi_host_attach] *ERROR* failed to add dsi_host component: -517
panel-simple-dp-aux aux-1-0008: DP AUX done_probing() can't defer
panel-simple-dp-aux aux-1-0008: probe with driver panel-simple-dp-aux failed with error -22

Enabling CONFIG_PHY_MTK_XSPHY=y and CONFIG_PHY_MTK_HDMI=y in drm-ci
resolves this issue for mt8173.

So enable these PHY configs for mediatek platforms.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f25423de383..09aedc3447b7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1573,6 +1573,9 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_MIPI_DSI=m
+CONFIG_PHY_MTK_XSPHY=m
+CONFIG_PHY_MTK_HDMI=m
 CONFIG_PHY_QCOM_EDP=m
 CONFIG_PHY_QCOM_PCIE2=m
 CONFIG_PHY_QCOM_QMP=m
-- 
2.47.2


