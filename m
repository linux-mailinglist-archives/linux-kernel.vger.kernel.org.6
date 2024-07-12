Return-Path: <linux-kernel+bounces-250682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F192FB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1B11F23130
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2216FF2A;
	Fri, 12 Jul 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tCUViSfI"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D5173344
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790132; cv=none; b=kmZqzPdepEvsEWgnax2BTxu7pQcRqGOFPg9BZHxmn2oC9WNj+XOl2km8jXjGiVp8BIqzLTOKKpvQUfPMYTlQJ1HhJM36NC/Zn65BGJjHOcMGwzuueTAxB5Li40t3A3Qd/ixnmPtRNFvWZHmSpWx4D1sxMzuQXlBqGAbtEVovU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790132; c=relaxed/simple;
	bh=WqsoBGpXREWYWrdzm6gUmVAExR8ppxjfgwC+XGjnGxw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHreF/l1Y4Rc9jFQQxe669ncfLs1t3OJHiicu7pmz6O0ybjf6CFADaEn2fdWaOlUoJO9UgLMnn+2S6OTS5Et90QJYc24NAZhyteKSomKgF11v1eigT9iUG5x9EmoLY3SEWEmEbv9JB6wYRth4PFUaHxobXsKqmepr9YoFYCKYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tCUViSfI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C89Xgj002842;
	Fri, 12 Jul 2024 15:15:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=WYgtUxOsPJNb2E3kFeNTvk
	Q2/fdwenANgMvmftG8sr4=; b=tCUViSfIC3FTlXEd1FtbiE6kiTqjiRY/oXQOa9
	CTRy3hvlKrGjzzEUuvFyver4NXftPiuS0sbY7ldNeCGdvgEuLMYJgZoZByMpNE7e
	kSyYhe2FEmaPKFqIDj2w8R4pk9q6jWJg/GFx7hXl1VyEtB4T4yScyRr69ozXdr09
	6Ni7up/LEAceuYPumr3JcM3WDIsiAszlkm3KaOeFCmzJlp5EZPW/Wti6YLSoDtMS
	53srUzMCorn5nGopqHYOT0HThkH4hHal5JeltgSvIGQS/veY0TKnlfd6y99y+1rX
	CXSq3Dd2sCD/S+gunvlFx/xkYRL9eHwaliBSFyW6N+wmRhvA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 406whj2ejr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:15:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 622FE4002D;
	Fri, 12 Jul 2024 15:15:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4759D20CB27;
	Fri, 12 Jul 2024 15:14:26 +0200 (CEST)
Received: from localhost (10.252.16.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 12 Jul
 2024 15:14:25 +0200
From: Yannick Fertre <yannick.fertre@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: add mask for lxcr register
Date: Fri, 12 Jul 2024 15:14:23 +0200
Message-ID: <20240712131423.98405-1-yannick.fertre@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01

The purpose of this mask is to simplify writing to the lxcr
register and not to forget any fields.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index cb4f08673a64..3876346a1303 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -187,6 +187,7 @@
 #define LXCR_COLKEN	BIT(1)		/* Color Keying Enable */
 #define LXCR_CLUTEN	BIT(4)		/* Color Look-Up Table ENable */
 #define LXCR_HMEN	BIT(8)		/* Horizontal Mirroring ENable */
+#define LXCR_MASK (LXCR_LEN | LXCR_COLKEN | LXCR_CLUTEN | LXCR_HMEN)
 
 #define LXWHPCR_WHSTPOS	GENMASK(11, 0)	/* Window Horizontal StarT POSition */
 #define LXWHPCR_WHSPPOS	GENMASK(27, 16)	/* Window Horizontal StoP POSition */
@@ -806,8 +807,7 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	/* Disable all layers */
 	for (layer_index = 0; layer_index < ldev->caps.nb_layers; layer_index++)
-		regmap_write_bits(ldev->regmap, LTDC_L1CR + layer_index * LAY_OFS,
-				  LXCR_CLUTEN | LXCR_LEN, 0);
+		regmap_write_bits(ldev->regmap, LTDC_L1CR + layer_index * LAY_OFS, LXCR_MASK, 0);
 
 	/* disable IRQ */
 	regmap_clear_bits(ldev->regmap, LTDC_IER, IER_FUWIE | IER_FUEIE | IER_RRIE | IER_TERRIE);
@@ -1474,7 +1474,7 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
 	if (newstate->rotation & DRM_MODE_REFLECT_X)
 		val |= LXCR_HMEN;
 
-	regmap_write_bits(ldev->regmap, LTDC_L1CR + lofs, LXCR_LEN | LXCR_CLUTEN | LXCR_HMEN, val);
+	regmap_write_bits(ldev->regmap, LTDC_L1CR + lofs, LXCR_MASK, val);
 
 	/* Commit shadow registers = update plane at next vblank */
 	if (ldev->caps.plane_reg_shadow)
@@ -1512,7 +1512,7 @@ static void ltdc_plane_atomic_disable(struct drm_plane *plane,
 	u32 lofs = plane->index * LAY_OFS;
 
 	/* Disable layer */
-	regmap_write_bits(ldev->regmap, LTDC_L1CR + lofs, LXCR_LEN | LXCR_CLUTEN |  LXCR_HMEN, 0);
+	regmap_write_bits(ldev->regmap, LTDC_L1CR + lofs, LXCR_MASK, 0);
 
 	/* Reset the layer transparency to hide any related background color */
 	regmap_write_bits(ldev->regmap, LTDC_L1CACR + lofs, LXCACR_CONSTA, 0x00);
-- 
2.34.1


