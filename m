Return-Path: <linux-kernel+bounces-369890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BB9A2413
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4FD1C2572D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E51DE4DF;
	Thu, 17 Oct 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wlel4X1+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF051DE3B0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172223; cv=none; b=WAZFXtf2V6W2vK+N2FRzJh3oUp/WhIYiVh559tl09DZkK63/Z35RMmmxSUJDLGeehhX8YG/1gPUayusJ5vfc8g6u58R7eogQlOXHtpX7Jr4HKfd0AnCmbSNSTsA6Ez96o7jWbDy3HpFopOqLXn2yBY4OFLysd0aImuyQ/klsSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172223; c=relaxed/simple;
	bh=TL6ZIgNYIKhO2ZRFDwsreyN+JUnPagCHOgWraaahB/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRK68LNmjI3RkS/JZasvLZO/KJiM/aR6aCtRolAK1HihQ1m6WuflyNZU6gWRLsCAke//xVJb9sMwJZDAwSFa3XJ/xDoIiPM/AEmLXW52KIzGZ3gAvZFlejFXF1qLSQ2PDhf8oXIeRZyInvi/q8heMoHZf2ZPpTS9M5LXMB810DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wlel4X1+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EC6FFF1;
	Thu, 17 Oct 2024 15:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729172107;
	bh=TL6ZIgNYIKhO2ZRFDwsreyN+JUnPagCHOgWraaahB/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wlel4X1+RK/6mX1msusJlIhm8u66RAg5v0vasnIZC2rml/JhCCct09VJ7cEEIpcs4
	 7BU9fFiI0qsuG7KTwt0gmWzmCbPKSqyk9TaCLLsHVAI51wrKc9Z74JQ0X73BnwQ8Pw
	 QPYCTx9K//mfBAgpkuiDxkHb5a9KPVOTWm+4MtEw=
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
Subject: [PATCH 3/6] staging: vc04_services: Simplify block bulk transfer code paths
Date: Thu, 17 Oct 2024 19:06:26 +0530
Message-ID: <20241017133629.216672-4-umang.jain@ideasonboard.com>
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

Blocking bulk transfer functions tend to open-code every function
parameter needed to initiate the bulk transfer. Instead of doing
that, simply pass a populated struct vchiq_bulk down the function
chain.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 34 +++++++++++++------
 .../interface/vchiq_arm/vchiq_core.c          | 12 +++----
 .../interface/vchiq_arm/vchiq_core.h          |  3 +-
 .../interface/vchiq_arm/vchiq_dev.c           | 11 +++---
 4 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index af623ad87c15..90b5ce5ee429 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -107,8 +107,8 @@ struct vchiq_arm_state {
 };
 
 static int
-vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
-			     unsigned int size, enum vchiq_bulk_dir dir);
+vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
+			     struct vchiq_bulk *bulk_params);
 
 static irqreturn_t
 vchiq_doorbell_irq(int irq, void *dev_id)
@@ -491,6 +491,7 @@ int
 vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const void *data,
 		    unsigned int size, void *userdata, enum vchiq_bulk_mode mode)
 {
+	struct vchiq_bulk bulk_params = {};
 	int ret;
 
 	switch (mode) {
@@ -501,8 +502,12 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 					       VCHIQ_BULK_TRANSMIT);
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
-		ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
-						   VCHIQ_BULK_TRANSMIT);
+		bulk_params.offset = (void *)data;
+		bulk_params.mode = mode;
+		bulk_params.size = size;
+		bulk_params.dir = VCHIQ_BULK_TRANSMIT;
+
+		ret = vchiq_blocking_bulk_transfer(instance, handle, &bulk_params);
 		break;
 	default:
 		return -EINVAL;
@@ -516,6 +521,7 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		       void *data, unsigned int size, void *userdata,
 		       enum vchiq_bulk_mode mode)
 {
+	struct vchiq_bulk bulk_params = {};
 	int ret;
 
 	switch (mode) {
@@ -525,8 +531,12 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 					       size, mode, userdata, VCHIQ_BULK_RECEIVE);
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
-		ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
-						   VCHIQ_BULK_RECEIVE);
+		bulk_params.offset = (void *)data;
+		bulk_params.mode = mode;
+		bulk_params.size = size;
+		bulk_params.dir = VCHIQ_BULK_RECEIVE;
+
+		ret = vchiq_blocking_bulk_transfer(instance, handle, &bulk_params);
 		break;
 	default:
 		return -EINVAL;
