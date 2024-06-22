Return-Path: <linux-kernel+bounces-225883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771119136B7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D86E283590
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646567A140;
	Sat, 22 Jun 2024 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJPvcjoY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EC4CDEC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096264; cv=none; b=plmY/yrmHtPTlRyO6x1QZcOwGGF+sGG4KXdwZ74qU/M4AQdx9ZhQJ6aJF3uCo048biGOqbEPEOqZvCzSrolSQAS0hy3d/DopWNHI8aubmzKsVmwFWiNhotsb/J/vBvW/icpbrpqsSDSmjkZlLB5qJfBJtckdUfPPX4rdJ8TlhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096264; c=relaxed/simple;
	bh=DMJyhKanCJP+dMIWYlrCNyg0Und4SQa32BNd1XlDk3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W8r0VZ/N0Eb9BEanKeT2oS3mQasCKuvHgaFdpWK9E4qD1rSI4TAuM8Z77e5M33lzQxUCdoo0EyOwutnGjFzG6wQcJr3Q8mWwHJk2Hz3nbf6b6eh76QscaTYEZ+gEFB/DcHEZ8YbAFsI55mzSH07q1g0p7uDFoUZ9EG7ts9cSfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJPvcjoY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso31741351fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719096260; x=1719701060; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hb4h18T1ibOKTo0yZzuu8k0jFemz2DPXX/Y7zaLl54=;
        b=oJPvcjoYyGylLRjOjNk2bS9C37wpuogjCErEQXggDPvEdojFFrridYVI0u2Vj+CQBZ
         Wnwx4vi8gxQyBD6m4vWYRY4aij/u9KCGiv8wezhka1G7JhvB6BPIwquDXDGZh7hDbvEx
         nfZhvUs1+x4z8VqKjL0hwAfP083yUV3Mspa4IKKooTCCNOhIyGH+m2LkFDadAmEo9Qut
         kblPAe4/Qd/1NFy3DU+EGvmo3L+IIMfsPdJXIdkRDPyU5faALyiULhwo9WINTuL+BMS5
         IpTnoq7OSofpW5EDgzj8x67wsHbHYJUKBcjaXsqHxK8JjVWfww76i80TSe9WQfEO2OWz
         Mh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719096260; x=1719701060;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hb4h18T1ibOKTo0yZzuu8k0jFemz2DPXX/Y7zaLl54=;
        b=um6AK129ZS2lDBhmA2Uz+0ls9BNvHiRj6ZGq5dFUektoiFTP5Itkx0rOYeoB4L2Jjf
         2F3F/ymT7OGPas129kIozVKDwEqcL9I1yg6Zy7Hym8V7bzdTAMU1RQtgaJWDJJui5qCV
         CPlfYrBOlX7mcQlVidG5xtdroQVVUE7soN40admHrz4PQ9iYGK6spIG88EsR2QKbp8yN
         u5fztBSTWUBQfyyaG+DvmgPOTpiRkrgbHf/oVm1UQoQqWK4bXRTrV5R8nD5kfR7SuTDo
         ismNxBijCVEEh9/fpg0+yczvPTGvCxnoeicCNaZLH52YeFZ+F6mb8ZDZMOoCLZoA6N/k
         nvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVlQAMSb+tTxyufY5R/PbIeVrYTQmAzqtwQHKWAXeZYW9M5JyDjByUhfPUIwTIXXggKoHA7bj3f4cYWnUDCjojgptRxhijg3Y09f8
X-Gm-Message-State: AOJu0YwWG9d2KEwt6nafgCJS8DfuYxDgyytBcvota4W2A6KIGuYZ3Y3F
	IseyBeIYL2VlLOyEVOeyqs+j/+SeQsFVq9zChz7QrbFgsBAjHTKYAy2J1RJo15Q=
X-Google-Smtp-Source: AGHT+IHDFKpNtjP5Vc5MfkY1zgYcpOqGHEQfDcxZxuoqCTLcSIIbnEU06RZGjGI/7az/tasOewANmg==
X-Received: by 2002:a2e:9087:0:b0:2ec:4d48:75f3 with SMTP id 38308e7fff4ca-2ec5b30765emr4074481fa.45.1719096260415;
        Sat, 22 Jun 2024 15:44:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d757f93sm5582431fa.78.2024.06.22.15.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:44:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:44:19 +0300
