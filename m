Return-Path: <linux-kernel+bounces-531631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0DA442EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D304B17BD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCD26BDA7;
	Tue, 25 Feb 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PcrDgfQW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02426BDA0;
	Tue, 25 Feb 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494113; cv=none; b=ONGRXcHQAbD78mLVCqVFEOHqSy9aGhCpaT6XED3AXOR3wXS4tSxTZWBPPiua2vnQiqdMIa1ibGfmb6eIbjNfRDfa6/JWGSebZsX7zxskO7w67Mrj6wWV6A+O1O1LxUQA4PzCgIzuCB5mfbkBLsaIBr7DiymH5gvo+g3Sxzx+bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494113; c=relaxed/simple;
	bh=2FVz/MmQJw35JVL8AhLj7sbkYBDTN69thgnUg6dUQvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkG1CNuwAYgDOfIRIGJ4Xf8oTOh4FySSouvncn5YSVFToi42XPCqEFFjrPrn34jNsjqTO0kBr4DP3spP21/lXIAjid7jUY8DTSQpETUZ6mo5NYV+n+fdpPFSWirXrbcSPVlPtlIuJFH2hwwRP98L/LGxgTyXKF9qJLoOHZ5xwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PcrDgfQW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494109;
	bh=2FVz/MmQJw35JVL8AhLj7sbkYBDTN69thgnUg6dUQvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PcrDgfQWxKG+M2AEM3AIEYXrcWeslQ1Z+wY4m1CDOjbSXh208NnWhDt/Y6JyXc4Nc
	 xE3TjxsnOra43Sn7pTpcr5ragRS8Y+Q5iEFAC2lqKzsCgpL9g3pRPCJruYQcFRk8M6
	 zbjk91++VVECDQ+o1tj4jWeLzkCYak6XgJu4gMQqfFtGzgx73lREj8zz+wY3Tx6VGl
	 LO4Z1xYT7vTk19ZXLUhDvMakU6d0qOxJWOalLr0m6ZjTCue0+5kcT5u2/NKKfoEBNI
	 Y3kNqbmlrAk4el71NqHYfDQFIqCZBanke+cEYNDhWba/Mv/TAsZAbcpsP/nPyRNlW1
	 +VsBn+0tOWUwg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 265E717E0E91;
	Tue, 25 Feb 2025 15:35:05 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:48 -0300
Subject: [PATCH v2 2/8] ASoC: mediatek: mt8188: Add reference for dmic
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-2-3076f5b50ef7@collabora.com>
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

Add the names for the dmic clocks, aud_afe_dmic* and aud_dmic_hires*, so
they can be acquired and enabled by the platform driver.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 8 ++++++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
index e69c1bb2cb239596dee50b166c20192d5408be10..7f411b857782375ba16702543295a5ae4b774f47 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
@@ -58,7 +58,15 @@ static const char *aud_clks[MT8188_CLK_NUM] = {
 	[MT8188_CLK_AUD_ADC] = "aud_adc",
 	[MT8188_CLK_AUD_DAC_HIRES] = "aud_dac_hires",
 	[MT8188_CLK_AUD_A1SYS_HP] = "aud_a1sys_hp",
+	[MT8188_CLK_AUD_AFE_DMIC1] = "aud_afe_dmic1",
+	[MT8188_CLK_AUD_AFE_DMIC2] = "aud_afe_dmic2",
+	[MT8188_CLK_AUD_AFE_DMIC3] = "aud_afe_dmic3",
+	[MT8188_CLK_AUD_AFE_DMIC4] = "aud_afe_dmic4",
 	[MT8188_CLK_AUD_ADC_HIRES] = "aud_adc_hires",
+	[MT8188_CLK_AUD_DMIC_HIRES1] = "aud_dmic_hires1",
+	[MT8188_CLK_AUD_DMIC_HIRES2] = "aud_dmic_hires2",
+	[MT8188_CLK_AUD_DMIC_HIRES3] = "aud_dmic_hires3",
+	[MT8188_CLK_AUD_DMIC_HIRES4] = "aud_dmic_hires4",
 	[MT8188_CLK_AUD_I2SIN] = "aud_i2sin",
 	[MT8188_CLK_AUD_TDM_IN] = "aud_tdm_in",
 	[MT8188_CLK_AUD_I2S_OUT] = "aud_i2s_out",
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
index ec53c171c170a8b4b47900e63ef79d53641e9b12..c6c78d684f3ee11ce79f2fac45cc5f1abdc97147 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
@@ -54,7 +54,15 @@ enum {
 	MT8188_CLK_AUD_ADC,
 	MT8188_CLK_AUD_DAC_HIRES,
 	MT8188_CLK_AUD_A1SYS_HP,
+	MT8188_CLK_AUD_AFE_DMIC1,
+	MT8188_CLK_AUD_AFE_DMIC2,
+	MT8188_CLK_AUD_AFE_DMIC3,
+	MT8188_CLK_AUD_AFE_DMIC4,
 	MT8188_CLK_AUD_ADC_HIRES,
+	MT8188_CLK_AUD_DMIC_HIRES1,
+	MT8188_CLK_AUD_DMIC_HIRES2,
+	MT8188_CLK_AUD_DMIC_HIRES3,
+	MT8188_CLK_AUD_DMIC_HIRES4,
 	MT8188_CLK_AUD_I2SIN,
 	MT8188_CLK_AUD_TDM_IN,
 	MT8188_CLK_AUD_I2S_OUT,

-- 
2.48.1


