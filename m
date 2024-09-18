Return-Path: <linux-kernel+bounces-332811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4FA97BF24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F061F221F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E361C9DF0;
	Wed, 18 Sep 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qnyGr0eF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39501C9878
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677106; cv=none; b=m/9Rnset5nTJwH0A9u85Jtdb7nAm08eXxHbVEK2j6CZQyt7MpUNiB4hDK8kg6lordROUORE8yCl7U9HX58+ZIHtkbwDWN0rPc4263txsimnXnWcECYYDWtxK/CrLAorDJkzdEJLgxgHloBNNBUBrWiz4QrQfF4lxbhACA/4N3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677106; c=relaxed/simple;
	bh=sPFkvcNPaqTNv6pNG8JxZmx068ImTFIjLol71A2L6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz8qEReMJfimI4Vp0HQaZx/VPraB3nt3xTiD1Mufb9WQBiblPspsCgHHO8BMPiK2DF/N61BxoovnGGrDMbI2Hqzfb9ihqzmwqnnw8xw12glDCsZvvzIWSHf3VfmKAzy6/SOpeWzi3fOl3iRbqdpYLUM5iVgz4vNvpFAhQ+YXYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qnyGr0eF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C835A57;
	Wed, 18 Sep 2024 18:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726677016;
	bh=sPFkvcNPaqTNv6pNG8JxZmx068ImTFIjLol71A2L6QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnyGr0eFR8qGVYkeSmP9GDP+7sJPB/XjomcF9wxWVPAdF84rv8ChMNLaAPF1VtLXZ
	 aYN7a8puZIul8hsYYRfcqmbxkp5lnq0+hk+KdBXIj2dKF5YLYJnijq78tO0sdYtzUl
	 dr7SFDyzRAge2e2clZJCF9yFwBk0jZBRPI3t3/2E=
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
Subject: [PATCH 3/6] staging: vchiq_core: Return -EINTR in queue_message() on interrupt
Date: Wed, 18 Sep 2024 22:00:57 +0530
Message-ID: <20240918163100.870596-4-umang.jain@ideasonboard.com>
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

queue_message() uses mutex_lock_killable() and
wait_for_completion_killable() variations of locking and wait event
completions respectively. These functions return either 0 (on success)
or -EINTR, if interrupted by a fatal signal (as documented in the
kernel).

However, queue_message() is currently returning -EAGAIN if these
killable functions are interrupted by fatal signals. Bubbling up
-EAGAIN might give a sense to the caller, that the code path can
be re-tried however, in actual sense, a fatal signal has been
received by the process and the process is going away.

Hence, we should align the return value with what these killable
versions will return i.e. -EINTR (Interrupted system call).

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 4279dd182a98..d7b22e37c2ff 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -922,7 +922,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 	if (!(flags & QMFLAGS_NO_MUTEX_LOCK) &&
 	    mutex_lock_killable(&state->slot_mutex))
-		return -EAGAIN;
+		return -EINTR;
 
 	if (type == VCHIQ_MSG_DATA) {
 		int tx_end_index;
@@ -963,7 +963,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			mutex_unlock(&state->slot_mutex);
 
 			if (wait_for_completion_killable(&state->data_quota_event))
-				return -EAGAIN;
+				return -EINTR;
 
 			mutex_lock(&state->slot_mutex);
 			spin_lock(&state->quota_spinlock);
@@ -987,11 +987,11 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
 			if (wait_for_completion_killable(&quota->quota_event))
-				return -EAGAIN;
+				return -EINTR;
 			if (service->closing)
 				return -EHOSTDOWN;
 			if (mutex_lock_killable(&state->slot_mutex))
-				return -EAGAIN;
+				return -EINTR;
 			if (service->srvstate != VCHIQ_SRVSTATE_OPEN) {
 				/* The service has been closed */
 				mutex_unlock(&state->slot_mutex);
@@ -1524,7 +1524,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 			set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
 		} else {
 			if (queue_message(state, NULL, openack_id, memcpy_copy_callback,
-					  &ack_payload, sizeof(ack_payload), 0) == -EAGAIN)
+					  &ack_payload, sizeof(ack_payload), 0) == -EINTR)
 				goto bail_not_ready;
 
 			/* The service is now open */
@@ -1539,7 +1539,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 fail_open:
 	/* No available service, or an invalid request - send a CLOSE */
 	if (queue_message(state, NULL, MAKE_CLOSE(0, VCHIQ_MSG_SRCPORT(msgid)),
-			  NULL, NULL, 0, 0) == -EAGAIN)
+			  NULL, NULL, 0, 0) == -EINTR)
 		goto bail_not_ready;
 
 	return 1;
@@ -1786,7 +1786,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
 			/* Send a PAUSE in response */
 			if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-					  QMFLAGS_NO_MUTEX_UNLOCK) == -EAGAIN)
+					  QMFLAGS_NO_MUTEX_UNLOCK) == -EINTR)
 				goto bail_not_ready;
 		}
 		/* At this point slot_mutex is held */
@@ -1903,7 +1903,7 @@ handle_poll(struct vchiq_state *state)
 
 	case VCHIQ_CONNSTATE_PAUSING:
 		if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-				  QMFLAGS_NO_MUTEX_UNLOCK) != -EAGAIN) {
+				  QMFLAGS_NO_MUTEX_UNLOCK) != -EINTR) {
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSE_SENT);
 		} else {
 			/* Retry later */
@@ -1913,7 +1913,7 @@ handle_poll(struct vchiq_state *state)
 
 	case VCHIQ_CONNSTATE_RESUMING:
 		if (queue_message(state, NULL, MAKE_RESUME, NULL, NULL, 0,
-				  QMFLAGS_NO_MUTEX_LOCK) != -EAGAIN) {
+				  QMFLAGS_NO_MUTEX_LOCK) != -EINTR) {
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
 		} else {
 			/*
@@ -3276,11 +3276,11 @@ int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int han
 					     data, size);
 
 		/*
-		 * vchiq_queue_message() may return -EAGAIN, so we need to
+		 * vchiq_queue_message() may return -EINTR, so we need to
 		 * implement a retry mechanism since this function is supposed
 		 * to block until queued
 		 */
-		if (status != -EAGAIN)
+		if (status != -EINTR)
 			break;
 
 		msleep(1);
-- 
2.45.2


