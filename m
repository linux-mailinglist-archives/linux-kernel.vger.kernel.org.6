Return-Path: <linux-kernel+bounces-337997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5A985210
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD7C285679
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619C14C5BF;
	Wed, 25 Sep 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD2Zz3KO"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E62F52
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727239110; cv=none; b=g8SLzc05WiNd5srTg0S1v8/SYQOleLNTcwePSjgbKYZs46OQAsofO/xsapvc02uGPlA1ncYSKzDHwvTC7nDcj4OG9xwFRxNe5I4cRXllnhYIGGXp2x6OP316Yj5uyXz88Y1BMEvaLM/8Rk3g987wgrzh0C/3mV/KABZiOPA/MHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727239110; c=relaxed/simple;
	bh=vcbtUAz7yhwWjWdeSyDPvePJuJQCbBjXfWfwU0OxtHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyYT1PrjiMF8dB+7HW5OpeuDk364JKr87suX+SGSaW798fKxU5ckSf/QmA5jq45Bp+bU1jN4b3rP8NWLvy0WQllCjAjXj6D+M+uRcjF+oqmrAumdG2FY+jZMYVtbay8mM/cUXMt2U2/iWEQqipvfERRu41uP1daLXm6LO2ZBu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aD2Zz3KO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so875430566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727239106; x=1727843906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/oxZoO71PQ5m5Ow+SV5/SV/jvpv3lxQQXCYtby61Bc=;
        b=aD2Zz3KOB5jLldI+7RcSUqDJrUMc0bvGg+Wpf/EGibPBGWfjdPvXPOTIlt5xKGUdwA
         lJpEZ4zCK2JPnWIHNe+oGJiVTLy3hnx3BoTuYq87O5NqajYKDM8KofPQl5xVNHjeAJ8T
         fOxILsEc8OjAPrHfq6f429dcr4yhykAWoumqxXHu5ZoXYNW8JyCvVwahWWLzyQbjRR7u
         fC4SVmp19ZIHA3B1ktAVH5+MsDWfSYPf+xTjymVKncRE9KUrznDGCiv0XUF2UpiAFqhR
         dJ3N5aXzR7D8RGk0IYQXKwdg5IOznNR23jSG5xvSkudcHjvu7bssxkiLX1cm2CtseJYG
         2HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727239106; x=1727843906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/oxZoO71PQ5m5Ow+SV5/SV/jvpv3lxQQXCYtby61Bc=;
        b=Gq79qVEmZCFEnN8fGV8WtTC9lIxWFLCBZWCbQvI8R+a99sxPE0gpm9km11rcUvJ82H
         JLrE2qjH8kwWUkVP5OdD2R0H/+FWecAqbW91JY2mf8Tiz6+sQm5pMCsNN0/YwJaKXg5D
         bBdyJE5o3l8o6Y4h8zMzseOlNQgHRtwVm9ugeW8nY4i9doOnQHcfG4tCrdCJbjwcv3Jf
         lCoWUowywO53B/j7KnYnqK6Jw79CUJGQp8yx2z7qgFRlL50rEMjhbA+fEZB8gfKfuoZy
         1P3kEZ7qbYKH1/u7MNYkni+fCmI94F8GkyGGwuEvxIrdtd2sgXtUDmjbujQ8yIcxIHGt
         e2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6RXDbHpNHBngUG6dySC+vEdICSZ9KmxhIrSyMEPrDBQ/WoYdM/yTdfmMGePDTwCFH1QRsEILmxa3pYXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzA8vY7QcT5R1JXlwobv9Aazdjk9ZQFL/PoDsIw6qkMIW8BTv8
	70RJrYC0oxHFm7ahnUmHssW7i969KuCHyeoRDX11EoY2c8X+KHBKbo5lP2Ds6++2iQdKKOxvU8m
	WzPA=
X-Google-Smtp-Source: AGHT+IHwdF5ljDQfVen2bB2i+DqTGyQ8nFc+SavdlwPgLOgvH9bEIVuNClRBPu4Uwc0aZm3GruhGCg==
X-Received: by 2002:a17:906:730a:b0:a8d:e49:c530 with SMTP id a640c23a62f3a-a93a05eda5fmr124902866b.42.1727239106340;
        Tue, 24 Sep 2024 21:38:26 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f346casm164857466b.24.2024.09.24.21.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 21:38:25 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	a39.skl@gmail.com,
	linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	vkoul@kernel.org,
	klimov.linux@gmail.com
Subject: [PATCH REVIEW 1/2] ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for DSM_CTL and SEC7 regs
Date: Wed, 25 Sep 2024 05:38:22 +0100
Message-ID: <20240925043823.520218-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turns out some registers of pre-2.5 version of rxmacro codecs are not
located at the expected offsets but 0xc further away in memory.
So far the detected registers are CDC_RX_RX2_RX_PATH_SEC7 and
CDC_RX_RX2_RX_PATH_DSM_CTL.

CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n) macro incorrectly generates the address
0x540 for RX2 but it should be 0x54C and it also overwrites
CDC_RX_RX2_RX_PATH_SEC7 which is located at 0x540.
The same goes for CDC_RX_RXn_RX_PATH_SEC7(rx, n).

Fix this by introducing additional rxn_reg_stride2 offset. For 2.5 version
and above this offset will be equal to 0.
With such change the corresponding RXn() macros will generate the same
values for 2.5 codec version for all RX paths and the same old values
for pre-2.5 version for RX0 and RX1. However for the latter case with RX2 path
it will also add 2 * rxn_reg_stride2 on top.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 71e0d3bffd3f..9288ddb705fe 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -202,12 +202,14 @@
 #define CDC_RX_RXn_RX_PATH_SEC3(rx, n)	(0x042c  + rx->rxn_reg_stride * n)
 #define CDC_RX_RX0_RX_PATH_SEC4		(0x0430)
 #define CDC_RX_RX0_RX_PATH_SEC7		(0x0434)
-#define CDC_RX_RXn_RX_PATH_SEC7(rx, n)	(0x0434  + rx->rxn_reg_stride * n)
+#define CDC_RX_RXn_RX_PATH_SEC7(rx, n)		\
+	(0x0434 + rx->rxn_reg_stride * n + n * (n - 1) * rx->rxn_reg_stride2)
 #define CDC_RX_DSM_OUT_DELAY_SEL_MASK	GENMASK(2, 0)
 #define CDC_RX_DSM_OUT_DELAY_TWO_SAMPLE	0x2
 #define CDC_RX_RX0_RX_PATH_MIX_SEC0	(0x0438)
 #define CDC_RX_RX0_RX_PATH_MIX_SEC1	(0x043C)
-#define CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)	(0x0440  + rx->rxn_reg_stride * n)
+#define CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)	\
+	(0x0440 + rx->rxn_reg_stride * n + n * (n - 1) * rx->rxn_reg_stride2)
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
@@ -3821,6 +3824,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_0:
 	case LPASS_CODEC_VERSION_2_1:
 		rx->rxn_reg_stride = 0x80;
+		rx->rxn_reg_stride2 = 0x6;
 		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
 		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
 		if (!reg_defaults)
@@ -3834,6 +3838,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_7:
 	case LPASS_CODEC_VERSION_2_8:
 		rx->rxn_reg_stride = 0xc0;
+		rx->rxn_reg_stride2 = 0x0;
 		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
 		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
 		if (!reg_defaults)
-- 
2.45.2


