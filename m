Return-Path: <linux-kernel+bounces-392590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF29B95E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55981C21E08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375E51CC158;
	Fri,  1 Nov 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIxJvSEr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6E1C7B82
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479929; cv=none; b=FF0SVdAuAtWsYi48wBEoVKLXK0kuA2JiTCtWko44/iVo7E/7u+hSY1krCjeqkm8sjCCVuAOWCdJrQqiMVDf+iZhCx+TfonjnjreWP9qkiZgTvtldbVv1+5Sa8OmoKwvSA3XcWjAlhss6OtYx+v0nGscjx+HA0bfCYTe4tfydeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479929; c=relaxed/simple;
	bh=0cI4Druq3wgMwpIPC03lQBTwMFzExwhpaf3TyJoH828=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9cNEhW1gB53fhKkqKJNPY0iCXP5pwjdtQJan0YHHunhLgw1yCY0Hy42sdBhLfo/5ci+WhdNiUEa22U3HoR6FJP4GSmuGtSj1+5DgoKCAh1M1CGyfvyidC7HxMYNibnPO4auPFaO6bw1L/HmW3P9hJ8xWqXwU2S1QtP8QH9pEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EIxJvSEr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a139be16dso37468666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730479925; x=1731084725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIgFE8ajZMpeiAYpHYnBzqCc2nrL9qems2WygOLr4KA=;
        b=EIxJvSErlGQfUuPSfVH+4bis9Jd/eCI4oTLmCXsB9mTQNFlF52LQ0625J59+3AGobb
         P7tovIOQVZFqE3eySd8htYCHz9jDAoIgvPjF1EpSAAve/paO/IS4izUmLqEd+KckaDZ2
         jkAxGwk7LyFemrmacZ9PLCOUGLJfyKMvyOfYJfCT/x2R8fbOZddM0YP+4Ei7SztZYD6q
         WruKSNkAvX+HkJJ4lrkcMFChykDe8C5XXCWx58AKHFyV5mj4XBlVurzR3C2lTyma94qE
         gRZCARnI+1h2m5AnqiDuRUYmmu2aoaX+31m360r0ReVbf70DhQizXCf34kESo9lXeb6R
         nMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730479925; x=1731084725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIgFE8ajZMpeiAYpHYnBzqCc2nrL9qems2WygOLr4KA=;
        b=YsfhE+Cbeil8bN+D8XdOOeMbUOB9G8wFATLkdHp2cBpifZ+oCQUrRBOOczAwdjPtKE
         CnE8Rg/D890nb+QkIGPqNSt0CIEuoIGWUF7EryTTdSbr+FVIH45WpV5YmqaeaU8p5DSf
         dEeG9RdpJYGFgP3XT/UxsB//qxBuBcB4oZGUZdbaBsj5G5vnC4sVoZNVEYmXgL03ORit
         BR0BdnsomEbXuV6D+wWnRk4hLfGz9shi1ljT2E0YZGN/gUHeP17a2Pud9YlfkxEEl/r9
         sF/AGG7UtrA4qEEPQOPGEENLkOLocqIZwcy2UUuz+nQtQso93kd0tKhkDrdz7g1A7qEt
         azSg==
X-Forwarded-Encrypted: i=1; AJvYcCVwF05xW7PiOrGXi9aP8pPqIwzn7NUn3Y4p1Ro3/NXn6YVV+vsgXxcaGNKr+lOxsKForSgOu8O2CPugfNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54SwWrEuBpibeWy92R47RNg2oZ1Ujwmlr8hw68LuCL+YlToyH
	XlDb98rWU98SY3XkiO3Wq71arXRsxsN4mRKgPvl5fGbpBmPGo7mmPInX5m6wask=
X-Google-Smtp-Source: AGHT+IEvUE1QdVJCYM6Vp3B7nB2TNby7k09UhE2S3PtVGATUzFJeVEY/1uZAt6ol92DJsS0nXER4lA==
X-Received: by 2002:a17:907:7287:b0:a9a:1a17:e1cc with SMTP id a640c23a62f3a-a9de5a4a878mr945085066b.0.1730479925286;
        Fri, 01 Nov 2024 09:52:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564942b1sm202087566b.5.2024.11.01.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:52:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: sc8280xp Add SM8750 sound card
Date: Fri,  1 Nov 2024 17:51:59 +0100
Message-ID: <20241101165159.370619-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101165159.370619-1-krzysztof.kozlowski@linaro.org>
References: <20241101165159.370619-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add OF device ID entry for SM8750 sound card with its own model name,
used to load proper Audioreach topology file.  The sound card is
compatible with SM8450 and newer family.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 922ecada1cd8..311377317176 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -190,6 +190,7 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
 	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
 	{.compatible = "qcom,sm8650-sndcard", "sm8650"},
+	{.compatible = "qcom,sm8750-sndcard", "sm8750"},
 	{}
 };
 
-- 
2.43.0


