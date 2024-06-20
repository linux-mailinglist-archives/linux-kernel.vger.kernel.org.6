Return-Path: <linux-kernel+bounces-223400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078F91125D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252F31C233F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D01BA065;
	Thu, 20 Jun 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NkZOgw6t"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990B1B47B0;
	Thu, 20 Jun 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912555; cv=none; b=jzw3lcV0+/TBp1iv/yqgkZPD74jHWGSXoj8TzdOivniugCIsRLPRiD8DSlWDtWSvPkt6gKqlwDSsrri0zF4iBW5qnSNjEJgJ2164D6jR9G7MEuK6d/uP5Fwte5517Vsk8liR4VG2CL4HkUx34cJn3byntPn5g4EJc8ehPC6O2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912555; c=relaxed/simple;
	bh=mYmnt4GK2dGIOCIs5anX3G58REvbWfiaZ0srsiFxdnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4UjgsU2gadLgXYObVvEIPwsIxfvpF9sgoqGL4lUJhD0vYJMUh2uojkjUjgiYUFh+z462ithITGIuNRbeBK8v/PRnDEtA/khHpZnPMbVefA59FNvYap+nw+yXlsgiKXeZa1LvAjQ3FhGJdgxk9gwGq+ZbKIn7RAkkrA8pYai41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NkZOgw6t; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718912544; x=1719517344; i=w_armin@gmx.de;
	bh=PYp2lv5xv22R9q1sDIOv7IbibTAKBTU+eiSHljr5q0c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NkZOgw6tF+AkUT4jtkoWL/LIbofS0AZAqX8mbEXBXblsByhzrwp26DZ1Df063+T0
	 tNvBXqX63TyQ6/yUukg0RRzu7Sh5/xa6w1+JZ8mlxBLVQ9dMs06jYkglP/70bsbcX
	 KlUdkTzK+dEm5tHoasbKTU4LTB13INsMgr5LBNhRpMSXVdJv4EssvJXGvghhWzLY1
	 mSfjivNUseq+oRDo4JfAUue3U2wKlKLpC7DmM1X3TivMcvhHb1dT6/+DXPxgFWcbz
	 OOY29APTOyD2Q8i+myb83yPUjwz5L34mfGUXSvqLj+EqyWuWUWTFBMxO1ZOvB+K4z
	 CMuKEDkhSyX+qDvKSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MiJZE-1soVDt3XXi-00lUcl; Thu, 20 Jun 2024 21:42:23 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: wmi: Add driver_override support
Date: Thu, 20 Jun 2024 21:42:13 +0200
Message-Id: <20240620194214.3071-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620194214.3071-1-W_Armin@gmx.de>
References: <20240620194214.3071-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nDT5ve5bn/1zdhwo1EqKkZGy8kV47xYEIMkcetYfJy8IkM8oynS
 oBk51ViQKdsyuiqrZH5sBzN5HBciQWJcDvtrv6XBIgUjATSF/CvCdkTJUE6G5X8m0Gt0VS3
 02U9aglRbC5Tc4qN8hKcCNzgBz5lJ/iK0PmFlycKUrESsytsgSJleTkFhRG4CVNCflvnBxM
 f2s7TKVAS+1Mo2EQPDCVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qaWDuPhjJdM=;kAoxaNUUSO8vx5KKcsFvMaM9OCk
 Fb8db+URy3LhuxhoHPqlyDUChbfLXV9bnG0ERehbH+Z/tQB/feNroLWHPzU2vFszJd0+ZB1xu
 Hfo/9SxGmJtkvWjSg0Xq9XlraoyQUHs55GlxcBu9ihVRR/WIptLei+EJGsBXaJ2K/MRFePsFz
 pd41ygVntfagvdfc5HBk8+NhNe0ODu/6+VcJ5oSgxFql/tqndbFyTk+ulHWKhcptu0vGBrS/r
 6KtZDUlT2PNL+HSqDHAsTidJi4nnkAhr33qB/GdHJ1BhkwepoPda+cySOZwx+WYLovRQeDLsG
 jrXE8uI+r6PX+t1DxUh4L/ApYExSgtnX+TtckN8a3pdxG4iRfjbN3zfN4/YXc+epqcuykI4Mm
 nWCD41i4yfIwBkdi82aQ6un6KTyMvQIH7z2u4Vnk/Sb+hGDbGCNtvuL4eB/fG9QewnwQAS8nP
 U7sfkVazKTyoWvMyT0f9JMfK/X0GFj0szp/USiTx2NGZRkXljIt4CtgM8ns4GEyKo5FRl1L3O
 R7Jxk2WcUZJbCC1XTD3zBcCsfECTHpl7K2R+xwHz9H+0vksxQo2uAwds6he5DImpHjZaMFO+1
 vYUjyJJx33zWJNoNn12Q45j42QWbHUT9PFrNwMvPadCoHfft+64Fk7FoJmajcUw6BXPQSiA2x
 Dd3y29g8kGKxVIhrzQlPM50UKB27VItW1HabEYM9pcRSTwLyzuwDwVGY6BHZfPNEgH43RyhPP
 DgfAmbChCSD76ulqgXMclCKe2piVXv+fQBoNf6zv3YB9iMp50qDOzyLxThkTtMQM5f8vDBCx6
 QrWMWjPJPdkMqbtgEj26P0+x6K3kkFGgxNssZjiQUZXFM=

