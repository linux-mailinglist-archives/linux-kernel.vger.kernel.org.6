Return-Path: <linux-kernel+bounces-332810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B497BF23
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BE7283366
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1431C9866;
	Wed, 18 Sep 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AI6IzqsT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195F1474D8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677103; cv=none; b=O8mM1Io1pTFLXoSMXeCdFoSQErZJyn+auyfuqrYLaQ8Hnd9ZPP7u+maEDBx5ZeOd7VpckCospzBAmLK0YOmNuJNo+a5J1EVYA+czLIJWNAq7/4VKAIbsZsYl7jx5jyMS7sLKvCjPKHdSX88GXnBFUonjjfYLqJoNKed4pPm80Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677103; c=relaxed/simple;
	bh=fr72GNiWGGMkBaBJOsubgeHDmrGDhVY9fNs4q1znF1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dra+TedHRXaV7ntSLGIxcdoFIt902hAc4MHftN4jFDjIGNR0NFgZWhB/fnapNicRv41EJUiSRdN2As9V+hSUzut5FWtT/gpkRxpqKRjoQSJbYVpbukJtMMPjr14DacxYFm31Gb07zKSE7Je+6LLSNMwJA3mLDGhstFLK/TZOuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AI6IzqsT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AB052C6;
	Wed, 18 Sep 2024 18:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726677011;
	bh=fr72GNiWGGMkBaBJOsubgeHDmrGDhVY9fNs4q1znF1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AI6IzqsT89qkaqhmtL3Op4ayghGkft3bX+EGOklLgOPcZFFQXND03SO6lsMfzZi3u
	 1A/FsF2wS/Ctk42VbDxzpFCD9vSW1WlkT1EgzSoiE0MWE9HZFv1U43Fx5E/cksjIUz
	 MOIY47X1pQLNCf0Miao23TMWBT8sceULA9GOxPOE=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/6] staging: vchiq_core: Use killable wait completions for bulk transfers
