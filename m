Return-Path: <linux-kernel+bounces-183827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF98C9EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE781F2106D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358B1369A0;
	Mon, 20 May 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6MYrYWF"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD7136986
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214812; cv=none; b=MjPOvUU4kREbq9yh8l4uMyv/+RQr6P00O1dI+p+AXUTysc2xEVmUy8lxfDf1qn65viiSNu9d6g99z1GnkNGXGyyZiApmGq9EHEXC/aB1A4txOCCTNIPzHcm+2gBJGlG5br8/cihRQnqZGVm/ePGXP9y1Fa30hSyxIiw1axa5/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214812; c=relaxed/simple;
	bh=qxTEu3ici03kyFNg7YUAaRSNbhz1E9XO7pvSyVueYdQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qa0iOs4cfZ8nL/U2Hpw9EmjQBqhm8u9ajWyW6Jt2gRN4aAHwssysMVzO96CPL+Rg4EHCTSdpPdHXcry/nuzp+vOKU+CRQ3Z9J6WD43mfNh/V3SiphxCqW/PDNHaG9eE/5O4R/bWMaw9iLfEWTMpLL9UEv0xyZFxxoQUfw/iSCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6MYrYWF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420180b5898so20049235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716214808; x=1716819608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9CW1lljdTQoniGbKlu71vNrE0DIfBG/7Rx4WjUbuCk=;
        b=T6MYrYWFzxSVznV8zxea0fHM9r7wcA4dbhFiBtLKKVSRCK/EIySrHNRtZF0nc0SB32
         jjr+WU663bK+PJuGxBtGhZTP39gzbB1Ex9OyNllW8L5QFghPkzHR7u3XyCGVFIXkLdYk
         r3pCXjjh1h7Kj+IcCJnsJs7+DNTu5E779FMe/Ah5zPppxHHVAKMbf+rhFJN77Kq9pVhH
         HAuulQNBIFjpF0vPmHB7wtJyxck6mxDVCwCj7xC8wrcDevyMLeoSTrGlHEVTrrrdc8Nt
         OHZTiV4ob9wKHVM3Q/j+ppP24xRmNKByTQJqslwiyM/iTwZMSEjXjKPkdboklYKvtZIS
         aNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214808; x=1716819608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9CW1lljdTQoniGbKlu71vNrE0DIfBG/7Rx4WjUbuCk=;
        b=FQLYmNjq7xA5jLx9NrSu6cawQJpQcZiNo8xq9PdvMwTGopZaHC/RN7AAHzo0NikbHt
         Aw3rnBCQZN3t+DEk8h6GkGhGFhVcRtmEvEnFbqlDb9TsxgF1dzSpt205UODkMn3BYYCn
         Y2A9iWt2tStt23YX8x6krlmlPuIrHCdMeD5T83w7DVKr5JRHlPdF5oxdTBVKxvEUq7P0
         p8fEfGin3lR1/CgbJb3qyQIh/yaWvK0HWyhHCb5l0YriAPMg53f8AWtH1aIMWrbOa08b
         BwVXm6QXt0yE0ZgFtZGWP/apK2K5u4qR+zvO27eSvzARF5zWn8e3MWNo+S4j2UEDrhMo
         q8aw==
X-Forwarded-Encrypted: i=1; AJvYcCX0/73OToAKdqbKu8jESstzmO5UsEXv1mom2VLqYJqIVT5qmC90aqjyiwqE2jn/YKI8bWhvd9bj63YoMMu/uRdFoohDeSUreNdeQvY5
X-Gm-Message-State: AOJu0Yzt0RNDqUE/xGkxbNj562SSwSomM/3dIwX/GJPnTYSOMgz3ckEe
	KV6YzTgtY8R7xM6AlRA3O4mz1cfP0G6qKpmyBi2c0A7XcMqv40Cb8Hjtdq8zuaQ=
X-Google-Smtp-Source: AGHT+IFMFV4mhRBn+UqvYUrYuChKPXu49L17Sxp3FBhQHYS2zeOYK9ww7CxKfAzYZrtdnWG/4vNAQg==
X-Received: by 2002:a05:600c:3582:b0:418:29d4:1964 with SMTP id 5b1f17b1804b1-41fea539b5amr228948405e9.0.1716214807754;
        Mon, 20 May 2024 07:20:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee962esm421612625e9.31.2024.05.20.07.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:20:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/4] ASoC: qcom: x1e80100: Correct channel mapping
