Return-Path: <linux-kernel+bounces-211886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3E905857
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3240528834C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5318308C;
	Wed, 12 Jun 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHUk6gdY"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0721822D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208955; cv=none; b=FTtt/+Posc18W5pdqG3iff+OJLDYXrxdXh+BS6QLqh3tKNt/A7wOOUsNggeIdjfpKl7nxuxGlWahAeaa/+RLdN4ftZgN44z3J4pQCK5H8S8cMmAG+vJ82FxXfJ/U7/7exLnisDfI8MHvTVhg1iGRfs/o0WhjvfWYP01yTngNkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208955; c=relaxed/simple;
	bh=0x271Ao5g1756MkJM0YnZ2eY6hyaiNB56Snmlinm2o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YEAOX5rWNjz2qEgME0xn1QF0YIUNIA3AaCm+DXBpMQ/K4oz/vfyNaP89iFiSXzoqrIS6ncApyjmghAEO2NtV+tqflrWNFXavpX0GgLpKjdkW4drq2v7wx3/es9V6ZgqpfaQBnQBT9fvDZn2+A4Ik9ePZAtzumVWrZj8wcJi9oQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZHUk6gdY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f176c5c10so6354266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208951; x=1718813751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSj1wRbpqkX+8+PyNrcUZX8/G9u8adS5MtyYj32OWN4=;
        b=ZHUk6gdYE7HhjTmBD7/pHKC/QFxNrgivpH3Kgu67gBOn6bb3uWUSlYyNWI8OFb3A2Q
         aVEi+LmgfQj35KHDZydjv8aYDeqxQoEFilnwh01D3SDRG4veErdGF+mbzXtU5kVQh+A5
         0BOy4hFngB8MPZO7aFCZbrnXM7KV4NWQzG/8jw8omS7vLemB+fxtydRL7Izg4+oFNp3H
         mlNV0qOc7giXGnE9AoNyqo4S9cTBjpfgdBQ5Ma4HNGzwAIM9j58dEO6NFcdOAv5gPM86
         r2O/0pqqG5hezsidXydfePTRpSfmM76QekK+TszJPYmGSN6GwkJZgkp8REQ6JtCrz/pF
         UvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208951; x=1718813751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSj1wRbpqkX+8+PyNrcUZX8/G9u8adS5MtyYj32OWN4=;
        b=KnXeJ3gor9TUwkhwAx+8puHoxYDI8DomMtELoztxQbAwVQoylrSGd8y8c6FA2eDOuw
         Aa+P4xwwe7OjR8L3Y/hxRFFzSZfHs6bfcnOfq2VC9ZKeKDT9Fag3ieN27BzMBa+d/Gvn
         W+eHbd491YG2dstjl99gYCtYeuGqnV1aG5E1wwyjzsg7icwnvWQvXKywy6IF/RZtEdjw
         8UCdG28eiV1EMBlmpLQoUb+mKlLJUwG8wsTkGd1Dklf8fDFCvDQH1UoD3umWv3iqSFK0
         kM+Q3h+LEqnPgG1O3P5+qQgD0DqyeKyOBJqDCpZr0GyqRhUTvt9mgiEOsLKOypHu7u/w
         IgbA==
X-Forwarded-Encrypted: i=1; AJvYcCUui5HTCA4Dl636XT/MDxe1msasJOwHhCvxRTs1IARTARdLbp46ulots70IN26XH/ytEju1h59OKg0n/lAPk64B4CBt/zrYJZ6XM5lz
X-Gm-Message-State: AOJu0Yzds027qtSdjgLmniRckgWzhRVxNhv4o8RkzqMrOksbZMIKsilg
	/LvGa4iytcFfmSYnYAi1jkUZd+z55S+fi4hAk1k7ylUhZdwXsKfHkqJSSLomg14=
X-Google-Smtp-Source: AGHT+IEV+h2vbFgATGGL7Df9HCn4pV0I/mu2nGi8vVCTHaKKyDaxGp2hEWUoko7ZRX+TvbTeiXVv0w==
X-Received: by 2002:a17:907:7208:b0:a6f:51d5:ef0d with SMTP id a640c23a62f3a-a6f51d5efb7mr24161066b.60.1718208951530;
        Wed, 12 Jun 2024 09:15:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:20 +0200
Subject: [PATCH 07/23] ASoC: codecs: wcd934x: Drop unused interp path enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-7-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=574;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0x271Ao5g1756MkJM0YnZ2eY6hyaiNB56Snmlinm2o0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmdGHA1Mc5AxCcNSVn2jKSCaXp7KokuKm2d+
 NCQKnMfgTKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJnQAKCRDBN2bmhouD
 1+lTD/9nG9SnZKzUodnBZ9jKxGLqAYbuAcS95yXfKwvzL7gcFcHTqWYYRmWfOkUvUdXI0oY0gsm
 f2e1nkk0kmT0EkLmhc3iqNtQyJJoyUIPl39A/Hb+F1xHJxJEKwD8ClpD04ZOk9ttcSFpL0Rp4My
 xMc6F76okJKgmFYQEkjA+076pxMninW9PZsJ/7+4pfSHl53ZvN7OOVTnV8o+zztUXXh4ENPaRK6
 NT0hxYfYW87xM8IDjxSoZ/gfah56JrgpkuJsLcuqnyOUax151rXLuTUSkMy229tfBykSVlnEOeh
 COZ6QUszw1/K+kOiHIuCvmIDqxbm/AQzJ/F8Db+NLmZq70RX7Q34KQlL4EUCUVyZNTjLxv4tCWx
 yPMnljYyvrsk0+Qt6t0BgyBpHsok0j2BNV12pheUwwHxfU4yQ9DYPDTRvgIPokPcGj3ouo8zL31
 Voqe+7/fffZVwBdpxp7wSgQCYoipHd9JLt3a8i2dne2u2J00Dd6TvCEP3EAzZ8nz6fsuOrlgvkf
 +tuImGM4u7PgBskHjQAsbryVbBayat5FJ9aHg4H2nc0Qd57pkZa7VXPubWcDPwVaX6/IoADkNYi
 aUHwj8pgZ4b+vIJnI2FJyeg+Uz9KkrJMvaYbQySUq6Xr1DWkeXOSHpE2uYQD6NleQs078936UEP
 p6r2LGdNa4noAmQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The enum with inter path is not used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index fcad2c9fba55..cdb68f34e55a 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -475,11 +475,6 @@ enum {
 	INTn_2_INP_SEL_PROXIMITY,
 };
 
-enum {
-	INTERP_MAIN_PATH,
-	INTERP_MIX_PATH,
-};
-
 struct interp_sample_rate {
 	int sample_rate;
 	int rate_val;

-- 
2.43.0


