Return-Path: <linux-kernel+bounces-427422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1C69E00BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A15162C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E01FC7C5;
	Mon,  2 Dec 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zsRCuEzY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39091F8F16
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139419; cv=none; b=N9vcBH6J8LWYdaH31V7S9d8MMjqUeH8sB8boEhTZwZp45kzVYvhJWJ6lTYYsCaoLVYhmc8aSGSE749uHiuQNNSWYJV40iZqIGrStOIxmXNEuGn9qFJhPHMq0JMVMX6E7CWjU+7J4VciRI0KqtvVs/c1vRoscL68yH8cBEhAal24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139419; c=relaxed/simple;
	bh=Bswv2ShtZ15EuEQneXOzrttn0rUwfA/DlAUnJf4MQAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2r54mIZSjBYJW8sNZNl+vRJcjf0Cpr+qgWgtdayaktaWMyiR43foECKOtUidrE96dIrrxFiSDHiaWw52/NdSPmPTm2I7pZcEBT9L4yEBImkC5dqcamWsPB3MgKRpZUuaT4qR5hBKEolXsWOtyqOqSqOgAUrC2LeESD2VVLBNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zsRCuEzY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aabd688fso25591245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733139415; x=1733744215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6QzxVLWRzRH/qOa9cOwOHFOV2Etnv6DT+rOyPz2/6k=;
        b=zsRCuEzYCSbDoJbFivfq6TxhcKcJqpW0gIhNMpnknMK72R0VObN/6hUFHcL33yGeBq
         J6+Z+4tha/pl9hL11LJC+Dfr2TECknKnXTohPJlnzBiNOA2AD7B7SLaNNdRB0uzCiYiE
         xXOFo2TcsAyPzDXd/NsPwqrfExYRovDFhlLOaB+lQ2g8fB1CgrF1oM+Y4JI19T9vgdNm
         sXEVAD3DoGwQ/+CLDYM4jjcgCbIFVxP38eWbTFqS8+L7enCG5yVL4ws2gGsZzSY08ILi
         FO8wSBBwxnZ9zV74cPNn8EcocFuhEQUEKOtfHUCIjig9beuNICEzxyaTRS7agi3iHv1t
         82sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733139415; x=1733744215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6QzxVLWRzRH/qOa9cOwOHFOV2Etnv6DT+rOyPz2/6k=;
        b=rGHS9kE30LzV4Sfpr40+h5lplxMmntIZCVXsBjVhL0cuW5OF+aWKURnB8Mb3dAeD1n
         AcvocL6UG3L05vmmAaCkQevl7W1dTOSuIO1eRcWdL0O4CoiwCerJH8wn2THpnNcI3YP3
         HZfcq6uGwZu58JBmVCptweikUVdrFscUKVTv/UcStaaaec23Hk+96y3ZepgSwSfJzEiO
         gng/hDGcuUGjlOqkZgRs2mYTS5aPeahp8hoIperrNKUwM6Qefszlv1t3NJ5M4TiJ0Lgg
         DsO4eDk2r8lNdOsmomX06cg1JAQFihhE2EGDrRgA57Yr+5ae5qKxuSYHcy8mnCctz1qJ
         oXkw==
X-Forwarded-Encrypted: i=1; AJvYcCXmHtp1lTq+j/Puv80+EXhFdntcwbIviNtIBDVvwnBIs8x1DJk4Bod/TNpLFZaPkXLaHG7QkU71UjEaVhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOg0EpLsew8RByZkZ79v2k1T+qOOAeoEGxU23pJSt6KFXahTLf
	W2BAQLyMYRzcxsfFKUyrIbdBSqGiJJfVAGhCCQDZ944W2L0avHCU54hrhdfEKDs=
X-Gm-Gg: ASbGncscz5KVQIh1ELMqERTAcN5DM6giuzVBh6SJCDUG3L5vKjpx/eXYPNLPTGOyaAt
	4+5ETk/fudYvkl6puUCZAPUWvA3tfx3a6H8lXifqlPr+FYK8ij6yBKp4EWa3pQtX0sk17nEwpQN
	ADbsX33fNB7NpjA7cyIYdS6RvYKCIhSjeCL+0mIjkFBIehPETQfu55CnLWQ3IA5FI2+9SO5sUgb
	KSd7xCX1W4XZqQbt0805Xp7D7DT65C/zSSknafioRHQpixLG1HJ/LFWOTb3LEAgL6XApqH1qWbp
	6/2B
X-Google-Smtp-Source: AGHT+IHDatiBRoIWwmUQ8rVBdMNdL4Mcz8nzQA/dLpj0wUKVfFU1d2TbucDXr8tjCjv/lds2UQqKAg==
X-Received: by 2002:a05:600c:3546:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-434a9de78d0mr187356325e9.22.1733139415315;
        Mon, 02 Dec 2024 03:36:55 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dd99504csm10275406f8f.85.2024.12.02.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:36:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	=?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kiseok Jo <kiseok.jo@irondevice.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Igor Prusov <ivprusov@salutedevices.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon,  2 Dec 2024 12:36:41 +0100
