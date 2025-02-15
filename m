Return-Path: <linux-kernel+bounces-515834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F41A36974
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070AD7A2AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA07B1A5B95;
	Sat, 15 Feb 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrvP4l6a"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921324B29;
	Sat, 15 Feb 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577968; cv=none; b=fDH+q1ekJ2vSjAcHcO4yG0m3OMvM2rvIi4PwaMRVRqDVbXHT9iH41w1W1QrzUgHa1wqww75ur9R9yXvgfYD5YURzf9RhMM3ModGy/+mULriQ9nEKagmqxuVYfYLx9WbFTMR9BluVUeq5xEfx92p9qgFVWFbX4rXy5d8uJWsCu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577968; c=relaxed/simple;
	bh=exy/ez26Hxfwd1ehJydaC5MQznjyT2T6KkrUovtbO0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5dk7DVKzdLxI+fCQXJYDHNzmsmEpHFJYFj0ttJTwu5JsJuhHVVz0bJq8c8hlPOP79LCTGXJbQlG58PxTsK7nqxgJ0kw+Otn2nQwQAiigTY+336ed4zLpsAgLBKgsvSAtfojtwT5NtQM1ny+zyenQabuoYMNTVGIc+/ACB/JNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrvP4l6a; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c92c857aso42461125ad.0;
        Fri, 14 Feb 2025 16:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577965; x=1740182765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMOl5DWfSarAr8NfczAc5bcb6e3mt57YM/YFQ8kMkDk=;
        b=IrvP4l6a8yUZO+DKzZSYhAtD5XyqvO/WDeCrF6CpHVLr0BaFc8YTuSFw8Wum/g6ZU8
         aMG4tc7Ai3c5NaWoQs6QSZYGjGjXojvec5Dp2S6c1G6SgS8dBJmOn7mkqBu6og7oNwYT
         QA3Lx6IpDFjrtGbshLO7x8YkYuYVj4z2kss9LELTW11wDng9ZXDw0O8UnA/Vnaua20/A
         Qu3ligrxpYVp9/8QG7pvXWn0J/baf/H4t7hMazz9PyV0tCsq3rhfJxWIMcRpirV5R0iX
         jK6EA6XXQx2kWDzL8VLo6Pqytf+Nht+bDLUQCYmoZB3i9c7SyB+IaiNigtQGGRxfkBT1
         6I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577965; x=1740182765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMOl5DWfSarAr8NfczAc5bcb6e3mt57YM/YFQ8kMkDk=;
        b=MNPLwdzXLI8gqRCuumcVs/hsFpUWJnUh37mBurrUgz33+5ZuD9IbvRiqfcQXQaZQSk
         GAtCd3Mz9l3x8Dt8QjuzuB7bbeKhhXkOwIcjg7j2EmnMEug1SscP/ueW/9F4YrFL71Nc
         oY3KUGmBKX+2k9LSHhFR6h6hPIq2WOVeqi7/VwLPJCKp08e5xzQbypIIdn1JkO8CbzOS
         9julc24hSM3zbygOIjr7Zax11wunuxbxgt4L1NUGtfYcS71tWunKwHSCiFG9tCaGAoan
         WHbW1uXCccAIpr8F8tusJ42UvAoSFOHHKT6HM+5aIeKxl9+1RgC4+TiFi18gMEkdWKrG
         9q5w==
X-Forwarded-Encrypted: i=1; AJvYcCUUSTlUulQ5TDwejoi8leHboXlFlvjJZVqC+5RgUpOSj8/aW1waxMcIB34POSeYZMHm/13WVWSi8lUQ@vger.kernel.org, AJvYcCVYSYIshbdZPMGl7Ac62yIXv/GWi8YgOI/761bYoeQyjKuSLQVWFnFmdBJrcu3CJJboXCniDfekqjqKY1w=@vger.kernel.org, AJvYcCWw2sARMb73G+1XesvUBaFlyJFNrVVbtKZZePCxShaYerKEtpRxoIUG9XgXOWTkfst7NSGiLu5i1lb17bx6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47Mr6J46yK3KeK4yIuIah2rYOrV99LGMPtB0Y8ncndJJVavn+
	YLQJL+3BLAwM/wWLC3qN7dli8G58I2iMV9NTRc4RSZfQ6gRklMzG
X-Gm-Gg: ASbGncufKYEN36epYLYBl6+KQu/sZjx0v3OFEyKKEMQdyHQiKf61iOlAfrsrGL36HA+
	xjLzX6WKLBpA38fA4Vcksogz4PFXb6z4aBbAXjAQ7soYNuPWBeCrsn7M465/0Txsz6HI7AhbYB7
	mHmrb8IijqE+AGs4+5ul1vaiEE+iVvWyHiPdvegMfdIPSNB0cBffY9tzon7a+F2myl44sRo2yj5
	NodZZ3xMGvVcC/COZ9PayebcdKCwWhdzwMUVyBhSLJRYc3K7r8gP1qwzcWSe74p4/TnFxn+Hga/
	vjW78p/WC1Pc1Mnph9TR2CyIapUCECu/RrPHXjE0D3pR+WfWIXllP0kP5y5HGDDNHUwDgt+e1fQ
	JU7g7iWpA1A==
X-Google-Smtp-Source: AGHT+IGAJaQEmpdeALEh/GyxIXOnz6R69HJuA5hOSl0OQ1WF8mnI0XnI3HlrKU2LHmfIXMS1gCOOuQ==
X-Received: by 2002:a17:902:ce89:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-221043951fbmr18345175ad.1.1739577965620;
        Fri, 14 Feb 2025 16:06:05 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:06:04 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:58 +1000
Subject: [PATCH 25/27] ASoC: tas2770: Fix volume scale
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-25-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=XaNoLJU7DdmYL4jp3fbyo1TQkWbzJcJkaIm31NjsXmo=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb+5Y/dPCvzHxiHDqWZYD0pO9fs9z2q4rpBCwS05So
 Lq/oOxTRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABOJ4mBk+Oi24ZzB+U9ZSSte
 qa1jkND8Vr9mRubCv4cl392puiPRNJ3hf+Duv7HchX/iTy6WcdwWWR4t6TX1lrWkyWFP7gn95xY
 Y8gMA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

The scale starts at -100dB, not -128dB.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 555642d5c53533d9959314f0384c4dfe91ca799b..a9e65f95ec8600d905c45db4e013d3c2602fa8dc 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -653,7 +653,7 @@ static void tas2770_codec_remove(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,

-- 
2.48.1


