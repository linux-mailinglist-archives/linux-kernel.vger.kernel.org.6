Return-Path: <linux-kernel+bounces-309979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BB9672AA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01188B22318
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF617C7C2;
	Sat, 31 Aug 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L835z0GY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65616D9DF
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121496; cv=none; b=ivHeU3ZtRqpQXKMCsu2eAf9WvIPDyx/kFqpxGkNUFcz0IsKrRCeBwbs3N/M9VQGCceEC/wRlpu4gMzTNAn/OJGFHR/quj4aKlQvN2HcGseM1nE3ldniZ+EaRsh2OgzKEgdJkGyQQRPb29zM9Y5bStT1ZaUw4wvp/2/CAxt0KXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121496; c=relaxed/simple;
	bh=0pbXxGUd1bi2OESgX8APm1ezqNo7xcQaD1ARKfVMAio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usYEC/0vp8UKWHilHqUP9O0ET+D0mb3CbZMmcAeTorZOfRZSeGGqDQft5z9rvegi7tI//Dz1AbYqiiHJs17DFeIy6DIuBhIGtZnkJZsNIRertUlgn8SV24bG1wcfz7QYpDX1KBpAbav2YUO+XNBLGHEKiNntXKflMhWzAKo9Akw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=L835z0GY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E6069667;
	Sat, 31 Aug 2024 18:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121422;
	bh=0pbXxGUd1bi2OESgX8APm1ezqNo7xcQaD1ARKfVMAio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L835z0GYoWQ043ytHw+aDwY/R4fxFwSC6bPshPB7D/w6VYgDTCl7vC+K6gzCcAwuh
	 RW6kevK94RFDrJsP+GVjeLX9+VKM75yhK+NkZmaUulcP91FzsX0N7FAnNshM5uRUJx
	 C15XT4b/wCFck7ZZvnuSaVEPBd9d+pLDpvNeL9ks=
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
Subject: [PATCH v2 3/7] staging: vchiq_core: Factor out bulk transfer for blocking mode
Date: Sat, 31 Aug 2024 21:54:31 +0530
Message-ID: <20240831162435.191084-4-umang.jain@ideasonboard.com>
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

Factor out bulk transfer for blocking mode into a separate dedicated
function bulk_xfer_blocking_interruptible(). It is suffixed by
"_interruptible" to denote that it can be interrupted and -EAGAIN
can be returned. It would be up to the users of the function to retry
the call in those cases.

Adjust the calls to vchiq-dev.c ioctl interface and vchiq_arm.c
for blocking bulk transfers.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           |  5 +--
 .../interface/vchiq_arm/vchiq_core.c          | 44 ++++++++++++++++---
 .../interface/vchiq_arm/vchiq_core.h          |  5 +++
 .../interface/vchiq_arm/vchiq_dev.c           |  6 +++
 4 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c4d97dbf6ba8..688c9b1be868 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -968,9 +968,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 			return -ENOMEM;
 	}
 
-	ret = vchiq_bulk_transfer(instance, handle, data, NULL, size,
-				  &waiter->bulk_waiter,
-				  VCHIQ_BULK_MODE_BLOCKING, dir);
+	ret = vchiq_bulk_xfer_blocking_interruptible(instance, handle, data, NULL, size,
+						     &waiter->bulk_waiter, dir);
 	if ((ret != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 067259f55664..b37899d46b57 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2985,6 +2985,42 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 	return status;
 }
 
+int
+vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned int handle,
+				       void *offset, void __user *uoffset, int size,
+				       void __user *userdata, enum vchiq_bulk_dir dir)
+{
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
+	struct bulk_waiter *bulk_waiter = NULL;
+	enum vchiq_bulk_mode mode = VCHIQ_BULK_MODE_BLOCKING;
+	int status = -EINVAL;
+
+	if (!service)
+		return -EINVAL;
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
+	bulk_waiter = userdata;
+	init_completion(&bulk_waiter->event);
+	bulk_waiter->actual = 0;
+	bulk_waiter->bulk = NULL;
+
+	status = vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uoffset, size,
+							 userdata, mode, dir);
+
+error_exit:
+	vchiq_service_put(service);
+
+	return status;
+}
+
 /*
  * This function may be called by kernel threads or user threads.
  * User threads may receive -EAGAIN to indicate that a signal has been
@@ -2998,7 +3034,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 			enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	struct bulk_waiter *bulk_waiter = NULL;
+	struct bulk_waiter *bulk_waiter;
 	struct vchiq_bulk *bulk;
 	int status = -EINVAL;
 
@@ -3018,12 +3054,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	case VCHIQ_BULK_MODE_NOCALLBACK:
 	case VCHIQ_BULK_MODE_CALLBACK:
 		break;
-	case VCHIQ_BULK_MODE_BLOCKING:
-		bulk_waiter = userdata;
-		init_completion(&bulk_waiter->event);
-		bulk_waiter->actual = 0;
-		bulk_waiter->bulk = NULL;
-		break;
 	default:
 		goto error_exit;
 	}
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 985d9ea3a06a..2dd89101c1c6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -474,6 +474,11 @@ extern int
 vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
 				      unsigned int handle, struct bulk_waiter *userdata);
 
+extern int
+vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsigned int handle,
+				       void *offset, void __user *uoffset, int size,
+				       void __user *userdata, enum vchiq_bulk_dir dir);
+
 extern int
 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
 		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 550838d2863b..830633f2326b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -304,6 +304,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		}
 
 		userdata = &waiter->bulk_waiter;
+
+		status = vchiq_bulk_xfer_blocking_interruptible(instance, args->handle,
+								NULL, args->data, args->size,
+								userdata, dir);
+
+		goto bulk_transfer_handled;
 	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_for_each_entry(iter, &instance->bulk_waiter_list,
-- 
2.45.2


