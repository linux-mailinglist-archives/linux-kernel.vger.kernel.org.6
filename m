Return-Path: <linux-kernel+bounces-516769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB365A37723
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE55A16D21F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B811A316E;
	Sun, 16 Feb 2025 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="j0N5OScx"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B01442F4;
	Sun, 16 Feb 2025 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734401; cv=none; b=jdCa1Tehv/HYBFM/SrAlpgvZj5lcxhmAwD9hFkn03hEPxdIraCP0ujyghxK2q23bjf5InLSYyVCPdvrwo9tXJi0RF2kg6TGKuOWaGj47uoi4ilL4AV5sLxXd9xUrWJP7elITg8HVi7ETt7UhXgl4tMEpHnCWoYcOFDhMt7OxRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734401; c=relaxed/simple;
	bh=MrfZ4f0ixgqBmbr6b+tZ8nXuoCrWVbwwBuBbnLY9zO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idVi3MKgYhgmcLXSg5c4DG4Hf39lpc1ei2PBkpIgShSZHhNEaBHCQOuAUb+b8R1bp8JTSRrSLfR5q4ltpF4JQKW16TUs0lHUbIX1rQShYKd820AhLgMFXjm+DndozzRDeXaiAa6OsfrlzvaxKVvQEJFfBGnIr2slDiP3OqzKZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=j0N5OScx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734397; x=1740339197; i=w_armin@gmx.de;
	bh=RfBOHIfH8DCdsKRfj+Ybg/Cue8cCReCmHYRkGqlvgPA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j0N5OScxOjF2LMY/htLMR9mti427TdEgFT8YCyPf91knhnxl3hmGBWrUT6j+Pe/O
	 /6sMbjEWCJX4X3f0oC+Svue/elZBhjyPUhRGfqlhhPjbo4ydCGKC3WUgdPx7CQZoL
	 1lyvqJqzTZsbNNCzDY9lty8y7BX9nZxKe1j43GOSyl4QOWDWKWBkoSGYz21lCvQpT
	 DT5lLV9tuAtcmCV8OVMqIj5fb19ixZSmrOJSE8npsr84+i7pJhuLHNGKsq3phF9PP
	 Q+v9+YX2zgZN0ovO+jeAHn6zOjCV93k3p7ftJ4+UfMzHkUVXgYLRrterSmM7wapMv
	 yKJ0Dy4RBSXMpgHJPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MD9XF-1tbBfR3vgf-001ygY; Sun, 16 Feb 2025 20:33:17 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	markpearson@lenovo.com,
	jorge.lopez2@hp.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 6/8] platform/x86: wmi: Rework WCxx/WExx ACPI method handling
