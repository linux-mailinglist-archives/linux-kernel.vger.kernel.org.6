Return-Path: <linux-kernel+bounces-189859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E135C8CF5EF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20301C20BBD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3613A267;
	Sun, 26 May 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wwonWoUo"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D55139D18
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754918; cv=none; b=TY314x76H5GgmTmdMJ7BEA4MFRHGphx/SxamlIxzN0JBQFzUrWT2YwcoE+c7IZmElNLQEeKRciMJ9Gk3537kLEqWNxLeKmRSweiyW0tHRzRx+ttlH4zLSAkcH/pCXWl2m2q3mNVKUhSvolLpccgzXawgo91UJwl5zX+4An50z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754918; c=relaxed/simple;
	bh=NHHEF6qgIYDL3JKqO/a1RnX6zjJQma+c6w+2Dkv4ieY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6WtSEB2dbzyySBLxYTsq8cQj1Hn/j8xdKvVhDpYg3sdVXEVR6QyVUX7KTNRN68BfNPVnn3JIqunOAT+vTvNZ9Ii6TBm3TxhjS+0/koMOYNBFBrwdeYxTOo5oeKdjHaUbOdZCJns1VZ4iF9Mgt43YxpNzlZpkjtii/ALIrchxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wwonWoUo; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqDOtfrHGXH6es9TBGAqjQmwlMGkG8wJlACKwDT/W9M=;
	b=wwonWoUoP+Sq04gbzVB1u5ftH4862mJeiJyrb4x4u3bDqgQoSwQlQc1dVYky1WKGVUWukq
	1Wg6Vdk2Bf6hNiLgtntfPJpmDgX0ILfDjW6AXx3UH7C3F9EH415x1ZMI6PURy/w7HZr/Np
	rwlP/BYKBepSgEKDtJ7lBVGO4HXM7O8=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v6 04/10] drm/bridge: simple-bridge: Use fwnode APIs to acquire device properties
Date: Mon, 27 May 2024 04:21:09 +0800
Message-Id: <20240526202115.129049-5-sui.jingfeng@linux.dev>
In-Reply-To: <20240526202115.129049-1-sui.jingfeng@linux.dev>
References: <20240526202115.129049-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make this driver less DT-dependent by calling the newly created helpers,
also switch to use fwnode APIs to acquire additional device properties.
A side benifit is that boilerplates get reduced, no functional changes
for DT-based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index fd7de9b6f80e..e7348ee6daf7 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -8,8 +8,6 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
@@ -164,33 +162,32 @@ static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
 
 static int simple_bridge_probe(struct platform_device *pdev)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	struct simple_bridge *sbridge;
-	struct device_node *remote;
+	int ret;
 
 	sbridge = devm_kzalloc(&pdev->dev, sizeof(*sbridge), GFP_KERNEL);
 	if (!sbridge)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, sbridge);
 
-	sbridge->info = of_device_get_match_data(&pdev->dev);
+	sbridge->info = device_get_match_data(&pdev->dev);
 
 	/* Get the next bridge in the pipeline. */
-	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
-	if (!remote)
-		return -EINVAL;
-
-	sbridge->next_bridge = of_drm_find_bridge(remote);
-	of_node_put(remote);
-
+	sbridge->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
 	if (!sbridge->next_bridge) {
 		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
+	} else if (IS_ERR(sbridge->next_bridge)) {
+		ret = PTR_ERR(sbridge->next_bridge);
+		dev_err(&pdev->dev, "Error on finding the next bridge: %d\n", ret);
+		return ret;
 	}
 
 	/* Get the regulator and GPIO resources. */
 	sbridge->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
 	if (IS_ERR(sbridge->vdd)) {
-		int ret = PTR_ERR(sbridge->vdd);
+		ret = PTR_ERR(sbridge->vdd);
 		if (ret == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		sbridge->vdd = NULL;
-- 
2.34.1


