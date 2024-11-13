Return-Path: <linux-kernel+bounces-407734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757549C7239
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D83B1F21FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785A44C7C;
	Wed, 13 Nov 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnxD/2RM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC02259C;
	Wed, 13 Nov 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506687; cv=none; b=kSiO12f7Rt1KGXRfRIHOZTmrNGe44LlmCT+r+ureGYeG1cVO67XEaW3w248yn0UGpGl870uLFAgBrwEsxxmBjdAjzB2obZomgjvW2H35UIXhs3MXh6CsHtkzej9xliuFQ882ZOeW/4zxQafbpXNxiTJM6gqk1DiHmq5imAda1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506687; c=relaxed/simple;
	bh=Kuwa1HPUSpT4CGmTqdocbMhT6tHj/MeXv9HrB20dCqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJRdvLrkj9NLIUyG79v/WaZzu6Kx5uT12G/RjjOfFSyP5nRqQGVHcj0M4L+7e1qjbeVo05dBl1vgT6w8dNkMLJA0uZEoCKxqixauBJBjSgm5NsnjSHRD4pypd4+jWg1HPjJihe2x1jGtTn00tnoee5ikH9SUiZe2FgiQB+yrMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnxD/2RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E830AC4CEC3;
	Wed, 13 Nov 2024 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731506686;
	bh=Kuwa1HPUSpT4CGmTqdocbMhT6tHj/MeXv9HrB20dCqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnxD/2RMVZS5ae0umyTA0TheVwk0nRHZecueoWKMIeSwmpmVNDyz4UZ0F8N10tOqt
	 +AsQnrY3C4XYy40AJ4w3YuVfu+S5pW0JTAkygX4oUaNOnu0RJ9Gt1KB4RnhCsKBgLv
	 LQpP3/+2tihLLkkUZKcTy+kim7+fHYsAlBIHWMWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Grant Grundler <grundler@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/2] USB: make to_usb_device_driver() use container_of_const()
Date: Wed, 13 Nov 2024 15:04:41 +0100
Message-ID: <2024111342-lagoon-reapprove-5e49@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111339-shaky-goldsmith-b233@gregkh>
References: <2024111339-shaky-goldsmith-b233@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 75
X-Developer-Signature: v=1; a=openpgp-sha256; l=3207; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Kuwa1HPUSpT4CGmTqdocbMhT6tHj/MeXv9HrB20dCqg=; b=owGbwMvMwCRo6H6F97bub03G02pJDOkmG39tml/umaMoMW39rWmih2S4ulOuB713sHwruKuqP NRRe+K9jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIVxnDfJ8lsff3Xfwz98K7 3ssW3qdmmRxOY2VYcEL4VJSE8JeZe+SOqSzY95HrvPycUgA=
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
v2: reordered patches, goes on top of series submitted at https://lore.kernel.org/r/2024111322-kindly-finalist-d247@gregkh

 drivers/usb/core/driver.c | 4 ++--
 drivers/usb/core/usb.h    | 2 +-
 include/linux/usb.h       | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index bc5c561bdbd5..f203fdbfb6f6 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -850,7 +850,7 @@ const struct usb_device_id *usb_device_match_id(struct usb_device *udev,
 EXPORT_SYMBOL_GPL(usb_device_match_id);
 
 bool usb_driver_applicable(struct usb_device *udev,
-			   struct usb_device_driver *udrv)
+			   const struct usb_device_driver *udrv)
 {
 	if (udrv->id_table && udrv->match)
 		return usb_device_match_id(udev, udrv->id_table) != NULL &&
@@ -870,7 +870,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
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
index 7a9e96f9d886..cfa8005e24f9 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1294,8 +1294,7 @@ struct usb_device_driver {
 	unsigned int supports_autosuspend:1;
 	unsigned int generic_subclass:1;
 };
-#define	to_usb_device_driver(d) container_of(d, struct usb_device_driver, \
-		driver)
+#define	to_usb_device_driver(d) container_of_const(d, struct usb_device_driver, driver)
 
 /**
  * struct usb_class_driver - identifies a USB driver that wants to use the USB major number
-- 
2.47.0


