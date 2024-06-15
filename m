Return-Path: <linux-kernel+bounces-215968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E790996D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C94E28339D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3F5381E;
	Sat, 15 Jun 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+bfh2+y"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C34AEE7
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474018; cv=none; b=R6b4lj+wfldejRrycmdrw3reUQ5xk64G9JdG9M3MVt4sWzev92DxFbIuQkThCxVGYdvvs3KKBD+MRqbHpmCrH7kmkCf7VHHUir69eJorRq1hvkCY+hLrqgV/kJPRu0lIDXBXbXv00a2dXMdg8mNUqC2QqStGg8hEb9/uEwS1+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474018; c=relaxed/simple;
	bh=ddqtoA1uBJgM4ZtSWBezi1tMizjV2f9A+YjMrypDB0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZvU14l+LYpDnG629x0ThkyBvcXHr/8SzSuSHuUF/1dB03yefLbrnsA9d0wwcY+T2lJ6mOjxehg2GBHOp0wcc3NKi44a2wB+VAlW2fV+WwP4BdM6zEoihIcAHGC4JDeGa1BOgGlgQvilIn0tShxhTAsjIyJ6alXkb8av4m+TfEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+bfh2+y; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc0a9cea4so2808185e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718474014; x=1719078814; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmJg3Zk7ayvVjEFeNh8H2uoFZWNvrWctySUTsFLFpHI=;
        b=w+bfh2+yoGNvCEKAl6tiRMK68wsMJ4AQsEhfHl5glXB0yVEPiAC1+YY1Fb3xbTcwYy
         9cFYgLl39RD0xgi5UUkz+x+FZcnazD6ION1hbsM36rkmlPsW43xSK0uGCxUkcI+E0kSW
         8D/hWcQFE5aL95N7QEGComxpa4ZGY15+ivlZFZHDFyIaVx9J1eZxuoFqzi0+pnymtoY9
         F1LYlx9jLvWhgdGxUiElyKoeX/Fy90RG73O2CQdtW5nNA1EmWCNYhjUwvwMSu0Mpllc7
         rZmc4GTW1u1lU7WMHaEVSPDkrmvB/iCj6opdNXZwvOm7xLiVY4DukmmYkFbLvA5ykYRN
         JUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718474014; x=1719078814;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmJg3Zk7ayvVjEFeNh8H2uoFZWNvrWctySUTsFLFpHI=;
        b=UchkUU5Y19VV5WAmNubpfC/M4w2K3iDLoKhd5VKLLzempLs3VoeiZ3vUl4780SqZuT
         MiT0nENyJ5IS+IDlKcHe7OqyX19N/Jcvah+LaSvZ+THN41NwzSaaVmkQhX5rLw1ud5Ji
         V/1bIPst4WPjWToy9+hY6knlKjmRCdsJuVgJu9Np3IILi4yxnrLzIljJ0bAqTD84j+TR
         EVaWnQ/rEZogunKBloZDNPcKYtuUPmUY+53wDf7TTgodTo9l7hOQ9GAQVtgKAstdjt3N
         OkY6UKPMD3XUXa+7CZ4e/RE//6hHvmqEaDevUqvzNZhFOUrH5Ki38PBX9ssC+OcebRGa
         aWog==
X-Forwarded-Encrypted: i=1; AJvYcCWMRlUnqySYTr1i4OFSUqOD86JwcmPPSLvEuxZ2fTAc904UlhjuHduMekIRKjCTTGq96jpVgkY87+sT4bf8U72rILTVJA2zv0+NGOvW
X-Gm-Message-State: AOJu0YwRKHeGCLlgQqgztPDkXPfZUGLdeVkzsJUy4u31253k5WcGVJ1e
	M81nokoa44sVQnyLHjyP8GyRJsQC23njwhSlflyhxDegFIFJzsx1WHZZQJOINBM=
X-Google-Smtp-Source: AGHT+IFm4N/WGbgtxHFOCEZqivRuQOIboj1UDEZQrvJvTza3m3xGBkRiUDyGVekSBkLFozGMfCMpJw==
X-Received: by 2002:ac2:4649:0:b0:52c:94ad:9b26 with SMTP id 2adb3069b0e04-52ca0464493mr2657808e87.30.1718474014218;
        Sat, 15 Jun 2024 10:53:34 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287affcsm799209e87.232.2024.06.15.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 10:53:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH RFC 0/5] drm: add DRM HDMI Codec framework
