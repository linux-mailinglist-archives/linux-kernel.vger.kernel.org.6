Return-Path: <linux-kernel+bounces-382478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA619B0ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC76281F52
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107221217F;
	Fri, 25 Oct 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DPP1/jM4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631620F3E7;
	Fri, 25 Oct 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883793; cv=none; b=fSfpq8te01WciFFRhlRzkzaX2gppY/SGdXuwpbLco8O9/zXhEaOGPfKULdIXQiAxtTTl0eZIE8hzaHskjn7wjJlXYE9dIlC7YTAfvN7tzroxmZ0CuSdcm/K8KcxF19CAhafWJfGjS3yue3kaGY5RFIWmJd7ApnJ8dx07jRDkqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883793; c=relaxed/simple;
	bh=2tHcE/ogxKyhf9iUDW6Y3SlaJW9yewZ2d46SHNhl2eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5evtMNDSeN3IAFW1DoCgfIBV5rP4V/FOxi7y3rd/UghpNEBJUP06W/1PD3AArpdXD1MPTb2t5/cz5HYWe2cAbDocKbOZ/8Fm0vHFEoCFLOX8Zf1nCoM7TCkvwnj4IEMRWR2f+4wq9eZDB7q3YtW6/5+a7+KkzeNCmthUikZd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DPP1/jM4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729883733; x=1730488533; i=w_armin@gmx.de;
	bh=3Gc66AMP1nr8dtCwfrDVjdXUEDfDZN98jHGNed6i2xE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DPP1/jM4kyGeGh1pkr4EdO3F2PIM4QtY5hdQ90ZyRTtQkahksOlHUozBGMFKmtLq
	 tpNOONtfJbYEhrOqFPzNmrBogIT15VDr6VJvbu+HEeSljnSAoDR4fwLBzLROD3/nL
	 dM+1Fih+kx0aRG8ofMTcZ76vqE+x8eg8+mDMLf+PICLrLMZ8s5sH2VUn2KHqwp0Nh
	 Kvgs6MUvIBLOznEu1uHUi9vNJknSCv31PZxX+XC9Px3EPguJ8+W3MDWm/gxw7VMG0
	 Oy2BfxyH52PDUt1Vu+iSrPISkaWLc/T5PvCEQD3ayHl8haMV9D7g//CYr4m6rLaOi
	 ggxtQMJ+iFcf/ku58g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N5VHM-1twcyF1kDa-011H16; Fri, 25 Oct 2024 21:15:33 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev,
	mohamed.ghanmi@supcom.tn
Cc: srinivas.pandruvada@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	Michael@phoronix.com,
	casey.g.bowman@intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: asus-wmi: Fix inconsistent use of thermal policies
Date: Fri, 25 Oct 2024 21:15:14 +0200
Message-Id: <20241025191514.15032-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025191514.15032-1-W_Armin@gmx.de>
References: <20241025191514.15032-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yR0EyrB1VNL/7Z5WOJ4u5V0vLe4T/ad+d+CCmeXBI6mvdzw2KFY
 ePIgTk84PBwNKZ1wwLS8kBAnMAl23zHcKR/apUQ90ToFVFJFyg7GCOmf6I5qek7wNdUVRw+
 yw7DeDzkHj4VzkYFKwoP4sqrM0Ff8juJ7CKHFKRBdTREgurHmk6RrFgNRrlKldQFkZJz/Qg
 4XNsfqlbwDtnwfaHOpnWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dRcupGxyLMY=;Xx4RYVSv3ykMLTiKeGFh6hZM93H
 x7tfiZY3aAv3ZRuGfiNH87KXcrDcQZlvOmAq5zVmPbgS0AlNULJb9VSw5tlq1nACG6crDNQUw
 NjLzcGPCyJf1coIBxsn8pj/OUc+zF1igNtVq80szC6of87o1WKZ841yqXXi+F/dO0gBpy/A4Q
 mOTxV3wDEhQCc+gpX+6FFsxON7wZpYCBobri5dZSHjjtbOf97+mRB+4zhw3vdTax8Qh9jQceM
 NlL3KkcCkcP9L9HglMVe5K9Jfz9zyilR/RxV//CvUg2pCuYfAtgjOTbdtqa8LgE+KfmkL8zxU
 4mma6LLuV4FA8WjJIAr5opK0D0iJ4bhD2FiF5eKCWXVwzMUf7eVgL7znXMQEFAI87kx+Oq2el
 3thitAVBEI1SMZ3ycqvk0hCUjD3LRBAHVlQOD2TP3/XpDanUXEnUglkYK/UvqmTuHiW9KJwM6
 kYkaoaJ8sXBdYDb0J2rEPZwwkXEC0bsnJU76vsHMjY0XgBirG9U6xt8Wz7PkdD0WJDnDu8TfG
 0QGliy9E1DtNm3LHU7OZPMvIzhrfxt4MAfbaYQTsfppFzwQbRVk5TpVcQfJu/GWWh2jm0CLNj
 H7fDycGvN5MvUxElQMo+CFKIOU/oA8PVoyz8mSi1mbDujn2usAQ59Pky6/1vXo1//Jet4Bfgp
 cWHRirsbYNG+/lDiBSVevQxMvhHBx4g2w5ywzApsMb/FcVvRNJdjDb5f0zG9/kWCn8kvQ2duf
 OOIV+C6qx++nHrCGqjZaI8n9O5mXBOtshFICGtCgSYQKupn0rQd+UNj4ZBhDmc3TVbaqCoNmZ
 IZ3wPRoNwxL6gO2MiQTZOVLg==

