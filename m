Return-Path: <linux-kernel+bounces-189863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449818CF5F3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FA6281246
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639D13AA4C;
	Sun, 26 May 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AQIUxBsY"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06E13AA32
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754932; cv=none; b=WnlRdH8m+aLgpiZLhuh7bCbKU+USI0T6pP75VYmMFEFz+24sre+UVEAQX3ShGlC7jHTAkfcEE4cyuQpZJ7Y3F/CfXjxuIcJiv17valMekqjBs+6dR6iYjk4+YLttRuAHzvrNMkTiYup7JLtFqCdINWBCkRp1YmMYkjkNDJHGmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754932; c=relaxed/simple;
	bh=Kz/eqHbUCd4L4KVRWDsSIgK1BXZgJsrO1jg4j6T1dqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuplHKolNDWhqzXpLqr+f+/4ERBEsY0uSSEGNgfSP7NayRvdt77wojN+6YSPn4aAXMjTjAk6sfGzdmc8w793QqTmKvBI2a1Rq6FOa8EohOYn/DRnlstqpeAK8VU4y6HfY0v8BUoGiULRSVEKVPyALhPv/iIGn5PuOj8f48jXcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AQIUxBsY; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPPCFVCrE6Vzm1J73QBI5DbfGkJjhE7+q8Dgk4gceA=;
	b=AQIUxBsYwLMZe/RsYxWV8cwFj0Kbzankyg7CYp0nqtGGtU/h4Qwq6L0BIhKKyLgnYpsin7
	9ceB4nHWJhSEW6kiYxI7fPGmTmHJqVarAzdU+MwkuVCIPkxJXbDdHFDCPUyoR6yDC3LpRM
	zCVwYOq99UjadxhewG9wiVrgS8/1084=
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
Subject: [PATCH v6 08/10] drm/bridge: tfp410: Use fwnode APIs to acquire device properties
Date: Mon, 27 May 2024 04:21:13 +0800
Message-Id: <20240526202115.129049-9-sui.jingfeng@linux.dev>
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
No functional changes for DT-based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 39 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 04a341133488..a1fae5e9dafd 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -261,8 +261,9 @@ static const struct drm_bridge_timings tfp410_default_timings = {
 
 static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dvi->dev);
 	struct drm_bridge_timings *timings = &dvi->timings;
-	struct device_node *ep;
+	struct fwnode_handle *ep;
 	u32 pclk_sample = 0;
 	u32 bus_width = 24;
 	u32 deskew = 0;
@@ -283,14 +284,14 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
 	 * and EDGE pins. They are specified in DT through endpoint properties
 	 * and vendor-specific properties.
 	 */
-	ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
+	ep = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
 	if (!ep)
 		return -EINVAL;
 
 	/* Get the sampling edge from the endpoint. */
-	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
-	of_property_read_u32(ep, "bus-width", &bus_width);
-	of_node_put(ep);
+	fwnode_property_read_u32(ep, "pclk-sample", &pclk_sample);
+	fwnode_property_read_u32(ep, "bus-width", &bus_width);
+	fwnode_handle_put(ep);
 
 	timings->input_bus_flags = DRM_BUS_FLAG_DE_HIGH;
 
@@ -319,7 +320,7 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
 	}
 
 	/* Get the setup and hold time from vendor-specific properties. */
-	of_property_read_u32(dvi->dev->of_node, "ti,deskew", &deskew);
+	fwnode_property_read_u32(fwnode, "ti,deskew", &deskew);
 	if (deskew > 7)
 		return -EINVAL;
 
@@ -331,12 +332,12 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
 
 static int tfp410_init(struct device *dev, bool i2c)
 {
-	struct device_node *node;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct tfp410 *dvi;
 	int ret;
 
-	if (!dev->of_node) {
-		dev_err(dev, "device-tree data is missing\n");
+	if (!fwnode) {
+		dev_err(dev, "firmware data is missing\n");
 		return -ENXIO;
 	}
 
@@ -356,15 +357,15 @@ static int tfp410_init(struct device *dev, bool i2c)
 		return ret;
 
 	/* Get the next bridge, connected to port@1. */
-	node = of_graph_get_remote_node(dev->of_node, 1, -1);
-	if (!node)
-		return -ENODEV;
-
-	dvi->next_bridge = of_drm_find_bridge(node);
-	of_node_put(node);
-
-	if (!dvi->next_bridge)
+	dvi->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
+	if (IS_ERR(dvi->next_bridge)) {
+		ret = PTR_ERR(dvi->next_bridge);
+		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
+		return ret;
+	} else if (!dvi->next_bridge) {
+		dev_dbg(dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
+	}
 
 	/* Get the powerdown GPIO. */
 	dvi->powerdown = devm_gpiod_get_optional(dev, "powerdown",
@@ -416,10 +417,10 @@ static struct platform_driver tfp410_platform_driver = {
 /* There is currently no i2c functionality. */
 static int tfp410_i2c_probe(struct i2c_client *client)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
 	int reg;
 
-	if (!client->dev.of_node ||
-	    of_property_read_u32(client->dev.of_node, "reg", &reg)) {
+	if (!fwnode || fwnode_property_read_u32(fwnode, "reg", &reg)) {
 		dev_err(&client->dev,
 			"Can't get i2c reg property from device-tree\n");
 		return -ENXIO;
-- 
2.34.1


