Return-Path: <linux-kernel+bounces-422793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281AA9D9E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55C116412A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC041DF247;
	Tue, 26 Nov 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TMmFxRvJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F861AAD7;
	Tue, 26 Nov 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651793; cv=none; b=OVBWYemKsxWE7ojKWPZSN8vOC2N/jJx+PtikuSPyduT7R0Hq1URTRZUFIYUrHo9JdCSK7EbcUQBOqp6ZSNkXvroN+j1EFk71XfduFw13RhIsLNfWj0gk24O0Xz62mJI1NqdlX/QihkHJSjXnV7OkxaT/gS/CJ3XkP4r/nRxIkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651793; c=relaxed/simple;
	bh=Ft7Hps8cVn5oFfsG0zN5jTRhSDFJ4zRVat3qnNXJlmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jH+Uug8s0XEYB5flqC5QFhP66Bm2SCZvKHb579n6MkzHWrW56sEa38Hb0BjncMUorK79pTHyukwXlj0iZ6Vn1LNlL8vHp46L3bZVFIEmKcrO1qGe3TWx3QVXHd9rGC4xfLCqZZ5bu53og0J8vA+nJ5quavP76Uh+amVi261tBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TMmFxRvJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732651789;
	bh=Ft7Hps8cVn5oFfsG0zN5jTRhSDFJ4zRVat3qnNXJlmw=;
	h=From:Date:Subject:To:Cc:From;
	b=TMmFxRvJXsflouuAgDPUFIqGHGGSMonQR72pyt4rQ7Khxzp7poIjBv3M64aWSVhai
	 +QQcjDWCsHcCEbBO9iszt6Ej6eOZC4RbO5CUKPV8RVINvYzMMPx9YSSlnmetYowMDz
	 Ihf4nOcvYNxwA9pPDE+Zn91vopOjik1qRkG4Yp3TWpLMb5cBnGQgl8bzvlhSLXwUdl
	 n0gpXRZcHRWFF1XLW6apg1hEFvKjVv/wHXMIJ0VM4UubbovywvqHVKlonrsQdDbjvw
	 Zy0oDlrIB8whALsU+dtSAYrJrGiIqCeieZdL1SGQLZ9WXNS/ol532LPmjCFkpi+T+b
	 VGDHv1XCQsacQ==
Received: from [192.168.1.63] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 65AB717E37B1;
	Tue, 26 Nov 2024 21:09:48 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 26 Nov 2024 15:09:43 -0500
Subject: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid
 panic during probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAYrRmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMz3cTi/GTd3JJs3ZTS3NxK3YLEvMxkXcM0c0szw7Tk1OSUJCWg1oK
 i1LTMCrCx0bG1tQBJs4MhZgAAAA==
X-Change-ID: 20241126-asoc-mtk-dummy-panic-1f7961fcecdb
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
Component via COMP_DUMMY()"), COMP_DUMMY() became an array with zero
length, and only gets populated with the dummy struct after the card is
registered. Since the sound card driver's probe happens before the card
registration, accessing any of the members of a dummy component during
probe will result in undefined behavior.

This can be observed in the mt8188 and mt8195 machine sound drivers. By
omitting a dai link subnode in the sound card's node in the Devicetree,
the default uninitialized dummy codec is used, and when its dai_name
pointer gets passed to strcmp() it results in a null pointer dereference
and a kernel panic.

In addition to that, set_card_codec_info() in the generic helpers file,
mtk-soundcard-driver.c, will populate a dai link with a dummy codec when
a dai link node is present in DT but with no codec property.

The result is that at probe time, a dummy codec can either be
uninitialized with num_codecs = 0, or be an initialized dummy codec,
with num_codecs = 1 and dai_name = "snd-soc-dummy-dai". In order to
accommodate for both situations, check that num_codecs is not zero
before accessing the codecs' fields but still check for the codec's dai
name against "snd-soc-dummy-dai" as needed.

While at it, also drop the check that dai_name is not null in the mt8192
driver, introduced in commit 4d4e1b6319e5 ("ASoC: mediatek: mt8192:
Check existence of dai_name before dereferencing"), as it is actually
redundant given the preceding num_codecs != 0 check.

Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY()")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c               | 9 +++++++--
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 4 ++--
 sound/soc/mediatek/mt8195/mt8195-mt6359.c               | 9 +++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 08ae962afeb92965109b303439419bc6e7c2a896..4eed90d13a53262f0df99384494c6992b0341471 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -1279,10 +1279,12 @@ static int mt8188_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 
 	for_each_card_prelinks(card, i, dai_link) {
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
-			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+			if (dai_link->num_codecs &&
+			    strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
 				dai_link->init = mt8188_dptx_codec_init;
 		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
-			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+			if (dai_link->num_codecs &&
+			    strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
 				dai_link->init = mt8188_hdmi_codec_init;
 		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
 			   strcmp(dai_link->name, "UL_SRC_BE") == 0) {
@@ -1294,6 +1296,9 @@ static int mt8188_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 			   strcmp(dai_link->name, "ETDM2_OUT_BE") == 0 ||
 			   strcmp(dai_link->name, "ETDM1_IN_BE") == 0 ||
 			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
+			if (!dai_link->num_codecs)
+				continue;
+
 			if (!strcmp(dai_link->codecs->dai_name, MAX98390_CODEC_DAI)) {
 				/*
 				 * The TDM protocol settings with fixed 4 slots are defined in
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index db00704e206d6d3f500a5c8533e0159f16cf77b4..943f8116840373a563f5f10a7bd0f5870c331b67 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -1099,7 +1099,7 @@ static int mt8192_mt6359_legacy_probe(struct mtk_soc_card_data *soc_card_data)
 			dai_link->ignore = 0;
 		}
 
-		if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
+		if (dai_link->num_codecs &&
 		    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
 			dai_link->ops = &mt8192_rt1015_i2s_ops;
 	}
@@ -1127,7 +1127,7 @@ static int mt8192_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 		int i;
 
 		for_each_card_prelinks(card, i, dai_link)
-			if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
+			if (dai_link->num_codecs &&
 			    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
 				dai_link->ops = &mt8192_rt1015_i2s_ops;
 	}
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 2832ef78eaed7283eaad822931ce0b515fa44d0a..8ebf6c7502aa3dedd213471b8968e2958f28c4a3 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1380,10 +1380,12 @@ static int mt8195_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 
 	for_each_card_prelinks(card, i, dai_link) {
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
-			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+			if (dai_link->num_codecs &&
+			    strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
 				dai_link->init = mt8195_dptx_codec_init;
 		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
-			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+			if (dai_link->num_codecs &&
+			    strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
 				dai_link->init = mt8195_hdmi_codec_init;
 		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
 			   strcmp(dai_link->name, "UL_SRC1_BE") == 0 ||
@@ -1396,6 +1398,9 @@ static int mt8195_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 			   strcmp(dai_link->name, "ETDM2_OUT_BE") == 0 ||
 			   strcmp(dai_link->name, "ETDM1_IN_BE") == 0 ||
 			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
+			if (!dai_link->num_codecs)
+				continue;
+
 			if (!strcmp(dai_link->codecs->dai_name, MAX98390_CODEC_DAI)) {
 				if (!(codec_init & MAX98390_CODEC_INIT)) {
 					dai_link->init = mt8195_max98390_init;

---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241126-asoc-mtk-dummy-panic-1f7961fcecdb

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


