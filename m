Return-Path: <linux-kernel+bounces-299175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3C95D12E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901791F235F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC518BC04;
	Fri, 23 Aug 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GkEVJanB"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F518BBAB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426082; cv=none; b=RnaC599UPts8RfRwMIWl+Vg4/kR198fdeLlxu5SHlJ+pqGuHsvgxt+ahGBOfdYy71yOzJkTj3Udhp/5b76Y7hOJW83gAoMIXtUTcfuOke3nsbPcfg6HRZEO3hnEUHOC9bVkgjYng8SHVy1AfEYlRbirGyl57V+PC4EMvZUKqqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426082; c=relaxed/simple;
	bh=kkR6c42KOoPB7oIjiPbRTYTeAakudszPtaPz4h9QZMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSqxTsrHnUzcznefcDe6GXJvdG1SbUEgfMWDlhirUN0HIv+4qrHTbjZnuGLVnII8zvTQ4sI/dqqH+wG3UCo0feYIxDgXWBg6V22MSoTwj/VyLxmFZzWGKOJGuN8awTqJtLQ6pPujlDdom4wyh7nIocyOZx5CaKnODyQ4QadU5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GkEVJanB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.29.25] (unknown [IPv6:2405:201:2015:f873:55f8:639e:8e9f:12ec])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F3D95497;
	Fri, 23 Aug 2024 17:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724426016;
	bh=kkR6c42KOoPB7oIjiPbRTYTeAakudszPtaPz4h9QZMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GkEVJanBEtyoAqgH4lff8Li4e/4Iuf2G/cg/Oojcs7HGrbBxz1jCTLBBIjCBD2R+u
	 YucN5DZ+Fx4ssVX9XgOPsMw6gJUO1qKNdZPz/3eohPx9c3/s3zQy3Flfgk0W9/BIFU
	 STyGhLIx1ZlEwb7YjuGUU89EFL1+g1AVveND/+4o=
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Fri, 23 Aug 2024 20:44:25 +0530
Subject: [PATCH 5/7] staging: vchiq_core: Drop vchiq_bulk_transfer()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-to_sent2-v1-5-8bc182a0adaf@ideasonboard.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
In-Reply-To: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724426064; l=5111;
 i=umang.jain@ideasonboard.com; s=20240731; h=from:subject:message-id;
 bh=kkR6c42KOoPB7oIjiPbRTYTeAakudszPtaPz4h9QZMA=;
 b=m9rlD3OyL2xW+iDkMlADVprKCcUn1atnOBoc5HidcmlEYl9huJkAY6myRnLjcomWi0MqblWOW
 GEtte3Cq3tnDGQigl0UYSo/5u7o9rIIwadb564/N337gLSLaIQD5lDR
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=7pvnIBNsDpFUMiph0Vlhrr01+rAn5fSIn/QtDeLeXL0=

Drop vchiq_bulk_transfer() as every VCHIQ_BULK_MODE_* mode
now have their own dedicated functions to execute bulk transfers.

Also, drop the temporary label we introduced earlier in vchiq-dev.c
to jump over the vchiq_bulk_transfer() call when each separate mode
helper was being developed.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 62 ----------------------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  5 --
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  | 10 ----
 3 files changed, 77 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 0606561fd3d0..43c6a214be86 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3067,68 +3067,6 @@ bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int h
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
index 8aaf3c9d3dbe..be85a15df9a7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -485,11 +485,6 @@ bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int h
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
index 7ecfcaa85569..4d8432158259 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -308,8 +308,6 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		status = bulk_xfer_blocking_interruptible(instance, args->handle,
 							  NULL, args->data, args->size,
 							  userdata, dir);
-
-		goto bulk_transfer_handled;
 	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_for_each_entry(iter, &instance->bulk_waiter_list,
@@ -332,22 +330,14 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		userdata = &waiter->bulk_waiter;
 
 		status = bulk_xfer_waiting_interruptible(instance, args->handle, userdata);
-
-		goto bulk_transfer_handled;
 	} else {
 		userdata = args->userdata;
 
 		status = bulk_xfer_callback_interruptible(instance, args->handle,
 							  NULL, args->data, args->size,
 							  args->mode, userdata, dir);
-
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
2.45.0


