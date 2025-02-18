Return-Path: <linux-kernel+bounces-518892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D0A395F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8871F3B9D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A623AE7C;
	Tue, 18 Feb 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivHcepl+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7422D790;
	Tue, 18 Feb 2025 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867936; cv=none; b=tponoHgdAZqDH0l3kVVLkisjqar4rXz8i+1RCe1PPa0kESjfj67Hpa6tKgmo9RNc/KLCySxImmwCRj+ZhuZjj2nZmK4UdUUhs1GBTYTobcePtX0VQKGkLUinXVn+Urx2vKjjCnXo+dU+E/DR1DEsNHCRAlBzTbsktGyLwylw2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867936; c=relaxed/simple;
	bh=ItwvcapWnX4No37sK5tr0C0YgHDBe9aBgKZAVcfytA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T20Pe1DDaNPYT+/a7woN7spAanD95+OPqNe55XvIGsSwBx+Oy8hOerBjfPuLl+l2OZdrUq6RhrVgYSEqcjqOZEtAgmOkwovgzH13p7Y5Zum2KDUNLbrbfwackix7rTy37njgL38vPX91esPlHx+wvblO//+oN8RcCqdjZ7c09Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivHcepl+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22114b800f7so39842335ad.2;
        Tue, 18 Feb 2025 00:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867934; x=1740472734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBccVGgKneSXfzYBkD4Jpd1sZnDdntYCilZFqeP7S/g=;
        b=ivHcepl+fbe8VdsPz3Dp8eZoYEo64w+Njs6qTeB8hMwdmy2eyr3pAF/Brpv76KKWBd
         HaEgN8bkbEFuiC5VdFHNlHEB4u4KQcYTfHtgVxzqjmR7wL/7vOkeoE0JmvwPgPev98Qr
         njmPnoxJ4Qn1wh6MA4BrOubWvvgvXKHOjRGf+oNCz0+amM20k+4cde8cGMmTM8uZSHhI
         A0qOtVa12imulLe26xCH4u103IqGSMLYj/868cL/NqxS4VQf+2QPDgJcYN+zrRvcM/gX
         GvnWrQY3r8jK+8Uk6SS9gt3/+Uh8txO64HTqkeUqX0IES+ouJ76VgX6fJjdihkhRVH2Y
         Kqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867934; x=1740472734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBccVGgKneSXfzYBkD4Jpd1sZnDdntYCilZFqeP7S/g=;
        b=bx34fy04rHPpkCaB5505KiOLbSKCOCIi0NZj8EjDWeCt171IX4EzDNBrAIQ2luqXnv
         r3FPZoW9IwUdmym2zN8zEuH6gESYCib6tFCGIiTdSQVMgGHOTxBDus3kXIqRhwI4Yw+U
         ml549ChJ/baE9ZR13h6MGJdje6OrTwtqm9YISc2HljGo9m1c4i/zzZq7SWhVpaKvoNLK
         t0O2fCGmilz9VJqIdMl068wa3MUpLBg/7M2ZctDgcHavEN/eeDIn1nu8bjuesXmWSoc6
         Bd3E0zZCAh65mBDBXcq64AAJYIxAq3GeK8aOVl7+49TZ/iklk85/IbbXqSEXAYpW8Fo+
         SBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUf0oH3M3kqmLC2zW7QvKbK185HDXNQ9iAVXpI6PIN7tYVaDAltwRULMmVyWTLufXOm5dbYl2pLXqwA5X0L@vger.kernel.org, AJvYcCV0yh9NsM1nqLRkdv4SzQ6SvDcnbVJV2IYK+9T1HrLTNZxWGHsmrELp9/hBj6HuLYmAf+NhtOKrOQ1tov8=@vger.kernel.org, AJvYcCWMxrFL0rxwKYfAMnASqFPkzCbeNe3iYRNhLAsnvjbTLvgAlsyEuoYAT6HnVn5+Y8DrIO7lBRtKH7sJ@vger.kernel.org, AJvYcCXRf5wmoURe3XjUbgU6Xv+JkmAyYQEqKHQXm4UI44YyaphsfRVv4wc4tyQIfnNHzSSSk5V3g5zNVWg63Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtOsHKr+gcvLA/Xr7t+Cj20ZzrBEXkY7lEENc+kNOy8ZRk7eF
	ntXsN5gJ+Zj/Ra3YNlBhDI/rl16pCCm4Bm34goMPK2q6ZUd4xe+fxoZfzWZb
