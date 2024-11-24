Return-Path: <linux-kernel+bounces-420179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D49D7786
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8349FB30F41
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EE4CB47;
	Sun, 24 Nov 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AWbPcabD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424771747;
	Sun, 24 Nov 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468489; cv=none; b=TeHFGtaQp2oKiUZoUh8E5336SwE0rFHuKCQuv1jdhg+I6Ztc6Ya7unY11hv++6Dts7TrEa2o92YjaxvlUBajXOT5mW1ZAN5bn/MgCRthenL19f8cDrV0IsunnGhG5YyJXubwormEeoN1iJS20QiurkDy6X+3hjEb3i98tIl8rJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468489; c=relaxed/simple;
	bh=Oe3JyZEwWHQ5DGyvSoDFsVx4anO3uKPtSPYDS60LLlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeXP+MfWZuJSZNZyedcNdQe6MJkif80qMMebBFnZyK46O4pS4CRUMvqXSmCTTA/HbcG2oJPial5yJhZI7u6c3YHO5QdDaYIFu5360WXhsWoRWTG77UxQFviwmNKGoErEnohhK7NMB/eF0T8g/OWpIMT7a+4ZTMzoTQLgFZQ4OS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AWbPcabD; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468479; x=1733073279; i=w_armin@gmx.de;
	bh=AgoyI1cc5qKANNY07ndy0SF1vtFAblDEsqsKxaRPzj4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AWbPcabD+bOaRSJlxdi0P6XDT8YZieisSy2OVvoDm+xeQbqtccLenz4H3pab2cNb
	 iBt8Ahiho9mE7NrwELRj0BDtHaOHhn0pK/WmVFf1Aoo7cKisTUQrb+MDNU29grWDQ
	 s1RUEJ5vpxUnRpfihG5dnOyC6/uunIs5ofdd6VUA6PmskRbCzFdqaA7mnHiwOzOVF
	 pqMVzhG3yvUsPps3JG6GH9KNvPzvDjDXKLaezPOCtSk536mxkRkQFlcxxDaqnSaLF
	 nQt6qeupAbl8Tv8AsYK0WXvgb1Ix1/bU0WpedfWlcgCC4q1WIp6m0bIls3lmPg+49
	 87iaeFna1W9caXOGxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTiPv-1t9RH00Ibl-00Q8rK; Sun, 24 Nov 2024 18:14:39 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
Date: Sun, 24 Nov 2024 18:14:23 +0100
Message-Id: <20241124171426.29203-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241124171426.29203-1-W_Armin@gmx.de>
References: <20241124171426.29203-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tRFbj9ZaUSraNy5SHBawwgI/kUz3KKdzJ5EFzjMHlsZDx72TVQr
 UlZStcvmYzrWkpk9q3RQHrSAVfLc6VxkGLdYHIJM0zoh+GGJ7VsqRupr1YWMn/WzGX+iHhc
 5Az8q2ELt0DKoN/oDwKpTFLsRcUU77rvUSeUbfzsbAtAalbHoaA9zO5vfcd1vYNRliMXTQM
 alghugKs6OtlGN+/Jd9yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i6QfNh8cN98=;0aWETE3+yHbTs1o3pm0V55Ur/wz
 qAAZWsbati1i6d+WyVsRMHNfnSTxW5QC3SlokXRhhNpGQ/YhWll/Mp+K4NcehcFgY/iWVvo/3
 CbTwhlQ3nLStLx3rCsD07guBXj2/bnze+TQLLxd8SEDjie1fFvDllaIqnl3gYfXlb1LCEMSbD
 fw1fWEM32tWjotH4HJdMc1RZimEe/JqsSyGtpcKwNMP6eYnY+Rtw8SeyYSXh7k2F3f3lO3kPw
 0p/wT5LsqHq7POysRW0miz0sj+6/Xm35griSlUNDEfy3nJQrrgPp4hTHm6ZyltwG25yzaPxvg
 rd8zpQZrBI7rqD5nvYn/gxSIbVM1fUukpr7LFG3Cc98Be85Gg6x1YocmcUvBWtu3xrfao2EwR
 3Su9fogyOivGplH8PUvMafblEcvPMxU8nn7/s1iMY/rVac0jAiZzNwlije5Yjd4nicnecCHLh
 E7zCIZuXLmcolBAY4XVqBGPQP8SfCCbubHGZrs872dp03ty2rGcp//ItsoteVO6+xLTq4WM5o
 doyvj84ufsA2Z8TSjFuuJTd7gTylaOu5KBFiGScT0fjbdqaGaILlbHBqJ0xAgUgekXTU7uESy
 1mEuaXW8zq7xZ9C76gkusKRm6RlyaiPr4iLGtnEh/e18yys2DbZLrtVZTib4/vCFBNSRjqevc
 wFRDfhEvmtOPIaMr4ZEpX3qIxNtWEmHMDpPcbjPFJXMGw2mkLh/tVFmLH9L+JVzv+TFJh2W1M
 ADW2vhDKMnc5qlllTPk/VAuffO+GXKCO2rTlMvKWjcZ5SoiPU21Q2P11fVO9UrHJ5OimmAV8P
 R/z3OaNfsM3qIshqKWKOcMGX7pt3BY28UCkbAFR/Mc8uUGtz/D3PEIRB/PsYrekOn/zoowjVT
 2stVy9qlWuXqKRJTnE44XrB1goyDgb4k4/WECQQwL3TWhwhrcpvbdv61mHR2uKmJsuKMUKZR+
 eJcFAHaqkCyOaktv3dMO7IyGV3KlqtzyAvDeMpulLjPOsgKq5YtQFEww4NVHRQf+7vY8KTLpc
 BKo0kFuHo2j853iGowfp58DZuqZyNgCC//SwTdTz4kYEO0zAAXu08Zd3SbSEcfXhsu1UAsuix
 JSpamwZ8Vk0rsdqDZil33udPhVWdx0

Rename ACER_CAP_FAN_SPEED_READ to ACER_CAP_HWMON to prepare for
upcomming changes in the hwmon handling code.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 5cff538ee67f..dd57787466b9 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -246,7 +246,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_LED		BIT(8)
 #define ACER_CAP_TURBO_FAN		BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
-#define ACER_CAP_FAN_SPEED_READ		BIT(11)
+#define ACER_CAP_HWMON			BIT(11)

 /*
  * Interface type flags
@@ -358,7 +358,7 @@ static void __init set_quirks(void)

 	if (quirks->predator_v4)
 		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
-					 ACER_CAP_FAN_SPEED_READ;
+					 ACER_CAP_HWMON;
 }

 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -2551,7 +2551,7 @@ static int acer_platform_probe(struct platform_devic=
e *device)
 			goto error_platform_profile;
 	}

-	if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
+	if (has_cap(ACER_CAP_HWMON)) {
 		err =3D acer_wmi_hwmon_init();
 		if (err)
 			goto error_hwmon;
=2D-
2.39.5


