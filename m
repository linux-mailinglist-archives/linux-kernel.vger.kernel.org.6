Return-Path: <linux-kernel+bounces-229348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4E916EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539781F22CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2F17967C;
	Tue, 25 Jun 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="is4RiFdk"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E505176AAE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334748; cv=none; b=RP8YZKwz8jMx/d/OEmWDMaA95fEIsDLs8QS7u3XODOZSW0oW3q8s71K5ZKx/0+9raSALNgzrYnYnwh4EgOuN7neHCrbDXXUzxw/xqkFT9X6nw29Or3EegsqKlX0ITkoeD42cR7nHMDKIoQR3AhvyOJI7KjJTnazRyJL6WGx0HCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334748; c=relaxed/simple;
	bh=4/CmNgyJJPY4+iEcsVtnGR9lNO+O99sF/57Okonhcg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVu+FelhR1M7xPjtKoYWiNzQ7LL3fv8sGe8/qAVOi/kafj3gDH8R7W3/tAuuF3B6kdEUSJAl9fkLTpRRsKfDdWRv4sl1rxhx7KYbZfuo7uJK/lzZ6vcCGeihg24T5j3oJF3LjKO00mVB58Upif/QSEMLuNAJtRIOylL/FODwsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=is4RiFdk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso86617151fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719334744; x=1719939544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUtLuGs0ukSBFvG4vkaqQiVb2jhLN4MYLhR39zHUHgY=;
        b=is4RiFdkYuAYgT3QtEVugO8WF/wBtCTu3P/UjsoxtPE0uvrnxxRbWvMhAumEtv6Wau
         9Yj5z0VEE69YpONoAQCB2fP28l2jC/yEICGi/RMdJgu2JLZs3QqQ1WtlooNS+n0oCOfY
         HN4uKUuWtsOvB66T/9AQAJqDTo1fN/dlrMFjImT4XUKDH+huvcCEnTAtjz3uBZ31TJlL
         xonvunMyLVRqJ9qrCxBi0v3W8g54TPiwKEWsyNeVTL3xc6U9lxTj1qUq/nhAjRDLhSCe
         qUavpqQoTBJCXLsEqXHJ9daKpwehd9fEtzkXIXyfCrk6x2zPP21Puh3pbGlIwswFwyAa
         6qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334744; x=1719939544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUtLuGs0ukSBFvG4vkaqQiVb2jhLN4MYLhR39zHUHgY=;
        b=j0yKvC1Kg3AfxdavdJ1dolOCwGiMvAktb4r6YK/Jh8XQzH2DApV/k3Dh74w8tQnSwA
         uJzdAFtwtjqSl6uy/w7LMAVEB4KK5Cb5WH5nO3cgABkkVJCq0fWVUCqPaz0jAv3qxcuP
         IbTkt1a+IFR08jnjHPKUjxYQqjeO0MTQCCzfDi+hEjzmd88nFqf52A7tQOfpc1X8Wqpd
         8ZBiKAWlPleLkA9cNjPTsBD1hZU9dcr2Hg0omb+jfSroLYCyj+VcnjIp9Ge6s9PNMT1B
         0420JmZXgXoldxg8L7Dj00/zX0HALlkwl4IDoHqqP7ddka0Z6OzN5Wn/sydzvD5u+DPw
         48Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW9YDl4iYmrQ2eBO4DWOmb2u9F5efikYzO9XuD7iEw8jy5zs73AS7vn8oEvLNWspMg8q4cRWUGQzlf5l334g+E7yRq/YUt6HJnrExoV
X-Gm-Message-State: AOJu0Yz9ZS4O/W/t3P8bppPhLL32ZylNAHUNnEVLv3YNY0gk5CQokuwo
	TS2eoaGJ/mm4OPXEfswiWZqVA8oD+9hV2PhOxYYGBM99JQqokqN70DOODr0g5jU=
X-Google-Smtp-Source: AGHT+IF+yvfNwt3CzjVCgx/SD+x0KZ4MaLL2paGfLqfyn+54m3RJ6VNAyPj7F6ue1aObFB8MN8mQIQ==
X-Received: by 2002:a2e:7c07:0:b0:2ec:4f0c:36f9 with SMTP id 38308e7fff4ca-2ec5b31d140mr65443721fa.36.1719334744481;
        Tue, 25 Jun 2024 09:59:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm217969785e9.46.2024.06.25.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:59:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Jun 2024 18:58:46 +0200
Subject: [PATCH 2/3] ASoC: codecs: lpass-wsa-macro: Prepare to accommodate
 new codec versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-qcom-audio-wsa-second-speaker-v1-2-f65ffdfc368c@linaro.org>
