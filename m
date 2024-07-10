Return-Path: <linux-kernel+bounces-247708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3B92D371
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143671F24A07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76B194143;
	Wed, 10 Jul 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/x69AqZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27E193462
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619568; cv=none; b=OZOnJC9pRnezxB+FprSYBxXTmn7tLxA1Eg3uEeGPe328C97lHMGjjl9o21MmZlVZpkx1+az4zD6luF1/zSoBNrmGhRGlwj1c2Tjqi/lF2lis5aoW7wbMf+vwkbaXpstQQArhDGglwqhdU9aJJfLvlgA/R9n8ZKJ0KtKXsmTMRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619568; c=relaxed/simple;
	bh=jEk16JQFT0IAvURH2BypgqgsTIx/BJn3KXaiR2tgfp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wci1zjV1JIIRcx5yyR3nqfGC4kk2YnKf0MNsCjcIBU8RpBlFFuv2N5rxSCjk4mCMMnxr+xgkrIh7og8TP5AAuE19QdXPAweEQGS1mFaX/Y7nqlxg/OzoBCF77A3zhESic+szMk3732b6TKsOc1XJBptW/4n7PaN9z+5+iKELcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/x69AqZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7527afa23cso791187166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619565; x=1721224365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slbrxxj5rb9E58CEYCsM+P7UiVj11eTUBnO9G+P7KZc=;
        b=o/x69AqZJF19Xv2lLRmgsxJS/bXSTIBWJh3ABqIXe0c+gBrUC27NGxvi038yPgCvXn
         O8jjWZrDdTIEeMl/VC3RMUi41V5buJxez2leZ9b1eS13qeWsd2TOH3CS+ARzeRX0HtPp
         gIfMVA2MqWbx+yGJJcLBBYdReyevjyLkuFB5E7c9Nn6Ye3x4e9R+uhwhVPYX39mZWfa7
         2zm8gn9smbOHtqfLFsQOkBH1YI2v7Oh/fz6uRu00XXaZaRypbE7Wrdrm1ND2LAIcmFw9
         PEzYk+LmgKzJxe/0S2KfLC+YhsCCDWF794hf/+H5oF1AfIvQjNkZKVp9ZSO5JttVYPxD
         StfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619565; x=1721224365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slbrxxj5rb9E58CEYCsM+P7UiVj11eTUBnO9G+P7KZc=;
        b=d8zQt+6E4VQkq8vq4iOfXdn5YrM6cDTIWjuWJ39XIc0WuSEGwTPHvPWpB3DZdACtiq
         Phhvxh56TGtKMS1/ygrJrvOB7jsRSvEVsX/sKFSJsq2utS7fehB/Vm15ivAZSyyrN99h
         6B7akXabxNqxerdlOaqgW/GT6Z0TJueRbsYT/cgwW32YqNiqx3S64elJv5XS2dmQ4hqp
         4Fadl+YBFTvoF8CdvLzI7txbrf6yJJbGMFlx7FoufV0KWFok65Mv18259b0Efy7K1+BW
         wY8LGQh1AjwE9GtuT06XrTP3GmFFdg9Nd5ijDhMHInnYSBiBA9gJ13KPOik3OjYunvn9
         PuSg==
X-Forwarded-Encrypted: i=1; AJvYcCUWKRQVHJ4h1N/4vjhIs1plI/kNbbJHfKQYd88kcyUaHdSS5qQ93MKREgplFoLJfmu/xhiA9C23A84gsT6NW2zzMtV51cwL/UrzIzNq
X-Gm-Message-State: AOJu0YyBTcwMBMRDBbVuMV6jarqxzBJb/xNmouV1hHp0HOoENdDw7TxS
	hKgJJv66g/cbPeq0Ss9IcGP5ZHGv8uZHMUG+EeeJcRQXO7ULMqNIz9NuzCHT/mE=
X-Google-Smtp-Source: AGHT+IEKMN2BAmzuOkKYboabNS9K1iF67rmPiNfGv71WggM/iASILIt6zY8AU4pXkJL1/oEkdkd06A==
X-Received: by 2002:a17:906:f592:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a780b7010a0mr599191166b.40.1720619565419;
        Wed, 10 Jul 2024 06:52:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8551afsm160440366b.166.2024.07.10.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:52:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Jul 2024 15:52:32 +0200
Subject: [PATCH 3/4] ASoC: codecs: wsa883x: Simplify handling
 variant/version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-asoc-wsa88xx-version-v1-3-f1c54966ccde@linaro.org>
