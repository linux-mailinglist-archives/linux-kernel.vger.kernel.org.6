Return-Path: <linux-kernel+bounces-518876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7EA395B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86912167F96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62022DFA3;
	Tue, 18 Feb 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOFaVg2c"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4122DF9A;
	Tue, 18 Feb 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867827; cv=none; b=G3NrWbkE8V+KE62JbAduIsk1LVeHCI2Of4qBKAj91zHJVx1dmPlafyKnxWKXRemvGxptRS8ewC7z1L70jj9m1eI/XYR4bNUg4/Zd8qay9e6w03Vuwva0PUNkDSr0+Z4p+7/+ZmNb3scKtZLK2a8UCywV/9en3NmW3nLX8L6oXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867827; c=relaxed/simple;
	bh=zMDQYtcRpt+4jFNPlg46tVCzKTkoPkLv+Vy2wz6r23U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bT8bAPddTRWbd/Zal9o7PgMa7dQaTWUiQHN2IeRkINPsDTWuDZHca4igP0e2i0utzcHzF09Ecbg7DLYlKWmDhQ9UE1aut3KPAko5pSakhDJc4QvQyiNKOvIDA4O4aXZTddlrEi0S35blJpj88UvcEf/LHGTMmrChELhQ7taVF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOFaVg2c; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220e989edb6so100672765ad.1;
        Tue, 18 Feb 2025 00:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867825; x=1740472625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1gmUMyFrIcKimBewI6q24dJKcEuoHIJdBxmZAwxaaE=;
        b=QOFaVg2ciY8PWFcSxq6ndmnGtiVak32vYlPXegVhhtgoSlA8PwL6bgOm8Q0ebx5NZh
         +/ZcTdlAVGAMJArO/GmpQRgFVBt5YIkPicPF0BZT3ApBnwsRDqtVpIYzj4vcpcT/a+z2
         m4ZpSPTnVgj8ROD+j3GeMItA8czOWXzONXl2cxw44hVQLlwIUBzOdx4o/nIf0SSKNuYZ
         fkNrYV6bq08FSUFIc2Q0jF+XM82e6VrSUXxnbar/PdaRwHSn2LgSGy2LpxS04mTC8MCZ
         VfxUXPOVuiRyjlUEZBANChHIy9uECVT2qTy3fPAtaD7iBX5pHpr6OZ4+hdudvlABmtsa
         Q/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867825; x=1740472625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1gmUMyFrIcKimBewI6q24dJKcEuoHIJdBxmZAwxaaE=;
        b=Mzk0pJCdrFU+IWlPMJLzvXNALwH/WwEZvt77gSsqzoE7HYHadTR0tO5lJzp37s9lx/
         f2buo8x2r4gR2Ek4H03UW6dDFa16DYYSbAMrZLuST2Eqawhqu/P14ZeI1SAZSVgyGj8Q
         YNIkz/zheGbdRoMjFWHrhk+BECzViz3XJ+/vkw7QD7WEP+V3xCAsg7tnkwjwJMrrMe68
         NQWUpodm2YqoyCNtViWkxJ/NyZFMr2VVoJqMUHnnCUKfTHOHixJ5UGpYBuKtwsh7t5rb
         4JHu2dyx3CmJa090phIbAiE1a/Qift5dOBZq60YHUYTE7IjRCWp00Jx9g8afJAJipj5b
         D4cw==
X-Forwarded-Encrypted: i=1; AJvYcCW7W+LmiHd6j57x2g9xswaCybWp7ID7GM5B6CjBr/mes0dPrbqaQq/h5Numps9N8jN1aQ7dhFNzupsnBbAt@vger.kernel.org, AJvYcCWH0zLcdjzRKNzLFnG+mjQp6k5eTgPB3DMeL9CMXTNC6EN0iMMTrIVlvhUjMg+FpR/DBorYFJo1z2QpdOw=@vger.kernel.org, AJvYcCWb9tDCBSziJULodZSsq3Io6OG8IRKOnBtEIO+nzl1ROljVtkxfRXHkl0AJDbu9JYQEwG6UBwIQla6uK/A=@vger.kernel.org, AJvYcCXRVLCL9x3ZYCGUqlukQWiwnXB/IcVmUB60NKZ35Y6JbvpAkqoM8VormKbaNjcAfxu2gW6Rja54TC5Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yym23ON3gyUUvsqxfXWgwlTpfF0H99bA/thBAgZYqFtz9N9sAxu
	BaROMNxy4H6gMmQ8tFJ9OhrZ8/6Ldkp4HTHoDcmLC3HruT/ols1rSZv5HUIB
X-Gm-Gg: ASbGncuQ1ypF5s8gKpVVbljzMkD70doqiE6WJtYcGZyz8JOpTvWugEB2enM/jly5zWM
	EdlGm78w6s+ben0u3m9sXZzJPBtnqueSo6ajibTGHcFzjfb4Xomt1N+KNeb3myB+IXCD3WSHzlL
	ICUSdpjFhkNERb6epBMZSYUrXFamSMoW/E8HH9YPyIVczeQBLgImS6ewhCvwWWza0N1wEH34bIh
	vYoUlffuoGA1K96y1QKvUeOmBoWFW0N0xYrrwaOaJ5L8ZGOZwtBKYG9YCwsEye/i03G2LHS3SSg
	AtTtOixU5AGgz4r5Jv4puoeCfeZ9DcCd1wLSX5EymTNyMkemB4w/uCTZ8AIVnvypRgBJRBIGJv2
	TBotaMKwr6w==
X-Google-Smtp-Source: AGHT+IFizoKmwjh9YN/ziweMuIVCIJzBsJIb0KmtkfpxkeL1KJmMlF3+L4OpNBzmyQWeoqE2IU22YA==
X-Received: by 2002:a05:6a20:9148:b0:1ee:ceb7:2b54 with SMTP id adf61e73a8af0-1eeceb72d97mr344927637.5.1739867825207;
        Tue, 18 Feb 2025 00:37:05 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:04 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:43 +1000
Subject: [PATCH v2 09/29] ASoC: tas2764: Reinit cache on part reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-9-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=YUiXWU8Gf9wDtlFFZhIrrwCN5xdBOaHOAAxlNP/Sbtk=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BJcV0qeUf8syhDg+XJ+6qn1lu+DXXdt+ZgvxK83r
 /DblMseHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAExkBgPD/2R1VsbLohz7d052
 Xbxdb3V827QsvYKC2I/tLqf15suWejP8FfB97LYhcK/A2/VnprWuYP/Eb2VrbbRY98hO4dlfjre
 FcgEA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

When the part is reset in component_probe, do not forget to reinit the
regcache, otherwise the cache can get out of sync with the part's
actual state. This fix is similar to commit 0a0342ede303
("ASoC: tas2770: Reinit regcache on reset") which concerned the
tas2770 driver.

Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 05d025ffc567fac25110fbde2ca19337b8ee329d..e4003a724c8c09303882ee36fc11133cf5c78b57 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -539,6 +539,8 @@ static uint8_t sn012776_bop_presets[] = {
 	0x06, 0x3e, 0x37, 0x30, 0xff, 0xe6
 };
 
+static const struct regmap_config tas2764_i2c_regmap;
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
@@ -552,6 +554,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	}
 
 	tas2764_reset(tas2764);
+	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
 		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);

-- 
2.48.1


