Return-Path: <linux-kernel+bounces-192952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB98D24D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184BF1F297DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A9178371;
	Tue, 28 May 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a++eu+yR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A842E639
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925164; cv=none; b=R+wSqDq2coWsNz7XYoozULmCzhziSblrPoKxyRbO3RLnQXdviWaPwuaBk/pH3SLd7fk9Ni5d6vYL4RErmbgkBGVTs6G9p7a2CmeSPua+8O79A/iwpyygZw2WEO7qtXyPBhXNlOtXKLsub0RpW1pH/3Rqvk2eIUAytNl5ZD8XudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925164; c=relaxed/simple;
	bh=onL8Mw3fVTnsVXTG9+UAfGyF9JpZXOhojGn8QWOqrnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PPOOrfnXT8u9woIngycz4EA/ON5jvZpARKQFP76CSJRJwGAKUpy9QNc9FB8EKJAbcKlLSOtFzNnou4JkSLgueta2CvWiM27bvSTk7eBJBmzv4Kyz6E/LrHUYJbrAu7g8P+hZ/UqwICIZ5X50FbmSd9Uyd1xbKEsY2EhsmbYCdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a++eu+yR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-529b79609cbso2061331e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716925160; x=1717529960; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsvN+JKnRavl5QSzlBkV48YEdvFno7OOnb/yOsGADHU=;
        b=a++eu+yRhrVuC/crmCNlWQcRYMF/rwcnBKkxrGLPXQ0UR4qEIR5GTViUeT4p12QcrO
         eSJwrotadnhqJZ4JTfRbgvDzxrrNSsKzJ0CJY6Y9p1gL5LMc5BKvav/fn918tmm0zIwx
         TJGys65Fqqm2lu0tQ3SGsuPfq771kI1E4tJH4G1OZzW8Wfkoz/Reg82sGwWYJLyjD/B8
         yOT+qn94MM605WlaxVU48NGfeGmXBdB8EhExWqdURvg/A5fS1x/vNPJAeJkR9PJOn7f3
         Guz7o+SQEwmvYKQRrBrq8D0xWFegVLHHX0kBoHqiK28FSkE7Q4acjGBWFtHrFKGtEE4T
         Hk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925160; x=1717529960;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsvN+JKnRavl5QSzlBkV48YEdvFno7OOnb/yOsGADHU=;
        b=HQUJbiZzn62CInaoLulqoV5NOAuf0fTWTMtnLX/sjoEadIb1lI3PxlouTdT9GtprTF
         6pJBW3mYjYYVf44nyTER7YB6Lbjj0eJWaULXXc+BcYQbyRpbviw9g5I/kBt7zi4hIRRh
         xoVrRsw1vQ0vQZQLSKsp9QJN1jQrZWd+UxPKJrABpzMktbh95xsgdeifv59/LsWiB9Q4
         cWYE/RAj0oxwVEC+Js62x/gj4IG1ADD8pKFj0ZlXq+eWhqnu1qB5MV5lbe5OkEfpgXO8
         cZZKXWFvJvMtyFs+d+QpObKOGszufC30o8gwduX+ZXXnpxiC9OBT4MQ2aKNYwAbQ8X13
         Fb8g==
X-Forwarded-Encrypted: i=1; AJvYcCV6U+nQ9y2m03dbjI1HNbJ4jGbG5seytID0qLjLLZTCwfaDxv9mdSvIIRiLQmMEyWq8ycXpn5uuO6ks0hwnFkgrzjQNKNhhYD3hbIo6
X-Gm-Message-State: AOJu0YykKGPTdLMXn0IXFZlgeIxmQaZwSzbLgMT5CKYp6W6mzW9WmHBU
	rpReurG3eRvf+mGEK+Y9Dv/ZUto33GSKSTK+S09rARLIqVXPmRt8d32qcfuj+nI=
X-Google-Smtp-Source: AGHT+IG4Bg7IjMdNadZXXn/36zsu8ZDorgbs/IEsWcGO+A4iZozCmrOizaHidaPk9MqyT8DHXEBeFg==
X-Received: by 2002:a05:6512:4004:b0:529:a55d:8d7 with SMTP id 2adb3069b0e04-529a55d0bbfmr6389655e87.14.1716925160173;
        Tue, 28 May 2024 12:39:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711f96c9sm1045234e87.245.2024.05.28.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:39:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 0/3] drm/panel: two fixes for lg-sw43408
Date: Tue, 28 May 2024 22:39:17 +0300
Message-Id: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUyVmYC/33NTQ6CMBCG4auQrq3pDOXPlfcwLqBMoQlpSWtQQ
 7i7hY0aicv3S+aZmQXyhgI7JTPzNJlgnI0hDwlTfW074qaNzVCgFBIFH2tLAw93mUpRcm0eXOs
 8k5UChIZYvBs9xXkzL9fYvQk355/biwnW9Z82ARe8wRK1LjBDiefB2Nq7o/MdW7kJ30QGuwRGo
 gXSFRBBU7Q/RPpBIO4RaSTySiCWWd0qJb6IZVlermC2JjkBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=onL8Mw3fVTnsVXTG9+UAfGyF9JpZXOhojGn8QWOqrnA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVjLmMvog05l/rjjZInaoUZ1R3/bqphbSLBIfW
 aq0YIVDkQWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlYy5gAKCRCLPIo+Aiko
 1QNTB/4zOPgYNZ7IwjqDIlZP52hwwALdFOgW40rNUxQK3Bt6S4RFuv5WnMmuoCt5j9FHXYdykoC
 CtUjUijy6ejoLZM0sEpqMUpxzMcvLjY+XONRDuCJQPUx5/4G7PUOxkVwafCxCoKm1DGagx0jEYO
 VnSsUqRcNqmx+em7fuef89wv+7WQIENkqTGMF7hJ/5tiSzTlYcr29p+NkYF1uR+GC5qS5+Up4kt
 ifjq01NFjn4Jp6VqjQJLB8sXMZZurnY0uP/k8i4DCW2HyvFfA8EVqXn/dwwBiUBy9J2l366rpiI
 ypKLjqXG3bsSObFF8OvQitHTwmnrEEcD1LlWNloeahJPpj6N
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix two issues with the panel-lg-sw43408 driver reported by the kernel
test robot.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v4:
- Reoder patches so that fixes come first, to be able to land them to
  drm-misc-fixes
- Link to v3: https://lore.kernel.org/r/20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org

Changes in v3:
- Split DRM_DISPLAY_DSC_HELPER from DRM_DISPLAY_DP_HELPER
- Added missing Fixes tags
- Link to v2: https://lore.kernel.org/r/20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org

Changes in v2:
- use SELECT instead of DEPEND to follow the reverted Kconfig changes
- Link to v1: https://lore.kernel.org/r/20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org

---
Dmitry Baryshkov (3):
      drm/panel/lg-sw43408: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/panel/lg-sw43408: mark sw43408_backlight_ops as static
      drm/display: split DSC helpers from DP helpers

 drivers/gpu/drm/amd/amdgpu/Kconfig       | 1 +
 drivers/gpu/drm/display/Kconfig          | 6 ++++++
 drivers/gpu/drm/display/Makefile         | 3 ++-
 drivers/gpu/drm/i915/Kconfig             | 1 +
 drivers/gpu/drm/msm/Kconfig              | 1 +
 drivers/gpu/drm/panel/Kconfig            | 6 ++++--
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 7 files changed, 16 insertions(+), 4 deletions(-)
---
base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
change-id: 20240420-panel-sw43408-fix-ff6549c121be

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


