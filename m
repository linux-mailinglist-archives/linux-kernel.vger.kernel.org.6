Return-Path: <linux-kernel+bounces-178535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FC8C4F22
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6764280E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440913AD03;
	Tue, 14 May 2024 09:54:27 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81577548FD;
	Tue, 14 May 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680466; cv=none; b=Dshqlt1r61/XX5LKtDBWz7rdbVbhH8ZbRtFduXR40und4nGjkE8Et2ejzaAfKrFAHOsfvufX84051BOUrbnE8p3t70uuJMb/c8453RshNby+kc3A7XAmEzSGZHo7FhEeTUSXqXeM1RxNDDtetU2/sowMWqkUSZiDfS/krpmCjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680466; c=relaxed/simple;
	bh=BFBMRM2lGg2wDx/pSbXYe8CjMwM8hP7SsCbNTvVCX1g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=c61HazQyiV3GV2yHcbCt5WI5F129+BgBb/o7j+CVG2Pu+S5H4z8ZvVwRmHThuIz2upBPHDQVHk9tYlxnPxVfUwwnkOH07puVbMvTroOzvHbOkVRZnTwsMUPBL95y07CtRIY9MFlkQuJwpufW+3o8NgO6nS5ad3z4MDB3rVSTtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CB941A0C0A;
	Tue, 14 May 2024 11:53:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 451FF1A07AE;
	Tue, 14 May 2024 11:53:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F36D1180226C;
	Tue, 14 May 2024 17:53:00 +0800 (+08)
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
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 5/6] clk: imx: clk-audiomix: Corrent parent clock for earc_phy and audpll
Date: Tue, 14 May 2024 17:33:29 +0800
Message-Id: <1715679210-9588-6-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
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
index 466b5b0d665c..f4a02ae7e64f 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -154,6 +154,15 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
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
@@ -171,14 +180,14 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
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


