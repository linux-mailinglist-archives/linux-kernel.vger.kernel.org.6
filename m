Return-Path: <linux-kernel+bounces-318738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3896F256
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C64284280
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620871CB15A;
	Fri,  6 Sep 2024 11:01:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AD1CBE83
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620510; cv=none; b=UVrHrzrI0DeT65sRFs8jKhatrZqnNwEu4tem+ZUZh7dH1LIt2OAyTaHYp60oSds37PcdOF1+siGQrSbugr0EahvwHdUytWDukrfVa2k+FFSJDAjv/46SkF34j04LBj0ivIWzlg8g72T+9xZoBNnZEmOHdtvHou3JCgGsbJvi9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620510; c=relaxed/simple;
	bh=k5+XVlhfp7J1OR8MASmqERqRjjzauNiOy6HXf1rlDzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A6EYT3DbykNpWjGQbEtrN6q+qMgRXwEfdYwmDMriyygVmSGxNY+0p7xsr15cRguiJ38r7sWV1fPLFBfExhbLmGBuHKGwmT9Mvo3DEbaQZB562kq466wUqasl6LbnoFpZfQwZKSimp0R742m54jr8MDmsoT+zQOAmzJPX81pRgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smWib-0007vq-40; Fri, 06 Sep 2024 13:01:33 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 06 Sep 2024 13:01:31 +0200
Subject: [PATCH] drm/imx: parallel-display: select DRM_IMX_LEGACY_BRIDGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-imx-parallel-display-select-legacy-bridge-v1-1-ebb17457e936@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAArh2mYC/x2NQQrCQAxFr1KyNjBWLepVxEWaSWsg1iEj0lJ69
 wY3D97i/b9CFVepcG9WcPlp1c8Ucjw0wC+aRkHN4dCm9pxuqUN9z1jIyUwMs9ZitGAVE/6iyUi
 8YO+aI7wMLN2Jr8EMsVdcBp3/X4/ntu0sELyIewAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the missing select DRM_IMX_LEGACY_BRIDGE to fix kernels builds that
have the i.MX parallel-display driver enabled, but the LVDS display
bridge driver disabled.

Fixes build errors like:

  ld: vmlinux.o: in function `imx_pd_probe':
  parallel-display.c:(.text+0x3129db): undefined reference to `devm_imx_drm_legacy_bridge'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409060118.z8BxMg7Z-lkp@intel.com/
Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/imx/ipuv3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
index 5a40c878ebb0..4897fbd77f3f 100644
--- a/drivers/gpu/drm/imx/ipuv3/Kconfig
+++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
@@ -14,6 +14,7 @@ config DRM_IMX_PARALLEL_DISPLAY
 	depends on DRM_IMX
 	select DRM_BRIDGE
 	select DRM_PANEL_BRIDGE
+	select DRM_IMX_LEGACY_BRIDGE
 	select VIDEOMODE_HELPERS
 
 config DRM_IMX_TVE

---
base-commit: 8a8a31205e62b57f1fb844d790d682286121f729
change-id: 20240906-imx-parallel-display-select-legacy-bridge-5fce63c8ce6d

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


