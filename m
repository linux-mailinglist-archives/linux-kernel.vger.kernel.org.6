Return-Path: <linux-kernel+bounces-233735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B745A91BC61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DEE284075
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548A155359;
	Fri, 28 Jun 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqiPDY6R"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6515382F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569495; cv=none; b=iXEmS6hJshf0gSa5XawFswvIUIO5A5Jlm4/jy9SgC06PsngyohDE54drIsmX3TzJN0TZDGGwhUXz5yDD4sbX/6Xs/0SJd1BjbEgjg8zOQDrS8z1VWyuQ8cYpMPCAj8TFH+Z3noimRLVYjslp6W6sjhlRR0KDrG4uy+G9rOqOBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569495; c=relaxed/simple;
	bh=+/S4oEpOVrDy/MErgYZK3QlF9tlGNIxFq9HMRBhfBvs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HGGzEQQ5VlKjwVIlXCUVlIoSjRNXryIeNBKKO+Cm9XXAUaHwv8ORsml/JgAdn0sLjX7fCfu8oQQxuR0BqY+a6lijo8KJ0feV1Wnd4SacYCYA8qGBsIh+z4rCMToFbvLTFeo4W1RAW7yKW2PrSjcXj4xD46LSQaYiCpEBokru0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqiPDY6R; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso3979761fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719569491; x=1720174291; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KM8DD+cslID7pkEl7Dub+wrgxyjLr4VeNk8hahbUqJQ=;
        b=mqiPDY6RrYG4JeKG/lchXa44QY9Zv0Fxny2I44zmR1FnpBxhrM1ix48N5BxpLOa3oM
         1h8FgqH4lXBXCkCXkcrmjd+7aA5o5FtBWToPEDr1OXPEb8o0boIEkROuH+jv8ZMXpyBG
         htc1BmrT+fVnn4Ey3zOE/YzcNQdg8guHLAJiKMSZg51+gIoevShUgeHb69npJgugzumC
         k2RHdFQintD69A4wKHMXDw0yGXUex8lF46cE6WJAJAZ+8ddxHF8cPTOwZl1T4x9qOi8Y
         6MLEKC47bdlmcO0fYzjAOqOac9ugcruUaXnVEI/DXs+u+vDHsma7IjF13/qcruSc2FmJ
         oOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569491; x=1720174291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KM8DD+cslID7pkEl7Dub+wrgxyjLr4VeNk8hahbUqJQ=;
        b=lKFV2SEmCWI9tX3o5famb0mMcnibdGKMn+jVN+e5+RBcFOQP3mtA6rwx2w2kn6XIwO
         Akk443Na+tdFFNLKuusjmz5Bt+1w4RDrtutikE5ycdyC2a+THm3etK2T0cvt2vFKGKw/
         +xg+F/103ruYAcqP0Cmy8QDSYWdD+/k+VD3YNWrXPnR4BOTy+EsWzmRGeyZKf3GBkoYr
         5IZ3NkwuxT9d/VmJARrGzcWtJgwDcdozRcDQi72NhdRLblXzxneV7X4LxxwQZU+l9idc
         LN/aWn0ykhYJVZZ/BreMpeED12EOjDyw1mdxrACMBK5kpUB5u8Y0Qe4IMJDYOtoyeEmp
         4J+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8k5wgpHQOP9viu/4VFjvWtoHzMaxGwKCG+7QXPPkkJJo69agcc+z9qrKVUv2Go03A3Vuh2yiaSRqOD/wQUu5WHj+y1pL9j6kReXjo
X-Gm-Message-State: AOJu0YzXTlqL0/feWQQLEEPUaTNED1IEworBtRUN/IqKt0IwfeNkbPIA
	8LO1RUH78R1M75TQXwZku+/ykDhaO1xEHLKmN9FYgJb2YojHVj3I4au+v2y72YI=
