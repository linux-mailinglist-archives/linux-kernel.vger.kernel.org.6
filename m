Return-Path: <linux-kernel+bounces-423942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D89DAE91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C41635F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB4E202F84;
	Wed, 27 Nov 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="TcVPEBqB"
Received: from sonic306-20.consmr.mail.sg3.yahoo.com (sonic306-20.consmr.mail.sg3.yahoo.com [106.10.241.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC016132F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739861; cv=none; b=MjUpUh11kgO7jiVNwfISMgbw4vEu8zFxfdfRCyAAusTQHIPpfBxvj0KQNu2DPn1CVlCjE6j2bxbecneHaHAaWjFeONTV71n6czrubyNGHViEvW4BKU+z8igN2Ici7PbvK6NSZpOiGTHumV/WyF3yIS5KH2u46Wsdd8SJogTGYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739861; c=relaxed/simple;
	bh=Twt+8FSwEojtmAUbs7V2KFAOzMAiYoD5583ceu3+44Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=mribLooHvcStB5yaP4Ms6vzLMigz8iDGjdgnfTO2drrsnzh8SZMKS3su2ngLO6la+7r+kOi/Y+oWwBNFJYQC0ryW6lxTmThtzB9P9IwJil534WlHQe7CYOOiawSXoTnR5vSEP+LTFv490od5VQvHKLReBQWaZ5RMMoWo7XLH8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=TcVPEBqB; arc=none smtp.client-ip=106.10.241.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1732739851; bh=QUU85dFdanFA4VOOJOFCY8SruHmkcNElHn/fVM1W5rU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=TcVPEBqBmuKhllSWY4z+Z5fUQWi05QgBMGjTSAvU2++PN5C4P09b93r4e3QNUvUGCnWJOn8dOd/WamSEMZgzfZTvFketzoHuOnEXfkwEFYITsbIfAw/R8ETMzEjOaFVOalVbyCT4OwRQMEyiogB6xnrHBfL3Ruo5r/jmhSDBhvRxLqM1TsypoIxOoYiTSB0pz0Gk9Y4irlk5I1MKQLkTZuWQ7pVE7lJ0osGtpfr+ocnv3FDoTWtYkIoJh6l7pkZO2thqZ12Tkt04ZnOvkTlkJCBWZZYdFNS7D6pE0GurzonaiUh+Q/qNapyWcVrZl1AVYffZasjWkkdaME7sMRrP/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732739851; bh=prZOsRvdLlg9Fe3uJCZNuOISdfXd7jzFs1DltojiG7y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Kh5JXCu2OlEEpAzxZ+hi4VSzLkVVFRj+TjddhkQYTyP5zwT5w9GqF4QCoB8E9A+3oCvVSqVlpEJOS/ne4uSPTsFdb4Vi6wrkxLWbZX//JVUfb60YlI9+qUi3UmPDdmt0HJEey9J0l0gYG0+SJjUokZeaELj1cz+ScBuKqs1mQu+gVWRV9m8GYpxVO4OK3jam4MKpFWW69DGkjcnXEAzUR9K++niuevkH1Uwgh45739XIBtvlatWbbHbWMGcodmVJ/kP8QXeMaOdl8Eav4B9pMyy8mKDAz2GLohx2YcnUV0ov8I7BlJwTrxLxhrWa0sJVitTdaUgfPtjrjzPwbiNUzA==
X-YMail-OSG: QnT3TjoVM1kpUZZa2jwgbO0FpB6ko_9KTYoVTz1Tst4JeR1sNuTYWChsxU0nwRk
 d1Gvnbt3Cn24tD37mCcVDzbZ8LTzBr7ab4xEuYRTzKm8C_yKiZqpBb_ts9ePOAhFiMXjm790xazr
 CAu9bc4lU8YIogboyEN2YvGN0yY_3ZYsYQ2q4slvfqzNo2gvI_glJADmOvzDMgqKjvCUbJhTokTk
 i3Y0sT_08JEuC8m3K._RlFTMyD8D6KOZHidv75EGFKEx6i4hE_jYNxLTINQuPx5tTDKKyFsQJdTP
 qEbddI9iks_akYsB.O8XLBW0jgrZcayCy264intTEcCPbICDDIidhnrzlbiO5p1MzZy1wbmbgcoA
 CL6DU6CI8gJnnX4rZNJm217Rsr3L0IQfKrY.yZhKrmZ_M8aVRxn8nXT506stlWWFh0Q2tvuh1lSm
 FDer3T53fSR4b17Z83NM9oh_zmDEQbMm9mfGuYauIwNx4BBNFq8msoqyLrCJV6nhyNs4TCcpnXc7
 xn.U79uQiZ5Eo2X9bNF0W3jhhpuFjfCHzEDz5uULckfFjV15fgY6AfQDgMPr.oOjw4CoWHxPkn64
 aQM_R1J8OAZVgEq25NH76KuekJnw6OOLaegGc1cpODA_JegLZ_vYmbKn5Rm0d17gKgmg8VRMXCCA
 AZu9BYf0qB9jto15eNO_jtxVWJrZwNvRksLaEiseEBjTnYa4o425UqZtFKRfhNYW5NvNqKmNneN3
 D.wVNlQksrnTWpAIQkCg2Kq8aZnZBYiEyTz97HeAwNu3gSXBeB3yynIy0mjLWci_yYefcVl8nzu8
 tplkwA5unRAne.pSoF1Qdx1fPDJNp56xYikte0jmiTqb4tOT9fWeHwAvENpvUC.dZ_1rKSLnVqiG
 uo8I4G1FCT678RPe14xmVfoSM6q8KWU75ScgkjSmdD8t1NuPwfQocXWNSDVEu1IWotGr_W1UsftI
 1mGMJ2lZZKhtAghthXH0Oj7cFbkrko0zgQ4w1fVQpm7X7PzYkhlLVxmrpowQ0X222P4e_SkHGQIS
 oh4uUsSieGTFoUJSENFdYPB4atXtsup2g4OZQZAvSiZbEx10YNEtA2P.u4Nx_8dKOWHEg6bcmEk0
 thoMCgtJkAflyZLKHHS8xpWXKLNP99Wup4QwabEVFo7ZbXPI8BZXBYjkyH9vsV3c9FQhrNYD47F9
 dqfx45eod6DyjnAOAMSIg3xqubDDgw0sCFGxPKQmMxJIzeGkh_T6UZG4A_qy8U1kUyjBkTAQKidT
 p68uga6rlN0bysd93r.cO9rvfKQTa2LFhizLGlmzRogEdUw_RDKZpWtQ.1rXOtIJYk01iiZ0HHQ4
 yso_2VDO19DyLWzVA.6.EApCj4sPUBxU_ZR_9Xrd85M8nvozhp0IngwykzjDMe.1QKU7IuUjvG8c
 zVo5keWbUrXc_8fhkx_L6SMC_EaqZ5JddK3YNuscLu.4mvD7QwkyKbC4.Xvy9lpo4Y.8X8y_s2l3
 I2CcX2AeRofNQ1tDm7TsQNGiVPDhHlaYUNfUQdPhpH1gUxZNG28I0gABYhgOCePhQsCF1bwG.kbW
 XTZK7Ao9HDg6F5BDQwBFSPyxPgW.uzK7cFm.09SG.nw6Ab9wMhJ8stur_Swik_GweZcgh8uGUfQd
 u3Y_AQo.f32KCzbU5uOVIghyQUKfXHBlWKwkI8KXUUZ3fVVIo6Kd1b3dpEDUg4Vx_OU__EFkKJ4S
 aRFBm85.fxsQrZy1ume1mllsEQPK7mpy2Kms.CZwe_bh9_pqPW9547yTkK_yhRzAfSH83L2p8Icv
 0EtMWwp7LmTPcm9GTrlhzbb8nZ5bh2GCOXumrryYWDWaplVRsjI.R.rgbXo3351JgWPZErW6iASd
 IVkh05orLOGL4dukpkG4YO6aZc1NdMRAlDJnP9Du60YnaobqLuaNhMLiqu.RMuBWeA7Oj8wKe5.Y
 EVrh0da6hWIACFqTF8a3ZeYGIe6.1vvfcFTT4LBkCuSrQZAm.VQehi0OBUZ1TvEUC6DOzzMBxZG5
 85oF.1Xow_.HmNQA6ePvWRbbkEEmJusoUP7iBPT.FO6YOZJSwV7qdpVs7vxTElAco2.mnPTPCyZP
 g0DsRnA9gT007_fGnB9fs11bMm1VIymcmR7JPpMDuj3ii7oszk.Dcsanx71saXOfu0SIDZwHPHGF
 rHpSdoVNoNYQkqXj4f7PB.74QpdZAX3tDIroAy.ZZ4_tvitAssFkRG10p3jPLnSAUT47dC2l.SG2
 BpJSm3uyOY7HK9tAbn5PG0uC5zvE1050VnqbupXt4da1zvw--
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 42b2dd56-13cd-4254-a90c-31d88ef963d1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Wed, 27 Nov 2024 20:37:31 +0000
Received: by hermes--production-sg3-5b7954b588-kwzfq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8c06cd126dae6fb3e2fb149bbc04486c;
          Wed, 27 Nov 2024 20:37:26 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Jonathan Woithe <jwoithe@just42.net>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Abdul Rahim <abdul.rahim@myyahoo.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fujitsu-laptop: replace strcpy -> strscpy
Date: Thu, 28 Nov 2024 02:07:07 +0530
Message-ID: <20241127203710.36425-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241127203710.36425-1-abdul.rahim.ref@myyahoo.com>

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors.[1]

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 drivers/platform/x86/fujitsu-laptop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index ae992ac1ab4a..a0eae24ca9e6 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -505,8 +505,8 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	fujitsu_bl = priv;
-	strcpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
+	strscpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
 	device->driver_data = priv;
 
 	pr_info("ACPI: %s [%s]\n",
@@ -891,8 +891,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	WARN_ONCE(fext, "More than one FUJ02E3 ACPI device was found.  Driver may not work as intended.");
 	fext = device;
 
-	strcpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
+	strscpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
 	device->driver_data = priv;
 
 	/* kfifo */
-- 
2.43.0


