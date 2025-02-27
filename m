Return-Path: <linux-kernel+bounces-536240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A370A47D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F4B1892FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5923534D;
	Thu, 27 Feb 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHrKWDMH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB422F38B;
	Thu, 27 Feb 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658204; cv=none; b=PPdzsQjff57MsLT4BFIgI1/R2AhssHOZWhI2F+iDQyGR7m2nilFJLRpEYTpKxMMdn/PIFPQvgr0JBUaCCGAOLIyD143ISdZOtQRRtbasWcbXo+jmukfPdMKpt48sgvYjYJLfnel9TATF5yq3wV//Ix1tah7gin/3Ptj0dGn3EGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658204; c=relaxed/simple;
	bh=VAlMGbLBKi4xU+F696Y6zd+wEM/gtuswNpD/DqJM1CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VV1EOFq6aPy9TJpkaRMyK6mC2GEOGhCX54cNqlXejjoTWFsjyyiy7mRLbJm7FXTNlvWpGo3LtxDNTcNLKfjEZ1oKKQAD3s8IBBIsI5aUI5gaA2Jb1dOALf6uQfyCCME+PvADXtrQ/8tmJCuEV5yhdeDiqJdGM8d5BC6bUTBMRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHrKWDMH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22334203781so26117365ad.0;
        Thu, 27 Feb 2025 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658202; x=1741263002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5ry6J/NoVdSnpNYCNQjATClf2ygTLOYGGyh+loV86o=;
        b=kHrKWDMHY62MtyxPVRK7qd/MBML1tD5HNEZUaDN0lHk8BT6/72GVjBUsuON3knEFIb
         uDrAZaiQ+/+/q91w2uBWihbwZCL6C5vwers9NMmgfRv5FcsEblc+JN3TtYRT7hru/vCB
         A6h8xvlSuYP26SiLmKsfWPpKe6e6Z8I+FaXWPQuYMbxO9vINcdvcdkMWEomgUFBKRF3t
         xddNmDVyywew/VMflS9QYe5WR1DEpHU3oZ475G+T44xqcloDHI/Z1xdy+dak7HzqhoPf
         R6AlVHeCSzOz/lYnGShwLYQAnMlebRQ6HjghDjpgxytJJSVwM51FBJkIYhA0auvDajXz
         ikLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658202; x=1741263002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5ry6J/NoVdSnpNYCNQjATClf2ygTLOYGGyh+loV86o=;
        b=pCvHwRpg84HTn9hyh8Lwaz3fiVks9wlVGDA9E77rb7IGHUCCciR10TFGr7Lg9UW9Ll
         nIZUdrHa5MEMGyGvPixFIQv4RFaEAc7/NbOMduKMBxFEvap24E3T5ebwuVJ2Uer3MtH1
         t+/RWEG6hWMJTBjutZPyu16euOwjyzo7l6suXvUeIR/zxshGjPzYk6nAD9GJH2CjsAB/
         do4ZwAQ5W4EqtXUWGsp5eO9nQXAt/4gLEZvt+9IswGbiHcJQbQ3cR8y2IVMzKVMUtOQ9
         uUJRcnlr721U8wAcqaRcXYURxo8wGD11cbHVhTRXCTLWps1HgYBykFxbQUujMojziri8
         efVg==
X-Forwarded-Encrypted: i=1; AJvYcCVHUFc5hBacay385PRwAJfTqTXIhssslaSgVzjJv8DiCZ6JTPmuRq3zkOQUFWZhBfPa9MXlPhyYXx0KDmg=@vger.kernel.org, AJvYcCVOsWXQtOxGJTdJc8Z/ul/vrwVz+yFd6v7tou1bvGyG2uHZAIbcfo9IXxInrhtc/wpHx64MPi666Ngr@vger.kernel.org, AJvYcCVoupGJhIDPxQWb4tD62py48InCRRkhtdGAPku7e9JtKOwBoGfSor5FyUuoVinu15sc+XsrY0vCoqRuXN8=@vger.kernel.org, AJvYcCVpLcpzkkmIv6ajDdrdNlIfDqEfPy1KE47sj6AweOGnY6c9hcCucVTXNCWYJZrYyWkiz6Z6CmKkrqYDBoOe@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDmTuqGRvlkEiF4EtYC08+GARHgB5rRrk+3zsYYqoKwxVRG+L
	mWTMj4307FrdR8KDHf//CsyHpj9pEutRitC96p7xaQxcoM32hfCo
