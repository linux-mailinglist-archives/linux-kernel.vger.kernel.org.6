Return-Path: <linux-kernel+bounces-365287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B601299E003
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DA11F22D71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7E1CACC9;
	Tue, 15 Oct 2024 07:57:48 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D91C0DE2;
	Tue, 15 Oct 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979067; cv=none; b=hT1Urzv9AyIF9Ds9mWZ0MNwdVa9yWNc6QtiMJq03wgqiT/1RFrGVbjHuAkdGTc/a6HGDS6hiXv1RpGjOFLrqqJ7yJj8ewdUE7GIvFmFb+gMojqfqUaZ6toT9t4Iwjxl20CgZ9HLPDptrphJ1AX3yqjje+USfeW7alPX34Nlhj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979067; c=relaxed/simple;
	bh=+W7tmOplPpwq8DoVsxdIHh6sDNgpjkPfm6+bC2x1s7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OeyTNLLiXHDVxeVI4bQgPAeeW3AX1MXW0/nO5o/9Mv+9OI11+1nWfxL9iEeYa5Qlpb3B6SW+G0ZQWpf+bjHeohi7OTS/fI8JJIo5dg2WRYCCMYNOhAT8oqqDE9OKq1L47qaBw3TpSd57K3tmjtLPG4ERwhbvSqiho4y4tdrQG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74D5E2001C1;
	Tue, 15 Oct 2024 09:57:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 33BA620055E;
	Tue, 15 Oct 2024 09:57:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 33C5B183DC03;
	Tue, 15 Oct 2024 15:57:36 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block
Date: Tue, 15 Oct 2024 15:34:04 +0800
Message-Id: <1728977644-8207-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

CREF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
enable/disable.

Add compatible string "nxp,imx95-hsio-blk-ctl" to support PCIe REF clock
out gate.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 19a62da74be4..25974947ad0c 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -277,6 +277,25 @@ static const struct imx95_blk_ctl_dev_data netcmix_dev_data = {
 	.clk_reg_offset = 0,
 };
 
+static const struct imx95_blk_ctl_clk_dev_data hsio_blk_ctl_clk_dev_data[] = {
+	[0] = {
+		.name = "hsio_blk_ctl_clk",
+		.parent_names = (const char *[]){ "hsio_pll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
+	.num_clks = 1,
+	.clk_dev_data = hsio_blk_ctl_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
 static int imx95_bc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -447,6 +466,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-display-master-csr", },
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
 	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", .data = &netcmix_dev_data},
 	{ /* Sentinel */ },
-- 
2.37.1


