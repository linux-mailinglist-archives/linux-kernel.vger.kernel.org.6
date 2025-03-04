Return-Path: <linux-kernel+bounces-543276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC22A4D3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7720118980B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DF1F666B;
	Tue,  4 Mar 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKmpZIA1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C81F76C6;
	Tue,  4 Mar 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069257; cv=none; b=dA2ncK2G7LBtdE7H0rkM+G2F90ygysDOoFWjI2dSFnBbME1HFCAzOCIVi4iq4niBJKiIx7TblehiRZZx8OiqFxk0ojb5RVrt4ADEyR4IbjRWF9EhDvAmXF5tmLBjwkfWCJFBfNv9i0388Clv+wsP9iVPlEBVsuVe7mtkzRPTfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069257; c=relaxed/simple;
	bh=Vau+qtkiLKbsSAyta7HK/1aydJ9QZlhuWFoLqVhFrJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6tx/8pjD7FV0QCybuyfsOPVhmDSls8WWEJTTBsr1nuqSJyeUpsulAXruAIqV4lPboPcUQlDYNiDFDInD04krf5ghhnPWnuSQgZwZb5hOwNwJyMVD/T3VzCjMsD30wGHn8g03ydbyecEKUWNRJ8J/Qptcq0tENG83kAPqZT6TKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKmpZIA1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e538388dd1so2695543a12.1;
        Mon, 03 Mar 2025 22:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069254; x=1741674054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+2M+lUouAH0+Jr+nyjeHl+wxA0K/oLUPdCGmVRRMGE=;
        b=CKmpZIA1asIggn9C+kyqJdqwL15RW2fFhjvV3gDQ+49eIqJNTtry+zZKLJYwMeFXJA
         cAMAbPeWSdiL4wj6vcPo+rXh++5z+VbJL9n6wbKnbYeBBROxd1iseftHhAaaFJIWlB/R
         EKIRo6xoHRiCstC+ZeJOReyoYzKE5fzIbsbmNf/jH7t3s5fvTnp8jqHRFU3PJusg9xdv
         W77RrqTqBqjIs3jYccSlHNEQ401X56LdlrD01MqefqCvmCA09eMjvghJU0QZuOVAhlPV
         odvH1MyMwaTuLujj3zQVyvWesjjyQfhBUoRW6/siYRiZuVo/MjRY6Mx9eLwq3jIhbTm1
         f/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069254; x=1741674054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+2M+lUouAH0+Jr+nyjeHl+wxA0K/oLUPdCGmVRRMGE=;
        b=I8wWfcElOvoh3RVfsfSR8FP2OYo+pJfZsWEc/JriMWI+3V44kZwGK19PB0B5xkOZc7
         f3jZ9x/j8B4DU7jpr9MBFZxLn8Lbl4rUXHplaepptJGaaSPvw/SxSiplpRgFuxJ94sNk
         6xOZxkLZx8e0mpi85NXdVf+yK55CSGRUuLl+6SUmDXzozOmWLztPIZ1Mmp+ARXHOwf6w
         aMBjQGIOR7Z0d18Nb5nok9QBHM+G+xG24XELIa3CaOrv2T5pAmBFuIpmq8f7qD3UOjJQ
         NJG6PtNIJzAnRE46XIsihuYMumKzaFPax60p6WQYcYo8WgtXAmLYj3GKXv6XOeHjYUN1
         leBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG0nqBslP2b2hdNxEz5vxdVsn8F8hTvwgXpt7yQ8VTbi6bipUzWs4KfbJLBBD8qmUutFZfPD/B2v3N@vger.kernel.org, AJvYcCWnrm52j+j2i03uYIp13wSQcgCQ1aUHG8fjig4YyAMr0vcUKBbId2UG0Q2DApMGgTaYoSyqOiRV+fkz465/@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCBA9yHrVF32MWG/r4A+/MgYxVNaeJ36/A9+fwO09TzfQTOn5
	3jNmQO+9bCSsLsVwqLqssLjaoLu2ZeDDmKfvJKXKH48PYUzmchx6
X-Gm-Gg: ASbGnctx+5yx+zjXjEoZgJ0HP+lyYjcChsp8QxQ/8RibiFGGJJ/nME3utKjYf/SZP9u
	rn8iyG7oLIuSQ8/50lpc5IPcHlL/5jVZAY+g8KyEK4dElIffKcxKgpCpHS53v5OK3c2A579D3kQ
	cUVdPTqMlS0u2XsNWRSWjk2zxLyonvuuDmPr5y9IAdUUCAvujS+1vy3zlGYIA85V0mR1vr1/kby
	p69VwXiugREH0S/2HMRIoX0bEBKK4vmqQvnzSKpLDh1CgrB1lxEQyYhk24J+85kPAZEBD6Q3cXY
	3CzqiG76As6unxoFQFrBcNRIc6wETkRSsKGyCvbmWzqLNrsnr7Ja3szGHumJA4a/Jkv5D4rM0de
	Hd4up6z9RHOi0JQM=
