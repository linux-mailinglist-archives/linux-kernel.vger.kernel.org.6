Return-Path: <linux-kernel+bounces-318333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C496EBE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF1B1C2117C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F4156220;
	Fri,  6 Sep 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e0qlwt6B"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A161552FA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607536; cv=none; b=YSUmy1uVRyZ+wa1JeZ2x9kg7ZaWxlLh2hg+yjyDXVNZk2Rg4OsMRfj6hCVHwjPzPlUUhnMg3lHZSVspQqAWRscHQswXaVvg3Jhm/+9zM04bKSuv4ic5fb76GX2T/ll9FxaYGlR21uwv5DdcgGdu46zhKqPip/7h/nJf/TU5RrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607536; c=relaxed/simple;
	bh=fwAv4gWavn/DhUiGDl2Pp1u7HvhXFCrXOPNkBJAD7yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1upSUCI4uLmS2ZngXNXTHMuv61/JirRWICu6fFtGbngeROkz0LuKIcuQCWi9leUcwXBy+SWfyJqFGR2nVCsmooHQcA2lc03eTt9nBS8kwG/8fSo3nR23D6giVjdWASuyJxPBR+LtJr0igUY5N1TH6WFj/6rrldraZYNhSVKGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e0qlwt6B; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:c173:4b:4a04:3a21])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0CF7A157F;
	Fri,  6 Sep 2024 09:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725607458;
	bh=fwAv4gWavn/DhUiGDl2Pp1u7HvhXFCrXOPNkBJAD7yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0qlwt6Bzp8ho/E7NisrBxR0FZfBOCLGRDegmCXJg1AmqVWmhSmrhXYJVzkz0Jrwc
	 gWwMc/NanoRacohK4Y64lxMguhpR0yLBQi48s0QsezeUGn7hB2Nxh1rUnHenLh2sAR
	 SeiqxAWiv0cs1f3bcKcvG0zF5CRooo+d1d74dzG8=
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
Subject: [PATCH v4 5/7] staging: vchiq_core: Drop vchiq_bulk_transfer()
Date: Fri,  6 Sep 2024 12:55:04 +0530
Message-ID: <20240906072506.174026-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072506.174026-1-umang.jain@ideasonboard.com>
References: <20240906072506.174026-1-umang.jain@ideasonboard.com>
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
 .../interface/vchiq_arm/vchiq_core.c          | 60 -------------------
 .../interface/vchiq_arm/vchiq_core.h          |  5 --
 .../interface/vchiq_arm/vchiq_dev.c           |  8 ---
 3 files changed, 73 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 573dad5c7893..9b0009d1906e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3055,66 +3055,6 @@ vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned
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
-	struct bulk_waiter *bulk_waiter = NULL;
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
-	if (bulk_waiter) {
-		bulk_waiter->bulk = bulk;
-		if (wait_for_completion_interruptible(&bulk_waiter->event))
-			status = -EAGAIN;
-		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
-			status = -EINVAL;
-	}
-
-	return 0;
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


