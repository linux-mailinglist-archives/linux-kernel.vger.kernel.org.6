Return-Path: <linux-kernel+bounces-309981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179329672AC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA171F22629
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989561802A8;
	Sat, 31 Aug 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cq+6KcTv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFD17E00A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121500; cv=none; b=X5lZICpW4CrUNOhAbifncFSUOwKDodTrtEFLJYHomOi6fnikfdTUBsZLleurYdELZG1MnwDKQFyFtM29T7kmKzVH26k5ccmACO4AK4x+EYCf+lWi/vc294RDbTufplV53QAxzWn2Vix/0VWF5cYxSWzmoGV4LRWQMSlEPl2C1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121500; c=relaxed/simple;
	bh=Q+KAL4DZhSyT3LL8Dykd2bNg6qoCySCNL/Bs864YG/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhMdEWXRqrO/IqA9kMxeSkSZ7IQmYBoZ/dad8CjRJ0tSrG2HbtPN7l1yNvet0HoniLI4unEQ/vnv/1enB52MYo9YN696tXR/NDFLrWT+dRXjMAXXh/A1t6K+Uaf4xFDc/SmOpV9WmJ4AQTLDDIjgJbzJXaH+pyHTv/rhPKl3oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Cq+6KcTv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 061E48BE;
	Sat, 31 Aug 2024 18:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121428;
	bh=Q+KAL4DZhSyT3LL8Dykd2bNg6qoCySCNL/Bs864YG/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cq+6KcTvsHFFKMXZVskuDcBscsrlBTK6jx/MpWihHC12nOafQCA/c5s7tV4DFnH30
	 VkL4HuPIoNLRsmjRJmJdxs2s6KmRIihKf3XohQrRemJoj00EaRulYSdyLl07JlYHiJ
	 Q98Aq7HsjLibbsDiXYmXKPnoQEeRFmaa2Dzu20JM=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 5/7] staging: vchiq_core: Drop vchiq_bulk_transfer()
Date: Sat, 31 Aug 2024 21:54:33 +0530
Message-ID: <20240831162435.191084-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240831162435.191084-1-umang.jain@ideasonboard.com>
References: <20240831162435.191084-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop vchiq_bulk_transfer() as every VCHIQ_BULK_MODE_* mode
now have their own dedicated functions to execute bulk transfers.

Also, drop the temporary label we introduced earlier in vchiq-dev.c
to jump over the vchiq_bulk_transfer() call when each separate mode
helper was being developed.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 62 -------------------
 .../interface/vchiq_arm/vchiq_core.h          |  5 --
 .../interface/vchiq_arm/vchiq_dev.c           |  8 ---
 3 files changed, 75 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 51fe18499e87..f333d1747917 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3061,68 +3061,6 @@ vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned
 	return status;
 }
 
-/*
- * This function may be called by kernel threads or user threads.
- * User threads may receive -EAGAIN to indicate that a signal has been
- * received and the call should be retried after being returned to user
- * context.
- * When called in blocking mode, the userdata field points to a bulk_waiter
- * structure.
- */
-int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
-			void *offset, void __user *uoffset, int size, void *userdata,
-			enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
-{
-	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	struct bulk_waiter *bulk_waiter;
-	struct vchiq_bulk *bulk;
-	int status = -EINVAL;
-
-	if (!service)
-		goto error_exit;
-
-	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
-		goto error_exit;
-
-	if (!offset && !uoffset)
-		goto error_exit;
-
-	if (vchiq_check_service(service))
-		goto error_exit;
-
-	switch (mode) {
-	case VCHIQ_BULK_MODE_NOCALLBACK:
-	case VCHIQ_BULK_MODE_CALLBACK:
-		break;
-	default:
-		goto error_exit;
-	}
-
-	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset,
-							 size, userdata, mode, dir);
-	if (status)
-		goto error_exit;
-
-	vchiq_service_put(service);
-
-	status = 0;
-
-	if (bulk_waiter) {
-		bulk_waiter->bulk = bulk;
-		if (wait_for_completion_interruptible(&bulk_waiter->event))
-			status = -EAGAIN;
-		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
-			status = -EINVAL;
-	}
-
-	return status;
-
-error_exit:
-	if (service)
-		vchiq_service_put(service);
-	return status;
-}
-
 /*
  * This function is called by VCHIQ ioctl interface and is interruptible.
  * It may receive -EAGAIN to indicate that a signal has been received
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 9c8c076eaaeb..468463f31801 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -485,11 +485,6 @@ vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned
 				       enum vchiq_bulk_mode mode, void *userdata,
 				       enum vchiq_bulk_dir dir);
 
-extern int
-vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
-		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
-		    enum vchiq_bulk_dir dir);
-
 extern void
 vchiq_dump_state(struct seq_file *f, struct vchiq_state *state);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 169a2ffda996..d41a4624cc92 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -309,7 +309,6 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 								NULL, args->data, args->size,
 								userdata, dir);
 
-		goto bulk_transfer_handled;
 	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_for_each_entry(iter, &instance->bulk_waiter_list,
@@ -332,8 +331,6 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		userdata = &waiter->bulk_waiter;
 
 		status = vchiq_bulk_xfer_waiting_interruptible(instance, args->handle, userdata);
-
-		goto bulk_transfer_handled;
 	} else {
 		userdata = args->userdata;
 
@@ -341,13 +338,8 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 								args->data, args->size,
 								args->mode, userdata, dir);
 
-		goto bulk_transfer_handled;
 	}
 
-	status = vchiq_bulk_transfer(instance, args->handle, NULL, args->data, args->size,
-				     userdata, args->mode, dir);
-
-bulk_transfer_handled:
 	if (!waiter) {
 		ret = 0;
 		goto out;
-- 
2.45.2


