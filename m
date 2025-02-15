Return-Path: <linux-kernel+bounces-516112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE866A36D0D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263AD17209D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C21C8618;
	Sat, 15 Feb 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIRCJ+94"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D531C7015;
	Sat, 15 Feb 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612407; cv=none; b=u0TEDKCnwi40IiMhKrvYUNTZEFDqS/tB4QVFSM7H7Y0ZTSINiM/iNa3FZayQ6TtUGxR4b3E5e+IisifosOrUM2+rIinzEEXv3gtsGSR621If046sAy1OCRcODHLKRzrD+PyWYkAoxAK0uxdvRzlj0mfvsAO5sLenRvEXBJGzZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612407; c=relaxed/simple;
	bh=K+fEAI3FKWYtSLQxgtsc7acLnt2h/zJjYMsxJYC7FvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crhbph4dok4qc9TSR6LXW9RSjTzrDcw84Ln3uTB5qvSCydYlXPP3+U7TwkapDcspu6dLYT5H7LHx+/VRch2o4koJiF0mZjDEd1BjrT7ToaykxZ00J4KC78vHiGJxNoI73+nZkk4BrEYfNErkzMyzG1SOlDoqpSLCawYfwOuhHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIRCJ+94; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so1873841a12.0;
        Sat, 15 Feb 2025 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612403; x=1740217203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npj1EmujK4Rc80WdjHAmlETUDGFaqlJvXT146PAmYzc=;
        b=nIRCJ+94Jw2b16q1UmhYF5eSTGhu75lIbW58LG18ZsU5VwXQkZ1zSIDljsvuUzFktR
         r4iy1GCDjJRoL7rZlRwnUc+DUffTbXxsmhMJwvHMMsn9pysOAIsMV+vqWXqsOx6NltKL
         OS1XJFqOinWWgvdo+iwWldu8XIcoGMeP2od6j+MRKu16Mg4dXKF5JdyrAD9zokb/ZnnQ
         2HyZhrYhC37EN1xqGn36RTkI+FERa1H+GooQBmLz1iE40/dlNak4ys6UXK3RRjX4hOpz
         FTx0XtnZCnrQCuTjHJAwvpHnuIymdq7OCL1/KtnPPLBGyUPU3e+legP2Oo1bmWwUx0xd
         1oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612403; x=1740217203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npj1EmujK4Rc80WdjHAmlETUDGFaqlJvXT146PAmYzc=;
        b=TeUNcSpFQJ/1p45kYpXTO1u1yIkl1b9piDkbSdAsnfH/Bd8OPXbgMvsH7G+u6Oahoi
         VlzWnCDBwE1mU6Dak+qE7fVAq4ngh/AI5vd3jQE5qTyYbU3hLDMKnpLloKgQYjxYiFvc
         Z/SzdqYBgOyrmCIba+nGHBhjzZo0Fe7d091xeDzA59LM11GRi/9nT8mOTnyENLmPxLwA
         G1Z4bCtfbNlElvPT4x0o3BE2F9PRj+CFiB9SVwt7zGfw4I0P2TBEFYHNz5MS4baiMWjZ
         IE2fYiQWzJs9/qsZLGfy93/U9DcN+RLxN2MfWzgkx6YghkNN8W7vlUE+9K4H+WNyWUYw
         KAyA==
X-Forwarded-Encrypted: i=1; AJvYcCWAbjbOpinhg89CJ7cXvjbscz37kAnf6OKofL2QpZshGF4FAQC4OUmx6ctHUKcY2TjLkAmi4xYbYf06@vger.kernel.org, AJvYcCXJOQ5HNurM0ZCEuQ/Yl2Fa++Pmv5Wx37xgn1r5e3IAu63QuCJqnVuuuzn85WM76BRFMZpqJYWK7Z7DubXd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5G9ZrO+DmPkKsaRPSfR6NQwzRMKSdp0aHXa5tv88Kq/LQiOyX
	5mwz2HgL7mF+kXmYt9SdYu+kKNBVaS6Ecdx9x1uTewZx4kJtl15/
