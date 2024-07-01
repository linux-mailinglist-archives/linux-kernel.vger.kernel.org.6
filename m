Return-Path: <linux-kernel+bounces-235694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A67A91D87D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBEA1F21F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD344824B1;
	Mon,  1 Jul 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJGwj9c/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17F5103F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817366; cv=none; b=utGENfd2Ch5hIH7JrMx4jhZcPTDKP6RXeTWj4Bpb4vknOsxbtV0crq+4MnDv10gsz7MiA0EvhUiYLry9AxcE3pHg+C5MBXnnoBLWXF1LylIy2Ktc8YMv6fzJNpjlaGAZwiD5g6m1Tn8ZArvmMNVIOhqT7SXmTuO5bKB6+4b+hLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817366; c=relaxed/simple;
	bh=aJ1LZosClX5NnP0cJXhnk/NVUavVqkeU0v2SDbbuCfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltyL0FRBrSIVCNKZL73TFhf8JGFlh+1XUu3FG9J5jBJrG+34k4cdDWQuRRCmuhotlPKXBYzgwsPoixA4SZEMbkmNoivyrbaMu217D9cXk83izZzF9d06ng2oQi7jVB4Jv9On+2NqvcWSXoVtPVvSHgB3WZdKr2+r2XESNyKmT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJGwj9c/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d10354955so3136501a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719817363; x=1720422163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMJ9ytIbd8fpZ+zpiTVxchehIRD6mB7COwsKFHn30yI=;
        b=tJGwj9c/tqICWraCp9z0ytaRnu5yRSRO2tZA4+tV2bv6v47mm3jY3Rr+LFy1gr7Sxq
         kvCgySZSfVNadga8gX8ALZLHA1A9YJ5A+YpOkRkE25vICgjVMugcsLRjEv9Y/Oa3fm08
         gJkErZq+n0M1wpZOJxelR/jmabSt3ZPCVf9yrfYmMVdCmpdbF0ObayUT87M0rtVtMa2b
         R4lJh2/HMY4Pn4klHSCJRPgq1ReUb0dV5GLtRix04fNxutYJLPLXaMa+bv4xnbsW/ri2
         tvAfl4C5gxGsDZZm2aXfHhHOlP9uW/sQiBAlybDBoT877lyszein7KsqL/58ePEqyjUk
         l6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817363; x=1720422163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMJ9ytIbd8fpZ+zpiTVxchehIRD6mB7COwsKFHn30yI=;
        b=bBiyaKQGXWwFfnG0ldDCReeuU7Pm370w5I328Syudg2ET4dPJiZOSU1w+CMdHVFwEp
         d6R8LPhLwys1FreDYeT7cHCwgXMGB7TfLbqXp2La5jOuC4BVSnMuKXFLRw+wdkHrN4k4
         eUyVMq5Qttlfn8jIoxHVAFjdzauGwSOFJMuFjLOCQIEe9VTzfF121O/5VMoA2PyOgrzh
         Kd0Xun4PAGPUcLD1upzSFcByU2NCteu7DvABjkUE7s5LlS8BHy1oU7LlifP+7Le6QQil
         0wstS8H9afVQIIteCg5th03wa7b941i4bPYiME12SbBBcXDGrbxe8wSxh2bhH0W1R0gy
         f48w==
X-Forwarded-Encrypted: i=1; AJvYcCWkzgRiirRBih0fAMiyiq77V2wXrCY4Kax+QiRCt/JalhQEl8RbvmfHI8Xf5nMt68Q+yRow6zE+az7EJkZlxY4zyVJf9OGF2QihdVNX
X-Gm-Message-State: AOJu0YwXu3pyuqHIQ4TvbALUyDOMpYrOJpziIG9sT/oUBR7G7XXIliEE
	tuYc4b5zJDetHvli2U5ryU7nLs7ce9Z52fy/E5GAbRBTVCfaduL7krDuWZJRYKs=
X-Google-Smtp-Source: AGHT+IHR5yOOsqPZFJrRu7Wk8J8cXhauusw1meNRgDWk7XLLZNs2DncjjI+qUlPMsRkkGHRfGt2GEw==
X-Received: by 2002:a05:6402:5cd:b0:57c:c10c:eee8 with SMTP id 4fb4d7f45d1cf-5879fa7f71emr2584654a12.19.1719817362830;
        Mon, 01 Jul 2024 00:02:42 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f036sm4034383a12.34.2024.07.01.00.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:02:42 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 01 Jul 2024 09:02:15 +0200
Subject: [PATCH 4/4] ASoC: tas*: Drop unused GPIO includes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-asoc-tas-gpios-v1-4-d69ec5d79939@linaro.org>
References: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
In-Reply-To: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shenghao Ding <13916275206@139.com>, alsa-devel@alsa-project.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

These drivers all use <linux/gpio/consumer.h> and has no business
including the legacy headers <linux/gpio.h> or <linux/of_gpio.h>.
Drop the surplus includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/tas2552.c | 2 --
 sound/soc/codecs/tas2764.c | 2 --
 sound/soc/codecs/tas2770.c | 2 --
 sound/soc/codecs/tas2780.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index a7ed59ec49a6..684d52ec6600 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -12,8 +12,6 @@
 #include <linux/errno.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 1dc719d726ab..d482cd194c08 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -10,12 +10,10 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 67bc1c8b0131..9f93b230652a 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -14,13 +14,11 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/firmware.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index a18ccf5fb7ad..a1963415c931 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -7,11 +7,9 @@
 #include <linux/err.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>

-- 
2.45.2


