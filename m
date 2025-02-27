Return-Path: <linux-kernel+bounces-536237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40CA47D15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24DE3AAE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E322FDE6;
	Thu, 27 Feb 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGzZc/xm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8E22FAF4;
	Thu, 27 Feb 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658189; cv=none; b=cVJlUSuHTNRi+zlJcUrP2KFEEjCsc6eMt29+mFnl+Xy+CJNnWbnqlpUZl1a5BMOfTKrEZ1m98HuQlRnURa6317TWZRTcnkq68ddrdpxrz9dsFaXIdJua9OtKAYGAv8O1pu8gXTXHBMATiuLgwnwCpHB39NMfb94vTejoj7hfhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658189; c=relaxed/simple;
	bh=C3fMl/nUTH2R9yPVtlYR97ew00Bt5b1HFMDjMdULqBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PS6fcx6EBmXy93ROMuFOPoxqhBDYZagv0GnMbXDLMZwj1/tSx3c+8DU3o/A/je3lu4dmO4gL8FKRKcowSyOrMJclcSyyqg27e4PKy1Cb3As9WS1L/TUPv31QDyZZTDiDYTLr0BnOUps5UFV0vnoefRHzWxuotlClVMX01Mrfbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGzZc/xm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22334203781so26113395ad.0;
        Thu, 27 Feb 2025 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658187; x=1741262987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLr65VWy9RLy1Sl5qrWRNMygIqDSaNHv3m0GyUnsMQE=;
        b=QGzZc/xmOXVsNiEYBxu3KMQg078hfowWnceVBGGjypRdj0z/EJIPPJgbMWqTpd5q5o
         hZpsswfLoj8VvqUpgWH8ORmecj7Ah8j0zcMMWNBohVxbK2zhVW3BNeYkQNhKXf3Diy1G
         qALpvIMlDnkdWManhvgKE+XKuY/dLlRDzl3ojgRNuQIBSpYc3euAw4vwnCMqVA60WoCz
         4Fki5NdqFvPzmUudQ6ESnkbrZ9ajmwb1A5d0h9Nw8LosiVus4H+ttcokUwEfTLDE8qoE
         +R/VV61g6wWOj4xBEs1O21HFFr6zCvF7EakXYkNY+Xkf7QdjG+bgob2PA+TqvWy0msqs
         Q7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658187; x=1741262987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLr65VWy9RLy1Sl5qrWRNMygIqDSaNHv3m0GyUnsMQE=;
        b=EiZ61iXSfurrBqtdpJkR30wa6rc9HAcM/PvpW4pQYpkMNkyKD+Qf+XWTCj1pXFSABS
         EcHsIX4JttOioNAdIB14s2G09z3L7bCm9BWoNY1TDDzCbHc/w5Cvk1mvLxRkyEynLHAQ
         KnKbhQXlzM3/+zXal1zBiWEAkAao5Qx7Vs5n0iRTsx9bwPbRRdi0A7UofbBWo1v8EQTg
         vDMtE6+yCxb1G7Z3CMdYVQwjhczGYp9oW1dl9y0M1khGl/uwrOmqUpKt4puf1+d6JKwX
         fglYqa7UaoqaTg0LUrYlfIQPVp85HmnPUAJ+IRP/jrkurCc7sYVpBKS0uQXviJVCLG2J
         867A==
X-Forwarded-Encrypted: i=1; AJvYcCV64KtT18H38C1vuZAN6yZT+K3zqMM/E96QzMnWYvC7tDYfgbX5JZjHm5y8R74OapLYQUP5cdpQZ2X0@vger.kernel.org, AJvYcCX0egFZBEn6yZWBnzyeMsh1x1fTXNT61dWGIWAaWOsy31pyD8Eqd4mQUwMcOE4av4FFJKdOtuQEsI4elWs=@vger.kernel.org, AJvYcCX6bGx/rz5UGwFifOsQFueLJvv/bT9iNNe1nQEtKuoewpdKfYZeWUtRCmYhcPNtXeUWZgd+p0bYwnPblwY=@vger.kernel.org, AJvYcCXMB/lVqzYgBdBuPxuuuP+SMpr9YqRDGf1RLZlpSZK/XiZMItLOXLbVFHWssy/VCjp39gIXVeSau6A3ANDn@vger.kernel.org
X-Gm-Message-State: AOJu0YxAan9aTOv6iadNpk7u4LLA8g7tZuKFyXBQx119ZcpTNL7yHVBj
	RVVwqM3GB4eVzR5yfXPvF5NwABNf0YnHrM1e6zfh29u5FGCqJGsj
X-Gm-Gg: ASbGncuN/GKDazmGFzb0xvW6PEtNW5SEb/qGw6lBRafzLcHP7DgrCyRXTDG3rvFPJ82
	3GGwwh+n4o9dlUMyvaRF7jj2dcYxgKjsZpNFxlW9yU/H0gpnIfSy5jV9A/eFVJF6w2Ky+G3C04E
	oguiatMXFZgT17uKUbP42Kf+kjCJnN9AgiU8ImfWl4W56VWI9IWv3eW8O009RKqbAyC03eruxjV
	U2pt+7AC23TRD2x7Ookk8UVzHgHUHuOoB6QnXpjG5e7fHfkkvk34Dge51guGgURckC5b2zVlilx
	nOwGZP3fIEScyPGU/7cu8/aNBVlT1Zx012BehmT9/ZnSFHtVHrvFWa/kZslSzXjgzWmZRGeMG44
	JqTDme3O5plz/D4DC8A34
X-Google-Smtp-Source: AGHT+IFmC+LEvCK0DwNMDPIsYIpYRsaLbfyC+/trnMSlEmS0nxupiwJxRNOdosgj8DYEi0BBxHaIZQ==
X-Received: by 2002:a05:6a20:914f:b0:1f0:e2d0:fb65 with SMTP id adf61e73a8af0-1f2e384f548mr5422538637.2.1740658186937;
        Thu, 27 Feb 2025 04:09:46 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:46 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:34 +1000
Subject: [PATCH v3 07/20] ASoC: tas2764: Reinit cache on part reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-7-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=1qRmdyEVykh3CldMGQqX5bd/Ea4U2G0jI3+vaQLHohk=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk+yS0S/WvaH8+BjfTeJCfkCNdwTm3TWz9qk2vO08
 rOtg/+rjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACbC+5Thf9zHj4/fC5TM5/C4
 HOHh/OGq7UWzWwlHVumvfvT6w6GrUu8Y/ocYHZhx7rRB/NS3XbcnLO5ffCZzfi1Ll3XAPyvzX1V
 /3TkB
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
index 08aa7ee34256896915f3ed6438b8b8827ce240c7..49b73b74b2d9dd6d09747cabc2b00519c549775d 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -546,6 +546,8 @@ static uint8_t sn012776_bop_presets[] = {
 	0x06, 0x3e, 0x37, 0x30, 0xff, 0xe6
 };
 
+static const struct regmap_config tas2764_i2c_regmap;
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
@@ -559,6 +561,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	}
 
 	tas2764_reset(tas2764);
+	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
 		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);

-- 
2.48.1


