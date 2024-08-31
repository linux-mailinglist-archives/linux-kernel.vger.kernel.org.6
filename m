Return-Path: <linux-kernel+bounces-309977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF949672A8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102EF1C2118E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148C14A600;
	Sat, 31 Aug 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jbom1DEa"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB65589C
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121490; cv=none; b=kZVl7tAw37GQ7ImMh+RMoi02obLESZ3PJhsF3my2nhKaAO1sRvCwsdbjj8+MFh8Tk4cNL/u4uSqlpzEPbs7zuud8uTSyhTkjYt6hCK9CsQljYnTINYHn8CLC8SvvvvPrg7VExIewQY+yWw3OZ5BN1skT7kzg/bfr/hbR6FBzlmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121490; c=relaxed/simple;
	bh=xXkimMuFA0YNhZ5TcXuLxQNc7lP3YrQ3XbZNqYWDnN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXreWBDr6EfQ0yt4CTA8ioA2OLMFb2jYmyAV7TRQLbAeeNvvuEDHnsvvku1i+3CmAHpqFDqQtv05ZQhsq4IpFhutSRb5BjMtFCPUXEYFhJmtMCQT9EE5sKxFjPfW3yGlv4pu6ODqkcho0LTOD8NQ7bPDvonvd0iRO0h3Ye4l03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jbom1DEa; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8FA287FE;
	Sat, 31 Aug 2024 18:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121416;
	bh=xXkimMuFA0YNhZ5TcXuLxQNc7lP3YrQ3XbZNqYWDnN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbom1DEaLxTkQnQOErVdm88L80GxkvX7XG6vAah4xWlotD8uwPoCgIiPN7dcE5Reu
	 LsC3V418fX47ME39WQBGRPZSfqdWsA+D+2i6SouAS8hXwAOF/97qhVy19gEfbN53Xc
	 DsA23hJaHCXtAVmYLkENDwVSpBVQ1hzpFNI2ONPM=
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
Subject: [PATCH v2 1/7] staging: vchiq: Factor out bulk transfer for VCHIQ_BULK_MODE_WAITING
Date: Sat, 31 Aug 2024 21:54:29 +0530
Message-ID: <20240831162435.191084-2-umang.jain@ideasonboard.com>
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
 .../interface/vchiq_arm/vchiq_core.c          | 51 +++++++++++++++++--
 .../interface/vchiq_arm/vchiq_core.h          |  4 ++
 .../interface/vchiq_arm/vchiq_dev.c           |  5 ++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 50af04b217f4..7db76e309d3f 100644
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
@@ -3143,6 +3138,52 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	return status;
 }
 
+/*
+ * This function is called by VCHIQ ioctl interface and is interruptible.
+ * It may receive -EAGAIN to indicate that a signal has been received
+ * and the call should be retried after being returned to user context.
+ */
+int
+vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
+				      unsigned int handle, struct bulk_waiter *userdata)
+{
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
+	struct bulk_waiter *bulk_waiter;
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
+	if (wait_for_completion_interruptible(&bulk_waiter->event))
+		return -EAGAIN;
+	else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
+		return -EINVAL;
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
index 77cc4d7ac077..985d9ea3a06a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -470,6 +470,10 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 extern void
 remote_event_pollall(struct vchiq_state *state);
 
+extern int
+vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
+				      unsigned int handle, struct bulk_waiter *userdata);
+
 extern int
 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
 		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 9cd2a64dce5e..550838d2863b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -324,6 +324,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\n",
 			waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
+
+		status = vchiq_bulk_xfer_waiting_interruptible(instance, args->handle, userdata);
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
2.45.2


