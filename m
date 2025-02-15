Return-Path: <linux-kernel+bounces-515824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7DA36972
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADF53B3327
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCE3B1A4;
	Sat, 15 Feb 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSFamHWF"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FD136988;
	Sat, 15 Feb 2025 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577899; cv=none; b=CDHigrOREpCZuSnrF0cG1jYtEMpJ3dV6uZp3eh85uZqOKEra/uSyhn/qw3mNrExCStI3oUkGvs6j7Z2IqMuxx6hQz7gMt/4q2/A13/6b1ypqMa8Qk0AZty1qAuVzWQcSiRpD5O8u472OkOAzkTPLcqa6KOsprJ43gOK7kyYV2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577899; c=relaxed/simple;
	bh=IgH2xciWZKB7uuHZHmdSRmIt01jSMO/zP2Qto0UovNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsB7RY6tC9BNoUtHWwW+k9g3hj+9mNy2ckZRg5/sqJhCk0MQfnbUcxITBLtmmn+Am3t5X3uWAsXgqRN4dXGd5Z77NxztZSadKTOPMomKoFUXhmg1vh/Ab8ztb1WGGIjFtFubEcC6Q8rxzgQ1AKE+KBCNAvyyKYjNtEKfmouRUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSFamHWF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so3856901a91.2;
        Fri, 14 Feb 2025 16:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577897; x=1740182697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2wYfo1Mtqu24Y79iekxONgnP5d7J5U5KCGS7O65vnE=;
        b=jSFamHWFmQRpWyzovC2+z5ndF9wb/qamLV/BaSgxM/SAlEKCpJMSCBLzhOzHKsdRxs
         iIVBSVrTSSM3m+FQcc3g8j82ZjcAjeEasfPricgMjKy3rR1DgxtHobUr048K1SD8IQg4
         Gol+JSc6Ms+OWGsVp8asMiC2Q/vNyBbP5Q3/sbkvc+a8d/MtXb9ogxmc8L8zfGIZ8utU
         mbp1fWOC6HzBrju3esjH1m8PTcndsj5InOnB5lFOyo4OQSaVU8EuiUxmF15wRojn5BJ1
         I+AM76JzbDxPfn8KzNHuFS0lBdJS5SDTKJOZPq2rJOakHwpDk7H86R3WGGtto7vznn5d
         2f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577897; x=1740182697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2wYfo1Mtqu24Y79iekxONgnP5d7J5U5KCGS7O65vnE=;
        b=ogr6fDhPvYH0md0MiVdU2tAPI3VNc00kOShls1yuakMGCkHXVwD1ZAKij6d2aXKNAJ
         uGxpA+MIySAT5Xh4QiyKBIgK+gfH2ZsKiFILUr5o0V0ibVfGtTimo3R8PI58wxETvITS
         Xv+69VvLlBahD/rjwxCH0zrDD4FiT0PCyn/fKOCGb6VUndAO7mqjHxAv9rYjWzLf0y8E
         35PnYQ5wEf9moHnEn+WVXOkuK1bsiD6x5ZQ+4UlmlwsYqqCGRQkdFO88iv4tDB9U45mg
         2xUXAiOzNCkZ29dnSoy8KlZbzcMVlfFmEL/o3ew8gQcTWfiK9dCQTknE2mKk1a/wRmiS
         yd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV8ZX4Sb4YEt7eM5nUoPqYxS/lk2T4mdp6Dfqok080WEuH+2DRAxP8OYh89PMEPZBLFJuPi3ErwDLb@vger.kernel.org, AJvYcCVwqiUyseJzy1h4SPuJaXZJW3Qpp4jU041Gq6xiJFlapQ7xgN1UGniBEewzuWiv5ZFRKHDvRxdGhp7FSiRV@vger.kernel.org, AJvYcCX9OH1xO269RuAh4krrNPGfVUwXit8uVz46XR+hl8c0WtpbIge9JyRIXYE9MlL7+ni/qr9jMaZEbEcRxCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9xS1xUDAck4fnEv4NaFpvxPKnOj+9GSa8BxpIlVRLTPDknZd
	4yS5mAfQcyNTb8PvP4P8YzFeDlhOy67yRgB9zTIot4H3LLZoa3Bg
