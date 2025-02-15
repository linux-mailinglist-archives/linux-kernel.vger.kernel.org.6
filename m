Return-Path: <linux-kernel+bounces-515833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9457DA3697D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5787D1716EC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D754C92;
	Sat, 15 Feb 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNFZoo+X"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634B1A316D;
	Sat, 15 Feb 2025 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577960; cv=none; b=KYPxj86p8f06A74roQ3KrP5fRijiaRmnZhZP5IX3fNmMrf4Gkjd2hV61YYJnfJNG07HWjHiIBGUPy4KarD74afb/cVffUJsHfhe2l/Kr2/DAuL85zb+XYGC32i9pQSsaJN4B5rkJB4nPXHv/AoRswi1g4VB0bpylEnpzViJxahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577960; c=relaxed/simple;
	bh=yRGOaXntFcAUP7G8Ig5QNnIqk9YZXl0nfFSHyW0Mwt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svWCw4ysgc/8p/ZAMLn5gG2s5VonW4nFJdWZ2Vu4LPwfE2fadFtzhNTOEi5MDpgOOrIlmD358gmfp40mJLRPjuQhXhdxxGF2k78IR4m3JSindb8PxMM+V7eCqBV0RjDchi04ddcqa8QAdORdE1Czzh/I069zv/PT+T8bO7p6RXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNFZoo+X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e83d65e5so35559005ad.1;
        Fri, 14 Feb 2025 16:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577958; x=1740182758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvcPqQygxLwJKAjZAsvRvzstw7HN+nfaJbAbMMQ2hVQ=;
        b=ZNFZoo+XJe9DtMsuohok1RkldXCjv2B7UKVir655soDC0+AvxFXvwOS9BffUvefCHf
         6PFUwGcIg7ILSN4hVVXalmfKQ0uYCBa5E4MgG5ULez5LxqSfZB5ulEyUvUXMueyhB/f1
         SyFaBHH8/5yfIwrSqvjx+R1g8mBBGFGGCLCHoSml3iu3azHveBGTQFyb0Ilj9v+kmdGK
         BlGhb/8C470rpZq02V6ntOfOCBAUwCR9EDhHDtWjFwf1o2XINXigpZ2TXVMbmxK+iyF5
         S+XE4HzKEGWIERwgzhpl+ZAxD6Q5u0Gi3lZDEtQtk+Ry3zEL7wa7HjLycjbAT+IB7G8D
         pNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577958; x=1740182758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvcPqQygxLwJKAjZAsvRvzstw7HN+nfaJbAbMMQ2hVQ=;
        b=OquDC0+BGvzeGm79s4Ac2/f3jkuIT8QE69jTSHil6M6xbaAwwOcWk4ewRjJmMPhINh
         64P7JsA3WiqZw6Gq7tvbi2Klm6V7Z0A9f6YYe/3P+HkdnqYFPMNA8zMxDpqJH4btypXq
         A8Lm7TR1U/Y9CE7CaeQk+/nMHrxhIH0eERnHP1+p/rIPmGuHflZdwFjoPmClWZPSxzRH
         6CSxDx8wAmH6PrIRj3UZzlzaQvx1xxFpIZ4gDccqk+qVf8rcHSoV7HFGJ7OeFUvVntgZ
         0YMXHABk662ga7v3n5z4bvPJwAis2uE9kchTNMGACSwSmPav35SeNwxrS0notTRQJpqx
         qB/w==
