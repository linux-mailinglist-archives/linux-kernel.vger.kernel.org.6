Return-Path: <linux-kernel+bounces-176578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED148C31DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A383A1F2195A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B01E526;
	Sat, 11 May 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bceFpgC6"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60079DC
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437838; cv=none; b=Y0Cftuu/xUzav5n1dWr4ZUbVjdt+ir5CI8B2g1EOeGW9NlfzEHwDyyfsDHFG4kUxIiL25m9L2igIiqvAtLUfANWUQq16KAgSupijZt12AMzl9dn5fMoyfFSNlS+pAfnl9f/MHBi6l8UMqtcMZAouXcf5ulaNnxDTC8w9R0naQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437838; c=relaxed/simple;
	bh=6JX9U5QXTQM+ymSkQwIVScF/Sz2ugLRJCrrSvRtA14Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnFyyJ/+yzS4CHbhKsuGuFASK45ek4NyvDmion8FTqHVfd9pnrRANSErGZSAsQMCRSKcR2v7gicjpJll9xfjYp94jdSONOV6mmnAsZFSJ/UEUdElbVFBrHUlyYz0/PgLIhJj8gXESQaZg6sFtdr4vcCIhCb6u644tU4My8hCsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bceFpgC6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715437834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8lCE5BMQPZQrEu+DdqUQa+ciyt6sV2leU46hmIRgywE=;
	b=bceFpgC62YkDbNS/v2cATnJkVcA3lhWGkOE64zqb3ABgk66VZE1un2/0/5lGMwOrHOZMML
	xlgBFzdKYFpXs5ZNvidF/AEFeVKT+EBD0xAsIAGY74R2Ubxdjtnx5CsjRfKjjAumwqaEhX
	xgU3ugvwy7yZX+bCEpvXipXhwqkqTjg=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/bridge: cdns-mhdp8546: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:30:27 +0800
Message-ID: <20240511143027.320180-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the cdns_mhdp_connector_init() function, the check on the existence
of bridge->encoder is not necessary, as it has already been done in the
drm_bridge_attach() function. And the check on the drm bridge core
happens before check in the implementation. Hence, it is guaranteed that
the .encoder member of the struct drm_bridge is not NULL when
adv7511_bridge_attach() function gets called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index e226acc5c15e..16b58a7dcc54 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1697,11 +1697,6 @@ static int cdns_mhdp_connector_init(struct cdns_mhdp_device *mhdp)
 	struct drm_bridge *bridge = &mhdp->bridge;
 	int ret;
 
-	if (!bridge->encoder) {
-		dev_err(mhdp->dev, "Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	conn->polled = DRM_CONNECTOR_POLL_HPD;
 
 	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
-- 
2.43.0


