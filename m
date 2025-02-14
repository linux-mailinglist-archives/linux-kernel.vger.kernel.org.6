Return-Path: <linux-kernel+bounces-515722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A735A36827
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C61890C65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466491FC7D0;
	Fri, 14 Feb 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="a4Dzh5UZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946B1FBEAF;
	Fri, 14 Feb 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571219; cv=none; b=t2KAg1ikTB1EgaQTjoGw0kjXOxtxOUB2Gv+jbQz2TpM9kwasmDKgLsM0o8DexA8aqlMe/TtNVXwP+ElE+oqbvVwgDY8bdfEf3OfSP8x3suDXGtJ4+dcrPDVTTSxwdfX38RUH78FBo+VVPUC/W0iw0mXsMZJzCAgz/pJp34Dh57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571219; c=relaxed/simple;
	bh=CnT4mfg1yO3umJ6k1peml/rMTgotc0aA9KDODzIxBJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uK43C5/xfpNGebBgwHp7YPo+vSXwrBH3wTlfF6rif1aiZ4Pi2w3E4GRFxwB9yFWwVALq1T0fVvJZVnrpa+xYBlBrDzAobcotnZlJDCEF/HTpMELbmyBBHyisWz/wpG4mYVohiF9I1+wYd/UiqoLxcRLFhGvautRfKAJwz2Oq5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=a4Dzh5UZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739571212; x=1740176012; i=w_armin@gmx.de;
	bh=6zqT8VKyc97Y8Lc+lE4Qm/S1/XWuJaIAJl7c2jgNYlw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a4Dzh5UZ9thfeE5viEVeE8QqajE9H7f+dNW2LVxu9RBnVuHrDTHK4W8MTyVc1XDv
	 rA7+5RMUd98fnTN/TijXRndcWhDR1Zy978RiSZu7jlQAxQ/9Bo4PTSC3QA1ySofRA
	 V8of7/Hdfv+ib9E6Wm1RoWyVVzixiGckbbWhe0t4LPpfrYCHxwmJk/aKhJdAujiLx
	 aUjJRQJyP7DLx3AL16xZ9s5rHB8n/h2ZDfCNdG3H6C+q9M4KVxHY+0FjcXhf0r9Ln
	 NV4HUyajGlcvtyOBc1r1ytWrmXXgESi06UQeZjC21xw9pGZvLAL3AfDOmrBre6fcT
	 2zjS8LZrkF0rl9lheA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtwUw-1tNyHX46zE-00xqy3; Fri, 14 Feb 2025 23:13:32 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] platform/x86: acer-wmi: Fix setting of fan behavior
Date: Fri, 14 Feb 2025 23:13:20 +0100
Message-Id: <20250214221322.47298-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214221322.47298-1-W_Armin@gmx.de>
References: <20250214221322.47298-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pHXyTx4ScP30V6BKf1dDzLsvrL01B6kLICCR7B+xGyP680qto9v
 untNdkHPmHLfWJ5QPi9Pj6Vlm2uMNF7k0c9EJPJU3pljLxxtwPFvDMinK0mVTl4ZEKDLP1I
 YjUuf+nZp7jwexWhdhbVorqYxfUiUARuOgqWGCDmnmX/RQib2aL+oMpe0uQeEdNMGGXI1eE
 7qMXsveKffDNb53hAKskw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Yblas6MYDY=;K5tryEpg9b4QxWGJtdduyrP0IET
 Cdh1kn4ERUd9ishEf9a4JWNrEg67vubTXxK/Vy/5QfUigwccp8EmLXWnKkHJ2eT9WA/HNaLFh
 8SrrtTL7SKDRv+HJoVC1EV5zTaqTA1moJqX2Uh2b0xVcJYGRGH2QQS/DtQ5mofFhVr2mwsjW3
 EdpVUAnluTFQI3kBvDtuptb/qB1NtLYjnD8SpWgOyaVGxigDcK7IvENJ1OVA/VnO7viMJBeYw
 5gf09LN8kox8wREXi+X2QafoaAONngKB8i1Dla3/5NZJUMfv6r/w2hqqB6eRsAivHXyDGupcG
 GE07zdQozCWY5wTYzx1MxG4fsh8Wy1FdvppANlz52SC1WVP63yFf5ZlBQ7/rJeM6fQwsapNhh
 j1w0xQ8vvDxWzzdUsxoqfx+QkmuHecyAXUM0BMorjyodhavnb4320Nzrf6Pp1Rc/NADNHQNTg
 HK54KwdvG+lgzQcsmXnAQT3Yt9TwFMHvDTbH7g9A6uLl3hClnWnQtnvIFXCinfn+za1BiH1EV
 17Wagr5UJELbBIHBfjjqL6ygycmJluzvVzNgdw2yn+yA02M0uXZQ9tsmKkvnOI127Br+8RHls
 heJiuWeCQbU9uYU5d9Ts9gVVkno3J1gv04NZxHyvIx0YulEIh7MuZ9AXF3YS4hy3+NPguWlnV
 Bkk+lzWcgg16C1YCgwKcQPp8qv/fEqkZhbBtPkVr1hFgxuEyCgPAxpm9uaPXv4sfkU6nIKqSz
 EygaVeblp2XvuQmEQBSduZL+Vj9LEgZzAvbkUA4ckxfPjka93iQkUTxvc2dzg8dHFMmJSPKJ4
 lcgMgtUH0sTxVa3N1OxZanpQ6JEcl/k22B7nUaKJ2Ipy4t/rSZZmSKoefFxEaQoqrk3jO7eGA
 hu/k5RFAD0TtmvbZleINKyZkrRgykifgg3y1FQRKAwt9oyAZ6HB4WCooTU51elrFT7MJ0JNRd
 TX9IFgNpt0A/MJzPMSagDIyjqdt6w6UX6qliyyS+NdYKEBeFIIh+5MJQVrddJeh8QVKfDspPt
 xh+4ESGmEyZXlyxc4u1FdKczMd74eOfb2etiSUPsaxZTXCrt/vEEANWvPIN7x+wS70+ObODrM
 3053D0CNsb68aa5/P9C53qjDcDU5LYwZlkSun0GJb/PDa9uRQw7LIz+Zwjun3Mry/VKtRKmNi
 5KiIezc2Kd8mBgvSiaRgqgXFuytDX0PNAJCa0Nm+7pcK5m2zvEIEFYJtmtlZGjg25gLtWekT5
 2Tjrj2SUbi5BnDzYz3n0DDHDPC7uB7ixR6JZrp7N39t634Rud1ja+1X9Nf0kKvkuetvkmv+Lh
 0YOBaG6Nucuwk6G2ZFQq8vG5mJDOnqdjM8Vlrhw0+2H6/i2+5Kn8Z1AVUtFTNAummGuYYzdqr
 VOBLbhUAgfmAbl3oakJMzXdL2kAfv81jwwbVeZuF7Vi2W/BTdsQd09jEzXIzxMdzRpuvn/rL2
 XAsfSdNFCGf/TDExDClWXtUZgS8XXlTjmvpG6zIvxEUvDXg9e

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


