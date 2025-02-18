Return-Path: <linux-kernel+bounces-518901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B287AA39615
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8213BA24B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05DE24112D;
	Tue, 18 Feb 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuNeABBR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96122E40E;
	Tue, 18 Feb 2025 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867983; cv=none; b=WJekuKphq5DBkjTo+pcWwBi55xgwuxmOMHbThq+AH+ywe1tesgg6ExsKhXWSnp2oDKYGLn7HlCOinOBJBGoF4PWQdw96eM3ftxU4xiBCy+lHsevWPWlIaJAGcwmseDhSTNPu/ZHtfxh0pbfatjZzXdaEWXDKU2k7MV8ICE5pRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867983; c=relaxed/simple;
	bh=cnRZPokli+PfTbq6PV97MiDRn1Pju3ic7oVd9IoPL0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqSTBRAsw9m6ImIYXY83qp/BIXy9LFa9IYo8QNKD4MDUUM+4J5SVw/2YWy/AdpfQ3IiyIt4yWOnC5CvPC0jBri3cb6O5hH1Igm4i3AL3qa1xy5wPkc1yurmEVkfp0eKcXL2MgiJA6HbTqnwXNGR8JblNIudEjvnRPpWiD4FykxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuNeABBR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2210d92292eso68992815ad.1;
        Tue, 18 Feb 2025 00:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867981; x=1740472781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgDiTLXgcA1eRcm2kMK/ECehpkZvEq1aeeBEe2lQUg0=;
        b=XuNeABBRZZOJQU7qwqisFimUtVRU3gA6y0HEVcMD55k+TlhTEpUz9dIZcHjgBI9JFe
         awYcMLTMJHfxNI1HRCdf/tjzWOClf6aSa814uTEujo+9XzjZCgyxrwSxZ3xAGmO+uD2U
         pvKR9YMAK4++NL/eVzOffsRLxfqax3e+L0WfkBUxEpFE19t5k/zIYkwwme3GCTVjmsPr
         t7c7V2TxCIKGlnVw9TxOb1T+ijGnXtCpiEhNr44HB/Ij3U0cbcvGRy0YOHB8ULu4co1u
         pm02TEC9Upm/a5bD9FjRvsua4Uk8GjR79YhD991dqb24v5kn+7HivjrmCWbMU4GrPtpc
         C3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867981; x=1740472781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgDiTLXgcA1eRcm2kMK/ECehpkZvEq1aeeBEe2lQUg0=;
        b=HqgItqBZ7DnPkU4v8rkzZaJHgeQBQMDWOzMdcRosZk5F7zA8pzPda4Be5URtpb35yK
         6rXvJ6RXhVZyaUJx9Z4V1eob91G2q/ip0lEqE4kyeFSlgqHTtoAc26S2OIFy4dQQsQ29
         vSDe5Ha+uRdb9C1pAfNFMfCS3myZrr5AkS4sHteYzs7HW5aTyo9yQHxllfLDoICjrVhg
         qmTVcnwgYDocbmGerMbfwQfjwn9Zge11cHT/s2o3jaz6aWCVPSAGCsOzQDupdTxZZ5qa
         wqds0ZnHjwArbSiS9z73hOQMpTqXlsVaonfcqxY1xV1FqwD8pZyVcYULDIDBzL7RolYa
         HQJg==
X-Forwarded-Encrypted: i=1; AJvYcCWHdnqcL5CYt+cP44LMnGF468Ti5VLwihXtedGv/vpWsjALkkpBu39IsX6igthfwcWpbOVBZfRHH24z5P1o@vger.kernel.org, AJvYcCWys6SCM1bDCFcUNJ6lfWLztkKgiWlbNeHdmd1o1EwruUXA13CG3gxQ8LnCH1GwZT04pHV4N8PNZeDtazs=@vger.kernel.org, AJvYcCX3rrcdwEyTEGK//hm0gdxBFiElYTYVcT71l/TIS9QfvDaFQO9BcbZ7NqPom6vzlk53bRgGhI8gr5/j8dg=@vger.kernel.org, AJvYcCXWo+qAMJwcBf68XErVNTCMrTDjOspVf0vR20Y7w7rfmwvZQk96YhRGHqqc2I3NtKdG9uDyk3fdQWsc@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/lD4d38PNuhOd7HgijtPvNT/IpNMZSpMJMrU5kVRVjJxVNJV
	Wq1FkumWMt4Iti39ay6mXAkyuORN/qq4fGBsdblaJljYlOZikJ6sEKYuLEpU
X-Gm-Gg: ASbGnctwXdHQlMCeXVlqMpBmEL0qMRbXYA7l02iGEDJFHgLZWeduTMRHezqaddE9e4w
	CW5+M64kNwKckfsnYHWFljQwSmb69Xxk1UYacyXXJuJ3c7KPb6U5ZCQAvVPJn1bGfFXHfe9ItsB
	SGQVPzLvmRc84sWfGIfsgxRNmlw8kKaQpJ6Ebgs63Ej5PfZxkMwHMvzm+TNhNFFB7CQnB4VY9C3
	cVAXh/immHkjla63mOKzx4gyeqj8MGclxtIGfjvrW5Uf7sVopheOCAnOK7ioXmruMrlw+/32V3K
	9pvMLKgGtjOA9yiHjpQiGmr7q0rguIMv7kTdtZibmBERrbVkJo2nnkBOtVLtB9zg4RAy4hFh/wh
	3EfcOwR+F9g==
X-Google-Smtp-Source: AGHT+IH88g4GyXoeH30GTgM2lLwIX651E60KGhXaM8FdRzJc/IPiDl+2MnrPc+ajkNhWejLD6XKKcQ==
X-Received: by 2002:a05:6a20:4323:b0:1ee:66bc:9138 with SMTP id adf61e73a8af0-1ee8cb1b450mr24059373637.24.1739867980777;
        Tue, 18 Feb 2025 00:39:40 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:39:40 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:36:03 +1000
Subject: [PATCH v2 29/29] ASoC: tas2770: Set the SDOUT polarity correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-29-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=6r055cv5h6bTewX3So8WzRWOgNxg0HoosgfY3TM6nG0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JLN59Z1FAtLLExNURauyt7+fUo7O5dxoEbjVL5fq
 sePmT/tKGVhEONikBVTZNnQJOQx24jtZr9I5V6YOaxMIEMYuDgFYCJmmxj+B1/SPbNs4bGixENP
 Pv31EMpe9vrtxG93JA3O/3tWzFfs+YCR4foUW/PZ+7rUks+vnWH2Pe2xlyiDO8NCn8x7VlEB9Sd
 6mQE=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

TX launch polarity needs to be the opposite of RX capture polarity, to
generate the right bit slot alignment.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c4a5f4d1ce09a8e68759dd75d532d06d2a7f2d39..98b53557c0937c150d6c21ece8ede8f94afcd9f9 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -359,7 +359,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct snd_soc_component *component = dai->component;
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
@@ -376,6 +376,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 |= TAS2770_TDM_CFG_REG1_RX_RSING;
+		asi_cfg_4 |= TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		invert_fpol = 1;
@@ -394,6 +395,12 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
+					    TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		tdm_rx_start_slot = 1;

-- 
2.48.1