When changing the thermal policy using the platform profile API,
a Vivobook thermal policy is stored in throttle_thermal_policy_mode.

However everywhere else a normal thermal policy is stored inside this
variable, potentially confusing the platform profile.

Fix this by always storing normal thermal policy values inside
throttle_thermal_policy_mode and only do the conversion when writing
the thermal policy to hardware.

Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan=
 profiles")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index ab9342a01a48..ce60835d0303 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3696,10 +3696,28 @@ static int asus_wmi_custom_fan_curve_init(struct a=
sus_wmi *asus)
 /* Throttle thermal policy **********************************************=
******/
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	u8 value =3D asus->throttle_thermal_policy_mode;
 	u32 retval;
+	u8 value;
 	int err;

+	if (asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_DEVID_THROTTLE_THE=
RMAL_POLICY_VIVO) {
+		switch (asus->throttle_thermal_policy_mode) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			value =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			value =3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			value =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		value =3D asus->throttle_thermal_policy_mode;
+	}
+
 	err =3D asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);

@@ -3804,46 +3822,6 @@ static ssize_t throttle_thermal_policy_store(struct=
 device *dev,
 static DEVICE_ATTR_RW(throttle_thermal_policy);

 /* Platform profile *****************************************************=
******/
-static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int m=
ode)
-{
-	bool vivo;
-
-	vivo =3D asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_DEVID_THROTTL=
E_THERMAL_POLICY_VIVO;
-
-	if (vivo) {
-		switch (mode) {
-		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
-			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
-		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
-			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
-		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
-			return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
-		}
-	}
-
-	return mode;
-}
-
-static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus=
, int mode)
-{
-	bool vivo;
-
-	vivo =3D asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_DEVID_THROTTL=
E_THERMAL_POLICY_VIVO;
-
-	if (vivo) {
-		switch (mode) {
-		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
-			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
-		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
-			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
-		case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
-			return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
-		}
-	}
-
-	return mode;
-}
-
 static int asus_wmi_platform_profile_get(struct platform_profile_handler =
*pprof,
 					enum platform_profile_option *profile)
 {
@@ -3853,7 +3831,7 @@ static int asus_wmi_platform_profile_get(struct plat=
form_profile_handler *pprof,
 	asus =3D container_of(pprof, struct asus_wmi, platform_profile_handler);
 	tp =3D asus->throttle_thermal_policy_mode;

-	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
+	switch (tp) {
 	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
 		*profile =3D PLATFORM_PROFILE_BALANCED;
 		break;
@@ -3892,7 +3870,7 @@ static int asus_wmi_platform_profile_set(struct plat=
form_profile_handler *pprof,
 		return -EOPNOTSUPP;
 	}

-	asus->throttle_thermal_policy_mode =3D asus_wmi_platform_profile_to_vivo=
(asus, tp);
+	asus->throttle_thermal_policy_mode =3D tp;
 	return throttle_thermal_policy_write(asus);
 }

=2D-
2.39.5


