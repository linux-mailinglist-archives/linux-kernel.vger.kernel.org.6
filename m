Return-Path: <linux-kernel+bounces-185805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD678CBB27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868D628280A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931F79952;
	Wed, 22 May 2024 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZNGAIM/"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2278C6E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359159; cv=none; b=N+I4vYvZiVnM9uz5InLcqt7K2i0B/WfSiaMIGLjkIYu+NCgVzsOpmLyyw9Xvk4GLRvpsSdcMJAuCmWsRGnHcn06S6o9sVx72sAYOMOWtBecB1bJdar1mDZH8Hd9WwQK533SqFfuKhXR+DtU59hUBydeYDfuQDutwMuHPHfCd8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359159; c=relaxed/simple;
	bh=oRcVW2b7RmaHCnZgU9s+liJiuQhOof/Wv7h+/P64vIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aEqQ/c++2XGhg/TH+T3eE2kRIkmSei8Ad4cEXBZiDEzFIzAVzIcq3J0E5FwsMT0IXWpRlmr+Lt7CQJL4hKdZUpgn2jKPQn7bpTXFF8KhXT/+VVvLWFUEXfk9PTeN5+lwtWAaxyPZA6xlFFwjdrjKchHiN97HsYr/bT5l9WPVU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZNGAIM/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f40b5e059so6606055e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716359155; x=1716963955; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXLCoFAT4Nr83TUnXDuvZrugwAWtGHeO95Weg/poUGU=;
        b=LZNGAIM/06KGLLzkJN+1qyEVEDoM1v/xzOw+BB09Gixof/y1hZajmsSM7Ob12s5qu5
         ucJQH2DpTOEiBExQEZFUiSblPCvQzo4UVkPvmL+DCdy8aJQUu6rsJeXtlPrwxxQglBM3
         meAmGUHYadkDEqxmOTwNKqVIsuY4BEWHPMCArMnXgpKCAPa8VnDedlxa/hjQ89luLJk8
         liGcriPC0/H2mX1Geu7PWHxxxAsYfQWBr5pbT+ccUx9rIVgVeFJjzlVNxgVtxlTBVCog
         BzH+oJ4E0V/u9S9//s57CKyb4PBNGB522sbPgwn9KZARyvMVWBlIJfsmya4LkwkNWXVq
         /DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716359155; x=1716963955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXLCoFAT4Nr83TUnXDuvZrugwAWtGHeO95Weg/poUGU=;
        b=e31ov89TJgwZkSrRsv3pCeMEquHOLI8GDeN6ox0ErRCyRTTeo3mPfC1xA6+qYBYurQ
         PxxFFpvArKJPLb+xlIxltWLTjuWpw1dvkzLgPLGtQLVoRwTcMi0ghs0udMIj+zfaQZ11
         vIHCCUR2JvJqtexndhtoamUhu+UtuWUhO2AO45CIkOEwX2zJtbCXgT9RFEVWDrQym9oI
         sTkr97zxD1TV1OCVF+Cs0pv/1pRbVo1Zuc3Uth3uixi1JdMIL+2U+uVkT7g+iiUwsm3r
         9EXDtFSHVLQWDWO2Wz4GkRhRwne+Km8/KLOKkhtrw4qiG7u6N26P5MbQ4EKXsRK3jfZU
         0mSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZGd/42tffZQ2N4UpYLv2jkmcO1kWrN+ctXPoPeqSiT2qR5gIph+XN2aNUUpfEJB03T7ReLiz3gUo8YCW6CrBFG+7vSaYZibodheFH
X-Gm-Message-State: AOJu0YwCpjbRQEtpPRppRFqr3MXH/fcUVbtmdgfTFQQJZWNNIau+wJV+
	nuxGNFeltQrHYN03EYuK9LP7MGJtlgmdrsAbB+tewFuYtwqh5KsaJnYOBXtN7Zo=
X-Google-Smtp-Source: AGHT+IGX+HGpof31CbGG3ey+krSYpZvkL10bQ1Csjx7rDsXyKZf7WF8br6dYBsvJYIvPPjp//uYZNQ==
X-Received: by 2002:a05:6512:358f:b0:521:f000:5d1a with SMTP id 2adb3069b0e04-526bfc02c3emr486204e87.59.1716359155168;
        Tue, 21 May 2024 23:25:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad4d0sm4910023e87.49.2024.05.21.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 23:25:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/3] drm/panel: two fixes for lg-sw43408
Date: Wed, 22 May 2024 09:25:52 +0300
Message-Id: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPCPTWYC/33NTQrCMBCG4auUrB3JTFPbuvIe4qI/kzZQkpJIV
 ErvbtqNCOLy/WCeWURgbziIc7YIz9EE42yK/JCJbmzswGD61IIkKalIwtxYniA8VK5kBdo8Qet
 ToeoOCVsW6W72nObdvN5SjybcnX/tLyJu6z8tIkhoqSKtSypI0WUytvHu6PwgNi7ShyjwJ0GJ6
 JF1jczYlv0Xsa7rG2ClSEP2AAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oRcVW2b7RmaHCnZgU9s+liJiuQhOof/Wv7h+/P64vIQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTY/xD9ITufJQSk92eKn4zrpAjtoqX7DTPDRhO
 pcE8CPeuxqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk2P8QAKCRCLPIo+Aiko
 1fxLB/4q18LHEJ28oA5ep3OXXNTUN19o1mCkDD3brnUoQ8pC9gwRIaQriJw5p1tNseccfBTK3wR
 tuBJAdnZjzi6rlANM+JVasAlooV9fVtWi/HLaF5QDb+r4rb4nUbFBGr2WLD5DnkTjEcaeuQ4ucj
 Z3tXVxKBh+f5fq74jtPYIglVBdFt1r5x6RD0DTXAKL3BF0HsI6esPyiAGQCyreQjQd9Fhf8RSUG
 BU+ZQyuzoWyUmwp/yyJfyTGxFnRkxZ3kVyoEQRfys7hR2+4BhCTCMENhyMK+0LERl0qKLDV6UCr
 BXjjWSgi8V4Gsw1gHHoFqSodE+W5HRDBlrZEpS712YzAICCm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix two issues with the panel-lg-sw43408 driver reported by the kernel
test robot.

To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
To: Sam Ravnborg <sam@ravnborg.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
To: Pan, Xinhui <Xinhui.Pan@amd.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Rob Clark <robdclark@gmail.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Vinod Koul <vkoul@kernel.org>
To: Caleb Connolly <caleb@connolly.tech>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Changes in v3:
- Split DRM_DISPLAY_DSC_HELPER from DRM_DISPLAY_DP_HELPER
- Added missing Fixes tags
- Link to v2: https://lore.kernel.org/r/20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org

Changes in v2:
- use SELECT instead of DEPEND to follow the reverted Kconfig changes
- Link to v1: https://lore.kernel.org/r/20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org

---
Dmitry Baryshkov (3):
      drm/display: split DSC helpers from DP helpers
      drm/panel/lg-sw43408: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/panel/lg-sw43408: mark sw43408_backlight_ops as static

 drivers/gpu/drm/amd/amdgpu/Kconfig       | 1 +
 drivers/gpu/drm/display/Kconfig          | 6 ++++++
 drivers/gpu/drm/display/Makefile         | 3 ++-
 drivers/gpu/drm/i915/Kconfig             | 1 +
 drivers/gpu/drm/msm/Kconfig              | 1 +
 drivers/gpu/drm/panel/Kconfig            | 6 ++++--
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 7 files changed, 16 insertions(+), 4 deletions(-)
---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240420-panel-sw43408-fix-ff6549c121be

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