Subject: [PATCH v5] drm/display: split DSC helpers from DP helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240623-panel-sw43408-fix-v5-1-5401ab61e738@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMJTd2YC/33NQQ6CMBCF4auQrq1pp1MEV97DuKBlqk0MkNagh
 nB3CxsxEJf/S+abgUUKniI7ZgML1Pvo2yaF3mXM3qrmStzXqRkIQIEgeFc1dOfxiQpFwZ1/ced
 yjaWVIA2xdNcFSvNsni+pbz4+2vCeX/RyWv9pveSCGyjAuQNoQDjdfVOFdt+GK5u4Hr6ElpsEJ
 KKW5EpJJM2hXhFqQQBsESoReSkACl3V1ooVgUui2CIwEUoJg4CojbU/xDiOH+2U74l8AQAA
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6294;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=DMJyhKanCJP+dMIWYlrCNyg0Und4SQa32BNd1XlDk3g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd1PDaDbcOaO6AVtbWU5HxAGmxznblgOYlZqmu
 ahB+KMXckCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZndTwwAKCRCLPIo+Aiko
 1VDpB/4o/mUbXW19tpmrel48R/vqM1tRHBa71mqLYLVvB7jeKUyzS2yzoKpzdZ711v9CxWGh/ha
 +vYxvkMMnmNQDqzeLbYO6H3wf37eBbFXKCTWY2/lCFeRbINxtEkTmY7eg8C4Pzd4I9wOPpjqdML
 abHFYOs4Z+dUw09rkDo8U8mexj9u5FQ/t3kpQ8H/O33d86961velqT7cLuCw/MQA0h8A8o5vPmw
 qs5NAY6cdoa/62+szgo4md/KDOLbHYbf6U2ay4SPmmMXs24CV3+5Iu0wh3M1LxY13VoI+Z5wG2o
 goG2Sk8GIz8YeUNQuMFLZZKqFzqZjiRfOMaBN0zg3D8hIe3m
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Currently the DRM DSC functions are selected by the
DRM_DISPLAY_DP_HELPER Kconfig symbol. This is not optimal, since the DSI
code (both panel and host drivers) end up selecting the seemingly
irrelevant DP helpers. Split the DSC code to be guarded by the separate
DRM_DISPLAY_DSC_HELPER Kconfig symbol.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
To: Pan, Xinhui <Xinhui.Pan@amd.com>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Rob Clark <robdclark@gmail.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Changes in v5:
- Drop applied patches
- Link to v4: https://lore.kernel.org/r/20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org

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
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 +
 drivers/gpu/drm/display/Kconfig    | 6 ++++++
 drivers/gpu/drm/display/Makefile   | 3 ++-
 drivers/gpu/drm/i915/Kconfig       | 1 +
 drivers/gpu/drm/msm/Kconfig        | 1 +
 drivers/gpu/drm/panel/Kconfig      | 6 +++---
 6 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 4232ab27f990..5933ca8c6b96 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -6,6 +6,7 @@ config DRM_AMDGPU
 	depends on !UML
 	select FW_LOADER
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index 479e62690d75..a2e42014ffe0 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -59,6 +59,12 @@ config DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
 
 	  If in doubt, say "N".
 
+config DRM_DISPLAY_DSC_HELPER
+	bool
+	depends on DRM_DISPLAY_HELPER
+	help
+	  DRM display helpers for VESA DSC (used by DSI and DisplayPort).
+
 config DRM_DISPLAY_HDCP_HELPER
 	bool
 	depends on DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/display/Makefile b/drivers/gpu/drm/display/Makefile
index 629df2f4d322..df8f22c7e916 100644
--- a/drivers/gpu/drm/display/Makefile
+++ b/drivers/gpu/drm/display/Makefile
@@ -6,7 +6,8 @@ drm_display_helper-y := drm_display_helper_mod.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER) += \
 	drm_dp_dual_mode_helper.o \
 	drm_dp_helper.o \
-	drm_dp_mst_topology.o \
+	drm_dp_mst_topology.o
+drm_display_helper-$(CONFIG_DRM_DISPLAY_DSC_HELPER) += \
 	drm_dsc_helper.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_TUNNEL) += \
 	drm_dp_tunnel.o
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index faa253b27664..db400aad88fa 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -11,6 +11,7 @@ config DRM_I915
 	select SHMEM
 	select TMPFS
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 1931ecf73e32..6dcd26180611 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -111,6 +111,7 @@ config DRM_MSM_DSI
 	depends on DRM_MSM
 	select DRM_PANEL
 	select DRM_MIPI_DSI
+	select DRM_DISPLAY_DSC_HELPER
 	default y
 	help
 	  Choose this option if you have a need for MIPI DSI connector
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index bf4eadfe21cb..afae8b130e9a 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -349,7 +349,7 @@ config DRM_PANEL_LG_SW43408
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for LG sw43408 panel.
@@ -558,7 +558,7 @@ config DRM_PANEL_RAYDIUM_RM692E5
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Raydium RM692E5-based
@@ -916,7 +916,7 @@ config DRM_PANEL_VISIONOX_R66451
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Visionox

---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240420-panel-sw43408-fix-ff6549c121be

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


