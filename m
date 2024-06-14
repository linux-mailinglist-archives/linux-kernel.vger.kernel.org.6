Return-Path: <linux-kernel+bounces-214866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A983908B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65428B2312F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819419644B;
	Fri, 14 Jun 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="segs75tm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827E192B98;
	Fri, 14 Jun 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367117; cv=none; b=tXVD/7zdXPt1qreZyZV+yfTVSroF0ZDzqv6cMVUPN1WLErRUMvMRYD5C+R6Q31BAf+69zaM1dd8+UdLuxJM1BumAErbQBuBtiZLEBYB1n/zw+R6Iz8CW3WAMIjliafSCpKYkrL5YPvCbl6R/bRMOxphmkpLqqvxbY+f3wznlCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367117; c=relaxed/simple;
	bh=aWCY1aJm0OUGDkP3er9YqI5eYDuhfcLrTmx6H7rZDmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFzPycnDCUTQSjgd/HF9/hyliC1k+8dUo77q/4Q8IyZ1ncQr1Y6kwxtHTvA4MpNav2VztEHV6s3JCHHDrtvlj0Afb0mve3dRejXFm3ybpIDY7DEuwAlgcafnxhO+014I9OaI9rGcUI1a7CkdwwWaLiK6SWi4TGqIEeThFooZKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=segs75tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4821EC2BD10;
	Fri, 14 Jun 2024 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718367116;
	bh=aWCY1aJm0OUGDkP3er9YqI5eYDuhfcLrTmx6H7rZDmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=segs75tmF9EF+LZW2AFx0a9S+eT01AUO3Z+ErLo2XbWAag8FvWZEeN4a5FpyzHbMH
	 BXfYDQ8l1jntuMlg4X+23878dMlpDuh9ApmU0llX/NUvLefKCAkvHMBzsR+kcLij4E
	 5yDRqEqJpI3pi+EE4nYHldNHHh7RNJ3dTnOczpzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/4] USB: make to_usb_device_driver() use container_of_const()
Date: Fri, 14 Jun 2024 14:11:50 +0200
Message-ID: <2024061451-deviator-scabbed-2131@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061448-manly-universal-00ad@gregkh>
References: <2024061448-manly-universal-00ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 73
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=aWCY1aJm0OUGDkP3er9YqI5eYDuhfcLrTmx6H7rZDmk=; b=owGbwMvMwCRo6H6F97bub03G02pJDGk5xu13V/+JfWdVM39B6YH57j5+pevlzsj+//N+Xdb1G Wd9PxWs64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJVPxhmKco9/hL0CXH80f5 +UMFxJbd/jp1x1uGOZzfiiZ9m8W+mn9Sx3PGJrtdxo8ufwAA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Turns out that we have some const pointers being passed to
to_usb_device_driver() but were not catching this.  Change the macro to
properly propagate the const-ness of the pointer so that we will notice
when we try to write to memory that we shouldn't be writing to.

This requires fixing up the usb_driver_applicable() function as well,
because it can handle a const * to struct usb_driver.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Yajun Deng <yajun.deng@linux.dev>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/driver.c | 4 ++--
 drivers/usb/core/usb.h    | 2 +-
 include/linux/usb.h       | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index c985a272e552..d0fb2f315d65 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -840,7 +840,7 @@ const struct usb_device_id *usb_device_match_id(struct usb_device *udev,
 EXPORT_SYMBOL_GPL(usb_device_match_id);
 
 bool usb_driver_applicable(struct usb_device *udev,
-			   struct usb_device_driver *udrv)
+			   const struct usb_device_driver *udrv)
 {
 	if (udrv->id_table && udrv->match)
 		return usb_device_match_id(udev, udrv->id_table) != NULL &&
@@ -860,7 +860,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 	/* devices and interfaces are handled separately */
 	if (is_usb_device(dev)) {
 		struct usb_device *udev;
-		struct usb_device_driver *udrv;
+		const struct usb_device_driver *udrv;
 
 		/* interface drivers never match devices */
 		if (!is_usb_device_driver(drv))
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index b8324ea05b20..a9b37aeb515b 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -75,7 +75,7 @@ extern int usb_match_device(struct usb_device *dev,
 extern const struct usb_device_id *usb_device_match_id(struct usb_device *udev,
 				const struct usb_device_id *id);
 extern bool usb_driver_applicable(struct usb_device *udev,
-				  struct usb_device_driver *udrv);
+				  const struct usb_device_driver *udrv);
 extern void usb_forced_unbind_intf(struct usb_interface *intf);
 extern void usb_unbind_and_rebind_marked_interfaces(struct usb_device *udev);
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 4390426973f4..5c619e8240fe 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1283,8 +1283,7 @@ struct usb_device_driver {
 	unsigned int supports_autosuspend:1;
 	unsigned int generic_subclass:1;
 };
-#define	to_usb_device_driver(d) container_of(d, struct usb_device_driver, \
-		driver)
+#define	to_usb_device_driver(d) container_of_const(d, struct usb_device_driver, driver)
 
 /**
  * struct usb_class_driver - identifies a USB driver that wants to use the USB major number
-- 
2.45.2


