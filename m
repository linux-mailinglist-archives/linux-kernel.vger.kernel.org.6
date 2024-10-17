Return-Path: <linux-kernel+bounces-369889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8AE9A2412
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1A1C254D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C251DE4C9;
	Thu, 17 Oct 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jeVauZPE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158571DE3AC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172221; cv=none; b=SbO0MP/fKJIkiBrm4WbDuyFdn5J1o8IT2AzN4/i0CP1awR/1EtAHZuiij88l9iKuXxlMEjydySM9MDJVvTUNMJKdmB7arUNG322DqZFBtDZn5U/dAq+a7N1TlQgJ7x0vI0KD/QvnMeDXfoBEXC4B5PIdIEfLJjBmLyQIdR3jJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172221; c=relaxed/simple;
	bh=EqLwRX+3J2XHSyc5StHZnS7+pkIcemBGni0Mlp9KqUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5YYph8mZJEk4r7JMwgDPf5tYJyiOjG4bxTemc3waQbjYYAhjFFPVMfjAvhMGh0JPt45F9xby3fGZO+/X0V9X32vePpuQWHYgG7gIHRtUaNPj2N1C3+xVDdDkg41MNAkIkpkIdpcmh39/wSH1LUOEd535CRJasOCmH9fcfU8RV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jeVauZPE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 363641014;
	Thu, 17 Oct 2024 15:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729172105;
	bh=EqLwRX+3J2XHSyc5StHZnS7+pkIcemBGni0Mlp9KqUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeVauZPE3eVeXIH3E0eI+TpcpsbCnzB72b+bMD5lG3s8JKvW+NFxFD7NOb6CvqCZj
	 YkVm14DFh6GBWwD/oCRc90N+tVzXn6gWCMUoSEfY5UiEgrkB/rE2wwNQy1dqNgS0Tv
	 ZcizDZSdluNmSidsz4BtIIBNPeOC5HAMk6rt7zPw=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	kernel-list@raspberrypi.com,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/6] staging: vchiq_core: Simplify bulk data preparatory functions
Date: Thu, 17 Oct 2024 19:06:25 +0530
Message-ID: <20241017133629.216672-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017133629.216672-1-umang.jain@ideasonboard.com>
References: <20241017133629.216672-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two functions create_pagelist() and vchiq_prepare_bulk_data()
open code bulk data arguments ('size' and 'dir') in their function
signatures which can easily be obtained by struct vchiq_bulk pointer.

Retrieve the arguments from vchiq_bulk pointer instead and reduce
the number of arguments passed in create_pagelist() and
vchiq_bulk_prepare_data().

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c             | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7c6f09a9d917..62356a165696 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1482,8 +1482,7 @@ is_adjacent_block(u32 *addrs, dma_addr_t addr, unsigned int k)
  * cached area.
  */
 static struct vchiq_pagelist_info *
-create_pagelist(struct vchiq_instance *instance, struct vchiq_bulk *bulk,
-		size_t count, unsigned short type)
+create_pagelist(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
 {
 	struct vchiq_drv_mgmt *drv_mgmt;
 	struct pagelist *pagelist;
@@ -1497,6 +1496,9 @@ create_pagelist(struct vchiq_instance *instance, struct vchiq_bulk *bulk,
 	int dma_buffers;
 	unsigned int cache_line_size;
 	dma_addr_t dma_addr;
+	size_t count = bulk->size;
+	unsigned short type = (bulk->dir == VCHIQ_BULK_RECEIVE)
+			      ? PAGELIST_READ : PAGELIST_WRITE;
 
 	if (count >= INT_MAX - PAGE_SIZE)
 		return NULL;
@@ -1740,15 +1742,11 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 }
 
 static int
-vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk,
-			int size, int dir)
+vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
 {
 	struct vchiq_pagelist_info *pagelistinfo;
 
-	pagelistinfo = create_pagelist(instance, bulk, size,
-				       (dir == VCHIQ_BULK_RECEIVE)
-				       ? PAGELIST_READ
-				       : PAGELIST_WRITE);
+	pagelistinfo = create_pagelist(instance, bulk);
 
 	if (!pagelistinfo)
 		return -ENOMEM;
@@ -3074,7 +3072,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	bulk->offset = offset;
 	bulk->uoffset = uoffset;
 
-	if (vchiq_prepare_bulk_data(service->instance, bulk, size, dir))
+	if (vchiq_prepare_bulk_data(service->instance, bulk))
 		goto unlock_error_exit;
 
 	/*
-- 
2.45.2


