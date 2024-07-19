Return-Path: <linux-kernel+bounces-257673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C3937D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610B52824D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915301487E3;
	Fri, 19 Jul 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Uc4bYMIV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97F59168;
	Fri, 19 Jul 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421451; cv=none; b=eV1evtHHT8+e3gGy35b3QkbPoSuA63GwLe5Gu/yMelJ5VTJBv8/8DRp1GQWgBpyJmQBvEGhQCcB1vXoKsap0yRpBHcRhmFsrJl44mN05eXc0qwEcTy1AcLztQuMMBs24mfPGkOiwpew1B+0xfg0mnujh384a47xSmkJV97jH/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421451; c=relaxed/simple;
	bh=zhWRHgnHuwV/l/mbk02OZ3eImJEQQ1aOLWOTcfjzHWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICzPsmIINtO9L0inpTYOkayA6scCJZ6VB8XGYgj/4G5CcfQ+BXk14gQWOuRiVASR0X6DsXQG6/eDepjD4RTHQx4p8bZiiY7e1rsXqdz6kABXKCfwRMtfhDoVEChicEjjXbwMl1AUuEQw/r+RQRoJ4vSDlBJzuIMK8bDojJKIzIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Uc4bYMIV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721421429; x=1722026229; i=w_armin@gmx.de;
	bh=JzkrddmU1/BMgLEAoo1h+oYv4fNeYIF3jP8yDToxero=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Uc4bYMIVbzfUGTH58tGbAlldmGXs6pfiHI9IqlGedhKWm1tZLTv5bAipkBUpHsNb
	 E8u/MSFxgacnO1wJkzQXFmRfwwId9txS4E7y4Xej8g+Q8OX2RwHuSW5YT8txe9SSA
	 qikhX2AeIsnfmIqhw3fegXLc8IILsgdYN7zvU5w0Jo3E9GpYyGQqBanlzPrl6Rswi
	 5KkN/jZ2fnBiG0YehVbVQ5Grhb3Yx7FMP1qtH75jzNfzJG5gBImdYG/TPa2eefAQt
	 4U0c12rL/6B7HjYiDNGCXhpx+MPC6wemLWjgvSchvt9CRlAHobWExzuzZpKP+mJJW
	 mHwpTpYWd0zN5guu5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MJVHU-1skEHM3lhw-00Tdfb; Fri, 19 Jul 2024 22:37:08 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell Latitude 7320 to fan control whitelist
Date: Fri, 19 Jul 2024 22:37:06 +0200
Message-Id: <20240719203706.19466-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SYxTOHjVLvmV/gfVShGuiF4q6t/sVnjtpHSOV3MRBbFr+Dy++zY
 9XeGBVICVS/BzT5GvrbBYEiM7/nEQOGsXMeiuZiXm31S8dLyawJy6C6nhKe1Q67UBUWou1S
 66UrSfQwzEOo1H+/p9WFOmv0Sukbrue11AaytdSRagYZZa0iMGDmvzEi//N5+2W8ZBA4Ke8
 T3/9kUOma/EDvN4TsKFdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E9QEDZz01j4=;7lZ66irtTqbAOPfdPFFE9j6ksrW
 g6KAoLnh6ptkUvuhGoej7YPgSf0E202vVViybp9HwLts/2F+JdoB3wxM8l8+vup7JQCaAyhcx
 uf75pWBYHVzevY651GxiJlA0VOsQfOoKU09r8sMH6qxBHay1Apy3wj+698t86PMTzbuLzXJQA
 2EdDQwpqkohh6WrGQwzwQTXeSvXw1+QN3Hln+qLQVSVWXYy/9df4h4pqzhDdMSYIVuGnEF/pI
 T3cqTwTKueNr0KMEBmcqrPzV+I6qFCbt7AoffBqug3RT2V9Ln1gTk9xWu9W4GXKT4sZKvsupy
 ANo6oaL/fmMbX5zKChYYr/YOMfX6AbgEff3mh1FqOb4VYsKrYxc5TQiuENJY6LUePJTmP59tq
 an4evYYE2M8b4aGyPNnWWGMZHoGSqCzYy5atVKtJ3Wsu0j1ne26eBW1rycoXXn3Le21qpXVL5
 vbfl/iMW/j1pOVDHIpzIVIZcPCsELLCyyxFOE3qIL7v8bPr+cy/9mKw8fNX7Wb4G1WpSIgxxs
 O/me2K+1CqzN+3xgnOKuAD0gz+hC2kiUyJ4MG31SMMlBvGCyUBtvXUXufVErk71v//hH2e7Qa
 OOnYwEpD7Iaai+Ki4qYkx88BxzSZQoahyLcZllPaH+OwFHbCTJt9MnwtP/jIp9yqTJ475/xDI
 IRjR38aMsexyNnuGXCZ6gjTjrJSUhSzeLUscoDrg8aBwa/K3XtT2GHUQn1DSxxI2KczVSn/p4
 mVrcZ5jyODmRiruPVqF8t8V8vDLLJ/3uF/Q7BXPS0613jnvZq+UYXILKV5mwcjA3z1KOFVtjr
 8HKtPdepj83fswZj0yX2SraA==

Add the Dell Latitude 7320 to the fan control whitelist to allow
for manual fan control.

Closes: https://github.com/Wer-Wolf/i8kutils/issues/8
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index c75bfe93f2f6..ac4484bd949b 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1488,6 +1488,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
_control[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident =3D "Dell Latitude 7320",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 7320"),
+		},
+		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
+	},
 	{
 		.ident =3D "Dell Latitude E6440",
 		.matches =3D {
=2D-
2.39.2


