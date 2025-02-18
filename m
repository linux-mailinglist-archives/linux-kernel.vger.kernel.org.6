Return-Path: <linux-kernel+bounces-520482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27675A3AA62
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2FD7A7582
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639B1DE2AD;
	Tue, 18 Feb 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JbEnwKE0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5761DDC0F;
	Tue, 18 Feb 2025 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912113; cv=none; b=fam3qkACPSr9dP9np7HJ2/hKQquF2h1v+BBHXXuynKk3JnqGo10Ovj8v4Lko7rLtbJz3HRJD1LWFb87is0Uar3Eqc21EStUzGXjkvUKAxzI8H74uI30xKXfSeARISv95bb2y0vTO3If8ZMjp9/nBLNrTRt0liOx9XgLqvns4k9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912113; c=relaxed/simple;
	bh=3YnY/uMi17Uzm05Qv3r1B6XSlUyGLXWcGCasGpgBNLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsIVJvq2N9P/FOJtoL8fhGzrb2mxyHpq8Ix6lahelVK4oJ4Edkr2TqEdnNZaQiS53O6ytUGW1M68pbghv2EOtuTGECrraBQI81MMNWDS1VQk7oljZUKBfV40AyD0il8wZ32/d9V/EQaHDrzPEL+AtiUJo2Fw+A18WDGKI0NoyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JbEnwKE0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912110;
	bh=3YnY/uMi17Uzm05Qv3r1B6XSlUyGLXWcGCasGpgBNLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JbEnwKE0TZ+9GkJdvqY3yqoKFOgoAYBTx+3RxPEfrRDOwEAeuOrLNGLlmh9iBaOUs
	 uUt8UhCf2n4C1hnZawdsi2YQhG/Qi+tnOEtPzp6USCo14qYz+tphxCSj1ai8jLaqcT
	 bJ0Ac3LxKd9V+p4DNu+7yiLJRu/A67t4+QPzrwv/JWe2AlPbdmw4jnU2+RImrsKT7l
	 yakmI1C68z1rV0jsGFckpc8xkcfTm4SWsgokOgHkOj2bn2JOz+W2qKsKd7IZG7q0Ui
	 jOsssYKm1Q8vyxixFqiiKLnWEyKa6G7MPxTfexp36WDoFU1C2d/oK44py6uKaPy9F+
	 7CnhvKKkccioA==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E8C3617E0860;
	Tue, 18 Feb 2025 21:55:05 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 18 Feb 2025 17:52:18 -0300
Subject: [PATCH 5/6] ASoC: mediatek: mt8188-mt6359: Add DMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-genio700-dmic-v1-5-6bc653da60f7@collabora.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
In-Reply-To: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
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


