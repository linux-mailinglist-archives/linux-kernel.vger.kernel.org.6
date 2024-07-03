Return-Path: <linux-kernel+bounces-239096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B992562B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D641C22D14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A5C13C3D3;
	Wed,  3 Jul 2024 09:10:56 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4613BAE5;
	Wed,  3 Jul 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997856; cv=none; b=g4INeW+ub0495MH5Z2YndqWj8doapyrU7x1jim+IzrSr0easCMp8leSQ5KqlMCTcHJXvsSoFxXfY4EpMA+IWbapX1IQ7mG1828lZkxa5tV/QnLOtcjGnkMvkK1P4xhuT2UtdAD6L50P5OrOr35O9G0uALvKYSobv0PfXMPL8iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997856; c=relaxed/simple;
	bh=NQlx3gZGv3Sa0HaSIw7eAGKniKFtv98EAfSVKXqEC7w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TYKlOQfRlLFt5Sx+ehNUGDAZcNR5Zs3Yz9VhPGObMvAj3V2+6L+wkpN7xcUQIXakFVH7ooGQMqkmu1JlgDdsuszKX/i0kB2Plt4za/mSEhr3WfXJBlhUaCZ7+oQpQcQSzjB9lmvcnbbdN68E8NL0rVnYpfbUvctyu3XP+5LgTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 591BE201977;
	Wed,  3 Jul 2024 11:10:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F214200508;
	Wed,  3 Jul 2024 11:10:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 69C7C180222B;
	Wed,  3 Jul 2024 17:10:45 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: imx8: Add .name for "acm_aud_clk0_sel" and "acm_aud_clk1_sel"
Date: Wed,  3 Jul 2024 16:52:51 +0800
Message-Id: <1719996771-11220-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

"acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this ACM
driver, but they are the parent clocks for other clocks, in order to
use assigned-clock-parents in device tree, they need to have the
global name.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8-acm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1bdb480cc96c..a1affcf6daff 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -114,8 +114,8 @@ static const struct clk_parent_data imx8qm_mclk_out_sels[] = {
 static const struct clk_parent_data imx8qm_mclk_sels[] = {
 	{ .fw_name = "aud_pll_div_clk0_lpcg_clk" },
 	{ .fw_name = "aud_pll_div_clk1_lpcg_clk" },
-	{ .fw_name = "acm_aud_clk0_sel" },
-	{ .fw_name = "acm_aud_clk1_sel" },
+	{ .fw_name = "acm_aud_clk0_sel", .name = "acm_aud_clk0_sel" },
+	{ .fw_name = "acm_aud_clk1_sel", .name = "acm_aud_clk1_sel" },
 };
 
 static const struct clk_parent_data imx8qm_asrc_mux_clk_sels[] = {
@@ -179,8 +179,8 @@ static const struct clk_parent_data imx8qxp_mclk_out_sels[] = {
 static const struct clk_parent_data imx8qxp_mclk_sels[] = {
 	{ .fw_name = "aud_pll_div_clk0_lpcg_clk" },
 	{ .fw_name = "aud_pll_div_clk1_lpcg_clk" },
-	{ .fw_name = "acm_aud_clk0_sel" },
-	{ .fw_name = "acm_aud_clk1_sel" },
+	{ .fw_name = "acm_aud_clk0_sel", .name = "acm_aud_clk0_sel" },
+	{ .fw_name = "acm_aud_clk1_sel", .name = "acm_aud_clk1_sel" },
 };
 
 static struct clk_imx8_acm_sel imx8qxp_sels[] = {
@@ -231,8 +231,8 @@ static const struct clk_parent_data imx8dxl_mclk_out_sels[] = {
 static const struct clk_parent_data imx8dxl_mclk_sels[] = {
 	{ .fw_name = "aud_pll_div_clk0_lpcg_clk" },
 	{ .fw_name = "aud_pll_div_clk1_lpcg_clk" },
-	{ .fw_name = "acm_aud_clk0_sel" },
-	{ .fw_name = "acm_aud_clk1_sel" },
+	{ .fw_name = "acm_aud_clk0_sel", .name = "acm_aud_clk0_sel" },
+	{ .fw_name = "acm_aud_clk1_sel", .name = "acm_aud_clk1_sel" },
 };
 
 static struct clk_imx8_acm_sel imx8dxl_sels[] = {
-- 
2.34.1


