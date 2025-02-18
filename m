Return-Path: <linux-kernel+bounces-518894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A47A395E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0910216E6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8623C8A3;
	Tue, 18 Feb 2025 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SISPzGcA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764422E3EC;
	Tue, 18 Feb 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867952; cv=none; b=eoqLk/aPb9TXlzjehoVQx6Q2uFSVIiOgY354PFC90RUsNU81Qxt9NYq6ohtg9ljOJOWeWte+s2qmn5OTl9yEWqCnwga21khAEZCVc4ldyN3pH9acF2Zx9lMZ3D0h6kQ7BxGbc8g/kZEAOBnUfjWOuSVd2e5x0ZE155bOxMNCNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867952; c=relaxed/simple;
	bh=X2NC1nq9Jr2CWV2sHejLqmJzvcXpyv7PewGMJfaLDGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjOn9oARzE3U5IONnv2i9WA/Pt97M+nYgecxl+Q3ebEPqcVooMvaC27aS5R/Veis8GNrcpidlguuBZA2j8hUsA8ZiZG87eCw6oN8O0mZVX7VMpXnQn5SUtcQSssHOmlU/Xu9A9qQ9dejy4IMcgcZqz4eDoB9PJMZ/c0l90v2AOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SISPzGcA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bff984a0so91919775ad.3;
        Tue, 18 Feb 2025 00:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867950; x=1740472750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3klWhPvV5GUbiPplkmf5p0VOnIAHNQHeW5yF0WhLQg=;
        b=SISPzGcAIk7q0R95+aK4npXAb4RaucwBcn/zz4p/7h/sEh6saADKd7Pg5GGvmg5dgu
         c2R1Rgd7UyOh5Xusy890cdhTq9Npxp8qRkJs0Ik33MY0NX6frcCseTAZk6DSfhcvyEGz
         gZKFe5KdXkfqZAmWtfRpKCEsVobI0FXLjsfipWZ4DJo7SNHQhs+dI/fovev47VJaCei2
         11MEwB4LjLp00B79OWCkycKRpqx0c8spA0AwKPfbJoJiBIgb2ZvygPH+gWBEGlMufBNw
         icn+IveIObWFXP2hgnjWVQQC17FA13yQhcka5fNq/ckvcxdvWNbw7rT9OwT8hIifUobj
         ne/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867950; x=1740472750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3klWhPvV5GUbiPplkmf5p0VOnIAHNQHeW5yF0WhLQg=;
        b=U5bDLu5+VBwM0kwdA98LjgPHFVjIRtp9K7K2TNkAdgLS4kr7ikiQCCzA3xdfUJsDSj
         hrBgtoKtt2idOtEEq6ii8vEe0HGfse+A0t9DEPwi5GyKdHCHgva43ZbYMdY4y0VdkCon
         nqnTJBE26HnVlZbQvYusJ2bX7ok7dVM/q4vz8SDPgGRcHgzfrtaorMBdHl/BJ7McYLDu
         4aIZXYEVW0XqAz+WiEi8AXUhgQLWpzrV6+/4tCPBaSVC2ktZ91EK+fYRHjv73GYkmrDd
         IQFRWeHAZgqdHY6NiQTTI1/33KHdea/cv4FRSEXeEvDAVMJ6sY6xS+EBirSsbgFeh8Ba
         tM0w==
X-Forwarded-Encrypted: i=1; AJvYcCUqAqNjZObuSqEHeoJpf8UiDigQfXn2+dwYwDC7COQoait7AGw0uwBIIZEg3s+scenen0tlBhzF9IXjzqw=@vger.kernel.org, AJvYcCUqmogjk4l6hK404RbijG+EyvuFK9CSXvVizw4vyeVF4/ZtaCG7sgXk3ZVqG/XyKrcw8pE9hOzgWdo97EX3@vger.kernel.org, AJvYcCUrE77UtTTIjOeEpbbG8QQjvmLPXakktptCUGGxlMirdyX5ZWkNpDZuFdxxteVbhUQbgBlGPCw8L6mO@vger.kernel.org, AJvYcCVAn6vtUIvCynE0VA5drzjue5CofsLZCxikNFV5axsiQdYgCwFmKRqXj2BUNpvhRBuW5D/eUg0XRFdzGyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfgeFdzDcGuqrA+9MzVv2h7wiPDRgawygto/22g/haqdSPkXlA
	bgd7KHYE8IxzT3yoYlEv/QaHZdTU4VZ6sFhxgoFheJCocYnc/7tE72Bnf6OJ
