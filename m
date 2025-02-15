Return-Path: <linux-kernel+bounces-515820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE63AA36967
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166C91716F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD445C18;
	Sat, 15 Feb 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIdz2gSB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF63C14;
	Sat, 15 Feb 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577871; cv=none; b=sWQMTQ0f59TDT+xp7cJgsB4Y9CQiNeELsd6E+siBBrhp7gXc9jkREaJZkw77N2h0Ldxp7cuF7XLUSFS8Vlze+WyEeWc8ndJ/wGWjCUkFEuPE/IRA1NTj6swAI0ojdGHllNGZmYPQhQEQQ9WCQJ/bpfm4Ebvn6n51AkkGS0EVH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577871; c=relaxed/simple;
	bh=pIT8fa7AikE5hQoNF7uQQTf0quqyppsCvMu4hB34kEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGx76S7UQehVx8jA5j27Rx+i2+9C5n5bDON3qMrd3s2JIJIuqjDhiUEB2L/oKsLaVQBPVvdI5KlxP0XdJb+ymyDjp5Av1Igm1hw/g0jMJPny5VNWD4u9hC+uon21M8IEJCKVTvEzCV7ekHAlrUuaoYR9rdDDIh8rJ2/4LCMKnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIdz2gSB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220f048c038so21035605ad.2;
        Fri, 14 Feb 2025 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577869; x=1740182669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCWqE63NtboLaDF6y6v1iT2JtwVZeKCpz8kd6RHpgE8=;
        b=lIdz2gSBZZjpukafVHD+RZxBx+nengMzR8VAUiR2jR4+dSWRdxSiJjmUGpnJZuVphf
         COkq973InQjf55omG3T8HdpgtK/aNCq9OMwa0yF6o0SIiq9jkbBYrqET58n10dGnEqjI
         pi2e34PB1g8+80Eul+dFiHe/5pfzB39D8nuOEqp2Kq/KOK4xxvsgWdWrTGbs5Q//HF/Z
         Uaq1Z01kRxi36J3JbWLCJugHdJG8qwqG3fqZGQahZR4OtBH+Q2lbZlK/is9EjbBffhZ1
         H/r5q7uN2gsmWsqbN0A+qIS5HM20mNtElvYa6NeLEIFyd0uCOxCL1nngKJwhdNGEnciE
         bVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577869; x=1740182669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCWqE63NtboLaDF6y6v1iT2JtwVZeKCpz8kd6RHpgE8=;
        b=X3D28vIuKnH9kmgkjwRBQ16CHtRvh6CZZivfPekXbfFPjvpQELhY7WNxgMi8/QJ4rB
         4mZtrxpvsqmCDP+KZuPCzF8klVKGgxzu0fc+PFn73q5gHEWiglI7G+ccCWIDN4ku2Yfc
         hFWf5iSX12Lg4ys9RpeO38pOALVgQ/aq8zDa3FzqO9jkPQKQ1rmB8y/iLpnULRQBjVWY
         DxVMORikMQ4g4q2iXd+IuwzfNbIf7Yij2NVPP19ff56dOCC+6OjCiC0ZVP3EbWeuyNTq
         lhcZNX9U9EkMduwLxmyBU7/dz3qFPa67ir89ZSFVcfM6QD7Uzk9w1orgLIToRAkRuPbO
         DN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPUDyawNj8Sf8P8nu9mgVJ1X8sXoq6PvjBC2+E/z1X06TeHrEXbUUxlbaqHfhSW154U03YjkxicJX4@vger.kernel.org, AJvYcCUYwpaB3uEZUDLjjDfm6CW7+nbK62KLBZs/YxRdFRDC8FhqR6RLnYtz9ZlsdbiV0LvBAuDfjZBg+CMehVE2@vger.kernel.org, AJvYcCX2swYCcuIkVW2jJTZa1JwcXnS9MQ/kK78+F4jzm8vuyarMgftUPcKsoKM3CCXrQ4KrIiSo3XOCs10brrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoEWTybTz5FVAynqCWF7klriLNmnwJIuvd5LMz4+Fskk30RVS
	Wehtm+ja5ltYIP4mfOiyiyUkLy5JX6NBTeV/ONk/ncFUpfVRlKJF
