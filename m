Return-Path: <linux-kernel+bounces-187495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A096B8CD290
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B842283FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44F14A4F1;
	Thu, 23 May 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSl1ITqO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E01474BC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468497; cv=none; b=FbVlPr67uuz0GvkSgVYQv95Dk5gGNBf10mPJjuMbE/EEYAOHkkGgzgJGU7o7nq+gZWyiyrvzLAj02V3U/Wx6DV7bPmMyJCvyb1RV2NbURcjDLDGzVLQ1VhyX1uLDp06wF4/WtwGjeZExffX4lFoRjCGz5N/N3JvxE62QpHzpn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468497; c=relaxed/simple;
	bh=7H+i1fptu+/6Y+LOC9QHsTZy3fxGXIz/oEFy/KEXe1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cjp1e8si03cfEfP/TnWsSEb71lgaPTjemDmYa/D4VHhs960b/oE5WCwJAQMNZrEwna3/X8jbFI503oNP8UD5kgjmNiHSMYGuhh/YpJeXp9oyvvfhxyVBE+HgGrwF0uVxfgZdORFz71PW3tfKUSyWmSu5/eonenccuBqs5AU63cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tSl1ITqO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e271acb015so99596111fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716468493; x=1717073293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9x7Vo9vvu6p2oA0ahpRMi8dtMiJqaBytkcFXFhGqro=;
        b=tSl1ITqOeIxlXeUt6P5UHsVxcjkXYlpQlLqeeLH7uR2VoGiIvSylVlfuFZ8h++Lzw5
         swieuFVWzzBOdU2pjxCH9kOW3cZsjxaIPI9EDmsDm5V+i8kwyAig0FDkhn8NG3vsx3wc
         XVIGSoTsR93wjgEVTnlqAfoNmGrKRpqAB/8HFgqSEaxH/8foEzVOOzG1gQkauXNugoJA
         5x42g8tpoUMwF0NyeMty2Qu0fAeHuNb8KjSij7jWFAOM75SOgNUX4ppWtovCZzbWFLAn
         cG0B/OdvsILjp4scEd+9awy17v5zekTSp8Dy8q7eHWUdxnE65muR4dzhtMVD29ZmqV0q
         iImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468493; x=1717073293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9x7Vo9vvu6p2oA0ahpRMi8dtMiJqaBytkcFXFhGqro=;
        b=ickUc5gZyPE4pQ9eLIbB1PepD1zbyncWYiLEI6D+Q+Y67fG4c0L1NGuVPXHjSk0NZR
         4feqo6gwvI2ivNGUB1+RjYA4IuzXHWRvIQKmXJOPDanEVDk7n8H0UUGXY9kfmy7D+ydR
         KMkV+Fn40zWerMaVs6xgXd8gV2YrkYz4F0OpI3BY5KOIO4Ont0jAo4HefHfiks9+Nw9C
         tKMCdM+irU8iGpbNrCmMBVxsdRBGj11M7QjKe7ePeoYs0gqm1PpmHSRjUM1oZ3ZSnobw
         OJBwN8DiqlPVtQSTcelJyow2PCaZX3kdBRpRTHfdRzjWeS87h7AxAG09ZYe69sLko+SV
         QwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPdSxCf6+PYW/hGXmC0RbEtRAKonMXmlXrNH5fho7IiKmg8MW6IUZD8CQd8px6FlT4TcBUdMy4pAzI6tVGUTKZSlwJpqyt5EhStxj
X-Gm-Message-State: AOJu0Ywfe1jfsKNiqvIr4cc6d1PqSKMd/tzROGPEw0yx/u5ekoHPT200
	m81ZE5HXvLtJwa7r/3T4d+rwX9v/pmHX91P+T4GJpzk0aOSp5z7VOQTd3kNW+/Q=
X-Google-Smtp-Source: AGHT+IHVrcU5GJOVwh3WzZ4bOBvGIcYyS9n60HryD8j0shddZfNZ79T+iSUvTkXyJ5Fbh3kQEMvcdg==
X-Received: by 2002:a2e:2e0e:0:b0:2e5:61f8:db58 with SMTP id 38308e7fff4ca-2e949465c21mr31089701fa.11.1716468493033;
        Thu, 23 May 2024 05:48:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm19730031fa.112.2024.05.23.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:48:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd938x: Drop no-op ADC2_BCS Disable Switch
Date: Thu, 23 May 2024 14:48:08 +0200
Message-ID: <20240523124808.42923-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ADC2_BCS Disable Switch" control does basically nothing: sets field
in driver's private data structure which is never read again to
configure hardware.  Drop the control as it has no effect.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 9e2070356b84..73387152ce02 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -206,7 +206,6 @@ struct wcd938x_priv {
 	bool comp1_enable;
 	bool comp2_enable;
 	bool ldoh;
-	bool bcs_dis;
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
@@ -1650,31 +1649,6 @@ static int wcd938x_ldoh_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static int wcd938x_bcs_get(struct snd_kcontrol *kcontrol,
-			   struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
-
-	ucontrol->value.integer.value[0] = wcd938x->bcs_dis;
-
-	return 0;
-}
-
-static int wcd938x_bcs_put(struct snd_kcontrol *kcontrol,
-			   struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
-
-	if (wcd938x->bcs_dis == ucontrol->value.integer.value[0])
-		return 0;
-
-	wcd938x->bcs_dis = ucontrol->value.integer.value[0];
-
-	return 1;
-}
-
 static const char * const tx_mode_mux_text_wcd9380[] = {
 	"ADC_INVALID", "ADC_HIFI", "ADC_LO_HIF", "ADC_NORMAL", "ADC_LP",
 };
@@ -2695,8 +2669,6 @@ static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
 		       wcd938x_get_swr_port, wcd938x_set_swr_port),
 	SOC_SINGLE_EXT("LDOH Enable Switch", SND_SOC_NOPM, 0, 1, 0,
 		       wcd938x_ldoh_get, wcd938x_ldoh_put),
-	SOC_SINGLE_EXT("ADC2_BCS Disable Switch", SND_SOC_NOPM, 0, 1, 0,
-		       wcd938x_bcs_get, wcd938x_bcs_put),
 
 	SOC_SINGLE_TLV("ADC1 Volume", WCD938X_ANA_TX_CH1, 0, 20, 0, analog_gain),
 	SOC_SINGLE_TLV("ADC2 Volume", WCD938X_ANA_TX_CH2, 0, 20, 0, analog_gain),
-- 
2.43.0


