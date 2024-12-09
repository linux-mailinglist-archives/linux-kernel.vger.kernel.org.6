Return-Path: <linux-kernel+bounces-437093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA999E8F02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67044163DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D256B2165FD;
	Mon,  9 Dec 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWnDqDmJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D5215F72
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737498; cv=none; b=LxDx4DZX7nOdKkPJ4pQ1QP4HmXvT1FmgkMhu9aI1nyp3xNVmHWjRDLe1ZUt41P6BQSNljJS5Gcafhd24z8oRligF9i4VciYDp9plGlhe5zGVRCeNTxiJiEM1vKTdUz4AfEIS5S8GrMnJIyot5WYPAYAxmwjNXUps/VX6a1xnnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737498; c=relaxed/simple;
	bh=ZMBz5ZZR5lOt9yuXE50yqmicdPRxRt8rxwXfEc+KwWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxGmgQ/uV/nrY970KLOsWq8MkQCUVB5akkHNAMdoDaABo9V/6PiYTgFySSDD1TCiAx7iJHxlzf0tLtqkr5LohR/jb/mJ6BqIML//Vqz2HBkM7gaORRAGJLF+ipj5rX9kZL0AZc98oClu2YzVubFdTsgegMyE8JsW2e5rYPmf96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWnDqDmJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a1582c86so3517665e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733737494; x=1734342294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs9vbivkO216Dc8HYQ/Zd8gvHi0Ause9by/A/vR6Gl0=;
        b=tWnDqDmJjGJ1Xy5Oug080yEh178hFhpv/hvnskPD2l9d7g4c4ASsfUqhY1i44k98k2
         skVN77GebYJ7yjOxDCVlP+SZ390NNtoV25Rps9orJVL+1jnXrfB/X/Fp2Q89JPueQr+8
         Zl+6FFLzRAREDRThFW61VMmyrPYMCExLxJjULrmrXFvnyEA0GeHBEL73TZcM6Tw9GzXs
         XjlkfUe2ecTPhCWqppfkZPEsAWmI9PwVsaCIzSdvXTCBqYCDgYNzMKNUTsqCQiWyLEaT
         mV9DY42CDRyQbZmJ/qSd5MB7rvVczQIdPB8Lot16NWAAKs65J61+lVpwrchseE4BW3ca
         cB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737494; x=1734342294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs9vbivkO216Dc8HYQ/Zd8gvHi0Ause9by/A/vR6Gl0=;
        b=QctPtVIWlk416wEx5NBBreSVgDRURMKdHr1USQAmz2uw6SguL6g4tJoEJyArIi9uSb
         BvXNQ8Zns7VzlZi7pfZ2PcNKQJNnkO/8QC+V7N/Bgi1qNeHCDghASP1UGgaYjFnRXDU9
         v3YG7Jpt15kDYKo1wXvBCyJavebCB6qm+gaAM8t6lFqfZoSkk8VV/12I4YbAn/OfKK2w
         whfSszoSYSV8vdarAblO9YLbp79EDdp1W4K4W3x99dgAFzbWq741izU8VC1gI2UJUSSt
         OQ4VZtOxbQqD3Djc6VMzwnRDE+uqqmh/8YMv6qlPEh89piIP4wFcTPq7LIqeu9hu7AsU
         kJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWRmj2W+hi7sDVLwnPEMK02N++uN93UyZo0IPoDOIoYjfpn7X87mFpT/eWLo2pg6t+0X/1kBtx7NAFYrFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoR5cHcfq1loSRs2+uMSYgmVnx6bJD4U2TDM1f9QkFEacy44E5
	0f1bJmG4hxWtnO//8Almi1mDjCbf4FPJeGUTL29x1ge3Obao/nghJ4AARroBYMA=
X-Gm-Gg: ASbGnctrBF3bRe8F14cAT5ir5twmRJcDe4GVlPGX/KQaIOwcQsDhFsICikOBDdxH/oe
	063v2yuAr9x8cGARXdgUZ2DfaEJB3Yp7O0xjsXP7umdRP/1BFlaaMLAO3j1pTfwOuQGzGdIPlSE
	/xORo5dppHSHiz6DnZ3oIaJQj1NGOgN2Am6RjRVErEGvElXa87OE2DHF9GLF7zQ+ZBuVx82PD+5
	19ECr+vph2TaHrgmxRh3XmE91FF48XYmODjDiXbysnXl9drbh0tXGGbvBoiDqIs
X-Google-Smtp-Source: AGHT+IHecMb6+js452qiT9G+qHvWh9vpINrVmf9jmZNLo9NLCiKBHCX+t3zASHR8lIlaD2w5TTHXtA==
X-Received: by 2002:a05:600c:138c:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-434dded98a6mr37786385e9.8.1733737494165;
        Mon, 09 Dec 2024 01:44:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e962028bsm80503345e9.38.2024.12.09.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:44:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v2 2/2] ASoC: dt-bindings: qcom,wcd9335: Drop number of DAIs from the header
Date: Mon,  9 Dec 2024 10:44:42 +0100
Message-ID: <20241209094442.38900-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209094442.38900-1-krzysztof.kozlowski@linaro.org>
References: <20241209094442.38900-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of DAIs in the codec is not really a binding constant, because it
could grow, e.g. when we implement missing features.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dzmitry Sankouski <dsankouski@gmail.com>

Changes in v2:
1. Use "dt-bindings" in the subject prefix.
---
 include/dt-bindings/sound/qcom,wcd9335.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/sound/qcom,wcd9335.h b/include/dt-bindings/sound/qcom,wcd9335.h
index f5e9f1db091e..4fc68aeb9e04 100644
--- a/include/dt-bindings/sound/qcom,wcd9335.h
+++ b/include/dt-bindings/sound/qcom,wcd9335.h
@@ -10,6 +10,5 @@
 #define AIF3_PB                 4
 #define AIF3_CAP                5
 #define AIF4_PB                 6
-#define NUM_CODEC_DAIS          7
 
 #endif
-- 
2.43.0


