Return-Path: <linux-kernel+bounces-211888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6F90585A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC1D281CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E411836DA;
	Wed, 12 Jun 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wt1pOzzM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D11822F9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208957; cv=none; b=NzcWZ1pW5BxLe2iIxanjAULfTiiIXyb9JZK8Eg0V0UyizSkglL7o85zqD1ol4OrPidhvRqnIK1MylfhrUpFI0kRKisGjm9uZpeAeF5UAhrwRr2uWpkvQdgjvHCgWOTGOf+XpulMPYI/NK/bSm2O4Y79QAa1MsoNdydZsZCB5YkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208957; c=relaxed/simple;
	bh=g2xHVarXvyCS+YBEFCdlIQ1R2j746Vst49InZdmOz3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpvQM2huM74LzUdS5ziONmEk8d/IV5VHrv3FfcgyL3bBRvHSdnl+lx3yvwRWCShjujgSEI3OyTrLAEd+6PNWVU8RVuQr259cK3w+kGTrco8QOHQVjM1zBahu2hV5Nl2WTkSyy773yGQkkk2Gdriv9SaR1F7XMDD8MdypC49yEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wt1pOzzM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso9067866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208953; x=1718813753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8VimLKvT4ABsxFxevhxxNfg0qw4/IiIcQHT7uX7SMs=;
        b=Wt1pOzzM9gCxRC1biG7CNd9S/fjctZNnvTXHaqFZYpKwqLP/BbHNcbEFOdKT8OTYKG
         qpqm9Xx2kEf86NSjYKv8ThvakGvaHvySrOwZXATtPnybzgj+lgQhkOUnFtam6VEHkW0U
         9mc6CpPA+Xm3TH6v3VT9+PpDxQQO1EMf3D+35ZvZ7J6wfz5PLZMzTRtBdoIrstgVkodQ
         FM9UjTqPK2L9UOkZFwAH6TDZH9vlF7JS7ngHh5p4pEAo3oT6aoaWxIpOr8uDTjHAH1Kk
         Eainc76+AIRmaAHy0n/ls5nPNjps+LXDa/M5bSQM+vrJIuwrPP8F4XQmB0zogQfdMEiN
         bmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208953; x=1718813753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8VimLKvT4ABsxFxevhxxNfg0qw4/IiIcQHT7uX7SMs=;
        b=JlFwwCJifC2yRBkRXt3Ns8JDvZBpBjhOn0CesXGu08aip0zgIyPKnVanC+asAvW6LV
         MFlIr3Lg87n/AnHmi+fFz5RovhNUilFVlJKr69o+/usQ+DpYuyEnLOkIZm+8e99p6Gdd
         jwCfkUzxd5q0NMzQnYTmbnlpBW6UsTC/SX8CDNpDPWJiUDZFYdoR17uDpdXlRUdEq6T6
         y0A73j/dcWlVzaogxoRp7XznsiHmSHoZI/V0POy0v+6s2kTXH/GzgcIPGa81qf2jAjc3
         /e/4klERy4CUn/860F934u/VKF7UQcFempgbDS0IA3h+yAOIYNGEZUw3xa1N5eotgCK9
         jSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEO3VNRsUSoCYuEzgqWicghYerZuG4VlWVZXKh9tfxQABi6VqZIcDVmsCJhK0gB7AzJAtPYHmIUrxYFXapxQ+eL2QswlPDSf80Dn6q
X-Gm-Message-State: AOJu0Yy6RKto/y8LOeWgc5tPfMQMyHfObQIXZvQTb8/tmA5PnMXd7ZPB
	ZsEOIwwBc6H9QjnRf9nr9bK/qzXo1x0oys1Hs0X66QWHUBSRrbf49RHjsMkHJKAICUDxVwUqAj9
	c
