Return-Path: <linux-kernel+bounces-518891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE16A395EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045BA3B9B52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F022D4F3;
	Tue, 18 Feb 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7zomEhl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E622E011;
	Tue, 18 Feb 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867929; cv=none; b=EMU9qDJS1ruQ4B4+g+H5izJMXMhNuDeogbbWV0K+VpYtVipkbqDdUdh282qsgLGmM4+qhf+nCnRSk3siqHsAqqwRNyPDVWMoKsN4wjzh6zvyfA5sFPHDY4d4N/f8LjKl+pJSfX9gQuyU2iRAViuJsEL+kXMCQ1k6YDAAyITDGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867929; c=relaxed/simple;
	bh=tc7+YebJokOjioegbqEEyvkD73m77q1TkPf5QJVCYzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BW8vhlYKN7hlzLjzqNRw3aFzVC63RGLVX823iVsgVbq7aDOZwSr3mhfombcw9pJWheibhcz8qO3uhnRBbH/m1IuHtWVXlPifpvyv8mX1zmvc1oGo2u/qKuOBy7buz0U9388I8qN2N2s93XOezp1B4yWB4OmyVjoUk2b0p2+n0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7zomEhl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22104c4de96so43790335ad.3;
        Tue, 18 Feb 2025 00:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867927; x=1740472727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiLOjjzQ00SZoyjfGDk34XDYKUpsi/uREEWpuvAfIUM=;
        b=a7zomEhlIez8rNJjwFxuCsJL0qqySbJusfb2+rhJYMV9usMpSIb/Bvo9xjaHg8jEvu
         LzCYDtC3V9U0SQJjpIHfLpVEPT2+6sprlHTJ61m1RiMfUUZiOhNV4NL3eIpOk/Rcsp8r
         0X+0KNJZNqJly/A3brAbn8fFawC596Wf964V1V2p/VS9mZspauAX9TDVgS5RxtIp2DRO
         BVR/8kCu62fPG4jmHVv4uvL67Q7o6EyypXaRQbuunu7RMqeF2n/A+tc1k4+aoOkafq1t
         xO3Tm9UgB/MCHQthSF027+jM4XKpWzoazKwZmGYcCSsRz3ZCa+JJXdybdsjcKXx09N8c
         WKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867927; x=1740472727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiLOjjzQ00SZoyjfGDk34XDYKUpsi/uREEWpuvAfIUM=;
        b=hqofygmAXOQVgFzm71NXBxswJBcHdYnteg+5pQbiti45I/EowDSkB7FZryrwK6U38t
         ZhupIdYPnEIKy97CC4OIeZvtsg0tCcXMOS92Qmhn/uRkFIBQn8LLNhuasBhKvV6Y05rR
         zAmlpX3aXneuI07E+ApXmZnu4XJlyk/iEwO/4lL5nDLZR1TvzlA2oVXQyLJx+eXAEN0K
         jZw9SPq4AlrM4G08bFNNIQaV42oU/VCi0ZpHXVPhp6GS0ZOyMMnb5/qdm55i01/nvPG9
         GuGPvguk0KtqgB0jN1sshqIdNaH/2ymX1g6KTgL0HLxdot+PTdOe060oN7iiF+1+MLPM
         cCdg==
X-Forwarded-Encrypted: i=1; AJvYcCUxgEouKbr1ionHz8RmGA3Edc1vEGfLnseizK6d2oHwvXGU93b6t/aEQ3OCGpYZa2FC5ccIdlxB01tdppU=@vger.kernel.org, AJvYcCVEz9cCA31wpKHTXphdcBHjVvZcUvdQCN+/nJHGFuowNXlOSTGSxSL65cb2JdLVNAvxYQ0eGeUcw55Y@vger.kernel.org, AJvYcCWIUek+o3TBnwW9CSf5th1Gt9mXaDtoTFH0UL552UNSmWfXBrU/MkF4fm4WxvarQZgshdRzpfRb1+ofbhT/@vger.kernel.org, AJvYcCWmvNmabmxCQS9vozJTwVerUjzs/Od1Gq58VpuTG719TxpIC6eaDYffrk39jnP85AnWTRyqZ3eU+VEntZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4oY8BNxWFILawd+F3RCUaD4Hg/2NgpYec0GaQIdE1NQasWdq
	M01QZIR702jeVBydNCUzhJCUWhJfzH0fN6ht/GfFsgm7BIhqtuQOU1dqhTdw
X-Gm-Gg: ASbGncsFuOStia5DOeTBfcfYyE9KjZ6GF2tAUPO5At28GnYjnMbr40M2KRwbw0TP1pI
	v3ht9RhzodfCKBIbkvztSnpXr2Giu1vixTa3iQmhsegKu2omdaBDuGkKTSx1r6MucQaCxLqUGe4
	vPCP52JtEcgYw2+jTh8HhyzIKghdTUQRvawTTAuaMtruNryXttbP3222i8Tr1x3krSQTPD3i+zV
	hqXEfYASbN14UnYgR2Ci2tEyQ64nyE5fL1xIy2/pCWaTojtgq3SjocREnb/DFMgDcNO7i2oxssI
	VZ9VvCCQreMPmj22HT0T5yV3j7Vl+aGhqlHQwjaVuCwQQ76IDp7zVsjJ3j0MGtagOGSY0BiQEiU
	10JXgx6OMhg==
X-Google-Smtp-Source: AGHT+IGn7aILehQqPamgsv5OD4CsnwPVWdUowtXQ4D2uJxQ6nLUSk3lLQaRP5n8bye+Ha7GQaWZmlA==
X-Received: by 2002:a05:6a00:1707:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-732618fff8fmr21627172b3a.20.1739867925781;
        Tue, 18 Feb 2025 00:38:45 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:45 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:56 +1000
Subject: [PATCH v2 22/29] ASoC: tas2764: Mark SW_RESET as volatile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-22-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=815;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=JfeFMAA2K8mo5v0Zj4GGq5hrsXO4W6rdqXHcDI+Alb0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JJmaGmlZCwPvew3T7n94bzejCvs9e+OBjZMXv1l2
 mazSWaGHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEyk8hojw8KVuYsmrjruqich
 sKYj1+vItP3hInzSl9ZnLFvj/Ge1oSEjwwF3+4As+RUKqice3GsWXlyx53sPZ3TBzl7uUvZvm2Q
 e8AIA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Since the bit is self-clearing.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d316a369c43002e6a8a8160b85384b8824667bb1..3c21810358881b6935a50807cf7c745291dee3e6 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -873,6 +873,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;

-- 
2.48.1


