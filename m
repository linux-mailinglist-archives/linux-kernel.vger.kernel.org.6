Return-Path: <linux-kernel+bounces-333575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D912897CAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FE91F23083
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05019B59D;
	Thu, 19 Sep 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t6gMqDiZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB019F49A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755712; cv=none; b=MbUawGZ7/VgR9ZbH7TlbrPocKShJJhXwZtArIEmAjnMCkCfpnHhWOSNQa7CzFNSh6vIi+G8T4zzZyAJIUbF2e6dBbNBNIMrgQyK0k4QRapLHMp45PifBJM3OsSfXMKF4ufPc76eP+ceguzBeKe4LIAYG0SFszYMjjSvdRclP1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755712; c=relaxed/simple;
	bh=vXQfoi9V2PmzfXTkCro03EgekhTgkHwHVEyWHwje/qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StZSdIm99SB3q+5z0ySqaOE9T8YhBYnLc2HvvmZT4s9KJdiaDcamapg/wgq8PcP3RaqdLViqz4XVzbhpsspxUfx41Sm3YBucRR3eLoFr5RbMa2Xze4n0mLE9pGyYC9u1sp39gNgkcTF1O9/j1EHebQP+zADJ47ie2j5JtJxY7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t6gMqDiZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 693AEC8E;
	Thu, 19 Sep 2024 16:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726755624;
	bh=vXQfoi9V2PmzfXTkCro03EgekhTgkHwHVEyWHwje/qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6gMqDiZl8XeyTYURO88bzPH9LwCOqqquVxg7gfZXXBh9PECL/KEgPLfbQLPfzM6a
	 7jyJKOnyFZ8xGdmbwPVkhBcQeChJI81Wm7m7ji9MGCbP+SwFx3uEWvTGx41DJTmhjA
	 pRGumF8JHfxiRgfoamj1uAoBdC2HpOSKZMbuxS3o=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/3] staging: vchiq_core: Move bulk data functions in vchiq_core
Date: Thu, 19 Sep 2024 19:51:29 +0530
Message-ID: <20240919142130.1331495-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
References: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bulk transfers core logic lives in vchiq_core.c, hence move all
the preparatory bulk data allocation helpers to vchiq_core.c (from
vchiq_arm).

The discrepancy was noticed when vchiq_prepare_bulk_data() and
vchiq_complete_bulk() are being used vchiq_core.c but are defined
in vchiq_arm. Now that they are now confined to vchiq_core.c,
they can be made static and their signatures from vchiq_core header
can be dropped.

vchiq_prepare_bulk_data() and vchiq_complete_bulk() depends on
struct vchiq_pagelist_info, cleanup_pagelist(), free_pagelist() and
create_pagelist() hence they are pulled in from vchiq_arm as well,
as part of this commit.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 337 ------------------
 .../interface/vchiq_arm/vchiq_core.c          | 324 +++++++++++++++++
 .../interface/vchiq_arm/vchiq_core.h          |  19 +-
 3 files changed, 338 insertions(+), 342 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8e9a5c67a6de..cc0b3f2506a4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -14,7 +14,6 @@
 #include <linux/device.h>
 #include <linux/device/bus.h>
 #include <linux/mm.h>
-#include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/bug.h>
 #include <linux/completion.h>
@@ -36,7 +35,6 @@
 #include "vchiq_arm.h"
 #include "vchiq_bus.h"
 #include "vchiq_debugfs.h"
-#include "vchiq_pagelist.h"
 
 #define DEVICE_NAME "vchiq"
 
@@ -108,17 +106,6 @@ struct vchiq_arm_state {
 	int first_connect;
 };
 
-struct vchiq_pagelist_info {
-	struct pagelist *pagelist;
-	size_t pagelist_buffer_size;
-	dma_addr_t dma_addr;
-	enum dma_data_direction dma_dir;
-	unsigned int num_pages;
-	unsigned int pages_need_release;
-	struct page **pages;
-	struct scatterlist *scatterlist;
-	unsigned int scatterlist_mapped;
-};
 
 static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
@@ -145,35 +132,6 @@ vchiq_doorbell_irq(int irq, void *dev_id)
 	return ret;
 }
 
