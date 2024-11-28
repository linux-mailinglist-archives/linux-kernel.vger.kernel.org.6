Return-Path: <linux-kernel+bounces-424822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E39DB9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C14A281349
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62921B85D4;
	Thu, 28 Nov 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hyyAdrMS"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64785C603;
	Thu, 28 Nov 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805489; cv=none; b=Dx1wx4pwMECA4npn+Kx12Laz1PMm6mXLn79r8HKBEYNVdyOVPbenOB9jJAJjTH+ROJqD1YYHF3ZwwJCMZjpY4ImrigjlEbuTJZkioiJj+egb3fZ1YAbOaGR91qhWz8r+vGuTLT40/LULoot3BQXanMzYz7E0caoFOjgfk4nFN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805489; c=relaxed/simple;
	bh=dz5zS6kB5edcWn2Vs0OGpGrGB8qow0mRIbMXAAwJx2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5VM6XMN3Ni+ruYCY9k/6aOsOwR0ussJ0a1E/JHEM8swxAFVJKry4l/jbYakkiAWB3iczs6dDr4vIfTd9Rr5Qo1fDO6DDkMSEAhXMr6lPY2F87FmhouiEDDd9hFlCzglmVRiLG8GoJfG15vebKt9QcbGMFlN2v2MR/PAjdmmMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hyyAdrMS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732805479; x=1733410279; i=w_armin@gmx.de;
	bh=UP050hPGANPERFI8S6uX7fXmxD8vqSI87oyADFw+R4g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hyyAdrMSVZGOlc+BKtn1RMPNKtkowh6QxY7vmCEUc/vHkWcEN4ZRxxd4oDR25TIh
	 Iu92M+HlqpL7pMVz2gV+tL+86wplTvuMsmV3vB3J//UfC8WfRK4NchRHd42/PYG2w
	 x2BsM+aoC3OttueSZq+mGghTas9iA5VlTYzO4YSL5C4jS94NBwIXL56ZSF9wC+4Um
	 fz6mlWYH/CpKavd0AWdy58ifhnmU+5eglSx2lILdQK/xIlPeajY63DkxJpHco82H5
	 wONqNJkwNmpyOZXXPs4tAjCnixzgv6NsjEoSQuIshRMKP3xiwIOfLKt43o+QNwNjO
	 B98osS8t03nJMjSX8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.179.133]) by
 mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M72oH-1tKpGS1Iit-00CXmR; Thu, 28 Nov 2024 15:51:19 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
Date: Thu, 28 Nov 2024 15:51:01 +0100
Message-Id: <20241128145104.13538-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128145104.13538-1-W_Armin@gmx.de>
References: <20241128145104.13538-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:js5JNUM+2F15uXqWEhk241vSMEczGV4uMI9NgEsvup2ZbRh0rQN
 +6EByMf4ud4E+3/Z78Jjpdu2d7nYGsS0b6zb+i2eqxvMoR1CyourS1TMKk1TXGyj/L8dLsq
 LyR2Nn8WXPsxYDL3Lhlmfd2U5aEcXfLY4s71M6y/IgkWO9UoVBBC3NCP2Ku58CuW4vQ3NbE
 AGq0vpaV/GUa7SttOMGqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4EEHqvNxkaM=;NXU6i1BAbdftIYgMNVMrDMySVXD
 VGf9dfgHay6WES7FlyrAdtEJxesTHs1PB0/vNvH1UyJfJOljswv0ONn2PWZW2tcrgpfPyUYgr
 tt6h8zJSpIGqKmY7sVwwi/FJTDl17Jo9CQIRmJf3xcWqYUX4c+2wP7P8kcigQ7LNGNE3+O3UK
 IIBjQUrD0aX/zhFipSE6GreahEr+G5ScCLri5ZYLBwOwkFX0M4Jyc7NuaM+N0L9JkBeG2viIY
 kW+nSlRb0+ZPmtSI4HOjFIKoGQBBfJfFY4xWoArYeG5CGw7uLx3EBMeAaTHasdu4KV+oURJo1
 R8zNLYEJqYxNU6tbE54trNZsYe7wbkbsGAGN/bmrDEabQ37Vh0Co+y3OwjElrIx4s3xIr7a6A
 ucLNL8xVn3PpVp/8HQCPVXa6uyFVrNl+s5VOlMe6e7RsuUO9c1SXj+4VqVLYCP1yslCyE0sCq
 bSuD5cMac5j2NZ47qL19dM0cnDOc8yv3h3qLf25/rLqCKuTTLFyH/H528VcDqyJ3hJYFlO3u0
 Ql9Acpw8zCj2+H+X9D+EcRZQvJVM5Kif2tzTaYyy6groxNbb0Prd23c0y46kJnFbP/an/w9Bv
 ef8iDUPXmOIMIsPugKDwrJudPmRjgMjcNHgwGjRQ1K0N5v8B0CRJ2j9R+Zxyolq0JyP/7Rp/0
 4sofDnHA1vm4U6laQq2NxuWyXs9oU9fpyH8z7MNlLUoW9w/Ouyk9wm2Hsxikt21qKTyEbthnY
 84qnsdFTmJxtJKoA05bg1MKI3pucfeJtQ+de4uCigghdq/r/+VbA1XbF+dmkeKztgdAIh/S21
 GPZGHDLjvROEtPEBbZO7XiSI6CmKDvO8FrJt2Qqd06IRlxKAwlE+UsNkmtM3nLDJYYj2nQT1H
 o3BRAbMy2gQxKiCbigDIKBLVLRflzLXDW3N5c11yyiF5kLNpAIjZyAtE7cDCbGRpIZJsTLFsf
 liQzrFN6VYEkxedecj1Se0bcH2Zr9+eNgNlPGYcA75zQ8ecVstyEmVY3P8LEeVc5AvUL+DH0e
 Y2TI2CtWnx3lGJoJUMmj9XqAC58/YQ7SpytC5L86NQac20mgagbjaM6ipES8PE6fTM42qjH5d
 fd0IMFMaiqPKYGRMl2Sdk02gytKgxn

Rename ACER_CAP_FAN_SPEED_READ to ACER_CAP_HWMON to prepare for
upcoming changes in the hwmon handling code.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 5cff538ee67f..dd57787466b9 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -246,7 +246,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_LED		BIT(8)
 #define ACER_CAP_TURBO_FAN		BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
-#define ACER_CAP_FAN_SPEED_READ		BIT(11)
+#define ACER_CAP_HWMON			BIT(11)

 /*
  * Interface type flags
@@ -358,7 +358,7 @@ static void __init set_quirks(void)

 	if (quirks->predator_v4)
 		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
-					 ACER_CAP_FAN_SPEED_READ;
+					 ACER_CAP_HWMON;
 }

 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -2551,7 +2551,7 @@ static int acer_platform_probe(struct platform_devic=
e *device)
 			goto error_platform_profile;
 	}

-	if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
+	if (has_cap(ACER_CAP_HWMON)) {
 		err =3D acer_wmi_hwmon_init();
 		if (err)
 			goto error_hwmon;
=2D-
2.39.5


