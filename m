Return-Path: <linux-kernel+bounces-534350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BAA46633
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6A619C3E65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11821D5BD;
	Wed, 26 Feb 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDsqIJ2n"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFE21E087
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585191; cv=none; b=tBCuYF02f3bxAfTeq8Ae+gj5Dzz3dw43hD/Zs0DC0RgeewcAu1ALZfO0427wtE54aUTJTC0wkoo3KU/wNOQnyUZITqpQSeU/k4I2dZO1Qg0dUdR1KpsfQWnkzFUpKo0VYvTnDybIH4Y2+2hCO/gD5S7vsrLVR2BI4Gth0yR6Mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585191; c=relaxed/simple;
	bh=Ix8Bxs/mq9c3NDyufsC2zFva7j4lBNb99kkDr40vNZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8e0oIspUC1N0quzvZvhJDJji4Wu7+olarG4pgzWkjmFKnZRtjss92W1kDgbz5FH3ib9TpPTLNuNg08k4P21vcnSafPUQ53iqQv0tYiMCb/YC6U1wZ4tOxlrijGSmQx8sM+4at3nCBZArxjpEZ0JL/BGeOFaXPPjCF+sYGYMdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDsqIJ2n; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740585187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLZwvUzMPwM7gs5/TU1muo/u+9TONRrQvYNi/eC2T2k=;
	b=UDsqIJ2n3SC/bgzXxizoF3+PYOXRXdnSMT3VKcVx6xz4PE+UAgvCr9eh94swHx/qjlFL/k
	CeVK3v2kmNPrm8aJ7npfGvRsDfVhZs2MYjGAL8/NbhW4D0iT2TBlmIx+nhqjIcdo0Z7Yzp
	9Q+Ae/MANUHExJl40jsEfyZzZWkkxbo=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v10 03/13] drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
Date: Wed, 26 Feb 2025 21:22:18 +0530
Message-Id: <20250226155228.564289-4-aradhya.bhatia@linux.dev>
In-Reply-To: <20250226155228.564289-1-aradhya.bhatia@linux.dev>
References: <20250226155228.564289-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

The crtc_* mode parameters do not get generated (duplicated in this
case) from the regular parameters before the mode validation phase
begins.

The rest of the code conditionally uses the crtc_* parameters only
during the bridge enable phase, but sticks to the regular parameters
for mode validation. In this singular instance, however, the driver
tries to use the crtc_clock parameter even during the mode validation,
causing the validation to fail.

Allow the D-Phy config checks to use mode->clock instead of
mode->crtc_clock during mode_valid checks, like everywhere else in the
driver.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Cc: stable@vger.kernel.org
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b0a1a6774ea6..19cc8734a4c8 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -568,13 +568,14 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long dsi_hss_hsa_hse_hbp;
 	unsigned int nlanes = output->dev->lanes;
+	int mode_clock = (mode_valid_check ? mode->clock : mode->crtc_clock);
 	int ret;
 
 	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
+	phy_mipi_dphy_get_default_config(mode_clock * 1000,
 					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
 					 nlanes, phy_cfg);
 
-- 
2.34.1