-static void
-cleanup_pagelistinfo(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo)
-{
-	if (pagelistinfo->scatterlist_mapped) {
-		dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
-			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
-	}
-
-	if (pagelistinfo->pages_need_release)
-		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
-
-	dma_free_coherent(instance->state->dev, pagelistinfo->pagelist_buffer_size,
-			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
-}
-
-static inline bool
-is_adjacent_block(u32 *addrs, dma_addr_t addr, unsigned int k)
-{
-	u32 tmp;
-
-	if (!k)
-		return false;
-
-	tmp = (addrs[k - 1] & PAGE_MASK) +
-	      (((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT);
-
-	return tmp == (addr & PAGE_MASK);
-}
-
 /*
  * This function is called by the vchiq stack once it has been connected to
  * the videocore and clients can start to use the stack.
@@ -224,270 +182,6 @@ void vchiq_add_connected_callback(struct vchiq_device *device, void (*callback)(
 }
 EXPORT_SYMBOL(vchiq_add_connected_callback);
 
-/* There is a potential problem with partial cache lines (pages?)
- * at the ends of the block when reading. If the CPU accessed anything in
- * the same line (page?) then it may have pulled old data into the cache,
- * obscuring the new data underneath. We can solve this by transferring the
- * partial cache lines separately, and allowing the ARM to copy into the
- * cached area.
- */
-
-static struct vchiq_pagelist_info *
-create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
-		size_t count, unsigned short type)
-{
-	struct vchiq_drv_mgmt *drv_mgmt;
-	struct pagelist *pagelist;
-	struct vchiq_pagelist_info *pagelistinfo;
-	struct page **pages;
-	u32 *addrs;
-	unsigned int num_pages, offset, i, k;
-	int actual_pages;
-	size_t pagelist_size;
-	struct scatterlist *scatterlist, *sg;
-	int dma_buffers;
-	dma_addr_t dma_addr;
-
-	if (count >= INT_MAX - PAGE_SIZE)
-		return NULL;
-
-	drv_mgmt = dev_get_drvdata(instance->state->dev);
-
-	if (buf)
-		offset = (uintptr_t)buf & (PAGE_SIZE - 1);
-	else
-		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
-	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
-
-	if ((size_t)num_pages > (SIZE_MAX - sizeof(struct pagelist) -
-			 sizeof(struct vchiq_pagelist_info)) /
-			(sizeof(u32) + sizeof(pages[0]) +
-			 sizeof(struct scatterlist)))
-		return NULL;
-
-	pagelist_size = sizeof(struct pagelist) +
-			(num_pages * sizeof(u32)) +
-			(num_pages * sizeof(pages[0]) +
-			(num_pages * sizeof(struct scatterlist))) +
-			sizeof(struct vchiq_pagelist_info);
-
-	/* Allocate enough storage to hold the page pointers and the page
-	 * list
-	 */
-	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size, &dma_addr,
-				      GFP_KERNEL);
-
-	dev_dbg(instance->state->dev, "arm: %pK\n", pagelist);
-
-	if (!pagelist)
-		return NULL;
-
-	addrs		= pagelist->addrs;
-	pages		= (struct page **)(addrs + num_pages);
-	scatterlist	= (struct scatterlist *)(pages + num_pages);
-	pagelistinfo	= (struct vchiq_pagelist_info *)
-			  (scatterlist + num_pages);
-
-	pagelist->length = count;
-	pagelist->type = type;
-	pagelist->offset = offset;
-
-	/* Populate the fields of the pagelistinfo structure */
-	pagelistinfo->pagelist = pagelist;
-	pagelistinfo->pagelist_buffer_size = pagelist_size;
-	pagelistinfo->dma_addr = dma_addr;
-	pagelistinfo->dma_dir =  (type == PAGELIST_WRITE) ?
-				  DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	pagelistinfo->num_pages = num_pages;
-	pagelistinfo->pages_need_release = 0;
-	pagelistinfo->pages = pages;
-	pagelistinfo->scatterlist = scatterlist;
-	pagelistinfo->scatterlist_mapped = 0;
-
-	if (buf) {
-		unsigned long length = count;
-		unsigned int off = offset;
-
-		for (actual_pages = 0; actual_pages < num_pages;
-		     actual_pages++) {
-			struct page *pg =
-				vmalloc_to_page((buf +
-						 (actual_pages * PAGE_SIZE)));
-			size_t bytes = PAGE_SIZE - off;
-
-			if (!pg) {
-				cleanup_pagelistinfo(instance, pagelistinfo);
-				return NULL;
-			}
-
-			if (bytes > length)
-				bytes = length;
-			pages[actual_pages] = pg;
-			length -= bytes;
-			off = 0;
-		}
-		/* do not try and release vmalloc pages */
-	} else {
-		actual_pages = pin_user_pages_fast((unsigned long)ubuf & PAGE_MASK, num_pages,
-						   type == PAGELIST_READ, pages);
-
-		if (actual_pages != num_pages) {
-			dev_dbg(instance->state->dev, "arm: Only %d/%d pages locked\n",
-				actual_pages, num_pages);
-
-			/* This is probably due to the process being killed */
-			if (actual_pages > 0)
-				unpin_user_pages(pages, actual_pages);
-			cleanup_pagelistinfo(instance, pagelistinfo);
-			return NULL;
-		}
-		 /* release user pages */
-		pagelistinfo->pages_need_release = 1;
-	}
-
-	/*
-	 * Initialize the scatterlist so that the magic cookie
-	 *  is filled if debugging is enabled
-	 */
-	sg_init_table(scatterlist, num_pages);
-	/* Now set the pages for each scatterlist */
-	for (i = 0; i < num_pages; i++)	{
-		unsigned int len = PAGE_SIZE - offset;
-
-		if (len > count)
-			len = count;
-		sg_set_page(scatterlist + i, pages[i], len, offset);
-		offset = 0;
-		count -= len;
-	}
-
-	dma_buffers = dma_map_sg(instance->state->dev,
-				 scatterlist,
-				 num_pages,
-				 pagelistinfo->dma_dir);
-
-	if (dma_buffers == 0) {
-		cleanup_pagelistinfo(instance, pagelistinfo);
-		return NULL;
-	}
-
-	pagelistinfo->scatterlist_mapped = 1;
-
-	/* Combine adjacent blocks for performance */
-	k = 0;
-	for_each_sg(scatterlist, sg, dma_buffers, i) {
-		unsigned int len = sg_dma_len(sg);
-		dma_addr_t addr = sg_dma_address(sg);
-
-		/* Note: addrs is the address + page_count - 1
-		 * The firmware expects blocks after the first to be page-
-		 * aligned and a multiple of the page size
-		 */
-		WARN_ON(len == 0);
-		WARN_ON(i && (i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
-		WARN_ON(i && (addr & ~PAGE_MASK));
-		if (is_adjacent_block(addrs, addr, k))
-			addrs[k - 1] += ((len + PAGE_SIZE - 1) >> PAGE_SHIFT);
-		else
-			addrs[k++] = (addr & PAGE_MASK) |
-				(((len + PAGE_SIZE - 1) >> PAGE_SHIFT) - 1);
-	}
-
-	/* Partial cache lines (fragments) require special measures */
-	if ((type == PAGELIST_READ) &&
-	    ((pagelist->offset & (drv_mgmt->info->cache_line_size - 1)) ||
-	    ((pagelist->offset + pagelist->length) &
-	    (drv_mgmt->info->cache_line_size - 1)))) {
-		char *fragments;
-
-		if (down_interruptible(&drv_mgmt->free_fragments_sema)) {
-			cleanup_pagelistinfo(instance, pagelistinfo);
-			return NULL;
-		}
-
-		WARN_ON(!drv_mgmt->free_fragments);
-
-		down(&drv_mgmt->free_fragments_mutex);
-		fragments = drv_mgmt->free_fragments;
-		WARN_ON(!fragments);
-		drv_mgmt->free_fragments = *(char **)drv_mgmt->free_fragments;
-		up(&drv_mgmt->free_fragments_mutex);
-		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
-			(fragments - drv_mgmt->fragments_base) / drv_mgmt->fragments_size;
-	}
-
-	return pagelistinfo;
-}
-
-static void
-free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo,
-	      int actual)
-{
-	struct vchiq_drv_mgmt *drv_mgmt;
-	struct pagelist *pagelist = pagelistinfo->pagelist;
-	struct page **pages = pagelistinfo->pages;
-	unsigned int num_pages = pagelistinfo->num_pages;
-
-	dev_dbg(instance->state->dev, "arm: %pK, %d\n", pagelistinfo->pagelist, actual);
-
-	drv_mgmt = dev_get_drvdata(instance->state->dev);
-
-	/*
-	 * NOTE: dma_unmap_sg must be called before the
-	 * cpu can touch any of the data/pages.
-	 */
-	dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
-		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
-	pagelistinfo->scatterlist_mapped = 0;
-
-	/* Deal with any partial cache lines (fragments) */
-	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS && drv_mgmt->fragments_base) {
-		char *fragments = drv_mgmt->fragments_base +
-			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
-			drv_mgmt->fragments_size;
-		int head_bytes, tail_bytes;
-
-		head_bytes = (drv_mgmt->info->cache_line_size - pagelist->offset) &
-			(drv_mgmt->info->cache_line_size - 1);
-		tail_bytes = (pagelist->offset + actual) &
-			(drv_mgmt->info->cache_line_size - 1);
-
-		if ((actual >= 0) && (head_bytes != 0)) {
-			if (head_bytes > actual)
-				head_bytes = actual;
-
-			memcpy_to_page(pages[0],
-				pagelist->offset,
-				fragments,
-				head_bytes);
-		}
-		if ((actual >= 0) && (head_bytes < actual) &&
-		    (tail_bytes != 0))
-			memcpy_to_page(pages[num_pages - 1],
-				(pagelist->offset + actual) &
-				(PAGE_SIZE - 1) & ~(drv_mgmt->info->cache_line_size - 1),
-				fragments + drv_mgmt->info->cache_line_size,
-				tail_bytes);
-
-		down(&drv_mgmt->free_fragments_mutex);
-		*(char **)fragments = drv_mgmt->free_fragments;
-		drv_mgmt->free_fragments = fragments;
-		up(&drv_mgmt->free_fragments_mutex);
-		up(&drv_mgmt->free_fragments_sema);
-	}
-
-	/* Need to mark all the pages dirty. */
-	if (pagelist->type != PAGELIST_WRITE &&
-	    pagelistinfo->pages_need_release) {
-		unsigned int i;
-
-		for (i = 0; i < num_pages; i++)
-			set_page_dirty(pages[i]);
-	}
-
-	cleanup_pagelistinfo(instance, pagelistinfo);
-}
-
 static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 {
 	struct device *dev = &pdev->dev;
@@ -616,38 +310,7 @@ static struct vchiq_arm_state *vchiq_platform_get_arm_state(struct vchiq_state *
 }
 
 
-int
-vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
-			void __user *uoffset, int size, int dir)
-{
-	struct vchiq_pagelist_info *pagelistinfo;
-
-	pagelistinfo = create_pagelist(instance, offset, uoffset, size,
-				       (dir == VCHIQ_BULK_RECEIVE)
-				       ? PAGELIST_READ
-				       : PAGELIST_WRITE);
-
-	if (!pagelistinfo)
-		return -ENOMEM;
-
-	bulk->data = pagelistinfo->dma_addr;
-
-	/*
-	 * Store the pagelistinfo address in remote_data,
-	 * which isn't used by the slave.
-	 */
-	bulk->remote_data = pagelistinfo;
 
-	return 0;
-}
-
-void
-vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
-{
-	if (bulk && bulk->remote_data && bulk->actual)
-		free_pagelist(instance, (struct vchiq_pagelist_info *)bulk->remote_data,
-			      bulk->actual);
-}
 
 void vchiq_dump_platform_state(struct seq_file *f)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 88d510c6793a..586c41cd1ed5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/highmem.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
@@ -1437,6 +1438,329 @@ poll_services(struct vchiq_state *state)
 		poll_services_of_group(state, group);
 }
 
