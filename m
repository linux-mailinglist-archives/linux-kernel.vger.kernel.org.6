Return-Path: <linux-kernel+bounces-239436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B09925FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FC61F2319E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDE17B436;
	Wed,  3 Jul 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEWc08Jf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157D17A596
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008680; cv=none; b=G8LXHdJRUQ5yLg8z1bcPD5SXPkyHaZh3Jo5aoBwjcr/TefBpA+kkaNNVh3FsS6uDfw7FSyHlmr7zVRgQc3NOXVgseikw2gvJtJPLzU+hstTZXdt0nxyv4YAQGCOSXBfoJ5cS6umOSFySca9GZ+HKVH8B4vQgQCzWCjPQ1Rmfb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008680; c=relaxed/simple;
	bh=DS/IDp+LqdRHE3mvtnrgUtVAz5GNkmhuj8B4aFV9euQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6RBNkHjonzF8ZUzLDf3oBhIcs8D+dafqAf3ofS+wFCFR6eBF2KH7/24jpCwUtnJ+ouIj90GcxRFHCvgViLaJSOvOO+UIjh0i7mwKo+zpiuC4orphuM3m4y7AAsjgrrl3pbpg8EwEdHWU2yGgHiI/eZzaALHq6EH+Z+0nW+zczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NEWc08Jf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso40996655e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008678; x=1720613478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V81m9R3WE5N86wntgnBniIBHNui3TaNJXIYWRSi4OAc=;
        b=NEWc08Jfo287bKYKUUiLpafzU0NJzbN/1pl6uojLyyuZqEmkw1yS+f21zDOWmYV5Bs
         ysEII2kxEdgw70FuT0uoovFsu0cqmeo8fLO1iRqlR21F7rHTsOJSnKHRP2QlOBcpCVt1
         eli2b3LQb+hWTtky7Q5K0EPTqul09nv6NNu9XUTQJaUIs9M/rkeS5GJ3D4AXL9IqJXpB
         GoCmnhDjvC+ty6XK+zE5Hi5fXqKvjZY3P4G9kwBQqaq0j6FIi3JjKLG7g+v7MXj+Jjrr
         tydPu3bl6rfxhMYbl8M1bX/ki3oTyC/tvZA+zNiSqUgmBfdbkMRQ1XoEE4znF+ltIime
         xb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008678; x=1720613478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V81m9R3WE5N86wntgnBniIBHNui3TaNJXIYWRSi4OAc=;
        b=TKkiik0OXnroQvIVKhYnskr2E3jU/yyzliE2lyd9cvI64Yh+PeRsgQdPEnGrqIdaS3
         AkKdyrwgMMBz0uQcWD9w0PpbtUMjkir7kVei8xF8C40VSbD7Xm34nNbHJQYcCPbZou5l
         rtA5IpgAZtSsr4LXwPzLvPzH73FYlZ2WaQO0SgI5GsvmFntP2vZGABxJT14ti4lPtJWm
         ZHh8P1E5v7VuIZkPN3TTwiqiCaaV9onrvHldbygRoXUJ6HZHtOclItsnrCMGS1XreXwm
         yNYa3LXSyW4+Gktl8/vPPIpeyQwx9e4AP7uB0LDQ+gWCDLXMYiCRkN8o6nBYngdun5LP
         +Myw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9YwCvp7XLD7dKqKTiJ+jZfmuLn0kqtBErXg1Zl86ggR24CKnWvmqgNJaekFgmynliG1PVuHXqIz7WSpOGRgNW9FYiQK3u41kkc9b
X-Gm-Message-State: AOJu0YzRYVjOQBiD7NAJMwZ0dxD4UXDht85R8J9RNxCvaMK0LXvP78Re
	nklW9rZEOYgWm0ZdD1tS1USpUMq/ECwMIKvXDU7lSndaVi5gGAqsFcOPPCM0Sbk=
X-Google-Smtp-Source: AGHT+IEy3cvbIPXgRehmrxbeY1VP2hPk71QJIpRF5k9fYxa9g3eh0P0YLDcrqZVRfqAtmQR/bgW1Eg==
X-Received: by 2002:a5d:58c8:0:b0:367:4d9d:569e with SMTP id ffacd0b85a97d-3677573211fmr7148838f8f.71.1720008677736;
        Wed, 03 Jul 2024 05:11:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 14:11:00 +0200
Subject: [PATCH 06/11] ASoC: audio-graph-card: Use cleanup.h instead of
 devm_kfree()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-asoc-cleanup-h-v1-6-71219dfd0aef@linaro.org>
References: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
In-Reply-To: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DS/IDp+LqdRHE3mvtnrgUtVAz5GNkmhuj8B4aFV9euQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/WXyjhdMmNo0GaMA/nQmQHmNLei7121GkMX
 9CXdHbwkg2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/1gAKCRDBN2bmhouD
 1zySD/9moQASzEdIyJNIMW/1XTuG74QTsA+WHBfP/SMJNsQ14mbjd5gXLpmMxWJ5nTj2Tn3HvqP
 FGGryHmFFr3jexVUU5Ueq8LvG8EfsLNZLrGhJQdeTGo5CPdCR00RvhkIWBBzvT8r3ix7fltedvS
 KD79KoVa6+ARsgBCqGNmzmfaiUjsOTIyfzG4BX3lHtBoJ01r6g2HhjStY2Tp6xvqQlHvG8S12md
 pBW8QUI1YM+gk6L0L/wSzBMIb6C5q7aTJpRjY4rAP5267YeLa/m994LCzRcjHz8DYihyO3AlxfX
 wvrHCLk89XyUuS+LavCeHanMxHB0/AlaEeF8eE9vtudNWKrTFhQU0w26qVqWHq9lVw3C+jqqs4x
 GgpgQgl6k3QzHJQziZ05kyolA/N0hPYuPGBUGxjgJZVn4/q8FuaB4VYlJfmocBRNJe4kYJnUqXI
 5azhw7+mDi7iJSMQe1QazVFW0Q8M5JuEc6lRRggJ8ZH6+lTqnUn6UtPM4EQGzqytgduJXtaXm7z
 XWERZodnnF9NJ4B3YEaCO47KNoW/ZRxGgXAviKq7L8U4uaxuKV7Qgvk2rLNaqzOKAkPV1lzcmLO
 0s5ffkOj2vDYNcjqLFht/W2+R8i97qRsLWTf7l9GWinkLTZSaTTJYXVoK0fhKqpjTs4eM3roqP3
 SVE73xekq9kTZcA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h, instead of devm interface, to
make the code more obvious that memory is not used outside this scope.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/generic/audio-graph-card.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index acf7d92d21e6..3425fbbcbd7e 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -7,6 +7,7 @@
 //
 // based on ${LINUX}/sound/soc/generic/simple-card.c
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -573,10 +574,9 @@ static int graph_get_dais_count(struct simple_util_priv *priv,
 int audio_graph_parse_of(struct simple_util_priv *priv, struct device *dev)
 {
 	struct snd_soc_card *card = simple_priv_to_card(priv);
-	struct link_info *li;
 	int ret;
 
-	li = devm_kzalloc(dev, sizeof(*li), GFP_KERNEL);
+	struct link_info *li __free(kfree) = kzalloc(sizeof(*li), GFP_KERNEL);
 	if (!li)
 		return -ENOMEM;
 
@@ -628,7 +628,6 @@ int audio_graph_parse_of(struct simple_util_priv *priv, struct device *dev)
 	if (ret < 0)
 		goto err;
 
-	devm_kfree(dev, li);
 	return 0;
 
 err:

-- 
2.43.0