X-Gm-Gg: ASbGncsu0HyqzftO3ern4odmsR3qIVlzLLKbJcNYbm2/BSkHLoQ1lO0+nO45ahh46Fh
	W7SWlwyuU1pvzkdXdpVLjb5Qek1PChv3b3kLF0a1csKn9mBB9xuFAiMnzGr8kwdqwTGyA5WNWi3
	xexovrV6ZfnMVf0R3D5gdIEC399wfhEMSG6ZPHC0bebEtuhJ7KO7LJ9WnVYKERdqGS7mOvL92HH
	QcUnrvRKIKonKOunSUQ++BiDGF9txOX8bmCQVfeiZISlALdBz+hzhdQGMpDC5Ev7kabJjfflAvX
	0IINiAky4Y6WAFxwcdjsllc0aRGSlVTZ43J1Sp8e/LplADrKyO4RZzDLyDRorxnbzR05vzrjVmn
	mtFILxQdI0w==
X-Google-Smtp-Source: AGHT+IGHKLIIACivpmlg0oNUyAsiJUK8vKEeoxPu4+S7wNX7g5x99bBs0VbS7loNNK94SJ5cXy8Qtg==
X-Received: by 2002:a17:90b:3842:b0:2fa:ba3:5455 with SMTP id 98e67ed59e1d1-2fc40d13e1dmr1806453a91.7.1739577896696;
        Fri, 14 Feb 2025 16:04:56 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:56 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:48 +1000
Subject: [PATCH 15/27] ASoC: tas2764: Power up/down amp on mute ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-15-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=RUoG4wMIIwA+IrEHWzmf6WOptdb8et5Kz7rzipJV6QI=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26b6scZ/oSVZVFSwONU9jzJL05L1tnaZHlnhgnxx
 zs8OsPXUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwESSWBkZHv92kldZum6lynWz
 pMC1jXx9a+UmPz10R3CpaXS8oo8FDyPD88a50UccZ4kZ6p56lLV4YdQhyVh2/fTjqQdFXDmfprt
 yAgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

The ASoC convention is that clocks are removed after codec mute, and
power up/down is more about top level power management. For these chips,
the "mute" state still expects a TDM clock, and yanking the clock in
this state will trigger clock errors. So, do the full
shutdown<->mute<->active transition on the mute operation, so the amp is
in software shutdown by the time the clocks are removed.

This fixes TDM clock errors when streams are stopped.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 51 ++++++++++---------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 75e49c85861b1eb6b312e8a455dadbbc7f54c836..2baa7fbb5fdeaf50cfb76a7eddf752cae2511329 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -194,33 +194,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new tas2764_asi1_mux =
 	SOC_DAPM_ENUM("ASI1 Source", tas2764_ASI1_src_enum);
 
-static int tas2764_dac_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		tas2764->dac_powered = true;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		tas2764->dac_powered = false;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	default:
-		dev_err(tas2764->dev, "Unsupported event\n");
-		return -EINVAL;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static const struct snd_kcontrol_new isense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2764_PWR_CTRL, TAS2764_ISENSE_POWER_EN, 1, 1);
 static const struct snd_kcontrol_new vsense_switch =
@@ -233,8 +206,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -255,9 +227,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct tas2764_priv *tas2764 =
 			snd_soc_component_get_drvdata(dai->component);
+	int ret;
+
+	if (!mute) {
+		tas2764->dac_powered = true;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
 
 	tas2764->unmuted = !mute;
-	return tas2764_update_pwr_ctrl(tas2764);
+	ret = tas2764_update_pwr_ctrl(tas2764);
+	if (ret)
+		return ret;
+
+	if (mute) {
+		tas2764->dac_powered = false;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int tas2764_set_bitwidth(struct tas2764_priv *tas2764, int bitwidth)

-- 
2.48.1