References: <20240625-qcom-audio-wsa-second-speaker-v1-0-f65ffdfc368c@linaro.org>
In-Reply-To: <20240625-qcom-audio-wsa-second-speaker-v1-0-f65ffdfc368c@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26562;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4/CmNgyJJPY4+iEcsVtnGR9lNO+O99sF/57Okonhcg8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmevdSCPx9jSvj+azocNvsY2wvFpq0WjnCztlls
 5zS+tV2P0iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnr3UgAKCRDBN2bmhouD
 1/xgD/4yBdpR6GQScc/oHVQJTZq3rN66IMl6AqlU762//fxHYPrp1HZuphKc9L5J918PPfjlB9q
 hZVeKhZcyHMguflqB3QuXqtqQaklQP5kK2liMKeKejU000qoeQXFvjZUUI214Sa1xBkbhVSk3Qg
 jmpFI9JMqPa0KbBWEZEBSgOc0PQjlgST3eayxSpWESo45T/130gAeXcRDvwXmx92UXb0mqnAziZ
 8fuNOQ6d2TN05zWsS/hsMrEyihFUKkOv6qQsl6BeADDP+Kc3IAG98PrhTPnScto3/KhW6vbOULN
 EX+9mN5T21VtF/CrrlQYwS01uGHVwU7m6eGI+tV0YqcS/MbCvS3JC/5M2rwjv2UaLoDXV3SFfWL
 TcCvUGMJuUHYlbkKhGWwVS6bXEyJ1QESOG8Nq5LNS37wTDwqzJO1MvaHJhSpUC2WyaqpOnzRFoT
 xIjhG7Nk58cKRCkvc8vkkFjC4nEG29784yPsNo+x8ipGjApgm1kDmZMHwr3HkxXfXfF5W9ehlbe
 smi4PAJJwGDHw6xKTq6xcimSPK5wHIR5z/mXxYdYgzMOkHeESJXo7EphfY3hN0z1mRHpfcVMgAS
 dxZA7yxcYVV0tZhmjURkec7nFdDgpRjbnuPw0DD5s0bkX8814ZPv+s13sbQuKtBPrAciBMzjLbS
 yrbiEvyLcggQUng==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver for Qualcomm LPASS WSA macro codec was developed and tested
on codec v2.1, however v2.5 has significant changes in the registers.
The driver correctly works for v2.1 codec, but has issues when running
on SoC with v2.5 codec (so starting with SM8450, even though playback
works properly on that SoC).

Prepare the driver for handling differences in register layouts of newer
version.  This does not have functional impact on older codec versions,
but just:
1. Renames few soc_enums and widgets as v2.1,
2. For registers being different in v2.5, moves the defaults and regmap
   configuration to new structures,
3. Adds new 'struct wsa_reg_layout' with offsets and masks for few
   registers, so most of the code can stay unchaged on v2.5,
4. Chooses proper widgets, regmap config and register layout based on
   version of the codec.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 340 ++++++++++++++++++++++++-------------
 1 file changed, 218 insertions(+), 122 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index d12aff62a868..7888bc6c7dbb 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -44,11 +44,7 @@
 #define CDC_WSA_TOP_I2S_CLK			(0x00A4)
 #define CDC_WSA_TOP_I2S_RESET			(0x00A8)
 #define CDC_WSA_RX_INP_MUX_RX_INT0_CFG0		(0x0100)
-#define CDC_WSA_RX_INTX_1_MIX_INP0_SEL_MASK	GENMASK(2, 0)
-#define CDC_WSA_RX_INTX_1_MIX_INP1_SEL_MASK	GENMASK(5, 3)
 #define CDC_WSA_RX_INP_MUX_RX_INT0_CFG1		(0x0104)
-#define CDC_WSA_RX_INTX_2_SEL_MASK		GENMASK(2, 0)
-#define CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK	GENMASK(5, 3)
 #define CDC_WSA_RX_INP_MUX_RX_INT1_CFG0		(0x0108)
 #define CDC_WSA_RX_INP_MUX_RX_INT1_CFG1		(0x010C)
 #define CDC_WSA_RX_INP_MUX_RX_MIX_CFG0		(0x0110)
@@ -173,22 +169,7 @@
 #define CDC_WSA_COMPANDER0_CTL5			(0x0594)
 #define CDC_WSA_COMPANDER0_CTL6			(0x0598)
 #define CDC_WSA_COMPANDER0_CTL7			(0x059C)
-#define CDC_WSA_COMPANDER1_CTL0			(0x05C0)
-#define CDC_WSA_COMPANDER1_CTL1			(0x05C4)
-#define CDC_WSA_COMPANDER1_CTL2			(0x05C8)
-#define CDC_WSA_COMPANDER1_CTL3			(0x05CC)
-#define CDC_WSA_COMPANDER1_CTL4			(0x05D0)
-#define CDC_WSA_COMPANDER1_CTL5			(0x05D4)
-#define CDC_WSA_COMPANDER1_CTL6			(0x05D8)
-#define CDC_WSA_COMPANDER1_CTL7			(0x05DC)
-#define CDC_WSA_SOFTCLIP0_CRC			(0x0600)
-#define CDC_WSA_SOFTCLIP_CLK_EN_MASK		BIT(0)
-#define CDC_WSA_SOFTCLIP_CLK_ENABLE		BIT(0)
-#define CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL		(0x0604)
-#define CDC_WSA_SOFTCLIP_EN_MASK		BIT(0)
-#define CDC_WSA_SOFTCLIP_ENABLE			BIT(0)
-#define CDC_WSA_SOFTCLIP1_CRC			(0x0640)
-#define CDC_WSA_SOFTCLIP1_SOFTCLIP_CTRL		(0x0644)
+/* CDC_WSA_COMPANDER1_CTLx and CDC_WSA_SOFTCLIPx differ per LPASS codec versions */
 #define CDC_WSA_EC_HQ0_EC_REF_HQ_PATH_CTL	(0x0680)
 #define CDC_WSA_EC_HQ_EC_CLK_EN_MASK		BIT(0)
 #define CDC_WSA_EC_HQ_EC_CLK_ENABLE		BIT(0)
@@ -217,6 +198,24 @@
 #define CDC_WSA_SPLINE_ASRC1_STATUS_FIFO	(0x0760)
 #define WSA_MAX_OFFSET				(0x0760)
 
