Return-Path: <linux-kernel+bounces-563099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E49A636F8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D0188E8B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3E200106;
	Sun, 16 Mar 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl3c3LzQ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC251FECC6;
	Sun, 16 Mar 2025 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149174; cv=none; b=hIOl+f5IXzzn485lEDCfAmjLBUftAhVmPkegJ438DqsxYSOyxNVR9JQ5S1Ezd2RNzDiNnBYOqcTvd6IVBNV+0aoCJVaM/NoS97hZKVC+rmB6kEKASj/c6nmI8GAhECrUuKZk5HhppxT9Ys9u4zjcGF5KuBoOB+Y8laeGuv8nLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149174; c=relaxed/simple;
	bh=GNdM5JMwEsZys9Gnl/ee+dTEs4h0iUU0Ghm/nQXH/xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7d8VSGZiN/IJSNCow9F53rqB+1fPl44Y7CqouX4/PKTViq+uTsX+6CIfQ0VtLkqnQIkQe5C4+MDD2S19SRhvbyC9Ow67MwGviiQyANrIUkzEiScmc63NoQO59caMRU473hW4q9jH79iYdH4r1z6/W+4m62SBoDeYt5oQEehqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl3c3LzQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so905036166b.1;
        Sun, 16 Mar 2025 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149170; x=1742753970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw4iz1UTiNOOq8JGEbYmPx0iiOi3I3/FxjgthphhYEA=;
        b=cl3c3LzQy/uMQdNLK5gZV/sgnfnZv6/G3lLEM1CoXwO0h+1DBWD/qo5jSwNBkJ0++b
         Uk6l0APKhd8G7V1P7z1B0CWy8V0SPWYex14XpsG53Hba5RR01i0XveNyB7iEHzxY3GQv
         KZa2dBriLjjjYW4u2M0epoX9h+mvvzMmL+qw7uRDW/hdXLtX24seEtUA5CHWztNDCIH0
         +bBcWAuZF64gLDyYjSIaW7xgpUlg3h6rJvS6Bef/nIBsjfYHEoD4OE7Oig1f0g5ZCZLD
         8K8+/kCP4R7eM/Taywj4brqO23y3EQbPecul04Uwiy5LKWyQCa+dMsm4xUPeIkRv03Lo
         WwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149170; x=1742753970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw4iz1UTiNOOq8JGEbYmPx0iiOi3I3/FxjgthphhYEA=;
        b=o3mzarc9Qx0ZExXX26HHwYkjceEJMurtTeefveXD7tlqAsigpstSCruew6SqdArPBW
         JzasU1pVv2FqtvB5X+QEzbEYGzhAAY6q///YDnH9+0EycS1lHnqxa7iGlqjhtNI0mtcS
         7X36gpSSI6B/+gtkE68P92vnZMq8oKW6+CSdhiGtSTMmOzrku9tnVkbY1MjnGBywnWJi
         9CYvwAtJ9yLAW68mMikGJ2dvSVtOq2b517UxNkVIgQQVYmAwMVLrsQqcSlvvvqdKQnA4
         ZXlcYZ7NTOO0ZD+FeCpoc1fp0H+9bci4G7xdLO4gp5uEHN/xTN1yL8V6VG35fMFb45bX
         PhBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQxOLv0FICrGO8zj2NmwF/AKjHVJAekKDSJVONImdBLoEZSR1QfwR1gAlUicprzjE1BrR9Y4J9hB+b@vger.kernel.org, AJvYcCX/8BwfvGHk7iN7SvO1gNNp2+wkFzpNOpKBinOxTxTvIiUVDemLd1qFus0yLgDEnAnWjLhhDzG40igu/O6A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xVjG2KGlBtuynB0rWhbFReWPwIW6pnERUjWvvwrZyzGCw5so
	mCsjuSy3T7KSKFnG/DJb2FPiMtV1kY6SABdh9EleNuHWZinzltM8lBGgoA==
