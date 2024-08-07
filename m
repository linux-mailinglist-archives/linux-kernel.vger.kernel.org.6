Return-Path: <linux-kernel+bounces-278060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150594AA48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A291C20F45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996408121F;
	Wed,  7 Aug 2024 14:37:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79637E0E9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041425; cv=none; b=GfO1B6JHtvppsLmyGFI1AuYUbjKU5i/KxoYvCdPmZKs/IqCUcOJuTCW6NyzePTaAeVjOwJ86ttLm7DE4erc7VvnDBFXKjWf+NiTDN9r5F7zkzeMa/4URXmLxM4bqxrvp6PtMEOLyA4VqeQ+wSbSTkXeEQbEP8myV3U8ym0OlKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041425; c=relaxed/simple;
	bh=CWJVjRJL3Iy2iDf4saj3FvA/JduymDRbukIlMV/8hK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUQkqxmMElTTQ6JfB0W8qzko4h6nCXfGS1aI57ozIqvMV2Cvwq2dsXOpHaH0B5owF/QaDHwoWnu5iE9gEwlyvqZI1Z3mjqaYkKfOmssFrPzqo8SapRwWdBBG4x16VxkbWnnapF+asbXq3W3H6JnxGbceHGLrxz2RsNyfI1vf7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sbhme-0004Iv-Ie; Wed, 07 Aug 2024 16:37:00 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 07 Aug 2024 16:36:51 +0200
Subject: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev port
 features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-0-f33ce21353c9@pengutronix.de>
In-Reply-To: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-0-f33ce21353c9@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On board devices may require special handling for en-/disable port
features due to PCB design decisions e.g. enable/disable the VBUS power
on the port. This commit adds the necessary infrastructure to prepare
the common code base for such use-cases.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/core/hub.c             | 22 ++++++++++++++++++++--
 drivers/usb/misc/onboard_usb_dev.c | 13 +++++++++++++
 include/linux/usb/onboard_dev.h    |  6 ++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..e639c25a729c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -450,9 +450,18 @@ static int clear_hub_feature(struct usb_device *hdev, int feature)
  */
 int usb_clear_port_feature(struct usb_device *hdev, int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	int ret;
+
+	ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
 		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
 		NULL, 0, 1000);
+	if (ret)
+		return ret;
+
+	if (!is_root_hub(hdev))
+		ret = onboard_dev_port_feature(hdev, false, feature, port1);
+
+	return ret;
 }
 
 /*
@@ -460,9 +469,18 @@ int usb_clear_port_feature(struct usb_device *hdev, int port1, int feature)
  */
 static int set_port_feature(struct usb_device *hdev, int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	int ret;
+
+	ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
 		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
 		NULL, 0, 1000);
+	if (ret)
+		return ret;
+
+	if (!is_root_hub(hdev))
+		ret = onboard_dev_port_feature(hdev, true, feature, port1);
+
+	return ret;
 }
 
 static char *to_led_name(int selector)
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index f2bcc1a8b95f..f61de2c353d0 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -520,6 +520,19 @@ static struct usb_device_driver onboard_dev_usbdev_driver = {
 	.id_table = onboard_dev_id_table,
 };
 
+/************************** USB control **************************/
+
+int onboard_dev_port_feature(struct usb_device *udev, bool set,
+			     int feature, int port1)
+{
+	switch (feature) {
+	default:
+		return 0;
+	}
+}
+
+/************************** Kernel module ************************/
+
 static int __init onboard_dev_init(void)
 {
 	int ret;
diff --git a/include/linux/usb/onboard_dev.h b/include/linux/usb/onboard_dev.h
index b79db6d193c8..45e1f7b844d6 100644
--- a/include/linux/usb/onboard_dev.h
+++ b/include/linux/usb/onboard_dev.h
@@ -9,10 +9,16 @@ struct list_head;
 #if IS_ENABLED(CONFIG_USB_ONBOARD_DEV)
 void onboard_dev_create_pdevs(struct usb_device *parent_dev, struct list_head *pdev_list);
 void onboard_dev_destroy_pdevs(struct list_head *pdev_list);
+int onboard_dev_port_feature(struct usb_device *udev, bool set, int feature, int port1);
 #else
 static inline void onboard_dev_create_pdevs(struct usb_device *parent_dev,
 					    struct list_head *pdev_list) {}
 static inline void onboard_dev_destroy_pdevs(struct list_head *pdev_list) {}
+static inline int onboard_dev_port_feature(struct usb_device *udev, bool set,
+					   int feature, int port1)
+{
+	return 0;
+}
 #endif
 
 #endif /* __LINUX_USB_ONBOARD_DEV_H */

-- 
2.39.2


