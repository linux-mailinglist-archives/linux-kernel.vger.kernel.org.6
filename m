Return-Path: <linux-kernel+bounces-174087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E38C0A16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEF31C21C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C7148839;
	Thu,  9 May 2024 03:18:46 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7F14831D;
	Thu,  9 May 2024 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224725; cv=none; b=EQxzC89jJfq1nH+0wLK9ZpMqvDVfmORWQ4HVa1voWRXUdm6z6125L9RcyrExuSJ30TbRC8wSeh7bTNyT2bP7uRakOa28EgWHpgCOndanujrecrRd48eltgR5PvnFeP8dnvgc/vcUiSpOLqe+kIUnekzPyjo8QmB8H6tGCeZf3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224725; c=relaxed/simple;
	bh=VGDmCzZ+i4TZSCedBs+r4B2MJ2hukWvZ1niBtixa1e4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=CR58TTkFKcPLhyRzpsxWB/fUScq7vDlmIBWXoDleQLhwISevroRxFgMF7EkRDc5Z6vB9NmQ56APUDGQStB6Y4pfYi0gU6pN1E3UsHFbO+2h8W7Zh2vrbQW7jSe3qTa2VrcGrLoaKlgAkjekZK5YERi6DZ+RHwGkJch2VehLRSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90A97200AA9;
	Thu,  9 May 2024 05:18:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 456D42007D5;
	Thu,  9 May 2024 05:18:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B099181D0FC;
	Thu,  9 May 2024 11:18:40 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] ASoC: fsl_xcvr: Support reparent pll clocks for phy_clk
Date: Thu,  9 May 2024 10:57:39 +0800
Message-Id: <1715223460-32662-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When there are 'pll8k' and 'pll11k' clock existing, the clock
source of 'phy_clk' can be changed for different sample rate
requirement.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index c46f64557a7f..0ffa10e924ef 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -15,6 +15,7 @@
 #include <sound/pcm_params.h>
 
 #include "fsl_xcvr.h"
+#include "fsl_utils.h"
 #include "imx-pcm.h"
 
 #define FSL_XCVR_CAPDS_SIZE	256
@@ -33,6 +34,8 @@ struct fsl_xcvr {
 	struct clk *pll_ipg_clk;
 	struct clk *phy_clk;
 	struct clk *spba_clk;
+	struct clk *pll8k_clk;
+	struct clk *pll11k_clk;
 	struct reset_control *reset;
 	u8 streams;
 	u32 mode;
@@ -362,6 +365,8 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 
 	freq = xcvr->soc_data->spdif_only ? freq / 5 : freq;
 	clk_disable_unprepare(xcvr->phy_clk);
+	fsl_asoc_reparent_pll_clocks(dev, xcvr->phy_clk,
+				     xcvr->pll8k_clk, xcvr->pll11k_clk, freq);
 	ret = clk_set_rate(xcvr->phy_clk, freq);
 	if (ret < 0) {
 		dev_err(dev, "Error while setting AUD PLL rate: %d\n", ret);
@@ -1287,6 +1292,9 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return PTR_ERR(xcvr->pll_ipg_clk);
 	}
 
+	fsl_asoc_get_pll_clocks(dev, &xcvr->pll8k_clk,
+				&xcvr->pll11k_clk);
+
 	xcvr->ram_addr = devm_platform_ioremap_resource_byname(pdev, "ram");
 	if (IS_ERR(xcvr->ram_addr))
 		return PTR_ERR(xcvr->ram_addr);
-- 
2.34.1


