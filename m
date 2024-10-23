Return-Path: <linux-kernel+bounces-377914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B86FB9AC880
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F98AB242A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C31A7AF7;
	Wed, 23 Oct 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D3eG7eOr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF831ABEAC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681500; cv=none; b=J17+rK26Rc1UAZ8Qz/wM7M4VNXxXzFgh8/KMe2dkXgiADIFd0Tqa/4zfJ0aeGRlVa6tINf/sShcSoghQv9NrbUOs6bFjE+X7Fk8qcASLj977NpuNxwk6BFDbU9LcFthIyyhMwFHAp7V8r7bwWAoTvC9t9U1etD/mxzKsooY/39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681500; c=relaxed/simple;
	bh=TNPi62Wih43ydCcvW6KjvjYGbgJFkkVc209bi8iV4bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opf/DQmWW8BQ9VUKddXNarX23YeO2Ni6fCsGOKBoGPBAO6IAgW4a7R2WVJrn4oFrxzWJBh8WSf2rZ2mUdK/PmPcfwHxtG2HeauhxswX5zw60MWYqc8isnrnTOZrS/WOvII1Htz7XaY3k0Yi2M+VK1TZ0KTEj4gYtZ8iZ7H4kGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=D3eG7eOr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3ED4182A;
	Wed, 23 Oct 2024 13:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681390;
	bh=TNPi62Wih43ydCcvW6KjvjYGbgJFkkVc209bi8iV4bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3eG7eOrokVhIeflPyOcA676N9RRGceTdo4hQw3cm1tji4TqxUD9ZFdKkvnvidNn2
	 5CV/bEZIdL9QjEl1VmKv1UGkjw1tHcoJmF+MLp3mQUIy91nQyNHF3a7dZsMJAahC1i
	 o+EyWUNNzwaEc5/qoIsLOdLQG3IjyJeZ2nYYSxnY=
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
Subject: [PATCH 6/6] staging: vchiq_arm: Track bulk user data pointer separately
Date: Wed, 23 Oct 2024 16:34:06 +0530
Message-ID: <20241023110406.885199-7-umang.jain@ideasonboard.com>
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

A bulk callback transfer can be initiated from two places -
inside kernel interface or from user interface. However,
the callback data pointer 'cb_data' is used for tracking both
sets of data pointer. This commit tracks the callback
data pointer from user interface (named as 'cb_userdata') separately,
in the bulk transfer service callback.

This is esentially done by adding a 'void __user *cb_userdata' for
tracking __user pointers in vchiq_bulk and vchiq_completion_data
structs. Furthermore, the 'cb_userdata' data pointer is appended to
the vchiq_service's callback signature.

Separating the two callback data pointers ('cb_data' and 'cb_userdata')
fixes the sparse warnings around mixing userspace and kernel space
pointers.

As there are no additional sparse warnings left for vc04_services,
drop the relevant entry from the TODO.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  3 ++-
 .../include/linux/raspberrypi/vchiq.h         |  5 ++--
 drivers/staging/vc04_services/interface/TODO  |  4 ---
 .../interface/vchiq_arm/vchiq_arm.c           | 27 ++++++++++---------
 .../interface/vchiq_arm/vchiq_arm.h           |  3 ++-
 .../interface/vchiq_arm/vchiq_core.c          | 14 ++++++----
 .../interface/vchiq_arm/vchiq_core.h          |  1 +
 .../interface/vchiq_arm/vchiq_dev.c           |  8 ++----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  7 ++---
 9 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 133ed15f3dbc..dc0d715ed970 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -96,7 +96,8 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 static int audio_vchi_callback(struct vchiq_instance *vchiq_instance,
 			       enum vchiq_reason reason,
 			       struct vchiq_header *header,
-			       unsigned int handle, void *userdata)
+			       unsigned int handle,
+			       void *cb_data, void __user *cb_userdata)
 {
 	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(vchiq_instance,
 									     handle);
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 9a6ab006bed2..ee4469f4fc51 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -56,7 +56,7 @@ struct vchiq_service_base {
 			enum vchiq_reason reason,
 			struct vchiq_header *header,
 			unsigned int handle,
-			void *bulk_userdata);
+			void *cb_data, void __user *cb_userdata);
 	void *userdata;
 };
 
