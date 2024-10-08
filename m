Return-Path: <linux-kernel+bounces-354587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D1993F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEED41F252F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B11C1737;
	Tue,  8 Oct 2024 06:52:01 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10216BE23;
	Tue,  8 Oct 2024 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370320; cv=none; b=cuutEa6cQjE7VXcvQxI8NkZRauY/VrVsjsB3AeoVHLWRVaexkuzmUKz0SNjIwiouYoYriWMfhAwa+DF3mEWS1hMDBN6tVHeCJpN1h3/RtOXEEEg8P7GA/k80XqLP3CWzss2SJDdP5rxmSEEG/sdAY871CJerzNLL8q8GN5abfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370320; c=relaxed/simple;
	bh=GUvhzlzFzjridXdFhrrGBeRXP9UI7+yDU7tLFIai60w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=A76Lq/IN4241AiHM/7dulnIj2Hs0l9IWl4JY/LxNc4TO1SgFATRmItXJd6yGxOTqA7EwpCni7vgxVfri+RZo3am3diF9vR8nzrU16eMhfg4eNcaIBtXVhzaK0nMImzF4NBBOHjtrPRHDizi7VYYRst6aKf0pPCmmj9KAAJyt/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D9A5200269;
	Tue,  8 Oct 2024 08:51:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03EA1200222;
	Tue,  8 Oct 2024 08:51:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 55889183B721;
	Tue,  8 Oct 2024 14:51:03 +0800 (+08)
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
Subject: [PATCH 1/2] ASoC: fsl_xcvr: enable interrupt of cmdc status update
Date: Tue,  8 Oct 2024 14:27:52 +0800
Message-Id: <1728368873-31379-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728368873-31379-1-git-send-email-shengjiu.wang@nxp.com>
References: <1728368873-31379-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This enables the interrupt to be asserted when there
is a change in Capabilities data structure / Latency
request of the CMDC Status register.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 4 ++++
 sound/soc/fsl/fsl_xcvr.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index beede7344efd..9e24d6462c01 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1265,6 +1265,10 @@ static irqreturn_t irq0_isr(int irq, void *devid)
 		dev_dbg(dev, "DMA write request\n");
 		isr_clr |= FSL_XCVR_IRQ_DMA_WR_REQ;
 	}
+	if (isr & FSL_XCVR_IRQ_CMDC_STATUS_UPD) {
+		dev_dbg(dev, "CMDC status update\n");
+		isr_clr |= FSL_XCVR_IRQ_CMDC_STATUS_UPD;
+	}
 
 	if (isr_clr) {
 		regmap_write(regmap, FSL_XCVR_EXT_ISR_CLR, isr_clr);
diff --git a/sound/soc/fsl/fsl_xcvr.h b/sound/soc/fsl/fsl_xcvr.h
index 882428592e1a..ce27b13698e7 100644
--- a/sound/soc/fsl/fsl_xcvr.h
+++ b/sound/soc/fsl/fsl_xcvr.h
@@ -165,6 +165,7 @@
 					 FSL_XCVR_IRQ_MUTE | \
 					 FSL_XCVR_IRQ_FIFO_UOFL_ERR | \
 					 FSL_XCVR_IRQ_HOST_WAKEUP | \
+					 FSL_XCVR_IRQ_CMDC_STATUS_UPD |\
 					 FSL_XCVR_IRQ_ARC_MODE)
 
 #define FSL_XCVR_ISR_CMDC_TX_EN		BIT(3)
-- 
2.34.1


