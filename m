Return-Path: <linux-kernel+bounces-531635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65517A44312
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0665319C5788
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15126BD86;
	Tue, 25 Feb 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PlZtZ/LP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9A26B965;
	Tue, 25 Feb 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494126; cv=none; b=TethwYPjQHUPt+sQ8cpV6KT1QcKFeznRqyrYyM+wtvHvc9KEvHiGn8RoSWiC/c4YXDKIauOTtILqLHXLUCDodFd1kwbXuEXAIRY9QNuMesD/aauCjzePdosDBNutt4Qh0imIKCa8hJzotkRJ9bImewKtZTOx1VBnKlh0GpcStlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494126; c=relaxed/simple;
	bh=JCE4p346p31jQgHf80qzDsHOhPDN++XJ848duY7iYv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fq+FPiZJq+uk60zkD5hkmztQuW7Lno0YNJ6dSqzxE2ZFNuNtlFWNxKLif4rKtBXel2VoETY3tx/RtRF9jNfb6Ywwg+U8tC9iN6O0pn2Njlv1cCZYL5Jf8o1wIbmElG1HwYOW0Vn5iRJ0Y4eQC7Sl9K3sch0WTYV7iDYRFsnxPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PlZtZ/LP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494123;
	bh=JCE4p346p31jQgHf80qzDsHOhPDN++XJ848duY7iYv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PlZtZ/LPxsveMjhUJGmt6WtyjcEWKkMBP15eJr0sN541bg+HaP6TqLCj7HE/dgloZ
	 osv0IrO9iqEnFsQcQIJ+rBZ2RbWNvmK18NRR76v1VbpFNzDC4hQJHmpRaSa9sakms7
	 yPPf6gLSVsakrM7Q3qfG21+PDyEESfq+jytvr1hxnG2dApPugTU7V6DFuCySc+7Ama
	 uXuvFCrWS7f4UfMalNFhL6G+18MhcMXHYTkki9Y3b12UpbNsZkfkdCKDYkHi6tac4R
	 /wBxTCWSi1WTGK0S8hq+/9ZhWWQkm1eeNQv0y2qxUcUXJjsj9P3uVKVaVQnl6LOyC9
	 EuW/Xo0iUN2KQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4A4417E0DD7;
	Tue, 25 Feb 2025 15:35:19 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:51 -0300
Subject: [PATCH v2 5/8] ASoC: mediatek: mt8188-mt6359: Add DMIC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-5-3076f5b50ef7@collabora.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
In-Reply-To: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

Add the DMIC backend, which connects to the DMIC DAI in the platform
driver, as well as a "AP DMIC" mic widget. On the Genio 700 EVK board
the dual DMIC on-board are wired through that DMIC DAI.

Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 2d0d04e0232da07ba43a030b14853322427d55e7..420b1427b71dc1424a52f7ab6140c14659036733 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -150,6 +150,11 @@ SND_SOC_DAILINK_DEFS(dl_src,
 						   "mt6359-snd-codec-aif1")),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
+SND_SOC_DAILINK_DEFS(DMIC_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DMIC")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 SND_SOC_DAILINK_DEFS(dptx,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DPTX")),
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
@@ -297,6 +302,7 @@ static const struct snd_soc_dapm_widget mt8188_rear_spk_widgets[] = {
 static const struct snd_soc_dapm_widget mt8188_mt6359_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("AP DMIC", NULL),
 	SND_SOC_DAPM_SINK("HDMI"),
 	SND_SOC_DAPM_SINK("DP"),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -533,6 +539,7 @@ enum {
 	DAI_LINK_UL9_FE,
 	DAI_LINK_UL10_FE,
 	DAI_LINK_DL_SRC_BE,
+	DAI_LINK_DMIC_BE,
 	DAI_LINK_DPTX_BE,
 	DAI_LINK_ETDM1_IN_BE,
 	DAI_LINK_ETDM2_IN_BE,
@@ -1120,6 +1127,13 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		.playback_only = 1,
 		SND_SOC_DAILINK_REG(dl_src),
 	},
+	[DAI_LINK_DMIC_BE] = {
+		.name = "DMIC_BE",
+		.no_pcm = 1,
+		.capture_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(DMIC_BE),
+	},
 	[DAI_LINK_DPTX_BE] = {
 		.name = "DPTX_BE",
 		.ops = &mt8188_dptx_ops,

-- 
2.48.1


