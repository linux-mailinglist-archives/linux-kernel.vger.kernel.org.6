Return-Path: <linux-kernel+bounces-435701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF48C9E7B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906E128136E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291A204575;
	Fri,  6 Dec 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EG2R5s3R"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F322C6C3;
	Fri,  6 Dec 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522227; cv=none; b=N56WWx9YRibmse4LmN1yycbEsaPDHGUrnjjOHA34hxgi02z6PsZGGF5dKHunKYTv1M+UTOB9zN4OXqFfY5PAEKzHxUlQjvCnFS/qM3ZmLBZfamNmndUuTnBdtoIXA/dChSckR9D18aFjrvgX0yw3nZCLkE7gm4QWh6W5mSupy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522227; c=relaxed/simple;
	bh=SmywzE/8SrM/WvdqM+K4Uq23ueox1yqICb1mpZzjT/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YeGgNW6ZwIlt5Tr6f+qMFgVLtZUUUrH83ztH9xGPWNkS50c5ShBcrsX9PWciXbPWHXByl2+SasUlruSGIQHrwVqEAaK8ZFw0EYj0fMNNCEAlNRsBc59CSi4BjnG5gEtDiUp1Kkh/Otjbrw5mIE8wMS5ZdbM+NStRo3HcO8NTK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EG2R5s3R; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733522216; x=1734127016; i=w_armin@gmx.de;
	bh=mM0+9Xt8SfhtSQJF2vyZ3azlCiuQbKlJQqRaVWm1nTo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EG2R5s3RqiEF0YTbPodCHRgXqtBhxvmhUQssyR3zHJDgLxBoG6CWgaWazI1zywFY
	 wL1tu1yrSmYg3g1VhQJxPD+XBaXn+GI12E+9uZIA7bvSmPDRweA3ZSa76AEW2wSrB
	 b1hUvgswfBw5NzQVEk0pjdNwAs4bQt21DCGkBCNpajtlbKjI0ByJZRJGLTh1uvf1Z
	 yg/S0ql2sa3lv1dWUA7GZA28GZfjL0DoHtiHV9qe6Le6BkFH6kge7HvfxRWFjDqw2
	 L76YAfBHCI08ivoPrSvHE5e/MT4lXVRkvJeTZdcTuSuFVRFO5NX7KzG0pvixU2KOS
	 WNE0dyiWNJ1yvNgreA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M4s51-1tJxQm3zD5-00BFlp; Fri, 06 Dec 2024 22:56:56 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: linux@weissschuh.net
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi-bmof: Make use of .bin_size() callback
Date: Fri,  6 Dec 2024 22:56:50 +0100
Message-Id: <20241206215650.2977-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iyM4dC2L+GYkowPGgDXdq5goD0TD+/TK9baZlTimbb8wj+YbDis
 /HEzq0VAbr37z3OVzEUu5SivP1d4Wqc2yyaz5pB1hkct5HIZFvPnPk6g0yViBQDuqAIhOxk
 tohsUClrz9/NVkltMOcz5G0k7id4Mu8fOqa8vho6rKxbDfyK6mC0Nz0IQm+WGyTSxxbbSx8
 5bLeSgPjKeSkGtlH6dFGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0H2r0O+nqyU=;z91BdkoBc1NFdxKG2Ipq8dMpgEt
 rvHnRkKUYtpmjbCB9UJi8vAKyI2bVAu7whUm9JLGzccB9rqpfY2U+0l/KZWguUc/CN9Fdulvm
 5YYh1sG7rN7Tq1O8nhT3fGNkE96/Cy2CFR8BMeUfGi6CPjazpDq4LCLoMMQO7lS0r/MgZCl+E
 Ps/QNPZ96GsVaT8XUpNHPcYW3qbEVoSMBtPN68TzfQDGvLnKGokY6GR76VfmwnQxo9TogEROy
 vi+Y0z2UED6gVlOn6oac46tUAH6JDGxcIjXps9Xb7iY4ywNLQoa9/SEZQTRHFiPTsw98Dm5nZ
 UKSYiXRiewU7LUMjY38mKkd5GGEglLoLYItx2DL18g8z3zs39ZrrDUDG9Z9JfoE4EsGHbcmr5
 VpoXAT7mRcVr/zGv148kB86Y1/hdcBOCr553hNGPxKCrRsm3iONhAEp3U4pq3JWDjJQp+1ySX
 qOZnvfrGRRluZFzVD39XmNtV1PFUKxbDBibmDwi/XDWSMOANYb38ep62eJwEGMY5QTfsnTgeM
 vg11mWYsvLLBoG1CPAAEwnLvSUxxg/+9MA9g6Y/XKwnkcSEu8323GFkeEgBBNcGBfowthF41K
 xDD/jXCfWNEzhKyA4yQxJ7/l9gnSSqaKQcnm1t+YHnXaWYuhrejwDxQm6k6aF/OdG2VJ2Rch8
 esowZLihy3/YL84JUeI/RAcCKDgrl3u4n+ubvdT/PrKk5nV8jbaE6x7uvcfFlgVi7FJ16/0V/
 5YIWkNcEhL2yYgOSuwSoYlL6s6vGlhPpsFwUt5UQkzwTaYHmOGzmrbB5li3KdRAFOn5wdveXU
 1wN5f1B3eEBKBOw+/CWwwVFHgyg9/U/RQZvA39DFzj3ueM/KZPSPEeaXY5JtMGDofd/hz6Bw5
 4i4jKL89rNPMVodbEaz6po9wYjjp4xDqhc62g0vM/yQhBhY8iY2y6M+y6LA8F/JZ1DEZ+Mnbv
 ry4FYfr2zWFoB4aqmw0CQC2LpBFIK1uQKsNj/OzpHzDhYZIX6uxeo1s5tDm8iCpRIl6gEsZXi
 meTNT54U14J/uUn8Zr37wUGIGD/IqaSyH3d4PsPE2WhJs0x9+P66g7IcRuszxeGUKM+QTr4TQ
 hAyxe5aKN2y5mjsf/ptrOt8yRPfVlK