Date: Sun, 16 Feb 2025 20:32:49 +0100
Message-Id: <20250216193251.866125-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216193251.866125-1-W_Armin@gmx.de>
References: <20250216193251.866125-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0P9QMJU5AH0jT3Z6Bp1YuLyM8hZGN8kYikhhK6uquLHpH8lr+FK
 X0bEzSScBFpkYvvFcZ1uQrmpts2wJ0FSs/OImw/rvK5PTc1DUJ9MkV+9cwfk8b0ZXlEnRB8
 0fVBXIQHqO1ZBXv40NpElYwQRamItMe0AtGvnx8flnUwCxNFNyiamL2u4LjnxkHY1KdvUVl
 mogiwPkxYg3N6XMnH6O9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s4KPpRLx5Ms=;9L9wkEpJgQAjpopQ7DiKR4j2Alj
 VhOdeW9nu++wEI688sJx474lhlCeMD+hg/CalGbMp1TXB+2wQJpqp17XqXepGWlWHCpzzSF/5
 Luw9UPR/hoQ/vmvE8mobuutw9HktpYXWHT4R/lOFVhybn86hOe2dNT6OomwWsbDQ4oT/4iHo2
 BCYYmO7pHStn0UW6g8S6oJ9hiawPAIoKgFvdxjke5di4Rs+ai+9xO4fyoiQVQ5Ri3vy9wJtJ5
 gIiNk1Tsc2QRa7X5z1/6ZZz4P0wE47L3CRxRcz9q676KwkEIXFWt8kkDS6xE38m3Hc09QeHGT
 kxfUQ67gAfLqZNzBqHcO05g/+Hf120n9wpKvCGs3w+f3uyUpfDCylC9VXydD0gOTU6YUt1G/d
 jTIFSyVmmDgb1VoQp63zsnVQTRtHyv/s8F6jAZ7oVPNcJLuJ2RLiTKDcmfeD9gkekNmfldASQ
 EVq1clLSzEFYt0Te/hMzOP1CtX1zwNFo1EMrFf12Kjmzjugtr1haaxlpuUGoiI+SCmiJRKRlx
 MJFDY+p1ntC9LvSpuK1xltbLhNS1jKndzyk3QYDj6qLsjIoZjNZrGO5s6phs69JdpOb2FAlXk
 4qKSXp+JkiSI2+iW4Xe0R2rFRfnWjyQLr3wFb/1hPIlf053t4Phyy1pcoB7geYCzVXSQO3RIZ
 pw0p+8Ee5DzlEjRg1zcJaxR7LtErpAW+zW2w2b7n8kCaKVYJXfZpzASmY0jaLOoclNF6eabmc
 9rQWjHa4BvixMHKSgYJfrzzcNAIFSAwz1fW8wpD1ed8RTj+6g74BXx9I6RP9FZdLkWUGIVu1Z
 W67HQOAKQyIRrEHpxZIqzvqArnj6tBIvgchQ4Nf6i7CkiDDdcnoO1eNpHY9JjNZacqCj7Cos3
 m/MFbO+YJHEEfM+jBsv0+vDmqyPuVUVsBpqR0svEOevWj3QOpx2vRSLFVhH+mAsNQBnMXxwjO
 9/i0qGpAw6KGr4fwsZTLVc8xCZyCZsE1ZBR383CQ7FTeU0lq+HvBYvvJrq9nHd5HOGBcYg4d2
 f5AdDhGMlPsLmTVpYs1R5GtEVjhT4frcccEQgEaj6myJfqHNXzOdBVakSeXeF9MX0AIhoHN1g
 O153vTMMYArbzF8HKyQQSs9a1pIIgEmyn0CbeWbWqG/u9oa+TGVgyx6jgHXcxhxI++WCMQRIA
 EGkOjbTO6Ismhgj5ZT1Zc58sP/kezP6DPAY9iA2Z7h+5JAhVYvbFpdq1SrzktufVn3aaoVeZV
 pi2cKLerofqPMrXjR4g+5eOhbOTRzpOs7Ha+Uyo7XLgMGyOO7Jf2v3TjbQtMWJp6EzsdmhfOa
 OziQ64AMFyTnBK/QS3SyBHAq8paI/Q1a0pQiaKk3xI9J12IGd7MfV95pZN3YSkHt4FbIu0M8h
 ut09ulWJ2/hHqNu8RUiYtlKpoaqmIkrnw4vAzMQMxpCWf3pj4DqyXJebKq

The handling of the WExx ACPI methods used for enabling and disabling
WMI events has multiple flaws:

- the ACPI methods are called even when the WMI device has not been
  marked as expensive.

- WExx ACPI methods might be called for inappropriate WMI devices.

- the error code AE_NOT_FOUND is treated as success.

The handling of the WCxx ACPI methods used for enabling and disabling
WMI data blocks is also flawed:

- WMI data blocks are enabled and disabled for every single "query"
  operation. This is racy and inefficient.

Unify the handling of both ACPI methods by introducing a common
helper function for enabling and disabling WMI devices.

Also enable/disable WMI data blocks during probe/remove and shutdown
to match the handling of WMI events.

