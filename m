Return-Path: <linux-kernel+bounces-240349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02EA926C79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB071F23D67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA817A58E;
	Wed,  3 Jul 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RFFHRHL/"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00141C68D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049547; cv=none; b=X2wj3/IQa7E9M5bCZ9OT82/NvIQMWykpFGPaalhDWNUUZxP1VsXeGOPdPXPt7PKvzm7nwkAYMHJVACGOiwpKJk8rA5XuYvwkItYdf/xtwfnB4HLMvlbrwrHHRygESRq/k0wGkuf2ISRF+dBkXvCPxRRyjRhJrT1FDdDtKV3ejXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049547; c=relaxed/simple;
	bh=AkB9Utqt7tT8kjYv0COS7muakfHf+uwc5nbLwiB7qWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rhssb5OOBd9srJggRPJAvyIakDmsI4kxVW4/9R177gemwnLAzBQUBUx5z2+t0xmHt/8Sx65U5YZzpjgME2qWZKSHMdhtuoYABFt9BL/Laz0CeMVqlKzsw5uAXpUxAUEX0au3a/3CPOg70bpYKBqkB2Q3zTTlUG1YUfGVsL8tU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RFFHRHL/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720049542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lZlEw+Fn9hl8WVVU5TGBdkPfXk1IUsyRsh6CxIbbcHo=;
	b=RFFHRHL/BIMNa+DJmfGc3RiA6ssbcnwsNILQ5RSm+yVVf+MIQc37InYfNhMEbA0Kwc/UJM
	Y4SzsE2LedBnsxnSsA1EIHLblLXP45j3Dfc+AebWa3PYWFu0YkbzdoP29WKobyieSTAmtL
	rllL+pjdULYQwPC+98TvkIgliMkqcr5zmCuXdtS90UCbdi7i1wNuiM+QzRHPOIxdY6sXeE
	My4UesB4b8ECB7zZ2xHw78T1UIWPiz+fBFGlEEJjZdpIKhypS7ZT+RnaeotvVwWy8PSSGM
	TqgmWqB12TqLdTLMq3OKOvQHSpBgSJhbOaeboYqWYBmrhl86dlCQBgk427Ds0A==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: cdn-dp: Clean up a few logged messages
Date: Thu,  4 Jul 2024 01:32:20 +0200
Message-Id: <92db74a313547c087cc71059428698c4ec37a9ae.1720048818.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Clean up a few logged messages, which were previously worded as rather
incomplete sentences separated by periods.  This was both a bit unreadable
and grammatically incorrect, so convert them into partial sentences separated
(or connected) by semicolons, together with some wording improvements.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index bd7aa891b839..ee9def197095 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -969,46 +969,44 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 	/* Not connected, notify userspace to disable the block */
 	if (!cdn_dp_connected_port(dp)) {
-		DRM_DEV_INFO(dp->dev, "Not connected. Disabling cdn\n");
+		DRM_DEV_INFO(dp->dev, "Not connected; disabling cdn\n");
 		dp->connected = false;
 
 	/* Connected but not enabled, enable the block */
 	} else if (!dp->active) {
-		DRM_DEV_INFO(dp->dev, "Connected, not enabled. Enabling cdn\n");
+		DRM_DEV_INFO(dp->dev, "Connected, not enabled; enabling cdn\n");
 		ret = cdn_dp_enable(dp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Enable dp failed %d\n", ret);
+			DRM_DEV_ERROR(dp->dev, "Enabling dp failed: %d\n", ret);
 			dp->connected = false;
 		}
 
 	/* Enabled and connected to a dongle without a sink, notify userspace */
 	} else if (!cdn_dp_check_sink_connection(dp)) {
-		DRM_DEV_INFO(dp->dev, "Connected without sink. Assert hpd\n");
+		DRM_DEV_INFO(dp->dev, "Connected without sink; assert hpd\n");
 		dp->connected = false;
 
 	/* Enabled and connected with a sink, re-train if requested */
 	} else if (!cdn_dp_check_link_status(dp)) {
 		unsigned int rate = dp->max_rate;
 		unsigned int lanes = dp->max_lanes;
 		struct drm_display_mode *mode = &dp->mode;
 
-		DRM_DEV_INFO(dp->dev, "Connected with sink. Re-train link\n");
+		DRM_DEV_INFO(dp->dev, "Connected with sink; re-train link\n");
 		ret = cdn_dp_train_link(dp);
 		if (ret) {
 			dp->connected = false;
-			DRM_DEV_ERROR(dp->dev, "Train link failed %d\n", ret);
+			DRM_DEV_ERROR(dp->dev, "Training link failed: %d\n", ret);
 			goto out;
 		}
 
 		/* If training result is changed, update the video config */
 		if (mode->clock &&
 		    (rate != dp->max_rate || lanes != dp->max_lanes)) {
 			ret = cdn_dp_config_video(dp);
 			if (ret) {
 				dp->connected = false;
-				DRM_DEV_ERROR(dp->dev,
-					      "Failed to config video %d\n",
-					      ret);
+				DRM_DEV_ERROR(dp->dev, "Failed to configure video: %d\n", ret);
 			}
 		}
 	}

