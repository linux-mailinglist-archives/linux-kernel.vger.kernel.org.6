Return-Path: <linux-kernel+bounces-572653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF5A6CCB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3451E1B6026E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D0236426;
	Sat, 22 Mar 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Z3LtJmV1"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447F235340
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678979; cv=pass; b=oF7LI7YlkBGaEy11qtHNNR90omSk9VYdUv1psU1pitXsbfR0UDBQ7X+1YKAoNAD2BA+rzZjQtFyd6dtDa/jagVzMuF7fNtbDaO5fobE1jL+la5/H1C2nAvWcM7cF9vq0PZaHYgTkwHbCHmYJBHVOrpCyYlvlD2ewyZw10HiUP6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678979; c=relaxed/simple;
	bh=C5mh2blTq89it3k/qfDOOnCSPYBFosnK+Kzh2mMEpao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyPSGPdr5qVM1rTv+lXPleRzoTa9GRyU2EZ5jmIivGdtCHtDnRBXBl6XJG5FR820qSupAwa2gX2ddLKPf9mh5jDWfJIl8IPhm5wht6TiD2/QwyNAP1xmINMJC+c+0k0tKaT+DS+P+W72U9ZlcP0an+Gyd9Vqej/H54vZrBeXZOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Z3LtJmV1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742678955; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=juaxAJCrvrgSeb48itlacxngBqXwLrekvexnPpvTbbu7R8QTqwhtr5zawhmjfbKxWTyykbx6oKcHxDuHdjWE+04cg5krCppUy1RHUM7Htf4C9gm8SRn+8ATNq2Zk+VGnKRfE3snUVU/M9sVVxP4Sa8Er0ijoHSiGbMK9nBa8NmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742678955; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D8skzeqwalBI3wYRwszZe+VNe6TDcBK3mAxl50TBKew=; 
	b=grsGYVO2TEDWJLi+expl4QKgARf+MdWS5heR+R8nnvPo6Pe/NOaQ42E/ey4eRWMnChVQ4OuF+ap4hLGMJsfSGLri6CDdKgg5oODmhmna/+FO8ZB6r9TpmIdAS7lbSXadSWKJH/uiL7OcTEyjMgZ81ozF/uRgRHLbrqxput21j64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742678955;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=D8skzeqwalBI3wYRwszZe+VNe6TDcBK3mAxl50TBKew=;
	b=Z3LtJmV1Duqg51kpfxHWZuqIMGJnLXbhss9hp6cHm7HfwA1OC/JJ0kagavWCG97g
	oe0LY9LxI9fnBL4EURSRotfVdVeE077avC2FGSrjzZYjkGv44xj+Z+D7GSRToTPWmLV
	unPbTZwBzR5Atrb6z1FkAjs8foxjWcDSRMzEPeHA=
Received: by mx.zohomail.com with SMTPS id 1742678953019135.32721424030217;
	Sat, 22 Mar 2025 14:29:13 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v20 02/10] drm/gem: Add _locked postfix to functions that have unlocked counterpart
Date: Sun, 23 Mar 2025 00:26:00 +0300
Message-ID: <20250322212608.40511-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add _locked postfix to drm_gem functions that have unlocked counterpart
functions to make GEM functions naming more consistent and intuitive in
regards to the locking requirements.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 6 +++---
 include/drm/drm_gem.h     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 27778e5ce0c0..1e659d2660f7 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1543,10 +1543,10 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
 EXPORT_SYMBOL(drm_gem_lru_scan);
 
 /**
- * drm_gem_evict - helper to evict backing pages for a GEM object
+ * drm_gem_evict_locked - helper to evict backing pages for a GEM object
  * @obj: obj in question
  */
-int drm_gem_evict(struct drm_gem_object *obj)
+int drm_gem_evict_locked(struct drm_gem_object *obj)
 {
 	dma_resv_assert_held(obj->resv);
 
@@ -1558,4 +1558,4 @@ int drm_gem_evict(struct drm_gem_object *obj)
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_gem_evict);
+EXPORT_SYMBOL(drm_gem_evict_locked);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 13c312ca07ae..43cf3c2c7ca0 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -561,7 +561,7 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
 			       unsigned long *remaining,
 			       bool (*shrink)(struct drm_gem_object *obj));
 
-int drm_gem_evict(struct drm_gem_object *obj);
+int drm_gem_evict_locked(struct drm_gem_object *obj);
 
 /**
  * drm_gem_object_is_shared_for_memory_stats - helper for shared memory stats
-- 
2.49.0


