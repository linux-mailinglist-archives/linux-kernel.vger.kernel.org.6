Return-Path: <linux-kernel+bounces-520478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE74A3AA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A991886384
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE01D7E21;
	Tue, 18 Feb 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g2w2EmJ3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41FA1D5CC6;
	Tue, 18 Feb 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912094; cv=none; b=nQV0WoXUHLsgRLyGioDg0RgAI/GeIeThSMOQ+Sdkyjh+DwDhtCSHWwP+qcFPotsxMdFixdzYXz+3vFF66jR9zP+WU5X+HfiL76eKss85vdlFgrnzrtq1NMr06lOGlRxX6NkwW+xlxncuASTyKAHLHEyRWu1etQ2nrGZWOcfnN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912094; c=relaxed/simple;
	bh=Yk5XIblYjpzjabFJKo9Uv7D5fdBdo4hChmW38vMB4iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKPWYdLY0j3hK0hlBNN9G9id/TqISXHNf4Hz0+f6iVUpM0AhyNwCDrSsNHmkJhIg0AOxoPG9Cm/3b6M1bV7NxdXjRXP3kRYay/+PP2DhH05jht7bzQl461pt+8TW5T7nKBnyP5FF/EpLjDWDb3/kWFVSlPxRkHMd+bwlcpv61ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g2w2EmJ3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912091;
	bh=Yk5XIblYjpzjabFJKo9Uv7D5fdBdo4hChmW38vMB4iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g2w2EmJ3WrGM8xkTw19TeP7qw2jgoJxVuJIKF/TM0Wxhv7+um7O3A4lz/bwUXcfTM
	 BtCVjKXsK7GZBBaFVAxulvP+VXVHPyXFkfj1d4OsebtzhR1Tij007/4inVA9RNeXxG
	 qg43FeRQCrC1rMmtWaqQ7gte+AdojU5FajtHId6B3V4RMyI9QqieXx0fIOy0TzL+jK
	 sDDamSoxcCVuSjUK34rpkUm7cZMtflJ5fyo8iP/wLhubNK8WxwRIvd8E0JpOyjCL2Z
	 SohPC28puZ5x08cdb5jz4RGRxO7DEL2PurYCXA4KD5evMEsdB4+pIwPWJ5kvxgEEK+
	 iOEsZACeovb6Q==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 07C1617E0657;
	Tue, 18 Feb 2025 21:54:46 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 18 Feb 2025 17:52:14 -0300
Subject: [PATCH 1/6] ASoC: mediatek: mt8188: Add audsys hires clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-genio700-dmic-v1-1-6bc653da60f7@collabora.com>
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
index c796ad8b62eeaa929f24c09755f428116b105404..e7b2c9da61f6b5dbe9002a294ebbb7f4415fe54c 100644
--- a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
@@ -81,6 +81,10 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD1(CLK_AUD_AFE_DMIC2, "aud_afe_dmic2", "top_a1sys_hp", 11),
 	GATE_AUD1(CLK_AUD_AFE_DMIC3, "aud_afe_dmic3", "top_a1sys_hp", 12),
 	GATE_AUD1(CLK_AUD_AFE_DMIC4, "aud_afe_dmic4", "top_a1sys_hp", 13),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES1, "aud_dmic_hires1", "top_audio_h", 20),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES2, "aud_dmic_hires2", "top_audio_h", 21),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES3, "aud_dmic_hires3", "top_audio_h", 22),
+	GATE_AUD1(CLK_AUD_DMIC_HIRES4, "aud_dmic_hires4", "top_audio_h", 23),
 	GATE_AUD1(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm", "top_a1sys_hp", 14),
 	GATE_AUD1(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires", "top_audio_h", 16),
 	GATE_AUD1(CLK_AUD_ADC_HIRES, "aud_adc_hires", "top_audio_h", 17),
diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
index 6f34ffc760e03beddc3001046e554edd7ea2c478..820f2aef17ea40be1a80aece604b4a319934312f 100644
--- a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
+++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
@@ -30,6 +30,10 @@ enum{
 	CLK_AUD_AFE_DMIC2,
 	CLK_AUD_AFE_DMIC3,
 	CLK_AUD_AFE_DMIC4,
+	CLK_AUD_DMIC_HIRES1,
+	CLK_AUD_DMIC_HIRES2,
+	CLK_AUD_DMIC_HIRES3,
+	CLK_AUD_DMIC_HIRES4,
 	CLK_AUD_AFE_26M_DMIC_TM,
 	CLK_AUD_UL_TML_HIRES,
 	CLK_AUD_ADC_HIRES,

-- 
2.48.1


