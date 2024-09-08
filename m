Return-Path: <linux-kernel+bounces-320106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA253970644
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562C81F21E59
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AF1537D2;
	Sun,  8 Sep 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISbnTowJ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADE130A73
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788696; cv=none; b=osF75e25LEL0UMAHw0LYoSOr3SnzTtj7PDBMxJTZm7Bg6pPkm3XdSE6vFlSFuKo6Qyy69YgxcMYT7xNCr3AICD7pcwkoK/81/V95KtYJES1W79SG0QA0vBdYDuvd/ksN9kca4YU6kHWgcE5hPUdO8wpEw4OIGdHR5jjkhQAD6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788696; c=relaxed/simple;
	bh=G1hFloUTtWCIMK77J9kTVpNJLAKU6hUXd7H3t+JPiPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9pUncU0tLUsbop8YD+xWy2d+GCbmhkzpEBfe/aUAbNnJmgEGLrTrITrZ38laxWBABQvUzzPLkvFyujJm4TRxZ+rNp9kE+gZjBnnJc+FiXbBvjnBMJh/5pZEC8PmH1aJSoVF8FCPP1NzVmXE3/WaO4CrnrsGm7yf0aStn/6R+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISbnTowJ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAHogt64c5kc7Y5YIuhEER7fMKYPMI3sUmBW7MfbuoU=;
	b=ISbnTowJKRJD4v5Y/1dJoz9dC5D6tqEvzps0KId0ZtCc0xfszj0YAiQwkNq4U9rTo+jFzD
	GQSM2+s2C+MdtzcxcilN4KwtpxQOezqKL6en3A9nwo8B1Y3z3zCijWRuGLGjifBy+j5vD8
	oV2dCVJM0fknzeicdJPJ2vmzqECfPck=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 11/19] drm/etnaviv: Add etnaviv_gem_obj_remove() helper
Date: Sun,  8 Sep 2024 17:43:49 +0800
Message-ID: <20240908094357.291862-12-sui.jingfeng@linux.dev>
In-Reply-To: <20240908094357.291862-1-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Which is corresonding to the etnaviv_gem_obj_add()

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 39cfece67b90..3732288ff530 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -19,6 +19,8 @@
 static struct lock_class_key etnaviv_shm_lock_class;
 static struct lock_class_key etnaviv_userptr_lock_class;
 
+static void etnaviv_gem_obj_remove(struct drm_gem_object *obj);
+
 static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
 {
 	struct drm_device *dev = etnaviv_obj->base.dev;
@@ -555,15 +557,12 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 {
 	struct drm_device *drm = obj->dev;
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
-	struct etnaviv_drm_private *priv = obj->dev->dev_private;
 	struct etnaviv_vram_mapping *mapping, *tmp;
 
 	/* object should not be active */
 	drm_WARN_ON(drm, is_active(etnaviv_obj));
 
-	mutex_lock(&priv->gem_lock);
-	list_del(&etnaviv_obj->gem_node);
-	mutex_unlock(&priv->gem_lock);
+	etnaviv_gem_obj_remove(obj);
 
 	list_for_each_entry_safe(mapping, tmp, &etnaviv_obj->vram_list,
 				 obj_node) {
@@ -595,6 +594,16 @@ void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
 	mutex_unlock(&priv->gem_lock);
 }
 
+static void etnaviv_gem_obj_remove(struct drm_gem_object *obj)
+{
+	struct etnaviv_drm_private *priv = to_etnaviv_priv(obj->dev);
+	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
+
+	mutex_lock(&priv->gem_lock);
+	list_del(&etnaviv_obj->gem_node);
+	mutex_unlock(&priv->gem_lock);
+}
+
 static const struct vm_operations_struct vm_ops = {
 	.fault = etnaviv_gem_fault,
 	.open = drm_gem_vm_open,
-- 
2.43.0


