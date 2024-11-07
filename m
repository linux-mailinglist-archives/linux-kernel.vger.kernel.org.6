Return-Path: <linux-kernel+bounces-399082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F659BFAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FA3283E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB96FBF;
	Thu,  7 Nov 2024 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YXTohGg0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23083802;
	Thu,  7 Nov 2024 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939960; cv=none; b=SIYJPAPrmAmxgs5Pp55Kf9SJTH/q+lNgf/n8j/XQGVEPYtWt1cgNs34MiWj1vHfzarMQ+9zEClsryhuqsyJDot9hprkRs9w5+hurYPloZJDWYHRG7cRtfcDJ2JEE+s+LsT9g4n+SdCBsZj9G75NtP3cvC8tbo4Oi+GLTVkoDm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939960; c=relaxed/simple;
	bh=TT7HlVRFxw1GAd62T5Q4/Ve33tNll6qGnDMOCZPzNMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjoK6OxjIgik8nY3R2A5YpWhH9zc18LA/Q3lrmaKY27TyjtC5JDb7JC6XEp8H7VqI0Jkxs6b5vR2XBYrgDOAz9Zy76PEb+/ceXg6j19YAKWeeFAG9e83p5Lmb+MioYZAHaLERwrqfYncGj0BMjKQW0TrT1kmEBPmLhpGI8lTe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YXTohGg0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730939901; x=1731544701; i=w_armin@gmx.de;
	bh=LNOp/yeIPjPfCtSw3lO1DGc24JRvcgll0Xua2h+ZKOk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YXTohGg0eh9FSNXOY/6HXhon/7OsEcnZyZT66uPWYRdKqAB22y5EQF2n2IFaHnQM
	 z3ROhYLdG2bYnWo1w8J435xGJGDGwjHp63sBX7eZ8cemrWZPWD0/HavhyT87X+t0/
	 PCv+2z9tJ0EQUo4/gr2Jwwx/6mYWYwDeSiMuq7fIlL4FX9rV2BT3+l7We1Xj0mygP
	 mBkjwhY0qqsJ4LYm/cj7NO88Fe9IeVPccNw7IlUmifBsJNKc6NKGbKWnWVhG/9aeM
	 6BIREdzzhemJUV/HnzBrXTPow/mPIibGbAZgbtf+k+0aAf1f1wkX31tTbntL4+WBs
	 q8pPlmUyZPVHiHW3Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mz9Yv-1u55SQ2xvf-013Qy8; Thu, 07 Nov 2024 01:38:21 +0100
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
Subject: [PATCH v2 1/2] platform/x86: asus-wmi: Fix inconsistent use of thermal policies
Date: Thu,  7 Nov 2024 01:38:10 +0100
Message-Id: <20241107003811.615574-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107003811.615574-1-W_Armin@gmx.de>
References: <20241107003811.615574-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a0IKNqKRmere3yeM5Ftg85jMXrSaYMXOwodfQ3b/dgYv1oUUYsw
 BFccwAaDBpo7f8HAGNr+GuM0jpO9Z4Vme5SfC+lhdGwTjHhoanmAJfamJ9WgdTD+BDva8dq
 M1bUXUtdh8xrhx1oz4PyNssz9WqNsMofBLk/RRfhV+uOLINxlpcg61TCoTPrHdlseqQ3+0C
 gCeL952VdMcZTZFi5LuVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p3F9FySU/sA=;pCyc2Iq94lyk5YRuKydO2+hePGq
 wehf4LcACLjx9g4B+AxK5kui1f63aeDOv5NNRlWTHxT0yDYkjDsHVX4YpngjTVfsaqwNY+6Vz
 7D9UN+SRzQP89Y2PREOcEC/bj2ZRXTIFmhGhc51AfeZwt6ImSaoiVdvd4IVeYW4ke6EVGuooH
 OYwfo+Oo/QWIz0PY+YEKbrmnXJ/Pu9PlDFQvXJEiPleV1s41rOlz/UwioVGgBVhY0ltokdorj
 fDGFcla+OpJmjVt40Y6FYqao46VvItWHlpSgBHLnexmrp3kx6se1jlkX+RMP4s/SO8wTIkdra
 I4fAnprrvMZ41wIhlFUzJgZDN7aS3R/uGqvXJnVBiARPuUWGWtRObhVaUraiDDCENCa43Yp8K
 5ag2eWqqoasYroBQzozMvLkqcYrHYxouxfW6asAScgI8FXz8DgBj3/iJ8StDptVrgCsa7JUkO
 cnd4hZSx6wWCRFABDqxcV9mU5ry9iJt9tgU7KSSTHS3Vv8Y+9qNEGx9OrgTSc5A9G89mqmOKW
 qihbRkbT02k5DfwRpA7g43d7AFMqGSLWue08CDDuf4nyQuUx+HzcjVpM1MS/5KRn1m8q9lO2S
 vExVnyT3EEtLknt5FpY0UsjEfWSCXHB/EZ6exA4St+n3ZaRVU069tIKi452zi1dZktgPatByW
 hdLZICiaNo2DAxxQ//KZZCWZ/Fj9S/vQvtqTsMf6fEGTCmXNpcSHor8tUhXb3XaSdGUOhDKPk
 R2kPEXub7Vd2tfrOLoA1lwgIBPNTusayfb/gKN9dG5ZjTlb1MPQ48CIS1djJf9xoUdVSQAkH+
 UBQ9kXdfqhmoNxADbXs9gSaD8AT0EMefOjQy/HI//786yXuRu/dH2Tqcht4fkxIVmF287UVay
 uGDqUdC3/bHUGwfizzKQNcS1IQIF0XT/quZP4ndQZ+lAEjGwybsR5wWok

When changing the thermal policy using the platform profile API,
a Vivobook thermal policy is stored in throttle_thermal_policy_mode.

However everywhere else a normal thermal policy is stored inside this
variable, potentially confusing the platform profile.

Fix this by always storing normal thermal policy values inside
throttle_thermal_policy_mode and only do the conversion when writing
the thermal policy to hardware. This also fixes the order in which
throttle_thermal_policy_switch_next() steps through the thermal modes
on Vivobook machines.

Tested-by: Casey G Bowman <casey.g.bowman@intel.com>
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


