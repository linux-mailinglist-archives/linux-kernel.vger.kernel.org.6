Return-Path: <linux-kernel+bounces-281486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF294D76A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E31C2265B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945916B75C;
	Fri,  9 Aug 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LMn+NvlH"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2071607A3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232198; cv=none; b=peRIIXRbmkIhJJsZzsb3FAgOJI7HtsGVFZj1Nzf2VjiyZTZPgH/iEKtV22rjdtQ65Y26AfCvjjsjuyEE2abwdvF3Fq8OMpJ4xoNnAs5gw8PGYk9K9Whco6BFkwPOWy660jQM/5rSh7cLwArMr30oNR5BSwfNs2Ktm60NaVqTQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232198; c=relaxed/simple;
	bh=0fSJl10Wfz/WiOqEdLqluBRz9Ww3o4AEuDmsIsMpqmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rz7mhnXRozHbPwfotZvN9Ckjo/Z64Lk2rjP+xs1dK/nxO6BHaHbYkYw7xnYzDEFkqXdvIpBz/Yn8kznhFel59bXRHxC8bIuDWKM/jT/PCi/81YIgnBY2zam1z9r4g80gM9/WInthXLRamTU3yI/0ecYVj2Fu1BzLQaeAuwPRf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LMn+NvlH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723232194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7CIj8q4tM0sAgHaW8MP8eR835TxAvTZNNma/3Wy8v8=;
	b=LMn+NvlH7irQNqV/QM3q8852JuMKybyGWRDKWLvqzWifxmU40zKQ7prVaryy6As85hVv+n
	+8j8nU9hxE0psilplvAQK1C+D8kA8IvEl0csOA2VMQnjoh0VyLJrKTwLKG132xtosrLX6B
	UcPL2xLoPJ5dMg88DwUKkTg6QbE7znc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v6 7/8] drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
Date: Fri,  9 Aug 2024 15:35:59 -0400
Message-Id: <20240809193600.3360015-8-sean.anderson@linux.dev>
In-Reply-To: <20240809193600.3360015-1-sean.anderson@linux.dev>
References: <20240809193600.3360015-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a non-locking version of zynqmp_dp_bridge_detect and use it in
zynqmp_dp_hpd_work_func so we can take the lock explicitly. This will
make it easier to check for hpd_ignore when we add debugfs support.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v3)

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index e0ab3b3e8580..f5203ffa3c75 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1567,14 +1567,13 @@ static int zynqmp_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
-static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *bridge)
+static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 {
-	struct zynqmp_dp *dp = bridge_to_dp(bridge);
 	struct zynqmp_dp_link_config *link_config = &dp->link_config;
 	u32 state, i;
 	int ret;
 
-	mutex_lock(&dp->lock);
+	lockdep_assert_held(&dp->lock);
 
 	/*
 	 * This is from heuristic. It takes some delay (ex, 100 ~ 500 msec) to
@@ -1603,16 +1602,26 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
 					       dp->num_lanes);
 
 		dp->status = connector_status_connected;
-		mutex_unlock(&dp->lock);
 		return connector_status_connected;
 	}
 
 disconnected:
 	dp->status = connector_status_disconnected;
-	mutex_unlock(&dp->lock);
 	return connector_status_disconnected;
 }
 
+static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *bridge)
+{
+	struct zynqmp_dp *dp = bridge_to_dp(bridge);
+	enum drm_connector_status ret;
+
+	mutex_lock(&dp->lock);
+	ret = __zynqmp_dp_bridge_detect(dp);
+	mutex_unlock(&dp->lock);
+
+	return ret;
+}
+
 static const struct drm_edid *zynqmp_dp_bridge_edid_read(struct drm_bridge *bridge,
 							 struct drm_connector *connector)
 {
@@ -1696,7 +1705,10 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
 	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp, hpd_work);
 	enum drm_connector_status status;
 
-	status = zynqmp_dp_bridge_detect(&dp->bridge);
+	mutex_lock(&dp->lock);
+	status = __zynqmp_dp_bridge_detect(dp);
+	mutex_unlock(&dp->lock);
+
 	drm_bridge_hpd_notify(&dp->bridge, status);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


