Return-Path: <linux-kernel+bounces-211891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA81905889
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40212B2532F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF218508E;
	Wed, 12 Jun 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMtTRhlf"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB139184102
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208961; cv=none; b=n2T817l6zCTjk5OCLMuugiiprYLi7DOC0J8sssigYeCHsVxcGnAjWVBUgOvjRM4LhGGwkpvGh9Zgk+1PXNQUIg0FBNqLrAqa0Aaa5wMoS3VFIC5faSBgihxPmwmSQ9u48Wqjwr3tEsz46lbXWEZ2YiGnw6yPBPFBU/3FXCoFsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208961; c=relaxed/simple;
	bh=LTstfjn1hMHMf+Q8MdqFM/YRF0Q4UyK8wtDcQ2OvBmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pm+3uiNE0GbJJzsCrJFib8QqhpkiklwqPi3M+cuVVnBnAvO2RHARBDY2y0V4+G3Y64gQJcKz0XOo3dAKn7TAWJHAVVfQnEenWNKfGoUvcjJgRQfcSChYW1h852SSXNLl0ic1T4MwPuLYmnqLeMT79gth9MFecKv1Y1R/AOI1wQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMtTRhlf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a62ef52e837so9060866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208958; x=1718813758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0RoCwzR24DTjnx5Ae0LKefqJtZxwLkqbFaLkQ97nAo=;
        b=tMtTRhlfNNOn+e0JrmKMGpLfamz8acLFFF+g1WzLMtnj7bdXFzI7mVEzXC7wOSXKMt
         PXdSJXuoLDaKju1MQy/Ndx63ziqR8Q80Fxt3kBxXt3XHbM7PVB0fyMeca+MtI2pV+N2p
         733ApdgUBBGJ5lUXPkP0oYWnK4yzonu2/SCbWyGiVdc2AjvX4dLKP//Xx0iVPBYEfAbn
         1w9kHITvGy+Qdz6QxD0Z7a2/WapiqSNasupuRoh1TVx7MtLf/fkvhxSQ3BcrdThbiO1z
         fFam/lXKqdDl+Q3yrcVjTHd11K2E8e++ZJDvejOvPIaVTEBtTYweDrUsubfc3p/uK4eR
         Zg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208958; x=1718813758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0RoCwzR24DTjnx5Ae0LKefqJtZxwLkqbFaLkQ97nAo=;
        b=HTUr0vvBMREXfowfYiIs6gY+WM0Ad8b0YVo67Hx5rE+aZgO4pGQ1W882iODFG1N6nM
         wxIdroefnCl2IblLxGsNOEn2LCY+c2mPZ0PTMLMSdVqnbcgI2DerrrczndNYx2NWK8lA
         Ljhihtex8nqaF7aHQ/JwHEWHGt7GUMD544ABIOoV+GalucLTqRTADLs+6L18QJoqHL6x
         w91CPefj19FzL5LU4lxyA61ZH9caZuaUnpw4lr1iSgYcX8r8HNi4JMhMmQbNTPHG/0+s
         /9f63Jz2qxjZV9QjSrQ8CDP1gimodAgtSxsxhTKK2UmC4BCw1dwt/okh3I+4k05bex7f
         Bu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfEhDlsr9KZSmPnRDU4iDv+2VBpHEDXPXFdG7c2ZF8xxeYJFjaG0AxcbpEJkSedqibW07Fo6ukVTTTirD+hSVr1oH9coo0J53BP+sV
X-Gm-Message-State: AOJu0YyNkM1xKSUq78y4IpeNJFhhofUi3tiCZgKfhGcGxoOqCmfXOzz1
	Qz2K8He3WIynKw3vVNNq3imm1Nwkhar47Y8Dea658PIbNP38eoXbsP5FwYm6vfc=
X-Google-Smtp-Source: AGHT+IEHT7fjxNIbBkv5TRIIRZ6myoWuerWmlXjHIwCrkRZNl6xan8/1FVtMhhGq1x0G45gcVVc3LA==
X-Received: by 2002:a17:906:756:b0:a6f:4a5c:4ba9 with SMTP id a640c23a62f3a-a6f4a5c4e2dmr136376666b.39.1718208958141;
        Wed, 12 Jun 2024 09:15:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:25 +0200