X-Gm-Gg: ASbGncufcx2O3r/WaY4b2QxorCi8kxE6DETxPA7cKGsPNtdUl6xTIn8uTOYatn7F/0C
	cQL6oHRSFWePcuzwbApiS/DtBFuDtlbW0vmu09bCtmX1nwU9UHeImm6Jg3ryGQrnKjfdFn5k4r5
	Mf8cxGavu6eJheJW7RX6kGAyIEf5aLrwjTApUaiJIUajHxKuS4ax5IIm1HuZYdIH8yI51BWABSJ
	CJseKS/VKnFZOknHho3w6IY7Enzr1qWzwQAMgyqP1EDb0PgO6KR8TxUEUYmUWTHreSjZdqj1c8B
	Djsq6bO2X/f3QUvE9PR6NIeAtrbIQnDYN7Jb9jjLzmAjh8uBWsgMqQibwU1F9Q==
X-Google-Smtp-Source: AGHT+IHhDJG2OKgZ99OHjaCv4S3GetWFGXNgYX3dY3ZP8clYIIVo+CT6TdzwkUJH+sTSHnORJS8f2g==
X-Received: by 2002:a17:907:9709:b0:ab7:d87f:665b with SMTP id a640c23a62f3a-abb70de2845mr171847766b.48.1739612402824;
        Sat, 15 Feb 2025 01:40:02 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:40:02 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:44 +0100
Subject: [PATCH v4 9/9] regulator: bcm590xx: Add support for BCM59054
 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-9-dbfb2d76a855@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=17777;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=K+fEAI3FKWYtSLQxgtsc7acLnt2h/zJjYMsxJYC7FvU=;
 b=w42oWHqXVrvZa9ig1clVS9YpIcWWfgPeiaoyn+ogV6opHAsQBRE+m5yMrFL0Os5vpJEbmOTHJ
 rFwLoOm9h9fBtRX/E4w4gf0Iw4Sey+s/BMiu/e3M5cB9BwsL5uLmvGC
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59056 and BCM59054 are very similar in terms of regulators. Add
the register definitions for the BCM59054 and enable support for it in
the driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Lock MICLDO at 1.8v to match vendor kernel behavior
- Set different voltage table for VSR based on PMU revision
- Fix incorrect table being used for LVLDO1
- Add missing newline to "unknown device type" error message

Changes in v3:
- Adapt to regulator info being moved to tables
---
 drivers/regulator/bcm590xx-regulator.c | 649 ++++++++++++++++++++++++++++++++-
 1 file changed, 647 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index ccae8f82999b0af085eb40dc31227d345e41462b..d03edf8c411b8e86201a23b97df8897955c3234d 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -57,6 +57,17 @@ static const struct regulator_ops bcm590xx_ops_ldo = {
 	.map_voltage		= regulator_map_voltage_iterate,
 };
 
+/*
+ * LDO ops without voltage selection, used for MICLDO on BCM59054.
+ * (These are currently the same as VBUS ops, but will be different
+ * in the future once full PMMODE support is implemented.)
+ */
+static const struct regulator_ops bcm590xx_ops_ldo_novolt = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+};
+
 static const struct regulator_ops bcm590xx_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -111,6 +122,13 @@ static const struct regulator_ops bcm590xx_ops_vbus = {
 #define BCM59056_SR_DESC(_name, _name_lower, _ranges)			\
 	BCM590XX_SR_DESC(BCM59056, bcm59056, _name, _name_lower, _ranges)
 
+#define BCM59054_REG_DESC(_name, _name_lower)				\
+	BCM590XX_REG_DESC(BCM59054, _name, _name_lower)
+#define BCM59054_LDO_DESC(_name, _name_lower, _table)			\
+	BCM590XX_LDO_DESC(BCM59054, bcm59054, _name, _name_lower, _table)
+#define BCM59054_SR_DESC(_name, _name_lower, _ranges)			\
+	BCM590XX_SR_DESC(BCM59054, bcm59054, _name, _name_lower, _ranges)
+
 /* BCM59056 data */
 
 /* I2C slave 0 registers */
@@ -471,6 +489,617 @@ static const struct bcm590xx_reg_info bcm59056_regs[BCM59056_NUM_REGS] = {
 	},
 };
 
