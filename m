Return-Path: <linux-kernel+bounces-254742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCC933711
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E431C22CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A71400A;
	Wed, 17 Jul 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qikMfKZq"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B91134A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197779; cv=none; b=FqaSpnCuXtAUyrBm/EQRru21TnP2igBsGTaHq3g1PFPqHV7c1S/AnQgh35kJWRYCEjbAzVygG8BwUmrYseJVTECireKg5jNQ/JkiJlRSXLz9fEAyQAUUU9kEh+JHYDJQDUTJFXRZKmOx2Ee+9P7G80ehJOKVz2ONQbQr4cG2DGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197779; c=relaxed/simple;
	bh=61m2tr3oYFO/p63EFy2phc8FWypmlsQbhb7IXD8m3Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTsS+isdR7a1Ihh72K2NvNAG/rNfwI2/3jIRt43zuU5I7oS6F5cbPV+EH80ZdvJMmcf96x2UlUlYnwQ/zUEO6iWZZJKgaEmhZMyxVtIjPzpNm2/+uaQLxbbubcT1UMCfeHvd78NmDPhZylIdWh3SCXicUuF7wIUkedOPD5A/TAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qikMfKZq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721197774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XcMogaAUaZ3MeH9Rz27kLYrZiPWISfiW31C8HrmU3oc=;
	b=qikMfKZqXWx8jVfMM0XqFrblNKG6yB0RbQORKkwSHifzQBHyLNdKNN/ysn41q9OYaCNFfx
	DlDMCcM097yOduIVvMqMe8PSinsYCdC8UDsxXXhk+t/UYDKz1r6SW+Xv38ooC0y6nGDx9R
	eLWX/Tg/lFE5rkmZVwqffK2PM32RSCSygFFy1X0F5vx5C6cmEegd77rWHXw5T46PPqoQ7x
	mGgztZcM/p10Xhv5dBX45N2DCjqqklwdGWE39NgYIXkKARS/G5jTXOB6SUunPY7q2lnmtx
	fhvjIRNMk6YdbpKDtJ8wH0vJH2iAYphRXLpxY4d1TFcBCZ2NCA07hIfTeYJqEw==
To: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: [PATCH] drm/rockchip: dsi: Reset ISP1 DPHY before powering it on
Date: Wed, 17 Jul 2024 08:29:14 +0200
Message-Id: <6e0ce232acfe952970e9b37402fe08a3678aa43a.1721196758.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

From: Ondrej Jirman <megi@xff.cz>

After a suspend and resume cycle, ISP1 stops receiving data, as observed
on the Pine64 PinePhone Pro, which is based on the Rockchip RK3399 SoC.
Re-initializing DPHY during the PHY power-on, if the SoC variant supports
initialization, fixes this issue.

[ dsimic: Added more details to the commit summary and description ]

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 4cc8ed8f4fbd..9ad48c6dfac3 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1240,6 +1240,14 @@ static int dw_mipi_dsi_dphy_power_on(struct phy *phy)
 		goto err_phy_cfg_clk;
 	}
 
+	if (dsi->cdata->dphy_rx_init) {
+		ret = dsi->cdata->dphy_rx_init(phy);
+		if (ret < 0) {
+			DRM_DEV_ERROR(dsi->dev, "hardware-specific phy init failed: %d\n", ret);
+			goto err_pwr_on;
+		}
+	}
+
 	/* do soc-variant specific init */
 	if (dsi->cdata->dphy_rx_power_on) {
 		ret = dsi->cdata->dphy_rx_power_on(phy);

