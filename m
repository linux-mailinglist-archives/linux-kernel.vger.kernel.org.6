Return-Path: <linux-kernel+bounces-520481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2CA3AA67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788C31889C01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDBE1DD0D5;
	Tue, 18 Feb 2025 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J2pZctMM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291821DA11B;
	Tue, 18 Feb 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912109; cv=none; b=YKLrao34d6U/fxxZzgO9+g74uf90gXNFDH7VV4rz5i+7sUN7milxoOxUFnJ6w83JHYDN34qN4TmHyK4IisW1EqZzXlgCpJvyjA8vJzTZw1knVwUKEVpD0mvPQdyrT/E1N0SU5eqSr9vlNpP0BiRJ5n8QNpwoBxSSWmmAV74PgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912109; c=relaxed/simple;
	bh=RCOEgMcbu8F37597THR5ibDygJbXzo49NGcuenC8qGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/W/7RNaSJfAvgM4NCsRir+ihA4nZc53DBeC4K3NtIQccRoyC18uL2KFvuvM0A/NyaviaXu6Lgsc6C62Ki8vjJNHk/FwZbENtTgNYOBY9nFEP/7ESk5XOJnLD0sz0O6KFeDn6vD+gTNNQehsmOyObE4F8/jw2LG+D7wKZ6swdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J2pZctMM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912105;
	bh=RCOEgMcbu8F37597THR5ibDygJbXzo49NGcuenC8qGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J2pZctMMTczAE0FRlOcksPIgQ0ic6IwGIUI6nVIjCT/fKj6ePg0cA/pAK76gmonbV
	 eLwzY43smhn8Q04Up4hqNtcWf2wvLky1xORmDXc9WOClOTVA8w84l3lV28pOtuEO2Y
	 DJDAdOQMnh7NdkwpMavj/NEBvpglfo6n5jMNJcg8sUf10FS85T6RPr1tx0QmnlxYHs
	 SXUtAq5qKD8pN42GKbgr7P09E2RauVlWd4wUAvGIi/gRQXp8uyOb9/vkn507NP3ZnP
	 /luKJT5qpInYCJyP5GpjZyFbIP6vE8FU1V/bbD4Jb5a/UV5kN/22GhoXuwZjFUOeOE
	 OqMB7uKH2bQtQ==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 58C1417E0657;
	Tue, 18 Feb 2025 21:55:00 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 18 Feb 2025 17:52:17 -0300
Subject: [PATCH 4/6] ASoC: mediatek: mt8188: Support DMIC in AFE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-genio700-dmic-v1-4-6bc653da60f7@collabora.com>
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

From: parkeryang <Parker.Yang@mediatek.com>

Add the AFE routes that connect the DMIC (I004-I011) to the UL9 frontend
(O002-O009) and register the mt8188-dmic DAI driver during probe.

Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/Makefile            |  1 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |  1 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/Makefile b/sound/soc/mediatek/mt8188/Makefile
index 1178bce45c50ba252672a32b3877732a5a76c610..b9f3e4ad7b07ba9e21c846706371c53269f894db 100644
--- a/sound/soc/mediatek/mt8188/Makefile
+++ b/sound/soc/mediatek/mt8188/Makefile
@@ -6,6 +6,7 @@ snd-soc-mt8188-afe-y := \
 	mt8188-afe-pcm.o \
 	mt8188-audsys-clk.o \
 	mt8188-dai-adda.o \
