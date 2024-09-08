Return-Path: <linux-kernel+bounces-320264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF4970820
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC821C210C9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E9174EEB;
	Sun,  8 Sep 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRiR9W5F"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF98170A31
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805320; cv=none; b=BsQgz5F0mu7k6xrXoynvUdMIWrLmJH31fQgOiTuVHauOH8bNWLz96OKsRJM5MTTexCSTj7wQ6Lyc2TjfeyaCOhLduQjbi+qeWp24h5uODRxErssPqdJFl8rd5CaPucl6/3hxrs7BH5TjQxR4Dbt22IQh+5D8ZIHr3jxFh2Z+pHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805320; c=relaxed/simple;
	bh=crUOVtF8wl03qYwZi7N/pIKnRz+XR7DUlbnH+NouxJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hB50wTnx1la6pNU5susUJyiMhZnMdIZAPsmWicX9W8HMJXDziN77BMoCWXOpVjqOEfKIXjyJcrLW3hu2Z6coJVU2PQbz6e5ftFbxnqw0okPhkQM72rmyU3G/JE36y2/XkuDBEF13xSeqGhTCjtmMbN6d6hWcqFUAhGQWLoMi98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRiR9W5F; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb0d0311fso1541585e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725805316; x=1726410116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB5jr1/a17Qw9RVDWm+OnjEYYAvO8EC+zVlD8qC1Kcs=;
        b=zRiR9W5FraBZvoaWaYMbWWn0056thBapSYjedIVc+jZIxPBtYCMlhFAZHXAjo2AbIO
         fWbRSOpwrhaek7wNS+sEMjrMe7r3/Bf/vm6p6mrZdijVxExNxypDvmT3WdRqRZnfued+
         AwVG+g4UToqXCh/CFwcBbdaTbCiW+GrSipfo5XGNWqxeFx+buU/t/vgnQbPgOj1u1Ob6
         +i5NGs1Ze+gorSl6iBUeYCzoLrNc+OYByZoIj1H0qkM3lKpp7jiOr6WSbEmCo5VdZ/D5
         QG0D/wfye3K5tOSgnWz8f6lpKcC3w96+Zvi6uRFTjH8T0rzhegm6eiJhBGBwPIGbYQWq
         MC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805316; x=1726410116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB5jr1/a17Qw9RVDWm+OnjEYYAvO8EC+zVlD8qC1Kcs=;
        b=Cj7wQwjXaCxaWON7XvptgVScwNsFJyENGJLUm7ngoKh19/vy9S4bipBGqo8ZGkNFHn
         2pxBPRFxG0JLvIMBF8EcrCC3D/vg9cKne1ZeUFhePXhRxz0fawCcSy9M0QZmszhSFx0J
         cbPMGxNY/7TXgzHtVfpBHVz1tV0L/NJebCMJJLbLk8cCNh2oSLe7XNwUMQl/nbgUPUB5
         TIHZQZivvWWNI4J8FmRdicf84LpkNrehdJ2iwnfPqlvLRImoS8AoWq541BffuEth0z/j
         UsGBJDt43/NfbHtLRFAM3KzyV232H5YTwwpbBTe8KI1WnylUz/6F2GqJxXVuzLgk041w
         mCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhPymPc+qY/8IkIeQ2P8fGTKMtox9pi5ChZLmwAmdN1QSDTNK18FzZ+f0VUG2KjEJ/artn3PuvY4425Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuY52tL9woe6y4tTmtBQAq26xwIy4d6BndnMZpbssMWbMLUtI
	W3vajTfgR8BUh4U4Y9PSDN/i8R9fQfsaesQ67NI4QlCgGrFRSJW8NLNUcX0q3O8=
X-Google-Smtp-Source: AGHT+IEFghUIs3JLLMCLIc/+MFj1+yQJjFDJp6mNzr37xyzU8YsLEL/hiSYgzOa7b690ExU9/x+VRg==
X-Received: by 2002:a7b:cbd6:0:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-42cb55f1448mr4842685e9.6.1725805315297;
        Sun, 08 Sep 2024 07:21:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm3465092f8f.56.2024.09.08.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:21:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 08 Sep 2024 16:21:34 +0200
Subject: [PATCH 4/5] drm/mediatek: dp: constify regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240908-regmap-config-const-v1-4-28f349004811@linaro.org>
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
In-Reply-To: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=crUOVtF8wl03qYwZi7N/pIKnRz+XR7DUlbnH+NouxJI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3bL2WBZUZoPTgLGvdfqLUo2h9AY+9HYWr/Zzr
 GQDQ8pK39aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt2y9gAKCRDBN2bmhouD
 11ZXEACa9khZ8BfJwy1IrIOqvJtmn/fQUMm0z7B3JpGGWvxswrY4bTvTiuOUHGXaWYykA2sKS5R
 /mPLfJixbQ9smQsZ6KU9jCYt0xkLABPMIGAon5DUsQaslCnvbwRBUmFPSOolN2VVr+JFcKGGiwX
 UXBxY+kI+IvA4OG2cqdk4SWgvA0E6Zk/MbmxeP0tQSqOw5zEKAWPU5Z5N4VsiHWBR5Fi4LX0Q+r
 YUwHWlud1iq8Zg6uxf2Uaahu+iHdqsTl8uoU1LUloB7rRNSYEA6MMGquVGp49NxXDT6+F2OlkM7
 ZPpM0YH9fms45q5055fOBsjsvrFv09qSVrXm25l2bmG8MbsOPplxoXHUZ1VucmWYJP1H6RN6+SM
 1MHCeFao243tZxITkw+SH/6X+hFgH3e1mDg31NDKulPxZP/zLJ9d+nJES+SMH3MuDEVkvEjKzIY
 SVEorP6+8K2r5h4Q9pooSy7Lekdhg68VA48BeW2/htj3tjFV6GgEwBRgAntFq/BbwivXmdjzgT4
 71R9akZCVSJxErQ/p8HmBvpSWsgSG/KUo5PepF0xsY/ekvLVh8Ntlpoawlt1EWRqKQ8JIwa0FA/
 UWNdX/v8HqKnFADlWwBpeo1cTswqjmKt3tuwxJcXppAgilI9oAHbyHxbEt+Jtur8WwPsWQpH+Mq
 GFKo3Js0eafmwbA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Mark local static 'struct regmap_config' as const for safer and more
obvious code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d8796a904eca..f0f6f402994a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -311,7 +311,7 @@ static const struct mtk_dp_efuse_fmt mt8195_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
 	},
 };
 
-static struct regmap_config mtk_dp_regmap_config = {
+static const struct regmap_config mtk_dp_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,

-- 
2.43.0


