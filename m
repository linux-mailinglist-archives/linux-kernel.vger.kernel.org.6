Return-Path: <linux-kernel+bounces-232483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1A91A97D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6796D1C21A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDACB197556;
	Thu, 27 Jun 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjXihHoD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FCE196C9C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499486; cv=none; b=rI/JjTCI0nKN19G3m0vmZpV3dlUUFR+rIxYvYwK81Kg8S5+sgizQfqll+M4N2MzWgdvXJkSopXO6//c5DAgqpYqq5DiXDh7oOjr+MYUNGI1nUCEW+/NmVIK4833fcWvUvH+fUKK1AZILfgik06KKaA9zOi3FlW9uicwdu11citA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499486; c=relaxed/simple;
	bh=TUm0RaYqomUaGHfxczMiGxcHyL3VSRfdBI0wiwOJXjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cDALmCNnKCpPn+aMtHRChHEdNPUKj4U4Jx03yYXLoTIGYsg/ZvaUitGHqPy2Yrbz1XRFwmZZZ67WmXWduWaW/UfSuQhH0gWbgKZ3WXz87wHt7RNnDkjl/ZCjFtOPKdbZwAqw83yHnaphBqc39Qfe+lnGDjuQxIqfSu4L8aKVZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hjXihHoD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424f2b73629so21596775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499483; x=1720104283; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmLpAWmlJIdMq/VoHVTuZd9JbEM9j0iTEvmVKd3mZ4w=;
        b=hjXihHoDkO9rL8J1o+VSEdxrczVByj4cekgsIDJpgPKiXRe6qSP2HJvshonGYyvOOD
         EgT2tPRaP7oc8RE3XTA1+JSw2yKVVdHnrw6vX4Sxssx212qWGNeQTZofnYuyVWfRjuYd
         KXdJOMnUWRSOicz8scUN8+aawJ9YwffVNtq7a8tiOPSnurtRyV+7pBWjUFGFhO5jtrz2
         HuNca4lzG3r3Ob4enEa6NNx5j47db0n276QEyQvaMB/xlZJ0zo7lBNZ68OKJDOCRu/tZ
         0FN87HeHkziiHxfT4aqkq3mpODvfPzwL4K/0V0XVoEHRX/+LGGqGvkH5pV+cTIIbWsK/
         kJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499483; x=1720104283;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmLpAWmlJIdMq/VoHVTuZd9JbEM9j0iTEvmVKd3mZ4w=;
        b=AgHvLDs/6Vv8G5qwJbXT/MjmQGz9Y/VWDLPiV/ZBJIhyYh1Q9mNu3ZwIjA/oiLek3w
         ngQJrBI3mhtDpYRABSOoYgzTz0vFNdPOkcSwljcX4tG0CQv7xMiVnmLhO1uYgsGUjvKY
         OryMlwTSUY7cBbbFlPQikdQEIJGS4GUeub/pgbDOXRpYIYm5ZNA9vjKylV3Aae//6j13
         wlbxHh6HoH5oZmNWBt/sDF/pAqwsJrtMzpk4V+zBcgSH/taOwmg4DfrqlANTaz5cWXib
         QtIoIJnVgGb/ckMkv+lHgYvo9IfmOUlH4IeodVgsuBNaBCI1HO/gFM19NbBysdZl8Bms
         DSuw==
X-Forwarded-Encrypted: i=1; AJvYcCUC+m2/3H9Vn1svIfsN5Bhd2oCL8DQ2q35oBzQ5j5OYGjPnsTQ7w0SPY7SLn/S++Yh4rXjoj/NDBYVFm44wmHEj2FWyBTA5vFBezq4l
X-Gm-Message-State: AOJu0YxOOpdacvvKaKeOkEHcnm/Qv3s54ASefadfAYZkhpbDIOKOJOHS
	3xZo6cauyKKaTv0oGA6/l6teBOHKQDvelQROiaVXC+w/yQYh+jcSTvNxnsJKouSlHRA4GJDWD1C
	IVwM=
