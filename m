Return-Path: <linux-kernel+bounces-314946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE796BB48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1111C281644
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A31D47DB;
	Wed,  4 Sep 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kNgEgRDJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="R8muNlAj"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3E1D2234
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450714; cv=none; b=KuwxBklyatXwzgT2gi7uEAn0jNdSGROjh2yUqVZ7UQMVJ0XzjTtrdA0lhzkcu15mZE/+zZT5NI0aCevj+YUp7qlbVx05ocsSqekxao2J+RJvxXCu0ucWWadBAMZ/vEToxVbj279MQ5Djod0xu0FZBF2iVfO57481GmAxa1TvZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450714; c=relaxed/simple;
	bh=+pYIYMQ0DspgqfvQGmuBoGrq9uHeRjxrkdW45I0jm3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5OoUqfFgfZL/Jg7ePYsQGcssnJno4YgaHSnTq7TTsNt3vO4pcc6s/RjcUUdyr6qeDXTXpMCe5+r7ZEOkIoYmdsxm5Uhs9Vxv0QOLwyqCfxVRFIhGWHtv01PdqiVT9IWg4DnWrHiu5z3NIp2JyvatC7gfhqaBkNqsA+e1Qsh3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kNgEgRDJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=R8muNlAj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725450711; x=1756986711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ih/v3JlPgjnunjeMXetvHkaR0ZTTwffvOCV3Ri/27Bg=;
  b=kNgEgRDJpB2S+p9bP8y1p1SFMpWLEm/vqLpVLAHgGph2LHGovgfJOt1z
   PPHMk5saib3W/cSvLaRPch8jIBLZa4nHc1J2UveeGeQW0Mjxq99DVishJ
   FUbKC5e3mB0y/jw0LlbbRhY1ttv/n8VGepf1z2nkGlZOerTnWU5giaYFR
   JJaR8urau3LZs/tWx4Ws0orkioAhf/wux6FApx/sNpDyNXtMhJUbaTvlw
   RU9QH5rNjJruBVN8Qo+nbC7zaQAEBxf8XSjM19VQ/CAW2lWrcV9a7v4YB
   rRrK8zcw41RJlClDfd7lHWwR6jpc7pAyvFtQNvM4hyDAwjkqaLhsULRHv
   w==;
X-CSE-ConnectionGUID: vxHa9s2wRZG41VrFBw4TXQ==
X-CSE-MsgGUID: e6ujeLxoQTK0205HQGqfpQ==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38762020"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 13:51:50 +0200
X-CheckPoint: {66D849D6-F-C661815F-E221238E}
X-MAIL-CPID: 9876011BF6E44B1ED856FEFA708AE4DA_1
X-Control-Analysis: str=0001.0A782F21.66D849D6.00E0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD8A6160CE2;
	Wed,  4 Sep 2024 13:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725450706; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ih/v3JlPgjnunjeMXetvHkaR0ZTTwffvOCV3Ri/27Bg=;
	b=R8muNlAjk0m0tbrxDQOJLbgRwtkLvBXe29alHKw5jongGP59ZYi2r1pczqGmdTTL8nd3gn
	RY0VN3ymmkQKA7wG0DTj3zaxdbnKHwv+vD/ETS4qg6lxDu4BDlMZ4GZtRBf7uD26sUBU63
	uZze6YK68t8nuc6h9wMAlIs/ueL2Zuz8O9+xVW3JEsRU7QlV3SSeU76+c4LYl+CtAQfrMM
	cUb9dMqysmfJvCCK4hgrKX/UDoG49DYsKf8+YLO0gBNbWdu0x4ezu+ERK2pUF7orNpMfcN
	kYjBwTZ3sFv9ozI2lCwiklWFEFLv16u80cHYGyLWgXtt7Zv/cx1RwRN/iEqkpA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [RESEND 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Date: Wed,  4 Sep 2024 13:51:35 +0200
Message-Id: <20240904115135.1843274-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904115135.1843274-1-alexander.stein@ew.tq-group.com>
References: <20240904115135.1843274-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

The PIXCLK needs to be enabled in SCFG before accessing certain DCU
registers, or the access will hang.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 14 ++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index 5ca71ef87325..c9ee98693b48 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -8,6 +8,7 @@ config DRM_FSL_DCU
 	select DRM_PANEL
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
+	select MFD_SYSCON if SOC_LS1021A
 	help
 	  Choose this option if you have an Freescale DCU chipset.
 	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 90cbd18f096d..283858350961 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -100,12 +100,26 @@ static void fsl_dcu_irq_uninstall(struct drm_device *dev)
 static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct regmap *scfg;
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
 	if (ret < 0)
 		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
+	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (PTR_ERR(scfg) != -ENODEV) {
+		/*
+		 * For simplicity, enable the PIXCLK unconditionally. Disabling
+		 * the clock in PM or on unload could be implemented as a future
+		 * improvement.
+		 */
+		ret = regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
+					SCFG_PIXCLKCR_PXCEN);
+		if (ret < 0)
+			return dev_err_probe(dev->dev, ret, "failed to enable pixclk\n");
+	}
+
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index e2049a0e8a92..566396013c04 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -160,6 +160,9 @@
 #define FSL_DCU_ARGB4444		12
 #define FSL_DCU_YUV422			14
 
+#define SCFG_PIXCLKCR			0x28
+#define SCFG_PIXCLKCR_PXCEN		BIT(31)
+
 #define VF610_LAYER_REG_NUM		9
 #define LS1021A_LAYER_REG_NUM		10
 
-- 
2.34.1


