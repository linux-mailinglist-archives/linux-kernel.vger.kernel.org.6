Return-Path: <linux-kernel+bounces-510881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12213A32323
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F1C164D47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCE209F31;
	Wed, 12 Feb 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aWlTfeJa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452E2066C5;
	Wed, 12 Feb 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354646; cv=none; b=e5TIrspumSfgzKJdFdIKD3yPTw34IN1O1A6QiUrqQJ+gzRQvdz8VWzlDNOfkQ9Kr+fKLq7cwPlALQT9TGofWVSDM0DHDpkk763XPw6WjRm4yTQnHZ6kFdrgCjDX2r6kDLYvJgLRIUbXa9njq6vUTZel4DKrnNywGBheUEZwNj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354646; c=relaxed/simple;
	bh=k/RUvzzosIlMaN4wLtBvyAmJ1Kbx1W1GZa907HCOqbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsWDn3uCVKUutSszPsdZlo5Zyuegm35RDvpOqVgc7vaT14nGCQBmiczJiFPxvNq3gxagv9gE+BOqXCFSZ3RFdU+mqH670CeRGDY/1mqqJxwZ6EsJD8rRcK+SJoeo1MzuKOiCtH+06E+8lTtJtL+HjBMU3Q1dD8CD1cQFkZ0oD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aWlTfeJa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354642;
	bh=k/RUvzzosIlMaN4wLtBvyAmJ1Kbx1W1GZa907HCOqbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWlTfeJaksqtJNVpk8S9gu7NRwCnqOnCR6JTmPOp+FTlOr0hHb8ETY99f9QB5csKy
	 4teTuG5DuLfIaZpN9DJO6OMEOOr4B5BX1SpJGbfQczueLXpVxjMVy5AqWcSTD7s5EQ
	 7v9UDh/QVdJkYooGM0yRTk5qTK15ORL88DA6Z2mYWuFQXgQDK7elFqFNdJjcrtrkQq
	 zQKzfOZTG4RYyHmg85iaApiGx0nr/1dVMeVkRV2U8/OLg+GYuu1jeX3FKqd7Aa7d13
	 itxls/UQce4keu02YHwslnKn1PIEL0NTpyGN3e4eD28QhR7OxL2q5vzV+qZ7FVsAgX
	 oC1maJfjsOUpQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5BAE217E0F68;
	Wed, 12 Feb 2025 11:04:01 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	u.kleine-koenig@baylibre.com,
	amergnat@baylibre.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	macpaul.lin@mediatek.com,
	pablo.sun@mediatek.com
Subject: [PATCH v2 2/2] clk: mediatek: mt8188-vdo1: Add VDO1_DPI1_HDMI clock for hdmitx
Date: Wed, 12 Feb 2025 11:03:42 +0100
Message-ID: <20250212100342.33618-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
References: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing clock found in the VDO1 controller for the HDMI TX
controller over DPI1.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8188-vdo1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8188-vdo1.c b/drivers/clk/mediatek/clk-mt8188-vdo1.c
index 4fa355f8f0c2..f715d45e545e 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo1.c
@@ -43,6 +43,12 @@ static const struct mtk_gate_regs vdo1_4_cg_regs = {
 	.sta_ofs = 0x140,
 };
 
+static const struct mtk_gate_regs vdo1_5_cg_regs = {
+	.set_ofs = 0x400,
+	.clr_ofs = 0x400,
+	.sta_ofs = 0x400,
+};
+
 #define GATE_VDO1_0(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo1_0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
@@ -62,6 +68,9 @@ static const struct mtk_gate_regs vdo1_4_cg_regs = {
 #define GATE_VDO1_4(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo1_4_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_VDO1_5(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo1_5_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
 static const struct mtk_gate vdo1_clks[] = {
 	/* VDO1_0 */
 	GATE_VDO1_0(CLK_VDO1_SMI_LARB2, "vdo1_smi_larb2", "top_vpp", 0),
@@ -129,6 +138,8 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_3(CLK_VDO1_DISP_MONITOR_DPINTF, "vdo1_disp_monitor_dpintf_ck", "top_vpp", 17),
 	/* VDO1_4 */
 	GATE_VDO1_4(CLK_VDO1_26M_SLOW, "vdo1_26m_slow_ck", "clk26m", 8),
+	/* VDO1_5 */
+	GATE_VDO1_5(CLK_VDO1_DPI1_HDMI, "vdo1_dpi1_hdmi", "hdmi_txpll", 0),
 };
 
 static const struct mtk_clk_desc vdo1_desc = {
-- 
2.48.1


