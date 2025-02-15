Return-Path: <linux-kernel+bounces-515822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A1A3696A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746B716A98C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A69189F36;
	Sat, 15 Feb 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e783JxQZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F94C8E;
	Sat, 15 Feb 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577885; cv=none; b=QCRt7oC1Y/M2W/w/ndwT+QaomEJ7l//u/Fupzn4j83oaBd3mwqzt9Y1JvlWq/dC3WwYKxHksJ0GNYvm5mEzur/mT0LcWn5aljGDYJJLtc0IwPkzZ/Bgynrsgde5hVFSV+W2nJ/vJzq4Djn/CjQIdDOnRmWVT7/mQbhZz+uofs44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577885; c=relaxed/simple;
	bh=avQn/VhlgQeahgG8tI1AA4uleObwB3TDgNlHt81617Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKGTZG0+WACMlIvXH4SLAmV9OtVAlN0qYEQWFR9iKET4XgO0TMI+9AyJlEwm7HkUkCmRpy9BDwnknLmI4Cn++/UKzuf3qyjcvecLPx1nbAay4j3MQntcxd+8OkCSRyS+n8B5wIHvQhCnNR35ly1fcqQgzvqqICIM3m9adM2hzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e783JxQZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220e989edb6so41409845ad.1;
        Fri, 14 Feb 2025 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577883; x=1740182683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+dZdn5+oQsOB5+cSz2r2GMKgGUJjwVauG7gsEGMQik=;
        b=e783JxQZUGxEkj1xBK/G4+uiFWJCpFyn5rcBqHJyI5BJ3IiirXLGm+5Gu9EIQiVMIS
         D/N+ER+yCM0FEmtAz3sO26peVZ6j+hCDFLJbUqG23kkXGvZckleqcIYQAQEpu4NliVJk
         6sYx4p0cZEABkuwQGQIC24ku7pvcsI8aGOxYKCNKCH1nQykg1BW7+RcnPVjMaKnPJyZC
         WyuxJJ0HbAu3jvRtKF+81ag/h68Lgenhk7x2e9Wt9qhepvPEFQ8hvGNPSGCWJmCzqabJ
         pDjeHvAkP1IYGcVPWqjq/kIzQUXaZuDtll7DZC/ssjKeDetfj40TJrFBqIEa4JW1wM1K
         /jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577883; x=1740182683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+dZdn5+oQsOB5+cSz2r2GMKgGUJjwVauG7gsEGMQik=;
        b=UmgbP5tGxbfmisKFqYSS7QXlFIaA8aiYuF6+a6mxArQJBKQQwjY9G+QJyQTzFsAeS4
         D9ZOiWEc9E04JHLBJxLKdcQT1QMdcH4UCWgsaZk1dlXjnZMzcPphh/3DW661kAdxEvl0
         jkUIqFKR97RdtrXRdLOmblrRIYvnBZ9utehdw3zBZdD0D8ntNs19ifHtZmJL9Bj2P5yU
         X9T9ZwgdUf4UUTpplQaIEtbke0yIvg5bYV/WD4EssCUsroF629q8tE6klpded+JLd64m
         IYi093Oiq7rls4bjkAbip+A9o4q4p2AZPrBcoBchxxA24c6mjwYyDf1TJiwaZDksnh9+
         j8qw==
X-Forwarded-Encrypted: i=1; AJvYcCWWH8yMs+RYL43JO9r2+sEFlAWChu+1IqRTq1loa3BscaJezAEaDAg4gTKergV2eX0PssutaX7FzOtj@vger.kernel.org, AJvYcCX1zDgnYVuOchEghO/4xrnsJCtAuOM6phocKKAGeKJNb/WMS3kk1LoyqvfT0t/m0RwdyOXpCRoUmZEST2QJ@vger.kernel.org, AJvYcCXnf6PbKryXdyb5hM7A4sVQcBAss+K6v0AsHCry7pGQZXCOLePG7ARoNa2wSEL42OXR+8FwLMEhQdwsXiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX07bxVkcXZOgSDPBDCMivhWb6eP+JlojUcdsrhVwGsq2/+FM7
	b8/F35aTXwaaWtfuBddrns4CehziAiDNcEAJW1t4pqU4UPLGMTk+leSK84HA
