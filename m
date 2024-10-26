Return-Path: <linux-kernel+bounces-383364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601C9B1A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 21:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C724028275B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B841F1D47AC;
	Sat, 26 Oct 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LSylOKgA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FF1D7E47;
	Sat, 26 Oct 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729971510; cv=none; b=UAimPprtzvqN23Vb1asf75fPTDFbz95xQGu50gb043RQUpAusu2F+LZRlzUM0ZWDWgaXTUBxsOHbo4PeMfQRQomGIMnQ9Mypqxpd8jNJmfoRd1Z8UMRjwU45jyn0NNl8V/3Yr2q/ZsViIPFc6+iQYdWqNMM57cDA8/gnXZ3oq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729971510; c=relaxed/simple;
	bh=CAjaIga0moJZaXmcJDbZNckkj6s88q/WhUmG3ZcyAqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CyFhKqjO2oQzw+EWzkHM6/cJPQLc+FlnIetwcUwN+s16ftigrvNeLh6G/Ac77OUyjJOBp6YRL2pR3WaEjMdzX7bxEv7POBxzhVDgBszIAV/XzHNtBMlsl7uWw1ZGhS1ioFITchaYjVm/39pZb/lmQYssn+ss7fopd5O/Z5B3RIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LSylOKgA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729971493; x=1730576293; i=w_armin@gmx.de;
	bh=CWGXwTdE6nfX4UbzSNt/UUtpdKQ4k5QiGDJh7xGsi/w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LSylOKgA+PWhDCNaPBEfZ8e3LMAor3fgb07nMpEokWxrNodVg7bSyBLCTg93EHmF
	 9OxCT3uR2Wc6K5fxo9prXL3Hs/uxAVi2sPYbw72VSnuDrCkxEN/+NfSq4DTalpeu2
	 i59YeZuzvrX2rvwGMnAOedkc+HwMK+E5bQmzpDGg70ETLaaWTG9fU3wBEv3HLNNSz
	 kEQuvtcfAqOHFVrRWGlL2UNqRb5rowycZdBHBwTQklRLIyTGKPQvDmG/Wc8DDCzX9
	 q77NvblLW81uJ69SDJC3DUT07roz87duLxmdXIBXhsb/9hcYDHiHgxnCpwMfDtorc
	 JQNSRA8k/Kr4gM2Zag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mz9Z5-1trXiZ3VUh-014GLb; Sat, 26 Oct 2024 21:38:12 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: wmi: Introduce to_wmi_driver()
Date: Sat, 26 Oct 2024 21:38:03 +0200
Message-Id: <20241026193803.8802-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026193803.8802-1-W_Armin@gmx.de>
References: <20241026193803.8802-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:svEA9Ev7EsPla91zeaQbT2xrrp18elmlJ5cebA5zHoj47nHGNiB
 765ttV85enHNzZq+lc5XJBSSu46+fiaA8eJjug8kQdPjuKCNzmvF2JAUnHg438cru3OliL5
 hT9xhR9OTxegj4wwOTmqRcubi4wHGPua735d0IuoEavecOE1mHFEeaaGF05HV19IvyjCIKX
 rJE+tUZqFkZFiC/oR/Xaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yJusnooQexk=;ZpRa22kfi5cfwEo/LUq2lIcsiLc
 7fGRONwy5xqLzRnRevm60uqU3jOGcs8yKPWmjPqz0GnIQJhQ742IPidVIS5HWleh/pr1LNnwg
 ppcrqyaAPXtOEPx/WYbKf4rXXwgKw+/WJGjIw8JOtg5cP2dka7XpDvGY39d7AkvcmrgFaxsF9
 FDDhHZXLZI5ZmWLQet7MJjhd5X1mAAjYTu0F0YcSm9nyIkUCZJLTklErt48PRFi5fGZ9NcE9c
 klsRJzXM+H8CZ2qRt99YKXc1rjj3UyWkLYpT43BIZ78Kpd3hxsV2I1iEC4BG7k42vAaJKmN1y
 nrFo1RNzk+V0ttz5/RqQ74E3ves8u5ENaFNsbJlIpJETIfef9iuOHMUagL9FmTH+rE2CsmIxF
 s+i6E2kkXwfP2gR2R6WKdT9TpehYJZiJR7WlWf2SjZABTrTVSiorv8OjCQq1WnevUnXqgggSU
 hEwjFBwpeOEzGVlqNQD0XUEtMbOgnPULL8ZXm/7hA0l6FgLeMoiTvoK2tA4yYRBBg5lIzg9s6
 Eoln9IMnwZri4pNxw9EgdJJ0TSc9tFobIRrihY61YrloJTdOLChPTBxHwM1PpC5P0r9w/A1mL
 6JUkTezxTLGFnain4DlJRap4wOzwcomsrdlmwL/Xq1SlarhytfVvfkg2NEDhUApg0oTxYjUtK
 jm/FMSHKhbEaDiW3C0nerPS5BxKAMbjdxWpHTGhLynl4BU0dyvlG8FihzTwwNKWQiVmNUtabN
 m20ZYCy+CXuqO5F4Fsvk5x9ZRWAoXjWiOW1beIuH24baa7p693G+rsqCKly5qiJ5ESijrg2l7
 WD6O/QnXNKKSmNlntduck/OA==

