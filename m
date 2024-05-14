Return-Path: <linux-kernel+bounces-178876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D695C8C58F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134701C2178B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73A17EBBB;
	Tue, 14 May 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b83KCb1T"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBF262BD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701261; cv=none; b=CY8v2LLaZJ5dKBHAbik1PG+n/M0JQ/aCQtB3/okNM1PegGZlXSX02KnEbLNKrQZ3dZFHvoDc1L0/Mb/kZDuz/F0U6SOdK3WiJn53DDz9UZnYmZM8WVDCL8FR416n46SxmY/13S7cgttaMbmb0qfyfAs1gVdQwPtPkyGitwrVZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701261; c=relaxed/simple;
	bh=F9v1VUN1ZoU146hLbnQ5w5Ftyw0qZ6Aa1wSGARKVim8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abYCF1wy/JnTUmj0iZlFL0oIudRWM5YDJ1rnBZglhTYGtU2U05kknakBXILxpKDaCu4O99UsTg5DQNyAiL1aN8dUhHMJkQ5meSnGEIlX8lD2St4JmpCqIj8Vz134k4YWW6UNAZbL6nnbBkkU9Tb1uCFD6EluHwidnIHZCPY4+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b83KCb1T; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715701257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+05gkzCN5mCB4ObLHZD3qVmOLfaIYvz5ahLIgbHM3dE=;
	b=b83KCb1Tg0IIJh0e+PTZYsvu7sHmyZ4628WaUjPak1hG/ZRyuUFvR1VUsHAjehi6J8w9qx
	dwr1xixVGf18AG0ajiDQLreUdugxBgiy670YKjD/OnIwyo8WHskKETATD4OA1isHD5uGBW
	FALM0ULUBiAVMAthwhdJMzKbtD5A8xI=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 1/2] drm/bridge: Support finding bridge with struct device
Date: Tue, 14 May 2024 23:40:44 +0800
Message-ID: <20240514154045.309925-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240514154045.309925-1-sui.jingfeng@linux.dev>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The pointer of 'struct device' can also be used as a key to search drm
bridge instance from the global bridge list, traditionally, fwnode and
'OF' based APIs requires the system has decent fwnode/OF Graph support.
While the drm_find_bridge_by_dev() function introduced in this series
don't has such a restriction. It only require you has a pointer to the
backing device. Hence, it may suitable for some small and/or limited
display subsystems.

Also add the drm_bridge_add_with_dev() as a helper, which automatically
set the .of_node field of drm_bridge instances if you call it. But it
suitable for simple bridge drivers which one device backing one drm_bridge
instance.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 39 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 584d109330ab..1928d9d0dd3c 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -213,6 +213,23 @@ void drm_bridge_add(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_add);
 
+/**
+ * drm_bridge_add_with_dev - add the given bridge to the global bridge list
+ *
+ * @bridge: bridge control structure
+ * @dev: pointer to the kernel device that this bridge is backed.
+ */
+void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev)
+{
+	if (dev) {
+		bridge->kdev = dev;
+		bridge->of_node = dev->of_node;
+	}
+
+	drm_bridge_add(bridge);
+}
+EXPORT_SYMBOL_GPL(drm_bridge_add_with_dev);
+
 static void drm_bridge_remove_void(void *bridge)
 {
 	drm_bridge_remove(bridge);
@@ -1334,6 +1351,27 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
 
+struct drm_bridge *drm_find_bridge_by_dev(struct device *kdev)
+{
+	struct drm_bridge *bridge;
+
+	if (!kdev)
+		return NULL;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list) {
+		if (bridge->kdev == kdev) {
+			mutex_unlock(&bridge_lock);
+			return bridge;
+		}
+	}
+
+	mutex_unlock(&bridge_lock);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(drm_find_bridge_by_dev);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
@@ -1361,6 +1399,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_drm_find_bridge);
+
 #endif
 
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4baca0d9107b..70d8393bbd9c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -715,6 +715,8 @@ struct drm_bridge {
 	struct drm_private_obj base;
 	/** @dev: DRM device this bridge belongs to */
 	struct drm_device *dev;
+	/** @kdev: pointer to the kernel device backing this bridge */
+	struct device *kdev;
 	/** @encoder: encoder to which this bridge is connected */
 	struct drm_encoder *encoder;
 	/** @chain_node: used to form a bridge chain */
@@ -782,12 +784,15 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 }
 
 void drm_bridge_add(struct drm_bridge *bridge);
+void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev);
 int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge);
 void drm_bridge_remove(struct drm_bridge *bridge);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous,
 		      enum drm_bridge_attach_flags flags);
 
+struct drm_bridge *drm_find_bridge_by_dev(struct device *kdev);
+
 #ifdef CONFIG_OF
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 #else
-- 
2.43.0


