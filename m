Return-Path: <linux-kernel+bounces-567339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43224A684B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD03BFC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDA24EA96;
	Wed, 19 Mar 2025 06:01:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151781598F4;
	Wed, 19 Mar 2025 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364108; cv=none; b=Ut74x2Cfaepjn4Ng5GLnm2d5Qa1OIxHMSX7vFHIIhO2wG3GJteXPQyUqyQwmwQ5XWE1rREFh454fLC8tiC720mRqH7NH04ecRENkM2PQIq5qpHA6LAfJwRQn/11mnRlo28d4MfrZmqKh9WUHpM/eruvgQPTdIj2O01oYqjllTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364108; c=relaxed/simple;
	bh=O+/3bAgQEXsLeTYbZ+T8NDIikrDwqM7YBfVeNvN53yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDwLXr9eF+0tg3hBXJ3TG+sXRbrrLrcT9/cn/DIYsPw+f3uE8PUSuTU/I/R530tdHpSP62Ljq1vLpdSnY81vjgjSOlpwrM7DWKa1gQF8EfGR5xMgR23FN8mWT3iIf7YhffiIBYEhHYcdrXp/a2VXraWQO9dLghnNO4kTSwsmIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9c1c73f6048711f0a216b1d71e6e1362-20250319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b0055900-673b-4e67-85ca-cce063e7a286,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:84368d1a854d9369a4807f4faecb4f4d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9c1c73f6048711f0a216b1d71e6e1362-20250319
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 571012771; Wed, 19 Mar 2025 14:01:33 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 42DBC16011396;
	Wed, 19 Mar 2025 14:01:33 +0800 (CST)
X-ns-mid: postfix-67DA5DBC-916915388
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 0111B16008107;
	Wed, 19 Mar 2025 06:01:31 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	stefan.eichenberger@toradex.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: [PATCH WITHDRAWN] usb: core: Add boot delay for DH34 board in restore mode
Date: Wed, 19 Mar 2025 14:00:46 +0800
Message-ID: <20250319060046.3438058-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306061749.1502029-1-lijiayi@kylinos.cn>
References: <20250306061749.1502029-1-lijiayi@kylinos.cn>
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


