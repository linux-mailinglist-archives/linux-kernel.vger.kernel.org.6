Return-Path: <linux-kernel+bounces-425914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335E9DEC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE5B16366A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2601A76D5;
	Fri, 29 Nov 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pMtlXOvi"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8B1A4F0A;
	Fri, 29 Nov 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908858; cv=none; b=kNQLtLw2VHOuJkCFVlw8nTRCSOEn3ks4fAQo0G2o39kZ4mYk3gBGVZavrrZ9PX5xI69kBJnIAhBPPfCQqmwEkGpw3kGukUFuX6+OYyzTsfd/JFVDpgGuuGYAJT8TzIb9IuRJO0seP+pXJgwnlGnhS4vys349dNRTh8K2c/n+hUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908858; c=relaxed/simple;
	bh=dz5zS6kB5edcWn2Vs0OGpGrGB8qow0mRIbMXAAwJx2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQp3bUyEbUn8UHydIYmU6kC+vi3GBZP0REni3KJuye88l7ar5T7BePs4/bUAEuawBYIjdSDrjuEgZ0YsEZHLxnYjxMiDiSLoajzxzG8/ARa2yFrI9q+yzvZZ5Ys/lkgNxw5R6u395uYguioswjOiUcFW24nX/XKipHscqyEYMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pMtlXOvi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908848; x=1733513648; i=w_armin@gmx.de;
	bh=UP050hPGANPERFI8S6uX7fXmxD8vqSI87oyADFw+R4g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pMtlXOviVuP/0c/VZE3BmWlfr8BSGfpa88JdMdPTdi8Ak0LALIUK0t/ldk3+N5Os
	 zj5BkFIcQO+vUQ46wbQvvN1TM7wTc6v5CSYjhNCocgIc3RjIrunRnfUQfN1grPIra
	 4y7M3dJp1NbWvX8G5clOzxA+G20+txIveS3R9kkqT5kz2cGXSVNNqpjY/uIh0/XBe
	 /aU4rZFEXDRrqY7Qrg5pm83Yeox0jh27kMOLXapqrFpqaQUGTM7NbRlrTso3EIiuC
	 PHcml5WiJQ+GrH0PaBKOoLnGb/hm5dGWoQhO9/brh0HOU/+eDO9Ta7HmGjf4I+kBL
	 5NijFCaUceI8j7a/Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Ml6mE-1tyBKe1qWa-00bZpw; Fri, 29 Nov 2024 20:34:08 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
Date: Fri, 29 Nov 2024 20:33:56 +0100
Message-Id: <20241129193359.8392-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:CxxXdM/g/JJe86yHe7miFfeHVmzZyNrAK6s1Mxlh6wdbYs4BDRS
 ZRTzrz/bKpbaj1MIrSbBSl6YEG4Vr5BA2JySYrEft+051JTkYrBGYdd8c+s+mgSOr/Fi5UU
 5SIMhxHzscBf2rmOq22Xu44fqOy88Q7SuULavF7/wbP2CSyGG2QXarEJ7ahpxUrXjjfGhAX
 VSJEN1eFPUBern0O4s5Aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y3hhQITfx6o=;iTHL1kidGw47cGdYyI9Z6CRUeHN
 ORaWGBW9TP/NErwupKaPAAhjSlxywEXBxsKprGrVaOlAxQZHOfZnvCIOXgwSLtzex1dEdYPHy
 aCOlLTLmgEbTIi38yD3oKCx6EIGwEsVNIy8/6iAMsMvlP2Eq0DuPyDhMVgVkrEaqdf+3x5pnM
 T/gW5xw5iiARHOfmo7I2O/F4O77Yp9x3154w+Loq9opbqblazjDATT3Dkb91F7EUS6KDWmo2L
 EAsoN3i1oUkABme4tVHH3y1bIJSxE24yjmNbh5dzFWe/XOsPE+M8s58e1ufpIOBub/x5ifClo
 Y86yVTsnW6WUIR68jfcBVMPvkMBQhMkecaqfSu0IkrSW3rnEm9F9oZAetbpIxm1baE1hbG0++
 Lq/2DyCQwtaq8lXNQZ8xbT7fFlWS5NZ+a71YxvQMWQrz9dAWPB6PkYEOPj/e0DLN06ppkUKlV
 DD8VyvOP/h02uvl1TDavb3FCkc2EdRVfBt6aYOJRRxK2nzntGGZcnc1OkraxAuIivFLCRQROT
 firCR3sQFOL0hvRzr2pKQA2/+i0enpzmUo4u62oyWsv7bnwWCH6yslKltinIh2Iz7bMwACIxG
 5ZGba/yHORrG976swKgu4FP5w8xiNpyjcpMggMoUYvtZWgOcDkieaKeAbGI5/1Ru2NvermQGg
 Oj87HAOqyj4OQnSZtHBahBHPe2JTM5X4wVcZlTztR+OYTlLzq0Kz7ExVSKKTxuoNE+xcfFHoS
 8lwOvalkD3TQomGmCtJAgrss0Qdn2A63vkgS5ANJ7d/r7jg2albr+GXnPqlnrkh84vODBtiWy
 Ie0JWsSDHN0bapzU9hUCwXzgrTug8zzL448hEafB6AHeH3yiynOfIQFJfx6FZZH1kxcH+AQRS
 CDl2c27irjDgC2IaZn3etzp2iiPeeboc1x5432tu1DVt1vZrMUNUHI4tdVfwTMq0dFAZC9CQm
 UDBtUPLXWXIawbgux//HbpyQYUkul5fcbynLa1l6PQyVx7Rfbj1h6AePVp9bOKuLxTSrzKbt8
 lj4TqvQs9Jqmhf71ImRHRl7cDY4y0+nlbnI25aiwGryXTiU9a5Sb0mBbTj28KG4LIrli/N4z+
 K9CAW7+ziXv74HaiEonf3+BygsDBpb

Rename ACER_CAP_FAN_SPEED_READ to ACER_CAP_HWMON to prepare for
upcoming changes in the hwmon handling code.

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


