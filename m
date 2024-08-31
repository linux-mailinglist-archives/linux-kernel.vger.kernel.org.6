Return-Path: <linux-kernel+bounces-309978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8E9672A9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F02C1F223D1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EDF502BE;
	Sat, 31 Aug 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GjG5JhhV"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA574C08
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121493; cv=none; b=V/rdY9mIU/fnfHGVlbUTDrGrnwsUVWd0rZF0QFp8vnPF9r1fUNz22bvcdAPqm0Tb21Chd7wAEZZYqI6a+ICsdqsgy8YGgeBUKUlS+XCW3nVnn6oymMblhq6RVdzFNv6h4Wwz8cuNDf6WKiwzJYhACVZW83eJQzkQgsEpLIBtM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121493; c=relaxed/simple;
	bh=iJqAcxikFIBNZVnOuqiEne8UVfrom5PwjJ2Inkcv5Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfxM2pmLwW3WttoLJLnTdT1vaqP/IvNyEawC1JYifEd/2AH43LbztFsC7KsmNzTq7zcUXfJCfa4CvcVwbZryEwP8zbUp3CGWdHaA6ctgHwC2J2CeyDZlAXBXSRZa6260ZYhTErz2mN6exJTHxsOxLjWr4hzvBLiONkm+b6dpOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GjG5JhhV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 578DB8BE;
	Sat, 31 Aug 2024 18:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121419;
	bh=iJqAcxikFIBNZVnOuqiEne8UVfrom5PwjJ2Inkcv5Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjG5JhhVZWD0Zn6VaCey09GeqyT7cGXkGICiRlA7r4Xkm7xPZOwHQuCcRmuBeUCdQ
	 w7OzgmpId1sLIQQdhJfX5kWmjK8UXOpk3D22TtKDZ7ErstUV6rowWDdAK7+S1H2hgB
	 qd2eqhgPCGn9E+QieIs8xTkCZU68jFF2LMCdIZOE=
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
Subject: [PATCH v2 2/7] staging: vchiq_core: Simplify vchiq_bulk_transfer()
Date: Sat, 31 Aug 2024 21:54:30 +0530
Message-ID: <20240831162435.191084-3-umang.jain@ideasonboard.com>
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

Factor out core logic for preparing bulk data transfer(mutex locking,
waits on vchiq_bulk_queue wait-queue, initialising the bulk transfer)
out of the vchiq_bulk_transfer(). This simplifies the existing
vchiq_bulk_transfer() and makes it more readable since all the core
logic is handled in vchiq_bulk_xfer_queue_msg_interruptible(). It
will also help us to refactor vchiq_bulk_transfer() easily for different
vchiq bulk transfer modes.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 217 ++++++++++--------
 1 file changed, 121 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7db76e309d3f..067259f55664 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -189,6 +189,13 @@ static const char *const conn_state_names[] = {
 static void
 release_message_sync(struct vchiq_state *state, struct vchiq_header *header);
 
+static int
+vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
+					void *offset, void __user *uoffset,
+					int size, void *userdata,
+					enum vchiq_bulk_mode mode,
+					enum vchiq_bulk_dir dir);
+
 static const char *msg_type_str(unsigned int msg_type)
 {
 	switch (msg_type) {
@@ -2991,15 +2998,9 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 			enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	struct vchiq_bulk_queue *queue;
-	struct vchiq_bulk *bulk;
-	struct vchiq_state *state;
 	struct bulk_waiter *bulk_waiter = NULL;
-	const char dir_char = (dir == VCHIQ_BULK_TRANSMIT) ? 't' : 'r';
-	const int dir_msgtype = (dir == VCHIQ_BULK_TRANSMIT) ?
-		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
+	struct vchiq_bulk *bulk;
 	int status = -EINVAL;
-	int payload[2];
 
 	if (!service)
 		goto error_exit;
@@ -3027,89 +3028,10 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 		goto error_exit;
 	}
 
-	state = service->state;
-
-	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
-		&service->bulk_tx : &service->bulk_rx;
-
-	if (mutex_lock_killable(&service->bulk_mutex)) {
-		status = -EAGAIN;
-		goto error_exit;
-	}
-
-	if (queue->local_insert == queue->remove + VCHIQ_NUM_SERVICE_BULKS) {
-		VCHIQ_SERVICE_STATS_INC(service, bulk_stalls);
-		do {
-			mutex_unlock(&service->bulk_mutex);
-			if (wait_for_completion_interruptible(&service->bulk_remove_event)) {
-				status = -EAGAIN;
-				goto error_exit;
-			}
-			if (mutex_lock_killable(&service->bulk_mutex)) {
-				status = -EAGAIN;
-				goto error_exit;
-			}
-		} while (queue->local_insert == queue->remove +
-				VCHIQ_NUM_SERVICE_BULKS);
-	}
-
-	bulk = &queue->bulks[BULK_INDEX(queue->local_insert)];
-
-	bulk->mode = mode;
-	bulk->dir = dir;
-	bulk->userdata = userdata;
-	bulk->size = size;
-	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
-
-	if (vchiq_prepare_bulk_data(instance, bulk, offset, uoffset, size, dir))
-		goto unlock_error_exit;
-
-	/*
-	 * Ensure that the bulk data record is visible to the peer
-	 * before proceeding.
-	 */
-	wmb();
-
-	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
-		state->id, service->localport, service->remoteport,
-		dir_char, size, &bulk->data, userdata);
-
-	/*
-	 * The slot mutex must be held when the service is being closed, so
-	 * claim it here to ensure that isn't happening
-	 */
-	if (mutex_lock_killable(&state->slot_mutex)) {
-		status = -EAGAIN;
-		goto cancel_bulk_error_exit;
-	}
-
-	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
-		goto unlock_both_error_exit;
-
-	payload[0] = lower_32_bits(bulk->data);
-	payload[1] = bulk->size;
-	status = queue_message(state,
-			       NULL,
-			       VCHIQ_MAKE_MSG(dir_msgtype,
-					      service->localport,
-					      service->remoteport),
-			       memcpy_copy_callback,
-			       &payload,
-			       sizeof(payload),
-			       QMFLAGS_IS_BLOCKING |
-			       QMFLAGS_NO_MUTEX_LOCK |
-			       QMFLAGS_NO_MUTEX_UNLOCK);
+	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset,
+							 size, userdata, mode, dir);
 	if (status)
