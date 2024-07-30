Return-Path: <linux-kernel+bounces-267945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B1941CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406C1289684
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6118E044;
	Tue, 30 Jul 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GO3ovaGd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432718991F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359334; cv=none; b=JnGRiwWX11wCzilN77GyjJ/8eDR3L5D8skAQvi8ZGvjWQxp5s4Oj4zkrJKGAJZbIsFTR5XgodSHTHEMSwUfwIpF3J/LZInBkdlvIWhgl1nDCy+wBuqMlNYAlZC/99k2kxU+UhDvKqRTQy4DLF9a4Q3X9bgnuwpq0AoT/olg74vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359334; c=relaxed/simple;
	bh=yx4rqUWItmn1vyFdwqB5nWkzZYpgxj1l70D0RG6zTY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+4vwt6mhHJx4tDWNNpTPE3OwGEWnTMK5YggapH58BUnmAa4dpH/pznieXkVurmVl7by8pn7sOpUjrn0myll+lSwhc4Id1nFmGJo5A2eZ+TgGJmhaF53+S7R6SU+eBM41w4fkoBWv/f25YDjw3IX4VNGcd/Vkl6krmGC6a7vMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GO3ovaGd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from ATX.abc.com (unknown [IPv6:2405:201:2015:f873:55f8:639e:8e9f:12ec])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7BB8E268;
	Tue, 30 Jul 2024 19:07:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722359282;
	bh=yx4rqUWItmn1vyFdwqB5nWkzZYpgxj1l70D0RG6zTY4=;
	h=From:To:Cc:Subject:Date:From;
	b=GO3ovaGdLSlkICMAqQseF2C5FUab8cTvzoEa4hfJY2Py83O5w9KDQFmFULol9qxRT
	 Os8I/VHM83NX2vNqa39N0OBYavScLG34Qud+Fnt2RT7SIaSOAGb3Fj8YVb2upsF5aH
	 VCTYZBTM6el1B4hpHWjfez53W4fC8sy3v0wl5cAo=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-staging@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH] staging: vchiq: Avoid mixing bulk_userdata kernel and userspace pointer
Date: Tue, 30 Jul 2024 22:38:40 +0530
Message-ID: <20240730170840.1603752-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vchiq_dev.c, there are two places where the __user bulk_userdata
pointer to set to a kernel-space pointer which then gives relevant
Sparse warnings as below:

vchiq_dev.c:328:26: warning: incorrect type in assignment (different address spaces)
vchiq_dev.c:328:26:    expected void *[assigned] userdata
vchiq_dev.c:328:26:    got void [noderef] __user *userdata
vchiq_dev.c:543:47: warning: incorrect type in assignment (different address spaces)
vchiq_dev.c:543:47:    expected void [noderef] __user *[addressable] [assigned] bulk_userdata
vchiq_dev.c:543:47:    got void *bulk_userdata

This is solved by adding additional functional argument to track the
userspace bulk_userdata separately and passing it accordingly to
completion handlers.

This patch is inspired by commit
1c954540c0eb ("staging: vchiq: avoid mixing kernel and user pointers").

There are no Sparse warnings left to be fixed in vc04_services,
hence drop the relevant TODO entry as well.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  3 ++-
 .../include/linux/raspberrypi/vchiq.h         |  7 +++--
 drivers/staging/vc04_services/interface/TODO  |  4 ---
 .../interface/vchiq_arm/vchiq_arm.c           | 26 +++++++++++--------
 .../interface/vchiq_arm/vchiq_arm.h           |  3 ++-
 .../interface/vchiq_arm/vchiq_core.c          | 21 ++++++++-------
 .../interface/vchiq_arm/vchiq_core.h          |  5 ++--
 .../interface/vchiq_arm/vchiq_dev.c           | 10 ++-----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  2 +-
 9 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 133ed15f3dbc..c44f3d5cca70 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -96,7 +96,8 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 static int audio_vchi_callback(struct vchiq_instance *vchiq_instance,
 			       enum vchiq_reason reason,
 			       struct vchiq_header *header,
-			       unsigned int handle, void *userdata)
+			       unsigned int handle, void *userdata,
+			       void __user *uuserdata)
 {
 	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(vchiq_instance,
 									     handle);
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 6c40d8c1dde6..c777952dd9d9 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -56,7 +56,8 @@ struct vchiq_service_base {
 			enum vchiq_reason reason,
 			struct vchiq_header *header,
 			unsigned int handle,
-			void *bulk_userdata);
+			void *bulk_userdata,
+			void __user *ubulk_userdata);
 	void *userdata;
 };
 
