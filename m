Return-Path: <linux-kernel+bounces-518868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B613A3959E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2FF3AFA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BBF22D4ED;
	Tue, 18 Feb 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG8q7eOR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42A22B8D0;
	Tue, 18 Feb 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867765; cv=none; b=lCSS4Ezx9ZG/E2FViaMEMNq27UpasxnJPxldLyHAZfz8uo6fhdr4LU2bBSEsGBPBvYhgxrmTBZKZ+QBUPizZjyvqE35TW/X3si4KSVTuOEEgOTtgiQ5+Wu4xrOSnQ+sTgS+36J9JC56n+eZapyOTH7I4nY3upGjZA5+4yjU1HbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867765; c=relaxed/simple;
	bh=JjlvOPqR1QdqJhsMRRHhvT8COSrKfIPpL8mmZWKayTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAUzLktwFmXZ0mesgnMdBVBRrbvCvvDtxNWuL9hecEuWMMgt0jFdW9E+KVI3bNjh2NtlhbNKDtOfRC6jfWTFrWylwA+cEOqDNShXttPKDZCisEWb3gEU4HSFx8ew0SP/2SeaM2l1vL1jXHlscN4WRKJYTWH849tJ/NlVzGmZ7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG8q7eOR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221050f3f00so50366675ad.2;
        Tue, 18 Feb 2025 00:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867763; x=1740472563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BceYlCX5vbozGNFMmQiIjW33ZPH5I7W91a3fTwyhgQQ=;
        b=bG8q7eORPvBjTgxG5ri9myYo3BtJsxH9bkH0TMj0l9yyvTnkgghJGrU3QZm3BQhNP6
         2N0dPoE2vMpT5Qb9/VQ33qMg2dcd/rMJRngOjRycx8d3tG033Qw4qOktKiar/vjuQKDf
         9fRS5HV4rHVos1PENHaXFCgDpxRAyoisvHf+eZMZKbxsL0OTmKrIFEsGknIYk9EH2R6Q
         JS4fkOveP21/6HTLcUFK9/mL+iQeSL58dixXFeDPE+hdgQ9+rrN3xCO/oGPbyKmjA2Ss
         v+qiHVblPrG85Y1chQUljksAdt+2DWiNR/v7jtQN+z+H/G7Ha3P03MKF5YEz170K7MAL
         k0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867763; x=1740472563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BceYlCX5vbozGNFMmQiIjW33ZPH5I7W91a3fTwyhgQQ=;
        b=t8Lh0OW7y+nS91TYbuB1l72pXYOREovlFogbo4Rc7PIRwG8NDuH8eOgEzPeBLvgDVs
         LdSBPERyXP597oKHH6bPOeto3SZJLqnzXWzu4sYYBimyiij/iSoSjpvF444O3aoHRAsn
         4U1ZGbsEW6YgmDaTp7XfT4+vt2x1Ez8kvq/ZQYMpQR6kwcvNVjmlQlJhnjXhJYG+WE3p
         RD/FLasoFPKYuUeNZpUKBrVyukKucbS4KG+IpPIwZIOZOAUYUK7HBD9DAp1NJEZhrb/P
         B5sqCJT2tAlqjWwLeB1mb7S7xPXv/DKhnLNbV0bHyxe984jPmKEs7eDjAiRTRFkAx2XW
         nP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0lK3lWQ72MUx9XBTndGljlMsHEc31LPBa0WF3r5wzwqZ/GCm2n7mLyWEdtCUnORCn+kcDX03lXZcy@vger.kernel.org, AJvYcCUpn3enwQ1NfpaIgoZOwqNiALOhLJj3PDeTP/G7obSY29x/s80qqw6urnqHgGZzZOgFmswO0bnhhSCt3Fc=@vger.kernel.org, AJvYcCW4ltY7fyGnFdclqy02XxWj3hrAo3HCRFNBZgRwV+iEoF4TQzGZ5lwlt0e1xEwE6JhdftBWQRZkRhz3lRrL@vger.kernel.org, AJvYcCWlj3OPdDFahXcpISTbvhaOVWQc3Uzl3ho2tV0dhEzoFfFeFaxcLRJbDZn1JgYv+MRWX3aFHqnQdrPEsDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfLFgbpn+w02AE0XynPzKXok9qrmYtPD20qLfd+U63vF+VeC8
	bPLAyV557FYMJvbFAhdm5d76IscwuZWBF4K/EHqrPfvl/YXOwnmEt1xpZT9f
X-Gm-Gg: ASbGncsfLMJ5CjDMRYBS1qaQsCFYIBLGO1+iSclerWeBRrPGjAxzD7rYYp3tbgdCmMZ
	t0PJr0Z8ksz0OtN571ZK0AGNwHrqid01BPFiufA+ryo5GrSz90l/+IiOJ3gg7+E7jM3I5WFzkBr
	2jfsno3P5qEPaeF1N7H6pYU5JdIG0k6woR8SwK1WRHpQRd404DaX7njWlM6DjJdFxg6VzQrI128
	i64HOONUqQMQsTiBlSOs0kkFhdxxOOpQ8Gr0V29Av1FE4AIcQJZZ0E78rBhKMJx/B3msuPwpccQ
	S4qdNe284VsHSfb3e7Zle5ItxVbw2LI1SteCMJ1wrtVe3/UChitITJZELGcbkmeoKy7scFP6TN7
	vN+XXcSbviA==
X-Google-Smtp-Source: AGHT+IExe1obOg6JdhqaMeZP9BJnI/sbek9jjVND4C34Fb62dH/AuT4ztTLKvkL9heLj+cU5Y+13Yw==
X-Received: by 2002:a05:6a00:3e0c:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-732618c1ec6mr22056568b3a.16.1739867762934;
        Tue, 18 Feb 2025 00:36:02 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:02 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:35 +1000
Subject: [PATCH v2 01/29] ASoC: tas2764: Fix power control mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-1-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=802;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=3C7DOfIHda8WjgBc3ejixI8wNYha3fB9QmWCFcWPEPU=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OIF+d793mUl/67UftksU+dWFj03dY0LHw8etclyq
 Vn7lP1hRwkLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABM5ysvwhW/foRXV/cLFGnsK
 bHf/EDc3Xrrpk5u47RGjL5X3g50SGRlmLKhnUFc981p7S/gro5hrUXnzPr0RYXuUuejkcruEV+l
 sAA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 168af772a898ffd1c5e96c50df77ff6225f704cd..d13ecae9c9c2f57853db70bb1eef2380f6fec45c 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)

-- 
2.48.1