Date: Sat, 15 Jun 2024 20:53:29 +0300
Message-Id: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABnVbWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU2MD3ZSiXN2koswUoExGSm6mbnJ+Xl5qckl+ka5lkkGambmRqaW5cao
 SUH9BUWpaZgXY7GilIDdnpdjaWgBlz5AQcAAAAA==
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4197;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ddqtoA1uBJgM4ZtSWBezi1tMizjV2f9A+YjMrypDB0I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbdUcnGkM68bEisjHoE5CPO3VIVd5axzFVmDg/
 5c0g+u361qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZm3VHAAKCRCLPIo+Aiko
 1U6iCACdT8AojSMNtwl/BxSfQjvhHDQ5z41aRmvL9mL2j5Ycysr0ijd+7RtZNrBgHOLbOhy090x
 YD/r/L2ecfeOlwZr4OiTO+W0OZd8zRo8ZaYuGd1aoARArRK/UEamnuHp8qiwSJsnC+3VXgCk1QX
 +XC83bRm1g3XHLBWvVRByt3SgK+3avMEUfuKOlZhPmM1Pd9OCBYE+t+GzZBF5ZPInHbv70j6Ute
 dZyrPIxTopbjPUErC2/8s0Ea7XRyA7tIxmVz1+Qk+EUMYwsEmJvTbWDmM+ygo1UTWluPBHn5ELa
 iZAAG/r8/j774lsSqwXyzxwwOrhIhWiG++9KKEI/+ej0tgdn
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While porting lt9611 DSI-to-HDMI bridge driver to use HDMI Connector
framework, I stumbled upon an issue while handling the Audio InfoFrames.
The HDMI codec callbacks weren't receiving the drm_atomic_state, so
there was no simple way to get the drm_connector that stayed at the end
of the bridge chain. At the same point the drm_hdmi_connector functions
expected to get drm_connector instance.

While looking for a way to solve the issue, I stumbled upon several
deficiencies in existing hdmi_codec_ops implementations. Only few of the
implementations were able to handle codec's 'plugged' callback. One
third of the drivers didn't implement the get_eld() callback.

Most of the issues can be solved if drm_connector handles
hdmi-audio-codec on its own, delegating functionality to the actual
implementation, be it a driver that implements drm_connector or
drm_bridge.

Implement such high-level framework, adding proper support for Audio
InfoFrame generation to the LT9611 driver.

Several design decisions to be kept in mind:

- drm_connector_hdmi_codec is kept as simple as possible. It implements
  generic functionality (ELD, hotplug, registration).

- drm_hdmi_connector allocates drm_connector_hdmi_codec if the connector
  is setup correspondingly (either I2S or S/PDIF is marked as
  supported).

- drm_bridge_connector provides a way to link HDMI audio codec
  funcionality in the drm_bridge with the drm_connector_hdmi_codec
  framework.

- The drm_bridge didn't implemnent support for no_capture_mute flag. Nor
  there is support for no_i2s_playback/_capture and no_spdif_playback /
  _capture flags. I think it's worth moving no_capture_mute to the
  hdmi_codec_pdata, together with the rest of the codec data. This will
  allow us to keep single implementation of ops in the
  drm_bridge_connector.
  At the same time it might be worth reverting the
  no_i2s_capture / no_spdif_capture bits. Only TDA889x driver sets them,
  while it's safe to assume that most of HDMI / DP devices do not
  support ARC / capture. I think the drivers should opt-in capture
  support rather than having to opt-out of it.

- The bridge's driver has the unbalanced call to
  drmm_connector_hdmi_codec_free(). This is because of the difference in
  lifetime cycles. The drm_connector is tied to the lifetime of the DRM
  device, by using the drmm_ calls. However the bridge can be removed,
  while the DRM device is still lingering on its path to destruction.

This series is in the RFC stage, so some bits are underdocumented.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (5):
      drm/bridge: lt9611: use HDMI Connector helper to set InfoFrames
      ASoC: hdmi-codec: pass data to get_dai_id too
      drm/connector: implement generic HDMI codec helpers
      drm/bridge: connector: add support for HDMI codec framework
      drm/bridge: lt9611: switch to using the DRM HDMI codec framework

 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/bridge/Kconfig                     |   2 +
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c     |   3 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   3 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            | 347 ++++++++++++---------
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |   3 +-
 drivers/gpu/drm/bridge/sii902x.c                   |   3 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |   3 +-
 drivers/gpu/drm/drm_bridge_connector.c             | 130 +++++++-
 drivers/gpu/drm/drm_connector.c                    |   8 +
 drivers/gpu/drm/drm_connector_hdmi_codec.c         | 157 ++++++++++
 include/drm/drm_bridge.h                           |  46 +++
 include/drm/drm_connector.h                        |  33 ++
 include/sound/hdmi-codec.h                         |   3 +-
 sound/soc/codecs/hdmi-codec.c                      |   2 +-
 15 files changed, 594 insertions(+), 150 deletions(-)
---
base-commit: f83b272021ad706ff952bc53b707a3a8657eef71
change-id: 20240530-drm-bridge-hdmi-connector-9b0f6725973e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


