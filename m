Return-Path: <linux-kernel+bounces-383362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0229B1A99
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1781C21597
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091E31D6DB9;
	Sat, 26 Oct 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YbFGbmzn"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61CBE4E;
	Sat, 26 Oct 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729971504; cv=none; b=IpRn6AB4iX7Mb//BXaYnUCGiB0RnJ8ZdLVZurI9j/yfTjgLAOV/d8cmj0kvqiDuJGdYIFJ9GwuMjcbnUynJIWhY+Hlg7klEI0/j1JGZfv8cJoL7FAz/Fj3M02u3qvG2JnAosNVKAR1RJTQ/czUnD9MkUPCGyApdEa9L072wa2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729971504; c=relaxed/simple;
	bh=5RRWiQmsC5FKUz3XyvJ7/XFVMP24+NnJLtShimQI7fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4NJFbzyfbOuPfteKJmeuqWR1J2WGup1riMEmC/v+vRMi1BiNQkaoeIMopPg3RNZJlg/PCE1Y8TpIDHdGYcN1daZj9rfuhY/u18K/YboENOdItu/juqe0MH8zRhkY/7F4gvbqu4cfmx5MOcXIxNHDZPsDtSniQz6y/Yo3srLR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YbFGbmzn; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729971491; x=1730576291; i=w_armin@gmx.de;
	bh=6GN27BLIp3KciUHEE+3grnjPhepIK6d4LaQSPpqOLms=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YbFGbmznwJZYoCKEcOeYJD343p5KXGu+R+/OAY63wLAIiTOwboIAsIbclZdbnCMU
	 wXZ24BKiNOXxkpONz94hQh7swP/ZfNGY1+ZdPftcztSfPWgjZNQB0CKJ/ZsT0UVNV
	 t6YfRQxnin1Pg/MHnXL39JQiyXgw3tISJ0r/oumSOPcq/ln01BY1fw/PqH8s2USJj
	 TcAfQ79Hce5WPBgXNJdLo4TtHfbPKxqEQH3Qk+QZRRgKDj7W02Y+UI4z7vGtmZ3aE
	 B4UBaswW2LWAU0yUYkOIB/nEMRal2BufutxZTpyjdWhsFKjyqIQeFWbHTKi/Th5Sm
	 bgwb9pSOUFfVrVQLPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MK3Rs-1tJZPR0nR0-00P955; Sat, 26 Oct 2024 21:38:11 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: wmi: Replace dev_to_wdev() with to_wmi_device()
Date: Sat, 26 Oct 2024 21:38:02 +0200
Message-Id: <20241026193803.8802-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:iL45+0jZjvfGTJDg4ehBeGTA53P63hBb4KVnBE8k/yJh3FCnDKa
 uEeMsxmaLPuHekqLP8EeHpfkMkHnOAdlAj5kiMwp6BQPV5zyPDSiqjY8vu/PryOd/pPsFfO
 ZB6/jkli75y0rdR6S5k7taSG0n6eLHbK8jX+4BV+dmYEX4mNAPPxWKSRVUuMBukHFdJRLC3
 Bu+6h52G3y3D1/oxmuy3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tDixci3RelY=;8qhZ2iBKfT2c3OTwZrkrQLhC8An
 6h20oixrkVKHJZRhkpbJBe/YR4K4QCGHdTNGw0wYyhMy8CBRAUDBeziHu3PdnOYJm/khCk8wW
 dAy6kS89l25j01VyOi1JtEpVsXhBj687cMZMn+G0m45hB4HPO3WIAIauwoichbpZVwRiaKGQY
 K5hTW561GdOjBaj6slffoRkk5EXIvkEn+2srnvX7plXwgLqxM96RVKbLRF2ospmj9d+kVbH97
 aIxwke3UgMkM5UszZn43CJ3AA8vqMGOnPiw/l2fMQxEdw75as8xm0rDxHorsWidN6+9bFHdNP
 Eu7dUB4Tvi2eR09pIfPJ3UQbg2ntXvJCX7QmQCYk61Clyp/EEiIQfgq1KKqIjnpcyaOc4/7dy
 /EAFs3gyZFFr9xFgktjtfYXx1FDkGvHhnCfTJfL7YDAJ2oX0a/A8OYQahzZBlKTVExU6Xj41z
 ICFbRXO8l+MVNr1iWWfFlKAZDKyZAXeYKGOEilsT5PSvPzaxfz54Ry4t/E+i5i98N7Suxibp/
 b5OaJ1S4Gw6NabSJOxdAciABpqgi+LVjjC29qkumu6wVRkRwX/68AIV2unJh70ugx/3JE0lCC
 6eHxEMyLCQj7bZvqiV2nACAB7kAzDFIDrmdzx6Bkn8pW6uJw5PObKAGXLYiL3LtA0PoGt+hSo
 bnuN3vWpZfHMidSRklr83vefjzf1et4MyxEpAdNW6B+omVsVbBA3ttVlDSZtFVsKa9NoPukxu
 8Iyu8kcX9RF0P5MgWfuZLBoAu4UklPOWYX6gHoH20+zQzCAO/ouL2jl4OJL76OJeKlUUlCUIb
 auxSWODhffKEr2/UwSD3No0w==