X-Gm-Gg: ASbGncs9QrR1jkvpg72UBkrXYy8qDtpQ3Ut/wnPS4vwwR7STL3E2C02ITbRPq7oggn5
	1nrL3QLlXNHN0YVzSc8YfNdZWYQRjyoiyY44IvKjFVIcrN5CCuE2hfT+aVmKgMA+njrAZlRRYtH
	uT3iIW1NRLJ7i8oiuoIRnNN+sPd9Q3+1xtRf4Z9QK5qsB+knW8uF4AoD6Xn7GuH7whx3uPCeukp
	i6caVyi0uO9d1BZIDBSPMvsjDXLrFTPuk8BC4p6HUpQEqM1UyamL76mdp9BDxVCLiNzUsaa6tip
	6XHLS+Z/dggeAk/Tddv2K3w/lgng3/gAMEU7KQ/Wf3zj75YNzqY7rDDfnSnSvGHiiEZkJXpandT
	4z+H4iHCkwkbNATTTxssB
X-Google-Smtp-Source: AGHT+IELA2MVEJT24EW2bxG3k6ZlSSpQ5TmMYRzmcOjW8RmSRjowq6jcIcch4pPSi6eG4EqbV3bfRg==
X-Received: by 2002:a05:6a20:8402:b0:1ee:b5f4:b1d7 with SMTP id adf61e73a8af0-1f2e387ef46mr4574714637.7.1740658202396;
        Thu, 27 Feb 2025 04:10:02 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:02 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:36 +1000
Subject: [PATCH v3 09/20] ASoC: tas2764: Configure zeroing of SDOUT slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-9-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=tMEwKfdUcN1GIbtYuD0/lRExutgObIXbnosPkubAYYI=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk91JD2dOGkue/LVHa91VHiZt06qVls9aaqbZ73MP
 //+LZsjO0pZGMS4GGTFFFk2NAl5zDZiu9kvUrkXZg4rE8gQBi5OAZjI9hxGhua/CRt//fpdmu7u
 N/nek1tPplZciP4VuknN+dqShJW/Aw4w/LOxSu5c9p7jUVWk1azr3Zd/PM+f1ZDL83mD4Z+Uw5m
 7pVkB
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

The codec has an option to zero out certain TDM slots on its SDOUT
output according to a preconfigured mask (otherwise the output is, for
the duration of unused slots, in a Hi-Z state).

Since the programmed value is dependent on how the chip is implemented
on a given board, configure this feature based on a mask read from the
specific codec's Devicetree node.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/tas2764.h | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 49b73b74b2d9dd6d09747cabc2b00519c549775d..f33ac89ffc598c39f3a7e0d620724098ca5bc3d3 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -40,6 +40,7 @@ struct tas2764_priv {
 
 	int v_sense_slot;
 	int i_sense_slot;
+	u32 sdout_zero_mask;
 
 	bool dac_powered;
 	bool unmuted;
@@ -601,6 +602,23 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	if (tas2764->sdout_zero_mask) {
+		for (i = 0; i < 4; i++) {
+			ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
+						      (tas2764->sdout_zero_mask >> (i * 8)) & 0xff);
+
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
+						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
+						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
+
+		if (ret < 0)
+			return ret;
+	}
+
 	switch (tas2764->devid) {
 	case DEVID_SN012776:
 		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
@@ -749,6 +767,11 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
 	if (ret)
 		tas2764->v_sense_slot = 2;
 
+	ret = fwnode_property_read_u32(dev->fwnode, "ti,sdout-force-zero-mask",
+				       &tas2764->sdout_zero_mask);
+	if (ret)
+		tas2764->sdout_zero_mask = 0;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 3251dc0106e07862dd69efd69fa0e40c3858ecb7..4cf0f7f112d6c3002203fa32e900efd640ef3f22 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -123,4 +123,15 @@
 
 #define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
 
+#define TAS2764_SDOUT_HIZ_1		TAS2764_REG(0x1, 0x3d)
+#define TAS2764_SDOUT_HIZ_2		TAS2764_REG(0x1, 0x3e)
+#define TAS2764_SDOUT_HIZ_3		TAS2764_REG(0x1, 0x3f)
+#define TAS2764_SDOUT_HIZ_4		TAS2764_REG(0x1, 0x40)
+#define TAS2764_SDOUT_HIZ_5		TAS2764_REG(0x1, 0x41)
+#define TAS2764_SDOUT_HIZ_6		TAS2764_REG(0x1, 0x42)
+#define TAS2764_SDOUT_HIZ_7		TAS2764_REG(0x1, 0x43)
+#define TAS2764_SDOUT_HIZ_8		TAS2764_REG(0x1, 0x44)
+#define TAS2764_SDOUT_HIZ_9		TAS2764_REG(0x1, 0x45)
+#define TAS2764_SDOUT_HIZ_9_FORCE_0_EN	BIT(7)
+
 #endif /* __TAS2764__ */

-- 
2.48.1


