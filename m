Return-Path: <linux-kernel+bounces-358774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F020199837A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DDF1F239DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00811C2DA4;
	Thu, 10 Oct 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FhXyedf7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECD1C243D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555815; cv=none; b=Uqm6nBAA9qYxEbbLW7hsZXzXH0QAXqZtmxKoPo2UUqJfB2622LUImUv0LfbeGuQD2x1zpoXgyZgjyXfpanPVNkcFzX1nFno8cKymeFcyc24rxMSi7pa7ar25HGKEV5UVQJtjseZY1YI5pZSgQdGRTqswfAoBbIwO3vemMc4Yn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555815; c=relaxed/simple;
	bh=s/1gGhbnt50tcEUMLNEZ7eg+4hprLgeErANYEfXxqho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2zW3X9SZJqcgwKU5fPfAIExQIOb2C7mdrhxoVUzhkerc+ZsGQjv2TAF2mOJlK4dTctYHr+XN/P4Jcx7N1Ote+ETYgDyGMNb2Sc8myitnWI1KY5oqJJqgxfboURPbtzoUR6N/dOLivdoraNF0ml3i5sjQfV0yuQ0FWhj+udJwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FhXyedf7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F06F1648;
	Thu, 10 Oct 2024 12:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728555709;
	bh=s/1gGhbnt50tcEUMLNEZ7eg+4hprLgeErANYEfXxqho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhXyedf7uq/9gqlzV1eYj7ouAG0A7n/jKnsL2qcZJ0hTaRf7ld7GFB3P/+YjJfZYL
	 KuN1W7kiWh5MU/eRpio4YTouFUY7nEK4I/EpAYTqoUS0NqSO0RYjyl0Cg8T/FkPc3U
	 LJtWLgo2P4yoilFtgF1lJcF2eN0MNgxln15CPapg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 5/5] staging: vchiq_core: Locally cache cache_line_size information
Date: Thu, 10 Oct 2024 15:52:49 +0530
Message-ID: <20241010102250.236545-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010102250.236545-1-umang.jain@ideasonboard.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Locally cache 'cache_line_size' information in a variable instead of
repeatedly accessing it from drv_mgmt->info. This helps to reflow lines
under 80 columns.

No functional change intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index d03b67f9cdb7..19c24dd9d1b3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1516,6 +1516,7 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 	size_t pagelist_size;
 	struct scatterlist *scatterlist, *sg;
 	int dma_buffers;
+	unsigned int cache_line_size;
 	dma_addr_t dma_addr;
 
 	if (count >= INT_MAX - PAGE_SIZE)
@@ -1666,10 +1667,10 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 	}
 
 	/* Partial cache lines (fragments) require special measures */
+	cache_line_size = drv_mgmt->info->cache_line_size;
 	if ((type == PAGELIST_READ) &&
-	    ((pagelist->offset & (drv_mgmt->info->cache_line_size - 1)) ||
-	    ((pagelist->offset + pagelist->length) &
-	    (drv_mgmt->info->cache_line_size - 1)))) {
+	    ((pagelist->offset & (cache_line_size - 1)) ||
+	    ((pagelist->offset + pagelist->length) & (cache_line_size - 1)))) {
 		char *fragments;
 
 		if (down_interruptible(&drv_mgmt->free_fragments_sema)) {
@@ -1699,6 +1700,7 @@ free_pagelist(struct vchiq_instance *instance,
 	struct pagelist *pagelist = pagelistinfo->pagelist;
 	struct page **pages = pagelistinfo->pages;
 	unsigned int num_pages = pagelistinfo->num_pages;
+	unsigned int cache_line_size;
 
 	dev_dbg(instance->state->dev, "arm: %pK, %d\n",
 		pagelistinfo->pagelist, actual);
@@ -1714,6 +1716,7 @@ free_pagelist(struct vchiq_instance *instance,
 	pagelistinfo->scatterlist_mapped = 0;
 
 	/* Deal with any partial cache lines (fragments) */
+	cache_line_size = drv_mgmt->info->cache_line_size;
 	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS &&
 	    drv_mgmt->fragments_base) {
 		char *fragments = drv_mgmt->fragments_base +
@@ -1721,10 +1724,10 @@ free_pagelist(struct vchiq_instance *instance,
 			drv_mgmt->fragments_size;
 		int head_bytes, tail_bytes;
 
-		head_bytes = (drv_mgmt->info->cache_line_size - pagelist->offset) &
-			     (drv_mgmt->info->cache_line_size - 1);
+		head_bytes = (cache_line_size - pagelist->offset) &
+			     (cache_line_size - 1);
 		tail_bytes = (pagelist->offset + actual) &
-			     (drv_mgmt->info->cache_line_size - 1);
+			     (cache_line_size - 1);
 
 		if ((actual >= 0) && (head_bytes != 0)) {
 			if (head_bytes > actual)
@@ -1737,8 +1740,8 @@ free_pagelist(struct vchiq_instance *instance,
 		    (tail_bytes != 0))
 			memcpy_to_page(pages[num_pages - 1],
 				       (pagelist->offset + actual) &
-				       (PAGE_SIZE - 1) & ~(drv_mgmt->info->cache_line_size - 1),
-				       fragments + drv_mgmt->info->cache_line_size,
+				       (PAGE_SIZE - 1) & ~(cache_line_size - 1),
+				       fragments + cache_line_size,
 				       tail_bytes);
 
 		down(&drv_mgmt->free_fragments_mutex);
-- 
2.45.2


