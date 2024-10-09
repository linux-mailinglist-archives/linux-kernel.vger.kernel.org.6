Return-Path: <linux-kernel+bounces-356495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102C9961ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F21C236A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E8A1885BF;
	Wed,  9 Oct 2024 08:10:16 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B41169397;
	Wed,  9 Oct 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461416; cv=none; b=RlQ0okohnXy9C3NVlxv6u9hWMGiNEaHt7z2Lhs267Xo3egWsh/x+PKoSKTwY2Sy8VBrz0aEiq7K7vFnwk4ZtRuRv9NP4nebw06FndUWqyebBVzlmsPytuXOGexEGTfSFgTygCTZJH5b7d2eoSY483VAo9A9Jtw67P42RCPm0yFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461416; c=relaxed/simple;
	bh=B0M9xs1LqzT8oCRHj3FSkWt6xZSJRwnB2NPO0CekjJ4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=d6u7sFAtxB7izVDwXESeSWHaV1zF8mkqhwOADeVTSZyYRnX1vcSucM4ibcsocLTtd1dtaKklrzjlaIg01GpCQvNRb/hKq5IuXi/CurfM789BsLaRJV1hvPNSPFInl2kqq+zmILkBVVW2ZhFS/4HDHKVVT1L4+0+AVX3XKwi18xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BBAD1A27D8;
	Wed,  9 Oct 2024 10:10:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E7AC31A1D73;
	Wed,  9 Oct 2024 10:10:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 38FFD183F0C7;
	Wed,  9 Oct 2024 16:10:05 +0800 (+08)
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
	linux-kernel@vger.kernel.org,
	chancel.liu@nxp.com
Subject: [PATCH 1/2] ASoC: imx-card: Set mclk for codec
Date: Wed,  9 Oct 2024 15:46:43 +0800
Message-Id: <1728460004-364-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728460004-364-1-git-send-email-shengjiu.wang@nxp.com>
References: <1728460004-364-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chancel Liu <chancel.liu@nxp.com>

In some cases, ASoC machine driver may modify the mclk frequency
according to sample rate but the value in codec is still initial
frequency which should be replaced. For example, we should update
mclk before setup for cs42xx8 mclk relating registers.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-card.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index a7215bad6484..2f3dbbd15791 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -370,6 +370,11 @@ static int imx_aif_hw_params(struct snd_pcm_substream *substream,
 		dev_err(dev, "failed to set cpui dai mclk1 rate (%lu): %d\n", mclk_freq, ret);
 		return ret;
 	}
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk_freq, SND_SOC_CLOCK_IN);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(dev, "failed to set codec dai mclk rate (%lu): %d\n", mclk_freq, ret);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.34.1


