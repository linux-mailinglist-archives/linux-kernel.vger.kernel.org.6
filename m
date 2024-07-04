Return-Path: <linux-kernel+bounces-241657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D064927DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3256828790E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF863131E2D;
	Thu,  4 Jul 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD0EKqad"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1414204E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120633; cv=none; b=T4F0rSeaSIbvUtmJn7FvFOxjBo5Y8BICauF0uwxVSzgvh4rHMV6YLNGco0FFJ7zSLMBaQVfYN9TpOXe6ebvB1A76wFN/bWD3Ko8XNs28v58JMCnGfuZ/LhAvtnPvMDhL9JVoLkTjzoLu08QuGkaY26aSlidU58rW1zCT6PrKaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120633; c=relaxed/simple;
	bh=EB5J+r5kFrFeaW4QDQqjIBc1cvwJxswklt/htDn32yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RpCegiGIGy2wS8zYXMgW0hOCfLMNdnd+r0oMBRfF8SOu4GXWRpKcbRhIXxt0L6gm2P9PHfJfy4ZLgdSiB/WEU9UFIin8ZosTWT+exue3vPSK7/tJ/Mb0bSk2mSsOcd6mPwgNGfS7jMWU1FpCzu4H6PuOxHeZxHJQ+grfWrtxP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eD0EKqad; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e991fb456so916487e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720120630; x=1720725430; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wVre2SxBMYBgXmlpdpsQlNbXS+4eCQaIUhshOOyPPM=;
        b=eD0EKqadY8vYN6tW2m2dyozGOjofi9I3k2aeBSfaV7kPzpeWOw1H/FutuVLyTB6wo2
         OmtszZuHrDQgcsuMqFV4wdHoO2befBkBxkhcu/n+4Ikb8Er+u43Sozh5+I8G3xRLWs9Y
         UU2uGoVoIykNNIbomM1KckqWOaOdG8P2l+M6dse4EATAvnG0FmO2op+qwP9UTjZzFAa6
         Hatnl+11wwmwt8kHeQgmM9YEQvPsavGsNdnctvNfcKz0z2FRFPVJUOvKfJZJ6HOmB9n8
         baEu8IFRki6MZ0qYJVtTq1bJCuNxXdwFMUmeDC5EcauDO0MqAvtL0xATkjPb834gJx3C
         JhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720120630; x=1720725430;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wVre2SxBMYBgXmlpdpsQlNbXS+4eCQaIUhshOOyPPM=;
        b=NJ9gGQeJVYxKLfPpFRbXJvr0TaKIkB5Y+g93jjDBpzJV45R1zRt1M1MmflnreQlytR
         c5d8wEDYRmA1MDZy7sMR0PTA21wdvPL8iYaTBjwVv4Yn5UbOcZbL9L7OsNYSs4yZe0Gh
         rueN5nKJHIO0GefIk4+IrNR67EhuPDMiBYE1jEq10Vbnpae7Sa+zGf9Dswe3l972fepL
         UDpLvN2UrI95QQO6XDy1iUe9OwYyv4alvcus/KkKbuF2USKP+k51ntOo7/ke2OaCeiw4
         TB3DoADiTf2Tg93lhraByp2b2gRR3QsYNKmUJLZ+9olZXGE00E2jyZFBdef/UeVx06Zr
         Z9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV49tvdNGO0Jw8e7uJpWFdYHrus5EaAtK6vFMRMQLKOItmR1nmgHWVWuxTgI7jpQ0n1rH6rDUAAwECAltejxTTxky0qUPqmDoRf0zth
X-Gm-Message-State: AOJu0YxM6GighQMQRBK2/D1+Pt51eFSsvwqUPNFG8MexsWkdUQMsyGIr
	cp9Ablf+ADNQdItsFuLVugcNtCnXB0e9aWF77bn8dLS/VcatDEXuxeS1CR7QKOY=
X-Google-Smtp-Source: AGHT+IEpAN9FJbUqjOVmLuHMHyufLg/IUIcYjwrw7gQRsGu0arTySk0d4oxbiqTopbo1El8C2IeDMA==
X-Received: by 2002:a05:6512:1187:b0:52c:910b:9c7d with SMTP id 2adb3069b0e04-52ea0df66a6mr812095e87.21.1720120629808;
        Thu, 04 Jul 2024 12:17:09 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e97de5ef6sm635046e87.58.2024.07.04.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 12:17:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Jul 2024 22:17:08 +0300