Message-ID: <20241202113641.1003836-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Bswv2ShtZ15EuEQneXOzrttn0rUwfA/DlAUnJf4MQAQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnTZvJNx/F0I5Qb9qkzsGuYkyoo72y5wqfySfJ5 7IJSHQeUR2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ02byQAKCRCPgPtYfRL+ TnClB/9XFZJTTFfAaG9fQkpSBU9HElltsdBYGA7AOiTCGNvpZR1ZwTeF+imbmJ4GKZqQl9xq6qg 4Q/rfLb8DPw7o95P6hG9TxWRJ36Cgr2xR2Ox8kKe+M/Bu8AxVTOQTYeiWURC91JCJKmpSVY4fK9 7XBPHeQJJKHyHQ0DgqDV5QdVTwncw5l0nhDcWicsGKQdwcpfaDHlICCpDbaK+zjWohRTpcCb0jY bf16wDBqXGRwOJFDEbi91nCfEL4YV1WbjX54pA9u78NuU+zjvAGKcyaGjfe4Wzxe0tT2LYoUTUS GeRPMD7CtJ0R4t4QvZ1zVID44/6vQywEuTf2RY8AYFeWR5nD
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is the third iteration of this patch (after

ba2a2c378ada ("ASoC: codecs: Drop explicit initialization of struct i2c_device_id::driver_data to 0")
6f9faf1410fe ("ASoC: codecs: Drop explicit initialization of struct i2c_device_id::driver_data to 0")

these unused zeros seem to repopup even though in the mean time most
templates should be fine.

Best regards
Uwe

 sound/soc/codecs/cs42l84.c | 2 +-
 sound/soc/codecs/es8323.c  | 2 +-
 sound/soc/codecs/ntp8835.c | 2 +-
 sound/soc/codecs/ntp8918.c | 2 +-
 sound/soc/codecs/sma1307.c | 4 ++--
 sound/soc/codecs/uda1342.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
index 17d5c96e334d..88cf3c03986e 100644
--- a/sound/soc/codecs/cs42l84.c
+++ b/sound/soc/codecs/cs42l84.c
@@ -1087,7 +1087,7 @@ static const struct of_device_id cs42l84_of_match[] = {
 MODULE_DEVICE_TABLE(of, cs42l84_of_match);
 
 static const struct i2c_device_id cs42l84_id[] = {
-	{"cs42l84", 0},
+	{ "cs42l84" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, cs42l84_id);
diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index 6f4fa36ea34d..a9822998199f 100644
--- a/sound/soc/codecs/es8323.c
+++ b/sound/soc/codecs/es8323.c
@@ -758,7 +758,7 @@ static int es8323_i2c_probe(struct i2c_client *i2c_client)
 }
 
 static const struct i2c_device_id es8323_i2c_id[] = {
-	{ "es8323", 0 },
+	{ "es8323" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, es8323_i2c_id);
diff --git a/sound/soc/codecs/ntp8835.c b/sound/soc/codecs/ntp8835.c
index 796e1410496f..2cc4c6395f55 100644
--- a/sound/soc/codecs/ntp8835.c
+++ b/sound/soc/codecs/ntp8835.c
@@ -454,7 +454,7 @@ static int ntp8835_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ntp8835_i2c_id[] = {
-	{ "ntp8835", 0 },
+	{ "ntp8835" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ntp8835_i2c_id);
diff --git a/sound/soc/codecs/ntp8918.c b/sound/soc/codecs/ntp8918.c
index 0493ab6acbe4..a332893fc51d 100644
--- a/sound/soc/codecs/ntp8918.c
+++ b/sound/soc/codecs/ntp8918.c
@@ -371,7 +371,7 @@ static int ntp8918_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ntp8918_i2c_id[] = {
-	{ "ntp8918", 0 },
+	{ "ntp8918" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ntp8918_i2c_id);
diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index f2cea6186d98..480bcea48541 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -2011,8 +2011,8 @@ static void sma1307_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sma1307_i2c_id[] = {
-	{ "sma1307a", 0 },
-	{ "sma1307aq", 0 },
+	{ "sma1307a" },
+	{ "sma1307aq" },
 	{ }
 };
 
diff --git a/sound/soc/codecs/uda1342.c b/sound/soc/codecs/uda1342.c
index 3d49a7869948..b0b29012842d 100644
--- a/sound/soc/codecs/uda1342.c
+++ b/sound/soc/codecs/uda1342.c
@@ -319,7 +319,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(uda1342_pm_ops,
 				 uda1342_suspend, uda1342_resume, NULL);
 
 static const struct i2c_device_id uda1342_i2c_id[] = {
-	 { "uda1342", 0 },
+	 { "uda1342" },
 	 { }
 };
 MODULE_DEVICE_TABLE(i2c, uda1342_i2c_id);

base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.45.2