X-Gm-Gg: ASbGncufhxR18pWj0/9GjnS1Wu16+n0fuas9jdXMdGVKscPaceVheTdChLPTzd7SDQx
	UKIDrcp4iYadreXciM67nn7vlaxpDDJaW+JF2UXKsYPDiY1BGzpLqGxc9eryk8Ti28dCeJ8wj/7
	3CU256DhFIUriABMrn/zilOrhEFGqATOsbbhlydZirMEcKSE9xwsObch8iyBhJgiP+uDIMmRVOV
	SDPLEv5pLbUQR+fP8nyliP7TKL4tf/ECSGqRMLn7urLoQp7ToBgTFJI/BDx3VJwZwFYQRRGHO9y
	onhpVFHBx6U1stXjnpHu2v9nHvIJJds2Z9sGWsJ92ASRXYqTI7Vgx4WDvrOipLYKzHscPdkKBoX
	nEtdacDpKM0fCPB8qEw==
X-Google-Smtp-Source: AGHT+IGlgFT9lkDADyc97zufmx5nCyT3ZRePeuTB9o0CscBhDi7VEhli6vq88ctW1mrNL8ArAFIX9g==
X-Received: by 2002:a17:906:6a0a:b0:ac1:e18d:a738 with SMTP id a640c23a62f3a-ac3311b11d1mr1080027166b.3.1742149169932;
        Sun, 16 Mar 2025 11:19:29 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:28 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:56 +0100
Subject: [PATCH v7 08/10] regulator: bcm590xx: Store regulator descriptions
 in table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-8-4281126be1b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=16568;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=GNdM5JMwEsZys9Gnl/ee+dTEs4h0iUU0Ghm/nQXH/xs=;
 b=djCZdVNcDloT05w3TsivnJlzGZJivc1yD8CQRAHWgKWWD94sJHFXV2RzNp+NIDQJG0xsm/Efs
 KYHhmps31gRAK+/XzBtgLw48znT2IYVyFYKT1OLwSJko3AtP7Uxy6OA
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Instead of filling in the regulator description programatically,
store the data in a struct. This will make it a bit nicer to
introduce support for other BCM590xx chips besides the BCM59056.

To do this, add a new struct type, bcm590xx_reg_data, to store
all of the necessary information. Drop the old IS_LDO, IS_GPLDO...
macros in favor of the "type" field in this struct. Adapt the
old bcm590xx_reg struct to the new types.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Adapt to changes in MFD header

Changes in v5:
- Move the bcm590xx_regmap_type enum to the bcm590xx.h header
- Rename bcm590xx_reg_info to bcm590xx_reg_data

Changes in v4:
- Replace incorrect return in regmap selection error handling
- Use switch statement for regmap selection

Changes in v3:
- Added this commit
---
 drivers/regulator/bcm590xx-regulator.c | 473 ++++++++++++++++++++++-----------
 include/linux/mfd/bcm590xx.h           |   6 +
 2 files changed, 322 insertions(+), 157 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index a17311fa30e4d48c0a4925778d7bed486ac7a982..c2427ea166626bdc1eb7cfb99997d95e5125ed91 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -20,6 +20,18 @@
 
 /* I2C slave 0 registers */
 #define BCM590XX_RFLDOPMCTRL1	0x60
+#define BCM590XX_CAMLDO1PMCTRL1	0x62
+#define BCM590XX_CAMLDO2PMCTRL1	0x64
+#define BCM590XX_SIMLDO1PMCTRL1	0x66
+#define BCM590XX_SIMLDO2PMCTRL1	0x68
+#define BCM590XX_SDLDOPMCTRL1	0x6a
+#define BCM590XX_SDXLDOPMCTRL1	0x6c
+#define BCM590XX_MMCLDO1PMCTRL1	0x6e
+#define BCM590XX_MMCLDO2PMCTRL1	0x70
+#define BCM590XX_AUDLDOPMCTRL1	0x72
+#define BCM590XX_MICLDOPMCTRL1	0x74
+#define BCM590XX_USBLDOPMCTRL1	0x76
+#define BCM590XX_VIBLDOPMCTRL1	0x78
 #define BCM590XX_IOSR1PMCTRL1	0x7a
 #define BCM590XX_IOSR2PMCTRL1	0x7c
 #define BCM590XX_CSRPMCTRL1	0x7e
