Return-Path: <linux-kernel+bounces-262095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0138D93C0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0281F21C02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2A1993A4;
	Thu, 25 Jul 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFp/k77c"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA03199221
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906640; cv=none; b=o2iI78JihIK0frNhCuy2Yu6d4Cy2Skbv7lPh/t/Ob86+D7t+rkGFke+e0h0ybYyZtcX4WqUF8EtQ2M481jEmhrDV9rCydL9bdFmCwghnMyYCWIzeqREn4DlN3Xjet648XC6s6fhE83Ts494hQNUp85fCD/As9y0CJXV2RtRI5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906640; c=relaxed/simple;
	bh=5bfQhydr9tMLNetcsEZz+hbSCdoeA4DrLZ/v+dMoi3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebw0aM4TrnBilye2dUSdGhIVdlPArBShonbbSaI2Btw765JWleF2fNn+XWmXJGa2wbRLedl4fslaUkZdLPHThOBfQ2kEO9zGfdLS8TljWjfP/pxhWqk2OUtcmVEhAAqtGrOwkfH5D2K1HoJT1Qvi8T7I0VJ5i33nQuuHXGmoI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UFp/k77c; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-368584f9e36so416947f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721906637; x=1722511437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFlLzwLRceHnWpJnvPhTnE02ITLGjL6VJSNAT7ByPwI=;
        b=UFp/k77cD8VG+Pl2V8sXS+RDd9gvJn4WRK+HdqiknmVBiS91x5UcqsiQi4XeUIObMX
         L5nsyg7sfIh+AtJ9Cv800VSu3UVYtBDeZ/N6Zqf3kJmhElpLsH0S81jZxB0K4mFq/APL
         HKY/+5upxy/9lL3w8Glkjf8hrS2+yhA4Evezx6D9NEkxYM2xz39XO+vvxphEZw4fYyMP
         PxRor4WrOeOdkSa271st5RcU4fLWmzCRGyG0VvVAPMqnCExZKMtsRGSSXVoNzAiZ4fcI
         /FU4p/Wz8yEf4rbNaQ2snqkZGVEgAHi90OPxZvnD78UjwrwHbl6/Ue9JKHLwTlx/H5zU
         XZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906637; x=1722511437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFlLzwLRceHnWpJnvPhTnE02ITLGjL6VJSNAT7ByPwI=;
        b=S9RYpRMwtZ40kJITNAr4pLSa6wbQfZJ3O1J2U00tuUVF7HOvpqZU4b7gQoSIVvUu63
         +YvhKHyb9c2tDGvWB2U16kKVrtyiW/olbjCYrqfkTHjGcHi0rQZsP4YnuH/2Ri1MRyh6
         nOBtUZwmNEuI2psQK//PMqF10aNy+FtoCRZfUUM7gi6sAzx7L1XDoognDEJcOA7+Uri6
         RdTG5eIzIY6+XNITYOjbZ98FZj4p8FSttIfzBgX9RPGKERVxRCKo0txVv0RmTpAFOLoI
         NEGlucYKuGM+OV/rqQ4dirynjRgQN8+We4I4hXYFIA1/OkeUIT2/UBc1VBfpCVzh+76b
         xTOg==
X-Forwarded-Encrypted: i=1; AJvYcCW7LNbq03oga8c3E1Eu2TD1rt3W6EFAIZv2yHNqpWxg9FQqBImGqVRgmXTFy/vLKSbYTWZck9T9SuTsBuFbXWkQXHj4NH1TrBMYPcHu
X-Gm-Message-State: AOJu0YyA3f7PdUMg3W+29hTO+RGoVYKJ1sE9bONmJvb7qVUbcuaGErg7
	GvmPeGrqwq/rEgxw97bVO6CUIXrzGLj2ZhW2jweqOt34nBomdH6sQw0Kz5Bzqzo=
X-Google-Smtp-Source: AGHT+IHI+UfhUfC5IdbfjZbkmX32phYaaUoqE0Hf3dZqYfF6Agh382b8dMvAJQrIcQK8MCKaSP5q+w==
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr1441762f8f.39.1721906637372;
        Thu, 25 Jul 2024 04:23:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e072asm1823607f8f.42.2024.07.25.04.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:23:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jul 2024 13:23:44 +0200
