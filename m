Return-Path: <linux-kernel+bounces-371901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465849A41F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3B9281FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BA2200B93;
	Fri, 18 Oct 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4DnIe2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92F2746B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264136; cv=none; b=MDBIfvr3hzL4VHf6B4dUdc5doKhWFtu+OYxOR1IefuOXYKISK6QbWum/hgGoQL3bxKLaor7mj9NDaeQKEh2jEWa+rIxsG7vYCUrwrTY4B46O8QTk5MuPE9/tqzFiokd/pi1bWIzCEr9ywBStrRpMqsci7L8sQ8F6QtRYL6A4hzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264136; c=relaxed/simple;
	bh=latyxkadioFYo8ef1ZgGf1RqY2UASR0JhFNU12tkpec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6I5Cso3rDNa7sNUjETZQDNms0EZv+Q7ZXiUlRc64fGyv1V6wnST0/Gydt7LDMRbBISlGePfAviMQvt1+fe1Qn7mWTANIb6RGxFL9DV8YgyEe832XnFm6fMH6jzygQJ8g7f4OUt+inSwtI8N0v47wxn6L2Zkgn5PmxO05GSGpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4DnIe2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ECDC4CEC3;
	Fri, 18 Oct 2024 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264136;
	bh=latyxkadioFYo8ef1ZgGf1RqY2UASR0JhFNU12tkpec=;
	h=From:To:Cc:Subject:Date:From;
	b=C4DnIe2DzJVIt7yxvdCcvRJ8TX2cwMtXPLpRvalEy5uc4PHdNmq4I0nXgVfutkJZg
	 7RIGXcv9d1jRThiGiIpyvyD7SZDosUOJ3OCjSVOC7yFpNemmrQ8zzOxfV466nXqx3/
	 0vjTIn8LNtcFka+u3VUUVuNTknhdlQcdArm8v5ceYNjCW/Sw78QoI51VBe4mMGBn6Q
	 G4suXjg5164IcWmV6KDSqfyKIsEC1nLoBjGYbwWHc7z5VXF6L+KZHHPUrjUJVK3zMM
	 3yef58A3BPvdFlzwZwYZnSnWsjdvPqDS/n5sZ7ARQz8m6Fz2DIop7EGaZrffpZRejv
	 gecmkvYdIp9Ig==
From: Arnd Bergmann <arnd@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Imre Deak <imre.deak@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge-connector: select DRM_DISPLAY_HELPER from DRM_BRIDGE_CONNECTOR
Date: Fri, 18 Oct 2024 15:08:45 +0000
Message-Id: <20241018150850.3418359-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The imx display drivers use the new bridge connector helpers but don't
explicitly select CONFIG_DRM_DISPLAY_HELPER, leading to a link failure
in rare configurations:

ld.lld-20: error: undefined symbol: drm_bridge_connector_init
>>> referenced by imx-ldb.c
>>>               drivers/gpu/drm/imx/ipuv3/imx-ldb.o:(imx_ldb_bind) in archive vmlinux.a
>>> referenced by parallel-display.c
>>>               drivers/gpu/drm/imx/ipuv3/parallel-display.o:(imx_pd_bind) in archive vmlinux.a

Move DRM_BRIDGE_CONNECTOR out of the DRM_DISPLAY_HELPER block and
instead select that symbol indirectly.

Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/display/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index 0f07cf1483ff..beb05d9bab50 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -11,14 +11,15 @@ config DRM_DISPLAY_HELPER
 	help
 	  DRM helpers for display adapters.
 
-if DRM_DISPLAY_HELPER
-
 config DRM_BRIDGE_CONNECTOR
 	bool
 	select DRM_DISPLAY_HDMI_STATE_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  DRM connector implementation terminating DRM bridge chains.
 
+if DRM_DISPLAY_HELPER
+
 config DRM_DISPLAY_DP_AUX_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
 	select DRM_DISPLAY_DP_HELPER
-- 
2.39.5


