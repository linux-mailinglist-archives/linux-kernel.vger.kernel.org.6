Return-Path: <linux-kernel+bounces-394054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6A9BAA06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE3C281F72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F179FD;
	Mon,  4 Nov 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wwif5Mqr"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1E6AA1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730680931; cv=none; b=T57Z1MJtcUF7y1UP/1XxC2NofCWPTgvc93/3OLGLFucq00jSQ1jubaZMXxXIZkXw66DxuQQ/fYI7BQxntARRoQOPGWceN+15g+gObfh2Q7K8yxM962gI+Et458tbPIsw5dQ0dwP7yz/letm0qjXEOUBGvcyvBvBkRE0PJi1Ptl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730680931; c=relaxed/simple;
	bh=UwwUbw9616lL6jaJ72iUGVwewNrgUxY8OLqklchWYGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1afLWHo7m+AdHGIN2IJiMUnS4hLGb7o9I/6jgBSWx3Uh0Q4CqNLC5ZwsV79WgdHWV8RRdvUfxT6VDtZ9Y8X++5xDMDnhlT9WS4UJlY6L86fpkiqvAYpUhcOITsEm10u/QwJPbz79Ly2Rm+zsUkcrpDwrLAfIbcacN/6aLqnRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wwif5Mqr; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730680927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mnu5J7z5ffD/k3tXSN3gqMpZQliUz1lpi/hSy+21gDs=;
	b=Wwif5MqrNPC4eEbhBjHeVPrnjxpggDNWgBCDYagSZlw0wjeTeHBVYo6xAYVp9YzX0ByySb
	XaA0Q222OGtb6DKQlYHqkthcZeOqpB1rv2nx9YLkSFbPpBrxbQOLxp2BZsYi7IlIJsy1CP
	OVJjtz82OnQO7oMs3RhnrGGG30fKoh8=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v16] drm/etnaviv: Fix page property being used for non writecombine buffers
Date: Mon,  4 Nov 2024 08:41:56 +0800
Message-Id: <20241104004156.8635-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the etnaviv_gem_vmap_impl() function, the driver vmap whatever buffers
with write combine(WC) page property, this is incorrect. Cached buffers
should be mapped with the cached page property and uncached buffers should
be mapped with the uncached page property.

Fixes: a0a5ab3e99b8 ("drm/etnaviv: call correct function when trying to vmap a DMABUF")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
Split from my PCIe device driver wrapper support series, since this probably
should be resend as a standalone patch.

v15: Use `obj->flags & ETNA_BO_CACHE_MASK` (Lucas)
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index d51843d9a476..d2cb9dded051 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -362,6 +362,7 @@ static void etnaviv_gem_object_vunmap(struct drm_gem_object *obj,
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
+	pgprot_t prot;
 
 	lockdep_assert_held(&obj->lock);
 
@@ -369,8 +370,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, obj->base.size >> PAGE_SHIFT,
-			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	switch (obj->flags & ETNA_BO_CACHE_MASK) {
+	case ETNA_BO_CACHED:
+		prot = PAGE_KERNEL;
+		break;
+	case ETNA_BO_UNCACHED:
+		prot = pgprot_noncached(PAGE_KERNEL);
+		break;
+	case ETNA_BO_WC:
+	default:
+		prot = pgprot_writecombine(PAGE_KERNEL);
+	}
+
+	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
 }
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
-- 
2.34.1


