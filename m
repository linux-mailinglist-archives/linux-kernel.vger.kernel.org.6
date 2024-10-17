Return-Path: <linux-kernel+bounces-369891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB219A2414
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B161E1C22BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6701DE4CA;
	Thu, 17 Oct 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Pt4HuMel"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AE1DE4CD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172229; cv=none; b=dMGbeaCoBUu91NYSp+6NkXIJL0WoR8a6QJzIHG70ticSkR3CugVnMC3BPPjbkDRm7eISjfnCLMzkAM4JPSPJC7TwkM75KmzLKejkKafuod7VHwHG+SaidIJoEnVYF7kynyj5Dp4x2GwcwjAylH6Lt0ozScS6EBKOn61KCPIIrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172229; c=relaxed/simple;
	bh=7FmiJpS58px7WK9bLlNddRfh4cPoo5zN7ciSpgUvPHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJj18cPYOEhmOm5r57/bq/2LC9BcZ2u183977HomfH4aMlmDCwOTrZBesgJyaXdKvywjV4FsFVtail9chJEbuGiQUZEL3lYuJIH2FPy46VA2B4js0aZvr7eDKaYzL1gqZFVoekiv+LoVI43KqoNM/Efx4lpnJVESajHHj7X+B4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Pt4HuMel; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C73FC12E9;
	Thu, 17 Oct 2024 15:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729172109;
	bh=7FmiJpS58px7WK9bLlNddRfh4cPoo5zN7ciSpgUvPHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pt4HuMeloxDnodpvy50inHq7YbhniLx14a8r3BEmbwO5kwE5PjJJKfnHGrd6n8Q9P
	 7uipWG6vQnKiSf61tXlOQnkDlwc4HozYtggFA/Ij7ByuhNGl5hQqtvWQekXadVDL4J
	 QSm4PO68ZRcSDf1/raoEjaOpZh/YBa3X0HlSOq1M=
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
Subject: [PATCH 4/6] staging: vc04_services: Simplify (no)callback bulk transfer code paths
Date: Thu, 17 Oct 2024 19:06:27 +0530
Message-ID: <20241017133629.216672-5-umang.jain@ideasonboard.com>
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

The (no)callback mode bulk transfer tends to open-code every function
parameter needed to initiate the bulk transfer. Instead of doing that,
simply pass a populated struct vchiq_bulk down the function chain.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 21 ++++++++++++++-----
 .../interface/vchiq_arm/vchiq_core.c          | 15 +++++++------
 .../interface/vchiq_arm/vchiq_core.h          |  4 +---
 .../interface/vchiq_arm/vchiq_dev.c           | 12 ++++++-----
 4 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 90b5ce5ee429..c2e7c2bd5071 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -497,9 +497,14 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 	switch (mode) {
 	case VCHIQ_BULK_MODE_NOCALLBACK:
 	case VCHIQ_BULK_MODE_CALLBACK:
-		ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data,
-					       NULL, size, mode, userdata,
-					       VCHIQ_BULK_TRANSMIT);
+
+		bulk_params.offset = (void *)data;
+		bulk_params.mode = mode;
+		bulk_params.size = size;
+		bulk_params.userdata = userdata;
+		bulk_params.dir = VCHIQ_BULK_TRANSMIT;
+
+		ret = vchiq_bulk_xfer_callback(instance, handle, &bulk_params);
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
 		bulk_params.offset = (void *)data;
@@ -527,8 +532,14 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 	switch (mode) {
 	case VCHIQ_BULK_MODE_NOCALLBACK:
 	case VCHIQ_BULK_MODE_CALLBACK:
-		ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data, NULL,
-					       size, mode, userdata, VCHIQ_BULK_RECEIVE);
+
+		bulk_params.offset = (void *)data;
+		bulk_params.mode = mode;
+		bulk_params.size = size;
+		bulk_params.userdata = userdata;
+		bulk_params.dir = VCHIQ_BULK_RECEIVE;
+
+		ret = vchiq_bulk_xfer_callback(instance, handle, &bulk_params);
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
 		bulk_params.offset = (void *)data;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 6c52827868d5..bb46aa20bdb4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3502,9 +3502,7 @@ vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
 
 int
 vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
-			 void *offset, void __user *uoffset, int size,
-			 enum vchiq_bulk_mode mode, void *userdata,
-			 enum vchiq_bulk_dir dir)
+			 struct vchiq_bulk *bulk_params)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	int status = -EINVAL;
@@ -3512,21 +3510,22 @@ vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
 	if (!service)
 		return -EINVAL;
 
-	if (mode != VCHIQ_BULK_MODE_CALLBACK &&
-	    mode != VCHIQ_BULK_MODE_NOCALLBACK)
+	if (bulk_params->mode != VCHIQ_BULK_MODE_CALLBACK &&
+	    bulk_params->mode != VCHIQ_BULK_MODE_NOCALLBACK)
 		goto error_exit;
 
 	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
 		goto error_exit;
 
-	if (!offset && !uoffset)
+	if (!bulk_params->offset && !bulk_params->uoffset)
 		goto error_exit;
 
 	if (vchiq_check_service(service))
 		goto error_exit;
 
-	status = vchiq_bulk_xfer_queue_msg_killable(service, offset, uoffset,
-						    size, userdata, mode, dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params->offset, bulk_params->uoffset,
+						    bulk_params->size, bulk_params->userdata,
+						    bulk_params->mode, bulk_params->dir);
 
 error_exit:
 	vchiq_service_put(service);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 82d27788b10b..186b1395d3a2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -505,9 +505,7 @@ vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
 
 extern int
 vchiq_bulk_xfer_callback(struct vchiq_instance *instance, unsigned int handle,
-			 void *offset, void __user *uoffset, int size,
-			 enum vchiq_bulk_mode mode, void *userdata,
-			 enum vchiq_bulk_dir dir);
+			 struct vchiq_bulk *bulk);
 
 extern void
 vchiq_dump_state(struct seq_file *f, struct vchiq_state *state);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 8043974f8893..f56057e17963 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -335,12 +335,14 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 
 		status = vchiq_bulk_xfer_waiting(instance, args->handle, userdata);
 	} else {
-		userdata = args->userdata;
-
-		status = vchiq_bulk_xfer_callback(instance, args->handle, NULL,
-						  args->data, args->size,
-						  args->mode, userdata, dir);
+		bulk_params.uoffset = args->data;
+		bulk_params.mode = args->mode;
+		bulk_params.size = args->size;
+		bulk_params.dir = dir;
+		bulk_params.userdata = args->userdata;
 
+		status = vchiq_bulk_xfer_callback(instance, args->handle,
+						  &bulk_params);
 	}
 
 	if (!waiter) {
-- 
2.45.2