@@ -28,7 +40,25 @@
 #define BCM590XX_MSRPMCTRL1	0x8a
 #define BCM590XX_VSRPMCTRL1	0x8e
 #define BCM590XX_RFLDOCTRL	0x96
+#define BCM590XX_CAMLDO1CTRL	0x97
+#define BCM590XX_CAMLDO2CTRL	0x98
+#define BCM590XX_SIMLDO1CTRL	0x99
+#define BCM590XX_SIMLDO2CTRL	0x9a
+#define BCM590XX_SDLDOCTRL	0x9b
+#define BCM590XX_SDXLDOCTRL	0x9c
+#define BCM590XX_MMCLDO1CTRL	0x9d
+#define BCM590XX_MMCLDO2CTRL	0x9e
+#define BCM590XX_AUDLDOCTRL	0x9f
+#define BCM590XX_MICLDOCTRL	0xa0
+#define BCM590XX_USBLDOCTRL	0xa1
+#define BCM590XX_VIBLDOCTRL	0xa2
 #define BCM590XX_CSRVOUT1	0xc0
+#define BCM590XX_IOSR1VOUT1	0xc3
+#define BCM590XX_IOSR2VOUT1	0xc6
+#define BCM590XX_MSRVOUT1	0xc9
+#define BCM590XX_SDSR1VOUT1	0xcc
+#define BCM590XX_SDSR2VOUT1	0xcf
+#define BCM590XX_VSRVOUT1	0xd2
 
 /* I2C slave 1 registers */
 #define BCM590XX_GPLDO5PMCTRL1	0x16
@@ -94,11 +124,6 @@
 
 #define BCM590XX_NUM_REGS	27
 
-#define BCM590XX_REG_IS_LDO(n)	(n < BCM590XX_REG_CSR)
-#define BCM590XX_REG_IS_GPLDO(n) \
-	((n > BCM590XX_REG_VSR) && (n < BCM590XX_REG_VBUS))
-#define BCM590XX_REG_IS_VBUS(n)	(n == BCM590XX_REG_VBUS)
-
 /* LDO group A: supported voltages in microvolts */
 static const unsigned int ldo_a_table[] = {
 	1200000, 1800000, 2500000, 2700000, 2800000,
@@ -111,10 +136,6 @@ static const unsigned int ldo_c_table[] = {
 	2900000, 3000000, 3300000,
 };
 
-static const unsigned int ldo_vbus[] = {
-	5000000,
-};
-
 /* DCDC group CSR: supported voltages in microvolts */
 static const struct linear_range dcdc_csr_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
@@ -137,115 +158,25 @@ static const struct linear_range dcdc_sdsr1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 52, 63, 0),
 };
 
