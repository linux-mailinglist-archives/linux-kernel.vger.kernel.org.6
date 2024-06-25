Return-Path: <linux-kernel+bounces-228372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8214915EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBEB283DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA41146015;
	Tue, 25 Jun 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="dscUMdYJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC9145FED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297319; cv=none; b=ix/H+hFzqPwG2IOFIU7FIljD5Kv3H97944HT366sRtepqEkVPESm4kJDQpC15cDg9tK6UQmEUd1s119yxZ70GWCJxfmcN2pp/v75/FrHKOUeCpZNkiME94mdklwxemVZ9IezguO50b2o+TFSEr6DG920H2Aw2vPKn5XwRSmCKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297319; c=relaxed/simple;
	bh=pCo8XIlw9Gd9qvjFrGaZ1lxsXsD9xew1R7axNzBukVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJytrFd5FRcIK9DMeV7yRg3URiz56zDkpyn7JJuZQhWDmKtyr7afqRmMxV4nQVOwXBScDoL+ER96eG+0qWfndHMtssLTJK18nBTQPJk5DacbNMIbWB8RzkYKHhZITK9yrmdyUNzfizwngj7F5kZgEFscDFtVzfFcR7jlHJWwLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=dscUMdYJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719297309; x=1719902109; i=w_armin@gmx.de;
	bh=WhufMxP7Ijq4qlmWwyf+Gifp5LR3u3L77rJHIX6mfqc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dscUMdYJot1rVI01J3Q7/wVr0NxjuD1C+NF5s0YFeWB2k8OTV0mS9K6qnQ/D76x5
	 9gcxIq4L3/b+gyyvOb3d4mGb6m7smg7Q3cB1Yso+ghcWns1h6JS0zNqBi6OE1elGU
	 339EmA8VopMSlxD+565Jnlrcjq4EUXwn36KUlUCEqozK014IF/FP6XHfGp9i9uXSt
	 m9bs3g10fmHWXfSZ5zRJMMVO8/q5lQn49ITDJ4P+/2fA4QwnEN1P9m2R8A41LLk2n
	 1kQaDLdCVsPohqNqCpJb4EkDHOcbLSCi6VRs16Yb0/PZu24P9wFYqmyzMt2SsRaQH
	 SKuLQ/FA4tN0OOyMUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mv31W-1sdfDB3BuS-016zAD; Tue, 25 Jun 2024 08:35:09 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: hkallweit1@gmail.com,
	u.kleine-koenig@pengutronix.de,
	srinivas.kandagatla@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] eeprom: ee1004: Add nvmem support
Date: Tue, 25 Jun 2024 08:34:59 +0200
Message-Id: <20240625063459.429953-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625063459.429953-1-W_Armin@gmx.de>
References: <20240625063459.429953-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EnL2eJS46vWOV07mo9qOC3y8GMF4IShL45SFnqImzBv0JWeKNw+
 jzAbRm5/uuGMKFZXqAbT9lxA3v2ZImKEhMDxmKfDxQUY0ZmhOK93DEvNQnKSflCKH2pjJ1i
 k3Oiw54IjHowmYIJTrrW0UgdXD2+nCZxemsnwQm9cZN5Lcdf1eUlDiSFs/iu0GkRw1fq4ll
 60S9SCcqnAv9bDdOt7B2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y/SgBsmhZew=;XCFS2uhy+20lRR625R/F8ObEcPS
 BhaByOtn+8x7uUiOb0dlslsL9pnZrfo3NfgAo5gINPKsSL+XQOAvhYAL7j7YOgne9kMAybswf
 pRa7R5kETdvSCHyOI2rJGABC0OemGcFYu0c8b1IzE5k6GGPmd8xY831hoIlQR7ZqXI3PWyejA
 zoYtQdgvtR5GzK8INe+BzE9PHKl19xjUUuO4TcAUkkootMLizMO1AMrsi25AZQw9goX9U7kAD
 XBksT8vBg79Nwa3YvdyZ7x7a8ops9YKNsR4uNGH1b5mfXfFfEJ2gCUUnKjjbFXgbO+6Lf3tj9
 /mBZekkzJ9+Sq9QDA3l9AKi02g+xNCUURc4rnykSbiyad5b2ETUmAbSpvvfiyVxZdzwiApZUT
 zXTYSf1rOtJ6mSNtTfqTyhhKs+E8QysR548DHFR/Ghfuv6pLzWhmJGUp6w6dzgz/ePslmoAoF
 KyRhiV9W97CS0aqrWO9j/+7JLFo5Z5VvrwnDfpF8StFWZ+BlvFcfQAqSoBp7HNS4oWhCZyaLV
 WYMF76GAhaCdaudhuTMTHDR++1RijV9azDSZG0z/c/rqM+MqCzv8Rnhsw0SgHy6jEGTJTw+85
 ktcmOkcOnE5+otBzfqYu4n4jPA4FY5eSJDoTaBN3Jkn0Va08uQrohebM3sY7J1vcKSkxf6ZXx
 QsJPBV4F4vxBwHXWirJUj/c7zcxMOMxnR1INVzhACKBk+dXOCRYub0zCirYoKA1+z9aZa8/ZU
 wBPgxNPqRRs4wC4q3pDlAgoPbhZ9y3nHhqFPFET0kGZJlp+fJ0d4gnAHym+WqzXrl0dL6NTMB
 UO25OwrHRmTNwedxCShdM38tcvT8t7i1tCNaTfO00hciU=

