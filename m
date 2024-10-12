Return-Path: <linux-kernel+bounces-362271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EAE99B2D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326EC1C21799
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52C14F9F7;
	Sat, 12 Oct 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFpjKRER"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2E14F9CC
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727806; cv=none; b=U0x/Qz2PSWglRy93V7nOScCE5006KoF3yaeperUjNe0C1xZf34CRiplcGF03TSlfDloteZwsiGE1wKNsawV9+SHNYQGAWMttm4T3ujwc0p9B688ESLwVEvFWltr0kAwqQcfPg9VfPR64OES3SDxPb651MBudQ2dcfjdz3GegoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727806; c=relaxed/simple;
	bh=/N/JcDO+6CWWbhryzqtCbbOf8//DbO7y9enT4qub5c0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hn5sI2ptrD9/9FD3S97XTTgfEHWP75li/lWGsv4GDbt3ehqlx88HQgl4Yaoh+/m8ZdsaFsfe12mS0OfYiLsOQXvmYGIJAgAGL3zSTdRr6iz0PGibZViNaa8jNtVOLF0566PAhJfw+A55BXvKpoxmB3noy3bGew52TrxR4NbAx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFpjKRER; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4311b5e4eb7so1981815e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728727803; x=1729332603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGmGeTLwIiqZ3Ze1waxn/VoLJ2wqz8u5IQzeHL1oriI=;
        b=wFpjKRERnB2paY83Ct4tKt1I3G/WP5G3idq+HG+/U0IOKXcuzJwwDv7kWO7vY0qpaN
         Ar1G7MGvH6fThVWOANkUFeC8YFaQoMm3EXt0ea3hD5d8vNphLqzhhAg+s8ocfRuprRkB
         o49tq5JZiLEVpT9t50GQ/sflkiVkJW4YLuCAqffeAMJuC8DoAHR91w+12tfU32td46Mo
         rJ7H5/uW6ktoJX/oqmIby469jkghA1++wLURC3uMcXhoGsAZ9v1diRpBvQ5sRM3dKKh7
         kSJA7ofwxP3Oy4lyBmmY3Cj3Mt4bVizk3xDyjeATbAVoXWXKdauvbr37xjDNLIqGOYAG
         yiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727803; x=1729332603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGmGeTLwIiqZ3Ze1waxn/VoLJ2wqz8u5IQzeHL1oriI=;
        b=mBmJZUDbleK91rTMuLCbuzN4+7EqkU0POBGg1E+CZ8tMbLmmNtJ9ZJZ/AtOGL7QJBj
         +NzMxFEhemdgyUq5husLwgu/viqGKwIx4pRuQkmdcuZRxG5RL180rVD+s6235MR5ckz6
         eYUlvbeQEh90JutAaR8KbrEBw6uxIsEQPiT6Q2gXAs5XO/rLZl7AjzZ7jDYsyn61auHo
         xPgF2Z/LJPsbBvu9xvA6xtzw/NbCPymgtp5I85WOvsUpmZvzREF3ZPdCVmWs/oU8zgqk
         FC2/ceX8p9ayjEon8ePvuLxpu38LvWU2UjIuXY/1cNKCatRVfnZIdpNWVXoSXUKfyJLV
         aNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkI1UgPKOmTXM4PyMSzOgcNiFkrDeFFB4B872vXW922zvMsDa0YN6NuILOPvoyf5Dlld50YeJ1TZI+QLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVj6tId67+i/jjxtA1+z0y6d0p2/z3h6vgcRS22n3JAofmKv/
	lW/bZHcb9F6fzeEPPv+wlEHaRf1qfWB8hQ+3OWGgmVD+A7GC9Puq+cdihFXfXjg=
X-Google-Smtp-Source: AGHT+IGOZaLCfa491XV9D3GxZzkODzZuwV2ZBJ7At8DabGFGe+8w2Ai750NiESQ8kKvTi0zY0Y95eA==
X-Received: by 2002:a05:6000:186c:b0:374:cd01:8b72 with SMTP id ffacd0b85a97d-37d5526f177mr2119893f8f.9.1728727802978;
        Sat, 12 Oct 2024 03:10:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfcdbsm5963998f8f.58.2024.10.12.03.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 03:10:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: Select missing common Soundwire module code on SDM845
Date: Sat, 12 Oct 2024 12:09:57 +0200
Message-ID: <20241012100957.129103-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SDM845 sound card driver uses qcom_snd_sdw_startup() from the common
Soundwire module, so select it to fix build failures:

  ERROR: modpost: "qcom_snd_sdw_startup" [sound/soc/qcom/snd-soc-sdm845.ko] undefined!

Fixes: d0e806b0cc62 ("ASoC: qcom: sdm845: add missing soundwire runtime stream alloc")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 762491d6f2f2..3687b9db5ed4 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -157,6 +157,7 @@ config SND_SOC_SDM845
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_QCOM_SDW
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	imply SND_SOC_CROS_EC_CODEC
-- 
2.43.0


