Return-Path: <linux-kernel+bounces-518890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39BA395E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E19C1797FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3423956F;
	Tue, 18 Feb 2025 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRfN2DMe"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952422DFE5;
	Tue, 18 Feb 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867920; cv=none; b=Mbm8BUNMGmwWT2OlzSqazzJu4OYMmITM5J8w06PxM8lhOT1xeiVxHo5Aqpeed+61PeN9wrw1MOoHbD4lMQpDcUrIj5aAvw1OuamdbqwUR0UqApEtN49SJqy7+Z7FabNAnLgxjMUQ5fbs1hxrlmjN8lna+LEEYU2YNgRWZfejuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867920; c=relaxed/simple;
	bh=kJTFUNaJvHb40kFLT4FXflK4GFWczcgIpzfS/OJgv8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hztCOvReWVdX8zacwHlO6v5e/lDvtZgyPiSp2kQTre195qPQKJUb3QR5SE0Y8WwFXCPXDktao2a8xkFVN3f8jILN51Cl27In69IaZrznwRFQ7ICYn7Gh47BbTzSqySrIYZyYm1eoBTo0AOXRlx0WapcmQsQjZWU7L3kceNhqQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRfN2DMe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d39a5627so74789145ad.1;
        Tue, 18 Feb 2025 00:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867918; x=1740472718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0xnSZoULp+tJndSbsnTe4b8bjzfxIgtXuAx9KCZHhY=;
        b=iRfN2DMekoWzp7OOLenpb4XIm7+3CNIidlVN6E6dxW+5TNRffY0webmHCYn58KLREK
         /egcNnozgl9Kz0Vtn6l2qhME3KtFf13X8UMu4iWo+t1v1TLDj6Nwkt6aCPoOc/7BoEFX
         ZkaAvsIF/U5Ah470ygBoN012Je8s1hq3UOfrp0R1UM24+TQt+tpndTIeRnr1pCCAKxqo
         HWTQfvuAeTxSQIKrE0OhPX8WRceSrXnkP44RFFCOrRzq7FUKyxHVUfg0BDOCaRekMMLr
         SKIeD/4YYyxn98pEnYxuECoH+w2ONe98WBm5zj3brI96goZsnaiqKf8bnjZ4MnrKhOZv
         +Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867918; x=1740472718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0xnSZoULp+tJndSbsnTe4b8bjzfxIgtXuAx9KCZHhY=;
        b=DqQ+uJz5enUJ0XF9VGS963NFn2vnBy6gZiwRzX/Kw1qwReJJmDf1ULMPbfWPYFWxbd
         Kykiv6qvtnTH2DKMzkfU2xiu/w/S5VUyzgt4mWB3Gt1zahgJfg1gmD6RaA1sfMFtLriF
         g5fv9n6RUc8ga2Z+GQ9RSDvs8napsvjFCEWrMfFaziCR6id4xvLzRa7zOmGho2mM6AyD
         r5CdbxletjX8Wxa9PUSGCCdMjGMMMRiI3bJkQHmzOndZQn1u/8kVv8d5VkKjX1lSgZK5
         nRxUmofnBwrCs/4Ip1uzgutT4S/nu5uy212WF/g+wtmD+cqPyHTA/b1qePaDmvZBpjRX
         YUjg==
X-Forwarded-Encrypted: i=1; AJvYcCUojNmJPGiXc31lJLXqVYUX0SgKy/0bOQ9HMwIBWTcV1rgs5hIIDQ7kjAYLB2bobCjIN7NEHpuwpw6dv/0=@vger.kernel.org, AJvYcCVVHgfugMwFz8Iw8kcmzDNCd5po1A3Q+OKm1WEhuN1y8OfGcz60YCKGvPEDqcT4/QCIrbMvKlca6yOG649S@vger.kernel.org, AJvYcCVnKY1z8XIjEwLnV3WuubQ0xxgMCdsm+PZIg/SYPeKQCczmDdZkMHi9Wadzsr9H+LJXyqx0TF+8pIi6@vger.kernel.org, AJvYcCVvCz8o1CrYyKzjzWNeEsbyT7I5M17SARC2XQ0YWdJMAi+nYAJqNFzDXL8aBRD6smCk/EgBO9NqnqgGYCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwO276YXKNE6TMNGSsqiA3mHtfMt5Jkzeq9sgldlw3rVu4w8jW
	XW6OsmptszlA3Vc9qFhLK1hPn6/i8CvXHoCOVsjHdTLU++SNTPObEpR4BdK+
X-Gm-Gg: ASbGncvtHb+xaU7jIOx90zENPBZDRR3XLkKOmjCQbfw+9+fF6UcFfPdphroqK/D6HCD
	4RqNjxCwsVyr5s22+scmZZGheSfXsGxOg++mQnVXLeIwXbq7h4pS/3DX06i9+tv5D96Emphf0Fv
	UJKOgZ4gnxAuJoOBOTd71O6KP4/EYelXkt0+zlb4FJvgXSgmyW0RJgB9Aq64LKB6sq9AsD5tyMW
	tMRdAeigZSBjDLDysGVxGJ/Sa/5M60cjk/3WOraBt6pKogvpKuU7v4DShpAHu7T34jzhEgZAPBy
	0d1grgh//de7xt+saYbcs0C1TsqA6ZTev1pOaVWth1EbYTKgOXUPNerlnrc+BZ3NE2n3pBOUOcL
	Y5oL1+ZLCIA==
X-Google-Smtp-Source: AGHT+IFDrRp31PJvU6mzhR2mwgz+DW/BV7o0dC65MC+BF3NgEj/m25LCivVIpTeTBYyEDntfFRI9SQ==
X-Received: by 2002:a05:6a00:198c:b0:730:4598:ddb5 with SMTP id d2e1a72fcca58-7326177622emr22154290b3a.2.1739867917918;
        Tue, 18 Feb 2025 00:38:37 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:37 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:55 +1000
Subject: [PATCH v2 21/29] ASoC: tas2764: Add reg defaults for
 TAS2764_INT_CLK_CFG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-21-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Mbk5j67i1cV333wWEgS3bKTpMGxWCx//aUmM6Ej9rq8=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JJMf8fq7cwz1nK6eUmu6VR7o5J77lqlVbWOdYWX5
 j/WN+ruKGVhEONikBVTZNnQJOQx24jtZr9I5V6YOaxMIEMYuDgFYCKBtxj+SuuHbJB9sEzlnErE
 1s+yf1ZyaWwQ2+4v9ORAyLGKtMRdNxgZfu3W89T30+pyeHA91F3+pMOs36kr2JuNZPOYT0aLqnB
 xAwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 5d89d47c1667c1067f88169575b7b76e9a25bda4..d316a369c43002e6a8a8160b85384b8824667bb1 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -855,6 +855,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {

-- 
2.48.1