+/* LPASS codec version <=2.4 register offsets */
+#define CDC_WSA_COMPANDER1_CTL0			(0x05C0)
+#define CDC_WSA_COMPANDER1_CTL1			(0x05C4)
+#define CDC_WSA_COMPANDER1_CTL2			(0x05C8)
+#define CDC_WSA_COMPANDER1_CTL3			(0x05CC)
+#define CDC_WSA_COMPANDER1_CTL4			(0x05D0)
+#define CDC_WSA_COMPANDER1_CTL5			(0x05D4)
+#define CDC_WSA_COMPANDER1_CTL6			(0x05D8)
+#define CDC_WSA_COMPANDER1_CTL7			(0x05DC)
+#define CDC_WSA_SOFTCLIP0_CRC			(0x0600)
+#define CDC_WSA_SOFTCLIP_CLK_EN_MASK		BIT(0)
+#define CDC_WSA_SOFTCLIP_CLK_ENABLE		BIT(0)
+#define CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL		(0x0604)
+#define CDC_WSA_SOFTCLIP_EN_MASK		BIT(0)
+#define CDC_WSA_SOFTCLIP_ENABLE			BIT(0)
+#define CDC_WSA_SOFTCLIP1_CRC			(0x0640)
+#define CDC_WSA_SOFTCLIP1_SOFTCLIP_CTRL		(0x0644)
+
 #define WSA_MACRO_RX_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
@@ -237,8 +236,6 @@
 #define WSA_MACRO_MCLK_FREQ 19200000
 #define WSA_MACRO_MUX_CFG_OFFSET 0x8
 #define WSA_MACRO_MUX_CFG1_OFFSET 0x4
-#define WSA_MACRO_RX_COMP_OFFSET 0x40
-#define WSA_MACRO_RX_SOFTCLIP_OFFSET 0x40
 #define WSA_MACRO_RX_PATH_OFFSET 0x80
 #define WSA_MACRO_RX_PATH_CFG3_OFFSET 0x10
 #define WSA_MACRO_RX_PATH_DSMDEM_OFFSET 0x4C
@@ -334,12 +331,34 @@ enum {
 	WSA_MACRO_MAX_DAIS,
 };
 
+/**
+ * struct wsa_reg_layout - Register layout differences
+ * @rx_intx_1_mix_inp0_sel_mask: register mask for RX_INTX_1_MIX_INP0_SEL_MASK
+ * @rx_intx_1_mix_inp1_sel_mask: register mask for RX_INTX_1_MIX_INP1_SEL_MASK
+ * @rx_intx_1_mix_inp2_sel_mask: register mask for RX_INTX_1_MIX_INP2_SEL_MASK
+ * @rx_intx_2_sel_mask: register mask for RX_INTX_2_SEL_MASK
+ * @compander1_reg_offset: offset between compander registers (compander1 - compander0)
+ * @softclip0_reg_base: base address of softclip0 register
+ * @softclip1_reg_offset: offset between compander registers (softclip1 - softclip0)
+ */
+struct wsa_reg_layout {
+	unsigned int rx_intx_1_mix_inp0_sel_mask;
+	unsigned int rx_intx_1_mix_inp1_sel_mask;
+	unsigned int rx_intx_1_mix_inp2_sel_mask;
+	unsigned int rx_intx_2_sel_mask;
+	unsigned int compander1_reg_offset;
+	unsigned int softclip0_reg_base;
+	unsigned int softclip1_reg_offset;
+};
+
 struct wsa_macro {
 	struct device *dev;
 	int comp_enabled[WSA_MACRO_COMP_MAX];
 	int ec_hq[WSA_MACRO_RX1 + 1];
 	u16 prim_int_users[WSA_MACRO_RX1 + 1];
 	u16 wsa_mclk_users;
+	enum lpass_codec_version codec_version;
+	const struct wsa_reg_layout *reg_layout;
 	unsigned long active_ch_mask[WSA_MACRO_MAX_DAIS];
 	unsigned long active_ch_cnt[WSA_MACRO_MAX_DAIS];
 	int rx_port_value[WSA_MACRO_RX_MAX];
@@ -358,13 +377,23 @@ struct wsa_macro {
 };
 #define to_wsa_macro(_hw) container_of(_hw, struct wsa_macro, hw)
 
+static const struct wsa_reg_layout wsa_codec_v2_1 = {
+	.rx_intx_1_mix_inp0_sel_mask		= GENMASK(2, 0),
+	.rx_intx_1_mix_inp1_sel_mask		= GENMASK(5, 3),
+	.rx_intx_1_mix_inp2_sel_mask		= GENMASK(5, 3),
+	.rx_intx_2_sel_mask			= GENMASK(2, 0),
+	.compander1_reg_offset			= 0x40,
+	.softclip0_reg_base			= 0x600,
+	.softclip1_reg_offset			= 0x40,
+};
+
 static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
 
-static const char *const rx_text[] = {
+static const char *const rx_text_v2_1[] = {
 	"ZERO", "RX0", "RX1", "RX_MIX0", "RX_MIX1", "DEC0", "DEC1"
 };
 
-static const char *const rx_mix_text[] = {
+static const char *const rx_mix_text_v2_1[] = {
 	"ZERO", "RX0", "RX1", "RX_MIX0", "RX_MIX1"
 };
 
@@ -389,68 +418,68 @@ static SOC_ENUM_SINGLE_EXT_DECL(wsa_macro_ear_spkr_pa_gain_enum,
 				wsa_macro_ear_spkr_pa_gain_text);
 
 /* RX INT0 */
-static const struct soc_enum rx0_prim_inp0_chain_enum =
+static const struct soc_enum rx0_prim_inp0_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT0_CFG0,
-		0, 7, rx_text);
+		0, 7, rx_text_v2_1);
 
-static const struct soc_enum rx0_prim_inp1_chain_enum =
+static const struct soc_enum rx0_prim_inp1_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT0_CFG0,
-		3, 7, rx_text);
+		3, 7, rx_text_v2_1);
 