X-Forwarded-Encrypted: i=1; AJvYcCWb+zr6dA8A9aOUio2Xn1aQCeQtucygv+qjLC8CtWknwTYVeXKO+t7jlJitQoftaa2fdSLkRPZIP2Lz@vger.kernel.org, AJvYcCX9jR8feTu+omBqxNXGz/KjymFVvmaWK78nHipAlCP/1hIO3cfJpIgpZfjy8Nj+1gU/Px588K6qvEG8qBW2@vger.kernel.org, AJvYcCXviND1Tsf1cgG9i0PmCnRjKB867WqDpcBX0Jmq2wOs7QHJyfgyDKKN8FOPfp5p5I7zapBJydrE9+uE6TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzecU6w/V6FeBXj3sIUZbiziFQ4wuGVzSGh+rsqzdtkBGmR5iPY
	t/q/DmGRd5S/U8J4JrdeCkxMSUnVLEHuM/VGu9ykIj8lBsmCkB04
X-Gm-Gg: ASbGncvm6wS3YgQA6dyKv8wRy8Hnuj1uZvdBiqUA1iONEsJRfzgPLjK+564mpTvnb7e
	Nbsj1MtD0KaVcuvpXrrqbsVq9VvkC50zIFDSOIit+miAZXEHlBUyAKHss+UfDC/jAYWniRs+zfb
	KNg/u4zDku0u2m/SyfC80M9/rG90H0XiqdAqE49zKvBclS5Ch5yhBudPDov7bYXstaoyzBJIMwe
	GJnizvAFcIaUQpX4yaUJqxrB6WElh2UGGGTdtqisnffemkdX2FnSlAeAJEwM/N+gC0/VEnxuLU1
	KrWinigsrmdxlIPm+i3zs6DWlizt7CdkthGoNmIhHVL+t6llCPzybSbNxVG/GAznod7oON8m4C0
	GEjJlYgwuvg==
X-Google-Smtp-Source: AGHT+IFRv69gAw2fRJoZG3kyG7EwNhQXkCZqOctEOFul9MREID8wtj+8ZoKObs4bUkkFVHzmedsfJw==
X-Received: by 2002:a17:903:22d2:b0:220:f7a6:a02b with SMTP id d9443c01a7336-2210406aac0mr17325665ad.30.1739577958269;
        Fri, 14 Feb 2025 16:05:58 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:57 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:57 +1000
Subject: [PATCH 24/27] ASoC: tas2770: Support setting the PDM TX slot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-24-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5008;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=7Dfog4ukmvCbrAJFblLGt8FQ60ffyBvdFlYgVThiPWM=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb+7o3vA5pUraouFG4qtz9YIaGl+X+krMl+eYpPwm5
 ON9++jbHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAExkXSIjw7GJstcfpPeua/9i
 9rBcTYOpY8a9nsA98tcXhiqGS7MJFzMy/DXiOfJe7LDhN5/WKybSQh57YnMvcub9nKU8pT+FbZ8
 iIwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

We don't actually support configuring the PDM input right now. Rather,
this is useful as a hack.

On Apple Silicon machines, amps are split between two I2S buses which
are logically ANDed internally at the SoC. Odd and even slot groups are
driven by amps on either bus respectively. Since the signals are ANDed,
unused slot groups must be driven as zero to avoid corrupting the data
from the other side.

On most recent machines (TAS2764-based), this is accomplished using the
"SDOUT zero mask" feature of that chip. Unfortunately, TAS2770 does not
support this. It does support zeroing out *all* unused slots, which
works well for machines with a single amp per I2S bus. That is all,
except one.

The 13" M1 MacBook Pro is the only machine using TAS2770 and two amps
per I2S bus:

L Bus: SPK0I SPK0V Hi-Z  Hi-Z  SPK2I SPK2V Hi-Z  Hi-Z
R Bus: Hi-Z  Hi-Z  SPK1I SPK2V Hi-Z  Hi-Z  SPK3I SPK3V

To ensure uncorrupted data, we need to force all the Hi-Z periods to
zero. We cannot use the "force all zero" feature, as that would cause a
bus conflict between both amps. We can use the pull-down feature, but
that leaves a few bits of garbage on the trailing edge of the speaker
data, since the pull-down is weak.

