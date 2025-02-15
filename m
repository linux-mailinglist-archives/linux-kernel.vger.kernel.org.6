Return-Path: <linux-kernel+bounces-516345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A87A36FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B9817078D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B21E5B77;
	Sat, 15 Feb 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EqMjC3/N"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05813AD1C;
	Sat, 15 Feb 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641559; cv=none; b=m5KWCXiKM+cddf+vSK2ttAiDBM4reNBI1Tt4Vts2H4V2J7P8DakgBwSMXY1MY9JmQvOk/JYrABpwzc/p95G+vPeUt6f2JtYtWrHdq+JwvQi4w+4QO4Jq4JGJjmLghR+LxdygY4g+/usMYCrGIqzkuXx/LrZqma6X995vJZm/gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641559; c=relaxed/simple;
	bh=CnT4mfg1yO3umJ6k1peml/rMTgotc0aA9KDODzIxBJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+Ia1Gv7r91Z6e81hoynHD049HeXQti6PchNhsPrdyhCOUUbzsYMPl4uzr3se0uQeGaelEvCGhg+8Opon4NaMfzHnYDynm4Oj6oBrKpPmIfSGpvpE1zNnOrQ7pDgzQSrReglpmcrffyvMbZf7nX0zHrLrYpyix6jP/xRuUEJ1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EqMjC3/N; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641552; x=1740246352; i=w_armin@gmx.de;
	bh=6zqT8VKyc97Y8Lc+lE4Qm/S1/XWuJaIAJl7c2jgNYlw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EqMjC3/NjY7UcT9ec6Sek1DfTvEbMI8JC07a7nhaXm5fEDor5/4yZ+Ul0HqM99Jo
	 +jQV1J/WZRmdhuBkI/Fua33Sz6pCeCuL/1FjbGSdaXR4wbnSQfE2YaLz+0AlTJUJF
	 2JPJ+pdhIDxHg1ohR/CC2UnaUC0sHP/evTumPqSGI8OOeNeA7KUYS0IexfWidu+/U
	 9bW8Kq8z68q7sudRvlgoduDGtT/BowTp4fKnWCjIrTHeqM2m4rwL2jZOFX9jeAU2X
	 xAgCcFTt4ieu85tZeQZ/98mUxNemgO4Nie9oUak3IF9KzCgZTEGtnzxzcv/gDODiv
	 ffyKU0+MbRaCdCuwcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mzyyk-1tOmqU1hkE-011NKn; Sat, 15 Feb 2025 18:45:52 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] platform/x86: acer-wmi: Fix setting of fan behavior
Date: Sat, 15 Feb 2025 18:45:42 +0100
Message-Id: <20250215174544.8790-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250215174544.8790-1-W_Armin@gmx.de>
References: <20250215174544.8790-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ykQpIFL70NphPtODBm6xiEFgSuyWLfSBtMChkDvUMDLWDv6v1eL
 jHuHT8WooVzyojbHEF6dbxmovzL1huO+zXBUKBqv9vwrHBj5XWk0zkTzhZB5SZztUA6pUUy
 pZH8s3YKqpHlE+cI3Ge/lqk/sMJj1Lhv92dZ/g30yC22uOKg0EAaRVeyJLS/51A/GIRMM12
 oezU8mzIq2G4gtIuerXMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X+7VWmHZ7KI=;8iVEwb2WuEGvTcNrRZo6HFMsPgP
 SMRZfFFfAK69c5BNewtTsZ0uv5QaQo4qB78sE302rUZAK9bQB8iYQjFSuYDteNKNB2TRwIogY
 WU9FNJYVIRyEKpOdMuYGcsgT9ekofijbPxGIknZp5uH/7MLDIv8K3zjIBNg7QCdAYG+I49LDF
 9gbRo3yY9jVUjXEipoPIIuPGA8kR8xrs6dTrKQ8JeGqNVNK6Keip3zr/4SF8bBQ/6tzhdO6Xr
 4wMpXlUdD2KIWHWoRujOaYQoxAe2ZQAl/3BwlAbKXHYMwDSX0xnbRXv5JXlF2bKsIEPd00ykn
 UtL/sSlB2GRecjIyas3UCf8LexKs5WRUDz8eRCTg1+8KrM+rkDXNi6Lp1ni26bfUqOpzaCym6
 OfE+M4MJJh/xduyGB9ySEjsmWd9fElQbpgngRaMXjs+PqCirT4N6C71lBMHRDHiXypyp6B1xP
 XywxaYx8LYJ3+YfR31lCo9hqnqr0bN/9vvZeRms8/8JG/ymf1fLAGQmjcj2Vrsk7svnWowSfp
 B+sfftdA9Cy/+0LIATld174qTUPDptpRhMLXAKDjel/ZhkdQMgWzs0FRuSqS3qoDmAvgs742q
 bkOBliF0cDIlvF/sLxdArH4QF3KwINyYDEMLk3+l5PYhoiTLXYGZyz0nW6ZspGTOOHEdJ5b4g
 3QOkTX+F0fCxV3pOvbev/ClrJe8vffFfjbGak4ffAq/nroO5hOlQS6GhPUZBLzuKTnTskrT6y
 Jr8bYPc+wAFL74XrPeDhDgtmcIxXo9yXIwFBUi5a05yMiAF3ykalkXLw8VMYeT3p2S7ATS/G5
 kHBTG/dsQXGSj/99hs7kwtEkjNnafKqjQ5NUxgwcO5q0wrH3/wF0fnIcYlZXuH4RymH09q7Tj
 efr1PR4ijzCFCTRkYe4JPNLp2gePfnrXa+78ObQSzc5BYtSrOvYU73Il5hD0oiO1PxoFkSmt9
 6pXB7UF2HdttoEzeDPV+uKTyWWayX3qB0PQXHC99qXwjptqfGHE4ur0XKcJjEz77k/+VGlAaD
 eBnMnyc2CY8dY+6gcMI40hQljIA3GlskNTY/M3536/Eypvra/YP6/QEDLwS0u69aoaoC2aByX
 JqPkRx2Y0YlWqhM6KWyD60+3qTGnsQOh2+mOLEOnvrxqsxV0dpF4rvw/IS72N6tR1ipLzKvLU
 qBhFp14Rx190LQlV6JBtHpM6yPURaqhsOJHelxGyZyuGdM4srDP53Dd+cxdVzD/PUcvMmnJXv
 ZgC5vPfxu7UGye/dFLBasU73fHeZ5Kl0ArJTpwnUDZHSBD5ndjeietDB7xxXlsXDDkN/UfQ0G
 /jOHKCNfle//wQCVOuCXSkNt3+r82o+WyStgPLRD6CnWERLi3L1IGwEKo2L1Qze40UkXvlAwt
 UQ/BRIUR+YwCBPf1kUlP8OhV2ih+962GNvPpuTsCfde1NWf+CL/EwZP6R2szOYCB9x+L5NwHG
 WgzJTQOxK9PGxuKObQkvCFGgu86lLYwsOedXfNWcDa1iSNMOS

