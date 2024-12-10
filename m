Return-Path: <linux-kernel+bounces-438612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE09EA384
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A6B188784A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583A42056;
	Tue, 10 Dec 2024 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Pof5zVH5"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F2208A7;
	Tue, 10 Dec 2024 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789838; cv=none; b=fpVrloovIoQj8/HVi/1qGZkzXoUNm8pPSNvp6GPWoRjJM/O+ihCHeTPM5RqNC+e+UbYA4sNll8AV9a1jyyRc4vuXoS1T3CZbRdYBPDTQhK7V1kjia+xCVSkhgIN9A8a1qTw9XA4OW4bwGeaBSZSstfst5o6gz+JFoB0EYXtFViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789838; c=relaxed/simple;
	bh=LR1g7gIxaoVx0dTzeqGsXrg7xhhuaGHVl2rTR06y5Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUsUiX5/IOC278Lhjjg9NM0Yye6BLnK1qiM/zn2NPZp2hCLF0aPTYg0OXC+EJBN7XK6h795IUW91NnHmXBovtKVbyjPrJo+RILa6SZd0KY3MBTrPLacMpCOp0gHm3oNzILqAlORPA8ACz389HEP4k+pevJsTWwAzbgCgjAaY1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Pof5zVH5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733789828; x=1734394628; i=w_armin@gmx.de;
	bh=9sHqBJzy5pd/TkZFigEltiiGQPEFM5EM5zZ5JqmZL9M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pof5zVH5RE1fEtjDaYCSM8slpt8UDXiLSe5e5jcqIiKID4OAIfCkRnYNC90AnVtX
	 Io1nWyYG3c+o8EHyp+n8MDiKV8yrDVy92n3xwHeeG/5R8WceZQ9UiG4g/NihT6W4H
	 dRtOodUc8vcO/0Ge6qjnMIqgG+kpD5gjE6sWt9g7TixVdQf6lr44Co79EO9icJ+47
	 AOj+Lqw+qbOTIIyTlK2j8oIG1lZjFkl2w6JKoYZudiM9j3E/LDE680zBv+v9cLyg1
	 2uqf7q1qqBR7d9Ko1CKxeOaIPZI+Q6UZPArXlxo9MYBXg3uf8vS3/EMzHSi78qpPf
	 9PErmEDVNsngh7cLKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYeMt-1t6u870U43-00WWof; Tue, 10 Dec 2024 01:17:08 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuurtb@gmail.com
