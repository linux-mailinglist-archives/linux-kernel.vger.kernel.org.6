Return-Path: <linux-kernel+bounces-352158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D6991AE3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4771C2146D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3C11662F6;
	Sat,  5 Oct 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="et/nPecI"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A515C120;
	Sat,  5 Oct 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164338; cv=none; b=OadRHgbZkLgM4y1iRFgnjcHlXoOxkFj75hD5nhCKyRMRYzo3VLaeeZhS/4bKmXVsJzumSg+NtMgzxKRz+Fg6zHovC8b9/WL0SaqROwYBNqm9npMJDhzRCa72FqPeodVX4ufSa2CUzbZp766K2itq3CXjsxvkHU/nTVMieXu62PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164338; c=relaxed/simple;
	bh=0oBKcUyGqkpkmby5GqOlg9PE/r+Q/hEQ/piNBSV4BdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zogu+O6/7M8bTIluswdZXiTz3ixeCxC7eeLrUkMIcSr/dOKsosVXZUKe4LMzDgBl0vCmwEq0pUQhfMqdeXC08yjXXIRwPiN6hUE7VWLN679Ls12giAalGPybBpHm33VsICs/E6ZZHrZCRljPXxi1YFNtm+MHziliSIR0M5VRuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=et/nPecI; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728164323; x=1728769123; i=w_armin@gmx.de;
	bh=wk9WXUNPlEFxTQJgc/e4AfqCIWp0mOT+O0oSXXjXsbQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=et/nPecIjcJ9leLPEK8MN8pjXwCCLsmL7YFz0aWtBywmXHnFc6f6yatA/pTvUpIB
	 zNs9QummKnhr+N8wtrsDFlB8i5CzKbuT/12a8FWUekb40fYFrMdz62SADvsDiGw5P
	 LlAOY8AgewIQYVqSoUbbTll2MLCBqkXwV7VYoO9n+ObfTWZQVDOQIbv3phjD63WIL
	 qCpgsfRF8XGgOAk8zyWCy+z/FeTxKLtZ8mZMrTFxM7YTtY6q4g0e0DJ9UpZjBsd3H
	 w3w0KnnAViJ+FfzyBWJUHxOvRupBUa7wV7UtKr9/YA/K7WtC5uf+XpL3w83rm+/dI
	 FlKO0/+45vIrpwVnpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbAcs-1tYT751D1U-00bMZd; Sat, 05 Oct 2024 23:38:43 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: wmi: Implement proper shutdown handling
Date: Sat,  5 Oct 2024 23:38:25 +0200
Message-Id: <20241005213825.701887-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241005213825.701887-1-W_Armin@gmx.de>
References: <20241005213825.701887-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pHlxfk8m68dTwbbjgBIg/XGjKWKlg424InHBVPpknGZakrS/B3o
 g38ZnqosTIjozZqQP/Q/vzVBvgJF2yYbJg/wvviO9wyhVCScDltYlUud7Sf9eSCSiL5dSno
 G1xhG+xYF9cGX7UoFGEXCU0M8WaqlPkcqxFeIy0OOfWPb1g/AROhklHyvdxFuwNQzFVQAZ9
 mgbDn60ng+NXOqOhL/1TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1fZiMQq8kn4=;dfxvqlUSN6vgJAIdVm0SL7gMYLd
 4EETbQgReCLBTKrHyuD2PIT934qzUrtjpjBAww2IvzZva/TygG06iOzLKZZAypsGqDQjsP3qP
 c0ZWPVEWTwglY/Ey1HKQRYlMzbzEXELcbUczHl5Ae2/1DIGC8+rKLUowSERSc+khN17vfFMqS
 nFoBQrJLKp93WNv5viOg8znuQzB/0FKFav2puhlfsRjVCO4QuxYuFljCRQ+PxUV7iPyCwbgwv
 1qgBCNHz7PWg8qWiEjnAW4H30wQEGiaWFkLX98Rv4SvsUm5w87BbsBeVXcC6WbwUXnDLyCtxd
 m0PlGJTuusypTJRAL1O/yE84JDmR9NIznWH7SIsqvq3duOheO3vSbK6w/iCcH/Ut/+H7aZ1wQ
 B8uZE1RP1MsGS404rWpZ91AxPygh/JfQwq6kV9jsLCrJQHHpUQ/zjoD/mVn/D0zxAgmeISXW2
 MSt5MuvjXEvsTFOupilQijMcfTxeYN7SGmhc04pzVayP8YA85Qqdr3jtNMe7HRqCYFLUzM9R+
 Ho0z+xVoRctiRown2mBqf83OaYxRiDM6zE6wuYlrtVJ4vfS/xKilEDCsWAnhF4uRzcIyd8fMq
 A+2T/XJe38oZPWE4gZbPQB62h32fP6XwM4h7OXfBMmlJ+ezyEz4czYH1bauFUvXsAl94VhItU
 ZqUm5aanGrn/a/6rAJJGmQ4q9/0ocYUBcyWfUb0tpUYO51qDYGQDP5APvVL44L/k8OEAyIM/e
 yFCe1wmXWtB2ohFD4YBDxTDzkw+ICd84GgJ/O0swKQLispYVrcscmotof9skKoP884TVullHl
 UqGIIw6qGAiQVnqSzeJMbFwQ==

