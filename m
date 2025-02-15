Return-Path: <linux-kernel+bounces-515836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A87A3698A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C051898C65
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A91A9B58;
	Sat, 15 Feb 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwKPX+d9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E11A841A;
	Sat, 15 Feb 2025 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577982; cv=none; b=jzLXAq8S3nNTVT2Qh5Pas7TwJoPcuWx3Bg57PZCy5gFApZL1aRM2OHQm23PwPi48YuVzg/+h9l9dx3ec5SoYeBZgEpHky8RMOHuWaCFT8oghulyFHxcJuqVWSNvmb6zCVyBycsmSYCBvJ+mewcX9FjL9hat1FnXDvUYiqgIY/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577982; c=relaxed/simple;
	bh=YGx9PSaUXVNDPo2cH+rNjw2DIvjtU+dlXI+O382Ewmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmmAYc78a2N9c1bmMb36uxWHayb/R+3yavEJVfWTD913uBRyNE/5upj2IzYCSJ2JEybkJ0B5ZDKAvjFzUlVCZADe9j9KIS7ILnfqZEmS0y8nWxws1B2DLuFkKI3EFvkos4K0cvoRwW0q6Gas0QrODtZqDpzephlI6ueI2XAV/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwKPX+d9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e83d65e5so35561795ad.1;
        Fri, 14 Feb 2025 16:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577979; x=1740182779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZ84+yPdbVuhz7ak3Hw1Cb8Gf7TrNSS/4QEXDz4j3UI=;
        b=mwKPX+d9ZxjXnlHOLDVHaUdrpL5ZjIXHrs7IT1VUHgJDXtoJRF7DafI1fkHKOLP+cl
         n9F4EThzZdOPolEMSXvsvGdGDPXhKtM57sPcQjIvD0CbUMzXZhqi2pnZse/S7z6QeDCo
         C67RBS49QV4Y4y1LlWiOiPn1MrXfVyrFQKD1ia9Js6e0oobFXsiPqg3UaNbiG5ToObxM
         Y+TWTsqiZqTwYOKUzwM67dhva2NC2XQil8/9+f6NHk7FvdJc00KMJWYcoloTK8YWNof+
         /ejKsgyIfRADfIVLi1MXG7HdHA3S+Cw/pBqqfUNwsclm7UqsH9W0GDibG4zfFS63H7kG
         7UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577979; x=1740182779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ84+yPdbVuhz7ak3Hw1Cb8Gf7TrNSS/4QEXDz4j3UI=;
        b=k2MV127Wc2yv26Qof4TPaXPx0TaAiUIpOyXITOHa+2P6mI4mR6kO5AzOwvjVZ9XttE
         zjoss4QJuQSo8+yZO+/XDymrYxLNd17negLfc2a+dHzDlu9JxW1rZDTOODMulp5734N3
         RpUUshyPUw+TMb8+vT5kpihQD9v39UifGS9NImcz999l+4CNhc8g8NNI+6fXYgvYmt4Q
         hgYTfqpSPyg5+voDCJwdp5G64Cy6UUkX4nV0CzIqYx41G9J35/i+caAgAz8x+iuV1PZo
         HyF/lOCh/yjQctXZkOfTVQQ1B+H/LPR79HmJRq7ywVMVfb0+6+1QM1T/OlhXup2zIvf4
         ijEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcJVCP8A9RasBdQkYBJwqLweRolLhBvd/Uq1h6ad0ppGmf4QBch/vrGcALmxQKTBnJfeXrXes7KEslICs=@vger.kernel.org, AJvYcCVl8b6ua6gU5/7/fww/CPByn7ox5AOGVX0kVVjYCjfEmfhKcisdsPqO7KLneNPWFf2IqguF8iKDjaM7QY/2@vger.kernel.org, AJvYcCVlM2uRejOZ9yzaxK7Dfvonqcgig3N9XS2OKpwwV+FSR08Kf7lE2gBQ1yPKJV8zvfbRh3lRp8GjnuK2@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPr/SqA1Ntb/IgcSEpxgWV7NBYJOD2tu8CyPDquW3vDhnNape
	ClA7SFEqCLySUJfRXzXW+2gn9EkzJ9Is2e7R0Ke7+z9bGh5pm1XS
X-Gm-Gg: ASbGncv3KwJczCYnJT5HTYHbU5+XHawAPMgInC7rf7WB4v3ASOLoR4cRbNsDKFfqOji
	3qbR42Di96kPaeFVsfKuO8lAH02Dy0c2n6TS2wJ7oOdfgsPC87Vjbf6Tdlx9EowU5UZF8eMB0in
	5BbB63cdtHVmOGTvihMk4MGUCUlvxUjJNF+adrFtRIECPmV8LLQFqp59nty0aAPTt8n/llMQtyF
	1q9bkEh0t7RpYBQJY3UmcJnhhUGPoDMe2XnyoaWywcvpDF2rR/nWbv1gR4X0Z/MhZRUPnS1jQCC
	pATruljVCZx3oQYqGaDu9avYtWrAiZQpRbPGeCS7As/QHBtfGAm/WMMXvUyyn1Ky3iOiZq41aoh
	fwCM4bXDLLA==
X-Google-Smtp-Source: AGHT+IG6Hm9pNI6VvtCGvN8M2e0uv4buL4nr2DpT31d3QO2bC+lTvrwW2S2SN9aTyfVa/+xOt06boA==
X-Received: by 2002:a17:902:d50d:b0:220:f91a:4650 with SMTP id d9443c01a7336-2210402bfb5mr20473085ad.19.1739577979635;
        Fri, 14 Feb 2025 16:06:19 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:06:19 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:03:00 +1000
Subject: [PATCH 27/27] ASoC: tas2770: Set the SDOUT polarity correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-27-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=t7b1dvsnhFRkTomOlVk7jphWt6a+ItGg7B4nOBgPrGs=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb+54zPRzi9h80w331v155OGz4v3mBdahNcVm3Z9Vw
 nbL5W/Y31HKwiDGxSArpsiyoUnIY7YR281+kcq9MHNYmUCGMHBxCsBEdhgx/NPaa8J6NsC2Y9aK
 RV63t9iuXGixfo+cxJW+Sb9K/liqnN/GyHDBZFPP34qt1uL7bsUVZEorrp7E3SrLs+apoRZvc8G
 Kn4wA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

TX launch polarity needs to be the opposite of RX capture polarity, to
generate the right bit slot alignment.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index a9e65f95ec8600d905c45db4e013d3c2602fa8dc..793a0df499a631d8e4670d4a452572b2dae0c477 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -358,7 +358,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct snd_soc_component *component = dai->component;
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, invert_fpol = 0, fpol_preinv = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
@@ -375,6 +375,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 |= TAS2770_TDM_CFG_REG1_RX_RSING;
+		asi_cfg_4 |= TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		invert_fpol = 1;
@@ -393,6 +394,12 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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


