Return-Path: <linux-kernel+bounces-538894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74AA49E76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79622189873F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9081271297;
	Fri, 28 Feb 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSR635T8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC926E140
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759277; cv=none; b=ePYA5Z1pOqZ0d2GD9Jp2fBYvgz9R3B2QPEtRcTleGsV3sIKAvS1bS8IPqmZGosy7o8cNTKcA2+a4h9HNpjWSKtd9uSyQRvsbDRhGp5KNaoKq8qPWZmC7UnibOw8GbGrHx/SbqljrkJNp1CZ2lDZBzlMe1WGyjJgG2YLm3n+2Z2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759277; c=relaxed/simple;
	bh=TsOMlzyWGhLPB8XA0OFllVNotLhXSAWLfRCutrm2gDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cT4iO/C/hjlUe3vsjyC/ovhayfvtZgDwjiqVO06yIbNkni+uqPETq7CAcEEQOSaBJ+JssOE6URUEPx9CDIS5hnLQqvjsRD4cm5570o+HojYJBqadSfny7bZmBwDg9uLZgsgX1qu/HJexUTUGXgpYBSY7ugWfa37XoTXBLLvLW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fSR635T8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so22494215e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740759272; x=1741364072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mA0q1eDANk1VuTwQiJxyjICzoV7Kt4ns/vCaHe1Vf1s=;
        b=fSR635T8Kz+puUHI2t35h/u3ZBDd6ZToYjmF4jyGBsk3OKDYMqAgFhAv+gUqZDA9++
         KfhHtcev2KBB5BYVM3nG3ro0OiieDOIy2nMFmu1v3igUG+q9NeyYQN5v2lXa0IREIxwO
         R19pNE63UIe7PDs3uyoyhcfHP+lX6xg9iAvjVaJ9C/B+P6ik0sXOUDkdhAvGpZN1cd4E
         DCmebjW+CzpC9kxT28P0iiF7nUA19l0B3YLtD5CzFe0OT30AFvsdN1+62A4g8SppxAIV
         vnttJU7LYREJQIzbrOy4jL8QVw6o+M+GoQgGkLrJxjCJmFCnj+Nw8Uz00jw0EEJ+rs8O
         qfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759272; x=1741364072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA0q1eDANk1VuTwQiJxyjICzoV7Kt4ns/vCaHe1Vf1s=;
        b=emgP66Z2spMkMedfbGp9wVaijbBUt4FRvhrbFgfFcuMIpW7sA4j88HtCeOUhhBabFH
         A8HvQ3eHyhIeItAB6r6LcQqD0h/RQ+L5xmnQK1F8+xpgQFIMuc9C/MRiidF4rLFMKhcZ
         zWanyw5EibPnAur+e+4snRAci8fN9VQi51ehQRdG1SjLatLeSXSlzHalQLRZz82tnMM9
         F16sVGZa55j3I+XUHMtV7Ks2P9iGVz2SbIYk7kKhgDMbmRwLjO5gbv6/nFztZqWhfa+D
         GvVcOAA3oN4wH2UZwwiSSTPIR3KfpNY8j0Q8WvgsJBqG8LzN0K3PgI6LQ9GJPFqjRHTp
         fIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/7fqhd+3K7Kx5maLYYVD3WKQ2HFUbud6R2XvJDU0sJwgO+Lc22AqgkfKZjaR34yF2dVnhwnIb6Mx45QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwezNNc3lf5Z9m0BlHo4yEwl7OoQ1PoILUi/oVRSg2hzmtFR5sM
	MvV5YoxhaKWGJJ1vNaq+kGnT7gLG/IQZgfhpYULSlqvJQG+OTYCUrrmklVhmgQg=
X-Gm-Gg: ASbGncuY+/yUvlqAfrf9MiX5KwqpXiqV3Zd9xvSFHbZ/3ptmRg94JIJaNd7YUJC10Qr
	coUn9+HN0JEo1kzUOF1OpytL18xz/nBxgpeVJZnYV4IDoEM6tcjgPCbotOaba8+/XtWCr8CmTqu
	083refuvba/QEBFv1tKaKWrgk9hpMWNsfHUgCV+/aNEza4FZuAluEU2j53r90wct/GfHRK3sTCU
	JYm60Z/hRtA2kklR0fbMyCiEVZkVvGoKyaj82fk6SCgEmCPJBZBu7R+vJSI/0pKICLbAWU6b2tB
	b+O45Y770sWdFNibqdCqd8Z5iiQu6iw6cu6QXQ5n2uTpI3NP
X-Google-Smtp-Source: AGHT+IEorpcQWBNQMknvoMwXDyrUVNGuGeLWwhyPQjwWgrfHo9N4oJU2oROHaGMiKCwUM7rlOaPVbg==
X-Received: by 2002:a5d:5c84:0:b0:390:e62e:f31f with SMTP id ffacd0b85a97d-390ec7c67damr3299605f8f.3.1740759272554;
        Fri, 28 Feb 2025 08:14:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795d30sm5690232f8f.10.2025.02.28.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:14:31 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: sm8250: explicitly set format in sm8250_be_hw_params_fixup()
Date: Fri, 28 Feb 2025 16:14:30 +0000
Message-ID: <20250228161430.373961-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting format to s16le is required for compressed playback on compatible
soundcards.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 45e0c33fc3f3..9039107972e2 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -7,6 +7,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <linux/soundwire/sdw.h>
 #include <sound/jack.h>
 #include <linux/input-event-codes.h>
@@ -39,9 +40,11 @@ static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
-- 
2.47.2


