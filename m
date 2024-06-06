Return-Path: <linux-kernel+bounces-205162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B58FF83E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B92F286D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289913F450;
	Thu,  6 Jun 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EdDXlTeF"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E0145FEF;
	Thu,  6 Jun 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716975; cv=none; b=noNIvYqO+7Hg+dzZ4h6mYg9Mn/IQ5a8y1ex6eOEZ34qfWwDNyD2cqlpMTzhkrT8ZJ915eQOV+Gm36BmQOUiOTvA1+tBoT4rs9QQIhX6TugVAqyHd1cAE60UXcH+cLgLhsF0wQc4PfH9c6PZ520ZN3Lw3PZ96JI9AVMxBySV6hVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716975; c=relaxed/simple;
	bh=O+epwMalW8q1ywVQftnD3kr4enZ/tUns59fgSJivT+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keu/uBDs6LUINore9ANA9zswNH6diyZecHsmuNXZ7aLPo8k81jG/4aNV/VHJh4sAf0MJcrArGSXWL0MINySg4mPse/N5HPUO7oV8ONouGMX9558SO/OKUzMz32PktBuQJ1hfjWRd/orMuncr4zvhCsgRmKlzP9YLenMX+fz5IOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EdDXlTeF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717716966; x=1718321766; i=w_armin@gmx.de;
	bh=/OsDHVNN0gnO8H9MbGHuZBgRREzhWlwQMthhpDzyH7k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EdDXlTeF1uTugR21JZRATobsXjzfwAe1feN0erAXCtDxnGGgNPb33Fu6fnAuUbpk
	 QT/4uA8wvYbVzPPKVsqd+zBHm6TuVSctCCGxkBL2n2oPAe+v6aWm/QknkJdqLL5dw
	 6B2CTecfWldIeeCjLsNEni8lYitH7bR6+ojL2+EXiVRDkkwtZ54eR9Pobp2XcP+AJ
	 z30z/6QhON4eAHz9ZwtHkC4XG4Zn9P2O2h/ktDQHTaTiipUz0qZmYT74O15TmiyaT
	 gH5eLiF7CZxLQh/reS20A3FA/HQ/bp0s27ZnnRVtKXXq2VAHBBwTCqd+TgH2Yne1u
	 KBeW67QD8VllTSbk4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MdvqW-1spF6B3kvO-00psKd; Fri, 07 Jun 2024 01:36:06 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	agathe@boutmy.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: lg-laptop: Use ACPI device handle when evaluating WMAB/WMBB
Date: Fri,  7 Jun 2024 01:35:40 +0200
Message-Id: <20240606233540.9774-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606233540.9774-1-W_Armin@gmx.de>
References: <20240606233540.9774-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:isifIVrCilxhIMRnNU3HGt2G8q3KK3cF7QzUOhPJGYG+J9SkNY8
 dc7pQuXtiMaQiG1hapVGSFZJx1bm5y6bFKCt4MTLoWa+7mK6ST3jZUfSOM/3IjRa35KdiVu
 SijdKukOdoXg2i8XBG/09uNmliz2mCh2QXTkPHAfjymWTiUozifYV+RrjLqfgcpeA1FuqP4
 Hrb8RlaKJC1MXIVS3XMFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:esqjQDeZD5E=;nRjU9DmUydieYbAg918/syNmZkh
 d2kWsXw/dQiR6V3WKyzfuo8+zitsHu/Bz4mMlSF5MWFOT0tkfaXZXERWmYrI5VyMxatBqrpw7
 idHXbj4L9aRcpiunVsPXG+C6a+ygK0+0pwpPbWUHgSBWi3pJpZRUgVcFaKdXAdoOROx2MAlE7
 iuQsH8FRemwFDD7t8dGfFM7I1XRvicvFmgbbEz7MDk6dYmNEX31O3asHKA9J92DowJeq6+hta
 PjWiTRDRg8nmQpnREUqrFMKdt3iNzaJbjvNSjR7HJGj0nmsMJcDf4uRh6VT8Q0qG9+KZUMWZe
 EQVz72wP8Cp5xDh7cFDpsC7CE/Vs/ZwjWu2fg37Zfx3bcs1YZUYu+EUUQCdI2MlDycoujaM/W
 +Jq0TU+AEO4g6jZY4sqyYnjApAle9guV7DtzmxiA10q8/DrAtTK/gm/WYErDy+ZuF5yfT6zt0
 lCbYrOZ4Ab3czGbfbcVUgxVpXGI6Bf2u+1PR/SIoOrarTpS/SUQyy7iNlWOjv8ycJT5e1NkhY
 0SEgRD7ieU0R251Wv/JfFusLt+ULsjT2MLEp5xBJP/FVy1RMrqarOMHGliHASi/s7B5moFBAD
 Pwgug8pJzxkIVPGm1OVmwGr7xhUy5pqah3F5NIoiuTNO6/CGgnbj53DV4Fh9cz6oQddccK9K0
 ZpLSFHtzCeacybVszmB6lkVGxyJwf66GNLWD4Pg9LdsI6Yw3x/J8DN+Mbr0sUvXcUC8E2xWvz
 PHW25e8RRu+d+A8/6bDUaAlXeo+0J+BFMDNNkyixranzLBppFcbSwqY/tHnFde/eT/eh9BIzS
 AXa2X2/xZr1jfV8wkb5L9s1B5i1A2Rx+kWgTGzdm9ohiM=

