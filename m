Return-Path: <linux-kernel+bounces-234599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E4791C86D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6667B2605C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43A80BF5;
	Fri, 28 Jun 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pdyKr325"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B780034;
	Fri, 28 Jun 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611273; cv=none; b=PjVVZnBwNO54K3h8SeGgyTxVDRVOa9c1PkzMaXbA5WtG1LyM8tNwvgwz4LRBbQFNESNmaIJl41zbKnXd1S/G4+r7UTH9Hrl17SUhNjcUremnnKtFPXHmsjRuzRW/HE8rWtFeRWinih+bWVkXa1YooxpYwpgEoX9yl5RFow37zDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611273; c=relaxed/simple;
	bh=B/8tZDJsGVsaLODreD1PIpyCj/+GdBxQ3ATGY0y3Po0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBwJ37KsXR8QhElszE+kRSEkygvlV3DoA6FfK96cOcUPIanzyyikvds/Cw0SzKX3ztpepxMXNCKstXW8I55ACXXcEUtQRLGz2cqGR2R0a+VVBdvvPFvmmU0gMdHeovumtj8MXQkELSRfNmZaqO+JKs8zGxojc3BDKDgcyExybDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pdyKr325; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719611250; x=1720216050; i=w_armin@gmx.de;
	bh=VA8OHoFyFxNsoLyIQwYK59+hH83W2X16hxmTj+3risE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pdyKr325ds91WRMkamNsTr/XbH63AkeSgMqcGq9nMyOrAAQEnNgI6taCXeVHSC5d
	 7QLqICg4m3ORyeSlhF1gbr05STf+po9DKbRDSdoLou4jwaQZ4KZfomaAW+jDMZMEI
	 VKxWfQjpzkDQBluKDlgiJI7iBz8xoEWk12VRjbXIMtAgeCNpRutd7BNMb5DG9vH3y
	 GrdIefFXPsTsQv6X4QCA+QlmzG7ZhzpKdPVwoTUrfKfLno+D6Mrai3uPUmzVPTOCI
	 BtDkSXNfGAvhmriEPLPddOLVHySVdcAj4Wta48dFaS+38R0ezVUY+mwHDV0NSkPUz
	 FK8WTgiEKrzVWr76GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MulqN-1seI1h1KUt-00t7wm; Fri, 28 Jun 2024 23:47:30 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell OptiPlex 7060 to DMI table
Date: Fri, 28 Jun 2024 23:47:23 +0200
Message-Id: <20240628214723.19665-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:edCRx5YbhlfbA5nZqBnVML37Fv32WAzxjXHbspgsi0Io7Z+yFC4
 l+VmUGRSOddmhnPeGHXVA/tVTaLp2svvZO8FYTFqzqzjh/6eWjwazfOHL0gwoHyqzjl5F4/
 BNn10veGLkZnv2vjLigKQd/rpbjL/7X9AGhz7xbY5vrE+bykCoSx1tAifD4r5a09eFnAxFg
 UxldkEJsc6bgTD8/EAM3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e3gYM6X2Pmw=;rWgXJM43Zx8LD6ixVfTkZpEFFcc
 Lju95X/jBfQwzwS6JtuZ2vK8iuRhXpLbZZMozycgVApGiNx5o4qALm8uM/OXbv0GCrgw7XHOs
 /SUo/2EZAVVYRIc2n+SZZa4MA+yKQGkC91WkSNVfrvda2VEn1ePFrxkD4Hz1vlZ5iI4wG8NT+
 5ODFp1QifXes6J7W9iTanWJxOyN3aeWUB/MQ5S3lJM9bo5pTvzEL/OGD1tfiXzm6A9F1SM9r4
 rMHalKHXmOHZ50dIQmBtTu8AMClTl0YfPiHH9zjvgmGhEeIZ3bTDPxl39pYmYRVTxxP10xgfi
 mbGoTQqFdwDcQzYDxL8VBLfBX1atRKNp6cQIaLZildShX59BuGKVZkLPUw6lpqKlav+RcSYuT
 Dfi65nAXTPYxTT1yE6EU/ZaI4eHQB2cAeIGt1c8GHQQY7il+yACjx/Xj2aX0qDZk+Dmel9NCt
 EU0AY+vvi+95Vbqpm/bFmYPruVRdVCWPEW/xhmg9wMM5w2pZ8/2fjHZwojtI10MgK+1E4JWZI
 6NWVh/8LVhlBeu+xZFHh+k96xAPbNCt1mERpS09jLZP9CXPz6c4I0Xp6mFZ47Dz2W3L7sFS4T
 OEJsg3a4dEuhMLA0w+2JwW6doIaAWej4E86d9OZ7HB/tb0zcpu2oLiiE22DIsLTmm0E/cLxx8
 lrVhKyff6OKHd1RhibqMnNejEWNprHtP7s+gG9khc6WE31srMywNUnHgoFHX3MB/hxn46hYtY
 CA2hnRpfQhbUwMFZVr1VANdA/LAS5tI91Ka3c4YK2mYhVFTZZkQqX7mujFTfOfgHJJfKYRVP5
 YmCtzB0sComymoyM6LAh6MnrGK7R21Iy4OusZ70gNDl54=

The BIOS on this machine is buggy and will in some cases return
an error when trying to get the fan state, but reading of the
RPM values and the temperature sensors still works.

Closes: https://github.com/vitorafsr/i8kutils/issues/38
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 2 ++
 drivers/hwmon/dell-smm-hwmon.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index 977263cb57a8..74905675d71f 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -360,6 +360,8 @@ Firmware Bug                                          =
  Affected Machines
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Reading of fan states return spurious errors.           Precision 490

+                                                        OptiPlex 7060
+
 Reading of fan types causes erratic fan behaviour.      Studio XPS 8000

                                                         Studio XPS 8100
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 48a81c64f00d..c75bfe93f2f6 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1263,6 +1263,13 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
 		},
 	},
+	{
+		.ident =3D "Dell OptiPlex 7060",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7060"),
+		},
+	},
 	{
 		.ident =3D "Dell Precision",
 		.matches =3D {
=2D-
2.39.2