Replace dev_to_wdev() with to_wmi_device() to stop duplicating
functionality.

Also switch to_wmi_device() to use container_of_const() so const
values are handled correctly.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 9 ++++-----
 include/linux/wmi.h        | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4704e79197f6..b2576d5189ed 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -91,7 +91,6 @@ static const struct acpi_device_id wmi_device_ids[] =3D =
{
 MODULE_DEVICE_TABLE(acpi, wmi_device_ids);

 #define dev_to_wblock(__dev)	container_of_const(__dev, struct wmi_block, =
dev.dev)
-#define dev_to_wdev(__dev)	container_of_const(__dev, struct wmi_device, d=
ev)

 /*
  * GUID parsing functions
@@ -199,7 +198,7 @@ static struct wmi_device *wmi_find_device_by_guid(cons=
t char *guid_string)
 	if (!dev)
 		return ERR_PTR(-ENODEV);

-	return dev_to_wdev(dev);
+	return to_wmi_device(dev);
 }

 static void wmi_device_put(struct wmi_device *wdev)
@@ -761,7 +760,7 @@ static DEVICE_ATTR_RO(object_id);
 static ssize_t setable_show(struct device *dev, struct device_attribute *=
attr,
 			    char *buf)
 {
-	struct wmi_device *wdev =3D dev_to_wdev(dev);
+	struct wmi_device *wdev =3D to_wmi_device(dev);

 	return sysfs_emit(buf, "%d\n", (int)wdev->setable);
 }
@@ -851,7 +850,7 @@ static int wmi_dev_probe(struct device *dev)
 		dev_warn(dev, "failed to enable device -- probing anyway\n");

 	if (wdriver->probe) {
-		ret =3D wdriver->probe(dev_to_wdev(dev),
+		ret =3D wdriver->probe(to_wmi_device(dev),
 				find_guid_context(wblock, wdriver));
 		if (ret) {
 			if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
@@ -878,7 +877,7 @@ static void wmi_dev_remove(struct device *dev)
 	up_write(&wblock->notify_lock);

 	if (wdriver->remove)
-		wdriver->remove(dev_to_wdev(dev));
+		wdriver->remove(to_wmi_device(dev));

 	if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
 		dev_warn(dev, "failed to disable device\n");
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 120019677fc6..fca5fd43c707 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -34,7 +34,7 @@ struct wmi_device {
  *
  * Cast a struct device to a struct wmi_device.
  */
-#define to_wmi_device(device)	container_of(device, struct wmi_device, dev=
)
+#define to_wmi_device(device)	container_of_const(device, struct wmi_devic=
e, dev)

 extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
 					  u8 instance, u32 method_id,
=2D-
2.39.5


