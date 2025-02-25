Return-Path: <linux-kernel+bounces-531630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519ABA442FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3574619C00B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8E267B9D;
	Tue, 25 Feb 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J8iN9rn7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3A26B2A4;
	Tue, 25 Feb 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494109; cv=none; b=N/eYWFS/uBBXhQIolN6/P9bA6ghk11FTbL753u18jdYGBbptj/1L8Q+MGwmiD1sPaugkGETU2zHUfsvlSTdCvzDGle8uIKkLwIUAspP7WtUIZsb4fu4I5WtoBQcCKmgVG/aDHG1YfuIvXxkQDtOtMUS7zlV6c4Y9RZujZjeN1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494109; c=relaxed/simple;
	bh=VOTlkRaTJUxVymB+VRML2zW6NSmIQJd6XGkId1VraY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0bPa+nMKfBpqCFOI9YNhY5n4ZwfFJv6xvfmuvbmpaLRysoxivdhATQtRQoU70dUpigrC5X+abIlWAgX/0j8uPnlTcgJmoaDrm6lwCtYox8SEC0OPCqxsmjcoO4yimboJQGwziiInx5cNeDciDW3BbWN1SdTW2ReH1r2pvEwCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J8iN9rn7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494105;
	bh=VOTlkRaTJUxVymB+VRML2zW6NSmIQJd6XGkId1VraY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J8iN9rn7M9ODiSRDL1LE/Bf8VoJqyJSSl8XDO7lkOrw2THUkCmMpfLkLfqFtEjvSz
	 HekKyWTk0Z1lN/gKHVh9L+NGuv5aMpMeeUkiVYorIqjpaBreR1inM0HqhdhekbcDwy
	 SegcVs3yAE0OaPzqApBUTdkxJqtzM/5VDTvAjLTrp5lgdYM902VUAgcgE7B3gqJBIm
	 wvBxsKJK8EsPRxDdoapjfqlDrGJD4hDl1Uw1hpfa0kpO77cMWFX52tkhyEwZhyKoh6
	 KqpEyE0UEaTrq0C0vr2/iqTfAOCeAs3pypscEvmdQQbQcXFgYl7o5sA+u7ONu3impj
	 QsewR5a44WNfg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D16AA17E0DD7;
	Tue, 25 Feb 2025 15:35:01 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:47 -0300
Subject: [PATCH v2 1/8] ASoC: mediatek: mt8188: Add audsys hires clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-1-3076f5b50ef7@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Describe and register the aud_dmic_hires audsys clocks, which are needed
when recording the DMIC at a sample rate of 96k.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c   | 4 ++++
 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
index c796ad8b62eeaa929f24c09755f428116b105404..40d2ab0a7677b64985f9fc9eb38f67bca7ecd4f9 100644
--- a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
@@ -84,6 +84,10 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD1(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm", "top_a1sys_hp", 14),
 	GATE_AUD1(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires", "top_audio_h", 16),
 	GATE_AUD1(CLK_AUD_ADC_HIRES, "aud_adc_hires", "top_audio_h", 17),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES1, "aud_dmic_hires1", "top_audio_h", 20),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES2, "aud_dmic_hires2", "top_audio_h", 21),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES3, "aud_dmic_hires3", "top_audio_h", 22),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES4, "aud_dmic_hires4", "top_audio_h", 23),
 
 	/* AUD3 */
 	GATE_AUD3(CLK_AUD_LINEIN_TUNER, "aud_linein_tuner", "top_apll5", 5),
diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
index 6f34ffc760e03beddc3001046e554edd7ea2c478..9cb732863c104383b9859b4bb5b3f5c289ad1864 100644
--- a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
@@ -33,6 +33,10 @@ enum{
 	CLK_AUD_AFE_26M_DMIC_TM,
 	CLK_AUD_UL_TML_HIRES,
 	CLK_AUD_ADC_HIRES,
+	CLK_AUD_DMIC_HIRES1,
+	CLK_AUD_DMIC_HIRES2,
+	CLK_AUD_DMIC_HIRES3,
+	CLK_AUD_DMIC_HIRES4,
 	CLK_AUD_LINEIN_TUNER,
 	CLK_AUD_EARC_TUNER,
 	CLK_AUD_I2SIN,

-- 
2.48.1


