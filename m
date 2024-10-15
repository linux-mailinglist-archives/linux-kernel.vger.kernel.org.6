Return-Path: <linux-kernel+bounces-365235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B192199DF52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B270B21848
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C88199FA8;
	Tue, 15 Oct 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/aMMY2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27D4C7E;
	Tue, 15 Oct 2024 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977411; cv=none; b=Ep9lNLodlmfdct8KmB3+UQfJ4gMmIRO5yheFWxNeBtJDlLN4ygpU2g054A0XXLlSK4NK8WVEhYTyvRxZvXU3M1EpPX4JWEt0W7ReWnF7ceAwUaatGMC9oth7oZdJoGsj9S8pkXHMb7kBUzyp+UlDnaZCcZKkwNrxuee3+eRUc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977411; c=relaxed/simple;
	bh=WzQng1jqigLHiW/ZeFs9Mk/VLb7dmk5XfaPiLi6P/U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H0En4a6/mEuNbIV7mA4RrWH3vD0sT8aCOeKvIwqFoLYAqSV5jsTMET4PWtvGjUQMWLJUyPWSRZBEdLUWvKOmlbZJ1r1oOQoLmnVnKD1zRJoxVfnQnUrDjK13/GIBw/Dqe47RAGRmAdcSbosKV05dYwyNMpZ3VIC2XEqLuof2LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/aMMY2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5810CC4CEC7;
	Tue, 15 Oct 2024 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728977411;
	bh=WzQng1jqigLHiW/ZeFs9Mk/VLb7dmk5XfaPiLi6P/U4=;
	h=From:To:Cc:Subject:Date:From;
	b=G/aMMY2RTpSHa/d9iSlkbAP8/2+6vPMCQj7WcPtrsPpvFCOFje8w2wZwdz+e4wQiu
	 Kp7Bq6TEHSUSsD5IpvX9ZK8mOkQEENGT5w0qlsCCBL5Mt6QibSOEFXs5FVsDLbuJUX
	 cuJvFXopzldl1ywj+8eSw5aDrOuAa7q4a+KOxAHeMX0jHV2+3eINPuL38nigxOIW78
	 6WJD9ZJeTb2zVlU8X7gi1A+EoXvTNx1jBpiusAg26WbwWs5yFjx4A6P6ekxAmwqXws
	 DPEZGlNnx2OSiYnHgvH82/uyGMtR1xUJxW2b6L7cMAyARYp9IvWMSO7njdAZooskBg
	 B8/XL1sUO8rlA==
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/imx: parallel-display: add legacy bridge Kconfig dependency
Date: Tue, 15 Oct 2024 07:29:57 +0000
Message-Id: <20241015073004.4066457-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver now uses the legacy bridge helper code but can be configured
to get built without it:

ERROR: modpost: "devm_imx_drm_legacy_bridge" [drivers/gpu/drm/imx/ipuv3/parallel-display.ko] undefined!

Add the required dependency, same as in the ldb driver.

Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/imx/ipuv3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
index 0ea1feb84672..acaf25089001 100644
--- a/drivers/gpu/drm/imx/ipuv3/Kconfig
+++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
@@ -15,6 +15,7 @@ config DRM_IMX_PARALLEL_DISPLAY
 	depends on DRM_IMX
 	select DRM_BRIDGE
 	select DRM_BRIDGE_CONNECTOR
+	select DRM_IMX_LEGACY_BRIDGE
 	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
 
-- 
2.39.5


