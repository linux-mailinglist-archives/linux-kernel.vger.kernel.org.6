Return-Path: <linux-kernel+bounces-368855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BF9A15AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2991C21542
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A581D4359;
	Wed, 16 Oct 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSWnKtOA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516B1D4325
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116656; cv=none; b=pF1UALmYT9VmIMACjO1gTE8HPxjvTXNNUImabl/qDgrMNXit582TgmUMwPrWWNBqBMA1a6knw5iO/M0q3LkfYUdpJQTYiOYTEEqogddjF0aO5S+DU1qZ0F2dCL4y/C4unBwBB6V4yvsk86o4yAuMrcxWgw2yk5IOJ6WVViG/kSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116656; c=relaxed/simple;
	bh=DnqN0GYxTQTNhr1sTx2f2oTCRxAX06WOtWLVVwvY7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdBAIJTnC5rHF4onGY7F4qMLg5xTwY3XKuOfyI7kCJMKKroA6RYYP/rmG3ZP/hrCJWYfTIKKQIGkM1JrAnIqpEC/vB9LadvdeBZpn/OtFmp3FmZYSJ1k8bnBXYRvcvsRO6y2YBFCOlf6TQLZtOnBD/rbT80Dk+9F2x4sYxhuN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSWnKtOA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315abed18aso269315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729116652; x=1729721452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkmU+TMQPcdZQQS44rLXxdRUirokbMiNxtTTnsu7A1M=;
        b=dSWnKtOA7yw1Owg3mmik+FTQ90RHSGMwPHhQX0LG4gTZ/yg7nIu8ULx488nnf6Y/IG
         NjeexXsnBp04pQ3pFtpZMvkaB2zs62TPvRJ1JDLlcAfDWNXs9Q+cjlaJJ0LanT/YQMNt
         CbhBHxn4ySkZoDgUwHNvccqYNido4CrJO/XgCbL7Yn/QdMw9Og6OrGiMgbihq6cERPQZ
         txt/uHMDQStlfdbOLuZT1LlyxFydyhErsL04yJ9+iGNxDuixOs5l8GFJNv5H5fIFXI5n
         V4Tmf3JkqU387J0aeoMCN210+s2YOLW2kAqrm9vR+C5H12oiL3KW/xu4Qu/eehUCCMt2
         aylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116652; x=1729721452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkmU+TMQPcdZQQS44rLXxdRUirokbMiNxtTTnsu7A1M=;
        b=Lj3+YRgv3DmCuqH7MSGVIytN9AdUb/FYV1ECZv1RF93rjc6uHROtH1t7jT51nuEOxf
         OnRARoZOmmN8sefK8WlsYIReK6Jfrg+N06hk3uwlojVqwzGu/nZOcBo7RSNMcuuplYx0
         Jm7/jt+8V8MEcbFZEATBIuVovybep6rWhVXUYG8skY7XmYXNeqXssrnywAyqaEmjVC3Q
         ziRkZMAtGqJdtkiPhaFcApiC8eKrutKK4c/gHcNIFetMyYLljELPHOaxVpK5wh+VftJr
         zoo/PUx1LzzHPNpVx2p1XqRaDiu0bWGJkjbgqjolBnXVOM6Gs3mC9Qu2mfh7BBtlLREg
         7M/A==
X-Forwarded-Encrypted: i=1; AJvYcCWM8RSoWXlo2z26BT0upQ+Dh0FciVi8dNS2v9GLW3CgN79e27kbquEPxMG97byWdDT43Z1rroLR4DYiRSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MhWQ4L/Bpa22lqnfyS7r0+rLBc2+77xrp2t/2L8MoQTKmjaO
	5JEE0vekLkbMMrL1uzh9JBpKi52lMAgFu7RcgF+SrUlMtiBUKzc9Be1yro8I5D8=
X-Google-Smtp-Source: AGHT+IE/7GB+laIBn4fQ2eRBjGrY2BLeDRMpZT3OgDpcIf9Rc1ybtQP6yIC4+eEfg4Ir/JeWq7i1xA==
X-Received: by 2002:a05:600c:1d0b:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-4312561a417mr140028865e9.33.1729116651788;
        Wed, 16 Oct 2024 15:10:51 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c38b39sm6267325e9.6.2024.10.16.15.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:10:50 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	a39.skl@gmail.com,
	linux-sound@vger.kernel.org,
	broonie@kernel.org,
	dmitry.baryshkov@linaro.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	vkoul@kernel.org
Subject: [PATCH v2] ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for DSM_CTL and SEC7 regs
Date: Wed, 16 Oct 2024 23:10:49 +0100
Message-ID: <20241016221049.1145101-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turns out some registers of pre-2.5 version of rxmacro codecs are not
located at the expected offsets but 0xc further away in memory. So far
the detected registers are CDC_RX_RX2_RX_PATH_SEC7 and
CDC_RX_RX2_RX_PATH_DSM_CTL.

CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n) macro incorrectly generates the address
0x540 for RX2 but it should be 0x54C and it also overwrites
CDC_RX_RX2_RX_PATH_SEC7 which is located at 0x540.
The same goes for CDC_RX_RXn_RX_PATH_SEC7(rx, n).

Fix this by introducing additional rxn_reg_stride2 offset. For 2.5 version
and above this offset will be equal to 0.
With such change the corresponding RXn() macros will generate the same
values for 2.5 codec version for all RX paths and the same old values
for pre-2.5 version for RX0 and RX1. However for the latter case with
RX2 path it will also add rxn_reg_stride2 on top.

While at this, also remove specific if-check for INTERP_AUX from
rx_macro_digital_mute() and rx_macro_enable_interp_clk(). These if-check
was used to handle such special offset for AUX interpolator but since
CDC_RX_RXn_RX_PATH_SEC7(rx, n) and CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)
macros will generate the correst addresses of dsm register, they are no
longer needed.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---

Changes in v2:
- updated macros as suggested by Mark and Dmitry;
- removed INTERP_AUX if-check in two functions;

Link to previous patch: https://lore.kernel.org/lkml/20240925043823.520218-1-alexey.klimov@linaro.org/

 sound/soc/codecs/lpass-rx-macro.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index ef7a70fa6966..febbbe073962 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -202,12 +202,14 @@
 #define CDC_RX_RXn_RX_PATH_SEC3(rx, n)	(0x042c  + rx->rxn_reg_stride * n)
 #define CDC_RX_RX0_RX_PATH_SEC4		(0x0430)
 #define CDC_RX_RX0_RX_PATH_SEC7		(0x0434)
-#define CDC_RX_RXn_RX_PATH_SEC7(rx, n)	(0x0434  + rx->rxn_reg_stride * n)
+#define CDC_RX_RXn_RX_PATH_SEC7(rx, n)		\
+	(0x0434 + (rx->rxn_reg_stride * n) + ((n > 1) ? rx->rxn_reg_stride2 : 0))
 #define CDC_RX_DSM_OUT_DELAY_SEL_MASK	GENMASK(2, 0)
 #define CDC_RX_DSM_OUT_DELAY_TWO_SAMPLE	0x2
 #define CDC_RX_RX0_RX_PATH_MIX_SEC0	(0x0438)
 #define CDC_RX_RX0_RX_PATH_MIX_SEC1	(0x043C)
-#define CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)	(0x0440  + rx->rxn_reg_stride * n)
+#define CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)	\
+	(0x0440 + (rx->rxn_reg_stride * n) + ((n > 1) ? rx->rxn_reg_stride2 : 0))
 #define CDC_RX_RXn_DSM_CLK_EN_MASK	BIT(0)
 #define CDC_RX_RX0_RX_PATH_DSM_CTL	(0x0440)
 #define CDC_RX_RX0_RX_PATH_DSM_DATA1	(0x0444)
@@ -645,6 +647,7 @@ struct rx_macro {
 	int rx_mclk_cnt;
 	enum lpass_codec_version codec_version;
 	int rxn_reg_stride;
+	int rxn_reg_stride2;
 	bool is_ear_mode_on;
 	bool hph_pwr_mode;
 	bool hph_hd2_mode;
@@ -1929,9 +1932,6 @@ static int rx_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 							      CDC_RX_PATH_PGA_MUTE_MASK, 0x0);
 			}
 
-			if (j == INTERP_AUX)
-				dsm_reg = CDC_RX_RXn_RX_PATH_DSM_CTL(rx, 2);
-
 			int_mux_cfg0 = CDC_RX_INP_MUX_RX_INT0_CFG0 + j * 8;
 			int_mux_cfg1 = int_mux_cfg0 + 4;
 			int_mux_cfg0_val = snd_soc_component_read(component, int_mux_cfg0);
@@ -2702,9 +2702,6 @@ static int rx_macro_enable_interp_clk(struct snd_soc_component *component,
 
 	main_reg = CDC_RX_RXn_RX_PATH_CTL(rx, interp_idx);
 	dsm_reg = CDC_RX_RXn_RX_PATH_DSM_CTL(rx, interp_idx);
-	if (interp_idx == INTERP_AUX)
-		dsm_reg = CDC_RX_RXn_RX_PATH_DSM_CTL(rx, 2);
-
 	rx_cfg2_reg = CDC_RX_RXn_RX_PATH_CFG2(rx, interp_idx);
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
@@ -3821,6 +3818,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_0:
 	case LPASS_CODEC_VERSION_2_1:
 		rx->rxn_reg_stride = 0x80;
+		rx->rxn_reg_stride2 = 0xc;
 		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
 		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
 		if (!reg_defaults)
@@ -3834,6 +3832,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_7:
 	case LPASS_CODEC_VERSION_2_8:
 		rx->rxn_reg_stride = 0xc0;
+		rx->rxn_reg_stride2 = 0x0;
 		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
 		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
 		if (!reg_defaults)
-- 
2.45.2