When performing a system shutdown under Windows, all WMI clients are
terminated. This means that the ACPI BIOS might expect all WMI devices
to be disabled when shutting down.

Emulate this behaviour by disabling all active WMI devices during
shutdown. Also introduce a new WMI driver callback to allow WMI drivers
to perform any device-specific actions before disabling the WMI device.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../wmi/driver-development-guide.rst          |  7 ++++-
 drivers/platform/x86/wmi.c                    | 27 +++++++++++++++++++
 include/linux/wmi.h                           |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentatio=
n/wmi/driver-development-guide.rst
index 429137b2f632..676873c98680 100644
=2D-- a/Documentation/wmi/driver-development-guide.rst
+++ b/Documentation/wmi/driver-development-guide.rst
@@ -64,6 +64,7 @@ to matching WMI devices using a struct wmi_device_id tab=
le:
         .id_table =3D foo_id_table,
         .probe =3D foo_probe,
         .remove =3D foo_remove,         /* optional, devres is preferred =
*/
+        .shutdown =3D foo_shutdown,     /* optional, called during shutdo=
wn */
         .notify =3D foo_notify,         /* optional, for event handling *=
/
         .no_notify_data =3D true,       /* optional, enables events conta=
ining no additional data */
         .no_singleton =3D true,         /* required for new WMI drivers *=
/
@@ -79,6 +80,10 @@ to unregister interfaces to other kernel subsystems and=
 release resources, devre
 This simplifies error handling during probe and often allows to omit this=
 callback entirely, see
 Documentation/driver-api/driver-model/devres.rst for details.

+The shutdown() callback is called during shutdown, reboot or kexec. Its s=
ole purpose is to disable
+the WMI device and put it in a well-known state for the WMI driver to pic=
k up later after reboot
+or kexec. Most WMI drivers need no special shutdown handling and can thus=
 omit this callback.
+
 Please note that new WMI drivers are required to be able to be instantiat=
ed multiple times,
 and are forbidden from using any deprecated GUID-based WMI functions. Thi=
s means that the
 WMI driver should be prepared for the scenario that multiple matching WMI=
 devices are present
@@ -123,7 +128,7 @@ ACPI object is being done by the WMI subsystem, not th=
e driver.

 The WMI driver core will take care that the notify() callback will only b=
e called after
 the probe() callback has been called, and that no events are being receiv=
ed by the driver
-right before and after calling its remove() callback.
+right before and after calling its remove() or shutdown() callback.

 However WMI driver developers should be aware that multiple WMI events ca=
n be received concurrently,
 so any locking (if necessary) needs to be provided by the WMI driver itse=
lf.
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 3cbe180c3fc0..a01223c23d10 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -884,6 +884,32 @@ static void wmi_dev_remove(struct device *dev)
 		dev_warn(dev, "failed to disable device\n");
 }

+static void wmi_dev_shutdown(struct device *dev)
+{
+	struct wmi_driver *wdriver;
+	struct wmi_block *wblock;
+
+	if (dev->driver) {
+		wdriver =3D drv_to_wdrv(dev->driver);
+		wblock =3D dev_to_wblock(dev);
+
+		/*
+		 * Some machines return bogus WMI event data when disabling
+		 * the WMI event. Because of this we must prevent the associated
+		 * WMI driver from receiving new WMI events before disabling it.
+		 */
+		down_write(&wblock->notify_lock);
+		wblock->driver_ready =3D false;
+		up_write(&wblock->notify_lock);
+
+		if (wdriver->shutdown)
+			wdriver->shutdown(to_wmi_device(dev));
+
+		if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
+			dev_warn(dev, "Failed to disable device\n");
+	}
+}
+
 static struct class wmi_bus_class =3D {
 	.name =3D "wmi_bus",
 };
@@ -895,6 +921,7 @@ static const struct bus_type wmi_bus_type =3D {
 	.uevent =3D wmi_dev_uevent,
 	.probe =3D wmi_dev_probe,
 	.remove =3D wmi_dev_remove,
+	.shutdown =3D wmi_dev_shutdown,
 };

 static const struct device_type wmi_type_event =3D {
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 3275470b5531..120019677fc6 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -56,6 +56,7 @@ u8 wmidev_instance_count(struct wmi_device *wdev);
  * @no_singleton: Driver can be instantiated multiple times
  * @probe: Callback for device binding
  * @remove: Callback for device unbinding
+ * @shutdown: Callback for device shutdown
  * @notify: Callback for receiving WMI events
  *
  * This represents WMI drivers which handle WMI devices.
@@ -68,6 +69,7 @@ struct wmi_driver {

 	int (*probe)(struct wmi_device *wdev, const void *context);
 	void (*remove)(struct wmi_device *wdev);
+	void (*shutdown)(struct wmi_device *wdev);
 	void (*notify)(struct wmi_device *device, union acpi_object *data);
 };

=2D-
2.39.5


