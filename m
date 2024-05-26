Return-Path: <linux-kernel+bounces-189862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA88CF5F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DD5B21352
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3D13A89F;
	Sun, 26 May 2024 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+NBYNLM"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DD13A897
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754928; cv=none; b=pDu0/35nqbCGiErJ7dHyD2EGLpnWPNFFjN7rU7vDkIzNm6PZD8krVQAzvWaY6uyynKpcHh52I7rLcEWPqZJMDOMstinFO6Glo1YO6+k5WhDWaRlvFuGqRVO2dK/wOiedWLdlnfSwSBVtJ2Vj5wf8gDiS+HZAN8PQLGB3hHkNuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754928; c=relaxed/simple;
	bh=+SCbkHtXmSwmPLYiAo5QvV4vb3VSwL6VziphHq3TYU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFenp9Qt9PkDKTPFGTr2TYxBRnX1z0boYCpxn/ClQ0brkzWNC+XLD5MDLFv7ewPPTZ/0IT/eXs1Nqgr2OA0JsGtzeD0C3Yq2zL0+hk3eiGMnnmUo4HWn7gem8MkIP6iSufYmmcjAlihCF8F4gcCg81JISFWX2zWYaTEC4i8NAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+NBYNLM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qhbed/SUcFr0rLoLCUd1P5dCcGTlbJ/ZBy5axgpBfHc=;
	b=c+NBYNLMsdSfYP94yF9anFJ2yfdIdneelWbdWt7lQ5BYsNmPU186fcNHZ6jqeK1dJgS/OR
	PKM5yZp2hQZHoyPVaDx+vkbnXF6AVR+ouALZcqOU6iVbs/nR3Bx92WEhDGhPbDNugBiVel
	5xE+U/pqiB6xPwJv23v9L0PZc0vPQI8=
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
Subject: [PATCH v6 07/10] drm-bridge: it66121: Use fwnode APIs to acquire device properties
Date: Mon, 27 May 2024 04:21:12 +0800
Message-Id: <20240526202115.129049-8-sui.jingfeng@linux.dev>
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
 drivers/gpu/drm/bridge/ite-it66121.c | 55 +++++++++++++++++-----------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 8e4fc082bb8c..3fa650f7fec9 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -15,7 +15,6 @@
 #include <linux/bitfield.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/of_graph.h>
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
@@ -1480,7 +1479,7 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
+	if (!fwnode_property_present(dev_fwnode(dev), "#sound-dai-cells")) {
 		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
 		return 0;
 	}
@@ -1503,13 +1502,36 @@ static const char * const it66121_supplies[] = {
 	"vcn33", "vcn18", "vrf12"
 };
 
+static int it66121_read_bus_width(struct fwnode_handle *fwnode, u32 *bus_width)
+{
+	struct fwnode_handle *endpoint;
+	u32 val;
+	int ret;
+
+	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
+	if (!endpoint)
+		return -EINVAL;
+
+	ret = fwnode_property_read_u32(endpoint, "bus-width", &val);
+	fwnode_handle_put(endpoint);
+	if (ret)
+		return ret;
+
+	if (val != 12 && val != 24)
+		return -EINVAL;
+
+	*bus_width = val;
+
+	return 0;
+}
+
 static int it66121_probe(struct i2c_client *client)
 {
 	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
-	struct device_node *ep;
 	int ret;
 	struct it66121_ctx *ctx;
 	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(dev, "I2C check functionality failed.\n");
@@ -1520,29 +1542,20 @@ static int it66121_probe(struct i2c_client *client)
 	if (!ctx)
 		return -ENOMEM;
 
-	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
-	if (!ep)
-		return -EINVAL;
-
 	ctx->dev = dev;
 	ctx->client = client;
 	ctx->info = i2c_get_match_data(client);
 
-	of_property_read_u32(ep, "bus-width", &ctx->bus_width);
-	of_node_put(ep);
-
-	if (ctx->bus_width != 12 && ctx->bus_width != 24)
-		return -EINVAL;
-
-	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
-	if (!ep) {
-		dev_err(ctx->dev, "The endpoint is unconnected\n");
-		return -EINVAL;
-	}
+	ret = it66121_read_bus_width(fwnode, &ctx->bus_width);
+	if (ret)
+		return ret;
 
-	ctx->next_bridge = of_drm_find_bridge(ep);
-	of_node_put(ep);
-	if (!ctx->next_bridge) {
+	ctx->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
+	if (IS_ERR(ctx->next_bridge)) {
+		ret = PTR_ERR(ctx->next_bridge);
+		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
+		return ret;
+	} else if (!ctx->next_bridge) {
 		dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
 	}
-- 
2.34.1


