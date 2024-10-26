Return-Path: <linux-kernel+bounces-383363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E311B9B1A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A2BB21765
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682511D88AD;
	Sat, 26 Oct 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QqSWk7fc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA51D5CD6;
	Sat, 26 Oct 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729971507; cv=none; b=glp4jPNayPR/gdpBVcvgpdhXO1oHcFT4vRw31SPQS1fIMVtBMuPuPxpYSwxGPRJEift7jk/NdnPW0r8yN2n7exE6lyD7YUjK1T8YBbHa9F87rIVRNnMNwfqDxIQq44J50MoTF8XAxBtgSVOCtoqv9ho2eSjvLc5YtOklzdrkEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729971507; c=relaxed/simple;
	bh=d1V/dguyMdkQ894qaTrU0VIKewUzrG583siX1uYRUuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBiEA8OTYC3T6aa1SBv5Vx/WA/VgjfniSGZJRTizTExDcXIH17QLZxYNEjWNPLYe8wf9G30FEFbukatDwT5qtj4viWeMISNKVH1o7ePnR2ndMeVd3hjj3jjEXUahu13RyYFsM2CM70zi2KpTpEmKspxxYVx+4bqFB532N9Hkcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QqSWk7fc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729971487; x=1730576287; i=w_armin@gmx.de;
	bh=Gf9Rm3uYqtLsaxiRDrxMARdgLCzi8xnbixUi1ilrFmg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QqSWk7fcd0sb3b6lpx1yidaJyy2nQ/4a56xvHLt1jE0XLa50W/MBwMruYZyAFe3k
	 CVaLh8V/o7N2OLRPcYmVKIZ3RMWz7pemdryKKSn4qVETzCv7iP+ljknmAEZovvuV0
	 k2fdprSSyl7ukQ4WY+GYmXiLYBBLgVhkrzcPtPby3RpOXDGpT2yrChZYuIcgZjuPk
	 54KcC2SDmH9+qSx2xNSL56SN+Ev9uBXjaNSON/QIKtxxPJplQSqDLKXeLJ8bRAc/1
	 DDIDczVc6/SZk/0plekT9um5TP/CF/osEJSF8XFD63krdcDsbQYuV5xsyLHyEJdXL
	 /y7K00/s0gy+EsOZ9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvsEx-1tuoxs2HEl-015nSX; Sat, 26 Oct 2024 21:38:07 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: wmi: Remove wmi_block_list
Date: Sat, 26 Oct 2024 21:38:01 +0200
Message-Id: <20241026193803.8802-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kZJhtkoclHRproBQXZZet/ATUoqs3c+/9DMHHFpC39RiWdUuA2y
 jZbyFccFYjKB3NwKarpL4kevuAg6zIyANBG18bTCK0JGWighPXHTKLG2KM2rtV37ypXvkQU
 Dy6Ew/pZfy2llSbCsmw7OS6zfb+P/JV/Ha1WWJ16PS7TlQQUN1LAlvcLgPUgHmC9S3YOAvt
 9Nmn2A/tASxe37qpwUmew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2p/BzGKeGUs=;q/CARAxDSmw5TpR4a5JsaF3rEt7
 nxnD/vcPlb1lbxzS6jO367m7vs7GOQqEUk4YuYhMbPV7VwsNri3tk2+Q8ylByrkR26aw5GeCY
 bEPESbC3fDMVFeSWw0jn4u391I2HEl1Sb9gMAvEUyzs0yGTD6EASY40sA9077nHMUnUglVazJ
 O7kXLjgC3/izmC8H+nDIuT9FcD0QJJLgqxCO3groo+17BDCQ28eK0d2ResntZA2zJiDEkj2FH
 NrJyfRuMV4APDtAJLUHrQ1pTPa0E3O4RWaxkk8T7a3GrY4lgBINyek3GZwa8e3wA3p8iTmnXN
 +uodMD44loQIzq3nndqxCSVZ6TDaALZg7op2ybudBKdQOqTkU8FMbnDTNEYYXsVnm7WnhbHUD
 ht+HczaEYCmLg0saUwmlw0PZKTCnORgQ0NmmrqH2y4p85b3zKACPu67GVKwu0A8C/buvvSkeQ
 TBAGsSZlnO2UYDOm1SILCgHfmQoIxxZdiYJu95nV084HjrXxObX/IgpBb4vK53lCkPvHCY2zZ
 UC4fWHZctU+gStLJUWLmRp/VkIo6OTmbffFsdbVnTO58LDyOi4faIC8vkEFr9vVoFHHfu/RAd
 dhYExKREU+9KddG7bl8q2xw8lBxK/YZtIozBV466NpLFoC4IVeYxWdw6n5Opqw8BoOyaSPkxz
 /YWrIPbfTO2gtwYPITTVzGa3TDH7efOlU7P8/OcslUgq2WCkNP1MX1yi1a3iE4rJNRpnLEZvH
 u6Ih0ruhdkA8MAO2UErKTd3bgb3emj+N6l78TcNunqVo7EEYQrBnzWfQEcFPbJQMctJk7BDO2
 W/UffGmvUTX6cl+2sIvlDlQQ==