-struct bcm590xx_info {
-	const char *name;
-	const char *vin_name;
-	u8 n_voltages;
-	const unsigned int *volt_table;
-	u8 n_linear_ranges;
-	const struct linear_range *linear_ranges;
+enum bcm590xx_reg_type {
+	BCM590XX_REG_TYPE_LDO,
+	BCM590XX_REG_TYPE_GPLDO,
+	BCM590XX_REG_TYPE_SR,
+	BCM590XX_REG_TYPE_VBUS
 };
 
-#define BCM590XX_REG_TABLE(_name, _table) \
-	{ \
-		.name = #_name, \
-		.n_voltages = ARRAY_SIZE(_table), \
-		.volt_table = _table, \
-	}
-
-#define BCM590XX_REG_RANGES(_name, _ranges) \
-	{ \
-		.name = #_name, \
-		.n_voltages = 64, \
-		.n_linear_ranges = ARRAY_SIZE(_ranges), \
-		.linear_ranges = _ranges, \
-	}
-
-static struct bcm590xx_info bcm590xx_regs[] = {
-	BCM590XX_REG_TABLE(rfldo, ldo_a_table),
-	BCM590XX_REG_TABLE(camldo1, ldo_c_table),
-	BCM590XX_REG_TABLE(camldo2, ldo_c_table),
-	BCM590XX_REG_TABLE(simldo1, ldo_a_table),
-	BCM590XX_REG_TABLE(simldo2, ldo_a_table),
-	BCM590XX_REG_TABLE(sdldo, ldo_c_table),
-	BCM590XX_REG_TABLE(sdxldo, ldo_a_table),
-	BCM590XX_REG_TABLE(mmcldo1, ldo_a_table),
-	BCM590XX_REG_TABLE(mmcldo2, ldo_a_table),
-	BCM590XX_REG_TABLE(audldo, ldo_a_table),
-	BCM590XX_REG_TABLE(micldo, ldo_a_table),
-	BCM590XX_REG_TABLE(usbldo, ldo_a_table),
-	BCM590XX_REG_TABLE(vibldo, ldo_c_table),
-	BCM590XX_REG_RANGES(csr, dcdc_csr_ranges),
-	BCM590XX_REG_RANGES(iosr1, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(iosr2, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(msr, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(sdsr1, dcdc_sdsr1_ranges),
-	BCM590XX_REG_RANGES(sdsr2, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(vsr, dcdc_iosr1_ranges),
-	BCM590XX_REG_TABLE(gpldo1, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo2, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo3, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo4, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo5, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo6, ldo_a_table),
-	BCM590XX_REG_TABLE(vbus, ldo_vbus),
+struct bcm590xx_reg_data {
+	enum bcm590xx_reg_type type;
+	enum bcm590xx_regmap_type regmap;
+	const struct regulator_desc desc;
 };
 
 struct bcm590xx_reg {
-	struct regulator_desc *desc;
 	struct bcm590xx *mfd;
+	unsigned int n_regulators;
+	const struct bcm590xx_reg_data *regs;
 };
 
-static int bcm590xx_get_vsel_register(int id)
-{
-	if (BCM590XX_REG_IS_LDO(id))
-		return BCM590XX_RFLDOCTRL + id;
-	else if (BCM590XX_REG_IS_GPLDO(id))
-		return BCM590XX_GPLDO1CTRL + id;
-	else
-		return BCM590XX_CSRVOUT1 + (id - BCM590XX_REG_CSR) * 3;
-}
-
-static int bcm590xx_get_enable_register(int id)
-{
-	int reg = 0;
-
-	if (BCM590XX_REG_IS_LDO(id))
-		reg = BCM590XX_RFLDOPMCTRL1 + id * 2;
-	else if (BCM590XX_REG_IS_GPLDO(id))
-		reg = BCM590XX_GPLDO1PMCTRL1 + id * 2;
-	else
-		switch (id) {
-		case BCM590XX_REG_CSR:
-			reg = BCM590XX_CSRPMCTRL1;
-			break;
-		case BCM590XX_REG_IOSR1:
-			reg = BCM590XX_IOSR1PMCTRL1;
-			break;
-		case BCM590XX_REG_IOSR2:
-			reg = BCM590XX_IOSR2PMCTRL1;
-			break;
-		case BCM590XX_REG_MSR:
-			reg = BCM590XX_MSRPMCTRL1;
-			break;
-		case BCM590XX_REG_SDSR1:
-			reg = BCM590XX_SDSR1PMCTRL1;
-			break;
-		case BCM590XX_REG_SDSR2:
-			reg = BCM590XX_SDSR2PMCTRL1;
-			break;
-		case BCM590XX_REG_VSR:
-			reg = BCM590XX_VSRPMCTRL1;
-			break;
-		case BCM590XX_REG_VBUS:
-			reg = BCM590XX_OTG_CTRL;
-			break;
-		}
-
-
-	return reg;
-}
-
 static const struct regulator_ops bcm590xx_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -272,73 +203,301 @@ static const struct regulator_ops bcm590xx_ops_vbus = {
 	.disable		= regulator_disable_regmap,
 };
 
+#define BCM590XX_REG_DESC(_name, _name_lower)				\
+	.id = BCM590XX_REG_##_name,					\
+	.name = #_name_lower,						\
+	.of_match = of_match_ptr(#_name_lower),				\
+	.regulators_node = of_match_ptr("regulators"),			\
+	.type = REGULATOR_VOLTAGE,					\
+	.owner = THIS_MODULE						\
+
+#define BCM590XX_LDO_DESC(_name, _name_lower, _table)			\
+	BCM590XX_REG_DESC(_name, _name_lower),				\
+	.ops = &bcm590xx_ops_ldo,					\
+	.n_voltages = ARRAY_SIZE(_table),				\
+	.volt_table = _table,						\
+	.vsel_reg = BCM590XX_##_name##CTRL,				\
+	.vsel_mask = BCM590XX_LDO_VSEL_MASK,				\
+	.enable_reg = BCM590XX_##_name##PMCTRL1,			\
+	.enable_mask = BCM590XX_REG_ENABLE,				\
+	.enable_is_inverted = true
+
+#define BCM590XX_SR_DESC(_name, _name_lower, _ranges)			\
+	BCM590XX_REG_DESC(_name, _name_lower),				\
+	.ops = &bcm590xx_ops_dcdc,					\
+	.n_voltages = 64,						\
+	.linear_ranges = _ranges,					\
+	.n_linear_ranges = ARRAY_SIZE(_ranges),				\
+	.vsel_reg = BCM590XX_##_name##VOUT1,				\
+	.vsel_mask = BCM590XX_SR_VSEL_MASK,				\
+	.enable_reg = BCM590XX_##_name##PMCTRL1,			\
+	.enable_mask = BCM590XX_REG_ENABLE,				\
+	.enable_is_inverted = true
+
+static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(RFLDO, rfldo, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(CAMLDO1, camldo1, ldo_c_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(CAMLDO2, camldo2, ldo_c_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(SIMLDO1, simldo1, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(SIMLDO2, simldo2, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(SDLDO, sdldo, ldo_c_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(SDXLDO, sdxldo, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(MMCLDO1, mmcldo1, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(MMCLDO2, mmcldo2, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(AUDLDO, audldo, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(MICLDO, micldo, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(USBLDO, usbldo, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_LDO,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_LDO_DESC(VIBLDO, vibldo, ldo_c_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(CSR, csr, dcdc_csr_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(IOSR1, iosr1, dcdc_iosr1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(IOSR2, iosr2, dcdc_iosr1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(MSR, msr, dcdc_iosr1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(SDSR1, sdsr1, dcdc_sdsr1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(SDSR2, sdsr2, dcdc_iosr1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_SR,
+		.regmap = BCM590XX_REGMAP_PRI,
+		.desc = {
+			BCM590XX_SR_DESC(VSR, vsr, dcdc_iosr1_ranges),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_LDO_DESC(GPLDO1, gpldo1, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_LDO_DESC(GPLDO2, gpldo2, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_LDO_DESC(GPLDO3, gpldo3, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_LDO_DESC(GPLDO4, gpldo4, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_LDO_DESC(GPLDO5, gpldo5, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_GPLDO,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_LDO_DESC(GPLDO6, gpldo6, ldo_a_table),
+		},
+	},
+
+	{
+		.type = BCM590XX_REG_TYPE_VBUS,
+		.regmap = BCM590XX_REGMAP_SEC,
+		.desc = {
+			BCM590XX_REG_DESC(VBUS, vbus),
+			.ops = &bcm590xx_ops_vbus,
+			.n_voltages = 1,
+			.fixed_uV = 5000000,
+			.enable_reg = BCM590XX_OTG_CTRL,
+			.enable_mask = BCM590XX_VBUS_ENABLE,
+		},
+	},
+};
+
 static int bcm590xx_probe(struct platform_device *pdev)
 {
 	struct bcm590xx *bcm590xx = dev_get_drvdata(pdev->dev.parent);
 	struct bcm590xx_reg *pmu;
+	const struct bcm590xx_reg_data *info;
 	struct regulator_config config = { };
-	struct bcm590xx_info *info;
 	struct regulator_dev *rdev;
-	int i;
+	unsigned int i;
 
 	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
 	if (!pmu)
 		return -ENOMEM;
 
 	pmu->mfd = bcm590xx;
+	pmu->n_regulators = BCM590XX_NUM_REGS;
+	pmu->regs = bcm590xx_regs;
 
 	platform_set_drvdata(pdev, pmu);
 
-	pmu->desc = devm_kcalloc(&pdev->dev,
-				 BCM590XX_NUM_REGS,
-				 sizeof(struct regulator_desc),
-				 GFP_KERNEL);
-	if (!pmu->desc)
-		return -ENOMEM;
-
-	info = bcm590xx_regs;
-
-	for (i = 0; i < BCM590XX_NUM_REGS; i++, info++) {
-		/* Register the regulators */
-		pmu->desc[i].name = info->name;
-		pmu->desc[i].of_match = of_match_ptr(info->name);
-		pmu->desc[i].regulators_node = of_match_ptr("regulators");
-		pmu->desc[i].supply_name = info->vin_name;
-		pmu->desc[i].id = i;
-		pmu->desc[i].volt_table = info->volt_table;
-		pmu->desc[i].n_voltages = info->n_voltages;
-		pmu->desc[i].linear_ranges = info->linear_ranges;
-		pmu->desc[i].n_linear_ranges = info->n_linear_ranges;
-
-		if ((BCM590XX_REG_IS_LDO(i)) || (BCM590XX_REG_IS_GPLDO(i))) {
-			pmu->desc[i].ops = &bcm590xx_ops_ldo;
-			pmu->desc[i].vsel_mask = BCM590XX_LDO_VSEL_MASK;
-		} else if (BCM590XX_REG_IS_VBUS(i))
-			pmu->desc[i].ops = &bcm590xx_ops_vbus;
-		else {
-			pmu->desc[i].ops = &bcm590xx_ops_dcdc;
-			pmu->desc[i].vsel_mask = BCM590XX_SR_VSEL_MASK;
-		}
-
-		if (BCM590XX_REG_IS_VBUS(i))
-			pmu->desc[i].enable_mask = BCM590XX_VBUS_ENABLE;
-		else {
-			pmu->desc[i].vsel_reg = bcm590xx_get_vsel_register(i);
-			pmu->desc[i].enable_is_inverted = true;
-			pmu->desc[i].enable_mask = BCM590XX_REG_ENABLE;
-		}
-		pmu->desc[i].enable_reg = bcm590xx_get_enable_register(i);
-		pmu->desc[i].type = REGULATOR_VOLTAGE;
-		pmu->desc[i].owner = THIS_MODULE;
+	/* Register the regulators */
+	for (i = 0; i < pmu->n_regulators; i++) {
+		info = &pmu->regs[i];
 
 		config.dev = bcm590xx->dev;
 		config.driver_data = pmu;
-		if (BCM590XX_REG_IS_GPLDO(i) || BCM590XX_REG_IS_VBUS(i))
-			config.regmap = bcm590xx->regmap_sec;
-		else
+
+		switch (info->regmap) {
+		case BCM590XX_REGMAP_PRI:
 			config.regmap = bcm590xx->regmap_pri;
+			break;
+		case BCM590XX_REGMAP_SEC:
+			config.regmap = bcm590xx->regmap_sec;
+			break;
+		default:
+			dev_err(bcm590xx->dev,
+				"invalid regmap for %s regulator; this is a driver bug\n",
+				pdev->name);
+			return -EINVAL;
+		}
 
-		rdev = devm_regulator_register(&pdev->dev, &pmu->desc[i],
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
 					       &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(bcm590xx->dev, PTR_ERR(rdev),
diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index fbc458e94bef923ca1b69afe2cac944adf6fedf8..5a5783abd47b9a6bb6f9bb3a8cafddbd01aa7fcc 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -27,6 +27,12 @@
 #define BCM59056_REV_DIGITAL_B0		2
 #define BCM59056_REV_ANALOG_B0		2
 
+/* regmap types */
+enum bcm590xx_regmap_type {
+	BCM590XX_REGMAP_PRI,
+	BCM590XX_REGMAP_SEC,
+};
+
 /* max register address */
 #define BCM590XX_MAX_REGISTER_PRI	0xe7
 #define BCM590XX_MAX_REGISTER_SEC	0xf0

-- 
2.48.1


