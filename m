Return-Path: <linux-kernel+bounces-438611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E599EA381
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4941887C71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFD679C0;
	Tue, 10 Dec 2024 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KsO25G4G"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C23635;
	Tue, 10 Dec 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789833; cv=none; b=gpaAVo+PCtpv7Y1f8Xkj6iwkxEERF+hlhBTEJplLPl886ynDMxbNRGIc9/OaaVuDKAbPTC+iwtJjHNPJnJkU7NfWil+ULBz5zh4nn8f0PqPjD35wT/DhXLAnMiDD6eT/jg2x/KoM1OrmDp7dzMcFe8Vj9fDGQ2aXCdKCEsFlxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789833; c=relaxed/simple;
	bh=w8PL8xxnxxYhfjStXYwd8Cyyx6b7jZdtJLncxdh1dsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0MmVCPWkOfjl5sXYhvYztBUcY6kiQkv566kUt1ruqGGcOZ+k5iuMIROC3MhA0XrqtYO7hLU8dddNW0Tt8EhYCMCQEIYyp5VWj25Zx36VZf4x6btOmBab6LjZSZdJ3liF0GxdZqOC6xyRIcHW+w5QP9kpsw9X3wpSmAl131wRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KsO25G4G; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733789824; x=1734394624; i=w_armin@gmx.de;
	bh=gCOj+xJwVV00bzuAA7053ZW1ofwq96/t2R3OAQyBSAE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KsO25G4GZMYYARzSk5/uYGMvHgZLOKsAFsdGcKta4mPV2eo/zuI7atwKbRbjTu2q
	 X4P8X1CU8w56KYr+3Dcico8vd3kFIRtPk3Suv3jAkDRTux4sL+8MDBVuboQtHenlE
	 AawFa15IlB1Fd9FbinvOfP4ny8YbnSmgAIoou+Bg1T11RWvfLcKs9RKoT95ztVECp
	 JlDQ6BjmYcqBfbaY4Nkscn5cWigtgRuIoplwiR2tW6pFyKk7WqvDmmYCF3Xa5wjMe
	 9vyTvPfqeZ9FjARnfH8DaW0En/YbPhSqlz0PiCe+RJGq7G41FgndhNY5eY8ieId9h
	 eQRiXiAZq6Hs+qQcnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mnaof-1u1KTi28N3-00c1kL; Tue, 10 Dec 2024 01:17:03 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuurtb@gmail.com
Subject: [PATCH v4 1/5] platform/x86: acer-wmi: Add support for Acer PH14-51
Date: Tue, 10 Dec 2024 01:16:53 +0100
Message-Id: <20241210001657.3362-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210001657.3362-1-W_Armin@gmx.de>
References: <20241210001657.3362-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3knchs1Dc7BsInfSEmVfkqEtYOVgJxXVK+KcU0GitjD08neQyG4
 A1HL2K7tVxrr5oQV/OWGMC40FEpN60JfwI0Nqyp5oJ29rx+CDFXvNzcr7Y2bi9MSq2oqiQf
 wK5OImItfkdzhGpLBVNb1MAUce06zNvMUjdmZIaEEXfNPiP9BvaHagKnK6dBHZZLPUO8Drw
 Mxaozwpd99Uva6Awl5Y1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c6G4skQDPkw=;E11znX+t5noiEc4/uuFSs8TgqY5
 uUD2pBriQnCKxSEFlmOISqvxZcQMXd7SWtgM9qDmtxCba+tki9119ZJy8Zh6KSfFZ1R9g7kIO
 g6mZMOlnXXJC11I4kD5I7jhBM3Sj/7jogsahEJBV9hxQM8QKnVhE6f/ZozvvzhHw6rDtYzf+V
 4itjLv/r5q+FUuI9c0hQBnWG518iUsVOGkrq/R941JN8XDVC2iUNuOVzAagsOHhcQq2L+3D/0
 YWyXZTDEFUmVp/rLEZWvxRZw60S3lPQ4ENOgecZsb7ajPpxoTZdcDAP3P2n1n7OYA3hcv+dw+
 DX4ylmoC3To/tmaMxyHN62TwTRjIC7NmrR5/IR16UsslHfl0ARwPSdOPteGiV8amsiX9ak+nz
 aRV9TB6+vOWq/eNMc60juctZ3xMvBu9RrB+JJbx0Cw9IuuiM2Ob3uhdBYYNCRCYI2qypPYGtR
 IrP1CJFIx4Ema5oWsCqEm9LN3MhhIqOW2PInTP2uWK/LevvNjIQIqPUbtio9mbo4B1UTq9SGY
 6wlMQCl4ZQEp0Z5WhTntqwpli+peHLDgHuZaolPKCAn7lzOl550PMRPXWC49w464rDPvECbYk
 42d1jf4ddc2zyYo/MsSrvBly2IK94FH5pcuwUy6trQEah7Ij43nPjKhZ7ydTZIVW/5LuKgKU3
 A1FEC6/uFy+0rk4i8x8l1McDSOV5iFEKUJ6nGjV0K/V7wYAZcv9Eh9/F9Qt7DZJtsR+cIKA9m
 W8XVlHQPCMQHSzxHiIQwPV5KF2XGnUd0Wr3prxvvRxhOp8C7iDMDY8UyheVKu38BzoWVaXoyM
 K9sqJal5NVIBvF7ALbDh6N0XwLLfYLazKo/ZAjkeWsPglpmmseDJrLfGv/DUFpuxjHvKGn7Td
 o1WdnrYw3k63t2v6FIwiaR6QNBZm/ofPzu0kKBsWaXzruuEfpkDKNf3uOOjukm7Z9FFOMW7cv
 26BS7OQcCY74910ElA6EIWG4jRcPGIqfvprOj+RO2U6ZpoCkQQnIe0u5f66x4YerKLlv1u35Q
 HZnrNVN9I95Ejweht89heSzwDxsc3Jm67tzl5NvnN1Qz6gX7rSEi5wfV624VenGBlMDvJB2zp
 dDA1lUqV1wHuYC/d1iCvyqKVlYZuSu

Add the Acer Predator PT14-51 to acer_quirks to provide support
for the turbo button and predator_v4 hwmon interface.

Reported-by: Rayan Margham <rayanmargham4@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/CACzB=3D=3D6tUsCnr5mus=
VMz-EymjTUCJfNtKzhMFYqMRU_h=3DkydXA@mail.gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index d09baa3d3d90..5cff538ee67f 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -393,6 +393,13 @@ static struct quirk_entry quirk_acer_predator_ph315_5=
3 =3D {
 	.gpu_fans =3D 1,
 };

+static struct quirk_entry quirk_acer_predator_pt14_51 =3D {
+	.turbo =3D 1,
+	.cpu_fans =3D 1,
+	.gpu_fans =3D 1,
+	.predator_v4 =3D 1,
+};
+
 static struct quirk_entry quirk_acer_predator_v4 =3D {
 	.predator_v4 =3D 1,
 };
@@ -600,6 +607,15 @@ static const struct dmi_system_id acer_quirks[] __ini=
tconst =3D {
 		},
 		.driver_data =3D &quirk_acer_predator_v4,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "Acer Predator PT14-51",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PT14-51"),
+		},
+		.driver_data =3D &quirk_acer_predator_pt14_51,
+	},
 	{
 		.callback =3D set_force_caps,
 		.ident =3D "Acer Aspire Switch 10E SW3-016",
=2D-
2.39.5