@@ -65,6 +65,7 @@ struct vchiq_completion_data_kernel {
 	struct vchiq_header *header;
 	void *service_userdata;
 	void *cb_data;
+	void  __user *cb_userdata;
 };
 
 struct vchiq_service_params_kernel {
@@ -73,7 +74,7 @@ struct vchiq_service_params_kernel {
 			enum vchiq_reason reason,
 			struct vchiq_header *header,
 			unsigned int handle,
-			void *cb_data);
+			void *cb_data, void __user *cb_userdata);
 	void *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index dfb1ee49633f..2ae75362421b 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -27,10 +27,6 @@ The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
 indentation deep making it very unpleasant to read. This is specially relevant
 in the character driver ioctl code and in the core thread functions.
 
-* Clean up Sparse warnings from __user annotations. See
-vchiq_irq_queue_bulk_tx_rx(). Ensure that the address of "&waiter->bulk_waiter"
-is never disclosed to userspace.
-
 * Fix behavior of message handling
 
 The polling behavior of vchiq_bulk_transmit(), vchiq_bulk_receive() and
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index bcfd4ccc8373..505ab32e071c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -632,7 +632,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 static int
 add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	       struct vchiq_header *header, struct user_service *user_service,
-	       void *bulk_userdata)
+	       void *cb_data, void __user *cb_userdata)
 {
 	struct vchiq_completion_data_kernel *completion;
 	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(instance->state->dev);
@@ -662,7 +662,8 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	completion->reason = reason;
 	/* N.B. service_userdata is updated while processing AWAIT_COMPLETION */
 	completion->service_userdata = user_service->service;
-	completion->cb_data = bulk_userdata;
+	completion->cb_data = cb_data;
+	completion->cb_userdata = cb_userdata;
 
 	if (reason == VCHIQ_SERVICE_CLOSED) {
 		/*
@@ -693,8 +694,8 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 
 static int
 service_single_message(struct vchiq_instance *instance,
-		       enum vchiq_reason reason,
-		       struct vchiq_service *service, void *bulk_userdata)
+		       enum vchiq_reason reason, struct vchiq_service *service,
+		       void *cb_data, void __user *cb_userdata)
 {
 	struct user_service *user_service;
 
@@ -712,7 +713,7 @@ service_single_message(struct vchiq_instance *instance,
 		dev_dbg(instance->state->dev,
 			"arm: Inserting extra MESSAGE_AVAILABLE\n");
 		ret = add_completion(instance, reason, NULL, user_service,
-				     bulk_userdata);
+				     cb_data, cb_userdata);
 		if (ret)
 			return ret;
 	}
@@ -730,7 +731,8 @@ service_single_message(struct vchiq_instance *instance,
 
 int
 service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
-		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata)
+		 struct vchiq_header *header, unsigned int handle,
+		 void *cb_data, void __user *cb_userdata)
 {
 	/*
 	 * How do we ensure the callback goes to the right client?
@@ -769,9 +771,9 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 	rcu_read_unlock();
 
 	dev_dbg(service->state->dev,
-		"arm: service %p(%d,%p), reason %d, header %p, instance %p, bulk_userdata %p\n",
+		"arm: service %p(%d,%p), reason %d, header %p, instance %p, cb_data %p, cb_userdata %p\n",
 		user_service, service->localport, user_service->userdata,
-		reason, header, instance, bulk_userdata);
+		reason, header, instance, cb_data, cb_userdata);
 
 	if (header && user_service->is_vchi) {
 		spin_lock(&service->state->msg_queue_spinlock);
@@ -783,8 +785,8 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
 
-			ret = service_single_message(instance, reason,
-						     service, bulk_userdata);
+			ret = service_single_message(instance, reason, service,
+						     cb_data, cb_userdata);
 			if (ret) {
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
@@ -822,7 +824,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 		return 0;
 
 	return add_completion(instance, reason, header, user_service,
-		bulk_userdata);
+			      cb_data, cb_userdata);
 }
 
 void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f)
@@ -909,7 +911,8 @@ static int
 vchiq_keepalive_vchiq_callback(struct vchiq_instance *instance,
 			       enum vchiq_reason reason,
 			       struct vchiq_header *header,
-			       unsigned int service_user, void *bulk_user)
+			       unsigned int service_user,
+			       void *cb_data, void __user *cb_userdata)
 {
 	dev_err(instance->state->dev, "suspend: %s: callback reason %d\n",
 		__func__, reason);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index b402aac333d9..e32b02f99024 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -155,7 +155,8 @@ static inline int vchiq_register_chrdev(struct device *parent) { return 0; }
 
 extern int
 service_callback(struct vchiq_instance *vchiq_instance, enum vchiq_reason reason,
-		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata);
+		 struct vchiq_header *header, unsigned int handle,
+		 void *cb_data, void __user *cb_userdata);
 
 extern void
 free_bulk_waiter(struct vchiq_instance *instance);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 3c811b8f210c..064c22fa31c9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -458,20 +458,23 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		      struct vchiq_header *header, struct vchiq_bulk *bulk)
 {
 	void *cb_data = NULL;
+	void __user *cb_userdata = NULL;
 	int status;
 
 	/*
-	 * If a bulk transfer is in progress, pass bulk->cb_data to the
+	 * If a bulk transfer is in progress, pass bulk->cb_*data to the
 	 * callback function.
 	 */
-	if (bulk)
+	if (bulk) {
 		cb_data = bulk->cb_data;
+		cb_userdata = bulk->cb_userdata;
+	}
 
-	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %pK, %pK)\n",
+	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %pK, %pK %pK)\n",
 		service->state->id, service->localport, reason_names[reason],
