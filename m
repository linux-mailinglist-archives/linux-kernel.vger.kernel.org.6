Return-Path: <linux-kernel+bounces-171942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98D8BEB01
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E20285E00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D6B16D325;
	Tue,  7 May 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fF1pfyVR"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4F10E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104850; cv=none; b=OaDpS4wQKdlodklS8NSp1Bzc4oY/CnnK8thc+jJ5GpRM1r/8pWQzEMuCmi34O1EQperl7D5aCLagrGOB3a8GbRU2fjaU7wPY4sk5NiVjJHe60qQUyhcUoXYysIq9NL8VUqnFy5RruTs1OLiCxcjx+1CAGHwWEovI1dKnqdvIXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104850; c=relaxed/simple;
	bh=xN1VWl6d7UWw/9znVR7KQPIH2t/Yorb7YaTWcrZ9B2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKhcPCd+4WfrxAhxgH5O8Vp9ARvWDqRsMoEG2esd8HNBD1VPvOCcQkgmThl2h5wsWopGFMK8AZguqvgRWqf7kfZ41oVz3ta7op7cKiSKy+FOEs43XTEF5t7GaYoRDsId4q/uTIl/qe+xqPTqMqx2IT1Sk7PuT3EBLYjb7B9Uxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fF1pfyVR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715104845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3dZRrtiT6u2AQq8yaWtkXaA1FaAqAm5F7GJug5lWD1c=;
	b=fF1pfyVRJsGtYEYWjlhft20hOLvQU81HyMeiblHpjRdS/UCf5xhyKb218MQmfB+XnCgCS7
	jNvfMjSlFRYOz7Aqg5x/U5+JObktZdfdxFEFsVvQtRc4WGw4hrhwVObI7qaWdsyJQwol8e
	Kqz+jsP+03xpnZjnVSr8f5EX5RiauRs=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/drm-bridge.c: Drop conditionals around of_node pointers
Date: Wed,  8 May 2024 02:00:00 +0800
Message-Id: <20240507180001.1358816-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Having conditional around the of_node pointer of the drm_bridge structure
is not necessary, since drm_bridge structure always has the of_node as its
member.

Let's drop the conditional to get a better looks, please also note that
this is following the already accepted commitments. see commit d8dfccde2709
("drm/bridge: Drop conditionals around of_node pointers") for reference.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 30d66bee0ec6..a6dbe1751e88 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -352,13 +352,8 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->encoder = NULL;
 	list_del(&bridge->chain_node);
 
-#ifdef CONFIG_OF
 	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
 		  bridge->of_node, encoder->name, ret);
-#else
-	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
-		  encoder->name, ret);
-#endif
 
 	return ret;
 }
-- 
2.34.1