After studying the linuwu_sense driver
(https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
the meaning of the SetGamingFanBehavior() WMI method:

- the first 16-bit are a bitmap of all fans affected by a fan behavior
  change request.

- the next 8 bits contain four fan mode fields (2-bit), each being
  associated with a bit inside the fan bitmap.

There are three fan modes: auto, turbo and custom.

Use this newfound knowledge to fix the turbo fan handling by setting
the correct bits before calling SetGamingFanBehavior(). Also check
the result of the WMI method call and return an error should the ACPI
firmware signal failure.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 75 +++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 69336bd778ee..f20a882e3650 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_SET_GAMING_LED_METHODID 2
 #define ACER_WMID_GET_GAMING_LED_METHODID 4
 #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
-#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
+#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
 #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
 #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23

+#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
+#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
+
+#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
+#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
+
+#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
+#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
+
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
@@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
 	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
 };

+enum acer_wmi_gaming_fan_mode {
+	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
+	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
+	ACER_WMID_FAN_MODE_CUSTOM	=3D 0x03,
+};
+
 enum acer_wmi_predator_v4_oc {
 	ACER_WMID_OC_NORMAL			=3D 0x0000,
 	ACER_WMID_OC_TURBO			=3D 0x0002,
@@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u3=
2 cap)
 	case ACER_CAP_TURBO_LED:
 		method_id =3D ACER_WMID_SET_GAMING_LED_METHODID;
 		break;
-	case ACER_CAP_TURBO_FAN:
-		method_id =3D ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
-		break;
 	default:
 		return AE_BAD_PARAMETER;
 	}
@@ -1618,25 +1630,42 @@ static int WMID_gaming_get_sys_info(u32 command, u=
64 *out)
 	return 0;
 }

+static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
+{
+	acpi_status status;
+	u64 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitma=
p);
+
+	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METH=
ODID, input,
+					&result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* TODO: Proper error handling */
+	pr_notice("Fan behavior return status: %llu\n", result);
+
+	return 0;
+}
+
 static void WMID_gaming_set_fan_mode(u8 fan_mode)
 {
-	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
-	u64 gpu_fan_config1 =3D 0, gpu_fan_config2 =3D 0;
-	int i;
-
-	if (quirks->cpu_fans > 0)
-		gpu_fan_config2 |=3D 1;
-	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
-		gpu_fan_config2 |=3D 1 << (i + 1);
-	for (i =3D 0; i < quirks->gpu_fans; ++i)
-		gpu_fan_config2 |=3D 1 << (i + 3);
-	if (quirks->cpu_fans > 0)
-		gpu_fan_config1 |=3D fan_mode;
-	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
-		gpu_fan_config1 |=3D fan_mode << (2 * i + 2);
-	for (i =3D 0; i < quirks->gpu_fans; ++i)
-		gpu_fan_config1 |=3D fan_mode << (2 * i + 6);
-	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TU=
RBO_FAN);
+	u16 mode_bitmap =3D 0;
+	u16 fan_bitmap =3D 0;
+
+	if (quirks->cpu_fans > 0) {
+		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_CPU;
+		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK, fan=
_mode);
+	}
+
+	if (quirks->gpu_fans > 0) {
+		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_GPU;
+		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK, fan=
_mode);
+	}
+
+	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
 }

 static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting=
 setting, u8 value)
@@ -1923,7 +1952,7 @@ static int acer_toggle_turbo(void)
 		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);

 		/* Set FAN mode to auto */
-		WMID_gaming_set_fan_mode(0x1);
+		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_AUTO);

 		/* Set OC to normal */
 		if (has_cap(ACER_CAP_TURBO_OC)) {
@@ -1937,7 +1966,7 @@ static int acer_toggle_turbo(void)
 		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);

 		/* Set FAN mode to turbo */
-		WMID_gaming_set_fan_mode(0x2);
+		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_TURBO);

 		/* Set OC to turbo mode */
 		if (has_cap(ACER_CAP_TURBO_OC)) {
=2D-
2.39.5


