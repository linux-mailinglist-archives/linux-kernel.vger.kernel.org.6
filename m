Return-Path: <linux-kernel+bounces-261970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20A93BECE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCD6283C04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B5197A9A;
	Thu, 25 Jul 2024 09:14:05 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E255197555;
	Thu, 25 Jul 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898845; cv=none; b=EN9X/3eJk813x1Y7BwgfuDabdqFq7kQw3qdqvjMlB/NGsW1NzviE3yeml77pYBkzE/MqEa2Etfvf/uQ8h0rbPw12ZkiT7/j1+dMfj41l9YdtbUVam7WcKEYtXbtuttXAyVWwzfvo4IpF2jNFAu16+a4qG6W/ifZp5TnlqToTRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898845; c=relaxed/simple;
	bh=OVu+AwzZ1DFmeiVH8FBfon+bMVBCK121eB0dGILl95Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=GboctMsiocIvD7W1PYGzkoZBnKoDW/TWc9DVj9HLHV6diJZUQfMniDJzwE5WodiSAUMlQDMvFhb2FRftk1cfjWXrqRr5hpJQZ3C5CWHAz54EnE8lA7t4KowP4C9eOE53v1rH+/dxCTsboDxLwOSShTm92Fo0qmh1Cujjht6e9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F1351A0517;
	Thu, 25 Jul 2024 11:14:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CADEA1A0515;
	Thu, 25 Jul 2024 11:14:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 36826181D0FA;
	Thu, 25 Jul 2024 17:14:00 +0800 (+08)
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
Subject: [PATCH 2/2] ASoC: fsl_micfil: Differentiate register access permission for platforms
Date: Thu, 25 Jul 2024 16:54:54 +0800
Message-Id: <1721897694-6088-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721897694-6088-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721897694-6088-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On i.MX9x platforms, the REG_MICFIL_FSYNC_CTRL, REG_MICFIL_VERID,
REG_MICFIL_PARAM are added, but they are not existed on i.MX8x
platforms.

Use the existed micfil->soc->use_verid to distinguish the access
permission for these platforms.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 96a6b88d0d67..22b240a70ad4 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -855,6 +855,8 @@ static const struct reg_default fsl_micfil_reg_defaults[] = {
 
 static bool fsl_micfil_readable_reg(struct device *dev, unsigned int reg)
 {
+	struct fsl_micfil *micfil = dev_get_drvdata(dev);
+
 	switch (reg) {
 	case REG_MICFIL_CTRL1:
 	case REG_MICFIL_CTRL2:
@@ -872,9 +874,6 @@ static bool fsl_micfil_readable_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_DC_CTRL:
 	case REG_MICFIL_OUT_CTRL:
 	case REG_MICFIL_OUT_STAT:
-	case REG_MICFIL_FSYNC_CTRL:
-	case REG_MICFIL_VERID:
-	case REG_MICFIL_PARAM:
 	case REG_MICFIL_VAD0_CTRL1:
 	case REG_MICFIL_VAD0_CTRL2:
 	case REG_MICFIL_VAD0_STAT:
@@ -883,6 +882,12 @@ static bool fsl_micfil_readable_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_VAD0_NDATA:
 	case REG_MICFIL_VAD0_ZCD:
 		return true;
+	case REG_MICFIL_FSYNC_CTRL:
+	case REG_MICFIL_VERID:
+	case REG_MICFIL_PARAM:
+		if (micfil->soc->use_verid)
+			return true;
+		fallthrough;
 	default:
 		return false;
 	}
@@ -890,6 +895,8 @@ static bool fsl_micfil_readable_reg(struct device *dev, unsigned int reg)
 
 static bool fsl_micfil_writeable_reg(struct device *dev, unsigned int reg)
 {
+	struct fsl_micfil *micfil = dev_get_drvdata(dev);
+
 	switch (reg) {
 	case REG_MICFIL_CTRL1:
 	case REG_MICFIL_CTRL2:
@@ -899,7 +906,6 @@ static bool fsl_micfil_writeable_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_DC_CTRL:
 	case REG_MICFIL_OUT_CTRL:
 	case REG_MICFIL_OUT_STAT:	/* Write 1 to Clear */
-	case REG_MICFIL_FSYNC_CTRL:
 	case REG_MICFIL_VAD0_CTRL1:
 	case REG_MICFIL_VAD0_CTRL2:
 	case REG_MICFIL_VAD0_STAT:	/* Write 1 to Clear */
@@ -907,6 +913,10 @@ static bool fsl_micfil_writeable_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_VAD0_NCONFIG:
 	case REG_MICFIL_VAD0_ZCD:
 		return true;
+	case REG_MICFIL_FSYNC_CTRL:
+		if (micfil->soc->use_verid)
+			return true;
+		fallthrough;
 	default:
 		return false;
 	}
-- 
2.34.1


