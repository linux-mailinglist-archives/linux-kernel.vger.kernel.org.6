Return-Path: <linux-kernel+bounces-516775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED61A37739
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23A31887528
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C561ACECE;
	Sun, 16 Feb 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MlXfy2YM"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3E1A3155;
	Sun, 16 Feb 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734428; cv=none; b=RulNUgUf9z8tS3iUBswz/8HOtHjfZQ1UEM6KEZ1O6+955ekuhRqInXd/BlCwW/4tYTvoPdvLyYADp6Ud+iiXhgmIPv/8ZmLuG846m82zDyDbYp46LN2dV9M3DwUDy2Fut6IX2SvGvmAtkBNv2REOeTeJpbMEZT0gcS0avkh76mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734428; c=relaxed/simple;
	bh=yy/egALJlGg2nyNQfr1nfCTmkXionDmd0uyxqFsuSmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rH5s2JxX9xkgpD2KEnPtSDpQ3pHRt/vg2VxBCN/dyIsFVkawamIZZN41kSqlCysCLiOVxqNU8cFty06XxKw363RKyHj35VdX6Jx9rn9Qd4NNoP3/VU0JaC4arTRn7b5/0JXYvvWpyMfZrijeSVnS1eRDct0koo21ZgrTMLV3JNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MlXfy2YM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734394; x=1740339194; i=w_armin@gmx.de;
	bh=rgLcWVwAD5AFEDNUDNUW1/ig/txcNSoRp3vKvht8+6c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MlXfy2YMw51CWV0Zo2Gqgl4/ACoFJbFrL5rbKjCyR3DWfmZxgCPFPVJwAn7ssWzY
	 kexh6Gordz64gW7PdUexJ5bP5e8RtakiRK+BIJOtxU0H68hq6jXFafBx+JxTvsBbm
	 BFrL/6PeK0CZMMYghHHabXhMl+Oozj7d8TKisiUd6SacYdZDkE2PwwuiBXKcUgGsX
	 RdSWrI4j9C0hoY8jguGF7EmDXAL0zOUbJv9qARMcgoPcmpoujezoaDWSnTjm+tvbs
	 9gTI6upRsdaKXgx81he7GJAHbcTq0jLjcT15ebP5fLbdDtG6EwQQzT4A4DMpxeLW9
	 VUah9qQV+KFtyV86dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N1Obb-1tLREP2Ohn-00udkZ; Sun, 16 Feb 2025 20:33:14 +0100
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
Subject: [PATCH v2 5/8] platform/x86: wmi: Use devres to disable the WMI device
Date: Sun, 16 Feb 2025 20:32:48 +0100
Message-Id: <20250216193251.866125-6-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:foQTVB0Ul4JZlTR+BQrhH2jsmqcpefP37lV069chqlusmHSXOcS
 gqqr09+JTAio3a9t3Azm7EKYzNMWCqTizTQNU2nBvTbQIw9TLTRg9Df8FbZk5nvgnKDIgJ8
 TEkl0J0pIDzAW2wTrAICol/rCkIokpOiC5Jod0SXbGOCw0pLwgIx0bejPpe/AbCaOKDq0YB
 x88hrVfKd0cRH80SFJYjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3w6imBrrSFs=;5j8/Aa5e/ratfIs67vS9q5hEJR9
 jNdTitAKmbP2R9fobzsRZ60Dm/Nc+s8jpu03TXtioHJ3nga4Obs++baMUn4uEVaC26o3fGONG
 NP+qiM2CRtJGnMxLkGiuAaoOzhPej0iPIpvRXTtXkiOicXuIHMGKc5KVOluqv/KYVoZo9EUyI
 K2CQaNqJaMHxhPZNZkfYtFDQaCrsBCmpw5E1ElYcQuHIVTNnGdc9llrh8/h2wWwJGmU4KfIsr
 U8cF1caFVzLA781/BSAYXfv0icfKFOvW2CQ7ra2TBH/7rACZlgETFc5s3IdCW8llENGIAWyPs
 G55kSVLK4vo8UZJkk6P5McNbQ9eSMZ15yAvhEGJ74lK7QZtIEX+SDEgiuanGyQJT7XsdkJr+X
 z/V/5Ny+OLuSPo7Bkw2kixBO4AsdCKECAsYaG/rtxKft0QLs2PsGR2ThKFGL80dFV2LeDC7My
 FXeO6RBqjM+qdHZRSlstg9Ga2C+vp4gfURR3PmYRksU/mxaKtLb0po/VrHoXgsnNpn99l/vGV
 DoVJNKWlIAMX1bV1WuiZH8SZYnXgUh8Kx2OPKmqDBlLt7QOQSoviIG3uke16JvnqZZA+RVk+m
 /Suw37lHoR6IFrX9Q/28q7/NimimZQqRLrina8arUsmHDC8Ft6JxBaJQmT23SPafjYaL5jK50
 JvA+Sca9zP974VHVg9c+r02TcvFw0KsrFErRK5fyvWyoz60knwK9voBH2ORjQatNAkxNc/kJm
 OGxyDvSJpqzXLOiUuQwKaorKlTrWrWXLflgtm/cwceCyd3uNY5g1vPBCllJDm3Jq7W7qIyCGt
 0yWBSHUzS6mflt/SVRIDh4/bKGOuh05QK+zMM28dGJAO8+F1oDYvSlnjpCGcOPz+WbrrO9eUl
 +IJN5vRIBTehny1UTJdS3/p0k7lKKd84VaA4wUfECK6/9n5TyMPL2OghJKpw980z5kCgBwWH0
 WARalYGHnasMav0Dg5fKNyDnrD44VxkcFLw8idgvfp0MCM82+XnEoFam0pHefBCxwmd5IQbsR
 TkfKWMyrcLuU6VekDn6sgju51Uu8l+wpOT941/V+Zx5LuYkvO1ayhsET6tbp2pxqy3TC+ez/B
 Cs1IMWEyDfUtZm1TxCO1MBfiuDj6utK15jiTIXi1HtwXOpSPPtoefiSXU4m6/c0h2bzxR6RbN
 3thcvuCt6+R66AT82OSLnY5QwRq1sMZyIQSbDVlqyYKOYdUCPzZP5re/5CQ5P9shnjU0r11Mo
 aE6RVaGHGS9joqWKLNeacaZfw6GDCTt1Tz0sOWNU7TgmtrgmOZhtoRcXJpAT6KDh1l06RLKc5
 ag89Nm79HMGv28dy+7B+q206NzdsLqjZLPfPPOSIhazRwziNRXp/vHDRawiBdCPiHUNjfKrfA
 ncqitgGwzlRpnmjAMHjpgM6YnjRp9BzKplOBgCa8AmGECSmhQFNFZvOB4q

