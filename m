Return-Path: <linux-kernel+bounces-176566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6D8C31BE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530062820A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE3535B8;
	Sat, 11 May 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DFtm7vDf"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB57F6
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715436211; cv=none; b=miNLtkxppDN8zrHv54FgczznMkRf98Rw0TrssgRHOWyrDiubR7P5clvitNVkI6Fe8uzgssg80fNEnC1SYiRDjQGwHuY7ThNEpMcUBpXTyyOwOUAmnAkIMBQcgyGAWwJc/XIpZI92Z7ZUo8y2Uup6L771M91rspzDNaNIwfxHQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715436211; c=relaxed/simple;
	bh=mhTRt8JHohS8YFer2Eja+AGnHgG9LVArYakcCH9pRfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ej63Ios8Y0RECdmRaAKFL927JBjtPzcCkbXglamBQynzMZbt2Luh0NHyw2w9hlfiU2dufxuu4CTWvhQHq/ZD2yJOXHlFCWQirKJerASa3gH7Aap/IMvQwaNF/xh2ruLg4d2ttjJXbNuDRpPf11LIP5ft5JJVMvO/b3u2xYH1MSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DFtm7vDf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715436207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWeNl4C384y+wMABXUhvSGBiKKDCfnTUzIRZ136IUcI=;
	b=DFtm7vDf8lNIht/QmjfZvuC4N/u5fJgQDjAqudEH6C3mQxWai1Nn/iPTUFf1qNO6LXLHe+
	VwMw0C8MytTgYLFVt4qR+d1P+5MDyY9PEPzWR88f54AsOxIDLnm3Uust1uoGQHTry1fDUp
	leK8W8MK1yENnGDO9v0LAzDtxjnd9YQ=
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
Subject: [PATCH] drm/bridge: panel: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:03:16 +0800
Message-ID: <20240511140316.318080-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In panel_bridge_attach(), the check on the existence of bridge->encoder
has already been done in the implementation of drm_bridge_attach(). And
it is done before the bridge->funcs->attach hook is called. Hence, it is
guaranteed that the .encoder member of the struct drm_bridge is not NULL
when the panel_bridge_attach() is called.

There is no need to check the existence of bridge->encoder another time
at the implementation layer, therefore remove the redundant checking codes
"if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/panel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 7f41525f7a6e..762402dca6dd 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -65,11 +65,6 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Missing encoder\n");
-		return -ENODEV;
-	}
-
 	drm_connector_helper_add(connector,
 				 &panel_bridge_connector_helper_funcs);
 
-- 
2.43.0


