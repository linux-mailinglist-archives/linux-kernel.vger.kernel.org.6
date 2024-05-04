Return-Path: <linux-kernel+bounces-168577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F28BBA5C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792091F2202B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DD217BD3;
	Sat,  4 May 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qXMsbgQr"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F45234;
	Sat,  4 May 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714816074; cv=none; b=HDglfoD/Db2lfA6ziiZMouDiPCZVw4BiW0TPX/SZAl3SXkZha4VNtsjBvz8tgVdn9xDEAW6msNuY6eY+uoHNc7NdKl/7NfcrNGmaxx+4McztgkHtwaOI7jP1g+OF/d28UISXxZ31WYIhR+YnxqFp5V9a5101Z2O05tMvFoAZVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714816074; c=relaxed/simple;
	bh=0RAXrA9ddTunKzQ27o/B/H26iN61m5JOjlIACCixexs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EenVVEiJW1UilZBkGoHWdOFrIi/UXwO+u0vtWZKNabIIbi597ERFuJL2WsV0JnI3nfsSuHO0Q7YaQ9nh7099qEgddUGEzEiTgf1C2SxoLe9XISOhR4p+G4qG/aUcVxrPiBAoOy6oMkt2ay9GfzYCSOqW8UzYskCUWJwbivIM1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qXMsbgQr; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 3BzasNrmCn00P3BzasC921; Sat, 04 May 2024 11:47:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714816063;
	bh=+sxsfrfYccN7R5PHA2bf4kljLQPC2B5E2Xz86Gbnl54=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qXMsbgQrYWfIaNijqNG3tjPKyVfI1+F11JfJnUUJLhwE4yxS3CcyRmvr0X4GwlSGq
	 UHxO9k4aSt7BUvCHEWiQrt6CUGrj5+OEw5K4aBM4nNYZWqgBTIwx74v3IEYoKwBkZi
	 Y/+PplttYcmno9WfdZKVJPVHf1q39sCfLdPV5+HjLoPER5NWjfbDWWSigG3MzaV216
	 l0SEntzJt6EqDqxPzo3lbyNxev8urLdyTTTZRi0vWrN9jdfTGNeBFKcgxpz+7Bu1Pq
	 zVW1J7kGjdvxb9hzCWSjzDV9pWkLOrreex3DMyh3AlwXV8VxLNTy579d8NCloIN0+s
	 eJVLebX5kCnLw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 04 May 2024 11:47:43 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: core: Remove the useless struct usb_devmap which is just a bitmap
Date: Sat,  4 May 2024 11:47:05 +0200
Message-ID: <1d818575ff7a1e8317674aecf761ee23c89fdc84.1714815990.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct usb_devmap is really just a bitmap. No need to have a dedicated
structure for that.

Simplify code and use DECLARE_BITMAP() directly instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

I've re-used the comment related to struct usb_devmap for the devmap field
in struct usb_bus, because it sounds better to me.
---
 drivers/usb/core/hcd.c | 4 ++--
 drivers/usb/core/hub.c | 9 ++++-----
 include/linux/usb.h    | 7 +------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index c0e005670d67..e3366f4d82b9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -866,7 +866,7 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
  */
 static void usb_bus_init (struct usb_bus *bus)
 {
-	memset (&bus->devmap, 0, sizeof(struct usb_devmap));
+	memset(&bus->devmap, 0, sizeof(bus->devmap));
 
 	bus->devnum_next = 1;
 
@@ -962,7 +962,7 @@ static int register_root_hub(struct usb_hcd *hcd)
 
 	usb_dev->devnum = devnum;
 	usb_dev->bus->devnum_next = devnum + 1;
-	set_bit (devnum, usb_dev->bus->devmap.devicemap);
+	set_bit(devnum, usb_dev->bus->devmap);
 	usb_set_device_state(usb_dev, USB_STATE_ADDRESS);
 
 	mutex_lock(&usb_bus_idr_lock);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8939f1410644..4b93c0bd1d4b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2207,13 +2207,12 @@ static void choose_devnum(struct usb_device *udev)
 	mutex_lock(&bus->devnum_next_mutex);
 
 	/* Try to allocate the next devnum beginning at bus->devnum_next. */
-	devnum = find_next_zero_bit(bus->devmap.devicemap, 128,
-			bus->devnum_next);
+	devnum = find_next_zero_bit(bus->devmap, 128, bus->devnum_next);
 	if (devnum >= 128)
-		devnum = find_next_zero_bit(bus->devmap.devicemap, 128, 1);
+		devnum = find_next_zero_bit(bus->devmap, 128, 1);
 	bus->devnum_next = (devnum >= 127 ? 1 : devnum + 1);
 	if (devnum < 128) {
-		set_bit(devnum, bus->devmap.devicemap);
+		set_bit(devnum, bus->devmap);
 		udev->devnum = devnum;
 	}
 	mutex_unlock(&bus->devnum_next_mutex);
@@ -2222,7 +2221,7 @@ static void choose_devnum(struct usb_device *udev)
 static void release_devnum(struct usb_device *udev)
 {
 	if (udev->devnum > 0) {
-		clear_bit(udev->devnum, udev->bus->devmap.devicemap);
+		clear_bit(udev->devnum, udev->bus->devmap);
 		udev->devnum = -1;
 	}
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9e52179872a5..1913a13833f2 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -440,11 +440,6 @@ int __usb_get_extra_descriptor(char *buffer, unsigned size,
 
 /* ----------------------------------------------------------------------- */
 
-/* USB device number allocation bitmap */
-struct usb_devmap {
-	unsigned long devicemap[128 / (8*sizeof(unsigned long))];
-};
-
 /*
  * Allocated per bus (tree of devices) we have:
  */
@@ -472,7 +467,7 @@ struct usb_bus {
 					 * round-robin allocation */
 	struct mutex devnum_next_mutex; /* devnum_next mutex */
 
-	struct usb_devmap devmap;	/* device address allocation map */
+	DECLARE_BITMAP(devmap, 128);	/* USB device number allocation bitmap */
 	struct usb_device *root_hub;	/* Root hub */
 	struct usb_bus *hs_companion;	/* Companion EHCI bus, if any */
 
-- 
2.45.0


