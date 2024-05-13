Return-Path: <linux-kernel+bounces-177754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F48C4444
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE97282A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722E15442B;
	Mon, 13 May 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1ILIjTF"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F81154423
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614309; cv=none; b=LQaEjdi8B0Itj3KYV5SwuiUMxGjMSnAtj0tTy8gSnST6t8i+FraeZOaY4cyPpIrgAwez6k56sXiUxmrEPRJRK42l9ZHIGNDenRyph9dxlNUw/MScmzYfvXtbbwTb18KTLa6WHq19TUN/SlWtl11DN++kpfmYU3kCxLZG+pEYEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614309; c=relaxed/simple;
	bh=OHFPhmCPsIkBczUTDxHdD/cg+ysEJEKlkbzJo8QYj5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5iXfeXMI3H7zk8qiMVDsxoPOofm+16o0V/7RmQJOf7GqI8xp3ARRAhQ0SSgLZ5zLnOAwdySj9bXM6JLHTlOFpaIFzrConjT9R0BQmIk51bT4I7ryUTkZFa6qlQdENxSXTPuHn6R9Bp/QjA/K7UXy5O3q9JggwRcxm+TBDJZqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1ILIjTF; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkbxX2OwAWgCxYscfgCjR1gkqrQYqnnGwxp+P1UMWgE=;
	b=M1ILIjTFecyKk9H38rYtTMjnYDkzCIWH6VjaWO4LgdWGc3drbux8+6gU+rdJ2rFR7Uzrjc
	pUmJ3PhNBkW+SKNY89iZQQkXrt8kNKzY/vJuIi0AtI2PWN0FsIH3Apj2PdnH4RefOmWadK
	PrEwXoOIgVOeduT4edcpSk3aWOGA0BQ=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liu Ying <victor.liu@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 08/12] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:05 +0800
Message-ID: <20240513153109.46786-9-sui.jingfeng@linux.dev>
In-Reply-To: <20240513153109.46786-1-sui.jingfeng@linux.dev>
References: <20240513153109.46786-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the ge_b850v3_lvds_create_connector function, the check on the existence
of bridge->encoder is not necessary, as it has already been checked in the
drm_bridge_attach() function called by upstream bridge or driver. Hence, it
is guaranteed that the .encoder member of the drm_bridge instance is not
NULL when cdns_mhdp_connector_init() function get called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 4480523244e4..37f1acf5c0f8 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -165,11 +165,6 @@ static int ge_b850v3_lvds_create_connector(struct drm_bridge *bridge)
 	struct drm_connector *connector = &ge_b850v3_lvds_ptr->connector;
 	int ret;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	drm_connector_helper_add(connector,
-- 
2.43.0


