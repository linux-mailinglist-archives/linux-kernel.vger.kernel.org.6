Return-Path: <linux-kernel+bounces-211895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4A9058B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E54B2CC32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782EC1850A1;
	Wed, 12 Jun 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoPbt6xm"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2C186E24
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208967; cv=none; b=vEhXPUw8GYBo3+MnEG5YWhMN9QIsYGWxnxvw5MvG7Tc3MGkPrbeVMf7mB2V/JgLwdPgyNMIur+iiPxqq6bkikqYYeA6H/2Hlk6JV1vjESZyV0W/V+GCUeD01N/iiyNvqYHgmDoV3Z38vzYASK7GBx4PGMyy1/0rYLqpEvtrbZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208967; c=relaxed/simple;
	bh=zKXd+91xEq5pfFCX7DOuH5v5v4sMaD9C4FPc04gU9r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuIuOYphqSG9ukuAJunQUlhh11C3SD28MRm/L06QCVBoEqgVZ6TA3Fta3pb5AD+kiBcNxZx5/8MtqQ5dbmH122i6C2dtgIjBffcc41ZqNanGGNC0u1X/pJ0JEFq5W9/MyQRCt17+jkNaA6UFVw7+B3ujYMZXqT8mxTeqdCHovIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoPbt6xm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d48ec3so11790566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208964; x=1718813764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiX6Sbf9ddGFk6daznvxWZY69rEFKNMVZ2nde0CgHqI=;
        b=hoPbt6xmYtAanIH3KlhM3t4Iw+N657KsclcVR45FEuOLceCYzXSyeV6dqM1S1+fxJF
         LvGJDrEx9fD86a2LGzHUn20NsDYbIJTUsHNpqFMBMEv7IeXmFXmCD2zd7yA0tWz8DoGs
         JnYUEuNEC1H3VeET1leUll7V6TtzoZtvZlI+L2nf2Lr1E8KZqrqiMr8cHu7+sl64MoEV
         Pf2ygGrqnNQdKv8VI3+dM5QBuR0hriD/TViSLvb+Dw/BtGApWdaTrWdF3tFfFlU4DUA2
         UlJTWiAtJjTaBLSxf33/2ntOHrEfbzOsRvjAYoTkdThA2gxLXmE95TOR38xvsqCXxMAW
         6P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208964; x=1718813764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiX6Sbf9ddGFk6daznvxWZY69rEFKNMVZ2nde0CgHqI=;
        b=qzwzW5sziThN6C0UauhY5Haa9uSAlcNBWmCO17KsVE0n9V27eLq0z+2OhIy1VnkFoK
         K+Th2A/k7tWkzWn3/LmJNR2jUIWdFoBj6L0DVO/9j3z4p5FN8EyFlOdz87+1JG+v59kI
         4cuxKdlnZ6Fzq+t5utzmJbC8+636mI7N2D7hKlFU1p8xTg4mGlB1gpcq2p0yayj/1gO5
         8Shz2GKSMmZ0VIE7to6/tO8uCMBaCWEY4NPVx/sAqKnOmvPsUZlrvJENZFUg40BnMhZ5
         bIoysEpGpC1QQBdWk/dalEV2bP69JXsRELE84uGely3/wCN14Ui1MaTaWhlv+pXMugCy
         1dpg==
X-Forwarded-Encrypted: i=1; AJvYcCW+4Hv0HllhTKYvVuOWX47KIvOI7fRYxHurgv+m/PPd9INO22OyP7x/7qA0cV8ej7UGWkuJWaiIEfSt2hespp07ZTzf6rK6ymJyWvFy
X-Gm-Message-State: AOJu0Yx+iKRmxXqtC9jbHFz29TF8nfZbxO3hQI7smILrnIfJ2MATheJw
	tInJno8IYgdvfP0g3WlykJgXqy7VdaPHNmjur8dGLgVLUHxqbpwc/+Zho2Z/pt67zt3KBjQpxUD
	r
X-Google-Smtp-Source: AGHT+IGiiOo8DvyESFXAfcAnuf1NGFEdhUpYILJtrfGZXuVCuhwhQWT5bCBjkKfscjQ0XSUs8MlYHA==
X-Received: by 2002:a17:906:c349:b0:a6f:22ea:55b6 with SMTP id a640c23a62f3a-a6f47d5cf04mr139036266b.65.1718208964688;
        Wed, 12 Jun 2024 09:16:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:29 +0200
Subject: [PATCH 16/23] ASoC: codecs: wcd938x: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-16-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zKXd+91xEq5pfFCX7DOuH5v5v4sMaD9C4FPc04gU9r4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmlSsu/q1HO0eaUx9PgU+Dxz56B2dOlI+KPw
 SXkBY21VYKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJpQAKCRDBN2bmhouD
 1yyVD/sEH+iwt0IY8qp1uSeTqpdM8WJOxtJQKO07crLnieq69XT6lz0MVNvBufuf1+jprRqGX4v
 G+vYXNWTc2+wT34jYp4HAVPIkd5O/+jrCJ2Fvc+D+l7/guwa6h7qp1K+K+AHgbPnrpLd3yWalYp
 LX9cWjSDD3e5vaqhn6Aj8UCMdTTy6uSqdr+Eu+MxpJoUb0+bhxmiJoCuAd5VDvxWYh5RguxjN92
 aRShTmq5mkX7ivZVE40xXJs3SYstK17V5HnByrTJwLNBWVZGGtvGmgFk7XQbrUAz44kSvOmkiyy
 LmVGLnZXVsA34h8P6QhaIcQU1K5HS1nNqmVgOslpjqbgn8X2543TlhR6PwncLlfT+O/ZPwu3qb6
 pn7Pduxpcz3NZiNctj6N/5SxqJ/2//NN6UWsYqvTg8oVEJJlEKIxTx6fp+uDaf1Y6WsPNqhE5vr
 EWMkoZA5/sh6D6A8NS0lwMpO/bgUuyXUFVu+5+RhTuTp8PrfAmCsALZAHKj1ioheTwKbKzPOwh8
 eXFODdsxR3TlMLou1tiByjgTfS81dywRci/lTwsS8j8RKTLgiKdD+KkuVVaDcFG0BQ9XWkHAUdr
 WB7JMNouzyG8LBZYzEIxeT+tAtaamYudAG3LzvraWM1USEsCt0RbSul5XqhNbUr3ZmdgF5gmAFW
 gfuek37KPhyfRQw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify few static data (MBHC reg fields, IRQ chip), so
make them const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 73387152ce02..124c18712422 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -221,7 +221,7 @@ struct wcd938x_mbhc_zdet_param {
 	u16 btn7;
 };
 
-static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
+static const struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
 	WCD_MBHC_FIELD(WCD_MBHC_L_DET_EN, WCD938X_ANA_MBHC_MECH, 0x80),
 	WCD_MBHC_FIELD(WCD_MBHC_GND_DET_EN, WCD938X_ANA_MBHC_MECH, 0x40),
 	WCD_MBHC_FIELD(WCD_MBHC_MECH_DETECTION_TYPE, WCD938X_ANA_MBHC_MECH, 0x20),
@@ -3027,7 +3027,7 @@ static irqreturn_t wcd938x_wd_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct irq_chip wcd_irq_chip = {
+static const struct irq_chip wcd_irq_chip = {
 	.name = "WCD938x",
 };
 

-- 
2.43.0


