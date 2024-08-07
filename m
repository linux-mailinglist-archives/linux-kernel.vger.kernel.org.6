Return-Path: <linux-kernel+bounces-278059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830A94AA45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3DC1C2112B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9E80026;
	Wed,  7 Aug 2024 14:37:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF47E0F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041424; cv=none; b=a+9XBgJwiOdlzhRgMSnOyIMgb+ZRG4ZNrno+gm+l5/n0SfYoOnL7x0+f2matomtmgtcH04UOlXNY5z6Y3OvgFaCmBynY6qOrt1lPm0jRBtcdZGhKaUm5NtbEgYluPb1+3MRDoiwd8Be8RgeBQlTXZibcwkgL/3mIQkcIo/trivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041424; c=relaxed/simple;
	bh=6Ex9JBBQeeumu+5bfMADPiTKVhDkyAOukkLhCDuwNR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJqQRjLKxBE04fJD8rMYvdfErf9iK4mkqHnBgvnXf4IE/mGwuyBInGLDD7osE10JKDGnSLxEh5q+WRLkrdobC2jN1pG5rObKb5dGUiAw3Z3p7Qzv2pIxbpBHNvrsAeTxmB7EespRhS3QbgnRg/cFg5X+n8B7yyGj5BF05E6HSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sbhme-0004Iv-Nh; Wed, 07 Aug 2024 16:37:00 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 07 Aug 2024 16:36:53 +0200
Subject: [PATCH 3/3] usb: misc: onboard_dev: add ext-vbus-supply handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-3-f33ce21353c9@pengutronix.de>
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

Add support to power the port VBUS via host controlled regulators since
some embedded hub PCB designs don't connect the dedicated USB hub port
power GPIO accordingly.

To support the above use-case the USB_PORT_FEAT_POWER port feature
handling must be added. At the moment this feature is limited to the
following hubs:
  - usb424,2412
  - usb424,2414
  - usb424,2417.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/misc/onboard_usb_dev.c | 63 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index f61de2c353d0..f8ca6ef9956b 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -36,6 +36,8 @@ static DECLARE_WORK(attach_usb_driver_work, onboard_dev_attach_usb_driver);
 
 /************************** Platform driver **************************/
 
+#define MAX_DOWNSTREAM_PORTS	7
+
 struct usbdev_node {
 	struct usb_device *udev;
 	struct list_head list;
@@ -52,6 +54,7 @@ struct onboard_dev {
 	struct list_head udev_list;
 	struct mutex lock;
 	struct clk *clk;
+	struct regulator *ext_vbus_supplies[MAX_DOWNSTREAM_PORTS];
 };
 
 static int onboard_dev_get_regulators(struct onboard_dev *onboard_dev)
@@ -212,6 +215,48 @@ static int onboard_dev_add_usbdev(struct onboard_dev *onboard_dev,
 	return err;
 }
 
+static int onboard_dev_port_power(struct onboard_dev *onboard_dev, int port1,
+				  bool enable)
+{
+	struct regulator *vbus_supply;
+
+	vbus_supply = onboard_dev->ext_vbus_supplies[port1 - 1];
+
+	/* External supplies are optional */
+	if (!vbus_supply)
+		return 0;
+
+	if (enable)
+		return regulator_enable(vbus_supply);
+
+	return regulator_disable(vbus_supply);
+}
+
+static int onboard_dev_add_ext_vbus_supplies(struct onboard_dev *onboard_dev)
+{
+	struct device *dev = onboard_dev->dev;
+	unsigned int i;
+
+	if (!onboard_dev->pdata->support_ext_vbus_supplies)
+		return 0;
+
+	for (i = 0; i < MAX_DOWNSTREAM_PORTS; i++) {
+		char *supply_name = "portX-vbus";
+		struct regulator *reg;
+
+		sprintf(supply_name, "port%u-vbus", i + 1);
+		reg = devm_regulator_get_optional(dev, supply_name);
+		if (!IS_ERR(reg)) {
+			onboard_dev->ext_vbus_supplies[i] = reg;
+		} else {
+			if (PTR_ERR(reg) != -ENODEV)
+				return PTR_ERR(reg);
+		}
+	}
+
+	return 0;
+}
+
 static void onboard_dev_remove_usbdev(struct onboard_dev *onboard_dev,
 				      const struct usb_device *udev)
 {
@@ -339,6 +384,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = onboard_dev_add_ext_vbus_supplies(onboard_dev);
+	if (err)
+		return err;
+
 	/*
 	 * The USB driver might have been detached from the USB devices by
 	 * onboard_dev_remove() (e.g. through an 'unbind' by userspace),
@@ -525,7 +574,21 @@ static struct usb_device_driver onboard_dev_usbdev_driver = {
 int onboard_dev_port_feature(struct usb_device *udev, bool set,
 			     int feature, int port1)
 {
+	struct device *dev = &udev->dev;
+	struct onboard_dev *onboard_dev;
+
+	if (!dev->of_node)
+		return 0;
+
+	onboard_dev = _find_onboard_dev(dev);
+	if (IS_ERR(onboard_dev))
+		return 0;
+
 	switch (feature) {
+	case USB_PORT_FEAT_POWER:
+		if (!onboard_dev->pdata->is_hub)
+			return -EINVAL;
+		return onboard_dev_port_power(onboard_dev, port1, set);
 	default:
 		return 0;
 	}
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index fbba549c0f47..e828bfe006ba 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -13,6 +13,7 @@ struct onboard_dev_pdata {
 	unsigned int num_supplies;	/* number of supplies */
 	const char * const supply_names[MAX_SUPPLIES];
 	bool is_hub;
+	bool support_ext_vbus_supplies;
 };
 
 static const struct onboard_dev_pdata microchip_usb424_data = {
@@ -20,6 +21,7 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
 	.num_supplies = 1,
 	.supply_names = { "vdd" },
 	.is_hub = true,
+	.support_ext_vbus_supplies = true,
 };
 
 static const struct onboard_dev_pdata microchip_usb5744_data = {

-- 
2.39.2


