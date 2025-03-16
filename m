Return-Path: <linux-kernel+bounces-563097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E3A636F4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66727188EBFA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB91FC7D4;
	Sun, 16 Mar 2025 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii4odJ/9"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90F1F76C0;
	Sun, 16 Mar 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149169; cv=none; b=OHC6D6D0/BUtl2LzqEBpvjoZ8KVushapq9A1qkRqj/d/MgWr1iGXwotXtj3uuNjRXVS5vByyook0PsdP0p2op7sfeY0iCtlc1PvogMEoOGvi2mPyu2Kb8LOw+gCh2kff7nEn+T7aSSmLnuv8gibzMXi54fVXvd+8Nm7tyVudEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149169; c=relaxed/simple;
	bh=v7kmhFS4/FCZzYhNN4jZO2ljmvejdJbM30D2qESzPQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/rrJSPnekp2veJIkn+Zjuu95WkzOJLH+yLwKofM1URXimaWhG1w9YwQBbup5EvAHe/3y9laIh3SmM781pvwqML7JMv83mUlcSgmbDphZgYaS7+ZgbONwZXw/LM8i8zlJhXdzMX+LxUtkiXU1mCdgL88ql5eP3fXJ3yNGoqy+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii4odJ/9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so631346366b.2;
        Sun, 16 Mar 2025 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149166; x=1742753966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2WGpLSZw0pQ2JyUw8cq5eE/wZXTd4ilCeNkW1xDF4Y=;
        b=ii4odJ/9D76MelOkktEEgmBezrUA4aj3f3DgdHvHLvsYMUbD6SI+j60HWFdkFnPJIB
         JHBtDnDS1OpKPOqWtgTnQnlIOYM9HusFSqerIyiEsF7G/Cvq+SQ0sFA0Nyq9W67i/xwT
         GSsFfPpfheNX/QdQnbkYpKTARczD0flbhMht/JLedQRCv5wWCGMfIG4PgqqlqM3HJVEV
         7yopbopemSnk65w2alVS9WENIfbClld1qauNSrO/tZNMiqfZ1hPPNizHnOLwcdHCr37a
         NZTTEGsSwQfXyuM+K/LfjsB4ZzqWCjhtYVJ0DMkRbr+HUEFOE4uXhE/mx13MoBZ9hFLU
         GVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149166; x=1742753966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2WGpLSZw0pQ2JyUw8cq5eE/wZXTd4ilCeNkW1xDF4Y=;
        b=dsa+I47bhuqDvUtUiXkS+nx2vKjuOVBbyzsJZYAVoJkNkijB9sSCr54vv2naMqh2g2
         hQENWJMqPn48R1iHJZrTdNjj8RXZ0ECSfehaRx1XFkwH7uQvS6m/tH8DX7slPLFVVit5
         BeF6lR0FAP7QCyJRn7GotrxdR9ssYoXTv8WKjTN/3FS4LFj56LPwA/7lSaco31SK1Qq6
         2tiTFLq3IKwau4YuraqGhJUMu//+62nd/nFiSObgyGGR5dlAYuP7oqjDvsPXbsIx3Pgb
         ibpZg8NEIw9KOsF1UlXtokqGQwT+/TAoueNlWJMxumx4dUVvl0kCgvmOOr1XMsGGSrwZ
         qzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNPBaFxQVh6S7wfd1Hp7Mx3PyTg+4HjfX15mBxiIBPZY340KonJu2nUYxt9pKMdD1FmG84RN1n/cCVHLRD@vger.kernel.org, AJvYcCXiHlluAHJ5YJ0kjx1c3b5DM09s7dZ4kNbmlZ+7fcXW8GGX4/jx4Kn/4hVVDedp0SFIGWP+si/Ne8Wr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yBz1j5kE0SSarlndi7PQ2LnzqfQ4Y48ttO6hu0JlwnBVMMaJ
	3R4VFm86MUTh6FZmqWWXdxVX+an2mmTJh/fvhn7fKu9phuL3pqi+
X-Gm-Gg: ASbGnctPLalU7VxU/KfcEyMPsazS1FxO+heQ2l8QidC3rDGXpOkkxKb0Nb92N0mY+wn
	tm/OWIDvNyNiamyoej70GeKbIJGtbj04nzd60hJFnZhZ8WQAMZAVZVPpCm2WCYLy570Gt4XIR/Y
	Vd19u/URonCVSrjv3txOAa8F5/LwaLggwOrGa80CAxPbaClZ/QTlQgW74bPQDPT9pur0YVJ/dj4
	M0HYvg9+Gpx2xF3bar/OaxAfbVR+FfIOPySghlcH+2ZgsHOWmBCk/cIRZasd6R+KNnhS61k8XRx
	EhtZ6Zy3gLBGJcT/ExLxTFWHX40MITSrmTLHEv8VXdzC/VR81HT4LMdIpASz2TL42qMBSB8A8qf
	j4ygCL3bqciKdRm5eRQ==
X-Google-Smtp-Source: AGHT+IGXOWQRDAcYMd/Exc8yvwI1iOo50BCvMmRGoY19tx/OzEDExs7J9Jn98aan+JZt52qJvtFkHg==
X-Received: by 2002:a17:906:4795:b0:abf:78ff:e26a with SMTP id a640c23a62f3a-ac3303f76c3mr950349766b.35.1742149165906;
        Sun, 16 Mar 2025 11:19:25 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:24 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:54 +0100