Use devm_add_action_or_reset() to disable the WMI device instead of
manually calling wmi_method_enable() to prepare for future changes
inside the WMI data block handlign code.

The reason for this is that we have to make sure that all
devres-managed resources are released first because some might still
want to access the underlying WMI device.

Because devres-managed resources are not released during shutdown
we still have to manually disable the WMI device in this case.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 646370bd6b03..7cb36a71e9ea 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -821,11 +821,19 @@ static int wmi_dev_match(struct device *dev, const s=
truct device_driver *driver)
 	return 0;
 }

+static void wmi_dev_disable(void *data)
+{
+	struct wmi_block *wblock =3D data;
+
+	if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
+		dev_warn(&wblock->dev.dev, "Failed to disable device\n");
+}
+
 static int wmi_dev_probe(struct device *dev)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	struct wmi_driver *wdriver =3D to_wmi_driver(dev->driver);
-	int ret =3D 0;
+	int ret;

 	/* Some older WMI drivers will break if instantiated multiple times,
 	 * so they are blocked from probing WMI devices with a duplicated GUID.
@@ -847,15 +855,19 @@ static int wmi_dev_probe(struct device *dev)
 	if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
 		dev_warn(dev, "failed to enable device -- probing anyway\n");

+	/*
+	 * We have to make sure that all devres-managed resources are released f=
irst because
+	 * some might still want to access the underlying WMI device.
+	 */
+	ret =3D devm_add_action_or_reset(dev, wmi_dev_disable, wblock);
+	if (ret < 0)
+		return ret;
+
 	if (wdriver->probe) {
 		ret =3D wdriver->probe(to_wmi_device(dev),
 				find_guid_context(wblock, wdriver));
-		if (ret) {
-			if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
-				dev_warn(dev, "Failed to disable device\n");
-
+		if (ret)
 			return ret;
-		}
 	}

 	down_write(&wblock->notify_lock);
@@ -876,9 +888,6 @@ static void wmi_dev_remove(struct device *dev)

 	if (wdriver->remove)
 		wdriver->remove(to_wmi_device(dev));
-
-	if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
-		dev_warn(dev, "failed to disable device\n");
 }

 static void wmi_dev_shutdown(struct device *dev)
@@ -902,6 +911,10 @@ static void wmi_dev_shutdown(struct device *dev)
 		if (wdriver->shutdown)
 			wdriver->shutdown(to_wmi_device(dev));

+		/*
+		 * We still need to disable the WMI device here since devres-managed re=
sources
+		 * like wmi_dev_disable() will not be release during shutdown.
+		 */
 		if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
 			dev_warn(dev, "Failed to disable device\n");
 	}
=2D-
2.39.5