Subject: [PATCH v4 3/5] platform/x86: acer-wmi: Improve error handling when reading gaming system information
Date: Tue, 10 Dec 2024 01:16:55 +0100
Message-Id: <20241210001657.3362-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:1mBd5hO5y1A45BeCH74sK3ta+g6b8CGloSWiUXcLe9zmenWCCFr
 cLq/TPA0JjXQ1Nl+E0hTxk7PFC+P/Tz8adOiV3JFOuO9dvkSr5bPEJeg+ISKDsJ+1usDEy/
 B7l4Wge7A9+bfxdPgyYQzyxw21T+sVnkXPQV74L5tOSfJFuOIi5EHtI0Vw/bO9MvQ3iCjsD
 RPmkJW0tc6/T3Hesg1GdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H1pY/+q2f7I=;h1xA4HPQAyXpghXWIbep1qi4tfT
 ixZT7wjVq8l1uHMRKNvbhnYgk1ziUVjOhGGAlfV07znVINs5gekHOA6dvIc7oBSyjlOxU5mej
 mSEeEOPOdZCFVVvJXsS+Ga9xgEnuBfjS3KYHe9a809yw1EMLc5k9Yh3x8uQxGdBka8rMVcA2z
 zc2DuD271xgGhogSFZWheqGCgumqehoANUAtjm8IbSfgUDZnkK5Gv2mjgqe98jfBWSTB9PJ4G
 x5pg95SugVc/ehdtbLEF4DBD8QZ7oeUYfsKIeRVa7Wg8KPd5tod3o0On+0cAosmSPJLnOwvaE
 m0VlOLVw2dssvt18VXBUc3yNBCTLocjTzHUYnCFKMVupAN5uWgEpLcRHyI2G2tAkyGHXt9fal
 450h2ToDSe/JIDR8nZC+3YHV7I8q9rl12wUQMvO8MG2NxWE16Bq60KVNyuWx5zEixnQ89VKjz
 5H0IQJdxV18dPQsgXqrjUpmujsBdDOmb01R5mG+kzjgClxcxS7+JqLoszWmwYUTNBCh+4BkyO
 kP99gGHfLX0c68ZZ7H1ASOF41BE33equaSbScwL+j/0S398GMSxvjx5BddW/tkaUpBD6TqgaZ
 Aac2PSzBwvA+MElqv67i+h6Oce2fTz1fSGb2AaWgYIMvzcGTZN/BunHLMNMFIgA6t3B5H0IlZ
 r1HtOtbCGB5OsV0iNCJgcHIqkBJzexueAdmmvLVIrJoIDSrox2xK/04+PfRRFdpIcylbCEVJT
 09kI3EIf3rTMZ8bIUF2jDoUJy23CbbDREZ92+36y1MdtwjDVFyKqerpDFYB7YcIpvLT5uziG/
 hXDqbBDCUIDYvn91XNeSoUN+cdw+moGkstvm/tsYIaRSOoJSIdzdwtdzg7EJ1qbHeEH4htjBs
 YHvxkeEl0IJzFporSaXtD09bm/v6Y/NUHnggR1727n1eCXwSTqFbOuimo3EGdc4eYpQ4uWITx
 N9jq3bzFJvbMFRaiC3dAYGdW+D08xk03Mcc//FAmobG64llRSMldVvIgM/pcaDokbS6JJS0NT
 ozWb6mRxQCXJSynE5O1oLeJeqHNZZH6fzcL+s2u3ZPE6TI4Dc9AQpRcFHlU9TDSPKfSCkoFrW
 jjr1fyfQe9jsE067kT1UQs7IFCu4A0

If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
8 bits will be non-zero. Introduce a helper function to check this and
use it when reading gaming system information.

Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 55 +++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index dd57787466b9..ac4500f33b8c 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -70,6 +70,7 @@ MODULE_LICENSE("GPL");

 #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54

+#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
 #define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)

 /*
@@ -1513,6 +1514,24 @@ static acpi_status WMID_gaming_get_u64(u64 *value, =
u32 cap)
 	return status;
 }

+static int WMID_gaming_get_sys_info(u32 command, u64 *out)
+{
+	acpi_status status;
+	u64 result;
+
+	status =3D WMI_gaming_execute_u64(ACER_WMID_GET_GAMING_SYS_INFO_METHODID=
, command, &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* The return status must be zero for the operation to have succeeded */
+	if (FIELD_GET(ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK, result))
+		return -EIO;
+
+	*out =3D result;
+
+	return 0;
+}
+
 static void WMID_gaming_set_fan_mode(u8 fan_mode)
 {
 	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
@@ -1762,22 +1781,23 @@ static int acer_gsensor_event(void)

 static int acer_get_fan_speed(int fan)
 {
-	if (quirks->predator_v4) {
-		acpi_status status;
-		u64 fanspeed;
+	u64 fanspeed;
+	u32 command;
+	int ret;

-		status =3D WMI_gaming_execute_u64(
-			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
-			fan =3D=3D 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
-				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
-			&fanspeed);
+	if (!quirks->predator_v4)
+		return -EOPNOTSUPP;

-		if (ACPI_FAILURE(status))
-			return -EIO;
+	if (fan =3D=3D 0)
+		command =3D ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
+	else
+		command =3D ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;

-		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
-	}
-	return -EOPNOTSUPP;
+	ret =3D WMID_gaming_get_sys_info(command, &fanspeed);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
 }

 /*
@@ -1942,12 +1962,9 @@ static int acer_thermal_profile_change(void)
 			return err;

 		/* Check power source */
-		status =3D WMI_gaming_execute_u64(
-			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
-			ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
-
-		if (ACPI_FAILURE(status))
-			return -EIO;
+		err =3D WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STAT=
US, &on_AC);
+		if (err < 0)
+			return err;

 		switch (current_tp) {
 		case ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO:
=2D-
2.39.5


