Return-Path: <linux-kernel+bounces-574435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3ECA6E544
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D2C16636C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869EB1DE8A3;
	Mon, 24 Mar 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9MdASJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F561DB548
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850510; cv=none; b=TqM0ewjHN7rfUEX6nSj22ZiQrkFrConmQur9UBwn7s/10El4ianD6xynT3GCDP2c+QEE1Zco8KNwiWftFZ+BYPgnfxkX0MC4CQazeICN1ZV1NNOmXMtRDtWIo7DID9Xt7L7/rV7n7q6Hh4WRHy+FrrTg0msgSNk/n8GxzuvqEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850510; c=relaxed/simple;
	bh=DoITmuJ3b3WOGd7I+KeumI4DPUboRPzOkttm2Ikla9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fDpyku0AKIgqs8eG/Bw/W48cm3Ajp9BWd9GSnPenjJm+WkVeGlonwTQi/Wb74k5pAe7p5vs5N4HEhGQAKiUR01aQVmkYg6CNJZLiPSQU164hbkaWZtaQGCrogf1j4JdkBgmjWn3zL18MFifqw7oSBx31JPG6TR+kMeRHdYBcWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9MdASJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F1DC4CEDD;
	Mon, 24 Mar 2025 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850510;
	bh=DoITmuJ3b3WOGd7I+KeumI4DPUboRPzOkttm2Ikla9I=;
	h=From:To:Cc:Subject:Date:From;
	b=R9MdASJAsUM0hFhYVVEzZ3U60/C7i09hn1bmiutfAjfsZhYHb9PhpaOz7Tt3+qLzv
	 IqETLEYI9oS4F7tN2oH4sKDgZS1t+LpYnCBnsK6aJrgvMQODJkN0azZkksZ3HqgxZ1
	 pZ+a0nV+3CQze0d9DgIlU+28R2XSeVnGFyW2+AMcnSrs41Nlc6a7c3W/9bhq9pdgbh
	 kEp6OrHj7Atusr0dTns2/HXL0bDqB7qs/HH6E8+lz1aQUXq89B3xf9Epwh5St9t/55
	 vQ/7NExMz5pQ4jXCv6PRQ3ObAVy0WZOTfngioztSPI3L2arG0A4AEbZjmkfc+8rum6
	 lFQ+RKKslc6PQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Liu Ying <victor.liu@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i2c: tda998x: select CONFIG_DRM_KMS_HELPER
Date: Mon, 24 Mar 2025 22:08:07 +0100
Message-Id: <20250324210824.3094660-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This fails to build without the KMS helper functions:

x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o: in function `tda998x_detect_work':
tda998x_drv.c:(.text+0x4e6): undefined reference to `drm_kms_helper_hotplug_event'
x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o: in function `tda998x_bind':
tda998x_drv.c:(.text.unlikely+0x33): undefined reference to `drm_simple_encoder_init'
x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x584): undefined reference to `drm_atomic_helper_connector_reset'
x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x590): undefined reference to `drm_helper_probe_single_connector_modes'
x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x5a4): undefined reference to `drm_atomic_helper_connector_duplicate_state'
x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x5a8): undefined reference to `drm_atomic_helper_connector_destroy_state'

Select the missing symbol and fix up the broken whitespace.

Fixes: 325ba852d148 ("drm/i2c: move TDA998x driver under drivers/gpu/drm/bridge")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index d20f1646dac2..09a1be234f71 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -91,12 +91,13 @@ config DRM_FSL_LDB
 	  Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
 
 config DRM_I2C_NXP_TDA998X
-       tristate "NXP Semiconductors TDA998X HDMI encoder"
-       default m if DRM_TILCDC
-       select CEC_CORE if CEC_NOTIFIER
-       select SND_SOC_HDMI_CODEC if SND_SOC
-       help
-         Support for NXP Semiconductors TDA998X HDMI encoders.
+	tristate "NXP Semiconductors TDA998X HDMI encoder"
+	default m if DRM_TILCDC
+	select CEC_CORE if CEC_NOTIFIER
+	select DRM_KMS_HELPER
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	help
+	  Support for NXP Semiconductors TDA998X HDMI encoders.
 
 config DRM_ITE_IT6263
 	tristate "ITE IT6263 LVDS/HDMI bridge"
-- 
2.39.5