The wmi_block_list is only used by guid_count() and without proper
protection. It also duplicates some of the WMI bus functionality.

Remove the wmi_block_list and use bus_for_each_dev() instead.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 50 +++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 2d6885c67ac0..4704e79197f6 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -22,7 +22,6 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/rwsem.h>
@@ -37,8 +36,6 @@ MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
 MODULE_LICENSE("GPL");

-static LIST_HEAD(wmi_block_list);
-
 struct guid_block {
 	guid_t guid;
 	union {
@@ -63,7 +60,6 @@ enum {	/* wmi_block flags */

 struct wmi_block {
 	struct wmi_device dev;
-	struct list_head list;
 	struct guid_block gblock;
 	struct acpi_device *acpi_device;
 	struct rw_semaphore notify_lock;	/* Protects notify callback add/remove =
*/
@@ -73,6 +69,10 @@ struct wmi_block {
 	unsigned long flags;
 };

+struct wmi_guid_count_context {
+	const guid_t *guid;
+	int count;
+};

 /*
  * If the GUID data block is marked as expensive, we must enable and
@@ -942,21 +942,30 @@ static const struct device_type wmi_type_data =3D {
 	.release =3D wmi_dev_release,
 };

-/*
- * _WDG is a static list that is only parsed at startup,
- * so it's safe to count entries without extra protection.
- */
+static int wmi_count_guids(struct device *dev, void *data)
+{
+	struct wmi_guid_count_context *context =3D data;
+	struct wmi_block *wblock =3D dev_to_wblock(dev);
+
+	if (guid_equal(&wblock->gblock.guid, context->guid))
+		context->count++;
+
+	return 0;
+}
+
 static int guid_count(const guid_t *guid)
 {
-	struct wmi_block *wblock;
-	int count =3D 0;
+	struct wmi_guid_count_context context =3D {
+		.guid =3D guid,
+		.count =3D 0,
+	};
+	int ret;

-	list_for_each_entry(wblock, &wmi_block_list, list) {
-		if (guid_equal(&wblock->gblock.guid, guid))
-			count++;
-	}
+	ret =3D bus_for_each_dev(&wmi_bus_type, NULL, &context, wmi_count_guids)=
;
+	if (ret < 0)
+		return ret;

-	return count;
+	return context.count;
 }

 static int wmi_create_device(struct device *wmi_bus_dev,
@@ -967,7 +976,7 @@ static int wmi_create_device(struct device *wmi_bus_de=
v,
 	struct acpi_device_info *info;
 	acpi_handle method_handle;
 	acpi_status status;
-	uint count;
+	int count;

 	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
 		wblock->dev.dev.type =3D &wmi_type_event;
@@ -1035,6 +1044,9 @@ static int wmi_create_device(struct device *wmi_bus_=
dev,
 	wblock->dev.dev.parent =3D wmi_bus_dev;

 	count =3D guid_count(&wblock->gblock.guid);
+	if (count < 0)
+		return count;
+
 	if (count) {
 		dev_set_name(&wblock->dev.dev, "%pUL-%d", &wblock->gblock.guid, count);
 		set_bit(WMI_GUID_DUPLICATED, &wblock->flags);
@@ -1120,14 +1132,11 @@ static int parse_wdg(struct device *wmi_bus_dev, s=
truct platform_device *pdev)
 			continue;
 		}

-		list_add_tail(&wblock->list, &wmi_block_list);
-
 		retval =3D wmi_add_device(pdev, &wblock->dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
 				&wblock->gblock.guid);

-			list_del(&wblock->list);
 			put_device(&wblock->dev.dev);
 		}
 	}
@@ -1227,9 +1236,6 @@ static void acpi_wmi_notify_handler(acpi_handle hand=
le, u32 event, void *context

 static int wmi_remove_device(struct device *dev, void *data)
 {
-	struct wmi_block *wblock =3D dev_to_wblock(dev);
-
-	list_del(&wblock->list);
 	device_unregister(dev);

 	return 0;
=2D-
2.39.5


