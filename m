Return-Path: <linux-kernel+bounces-251681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C26930820
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 01:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAD9283BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 23:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490615B99E;
	Sat, 13 Jul 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="K4sVA/Oz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114118C05;
	Sat, 13 Jul 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720914533; cv=none; b=dWYXX/HyEeWxRAR1q/kgl/1l7WBAeSJixtdRRLqzjfS+tSAPNo1iUJ6XI11eEYmKgyZqUnQeJUfFAG1sYsMVt3OTzDO0vd86Tdnyqs9XzB8+3HtdyHNtdtNHJsOsg3hmvMCB9KKiLcgvyBkUDguR8vADLtL1X6Da0qostL5aPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720914533; c=relaxed/simple;
	bh=VTBOsWFIaAnz7lUz1314VbobSjDRgYhIU5WHIYfETB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TB671cOV97hph2E+ONzFlHmn/lqTxW1sLgmrXsasOGbgV7t8uj1grIlxaAjMLfSRoWvnzBSUpVR3YYVUXTctqc5K07bqA7oMHYCAqbF3k/lEBHU0jukxk7WRDzreWqCW7jrbLPge0tbjwdxdgAFtTBQF7oXUGWkTtLE7ZyJPfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=K4sVA/Oz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720914506; x=1721519306; i=w_armin@gmx.de;
	bh=2ciL0AoO/wPD59ay6atYUpbgv8f7o7sDhJ70O03OhhU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K4sVA/Oz2Y59SeCEsXyX7yGxcywtii0yR9+/CCluIMpHaw8VAmRGkt0L4iTD/ZZo
	 RC6RXeHbbM6RpfB8fEYejM2vgLomNTrokvseZf6icCfEPKuJw1aQqqlewawHnU9PT
	 17852cBfdF244dr9VgkuOZdxevolycbu2cWAIQsI1NSOKFAgyFVZPUs/rfzKoBj3M
	 KRTvKV1hBh9mg+vQ6c+4S8Ixa0lSfT5pBSClY+iwE7pqU+5OKZq+aZpxFNqnN5CHl
	 V5+/ltJnIaBcKiAuY3SuAKyX4sVuINWm+PulCxmixAyD/EhUrVTSpgp+XYB1qyhYd
	 yUdOrRqPNfQ1GVrH0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mkpap-1s52eL1THb-00cXnK; Sun, 14 Jul 2024 01:48:26 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org
Cc: hkallweit1@gmail.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH] eeprom: ee1004: Fix locking issues in ee1004_probe()
Date: Sun, 14 Jul 2024 01:48:13 +0200
Message-Id: <20240713234813.21746-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oEJlDxB7A5+Hn/mxZsnYzED27fIT0pVUB5Ueu1Pl4oyETV1f9Rn
 Jip94HS7leiMz5Ucue2OSbuRx979vaDPjG5r53mVDFEpG6GPdAV2GfbFPXJ4jULxa0kMyFD
 w2GFzwwxo1u3/9xGM/hL6UocWMF1y1136ZIQsiPxEt1Ei+o87OgHRH7qNb0OTEmZafXaFuN
 dmJQ50IPB/QdIAzRVmO2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eeovI1BHIac=;v9WxZS9CTtVN2Our+k/jadF8H0c
 qAFMc/bocMjM9T5clr2iPHy5i7Jm6RulXfBEGppgpTjh/Cdsax3tL3s1b+iQWT3Skz4bCzdzm
 Z33+xyjAg+EhR4CaIgf1f/5olxFv4mYS59MFYTepMjPwuuqP9TPvMadpvepBA6CYjRrqqr1n2
 VEstqYTQDkMMq09Q+vfxAzEJQRiGmN+Mhg00feWlrBeifw4OhrEBvJzMmOayJes7hMl8IgQKN
 2JcTmoVFoBRZrLF/8FjoVrr0EQ3Tu8Dmp/WIPculXZBfdz6MXgIHcuioXDDLMggZIdT/brYpQ
 bazwwO/Kjb9PLcHw0W2dDdebS1Is5wRS8GoOVpip6ifBq59wkv0JSqe4iX0absH5VcRXrJIH8
 GCslsFqSbgnpAZhqWUZmuhrfcY+S2oX+ooXomXyssT1Zu5yu0UgBrB7Ge2LrthagvLyYzfOb2
 kVsKlkhFE6VtV9PAmGAh8H+gGgMEnjFygzKL2BWCsWeFw9aOuCkAEwdVYX8ISjQ/TSiNl2Bth
 oDWFP7i0JeY8g+AIbKIiHNm1XPQfhFb4XY0Ea5e6LWlqeY5nA8Fkj6hlkpW7rvTUNw3ruGWe0
 e1vah96Kmoqo2/AbFTH9dEMRJPF5f/6Gg9kBcXeoRwoV26za9kvybImxEjDVN9UqNSHRUYgct
 eWbsuxJuZR4LKOa801KsACUtDiSRGzoF7SMljYP5M6usiukFOXEkCcKlRvXMIBFYwNFi5PA99
 S1OsmDWBAEd9SJsR1Nf2IFVX0JGPmlHyZVuRoVdWVR8B5yM8i38R8HIKQtmoXl9twFqGfOBt2
 C7nZA4+GnJ8T9Enx4oX4BJ7g==

