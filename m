Return-Path: <linux-kernel+bounces-189856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F98CF5E6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939CC1F2125C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C08139592;
	Sun, 26 May 2024 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="thbuwD16"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9B1386D1
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754908; cv=none; b=brr0JeUSCg++52x/PshtBE4TT2iDkBSXutdCQU8nhgiY+XXubmtG3eHMRn3DmI7UABRwE8IyDJFq5vhVqNo/05uI9aQxorwzQHYzQk2OJS/YC7RJOaHxXVHyGlQ8bc6nNa52+9NskhpNSfuw/8jCfLlnpYqKbaVlAxIR7C5bwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754908; c=relaxed/simple;
	bh=qMXwCeIM1C7ZZfksXGJEnRIXsvC3QSzpQ4EzwJ0bKyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blAk4rSVj0hfhmZ3HlGPNd/jf1ojmj33QsbZsvwseFqDOGbgGb4vzGflIxxSDkkE1cVjid0UkruF2OpjMyudhJVKLCD3a0fhdFdDHdmrnNp6nO06KmjrQCiv3m6u1jKnCthoEiEFqCYrBX3NfozZJ0ZrGfvCKD1ydn3nxL+Fm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thbuwD16; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TesjfpUGDPwVI7KOd3mjPhe4mEXc1CsmbWQvMFAKEY=;
	b=thbuwD16tGjJd8wjfYaHZeUPgFecI5vvma6S+JUANcmMNuzXERGwyWgldMnUvt/OP+D/9L
	+GAHHD9C3qu7VU7RXvmsZFF3cm/fz9jzuke3HxrQMskDe6LO/ecaoCDOz+kHfyE+drKfNM
	opArLMaNvlBY8HK4eogbHGAKoaOTMb0=
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
Subject: [PATCH v6 01/10] drm/bridge: Allow using fwnode APIs to get the next bridge
Date: Mon, 27 May 2024 04:21:06 +0800
Message-Id: <20240526202115.129049-2-sui.jingfeng@linux.dev>
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

The various display bridge drivers rely on 'OF' infrastructures to
works very well, yet there are some platforms and/or devices lack of
'OF' support. Such as virtual display drivers, USB display apapters
and ACPI based systems etc.

Add fwnode based helpers to fill the niche, this allows part of display
bridge drivers to work across systems. As the fwnode APIs has wider
coverage than DT counterpart, and fwnode graphs are compatible with
OF graphs. So the newly created helpers can be used on all systems
in theory, assumed that there has valid OF/fwnode graphs established.

Note, the involved drm bridge instance should also has the fwnode
assigned, so that the user of it could find it via the fwnode handle.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 74 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 11 +++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 584d109330ab..cef5bc88ee60 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1363,6 +1363,80 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+/**
+ * drm_bridge_find_by_fwnode - Find the bridge corresponding to the fwnode
+ *
+ * @fwnode: fwnode for which to find the matching drm_bridge
+ *
+ * This function looks up a drm_bridge in the global bridge list, based on
+ * its associated fwnode. Drivers who want to use this function should has
+ * fwnode handle assigned to the fwnode member of the struct drm_bridge
+ * instance.
+ *
+ * Returns:
+ *  * A reference to the requested drm_bridge object on success, or
+ *  * %NULL otherwise (object does not exist or the driver of requested
+ *    bridge not probed yet).
+ */
+struct drm_bridge *drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct drm_bridge *ret = NULL;
+	struct drm_bridge *bridge;
+
+	if (!fwnode)
+		return NULL;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list) {
+		if (bridge->fwnode == fwnode) {
+			ret = bridge;
+			break;
+		}
+	}
+
+	mutex_unlock(&bridge_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_bridge_find_by_fwnode);
+
+/**
+ * drm_bridge_find_next_bridge_by_fwnode - Find the next bridge by fwnode
+ * @fwnode: fwnode pointer to the current device.
+ * @port: identifier of the port node of the next bridge is connected.
+ *
+ * This function find the next bridge of the current node the fwnode
+ * pointed to, assumed that the fwnode graph has been well established.
+ *
+ * Returns:
+ *  * A reference to the requested drm_bridge object on success, or
+ *  * -%ENODEV if the fwnode graph or OF graph is not complete, or
+ *  * %NULL if object does not exist or the next bridge is not ready yet.
+ */
+struct drm_bridge *
+drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port)
+{
+	struct drm_bridge *bridge;
+	struct fwnode_handle *ep;
+	struct fwnode_handle *remote;
+
+	ep = fwnode_graph_get_endpoint_by_id(fwnode, port, 0, 0);
+	if (!ep)
+		return ERR_PTR(-ENODEV);
+
+	remote = fwnode_graph_get_remote_port_parent(ep);
+	fwnode_handle_put(ep);
+	if (!remote)
+		return ERR_PTR(-ENODEV);
+
+	bridge = drm_bridge_find_by_fwnode(remote);
+	fwnode_handle_put(remote);
+
+	return bridge;
+}
+EXPORT_SYMBOL_GPL(drm_bridge_find_next_bridge_by_fwnode);
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4baca0d9107b..725d6dddaf36 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -26,14 +26,13 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_mode_object.h>
 #include <drm/drm_modes.h>
 
-struct device_node;
-
 struct drm_bridge;
 struct drm_bridge_timings;
 struct drm_connector;
@@ -721,6 +720,8 @@ struct drm_bridge {
 	struct list_head chain_node;
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
+	/** @fwnode: fwnode pointer to the bridge */
+	struct fwnode_handle *fwnode;
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
@@ -797,6 +798,12 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 }
 #endif
 
+struct drm_bridge *
+drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode);
+
+struct drm_bridge *
+drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port);
+
 /**
  * drm_bridge_get_next_bridge() - Get the next bridge in the chain
  * @bridge: bridge object
-- 
2.34.1


