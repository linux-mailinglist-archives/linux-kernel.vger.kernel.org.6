Return-Path: <linux-kernel+bounces-518888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CF0A395B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A35618958D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573522FAF4;
	Tue, 18 Feb 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD2kpMJt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633822F3BE;
	Tue, 18 Feb 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867904; cv=none; b=HePY4xylUCDrCinJUID+PmwxmzgcEu28SQJfGNBe/ymlCTTbDpHaYQ1xK5Z48BHZ1uZ9eCuqCthfPK+uzLG8ME/hsRLaLyW8TK2FffzBXbJ8i/Sn/IlQG3RGH9QIwDqZdmyTYyVYZy4U3zz4JeYIt9fOPXtzg78IBqOClnUG4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867904; c=relaxed/simple;
	bh=YMQbzuiyaL1Iaf8NDdQ1vVxMPoqlW0XTKmhgm4P53e4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dooud3av/WFAmsToCDkZ1gc0/FHG3uzXHCDgF8uRNfbhSjz84OQwpR8nivwNakI57VOpdoabKuX90Gd+m6luNOv1QVuo+E4n+tn0Sqg05q4xHITp1DB+/EqT5oFRpnPnLMODDM1oR9WZBrYGR/kXcI1m8HgTY83OJhb5Wrq2BB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD2kpMJt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221057b6ac4so43967235ad.2;
        Tue, 18 Feb 2025 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867902; x=1740472702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hyqeyf27F6I7AKPqAgQeLe+BV+1ml+NgHZwH/Ryil30=;
        b=RD2kpMJtcSSWvJqlQ+l49i9jRpPjEMLhhpuDVcXo6qGXxF3Mk7OXOImhXeitd9n4Bf
         ffnRVBYvQEcPAvR6s+BTFG3+Sm/UXZPvaLfCJTf0fucV5uSKSHk0CY3CN9GGiNBH8Msk
         Jo9gHkaJhFNU+69oR8Kdv/lggmH4ELO4rQxBZxmXgvxUirAgbBWAr4PV43ARoHIRL836
         1t+lp8nOdVgiotMK303hYNZLOFI+uKNWf3r05U5f8g8WTLiLvpV8fzaBbENlPG1KbeYV
         40FPheFvquKjruUOmAXrKIHSSuBLv6jh2XCug2o9KTV3u+7MyRB7FikoUy45K6MmqsDb
         YXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867902; x=1740472702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hyqeyf27F6I7AKPqAgQeLe+BV+1ml+NgHZwH/Ryil30=;
        b=j/NRq8VHKmFMrpK9udvm3H6SQ7UoWukJnQpVqq6qi0aPyGdeQSITTFPCmosdUenqwp
         5nnymJE7Yycd9Ds7aP6ghk6sQTVuJP4qqvMppJQ17qc7R4t3BR7fuLW8H3lw0DzYYgwq
         ZV5n5enuf+z63GX8OjDvjKJ8XggW+Q+CwkRbiqEMZQ76k7GVkr5Yz79zNSlRFZFgraxZ
         ZZiFVSxd9W9NF9vDKT11s9E2wXJji3eEmpSt6dn3I6QBK0sIi3Df79JzWSDwS1/Yrayj
         iV5mTPKWr8PAkpsHXg3mPniCXSC3T1L2dR2pqz802Mq4esxEG17pbAeHIBBCni1BEzo6
         Sfvg==
X-Forwarded-Encrypted: i=1; AJvYcCVSN58/SiH8tvtNMdRQRhqRFaRS3hRO1HCmkMQLRnIh36ftYxZKB/C6+TJA1mZV164R9c70jfA2pmsLxp4=@vger.kernel.org, AJvYcCVojT2UxT8gfCi5cs9gyzs2aw3YEiKr6kFiH8NBd/aOezLgKDACEn03sOx39twKPmtlm0wDqPF8MBWCgvg=@vger.kernel.org, AJvYcCXBwkfSQPwSIUiNCfbLp+QEwY/jHRYFtvFCowPDvbgG6dUwLm42xfCEC2N7ztgQZf2HcYDummOoIUPb@vger.kernel.org, AJvYcCXU6a8AzDcAnes/3QxZwC214EMFMwkGdMhY3UNik3ZWX4WUtiNqzJUlnr4fu2howf5Huf52gIx4jca/yWHN@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwDxKjAhW0hUrdeH0WAVIES6wJQ0CqP9zrMPKFN9xBqnF7VrU
	JiISyPK3NJme74FgYXITlo3m0bRMn7MUtKEdYgjubN1wK7j1PfGvR+fwhsQ0
X-Gm-Gg: ASbGncvJIgPjUqs9WuXThPSPjFglDKoekxbbpbRyntSEqFHHeXKuveDMNhb1fVXWU4F
	qpMJor0hH+Lynqyp23f281uloFWEJOUHIP3PketGlXY5BCghkAQSyJA6pdG4ltLVm0TbygkuZBG
	IllgxaoWF7YfgcVFo2rRJCh4/iXZBBp7Bn1qezE9Nfoib3bHOomJO9gk4d6zd9Rcek0Cppp5mqN
	bXnCb5qMyBD5faDb623AAEjemMDUDk74Mi2HIdwXh/+JFLSflD8FJE02/uVZdclpyiZ60vdUb3h
	JM7p6eRr8o7NDJo7otc0/VZIWqf4GOAvrCDLgvYsbJQ8YG/QgfWUxZ516UhhR/q9jNNuP5SYjN6
	hn5ZxnSzNbA==
X-Google-Smtp-Source: AGHT+IGkUu7BmztVJnNnLd9/2arCGoguxbm/707mGBgU7NigUyCi+pzQzWsh6RXWD/XRKiCh/p9pUg==
X-Received: by 2002:a05:6a21:4014:b0:1ee:833a:39a6 with SMTP id adf61e73a8af0-1ee8cac1610mr23081603637.4.1739867902350;
        Tue, 18 Feb 2025 00:38:22 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:22 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:53 +1000
Subject: [PATCH v2 19/29] ASoC: tas2764: Power up/down amp on mute ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-19-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=I5n7Dz3MYeIHjWigjiDeLt+4w349RXEkojMNn8Ex6EY=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BJLdupmyrdKd3WzVj8UMrk4Ncv5wYadS6fMe/Iwb
 c7tjub0jlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACayIYiRYbvlfuVX333nb13w
 y0hJrvhLe27cpyPMUprzj4mwM89bl8LwP67+9DHxxtWl7Fd5hGw8YouZT2odXu9/nf2FjV1Ymu5
 5LgA=
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

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 51 ++++++++++---------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 16df453190961b8ea6809cf4e6a9c588f41b5a82..7b69ab94c4bbd5f074d57a42f71b32f5fd63d560 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -195,33 +195,6 @@ static SOC_ENUM_SINGLE_DECL(
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
@@ -234,8 +207,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -256,9 +228,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
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