X-Gm-Gg: ASbGncuM8JbiAH9XHTVq2o3LHzocd8LRF6d7KpR5NFm4SorlMK+7e0+ZJd/Y8oxY9Go
	Jcs6WVDgnU6qMS3J77VmRngkODEoIZ5NQBsSWksv2IjRynL2SyV2kwlC+FG5Ct28mdY+hj2Iu1o
	u44rpYJ7O6rZY12XDJEBft6xh6GdRz+c8CVHW+iC0n14lJSIvX/TrcKQM5YkwkUtwlZAu6DS7Xj
	uxE3rpWuMKsRVSJilJ7hYUiHDNTGIQi5uFX9PCzT1/yZY3iNrbtbNp3M8xXcwn8bfCAFOuGyyfw
	5dZ8NZooh6t1yGTmTPIHdhqRAQWOeqoyPUWuu1uSElk5jh/PwlF79USiQyWEYp/rCumkQUxEUBR
	ZJPU2lGsDTA==
X-Google-Smtp-Source: AGHT+IF69YRAn5za8af2MFH/DZsCI2LxXwdYM/i7Z3apD02bSq4Txk+V6Fr0TuaTMacvAOBd9qFZJA==
X-Received: by 2002:a05:6a00:3d55:b0:732:56cb:2f83 with SMTP id d2e1a72fcca58-732618c2987mr18713163b3a.15.1739867934222;
        Tue, 18 Feb 2025 00:38:54 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:53 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:57 +1000
Subject: [PATCH v2 23/29] ASoC: tas2764: Wait for ramp-down after shutdown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-23-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=5/z1Q+2cE2bo3ZW7z9/rxpTJXWPoJfee+5Zu6oCiyVQ=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JIErwqa11UlFG5t5lOLy3x2SvhxLK/nbob43Akd3
 TfuSTB3lLIwiHExyIopsmxoEvKYbcR2s1+kci/MHFYmkCEMXJwCMJHeLIb/nqqWv5fMTt2h+OP5
 CXdWiwtn2HexyS2r6l+nGbhwRWGRGiNDL3P3B9PKlDX6248vddVZdmZrUV0N+7JtrHKHWu5nH9R
 jAwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

When we shut down the amp, we need to wait for the built-in ramp-down
before we can remove the TDM clocks. There is no documented status
regiter to poll, so the best we can do is a delay. Datasheet says 5.9ms
for ramp-down and 1.5ms between shutdown and next startup, so let's do
6ms after mute and 2ms after shutdown. That gives us a cumulative 8ms
for ramp-down and guaratees the required minimum shutdown time.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 3c21810358881b6935a50807cf7c745291dee3e6..7d6cb29a749e234b325e253985eb0feac6f44934 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -160,6 +160,8 @@ static int tas2764_codec_suspend(struct snd_soc_component *component)
 	regcache_cache_only(tas2764->regmap, true);
 	regcache_mark_dirty(tas2764->regmap);
 
+	usleep_range(6000, 7000);
+
 	return 0;
 }
 
@@ -253,10 +255,16 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 		return ret;
 
 	if (mute) {
+		/* Wait for ramp-down */
+		usleep_range(6000, 7000);
+
 		tas2764->dac_powered = false;
 		ret = tas2764_update_pwr_ctrl(tas2764);
 		if (ret)
 			return ret;
+
+		/* Wait a bit after shutdown */
+		usleep_range(2000, 3000);
 	}
 
 	return 0;

-- 
2.48.1