-		header, cb_data);
+		header, cb_data, cb_userdata);
 	status = service->base.callback(service->instance, reason, header, service->handle,
-					cb_data);
+					cb_data, cb_userdata);
 	if (status && (status != -EAGAIN)) {
 		dev_warn(service->state->dev,
 			 "core: %d: ignoring ERROR from callback to service %x\n",
@@ -3073,6 +3076,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	bulk->dir = bulk_params->dir;
 	bulk->waiter = bulk_params->waiter;
 	bulk->cb_data = bulk_params->cb_data;
+	bulk->cb_userdata = bulk_params->cb_userdata;
 	bulk->size = bulk_params->size;
 	bulk->offset = bulk_params->offset;
 	bulk->uoffset = bulk_params->uoffset;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index f9a2268ad47e..fadca7b1b196 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -115,6 +115,7 @@ struct vchiq_bulk {
 	short mode;
 	short dir;
 	void *cb_data;
+	void __user *cb_userdata;
 	struct bulk_waiter *waiter;
 	dma_addr_t dma_addr;
 	int size;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index fcdf97391fb6..454f43416503 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -338,7 +338,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		bulk_params.mode = args->mode;
 		bulk_params.size = args->size;
 		bulk_params.dir = dir;
-		bulk_params.cb_data = args->userdata;
+		bulk_params.cb_userdata = args->userdata;
 
 		status = vchiq_bulk_xfer_callback(instance, args->handle,
 						  &bulk_params);
@@ -549,11 +549,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 		    !instance->use_close_delivered)
 			vchiq_service_put(service);
 
-		/*
-		 * FIXME: address space mismatch, does cb_data
-		 * actually point to user or kernel memory?
-		 */
-		user_completion.cb_userdata = completion->cb_data;
+		user_completion.cb_userdata = completion->cb_userdata;
 
 		if (vchiq_put_completion(args->buf, &user_completion, ret)) {
 			if (ret == 0)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 67489c334f7b..3fe482bd2793 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -551,7 +551,8 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 /* incoming event service callback */
 static int mmal_service_callback(struct vchiq_instance *vchiq_instance,
 				 enum vchiq_reason reason, struct vchiq_header *header,
-				 unsigned int handle, void *bulk_ctx)
+				 unsigned int handle, void *cb_data,
+				 void __user *cb_userdata)
 {
 	struct vchiq_mmal_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
 	u32 msg_len;
@@ -626,11 +627,11 @@ static int mmal_service_callback(struct vchiq_instance *vchiq_instance,
 		break;
 
 	case VCHIQ_BULK_RECEIVE_DONE:
-		bulk_receive_cb(instance, bulk_ctx);
+		bulk_receive_cb(instance, cb_data);
 		break;
 
 	case VCHIQ_BULK_RECEIVE_ABORTED:
-		bulk_abort_cb(instance, bulk_ctx);
+		bulk_abort_cb(instance, cb_data);
 		break;
 
 	case VCHIQ_SERVICE_CLOSED:
-- 
2.45.2