-static const struct soc_enum rx0_prim_inp2_chain_enum =
+static const struct soc_enum rx0_prim_inp2_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT0_CFG1,
-		3, 7, rx_text);
+		3, 7, rx_text_v2_1);
 
-static const struct soc_enum rx0_mix_chain_enum =
+static const struct soc_enum rx0_mix_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT0_CFG1,
-		0, 5, rx_mix_text);
+		0, 5, rx_mix_text_v2_1);
 
 static const struct soc_enum rx0_sidetone_mix_enum =
 	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, 2, rx_sidetone_mix_text);
 
-static const struct snd_kcontrol_new rx0_prim_inp0_mux =
-	SOC_DAPM_ENUM("WSA_RX0 INP0 Mux", rx0_prim_inp0_chain_enum);
+static const struct snd_kcontrol_new rx0_prim_inp0_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX0 INP0 Mux", rx0_prim_inp0_chain_enum_v2_1);
 
-static const struct snd_kcontrol_new rx0_prim_inp1_mux =
-	SOC_DAPM_ENUM("WSA_RX0 INP1 Mux", rx0_prim_inp1_chain_enum);
+static const struct snd_kcontrol_new rx0_prim_inp1_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX0 INP1 Mux", rx0_prim_inp1_chain_enum_v2_1);
 
-static const struct snd_kcontrol_new rx0_prim_inp2_mux =
-	SOC_DAPM_ENUM("WSA_RX0 INP2 Mux", rx0_prim_inp2_chain_enum);
+static const struct snd_kcontrol_new rx0_prim_inp2_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX0 INP2 Mux", rx0_prim_inp2_chain_enum_v2_1);
 
-static const struct snd_kcontrol_new rx0_mix_mux =
-	SOC_DAPM_ENUM("WSA_RX0 MIX Mux", rx0_mix_chain_enum);
+static const struct snd_kcontrol_new rx0_mix_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX0 MIX Mux", rx0_mix_chain_enum_v2_1);
 
 static const struct snd_kcontrol_new rx0_sidetone_mix_mux =
 	SOC_DAPM_ENUM("WSA_RX0 SIDETONE MIX Mux", rx0_sidetone_mix_enum);
 
 /* RX INT1 */
-static const struct soc_enum rx1_prim_inp0_chain_enum =
+static const struct soc_enum rx1_prim_inp0_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT1_CFG0,
-		0, 7, rx_text);
+		0, 7, rx_text_v2_1);
 
-static const struct soc_enum rx1_prim_inp1_chain_enum =
+static const struct soc_enum rx1_prim_inp1_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT1_CFG0,
-		3, 7, rx_text);
+		3, 7, rx_text_v2_1);
 
-static const struct soc_enum rx1_prim_inp2_chain_enum =
+static const struct soc_enum rx1_prim_inp2_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT1_CFG1,
-		3, 7, rx_text);
+		3, 7, rx_text_v2_1);
 
-static const struct soc_enum rx1_mix_chain_enum =
+static const struct soc_enum rx1_mix_chain_enum_v2_1 =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_INT1_CFG1,
-		0, 5, rx_mix_text);
+		0, 5, rx_mix_text_v2_1);
 
-static const struct snd_kcontrol_new rx1_prim_inp0_mux =
-	SOC_DAPM_ENUM("WSA_RX1 INP0 Mux", rx1_prim_inp0_chain_enum);
+static const struct snd_kcontrol_new rx1_prim_inp0_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX1 INP0 Mux", rx1_prim_inp0_chain_enum_v2_1);
 
-static const struct snd_kcontrol_new rx1_prim_inp1_mux =
-	SOC_DAPM_ENUM("WSA_RX1 INP1 Mux", rx1_prim_inp1_chain_enum);
+static const struct snd_kcontrol_new rx1_prim_inp1_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX1 INP1 Mux", rx1_prim_inp1_chain_enum_v2_1);
 
-static const struct snd_kcontrol_new rx1_prim_inp2_mux =
-	SOC_DAPM_ENUM("WSA_RX1 INP2 Mux", rx1_prim_inp2_chain_enum);
+static const struct snd_kcontrol_new rx1_prim_inp2_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX1 INP2 Mux", rx1_prim_inp2_chain_enum_v2_1);
 
