Return-Path: <linux-kernel+bounces-228371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE1915EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A325283B82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D771145FFC;
	Tue, 25 Jun 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IGdf4U6d"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B71CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297317; cv=none; b=rCq9jNEquAgIdaVRG/CshiggB947+8/z9LYPAVQs5Gpsbfv3HLUfOX19pJNgW47uvkgYDdlpCFwWancU45mlIce/GvNzP6rAmynH8Yn2p6T4ss50RaLgSRIyZoxEc4rW6r2QwKqv9Vb6pgn3JJLwIb6a9x23rzJ7ynQrmwQZZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297317; c=relaxed/simple;
	bh=lBnjct36G3drG+mcavFyer2tgBg1G6s60znH1k4d4gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmV2znu0yBYtfcRW+XMGriy5TGZBKJLassUbmpP0FQV2l0BNZxtvFgS7SttO4SCn4pwPyqjak2Ijbujvyy6tZK6ks6hdll2hLCFTJkIMxgGSjXmnkQpA6fIswzktzKBtQMzu7Mf4x8P6d0LGVYKL6Zj7k7U8zpKFQ/l5Bi4VWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=IGdf4U6d; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719297308; x=1719902108; i=w_armin@gmx.de;
	bh=RWKwv8Fsdu7u66NKAUfD+Vv47kvE3VWa8/QOTZn+UfQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IGdf4U6dMe6CGc9Br60OiEb1JCr2TPLa5L8BnJp8bBEY8gCQ+WcgQ5F0/TeKmieY
	 9cRXUR75LtN5FHuX4QLsbr1qQDNxgQW/vMnHx968O9zgYhbAaivEu4IoswR3U/VQ1
	 XKg3lpd7N7YTuSXKvRDT1C22rfTxQdZ4tK5XgbpQ/mjJ7u+c4DCEslzgYOFQD4WCd
	 VBnFFDO3jVOSEM94VitBCscRVFppt/OCLGtIN3HGWhHF8fIZukZKyeXgt4vGaDA6t
	 UZGi11cK65aonCYaMH/SXg71FCVDIiC6D5zf8ZFLeAz8k1lhM1Jsf/x69hYiNWfRo
	 76XyGaRnzfG8qoXYDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MhlGk-1sqwrk0mie-00fKJW; Tue, 25 Jun 2024 08:35:08 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: hkallweit1@gmail.com,
	u.kleine-koenig@pengutronix.de,
	srinivas.kandagatla@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] eeprom: ee1004: Use devres for bus data cleanup
Date: Tue, 25 Jun 2024 08:34:58 +0200
Message-Id: <20240625063459.429953-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:81gye1G+5KbvLxoRWo+uL6PLNcfePD85+thiMMJdOsoLTPp3eMA
 V3hghlilKvj9prmcOzcHNOCW8I6vaT8o2lVjaAVJ5Bjpm1hgtAQpviRqC4TXt9taWgFfidz
 lMyG6TbUIpSuorfjF/e6yIAjVDEXLmljP3NPGGpWXIdGBV8BhXdkwc+G/1/q8cEPlrsw5V5
 v6BgHVejfFk+VTEK1ZpYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b1Uhuz72N6c=;chcBcbpe431CYFxF9rc51WR7qk8
 qc7hS7vOM9GmN+rGNX0p0+IqhKqZcYfUBWC44soP0/PJ3JauoMh5Y/YMqX4eSXaNvlG85tLNx
 au3AiTbeHQqFnQ8pfV6J2IJaswxkUtMCV/18qtC5qNJTJOhvZNzLXfje40+Gc9mI2IIcqEYjc
 y67mVLhQBzWFxduu2xFgCvYLbWJcnHvyQsW9sM4ZnThw5Fo6iFLasyGlwHLAPWiqsGEnwhLtV
 oPn/d5d2U5v+BFsVCxYBf9BMll2Am8HtxiIQwPD9orwMH6x5DsHTKL7Gf1squu8m8oCw1q5Vv
 82AwDOOegqG5g1X6SNJby9JsWchVoIn60tGMd/AZ3XvYbhCahDM8KmXF4eANrMfYoKXchWFjK
 xrBpznsu179SIz74BfzkxPQftTcXHVn8Qfx72C/hBKMajx5ecjF7Nj3eLHH/4yiYNKbXIVy3/
 7eKuYUbJ2wx/4giQxtSUZuNqhNzNHos8pj0YTN1BKaekiFrRzkiDAU8XYBXUMIkIJkOlR+I3v
 6zeE5HRznImH72l+GmHYvncvRaWvEj+lofMCdzR2FQFHLmZE34JU95DobFh77LjEDoRoEaAy5
 za54NwoLBaXaCSkVj0shZXwf2g4S1Rkl6AW31u8j7+CvhcBNySF35R7LQopWK3nxNb5S3Dcee
 KRPb8B5fvJnCL9DA8bM/251OqEijoGmIs4oAXg8b9l64dxCk7reLGCizhK44MLmLdhWSRcfKN
 PsJP0IlR6RiX0H8k0DWY5DHOmiJOW31NeIn/y8MKGPMsD/6InmdcJHJYr+booUoAR+o+ZP7G/
 GcWpwyaxQkAu3Sz0TQxsuZvsRKLfyNd7nfldY9c0m9u1U=

