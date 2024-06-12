Return-Path: <linux-kernel+bounces-211881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCA905849
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D626F28CA91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C565181BB3;
	Wed, 12 Jun 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4iMsgmc"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2D181313
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208948; cv=none; b=AGBxpwhYrr/f0FjhDZGFE73ngPjbChWU73nJQoeFjPUdL7mOwVgSCIhqf9v37N6clpCqQpwty3/zgZO92yNySf4qhdmNuE+05CgtE3goPBvB/fN4IZ3ljaMUhnTozFx6PfqwmTy+vtdQw64esW6RyR9Era6aBUe9HVB1JMfLOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208948; c=relaxed/simple;
	bh=TdNpNaj0eDwPSxq1ZGkE2FZQIvk+R7zfpn4gMLOjX+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GG8/3N+G0dUr8H0PJ4TZFbnz5ML9HvHAyJicOUbxBe6V5JpUKBVgSGDvKyBl8+TW7pLCqj0Pb/jEg5m75Zs9bA8IEbB0YTkmYfnruvap/wbFBCNeB0GgItAOvDJCyi2Jn9iIULadC6SvuyRnAZ9Db7D6jrWg91eBbsrI4DTio7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4iMsgmc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso7755261fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208945; x=1718813745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaKNd5i+gdVNaPciWa/D++J8qKGcN7FLtSQUh7AiY4Y=;
        b=U4iMsgmcHxnFMQKFtU8WVw92WSKfnIptJbp11d8m30gCwhg0YhS4eGcYVP+OLThvKQ
         GZyCDOLug5oAS2TZvewEnBJlY0RVapJaKnoqLRJciI1dBLQYA9P7iyT6FAkQbbA+eem1
         yNLl4jN6XND5m7f3kDhX+y0+e5fx2UixNzYC/7WSsTegKWzy3lUIywW0nyy4amieUw79
         fDGv0EQjd0l4sNqYfTTbHcp7AquWcqqm5P/zZ36UausG3lYwuXcwWoP2r6ZBOcSHm1n9
         DDYgmHiqnNu1sIaNeVWCyWGW5m0/VfY+ytcWmyUPMecYK5SO7T6OOsiwsBzzWMzS8REg
         Bvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208945; x=1718813745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaKNd5i+gdVNaPciWa/D++J8qKGcN7FLtSQUh7AiY4Y=;
        b=UHCYz6CYmOX1B6mRBbAma7i+WdBrB9ynSD0ujehtszUbhGUVzWHGF9Sx5u8F4xNyAF
         G4QMMeGtgwu/jMc764Oshy8NNN5SMGOs8xiQBdfpif0g4yh9IEK70qYSqQP8LzTrnVCG
         lI3eWWkyNCaPV4Ps4cmI9IXMWY25XXUtfMnD0lzUwdw6GDzymGYGMwIb1zzLABQnScis
         LgO4T0OBcB1xlySVVcQ3unQbLOCeBgoNKcdAxbB7DtpB6x1g5lw9EV+Vpt662G88y5qf
         EMl+dCWOewURPogK2mJlEG7emmWZqe1HI/R5HYshBnrolH0si8kXDAmnyj6vwpLwegnC
         dgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU18ad1PmpP9WRU9FZU9SXeFWQz3O6eobo8bb7nWijTBN9mbHlUbMwIIPIg3mG8XhzBu0nJRGXNLCoBf3weZxoqoy0IGFxvt3yal7oK
X-Gm-Message-State: AOJu0Yy2Z36xjb/bBuNMFPr77383iVGeEvVF4FvYZNTCinh7OQp+T88g
	+Wx0LvV14kCIngkZDF2+kJ5VjEQhlxb8yngFlUArlgd1efhv2ZdYJqjb8o2EHPE=
X-Google-Smtp-Source: AGHT+IEzwT2wxUG76kYf4EvMc9Yl30u9Y8PGMPa0J3TjZNyfXgkujITCkQDy+SdY3WFDHmynS9zvlg==
X-Received: by 2002:ac2:4255:0:b0:52c:823f:2a10 with SMTP id 2adb3069b0e04-52c9a3bfbacmr1594725e87.1.1718208944923;
        Wed, 12 Jun 2024 09:15:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:15 +0200
Subject: [PATCH 02/23] ASoC: codecs: wcd9335: Drop unused state container
 fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-2-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TdNpNaj0eDwPSxq1ZGkE2FZQIvk+R7zfpn4gMLOjX+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmY8YBeHR15m8f+5MErlfvmIqZp0bmj+SsSf
 RNUS9y57USJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJmAAKCRDBN2bmhouD
 1wL1D/4m9Z8zECPMaR+QlPgGunewXkoXk4J8kftoxOJj041f12JKBnLg6dCCKMumkStuyALj26P
 GTcjwaDvh8pZ5ZDQdWRsIkz0ybb+P/SV4w+fFivPV5aCA9vSd8FhFe27SR/cR5pUHdaOZbbCCwa
 7wdTp6mQ8vU/913MBTKAmIwvyRxxUYgizmDR+DCXgCqW4DXSiStrHVgWxNpTHGrr6y6FOOs5jHE
 98kKSF0cCcmjlSBq066h1hq5n6RdiAWXqQ09R19dGMGIVh/+2tBtmhqdLsJuOpJv7U7Icuj3+wz
 Nos33lpPPUdIP7fjGEsrCfjTEHwYm9XWH5lLbFHAiL02thR/RSmCITEUjr2wHXfitMb7/BwlXbA
 r5RSwDsmqyIJTBxg2Ai90wyi2k3OxY9Z1Wv2D7/8A9pInpnBnn1/4dRebMXHO16T5TeNfESqOqo
 r0yonRkAWKWERkv+/Uwcb8FVJ/axk3ruw6xL6kG00RORnksktUrVx82ugI08z7Dt7h2x2eL6GWn
 9JoeEUUWe9aJuMELV/BWAb2UuzdbomV7pXF6on3ZH4310rP2TBQda6pWWWKRmnLdb00KkTrWmZl
 OzoEH4Ir5kYhjM29ccF3nGwj845CsJGLXUivBinWBT2uxMvuWGRQmU8IKJYCHMSElYQze7OFE4V
 dI8DwQKo7I0y9Dw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver does not use few 'struct wcd9335_codec' members, so just drop
them for smaller code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 42a99978fe5a..60e7704e48d2 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -297,7 +297,6 @@ struct wcd9335_codec {
 	struct clk *mclk;
 	struct clk *native_clk;
 	u32 mclk_rate;
-	u8 version;
 
 	struct slim_device *slim;
 	struct slim_device *slim_ifc_dev;
@@ -347,8 +346,6 @@ struct wcd9335_codec {
 	int dmic_4_5_clk_cnt;
 	int dmic_sample_rate;
 	int mad_dmic_sample_rate;
-
-	int native_clk_users;
 };
 
 struct wcd9335_irq {
@@ -5109,7 +5106,6 @@ static int wcd9335_bring_up(struct wcd9335_codec *wcd)
 
 	if (byte0 == 0x1) {
 		dev_info(wcd->dev, "WCD9335 CODEC version is v2.0\n");
-		wcd->version = WCD9335_VERSION_2_0;
 		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
 		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
 		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);

-- 
2.43.0