X-Google-Smtp-Source: AGHT+IHGFbihiK4LC17Z1HPkdsgv7xrg5O3Etzoo9ELEAqXsyotSeiGHHEDWd+tDnW/Vp67/PjINYA==
X-Received: by 2002:a05:651c:19a2:b0:2ec:616e:1c92 with SMTP id 38308e7fff4ca-2ec616e1e74mr107676391fa.2.1719569475239;
        Fri, 28 Jun 2024 03:11:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c15f8sm27024605e9.47.2024.06.28.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:11:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/5] ASoC: codecs: lpass-rx-macro: Few code cleanups
Date: Fri, 28 Jun 2024 12:10:54 +0200
Message-Id: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC6MfmYC/5WNSw6CMBQAr0K69pm2IL+V9zAsavuAl2AftkI0h
 LtbuYHLmcXMJiIGwijabBMBV4rEPoE+ZcKOxg8I5BILLXUhS13BvYCn5QeYxRHDNJsYwbJDC3Z
 C45c5gq5UdemVk2XTixSaA/b0Pia3LvFI8cXhczxX9bN/5VcFEtBhrupGOZ3X14m8CXzmMIhu3
 /cvDY1I39UAAAA=
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+/S4oEpOVrDy/MErgYZK3QlF9tlGNIxFq9HMRBhfBvs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfow6hXMAhvr9f3euJp7I7UGeii4vjsSCL5dyf
 0dQcDhU8YaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn6MOgAKCRDBN2bmhouD
 1/h/EACK/mT4hTlY/Gsqi924GgxMfmmCjxJcsbhVBxXqRdk5McOUeZeimSfM2jk1Qa7xwV9mtLv
 aH7mlwTsvWvXGhnzc89zVqSNPTLcxbRcTp2kzw/hcqLLkxhrUQ4bH9HKAOKDj28EEZ9KMnokauc
 eFiJFEy97/wP1P5mIU7ZL/u/luEqJgQReRYBS6JFCyPpn1rl/b5rSzUrbW6pQImR7hXdHyrgsxr
 ceSTCaMDFHcVeAq1lhrkItJn3+7SmNb07GYWfU90xK2uZ2LlmBgRMBILPn3ZSvsBkDP8dnoKrt2
 iPtTOo37byd0B5QlbG6FIF6qrFQP06gTLKg/MNxvQhckNZSK00eScFrwC/XLWHyEm6is+Vl2RoR
 msxHrNi81U4g51Ysb2SynbI2U9p4kdwLw5bkOWYiN8p7wUgSD0KoTclVKgDBu1yu8QxHaNy4lmB
 tWSXEGuj735nnWP7ldjj+qqXKOxP4wuMV83ksIJZ95HdTH5O7a6omqNiiGHdVK8miTgmjNrgmZf
 xAHgRqk5EAuvf6vMkh/WRRJW0ciWFaMIKvF9VcdfqJtHxdcinZUWBwL2gW5FMEMPKb8LQE69HB3
 bbXaeiPZiNM+XGFBzSTjLIuH67VlePOCwN1OXJqG/CmCisjpS2Jbnxnfusr+nPsphoA803YA90j
 NKZIK/tDtcY7Uaw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v2:
- Use cleanup.h instead of devm(), therefore not adding Dmitry's review.
- New patch #5.
- Link to v1: https://lore.kernel.org/r/20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org

Improve a bit the Qualcomm LPASS RX macro driver and align similar parts
of code with LPASS WSA macro driver for consistency.

No external dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      ASoC: codecs: lpass-rx-macro: Simplify with cleanup.h
      ASoC: codecs: lpass-rx-macro: Keep static regmap_config as const
      ASoC: dapm: Use unsigned for number of widgets in snd_soc_dapm_new_controls()
      ASoC: codecs: lpass-rx-macro: Use unsigned for number of widgets
      ASoC: codecs: lpass-wsa-macro: Simplify with cleanup.h

 include/sound/soc-dapm.h           |  2 +-
 sound/soc/codecs/lpass-rx-macro.c  | 31 +++++++++++++++++++------------
 sound/soc/codecs/lpass-wsa-macro.c | 22 ++++++++++------------
 sound/soc/soc-dapm.c               |  2 +-
 4 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: feca1ff0cd5ab7bc3990ec5a387d81d4dff88068
change-id: 20240627-b4-qcom-audio-lpass-codec-cleanups-27175f1d069f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