-static const struct snd_kcontrol_new rx1_mix_mux =
-	SOC_DAPM_ENUM("WSA_RX1 MIX Mux", rx1_mix_chain_enum);
+static const struct snd_kcontrol_new rx1_mix_mux_v2_1 =
+	SOC_DAPM_ENUM("WSA_RX1 MIX Mux", rx1_mix_chain_enum_v2_1);
 
 static const struct soc_enum rx_mix_ec0_enum =
 	SOC_ENUM_SINGLE(CDC_WSA_RX_INP_MUX_RX_MIX_CFG0,
@@ -489,14 +518,6 @@ static const struct reg_default wsa_defaults[] = {
 	{ CDC_WSA_RX_INP_MUX_RX_MIX_CFG0, 0x00},
 	{ CDC_WSA_RX_INP_MUX_RX_EC_CFG0, 0x00},
 	{ CDC_WSA_RX_INP_MUX_SOFTCLIP_CFG0, 0x00},
-	{ CDC_WSA_TX0_SPKR_PROT_PATH_CTL, 0x02},
-	{ CDC_WSA_TX0_SPKR_PROT_PATH_CFG0, 0x00},
-	{ CDC_WSA_TX1_SPKR_PROT_PATH_CTL, 0x02},
-	{ CDC_WSA_TX1_SPKR_PROT_PATH_CFG0, 0x00},
-	{ CDC_WSA_TX2_SPKR_PROT_PATH_CTL, 0x02},
-	{ CDC_WSA_TX2_SPKR_PROT_PATH_CFG0, 0x00},
-	{ CDC_WSA_TX3_SPKR_PROT_PATH_CTL, 0x02},
-	{ CDC_WSA_TX3_SPKR_PROT_PATH_CFG0, 0x00},
 	{ CDC_WSA_INTR_CTRL_CFG, 0x00},
 	{ CDC_WSA_INTR_CTRL_CLR_COMMIT, 0x00},
 	{ CDC_WSA_INTR_CTRL_PIN1_MASK0, 0xFF},
@@ -561,18 +582,6 @@ static const struct reg_default wsa_defaults[] = {
 	{ CDC_WSA_COMPANDER0_CTL5, 0x00},
 	{ CDC_WSA_COMPANDER0_CTL6, 0x01},
 	{ CDC_WSA_COMPANDER0_CTL7, 0x28},
-	{ CDC_WSA_COMPANDER1_CTL0, 0x60},
-	{ CDC_WSA_COMPANDER1_CTL1, 0xDB},
-	{ CDC_WSA_COMPANDER1_CTL2, 0xFF},
-	{ CDC_WSA_COMPANDER1_CTL3, 0x35},
-	{ CDC_WSA_COMPANDER1_CTL4, 0xFF},
-	{ CDC_WSA_COMPANDER1_CTL5, 0x00},
-	{ CDC_WSA_COMPANDER1_CTL6, 0x01},
-	{ CDC_WSA_COMPANDER1_CTL7, 0x28},
-	{ CDC_WSA_SOFTCLIP0_CRC, 0x00},
-	{ CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL, 0x38},
-	{ CDC_WSA_SOFTCLIP1_CRC, 0x00},
-	{ CDC_WSA_SOFTCLIP1_SOFTCLIP_CTRL, 0x38},
 	{ CDC_WSA_EC_HQ0_EC_REF_HQ_PATH_CTL, 0x00},
 	{ CDC_WSA_EC_HQ0_EC_REF_HQ_CFG0, 0x01},
 	{ CDC_WSA_EC_HQ1_EC_REF_HQ_PATH_CTL, 0x00},
@@ -597,6 +606,29 @@ static const struct reg_default wsa_defaults[] = {
 	{ CDC_WSA_SPLINE_ASRC1_STATUS_FIFO, 0x00},
 };
 
+static const struct reg_default wsa_defaults_v2_1[] = {
+	{ CDC_WSA_TX0_SPKR_PROT_PATH_CTL, 0x02},
+	{ CDC_WSA_TX0_SPKR_PROT_PATH_CFG0, 0x00},
+	{ CDC_WSA_TX1_SPKR_PROT_PATH_CTL, 0x02},
+	{ CDC_WSA_TX1_SPKR_PROT_PATH_CFG0, 0x00},
+	{ CDC_WSA_TX2_SPKR_PROT_PATH_CTL, 0x02},
+	{ CDC_WSA_TX2_SPKR_PROT_PATH_CFG0, 0x00},
+	{ CDC_WSA_TX3_SPKR_PROT_PATH_CTL, 0x02},
+	{ CDC_WSA_TX3_SPKR_PROT_PATH_CFG0, 0x00},
+	{ CDC_WSA_COMPANDER1_CTL0, 0x60},
+	{ CDC_WSA_COMPANDER1_CTL1, 0xDB},
+	{ CDC_WSA_COMPANDER1_CTL2, 0xFF},
+	{ CDC_WSA_COMPANDER1_CTL3, 0x35},
+	{ CDC_WSA_COMPANDER1_CTL4, 0xFF},
+	{ CDC_WSA_COMPANDER1_CTL5, 0x00},
+	{ CDC_WSA_COMPANDER1_CTL6, 0x01},
+	{ CDC_WSA_COMPANDER1_CTL7, 0x28},
+	{ CDC_WSA_SOFTCLIP0_CRC, 0x00},
+	{ CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL, 0x38},
+	{ CDC_WSA_SOFTCLIP1_CRC, 0x00},
+	{ CDC_WSA_SOFTCLIP1_SOFTCLIP_CTRL, 0x38},
+};
+
 static bool wsa_is_wronly_register(struct device *dev,
 					unsigned int reg)
 {
@@ -610,6 +642,26 @@ static bool wsa_is_wronly_register(struct device *dev,
 	return false;
 }
 
+static bool wsa_is_rw_register_v2_1(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CDC_WSA_COMPANDER1_CTL0:
+	case CDC_WSA_COMPANDER1_CTL1:
+	case CDC_WSA_COMPANDER1_CTL2:
+	case CDC_WSA_COMPANDER1_CTL3:
+	case CDC_WSA_COMPANDER1_CTL4:
+	case CDC_WSA_COMPANDER1_CTL5:
+	case CDC_WSA_COMPANDER1_CTL7:
+	case CDC_WSA_SOFTCLIP0_CRC:
+	case CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL:
+	case CDC_WSA_SOFTCLIP1_CRC:
+	case CDC_WSA_SOFTCLIP1_SOFTCLIP_CTRL:
+		return true;
+	}
+
+	return false;
+}
+
 static bool wsa_is_rw_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -701,17 +753,6 @@ static bool wsa_is_rw_register(struct device *dev, unsigned int reg)
 	case CDC_WSA_COMPANDER0_CTL4:
 	case CDC_WSA_COMPANDER0_CTL5:
 	case CDC_WSA_COMPANDER0_CTL7:
-	case CDC_WSA_COMPANDER1_CTL0:
-	case CDC_WSA_COMPANDER1_CTL1:
-	case CDC_WSA_COMPANDER1_CTL2:
-	case CDC_WSA_COMPANDER1_CTL3:
-	case CDC_WSA_COMPANDER1_CTL4:
-	case CDC_WSA_COMPANDER1_CTL5:
-	case CDC_WSA_COMPANDER1_CTL7:
-	case CDC_WSA_SOFTCLIP0_CRC:
-	case CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL:
-	case CDC_WSA_SOFTCLIP1_CRC:
-	case CDC_WSA_SOFTCLIP1_SOFTCLIP_CTRL:
 	case CDC_WSA_EC_HQ0_EC_REF_HQ_PATH_CTL:
 	case CDC_WSA_EC_HQ0_EC_REF_HQ_CFG0:
 	case CDC_WSA_EC_HQ1_EC_REF_HQ_PATH_CTL:
@@ -727,7 +768,7 @@ static bool wsa_is_rw_register(struct device *dev, unsigned int reg)
 		return true;
 	}
 
-	return false;
+	return wsa_is_rw_register_v2_1(dev, reg);
 }
 
 static bool wsa_is_writeable_register(struct device *dev, unsigned int reg)
@@ -741,6 +782,16 @@ static bool wsa_is_writeable_register(struct device *dev, unsigned int reg)
 	return ret;
 }
 
