Return-Path: <linux-kernel+bounces-540450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BCA4B0B1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA90170553
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F271D5AD4;
	Sun,  2 Mar 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UmkPCIU3"
Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9515530C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740904278; cv=none; b=Rnev2bfjqzUEczKz1buAE2ZPxgrARhtwI2sVUlgweIcpydzxujxfdJMfs3Fzsch9ns6o+U/iNQyu7A74MuZJFRsKXfO/3Ok/+k/4X2snKvbEFufE/VT7SINBVzuUXs9MQK4OgT+n90+eNWpWZWp5/ypFbT+912JmcHJA8Ohgp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740904278; c=relaxed/simple;
	bh=y1zWYMbvmH6Q9HIkd78pj6ScAKngrDjKJZbio6waGfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psQzVotIsAQwFp5At+xUSHGRVPSDJi6Fi16qmlbzQo3Fxvg+DK7A2ksDjmsRlnk5poRznU7hFbPgkMRPZ3j1vGgBfMYi2Vg+pUh/g9QcK1heT1tCfkkgIAa9d8qEGKUThUlfqWRJtAyIZdq999jtHBJl1sTucFlcTkMXubsG5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UmkPCIU3; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id ca1e3b0a;
	Sun, 2 Mar 2025 16:31:02 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: dianders@chromium.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: dmitry.baryshkov@linaro.org,
	andy.yan@rock-chips.com,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v8] drm/bridge: analogix_dp: Remove the unnecessary calls to clk_disable_unprepare() during probing
Date: Sun,  2 Mar 2025 16:30:43 +0800
Message-Id: <20250302083043.3197235-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNKSFYfTUxCGkodHR5KQ0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9555faec2603a3kunmca1e3b0a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46Fyo*GjIIP0sXFEsQPAMD
	GjwaCR9VSlVKTE9LQktPSU1PSUpJVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEtPNwY+
DKIM-Signature:a=rsa-sha256;
	b=UmkPCIU3194/fdIScDFyGJqmuyaoD1Wy6JprV81qNtT2lopbChW3FNhogW3p0vJNrzW+8Ixe7Qb728+YAJQ2uZkHqxnrdtl7BVAL5xgDyNxGOIGlqYvOqEurRXBD5ZZpkVyI+e1OXBXhx7E9van9kwmWemfzUXUMQjNiKs17ISQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1tSwbwgHgUYZS7h3tpCBw0paLu32oYZDiVorjRMVmIs=;
	h=date:mime-version:subject:message-id:from;

With the commit f37952339cc2 ("drm/bridge: analogix_dp: handle clock via
runtime PM"), the PM operations can help enable/disable the clock. The
err_disable_clk label and clk_disable_unprepare() operations are no
longer necessary because the analogix_dp_resume() will not be called
during probing.

Fixes: f37952339cc2 ("drm/bridge: analogix_dp: handle clock via runtime PM")
Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Picked from:
https://patchwork.kernel.org/project/linux-rockchip/list/?series=936932

Changes in v8:
- Fix the conflict because of commit 43c00fb1a518 ("drm/bridge:
  analogix_dp: Use devm_platform_ioremap_resource()")
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index f6e4bdc05ba0..817070613b03 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1605,10 +1605,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	}
 
 	dp->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(dp->reg_base)) {
-		ret = PTR_ERR(dp->reg_base);
-		goto err_disable_clk;
-	}
+	if (IS_ERR(dp->reg_base))
+		return ERR_CAST(dp->reg_base);
 
 	dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
 
@@ -1620,8 +1618,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	if (IS_ERR(dp->hpd_gpiod)) {
 		dev_err(dev, "error getting HDP GPIO: %ld\n",
 			PTR_ERR(dp->hpd_gpiod));
-		ret = PTR_ERR(dp->hpd_gpiod);
-		goto err_disable_clk;
+		return ERR_CAST(dp->hpd_gpiod);
 	}
 
 	if (dp->hpd_gpiod) {
@@ -1641,8 +1638,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 
 	if (dp->irq == -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-		ret = -ENODEV;
-		goto err_disable_clk;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
@@ -1651,15 +1647,11 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 					irq_flags, "analogix-dp", dp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto err_disable_clk;
+		return ERR_PTR(ret);
 	}
 	disable_irq(dp->irq);
 
 	return dp;
-
-err_disable_clk:
-	clk_disable_unprepare(dp->clock);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_probe);
 
-- 
2.34.1