On the LG Gram 16Z90S, the WMAB and WMBB ACPI methods are not mapped
under \XINI, but instead are mapped under \_SB.XINI.

The reason for this is that the LGEX0820 ACPI device used by this
driver is mapped at \_SB.XINI, so the ACPI methods where moved as well
to appear below the LGEX0820 ACPI device.

Fix this by using the ACPI handle from the ACPI device when evaluating
both methods.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218901
Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/lg-laptop.c | 79 +++++++++++++-------------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index db8a2f79bf0a..9c7857842caf 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -39,8 +39,6 @@ MODULE_LICENSE("GPL");
 #define WMI_METHOD_WMBB "2B4F501A-BD3C-4394-8DCF-00A7D2BC8210"
 #define WMI_EVENT_GUID  WMI_EVENT_GUID0

-#define WMAB_METHOD     "\\XINI.WMAB"
-#define WMBB_METHOD     "\\XINI.WMBB"
 #define SB_GGOV_METHOD  "\\_SB.GGOV"
 #define GOV_TLED        0x2020008
 #define WM_GET          1
@@ -74,7 +72,7 @@ static u32 inited;

 static int battery_limit_use_wmbb;
 static struct led_classdev kbd_backlight;
-static enum led_brightness get_kbd_backlight_level(void);
+static enum led_brightness get_kbd_backlight_level(struct device *dev);

 static const struct key_entry wmi_keymap[] =3D {
 	{KE_KEY, 0x70, {KEY_F15} },	 /* LG control panel (F1) */
@@ -127,11 +125,10 @@ static int ggov(u32 arg0)
 	return res;
 }

-static union acpi_object *lg_wmab(u32 method, u32 arg1, u32 arg2)
+static union acpi_object *lg_wmab(struct device *dev, u32 method, u32 arg=
1, u32 arg2)
 {
 	union acpi_object args[3];
 	acpi_status status;
-	acpi_handle handle;
 	struct acpi_object_list arg;
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };

@@ -142,29 +139,22 @@ static union acpi_object *lg_wmab(u32 method, u32 ar=
g1, u32 arg2)
 	args[2].type =3D ACPI_TYPE_INTEGER;
 	args[2].integer.value =3D arg2;

-	status =3D acpi_get_handle(NULL, (acpi_string) WMAB_METHOD, &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Cannot get handle");
-		return NULL;
-	}
-
 	arg.count =3D 3;
 	arg.pointer =3D args;

-	status =3D acpi_evaluate_object(handle, NULL, &arg, &buffer);
+	status =3D acpi_evaluate_object(ACPI_HANDLE(dev), "WMAB", &arg, &buffer)=
;
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "WMAB: call failed.\n");
+		dev_err(dev, "WMAB: call failed.\n");
 		return NULL;
 	}

 	return buffer.pointer;
 }

