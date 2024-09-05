Return-Path: <linux-kernel+bounces-316533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18A96D0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E01C247F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370D1946D0;
	Thu,  5 Sep 2024 07:51:02 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7E1940AA;
	Thu,  5 Sep 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522662; cv=none; b=PtPgsmKI+9WI4JziwJAGp8kYXW3M6cvfjoVeczu/UhRHKE5mg7V8MqqRMSSLbpH1ODnN+xDBVc0UfR7xy/tzLsanb+h1RsKDTw8V2OkRMNwCruR68Fe0H1ogPfAzI9QqBzjI9eo5FRbZ+y7cIRam32WMh2DkXqsFq7Nr5rix2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522662; c=relaxed/simple;
	bh=KrI/Gt9oGydJExzaoxEEfc2GgZCVqq6G4OT0XV5zzog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JOTGN3hhh2JMnmC0wJsRy4/LtaElxhye5eek2vA3kCreYsojtsuN0Ek2eWgl9gFfO3v2bmrlCEJXA3EoFH95bzCkSTlQErmfQpWr730TkMSzf6SEKdPVlGiRqQep3X+Fxku+tK1EoCxUEPu00zD5fl7b6lOWkUVXBgwE3EoaltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9AF81A0CBF;
	Thu,  5 Sep 2024 09:50:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B242F1A1800;
	Thu,  5 Sep 2024 09:50:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BFEF9180031E;
	Thu,  5 Sep 2024 15:50:56 +0800 (+08)
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
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block
Date: Thu,  5 Sep 2024 15:29:37 +0800
Message-Id: <1725521377-22645-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1725521377-22645-1-git-send-email-hongxing.zhu@nxp.com>
References: <1725521377-22645-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

CREF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
enable/disable.

Add compatible string "fsl,imx95-hsio-blk-ctl" to support PCIe REF clock
out gate.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 74f595f9e5e3..596dfb2f3b75 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -248,6 +248,25 @@ static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
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
@@ -418,6 +437,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-display-master-csr", },
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
 	{ /* Sentinel */ },
 };
-- 
2.37.1


