Return-Path: <linux-kernel+bounces-536234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6EA47D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8788A188D998
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB822F15E;
	Thu, 27 Feb 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGtFlery"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104C22F145;
	Thu, 27 Feb 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658165; cv=none; b=HttmhrqmGg8vdCESKNYhpQN1F8mQWkC8B5gaplli4d3MxWnrzjv+UeMeEVPtD0FOmIrn7pCfaaPVh7GKEM1+xNue0AdetFxPGzjkMmeB0MuG5eAqCAUUQmbnP3fw+C1ffWQOTt2hjqhz3QzS73XKULRYF5S6iZthDCICgkTfeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658165; c=relaxed/simple;
	bh=Io6kDR2zBBh3aBpK4VSy+F5NUnkYFLQhjOt7NCyhIZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbHy41SZXdtBNW1xden2l2+bAuV6NsqfAema3oAJMn+sHzAJxnxZYASVEFOtsC0TUsVwsPyehy4DjsHxWIz2QSL3GjG9WGA2IbAbQOw9WsmO2wTmVnH1cIX33jiYXOByoFKc1Xa6+bPvBD3GuRspC22sYZsJEVeLPS3JyD7J46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGtFlery; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234bec7192so20837555ad.2;
        Thu, 27 Feb 2025 04:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658163; x=1741262963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzpCBkvNFe+4cxCFesd8njDke2bm077RZxzjdl44kWk=;
        b=aGtFlery3pTEQm8VqULwCArnWJt7O8GOUNE2dF3tVoQAkZ5+knMVCYIQmXYLHsXWua
         AQqYsaFPTjT07OcraBQl+eotdM1GY+y/Sv4iml/BdjsUTAD5USa3O3U1lg1rTZJ7Tg8O
         S/JOR+SxaA4IsHCQ315kNt9eRQ7OsUb11vlQHCfdG1XgwkbEkobJNCqRUsu8HQqtDEhN
         exOJtpaV+iic4Vtk415uX1brNR+ndFKZ9XeYk+pZWO3TeU2JlB6PT/ZVlQfgKqeRx+mP
         P6usJkDDwfwfXB+2/4UOMGf0wjAiJd/BEIW+nefngV7ojUlcjNKsVteh8knUlMQtiYKQ
         xpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658163; x=1741262963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzpCBkvNFe+4cxCFesd8njDke2bm077RZxzjdl44kWk=;
        b=KL9mGIVSmhLex3gXUEvhO58ITuXljN4T4IGTJ2wsEqQUN0i6aBPbXl/6o1KMHC7++z
         o+UZDtKpViCPlZ8zVKa3CsmbgGkC/JmTesXRhU8aWDfDfDDtCBYkMohdMlIT+PJKa4fj
         +WH5IDb0cI/3OwIYLIXlONNVRDrnUz7CfUKAVDaPFxPOU17vxNsYtmEPSWL3t+gnOVcX
         yTvAleRg4nx64ZDTtMQig/Aq4Bx0cwaf4w9YfrFoApenvEIXMFI88asti0rFGCK0saDn
         rgjhYuWstz6+Z30PgxM/DcKABId2W6ak8TDjcE857/iX1RBUbF4VatB17qIDkBM3kS50
         HVEw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Zk5Xi/UyJkIn0jxv5XtVtnqp5VVFq/9sriVGfPyxx6crTJFm26gqXiSSuumrQQbL+t4LEJS4IvGBwrY=@vger.kernel.org, AJvYcCVSp2wy9Dh4p2dHMHzBNWXXRTpaPJhlJBwfJ9wN9IvfWMGDPTG66q7GR2VJk3JOpeXt+b86ZrO6FptaoJw=@vger.kernel.org, AJvYcCVrlipuJBHQ/YQ5ItlOm/A9I+dnzvqyMpc4lJM/bRRjvXh+/Liih3fQ4HfOGBGAYK9P870GyCmtfa0U@vger.kernel.org, AJvYcCXGB0KEtHGhrCerxkfxg9lRt280eeqAUjqQn6eh7jsuKB7YqjBNiD/fMpKA6N3R651tUkhbPNwksaBi5wz/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57bOqq23ibKBW37YWK4a7DynNQu5UDeVAGbym0Inx9uJ1rn1N
	+VzmHJp/XYmmCA7Pw2l1gvHfRX3G4B54FTZg2SCF+hQwyBSCqwSI