Subject: [PATCH v7 06/10] mfd: bcm590xx: Add PMU ID/revision parsing
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-6-4281126be1b8@gmail.com>
References: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
In-Reply-To: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=4816;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=v7kmhFS4/FCZzYhNN4jZO2ljmvejdJbM30D2qESzPQQ=;
 b=kpXrClBmSYX3k1C5REpTgl5jPoh4zXLAQG26nF1819if64hNZGWA3wSHsZe41WMoHOycIlE2d
 DESPqq4/UARCSY2ttuRfnQ9tHHMH2xv2GhtDQlym1/DgAO+6eZ5nmcB
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM590xx PMUs have two I2C registers for reading the PMU ID
and revision. The revision is useful for subdevice drivers, since
different revisions may have slight differences in behavior (for
example - BCM59054 has different regulator configurations for
revision A0 and A1).

Check the PMU ID register and make sure it matches the DT compatible.
Fetch the digital and analog revision from the PMUREV register
so that it can be used in subdevice drivers.

Also add some known revision values to bcm590xx.h, for convenience
when writing subdevice drivers.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v7:
- Return -ENODEV on PMU ID mismatch
- Drop "Check your DT compatible" from ID mismatch error message

Changes in v6:
- Adapt to PMUID being passed as device type value
- Rename rev_dig and rev_ana to rev_digital and rev_analog
- Rewrite commit message

Changes in v5:
- Add REG_ prefix to register offset constant names

Changes in v4:
- Added this commit
---
 drivers/mfd/bcm590xx.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bcm590xx.h | 14 ++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 4620eed0066fbf1dd691a2e392e967747b4d125b..140107263599777b30cce4cfc0f86a9278907d34 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -17,6 +17,15 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+/* Under primary I2C address: */
+#define BCM590XX_REG_PMUID		0x1e
+
+#define BCM590XX_REG_PMUREV		0x1f
+#define BCM590XX_PMUREV_DIG_MASK	0xF
+#define BCM590XX_PMUREV_DIG_SHIFT	0
+#define BCM590XX_PMUREV_ANA_MASK	0xF0
+#define BCM590XX_PMUREV_ANA_SHIFT	4
+
 static const struct mfd_cell bcm590xx_devs[] = {
 	{
 		.name = "bcm590xx-vregs",
@@ -37,6 +46,56 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+/* Map PMU ID value to model name string */
+static const char * const bcm590xx_names[] = {
+	[BCM590XX_PMUID_BCM59054] = "BCM59054",
+	[BCM590XX_PMUID_BCM59056] = "BCM59056",
+};
+
+/*
+ * Parse the version from version registers and make sure it matches
+ * the device type passed to the compatible.
+ */
+static int bcm590xx_parse_version(struct bcm590xx *bcm590xx)
+{
+	unsigned int id, rev;
+	int ret;
+
+	/* Get PMU ID and verify that it matches compatible */
+	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUID, &id);
+	if (ret) {
+		dev_err(bcm590xx->dev, "failed to read PMU ID: %d\n", ret);
+		return ret;
+	}
+
+	if (id != bcm590xx->pmu_id) {
+		dev_err(bcm590xx->dev,
+			"Incorrect ID for %s: expected %x, got %x.\n",
+			bcm590xx_names[bcm590xx->pmu_id], bcm590xx->pmu_id, id);
+		return -ENODEV;
+	}
+
+	/* Get PMU revision and store it in the info struct */
+	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUREV, &rev);
+	if (ret) {
+		dev_err(bcm590xx->dev, "failed to read PMU revision: %d\n",
+			ret);
+		return ret;
+	}
+
+	bcm590xx->rev_digital = (rev & BCM590XX_PMUREV_DIG_MASK)
+				     >> BCM590XX_PMUREV_DIG_SHIFT;
+
+	bcm590xx->rev_analog = (rev & BCM590XX_PMUREV_ANA_MASK)
+				    >> BCM590XX_PMUREV_ANA_SHIFT;
+
+	dev_info(bcm590xx->dev, "PMU ID 0x%x (%s), revision: digital %d, analog %d",
+		 id, bcm590xx_names[id],
+		 bcm590xx->rev_digital, bcm590xx->rev_analog);
+
+	return 0;
+}
+
 static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 {
 	struct bcm590xx *bcm590xx;
@@ -78,6 +137,10 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 		goto err;
 	}
 
+	ret = bcm590xx_parse_version(bcm590xx);
+	if (ret)
+		goto err;
+
 	ret = devm_mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
 				   ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
 	if (ret < 0) {
diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index 8d146e3b102a7dbce6f4dbab9f8ae5a9c4e68c0e..fbc458e94bef923ca1b69afe2cac944adf6fedf8 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -17,6 +17,16 @@
 #define BCM590XX_PMUID_BCM59054		0x54
 #define BCM590XX_PMUID_BCM59056		0x56
 
+/* Known chip revision IDs */
+#define BCM59054_REV_DIGITAL_A1		1
+#define BCM59054_REV_ANALOG_A1		2
+
+#define BCM59056_REV_DIGITAL_A0		1
+#define BCM59056_REV_ANALOG_A0		1
+
+#define BCM59056_REV_DIGITAL_B0		2
+#define BCM59056_REV_ANALOG_B0		2
+
 /* max register address */
 #define BCM590XX_MAX_REGISTER_PRI	0xe7
 #define BCM590XX_MAX_REGISTER_SEC	0xf0
@@ -30,6 +40,10 @@ struct bcm590xx {
 
 	/* PMU ID value; also used as device type */
 	u8 pmu_id;
+
+	/* Chip revision, read from PMUREV reg */
+	u8 rev_digital;
+	u8 rev_analog;
 };
 
 #endif /*  __LINUX_MFD_BCM590XX_H */

-- 
2.48.1