X-Google-Smtp-Source: AGHT+IGovERBfpldUSDoy9yj6OyIfZTUPkLDC3sHsnVcAxkg0Vg/RCJP9nojWITLyBFMPwHPCMaAEA==
X-Received: by 2002:a05:600c:460a:b0:425:6976:f5d6 with SMTP id 5b1f17b1804b1-4256976f94bmr391785e9.33.1719499482639;
        Thu, 27 Jun 2024 07:44:42 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b7b7c1sm31254075e9.23.2024.06.27.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:41 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 0/6] ASoC: codecs: wsa88xx: add support for static port
 mapping.
Date: Thu, 27 Jun 2024 15:44:37 +0100
Message-Id: <20240626-port-map-v2-0-6cc1c5608cdd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANV6fWYC/22Nyw6CMBBFf4XM2jG1RURX/odh0ccATaTFKSEYw
 r9bWLs895GzQiL2lOBRrMA0++RjyCBPBdheh47Qu8wghSxFJSscI0846BGpvQqrlChdqSHPjU6
 EhnWw/X742DhgGxkDLdPej0ytXw7Vq8nc+zRF/h7m+bKnfyTzBQUaV9/rm5NGKfl8+6A5niN30
 Gzb9gNqRURKwQAAAA==
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Manikantan R <quic_manrav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=TUm0RaYqomUaGHfxczMiGxcHyL3VSRfdBI0wiwOJXjs=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfXrYjFzYED0KcuZ2JaqXktrm4rVyEowwWxnc7
 ZMDozvIgn2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn162AAKCRB6of1ZxzRV
 N5JDB/43Bh6z6Gxcpdr+eCHQGR8F/SIcmOhRRJob22JEBqE9fxst1E4BmGL2OWc9anSJ0JiQvkG
 wDIlBGjV1kd2ClZwCkihYlOGZqDyxLdstSPAqpthkcIiPFejtitraxcVTB6sKMsdHRduPfak3qS
 qlE78YAwYpcjAq3tZyO3XkgrsuaJU3CQlZjaxe5lky/jxbnpINsDWMv8ZgyVFZziwHTOw6IQlWP
 blVTM+0Ha5AyruwnFkVODH/aJ0JgMS5n/LcsSVU7qW8mmlC/f9K27eXosEO7HhQcNiAN9LdM8/o
 /VE0NoeMHe8r9saW0v5K8xUmAzVcYdrw/i7xMiAdl4CeMkAJ
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Existing way of allocating soundwire master ports on Qualcommm platforms is
dynamic, and in linear order starting from 1 to MAX_PORTS.
This will work as long as soundwire device ports are 1:1 mapped
linearly. However on most Qcom SoCs like SM8550, SM8650, x1e80100, these
are NOT mapped in that order.

The result of this is that only one speaker among the pair of speakers
is always silent, With recent changes for WSA codec to support codec
versions and along with these patches we are able to get all speakers
working on these SoCs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes in v2:
- used dev_dbg instead of dev_info
- Link to v1: https://lore.kernel.org/r/20240626-port-map-v1-0-bd8987d2b332@linaro.org

---
Manikantan R (1):
      ASoC: dt-bindings: wsa883x: Document port mapping property

Srinivas Kandagatla (5):
      ASoC: codecs: wsa883x: parse port-mapping information
      ASoC: dt-bindings: wsa8840: Document port mapping property
      ASoC: codecs: wsa884x: parse port-mapping information
      arm64: dts: x1e80100-crd: fix wsa soundwire port mapping
      arm64: dts: x1e80100-qcp: fix wsa soundwire port mapping

 Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml | 8 ++++++++
 Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml | 8 ++++++++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                 | 4 ++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                 | 2 ++
 sound/soc/codecs/wsa883x.c                                | 8 ++++++++
 sound/soc/codecs/wsa884x.c                                | 8 ++++++++
 6 files changed, 38 insertions(+)
---
base-commit: 9935be184a55dd84fc3275094f2df095491f6ea1
change-id: 20240626-port-map-ef50c3304d4a

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