@@ -65,6 +66,7 @@ struct vchiq_completion_data_kernel {
 	struct vchiq_header *header;
 	void *service_userdata;
 	void *bulk_userdata;
+	void __user *ubulk_userdata;
 };
 
 struct vchiq_service_params_kernel {
@@ -73,7 +75,8 @@ struct vchiq_service_params_kernel {
 			enum vchiq_reason reason,
 			struct vchiq_header *header,
 			unsigned int handle,
-			void *bulk_userdata);
+			void *bulk_userdata,
+			void __user *ubulk_userdata);
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
index c4d97dbf6ba8..fae939f35642 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -859,7 +859,7 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 		case VCHIQ_BULK_MODE_CALLBACK:
 			ret = vchiq_bulk_transfer(instance, handle,
 						  (void *)data, NULL,
-						  size, userdata, mode,
+						  size, userdata, NULL, mode,
 						  VCHIQ_BULK_TRANSMIT);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
@@ -896,7 +896,7 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		case VCHIQ_BULK_MODE_NOCALLBACK:
 		case VCHIQ_BULK_MODE_CALLBACK:
 			ret = vchiq_bulk_transfer(instance, handle, data, NULL,
-						  size, userdata,
+						  size, userdata, NULL,
 						  mode, VCHIQ_BULK_RECEIVE);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
@@ -969,7 +969,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	}
 
 	ret = vchiq_bulk_transfer(instance, handle, data, NULL, size,
-				  &waiter->bulk_waiter,
+				  &waiter->bulk_waiter, NULL,
 				  VCHIQ_BULK_MODE_BLOCKING, dir);
 	if ((ret != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
@@ -996,7 +996,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 static int
 add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	       struct vchiq_header *header, struct user_service *user_service,
-	       void *bulk_userdata)
+	       void *bulk_userdata, void __user *ubulk_userdata)
 {
 	struct vchiq_completion_data_kernel *completion;
 	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(instance->state->dev);
@@ -1027,6 +1027,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	/* N.B. service_userdata is updated while processing AWAIT_COMPLETION */
 	completion->service_userdata = user_service->service;
 	completion->bulk_userdata = bulk_userdata;
+	completion->ubulk_userdata = ubulk_userdata;
 
 	if (reason == VCHIQ_SERVICE_CLOSED) {
 		/*
@@ -1058,7 +1059,8 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 static int
 service_single_message(struct vchiq_instance *instance,
 		       enum vchiq_reason reason,
-		       struct vchiq_service *service, void *bulk_userdata)
+		       struct vchiq_service *service,
+		       void *bulk_userdata, void __user *ubulk_userdata)
 {
 	struct user_service *user_service;
 
@@ -1076,7 +1078,7 @@ service_single_message(struct vchiq_instance *instance,
 		dev_dbg(instance->state->dev,
 			"arm: Inserting extra MESSAGE_AVAILABLE\n");
 		ret = add_completion(instance, reason, NULL, user_service,
-				     bulk_userdata);
+				     bulk_userdata, ubulk_userdata);
 		if (ret)
 			return ret;
 	}
@@ -1094,7 +1096,8 @@ service_single_message(struct vchiq_instance *instance,
 
 int
 service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
-		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata)
+		 struct vchiq_header *header, unsigned int handle,
+		 void *bulk_userdata, void __user *ubulk_userdata)
 {
 	/*
 	 * How do we ensure the callback goes to the right client?
@@ -1147,8 +1150,8 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
 
-			ret = service_single_message(instance, reason,
-						     service, bulk_userdata);
+			ret = service_single_message(instance, reason, service,
+						     bulk_userdata, ubulk_userdata);
 			if (ret) {
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
@@ -1186,7 +1189,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 		return 0;
 
 	return add_completion(instance, reason, header, user_service,
-		bulk_userdata);
+		bulk_userdata, ubulk_userdata);
 }
 
 void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f)
@@ -1273,7 +1276,8 @@ static int
 vchiq_keepalive_vchiq_callback(struct vchiq_instance *instance,
 			       enum vchiq_reason reason,
 			       struct vchiq_header *header,
-			       unsigned int service_user, void *bulk_user)
+			       unsigned int service_user,
+			       void *bulk_userdata, void __user *ubulk_userdata)
 {
 	dev_err(instance->state->dev, "suspend: %s: callback reason %d\n",
 		__func__, reason);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index b402aac333d9..43c73e986779 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -155,7 +155,8 @@ static inline int vchiq_register_chrdev(struct device *parent) { return 0; }
 
 extern int
 service_callback(struct vchiq_instance *vchiq_instance, enum vchiq_reason reason,
-		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata);
+		 struct vchiq_header *header, unsigned int handle,
+		 void *bulk_userdata, void __user *ubulk_userdata);
 
 extern void
 free_bulk_waiter(struct vchiq_instance *instance);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 50af04b217f4..b24a27a46074 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -449,7 +449,8 @@ mark_service_closing(struct vchiq_service *service)
 
 static inline int
 make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
-		      struct vchiq_header *header, void *bulk_userdata)
+		      struct vchiq_header *header,
+		      void *bulk_userdata, void __user *ubulk_userdata)
 {
 	int status;
 
@@ -457,7 +458,7 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		service->state->id, service->localport, reason_names[reason],
 		header, bulk_userdata);
 	status = service->base.callback(service->instance, reason, header, service->handle,
-					bulk_userdata);
+					bulk_userdata, ubulk_userdata);
 	if (status && (status != -EAGAIN)) {
 		dev_warn(service->state->dev,
 			 "core: %d: ignoring ERROR from callback to service %x\n",
@@ -1339,7 +1340,7 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 				enum vchiq_reason reason =
 						get_bulk_reason(bulk);
 				status = make_service_callback(service, reason,	NULL,
-							       bulk->userdata);
+							       bulk->userdata, bulk->uuserdata);
 				if (status == -EAGAIN)
 					break;
 			}
@@ -1689,7 +1690,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			claim_slot(state->rx_info);
 			DEBUG_TRACE(PARSE_LINE);
 			if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-						  NULL) == -EAGAIN) {
+						  NULL, NULL) == -EAGAIN) {
 				DEBUG_TRACE(PARSE_LINE);
 				goto bail_not_ready;
 			}
@@ -2072,7 +2073,7 @@ sync_func(void *v)
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
 				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-							  NULL) == -EAGAIN)
+							  NULL, NULL) == -EAGAIN)
 					dev_err(state->dev,
 						"sync: error: synchronous callback to service %d returns -EAGAIN\n",
 						localport);
@@ -2624,7 +2625,7 @@ close_service_complete(struct vchiq_service *service, int failstate)
 		return -EINVAL;
 	}
 
-	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL);
+	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL, NULL);
 
 	if (status != -EAGAIN) {
 		int uc = service->service_use_count;
@@ -2987,7 +2988,8 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
  * structure.
  */
 int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
-			void *offset, void __user *uoffset, int size, void *userdata,
+			void *offset, void __user *uoffset, int size,
+			void *userdata, void __user *uuserdata,
 			enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
@@ -3062,6 +3064,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	bulk->mode = mode;
 	bulk->dir = dir;
 	bulk->userdata = userdata;
+	bulk->uuserdata = uuserdata;
 	bulk->size = size;
 	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
 
@@ -3074,9 +3077,9 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	 */
 	wmb();
 
-	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
+	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK %p\n",
 		state->id, service->localport, service->remoteport,
-		dir_char, size, &bulk->data, userdata);
+		dir_char, size, &bulk->data, userdata, uuserdata);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 77cc4d7ac077..6d915aeeae7f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -114,6 +114,7 @@ struct vchiq_bulk {
 	short mode;
 	short dir;
 	void *userdata;
+	void __user *uuserdata;
 	dma_addr_t data;
 	int size;
 	void *remote_data;
@@ -472,8 +473,8 @@ remote_event_pollall(struct vchiq_state *state);
 
 extern int
 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
-		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
-		    enum vchiq_bulk_dir dir);
+		    void __user *uoffset, int size, void *userdata, void __user *uuserdata,
+		    enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir);
 
 extern void
 vchiq_dump_state(struct seq_file *f, struct vchiq_state *state);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 9cd2a64dce5e..3bb45342e89e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -324,12 +324,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\n",
 			waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
