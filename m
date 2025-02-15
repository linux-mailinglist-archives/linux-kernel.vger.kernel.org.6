Return-Path: <linux-kernel+bounces-516108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB47A36D05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262393B1314
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7961ACED3;
	Sat, 15 Feb 2025 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHR6ABHZ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616D1A7262;
	Sat, 15 Feb 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612398; cv=none; b=Wx1QOapdqXMfMdQ1gNdopf84+7PtLTPDGjOS+GswkUtqPoXiE0uBcDZD6/xz2WtRb0JVFfv3paIemuxkFSPiDunyY9F9PBBi2AuOogF4SnNC9NVCIItWe7YyO3M2vbgNNO0/FpLN+qQYuq/6PVRrDBmOzp6BA4dqqbY4jN8ewJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612398; c=relaxed/simple;
	bh=nlN0yd6P8KVs8h7+hjut7O2QhOwizp6bOkkjTgZWqVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gydCxC4LYLUO88d7RatHSZhjj2AFLSHAMUbySYlu1ZHwkF6XLpSt0JUgDBnlT8w0B5EIlLFLaCTWvERsolybcYLUgrPhS53lGIKNje8hXANImKgGE+ZipHBwLOZY8UiU3Q9VM6maPMN5VGje3rzDCxhM3eSGsvbQ/jUppxjTdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHR6ABHZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so5081251a12.2;
        Sat, 15 Feb 2025 01:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612395; x=1740217195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSHi7ULc5hxohEMqjG29q4+9VaxsYsZCGB+mI9gBuBk=;
        b=hHR6ABHZtlB/kMyFUzb5pWsjTyK/LnmpbT1iW0FfjK6pm0mQrGQ3Cbv9+FRpcyccRl
         Qb1U+hJy02aNg+bCjt0P51MoTWhH6HZO9GUVxmJWbd4OBKyyY4LwtfPZ/kKIThBQIi8p
         JMxn9YMs8l8NuEUHR6qzx8r6zQCmJbQabVafz7AUk/ed6gBVc/UHtj/Byuxl4d8kOIe3
         Ue009Qh71A3N+zhE3wC3HTjBwJ4xN4kHIRtuEWlyv/XfTHPGiDJpEWx9kdQ2H6BwrfY0
         JILY+PzdiFqVcuDg7XypKyBgufJT9E1eFIzIiZljIsatX2523xMqWH7vxlHccjOwPy5q
         PSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612395; x=1740217195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSHi7ULc5hxohEMqjG29q4+9VaxsYsZCGB+mI9gBuBk=;
        b=Rwap6/PRykF7YNEGU1v0N1vPNhQI5Z3pepMgLo6hTNSPQek0SJY/plRDnI0F0iMggc
         to2bkA8e7b0WEmTM5iMNL0e0lMe2g4TMjHxjVG+2ePfc5kuWp7X+E0OAdtCvbrLMBpcj
         RhtLd2TOA1I8RGOfoYfYZwSbQaCoGyIpsAWx5ZxKewXMOt6RRCBqwEqjf7cJORZ05JV6
         7NlYI9HwPNIgFWTuVo3jR9Lao8xqJ9BA2pmOa7MbSuqNoQQJ8YMOFF2vFYfD8qqsuEZt
         0HJgMC6t8dMXUqmKw5MtE/6YWJ3iy3ovZtAtHY2VLiUNPTQtIwGmR3/pXHkzyGrhxipT
         mCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfIhPTSqRUtQD7NbzkaH4J6N7Z84rroiOrMwQkjDu36yeZXN0jSUFv+SVjz3TL4FZDSYmmRC5xwT+RRDhb@vger.kernel.org, AJvYcCXmK/qSL7Q3eNiXIaVUZ4i39JkWvUT8qKWvoYoa5i7ecWbbH5FcVq1dhWZ7C/6d62vq5d2EQ0HUgxUd@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJRqDtwB+fop8KiW22euuEdPYUQuhLAhnrcAoX0UV4uqGS1bs
	yOoRKVfpdPC+ik2d47qaHt9tYClFdoypQO8PYA5Efyvgr1Wkt/zA
X-Gm-Gg: ASbGncvAspYcchbLg69So0Otjyx9ZVEe7jttiJmg3qqoQzyDTG65574vq5bP/Du7utQ
	nkQmn3bW51ynVZv5A0eS/ixMxpZ/310vuAWolVe+Ow9DFymZopdHEGox1o3W94eE0RtiAXZMrWs
	BoCdvpu0wtDW1kzT/pHKf1HIxAbrM++iHU4Wi3BGD0DE//CXuQmt2NEHNYPACgKGsbaHhIUQyWZ
	KlPbwYvpX3JPHDqkPm2OGYs4lWU3W8g5kRCKkXEFRIBJ/wg7SsGScuzc0PTZPcFkq97Ro5MMYK6
	2N5R+nthl+MJDNBGVrem8WJO7vy9OWr6JprCvF0qVGN1rFrGP11plpN/UcayFA==
X-Google-Smtp-Source: AGHT+IFyrQImPdhkXlUK0i/cJqlYoCjV9CaIt4H7aNflilngOsNxjxgQcObmRoJ4y7oOeBbOZ2j07Q==
X-Received: by 2002:a17:906:31c4:b0:aba:ec4f:fa4 with SMTP id a640c23a62f3a-abb709211d6mr184760766b.12.1739612394478;
        Sat, 15 Feb 2025 01:39:54 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:54 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:40 +0100