Add support for forcing the WMI driver core to bind
a certain WMI driver to a WMI device. This will be
necessary to support generic WMI drivers without an
ID table

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/wmi.h        |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index d21f3fa25823..6bfae28b962a 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -772,11 +772,39 @@ static ssize_t expensive_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(expensive);

+static ssize_t driver_override_show(struct device *dev, struct device_att=
ribute *attr,
+				    char *buf)
+{
+	struct wmi_device *wdev =3D to_wmi_device(dev);
+	ssize_t ret;
+
+	device_lock(dev);
+	ret =3D sysfs_emit(buf, "%s\n", wdev->driver_override);
+	device_unlock(dev);
+
+	return ret;
+}
+
+static ssize_t driver_override_store(struct device *dev, struct device_at=
tribute *attr,
+				     const char *buf, size_t count)
+{
+	struct wmi_device *wdev =3D to_wmi_device(dev);
+	int ret;
+
+	ret =3D driver_set_override(dev, &wdev->driver_override, buf, count);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(driver_override);
+
 static struct attribute *wmi_attrs[] =3D {
 	&dev_attr_modalias.attr,
 	&dev_attr_guid.attr,
 	&dev_attr_instance_count.attr,
 	&dev_attr_expensive.attr,
+	&dev_attr_driver_override.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(wmi);
@@ -845,6 +873,7 @@ static void wmi_dev_release(struct device *dev)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);

+	kfree(wblock->dev.driver_override);
 	kfree(wblock);
 }

@@ -854,6 +883,10 @@ static int wmi_dev_match(struct device *dev, struct d=
evice_driver *driver)
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	const struct wmi_device_id *id =3D wmi_driver->id_table;

+	/* When driver_override is set, only bind to the matching driver */
+	if (wblock->dev.driver_override)
+		return !strcmp(wblock->dev.driver_override, driver->name);
+
 	if (id =3D=3D NULL)
 		return 0;

diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 63cca3b58d6d..3275470b5531 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -16,12 +16,16 @@
  * struct wmi_device - WMI device structure
  * @dev: Device associated with this WMI device
  * @setable: True for devices implementing the Set Control Method
+ * @driver_override: Driver name to force a match; do not set directly,
+ *		     because core frees it; use driver_set_override() to
+ *		     set or clear it.
  *
  * This represents WMI devices discovered by the WMI driver core.
  */
 struct wmi_device {
 	struct device dev;
 	bool setable;
+	const char *driver_override;
 };

 /**
=2D-
2.39.2