X-Google-Smtp-Source: AGHT+IGTfvvCQj+ZNaFMkZ6wx7TiN7Ii9ExBRfK9lmhqZIRybLOb+747kCSXpsZax+KK21ylmXhTPA==
X-Received: by 2002:a17:906:a20a:b0:a6f:16c4:a5c4 with SMTP id a640c23a62f3a-a6f47d52367mr134173866b.20.1718208952754;
        Wed, 12 Jun 2024 09:15:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:21 +0200
Subject: [PATCH 08/23] ASoC: codecs: wcd934x: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-8-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=g2xHVarXvyCS+YBEFCdlIQ1R2j746Vst49InZdmOz3I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmeSFE+f/zsNCHQgFuBYKnXqNHmd/j2SQ58e
 6jiG2sco7GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJngAKCRDBN2bmhouD
 1yzcD/4yxf5LOsAQ3mrol2YYLGKoGQIRXfK3WfZuxOS/lBU0ucumfmz1z+oqUzYIqmccjQeKaXq
 NlGKJmaMY04RD+gyEGukOUDwSNI0d77Pf6bkVyzNe5924vuhazpCb58XhPOaAclJM0M6L2qwXXh
 7aLnQeNr4LC1yEyXxV4hVfxFyJHgRi8utspCKZKvtfhnwfm0xfURtYHoIg934GdiVpmbA/efN01
 zlWiGLeJcUr8tuFrykdDTP26XZVJaugMn9TjdcW2u2fHOnjX8SE2HlkckuvGFaTLFzw/N3/m9cw
 P3ClaU3RhJX58wtvJBETIVAYFeQgN++2cs9JQzQkTZovfsIeDNXWWWu6o3jDJj3IC6wxWpqE8nO
 yzuKEO65UNfyzwaV54XBGJu5lE37s4OsHPTbpwgYg7p0pRAAKhEdMnzTvB6Jr+qrF4Me8JQ903f
 wPrmt5RRRd04oMegWBw11QtzQVD0fmkQ3+9bntUc8pSnD/r6pKf5NJ1/TtJlNF7Nuh3VtUWyjXV
 o71thRJ5S/EcXAFiXbBCN58Q/re7UFQ5l/XRnQsvOIPO+bXA4bscNaiFerHEeBVYO7Q226iBweK
 soCp0AordfiLwFZ/Uh27/z7SZ3hFY5Z/EAMbunvdFmPkp9gciDgVreTzA6ihJR96wDL+i7JGQYD
 xzK1fG79wxsrJow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify few static data (arrays with sample rates, MBHC
reg fields, regmap config), so make them const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index cdb68f34e55a..7885aa423886 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -480,7 +480,7 @@ struct interp_sample_rate {
 	int rate_val;
 };
 
-static struct interp_sample_rate sr_val_tbl[] = {
+static const struct interp_sample_rate sr_val_tbl[] = {
 	{8000, 0x0},
 	{16000, 0x1},
 	{32000, 0x3},
@@ -522,7 +522,7 @@ static const struct regmap_range_cfg wcd934x_ifc_ranges[] = {
 	},
 };
 
-static struct regmap_config wcd934x_ifc_regmap_config = {
+static const struct regmap_config wcd934x_ifc_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = 0xffff,
@@ -1212,7 +1212,7 @@ static const struct soc_enum cdc_if_tx13_mux_enum =
 	SOC_ENUM_SINGLE(WCD934X_DATA_HUB_SB_TX13_INP_CFG, 0,
 			ARRAY_SIZE(cdc_if_tx13_mux_text), cdc_if_tx13_mux_text);
 
-static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
+static const struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
 	WCD_MBHC_FIELD(WCD_MBHC_L_DET_EN, WCD934X_ANA_MBHC_MECH, 0x80),
 	WCD_MBHC_FIELD(WCD_MBHC_GND_DET_EN, WCD934X_ANA_MBHC_MECH, 0x40),
 	WCD_MBHC_FIELD(WCD_MBHC_MECH_DETECTION_TYPE, WCD934X_ANA_MBHC_MECH, 0x20),

-- 
2.43.0