X-Gm-Gg: ASbGncusM9J8UvaQ1SogvLD5wlTvlTB5tr4uxsO2HgasNeWP7cec8gMJQskyhBye/8M
	fkzmaS/OEUSAt9nnYOImBpS1r5vYnlljyqzqegi3Mm86u5O1gVpDkrYeIcMw4ANDRSpwNUP279x
	s34syPsc8fYeegZpH7WRKWLdqHzG+WlJynb4kLK0IVNCbuValvVC/YxSP1Ug/01Y1FmZa8J8lhI
	9Bs0Pwga0M9U4vNYavfHlYDr9Q+JXQjWc1vxDV/MjjO54UffZugX65punsJyRkeaNuyg36JyQRm
	64y+K82/EBMWoMqsXVTACO5k7lJAumWhTfcA00Y2vQg8UKI1UPyeU40QOBH1CqdClHJ7QsGKAcV
	Qj3MKkW7x0EO4u7pSGktz
X-Google-Smtp-Source: AGHT+IFmjn8gZmsAiVDDh0ytBwNsGDZKLbshMCoMfcZDZX53iA6NwZyLI9KPUoJ8hC8j1OBKRPgFng==
X-Received: by 2002:a05:6a21:348b:b0:1ee:6d23:20ab with SMTP id adf61e73a8af0-1f10ad33426mr10797861637.10.1740658163129;
        Thu, 27 Feb 2025 04:09:23 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:22 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:31 +1000
Subject: [PATCH v3 04/20] ASoC: tas2764: Add control concerning overcurrent
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-4-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Edes/eOYgyHscimA5rczgRo/u/EfWQDXOVtLP4SmgoA=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk+eSplRlP06a+asbVk3RG4v45kS3HlD41piy4Ebv
 I/Ptl6Q7ihlYRDjYpAVU2TZ0CTkMduI7Wa/SOVemDmsTCBDGLg4BWAiM7IY/ify85+1OLTn+g61
 jQ82TjrzaZNH0PSLXa2n89e6KNl35egxMryN8lyzreNViu5qp4aSt1GKu19OFN54eqtyg/Kyq5F
 HF7IAAA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Add control to expose the option of autoretry behavior on overcurrent
events in the codec.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 9 +++++++++
 sound/soc/codecs/tas2764.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d9b4f898789fa9b59c94c97e3b130950b88c3a76..08aa7ee34256896915f3ed6438b8b8827ce240c7 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -634,12 +634,21 @@ static SOC_ENUM_SINGLE_DECL(
 	tas2764_hpf_enum, TAS2764_DC_BLK0,
 	TAS2764_DC_BLK0_HPF_FREQ_PB_SHIFT, tas2764_hpf_texts);
 
+static const char * const tas2764_oce_texts[] = {
+	"Disable", "Retry",
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	tas2764_oce_enum, TAS2764_MISC_CFG1,
+	TAS2764_MISC_CFG1_OCE_RETRY_SHIFT, tas2764_oce_texts);
+
 static const struct snd_kcontrol_new tas2764_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", TAS2764_DVC, 0,
 		       TAS2764_DVC_MAX, 1, tas2764_playback_volume),
 	SOC_SINGLE_TLV("Amp Gain Volume", TAS2764_CHNL_0, 1, 0x14, 0,
 		       tas2764_digital_tlv),
 	SOC_ENUM("HPF Corner Frequency", tas2764_hpf_enum),
+	SOC_ENUM("OCE Handling", tas2764_oce_enum),
 };
 
 static const struct snd_soc_component_driver soc_component_driver_tas2764 = {
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 69c0f91cb423986f7f0ded0b2160927f024d957d..3251dc0106e07862dd69efd69fa0e40c3858ecb7 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -44,6 +44,10 @@
 
 #define TAS2764_CHNL_0  TAS2764_REG(0X0, 0x03)
 
+/* Miscellaneous */
+#define TAS2764_MISC_CFG1		TAS2764_REG(0x0, 0x06)
+#define TAS2764_MISC_CFG1_OCE_RETRY_SHIFT  5
+
 /* TDM Configuration Reg0 */
 #define TAS2764_TDM_CFG0		TAS2764_REG(0X0, 0x08)
 #define TAS2764_TDM_CFG0_SMP_MASK	BIT(5)

-- 
2.48.1