Until now the wmi-bmof driver had to allocate the binary sysfs
attribute dynamically since its size depends on the bmof buffer
returned by the firmware.

Use the new .bin_size() callback to avoid having to do this memory
allocation.

Tested on a Asus Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi-bmof.c | 75 +++++++++++++++++----------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bm=
of.c
index df6f0ae6e6c7..3e33da36da8a 100644
=2D-- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -20,66 +20,66 @@

 #define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"

-struct bmof_priv {
-	union acpi_object *bmofdata;
-	struct bin_attribute bmof_bin_attr;
-};
-
-static ssize_t read_bmof(struct file *filp, struct kobject *kobj, struct =
bin_attribute *attr,
+static ssize_t bmof_read(struct file *filp, struct kobject *kobj, const s=
truct bin_attribute *attr,
 			 char *buf, loff_t off, size_t count)
 {
-	struct bmof_priv *priv =3D container_of(attr, struct bmof_priv, bmof_bin=
_attr);
+	struct device *dev =3D kobj_to_dev(kobj);
+	union acpi_object *obj =3D dev_get_drvdata(dev);

-	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buffer.=
pointer,
-				       priv->bmofdata->buffer.length);
+	return memory_read_from_buffer(buf, count, &off, obj->buffer.pointer, ob=
j->buffer.length);
 }

-static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
+static const BIN_ATTR_ADMIN_RO(bmof, 0);
+
+static const struct bin_attribute * const bmof_attrs[] =3D {
+	&bin_attr_bmof,
+	NULL
+};
+
+static size_t bmof_bin_size(struct kobject *kobj, const struct bin_attrib=
ute *attr, int n)
 {
-	struct bmof_priv *priv;
-	int ret;
+	struct device *dev =3D kobj_to_dev(kobj);
+	union acpi_object *obj =3D dev_get_drvdata(dev);
+
+	return obj->buffer.length;
+}

-	priv =3D devm_kzalloc(&wdev->dev, sizeof(struct bmof_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+static const struct attribute_group bmof_group =3D {
+	.bin_size =3D bmof_bin_size,
+	.bin_attrs_new =3D bmof_attrs,
+};
+
+static const struct attribute_group *bmof_groups[] =3D {
+	&bmof_group,
+	NULL
+};

-	dev_set_drvdata(&wdev->dev, priv);
+static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
+{
+	union acpi_object *obj;

-	priv->bmofdata =3D wmidev_block_query(wdev, 0);
-	if (!priv->bmofdata) {
+	obj =3D wmidev_block_query(wdev, 0);
+	if (!obj) {
 		dev_err(&wdev->dev, "failed to read Binary MOF\n");
 		return -EIO;
 	}

-	if (priv->bmofdata->type !=3D ACPI_TYPE_BUFFER) {
+	if (obj->type !=3D ACPI_TYPE_BUFFER) {
 		dev_err(&wdev->dev, "Binary MOF is not a buffer\n");
-		ret =3D -EIO;
-		goto err_free;
+		kfree(obj);
+		return -EIO;
 	}

-	sysfs_bin_attr_init(&priv->bmof_bin_attr);
-	priv->bmof_bin_attr.attr.name =3D "bmof";
-	priv->bmof_bin_attr.attr.mode =3D 0400;
-	priv->bmof_bin_attr.read =3D read_bmof;
-	priv->bmof_bin_attr.size =3D priv->bmofdata->buffer.length;
-
-	ret =3D device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
-	if (ret)
-		goto err_free;
+	dev_set_drvdata(&wdev->dev, obj);

 	return 0;
-
- err_free:
-	kfree(priv->bmofdata);
-	return ret;
 }

 static void wmi_bmof_remove(struct wmi_device *wdev)
 {
-	struct bmof_priv *priv =3D dev_get_drvdata(&wdev->dev);
+	union acpi_object *obj =3D dev_get_drvdata(&wdev->dev);

-	device_remove_bin_file(&wdev->dev, &priv->bmof_bin_attr);
-	kfree(priv->bmofdata);
+	kfree(obj);
 }

 static const struct wmi_device_id wmi_bmof_id_table[] =3D {
@@ -90,6 +90,7 @@ static const struct wmi_device_id wmi_bmof_id_table[] =
=3D {
 static struct wmi_driver wmi_bmof_driver =3D {
 	.driver =3D {
 		.name =3D "wmi-bmof",
+		.dev_groups =3D bmof_groups,
 	},
 	.probe =3D wmi_bmof_probe,
 	.remove =3D wmi_bmof_remove,
=2D-
2.39.5