+static bool wsa_is_readable_register_v2_1(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CDC_WSA_COMPANDER1_CTL6:
+		return true;
+	}
+
+	return wsa_is_rw_register(dev, reg);
+}
+
 static bool wsa_is_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -750,7 +801,6 @@ static bool wsa_is_readable_register(struct device *dev, unsigned int reg)
 	case CDC_WSA_INTR_CTRL_PIN1_STATUS0:
 	case CDC_WSA_INTR_CTRL_PIN2_STATUS0:
 	case CDC_WSA_COMPANDER0_CTL6:
-	case CDC_WSA_COMPANDER1_CTL6:
 	case CDC_WSA_SPLINE_ASRC0_STATUS_FMIN_CNTR_LSB:
 	case CDC_WSA_SPLINE_ASRC0_STATUS_FMIN_CNTR_MSB:
 	case CDC_WSA_SPLINE_ASRC0_STATUS_FMAX_CNTR_LSB:
@@ -764,7 +814,17 @@ static bool wsa_is_readable_register(struct device *dev, unsigned int reg)
 		return true;
 	}
 
-	return wsa_is_rw_register(dev, reg);
+	return wsa_is_readable_register_v2_1(dev, reg);
+}
+
+static bool wsa_is_volatile_register_v2_1(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CDC_WSA_COMPANDER1_CTL6:
+		return true;
+	}
+
+	return false;
 }
 
 static bool wsa_is_volatile_register(struct device *dev, unsigned int reg)
@@ -774,7 +834,6 @@ static bool wsa_is_volatile_register(struct device *dev, unsigned int reg)
 	case CDC_WSA_INTR_CTRL_PIN1_STATUS0:
 	case CDC_WSA_INTR_CTRL_PIN2_STATUS0:
 	case CDC_WSA_COMPANDER0_CTL6:
-	case CDC_WSA_COMPANDER1_CTL6:
 	case CDC_WSA_SPLINE_ASRC0_STATUS_FMIN_CNTR_LSB:
 	case CDC_WSA_SPLINE_ASRC0_STATUS_FMIN_CNTR_MSB:
 	case CDC_WSA_SPLINE_ASRC0_STATUS_FMAX_CNTR_LSB:
@@ -787,7 +846,8 @@ static bool wsa_is_volatile_register(struct device *dev, unsigned int reg)
 	case CDC_WSA_SPLINE_ASRC1_STATUS_FIFO:
 		return true;
 	}
