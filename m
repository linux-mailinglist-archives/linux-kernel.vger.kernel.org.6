Return-Path: <linux-kernel+bounces-536235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68BA47D12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D016A8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FA3231CAE;
	Thu, 27 Feb 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU2fr45F"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640C22F145;
	Thu, 27 Feb 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658173; cv=none; b=hSV/KvttDMrOs6Ew0nRp5BjfYgXB3sfgW3uZ0DroMUQUi7kk9bJZXgQHhN9410En4NdqJF462L7vUk78v7VTPu5jG5mROOGNQuVf5/dpsQW2bQtaP4xLt+Ox99k8QKrgTgCvn3D11hSIXIPGnV8EahhtkScMEPYNMr3Sck3sJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658173; c=relaxed/simple;
	bh=y9R3gC4DcFYDFbAgeXOJCoKDJMqg1SlzEiGmhUycXwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCcjwzah84QuxPkG/IaEdqUb7RAR0I0Q+rrs2AXqGEE6GElkMTjG44MOGcuLErqK5KJKnW1P2rCmh+ub70o/n1vE4gu8RYX26n/7IgyjWIswtVD+zt4+OVCapW7i2CA8F1su0lLFSNiUy3sDbaZvw3ysskFpYWymRTb3kvYj+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU2fr45F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22328dca22fso11797225ad.1;
        Thu, 27 Feb 2025 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658171; x=1741262971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeoXHbMNaZZnZxWSox36s26riivTYQEGCI8dhE09lK8=;
        b=EU2fr45Fgi4EMIGdRt5xgDGnbHBiIugqgpozhRMHgpnyerc1fvLB3DSkJuzq1k1aKK
         ZvAEOk6LZkCL+EiF6LivmclE59oQfRNwLph0OzXJUUvsKUmQZ8UljVCMYQL0mbrROpxy
         uuBRxu/DEyUjom9O1wxgV2/xuBdTs1WJeIOE7F0qS0Sl0vwjgs0XKP4gxmOUjY1WvNk6
         6m9IIYTbnuhDwQkCsyCTkzohYnffrR6XEa4framViG5bwqgg8gjSWHUTLtg7iBgF/Y6P
         Xergo1hl48SA0dLh+Mpom4tYNDMGr39IhDWjjNVmh6GZS6C0sRc2hdtrH49SC6CYKJ1m
         bYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658171; x=1741262971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeoXHbMNaZZnZxWSox36s26riivTYQEGCI8dhE09lK8=;
        b=dm53QJ3RgRjJwCTjFal/HphkvVIYsAn2jGtim3xbeyYP0mJJF0pGEVOLPjAr6bV96T
         Si99YImdRpdWK6pskXu86LMkngWl2cjnCBBqpEd3JVmvdAuD6Kd8VOsdnrepscTi+NYs
         WO+CdiuCoEG7GijhIdElYn+HZZzsjQ830EMRJ7CldjoosGvp0bNmvoiMqh6evQQcw1EB
         bg4t1Rh/dIr7D3xr8R9w9wupniT8EIorJ6wD+Vi62FPT+Sf1kjar4BZz0eJ+/vlg6TKq
         p+iRJAlm62qimZJD3CKYFSL7MOrpEEaCqciBazJKIaPWIA4dSsvIl489kNzwY3m+6Jo0
         dDmA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GJBofJtTEMOXapNEjKBlSWv3K90jrYrbiRJi31hGD7yyPa7+OWVpmyILjO4kYtzqbD65t2JcaQg4Pu8=@vger.kernel.org, AJvYcCVpY63GFsVS47LPiv6mNU1HVPR1O5cIezMhSFteHT1ftCGMakVM0FTE97vA9XiF5KTwMwhXX8xc2hNJh4s=@vger.kernel.org, AJvYcCX+BaW8rFyUr42wNwrEXpQRJWZQd3caBA7pFBUKTCc0yidfGtbRiC2R78y1LBeHLU3NwHlNd/nrsmhk@vger.kernel.org, AJvYcCXJvGp0oG4lYtMBvIzcxy2lEmoLkgBY1nKVZLDOPUG74rt5tJJGawIMOhU0SLN36NZoJMf7k2CcyTdqltX9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5XE2d63y0j0U05JHcXM3Wnv4Fqe1w6dHdzcMZRnYPE8uUwZc
	hywXfRDcdS3cR0wbhPAIGVbNN1yw9rh2VxsRISi/jHgUTGdxC2+m