Subject: [PATCH v4 5/9] mfd: bcm590xx: Add PMU ID/revision parsing function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-5-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=4714;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=nlN0yd6P8KVs8h7+hjut7O2QhOwizp6bOkkjTgZWqVw=;
 b=eI1XUZ6UU3sJHiIe+4reovvtp9PCU4kUBpXdOFbfjRTbDlf4dwaNAVSHIPANqcHmVS9JM1Sc9
 Hcq9GfqkhqiC+w7ntxFjoeEhjZSq4/Phktgl4aHVA4JF36mJjIs1Nwa
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM590xx PMUs have two I2C registers for reading the PMU ID
and revision. The revision is useful for subdevice drivers, since
different revisions may have slight differences in behavior.

Add a function to parse the data contained in the ID/revision
registers. Use the ID value to verify that the correct compatible is
used; store the revision value as two separate variables, rev_dig
and rev_ana, for later usage.

Also add some known revision values to bcm590xx.h, for convenience
when writing subdevice drivers.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Added this commit
---
 drivers/mfd/bcm590xx.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bcm590xx.h | 14 ++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 632eb57d0d9e9f20f801fac22eae21b3c46cefd5..094186165efa5a2356a442efdfb4da02ad9be9da 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -17,6 +17,17 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+/* Under primary I2C address: */
+#define BCM590XX_PMUID			0x1e
+#define BCM590XX_PMUID_BCM59054		0x54
+#define BCM590XX_PMUID_BCM59056		0x56
+
+#define BCM590XX_PMUREV			0x1f
+#define BCM590XX_PMUREV_DIG_MASK	0xF
+#define BCM590XX_PMUREV_DIG_SHIFT	0
+#define BCM590XX_PMUREV_ANA_MASK	0xF0
+#define BCM590XX_PMUREV_ANA_SHIFT	4
+
 static const struct mfd_cell bcm590xx_devs[] = {
 	{
 		.name = "bcm590xx-vregs",
@@ -37,6 +48,72 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+/* Map device_type enum value to model name string */
+static const char * const bcm590xx_names[BCM590XX_TYPE_MAX] = {
+	[BCM59054_TYPE] = "BCM59054",
+	[BCM59056_TYPE] = "BCM59056",
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
+	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_PMUID, &id);
+	if (ret) {
+		dev_err(bcm590xx->dev, "failed to read PMU ID: %d\n", ret);
+		return ret;
+	}
+
+	switch (bcm590xx->dev_type) {
+	case BCM59054_TYPE:
+		if (id != BCM590XX_PMUID_BCM59054) {
+			dev_err(bcm590xx->dev,
+				"Incorrect ID for BCM59054: expected %x, got %x. Check your DT compatible.\n",
+				BCM590XX_PMUID_BCM59054, id);
+			return -EINVAL;
+		}
+		break;
+	case BCM59056_TYPE:
+		if (id != BCM590XX_PMUID_BCM59056) {
+			dev_err(bcm590xx->dev,
+				"Incorrect ID for BCM59056: expected %x, got %x. Check your DT compatible.\n",
+				BCM590XX_PMUID_BCM59056, id);
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(bcm590xx->dev,
+			"Unknown device type, this is a driver bug!\n");
+		return -EINVAL;
+	}
+
+	/* Get PMU revision and store it in the info struct */
+	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_PMUREV, &rev);
+	if (ret) {
+		dev_err(bcm590xx->dev, "failed to read PMU revision: %d\n",
+			ret);
+		return ret;
+	}
+
+	bcm590xx->rev_dig = (rev & BCM590XX_PMUREV_DIG_MASK)
+				 >> BCM590XX_PMUREV_DIG_SHIFT;
+
+	bcm590xx->rev_ana = (rev & BCM590XX_PMUREV_ANA_MASK)
+				 >> BCM590XX_PMUREV_ANA_SHIFT;
+
+	dev_info(bcm590xx->dev, "PMU ID 0x%x (%s), revision: dig %d ana %d",
+		 id, bcm590xx_names[bcm590xx->dev_type],
+		 bcm590xx->rev_dig, bcm590xx->rev_ana);
+
+	return 0;
+}
+
 static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 {
 	struct bcm590xx *bcm590xx;
@@ -78,6 +155,10 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
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
index 83e62b5a6c45805bc2acc88ccc7119d86f9ac424..ba1cb3716b383d7a2ee396e0595a3b94d3b4ca5e 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -32,6 +32,20 @@ struct bcm590xx {
 	struct regmap *regmap_pri;
 	struct regmap *regmap_sec;
 	unsigned int id;
+
+	/* Chip revision, read from PMUREV reg */
+	u8 rev_dig;
+	u8 rev_ana;
 };
 
+/* Known chip revision IDs */
+#define BCM59054_REV_DIG_A1		1
+#define BCM59054_REV_ANA_A1		2
+
+#define BCM59056_REV_DIG_A0		1
+#define BCM59056_REV_ANA_A0		1
+
+#define BCM59056_REV_DIG_B0		2
+#define BCM59056_REV_ANA_B0		2
+
 #endif /*  __LINUX_MFD_BCM590XX_H */

-- 
2.48.1