Date: Wed, 18 Sep 2024 22:00:55 +0530
Message-ID: <20240918163100.870596-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240918163100.870596-1-umang.jain@ideasonboard.com>
References: <20240918163100.870596-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f27e47bc6b8b ("staging: vchiq: use completions instead of
semaphores") introduced completions for events in vchiq interface.
It introduced _interruptible() version of completions for waiting
on events. However, it missed a subtle down_interruptible() macro
override in vchiq_killable.h, which used to mask most of the signals
and only interrupt on fatal ones.

The above issue was fixed in commit a772f116702e ("staging: vchiq: switch
to wait_for_completion_killable"). Given the override logic of
down_interruptible() that existed in vchiq_killable.h, that commit
fixed the completions with the correct variation i.e. killable() family
of functions.

However, commit a772f116702e ("staging: vchiq: switch to
wait_for_completion_killable") later got reverted [1] due to high CPU
load noticed by various downstream and upstream distributions [2].
Reverting the commit solved this problem but the root cause was never
diagonsed and the entire commit was reverted.

This patch brings back killable version of wait events but only for
bulk transfers and queue_message() transfer code paths.

The idea is to bring back killable versions for various event
completions in a phased manner so that we do not re-regress again as
noticed in [2]. Hence, no other wait events are converted from
interruptible -> killable in this patch.

Since the bulk transfers are no longer interruptible (but killable),
drop the "_interruptible" suffix from all vchiq_bulk_xfer_* functions.

[1]: commit 086efbabdc04 ("staging: vchiq: revert "switch to wait_for_completion_killable"")
[2]: https://patchwork.kernel.org/project/linux-arm-kernel/cover/20190509143137.31254-1-nsaenzjulienne@suse.de/

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 17 +++----
 .../interface/vchiq_arm/vchiq_core.c          | 46 +++++++++----------
 .../interface/vchiq_arm/vchiq_core.h          | 18 ++++----
 .../interface/vchiq_arm/vchiq_dev.c           | 14 +++---
 4 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3dbeffc650d3..661b3a9a8280 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -857,10 +857,9 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 		switch (mode) {
 		case VCHIQ_BULK_MODE_NOCALLBACK:
 		case VCHIQ_BULK_MODE_CALLBACK:
-			ret = vchiq_bulk_xfer_callback_interruptible(instance, handle,
-								     (void *)data, NULL,
-								     size, mode, userdata,
-								     VCHIQ_BULK_TRANSMIT);
+			ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data,
+						       NULL, size, mode, userdata,
+						       VCHIQ_BULK_TRANSMIT);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
 			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
@@ -895,10 +894,8 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		switch (mode) {
 		case VCHIQ_BULK_MODE_NOCALLBACK:
 		case VCHIQ_BULK_MODE_CALLBACK:
-			ret = vchiq_bulk_xfer_callback_interruptible(instance, handle,
-								     (void *)data, NULL,
-								     size, mode, userdata,
-								     VCHIQ_BULK_RECEIVE);
+			ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data, NULL,
+						       size, mode, userdata, VCHIQ_BULK_RECEIVE);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
 			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
@@ -969,8 +966,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 			return -ENOMEM;
 	}
 
-	ret = vchiq_bulk_xfer_blocking_interruptible(instance, handle, data, NULL, size,
-						     &waiter->bulk_waiter, dir);
+	ret = vchiq_bulk_xfer_blocking(instance, handle, data, NULL, size,
+				       &waiter->bulk_waiter, dir);
 	if ((ret != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 1f94db6e0cd9..a381a633d3d5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -962,7 +962,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			spin_unlock(&state->quota_spinlock);
 			mutex_unlock(&state->slot_mutex);
 
-			if (wait_for_completion_interruptible(&state->data_quota_event))
+			if (wait_for_completion_killable(&state->data_quota_event))
 				return -EAGAIN;
 
 			mutex_lock(&state->slot_mutex);
@@ -986,7 +986,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 				quota->message_use_count, quota->slot_use_count);
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
-			if (wait_for_completion_interruptible(&quota->quota_event))
+			if (wait_for_completion_killable(&quota->quota_event))
 				return -EAGAIN;
 			if (service->closing)
 				return -EHOSTDOWN;
@@ -2662,11 +2662,11 @@ close_service_complete(struct vchiq_service *service, int failstate)
  * returned to user context.
  */
 static int
-vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
-					void *offset, void __user *uoffset,
-					int size, void *userdata,
-					enum vchiq_bulk_mode mode,
-					enum vchiq_bulk_dir dir)
+vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
+				   void *offset, void __user *uoffset,
+				   int size, void *userdata,
+				   enum vchiq_bulk_mode mode,
+				   enum vchiq_bulk_dir dir)
 {
 	struct vchiq_bulk_queue *queue;
 	struct bulk_waiter *bulk_waiter = NULL;
@@ -2695,7 +2695,7 @@ vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
 		VCHIQ_SERVICE_STATS_INC(service, bulk_stalls);
 		do {
 			mutex_unlock(&service->bulk_mutex);
-			if (wait_for_completion_interruptible(&service->bulk_remove_event))
+			if (wait_for_completion_killable(&service->bulk_remove_event))
 				return -EAGAIN;
 			if (mutex_lock_killable(&service->bulk_mutex))
 				return -EAGAIN;
@@ -2763,7 +2763,7 @@ vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
 
         if (bulk_waiter) {
                 bulk_waiter->bulk = bulk;
-                if (wait_for_completion_interruptible(&bulk_waiter->event))
+		if (wait_for_completion_killable(&bulk_waiter->event))
                         status = -EAGAIN;
                 else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
                         status = -EINVAL;
@@ -3105,9 +3105,9 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 }
 
 int
-vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned int handle,
-				       void *offset, void __user *uoffset, int size,
-				       void __user *userdata, enum vchiq_bulk_dir dir)
+vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
+			 void *offset, void __user *uoffset, int size,
+			 void __user *userdata, enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	enum vchiq_bulk_mode mode = VCHIQ_BULK_MODE_BLOCKING;
@@ -3126,8 +3126,8 @@ vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned
 		goto error_exit;
 
 
-	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset, size,
-							 userdata, mode, dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, offset, uoffset, size,
+						    userdata, mode, dir);
 
 error_exit:
 	vchiq_service_put(service);
@@ -3136,10 +3136,10 @@ vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned
 }
 
 int
-vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int handle,
-				       void *offset, void __user *uoffset, int size,
-				       enum vchiq_bulk_mode mode, void *userdata,
-				       enum vchiq_bulk_dir dir)
+vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
+			 void *offset, void __user *uoffset, int size,
+			 enum vchiq_bulk_mode mode, void *userdata,
+			 enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	int status = -EINVAL;
@@ -3160,8 +3160,8 @@ vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned
 	if (vchiq_check_service(service))
 		goto error_exit;
 
-	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset,
-							 size, userdata, mode, dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, offset, uoffset,
+						    size, userdata, mode, dir);
 
 error_exit:
 	vchiq_service_put(service);
@@ -3175,8 +3175,8 @@ vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned
  * and the call should be retried after being returned to user context.
  */
 int
-vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
-				      unsigned int handle, struct bulk_waiter *userdata)
+vchiq_bulk_xfer_waiting(struct vchiq_instance *instance,
+			unsigned int handle, struct bulk_waiter *userdata)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct bulk_waiter *bulk_waiter;
@@ -3200,7 +3200,7 @@ vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
 
 	status = 0;
 
-	if (wait_for_completion_interruptible(&bulk_waiter->event))
+	if (wait_for_completion_killable(&bulk_waiter->event))
 		return -EAGAIN;
 	else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
 		return -EINVAL;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 468463f31801..5bf543dfc9c7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -471,19 +471,19 @@ extern void
 remote_event_pollall(struct vchiq_state *state);
 
 extern int
-vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
-				      unsigned int handle, struct bulk_waiter *userdata);
+vchiq_bulk_xfer_waiting(struct vchiq_instance *instance, unsigned int handle,
+			struct bulk_waiter *userdata);
 
 extern int
-vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned int handle,
-				       void *offset, void __user *uoffset, int size,
-				       void __user *userdata, enum vchiq_bulk_dir dir);
+vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
+			 void *offset, void __user *uoffset, int size,
+			 void __user *userdata, enum vchiq_bulk_dir dir);
 
 extern int
-vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int handle,
-				       void *offset, void __user *uoffset, int size,
-				       enum vchiq_bulk_mode mode, void *userdata,
-				       enum vchiq_bulk_dir dir);
+vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
+			 void *offset, void __user *uoffset, int size,
+			 enum vchiq_bulk_mode mode, void *userdata,
+			 enum vchiq_bulk_dir dir);
 
 extern void
 vchiq_dump_state(struct seq_file *f, struct vchiq_state *state);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index d41a4624cc92..aca237919696 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -305,9 +305,9 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 
 		userdata = &waiter->bulk_waiter;
 
-		status = vchiq_bulk_xfer_blocking_interruptible(instance, args->handle,
-								NULL, args->data, args->size,
-								userdata, dir);
+		status = vchiq_bulk_xfer_blocking(instance, args->handle,
+						  NULL, args->data, args->size,
+						  userdata, dir);
 
 	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
 		mutex_lock(&instance->bulk_waiter_list_mutex);
@@ -330,13 +330,13 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 			waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
 
-		status = vchiq_bulk_xfer_waiting_interruptible(instance, args->handle, userdata);
+		status = vchiq_bulk_xfer_waiting(instance, args->handle, userdata);
 	} else {
 		userdata = args->userdata;
 
-		status = vchiq_bulk_xfer_callback_interruptible(instance, args->handle, NULL,
-								args->data, args->size,
-								args->mode, userdata, dir);
+		status = vchiq_bulk_xfer_callback(instance, args->handle, NULL,
+						  args->data, args->size,
+						  args->mode, userdata, dir);
 
 	}
 
-- 
2.45.2