Legacy GUID-based functions still have to enable/disable the WMI
device manually and thus still suffer from a potential race condition.
Since those functions are deprecated and suffer from various other
flaws this issue is purposefully not fixed.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 112 +++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7cb36a71e9ea..97c4a161799e 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -123,24 +123,6 @@ static const void *find_guid_context(struct wmi_block=
 *wblock,
 	return NULL;
 }

-static acpi_status wmi_method_enable(struct wmi_block *wblock, bool enabl=
e)
-{
-	struct guid_block *block;
-	char method[5];
-	acpi_status status;
-	acpi_handle handle;
-
-	block =3D &wblock->gblock;
-	handle =3D wblock->acpi_device->handle;
-
-	snprintf(method, 5, "WE%02X", block->notify_id);
-	status =3D acpi_execute_simple_method(handle, method, enable);
-	if (status =3D=3D AE_NOT_FOUND)
-		return AE_OK;
-
-	return status;
-}
-
 #define WMI_ACPI_METHOD_NAME_SIZE 5

 static inline void get_acpi_method_name(const struct wmi_block *wblock,
@@ -184,6 +166,42 @@ static int wmidev_match_guid(struct device *dev, cons=
t void *data)

 static const struct bus_type wmi_bus_type;

+static const struct device_type wmi_type_event;
+
+static const struct device_type wmi_type_method;
+
+static int wmi_device_enable(struct wmi_device *wdev, bool enable)
+{
+	struct wmi_block *wblock =3D container_of(wdev, struct wmi_block, dev);
+	char method[WMI_ACPI_METHOD_NAME_SIZE];
+	acpi_handle handle;
+	acpi_status status;
+
+	if (!(wblock->gblock.flags & ACPI_WMI_EXPENSIVE))
+		return 0;
+
+	if (wblock->dev.dev.type =3D=3D &wmi_type_method)
+		return 0;
+
+	if (wblock->dev.dev.type =3D=3D &wmi_type_event)
+		snprintf(method, sizeof(method), "WE%02X", wblock->gblock.notify_id);
+	else
+		get_acpi_method_name(wblock, 'C', method);
+
+	/* Not all WMI devices marked as expensive actually implement the necess=
ary ACPI method.
+	 * Ignore this missing ACPI method to match the behaviour of the Windows=
 driver.
+	 */
+	status =3D acpi_get_handle(wblock->acpi_device->handle, method, &handle)=
;
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	status =3D acpi_execute_simple_method(handle, NULL, enable);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
 static struct wmi_device *wmi_find_device_by_guid(const char *guid_string=
)
 {
 	struct device *dev;
@@ -337,10 +355,8 @@ static acpi_status __query_block(struct wmi_block *wb=
lock, u8 instance,
 {
 	struct guid_block *block;
 	acpi_handle handle;
-	acpi_status status, wc_status =3D AE_ERROR;
 	struct acpi_object_list input;
 	union acpi_object wq_params[1];
-	char wc_method[WMI_ACPI_METHOD_NAME_SIZE];
 	char method[WMI_ACPI_METHOD_NAME_SIZE];

 	if (!out)
@@ -364,40 +380,9 @@ static acpi_status __query_block(struct wmi_block *wb=
lock, u8 instance,
 	if (instance =3D=3D 0 && test_bit(WMI_READ_TAKES_NO_ARGS, &wblock->flags=
))
 		input.count =3D 0;

-	/*
-	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method first to
-	 * enable collection.
-	 */
-	if (block->flags & ACPI_WMI_EXPENSIVE) {
-		get_acpi_method_name(wblock, 'C', wc_method);
-
-		/*
-		 * Some GUIDs break the specification by declaring themselves
-		 * expensive, but have no corresponding WCxx method. So we
-		 * should not fail if this happens.
-		 */
-		wc_status =3D acpi_execute_simple_method(handle, wc_method, 1);
-	}
-
 	get_acpi_method_name(wblock, 'Q', method);
-	status =3D acpi_evaluate_object(handle, method, &input, out);

-	/*
-	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method, even if
-	 * the WQxx method failed - we should disable collection anyway.
-	 */
-	if ((block->flags & ACPI_WMI_EXPENSIVE) && ACPI_SUCCESS(wc_status)) {
-		/*
-		 * Ignore whether this WCxx call succeeds or not since
-		 * the previously executed WQxx method call might have
-		 * succeeded, and returning the failing status code
-		 * of this call would throw away the result of the WQxx
-		 * call, potentially leaking memory.
-		 */
-		acpi_execute_simple_method(handle, wc_method, 0);
-	}
-
-	return status;
+	return acpi_evaluate_object(handle, method, &input, out);
 }

 /**
@@ -421,9 +406,15 @@ acpi_status wmi_query_block(const char *guid_string, =
u8 instance,
 	if (IS_ERR(wdev))
 		return AE_ERROR;

+	if (wmi_device_enable(wdev, true) < 0)
+		dev_warn(&wdev->dev, "Failed to enable device\n");
+
 	wblock =3D container_of(wdev, struct wmi_block, dev);
 	status =3D __query_block(wblock, instance, out);

+	if (wmi_device_enable(wdev, false) < 0)
+		dev_warn(&wdev->dev, "Failed to disable device\n");
+
 	wmi_device_put(wdev);

 	return status;
@@ -471,6 +462,7 @@ acpi_status wmi_set_block(const char *guid_string, u8 =
instance, const struct acp
 		return AE_ERROR;

 	status =3D  wmidev_block_set(wdev, instance, in);
+
 	wmi_device_put(wdev);

 	return status;
@@ -551,7 +543,7 @@ acpi_status wmi_install_notify_handler(const char *gui=
d,
 		wblock->handler =3D handler;
 		wblock->handler_data =3D data;

-		if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
+		if (wmi_device_enable(wdev, true) < 0)
 			dev_warn(&wblock->dev.dev, "Failed to enable device\n");

 		status =3D AE_OK;
@@ -588,7 +580,7 @@ acpi_status wmi_remove_notify_handler(const char *guid=
)
 	if (!wblock->handler) {
 		status =3D AE_NULL_ENTRY;
 	} else {
-		if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
+		if (wmi_device_enable(wdev, false) < 0)
 			dev_warn(&wblock->dev.dev, "Failed to disable device\n");

 		wblock->handler =3D NULL;
@@ -823,10 +815,10 @@ static int wmi_dev_match(struct device *dev, const s=
truct device_driver *driver)

 static void wmi_dev_disable(void *data)
 {
-	struct wmi_block *wblock =3D data;
+	struct device *dev =3D data;

-	if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
-		dev_warn(&wblock->dev.dev, "Failed to disable device\n");
+	if (wmi_device_enable(to_wmi_device(dev), false) < 0)
+		dev_warn(dev, "Failed to disable device\n");
 }

 static int wmi_dev_probe(struct device *dev)
@@ -852,14 +844,14 @@ static int wmi_dev_probe(struct device *dev)
 			return -ENODEV;
 	}

-	if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
+	if (wmi_device_enable(to_wmi_device(dev), true) < 0)
 		dev_warn(dev, "failed to enable device -- probing anyway\n");

 	/*
 	 * We have to make sure that all devres-managed resources are released f=
irst because
 	 * some might still want to access the underlying WMI device.
 	 */
-	ret =3D devm_add_action_or_reset(dev, wmi_dev_disable, wblock);
+	ret =3D devm_add_action_or_reset(dev, wmi_dev_disable, dev);
 	if (ret < 0)
 		return ret;

@@ -915,7 +907,7 @@ static void wmi_dev_shutdown(struct device *dev)
 		 * We still need to disable the WMI device here since devres-managed re=
sources
 		 * like wmi_dev_disable() will not be release during shutdown.
 		 */
-		if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
+		if (wmi_device_enable(to_wmi_device(dev), false) < 0)
 			dev_warn(dev, "Failed to disable device\n");
 	}
 }
=2D-
2.39.5


