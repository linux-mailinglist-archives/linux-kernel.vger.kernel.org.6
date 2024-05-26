Return-Path: <linux-kernel+bounces-189861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD628CF5F1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8221D1C20B75
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBCF139592;
	Sun, 26 May 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kaipai+S"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232A13A404
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754924; cv=none; b=KnTCwM5RGLRgE7TIWf1MMiq/tXR+2ooF78xi2o7p9KRV3e86rBEOTTWP+RYkbKzM/qcsfVbVXjprHC9CBms1+YdkxeIdsshhiK1NBMvFxDfv6TCVXjisWmUAyqHrTmnvosco8h/Ta8mwwcU0vMz9Z0MBk2vYTzDoktH5skYpBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754924; c=relaxed/simple;
	bh=kYFxmWRdbPydozaGTcIpRlcm4XoGgiXWDEvjk/MZIVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wr4wA/K6/oiButMcUhipP88tnU7pBaWaIxMYk5IPsKCzsg8Z97gpLcT9cEcETrrcarqxSSqZVrcjw7lrwvjtjLSRdodWwxWlYKOCillO4iJOILIhzbZbooNHfv80J2NT88Mj1aOZ157LqZ2fHVw/wsk5rOMR1MIInq+MrbIv3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kaipai+S; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbVQH6UjLIjvKCoLX7bXmeNWCrvCRHfR0kUXIzVDjRE=;
	b=Kaipai+SutibUDr4EsmJ1eYyck6yOz9Qet87vyspLMoaPjpb6fOz9eF/0RObBYmFAFEWT1
	FH0xNfYVzyxeufSWffv8k61lrB5qoRVFcqiL8FA9UAAgdPvrCsHqUWGNtQrvyPtCDz+ck9
	QbP8lBxB+opjB/pyzv+kydXo4tDbEyY=
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
Subject: [PATCH v6 06/10] drm/bridge: sii902x: Switch to use fwnode APIs to acquire device properties
Date: Mon, 27 May 2024 04:21:11 +0800
Message-Id: <20240526202115.129049-7-sui.jingfeng@linux.dev>
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

Make this driver less DT-dependent by calling the freshly created helpers,
also switch to use fwnode APIs to acquire additional device properties.
One side benifit is that boilerplates get reduced, no functional changes
for DT-based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/sii902x.c | 43 +++++++++++---------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index f4808838717a..975511d623a4 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -827,20 +827,17 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		.spdif = 0,
 		.max_i2s_channels = 0,
 	};
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	u8 lanes[4];
 	int num_lanes, i;
 
-	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
+	if (!fwnode_property_present(fwnode, "#sound-dai-cells")) {
 		dev_dbg(dev, "%s: No \"#sound-dai-cells\", no audio\n",
 			__func__);
 		return 0;
 	}
 
-	num_lanes = of_property_read_variable_u8_array(dev->of_node,
-						       "sil,i2s-data-lanes",
-						       lanes, 1,
-						       ARRAY_SIZE(lanes));
-
+	num_lanes = fwnode_property_count_u8(fwnode, "sil,i2s-data-lanes");
 	if (num_lanes == -EINVAL) {
 		dev_dbg(dev,
 			"%s: No \"sil,i2s-data-lanes\", use default <0>\n",
@@ -852,7 +849,11 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 			"%s: Error gettin \"sil,i2s-data-lanes\": %d\n",
 			__func__, num_lanes);
 		return num_lanes;
+	} else {
+		fwnode_property_read_u8_array(fwnode, "sil,i2s-data-lanes",
+					      lanes, num_lanes);
 	}
+
 	codec_data.max_i2s_channels = 2 * num_lanes;
 
 	for (i = 0; i < num_lanes; i++)
@@ -1117,7 +1118,6 @@ static int sii902x_init(struct sii902x *sii902x)
 static int sii902x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device_node *endpoint;
 	struct sii902x *sii902x;
 	static const char * const supplies[] = {"iovcc", "cvcc12"};
 	int ret;
@@ -1146,27 +1146,14 @@ static int sii902x_probe(struct i2c_client *client)
 		return PTR_ERR(sii902x->reset_gpio);
 	}
 
-	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
-	if (endpoint) {
-		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);
-
-		of_node_put(endpoint);
-		if (!remote) {
-			dev_err(dev, "Endpoint in port@1 unconnected\n");
-			return -ENODEV;
-		}
-
-		if (!of_device_is_available(remote)) {
-			dev_err(dev, "port@1 remote device is disabled\n");
-			of_node_put(remote);
-			return -ENODEV;
-		}
-
-		sii902x->next_bridge = of_drm_find_bridge(remote);
-		of_node_put(remote);
-		if (!sii902x->next_bridge)
-			return dev_err_probe(dev, -EPROBE_DEFER,
-					     "Failed to find remote bridge\n");
+	sii902x->next_bridge = drm_bridge_find_next_bridge_by_fwnode(dev_fwnode(dev), 1);
+	if (!sii902x->next_bridge) {
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "Failed to find the next bridge\n");
+	} else if (IS_ERR(sii902x->next_bridge)) {
+		ret = PTR_ERR(sii902x->next_bridge);
+		dev_err(dev, "Error on find the next bridge: %d\n", ret);
+		return ret;
 	}
 
 	mutex_init(&sii902x->mutex);
-- 
2.34.1