Subject: [PATCH 2/7] ASoC: codecs: wsa883x: Use designator array
 initializers for Soundwire ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-asoc-wsa88xx-port-arrays-v1-2-80a03f440c72@linaro.org>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5bfQhydr9tMLNetcsEZz+hbSCdoeA4DrLZ/v+dMoi3A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmojXE6P6roRkXoVY/K1xVHnF3/DmAhMbfXU/SW
 rdbGLXNlCiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqI1xAAKCRDBN2bmhouD
 16GGD/oDVLyKmM0xSiNmRbDucXD4aBD0aY6ODnIpmZQ7/lnlpWOuPXgV2Q3c3djzlRym60/IOVP
 zmoUqNu2LiOecq/VdyyfFx7yNyn4VgQbu66YmVuMbwItvpbj+UF2KHUKElSMQoiu2FVHgrLthYg
 kf8VOeEMXFQ73IhWpygDAaBVFUMKT1pnMEsg5sJEvdC0oNOvU8/oOTK0SLmHC7HMfUw0PbXi+Cj
 BJwVj72PlXzdnIDc6oD+yQfbFy02TriW1i1iIeBrAfvneOKuNZQIHaz4f73cZpwhrlKzCl82r7k
 TvTXQv8nbRD9IU61S9SrKW/SfJWCMdHpU1htnkll82L2T1EcWtOgjB3TXkEmJYaI6ELSJtD04D3
 V1qxlXeT4P5gDhbE18tQm4xAxl1v8PsCBtmKg+6XkOmaKH/Wyw1uPGIQ8ia/rPlTbtciymTMh2s
 RZHljfhesgLD4wOsv0Cs0pla7hwsz6rS3Po9EfOZa6M9+wjHX44l2ti+JG7K/RKVMq7T0E88p9/
 UhVlhgEkm8TsPnK3vCegGOcZgCm4gn79xWpShxhnZL75+FTrNb7pQLRkA0Xo0zIdCO1k1DxCO3b
 4OqwGY/7N4fIufujHwb62cTuUukR9d5YITK7mLF75iPqj/23JqCfzLf7Axn6V4aLWrLmkwi7/pt
 s6cdJ6Tnbp69mMA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Two arrays (with 'struct sdw_dpn_prop' and 'struct sdw_port_config')
store configuration of Soundwire ports, thus each of their element is
indexed according to the port number (enum wsa_port_ids, e.g.
WSA883X_PORT_DAC).  Except the indexing, they also store port number
offset by one in member 'num'.

Entire code depends on that correlation between array index and port
number, thus make it explicit by using designators.  The code is
functionally the same, but more obvious for reading.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index d0ab4e2290b6..9dc2e4d96b10 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -482,33 +482,32 @@ static const struct soc_enum wsa_dev_mode_enum =
 
 /* 4 ports */
 static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA883X_MAX_SWR_PORTS] = {
-	{
-		/* DAC */
-		.num = 1,
+	[WSA883X_PORT_DAC] = {
+		.num = WSA883X_PORT_DAC + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
 		.read_only_wordlength = true,
-	}, {
-		/* COMP */
-		.num = 2,
+	},
+	[WSA883X_PORT_COMP] = {
+		.num = WSA883X_PORT_COMP + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
 		.read_only_wordlength = true,
-	}, {
-		/* BOOST */
-		.num = 3,
+	},
+	[WSA883X_PORT_BOOST] = {
+		.num = WSA883X_PORT_BOOST + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
 		.read_only_wordlength = true,
-	}, {
-		/* VISENSE */
-		.num = 4,
+	},
+	[WSA883X_PORT_VISENSE] = {
+		.num = WSA883X_PORT_VISENSE + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
@@ -518,17 +517,20 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA883X_MAX_SWR_PORTS] = {
 };
 
 static const struct sdw_port_config wsa883x_pconfig[WSA883X_MAX_SWR_PORTS] = {
-	{
-		.num = 1,
+	[WSA883X_PORT_DAC] = {
+		.num = WSA883X_PORT_DAC + 1,
 		.ch_mask = 0x1,
-	}, {
-		.num = 2,
+	},
+	[WSA883X_PORT_COMP] = {
+		.num = WSA883X_PORT_COMP + 1,
 		.ch_mask = 0xf,
-	}, {
-		.num = 3,
+	},
+	[WSA883X_PORT_BOOST] = {
+		.num = WSA883X_PORT_BOOST + 1,
 		.ch_mask = 0x3,
-	}, {	/* IV feedback */
-		.num = 4,
+	},
+	[WSA883X_PORT_VISENSE] = {
+		.num = WSA883X_PORT_VISENSE + 1,
 		.ch_mask = 0x3,
 	},
 };

-- 
2.43.0


