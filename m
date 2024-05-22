Return-Path: <linux-kernel+bounces-186717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5978CC7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA9D1F2164E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829497CF30;
	Wed, 22 May 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pE+hDY1b"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9ED210EC;
	Wed, 22 May 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412114; cv=none; b=tdanITgiFZt/SF04rAx0aK/ZMzSE6UqQEiTdqM94oI0yxm3ESqbMpmaCex/FzqR2MCy3PXHfaHOjiQHKkZCK3LQp5AUYxFQTqNz+jmb6D+OM7YSkHYL/oeIx2iUphbgAIMOIPRFoWB0UD3jaeWq63uhcJF+Xw0rfTozBLAio0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412114; c=relaxed/simple;
	bh=wyKwbRujRoPke4/lV1FaQwysoRe9GrzMwdiqFDBZiAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkwAznkdDHu+bVm/L39CNuMBLU6r688FxCyX6ahWFHp+hoAvgDQ3Rgqe9CPA6dBCMov5Lfg09joXctR48vzAKutgMJlTNKEbTxcE05f3hijG4yvOR+Q2TPY8+YZel5r8ex6PK0DJx9yHolI1IYpFogcT0bs3y6+OhGZGPai+N64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pE+hDY1b; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716412093; x=1717016893; i=w_armin@gmx.de;
	bh=Ve0t2+XFI9Sq3qDwo2DWYQpac4m55xmwNB3QXm9FJUg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pE+hDY1blw6tDsr5B03wLLZfVFcFzBEpmEpUJIk57dmjrH2Hh0BXHAbhipdSL/1C
	 01xdnqS7GYfy1KDi4J/rWGWx4fpbdKwWEXuM2RXo6fA2iMWS30/NpGI9QO3scGjzd
	 tHpyKLeOJAhX27kXtnJMzMI0Ig9ytM9zydvLK5HHRiXUNf+5zmb/Czx0zMMaiT9EO
	 RVVu80gQCtk3Kr+aQzDVYnuxEQ7U5bYT7PdnpqJf044TmmkdvNbJeZo6VliNUTbSU
	 PYK1IpKcQnoGttCq5CGJkqP/hIxYUSJNksQNHfG7j7tJMmWEu7vZW8+YU/Nxdlh6I
	 TlmUwPscGMBJ86Tn0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MPXd2-1rw3Ic3xti-00PqfZ; Wed, 22 May 2024 23:08:13 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell G15 5511 to fan control whitelist
Date: Wed, 22 May 2024 23:08:09 +0200
Message-Id: <20240522210809.294488-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fdXUM6MZ+sBQDtqO3gK+TP8KeY1OY738pQ40QACdE8sQyd7jf+T
 Ul1DGMWq+W3gcAX5BIb0KngD7rh6u0HoYhPlvAmHLqbWmkjlhxnXGpZIJrXVLH4+KyHlHf4
 gppZSXFvrj9y8b04YnFU2RffaDxE0ZefFFZ6W4ZILDkQB+7cNMYUj7/1Rmc9rop8R8FLJdf
 Yc4g+c5aJdF93vDCZB42Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1vT5TpDXUnM=;BIO6uTPAMAPW94jXjYxKpQoiJoo
 tfwPzRSpbwiGfEct1KHuw+oxoahDc3EHAEFxQX3kYZbUcJsXaoOo3MVhzbtKMujRLvqZ7tRh9
 AxbQNfjHUGC2A74my0Aow0AQKLBp/48dbFjA7ARXpqFixZmQdbwaFguVTggFhhI/pITJuuCVY
 qcVeaUCAgsGovbp6N1y894a/LLUmQA5YU2VpmEnlIDegYOo5qQC1/ITS4K/BjEgO+P7mvtZUY
 nZw9iji2FAoRWXq6GlHNN9hEAWAS//EDIQOPNX2Y1vAyGOqnXZkzrQLMNgfzocDw/jYeiipzS
 Hi9tDfETc8XM9bJQ9SI6Y2Mufo89akiMV9pOMnU0xgb6nlZeC2Yt28QjClm9DkzCOLF+l9UsX
 QiXcbHyKKobM1Je05n8Pu5erwyOkFxB21UMqNQZ024hCiL5DRSO8ZAVEXo7A/s6nXPjC1QwrY
 TWYPogHAgp/sp5A2Qd2oXoeLMaqeggYcOvRzZjOT07KQDH4R6THVNcE7ddD4Kw532R95KGvG5
 kX9U4RYiX/F4IrDuE0JTa/WOQ/AplNwnBn039lxSWLYchb6HGCLdlvKXSfszRx2I4i345B3bu
 vGGVq1fckYzMYvF+7JFxFR+y4/0vEb6c2CeQ3IifhLP4uxMWLqhq23UB5TO2ywDhucrk6meFM
 fP7lSOWN6uIt6A4HJeTJDjtTBsVxtePuxUQNiIzhDnE1c+OkKya8tDytD9CYoG3Sy2Tow1kcm
 EGjBH92UfTrMHW0vTo/aA/4z8qCveILSyrymdG0N7H0O7I1xJPFWsxFUIHzcN4YFXqGZl/b1P
 KXh+FI9ICHSfeceyHmrwUWhAMbkz6YHY8aeuTb5565Y3Q=

A user reported that he needs to disable BIOS fan control on his
Dell G15 5511 in order to be able to control the fans.

Closes: https://github.com/Wer-Wolf/i8kutils/issues/5
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
c
index 48a81c64f00d..942526bd4775 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1545,6 +1545,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
_control[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
 	},
+	{
+		.ident =3D "Dell G15 5511",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Dell G15 5511"),
+		},
+		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
+	},
 	{ }
 };

=2D-
2.39.2


