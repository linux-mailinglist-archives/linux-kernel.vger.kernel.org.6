Return-Path: <linux-kernel+bounces-520479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B759DA3AA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F357A6943
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C11D86C7;
	Tue, 18 Feb 2025 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UTZrteYL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8F1CBA02;
	Tue, 18 Feb 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912098; cv=none; b=JgLtxcgoljtXQcdQoXXrAzivkC2jTupo+LhH9vGGPYjBW9Zab2nbGHd0Muf8BPjvRNEkCQUUFw+uDEq82AkV1vtnpkMW2d9A9ywHlwzqYv+ToNNbwps96y4yWLzziAAkvJ+zdgglq/2Yu9Z9bNA+nrP7E+k7cENUuVzwTeMCPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912098; c=relaxed/simple;
	bh=NFA44qDILVNf0Qfs+SmsXbQIchoOI3d5XSIjOUol0GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufkCqMxY3n+mqtKVcHZLSw/FgWl2XsvXTXYMdK+qDT5MRndASn0Iz/Seg1X2iSxkxVE45vD7QRAVf/jveWcKbTJW9bSth23IySDIl0WoizfztwO6tBUQYDyQAUW3LXCpCJVOYGm8/c4IDrpxA7H+gaLZN9fmfbCASNUARNFHNSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UTZrteYL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912095;
	bh=NFA44qDILVNf0Qfs+SmsXbQIchoOI3d5XSIjOUol0GU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UTZrteYLC8LB3dt1TMJDxwrAuoeV81fjdrFtP8o4LGfUocC2hiqHlqBFPzoMjAJ74
	 NC224R1GBMDtfmZ9cXCz5Mgk23mV8KG3MrqgKiAYT5bTeP9JdjLw4kPrPhTKE2mBSz
	 J9fpqxCKR4tKX2F3F0pvDqmXbYAC63DbBrCbXQzYC2AcCXcCKPIj53+gQb+6yilYYO
	 373Jjos6mMI7Soglxi1ThYUVITM4sSaEPvUayL+kUtVMKFdND9A9sjMGL2llkNNKpq
	 CxwOULv7JK8vSUWIZ5dyLvHbBXqvBXEUHE6w9eTV3e1Wg+ATwQpy4DtNHZ33/ME/C3
	 n/XHb4vyDBVBw==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B448B17E0860;
	Tue, 18 Feb 2025 21:54:51 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 18 Feb 2025 17:52:15 -0300
Subject: [PATCH 2/6] ASoC: mediatek: mt8188: Add reference for dmic clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-genio700-dmic-v1-2-6bc653da60f7@collabora.com>
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

Add the names for the dmic clocks, aud_afe_dmic* and aud_dmic_hires*, so
they can be acquired and enabled by the platform driver.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 8 ++++++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
index e69c1bb2cb239596dee50b166c20192d5408be10..44c25b6e3d873448163b22e70f5b94cb5070654d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
@@ -58,6 +58,14 @@ static const char *aud_clks[MT8188_CLK_NUM] = {
 	[MT8188_CLK_AUD_ADC] = "aud_adc",
 	[MT8188_CLK_AUD_DAC_HIRES] = "aud_dac_hires",
 	[MT8188_CLK_AUD_A1SYS_HP] = "aud_a1sys_hp",
+	[MT8188_CLK_AUD_AFE_DMIC1] = "aud_afe_dmic1",
+	[MT8188_CLK_AUD_AFE_DMIC2] = "aud_afe_dmic2",
+	[MT8188_CLK_AUD_AFE_DMIC3] = "aud_afe_dmic3",
+	[MT8188_CLK_AUD_AFE_DMIC4] = "aud_afe_dmic4",
+	[MT8188_CLK_AUD_DMIC_HIRES1] = "aud_dmic_hires1",
+	[MT8188_CLK_AUD_DMIC_HIRES2] = "aud_dmic_hires2",
+	[MT8188_CLK_AUD_DMIC_HIRES3] = "aud_dmic_hires3",
+	[MT8188_CLK_AUD_DMIC_HIRES4] = "aud_dmic_hires4",
 	[MT8188_CLK_AUD_ADC_HIRES] = "aud_adc_hires",
 	[MT8188_CLK_AUD_I2SIN] = "aud_i2sin",
 	[MT8188_CLK_AUD_TDM_IN] = "aud_tdm_in",
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
index ec53c171c170a8b4b47900e63ef79d53641e9b12..68c46feb72271b950d4e538f63cedf524354147e 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
@@ -54,6 +54,14 @@ enum {
 	MT8188_CLK_AUD_ADC,
 	MT8188_CLK_AUD_DAC_HIRES,
 	MT8188_CLK_AUD_A1SYS_HP,
+	MT8188_CLK_AUD_AFE_DMIC1,
+	MT8188_CLK_AUD_AFE_DMIC2,
+	MT8188_CLK_AUD_AFE_DMIC3,
+	MT8188_CLK_AUD_AFE_DMIC4,
+	MT8188_CLK_AUD_DMIC_HIRES1,
+	MT8188_CLK_AUD_DMIC_HIRES2,
+	MT8188_CLK_AUD_DMIC_HIRES3,
+	MT8188_CLK_AUD_DMIC_HIRES4,
 	MT8188_CLK_AUD_ADC_HIRES,
 	MT8188_CLK_AUD_I2SIN,
 	MT8188_CLK_AUD_TDM_IN,

-- 
2.48.1


