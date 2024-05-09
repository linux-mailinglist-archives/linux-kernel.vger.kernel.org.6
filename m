Return-Path: <linux-kernel+bounces-174049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C48C099D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5312A1F22253
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB413C9AB;
	Thu,  9 May 2024 02:03:42 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AE13D26D;
	Thu,  9 May 2024 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220221; cv=none; b=iQBDukAWRyRAIzKfaKWR6qSB5QX+XsbOI6ha3QRb/kUaCOSnc1dtTIID6Il+h4PhQw4sYsjtn6sluHvvIcRzDDbD438Y3ZNPUWV1+jsHCswvU2mYac+0xYS2FZUeLx9u/4pjxSwAQfwNsDPlOYslvbG0Cx2AKWS7Q6QxAUealKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220221; c=relaxed/simple;
	bh=eUwcL9aI2F0Cu45RR1S0pmgtx3YEe7LfV3/UpkyDPg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LLbXpEICAGFckcI9fk9JHkQOycYBwtvvhy1mKru2+qg0olO7v5VqVNy6TB+xv6L5IbZgqZ6iO2++/Eh31l/R9jBboATup1L/qmZHO4gxPD96+UV6wLOHkgLDwRNdamD3hI2423cUjadi/nV9kHK0d7DrrGFKiKJJWBvS1MdWykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EAD1E1A1829;
	Thu,  9 May 2024 04:03:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AD2D11A156B;
	Thu,  9 May 2024 04:03:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9D509180222F;
	Thu,  9 May 2024 10:03:30 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] clk: imx: clk-audiomix: Corrent parent clock for earc_phy and audpll
Date: Thu,  9 May 2024 09:43:58 +0800
Message-Id: <1715219038-32453-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

According to Reference Manual of i.MX8MP
The parent clock of "earc_phy" is "sai_pll_out_div2",
The parent clock of "audpll" is "osc_24m".

Add CLK_GATE_PARENT() macro for usage of specifying parent clock.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 6ed44cd5001b..11a29bd46a9e 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -157,6 +157,15 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
 		PDM_SEL, 2, 0						\
 	}
 
+#define CLK_GATE_PARENT(gname, cname, pname)						\
+	{								\
+		gname"_cg",						\
+		IMX8MP_CLK_AUDIOMIX_##cname,				\
+		{ .fw_name = pname, .name = pname }, NULL, 1,		\
+		CLKEN0 + 4 * !!(IMX8MP_CLK_AUDIOMIX_##cname / 32),	\
+		1, IMX8MP_CLK_AUDIOMIX_##cname % 32			\
+	}
+
 struct clk_imx8mp_audiomix_sel {
 	const char			*name;
 	int				clkid;
@@ -174,14 +183,14 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("earc", EARC_IPG),
 	CLK_GATE("ocrama", OCRAMA_IPG),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
-	CLK_GATE("earc_phy", EARC_PHY),
+	CLK_GATE_PARENT("earc_phy", EARC_PHY, "sai_pll_out_div2"),
 	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
 	CLK_GATE("dsp", DSP_ROOT),
 	CLK_GATE("dspdbg", DSPDBG_ROOT),
 	CLK_GATE("edma", EDMA_ROOT),
-	CLK_GATE("audpll", AUDPLL_ROOT),
+	CLK_GATE_PARENT("audpll", AUDPLL_ROOT, "osc_24m"),
 	CLK_GATE("mu2", MU2_ROOT),
 	CLK_GATE("mu3", MU3_ROOT),
 	CLK_PDM,
-- 
2.34.1


