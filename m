Return-Path: <linux-kernel+bounces-377911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9889AC87C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17569B23DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C01AAE39;
	Wed, 23 Oct 2024 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i930unMx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA511A4E9E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681493; cv=none; b=Xt8DYQAghKkv+lYjsFNw9vUNhf5PYsOlm8ILUfCE4nh6EVC2WnHDX/AjlGPUGNcfO0/hUyjAX1oEd+nKIUyD80SodIA2qHi8EGdZT8CPLSM+W0nKCCN52O1nZaGs1tMuFraCnp/l3BceB5biK4HVyvo17WYq8/mPGTrrDBtrszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681493; c=relaxed/simple;
	bh=LkuPDmiNtkyAPKPo4egoogY7JtPMRLPdsJI6n3MyepI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0kvaGYNT6eVuk1yI00ERonLm0+IPAMtfizW5+Cc5Cbnx2eLQ2oDjFICzGxZ/UWb9PTqXjhEj2Fr549hphx9ydyT15oApsTCKpuw1uPVET3uijAB7ghoyRZLU3RkqFyDSR6REtdx/vafd73Dm1ow+VpnvHigGIiXRCS/SyIj7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=i930unMx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8FC0C82A;
	Wed, 23 Oct 2024 13:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681383;
	bh=LkuPDmiNtkyAPKPo4egoogY7JtPMRLPdsJI6n3MyepI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i930unMxxKJk61w5glqBMGlPx8fpx1QlG296saJ3vVnQXJTohHtxKqTTlMDs7R3+j
	 WEg2ysFoFU+xAZo0jLuvzu81R48FSoSb4mTUfjb0t5AyEGhmuRhYMjgHNMjG73qQCz
	 YVfNkD2EsP7Oi+leWbTKjtV2c7wxtuMDILyIoDqg=
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
Subject: [PATCH 3/6] staging: vchiq_core: Rename struct vchiq_bulk 'userdata'
Date: Wed, 23 Oct 2024 16:34:03 +0530
Message-ID: <20241023110406.885199-4-umang.jain@ideasonboard.com>
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

Rename the struct vchiq_bulk 'userdata' member to 'cb_data' to clarify
its purpose. 'cb_data' is meant to be passed to service callback
function in VCHIQ_BULK_MODE_CALLBACK mode.

No functional changes in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    |  4 ++--
 .../vc04_services/interface/vchiq_arm/vchiq_core.c   | 12 ++++++------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h   |  2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c    |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index ff627b297bc4..c06a57ea9cf5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -501,7 +501,7 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 		bulk_params.offset = (void *)data;
 		bulk_params.mode = mode;
 		bulk_params.size = size;
-		bulk_params.userdata = userdata;
+		bulk_params.cb_data = userdata;
 		bulk_params.dir = VCHIQ_BULK_TRANSMIT;
 
 		ret = vchiq_bulk_xfer_callback(instance, handle, &bulk_params);
@@ -536,7 +536,7 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		bulk_params.offset = (void *)data;
 		bulk_params.mode = mode;
 		bulk_params.size = size;
-		bulk_params.userdata = userdata;
+		bulk_params.cb_data = userdata;
 		bulk_params.dir = VCHIQ_BULK_RECEIVE;
 
 		ret = vchiq_bulk_xfer_callback(instance, handle, &bulk_params);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 5e52f8954be7..6095adaf0cf6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -455,15 +455,15 @@ mark_service_closing(struct vchiq_service *service)
 
 static inline int
 make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
-		      struct vchiq_header *header, void *bulk_userdata)
+		      struct vchiq_header *header, void *cb_data)
 {
 	int status;
 
 	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %pK, %pK)\n",
 		service->state->id, service->localport, reason_names[reason],
-		header, bulk_userdata);
+		header, cb_data);
 	status = service->base.callback(service->instance, reason, header, service->handle,
-					bulk_userdata);
+					cb_data);
 	if (status && (status != -EAGAIN)) {
 		dev_warn(service->state->dev,
 			 "core: %d: ignoring ERROR from callback to service %x\n",
@@ -1340,7 +1340,7 @@ static int service_notify_bulk(struct vchiq_service *service,
 		enum vchiq_reason reason = get_bulk_reason(bulk);
 
 		return make_service_callback(service, reason, NULL,
-					     bulk->userdata);
+					     bulk->cb_data);
 	}
 
 	return 0;
@@ -3065,7 +3065,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	bulk->mode = bulk_params->mode;
 	bulk->dir = bulk_params->dir;
 	bulk->waiter = bulk_params->waiter;
-	bulk->userdata = bulk_params->userdata;
+	bulk->cb_data = bulk_params->cb_data;
 	bulk->size = bulk_params->size;
 	bulk->offset = bulk_params->offset;
 	bulk->uoffset = bulk_params->uoffset;
@@ -3082,7 +3082,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 
 	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
 		state->id, service->localport, service->remoteport,
-		dir_char, bulk->size, &bulk->dma_addr, bulk->userdata);
+		dir_char, bulk->size, &bulk->dma_addr, bulk->cb_data);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 88766c9180a9..f9a2268ad47e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -114,7 +114,7 @@ enum vchiq_bulk_dir {
 struct vchiq_bulk {
 	short mode;
 	short dir;
-	void *userdata;
+	void *cb_data;
 	struct bulk_waiter *waiter;
 	dma_addr_t dma_addr;
 	int size;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 3d2827446f53..c99cd36a2696 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -338,7 +338,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		bulk_params.mode = args->mode;
 		bulk_params.size = args->size;
 		bulk_params.dir = dir;
-		bulk_params.userdata = args->userdata;
+		bulk_params.cb_data = args->userdata;
 
 		status = vchiq_bulk_xfer_callback(instance, args->handle,
 						  &bulk_params);
-- 
2.45.2


