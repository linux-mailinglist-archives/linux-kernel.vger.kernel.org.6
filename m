Return-Path: <linux-kernel+bounces-536236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA1A47D53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A926A7A2906
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B7232392;
	Thu, 27 Feb 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ufvRbV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83622F145;
	Thu, 27 Feb 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658181; cv=none; b=eFCpKkugUouPCHFJgdSya/ka1DHpLKxelYkRdqCvt3f0dlkMEOlNzIjU0RrTciNvk6gajxEcJJxpiM98pfD77m0lWYsziBBLfogB10KWnnJkUsVufZ4oz3UpyuV85cOFkpNQRDgzVMEYO+MhDxCTs4fyh3y93c1qU8ywWnUGaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658181; c=relaxed/simple;
	bh=kXVqm3Bcan36F2GLj/Gjs15SCdXWtkLPAjRDAFl/lgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhBdQ7wg/WHyiBiEZJ/NAFjA2fSjRj6OnS/kH2WQntdbSgXmdI33aXQLKNajDNGBtqbe1o+H4187sHsMKyyaG0p97TVhAVMQNz2pZj96ZZAQhOq3lueb0p2LzibDE3Cs4qjmz+poMIpr6qC16TnzuWrA3rhjVv62EPlLjVjjpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ufvRbV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234bec7192so20843865ad.2;
        Thu, 27 Feb 2025 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658179; x=1741262979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAEDHeJBFJU8F7o0MW5ekN1Mf8cimeNpcsWtMaG5SxA=;
        b=e1ufvRbVmnelsv/r6/5vcIFk3r2J69ZwsGJbVqQqZ0BI85UsX0LM5CoyrP3xpjft2z
         IlOWbuPjDlzpkX/qvOgCcSFUsd58HEPDsYyM4OvDv7NXmpQqxd8WuERdz+zvTyE7MuaS
         E/aLwZyYba6HWDvb4vloQacqFAlKKptGgAgv5vM+aiB+rQYyIeWWUTqtKKBfqkzpNdpf
         zEOtLPM63rmDHg7hdWf8zqP6kI69GkVnBTL3e9yH+mGoN+ylTXNEJgfplCPUZMEaKaFW
         2L+TUej8ueIDBNloumwaPrtnz8l0vRS4KwIpadUSN5urZ1AxOT2U08N/EwnABCsfNXl8
         ozHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658179; x=1741262979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAEDHeJBFJU8F7o0MW5ekN1Mf8cimeNpcsWtMaG5SxA=;
        b=M3L1lx71GsPBFvEklbpTzsog+2LPYqOyisDK8ZZ3A6MrbQq/cStaeYmRswXIJ6gNgA
         1ZIpUQOt8AyJX3NsmYgAr1BsWvzuSObkLRV/u8FvMnTu5In7UvYlo9b/SJvEp+COvarC
         FiNV9GAtZoExPDKNP1cqt7aOccH8vQNP9WzfhMkez3xAaD+mNdBnr6hDt+qz7bZo4W8m
         o2r53/fNO13MJ15W4D+D4esok4Y/SRcrVZVZvPEEYNsgfc4tB2bqcgBlmnVD+Q0YzP67
         HVtXEKrxrNeN4ZskdeTbVbHgVdSNyVbMI7KHN1lOItrX2+YK6eNPI4uNkdVHg8DQnor3
         k3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUACQv/95EkSFMGYhh8VCznfaXIBPHgDr9ypfAcAV9YSPmzfYMMu4/Ou6tc5SJrpbQ6FnPg/hW2VP39/AU=@vger.kernel.org, AJvYcCUVlCTWC/vNIR7g6PzjXcjTy7OwTE04NK6Tkb22yk8QREvpFzMuNCc6iRAKHmrng9Mh54Lj9nnkc8SjDd4=@vger.kernel.org, AJvYcCWgkPbfDCWR8e2TLygIOi27svc0SOmlLt3JcG534I0GOo7UxiaAhrIeeKr5Otldkz5vjTowjbb/uYvEcZ5K@vger.kernel.org, AJvYcCXdr3dL3giOyxqD/hcB8T7yChOUzO3bIaaPphqTN4nJKuhR7tEN4ysdCYrSOQuG/DYlScDl28g87A6P@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbDE6URW6W3xv1uzzqvjpsc6Bqkow45VldyZ3JrEkgc/mMEPN
	CeBRCVPkpgU/WTToD02qVWZau3MXRVUn/7lXDQ/Bg2LPmGJcBfkg