X-Gm-Gg: ASbGnculSJI5JoCITzeasGQL/UACsmIyBp93BfARTu+BZNAudfu0tejN0RPwIQf8DP2
	ZBtcXbkCV7uOHH70/i2bjRUqYPSccT85BDXEyEZ4RGnwHYPjb/n6HzZ746AlKmZTElLIX0uqjk7
	Ymsqxl3WoZPaRYfQ4GQar/Xz10lSy0LtIVYTNbqlGPtiPFiWm8q/qDo2cAZNyxrCkgf2Y5segMR
	DUS7ZwW/zQffzmK6ZlVFFkJkTPQvphuwoxzs44rBfoIFn3eNDhMvgd7XxrfIcRFu0VmNRxxxLZV
	NfP+mOeolFHjwTwhPVD8V6IBpRN8Ztrnnar4Ci6VfYwfRjTvf3YEPDAOtuaZLkZlApWKXYRvXT8
	uXOa0cpiuFw==
X-Google-Smtp-Source: AGHT+IFGVhxYw93mip/VYB42/aQk71fmFVbzVmISkib3+MSZgbWbsjSbcqRc1ID658YZQTeUw9eENg==
X-Received: by 2002:a05:6a20:9148:b0:1ee:ceb7:2b54 with SMTP id adf61e73a8af0-1eeceb72d97mr352523637.5.1739867949793;
        Tue, 18 Feb 2025 00:39:09 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:39:09 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:59 +1000
Subject: [PATCH v2 25/29] ASoC: tas2770: Power cycle amp on ISENSE/VSENSE
 change
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-25-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=5FscgszU7aN109tj/tiH9/gQFD8FoCu58ZEIeFBUt+s=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JImyZ/O2FuqYWVtp3bLpUH8lsjbErWA4+f+vc3Pn
 a+mbZHSUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwETWOzL8FbvbPkNtcu9f8dv5
 T6p/ODoHfgjY4BqRav/+oM5Ms3Ps8xgZJu1c/LOy3CH7n5zD9loXWw7Pk59+P1pqmWSivJw991E
 iHwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

The ISENSE/VSENSE blocks are only powered up when the amplifier
transitions from shutdown to active. This means that if those controls
are flipped on while the amplifier is already playing back audio, they
will have no effect.

Fix this by forcing a power cycle around transitions in those controls.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 30 +++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 6f9e56f02f7ca95d7878c68465d7016213ae417a..cf038f55453737b2173b986d90fd57d4cc14acfb 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -164,11 +164,37 @@ static const struct snd_kcontrol_new isense_switch =
 static const struct snd_kcontrol_new vsense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2770_PWR_CTRL, 2, 1, 1);
 
+static int sense_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Powering up ISENSE/VSENSE requires a trip through the shutdown state.
+	 * Do that here to ensure that our changes are applied properly, otherwise
+	 * we might end up with non-functional IVSENSE if playback started earlier,
+	 * which would break software speaker protection.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_REG:
+		return snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						    TAS2770_PWR_CTRL_MASK,
+						    TAS2770_PWR_CTRL_SHUTDOWN);
+	case SND_SOC_DAPM_POST_REG:
+		return tas2770_update_pwr_ctrl(tas2770);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget tas2770_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2770_asi1_mux),
-	SND_SOC_DAPM_SWITCH("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch),
-	SND_SOC_DAPM_SWITCH("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch),
+	SND_SOC_DAPM_SWITCH_E("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2770_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),

-- 
2.48.1


