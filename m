Return-Path: <linux-kernel+bounces-543277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F83A4D3BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C3F17062C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD301F8BAF;
	Tue,  4 Mar 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al9gQmkC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0921F791A;
	Tue,  4 Mar 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069260; cv=none; b=k0bHgvk8VUhbrN27Goq+MQ273lxBZO38MfP9EjHWZtKUTzTNFKb8M6NebyiERbPHr8tqzhU97RoTUUVGWNwLvSV6iO9fqWYp7L1uYth/+Q9mCylCZ1vVJLx1RjzS9B/1OK1hr5gTy7r883F3Rqjfo+5MFDIn8PX0BJxD+MMmE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069260; c=relaxed/simple;
	bh=u2OGhrqZxmDfJ/Q5M7YBVcOptPGc01YX0lvDGgoCLbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0gl3eU+f6VkhaEAuQ9bt5IWyyQRoe4Df1hwvx03hA7Z2HeIaY5Gjk1M72+eqBYNBPhhgHMTER9l4pa3AOWRPSe3oZ6vrHSqQFTIuOZnolVJtlcby2u0WxnezfBE4tidkHGJGGWyANmwbC4frpnf5gwwbmcEEeTv0fSbdHQqtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al9gQmkC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e50de0b5easo3978847a12.3;
        Mon, 03 Mar 2025 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069257; x=1741674057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL9fSfmC2gbi7TmBso7gC929m7SW/ZuTWklgZizzx0g=;
        b=Al9gQmkCBRHOJHzoPVktG3MAKWN0wWAsoFlCxYbizTwBioJigz0H6H3OwsxsFiPki3
         iJSfuLEhcPRwSQoDZWZKfVoZe9vl10UCtOhMcmvYmw17HcfIPGQMqkfNyKzICHKYyrrL
         Aeh00t9xrhuh1AVg9ypZa+38tbV3dxkO0kS0ryF0HzWbcxa3lJxPtrPo/+Xb5rTaSfs2
         rFVTOXBZ8pHY5f+K7Oat0En7wZslhl8ZMjHnNgoQIx5DxeyzEnhtPiJvgcFpv9lx7rEg
         gciSUmA4LUpK59zI/Qe4eGzpbWmW2DxbUfpmHiPSpdExcKjlmhx15PvtiRDo4sMjCeFJ
         o2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069257; x=1741674057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL9fSfmC2gbi7TmBso7gC929m7SW/ZuTWklgZizzx0g=;
        b=vvUv+6nvU0AkS933bDXjs2Uloq4/frHaY8t1J5ZMvgg1ubtS9aQphJhD1U7fXz3NhV
         UqjBKQKKQKfUfhhtVfhp5xMDV6AEnxo7jzii45ZHjZpvHGA4U89FOimUiOAHgD0sQu85
         3CxkpHzX43/O7xB8IITuvpQb6aCd0XtcgXP0Fd61ppP+EcbeQdmGEFeR7PX3d7RNLG0N
         DuEsjKkJJb/Pw4PHHAV+DObX6K6qlNUNgDodYJkaqnH41TVj28AkoxueA6UodABdGsqA
         89n/8ABQBvd5VlQlr926UsEV8d/z8Xck978Ev7ahRthrTFdvsDC2UP8exw5NWlrvfVdr
         7isQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNAflF17KVqDnvwBOyJYczuLKaeaU/Lm2fKSt19w7F0n2d3ka3sv3TAOSs+IDZgUi76712U97IWGP0@vger.kernel.org, AJvYcCWtquR6IxR296kXlMCzCc3coBaum7deoQeGLfefPWzmUAfdp5m0Y8wUASKyCIJ5Db48McZNYQzRYLURpYP5@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSH88JAVV9lUVxjARMaRA6/iwSRvYE4FXqhRyoGfdBxwcWOQF
	GqRJMkFRcDWFdWNdyxLeZcLHdYBZMt5HLSEdz2RCmewf1aq/zZ8Z
X-Gm-Gg: ASbGnct91EA2AzC9tni13YBlWJyU4v5/BAWdNqFXSpdck/BxFKmO6OBqZ5XTlGw/iyJ
	I05YlWDi3zPsUkhivStUEAQj41vrlYTVs9+vfePpszX//qAm+Qkw/5frTmw4BuOZtw+2lwJRJbM
	9ePQEpaeVooSX5M/KwqMUEO6A1mEQIrlpV4w9V8bN9WXdc2ZDLhBG4hsa9Xq81GHg7MK+Z1tND1
	D1sM/fgIMiEUCy2H23LYsxxunDoi+gewucgxjyS/KAkNLNb29bBAUuPRtDLoUD1GGqxYT6xp8xs
	kf90XQ0vGZJ7fYQm49wOTvGQwsGbB/tlBMIeZKJ7Gu29lYbXcj+Ith+hTX96oYzNP1gVcfFt30g
	bG5bWh60XdX3XA+8=
X-Google-Smtp-Source: AGHT+IGr724KnADcpi2c0dEd0U5JQgIx/eSdo96OsezNvU5yhQMIVFjmhqBBbY3PVbG19j56JbNieQ==
X-Received: by 2002:a05:6402:40c3:b0:5de:a6a8:5ecc with SMTP id 4fb4d7f45d1cf-5e4d6ad3ac5mr14666247a12.5.1741069256942;
        Mon, 03 Mar 2025 22:20:56 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:56 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:37 +0100
Subject: [PATCH v6 06/10] mfd: bcm590xx: Add PMU ID/revision parsing
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-6-ae8302358443@gmail.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
In-Reply-To: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069240; l=4721;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=u2OGhrqZxmDfJ/Q5M7YBVcOptPGc01YX0lvDGgoCLbY=;
 b=nry7wpU4lE1lnu3TQE5uHgkm6KR75IOT9KmCfV6SIJvym1wPCX7c5qmGhVp+bHI2OrXfxc7aj
 ROV991riQRfD8yXs89HXKcxvU5njEY44Fscp7CBVbKxP/odQLHf/adk
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
index 4620eed0066fbf1dd691a2e392e967747b4d125b..74dc4ae5ecd5db7fadc56918f63110c1265d4a76 100644
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
+			"Incorrect ID for %s: expected %x, got %x. Check your DT compatible.\n",
+			bcm590xx_names[bcm590xx->pmu_id], bcm590xx->pmu_id, id);
+		return -EINVAL;
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


