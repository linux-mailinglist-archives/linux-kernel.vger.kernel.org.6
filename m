Return-Path: <linux-kernel+bounces-233713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE691BC03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31E0285880
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1E153812;
	Fri, 28 Jun 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4UX/Q3F"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E54153561
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568718; cv=none; b=fV3VDY8yXSR/2LMQY9GO9p+nh9Dj5ofvlC/Cqxw8XIq9jLwfGFV7hjpkhqFeKOZrk3o5TCWgAH5p5m9LkP8Nfjgt21Hu6BZAyUxy/gSBgBBei4+mwPbGLCVz+/Qq2XScsJ/y5icpifprFclcUqLEIW3kXxCdSyT59hvmtt47K7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568718; c=relaxed/simple;
	bh=ucYPMV442p30SxLxZMrLgQRWfuQy7jPceEvUT16eTtw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GVx7rsRDaddlI0d9oQ29NEXBbAC9uTf5T3Q2qI+MpYOPiyD1o5aotSUZ1G2W2vhz+8V0PCg4QeI0/VM22VrxMX8ScQFX5kRQzow3VGmD+fcs8T/zgLa6sdHRACiN+xyPvW6rkg16Z3tJpaXbKASXn/AbA1pbfwIt0ZnXD80U4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n4UX/Q3F; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367339bd00aso350913f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719568715; x=1720173515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCrcRP7t2cWM1AO0t9JWEwOXAFYL4HbHcO1KAiAVOo=;
        b=n4UX/Q3Fw25r9RJRIiruRO34OmYaHSAnDVnilJShlC2vhOCgIla8fxMUxD77Hv4m2z
         WcDYjHuZQ3gTlZ41fcJFGkr6wmj84Rp6Zl/YJZhqkXsPkRQyYqGIB/f7ihg68CTkdJ0w
         9XNSy7MonqTt6C/19l1eQe7jV/6vYH9GuLMcx3RatAa7WE/QqdUNF/HOKSJXyOaZdgTe
         FNKq+ab0cWjx+zRJM33QKXbYx6CLoD+THfcvCt76/r3kQx4tEZRGIhPPrgeNTJLnxXFg
         vSsqMdJzSdt84CbKHqorHPBc5dvSfvrcroPJhqfgKd/MhCsh76Yx9nmF7moP3o1zi6RG
         j3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719568715; x=1720173515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCrcRP7t2cWM1AO0t9JWEwOXAFYL4HbHcO1KAiAVOo=;
        b=F+8eSJijtaY5OC8w0sLltAQJDg3J+i1RqqksXz+Fx+nCpV8QlLCNukMU5BTp2AvR59
         oYMZg9FfG9TZRvjOI5UPysdNbh5CIsYxVbRHz5RWxoWVXRaYKKF19LkPPvoGhbEOdu3H
         /5o/ICC2FQtsB/52XpDAgDDD+z5saTtN/WsU7KeDBWC7cnZ8u9lvOxAi09+dAf0ZyTU/
         /blIfKB2/eE8EKfyvkLsdy254em58Uwy+aw4ewcr6qb4Tngf9OZHO42yoi7EizbgBuIj
         NMYQgqxQYc6W5qRn7JjTVzNCl81ZxT8leajCy/zKkSvDkgG1gBLGGxt0GFbfCBT9FwfG
         7y5A==
X-Forwarded-Encrypted: i=1; AJvYcCW/KYlYb14ncOvaqDo0f4vpuRrurMuxyXQpJqNBJUAyS/o2efOqhymeNxR0jFBFBv5x3XPwdEaO3/vNavH/L/D9fffIJmYQXMxcPLTq
X-Gm-Message-State: AOJu0Yz3V21o701a+yYq2PaQFwu64smlkEmUw2nIt5sGQVlrQk24uKqv
	RgNozEOjpOZ0ladXvrISTJgHEiOjvv0AehRX7mbcfarVmSt4ePNdSJJ1Pmc6YH4=
X-Google-Smtp-Source: AGHT+IGj5zErCya6zo4TRvSCsMgDrJeZu+46l03p6bj9wmdPmAbzwhqn1j9jubXkm8l8eNFE6EkAUA==
X-Received: by 2002:a05:6000:156a:b0:367:434f:ca9a with SMTP id ffacd0b85a97d-367434fcca3mr3973868f8f.0.1719568714852;
        Fri, 28 Jun 2024 02:58:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e13d4sm1760802f8f.56.2024.06.28.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:58:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: codecs: lpass-rx-macro: Fix using NULL pointer in probe() dev_err
Date: Fri, 28 Jun 2024 11:58:30 +0200
Message-ID: <20240628095831.207942-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'rx->dev' is assigned closer to the end of the probe() function, so
the dev_err() must not use it - it is still NULL at this point.  Instead
there is already a local 'dev' variable.

Fixes: dbacef05898d ("ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 08308a63d1b7..8d4a61f7debc 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3843,7 +3843,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 				rx_2_5_defaults, sizeof(rx_2_5_defaults));
 		break;
 	default:
-		dev_err(rx->dev, "Unsupported Codec version (%d)\n", rx->codec_version);
+		dev_err(dev, "Unsupported Codec version (%d)\n", rx->codec_version);
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.43.0