-	return false;
+
+	return wsa_is_volatile_register_v2_1(dev, reg);
 }
 
 static const struct regmap_config wsa_regmap_config = {
@@ -796,8 +856,7 @@ static const struct regmap_config wsa_regmap_config = {
 	.val_bits = 32, /* 8 but with 32 bit read/write */
 	.reg_stride = 4,
 	.cache_type = REGCACHE_FLAT,
-	.reg_defaults = wsa_defaults,
-	.num_reg_defaults = ARRAY_SIZE(wsa_defaults),
+	/* .reg_defaults and .num_reg_defaults set in probe() */
 	.max_register = WSA_MAX_OFFSET,
 	.writeable_reg = wsa_is_writeable_register,
 	.volatile_reg = wsa_is_volatile_register,
@@ -871,11 +930,11 @@ static int wsa_macro_set_prim_interpolator_rate(struct snd_soc_dai *dai,
 		for (j = 0; j < NUM_INTERPOLATORS; j++) {
 			int_mux_cfg1 = int_mux_cfg0 + WSA_MACRO_MUX_CFG1_OFFSET;
 			inp0_sel = snd_soc_component_read_field(component, int_mux_cfg0, 
-								CDC_WSA_RX_INTX_1_MIX_INP0_SEL_MASK);
-			inp1_sel = snd_soc_component_read_field(component, int_mux_cfg0, 
-								CDC_WSA_RX_INTX_1_MIX_INP1_SEL_MASK);
+								wsa->reg_layout->rx_intx_1_mix_inp0_sel_mask);
+			inp1_sel = snd_soc_component_read_field(component, int_mux_cfg0,
+								wsa->reg_layout->rx_intx_1_mix_inp1_sel_mask);
 			inp2_sel = snd_soc_component_read_field(component, int_mux_cfg1,
-								CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK);
+								wsa->reg_layout->rx_intx_1_mix_inp2_sel_mask);
 
 			if ((inp0_sel == int_1_mix1_inp + INTn_1_INP_SEL_RX0) ||
 			    (inp1_sel == int_1_mix1_inp + INTn_1_INP_SEL_RX0) ||
@@ -916,7 +975,7 @@ static int wsa_macro_set_mix_interpolator_rate(struct snd_soc_dai *dai,
 		int_mux_cfg1 = CDC_WSA_RX_INP_MUX_RX_INT0_CFG1;
 		for (j = 0; j < NUM_INTERPOLATORS; j++) {
 			int_mux_cfg1_val = snd_soc_component_read_field(component, int_mux_cfg1,
-									CDC_WSA_RX_INTX_2_SEL_MASK);
+									wsa->reg_layout->rx_intx_2_sel_mask);
 
 			if (int_mux_cfg1_val == int_2_inp + INTn_2_INP_SEL_RX0) {
 				int_fs_reg = CDC_WSA_RX0_RX_PATH_MIX_CTL +
@@ -1299,7 +1358,7 @@ static int wsa_macro_config_compander(struct snd_soc_component *component,
 		return 0;
 
 	comp_ctl0_reg = CDC_WSA_COMPANDER0_CTL0 +
-					(comp * WSA_MACRO_RX_COMP_OFFSET);
+					(comp * wsa->reg_layout->compander1_reg_offset);
 	rx_path_cfg0_reg = CDC_WSA_RX0_RX_PATH_CFG0 +
 					(comp * WSA_MACRO_RX_PATH_OFFSET);
 
@@ -1345,8 +1404,8 @@ static void wsa_macro_enable_softclip_clk(struct snd_soc_component *component,
 					 int path,
 					 bool enable)
 {
-	u16 softclip_clk_reg = CDC_WSA_SOFTCLIP0_CRC +
-			(path * WSA_MACRO_RX_SOFTCLIP_OFFSET);
+	u16 softclip_clk_reg = wsa->reg_layout->softclip0_reg_base +
+			(path * wsa->reg_layout->softclip1_reg_offset);
 	u8 softclip_mux_mask = (1 << path);
 	u8 softclip_mux_value = (1 << path);
 
@@ -1391,7 +1450,7 @@ static int wsa_macro_config_softclip(struct snd_soc_component *component,
 		return 0;
 
 	softclip_ctrl_reg = CDC_WSA_SOFTCLIP0_SOFTCLIP_CTRL +
-				(softclip_path * WSA_MACRO_RX_SOFTCLIP_OFFSET);
+				(softclip_path * wsa->reg_layout->softclip1_reg_offset);
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		/* Enable Softclip clock and mux */
@@ -1416,6 +1475,7 @@ static int wsa_macro_config_softclip(struct snd_soc_component *component,
 static bool wsa_macro_adie_lb(struct snd_soc_component *component,
 			      int interp_idx)
 {
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 	u16 int_mux_cfg0,  int_mux_cfg1;
 	u8 int_n_inp0, int_n_inp1, int_n_inp2;
 
@@ -1423,19 +1483,19 @@ static bool wsa_macro_adie_lb(struct snd_soc_component *component,
 	int_mux_cfg1 = int_mux_cfg0 + 4;
 
 	int_n_inp0 = snd_soc_component_read_field(component, int_mux_cfg0,
-						  CDC_WSA_RX_INTX_1_MIX_INP0_SEL_MASK);
+						  wsa->reg_layout->rx_intx_1_mix_inp0_sel_mask);
 	if (int_n_inp0 == INTn_1_INP_SEL_DEC0 ||
 		int_n_inp0 == INTn_1_INP_SEL_DEC1)
 		return true;
 
 	int_n_inp1 = snd_soc_component_read_field(component, int_mux_cfg0,
-						  CDC_WSA_RX_INTX_1_MIX_INP1_SEL_MASK);
+						  wsa->reg_layout->rx_intx_1_mix_inp1_sel_mask);
 	if (int_n_inp1 == INTn_1_INP_SEL_DEC0 ||
 		int_n_inp1 == INTn_1_INP_SEL_DEC1)
 		return true;
 
 	int_n_inp2 = snd_soc_component_read_field(component, int_mux_cfg1,
-						  CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK);
+						  wsa->reg_layout->rx_intx_1_mix_inp2_sel_mask);
 	if (int_n_inp2 == INTn_1_INP_SEL_DEC0 ||
 		int_n_inp2 == INTn_1_INP_SEL_DEC1)
 		return true;
@@ -2073,19 +2133,6 @@ static const struct snd_soc_dapm_widget wsa_macro_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("WSA RX_MIX0", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("WSA RX_MIX1", SND_SOC_NOPM, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_MUX("WSA_RX0 INP0", SND_SOC_NOPM, 0, 0, &rx0_prim_inp0_mux),
-	SND_SOC_DAPM_MUX("WSA_RX0 INP1", SND_SOC_NOPM, 0, 0, &rx0_prim_inp1_mux),
-	SND_SOC_DAPM_MUX("WSA_RX0 INP2", SND_SOC_NOPM, 0, 0, &rx0_prim_inp2_mux),
-	SND_SOC_DAPM_MUX_E("WSA_RX0 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX0,
-			   0, &rx0_mix_mux, wsa_macro_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX("WSA_RX1 INP0", SND_SOC_NOPM, 0, 0, &rx1_prim_inp0_mux),
-	SND_SOC_DAPM_MUX("WSA_RX1 INP1", SND_SOC_NOPM, 0, 0, &rx1_prim_inp1_mux),
-	SND_SOC_DAPM_MUX("WSA_RX1 INP2", SND_SOC_NOPM, 0, 0, &rx1_prim_inp2_mux),
-	SND_SOC_DAPM_MUX_E("WSA_RX1 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX1,
-			   0, &rx1_mix_mux, wsa_macro_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-
 	SND_SOC_DAPM_MIXER_E("WSA_RX INT0 MIX", SND_SOC_NOPM, 0, 0, NULL, 0,
 			     wsa_macro_enable_main_path, SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_MIXER_E("WSA_RX INT1 MIX", SND_SOC_NOPM, 1, 0, NULL, 0,
@@ -2136,6 +2183,21 @@ static const struct snd_soc_dapm_widget wsa_macro_dapm_widgets[] = {
 			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
+static const struct snd_soc_dapm_widget wsa_macro_dapm_widgets_v2_1[] = {
+	SND_SOC_DAPM_MUX("WSA_RX0 INP0", SND_SOC_NOPM, 0, 0, &rx0_prim_inp0_mux_v2_1),
+	SND_SOC_DAPM_MUX("WSA_RX0 INP1", SND_SOC_NOPM, 0, 0, &rx0_prim_inp1_mux_v2_1),
+	SND_SOC_DAPM_MUX("WSA_RX0 INP2", SND_SOC_NOPM, 0, 0, &rx0_prim_inp2_mux_v2_1),
+	SND_SOC_DAPM_MUX_E("WSA_RX0 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX0,
+			   0, &rx0_mix_mux_v2_1, wsa_macro_enable_mix_path,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("WSA_RX1 INP0", SND_SOC_NOPM, 0, 0, &rx1_prim_inp0_mux_v2_1),
+	SND_SOC_DAPM_MUX("WSA_RX1 INP1", SND_SOC_NOPM, 0, 0, &rx1_prim_inp1_mux_v2_1),
+	SND_SOC_DAPM_MUX("WSA_RX1 INP2", SND_SOC_NOPM, 0, 0, &rx1_prim_inp2_mux_v2_1),
+	SND_SOC_DAPM_MUX_E("WSA_RX1 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX1,
+			   0, &rx1_mix_mux_v2_1, wsa_macro_enable_mix_path,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
 static const struct snd_soc_dapm_route wsa_audio_map[] = {
 	/* VI Feedback */
 	{"WSA_AIF_VI Mixer", "WSA_SPKR_VI_1", "VIINPUT_WSA"},
@@ -2281,7 +2343,10 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 
 static int wsa_macro_component_probe(struct snd_soc_component *comp)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(comp);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(comp);
+	const struct snd_soc_dapm_widget *widgets;
+	unsigned int num_widgets;
 
 	snd_soc_component_init_regmap(comp, wsa->regmap);
 
@@ -2298,7 +2363,10 @@ static int wsa_macro_component_probe(struct snd_soc_component *comp)
 
 	wsa_macro_set_spkr_mode(comp, WSA_MACRO_SPKR_MODE_1);
 
-	return 0;
+	widgets = wsa_macro_dapm_widgets_v2_1;
+	num_widgets = ARRAY_SIZE(wsa_macro_dapm_widgets_v2_1);
+
+	return snd_soc_dapm_new_controls(dapm, widgets, num_widgets);
 }
 
 static int swclk_gate_enable(struct clk_hw *hw)
@@ -2378,10 +2446,12 @@ static const struct snd_soc_component_driver wsa_macro_component_drv = {
 static int wsa_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct reg_default *reg_defaults;
+	struct regmap_config *reg_config;
 	struct wsa_macro *wsa;
 	kernel_ulong_t flags;
 	void __iomem *base;
-	int ret;
+	int ret, def_count;
 
 	flags = (kernel_ulong_t)device_get_match_data(dev);
 
@@ -2415,10 +2485,36 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	wsa->regmap = devm_regmap_init_mmio(dev, base, &wsa_regmap_config);
+	wsa->codec_version = lpass_macro_get_codec_version();
+	switch (wsa->codec_version) {
+	default:
+		wsa->reg_layout = &wsa_codec_v2_1;
+		def_count = ARRAY_SIZE(wsa_defaults) + ARRAY_SIZE(wsa_defaults_v2_1);
+		reg_defaults = devm_kmalloc_array(dev, def_count,
+						  sizeof(*reg_defaults),
+						  GFP_KERNEL);
+		if (!reg_defaults)
+			return -ENOMEM;
+		memcpy(&reg_defaults[0], wsa_defaults, sizeof(wsa_defaults));
+		memcpy(&reg_defaults[ARRAY_SIZE(wsa_defaults)],
+		       wsa_defaults_v2_1, sizeof(wsa_defaults_v2_1));
+		break;
+	}
+
+	reg_config = devm_kmemdup(dev, &wsa_regmap_config,
+				  sizeof(*reg_config), GFP_KERNEL);
+	if (!reg_config)
+		return -ENOMEM;
+
+	reg_config->reg_defaults = reg_defaults;
+	reg_config->num_reg_defaults = def_count;
+
+	wsa->regmap = devm_regmap_init_mmio(dev, base, reg_config);
 	if (IS_ERR(wsa->regmap))
 		return PTR_ERR(wsa->regmap);
 
+	devm_kfree(dev, reg_config);
+	devm_kfree(dev, reg_defaults);
 	dev_set_drvdata(dev, wsa);
 
 	wsa->dev = dev;

-- 
2.43.0


