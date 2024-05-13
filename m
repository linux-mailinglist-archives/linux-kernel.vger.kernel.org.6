Return-Path: <linux-kernel+bounces-177753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2718C4443
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29631C23856
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A177155325;
	Mon, 13 May 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+TFeV5u"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA7155316
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614306; cv=none; b=rdyc4cRTH5Z5bfNJUQwIRByFfyE4S+OEZSTaEeZ1O4yRoRaSP9Qut5ayk1UZsmc+JFOn4amzPgH554cgVIuuYICyFWMR+We7jZA3briZnGZSRUeYMuoEZHMEn+cpXT6FdSktoMxFkPG5Rum0qBSvMKfwYSri4ri93QQNlhzeV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614306; c=relaxed/simple;
	bh=PgpXnnsEU3a+phmsrJGk4HFEBOrA+xosJkYR3/+m+kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCp8smSzkjLa2tFoX65cYDcsQiEVo3+VvSmkOI5y7GSg4JVodsSbSsa+5wOAOsJDmBGE5D1E43h9AX6GRjedXaOY4p9MkES1kCJlxjhsqMtCXMMKl0JamjiFICWv36Ry6B8JU7PaRVzFiGB1hAmZDsNLSGBV5GVDq7i3w/5imyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+TFeV5u; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmmG+selwisq3Cij6Bl0HRC/hX07+VfIYU4xEOfZWQk=;
	b=B+TFeV5uri4dtgTs4C+zx/xC/D9sFg7q4eP6p16rzZMpdkuMD7H8X1y8GB+xwdtetfkrml
	2Xt0NKME0G0EPA38KadDthNWKq0ZtEPyxk5stQgR2Gls97xDiw4mJLj67BKxn1fRSNpKni
	f2tQuC/E0wAkGeChoLmKacQdST0RU+I=
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
Subject: [PATCH v2 07/12] drm/bridge: cdns-mhdp8546: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:04 +0800
Message-ID: <20240513153109.46786-8-sui.jingfeng@linux.dev>
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

In the cdns_mhdp_connector_init() function, the check on the existence
of bridge->encoder is not necessary, as it has already been checked in
the drm_bridge_attach() function. As the cdns_mhdp_connector_init() is
only called by cdns_mhdp_attach(), it is guaranteed that the .encoder
member of the struct drm_bridge is not NULL when cdns_mhdp_attach() gets
called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 8a91ef0ae065..dee640ab1d3a 100644
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


