Return-Path: <linux-kernel+bounces-524915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5DA3E8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73E27A56C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898F26771C;
	Thu, 20 Feb 2025 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DHfx1VNR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85611EE006
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094928; cv=none; b=N4p6YiNgJVBv/vFpk2ZU/Yn0zi5FCLcuz/DPHLh31GoIfJDpFNFSQMlJXSXQSqVd4z81sGgEOdcs3WVzfjdDG5Llsqteb10Tx3+Ug0P+Xpe9v7zRue4hOk0Lr0X1VMFVmzx/xWvV0k2Skc1XKE5p2rmTeD34T3C+PeIJNjmRx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094928; c=relaxed/simple;
	bh=Mngn8QbF7U3veJNGgXDU9h29JVMU3OJaq5L4lgj4WfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVy2H5WHZIeub/ERl8TFkQgnAn8tdByql1CrLOEFw3s3av2GnJOJlNn7rV7SXL+wCDWJnh7N7Hp56Et9HjUMyF9cSWvj52vgHmhlpp6kRKqPa9JViYOq415JGV/KPiikOSxCdAWo351/AIpqYz30UuTQmVTYy9br6covPiCdjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DHfx1VNR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eK4Q+gaIL/QDz6EnUoiKhEYDORlBBBWA6cwM5FTMJWU=; b=DHfx1VNRaazraKTN/FWLVGZCpy
	z1l/UskSBoxSdyWKGdBQIVOxFWCazo8EgM97zvh7yvzc9gXxO1gnzbWer374BOM4qps/DO9rh/eAo
	tjVLhlHI7+mTC0xa11E6zThVmfY2rFinw600vsJjzVQvd8YgGb1UWT8Ka69GegAuWLkVJ+zSwC8Ug
	GCFu0SoGzA2cI8yZFJA6rzI1m+NLAWzsJxg+mI1S/jV6jUcTMhjhk5d0+We6BO574D7HqRLjzyvJ0
	9tI5+05x6oJdn5AI4r538D6/N0gdMCU8dltkviQm0Ogs5H8BFYz3580Fee2CFTJ2V51Pkjk/dQWTe
	7phMiwFw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlGAz-0004Wc-0R; Fri, 21 Feb 2025 00:41:53 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: gregkh@linuxfoundation.org,
	heiko@sntech.de
Cc: rafael@kernel.org,
	dakr@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de
Subject: [PATCH 2/2] drm/rockchip: Fix shutdown when no drm-device is set up
Date: Fri, 21 Feb 2025 00:41:41 +0100
Message-ID: <20250220234141.2788785-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220234141.2788785-1-heiko@sntech.de>
References: <20250220234141.2788785-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the drm-driver probes, it mainly creates the component device, where
all the sub-drivers (vops, hdmi, etc) hook into.

This will cause the shutdown handler to get called on shutdown, even
though the drm-device might not have been set up, or the component bind
might have failed.

So use the new component helper to check whether the drm-device is up
and only then call the drm-atomic helper to release all the drm magic.

This prevents failures when the drm-device is never set, or has been
freed up already for example by a probe-defer during the component bind.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 439edc165ff6..285b721ff28a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -484,9 +484,11 @@ static void rockchip_drm_platform_remove(struct platform_device *pdev)
 
 static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
 {
-	struct drm_device *drm = platform_get_drvdata(pdev);
+	if (component_master_is_bound(&pdev->dev, &rockchip_drm_ops)) {
+		struct drm_device *drm = platform_get_drvdata(pdev);
 
-	drm_atomic_helper_shutdown(drm);
+		drm_atomic_helper_shutdown(drm);
+	}
 }
 
 static const struct of_device_id rockchip_drm_dt_ids[] = {
-- 
2.47.2


