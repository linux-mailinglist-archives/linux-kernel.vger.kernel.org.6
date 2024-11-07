Return-Path: <linux-kernel+bounces-399083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCC9BFAD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFE81F226DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16ACC8C7;
	Thu,  7 Nov 2024 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EWYbKHQh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD044A21;
	Thu,  7 Nov 2024 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939962; cv=none; b=mTZfGYcpnmmUum/AqaBJA5cUu64lLZxIvjq0rVny8Q5NFy3vTNybUFcD9SSB/iw+f201R8H356ZeNqxYmzTLndkUiJOcxP4aE0jqWBja+/JjEzI2743cSg10XgKQuhAW89/WiqDraeklBj5SBVMqSC2ANvG1dx2+9qGESbc1aMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939962; c=relaxed/simple;
	bh=CiNGNmCtmcQqR4cHpsTtyoNSfQjxTODBNQfMf2zqCnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEmLcSRvq9XwnenplRXi8Ltu+04NywOra5iFOkIaqgI4p6vRN37U14W6YPHdZrbrFpBniyboZlWMU2INcAjiueOEUI2xztt/mhDSHZNAyjq3Rkj31EGzj7ODcs1TyeXmq5d6ad+FxdlUg/4GhCoZ8pBwmu4oCNxGBSFUehV2cg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EWYbKHQh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730939903; x=1731544703; i=w_armin@gmx.de;
	bh=4/K7RD8dkLVueUtuW32hIC1eLVwXkD29dLtXLraKleY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EWYbKHQhE9GW6l6LrkfZncQLFBV9lLxQs6H9bxVGV4Yx7CQOLElJpc1ezZ+qWijW
	 4leK3CydLwJF2RwSwvmpXE/iRLj5JqSTQQOXQxaExP/UlMRr6pNojr7ILgbgNcYCR
	 8F9cAoFGE9bgILvMM92jqTDHuDAT1FplRDa/LXRp0HiYZxzWPMqbBwHS5fPKoDR2E
	 iFE/tOVjjRa3tE63OAtrCn4L8RyNmYkcSgFI82wG67H9xYci6tFEMDLnJBPmuM9c0
	 pDwVE/fF2AMS+vuV90gc/vm8IPHA1ltn+1dTCCE5gh2Zbu4//3Ld4PDZKg+xsu3cs
	 J1JzhN6fs7wio5OR6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mkpf3-1tWvwH3bwd-00e19i; Thu, 07 Nov 2024 01:38:22 +0100
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
Subject: [PATCH v2 2/2] platform/x86: asus-wmi: Use platform_profile_cycle()
Date: Thu,  7 Nov 2024 01:38:11 +0100
Message-Id: <20241107003811.615574-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:p4rJly3IMJzDUYMLOcDzSU9ohGwXQolasZTR9MX1vJfDConvt+F
 cgfCN9pUFqmsEWrS7UREjNCg15NA464aFB/MCWBhjNXHus74lz0nekZztV2D4Vma+8Es/HT
 xLgNhotv5RKdp82ZgHzjV4kMtzKtt9Kx95s2MBWtRRGI84M5MaYg+9VSu0ULpxsTCG0pHpp
 yoYnbEkjT0rLZVsxjgx9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JEFWBE15POE=;12ktHUjGRDDfq+M0VeTMYs4fE15
 PjrxW2m0a3Ido0Dvvd5gbdfnz183cZ6KxDOJrIdD+4Sjv8QST61cR7/pQLkYdNCBvmwRhW7+o
 P0iTX67vMHkS/LZu+Svr8FvSTjkPJICw9xeCo6hpECB+2RvgU3V2aD2cxsx5tR8nwkuDRZut+
 agjOUwlOL7KXjqh7NVt3qjxYgbQhZE2l8bQ+ToJ5xd3gC7TVJ6Gw7fU0/QaefdXrsYfuqK0u3
 A58+MjdSuIvg8+w+0iAMzCGINjL7Nb9ttVP2+BfFu3ewp1HMgcn/8L1subZESlY3YyhRkeemt
 WMh7GOWavTob4htTTuuq5jFKG7aEMXdrtfm/62Pv3jdc8Zq92+KFuzTEKGsqOwFpx5ajMsukS
 3JYpJsZ4kSTyNz2UszX1tRtckCIJ5uDRfiXDW3SnQ9msbB0Jw1bMrahQX3s2hkwlbuQitz3Cw
 apA6+CGwxrYjfk4nSOtpyDbbBSNzJJS5J88Xnrb7oizb0kg32JmAYvCu2frN74GqmQ3sas04V
 vHzmX/qDMDOdESsZBKfx82h/fjGGT7cH/tNlfN34DClBWIuhhBrZAPcESZvJbXGs8GzUcbF+r
 B0snt2gqJlIhvcBtzfDEkR2LhRD6cBR95V+yupoiV2f2JLyVNuu8CbEAvFxOnfxkLt3zerPi+
 G1dQ1Z2wUj3ugTT6W3vdxguo4RUg+PgOhJj2zsQ0gv2iOvazEBiFVTYRJY0fuuQcTLTjl53Rq
 wb+zIN/L5bwQKwswOizy6vBwZ9Ni2iJvl6GcW8p0CFuRCCLtmxWh/VSehILjTOljiiY8UVHAT
 8WEgVbHxvib7k03dDFpdI00Jc2omIOE0qyWNyvD7SjVpdwfpTcYZm7zrnJMHFx0F4IF/c4RA2
 TwWB5x28kBNjWL7vGKNtkeH5aZbLwbRYcly0uCQGVZw5C9MYak1fgJLoT

Replace throttle_thermal_policy_switch_next() with
platform_profile_cycle() to reduce code duplication and avoid a
potential race condition with the platform profile handler.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/asus-wmi.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index ce60835d0303..ba8b6d028f9f 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3755,28 +3755,6 @@ static int throttle_thermal_policy_set_default(stru=
ct asus_wmi *asus)
 	return throttle_thermal_policy_write(asus);
 }

-static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
-{
-	u8 new_mode =3D asus->throttle_thermal_policy_mode + 1;
-	int err;
-
-	if (new_mode > PLATFORM_PROFILE_MAX)
-		new_mode =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
-
-	asus->throttle_thermal_policy_mode =3D new_mode;
-	err =3D throttle_thermal_policy_write(asus);
-	if (err)
-		return err;
-
-	/*
-	 * Ensure that platform_profile updates userspace with the change to ens=
ure
-	 * that platform_profile and throttle_thermal_policy_mode are in sync.
-	 */
-	platform_profile_notify();
-
-	return 0;
-}
-
 static ssize_t throttle_thermal_policy_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -4301,7 +4279,7 @@ static void asus_wmi_handle_event_code(int code, str=
uct asus_wmi *asus)
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
 		if (asus->throttle_thermal_policy_dev)
-			throttle_thermal_policy_switch_next(asus);
+			platform_profile_cycle();
 		return;

 	}
=2D-
2.39.5