+/* BCM59054 data */
+
+/* I2C slave 0 registers */
+#define BCM59054_RFLDOPMCTRL1	0x60
+#define BCM59054_CAMLDO1PMCTRL1	0x62
+#define BCM59054_CAMLDO2PMCTRL1	0x64
+#define BCM59054_SIMLDO1PMCTRL1	0x66
+#define BCM59054_SIMLDO2PMCTRL1	0x68
+#define BCM59054_SDLDOPMCTRL1	0x6a
+#define BCM59054_SDXLDOPMCTRL1	0x6c
+#define BCM59054_MMCLDO1PMCTRL1	0x6e
+#define BCM59054_MMCLDO2PMCTRL1	0x70
+#define BCM59054_AUDLDOPMCTRL1	0x72
+#define BCM59054_MICLDOPMCTRL1	0x74
+#define BCM59054_USBLDOPMCTRL1	0x76
+#define BCM59054_VIBLDOPMCTRL1	0x78
+#define BCM59054_IOSR1PMCTRL1	0x7a
+#define BCM59054_IOSR2PMCTRL1	0x7c
+#define BCM59054_CSRPMCTRL1	0x7e
+#define BCM59054_SDSR1PMCTRL1	0x82
+#define BCM59054_SDSR2PMCTRL1	0x86
+#define BCM59054_MMSRPMCTRL1	0x8a
+#define BCM59054_VSRPMCTRL1	0x8e
+#define BCM59054_RFLDOCTRL	0x96
+#define BCM59054_CAMLDO1CTRL	0x97
+#define BCM59054_CAMLDO2CTRL	0x98
+#define BCM59054_SIMLDO1CTRL	0x99
+#define BCM59054_SIMLDO2CTRL	0x9a
+#define BCM59054_SDLDOCTRL	0x9b
+#define BCM59054_SDXLDOCTRL	0x9c
+#define BCM59054_MMCLDO1CTRL	0x9d
+#define BCM59054_MMCLDO2CTRL	0x9e
+#define BCM59054_AUDLDOCTRL	0x9f
+#define BCM59054_MICLDOCTRL	0xa0
+#define BCM59054_USBLDOCTRL	0xa1
+#define BCM59054_VIBLDOCTRL	0xa2
+#define BCM59054_CSRVOUT1	0xc0
+#define BCM59054_IOSR1VOUT1	0xc3
+#define BCM59054_IOSR2VOUT1	0xc6
+#define BCM59054_MMSRVOUT1	0xc9
+#define BCM59054_SDSR1VOUT1	0xcc
+#define BCM59054_SDSR2VOUT1	0xcf
+#define BCM59054_VSRVOUT1	0xd2
+
+/* I2C slave 1 registers */
+#define BCM59054_LVLDO1PMCTRL1	0x16
+#define BCM59054_LVLDO2PMCTRL1	0x18
+#define BCM59054_GPLDO1CTRL	0x1a
+#define BCM59054_GPLDO2CTRL	0x1b
+#define BCM59054_GPLDO3CTRL	0x1c
+#define BCM59054_TCXLDOCTRL	0x1d
+#define BCM59054_LVLDO1CTRL	0x1e
+#define BCM59054_LVLDO2CTRL	0x1f
+#define BCM59054_OTG_CTRL	0x40
+#define BCM59054_GPLDO1PMCTRL1	0x57
+#define BCM59054_GPLDO2PMCTRL1	0x59
+#define BCM59054_GPLDO3PMCTRL1	0x5b
+#define BCM59054_TCXLDOPMCTRL1	0x5d
+
+/*
+ * RFLDO to VSR regulators are
+ * accessed via I2C slave 0
+ */
+
+/* LDO regulator IDs */
+#define BCM59054_REG_RFLDO	0
+#define BCM59054_REG_CAMLDO1	1
+#define BCM59054_REG_CAMLDO2	2
+#define BCM59054_REG_SIMLDO1	3
+#define BCM59054_REG_SIMLDO2	4
+#define BCM59054_REG_SDLDO	5
+#define BCM59054_REG_SDXLDO	6
+#define BCM59054_REG_MMCLDO1	7
+#define BCM59054_REG_MMCLDO2	8
+#define BCM59054_REG_AUDLDO	9
+#define BCM59054_REG_MICLDO	10
+#define BCM59054_REG_USBLDO	11
+#define BCM59054_REG_VIBLDO	12
+
+/* DCDC regulator IDs */
+#define BCM59054_REG_CSR	13
+#define BCM59054_REG_IOSR1	14
+#define BCM59054_REG_IOSR2	15
+#define BCM59054_REG_MMSR	16
+#define BCM59054_REG_SDSR1	17
+#define BCM59054_REG_SDSR2	18
+#define BCM59054_REG_VSR	19
+
+/*
+ * GPLDO1 to VBUS regulators are
+ * accessed via I2C slave 1
+ */
+
+#define BCM59054_REG_GPLDO1	20
+#define BCM59054_REG_GPLDO2	21
+#define BCM59054_REG_GPLDO3	22
+#define BCM59054_REG_TCXLDO	23
+#define BCM59054_REG_LVLDO1	24
+#define BCM59054_REG_LVLDO2	25
+#define BCM59054_REG_VBUS	26
+
+#define BCM59054_NUM_REGS	27
+
+/* LDO group 1: supported voltages in microvolts */
+static const unsigned int bcm59054_ldo_1_table[] = {
+	1200000, 1800000, 2500000, 2700000, 2800000,
+	2900000, 3000000, 3300000,
+};
+
+/* LDO group 2: supported voltages in microvolts */
+static const unsigned int bcm59054_ldo_2_table[] = {
+	3100000, 1800000, 2500000, 2700000, 2800000,
+	2900000, 3000000, 3300000,
+};
+
+/* LDO group 3: supported voltages in microvolts */
+static const unsigned int bcm59054_ldo_3_table[] = {
+	1000000, 1107000, 1143000, 1214000, 1250000,
+	1464000, 1500000, 1786000,
+};
+
+/* DCDC group SR: supported voltages in microvolts */
+static const struct linear_range bcm59054_dcdc_sr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 1, 0),
+	REGULATOR_LINEAR_RANGE(860000, 2, 60, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 61, 61, 0),
+	REGULATOR_LINEAR_RANGE(1800000, 62, 62, 0),
+	REGULATOR_LINEAR_RANGE(900000, 63, 63, 0),
+};
+
+/* DCDC group VSR (BCM59054A1): supported voltages in microvolts */
+static const struct linear_range bcm59054_dcdc_vsr_a1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 1, 0),
+	REGULATOR_LINEAR_RANGE(860000, 2, 59, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 60, 60, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 61, 61, 0),
+	REGULATOR_LINEAR_RANGE(1800000, 62, 62, 0),
+	REGULATOR_LINEAR_RANGE(1600000, 63, 63, 0),
+};
+
+/* DCDC group CSR: supported voltages in microvolts */
+static const struct linear_range bcm59054_dcdc_csr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 1, 100000),
+	REGULATOR_LINEAR_RANGE(860000, 2, 60, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 61, 63, 0),
+};
+
+static const struct bcm590xx_reg_info bcm59054_regs[BCM59054_NUM_REGS] = {
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(RFLDO, rfldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(CAMLDO1, camldo1, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(CAMLDO2, camldo2, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SIMLDO1, simldo1, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SIMLDO2, simldo2, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SDLDO, sdldo, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SDXLDO, sdxldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(MMCLDO1, mmcldo1, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(MMCLDO2, mmcldo2, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(AUDLDO, audldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_REG_DESC(MICLDO, micldo),
+			.ops = &bcm590xx_ops_ldo_novolt,
+			/* MICLDO is locked at 1.8V */
+			.n_voltages = 1,
+			.fixed_uV = 1800000,
+			.enable_reg = BCM59054_MICLDOPMCTRL1,
+			.enable_mask = BCM590XX_REG_ENABLE,
+			.enable_is_inverted = true,
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(USBLDO, usbldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(VIBLDO, vibldo, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(CSR, csr, dcdc_csr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(IOSR1, iosr1, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(IOSR2, iosr2, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(MMSR, mmsr, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(SDSR1, sdsr1, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(SDSR2, sdsr2, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(VSR, vsr, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(GPLDO1, gpldo1, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(GPLDO2, gpldo2, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(GPLDO3, gpldo3, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(TCXLDO, tcxldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(LVLDO1, lvldo1, ldo_3_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(LVLDO2, lvldo2, ldo_3_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_VBUS,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_REG_DESC(VBUS, vbus),
+			.ops = &bcm590xx_ops_vbus,
+			.n_voltages = 1,
+			.fixed_uV = 5000000,
+			.enable_reg = BCM59054_OTG_CTRL,
+			.enable_mask = BCM590XX_VBUS_ENABLE,
+		},
+	},
+};
+
+/*
+ * BCM59054A1 regulators; same as previous revision, but with different
+ * VSR voltage table.
+ */
+static const struct bcm590xx_reg_info bcm59054_a1_regs[BCM59054_NUM_REGS] = {
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(RFLDO, rfldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(CAMLDO1, camldo1, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(CAMLDO2, camldo2, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SIMLDO1, simldo1, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SIMLDO2, simldo2, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SDLDO, sdldo, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(SDXLDO, sdxldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(MMCLDO1, mmcldo1, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(MMCLDO2, mmcldo2, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(AUDLDO, audldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_REG_DESC(MICLDO, micldo),
+			.ops = &bcm590xx_ops_ldo_novolt,
+			/* MICLDO is locked at 1.8V */
+			.n_voltages = 1,
+			.fixed_uV = 1800000,
+			.enable_reg = BCM59054_MICLDOPMCTRL1,
+			.enable_mask = BCM590XX_REG_ENABLE,
+			.enable_is_inverted = true,
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(USBLDO, usbldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_LDO_DESC(VIBLDO, vibldo, ldo_2_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(CSR, csr, dcdc_csr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(IOSR1, iosr1, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(IOSR2, iosr2, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(MMSR, mmsr, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(SDSR1, sdsr1, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(SDSR2, sdsr2, dcdc_sr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REG_REGMAP_PRI,
+		.desc = {
+			BCM59054_SR_DESC(VSR, vsr, dcdc_vsr_a1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(GPLDO1, gpldo1, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(GPLDO2, gpldo2, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(GPLDO3, gpldo3, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(TCXLDO, tcxldo, ldo_1_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(LVLDO1, lvldo1, ldo_3_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_LDO_DESC(LVLDO2, lvldo2, ldo_3_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_VBUS,
+		.regmap = BCM590XX_REG_REGMAP_SEC,
+		.desc = {
+			BCM59054_REG_DESC(VBUS, vbus),
+			.ops = &bcm590xx_ops_vbus,
+			.n_voltages = 1,
+			.fixed_uV = 5000000,
+			.enable_reg = BCM59054_OTG_CTRL,
+			.enable_mask = BCM590XX_VBUS_ENABLE,
+		},
+	},
+};
+
 static int bcm590xx_probe(struct platform_device *pdev)
 {
 	struct bcm590xx *bcm590xx = dev_get_drvdata(pdev->dev.parent);
@@ -485,8 +1114,24 @@ static int bcm590xx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pmu->mfd = bcm590xx;
-	pmu->n_regulators = BCM59056_NUM_REGS;
-	pmu->regs = bcm59056_regs;
+
+	switch (pmu->mfd->dev_type) {
+	case BCM59054_TYPE:
+		pmu->n_regulators = BCM59054_NUM_REGS;
+		if (pmu->mfd->rev_ana == BCM59054_REV_ANA_A1)
+			pmu->regs = bcm59054_a1_regs;
+		else
+			pmu->regs = bcm59054_regs;
+		break;
+	case BCM59056_TYPE:
+		pmu->n_regulators = BCM59056_NUM_REGS;
+		pmu->regs = bcm59056_regs;
+		break;
+	default:
+		dev_err(bcm590xx->dev,
+			"unknown device type, could not initialize\n");
+		return -EINVAL;
+	}
 
 	platform_set_drvdata(pdev, pmu);
 

-- 
2.48.1