Date: Mon, 20 May 2024 16:19:55 +0200
Message-Id: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtcS2YC/43NQQ6CMBCF4auYrh0zLZSCK+9hXJQyQBNsSWsaj
 OHuFlcaF7r8J5PvPVikYCmy4+7BAiUbrXc5yv2OmVG7gcB2uZlAUaJEBTp6AwunGjkilLB9OZr
 gqufZugFIyx5F21ClapaVOVBvl9fC+ZJ7tPHmw/01mPh2/d9OHBBaLgwvCLWU3WmyTgd/8GFgG
 57EO1j/BkUGjaG+0VWlpRJfYPEONr/BIoNVX6tSStGp9hNc1/UJN2XtNXEBAAA=
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qxTEu3ici03kyFNg7YUAaRSNbhz1E9XO7pvSyVueYdQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmS1wPkwfDv8/JKSXm0dNPMTxIXDRVFebiRd5tG
 Rfi7oFbYlyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZktcDwAKCRDBN2bmhouD
 17tuD/9YTQNIoaXe5gRU4/huML2k4qpGKAfAKpOtfIdcefcxlJaUreBhNbG3NgVx5vk9DyxcytT
 4lR8EJixZ+qOAz3oqgbZeb+hKf57nDzaYuHsHDp+RCpurlS4ee3d/RSrpgXwsQX8mqwEUkNi/7V
 fHYqzT1bIu7Qk4GxNOT4g7O7+uDTQD1uZjg86MqsCcIVlV4QlrR0iHYU9iEN8KQcluMYFQzFY3V
 QDxWUL0HFJVcnnMdcYoflXenzePdya1YT5NV8zKQRxyUM3amY9NowIgsDPR08tMPg26XJ8HfZ+y
 C5haLVcxWJ3cy+vCKfULweI2/Hrs66Ul8a9A0jwnxrJeR/d9o5qS2262kbS4M1G3MUUl97nPJYA
 57WLG6ExPdG6Sl2JF702lsHaRQ/b2PlK9dMddVVY36DRVEg70Su5nwJepl96oElFuOzKGlBh7xq
 0JG/ekmw51xfbs9xqQwTs7gDv3GlHd/vfgWnTkbwPiQGNruI1gC1SA0pSK1rZR6P/L6eYjYz0GX
 1idoZ2Sc71hQ3YtahfALkRBPhQ/whdQ70roa+R56b8KmX2xciuJMphIA8VFAfRh9l7ib43TzW8m
 E/XcViADtJ3VhU3iE6yh/D92Jk5RQ405hwgZEOrf59lLc3GMP35wH9R1lgqNu5OAKRlWk3jiVkv
 YtTPd/n76ZyOkow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

First patch is a build dependency.

Changes in v4:
- Rename audioreach_set_channel_mapping -> audioreach_set_default_channel_mapping
- Link to v3: https://lore.kernel.org/r/20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org

Changes in v3:
- Add missing Charles' Ack
- Link to v2: https://lore.kernel.org/r/20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org

Changes in v2:
- Re-work most of the idea according to Srini comments: set channel
  mapping for backend DAIs, not frontend.
- Patch #1: no changes
- Patch #2 is entirely replaced - now channel mapping is implemented in
  q6apm-lpass-dais.
- Patch #3: rework to new approach, but most of the code stays.
- Patch #4: rework significantly, because only backend DAIs is now
  affected.
- Link to v1: https://lore.kernel.org/r/20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org

Description
===========
X1E80100 CRD is the first board, which comes with four speakers, so we
still keep fixing and adding missing pieces.

The board has speaker arranged as left front+back and then right
front+back.  Using default channel mapping causes front right speaker to
play left back stream.

Adjust the channel maps for frontend DAIs to fix stereo and four-channel
playback.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      ASoC: Constify channel mapping array arguments in set_channel_map()
      ASoC: qcom: q6apm-lpass-dais: Implement proper channel mapping
      ASoC: qcom: qdsp6: Set channel mapping instead of fixed defaults
      ASoC: qcom: x1e80100: Correct channel mapping

 include/sound/cs35l41.h                 |  4 ++--
 include/sound/soc-dai.h                 |  8 ++++----
 sound/soc/codecs/adau7118.c             |  6 ++++--
 sound/soc/codecs/cs35l41-lib.c          |  4 ++--
 sound/soc/codecs/cs35l41.c              |  3 ++-
 sound/soc/codecs/max98504.c             |  6 ++++--
 sound/soc/codecs/wcd9335.c              |  6 ++++--
 sound/soc/codecs/wcd934x.c              |  6 ++++--
 sound/soc/qcom/qdsp6/audioreach.c       | 30 +++++++-----------------------
 sound/soc/qcom/qdsp6/audioreach.h       |  2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c        | 16 ++++++++++------
 sound/soc/qcom/qdsp6/q6apm-dai.c        |  3 +++
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 21 +++++++++++++--------
 sound/soc/qcom/x1e80100.c               | 18 ++++++++++++++++++
 sound/soc/soc-dai.c                     |  4 ++--
 15 files changed, 80 insertions(+), 57 deletions(-)
---
base-commit: 2b84edefcad14934796fad37b16512b6a2ca467e
change-id: 20240507-asoc-x1e80100-4-channel-mapping-ea5f02b9e678

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