Introduce to_wmi_driver() as a replacement for dev_to_wdrv()
so WMI drivers can use this support macro instead of having
to duplicate its functionality.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 12 +++++-------
 include/linux/wmi.h        |  8 ++++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index b2576d5189ed..646370bd6b03 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -653,8 +653,6 @@ char *wmi_get_acpi_device_uid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);

-#define drv_to_wdrv(__drv)	container_of_const(__drv, struct wmi_driver, d=
river)
-
 /*
  * sysfs interface
  */
@@ -802,7 +800,7 @@ static void wmi_dev_release(struct device *dev)

 static int wmi_dev_match(struct device *dev, const struct device_driver *=
driver)
 {
-	const struct wmi_driver *wmi_driver =3D drv_to_wdrv(driver);
+	const struct wmi_driver *wmi_driver =3D to_wmi_driver(driver);
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	const struct wmi_device_id *id =3D wmi_driver->id_table;

@@ -826,7 +824,7 @@ static int wmi_dev_match(struct device *dev, const str=
uct device_driver *driver)
 static int wmi_dev_probe(struct device *dev)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
-	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);
+	struct wmi_driver *wdriver =3D to_wmi_driver(dev->driver);
 	int ret =3D 0;

 	/* Some older WMI drivers will break if instantiated multiple times,
@@ -870,7 +868,7 @@ static int wmi_dev_probe(struct device *dev)
 static void wmi_dev_remove(struct device *dev)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
-	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);
+	struct wmi_driver *wdriver =3D to_wmi_driver(dev->driver);

 	down_write(&wblock->notify_lock);
 	wblock->driver_ready =3D false;
@@ -889,7 +887,7 @@ static void wmi_dev_shutdown(struct device *dev)
 	struct wmi_block *wblock;

 	if (dev->driver) {
-		wdriver =3D drv_to_wdrv(dev->driver);
+		wdriver =3D to_wmi_driver(dev->driver);
 		wblock =3D dev_to_wblock(dev);

 		/*
@@ -1173,7 +1171,7 @@ static int wmi_get_notify_data(struct wmi_block *wbl=
ock, union acpi_object **obj

 static void wmi_notify_driver(struct wmi_block *wblock, union acpi_object=
 *obj)
 {
-	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
+	struct wmi_driver *driver =3D to_wmi_driver(wblock->dev.dev.driver);

 	if (!obj && !driver->no_notify_data) {
 		dev_warn(&wblock->dev.dev, "Event contains no event data\n");
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index fca5fd43c707..10751c8e5e6a 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -73,6 +73,14 @@ struct wmi_driver {
 	void (*notify)(struct wmi_device *device, union acpi_object *data);
 };

+/**
+ * to_wmi_driver() - Helper macro to cast a driver to a wmi_driver
+ * @drv: driver struct
+ *
+ * Cast a struct device_driver to a struct wmi_driver.
+ */
+#define to_wmi_driver(drv)	container_of_const(drv, struct wmi_driver, dri=
ver)
+
 extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
 					      struct module *owner);
 extern void wmi_driver_unregister(struct wmi_driver *driver);
=2D-
2.39.5