-static union acpi_object *lg_wmbb(u32 method_id, u32 arg1, u32 arg2)
+static union acpi_object *lg_wmbb(struct device *dev, u32 method_id, u32 =
arg1, u32 arg2)
 {
 	union acpi_object args[3];
 	acpi_status status;
-	acpi_handle handle;
 	struct acpi_object_list arg;
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	u8 buf[32];
@@ -180,18 +170,12 @@ static union acpi_object *lg_wmbb(u32 method_id, u32=
 arg1, u32 arg2)
 	args[2].buffer.length =3D 32;
 	args[2].buffer.pointer =3D buf;

-	status =3D acpi_get_handle(NULL, (acpi_string)WMBB_METHOD, &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Cannot get handle");
-		return NULL;
-	}
-
 	arg.count =3D 3;
 	arg.pointer =3D args;

-	status =3D acpi_evaluate_object(handle, NULL, &arg, &buffer);
+	status =3D acpi_evaluate_object(ACPI_HANDLE(dev), "WMBB", &arg, &buffer)=
;
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "WMAB: call failed.\n");
+		dev_err(dev, "WMBB: call failed.\n");
 		return NULL;
 	}

@@ -222,7 +206,7 @@ static void wmi_notify(u32 value, void *context)

 		if (eventcode =3D=3D 0x10000000) {
 			led_classdev_notify_brightness_hw_changed(
-				&kbd_backlight, get_kbd_backlight_level());
+				&kbd_backlight, get_kbd_backlight_level(kbd_backlight.dev->parent));
 		} else {
 			key =3D sparse_keymap_entry_from_scancode(
 				wmi_input_dev, eventcode);
@@ -287,7 +271,7 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (ret)
 		return ret;

-	r =3D lg_wmab(WM_FAN_MODE, WM_GET, 0);
+	r =3D lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;

@@ -298,9 +282,9 @@ static ssize_t fan_mode_store(struct device *dev,

 	m =3D r->integer.value;
 	kfree(r);
-	r =3D lg_wmab(WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
+	r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4))=
;
 	kfree(r);
-	r =3D lg_wmab(WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r =3D lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
 	kfree(r);

 	return count;
@@ -312,7 +296,7 @@ static ssize_t fan_mode_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;

-	r =3D lg_wmab(WM_FAN_MODE, WM_GET, 0);
+	r =3D lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;

@@ -339,7 +323,7 @@ static ssize_t usb_charge_store(struct device *dev,
 	if (ret)
 		return ret;

-	r =3D lg_wmbb(WMBB_USB_CHARGE, WM_SET, value);
+	r =3D lg_wmbb(dev, WMBB_USB_CHARGE, WM_SET, value);
 	if (!r)
 		return -EIO;

@@ -353,7 +337,7 @@ static ssize_t usb_charge_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;

-	r =3D lg_wmbb(WMBB_USB_CHARGE, WM_GET, 0);
+	r =3D lg_wmbb(dev, WMBB_USB_CHARGE, WM_GET, 0);
 	if (!r)
 		return -EIO;

@@ -381,7 +365,7 @@ static ssize_t reader_mode_store(struct device *dev,
 	if (ret)
 		return ret;

-	r =3D lg_wmab(WM_READER_MODE, WM_SET, value);
+	r =3D lg_wmab(dev, WM_READER_MODE, WM_SET, value);
 	if (!r)
 		return -EIO;

@@ -395,7 +379,7 @@ static ssize_t reader_mode_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;

-	r =3D lg_wmab(WM_READER_MODE, WM_GET, 0);
+	r =3D lg_wmab(dev, WM_READER_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;

@@ -423,7 +407,7 @@ static ssize_t fn_lock_store(struct device *dev,
 	if (ret)
 		return ret;

-	r =3D lg_wmab(WM_FN_LOCK, WM_SET, value);
+	r =3D lg_wmab(dev, WM_FN_LOCK, WM_SET, value);
 	if (!r)
 		return -EIO;

@@ -437,7 +421,7 @@ static ssize_t fn_lock_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;

-	r =3D lg_wmab(WM_FN_LOCK, WM_GET, 0);
+	r =3D lg_wmab(dev, WM_FN_LOCK, WM_GET, 0);
 	if (!r)
 		return -EIO;

@@ -467,9 +451,9 @@ static ssize_t charge_control_end_threshold_store(stru=
ct device *dev,
 		union acpi_object *r;

 		if (battery_limit_use_wmbb)
-			r =3D lg_wmbb(WMBB_BATT_LIMIT, WM_SET, value);
+			r =3D lg_wmbb(&pf_device->dev, WMBB_BATT_LIMIT, WM_SET, value);
 		else
-			r =3D lg_wmab(WM_BATT_LIMIT, WM_SET, value);
+			r =3D lg_wmab(&pf_device->dev, WM_BATT_LIMIT, WM_SET, value);
 		if (!r)
 			return -EIO;

@@ -488,7 +472,7 @@ static ssize_t charge_control_end_threshold_show(struc=
t device *device,
 	union acpi_object *r;

 	if (battery_limit_use_wmbb) {
-		r =3D lg_wmbb(WMBB_BATT_LIMIT, WM_GET, 0);
+		r =3D lg_wmbb(&pf_device->dev, WMBB_BATT_LIMIT, WM_GET, 0);
 		if (!r)
 			return -EIO;

@@ -499,7 +483,7 @@ static ssize_t charge_control_end_threshold_show(struc=
t device *device,

 		status =3D r->buffer.pointer[0x10];
 	} else {
-		r =3D lg_wmab(WM_BATT_LIMIT, WM_GET, 0);
+		r =3D lg_wmab(&pf_device->dev, WM_BATT_LIMIT, WM_GET, 0);
 		if (!r)
 			return -EIO;

@@ -578,7 +562,7 @@ static void tpad_led_set(struct led_classdev *cdev,
 {
 	union acpi_object *r;

-	r =3D lg_wmab(WM_TLED, WM_SET, brightness > LED_OFF);
+	r =3D lg_wmab(cdev->dev->parent, WM_TLED, WM_SET, brightness > LED_OFF);
 	kfree(r);
 }

@@ -600,16 +584,16 @@ static void kbd_backlight_set(struct led_classdev *c=
dev,
 		val =3D 0;
 	if (brightness >=3D LED_FULL)
 		val =3D 0x24;
-	r =3D lg_wmab(WM_KEY_LIGHT, WM_SET, val);
+	r =3D lg_wmab(cdev->dev->parent, WM_KEY_LIGHT, WM_SET, val);
 	kfree(r);
 }

-static enum led_brightness get_kbd_backlight_level(void)
+static enum led_brightness get_kbd_backlight_level(struct device *dev)
 {
 	union acpi_object *r;
 	int val;

-	r =3D lg_wmab(WM_KEY_LIGHT, WM_GET, 0);
+	r =3D lg_wmab(dev, WM_KEY_LIGHT, WM_GET, 0);

 	if (!r)
 		return LED_OFF;
@@ -637,7 +621,7 @@ static enum led_brightness get_kbd_backlight_level(voi=
d)

 static enum led_brightness kbd_backlight_get(struct led_classdev *cdev)
 {
-	return get_kbd_backlight_level();
+	return get_kbd_backlight_level(cdev->dev->parent);
 }

 static LED_DEVICE(kbd_backlight, 255, LED_BRIGHT_HW_CHANGED);
@@ -664,6 +648,11 @@ static struct platform_driver pf_driver =3D {

 static int acpi_add(struct acpi_device *device)
 {
+	struct platform_device_info pdev_info =3D {
+		.fwnode =3D acpi_fwnode_handle(device),
+		.name =3D PLATFORM_NAME,
+		.id =3D PLATFORM_DEVID_NONE,
+	};
 	int ret;
 	const char *product;
 	int year =3D 2017;
@@ -675,9 +664,7 @@ static int acpi_add(struct acpi_device *device)
 	if (ret)
 		return ret;

-	pf_device =3D platform_device_register_simple(PLATFORM_NAME,
-						    PLATFORM_DEVID_NONE,
-						    NULL, 0);
+	pf_device =3D platform_device_register_full(&pdev_info);
 	if (IS_ERR(pf_device)) {
 		ret =3D PTR_ERR(pf_device);
 		pf_device =3D NULL;
=2D-
2.39.2


