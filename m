Return-Path: <linux-kernel+bounces-187350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950D48CD084
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC311C22852
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE578144D13;
	Thu, 23 May 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWOyTJTi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF85144306
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460967; cv=none; b=tTF8s/Pj09xK4qGOYAkGokW4FlRloBYCZKtwXJQHfzD+LtynevUtN+K2XDQCrCO/WroakXmaLFlSANNzw5xWusCNDbsYzwajie/ldm6Zlj6YdLdi+P+5oEAlW1Lg9pAygpSZTegSvVtFZndTwdE0qGipVPn2IFavqNqVHFpGPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460967; c=relaxed/simple;
	bh=BIp8V+DKGlfhtyH5F/wbHKFDgs2uvsnHX+CSz9AjqZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/jS197ePpTIaXIxFwg0QuvrJr03d2/d4CothrAVms4wWatWJih/aB6Z/hesZB4zhI3BSwzPglNNedK10wW6aLfq7S97JPvXJjkCLbjS7JybBgNr2fsGVmO++UuW0yEigPvaOXAtsPGcfRfa8kCpzA8uu5V5LGwCe49e7Ayvivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWOyTJTi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354e0d4db6cso1054569f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716460964; x=1717065764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KDdQKxWJ35TnwQ2Y115y1B8VQNH6wqcjHGIJjckbyM=;
        b=eWOyTJTiTk/rghDXhEZjj1Vx+T5cf/G/izCVUfkMUI3b6BBYRRRoHOhqi+wRhfIhd8
         JmH2UjBdU9kI4utsKjCHEXZLC2ZdhX87lU3T8Co6O0UshJRoOcfe6ToZVDAWIdIQEB3W
         HB8TgKeYTv2vD4XckNhCP9o4s4sMKwBvCZlvhiNoPknLfxje0etcV8MWr53n+Gv+nsjU
         sKkLKyM+E2aH8TftD5+Y8nloN9pgmaJoYHGjSZJsCVmqr0NYWInokjF1GSop79cbXdey
         hG4CipFIyxtS1jfJ4waOoqcZu/auylQL32bcu7qfJSYHQv1TDtYRZN/7CQxMeHU2Pj3D
         uT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460964; x=1717065764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KDdQKxWJ35TnwQ2Y115y1B8VQNH6wqcjHGIJjckbyM=;
        b=Gui6ORWZIKIcbSgGj/hikvHjDAQyRnR7sOK3grIno5heMWSPxnujb1Wf+V4QEvKKAo
         58EqIAMcraEJBeyom2G6ZVmUmUfivlorgyhcCEv3deN8vXbwxbBywNUnMpFl3GRl+klc
         1MYfVgDNIheumIRAoLofKnojbpQSduWKuDqwoQn9IhxItIioh3kn1ru5r3J6wguJf5bZ
         p0WF5U3jGWZcnW2cWu0vRDoUC3IuUfEqWAUYMJcZTdGI3yv9A4Xleh8lz310GNiB5Li6
         eGlwvAsRNcjyow2QNYwmgIacwADtloMtlUFEyRzys4/mqSHQ1qO1bqa+7L2zhwEikFLB
         UXag==
X-Forwarded-Encrypted: i=1; AJvYcCULHKq1ljNfQsUK7pvWgR2bNL9lb3u4Haa+YEa91w7UH1tbw+VIPBqW6kDgM9efwkHXytEbrF2ezNcgOnXLekGigTcHg8x/rkz1Szvj
X-Gm-Message-State: AOJu0YyI1yMWjeuSBlp49uiEGTcfI3isQn9gFWAEbtRlsBdNzs1TpGQw
	L/R/pipI7TOcdMjfWmflIjT2GRdgiTLfPqmN2OL8HnVOrKfU0aYqv8mO4BWMyLo=
X-Google-Smtp-Source: AGHT+IFCxOVGjni/Qou98ipUA8+WBVhug9nclkRA+OWW1zR++81o5emL3+a0SUxs0Okbnlo5TbFriA==
X-Received: by 2002:a5d:5142:0:b0:34c:f87b:f9fb with SMTP id ffacd0b85a97d-354f757d9c3mr1637122f8f.25.1716460964230;
        Thu, 23 May 2024 03:42:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501491c40sm516038f8f.28.2024.05.23.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:42:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ASoC: codecs: wcd939x: Minor white-space and define cleanup
Date: Thu, 23 May 2024 12:42:28 +0200
Message-ID: <20240523104228.36263-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523104228.36263-1-krzysztof.kozlowski@linaro.org>
References: <20240523104228.36263-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct white-space issues and drop unused
WCD939X_MBHC_IS_SECOND_RAMP_REQUIRED() define.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd939x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 201592c728c3..770bc2f35ba7 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -85,7 +85,6 @@ enum {
 #define WCD939X_MBHC_GET_X1(x)		((x) & 0x3FFF)
 
 /* Z value compared in milliOhm */
-#define WCD939X_MBHC_IS_SECOND_RAMP_REQUIRED(z) false
 #define WCD939X_ANA_MBHC_ZDET_CONST	(1018 * 1024)
 
 enum {
@@ -525,7 +524,7 @@ static int wcd939x_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 						      WCD939X_DIGITAL_CDC_COMP_CTL_0,
 						      WCD939X_CDC_COMP_CTL_0_HPHL_COMP_EN,
 						      true);
-			 /* 5msec compander delay as per HW requirement */
+			/* 5msec compander delay as per HW requirement */
 			if (!wcd939x->comp2_enable ||
 			    snd_soc_component_read_field(component,
 							 WCD939X_DIGITAL_CDC_COMP_CTL_0,
@@ -1869,7 +1868,6 @@ static void wcd939x_mbhc_program_btn_thr(struct snd_soc_component *component,
 
 static bool wcd939x_mbhc_micb_en_status(struct snd_soc_component *component, int micb_num)
 {
-
 	if (micb_num == MIC_BIAS_2) {
 		u8 val;
 
-- 
2.43.0


