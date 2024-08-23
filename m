Return-Path: <linux-kernel+bounces-299171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBF95D127
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1141A1C23C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1D18990B;
	Fri, 23 Aug 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PNa/mNj4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7B188A0C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426075; cv=none; b=OD8bbruBAXnbDJZM7EucR6OGk8BdfPrwLipQVIHkVha9KyQVUcHILkKUWK7O4FAJ43cHOXXFf/W21xIxqoPGlCjVsDokr1EVMy3wlxQH5aoToNkj+GS1w6hVb6XuwakqsdbKpeFpsvv8+ITPkVjCgqDHwDEEnrlOa2kCT9mo3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426075; c=relaxed/simple;
	bh=lURN2Re3Pjar6uAHMjExDR15wOW/qxPvOtr4hCvgpHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YI/Cu80tlNr7eT0XCgcxLSm+tRTDMk1hyWkeMHjFrVyQ9iZ767Z6tNw+WHaELH3TBhQY1D3Z5alTGUa4TLzHA4SVCba1aA+fi5/hE6ueOOdUPChE+UH+JK31q4GlMifXl1DNY84smNlTQ9D2jQAlSwYLMmSyVwdzwgvB1PTXoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PNa/mNj4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.29.25] (unknown [IPv6:2405:201:2015:f873:55f8:639e:8e9f:12ec])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8C0D497;
	Fri, 23 Aug 2024 17:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724426005;
	bh=lURN2Re3Pjar6uAHMjExDR15wOW/qxPvOtr4hCvgpHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PNa/mNj4peNITg3P7LuLq6O1n4h5y68fAMSt/Ik92XPLPKC1VKo1CQ6cp5NhlhUZM
	 Ng4Nma8J0Li0Ao7AcguHI9BAjcpEGWfgaNMHP/13V0y1qyuLtzdsm+UoV3LdhUrjQG
	 60tfrYtfasIkM3O2tTF6Lke1EICldwJcWex/yzTY=
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Fri, 23 Aug 2024 20:44:21 +0530
Subject: [PATCH 1/7] staging: vchiq: Factor out bulk transfer for
 VCHIQ_BULK_MODE_WAITING
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-to_sent2-v1-1-8bc182a0adaf@ideasonboard.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724426064; l=5484;
 i=umang.jain@ideasonboard.com; s=20240731; h=from:subject:message-id;
 bh=lURN2Re3Pjar6uAHMjExDR15wOW/qxPvOtr4hCvgpHY=;
 b=PVc43o8YsWerRejIwWUGZrs1ub2HQy6TeG+vzSK4AK5+as4GCS+M+9+1M1EwHd+yhkTeSrG/r
 otaLN4epa5NAuNqzRmtckTlRtKoYMWugj1ZAnkJ+5X0TPerlDKE6+v3
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=7pvnIBNsDpFUMiph0Vlhrr01+rAn5fSIn/QtDeLeXL0=

The bulk transfer is VCHIQ_BULK_MODE_WAITING is used by VCHIQ ioctl
interface. It is factored out to a separate function from
vchiq_bulk_transfer() to bulk_xfer_waiting_interruptible().

This is a part of vchiq_bulk_transfer refactoring. Each bulk mode
will have their dedicated functions to execute bulk transfers.
Each mode will be handled separately in subsequent patches.

bulk_xfer_waiting_interruptible() is suffixed with "_interruptible"
to denote that it can be interrupted when a signal is received.
-EAGAIN maybe returned in those cases, similar to what
vchiq_bulk_transfer() does.

Adjust the vchiq_irq_queue_bulk_tx_rx() in the vchiq-dev.c to call
bulk_xfer_waiting_interruptible() for waiting mode. A temporary
goto label has been introduced to jump the call execution over
vchiq_bulk_transfer() for waiting mode only. When all dedicated bulk
transfer calls are introduced, this label shall be dropped.

No function changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 52 +++++++++++++++++++---
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  4 ++
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  5 +++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 50af04b217f4..228a41ecf90c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3023,10 +3023,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 		bulk_waiter->actual = 0;
 		bulk_waiter->bulk = NULL;
 		break;
-	case VCHIQ_BULK_MODE_WAITING:
-		bulk_waiter = userdata;
-		bulk = bulk_waiter->bulk;
-		goto waiting;
 	default:
 		goto error_exit;
 	}
@@ -3115,7 +3111,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 		state->id, service->localport, dir_char, queue->local_insert,
 		queue->remote_insert, queue->process);
 
-waiting:
 	vchiq_service_put(service);
 
 	status = 0;
@@ -3143,6 +3138,53 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	return status;
 }
 
+/*
+ * This function is called by VCHIQ ioctl interface and is interruptible.
+ * It may receive -EAGAIN to indicate that a signal has been received
+ * and the call should be retried after being returned to user context.
+ */
+int
+bulk_xfer_waiting_interruptible(struct vchiq_instance *instance, unsigned int handle,
+				void *userdata)
+{
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
+	struct bulk_waiter *bulk_waiter = NULL;
+	struct vchiq_bulk *bulk;
+	int status = -EINVAL;
+
+	if (!service)
+		goto error_exit;
+
+	if (!userdata)
+		goto error_exit;
+
+	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
+		goto error_exit;
+
+	if (vchiq_check_service(service))
+		goto error_exit;
+
+	bulk_waiter = userdata;
+	bulk = bulk_waiter->bulk;
+
+	vchiq_service_put(service);
+
+	status = 0;
+
+	bulk_waiter->bulk = bulk;
+	if (wait_for_completion_interruptible(&bulk_waiter->event))
+		status = -EAGAIN;
+	else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
+		status = -EINVAL;
+
+	return status;
+
+error_exit:
+	if (service)
+		vchiq_service_put(service);
+	return status;
+}
+
 int
 vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 77cc4d7ac077..1fda8631d1b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -470,6 +470,10 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 extern void
 remote_event_pollall(struct vchiq_state *state);
 
+extern int
+bulk_xfer_waiting_interruptible(struct vchiq_instance *instance, unsigned int handle,
+				void *userdata);
+
 extern int
 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
 		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 9cd2a64dce5e..445b7938eea3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -324,6 +324,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\n",
 			waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
+
+		status = bulk_xfer_waiting_interruptible(instance, args->handle, userdata);
+
+		goto bulk_transfer_handled;
 	} else {
 		userdata = args->userdata;
 	}
@@ -331,6 +335,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 	status = vchiq_bulk_transfer(instance, args->handle, NULL, args->data, args->size,
 				     userdata, args->mode, dir);
 
+bulk_transfer_handled:
 	if (!waiter) {
 		ret = 0;
 		goto out;

-- 
2.45.0


