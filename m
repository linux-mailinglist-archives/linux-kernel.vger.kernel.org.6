Return-Path: <linux-kernel+bounces-369892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B819A2415
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B4E28D19F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927821DE3C2;
	Thu, 17 Oct 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Onb+sOEv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE91DE4DC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172231; cv=none; b=vECEoDcKkjW1atfe4yQW/+bHRF7Ghk0B7h6yh8bGjU533jrFfqRv3hf63Gu3TJeCUIflPKVdCjRntFCVEk+dDQhZckemJyF89DU/wno5lE1a/alq9ryh3H7sNHnqR6GVNxg/4KKmZwcflAYmD4pUdjibyMyiuA5Rgaq+Ew6nAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172231; c=relaxed/simple;
	bh=Zu496OQEDTWTNvz56oSeQb4zdJxLuEzbNXwR6ZUzPSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pljcaTwlDUhgol9veUQdrC2JbFsBABedDeitSJpIzgIMM1BaCjcNO0OFIdXRMz1v4Xfsyiu86vEcONxBhSgSWp3/nP0LLd/FKXdSdmkYLB0bX4W2JdETI/vR5MmkCLA5z2207JzR5BQBT4bg3jo6Wxbz6L25ySF7oGHgXh0xh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Onb+sOEv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 19128173E;
	Thu, 17 Oct 2024 15:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729172112;
	bh=Zu496OQEDTWTNvz56oSeQb4zdJxLuEzbNXwR6ZUzPSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Onb+sOEvIR7BLeu7MPWWIbk8SMQeFMv7jCTh0zfpimKnRO82aiWiyzQBkhf8O7+KZ
	 kX28kSUbZnTJArTRhpzCneVphJd0gMUvu2u8tvdhmGQRK53LtU/culAIf6fu426jy8
	 oMleqOzDzbMzC31svm9rFXpfWEkatoOZ4++13+7s=
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
Subject: [PATCH 5/6] staging: vchiq_core: Simplify bulk transfer queue message function
Date: Thu, 17 Oct 2024 19:06:28 +0530
Message-ID: <20241017133629.216672-6-umang.jain@ideasonboard.com>
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

vchiq_bulk_xfer_queue_msg_killable() is a common function between
various bulk transfer code paths (blocking, callback and no-callback).
These code paths were simplified earlier by passing a populated
struct vchiq_bulk pointer in order to avoid open-coding the parameters
required to initiate a bulk transfer.

Now simplify the vchiq_bulk_xfer_queue_msg_killable() in a similar way
i.e. avoid open-coding the function parameters and pass the struct
vchiq_bulk pointer directly, coming from the various bulk transfer code
paths.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 39 ++++++++-----------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index bb46aa20bdb4..9e56e34ca4d9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3022,29 +3022,26 @@ close_service_complete(struct vchiq_service *service, int failstate)
  */
 static int
 vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
-				   void *offset, void __user *uoffset,
-				   int size, void *userdata,
-				   enum vchiq_bulk_mode mode,
-				   enum vchiq_bulk_dir dir)
+				   struct vchiq_bulk *bulk_params)
 {
 	struct vchiq_bulk_queue *queue;
 	struct bulk_waiter *bulk_waiter = NULL;
 	struct vchiq_bulk *bulk;
 	struct vchiq_state *state = service->state;
-	const char dir_char = (dir == VCHIQ_BULK_TRANSMIT) ? 't' : 'r';
-	const int dir_msgtype = (dir == VCHIQ_BULK_TRANSMIT) ?
+	const char dir_char = (bulk_params->dir == VCHIQ_BULK_TRANSMIT) ? 't' : 'r';
+	const int dir_msgtype = (bulk_params->dir == VCHIQ_BULK_TRANSMIT) ?
 		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
 	int status = -EINVAL;
 	int payload[2];
 
-	if (mode == VCHIQ_BULK_MODE_BLOCKING) {
-		bulk_waiter = userdata;
+	if (bulk_params->mode == VCHIQ_BULK_MODE_BLOCKING) {
+		bulk_waiter = bulk_params->userdata;
 		init_completion(&bulk_waiter->event);
 		bulk_waiter->actual = 0;
 		bulk_waiter->bulk = NULL;
 	}
 
-	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
+	queue = (bulk_params->dir == VCHIQ_BULK_TRANSMIT) ?
 		&service->bulk_tx : &service->bulk_rx;
 
 	if (mutex_lock_killable(&service->bulk_mutex))
@@ -3064,13 +3061,14 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 
 	bulk = &queue->bulks[BULK_INDEX(queue->local_insert)];
 
-	bulk->mode = mode;
-	bulk->dir = dir;
-	bulk->userdata = userdata;
-	bulk->size = size;
+	/* Initiliaze the 'bulk' slot with bulk parameters passed in. */
+	bulk->mode = bulk_params->mode;
+	bulk->dir = bulk_params->dir;
+	bulk->userdata = bulk_params->userdata;
+	bulk->size = bulk_params->size;
+	bulk->offset = bulk_params->offset;
+	bulk->uoffset = bulk_params->uoffset;
 	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
-	bulk->offset = offset;
-	bulk->uoffset = uoffset;
 
 	if (vchiq_prepare_bulk_data(service->instance, bulk))
 		goto unlock_error_exit;
@@ -3083,7 +3081,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 
 	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
 		state->id, service->localport, service->remoteport,
-		dir_char, size, &bulk->data, userdata);
+		dir_char, bulk->size, &bulk->data, bulk->userdata);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
@@ -3489,10 +3487,7 @@ vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
 		goto error_exit;
 
 
-	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params->offset,
-						    bulk_params->uoffset, bulk_params->size,
-						    bulk_params->userdata, bulk_params->mode,
-						    bulk_params->dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params);
 
 error_exit:
 	vchiq_service_put(service);
@@ -3523,9 +3518,7 @@ vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
 	if (vchiq_check_service(service))
 		goto error_exit;
 
-	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params->offset, bulk_params->uoffset,
-						    bulk_params->size, bulk_params->userdata,
-						    bulk_params->mode, bulk_params->dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params);
 
 error_exit:
 	vchiq_service_put(service);
-- 
2.45.2


