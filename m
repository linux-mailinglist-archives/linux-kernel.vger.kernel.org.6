Return-Path: <linux-kernel+bounces-420186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432429D77D1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CFFB33240
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CE53804;
	Sun, 24 Nov 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EOlHsOjg"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF745027;
	Sun, 24 Nov 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468797; cv=none; b=dq+M8BH7txWuhn3uuWGTGQbH/EUV9b6uZcgJLu9HQTUfima4XywBg69oYitQ5/FEjDYPe00kIRcv6YCKt5KekUddJbGStn6W0Ss+Mj8J7x4fwzriJppQwBFZCS0CD2Q3/QqJpgltFvR5o5qW1/82UpKk7NEXIGa/R63hzgPKWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468797; c=relaxed/simple;
	bh=SiyOAWfEOoSDNAGYe5mn6YN8gKSom/svjafmGeHNZ2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZJTYqtSdokHqpBOXSEtoYx6oMYpU5bFPMGOJYSwnJ0dxUXvywx+VtUd3nTg79V4H162uu9VKfKyh1fX3dXtvkn5S87xHWBKYS4RmK1LyVrOhxRxtdM+zs5HTbmuqwt8jT+4RGxycmPIzrJwFcVImp+pWzQ+xg9fr9XBv413lReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EOlHsOjg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468785; x=1733073585; i=w_armin@gmx.de;
	bh=MaVLdz0KEOM2+iKMk8AYIj/yiGUUGZIESCAZ25eWQMg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EOlHsOjgpLJHWo1dmR4X1MtAoSxhy3khge74P9W9MJruSYfxo+Vx7MLQ4zYMWUKM
	 Lz9jAnNi3V3omTtacMJK3Vk5KIxwdM7PjfBBirp15iJREHY4LOL3NJlK4yhw8PExc
	 DZ95nXdCz7g8Du8dWRRQawcYSHrMw+dtbeMQABYJc5qn0DdPNZyVPwSfgd9VuL1jp
	 X1zSTfEI/SrsqJdUlE2BFH3Akwz3TzT8mZJyjQ3HfOTPae6RwDsQuVVfBJOLhzRCB
	 gkmmTS3Tsr10095jDv15VGTOwNWBkzjEUNxanUc677JxmUXB7ZG+bM+U7AXCO1mKI
	 JI7OlwRNYdWwUJdj8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N2mFi-1tj0Wq3XQq-00z9uP; Sun, 24 Nov 2024 18:19:44 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: auslands-kv@gmx.de,
	corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: Ignore return value when writing thermal policy
Date: Sun, 24 Nov 2024 18:19:41 +0100
Message-Id: <20241124171941.29789-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ym7xk3fgh+YK9Mf/f41TBn317ra0YOuIAYp86BiWGyi6ZqfuGHC
 X2b555StjQJFw+h/OBIvvEnkQGN3Mhzmjh0JhOWFvBaEcGOoPL4Xpg+mPepHUdJ792D75aa
 05IX2i3ZwIhpWqCKxSNRIGSz8ylkFqpPbmcyT1DrQsE58cqqFDq1hCGllZhOqxpopJ4M422
 EdQYjz+x5Ssll7kDqZF3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uRtQCbckZmM=;U3zqmhhBQlE+67WC0wuApVGh5h7
 B0dK++9cndnYjK5l6e1GkDbhmnR2G+dXAIIBvfG0GqvRN9Ohz1wnvJ+6jSDhwT0HQzwt1CHV+
 g0Q5vUeKlSqlCap2Q9n1NrTZdrTBkkmYP7iyDn+gjiq+ALoVgIlKyKPvi41GTFMrwdSA3EMqI
 z/MA52QCmvpbs/u1LTrZ4Funh/Lyt8GP4iALxGb4idtpfmZkrdkF+RBL1NMzpJpCVnJCZSbNW
 f/jzafArZUnqP+pFKe8ZtAplfBuHZtnFzH49BODb7+zdwkBVrrnsukHo5wRWiiI2W8y4+iQNf
 eqccLOGMc4FEAu0H/a91ABO+coZpitGe6EMrszF8AU32EE6hUqF2fKhcvYggrFQswRTT5KW8R
 vhIBXCRvfUTVag0T45izeARawUa99clYkmdHLW2EoVx0J4u2k7plf7FsK0qcgI23ul3Vgy4BF
 XCoeNWaWkXKDG2oKmoh0OcJQxMJ3KDdoA/Aybd6qYoCgq1zTp6MTsVcWIS/+riKprDqkdnnWR
 GHkwIyh+p1a/bdPBJQ0zz7S41sHHW4XI6CbPqvQkG84mCxDDiy525jWZRbYS/hZ9rAC1J3TVY
 0AT+CjC8Bx5jt6dN65Arrf0EwBdb/gbpcxXYp8IOYfzrQzC1RXH9yq0mO4N/BCWz3+XKZmjXD
 ed8rePqF9M9zhTJLOS+o8HEmvZSHWufbCXTpQx0mMduZzuJVxpsf1BVrzDREdw7vcAfQBvw/c
 DaoJj76xCSVEAO/df7B88WEV/2HPs4y5JxrrjeDCukbJTZadljw/5r2MTe1Pl9FO4HUIFuVzT
 YldZTI2qXQZ7ZxfkgxXTZtN2Bk/b1cM6MP3y+vrfjLW7dVox8hqiQ7TERy/JWQ5SVsGOStTke
 l9fEYgCaZuU8kV9EuuJchT4f75uRecSW996EFO9/YAJRWKS6pjNJ9QR5X

On some machines like the ASUS Vivobook S14 writing the thermal policy
returns the currently writen thermal policy instead of an error code.

Ignore the return code to avoid falsely returning an error when the
thermal policy was written successfully.

Reported-by: auslands-kv@gmx.de
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219517
Fixes: 2daa86e78c49 ("platform/x86: asus_wmi: Support throttle thermal pol=
icy")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/asus-wmi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index ba8b6d028f9f..8bd187e8b47f 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3696,7 +3696,6 @@ static int asus_wmi_custom_fan_curve_init(struct asu=
s_wmi *asus)
 /* Throttle thermal policy **********************************************=
******/
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	u32 retval;
 	u8 value;
 	int err;

@@ -3718,8 +3717,8 @@ static int throttle_thermal_policy_write(struct asus=
_wmi *asus)
 		value =3D asus->throttle_thermal_policy_mode;
 	}

-	err =3D asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
-				    value, &retval);
+	/* Some machines do not return an error code as a result, so we ignore i=
t */
+	err =3D asus_wmi_set_devstate(asus->throttle_thermal_policy_dev, value, =
NULL);

 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
 			"throttle_thermal_policy");
@@ -3729,12 +3728,6 @@ static int throttle_thermal_policy_write(struct asu=
s_wmi *asus)
 		return err;
 	}

-	if (retval !=3D 1) {
-		pr_warn("Failed to set throttle thermal policy (retval): 0x%x\n",
-			retval);
-		return -EIO;
-	}
-
 	/* Must set to disabled if mode is toggled */
 	if (asus->cpu_fan_curve_available)
 		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled =3D false;
=2D-
2.39.5


