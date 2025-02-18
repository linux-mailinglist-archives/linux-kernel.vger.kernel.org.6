Return-Path: <linux-kernel+bounces-518899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB9A395C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C5757A02F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC59233129;
	Tue, 18 Feb 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg+rPWum"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08A23C8D3;
	Tue, 18 Feb 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867967; cv=none; b=rbnv3EEvvo5jTwOjeh7vlCttzwCKhS7nRUOjMzwL/WXI6yUcxv60TJzAj4RxEWVS2gyPHdlIefZ1QypfGEqyB+/9Ld0hJdWs1/nbGOqgqH+k0KQsNSj8gUR2j7Hf5+13M4H/VRa3h+i7oiKStZ28fZmGDuTk84kFI2YKh0bKQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867967; c=relaxed/simple;
	bh=8ff1GLFJSH1XFuJHxqTqo2n8oq9C1G7biNgZMRb+Sko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEHP0uyXbflQ7SUIAbPZQ3fYGAhWkkck2H5GuqDbdsrJqtfoSXpuzmvB+vsrETPqe6Yd4Ma407c65XR6a3cFU1u7CSr6lQ7uh908iQ8GAImMYZWOTOuDAAQQDKwOdQ0O6Z5FPPubUQHLItSXgDkj1tzp02b1uRBFs6HZKj2IQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg+rPWum; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d132f16dso74006595ad.0;
        Tue, 18 Feb 2025 00:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867965; x=1740472765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43Tky4Akx6Ximp7XJZMHWPUNscdFFs1EIfbFGCX/210=;
        b=Yg+rPWum1OwSMc8QMncI2YqWfD6LAVbJ4Qvn48Pi7+AklvvjZacpw/snD6dTjN7V2z
         3JpEoRtF3/nDxeJKGOC1tziXpNZaS6FJiJZOACNloGferQN46nqFbOHaRzbaseXzpjVx
         Tj+NYp1jnLL5YyGoeao/8Gx9GHDs/GaFudNJ/jwxkYHjJvxQ+78AEP4VXHYntwv64nZ8
         ZFOMC77libNOw8dDRaQ1Esc6nlrh1VZHtZNSqzJ28sIZUe7swQHDgNwJ9qP7uPhSbDQG
         hGvj2bxSDqbRRakleToDLF6lcJSHXtV/9aMqfimPhlWlcR0gnHICl0q2oRGX+ZzrsDYN
         UJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867965; x=1740472765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43Tky4Akx6Ximp7XJZMHWPUNscdFFs1EIfbFGCX/210=;
        b=d78DArJckSzbJGxWWaVrDTCz7Z6icOzT3b7lm2Qw37jteaKaLidKaFdDy3iyyHAEv3
         VR43t9i38yAXYCHuuusl0t4JdFgGwE2sRjIwOha/i5WGoBDS2PxwWZ0hR41JaQbkZC+3
         hwb8ZaOzC6zIB7XW8ldJHfegYwerz3ImlQCR3x6N4wlpsslmCj7du6msb6efEbcHS+bz
         td2fwZrM9IibT2YLGlnh1cWRrHhRIpMR9RgiGgTPkp+viI4FGs+Asw/Q9mdAOjiIWoPF
         LrDjX8gDThWk9zrkJsFJbXhbSPvFlbdjsQ6tzV60RJksnWMUKSmdyYhxDoZBJ3D/b9ey
         /ppg==
X-Forwarded-Encrypted: i=1; AJvYcCUXbTUH1s9yRjKBxiP0j9VrCFYCQgKWIXJVd5CpthR00L82k/YHHAvBZPoXes+YjsgDfT+IeGNC2r77Dm0T@vger.kernel.org, AJvYcCUwqZMcjoDv1MdFTAwfXg7uTU8SKLmwsCx6VMirl9H4+D4iBUjKmlbg6QbDHNsltvBRMrq6DroCpDgMZL4=@vger.kernel.org, AJvYcCWaAlNBg/tIp4wHvmXpAEz4Cp1UFkHGhjpkTQ7nezqGZZ5Crh6cj5/7ikwWibe1jpG+9Q8SP3OPkowlBAU=@vger.kernel.org, AJvYcCXxiiUX1/hjD9yFqJKPJ3RH+m116yBq7cdqVCsd972m1vSMeAQF2FabClft3jBrPkPcIhZHRQt4v45m@vger.kernel.org
X-Gm-Message-State: AOJu0YyKRoEbOfGcY9iLjMMgaJjz+MEIDE1EKDLxonkMVypyi6lLvHXZ
	nGpIUJoc2ShYNhPVEblmBGcbSfg7cafZE1T5Emhjb/I/eQIfCPcIeHG+x9Ye
X-Gm-Gg: ASbGncvqN+o7OEITN3k+BFlPcVGcwfmuUhZG1xKQZXkEg38nDKcRg7PC/TQ7UQuDiE3
	/zDubBAxAVD2ckkvq4L0hQMpuofYKM9Sos8PH48RTlnOaE9I9j9FHa/+31oDf+i2vcconSXOF19
	i1/sI/uUZktK9uXYUMmO3a3hJsIjq5wbqFX3MB/11PDS4mh5ldSRyeqQ1UL+L5oxFRWgOa/AMCw
	DIXnqpK6m2sv0BH4tPhm5/fCOCFJ5FFoBLDxzUGZJ4qPgYk/Vm2M8Vf5BZlc2HCtvkMngC4pIx7
	8ZOHbyLWjNYffun8XF+f8+OKk/ynHlB7zmTF0U6SJXmniN6HYA2Gh1hFfO/swx49PAWKaPyOoRR
	FpVR0cJITAg==
X-Google-Smtp-Source: AGHT+IHNa++DvBF93IL8ikGwt+GXKPzSaW/MueognJN9Crhshcs/9PQZmE3fXkv/R0Z7oKx/w8ecXQ==
X-Received: by 2002:a05:6a00:198c:b0:730:7885:d902 with SMTP id d2e1a72fcca58-7326144b262mr22648246b3a.0.1739867965144;
        Tue, 18 Feb 2025 00:39:25 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:39:24 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:36:01 +1000
Subject: [PATCH v2 27/29] ASoC: tas2770: Support setting the PDM TX slot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-27-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5050;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Ud6taGhvuu8nz8or2ySRZQRi+fer0UI7LxTM7YQKGiA=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JL9mU7wr1ue+/liBP+BWV4d7359C8+fcOORTs3L5
 H9PJ1ww7yhlYRDjYpAVU2TZ0CTkMduI7Wa/SOVemDmsTCBDGLg4BWAimuyMDFPuxL0SfZmQeoHP
 pvZjtDdjZKHQs7YrSe2rVtuf+fKlYBrD/3r5WRLhf0+uufpcxo9nXchcJU3nhRz2fYkfrLsPe53
 Q5wIA
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

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 25 +++++++++++++++++++++++++
 sound/soc/codecs/tas2770.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 8adb558f9e89988e0decc344502da8226f8ff517..c4a5f4d1ce09a8e68759dd75d532d06d2a7f2d39 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -248,6 +248,19 @@ static int tas2770_set_ivsense_transmit(struct tas2770_priv *tas2770,
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
@@ -658,6 +671,13 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
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
@@ -825,6 +845,11 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
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


