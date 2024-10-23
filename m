Return-Path: <linux-kernel+bounces-377910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE949AC87A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCD21C2170A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139E1AAE02;
	Wed, 23 Oct 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RCL5i2Uz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52631AA786
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681491; cv=none; b=Ch8vqyuos6B7Fe5XheIfA7lF7EG5hRSAADqk/PBF9Wjnyqet13leIGTWRM/TN8DMuKNmPmM3vTMS5fMoGzKbeSWC0Cjwto4vHagamHIX/1MpLH3eINVjDyH7JdBkr6rYozogaQgQfMAU567CsU9cKUuXfvFln91j8xc6h0rYDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681491; c=relaxed/simple;
	bh=KIi8RtAK5zM28t9+jkOUOwbYGCTOpFii6+tjL4MbcHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J327dliCYF9eHNvIIuyL/QxQLAM+N2ll+cxtl5ENHQUiF8nRoslzkARcr9TZcaqaaMpPVC8vJvrJxgDATDy4bcTkULYC9goeFabDdOHyglPXhHnJAMXrkbzowNVupVzH3B4bhqen7pB/Om33VKUBsmV+s4zqTFy6fpAeewe3xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RCL5i2Uz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5BE9B9FC;
	Wed, 23 Oct 2024 13:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681381;
	bh=KIi8RtAK5zM28t9+jkOUOwbYGCTOpFii6+tjL4MbcHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCL5i2Uz8D/eOOwy4TGq7fbYtc9RXpNDFGzJJoc/cli0rzE1drvTTVf+0ItLuRJ76
	 RhttYQVRFn0IS2bfBqqvcHdc4kCp6ctwRWP/N9jWZnUhw4kOOjZJ8SLwiWeuLc57bY
	 6VKr/l/qCShXZoALwzZ+t3otaMsY70sXP7N5EB1A=
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
Subject: [PATCH 2/6] staging: vchiq_core: Bulk waiter should not piggy back on bulk userdata
Date: Wed, 23 Oct 2024 16:34:02 +0530
Message-ID: <20241023110406.885199-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023110406.885199-1-umang.jain@ideasonboard.com>
References: <20241023110406.885199-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, struct bulk_waiter is allocated for VCHIQ_BULK_MODE_BLOCKING
bulk transfer and its pointer is assigned to vchiq_bulk->userdata. Avoid
this kind of piggybacking and introduce a dedicate 'waiter' member in
struct vchiq_bulk.

The 'userdata' is meant for VCHIQ_BULK_MODE_CALLBACK mode, to pass user
specified parameter to the actual callback function.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c     |  6 +++---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c    | 11 ++++++-----
 .../vc04_services/interface/vchiq_arm/vchiq_core.h    |  1 +
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c     |  4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f23d98a1b960..ff627b297bc4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -594,7 +594,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 				 * Cancel the signal when the transfer completes.
 				 */
 				spin_lock(&service->state->bulk_waiter_spinlock);
-				bulk->userdata = NULL;
+				bulk->waiter = NULL;
 				spin_unlock(&service->state->bulk_waiter_spinlock);
 			}
 		}
@@ -604,7 +604,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 			return -ENOMEM;
 	}
 
-	bulk_params->userdata = &waiter->bulk_waiter;
+	bulk_params->waiter = &waiter->bulk_waiter;
 
 	ret = vchiq_bulk_xfer_blocking(instance, handle, bulk_params);
 	if ((ret != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
@@ -613,7 +613,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		if (bulk) {
 			/* Cancel the signal when the transfer completes. */
 			spin_lock(&service->state->bulk_waiter_spinlock);
-			bulk->userdata = NULL;
+			bulk->waiter = NULL;
 			spin_unlock(&service->state->bulk_waiter_spinlock);
 		}
 		kfree(waiter);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 90ab780b7e94..5e52f8954be7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1330,7 +1330,7 @@ static int service_notify_bulk(struct vchiq_service *service,
 		struct bulk_waiter *waiter;
 
 		spin_lock(&service->state->bulk_waiter_spinlock);
-		waiter = bulk->userdata;
+		waiter = bulk->waiter;
 		if (waiter) {
 			waiter->actual = bulk->actual;
 			complete(&waiter->event);
@@ -3035,7 +3035,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	int payload[2];
 
 	if (bulk_params->mode == VCHIQ_BULK_MODE_BLOCKING) {
-		bulk_waiter = bulk_params->userdata;
+		bulk_waiter = bulk_params->waiter;
 		init_completion(&bulk_waiter->event);
 		bulk_waiter->actual = 0;
 		bulk_waiter->bulk = NULL;
@@ -3064,6 +3064,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	/* Initiliaze the 'bulk' slot with bulk parameters passed in. */
 	bulk->mode = bulk_params->mode;
 	bulk->dir = bulk_params->dir;
+	bulk->waiter = bulk_params->waiter;
 	bulk->userdata = bulk_params->userdata;
 	bulk->size = bulk_params->size;
 	bulk->offset = bulk_params->offset;
@@ -3533,7 +3534,7 @@ vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
  */
 int
 vchiq_bulk_xfer_waiting(struct vchiq_instance *instance,
-			unsigned int handle, struct bulk_waiter *userdata)
+			unsigned int handle, struct bulk_waiter *waiter)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct bulk_waiter *bulk_waiter;
@@ -3542,7 +3543,7 @@ vchiq_bulk_xfer_waiting(struct vchiq_instance *instance,
 	if (!service)
 		return -EINVAL;
 
-	if (!userdata)
+	if (!waiter)
 		goto error_exit;
 
 	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
@@ -3551,7 +3552,7 @@ vchiq_bulk_xfer_waiting(struct vchiq_instance *instance,
 	if (vchiq_check_service(service))
 		goto error_exit;
 
-	bulk_waiter = userdata;
+	bulk_waiter = waiter;
 
 	vchiq_service_put(service);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 9ba4a2295dc3..88766c9180a9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -115,6 +115,7 @@ struct vchiq_bulk {
 	short mode;
 	short dir;
 	void *userdata;
+	struct bulk_waiter *waiter;
 	dma_addr_t dma_addr;
 	int size;
 	void *remote_data;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 6a9685d9fafc..3d2827446f53 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -307,7 +307,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		bulk_params.mode = args->mode;
 		bulk_params.size = args->size;
 		bulk_params.dir = dir;
-		bulk_params.userdata = &waiter->bulk_waiter;
+		bulk_params.waiter = &waiter->bulk_waiter;
 
 		status = vchiq_bulk_xfer_blocking(instance, args->handle,
 						  &bulk_params);
@@ -354,7 +354,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		if (waiter->bulk_waiter.bulk) {
 			/* Cancel the signal when the transfer completes. */
 			spin_lock(&service->state->bulk_waiter_spinlock);
-			waiter->bulk_waiter.bulk->userdata = NULL;
+			waiter->bulk_waiter.bulk->waiter = NULL;
 			spin_unlock(&service->state->bulk_waiter_spinlock);
 		}
 		kfree(waiter);
-- 
2.45.2


