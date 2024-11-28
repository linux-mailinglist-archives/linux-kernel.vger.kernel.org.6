Return-Path: <linux-kernel+bounces-424823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873B9DB9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB4628162C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFD1BBBD3;
	Thu, 28 Nov 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="W/twMklP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC71B6D0A;
	Thu, 28 Nov 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805491; cv=none; b=lkXDvQCIgLs9ygNZplSOwLekJrEBRlZA3j592ba5y2WwEkl+VxnPwcSx4w3dLrg3UkFNwQrkL16r9ayWeFO+SNqtDvI5ThgQTcAmNAs8WK70xPovVlPYmA0BS4gf5+zE4yGAEm6oLtEtni+L4JGPg26T2fUAsACNenUnW6Dgehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805491; c=relaxed/simple;
	bh=4yOdeZ6/wzBKklmkjBXqdD7C82LJbavp7/vhxJqYYSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1ktdViCtRuhBa48PWDbXP59N4kC1Z0VUxxb299Um5A/8yz4o6WJqMbeHtIvzr0SR1LvNAvqIeOdh8mtTQ5Nj7nQtOEfhz6QVmplawZzN+IL7V01ik9n6mWzaM8ihgYwovZS0QKPB+tDpEHTxuzqkpLnAXpVOeqsDjPGdXfcsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=W/twMklP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732805480; x=1733410280; i=w_armin@gmx.de;
	bh=+qpjumcm0obWOM8nAsXUgn5JYFFO1BSRr65px7Uw1ME=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W/twMklP6qs8caMcS9GVa9PrZy/er5k6a4rzfuWVsSwcg3HWCgRTMu3gxcFwLUvO
	 FL7klT4AuaPHt4dWMgpiWEZS3Ccq9AY4Mx1pW/wrMPLGiJS2yxeJnZbtrNjdo3qsN
	 Urg+kDJNk85LEGxWhAM99p6Q9swukDEHfTXU/2kuR2jmnSHPHRfyLwJXgJeojszhM
	 9C3bczdWQ2txS8BAviCjiF+AaAAE0/+FaiFW813uAwX0dGelDQT3HFPZU8R5BpWcz
	 da6SIY9tqDpHA9RVUi1ekFQf6dFCqx6dnvEh/Ddolxy/LEG3FWkeopW+JGEj3XMdS
	 C/s4MgU0SSX4b8HS6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.179.133]) by
 mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Ml6qC-1txTvA34qS-00kdWB; Thu, 28 Nov 2024 15:51:20 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] platform/x86: acer-wmi: Improve error handling when reading gaming system information
Date: Thu, 28 Nov 2024 15:51:02 +0100
Message-Id: <20241128145104.13538-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:W06au7PbS+bRuiXFOm1vZthqp+ga97B2Fhg7QGhQOR3KTz8p59u
 V0L7tGYR/gJleEnpsX9z63GrXX+6IpC452PYI8Yuu+watlkZL32thVeQ94cxNNWIHqxix6Y
 3OjxGydFrzgIvHSgtVX0tGZsg8Y2q50OvRIf+4AbVCEE7EadpujHZhV5kHL2w+CZNAk9N5P
 YGntSh1o2tlzilvH5Uufw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bSt8VMM2dKI=;JwnTo0/mKJj6//QkZSq0PK1LGZF
 FSRgNs91Pq7gS06MXT9554ltYRK7+gCzobUl554k347GyVBFi3K6vdXe5kyj3XQoh8RoMZ9S0
 FZ0VvoLllmrrHlHsL+90ynrHfyPXQm7nGmsxY+LNzvi7eFUhnBWWDlqr9GI+og4tYtyafRVn5
 XzV3OPI1AWJRUDXdOI3uOGFySIdLtoHXFIkaIYQs0Fxcu6tXU2Z9eU6Dq/gX7Z2jrADE+R2z9
 w1PGUbaCi3GMWlGfH8tn2DR0gsLza1hYDtOcTHt8lBijzsdY6HCdToQLFkjfY13wO3v3nMkXl
 rA89n3EB348SeASPiX16NRnxvQhgN82XKADJ1gjtLuPxWdVvvCUh18czNtTqxFk80i1/IBlUQ
 pGNj4nl9hPCDPbF3XGY8wTZfDF8iLbG5yN+rJrUOX1GufD+0A+Rrjuv1dFgRh7pLuTTEjqELV
 mX+DAY1MqXBw7aYR83nMcQW/N7PfJviEcP9PhE5QWgpRwBlawKj/taGo5jhKUxkobb0G9H6g+
 kXyo4BGZvcEsDaLNFHNZzq4fR/yeU8ioZ/23nqc9wugG3BcztHa9gAbsq9mnhtIPhy+qeqI+E
 /D2/RdzDBpZyO6/aSqRPCx/BSlZYLgyx06967E6S/zaAKiM4DMaN+lxQLvd6y6UZaOTk+7yDO
 +THxGKYyGzodljvZB0lHHAtW06eW1fD5Jp33HhZKMaYZs4sPbRYbthQSmONerBtmkcGZz/pQ0
 X/NCFSanqfisms0c+rDBZ6J8SmULUg+7lhtcrqxqdVpw4Ov5J/ByAoiQjyyAoYXAzxpuuEc6R
 NN1/fYq95hK7E+WgM48aePADMVVDGb1cg1CnTWvEdEuiOUP9FA11JHTTiDRmLn2dPjqrm5a2j
 Vpgz0nvMPvFB2EKYjf8s2GatlJda7qeBH3zSNnGQgm+TnrVBGo2x3omo8iBZzAyCWcp+4qb7Q
 V+1fb7wOXKx9wrAcKyZBQkGiN+VntPqiPZuYeJyDXohgIjNwhsX9ea+XWTeENw0YVboDNiOeI
 UM5K6znPBPsKj4/GsZjXQAdEwnwiaU8Awyt13pVL0d45GgEMhJi98Jom63pPVR8QQSk51T6cR
 SfSSKl0Y+uNlvCxkAcGJNp3hOErJGI

If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
8 bits will be non-zero. Introduce a helper function to check this and
use it when reading gaming system information.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 55 +++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index dd57787466b9..fcea017f0796 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -70,6 +70,7 @@ MODULE_LICENSE("GPL");

 #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54

+#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK(8, 0)
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
+	ret =3D WMID_gaming_get_sys_info(command, &fan_speed);
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


