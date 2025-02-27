Return-Path: <linux-kernel+bounces-536247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFEA47D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4291892262
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EE237179;
	Thu, 27 Feb 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLohwEpr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975D22D7A3;
	Thu, 27 Feb 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658251; cv=none; b=oQCGzpwP/Ef9LCUE2OTJrYI4XlwgoiubJ57hJETzNnPKuk1Guv3QycHVTrB4AuIWbpPQZXtxDF9ce/GIGO4dnstM8u1cWhHrU2pRP3SwTuuxvtk36JzS3hJV8OV3mC9k8HxAQ5AC5drcNr0rNy3Bop/ZhNjzcPfBD6rsXU5GVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658251; c=relaxed/simple;
	bh=Jn5R4wK+F5vTNEW4NRnrP+z7OqQNNC1+xuztTWGPtZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdOOoYGZ1mRjigSV+8qIatCT/7LbQgFSRUt2hVldwS+bSZPmfoa7pC4nImWDCkx9RuPOGoO66YvwxTB0yE7wvQnbCZ3ciFPxDRLkX9UJUAagTAgc1XGTmMMROlCun6cAkmw1DJuqu/mTxWRnCJuoQNP0KJvRWzV+CQzmN0OTHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLohwEpr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220f4dd756eso15517325ad.3;
        Thu, 27 Feb 2025 04:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658249; x=1741263049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKXxnscjJywE284s2zzqhnlPvX8qOMFroJHl0KF7p7w=;
        b=dLohwEprlCMjWqA9GMyZcqLM4ZY9E8r3TF6KwZlmO44IvbIDA7Aau0UF0tL1kyudM+
         v0wFD9Ohokl+BZlpbpaFCFcGvs2fObmLvfJYbPJAS5u4iHgw+9WuKQW9v2QSvxVwWEJe
         7zfUjU3cGf0konC9ueX7L6G6suWxE9oW64fpcImrlSnGckyFt9AXJEQMc+p7BqHS8QjJ
         fQFO/lRyCXYRNO1jt6XEhsBQYIa0VwvuX/TglolBPj4x+ov8nTZzQP59aDl4sml8t9Xy
         VwvxkKtrLUwIbiJ6IhQT8ieUpf563KOsbbjJ2uyX3w98UH5TQZ/8nYeL/841iSvZnjiD
         xx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658249; x=1741263049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKXxnscjJywE284s2zzqhnlPvX8qOMFroJHl0KF7p7w=;
        b=U+i0WZ0hY5H8vmGB29GYKkWjd9cLZk2jXwXz+rLTW0lezqYISfPK8YcsLAu1uzQZbZ
         A4GegeUKLPtKJSA/BoP1TFNpc/N12yd6eaOtVchr8zB48bnzRQ1b4v8qRlXeMLWuI6Tu
         CJUDCiS5M1LrLW+SpdMOFCKwDAsRr9EpTzGh5+zNHFGjknzMuGedQ7lCMu6EgLTWq/gk
         2s//nYKxnyHEoYQDOwDLrwQryzc3qE+zwe+gB1w4Lw61qar4Rw2pacCNuTFWDGeKHL3q
         DEmP1DFf2dLH0zlvBl+9CqJgO1LpYJeVeopVYp8Vu5NoYgUD39DRbP4VZA5KpK+DpT2C
         Renw==
X-Forwarded-Encrypted: i=1; AJvYcCV4HU1JkjuT4Hxp9X17wcBVR5kFhnxekA2D5nVPNLQmNhlp0d3u6ePUEMeysKAZzebjN2uEuifDD7g2@vger.kernel.org, AJvYcCW7WWTMugCc99SLS9IDxu0e8njmcAWAclHFn+NYXVJVNf6su0gzaiW1jjoo42YzFpYRuoFhNkFBnzE/vWw=@vger.kernel.org, AJvYcCWuAPgbg2LvHOTFxHhrobDVG5R2EtNr27xoWk+KU7w73rI61n1g50Ec9HzesHaBm5R489DRiNa1S/Ka5jI=@vger.kernel.org, AJvYcCWwye3YK4BLcuVKAqn1dGGROSyBca4BEOEJR25nDUPX998D6NGrJR2mQHrxyiWVHuOmaqWBNvzY2v3BZ5iB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcq7I6DeKBUe9+BRAaAsT25U9yZv2h92YOxWYnea2gN5DYsFp7
	jLR6fp71g/DyxIp+0ScU5EjMJFK2QgKKOmdrJZwZGErtkiZd+ezW
X-Gm-Gg: ASbGncvvXPOCvn/Aw36t5qEEZ4npJhIkKUVMuklkIyRoC9NMTfo/l/RVCFz7mtkDj1n
	Ksezuz3LExJMOqQ9h7cd0/Gnljt11YvtUwlkE5D4BJSL0vVbcCVK5E0PHm7ulzzMEue/vRDvgwM
	tWUt98q0YC+vEsP4/UOCqBO8U/DgONLNVblJyHjKTSp9F5beTL866RufMIAwc9cVUyirhXKhWDn
	BL+R0vmyMESMrMuWvpjl/i05CRx5ZuN4JuF27M3kWa4iEvHoYUbyefrSPjPRektjB5BKqbJzkvo
	WwkOVFSMGx53FEwQ1xz9c6A6KUj8zWegDTNYU3i69VIp0AAXWe6SHpza22jk8f7CiV/aZ1rIU+G
	sYCoQpHskUr6fK3NSIrf9
X-Google-Smtp-Source: AGHT+IECvK48B2XjM2PfdEU2bxSAhCxuahWqdNn1JQu7EMkKMyCFnXeFoQawqcQh0CvVJRZRbXvAfw==
X-Received: by 2002:a05:6a20:158b:b0:1ee:e17c:9665 with SMTP id adf61e73a8af0-1f0fc139ae4mr20557009637.15.1740658249009;
        Thu, 27 Feb 2025 04:10:49 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:48 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:42 +1000
Subject: [PATCH v3 15/20] ASoC: tas2764: Enable main IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-15-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=vSm2lXVQsvIt/wZW3rb/DSoIEzBC+koDnVUdHg4V6Mg=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk83rJ0rGW32g3dpy6SdBo/Fb3Pv2dVaZmeuo/lVy
 1987cXSjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACbScZGRYd+rX6lz9za//VN0
 a+vS+t2yz0L3KyatPWkpdoqhV9fjbw7D/8IQnpMbK0QuSIlt8s46+fxkxcvFDtuF9v36/vye2oK
 GH5wA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

IRQ handling was added in commit dae191fb957f ("ASoC: tas2764: Add IRQ
handling") however that same commit masks all interrupts coming from
the chip. Unmask the "main" interrupts so that we can see and
deal with a number of errors including clock, voltage, and current.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 2a787baaff5342e09cdfbf7939b0d635433f27ac..c122c07e2483b9ed1e6011dd949f97f8b2d0897f 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -715,7 +715,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
-		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0x00);
 		if (ret < 0)
 			return ret;
 

-- 
2.48.1


