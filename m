Return-Path: <linux-kernel+bounces-536254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52087A47D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977A73ABC10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85F2309B0;
	Thu, 27 Feb 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efDdgJM1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16622D4E4;
	Thu, 27 Feb 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658290; cv=none; b=RiABzV6uMyUiHKGvR1dQf0+svqTU9+ysxGaIPEg3kfQr7a1A5wsJcRN/smNgKjb21WO3iuQKM8sQNEfp61ZIDOAkc4iJeX96LEfIhChJLGKlnL4UC0tbxdYRfhdj6W+o1xdN7CGpu/AFgFlxer9ZsuJm2lN17MdZRYgNpLcVc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658290; c=relaxed/simple;
	bh=Sd3QdDEgr83Fg6PxxgYQ9P4zyv6jCRBeVjY/d6AX3g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hf9Mb1ZPE81pjpeUAtK2lUOx8JOki5HwoDJeiRLqGEhgQjfsIrcUFLEsTF5IanHgIR+M9RkXXxFm1omZO4FIWTsVkoP+QHvpHvSX1roW4LMfHMvL8EIK7FgGe6vY+OFl+QZ4Mm5YPYkrPQAIWdFic0hi3W8tbxbD51Nh/peYLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efDdgJM1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223594b3c6dso6584245ad.2;
        Thu, 27 Feb 2025 04:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658288; x=1741263088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEzzB9qVJ3Iw6yE+IGNZV4gwcPeMNS9a9nupNaDYjZA=;
        b=efDdgJM1euJwjUZWrcB0NkFb0bK1NyU4e0BZ5P/0s/wE2oQCTixA4gHziRHZSdyprP
         5o3G/SwZO806px4ZQP63w9VYfF52DyAT6ZIQKJwObVTSH/PttnIorlvfzZ3AJfKr+2Ig
         pyMRkb7ZmIys598u/WaEbenztjAnbpPcL+i3BYud+i/CpWkvSqYB7QIQN0TwHSm2vkWC
         q18wkJSnwC+ethHtyttncKesAduQVLUvM9gKmqNhO0ak4O1rVT7X8FqhpmVU+O5OYkNz
         qWyH4F43HaRNMQ9n5zwlwEnIWzmIRLZD4Mo1oFl1fItqFAeOpK4j0jUDawhrsbLZKipj
         niAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658288; x=1741263088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEzzB9qVJ3Iw6yE+IGNZV4gwcPeMNS9a9nupNaDYjZA=;
        b=TYCcGhO4sFl+qD5MejjVIOFUFP6NpBT152mkFK1G89ExVi4OiLhF4xq/EDTS34ps0a
         fSkPiIgiyykLg1VEugZEgyKc5R+6iB5pTmPOQKlhu+788Hm4Wisedmuh8wQaX0j9eIHh
         s4uUjPgKI6vqO74e8eVEgPdtdWcNnyN8Bxyg/NhD0pU37ymL1CVbfR1HWqdbEiT3jOu0
         pgxQPIlLeLO+hpQGYG+bf/IrfVdO51RBUKDwtZ+OTGSiMYCuAsErSoGCvv0MMYWU5jJP
         9MpkFnmgrS37pV7geYuHdDMI2c/VoQwYUMsDNF/glAAop1fpjblPlCKkKJXMdKyJXky0
         LErg==
X-Forwarded-Encrypted: i=1; AJvYcCU8RcXz5ki5LC8dTeCFrEqzi9AaAoPpOhVCZIICQD4jiUkNbuMCiEKkvc+yTcmg1FO7d3IK0s5iYCaJ8rg=@vger.kernel.org, AJvYcCUCfhQ3N6deV9T09zpZXIG2Qe+9fPY7yMYpHKj8vbpeTQ2HK2usGrCd6S++PhThoI4bGkJY/3YjnIUlfjo=@vger.kernel.org, AJvYcCUfi3KBI2zmcuolGu24P9ALNDhbQ8lHFMxeJfJC77k+0W29TgCyF9nMqSSIQ8R2VuwDiRVZiJfuSzkk@vger.kernel.org, AJvYcCXYKMMcIX2eod68nD9bBIM0Z8K7NP7iCfm6HCSJWhviFbhnWGw/1BvP60qRmLSZhTMPnC5TOdy8+kHPkDey@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4r3mHTEkF2F55MNGsSSJWR//sPGCrbzN/VlZKoTaazXtAAKkE
	wigNpFswspe328B6maQzh3lhhyDa3US0qI3FM9OQZ1iC5VFZEfXZ
X-Gm-Gg: ASbGnct5wlMJJyVzj0OQy3v+Prb2yJyiVdEMhNqJ/lh1PjO3AcUL3A/V88Cn9pjcMxT
	agHwJWSPxuZhRBNVMDincjxImzd1RShxny5w7vn3PN42r06tlubh2Df4iQS7qP44h6Htk4GtD1g
	BqTRbZDdpCbZY/SzGvzncV4gvwSXApEwKv7t26il2Eh+HrCnpNlqp1c8gt2K22fsO3Q24wvadYC
	/t/WVXkOTFNEFiPM51SxltW8iadNAvd0FJcXgcEnpQexMuXvvLkiS4QZoCysDh1o9hcim9xKTpP
	ERM31UO5LWLvtXVc8OhL3jJnzyY4Mpi/bS7fkRYDbdrcUUjWysgP/psegCI3AWZP0UIqQOXOp/G
	f+AYBPtNAUqaoyzacDOb9
X-Google-Smtp-Source: AGHT+IHdFPiIjso+jHQ5pYM1l26QNU+l3tZa6s8ZU6RVChKuKqgbn5vVYB+/pxo5sqBJaVfMPpIGhQ==
X-Received: by 2002:a05:6a00:8c3:b0:730:9752:d034 with SMTP id d2e1a72fcca58-734790a07bemr16311476b3a.1.1740658288101;
        Thu, 27 Feb 2025 04:11:28 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:11:27 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:47 +1000
Subject: [PATCH v3 20/20] ASoC: tas2770: Set the SDOUT polarity correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-20-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=IJKMt2MOzo4HqAlNbvJllezc8HVauxLaZQPm/TY6YwA=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk8XTzVteJa9zyGteXNIKOu9izN3CS9kSJYwaitYF
 5tnsaKto5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgIlESjAyNP66avXB65vk3+X/
 tyf5R1ur/1rWzGh3ZPl1gQXhTIKpSxkZWs9cP6RixZIod15C8rDMsqc3e3P8u3/dXGnXUcHfd2s
 1FwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

TX launch polarity needs to be the opposite of RX capture polarity, to
generate the right bit slot alignment.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 58f36cf471a6b7dd15c1b0600710396de4e2f61e..b68ae6236d69b43cfb1cf28cabf73b1f729191ab 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -352,7 +352,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct snd_soc_component *component = dai->component;
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
@@ -369,6 +369,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 |= TAS2770_TDM_CFG_REG1_RX_RSING;
+		asi_cfg_4 |= TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		invert_fpol = 1;
@@ -387,6 +388,12 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
+					    TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		tdm_rx_start_slot = 1;

-- 
2.48.1


