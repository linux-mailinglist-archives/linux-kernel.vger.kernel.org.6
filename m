Return-Path: <linux-kernel+bounces-237536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58075923A93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A711F2216A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844515665B;
	Tue,  2 Jul 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSYVUaLr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E46156230
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913737; cv=none; b=rX97Gi7zkSyEp143NhQbTr/EsXUDfGTjz3LE2S2a9QiuThJ2Dm5OurMZHsdtymmkh9JxjpiZmlL14ly4U8uldz36KoEf9cyE8INODZimEEX/+Z6Xw1eh4P1iWrJJ8YuyMoEtlF19Ym0PobdiWRTa0hJsI1wlj/HdkqqyFgU1eBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913737; c=relaxed/simple;
	bh=aKNowkMoWLFAr/Jk1xuF/YdaHNRoRTyW409aI6KfA7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZQEGHdkcn+EkrICE0JmU+aXADlbnNUj4rhSyb7inc/mhicH15AVSyWfNqfiLMsMfTxHi/leCLD/Fm4858L7r1I6YgZPYkU1jMERZqipGVdzdc85X56yA69TcQuKK6Gy/v1ODpaBqSchk7n85ahYv2MXGmUBsYzTtnQd1jx1nnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gSYVUaLr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso49250321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719913734; x=1720518534; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CL2rM6gQRFIxvwZxnMmv5tq1MwlblXKlT+xy6jtFjA=;
        b=gSYVUaLrqaeAVyEtZuFi8w+L57v9Ot0hLTzhwhKVovPNpoHZJ9wI4l+rATTp7k1KIu
         NygahyixTarrseyRsCTapiBQrJB6Ek6WMfkMxdJv8cQDTzPI28LKxr4AuPUjsJFgeT5R
         bYbyf8KYRzBsCCkX/PeZLylUDGbhGlGkoWLZ6UtQ1fGfi+7/EvNtLLlGiUXxfSroAd5o
         tFIJYvK9Iyt6HLU35sZ+aRP5ionWkrigstkbNzSw6UkOW5JpSgHb/Uam0VYRdURrzail
         OqPAPO8gOvvRCpt30MOmIQInp9LwWukgo4U8YZKwMyaxObtVJtrm/yGZzHbJg+ULDXr7
         nQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913734; x=1720518534;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CL2rM6gQRFIxvwZxnMmv5tq1MwlblXKlT+xy6jtFjA=;
        b=qF0Srhe/HZlltcj7kf/OfOPNA1wb7U1cRUIl5pw1RMDAL1+5aSDC/brSoZmcwtPJRw
         k/bKtY1VzT8kZb6ErO6f2sdQdc3d45GIWnZSvz6PXlWHrfCEWMiWGpDoL6qX3zFpZo03
         l5b6wum0Sv7siTRFP8Xu9PbMi82ts1FWM/ZbjuGz2yk6hhrnQafjXA3n/lzy4szhdw/7
         oRMa+8xL1fVsNoFxzHVhCBOlmLwC5CA3508rScnwurwqjnWhx64AlGyofKcG90Y4hyH8
         Y2U+hpB3HUt8U0HgzV4kxkIoxecsnzg1uSAN256UQcKV2FQYDvzQDPLe7Z2Etr3Xum+M
         Nm/w==
X-Forwarded-Encrypted: i=1; AJvYcCVuu08t/AxuurfBJJDx+AH3ccyNqhjzeHQbbrwRXh15CSaBaMxGqW499iHhP2qkY1NDtvNptUtDG8ylU+17DJ0ZDaGD5iNBxC+i4+O5
X-Gm-Message-State: AOJu0YwupTw6PyUvG+dIOpCPDlq2PQvlFcKTBmj80wBXM2soncAvxzHP
	dPo4R3uWu7y6e9k/gl4ZR4FbUzLgfuSeMiDF2Sj2Ug8sfRO1t6wxarlcjuih4kg=
X-Google-Smtp-Source: AGHT+IFGhvYT8vVyDqaa9mAmycqytwVYEQQ87UpawoBTG26K/hzWSg0FmrAnvTjW4b5csgd/vXjHrw==
X-Received: by 2002:a2e:b7c9:0:b0:2ec:56b9:259b with SMTP id 38308e7fff4ca-2ee5e6bd1demr44345871fa.49.1719913734219;
        Tue, 02 Jul 2024 02:48:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e333sm16231161fa.5.2024.07.02.02.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:48:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/4] drm: fix two issues related to HDMI Connector
 implementation
