Return-Path: <linux-kernel+bounces-261969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5771E93BECC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009641F2227F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BF197A7B;
	Thu, 25 Jul 2024 09:14:04 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2A196D9E;
	Thu, 25 Jul 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898844; cv=none; b=njHIviaSbm0eHUhUnnn8lfLxxfCc/Ls0ctMpzjVocZq5tQMpP17HDBKlA910i9JqJr7GE0mOZYb4H39kejCGEzU2PRJ4lHfxKSmQQ3kNnyDR7FYBMbi6QMF7i69DDu2Nrz1cDcNOrWTBAAjnRHvIS1FDhDFLQI4dgbp/6PWtfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898844; c=relaxed/simple;
	bh=6246fXnwCejdwvRR+WaV7yd8tVAr4cMG7Uezj8q2PYs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=mlGVVCevOS5RIW7E9iF0PAuW4fbeodrhPv4m1Ea8r0w6UIqqtUg3QQ7j2Tp/H79o/OzUCBw+tYdpUvNdDZJ+NNGbDrp0NMA0gNGCojSkXvmFk0ZUaSWL7fSw7kAP94GpgrnyBfXR/YieiSt1TK17ynZgbkHBt6WeLyjdiJrExGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC2EB2023A5;
	Thu, 25 Jul 2024 11:14:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B138F2023A6;
	Thu, 25 Jul 2024 11:14:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 19CE7180222B;
	Thu, 25 Jul 2024 17:13:59 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl_micfil: Expand the range of FIFO watermark mask
Date: Thu, 25 Jul 2024 16:54:53 +0800
Message-Id: <1721897694-6088-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721897694-6088-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721897694-6088-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On the i.MX9x platforms, the mask of FIFO watermark
is 0x1F, on i.MX8x platforms, the mask of FIFO watermark
is 0X7. So use the mask 0x1F for all platforms to make them
compatible.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 2 +-
 sound/soc/fsl/fsl_micfil.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 0d37edb70261..96a6b88d0d67 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -831,7 +831,7 @@ static const struct reg_default fsl_micfil_reg_defaults[] = {
 	{REG_MICFIL_CTRL1,		0x00000000},
 	{REG_MICFIL_CTRL2,		0x00000000},
 	{REG_MICFIL_STAT,		0x00000000},
-	{REG_MICFIL_FIFO_CTRL,		0x00000007},
+	{REG_MICFIL_FIFO_CTRL,		0x0000001F},
 	{REG_MICFIL_FIFO_STAT,		0x00000000},
 	{REG_MICFIL_DATACH0,		0x00000000},
 	{REG_MICFIL_DATACH1,		0x00000000},
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index c6b902ba0a53..b7798a7cbf2a 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -72,7 +72,7 @@
 #define MICFIL_STAT_CHXF(ch)		BIT(ch)
 
 /* MICFIL FIFO Control Register -- REG_MICFIL_FIFO_CTRL 0x10 */
-#define MICFIL_FIFO_CTRL_FIFOWMK	GENMASK(2, 0)
+#define MICFIL_FIFO_CTRL_FIFOWMK	GENMASK(4, 0)
 
 /* MICFIL FIFO Status Register -- REG_MICFIL_FIFO_STAT 0x14 */
 #define MICFIL_FIFO_STAT_FIFOX_OVER(ch)	BIT(ch)
-- 
2.34.1