X-Gm-Gg: ASbGncttLv0S7X11TWr1BvOD/d4Njf2jJQbrmHLbxTYgt4dXjEB2NfNQ+626YqyH4Cb
	kPj2fd6Fq4sPfki1CJTNwTieI1T62n1yfB3eiOfZlXBeljtfXfyGY5VWqvb4weFvi52iEV+s7i2
	dCfw4GlSJwZITSVC5qI6NPseR6ixw0TohV9zANr60VPFL2x+Jtt+ivopiBsIYOP00lDN1uGwLrh
	Co4SRUQdRZP/4fihimplZZcDdnjNoHvVm0Tp6Nf2MuY+Bi+kjZP7Mki7649gx9QYmaeIlzsXtMb
	dzuRyU8GKLPixEMGfj6JaFDmuZm0ll9fcu6VdJJt7NTNuWgHCRd0GoZ/5RzyviJLND1iy8+lSGj
	bE2jcvZ16xKhojgyICF4T
X-Google-Smtp-Source: AGHT+IGQyu6iPi0iwFfK9ojHPFOpbCezULBKbxEBCo5/jEYx233lkSxpnDwz+L55Flf/FLjGS3vkww==
X-Received: by 2002:a05:6a20:840d:b0:1ee:c631:6057 with SMTP id adf61e73a8af0-1f0fc78fac2mr22023526637.34.1740658171206;
        Thu, 27 Feb 2025 04:09:31 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:30 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:32 +1000
Subject: [PATCH v3 05/20] ASoC: tas2770: Factor out set_ivsense_slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-5-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=2q7/AnA+S3zg5UY6950rlfHRPwEmvXdr4IHaVW0DiDY=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk9GbI52PlW/wYJpQ1Kqw3N9Q3uzmV4qBWX3j2Uxr
 jaufnO9o5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgIlEfGZk+HHQ8qHWhOWFF6pe
 X03j3udy/d1byenfb6ptFj+Z0SO+dzkjw+HgpvtlrD+EUi0n+vw8vS98Sf26y0GJjsl3V3OsWL9
 0LwsA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Add a new explicit function for the setting of I/V sense TDM slots.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 40 +++++++++++++++++--------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 863c3f672ba98dd74a5ba1b15d650a90f91176a1..4a86fcec0c1ecab45b9ebcdfc90c78f3290c6fa6 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -189,6 +189,31 @@ static int tas2770_mute(struct snd_soc_dai *dai, int mute, int direction)
 	return tas2770_update_pwr_ctrl(tas2770);
 }
 
+static int tas2770_set_ivsense_transmit(struct tas2770_priv *tas2770,
+					int i_slot, int v_slot)
+{
+	struct snd_soc_component *component = tas2770->component;
+	int ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG5,
+					    TAS2770_TDM_CFG_REG5_VSNS_MASK |
+					    TAS2770_TDM_CFG_REG5_50_MASK,
+					    TAS2770_TDM_CFG_REG5_VSNS_ENABLE |
+					    v_slot);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG6,
+					    TAS2770_TDM_CFG_REG6_ISNS_MASK |
+					    TAS2770_TDM_CFG_REG6_50_MASK,
+					    TAS2770_TDM_CFG_REG6_ISNS_ENABLE |
+					    i_slot);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 {
 	int ret;
@@ -221,19 +246,8 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG5,
-					    TAS2770_TDM_CFG_REG5_VSNS_MASK |
-					    TAS2770_TDM_CFG_REG5_50_MASK,
-					    TAS2770_TDM_CFG_REG5_VSNS_ENABLE |
-		tas2770->v_sense_slot);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG6,
-					    TAS2770_TDM_CFG_REG6_ISNS_MASK |
-					    TAS2770_TDM_CFG_REG6_50_MASK,
-					    TAS2770_TDM_CFG_REG6_ISNS_ENABLE |
-					    tas2770->i_sense_slot);
+	ret = tas2770_set_ivsense_transmit(tas2770, tas2770->i_sense_slot,
+					   tas2770->v_sense_slot);
 	if (ret < 0)
 		return ret;
 

-- 
2.48.1