-	} else {
-		userdata = args->userdata;
 	}
 
 	status = vchiq_bulk_transfer(instance, args->handle, NULL, args->data, args->size,
-				     userdata, args->mode, dir);
+				     userdata, args->userdata, args->mode, dir);
 
 	if (!waiter) {
 		ret = 0;
@@ -536,11 +534,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 		    !instance->use_close_delivered)
 			vchiq_service_put(service);
 
-		/*
-		 * FIXME: address space mismatch, does bulk_userdata
-		 * actually point to user or kernel memory?
-		 */
-		user_completion.bulk_userdata = completion->bulk_userdata;
+		user_completion.bulk_userdata = completion->ubulk_userdata;
 
 		if (vchiq_put_completion(args->buf, &user_completion, ret)) {
 			if (ret == 0)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 67489c334f7b..24777e570ad5 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -551,7 +551,7 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 /* incoming event service callback */
 static int mmal_service_callback(struct vchiq_instance *vchiq_instance,
 				 enum vchiq_reason reason, struct vchiq_header *header,
-				 unsigned int handle, void *bulk_ctx)
+				 unsigned int handle, void *bulk_ctx, void __user *bulk_uctx)
 {
 	struct vchiq_mmal_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
 	u32 msg_len;
-- 
2.45.0