Use devm_add_action_or_reset() to clean up the bus data at
driver removal or when an error occurs during probe.
This will allow us to use other devres-based APIs later.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/misc/eeprom/ee1004.c | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index bf4f65dc6d9a..b1f760cc3be0 100644
=2D-- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
  */

+#include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -207,6 +208,16 @@ static void ee1004_cleanup(int idx, struct ee1004_bus=
_data *bd)
 	}
 }

+static void ee1004_cleanup_bus_data(void *data)
+{
+	struct ee1004_bus_data *bd =3D data;
+
+	/* Remove page select clients if this is the last device */
+	mutex_lock(&ee1004_bus_lock);
+	ee1004_cleanup(EE1004_NUM_PAGES, bd);
+	mutex_unlock(&ee1004_bus_lock);
+}
+
 static int ee1004_probe(struct i2c_client *client)
 {
 	struct ee1004_bus_data *bd;
@@ -228,6 +239,10 @@ static int ee1004_probe(struct i2c_client *client)
 				     "Only %d busses supported", EE1004_MAX_BUSSES);
 	}

+	err =3D devm_add_action_or_reset(&client->dev, ee1004_cleanup_bus_data, =
bd);
+	if (err < 0)
+		return err;
+
 	i2c_set_clientdata(client, bd);

 	if (++bd->dev_count =3D=3D 1) {
@@ -237,16 +252,18 @@ static int ee1004_probe(struct i2c_client *client)

 			cl =3D i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cn=
r);
 			if (IS_ERR(cl)) {
-				err =3D PTR_ERR(cl);
-				goto err_clients;
+				mutex_unlock(&ee1004_bus_lock);
+				return PTR_ERR(cl);
 			}
 			bd->set_page[cnr] =3D cl;
 		}

 		/* Remember current page to avoid unneeded page select */
 		err =3D ee1004_get_current_page(bd);
-		if (err < 0)
-			goto err_clients;
+		if (err < 0) {
+			mutex_unlock(&ee1004_bus_lock);
+			return err;
+		}
 		dev_dbg(&client->dev, "Currently selected page: %d\n", err);
 		bd->current_page =3D err;
 	}
@@ -260,22 +277,6 @@ static int ee1004_probe(struct i2c_client *client)
 		 EE1004_EEPROM_SIZE);

 	return 0;
-
- err_clients:
-	ee1004_cleanup(cnr, bd);
-	mutex_unlock(&ee1004_bus_lock);
-
-	return err;
-}
-
-static void ee1004_remove(struct i2c_client *client)
-{
-	struct ee1004_bus_data *bd =3D i2c_get_clientdata(client);
-
-	/* Remove page select clients if this is the last device */
-	mutex_lock(&ee1004_bus_lock);
-	ee1004_cleanup(EE1004_NUM_PAGES, bd);
-	mutex_unlock(&ee1004_bus_lock);
 }

 /*-----------------------------------------------------------------------=
--*/
@@ -286,7 +287,6 @@ static struct i2c_driver ee1004_driver =3D {
 		.dev_groups =3D ee1004_groups,
 	},
 	.probe =3D ee1004_probe,
-	.remove =3D ee1004_remove,
 	.id_table =3D ee1004_ids,
 };
 module_i2c_driver(ee1004_driver);
=2D-
2.39.2