X-Gm-Gg: ASbGncu4oAPKYVFv2hQ8y4AEN0CBHvSMY2Zh81b4Q8EOcFX0ltt593G63R8Bb5HLy7L
	Dn4NRNGKTli2qC/hdrMhXMxFH5WrIMQSLIxL9kozfNSkbnnP8W8I3z5Gq4sTTF+gRx+7eg8YxxK
	q2ErT+TwEW0B4HAo6FeBeimwvMLFAV1hcV+VHh6MMsIemoqvvffZbcqSqB9jf+VQhSPom/8xPMG
	IeFcVIkJuR/TiyGd2pxz+sbeuHD7eFx3bZiSHJqa9jHP3NUZ+kzweVezIptA3jjyLiBXj2YXPDi
	vRyDtI3iCVWb8urmmh1DlVBC1YkUU0fklkMV7cXnL1q/xs492iLHLqu9so3AVVRabH/P3H7iIie
	zoKle+AGWlg==
X-Google-Smtp-Source: AGHT+IFzYjLPU53Ebp4mx4orGbzMQ0X4WS3WUntmgSSj9qzkpka8VWRb3IebUhrznWCYrQjGNWVL5g==
X-Received: by 2002:a17:902:ecc6:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-221040bf7e5mr16193365ad.46.1739577869208;
        Fri, 14 Feb 2025 16:04:29 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:28 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:44 +1000
Subject: [PATCH 11/27] ASoC: tas2770: Export 'die_temp' to sysfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-11-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3064;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=fru2c8FvUJxKC1tULT0SmQ2VuwwPHfRZtkjpK3J6OcE=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb25TL/T4fO240YGOXIeakAqmtyxG52YdWzNF+IOs5
 EKzrJ7EjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACYSrsDw32en6bkDQfkXdl1W
 uMa6QPe0w04jR965F74daG7by+DxIo6R4Sfjm+mG0kKHNuQ2LZ1YFnIjMPz/vUOpSWd/CCTPXXX
 OkhEA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Export a file for the readout of die temperature measurements.
As per the datasheet, the temperature can be calculated by
dividing the register value by 16 and then subtracting 93.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 35a4d5a4a3e0cf4f71f81fd59f44f075c59cdbc1..9f3588ec117bb8ed0a6f2bbe5d7dc422862f052b 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -20,6 +20,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -491,6 +492,51 @@ static struct snd_soc_dai_driver tas2770_dai_driver[] = {
 	},
 };
 
+static int tas2770_read_die_temp(struct tas2770_priv *tas2770, int *result)
+{
+	int ret, reading;
+
+	ret = snd_soc_component_read(tas2770->component, TAS2770_TEMP_MSB);
+	if (ret < 0)
+		return ret;
+	reading = ret << 4;
+
+	ret = snd_soc_component_read(tas2770->component, TAS2770_TEMP_LSB);
+	if (ret < 0)
+		return ret;
+	reading |= ret >> 4;
+
+	/*
+	 * As per datasheet: divide register by 16 and subtract 93. We don't
+	 * want to divide just yet though.
+	 */
+	*result = reading - (93 * 16);
+	return 0;
+}
+
+static ssize_t die_temp_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct tas2770_priv *tas2770 = i2c_get_clientdata(to_i2c_client(dev));
+	int ret, temp;
+
+	ret = tas2770_read_die_temp(tas2770, &temp);
+
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d.%03d C\n", temp / 16,
+			  (temp * 1000 / 16) % 1000);
+}
+
+static DEVICE_ATTR_RO(die_temp);
+
+static struct attribute *tas2770_sysfs_attrs[] = {
+	&dev_attr_die_temp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(tas2770_sysfs);
+
 static const struct regmap_config tas2770_i2c_regmap;
 
 static int tas2770_codec_probe(struct snd_soc_component *component)
@@ -517,9 +563,19 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = sysfs_create_groups(&component->dev->kobj, tas2770_sysfs_groups);
+
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
+static void tas2770_codec_remove(struct snd_soc_component *component)
+{
+	sysfs_remove_groups(&component->dev->kobj, tas2770_sysfs_groups);
+}
+
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
 static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
 
@@ -532,6 +588,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 
 static const struct snd_soc_component_driver soc_component_driver_tas2770 = {
 	.probe			= tas2770_codec_probe,
+	.remove			= tas2770_codec_remove,
 	.suspend		= tas2770_codec_suspend,
 	.resume			= tas2770_codec_resume,
 	.controls		= tas2770_snd_controls,

-- 
2.48.1


