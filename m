Return-Path: <linux-kernel+bounces-548273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A545A542AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B52A7A207D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711281A073F;
	Thu,  6 Mar 2025 06:18:24 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129C3B1A2;
	Thu,  6 Mar 2025 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741241904; cv=none; b=CeNBfZcPTZQA97HdBvuY0GacoKuCqn0ahkyB71d8e3qhPwzNc9kXXSizpNCrH3xL9LsNLO2Y5oAyf9YZxQznNveNyTS7rH3GmrJFZ/6eXd7srcTYiQCpGhCPPnagppy3/lKzLRPAO7yuUi73ki3ou91FZFThFVxgeks1Nfr+yDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741241904; c=relaxed/simple;
	bh=O+/3bAgQEXsLeTYbZ+T8NDIikrDwqM7YBfVeNvN53yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTSrDLIjJyMufBaUIP1uBWFoTrfYkBTVw19x1aX/3XdQUw/JlAKuV0hR1ITfB3JK8UgSc/14Ffj0xwjxMKKULqKAe13rPK5/d04cLO8mjmzrynLpqRSycZTEHgo0gxmMFO8UceWaV9uED+fRE9HJmU2P0IlE8niZO2EeNNa7iYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c3f0f09efa5211efa216b1d71e6e1362-20250306
X-CID-CACHE: Type:Local,Time:202503061359+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:217f6337-3745-4702-b890-22111a4c6735,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d2a5be9f1788118d269b86d08de2a31c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c3f0f09efa5211efa216b1d71e6e1362-20250306
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1842131581; Thu, 06 Mar 2025 14:18:05 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 14AD116002081;
	Thu,  6 Mar 2025 14:18:05 +0800 (CST)
X-ns-mid: postfix-67C93E1C-888754310
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 49E4916002081;
	Thu,  6 Mar 2025 06:18:03 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	stefan.eichenberger@toradex.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: [PATCH v1] usb: core: Add boot delay for DH34 board in restore mode
Date: Thu,  6 Mar 2025 14:17:49 +0800
Message-ID: <20250306061749.1502029-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On certain DH34-model motherboards, USB keyboards may fail to respond
during the restore mode confirmation prompt due to the usbhid driver
not being fully initialized when device registration occurs. This
results in inability to input 'y'/'n' confirmation.

Detect this scenario by:
1. Checking DMI_BOARD_NAME for "DH34" substring
2. Verifying "restore" in kernel command line

Introduce a 200ms delay before device registration when both conditions
are met. This allows sufficient time for the usbhid driver to properly
initialize before user interaction is required.

Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
---
 drivers/usb/core/hub.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a76bb50b6202..b81b518f438b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -36,6 +36,7 @@
 #include <linux/bitfield.h>
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
+#include <linux/dmi.h>
=20
 #include "hub.h"
 #include "phy.h"
@@ -2610,6 +2611,7 @@ static void set_usb_port_removable(struct usb_devic=
e *udev)
 int usb_new_device(struct usb_device *udev)
 {
 	int err;
+	const char *board_name;
=20
 	if (udev->parent) {
 		/* Initialize non-root-hub device wakeup to disabled;
@@ -2656,6 +2658,17 @@ int usb_new_device(struct usb_device *udev)
 	/* check whether the hub or firmware marks this port as non-removable *=
/
 	set_usb_port_removable(udev);
=20
+	/* get board manufacturer information (DMI_BOARD_VENDOR) */
+	board_name =3D dmi_get_system_info(DMI_BOARD_NAME);
+
+	/* In order to load the usbhid driver on a specific model motherboards
+	 * before the restore mode confirmation, add 200ms of latancy.
+	 */
+	if (board_name && strstr(board_name, "DH34") &&
+		(strstr(saved_command_line, "restore") !=3D NULL))
+		msleep(200);
+
+
 	/* Register the device.  The device driver is responsible
 	 * for configuring the device and invoking the add-device
 	 * notifier chain (used by usbfs and possibly others).
--=20
2.47.1


