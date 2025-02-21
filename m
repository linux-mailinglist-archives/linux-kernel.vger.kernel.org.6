Return-Path: <linux-kernel+bounces-526582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2AA40091
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D483A9FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6D254B16;
	Fri, 21 Feb 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxpFx7LB"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A0254AE5;
	Fri, 21 Feb 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169006; cv=none; b=QSAUiA/gj9VMcDTGQAIohWyI5vLhxGNu4PphYyJd3WavGogZXqHTWutFgQYsIcGIu/LfoVTr1wE0zFw73edxb3u8CLvEjq/BZxTTZrLqx7sDQFsf0TrsSSg5YpToaHc/AAHQzZ+rJyblBebDQZl/3m7hBhlUlb0zLghyI4rL8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169006; c=relaxed/simple;
	bh=lQpDyLwD1v0ICLejI1CnQE4idFDW19bqjeBaJhBeGzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mh/xpzXMssYlOPNiIJBJHfFD95otncLKjYMp8DubAAc9poANbpKmbhWZOiHTO6Q8X/+ZfhePDk8ppsytI5eMN2ylXoajr/msZtAOtahetL1wcUm4gggkSXUhbh+va9Qk3tq8YD/KDBNLPmlz31ng+xTPYj0r2z/xvDs7Jqk9IH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxpFx7LB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so4825468a12.0;
        Fri, 21 Feb 2025 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169002; x=1740773802; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wjZ5pN/HhmFRAahEKqBfrFaTj2GU3BUMT0DWllxLuo=;
        b=PxpFx7LBmIuDicxPYhgqrlkitiDzxJCboTvdGKIuBDdAktiKBhbeiia1LAYc0u0Hbd
         ecc2ZAC6Kz2GLMZszVWyYn2zpNwz+hboSIYP0MnhRs6ASufxIka7uKHi5H96Re9ZRsc5
         EjDJclgoCKnYcFGCMHM3F0vx9UQWMdk0BDGL3xJ8cXlQxSFpLdvQKZbbuIcc+1UuC07m
         yZ0JTaoZoqLRmHNnTh3xM8QjSXfKyA4BCs8pmxluxmvnsPCTwU5SvIkhg7FBVWL+z6tz
         3dVsN2ekxS7HGYVMU1oNeiIpKH6aMB3d9GbAYB2sfrVwXzQlQw8xwh4LxYVkDG11m+Ba
         eCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169002; x=1740773802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wjZ5pN/HhmFRAahEKqBfrFaTj2GU3BUMT0DWllxLuo=;
        b=ossGVezu99ddjCilFVdvyoQ1RSLLVD5rHfleVFLAW59xAWvSBD0WmhJJbxVwrDr225
         mlDKvCs6es9oK/hLuos/PEteImkDm+dtlT0mj9aFnvGtetwe7h1NaXMXYe0cCGpeW/nm
         LCSjCRbDNqyBxoEZ+3LUdPR5gowCb8e0ku5DhaLoWds6ftM/q001B7dKdB61sf95KvuM
         3e2Qb8w/xa4O/09E99SfDsvjQ7X0Im2NVMpt8UT5mOwWEG81/FdBe79yh1rLGCdjmJt0
         bU7sJ/5odxLckS/RDE6oQPQ+StPPa56usqm3ftyjZKBeSCDUd127EhJazf16QwScVGWU
         p/pA==
X-Forwarded-Encrypted: i=1; AJvYcCUrMGyRFhLXzfzrASBdNnkgmnpwf0yen17G+p/AAY1uzZRoqCrgsL8o2FSJ+EHVlDNeybi0C7FdRdKy9mm6@vger.kernel.org, AJvYcCXfJQXWL/fcg/nyHFz9za4OjMLu+HzYtRd5C6FIPw3ktfMLl0q/3m4TxS3jsGtRRbtuPFZ8hEHk8MDC@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrG7Dq9MfKxLmWhxl8g1cV43vTAAAupUPEdzE9FrDxItZARiD
	BeDJC0ioiWHXAc876mQJHhfqwgUnC11AWrbu/+6BXMpVAESOWxHK
X-Gm-Gg: ASbGncslNNUGk2518mV4LBfVKXY5mVY7x+ggh/ZKCCWdHcky8SviiWyByb73S9n8vpS
	IKkfVy4qVDsYVbt+7v6oiV0bzm/UxMtmlz/PZLqqExU45KOyoi4OCuHMlfPrH68YIr1Z6Kbt8tJ
	PCHSDYNI6MZnF2ignlOcbWlln2hYtcYPEW78qJmyyhyKXjf3dnaPREqt14TZCyq2OBOMbWXXfat
	kARHeBXrnilB8peNf+aCquL7LJjtQbI2Cj+DBy70G54RcwjhAZkkwlVCRCYA3ukBqQUAVNu+7a5
	hqnKs+RHl6iU7fMpnnYc9X09RUGskkgGdVs8E4IwCuMAuIYx5CJtW+kF9ze8kecjaMUrfkkz
X-Google-Smtp-Source: AGHT+IFQavg/u6GXqPap5byMtJIE7uLPNliZ4KpjB8rQy5CAoh4E7eCI9gi7pYRF4U8U+uVjMMHpWw==
X-Received: by 2002:a05:6402:2691:b0:5e0:3f83:92ab with SMTP id 4fb4d7f45d1cf-5e0b7246c97mr4719984a12.30.1740169001697;
        Fri, 21 Feb 2025 12:16:41 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:41 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:27 +0100
Subject: [PATCH v5 5/9] mfd: bcm590xx: Add PMU ID/revision parsing function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-5-065f516a9042@gmail.com>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
In-Reply-To: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=4799;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=lQpDyLwD1v0ICLejI1CnQE4idFDW19bqjeBaJhBeGzw=;
 b=tA22jfFcQLrM8fzLcUdryGdYMiFXvQ/0EmyyKnCeciO3hD90+oZWx7ILF/h+/+egt+bDeGWV8
 elHjquag3IrBKCmMQpvFdwbqoEbbwYH1zzba+NxcuZ7LItYq/+tuQGc
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
Changes in v5:
- Add REG_ prefix to register offset constant names

Changes in v4:
- Added this commit
---
 drivers/mfd/bcm590xx.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bcm590xx.h | 14 ++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 632eb57d0d9e9f20f801fac22eae21b3c46cefd5..6e53cf3dbf54636faab635634a31e9e36827cece 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -17,6 +17,17 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+/* Under primary I2C address: */
+#define BCM590XX_REG_PMUID		0x1e
+#define BCM590XX_PMUID_BCM59054		0x54
+#define BCM590XX_PMUID_BCM59056		0x56
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
+	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUID, &id);
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
+	ret = regmap_read(bcm590xx->regmap_pri, BCM590XX_REG_PMUREV, &rev);
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