Date: Tue, 02 Jul 2024 12:48:51 +0300
Message-Id: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPNg2YC/52NSw6CMBBAr2K6dkwphVBX3sO4qO0Ak0hrpqTRE
 O5uYedSl28+7y0iIRMmcT4sgjFTohgK1MeDcKMNAwL5wkJJpWWravA8wZ3Jl42LIaCbI0NPLxj
 9RMCYcAbpsGttL5vaWlFMT8ZysVeut8IjpfL13qO52qa/+XMFEnSFpjPaO4/u8qBgOZ4iD2ILZ
 PWHVBVp1xjptTaVcvglXdf1AzDayO8sAQAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=aKNowkMoWLFAr/Jk1xuF/YdaHNRoRTyW409aI6KfA7I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmg80E/uw01rVCUV9/aHVNw+7mrZHA5xGH/z1ku
 wgDRH2QVzSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZoPNBAAKCRCLPIo+Aiko
 1TF7B/46yjVZP5lLBunRo1C//rOwvAtnwAf6s8MGaIH1D99u54/bXXOe0/1+JU6/FfW14C+ldOW
 0B7TXVXSDAKnRfkc+Du8xNPxup8qkp/O/MStUIjDILFSWNO0mp3z1lxgKSkhxssR3MVgP4Utn39
 +kvkMufpqMjfI/e037eyBikXpwliBqY0ypOqRMbOPKpm7d+DNCFvXCbqbEeNdDZ4tPj/UC3yjGj
 UamVAIKjOgfl58Jerxkvu0B9R10NKB836gPi4pYFH/SyDZdarj4JEOqUQP871eIhubHb5GMW+Kf
 5CSv0dhrKcmL+RtOWNqpps7hqpktZVhCLqFAIliasVK5Kx87
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Running IGT tests on Qualcomm Dragonboard820c uncovered two issues with
the HDMI Connector implementation and with its integration into the
drm_bridge_connector. Fix those issues.

Note, I'm not fully satisfied with the drm_bridge_connector move. Maybe
it's better to add drm_bridge_funcs::connector_reset() and call it from
__drm_atomic_helper_connector_reset().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v3:
- Document the DRM_MODE_PROP_IMMUTABLE requirements currently exposed
  only via IGT tests (Maxime).
- Move drm_bridge_connector to drm_display_helper.
- Link to v2: https://lore.kernel.org/r/20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org

Changes in v2:
- Actually pass the flags to drm_property_create_range().
- Link to v1: https://lore.kernel.org/r/20240623-drm-bridge-connector-fix-hdmi-reset-v1-0-41e9894dcdec@linaro.org

---
Dmitry Baryshkov (4):
      drm/drm_property: require DRM_MODE_PROP_IMMUTABLE for single-value props
      drm/connector: automatically set immutable flag for max_bpc property
      drm/bridge-connector: move to DRM_DISPLAY_HELPER module
      drm/bridge-connector: reset the HDMI connector state

 drivers/gpu/drm/Makefile                             |  1 -
 drivers/gpu/drm/bridge/Kconfig                       |  1 +
 drivers/gpu/drm/display/Kconfig                      |  7 +++++++
 drivers/gpu/drm/display/Makefile                     |  2 ++
 drivers/gpu/drm/{ => display}/drm_bridge_connector.c | 13 ++++++++++++-
 drivers/gpu/drm/drm_connector.c                      |  7 ++++++-
 drivers/gpu/drm/imx/dcss/Kconfig                     |  2 ++
 drivers/gpu/drm/imx/lcdc/Kconfig                     |  2 ++
 drivers/gpu/drm/ingenic/Kconfig                      |  2 ++
 drivers/gpu/drm/kmb/Kconfig                          |  2 ++
 drivers/gpu/drm/mediatek/Kconfig                     |  2 ++
 drivers/gpu/drm/meson/Kconfig                        |  2 ++
 drivers/gpu/drm/msm/Kconfig                          |  1 +
 drivers/gpu/drm/omapdrm/Kconfig                      |  2 ++
 drivers/gpu/drm/renesas/rcar-du/Kconfig              |  2 ++
 drivers/gpu/drm/renesas/rz-du/Kconfig                |  2 ++
 drivers/gpu/drm/renesas/shmobile/Kconfig             |  2 ++
 drivers/gpu/drm/rockchip/Kconfig                     |  4 ++++
 drivers/gpu/drm/tegra/Kconfig                        |  1 +
 drivers/gpu/drm/tidss/Kconfig                        |  2 ++
 drivers/gpu/drm/xlnx/Kconfig                         |  1 +
 include/drm/drm_property.h                           |  3 +++
 22 files changed, 60 insertions(+), 3 deletions(-)
---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240623-drm-bridge-connector-fix-hdmi-reset-0ce86af053aa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