@@ -537,8 +547,8 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 EXPORT_SYMBOL(vchiq_bulk_receive);
 
 static int
-vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
-			     unsigned int size, enum vchiq_bulk_dir dir)
+vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
+			     struct vchiq_bulk *bulk_params)
 {
 	struct vchiq_service *service;
 	struct bulk_waiter_node *waiter = NULL, *iter;
@@ -566,7 +576,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		if (bulk) {
 			/* This thread has an outstanding bulk transfer. */
 			/* FIXME: why compare a dma address to a pointer? */
-			if ((bulk->data != (dma_addr_t)(uintptr_t)data) || (bulk->size != size)) {
+			if ((bulk->data != (dma_addr_t)(uintptr_t)bulk_params->data) ||
+			    (bulk->size != bulk_params->size)) {
 				/*
 				 * This is not a retry of the previous one.
 				 * Cancel the signal when the transfer completes.
@@ -582,8 +593,9 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 			return -ENOMEM;
 	}
 
-	ret = vchiq_bulk_xfer_blocking(instance, handle, data, NULL, size,
-				       &waiter->bulk_waiter, dir);
+	bulk_params->userdata = &waiter->bulk_waiter;
+
+	ret = vchiq_bulk_xfer_blocking(instance, handle, bulk_params);
 	if ((ret != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 62356a165696..6c52827868d5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3471,11 +3471,9 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 
 int
 vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
-			 void *offset, void __user *uoffset, int size,
-			 void __user *userdata, enum vchiq_bulk_dir dir)
+			 struct vchiq_bulk *bulk_params)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	enum vchiq_bulk_mode mode = VCHIQ_BULK_MODE_BLOCKING;
 	int status = -EINVAL;
 
 	if (!service)
@@ -3484,15 +3482,17 @@ vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
 	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
 		goto error_exit;
 
-	if (!offset && !uoffset)
+	if (!bulk_params->offset && !bulk_params->uoffset)
 		goto error_exit;
 
 	if (vchiq_check_service(service))
 		goto error_exit;
 
 
-	status = vchiq_bulk_xfer_queue_msg_killable(service, offset, uoffset, size,
-						    userdata, mode, dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params->offset,
+						    bulk_params->uoffset, bulk_params->size,
+						    bulk_params->userdata, bulk_params->mode,
+						    bulk_params->dir);
 
 error_exit:
 	vchiq_service_put(service);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 05ef0666c2b3..82d27788b10b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -501,8 +501,7 @@ vchiq_bulk_xfer_waiting(struct vchiq_instance *instance, unsigned int handle,
 
 extern int
 vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
-			 void *offset, void __user *uoffset, int size,
-			 void __user *userdata, enum vchiq_bulk_dir dir);
+			 struct vchiq_bulk *bulk);
 
 extern int
 vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index aca237919696..8043974f8893 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -288,6 +288,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 {
 	struct vchiq_service *service;
 	struct bulk_waiter_node *waiter = NULL, *iter;
+	struct vchiq_bulk bulk_params = {};
 	void *userdata;
 	int status = 0;
 	int ret;
@@ -303,12 +304,14 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 			goto out;
 		}
 
-		userdata = &waiter->bulk_waiter;
+		bulk_params.uoffset = args->data;
+		bulk_params.mode = args->mode;
+		bulk_params.size = args->size;
+		bulk_params.dir = dir;
+		bulk_params.userdata = &waiter->bulk_waiter;
 
 		status = vchiq_bulk_xfer_blocking(instance, args->handle,
-						  NULL, args->data, args->size,
-						  userdata, dir);
-
+						  &bulk_params);
 	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_for_each_entry(iter, &instance->bulk_waiter_list,
-- 
2.45.2