X-Gm-Gg: ASbGncukQFt66N9EMBSnXadx59tF4POHbJT9b9evLifzX9cREy338w0uwzYli+CQS2L
	NTJKuFMYwcsI2FRFq/vjIKdWfNVE793cqzVITOr1u+PmC/RSTgQZI/b3KdcElPR8xyeQfVQCFiA
	u1/Q+gcFvX+4RIvDyqsVSEboaYBx1VWMHg+/ekLBXSu1kGhhYfH7XXwj/vaBPH5y4cMfZ54y6RR
	tzrfLqXzDrZXHAnt0pYdrs46G77KQP5L3NoAlCPzmXiwXXFuV0yO95bTRFlZ4JjUuh/A1YON/d9
	agJT4uNSaPO8eC8JiUb97sMP8Znm+PfxcYRkwuSvgm6e5FjktK13Hkw/QZfn+4WDkDLdx7lhKRe
	MUmhXfFcm+gUHH0RDss91
X-Google-Smtp-Source: AGHT+IFM2zqHEqQGdZD7CbNcSfwL1TPV/fIjrKD3F2p8of5kiMnTk4BKW+CwUOw2ypL6ib1URem66w==
X-Received: by 2002:a05:6a21:e8e:b0:1ee:c89e:1db1 with SMTP id adf61e73a8af0-1f10ad7ed2emr12060212637.25.1740658179086;
        Thu, 27 Feb 2025 04:09:39 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:38 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:33 +1000
Subject: [PATCH v3 06/20] ASoC: tas2770: Fix and redo I/V sense TDM slot
 setting logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-6-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=9oD673IPZ5uFrCCPftVCE6wRdPUQVoC5LK9O/3Xdq78=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk9uZXY99WTvjf2ejjEHfHtKjj6XMdx5T7PB48EzG
 c6LcZM2dpSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjCRB3wM/0uS+y9XP/v1/fy7
 be8dL8U2Cl7p5whouBG17NWB7uu1bd8Z/opE6f/a5Pb+evi8/knXb/96sj5r2jefxX6RYsE3jvQ
 dN2YHAA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

The former code sets the V slot from inside set_bitwidth according to
the bitwidth of the PCM format. That's wrong, since:

 * It overrides the V slot parsed from DT binding.

 * The V slot is set shifted behind the I slot by the length of the PCM
   bitwidth, but the PCM bitwidth has no assured relation to the TDM
   slot width.

Replace the former logic by setting up the I/V sense transmission only
in case of both I/V slots being specified in devicetree, and never
override those values. In case the slots are left unspecified, disable
the transmission completely.

There's an improbable case someone is relying on the old behavior, but
if so, that's a setup that only works by accident, and cannot be sanely
supported going forward. There's no indication anyone is consuming the
I/V sense data up to today, so break the former behavior.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 4a86fcec0c1ecab45b9ebcdfc90c78f3290c6fa6..7f219df8be7046912bf3ef452f75c17b5118bcf6 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -224,19 +224,16 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG2,
 						    TAS2770_TDM_CFG_REG2_RXW_MASK,
 						    TAS2770_TDM_CFG_REG2_RXW_16BITS);
-		tas2770->v_sense_slot = tas2770->i_sense_slot + 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG2,
 						    TAS2770_TDM_CFG_REG2_RXW_MASK,
 						    TAS2770_TDM_CFG_REG2_RXW_24BITS);
-		tas2770->v_sense_slot = tas2770->i_sense_slot + 4;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG2,
 						    TAS2770_TDM_CFG_REG2_RXW_MASK,
 						    TAS2770_TDM_CFG_REG2_RXW_32BITS);
-		tas2770->v_sense_slot = tas2770->i_sense_slot + 4;
 		break;
 
 	default:
@@ -246,11 +243,6 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 	if (ret < 0)
 		return ret;
 
-	ret = tas2770_set_ivsense_transmit(tas2770, tas2770->i_sense_slot,
-					   tas2770->v_sense_slot);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -505,6 +497,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
+	int ret;
 
 	tas2770->component = component;
 
@@ -516,6 +509,14 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 	tas2770_reset(tas2770);
 	regmap_reinit_cache(tas2770->regmap, &tas2770_i2c_regmap);
 
+	if (tas2770->i_sense_slot != -1 && tas2770->v_sense_slot != -1) {
+		ret = tas2770_set_ivsense_transmit(tas2770, tas2770->i_sense_slot,
+						   tas2770->v_sense_slot);
+
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -643,7 +644,7 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
 			 "ti,imon-slot-no");
 
-		tas2770->i_sense_slot = 0;
+		tas2770->i_sense_slot = -1;
 	}
 
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,vmon-slot-no",
@@ -652,7 +653,7 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
 			 "ti,vmon-slot-no");
 
-		tas2770->v_sense_slot = 2;
+		tas2770->v_sense_slot = -1;
 	}
 
 	tas2770->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);

-- 
2.48.1