Currently, the devres-based management of ee1004_bus_data has
several issues when it comes to locking:

1. It does not call mutex_unlock() before returning an error.

2. When encountering an error, it deadlocks when trying to recursively
   lock a mutex.

Fix this by moving the mutex-protected bus data initialization into
a separate function so that devm_add_action_or_reset() is called
without the mutex being held.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 55d57ef6fa97 ("eeprom: ee1004: Use devres for bus data cleanup")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/misc/eeprom/ee1004.c | 85 +++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index d4aeeb2b2169..89224d4af4a2 100644
=2D-- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -233,6 +233,49 @@ static void ee1004_cleanup_bus_data(void *data)
 	mutex_unlock(&ee1004_bus_lock);
 }

+static int ee1004_init_bus_data(struct i2c_client *client)
+{
+	struct ee1004_bus_data *bd;
+	int err, cnr =3D 0;
+
+	bd =3D ee1004_get_bus_data(client->adapter);
+	if (!bd)
+		return dev_err_probe(&client->dev, -ENOSPC, "Only %d busses supported",
+				     EE1004_MAX_BUSSES);
+
+	i2c_set_clientdata(client, bd);
+
+	if (++bd->dev_count =3D=3D 1) {
+		/* Use 2 dummy devices for page select command */
+		for (cnr =3D 0; cnr < EE1004_NUM_PAGES; cnr++) {
+			struct i2c_client *cl;
+
+			cl =3D i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cn=
r);
+			if (IS_ERR(cl)) {
+				err =3D PTR_ERR(cl);
+				goto err_out;
+			}
+
+			bd->set_page[cnr] =3D cl;
+		}
+
+		/* Remember current page to avoid unneeded page select */
+		err =3D ee1004_get_current_page(bd);
+		if (err < 0)
+			goto err_out;
+
+		dev_dbg(&client->dev, "Currently selected page: %d\n", err);
+		bd->current_page =3D err;
+	}
+
+	return 0;
+
+err_out:
+	ee1004_cleanup(cnr, bd);
+
+	return err;
+}
+
 static int ee1004_probe(struct i2c_client *client)
 {
 	struct nvmem_config config =3D {
@@ -251,9 +294,8 @@ static int ee1004_probe(struct i2c_client *client)
 		.compat =3D true,
 		.base_dev =3D &client->dev,
 	};
-	struct ee1004_bus_data *bd;
 	struct nvmem_device *ndev;
-	int err, cnr =3D 0;
+	int err;

 	/* Make sure we can operate on this adapter */
 	if (!i2c_check_functionality(client->adapter,
@@ -264,46 +306,21 @@ static int ee1004_probe(struct i2c_client *client)

 	mutex_lock(&ee1004_bus_lock);

-	bd =3D ee1004_get_bus_data(client->adapter);
-	if (!bd) {
+	err =3D ee1004_init_bus_data(client);
+	if (err < 0) {
 		mutex_unlock(&ee1004_bus_lock);
-		return dev_err_probe(&client->dev, -ENOSPC,
-				     "Only %d busses supported", EE1004_MAX_BUSSES);
-	}
-
-	err =3D devm_add_action_or_reset(&client->dev, ee1004_cleanup_bus_data, =
bd);
-	if (err < 0)
 		return err;
-
-	i2c_set_clientdata(client, bd);
-
-	if (++bd->dev_count =3D=3D 1) {
-		/* Use 2 dummy devices for page select command */
-		for (cnr =3D 0; cnr < EE1004_NUM_PAGES; cnr++) {
-			struct i2c_client *cl;
-
-			cl =3D i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cn=
r);
-			if (IS_ERR(cl)) {
-				mutex_unlock(&ee1004_bus_lock);
-				return PTR_ERR(cl);
-			}
-			bd->set_page[cnr] =3D cl;
-		}
-
-		/* Remember current page to avoid unneeded page select */
-		err =3D ee1004_get_current_page(bd);
-		if (err < 0) {
-			mutex_unlock(&ee1004_bus_lock);
-			return err;
-		}
-		dev_dbg(&client->dev, "Currently selected page: %d\n", err);
-		bd->current_page =3D err;
 	}

 	ee1004_probe_temp_sensor(client);

 	mutex_unlock(&ee1004_bus_lock);

+	err =3D devm_add_action_or_reset(&client->dev, ee1004_cleanup_bus_data,
+				       i2c_get_clientdata(client));
+	if (err < 0)
+		return err;
+
 	ndev =3D devm_nvmem_register(&client->dev, &config);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
=2D-
2.39.2