X-Gm-Gg: ASbGncvNdhruIyblxTDzDDNYa8CD5VxNBvwTFRL/zm2icQDzaj8xpO2xdwYV80zRh/o
	OT28SN62Meo8XdujcBEQiHLJIVsYOxxZed8MgCCR5vnevfEtCTbPprXL2DVNMIKDDaWZ+d9axaR
	KuBkzkCMsylovXf5LAU9aHUrwBt3H8/yhbC+IKYzuPZTiTjVB4ntWtWLlLtXKMkWb754Zfs5PwC
	Oc8jhoKIsIpNe2+eThooVkUNgjaKl0TBTaM/TI7jF9prkDx9zEAA0Xvh1DRH70GC7/mWkPxONeT
	r+81CxKDytadul5JcU9CmihpUtYQyOObHjLwnz1Yd4T4Oqmy8Dl0PLZJOtWqZxvscTIzDKmbBVO
	w2wob8fFFjQ==
X-Google-Smtp-Source: AGHT+IF0A/O3P2fni+IwGOThsKRu0xADtqt5QnMWSAbBMMUtl0QHjLZWjq0YyFA1Fr4p+LAcC80Rag==
X-Received: by 2002:a17:902:e803:b0:216:1543:196c with SMTP id d9443c01a7336-221040620b2mr18492975ad.27.1739577883025;
        Fri, 14 Feb 2025 16:04:43 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:42 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:46 +1000
Subject: [PATCH 13/27] ASoC: tas2764: Crop SDOUT zero-out mask based on
 BCLK ratio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-13-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=crv8gDizT2HlKiCBN8WV4dDNDnFJ9336ZzKsSQapktU=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24rTr8gdvthP0NvMDdj9ukdFzSjei9pp93kKtkhv
 tG9Qa2xo5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgIncsWdkOPu/rHDBfesYn+WP
 mWLf7+Li/T/h4IoK3Yuvps9YV7p90n2Gf9YKm6+sWnc8KuJoQ3RrbYm+UAbbr/zVt5stzJPfn/Z
 uYQMA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 56 +++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 25238d3721a21d5af8434490acfdb7ba53de9ce0..439e5bbd372cd467966ac9cac1c92e3e300fed54 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -375,6 +375,44 @@ static int tas2764_hw_params(struct snd_pcm_substream *substream,
 	return tas2764_set_samplerate(tas2764, params_rate(params));
 }
 
+static int tas2764_write_sdout_zero_mask(struct tas2764_priv *tas2764, int bclk_ratio)
+{
+	struct snd_soc_component *component = tas2764->component;
+	int nsense_slots = bclk_ratio / 8;
+	u32 cropped_mask;
+	int i, ret;
+
+	if (!tas2764->sdout_zero_mask)
+		return 0;
+
+	cropped_mask = tas2764->sdout_zero_mask & GENMASK(nsense_slots - 1, 0);
+
+	for (i = 0; i < 4; i++) {
+		ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
+					      (cropped_mask >> (i * 8)) & 0xff);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
+					    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
+					    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tas2764_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
+
+	return tas2764_write_sdout_zero_mask(tas2764, ratio);
+}
+
 static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
@@ -506,6 +544,7 @@ static int tas2764_set_dai_tdm_slot(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops tas2764_dai_ops = {
 	.mute_stream = tas2764_mute,
 	.hw_params  = tas2764_hw_params,
+	.set_bclk_ratio = tas2764_set_bclk_ratio,
 	.set_fmt    = tas2764_set_fmt,
 	.set_tdm_slot = tas2764_set_dai_tdm_slot,
 	.no_capture_mute = 1,
@@ -658,23 +697,6 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	if (tas2764->sdout_zero_mask) {
-		for (i = 0; i < 4; i++) {
-			ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
-						      (tas2764->sdout_zero_mask >> (i * 8)) & 0xff);
-
-			if (ret < 0)
-				return ret;
-		}
-
-		ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
-						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
-						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
-
-		if (ret < 0)
-			return ret;
-	}
-
 	if (tas2764->devid == DEVID_SN012776) {
 		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
 					TAS2764_PWR_CTRL_BOP_SRC,

-- 
2.48.1