X-Google-Smtp-Source: AGHT+IHmRZJWXxinp3S9yKdKxAQxAmR8UYiXoV3pVFigexm+q7DYIkPX028aeA4Fom82uQG7EDBq9w==
X-Received: by 2002:a05:6402:5c8:b0:5df:6de2:1e38 with SMTP id 4fb4d7f45d1cf-5e4d6b0ca3dmr16714679a12.17.1741069254457;
        Mon, 03 Mar 2025 22:20:54 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:53 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:36 +0100
Subject: [PATCH v6 05/10] mfd: bcm590xx: Add support for multiple device
 types + BCM59054 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-5-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069240; l=3092;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Vau+qtkiLKbsSAyta7HK/1aydJ9QZlhuWFoLqVhFrJQ=;
 b=cKgnfp5aYzSXknoJCrMwHDV0XkywmbrTIiMxmmHGahAu+caQfeqB75k3Wx8UG5AeiicIhr687
 AWQQPXVCrrkDI6kkEs//zqa40g8nM6JWbYYm5Mx+1OM2KurIy2kekwI
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 is another chip from the BCM590xx line of PMUs, commonly
used on devices with the BCM21664/BCM23550 chipsets.

Prepare the BCM590xx driver for supporting other devices by adding the
PMUID register values for supported chip types and store them in the
MFD data struct as "pmu_id". (These will be checked against the actual
PMUID register values in a later commit.)

Then, add a DT compatible for the BCM59054, and provide the PMU ID as
OF match data.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Move PMUID value to MFD header
- Use PMUID value as OF data/device type value
- Add bcm59054 to I2C ID table

Changes in v4:
- Rewrite commit message description
- Rename "device_type" member to "dev_type"
- Drop awkward line break to fit function call
- Add PMU ID/revision parsing function

Changes in v3:
- Fix compilation warning about device_type pointer cast type
- Name the device types enum and use it as the type in the MFD struct
---
 drivers/mfd/bcm590xx.c       | 12 +++++++++++-
 include/linux/mfd/bcm590xx.h |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 8b56786d85d0182acf91da203b5f943556c08422..4620eed0066fbf1dd691a2e392e967747b4d125b 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -50,6 +50,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 	bcm590xx->dev = &i2c_pri->dev;
 	bcm590xx->i2c_pri = i2c_pri;
 
+	bcm590xx->pmu_id = (uintptr_t) of_device_get_match_data(bcm590xx->dev);
+
 	bcm590xx->regmap_pri = devm_regmap_init_i2c(i2c_pri,
 						 &bcm590xx_regmap_config_pri);
 	if (IS_ERR(bcm590xx->regmap_pri)) {
@@ -91,12 +93,20 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 }
 
 static const struct of_device_id bcm590xx_of_match[] = {
-	{ .compatible = "brcm,bcm59056" },
+	{
+		.compatible = "brcm,bcm59054",
+		.data = (void *)BCM590XX_PMUID_BCM59054,
+	},
+	{
+		.compatible = "brcm,bcm59056",
+		.data = (void *)BCM590XX_PMUID_BCM59056,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm590xx_of_match);
 
 static const struct i2c_device_id bcm590xx_i2c_id[] = {
+	{ "bcm59054" },
 	{ "bcm59056" },
 	{ }
 };
diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index c614d1b1d8a217ac2f212908a4c19ae71fa56f63..8d146e3b102a7dbce6f4dbab9f8ae5a9c4e68c0e 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -13,6 +13,10 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 
+/* PMU ID register values; also used as device type */
+#define BCM590XX_PMUID_BCM59054		0x54
+#define BCM590XX_PMUID_BCM59056		0x56
+
 /* max register address */
 #define BCM590XX_MAX_REGISTER_PRI	0xe7
 #define BCM590XX_MAX_REGISTER_SEC	0xf0
@@ -23,6 +27,9 @@ struct bcm590xx {
 	struct i2c_client *i2c_sec;
 	struct regmap *regmap_pri;
 	struct regmap *regmap_sec;
+
+	/* PMU ID value; also used as device type */
+	u8 pmu_id;
 };
 
 #endif /*  __LINUX_MFD_BCM590XX_H */

-- 
2.48.1


