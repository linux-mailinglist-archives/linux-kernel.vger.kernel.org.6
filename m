Return-Path: <linux-kernel+bounces-382477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80FC9B0ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760111F214E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DC20EA54;
	Fri, 25 Oct 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ndkogysq"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80422803A;
	Fri, 25 Oct 2024 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883788; cv=none; b=Wb7XWz/6FJWolH1xT88k8jylE8WVlO79lA4nXku8Uev5iSnFEgUhxRCUVwbAhFeHBZxaT/lM6xw00P9Nkf2lU/brdr8hRR2vZMiR1UzIyI8mN8zIEF9uvax8yNNsbmPwx/XwYeXL9ZT24Qx1uRg74+r1cglOzwiUGlmV0NXmgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883788; c=relaxed/simple;
	bh=Jy6bIv31CFshpgmFe6r9PTiW5qhXOkneku83Jenlfdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHYZ+sNLIQsCk1ETQvPqB8JZfqRwn4LHS+zaffXB77YfF+zKZ6qtQorToEjf77YN2G2wGy9k+yN3t9yxqiGa5APaS1luSAawPVEYlARgzuT3REK+QHFXKq/8aSeBIl7zb052NOPXD5V2YakndFyjyea0usyQIQGMSYGGGtczB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ndkogysq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729883727; x=1730488527; i=w_armin@gmx.de;
	bh=HQaUR5ru1ESTSih7/mOo0Go5taqKXcO061/KCoE28gM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NdkogysqgOpKP+/Q9B00dEsZaPa6dEFea4DKk9FWS0CByi2/HXz17Z4dtcfODKr3
	 U/Q0BMVnTQaNF5sQfRpmsB/tG8parIaMe/0eBig9nouBUpFBB3K1PLu/gPUwidgDu
	 Frnp3Ac5Odqx3kbjtt/bN89ANf4eJWM5Jc3pCLGxj3xgCQllIgoIRbHe/q1Slk5k6
	 mDmvW2+4X6D8W0JUD3xWSSQl5AN1gB8L1e5qdwgYZQru4loMRidK46fJYsLsovY8i
	 54tPLgN/KaDsJFk0nf3CAS4wHZxNOqmbDDSmWoP/bT8XtOw7z38uNfZ0QHZjn0fzA
	 h21oehLJ99nougkFlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N6bfq-1txitt1zCg-00yzew; Fri, 25 Oct 2024 21:15:27 +0200
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
Subject: [PATCH 1/2] platform/x86: asus-wmi: Fix thermal profile initialization
Date: Fri, 25 Oct 2024 21:15:13 +0200
Message-Id: <20241025191514.15032-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:mntcIE4mXmkxQh8F9aOWWGF5VcdqfSLa7ENdY9L4ll7jl3qUmTE
 Px9wNtYR19fWjqUAdYMD/9IxAU+Es7hzpti8Ejb80RFpbevc3+1/Pgri9F1PuJBc5bCj4ei
 h0QE3EwG/3TG2aGVFzk6zem+OdttDc7qrytb1KgZHl3mOYJSCbkXlXWiZxms5psiM0B+mcL
 dKJzRO91YhCx9iGFRb5VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:16Zqp0/C73Q=;vxFMHFzIzIJIJYqZS2Rwt/Iil+U
 thWLa0UcgKN6l3mVNTEN8bPjGD8324LNTTgnoWcX+Kwg+i2kDb1SkvbM4uLFk7do5W2Qh+lVc
 7P9p6Jo2pagGllnmsL5MCUDTX2LTk/rD8B2gMr+w6xV/nEJsjjlb9kX1Yk5Yv3W/f1VRvPDPD
 k9bz9KcTYBhgSh+mhi9dKd33avbxHxwbs0BrDM8FmhN+8E9227CrAjERrj0sxFjQsdzWAAouc
 28tJrYb/uqXTn6neC0VUIB4t/2rBABiXNz0GhVp4Ew7KzYPcygF2TgterSguV/7vAO9NuKeHx
 LtvnBMUexYRclPVsioenPYO0ZQ5oWUL5lrPawJ/PWqp9C9xj8bx6pmv31kSYoa4WufaEwgNpa
 aYUhvhGsic4DFKPcleT0xUgdEnGcQqZlsEBrf2XZc89+s10zI0UwdOJ4HzmEnMRrKwmNW/vS7
 7X8pTdL2qP5pYuoPwAvwmCY5zbqu2oqWLetGgW2PYOJ1R+Lquc6UhozdaMy+3cpVrIlC0CC+Q
 xC1GUYQOr7bcBfSbId5QAhtU+IsZXUbiBCFFkSdXCQ/omIfi5nUQr1C8vd/He9TOI+2mo4lhb
 2FHkEo8pkmeCgSzHvGXAZeUy9+JCFt8zaclWk089TWz4MvP/JoTA3OSE0dEh062FbL++MNLEW
 0Bv8tNhbFWBTaYBKp19Aa8Lusz5Nh0F82zJfQI7FdDY03YhtDrOrWWTNlO2GZ5s7KLwttq3ZK
 dpZafWzCA/NRST1jjFy1bpFK/XI0D8kjxZvmMPfbz+EssLvbr+p3VnJV91oSxbsL4CDM1Utjy
 /5WbOSnNipekukKqB9KtaH+YSTyVll+512EaXnIv8uvVw=

When support for vivobook fan profiles was added, the initial
call to throttle_thermal_policy_set_default() was removed, which
however is necessary for full initialization.

Fix this by calling throttle_thermal_policy_set_default() again
when setting up the platform profile.

Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan=
 profiles")
Reported-by: Michael Larabel <Michael@phoronix.com>
Closes: https://www.phoronix.com/review/lunar-lake-xe2/5
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/asus-wmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index 2ccc23b259d3..ab9342a01a48 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3908,6 +3908,16 @@ static int platform_profile_setup(struct asus_wmi *=
asus)
 	if (!asus->throttle_thermal_policy_dev)
 		return 0;

+	/*
+	 * We need to set the default thermal profile during probe or otherwise
+	 * the system will often remain in silent mode, causing low performance.
+	 */
+	err =3D throttle_thermal_policy_set_default(asus);
+	if (err < 0) {
+		pr_warn("Failed to set default thermal profile\n");
+		return err;
+	}
+
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile suppor=
t\n");

 	asus->platform_profile_handler.profile_get =3D asus_wmi_platform_profile=
_get;
=2D-
2.39.5