Subject: [PATCH v6] drm/display: split DSC helpers from DP helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-panel-sw43408-fix-v6-1-3ea1c94bbb9b@linaro.org>
X-B4-Tracking: v=1; b=H4sIADP1hmYC/33NQW7DIBCF4atErEvFDAPGWfUeUReAhwQpsiOon
 FaR716STVLZ6vJ/0nxzE5VL5ir2u5soPOeap7GFfduJePLjkWUeWgtUSIpQyYsf+SzrlTQpJ1P
 +lilZQ30EhMCi3V0Kt/lhHj5bn3L9msrP48UM9/U/bQapZECHKXVokPDjnEdfpvepHMWdm/FJG
 NgksBEDcOqBGUI3rAj9QiBuEboRtleIzvghRrUi6JVwWwQ1QmsVCIlMiHFFmCdhUW8RRoI0pMA
 HC9xp94dYluUX+8+a3r8BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5642;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=EB5J+r5kFrFeaW4QDQqjIBc1cvwJxswklt/htDn32yU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmhvU0SfCI4iVIgT+QLF8ngmHFDvj5roZf3axsQ
 p2cURhDTBCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZob1NAAKCRCLPIo+Aiko
 1aN2B/9IioG/JNs/7TE4AxP4n6qIGUxISXut5Mv93XlV15PJswNNnOTZdP4x5pqcjp9xIBcekz2
 a1kyrP3RijZOx5zKxtS57Xdyp6rnCVVWgUBZCi0pDFEjN6ApOCaZTlxiL8kxH+FOrvcnYx4vSbc
 bJqh4y8BQV9cQoGYlcQ9Or9PGZiQc+IGs6SQJYs/M8C5fDu/pmVy1Ha6OU0dGKsSGlizL/HuQDs
 J5gBVCbkJ3UhFwSLNQz8vgNy5SXQxxuLNUcQO06D+e1Vlnxe1yQkWvJG7vax561Us46lGSuRFju
 HoZEcKgEZWrWjo9H2ioK1V8tMk41qeQ2ua10HaIWx4F7HkS9
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Currently the DRM DSC functions are selected by the
DRM_DISPLAY_DP_HELPER Kconfig symbol. This is not optimal, since the DSI
code (both panel and host drivers) end up selecting the seemingly
irrelevant DP helpers. Split the DSC code to be guarded by the separate
DRM_DISPLAY_DSC_HELPER Kconfig symbol.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> #i915
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v6:
- Moved the Makefile entry to follow the sorting order (Thomas
  Zimmermann)
- Link to v5: https://lore.kernel.org/r/20240623-panel-sw43408-fix-v5-1-5401ab61e738@linaro.org

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
 drivers/gpu/drm/display/Makefile   | 5 +++--
 drivers/gpu/drm/i915/Kconfig       | 1 +
 drivers/gpu/drm/msm/Kconfig        | 1 +
 drivers/gpu/drm/panel/Kconfig      | 6 +++---
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 0051fb1b437f..fc3237da8090 100644
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
index 629df2f4d322..a023f72fa139 100644
--- a/drivers/gpu/drm/display/Makefile
+++ b/drivers/gpu/drm/display/Makefile
@@ -6,10 +6,11 @@ drm_display_helper-y := drm_display_helper_mod.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER) += \
 	drm_dp_dual_mode_helper.o \
 	drm_dp_helper.o \
-	drm_dp_mst_topology.o \
-	drm_dsc_helper.o
+	drm_dp_mst_topology.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_TUNNEL) += \
 	drm_dp_tunnel.o
+drm_display_helper-$(CONFIG_DRM_DISPLAY_DSC_HELPER) += \
+	drm_dsc_helper.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_HDCP_HELPER) += drm_hdcp_helper.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_HDMI_HELPER) += \
 	drm_hdmi_helper.o \
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
index 26a4c71da63a..420385c47193 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -112,6 +112,7 @@ config DRM_MSM_DSI
 	depends on DRM_MSM
 	select DRM_PANEL
 	select DRM_MIPI_DSI
+	select DRM_DISPLAY_DSC_HELPER
 	default y
 	help
 	  Choose this option if you have a need for MIPI DSI connector
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 9f49b0189d3b..dac01ade7e2e 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -369,7 +369,7 @@ config DRM_PANEL_LG_SW43408
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for LG sw43408 panel.
@@ -578,7 +578,7 @@ config DRM_PANEL_RAYDIUM_RM692E5
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Raydium RM692E5-based
@@ -936,7 +936,7 @@ config DRM_PANEL_VISIONOX_R66451
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Visionox

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240420-panel-sw43408-fix-ff6549c121be

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


