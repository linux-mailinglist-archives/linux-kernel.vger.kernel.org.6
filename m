Return-Path: <linux-kernel+bounces-189858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1938CF5EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0197BB20C5C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C77713956C;
	Sun, 26 May 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZgaaq2L"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11361386D5
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754915; cv=none; b=UrgWRQC98nP8AsNUOw5duhvvILAjdVw0MR4R+L/ZL2eKnZuaiUHG57phzas3gtYqcLSeBB0CiP6T6n5Z2qBLjP8wvoNlMx65JZCpv3xwXwB7O2r/tJRstOCfZzwfjxi+OvvfF1F8KmUAkK2V0m8t5YACGasnw2w3H6qT8w0M1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754915; c=relaxed/simple;
	bh=TEAT7ln5dk99EzK70C7z+YnuBl1yk9GN5l9RBsiF/XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIw7FcZaY85tMCTMa5pjhnTJD5sGVQacB8aH+wL/gpI0CXYzuWu9BmrwVmXrs+7/H86j0y/c0L60/wZTtf101FDYwyXSRY8LbpjBM5S/4IcaLpszQ/y/kh88Cq3S3qTidamZ02zw0TrfhIzPXG1WgrGPXjWw6Dc4JpXhlJheviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZgaaq2L; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ax3mzsSKWaKtO/VKspU0u4aFE2YRX4lxmc4yisd0VCk=;
	b=kZgaaq2LcKIAVWpj5LqUOOMVFWZhtAPBeHsUIDVQkz2GEttX32HFWx9ChsUdE8US81w1lZ
	bkQQ97MJJ/UYmNfkfjaSv9SgEIdq53QccscD5/BJcNv9RL94Vk3CIWl8sFfZHjifaEgmCQ
	gOxaSv9XgpGdq5GKUC0yNCawxD4p5io=
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
Subject: [PATCH v6 03/10] drm/bridge: Implement of_drm_find_bridge() on the top of drm_bridge_find_by_fwnode()
Date: Mon, 27 May 2024 04:21:08 +0800
Message-Id: <20240526202115.129049-4-sui.jingfeng@linux.dev>
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

Before applying this patch, people may worry about the OF and non-OF API
will have a risk to diverge. Eliminate the risk by reimplement the
of_drm_find_bridge() on the top of drm_bridge_find_by_fwnode(). As for now
the fundamental searching method is unique.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 29 -----------------------------
 include/drm/drm_bridge.h     | 14 +++++---------
 2 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 7759ca066db4..4c5584922d3c 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1346,35 +1346,6 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
 
-#ifdef CONFIG_OF
-/**
- * of_drm_find_bridge - find the bridge corresponding to the device node in
- *			the global bridge list
- *
- * @np: device node
- *
- * RETURNS:
- * drm_bridge control struct on success, NULL on failure
- */
-struct drm_bridge *of_drm_find_bridge(struct device_node *np)
-{
-	struct drm_bridge *bridge;
-
-	mutex_lock(&bridge_lock);
-
-	list_for_each_entry(bridge, &bridge_list, list) {
-		if (bridge->of_node == np) {
-			mutex_unlock(&bridge_lock);
-			return bridge;
-		}
-	}
-
-	mutex_unlock(&bridge_lock);
-	return NULL;
-}
-EXPORT_SYMBOL(of_drm_find_bridge);
-#endif
-
 /**
  * drm_bridge_find_by_fwnode - Find the bridge corresponding to the fwnode
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 7b592cf30340..8d743dfe782c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -791,21 +791,17 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous,
 		      enum drm_bridge_attach_flags flags);
 
-#ifdef CONFIG_OF
-struct drm_bridge *of_drm_find_bridge(struct device_node *np);
-#else
-static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
-{
-	return NULL;
-}
-#endif
-
 struct drm_bridge *
 drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode);
 
 struct drm_bridge *
 drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port);
 
+static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
+{
+	return drm_bridge_find_by_fwnode(of_fwnode_handle(np));
+}
+
 /**
  * drm_bridge_get_next_bridge() - Get the next bridge in the chain
  * @bridge: bridge object
-- 
2.34.1


