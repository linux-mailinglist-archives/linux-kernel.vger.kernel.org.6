Return-Path: <linux-kernel+bounces-173864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E88C06A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5941C21377
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342C7D3FB;
	Wed,  8 May 2024 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="NUKjhBDJ"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16154132C17
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205312; cv=none; b=AVfUNWuPZDzf8+MBP89CUMQPR2r+JKA8bOzREc3XrSPZwtJcvA3nPApJO7bnBhRKWn2wDndtDrHAat/bgJPnnMWVZ9jPGrQgMjdcHz9yH4jfGsK/e2OC3BJBeq00LdfJqBmg6wpOXUys7i2vr5iV4gJGYoy/zFCuoPyknM3QDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205312; c=relaxed/simple;
	bh=oGiPE84HXus0gRyXfZVlq0FWkliZmfwCxTxKKS6WXpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPpYDGx57H4amc/+0Y0CQEmnjxuz/BJ4j5A6eMcUBon1sjSjD9KiF6qLGg/d4iABTn0i9FPxzuR2aBTJ1Dsb2Pp1SHuVaKZqD75FaawyorAK5D1+ZRKvnlaPERIxZiDFSewEU430mXNwu5JWv2O7sqb64iqai5ckkOKb4RbY7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=NUKjhBDJ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9897E2C031D;
	Thu,  9 May 2024 09:55:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1715205306;
	bh=6Ya6psyiZkVjd6vCOoXRQko98JcBDuKqMbbXBChzB9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUKjhBDJNR90QLnpmhCdECEq+ZQcSKnjVBKtbTpPQmGHKz5ZIEcn0mRMBsfox9xH+
	 43VZqF8W+P2Rw70pV76QGE3s1LK3+iWlvrhxTDMJxgdveDKRzsTOIQTJX8a/kH0Ygj
	 flAhq7Sd/3AUnaHXgSs5biAq48/FMLMdnuxE7lFDut/Yz56bD+xeYKBOXLLgNClfi8
	 IL70Np0pNf9OLXraZBdBj6dOepMSaI2dZSvVu9OTtjR6TFdIe3mHXEBzdIXQF8NlSA
	 oULm9ecnsbPZLESEPBr7mfgj1+mZj0kBvwtHyLEQdOPslR2V7siq+4Dw3AH60DO/W7
	 Vru6m8pAspXWg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B663bf4ba0002>; Thu, 09 May 2024 09:55:06 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 53B3B13EDD7;
	Thu,  9 May 2024 09:55:06 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 4D76F28042A; Thu,  9 May 2024 09:55:06 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] hwmon: (adt7475) Add support for configuring initial PWM duty cycle
Date: Thu,  9 May 2024 09:55:04 +1200
Message-ID: <20240508215504.300580-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=MfrPuI/f c=1 sm=1 tr=0 ts=663bf4ba a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=62ePmnuN2cZSMFv3--EA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

By default the PWM duty cycle in hardware is 100%. On some systems this
can cause unwanted fan noise. Add the ability to take an initial PWM
duty cycle and frequency via device properties.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Use correct device property string for frequency
    - Allow -EINVAL and only warn on error
    - Use a frequency of 0 to indicate that the hardware should be left a=
s-is

 drivers/hwmon/adt7475.c | 58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb30483..14bd618488f8 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1662,6 +1662,56 @@ static int adt7475_set_pwm_polarity(struct i2c_cli=
ent *client)
 	return 0;
 }
=20
+static int adt7475_set_pwm_initial_freq(struct i2c_client *client)
+{
+	int ret, out, i;
+	u32 freqs[ADT7475_PWM_COUNT];
+	int data;
+
+	ret =3D device_property_read_u32_array(&client->dev,
+					     "adi,pwm-initial-frequency", freqs,
+					     ARRAY_SIZE(freqs));
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < ADT7475_PWM_COUNT; i++) {
+		if (!freqs[i])
+			continue;
+		out =3D find_closest(freqs[i], pwmfreq_table, ARRAY_SIZE(pwmfreq_table=
));
+		data =3D adt7475_read(TEMP_TRANGE_REG(i));
+		if (data < 0)
+			return data;
+		data &=3D ~0xf;
+		data |=3D out;
+
+		ret =3D i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(i), data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int adt7475_set_pwm_initial_duty(struct i2c_client *client)
+{
+	int ret, i;
+	u32 dutys[ADT7475_PWM_COUNT];
+
+	ret =3D device_property_read_u32_array(&client->dev,
+					     "adi,pwm-initial-duty-cycle", dutys,
+					     ARRAY_SIZE(dutys));
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < ADT7475_PWM_COUNT; i++) {
+		ret =3D i2c_smbus_write_byte_data(client, PWM_MAX_REG(i), dutys[i] & 0=
xff);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client)
 {
 	enum chips chip;
@@ -1778,6 +1828,14 @@ static int adt7475_probe(struct i2c_client *client=
)
 	if (ret && ret !=3D -EINVAL)
 		dev_warn(&client->dev, "Error configuring pwm polarity\n");
=20
+	ret =3D adt7475_set_pwm_initial_freq(client);
+	if (ret && ret !=3D -EINVAL)
+		dev_warn(&client->dev, "Error configuring pwm frequency\n");
+
+	ret =3D adt7475_set_pwm_initial_duty(client);
+	if (ret && ret !=3D -EINVAL)
+		dev_warn(&client->dev, "Error configuring pwm duty cycle\n");
+
 	/* Start monitoring */
 	switch (chip) {
 	case adt7475:
--=20
2.43.2


