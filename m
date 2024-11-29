Return-Path: <linux-kernel+bounces-425915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B577B9DEC81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468F8B23012
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0A1A2643;
	Fri, 29 Nov 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rh5Y2Aet"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AC1A7265;
	Fri, 29 Nov 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908860; cv=none; b=uCI+jVI+hXh5b6y6rGF2ilZAwB/DaMJBEP2ybTicEKAtavckCQJnE7Ryw04F7wcSKYU5/O2Ei35iwzJhJ/2SER5+rquAPwxoo6lOqa7/Lmkh2WU+p3wbUJLxhArEPpHs6KcHwj/HSu5a0g6v9V/UwPJN+jhCcQCILvgWXHmtZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908860; c=relaxed/simple;
	bh=thiL7JmTLfsENiBP/KBz5mSFajlQALp5FP2zNwkO3Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQy0k9un4JQU/hKHN06jJUelOgF2v4WziQTkAbSt6QSKpQGa1k9b5A7U1wWfeah3yn8kDUOrGv/7HVjSQAWrzW8frtXhRrQzOTItzCaBFt0UHWn8bExakBr8V0LvfQ9NRxtBYlZbJbBaBBbG4ZGgZ54wm3I8/YOOz4lZ71R6Suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rh5Y2Aet; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908851; x=1733513651; i=w_armin@gmx.de;
	bh=fBN2K/XG1TLM9Y04maO4oJdMREklf0rnqTe45Gebmd4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rh5Y2AetpcTQCE4SScQ6XxySxYKn8euAwGICC3ZW1UWLspiVICOe3S/ihhcdltoO
	 gegluzlfc5AzmXMuThKISDAk88Z58Gyi9PJ9ltilOBo8JuW60i5SDocfyPs05qren
	 f4r+jNIquelhwOua/IcZIzmHw1ro4ixuX6vMCW9Yinjl5GoEBVNyVPRPnP+ZoQRjy
	 4WpYxH8RHt8wxpB3UvLyXt90p9yI8vXWMp1FDzz+0FfLwOoqbI6I6/RXip049LWdv
	 ZkoRENJB0Q5e/PdYLddAvNS09c88NVjH/TgNpbc7PHDkWEu7kvX2Zmb9I8C1mfNXJ
	 HYj348AeDSXYbeVaPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MQMuR-1t4Eb52O49-00RRzW; Fri, 29 Nov 2024 20:34:11 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] platform/x86: acer-wmi: Improve error handling when reading gaming system information
Date: Fri, 29 Nov 2024 20:33:57 +0100
Message-Id: <20241129193359.8392-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241129193359.8392-1-W_Armin@gmx.de>
References: <20241129193359.8392-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2vWT3UPwM0kOLQ7ERmaQ+ZznNn1ZJh9q8k2QkTqp6tsLi03yQI7
 BloU9QRyNyfms+4THZDTRm5PdbgdGBe3LbSFShx/Erui7Kxb0a+ZEB/kk3dVnfwBCEntTZf
 CIIbPezXt/CSx+1JzpDmYdm4idwSOBEmQ3p4rmgaeLmXX95Dq/H45RAKmX4CEsaViRkqUWo
 JQFoRHyei5e0DfJ301M/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UJAIDd1I5hc=;UrlrYwMIFYk7CQrStcgUTbv4fBR
 SdWLZR8D/dIoV40I3zeyQ4MuEkxqEjHGGozFwqbdq8zCiOmwS5+M5TwCEzqiUkSO4eVlzqB6r
 taFuwJ3hmQU2ASPCgwp1Z8RoAp7XjgLuFrN+gnWjqBer+tk4cep6/r6g3JkviHD5rPDLWirYS
 hXAow5ALYeMQmq/OL5sBdmL3uNetwZCENITN0ICC9Y2x6EGIYiqE++ZClmjDCsBNneRcLXIsu
 fZ4SH2sZE1HVgN62cvDAg0fRke1kJwZjLl7But9Pplt8JCz08gtdXCF6rHZAI5h17w7DUNUGX
 Xl3RR34dcPuwYoK9XAM/1niA3zCPVa11u2b049Xw4bhAUBi/xBir7gzfQqo2w/xq8S62wWe01
 lNc+V8q43tEJp0bRbUEsbhRJmCyrtDg+g9U5Jv8B1Fo1ZOx1uxu3JGjZEB/z9DlZHSuOdEpL3
 QRDORreru1sSobHKAPQ1z3GHmOL7y+/X6kXbNzANaAmHzi0fdxeLQz7vUYuOGq6bJKK6vZVYd
 Fm3GtA6q/+dQJ6MUoTz6N0/Q9xlW4K65MwfGmDmSnk4Q7zLbeqdHkAaMy7//9BRUIVstztmAX
 kssxTJ1CD8lIpg/HyMpSSct4UN/eL+lko/GZl9suHHb0H9ySVNK9RpId/mSNKOTtCwgnSd4vV
 NbHjfKYcDZkOOsCcM6u84JDZhfDF6yVYMyWY76QJnOgtIxETOgpu9QujBYgMBP0KLF0Pv7wiF
 rqWdk5dXY2sSqwXGLrwMkVheqwVXiJ6pyq7mnD0cgQoVOJD1h8+nJ2SCdjr7rbbitDeex0wtf
 GCTNIa99K1vCOp1Dydk7E8Yvr5EO2LVno2056m4EOGHRdRd8JhWJqRduyOnLrylWYxiLtYgPk
 zqOQsvVVwv+QkiLriDZLh0xNKHo9skLOMcls8kj/FfXUI3JgwCdiwcAH0s5phBYzvFO5sMpwT
 XPD30uhp8vHgxZJPv7Liy3nxMxSRZmE9que8cdGE2hzIHPAJa84iYWKHN+2uXhqV5x5QWjT93
 g//IRoJCf1FM3XloyMkXFA3fAhUEqeP9ys32Y66Zbl9XtM/0SFW+WJBG3AjeOztTAmNc7iKvy
 o66nyyZz3WNHb9bcjLQ6wmnlbyMI8C

If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
8 bits will be non-zero. Introduce a helper function to check this and
use it when reading gaming system information.

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


