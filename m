Return-Path: <linux-kernel+bounces-309980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662689672AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DEE1C21282
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1717E016;
	Sat, 31 Aug 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HkVMqz3U"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4117C7C1
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121498; cv=none; b=g2dE3rY+t6gkLwDeP8MrtY4dAVvXFdCgiHSPcUDmRdhjhQHwsUPNJkrJ1DnkUJr9x3Y1tGDr7l5iTv8ntEVwy95zqvbIE4v5zaeI/8WxBV/sSf3XGtpU3epnzWTb+ttcH+xLX4DXxPHOu/DC6LbDgioFlLpLQXa7NqAN/fMAkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121498; c=relaxed/simple;
	bh=NaHRU+VE5tx4gO3okmfGifbbUSInO0MbdAS4zEZgWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRVACMtDf1cmGlt5HV/Bir3dA/v6O9KxqRHAKNWVBxLgX3INaJ6bxatkoJN9Ao1hGz/++Qgq+MY/C0h+yl050/coGbbEiKEIZd8OANwizC7hhkqH59sRi6lSqmLKl7a/KGLGLUWT5swzOeK9Uhpvj0UrP+pOmW91zX+YmQtUzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HkVMqz3U; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 620E67FE;
	Sat, 31 Aug 2024 18:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121425;
	bh=NaHRU+VE5tx4gO3okmfGifbbUSInO0MbdAS4zEZgWdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkVMqz3UwMgE/2nwRf5eOT2rDE5HPIDzlHW7cPTUqGEX5fEvopu6QIwGOi+Oa7w6T
	 UfPfr7dlRmduNvsQJ+1r5ot64qLzibOv4YRqqhay86oGbGbByH6/7DAQw8trW0llE4
	 Fxq2B7ExbiXCWKNpCuek2cI9ARB3auTl/AgKrsbQ=
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
Subject: [PATCH v2 4/7] staging: vchiq_core: Factor out bulk transfer for (no/)callback mode
Date: Sat, 31 Aug 2024 21:54:32 +0530
Message-ID: <20240831162435.191084-5-umang.jain@ideasonboard.com>
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

Factor out bulk transfer for VCHIQ_BULK_MODE_NOCALLBACK and
VCHIQ_BULK_MODE_CALLBACK mode into a separate dedicated function
bulk_xfer_callback_interruptible(). It is suffixed by "_interruptible"
to denote that it can be interrupted and -EAGAIN can be returned. It
would be up to the users of the function to retry the call in those cases.

bulk_xfer_callback_interruptible() also takes in 'mode' parameter to
differentiate between VCHIQ_BULK_MODE_NOCALLBACK and
VCHIQ_BULK_MODE_CALLBACK, which then is directly passed to
vchiq_bulk_xfer_queue_msg_interruptible() inside the function.

Adjust the calls to vchiq-dev.c ioctl interface and vchiq_arm.c
for the respective bulk transfers.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 15 +++----
 .../interface/vchiq_arm/vchiq_core.c          | 40 +++++++++++++++++++
 .../interface/vchiq_arm/vchiq_core.h          |  6 +++
 .../interface/vchiq_arm/vchiq_dev.c           |  6 +++
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 688c9b1be868..3dbeffc650d3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -857,10 +857,10 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 		switch (mode) {
 		case VCHIQ_BULK_MODE_NOCALLBACK:
 		case VCHIQ_BULK_MODE_CALLBACK:
-			ret = vchiq_bulk_transfer(instance, handle,
-						  (void *)data, NULL,
-						  size, userdata, mode,
-						  VCHIQ_BULK_TRANSMIT);
+			ret = vchiq_bulk_xfer_callback_interruptible(instance, handle,
+								     (void *)data, NULL,
+								     size, mode, userdata,
+								     VCHIQ_BULK_TRANSMIT);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
 			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
@@ -895,9 +895,10 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		switch (mode) {
 		case VCHIQ_BULK_MODE_NOCALLBACK:
 		case VCHIQ_BULK_MODE_CALLBACK:
-			ret = vchiq_bulk_transfer(instance, handle, data, NULL,
-						  size, userdata,
-						  mode, VCHIQ_BULK_RECEIVE);
+			ret = vchiq_bulk_xfer_callback_interruptible(instance, handle,
+								     (void *)data, NULL,
+								     size, mode, userdata,
+								     VCHIQ_BULK_RECEIVE);
 			break;
 		case VCHIQ_BULK_MODE_BLOCKING:
 			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index b37899d46b57..51fe18499e87 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3021,6 +3021,46 @@ vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned
 	return status;
 }
 
+int
+vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int handle,
+				       void *offset, void __user *uoffset, int size,
+				       enum vchiq_bulk_mode mode, void *userdata,
+				       enum vchiq_bulk_dir dir)
+{
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
+	int status = -EINVAL;
+
+	if (!service)
+		goto error_exit;
+
+	if (mode != VCHIQ_BULK_MODE_CALLBACK &&
+	    mode != VCHIQ_BULK_MODE_NOCALLBACK)
+		goto error_exit;
+
+	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
+		goto error_exit;
+
+	if (!offset && !uoffset)
+		goto error_exit;
+
+	if (vchiq_check_service(service))
+		goto error_exit;
+
+	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset,
+							 size, userdata, mode, dir);
+	if (status)
+		goto error_exit;
+
+	vchiq_service_put(service);
+
+	return 0;
+
+error_exit:
+	if (service)
+		vchiq_service_put(service);
+	return status;
+}
+
 /*
  * This function may be called by kernel threads or user threads.
  * User threads may receive -EAGAIN to indicate that a signal has been
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 2dd89101c1c6..9c8c076eaaeb 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -479,6 +479,12 @@ vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned
 				       void *offset, void __user *uoffset, int size,
 				       void __user *userdata, enum vchiq_bulk_dir dir);
 
+extern int
+vchiq_bulk_xfer_callback_interruptible(struct vchiq_instance *instance, unsigned int handle,
+				       void *offset, void __user *uoffset, int size,
+				       enum vchiq_bulk_mode mode, void *userdata,
+				       enum vchiq_bulk_dir dir);
+
 extern int
 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
 		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 830633f2326b..169a2ffda996 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -336,6 +336,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		goto bulk_transfer_handled;
 	} else {
 		userdata = args->userdata;
+
+		status = vchiq_bulk_xfer_callback_interruptible(instance, args->handle, NULL,
+								args->data, args->size,
+								args->mode, userdata, dir);
+
+		goto bulk_transfer_handled;
 	}
 
 	status = vchiq_bulk_transfer(instance, args->handle, NULL, args->data, args->size,
-- 
2.45.2