+static void
+cleanup_pagelistinfo(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo)
+{
+	if (pagelistinfo->scatterlist_mapped) {
+		dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
+			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	}
+
+	if (pagelistinfo->pages_need_release)
+		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
+
+	dma_free_coherent(instance->state->dev, pagelistinfo->pagelist_buffer_size,
+			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
+}
+
+static inline bool
+is_adjacent_block(u32 *addrs, dma_addr_t addr, unsigned int k)
+{
+	u32 tmp;
+
+	if (!k)
+		return false;
+
+	tmp = (addrs[k - 1] & PAGE_MASK) +
+	      (((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT);
+
+	return tmp == (addr & PAGE_MASK);
+}
+
+/* There is a potential problem with partial cache lines (pages?)
+ * at the ends of the block when reading. If the CPU accessed anything in
+ * the same line (page?) then it may have pulled old data into the cache,
+ * obscuring the new data underneath. We can solve this by transferring the
+ * partial cache lines separately, and allowing the ARM to copy into the
+ * cached area.
+ */
+static struct vchiq_pagelist_info *
+create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
+		size_t count, unsigned short type)
+{
+	struct vchiq_drv_mgmt *drv_mgmt;
+	struct pagelist *pagelist;
+	struct vchiq_pagelist_info *pagelistinfo;
+	struct page **pages;
+	u32 *addrs;
+	unsigned int num_pages, offset, i, k;
+	int actual_pages;
+	size_t pagelist_size;
+	struct scatterlist *scatterlist, *sg;
+	int dma_buffers;
+	dma_addr_t dma_addr;
+
+	if (count >= INT_MAX - PAGE_SIZE)
+		return NULL;
+
+	drv_mgmt = dev_get_drvdata(instance->state->dev);
+
+	if (buf)
+		offset = (uintptr_t)buf & (PAGE_SIZE - 1);
+	else
+		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
+	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
+
+	if ((size_t)num_pages > (SIZE_MAX - sizeof(struct pagelist) -
+			 sizeof(struct vchiq_pagelist_info)) /
+			(sizeof(u32) + sizeof(pages[0]) +
+			 sizeof(struct scatterlist)))
+		return NULL;
+
+	pagelist_size = sizeof(struct pagelist) +
+			(num_pages * sizeof(u32)) +
+			(num_pages * sizeof(pages[0]) +
+			(num_pages * sizeof(struct scatterlist))) +
+			sizeof(struct vchiq_pagelist_info);
+
+	/* Allocate enough storage to hold the page pointers and the page
+	 * list
+	 */
+	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size, &dma_addr,
+				      GFP_KERNEL);
+
+	dev_dbg(instance->state->dev, "arm: %pK\n", pagelist);
+
+	if (!pagelist)
+		return NULL;
+
+	addrs		= pagelist->addrs;
+	pages		= (struct page **)(addrs + num_pages);
+	scatterlist	= (struct scatterlist *)(pages + num_pages);
+	pagelistinfo	= (struct vchiq_pagelist_info *)
+			  (scatterlist + num_pages);
+
+	pagelist->length = count;
+	pagelist->type = type;
+	pagelist->offset = offset;
+
+	/* Populate the fields of the pagelistinfo structure */
+	pagelistinfo->pagelist = pagelist;
+	pagelistinfo->pagelist_buffer_size = pagelist_size;
+	pagelistinfo->dma_addr = dma_addr;
+	pagelistinfo->dma_dir =  (type == PAGELIST_WRITE) ?
+				  DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	pagelistinfo->num_pages = num_pages;
+	pagelistinfo->pages_need_release = 0;
+	pagelistinfo->pages = pages;
+	pagelistinfo->scatterlist = scatterlist;
+	pagelistinfo->scatterlist_mapped = 0;
+
+	if (buf) {
+		unsigned long length = count;
+		unsigned int off = offset;
+
+		for (actual_pages = 0; actual_pages < num_pages;
+		     actual_pages++) {
+			struct page *pg =
+				vmalloc_to_page((buf +
+						 (actual_pages * PAGE_SIZE)));
+			size_t bytes = PAGE_SIZE - off;
+
+			if (!pg) {
+				cleanup_pagelistinfo(instance, pagelistinfo);
+				return NULL;
+			}
+
+			if (bytes > length)
+				bytes = length;
+			pages[actual_pages] = pg;
+			length -= bytes;
+			off = 0;
+		}
+		/* do not try and release vmalloc pages */
+	} else {
+		actual_pages = pin_user_pages_fast((unsigned long)ubuf & PAGE_MASK, num_pages,
+						   type == PAGELIST_READ, pages);
+
+		if (actual_pages != num_pages) {
+			dev_dbg(instance->state->dev, "arm: Only %d/%d pages locked\n",
+				actual_pages, num_pages);
+
+			/* This is probably due to the process being killed */
+			if (actual_pages > 0)
+				unpin_user_pages(pages, actual_pages);
+			cleanup_pagelistinfo(instance, pagelistinfo);
+			return NULL;
+		}
+		 /* release user pages */
+		pagelistinfo->pages_need_release = 1;
+	}
+
+	/*
+	 * Initialize the scatterlist so that the magic cookie
+	 *  is filled if debugging is enabled
+	 */
+	sg_init_table(scatterlist, num_pages);
+	/* Now set the pages for each scatterlist */
+	for (i = 0; i < num_pages; i++)	{
+		unsigned int len = PAGE_SIZE - offset;
+
+		if (len > count)
+			len = count;
+		sg_set_page(scatterlist + i, pages[i], len, offset);
+		offset = 0;
+		count -= len;
+	}
+
+	dma_buffers = dma_map_sg(instance->state->dev,
+				 scatterlist,
+				 num_pages,
+				 pagelistinfo->dma_dir);
+
+	if (dma_buffers == 0) {
+		cleanup_pagelistinfo(instance, pagelistinfo);
+		return NULL;
+	}
+
+	pagelistinfo->scatterlist_mapped = 1;
+
+	/* Combine adjacent blocks for performance */
+	k = 0;
+	for_each_sg(scatterlist, sg, dma_buffers, i) {
+		unsigned int len = sg_dma_len(sg);
+		dma_addr_t addr = sg_dma_address(sg);
+
+		/* Note: addrs is the address + page_count - 1
+		 * The firmware expects blocks after the first to be page-
+		 * aligned and a multiple of the page size
+		 */
+		WARN_ON(len == 0);
+		WARN_ON(i && (i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
+		WARN_ON(i && (addr & ~PAGE_MASK));
+		if (is_adjacent_block(addrs, addr, k))
+			addrs[k - 1] += ((len + PAGE_SIZE - 1) >> PAGE_SHIFT);
+		else
+			addrs[k++] = (addr & PAGE_MASK) |
+				(((len + PAGE_SIZE - 1) >> PAGE_SHIFT) - 1);
+	}
+
+	/* Partial cache lines (fragments) require special measures */
+	if ((type == PAGELIST_READ) &&
+	    ((pagelist->offset & (drv_mgmt->info->cache_line_size - 1)) ||
+	    ((pagelist->offset + pagelist->length) &
+	    (drv_mgmt->info->cache_line_size - 1)))) {
+		char *fragments;
+
+		if (down_interruptible(&drv_mgmt->free_fragments_sema)) {
+			cleanup_pagelistinfo(instance, pagelistinfo);
+			return NULL;
+		}
+
+		WARN_ON(!drv_mgmt->free_fragments);
+
+		down(&drv_mgmt->free_fragments_mutex);
+		fragments = drv_mgmt->free_fragments;
+		WARN_ON(!fragments);
+		drv_mgmt->free_fragments = *(char **)drv_mgmt->free_fragments;
+		up(&drv_mgmt->free_fragments_mutex);
+		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
+			(fragments - drv_mgmt->fragments_base) / drv_mgmt->fragments_size;
+	}
+
+	return pagelistinfo;
+}
+
+static void
+free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo,
+	      int actual)
+{
+	struct vchiq_drv_mgmt *drv_mgmt;
+	struct pagelist *pagelist = pagelistinfo->pagelist;
+	struct page **pages = pagelistinfo->pages;
+	unsigned int num_pages = pagelistinfo->num_pages;
+
+	dev_dbg(instance->state->dev, "arm: %pK, %d\n", pagelistinfo->pagelist, actual);
+
+	drv_mgmt = dev_get_drvdata(instance->state->dev);
+
+	/*
+	 * NOTE: dma_unmap_sg must be called before the
+	 * cpu can touch any of the data/pages.
+	 */
+	dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
+		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	pagelistinfo->scatterlist_mapped = 0;
+
+	/* Deal with any partial cache lines (fragments) */
+	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS && drv_mgmt->fragments_base) {
+		char *fragments = drv_mgmt->fragments_base +
+			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
+			drv_mgmt->fragments_size;
+		int head_bytes, tail_bytes;
+
+		head_bytes = (drv_mgmt->info->cache_line_size - pagelist->offset) &
+			(drv_mgmt->info->cache_line_size - 1);
+		tail_bytes = (pagelist->offset + actual) &
+			(drv_mgmt->info->cache_line_size - 1);
+
+		if ((actual >= 0) && (head_bytes != 0)) {
+			if (head_bytes > actual)
+				head_bytes = actual;
+
+			memcpy_to_page(pages[0], pagelist->offset,
+				       fragments, head_bytes);
+		}
+		if ((actual >= 0) && (head_bytes < actual) &&
+		    (tail_bytes != 0))
+			memcpy_to_page(pages[num_pages - 1],
+				       (pagelist->offset + actual) &
+				       (PAGE_SIZE - 1) & ~(drv_mgmt->info->cache_line_size - 1),
+				       fragments + drv_mgmt->info->cache_line_size,
+				       tail_bytes);
+
+		down(&drv_mgmt->free_fragments_mutex);
+		*(char **)fragments = drv_mgmt->free_fragments;
+		drv_mgmt->free_fragments = fragments;
+		up(&drv_mgmt->free_fragments_mutex);
+		up(&drv_mgmt->free_fragments_sema);
+	}
+
+	/* Need to mark all the pages dirty. */
+	if (pagelist->type != PAGELIST_WRITE &&
+	    pagelistinfo->pages_need_release) {
+		unsigned int i;
+
+		for (i = 0; i < num_pages; i++)
+			set_page_dirty(pages[i]);
+	}
+
+	cleanup_pagelistinfo(instance, pagelistinfo);
+}
+
+static int
+vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
+			void __user *uoffset, int size, int dir)
+{
+	struct vchiq_pagelist_info *pagelistinfo;
+
+	pagelistinfo = create_pagelist(instance, offset, uoffset, size,
+				       (dir == VCHIQ_BULK_RECEIVE)
+				       ? PAGELIST_READ
+				       : PAGELIST_WRITE);
+
+	if (!pagelistinfo)
+		return -ENOMEM;
+
+	bulk->data = pagelistinfo->dma_addr;
+
+	/*
+	 * Store the pagelistinfo address in remote_data,
+	 * which isn't used by the slave.
+	 */
+	bulk->remote_data = pagelistinfo;
+
+	return 0;
+}
+
+static void
+vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
+{
+	if (bulk && bulk->remote_data && bulk->actual)
+		free_pagelist(instance, (struct vchiq_pagelist_info *)bulk->remote_data,
+			      bulk->actual);
+}
+
 /* Called with the bulk_mutex held */
 static void
 abort_outstanding_bulks(struct vchiq_service *service,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 32b0521aa036..6662dd21e827 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -6,6 +6,7 @@
 
 #include <linux/mutex.h>
 #include <linux/completion.h>
+#include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
 #include <linux/dev_printk.h>
 #include <linux/kthread.h>
@@ -16,6 +17,7 @@
 
 #include "../../include/linux/raspberrypi/vchiq.h"
 #include "vchiq_cfg.h"
+#include "vchiq_pagelist.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
@@ -409,6 +411,18 @@ struct vchiq_state {
 	struct opaque_platform_state *platform_state;
 };
 
+struct vchiq_pagelist_info {
+	struct pagelist *pagelist;
+	size_t pagelist_buffer_size;
+	dma_addr_t dma_addr;
+	enum dma_data_direction dma_dir;
+	unsigned int num_pages;
+	unsigned int pages_need_release;
+	struct page **pages;
+	struct scatterlist *scatterlist;
+	unsigned int scatterlist_mapped;
+};
+
 static inline bool vchiq_remote_initialised(const struct vchiq_state *state)
 {
 	return state->remote && state->remote->initialised;
@@ -529,11 +543,6 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    void *context,
 		    size_t size);
 
-int vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
-			    void __user *uoffset, int size, int dir);
-
-void vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk);
-
 void vchiq_dump_platform_state(struct seq_file *f);
 
 void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f);
-- 
2.45.2