This is where the PDM transmit feature comes in. With PDM grounded and
disabled (the default state), the PDM slot is transmitted as all zeroes.
We can use that to force a zero 16-bit slot after the voltage data for
each speaker, cleaning it up. Then the pull-down ensures the line stays
low for the subsequent slot:

L Bus: SPK0I SPK0V PDM0  PulDn SPK2I SPK2V PDM0  PulDn
R Bus: PDM0  PulDn SPK1I SPK2V PDM0  PulDn SPK3I SPK3V

Yes, this is a horrible hack, but it beats adding dummy slots that would
be visible to the userspace capture side. There may be some other way to
fix the logical AND behavior on the MCA side... that would make this
unnecessary.

("How does Apple deal with this"? - they don't, macOS does not use
IVSENSE on TAS2770 machines even though it's physically wired up,
but we want to do so on Linux.)

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 25 +++++++++++++++++++++++++
 sound/soc/codecs/tas2770.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 7ac7ccb32b4db2050a8543b950a9872b7551845b..555642d5c53533d9959314f0384c4dfe91ca799b 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -247,6 +247,19 @@ static int tas2770_set_ivsense_transmit(struct tas2770_priv *tas2770,
 	return 0;
 }
 
+static int tas2770_set_pdm_transmit(struct tas2770_priv *tas2770, int slot)
+{
+	struct snd_soc_component *component = tas2770->component;
+	int ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG7,
+					    TAS2770_TDM_CFG_REG7_PDM_MASK |
+					    TAS2770_TDM_CFG_REG7_50_MASK,
+					    TAS2770_TDM_CFG_REG7_PDM_ENABLE |
+					    slot);
+	return ret;
+}
+
 static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 {
 	int ret;
@@ -602,6 +615,13 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	if (tas2770->pdm_slot != -1) {
+		ret = tas2770_set_pdm_transmit(tas2770, tas2770->pdm_slot);
+
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
 					    TAS2770_TDM_CFG_REG4_TX_FILL,
 					    tas2770->sdout_zfill ? 0 :
@@ -769,6 +789,11 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		tas2770->v_sense_slot = -1;
 	}
 
+	rc = fwnode_property_read_u32(dev->fwnode, "ti,pdm-slot-no",
+				      &tas2770->pdm_slot);
+	if (rc)
+		tas2770->pdm_slot = -1;
+
 	tas2770->sdout_pd = fwnode_property_read_bool(dev->fwnode, "ti,sdout-pull-down");
 	tas2770->sdout_zfill = fwnode_property_read_bool(dev->fwnode, "ti,sdout-zero-fill");
 
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index 2c2cd777f4bcba8ca91f79ccdfd9f159df5d3a97..b309d19c58e1daff980025fbced506a1a744559a 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -85,6 +85,11 @@
 #define TAS2770_TDM_CFG_REG6_ISNS_MASK  BIT(6)
 #define TAS2770_TDM_CFG_REG6_ISNS_ENABLE  BIT(6)
 #define TAS2770_TDM_CFG_REG6_50_MASK  GENMASK(5, 0)
+    /* TDM Configuration Reg10 */
+#define TAS2770_TDM_CFG_REG7  TAS2770_REG(0X0, 0x11)
+#define TAS2770_TDM_CFG_REG7_PDM_MASK  BIT(6)
+#define TAS2770_TDM_CFG_REG7_PDM_ENABLE  BIT(6)
+#define TAS2770_TDM_CFG_REG7_50_MASK	GENMASK(5, 0)
     /* Brown Out Prevention Reg0 */
 #define TAS2770_BO_PRV_REG0  TAS2770_REG(0X0, 0x1B)
     /* Interrupt MASK Reg0 */
@@ -150,6 +155,7 @@ struct tas2770_priv {
 	struct device *dev;
 	int v_sense_slot;
 	int i_sense_slot;
+	int pdm_slot;
 	bool sdout_pd;
 	bool sdout_zfill;
 	bool dac_powered;

-- 
2.48.1