-		goto unlock_both_error_exit;
-
-	queue->local_insert++;
-
-	mutex_unlock(&state->slot_mutex);
-	mutex_unlock(&service->bulk_mutex);
-
-	dev_dbg(state->dev, "core: %d: bt:%d %cx li=%x ri=%x p=%x\n",
-		state->id, service->localport, dir_char, queue->local_insert,
-		queue->remote_insert, queue->process);
+		goto error_exit;
 
 	vchiq_service_put(service);
 
@@ -3125,13 +3047,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 
 	return status;
 
-unlock_both_error_exit:
-	mutex_unlock(&state->slot_mutex);
-cancel_bulk_error_exit:
-	vchiq_complete_bulk(service->instance, bulk);
-unlock_error_exit:
-	mutex_unlock(&service->bulk_mutex);
-
 error_exit:
 	if (service)
 		vchiq_service_put(service);
@@ -3293,6 +3208,116 @@ vchiq_release_message(struct vchiq_instance *instance, unsigned int handle,
 }
 EXPORT_SYMBOL(vchiq_release_message);
 
+/*
+ * Prepares a bulk transfer to be queued. The function is interruptible and is
+ * intended to be called from user threads. It may return -EAGAIN to indicate
+ * that a signal has been received and the call should be retried after being
+ * returned to user context.
+ */
+static int
+vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
+					void *offset, void __user *uoffset,
+					int size, void *userdata,
+					enum vchiq_bulk_mode mode,
+					enum vchiq_bulk_dir dir)
+{
+	struct vchiq_bulk_queue *queue;
+	struct vchiq_bulk *bulk;
+	struct vchiq_state *state = service->state;
+	const char dir_char = (dir == VCHIQ_BULK_TRANSMIT) ? 't' : 'r';
+	const int dir_msgtype = (dir == VCHIQ_BULK_TRANSMIT) ?
+		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
+	int status = -EINVAL;
+	int payload[2];
+
+	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
+		&service->bulk_tx : &service->bulk_rx;
+
+	if (mutex_lock_killable(&service->bulk_mutex))
+		return -EAGAIN;
+
+	if (queue->local_insert == queue->remove + VCHIQ_NUM_SERVICE_BULKS) {
+		VCHIQ_SERVICE_STATS_INC(service, bulk_stalls);
+		do {
+			mutex_unlock(&service->bulk_mutex);
+			if (wait_for_completion_interruptible(&service->bulk_remove_event))
+				return -EAGAIN;
+			if (mutex_lock_killable(&service->bulk_mutex))
+				return -EAGAIN;
+		} while (queue->local_insert == queue->remove +
+				VCHIQ_NUM_SERVICE_BULKS);
+	}
+
+	bulk = &queue->bulks[BULK_INDEX(queue->local_insert)];
+
+	bulk->mode = mode;
+	bulk->dir = dir;
+	bulk->userdata = userdata;
+	bulk->size = size;
+	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
+
+	if (vchiq_prepare_bulk_data(service->instance, bulk, offset, uoffset, size, dir))
+		goto unlock_error_exit;
+
+	/*
+	 * Ensure that the bulk data record is visible to the peer
+	 * before proceeding.
+	 */
+	wmb();
+
+	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
+		state->id, service->localport, service->remoteport,
+		dir_char, size, &bulk->data, userdata);
+
+	/*
+	 * The slot mutex must be held when the service is being closed, so
+	 * claim it here to ensure that isn't happening
+	 */
+	if (mutex_lock_killable(&state->slot_mutex)) {
+		status = -EAGAIN;
+		goto cancel_bulk_error_exit;
+	}
+
+	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
+		goto unlock_both_error_exit;
+
+	payload[0] = lower_32_bits(bulk->data);
+	payload[1] = bulk->size;
+	status = queue_message(state,
+			       NULL,
+			       VCHIQ_MAKE_MSG(dir_msgtype,
+					      service->localport,
+					      service->remoteport),
+			       memcpy_copy_callback,
+			       &payload,
+			       sizeof(payload),
+			       QMFLAGS_IS_BLOCKING |
+			       QMFLAGS_NO_MUTEX_LOCK |
+			       QMFLAGS_NO_MUTEX_UNLOCK);
+	if (status)
+		goto unlock_both_error_exit;
+
+	queue->local_insert++;
+
+	mutex_unlock(&state->slot_mutex);
+	mutex_unlock(&service->bulk_mutex);
+
+	dev_dbg(state->dev, "core: %d: bt:%d %cx li=%x ri=%x p=%x\n",
+		state->id, service->localport, dir_char, queue->local_insert,
+		queue->remote_insert, queue->process);
+
+	return status;
+
+unlock_both_error_exit:
+	mutex_unlock(&state->slot_mutex);
+cancel_bulk_error_exit:
+	vchiq_complete_bulk(service->instance, bulk);
+unlock_error_exit:
+	mutex_unlock(&service->bulk_mutex);
+
+	return status;
+}
+
 static void
 release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
 {
-- 
2.45.2