Subject: [PATCH 12/23] ASoC: codecs: wcd937x: Constify wcd937x_sdw_ch_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-12-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LTstfjn1hMHMf+Q8MdqFM/YRF0Q4UyK8wtDcQ2OvBmk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmhBBzVRShUj1VYQpmrpSMRLxtLFx+CLMBIR
 JATHB9laYKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJoQAKCRDBN2bmhouD
 17KNEACKbYdkfoppv6n+mBfwN8E80Bvdy7+v/7JJre6HAW4Z6Z6RgRdCLEAxh05k7fBgq4/UAfj
 jSxcu7pXOKCgUvlkBMbA1/OjwGIq0+qB6t7R7RMS8OW72dlYEnJc5gz+SG1hTVybKfpkbXcN5y2
 ivhTJfyi0bQeYCftqgRR6Dhzy7goc+Vd28khWHuP3k+zolV6qTXfmSskz818mWDjP7aoP9d/57k
 gFRgmyvHtpRHs8AOr9rPQSwmG+al98s8M4+oHnmfgyO/xBT/k0VvLJgj54etrGpsyiFbp1XG9YU
 FKsecBbhHyPa+LNUVGIlEQ/qIn8exFoy6hfVGLEDQGcrz6HpwDZEbnPIi17fw5PNCmbkAaOUQRM
 HUhdZgjG2HSsiAAL5cr+drtIoD4Fkpj83PFFvWOP2cnCPMAO9s6gDJj3FQl2AEhc5ppiHGsJNBA
 B/SsxDtfZ9jxvgi4PitAUd1KnfwBLZ+Zs1yqLDPdqnG/6o6S2rfP/3jLS38vkmZUWU8O9T2oJ88
 KHIqlsWzayMzsvh4w/OqekWzHmwAl2yOdm+b2FOtdF92gvcfO5D0wlGg0a1cTkMrFCdyIbE+RUN
 5SzOTH1/xvQslhNtKqRQHYcvUwmyIaA8HtW0kY5rPyje0N2h/e6GmNVRX1H8iPgeBrxYTTeMZS6
 mFNdzhmp5tQTS3g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static wcd937x_sdw_ch_info array, so it can be
made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x-sdw.c | 4 ++--
 sound/soc/codecs/wcd937x.c     | 2 +-
 sound/soc/codecs/wcd937x.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index a45025bf96c6..a24d6c620dba 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -19,7 +19,7 @@
 #include <sound/soc.h>
 #include "wcd937x.h"
 
-static struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
+static const struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_HPH_L, WCD937X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_HPH_R, WCD937X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD937X_CLSH, WCD937X_CLSH_PORT, BIT(0)),
@@ -30,7 +30,7 @@ static struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_DSD_R, WCD937X_DSD_PORT, BIT(1)),
 };
 
-static struct wcd937x_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
+static const struct wcd937x_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_ADC1, WCD937X_ADC_1_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_ADC2, WCD937X_ADC_2_3_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_ADC3, WCD937X_ADC_2_3_PORT, BIT(0)),
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 4cf17d62a0bc..8b000ba9a469 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -1244,7 +1244,7 @@ static int wcd937x_codec_enable_micbias_pullup(struct snd_soc_dapm_widget *w,
 static int wcd937x_connect_port(struct wcd937x_sdw_priv *wcd, u8 port_idx, u8 ch_id, bool enable)
 {
 	struct sdw_port_config *port_config = &wcd->port_config[port_idx - 1];
-	struct wcd937x_sdw_ch_info *ch_info = &wcd->ch_info[ch_id];
+	const struct wcd937x_sdw_ch_info *ch_info = &wcd->ch_info[ch_id];
 	u8 port_num = ch_info->port_num;
 	u8 ch_mask = ch_info->ch_mask;
 
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index e6e1ad5926d5..6f857ce7d8b7 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -522,7 +522,7 @@ struct wcd937x_sdw_priv {
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD937X_MAX_SWR_PORTS];
-	struct wcd937x_sdw_ch_info *ch_info;
+	const struct wcd937x_sdw_ch_info *ch_info;
 	bool port_enable[WCD937X_MAX_SWR_CH_IDS];
 	int active_ports;
 	int num_ports;

-- 
2.43.0


