Return-Path: <linux-kernel+bounces-227676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08751915568
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47574281895
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2076D19F46E;
	Mon, 24 Jun 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JI3cCecM"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341E13A894;
	Mon, 24 Jun 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250299; cv=none; b=qxHVJHw2mOnMwmatX0mkfZahe9wjtADIeOCDRsgksMjL26z/YJRyY3jvlXBPianv3/dBJIpEuatClK3zeQVkf98wbrFYjeXYv6zvooil3/Oe/GAnYgAlvnGcGTtsic2yZoeInviWDOaJtd+Vj5tfY0iwZssUrEnQ1Fqxk71FTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250299; c=relaxed/simple;
	bh=XdxVXPs0FrzKGQmMSeDvltxdgcQwGC5Xcb4SblLsVFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ey7NM7NQYndLQN3PIwKcWhHAgFgxFrEekdPq+bICJzA1bDUaUGTa5U6Xyk6DWzeaPCvHRsJpIWMUYTOJXvhavg2SFSN+ytcIQXa+96pAS04ar+q4GrZeTIaiX9qHd+qC7pBVGR4p7TvP7qXKUAPaBpTeRSdM655syEv1TxkJNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JI3cCecM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719250287; x=1719855087; i=w_armin@gmx.de;
	bh=+qJmOMBm25X7fZDXRedua2L1lHerFi2JeTAI7UKGdKk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JI3cCecMm8besxxcXmGOYXONs9qkoeG619t8y5fBh0ToWCDY4dKzBFtTi2vcH323
	 vfSplnf3sOpGag4UBqeFFSodO4x9xLLzCzEf6Tj4soGJdM22dbdxGux+/LaOZuSdk
	 dDKBMxG6w5rg/rSp0USVCisrH7ifR90apYe8O5Dq8cV4DzKMMUdPKcUqVnwYqT+9o
	 3aiySMfhTm2gwKrz161PgUHINPSLDdXqLeAa/+6xxfyUrX3hIhFmkzstgbBklntEu
	 +DpHaW1TYoRldIHg386MXJqleWWV5VTJCsaLOzWLoORCP4/ZLLoEpZe0i7kAI9kZT
	 6ZbQz3zyIs87Qnb/fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MxDkw-1sWjmY3xGa-00z3uT; Mon, 24 Jun 2024 19:31:27 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: wmi: Add driver_override support
Date: Mon, 24 Jun 2024 19:31:15 +0200
Message-Id: <20240624173116.31314-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624173116.31314-1-W_Armin@gmx.de>
References: <20240624173116.31314-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQeSh2efmmUNKLT0JZocwEub67ShYeyMd8VPvF0B+CdEEdr9DsX
 QgOilNs47UzJkIfCvq23aWNMKRSiu5QN+dK590NfEhd60N4LkDGGPWVB8/njS66t1h6jY/r
 jKvpaugGwdJ9cvYOP+D7BRs7s9h0u2XQ4w/H9fccLYAUounLdpRifHv3aG8jKsBedGhZvtL
 m3eV0ioPrVm1bWhdKQ1gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QkVIK5W0X54=;fhB7SvGD/U4VJeC1+9iyD8JXu2q
 Rjg7YYiwRLbhFq3kAcZbUv48+M1f2QRgmHjM2RJtGwBMU+78e/PQ78gyMjBpmyCg5/tDwk6tO
 zuas7VRHvEVl4ZdBvHEurpcA5d7PUHcBywv/1yAQhWceXolWgMYNvjM2QMOQQ7WDDvRtpjKEN
 hx7msP8BFJubWA4ZSIx9hl33Ty1Gk3pwJY9JASSLr5j2Ta/AXFO24YbMQD57xrgi8Bt6/cXfh
 a94Q1J5y/bQWj9a43FT4A0/W7POP/8WQb7jm3tOG9Q7MU71BisGVYh2H2UUrQJuiGbOvk+PHP
 pBWQRkGBpW4cuEsL/B4As5GwUk2XqRden2MoutVUwkK1Gr4FT4YXMZm06kZ8cnSAjH1pXIZK4
 pGeHm3xQKmy05duG4hApENxlBTP9g3w6RKeFc2mDF8fHbP2uzMv5dlj3rC8YQ8adI7Z2iX5vM
 OJ9GQ14LzK71iO5L+mCd/baK5Aea5AnrHtilFT62Rp2cCtioNoXvjzNVx5bDiUR0ZAIxjXWS1
 /TXCzyax8EVzWPpoyvkD83f/iSyVW+JKJXew0YE2YhJjUe68b8fIVlOPPh1wXA6CbtKFEu86l
 7aL6mQ4uUoMFc5IS7qk9b97OLiPVdg6uWVYZ0Com/4O260ei1eyk3h4Y42Yeft0tqOBJ1xaAa
 SoDmuFmE1N3cujwhE0uiQSi59oJrQ/FKqMneSxdPgUZ3Ro5F+sNDe2m4f3FQW3cJzZF+5L0WA
 WQuEI98CTGnqJezt+yUsRFHlXcNBqcis8z5l0ER59vVmNhmI2MO11Ak4WuRcxFobj5dKbovWZ
 kCmL/KGfBnTDTJ+yXg2+XedPFinHXEIUwM5u8I/zoVkY0=

Add support for forcing the WMI driver core to bind
a certain WMI driver to a WMI device. This will be
necessary to support generic WMI drivers without an
ID table

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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


