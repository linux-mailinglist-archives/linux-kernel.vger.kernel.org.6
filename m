Return-Path: <linux-kernel+bounces-377912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC76A9AC87D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8284928256E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8821AA786;
	Wed, 23 Oct 2024 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="K309Z7iB"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB11AAE33
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681495; cv=none; b=hfp+pMx8ZZKSW73SCzvp6qmCjON12FedDRfOsesalC54ew8Vk/msyQY+CMy8jCJ1j0gvkPkJqDT2UJ25Szknhom++Z6M8XRjq3libz61btk7gGY7aAqXHkjpd5SMNdMdG5vjz4zCzFVnOkWbXcVJoGpmqILptWAO00nhZJ49pFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681495; c=relaxed/simple;
	bh=xHdIxr5t+jY9OyJWLgchvzvtGsJl4NVdoLGbuMoHYRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu4E74MtUxZr8wTj2A0brdIia4BWyAu454ejCkUgrwJZ2aXbzyo7nb/jRI43Boia8A/8VSqbgMoqlTfhntShRFlOroENwwtnVuZFA57Hm7uEoAbmy8gW88pYa0AcVTzuk5iw8bu6X5g4LMmvVItOxDdfYDmqtcrtpGT056NKpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=K309Z7iB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C43E38A9;
	Wed, 23 Oct 2024 13:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681385;
	bh=xHdIxr5t+jY9OyJWLgchvzvtGsJl4NVdoLGbuMoHYRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K309Z7iBlCQIl4pVKDO/iH87GRiGHP+2XDgSd71jOvzw37jnV09aiFPwJ9FxgfS2O
	 MaxBXlc5nVMzurjIR8EVfth49AqTWtWZX3L+/Hcd4vddOZKAZdQo8YmfCdFlhNvL1s
	 n2AVht3QfvxzbS22SbJaVvxIw+kBrzwaDkYOmWeo=
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
Subject: [PATCH 4/6] staging: vchiq: Rename vchiq_completion_data 'bulk_userdata'
Date: Wed, 23 Oct 2024 16:34:04 +0530
Message-ID: <20241023110406.885199-5-umang.jain@ideasonboard.com>
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

In a previous commit, struct vchiq_bulk 'userdata' got renamed to
'cb_data' since it is the data pointer passed in
VCHIQ_BULK_CALLBACK_MODE's callback. Since struct vchiq_completion_data*
structs also has 'bulk_userdata' for completion records, rename
'bulk_userdata' member to 'cb_data' for these structs as well.

This brings consistency and clarity for the struct members. No
functional change in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/include/linux/raspberrypi/vchiq.h       | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c | 8 ++++----
 .../vc04_services/interface/vchiq_arm/vchiq_ioctl.h       | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 6c40d8c1dde6..9a6ab006bed2 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -64,7 +64,7 @@ struct vchiq_completion_data_kernel {
 	enum vchiq_reason reason;
 	struct vchiq_header *header;
 	void *service_userdata;
-	void *bulk_userdata;
+	void *cb_data;
 };
 
 struct vchiq_service_params_kernel {
@@ -73,7 +73,7 @@ struct vchiq_service_params_kernel {
 			enum vchiq_reason reason,
 			struct vchiq_header *header,
 			unsigned int handle,
-			void *bulk_userdata);
+			void *cb_data);
 	void *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c06a57ea9cf5..bcfd4ccc8373 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -662,7 +662,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	completion->reason = reason;
 	/* N.B. service_userdata is updated while processing AWAIT_COMPLETION */
 	completion->service_userdata = user_service->service;
-	completion->bulk_userdata = bulk_userdata;
+	completion->cb_data = bulk_userdata;
 
 	if (reason == VCHIQ_SERVICE_CLOSED) {
 		/*
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index c99cd36a2696..fcdf97391fb6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -414,7 +414,7 @@ struct vchiq_completion_data32 {
 	enum vchiq_reason reason;
 	compat_uptr_t header;
 	compat_uptr_t service_userdata;
-	compat_uptr_t bulk_userdata;
+	compat_uptr_t cb_data;
 };
 
 static int vchiq_put_completion(struct vchiq_completion_data __user *buf,
@@ -428,7 +428,7 @@ static int vchiq_put_completion(struct vchiq_completion_data __user *buf,
 			.reason		  = completion->reason,
 			.header		  = ptr_to_compat(completion->header),
 			.service_userdata = ptr_to_compat(completion->service_userdata),
-			.bulk_userdata	  = ptr_to_compat(completion->bulk_userdata),
+			.cb_data	  = ptr_to_compat(completion->cb_userdata),
 		};
 		if (copy_to_user(&buf32[index], &tmp, sizeof(tmp)))
 			return -EFAULT;
@@ -550,10 +550,10 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 			vchiq_service_put(service);
 
 		/*
-		 * FIXME: address space mismatch, does bulk_userdata
+		 * FIXME: address space mismatch, does cb_data
 		 * actually point to user or kernel memory?
 		 */
-		user_completion.bulk_userdata = completion->bulk_userdata;
+		user_completion.cb_userdata = completion->cb_data;
 
 		if (vchiq_put_completion(args->buf, &user_completion, ret)) {
 			if (ret == 0)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 17550831f86c..afb71a83cfe7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -47,7 +47,7 @@ struct vchiq_completion_data {
 	enum vchiq_reason reason;
 	struct vchiq_header __user *header;
 	void __user *service_userdata;
-	void __user *bulk_userdata;
+	void __user *cb_userdata;
 };
 
 struct vchiq_await_completion {
-- 
2.45.2