+	mt8188-dai-dmic.o \
 	mt8188-dai-etdm.o \
 	mt8188-dai-pcm.o
 
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-common.h b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
index 1304d685a306bcb43b5131eff165b80051810b04..01aa11242e29c51539903fd1decc4c575d5e97bd 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-common.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
@@ -137,6 +137,7 @@ struct mt8188_afe_private {
 int mt8188_afe_fs_timing(unsigned int rate);
 /* dai register */
 int mt8188_dai_adda_register(struct mtk_base_afe *afe);
+int mt8188_dai_dmic_register(struct mtk_base_afe *afe);
 int mt8188_dai_etdm_register(struct mtk_base_afe *afe);
 int mt8188_dai_pcm_register(struct mtk_base_afe *afe);
 
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index d36520c6272dd8c8302bc3f59da33f82f273f366..a2b57e00ff4e502bfd8bc57835b792825f348c1b 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -652,6 +652,7 @@ static struct snd_soc_dai_driver mt8188_memif_dai_driver[] = {
 
 static const struct snd_kcontrol_new o002_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN2, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I004 Switch", AFE_CONN2, 4, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I012 Switch", AFE_CONN2, 12, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I020 Switch", AFE_CONN2, 20, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I022 Switch", AFE_CONN2, 22, 1, 0),
@@ -662,6 +663,8 @@ static const struct snd_kcontrol_new o002_mix[] = {
 
 static const struct snd_kcontrol_new o003_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN3, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I005 Switch", AFE_CONN3, 5, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I006 Switch", AFE_CONN3, 6, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I013 Switch", AFE_CONN3, 13, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I021 Switch", AFE_CONN3, 21, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I023 Switch", AFE_CONN3, 23, 1, 0),
@@ -672,6 +675,8 @@ static const struct snd_kcontrol_new o003_mix[] = {
 
 static const struct snd_kcontrol_new o004_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN4, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I006 Switch", AFE_CONN4, 6, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I008 Switch", AFE_CONN4, 8, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I014 Switch", AFE_CONN4, 14, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I024 Switch", AFE_CONN4, 24, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I074 Switch", AFE_CONN4_2, 10, 1, 0),
@@ -679,6 +684,8 @@ static const struct snd_kcontrol_new o004_mix[] = {
 
 static const struct snd_kcontrol_new o005_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN5, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I007 Switch", AFE_CONN5, 7, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I010 Switch", AFE_CONN5, 10, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I015 Switch", AFE_CONN5, 15, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I025 Switch", AFE_CONN5, 25, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I075 Switch", AFE_CONN5_2, 11, 1, 0),
@@ -686,6 +693,7 @@ static const struct snd_kcontrol_new o005_mix[] = {
 
 static const struct snd_kcontrol_new o006_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN6, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I008 Switch", AFE_CONN6, 8, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I016 Switch", AFE_CONN6, 16, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I026 Switch", AFE_CONN6, 26, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I076 Switch", AFE_CONN6_2, 12, 1, 0),
@@ -693,18 +701,21 @@ static const struct snd_kcontrol_new o006_mix[] = {
 
 static const struct snd_kcontrol_new o007_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN7, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I009 Switch", AFE_CONN7, 9, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I017 Switch", AFE_CONN7, 17, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I027 Switch", AFE_CONN7, 27, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I077 Switch", AFE_CONN7_2, 13, 1, 0),
 };
 
 static const struct snd_kcontrol_new o008_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I010 Switch", AFE_CONN8, 10, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I018 Switch", AFE_CONN8, 18, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I028 Switch", AFE_CONN8, 28, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I078 Switch", AFE_CONN8_2, 14, 1, 0),
 };
 
 static const struct snd_kcontrol_new o009_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I011 Switch", AFE_CONN9, 11, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I019 Switch", AFE_CONN9, 19, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I029 Switch", AFE_CONN9, 29, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I079 Switch", AFE_CONN9_2, 15, 1, 0),
@@ -1275,6 +1286,18 @@ static const struct snd_soc_dapm_route mt8188_memif_routes[] = {
 	{"O002", "I070 Switch", "I070"},
 	{"O003", "I071 Switch", "I071"},
 
+	{"O002", "I004 Switch", "I004"},
+	{"O003", "I005 Switch", "I005"},
+	{"O003", "I006 Switch", "I006"},
+	{"O004", "I006 Switch", "I006"},
+	{"O004", "I008 Switch", "I008"},
+	{"O005", "I007 Switch", "I007"},
+	{"O005", "I010 Switch", "I010"},
+	{"O006", "I008 Switch", "I008"},
+	{"O007", "I009 Switch", "I009"},
+	{"O008", "I010 Switch", "I010"},
+	{"O009", "I011 Switch", "I011"},
+
 	{"O034", "I000 Switch", "I000"},
 	{"O035", "I001 Switch", "I001"},
 	{"O034", "I002 Switch", "I002"},
@@ -3072,6 +3095,7 @@ static int mt8188_dai_memif_register(struct mtk_base_afe *afe)
 typedef int (*dai_register_cb)(struct mtk_base_afe *);
 static const dai_register_cb dai_register_cbs[] = {
 	mt8188_dai_adda_register,
+	mt8188_dai_dmic_register,
 	mt8188_dai_etdm_register,
 	mt8188_dai_pcm_register,
 	mt8188_dai_memif_register,

-- 
2.48.1