Currently the driver does not register a nvmem provider, which means
that userspace programs cannot access the ee1004 EEPROM through the
standard nvmem sysfs API.
Fix this by replacing the custom sysfs attribute with a standard nvmem
interface, which also takes care of backwards compatibility.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/misc/eeprom/Kconfig  |  2 ++
 drivers/misc/eeprom/ee1004.c | 58 +++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 4e61ac18cc96..9df12399bda3 100644
=2D-- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -109,6 +109,8 @@ config EEPROM_IDT_89HPESX
 config EEPROM_EE1004
 	tristate "SPD EEPROMs on DDR4 memory modules"
 	depends on I2C && SYSFS
+	select NVMEM
+	select NVMEM_SYSFS
 	help
 	  Enable this driver to get read support to SPD EEPROMs following
 	  the JEDEC EE1004 standard. These are typically found on DDR4
diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index b1f760cc3be0..2e69024380b6 100644
=2D-- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -16,6 +16,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nvmem-provider.h>

 /*
  * DDR4 memory modules use special EEPROMs following the Jedec EE1004
@@ -145,13 +146,17 @@ static ssize_t ee1004_eeprom_read(struct i2c_client =
*client, char *buf,
 	return i2c_smbus_read_i2c_block_data_or_emulated(client, offset, count, =
buf);
 }

-static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr,
-			   char *buf, loff_t off, size_t count)
+static int ee1004_read(void *priv, unsigned int off, void *val, size_t co=
unt)
 {
-	struct i2c_client *client =3D kobj_to_i2c_client(kobj);
-	size_t requested =3D count;
-	int ret =3D 0;
+	struct i2c_client *client =3D priv;
+	char *buf =3D val;
+	int ret;
+
+	if (unlikely(!count))
+		return count;
+
+	if (off + count > EE1004_EEPROM_SIZE)
+		return -EINVAL;

 	/*
 	 * Read data from chip, protecting against concurrent access to
@@ -161,28 +166,21 @@ static ssize_t eeprom_read(struct file *filp, struct=
 kobject *kobj,

 	while (count) {
 		ret =3D ee1004_eeprom_read(client, buf, off, count);
-		if (ret < 0)
-			goto out;
+		if (ret < 0) {
+			mutex_unlock(&ee1004_bus_lock);
+			return ret;
+		}

 		buf +=3D ret;
 		off +=3D ret;
 		count -=3D ret;
 	}
-out:
+
 	mutex_unlock(&ee1004_bus_lock);

-	return ret < 0 ? ret : requested;
+	return 0;
 }

-static BIN_ATTR_RO(eeprom, EE1004_EEPROM_SIZE);
-
-static struct bin_attribute *ee1004_attrs[] =3D {
-	&bin_attr_eeprom,
-	NULL
-};
-
-BIN_ATTRIBUTE_GROUPS(ee1004);
-
 static void ee1004_probe_temp_sensor(struct i2c_client *client)
 {
 	struct i2c_board_info info =3D { .type =3D "jc42" };
@@ -220,7 +218,24 @@ static void ee1004_cleanup_bus_data(void *data)

 static int ee1004_probe(struct i2c_client *client)
 {
+	struct nvmem_config config =3D {
+		.dev =3D &client->dev,
+		.name =3D dev_name(&client->dev),
+		.id =3D NVMEM_DEVID_NONE,
+		.owner =3D THIS_MODULE,
+		.type =3D NVMEM_TYPE_EEPROM,
+		.read_only =3D true,
+		.root_only =3D false,
+		.reg_read =3D ee1004_read,
+		.size =3D EE1004_EEPROM_SIZE,
+		.word_size =3D 1,
+		.stride =3D 1,
+		.priv =3D client,
+		.compat =3D true,
+		.base_dev =3D &client->dev,
+	};
 	struct ee1004_bus_data *bd;
+	struct nvmem_device *ndev;
 	int err, cnr =3D 0;

 	/* Make sure we can operate on this adapter */
@@ -272,6 +287,10 @@ static int ee1004_probe(struct i2c_client *client)

 	mutex_unlock(&ee1004_bus_lock);

+	ndev =3D devm_nvmem_register(&client->dev, &config);
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+
 	dev_info(&client->dev,
 		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
 		 EE1004_EEPROM_SIZE);
@@ -284,7 +303,6 @@ static int ee1004_probe(struct i2c_client *client)
 static struct i2c_driver ee1004_driver =3D {
 	.driver =3D {
 		.name =3D "ee1004",
-		.dev_groups =3D ee1004_groups,
 	},
 	.probe =3D ee1004_probe,
 	.id_table =3D ee1004_ids,
=2D-
2.39.2