References: <20240710-asoc-wsa88xx-version-v1-0-f1c54966ccde@linaro.org>
In-Reply-To: <20240710-asoc-wsa88xx-version-v1-0-f1c54966ccde@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jEk16JQFT0IAvURH2BypgqgsTIx/BJn3KXaiR2tgfp4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjpIlOgCYWfv4QovLUr9t2eeUmCY7lvvKDS73A
 VovMzO7Si2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo6SJQAKCRDBN2bmhouD
 19O3EACDQ8/ZgiJhxAwvdrYT9Y2yfZkcfzRJ2uk1DlBttj+8mn4kHwjx/iLc7H/P5lTj30Wu8NT
 Kaey6f2Q0xWYAxn+yx/nDwJwtY2ZKb5xmdf4Hko7bSsXDDL3VJRpV5kg6whjscNB8jmd1uraTVA
 cbdnHVXfICieiv+Ixsykpx94arFN5WsaAAynMv6hNwv3HT7d19ZUFFrqPnndTX0TAa2f/sWzbaF
 Dp/dsk/oUufHNz/X+C1PkKIQNCNMDkNmBqL8mUrymEHcb5BrFaSvYIIAdyNFt0FBOIizc0L+xE0
 U7dLgJnJifAz+vhqPJCHBWM/DCmTQue7ezM/P78hHj92oGcNidqlM7RGMhc+pJQ69/6wS3JMk9K
 2tamTHAsZ/JGa4bWBfqJ3eWf0atekroeY5xmfkfIyCNCORkgFCPhbnhntCjVgAox8ZB1beblCzQ
 Z7cZC4o2WvAOzROymQz3GrgLpB4NuO4I9vwIKVgwjGxXSuS9N94fsWZtJRI3F1PP5VKjsyrDmWv
 apyqKSVAyseJP+HqRHWIlWFioigECh8ZvnR2jXmiYRzF9tI5Mac0UC70pW/lV+JTL88+QA+wtbg
 5FQf5ARkfSONAFlt/QW91s+MqPui5LEFFoqLiQRVwIXITx+7FhFgPQXqR27WJxmumNXZR2of/Uv
 7zTxJXk/P9DlhKQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not use detected variant/version variables past the init
function, so do not store them in the state container structure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 60b78560f4b7..0692bc39308f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -438,8 +438,6 @@ struct wsa883x_priv {
 	struct gpio_desc *sd_n;
 	bool port_prepared[WSA883X_MAX_SWR_PORTS];
 	bool port_enable[WSA883X_MAX_SWR_PORTS];
-	int version;
-	int variant;
 	int active_ports;
 	int dev_mode;
 	int comp_offset;
@@ -1005,29 +1003,28 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
 	if (ret)
 		return ret;
-	wsa883x->variant = variant & WSA883X_ID_MASK;
+	variant = variant & WSA883X_ID_MASK;
 
 	ret = regmap_read(regmap, WSA883X_CHIP_ID0, &version);
 	if (ret)
 		return ret;
-	wsa883x->version = version;
 
-	switch (wsa883x->variant) {
+	switch (variant) {
 	case WSA8830:
 		dev_info(wsa883x->dev, "WSA883X Version 1_%d, Variant: WSA8830\n",
-			 wsa883x->version);
+			 version);
 		break;
 	case WSA8835:
 		dev_info(wsa883x->dev, "WSA883X Version 1_%d, Variant: WSA8835\n",
-			 wsa883x->version);
+			 version);
 		break;
 	case WSA8832:
 		dev_info(wsa883x->dev, "WSA883X Version 1_%d, Variant: WSA8832\n",
-			 wsa883x->version);
+			 version);
 		break;
 	case WSA8835_V2:
 		dev_info(wsa883x->dev, "WSA883X Version 1_%d, Variant: WSA8835_V2\n",
-			 wsa883x->version);
+			 version);
 		break;
 	default:
 		break;
@@ -1038,7 +1035,7 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 	/* Initial settings */
 	regmap_multi_reg_write(regmap, reg_init, ARRAY_SIZE(reg_init));
 
-	if (wsa883x->variant == WSA8830 || wsa883x->variant == WSA8832) {
+	if (variant == WSA8830 || variant == WSA8832) {
 		wsa883x->comp_offset = COMP_OFFSET3;
 		regmap_update_bits(regmap, WSA883X_DRE_CTL_0,
 				   WSA883X_DRE_OFFSET_MASK,

-- 
2.43.0


