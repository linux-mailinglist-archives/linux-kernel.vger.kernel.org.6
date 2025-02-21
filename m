Return-Path: <linux-kernel+bounces-526585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3322A40096
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1F1862C92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC4255E5C;
	Fri, 21 Feb 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcIew9Au"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C2254B1F;
	Fri, 21 Feb 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169010; cv=none; b=NugOKPKh6N1hvcPs8cTZ7Egqo1PvXboeVhmq6qFI+UtcXrtrpXwegc2J4q7xRJ7yZctmOeiO9mXFiZupYcN/Rvyb0M54D9wASTSUjgWtlE5cVIL3bCCtA1zbbR1C2G6YUGqtz2krRnTOgJYBu26HMQnTS6qI0b+wRslO//ZSwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169010; c=relaxed/simple;
	bh=oxEUTmHEMqFY1U3XRs1IUPrScVAW6Cpse2Hwuls1zg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZ1aTQ666gknQV2Pn2oGNrNsZAFOitjpWOUI0iytGIkl++KTHob0h+07cTLwjrlGjr5PJefRZWVfKkdb/Nm98cYpvllqGbJoT5D0lni5E3nWhi9Yss9wGxqaOM5oHbcbDxQIiEY166xS92MH6dpC0oVvJFHRduNQYvUuPweBdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcIew9Au; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so3869348a12.0;
        Fri, 21 Feb 2025 12:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169006; x=1740773806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miYnUngQpr1RBbtYz7RIfEo7Bq9k1QEoiU4vEkueku4=;
        b=OcIew9AueyOKpXdzzk8DYr2590CHQfHueSL1zej80YYEPVG4/3vA0ukFDoBXwKWVaY
         FE/ssV5aBaph2gPuwZJ/Y9HelaWua8mMMaStO0QvMcaa5qMmg7KuQXvabbyeKWkp65Pr
         zm1rLcMydcTMKeN9tPFN/UOCgLld18GsoBevt5/K2OTBXGDv7jUXNdy14Dp/v3wxd4GX
         fkCXnWgEibdOR0qvnOv36ok7tVb4M/iLZ56bemTTaYnuotSJ0jim8FDKJJ+FZCUl1Gba
         M59wiDT/iq5U0cMF9L4Hli8Xp3f3IKbWWEiNvnsbuCNopFbT0cEF7Gb6FUZKgK+WbNW2
         ROVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169006; x=1740773806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miYnUngQpr1RBbtYz7RIfEo7Bq9k1QEoiU4vEkueku4=;
        b=wWh2btF2UxQZWtsDZM//KyYrpJj2MNQQWtXwDS4YJo3qFzDJdRbM6cKcNOr2WC1T/Q
         PpND/gR8sMAIdBcFq+Jf8ONlzsn1hjwXbnYzJCAhe744mtrDop8hT/qGbybrYZIojKh+
         wTLGTbv0lC3kppEMRFpNMGOXMU71F6qKfWUYRkG9GoY0gz0THrQyM1zFNkB/vpscOFg5
         0HEyOvmDgl//GZkMrx5Hs6KIN5OPq2YMX/xcmzfs/VX4352QEQH6Da2KguGWhR4hk+bt
         uc0JA+OkWcYencyixrTx7OF9R3O1V0sPOR8mTFoWuWckPR4Ur01qgn3tY9NaUK56l0eP
         vSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhqrntBmTZ+IigcO4f67nx8bbnG5tw4XXI8jAHPfKFEutdNkC+Bx/i6l5GnmxHZ4h/Ocj/53vX333pROnt@vger.kernel.org, AJvYcCUnh9izZOydREihwfLsRVfouSTsk+Cc6DagiyWUwiRgfKiLNQDURtelOrUL2R1fHTsZrzxLXthmDLrl@vger.kernel.org
X-Gm-Message-State: AOJu0YzVD3ZjKKFU1VZXetavWVHXsod/vU2/2Bhpsxb+QEAXKLIh8THG
	09M/8ldhIdQcmlrTyGuKILqJ3lWAiDz67JE0UoROwTXhPqlJUwSt
X-Gm-Gg: ASbGncufUIUfouLHFqL1VqT5NuKE1W2OJtgu8hcVZ4N4dJnpWzNLt7pxi9m9RUW68kw
	aIc6YL/AeLEvVkDCX4f9dCbB/B9xx9R9ykGZniQ0yHUiAGrjcC2X/blXQzD6NtTNDcS83TkOK0G
	T/XTblQlvSbr1tOoEnphJXHN4oavclIcBpZt5gXnnLK8919eZYPWZ260nx+VlVu6K263cHJEE3b
	mpBlsPK1ZiGzfanhK15OYMja8SAwuaR089/lXZ+hp69qZSa7HoEqVAZ/N+P2fS/G2rax8Ckxy2h
	xMBDmtol2cZ3Sipx1RVqWpQmM/Iyy1kba2YUHfUUSQo8hfVV4LHwju77R8XcczAqHGU6GArw
X-Google-Smtp-Source: AGHT+IH+ddk0y9Vp43Lz1Mi7hwJahr4hfcSEP6gjo/cTLcqwNotVJhq3xhFx3e7hTHT+W6++hPiFjQ==
X-Received: by 2002:a05:6402:3488:b0:5e0:51a9:d425 with SMTP id 4fb4d7f45d1cf-5e0b724ecfcmr4192236a12.29.1740169006081;
        Fri, 21 Feb 2025 12:16:46 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:45 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:30 +0100
Subject: [PATCH v5 8/9] regulator: bcm590xx: Rename BCM59056-specific data
 as such
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-8-065f516a9042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=21159;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oxEUTmHEMqFY1U3XRs1IUPrScVAW6Cpse2Hwuls1zg8=;
 b=Z63MQJowjvI/J396YdhRAWDOjK8tlmMLNWsb21Nvpt2wWCB+V+i0ksrqDp0z2FPiczObU8EuF
 5WfJ+6IaB3hBAqC6DyfRXEmUPG4Uh5/GeCTDdl1S10AV2FJNOych5KG
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Previously, the driver used the BCM590XX prefix for register data
specific to the BCM59056. As we will be introducing other regulators
to this driver as well, make the BCM59056-specific values use the
BCM59056 prefix.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v5:
- Adapt to rename of bcm590xx_reg_info to bcm590xx_reg_data

Changes in v4:
- Drop unused BCM590XX_MAX_NUM_REGS constant

Changes in v3:
- Added this commit
---
 drivers/regulator/bcm590xx-regulator.c | 369 +++++++++++++++++----------------
 1 file changed, 189 insertions(+), 180 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index c2427ea166626bdc1eb7cfb99997d95e5125ed91..f35b2b72e46f70496e16be5244529a5d95d0546d 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -18,146 +18,11 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
-/* I2C slave 0 registers */
-#define BCM590XX_RFLDOPMCTRL1	0x60
-#define BCM590XX_CAMLDO1PMCTRL1	0x62
-#define BCM590XX_CAMLDO2PMCTRL1	0x64
-#define BCM590XX_SIMLDO1PMCTRL1	0x66
-#define BCM590XX_SIMLDO2PMCTRL1	0x68
-#define BCM590XX_SDLDOPMCTRL1	0x6a
-#define BCM590XX_SDXLDOPMCTRL1	0x6c
-#define BCM590XX_MMCLDO1PMCTRL1	0x6e
-#define BCM590XX_MMCLDO2PMCTRL1	0x70
-#define BCM590XX_AUDLDOPMCTRL1	0x72
-#define BCM590XX_MICLDOPMCTRL1	0x74
-#define BCM590XX_USBLDOPMCTRL1	0x76
-#define BCM590XX_VIBLDOPMCTRL1	0x78
-#define BCM590XX_IOSR1PMCTRL1	0x7a
-#define BCM590XX_IOSR2PMCTRL1	0x7c
-#define BCM590XX_CSRPMCTRL1	0x7e
-#define BCM590XX_SDSR1PMCTRL1	0x82
-#define BCM590XX_SDSR2PMCTRL1	0x86
-#define BCM590XX_MSRPMCTRL1	0x8a
-#define BCM590XX_VSRPMCTRL1	0x8e
-#define BCM590XX_RFLDOCTRL	0x96
-#define BCM590XX_CAMLDO1CTRL	0x97
-#define BCM590XX_CAMLDO2CTRL	0x98
-#define BCM590XX_SIMLDO1CTRL	0x99
-#define BCM590XX_SIMLDO2CTRL	0x9a
-#define BCM590XX_SDLDOCTRL	0x9b
-#define BCM590XX_SDXLDOCTRL	0x9c
-#define BCM590XX_MMCLDO1CTRL	0x9d
-#define BCM590XX_MMCLDO2CTRL	0x9e
-#define BCM590XX_AUDLDOCTRL	0x9f
-#define BCM590XX_MICLDOCTRL	0xa0
-#define BCM590XX_USBLDOCTRL	0xa1
-#define BCM590XX_VIBLDOCTRL	0xa2
-#define BCM590XX_CSRVOUT1	0xc0
-#define BCM590XX_IOSR1VOUT1	0xc3
-#define BCM590XX_IOSR2VOUT1	0xc6
-#define BCM590XX_MSRVOUT1	0xc9
-#define BCM590XX_SDSR1VOUT1	0xcc
-#define BCM590XX_SDSR2VOUT1	0xcf
-#define BCM590XX_VSRVOUT1	0xd2
-
-/* I2C slave 1 registers */
-#define BCM590XX_GPLDO5PMCTRL1	0x16
-#define BCM590XX_GPLDO6PMCTRL1	0x18
-#define BCM590XX_GPLDO1CTRL	0x1a
-#define BCM590XX_GPLDO2CTRL	0x1b
-#define BCM590XX_GPLDO3CTRL	0x1c
-#define BCM590XX_GPLDO4CTRL	0x1d
-#define BCM590XX_GPLDO5CTRL	0x1e
-#define BCM590XX_GPLDO6CTRL	0x1f
-#define BCM590XX_OTG_CTRL	0x40
-#define BCM590XX_GPLDO1PMCTRL1	0x57
-#define BCM590XX_GPLDO2PMCTRL1	0x59
-#define BCM590XX_GPLDO3PMCTRL1	0x5b
-#define BCM590XX_GPLDO4PMCTRL1	0x5d
-
 #define BCM590XX_REG_ENABLE	BIT(7)
 #define BCM590XX_VBUS_ENABLE	BIT(2)
 #define BCM590XX_LDO_VSEL_MASK	GENMASK(5, 3)
 #define BCM590XX_SR_VSEL_MASK	GENMASK(5, 0)
 
-/*
- * RFLDO to VSR regulators are
- * accessed via I2C slave 0
- */
-
-/* LDO regulator IDs */
-#define BCM590XX_REG_RFLDO	0
-#define BCM590XX_REG_CAMLDO1	1
-#define BCM590XX_REG_CAMLDO2	2
-#define BCM590XX_REG_SIMLDO1	3
-#define BCM590XX_REG_SIMLDO2	4
-#define BCM590XX_REG_SDLDO	5
-#define BCM590XX_REG_SDXLDO	6
-#define BCM590XX_REG_MMCLDO1	7
-#define BCM590XX_REG_MMCLDO2	8
-#define BCM590XX_REG_AUDLDO	9
-#define BCM590XX_REG_MICLDO	10
-#define BCM590XX_REG_USBLDO	11
-#define BCM590XX_REG_VIBLDO	12
-
-/* DCDC regulator IDs */
-#define BCM590XX_REG_CSR	13
-#define BCM590XX_REG_IOSR1	14
-#define BCM590XX_REG_IOSR2	15
-#define BCM590XX_REG_MSR	16
-#define BCM590XX_REG_SDSR1	17
-#define BCM590XX_REG_SDSR2	18
-#define BCM590XX_REG_VSR	19
-
-/*
- * GPLDO1 to VBUS regulators are
- * accessed via I2C slave 1
- */
-
-#define BCM590XX_REG_GPLDO1	20
-#define BCM590XX_REG_GPLDO2	21
-#define BCM590XX_REG_GPLDO3	22
-#define BCM590XX_REG_GPLDO4	23
-#define BCM590XX_REG_GPLDO5	24
-#define BCM590XX_REG_GPLDO6	25
-#define BCM590XX_REG_VBUS	26
-
-#define BCM590XX_NUM_REGS	27
-
-/* LDO group A: supported voltages in microvolts */
-static const unsigned int ldo_a_table[] = {
-	1200000, 1800000, 2500000, 2700000, 2800000,
-	2900000, 3000000, 3300000,
-};
-
-/* LDO group C: supported voltages in microvolts */
-static const unsigned int ldo_c_table[] = {
-	3100000, 1800000, 2500000, 2700000, 2800000,
-	2900000, 3000000, 3300000,
-};
-
-/* DCDC group CSR: supported voltages in microvolts */
-static const struct linear_range dcdc_csr_ranges[] = {
-	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
-	REGULATOR_LINEAR_RANGE(1360000, 51, 55, 20000),
-	REGULATOR_LINEAR_RANGE(900000, 56, 63, 0),
-};
-
-/* DCDC group IOSR1: supported voltages in microvolts */
-static const struct linear_range dcdc_iosr1_ranges[] = {
-	REGULATOR_LINEAR_RANGE(860000, 2, 51, 10000),
-	REGULATOR_LINEAR_RANGE(1500000, 52, 52, 0),
-	REGULATOR_LINEAR_RANGE(1800000, 53, 53, 0),
-	REGULATOR_LINEAR_RANGE(900000, 54, 63, 0),
-};
-
-/* DCDC group SDSR1: supported voltages in microvolts */
-static const struct linear_range dcdc_sdsr1_ranges[] = {
-	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
-	REGULATOR_LINEAR_RANGE(1340000, 51, 51, 0),
-	REGULATOR_LINEAR_RANGE(900000, 52, 63, 0),
-};
-
 enum bcm590xx_reg_type {
 	BCM590XX_REG_TYPE_LDO,
 	BCM590XX_REG_TYPE_GPLDO,
@@ -203,43 +68,187 @@ static const struct regulator_ops bcm590xx_ops_vbus = {
 	.disable		= regulator_disable_regmap,
 };
 
-#define BCM590XX_REG_DESC(_name, _name_lower)				\
-	.id = BCM590XX_REG_##_name,					\
+#define BCM590XX_REG_DESC(_model, _name, _name_lower)			\
+	.id = _model##_REG_##_name,					\
 	.name = #_name_lower,						\
 	.of_match = of_match_ptr(#_name_lower),				\
 	.regulators_node = of_match_ptr("regulators"),			\
 	.type = REGULATOR_VOLTAGE,					\
 	.owner = THIS_MODULE						\
 
-#define BCM590XX_LDO_DESC(_name, _name_lower, _table)			\
-	BCM590XX_REG_DESC(_name, _name_lower),				\
+#define BCM590XX_LDO_DESC(_model, _model_lower, _name, _name_lower, _table) \
+	BCM590XX_REG_DESC(_model, _name, _name_lower),			\
 	.ops = &bcm590xx_ops_ldo,					\
-	.n_voltages = ARRAY_SIZE(_table),				\
-	.volt_table = _table,						\
-	.vsel_reg = BCM590XX_##_name##CTRL,				\
+	.n_voltages = ARRAY_SIZE(_model_lower##_##_table),		\
+	.volt_table = _model_lower##_##_table,				\
+	.vsel_reg = _model##_##_name##CTRL,				\
 	.vsel_mask = BCM590XX_LDO_VSEL_MASK,				\
-	.enable_reg = BCM590XX_##_name##PMCTRL1,			\
+	.enable_reg = _model##_##_name##PMCTRL1,			\
 	.enable_mask = BCM590XX_REG_ENABLE,				\
 	.enable_is_inverted = true
 
-#define BCM590XX_SR_DESC(_name, _name_lower, _ranges)			\
-	BCM590XX_REG_DESC(_name, _name_lower),				\
+#define BCM590XX_SR_DESC(_model, _model_lower, _name, _name_lower, _ranges) \
+	BCM590XX_REG_DESC(_model, _name, _name_lower),			\
 	.ops = &bcm590xx_ops_dcdc,					\
 	.n_voltages = 64,						\
-	.linear_ranges = _ranges,					\
-	.n_linear_ranges = ARRAY_SIZE(_ranges),				\
-	.vsel_reg = BCM590XX_##_name##VOUT1,				\
+	.linear_ranges = _model_lower##_##_ranges,			\
+	.n_linear_ranges = ARRAY_SIZE(_model_lower##_##_ranges),	\
+	.vsel_reg = _model##_##_name##VOUT1,				\
 	.vsel_mask = BCM590XX_SR_VSEL_MASK,				\
-	.enable_reg = BCM590XX_##_name##PMCTRL1,			\
+	.enable_reg = _model##_##_name##PMCTRL1,			\
 	.enable_mask = BCM590XX_REG_ENABLE,				\
 	.enable_is_inverted = true
 
-static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
+#define BCM59056_REG_DESC(_name, _name_lower)				\
+	BCM590XX_REG_DESC(BCM59056, _name, _name_lower)
+#define BCM59056_LDO_DESC(_name, _name_lower, _table)			\
+	BCM590XX_LDO_DESC(BCM59056, bcm59056, _name, _name_lower, _table)
+#define BCM59056_SR_DESC(_name, _name_lower, _ranges)			\
+	BCM590XX_SR_DESC(BCM59056, bcm59056, _name, _name_lower, _ranges)
+
+/* BCM59056 data */
+
+/* I2C slave 0 registers */
+#define BCM59056_RFLDOPMCTRL1	0x60
+#define BCM59056_CAMLDO1PMCTRL1	0x62
+#define BCM59056_CAMLDO2PMCTRL1	0x64
+#define BCM59056_SIMLDO1PMCTRL1	0x66
+#define BCM59056_SIMLDO2PMCTRL1	0x68
+#define BCM59056_SDLDOPMCTRL1	0x6a
+#define BCM59056_SDXLDOPMCTRL1	0x6c
+#define BCM59056_MMCLDO1PMCTRL1	0x6e
+#define BCM59056_MMCLDO2PMCTRL1	0x70
+#define BCM59056_AUDLDOPMCTRL1	0x72
+#define BCM59056_MICLDOPMCTRL1	0x74
+#define BCM59056_USBLDOPMCTRL1	0x76
+#define BCM59056_VIBLDOPMCTRL1	0x78
+#define BCM59056_IOSR1PMCTRL1	0x7a
+#define BCM59056_IOSR2PMCTRL1	0x7c
+#define BCM59056_CSRPMCTRL1	0x7e
+#define BCM59056_SDSR1PMCTRL1	0x82
+#define BCM59056_SDSR2PMCTRL1	0x86
+#define BCM59056_MSRPMCTRL1	0x8a
+#define BCM59056_VSRPMCTRL1	0x8e
+#define BCM59056_RFLDOCTRL	0x96
+#define BCM59056_CAMLDO1CTRL	0x97
+#define BCM59056_CAMLDO2CTRL	0x98
+#define BCM59056_SIMLDO1CTRL	0x99
+#define BCM59056_SIMLDO2CTRL	0x9a
+#define BCM59056_SDLDOCTRL	0x9b
+#define BCM59056_SDXLDOCTRL	0x9c
+#define BCM59056_MMCLDO1CTRL	0x9d
+#define BCM59056_MMCLDO2CTRL	0x9e
+#define BCM59056_AUDLDOCTRL	0x9f
+#define BCM59056_MICLDOCTRL	0xa0
+#define BCM59056_USBLDOCTRL	0xa1
+#define BCM59056_VIBLDOCTRL	0xa2
+#define BCM59056_CSRVOUT1	0xc0
+#define BCM59056_IOSR1VOUT1	0xc3
+#define BCM59056_IOSR2VOUT1	0xc6
+#define BCM59056_MSRVOUT1	0xc9
+#define BCM59056_SDSR1VOUT1	0xcc
+#define BCM59056_SDSR2VOUT1	0xcf
+#define BCM59056_VSRVOUT1	0xd2
+
+/* I2C slave 1 registers */
+#define BCM59056_GPLDO5PMCTRL1	0x16
+#define BCM59056_GPLDO6PMCTRL1	0x18
+#define BCM59056_GPLDO1CTRL	0x1a
+#define BCM59056_GPLDO2CTRL	0x1b
+#define BCM59056_GPLDO3CTRL	0x1c
+#define BCM59056_GPLDO4CTRL	0x1d
+#define BCM59056_GPLDO5CTRL	0x1e
+#define BCM59056_GPLDO6CTRL	0x1f
+#define BCM59056_OTG_CTRL	0x40
+#define BCM59056_GPLDO1PMCTRL1	0x57
+#define BCM59056_GPLDO2PMCTRL1	0x59
+#define BCM59056_GPLDO3PMCTRL1	0x5b
+#define BCM59056_GPLDO4PMCTRL1	0x5d
+
+/*
+ * RFLDO to VSR regulators are
+ * accessed via I2C slave 0
+ */
+
+/* LDO regulator IDs */
+#define BCM59056_REG_RFLDO	0
+#define BCM59056_REG_CAMLDO1	1
+#define BCM59056_REG_CAMLDO2	2
+#define BCM59056_REG_SIMLDO1	3
+#define BCM59056_REG_SIMLDO2	4
+#define BCM59056_REG_SDLDO	5
+#define BCM59056_REG_SDXLDO	6
+#define BCM59056_REG_MMCLDO1	7
+#define BCM59056_REG_MMCLDO2	8
+#define BCM59056_REG_AUDLDO	9
+#define BCM59056_REG_MICLDO	10
+#define BCM59056_REG_USBLDO	11
+#define BCM59056_REG_VIBLDO	12
+
+/* DCDC regulator IDs */
+#define BCM59056_REG_CSR	13
+#define BCM59056_REG_IOSR1	14
+#define BCM59056_REG_IOSR2	15
+#define BCM59056_REG_MSR	16
+#define BCM59056_REG_SDSR1	17
+#define BCM59056_REG_SDSR2	18
+#define BCM59056_REG_VSR	19
+
+/*
+ * GPLDO1 to VBUS regulators are
+ * accessed via I2C slave 1
+ */
+
+#define BCM59056_REG_GPLDO1	20
+#define BCM59056_REG_GPLDO2	21
+#define BCM59056_REG_GPLDO3	22
+#define BCM59056_REG_GPLDO4	23
+#define BCM59056_REG_GPLDO5	24
+#define BCM59056_REG_GPLDO6	25
+#define BCM59056_REG_VBUS	26
+
+#define BCM59056_NUM_REGS	27
+
+/* LDO group A: supported voltages in microvolts */
+static const unsigned int bcm59056_ldo_a_table[] = {
+	1200000, 1800000, 2500000, 2700000, 2800000,
+	2900000, 3000000, 3300000,
+};
+
+/* LDO group C: supported voltages in microvolts */
+static const unsigned int bcm59056_ldo_c_table[] = {
+	3100000, 1800000, 2500000, 2700000, 2800000,
+	2900000, 3000000, 3300000,
+};
+
+/* DCDC group CSR: supported voltages in microvolts */
+static const struct linear_range bcm59056_dcdc_csr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
+	REGULATOR_LINEAR_RANGE(1360000, 51, 55, 20000),
+	REGULATOR_LINEAR_RANGE(900000, 56, 63, 0),
+};
+
+/* DCDC group IOSR1: supported voltages in microvolts */
+static const struct linear_range bcm59056_dcdc_iosr1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(860000, 2, 51, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 52, 52, 0),
+	REGULATOR_LINEAR_RANGE(1800000, 53, 53, 0),
+	REGULATOR_LINEAR_RANGE(900000, 54, 63, 0),
+};
+
+/* DCDC group SDSR1: supported voltages in microvolts */
+static const struct linear_range bcm59056_dcdc_sdsr1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
+	REGULATOR_LINEAR_RANGE(1340000, 51, 51, 0),
+	REGULATOR_LINEAR_RANGE(900000, 52, 63, 0),
+};
+
+static const struct bcm590xx_reg_data bcm59056_regs[BCM59056_NUM_REGS] = {
 	{
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(RFLDO, rfldo, ldo_a_table),
+			BCM59056_LDO_DESC(RFLDO, rfldo, ldo_a_table),
 		},
 	},
 
@@ -247,7 +256,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(CAMLDO1, camldo1, ldo_c_table),
+			BCM59056_LDO_DESC(CAMLDO1, camldo1, ldo_c_table),
 		},
 	},
 
@@ -255,7 +264,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(CAMLDO2, camldo2, ldo_c_table),
+			BCM59056_LDO_DESC(CAMLDO2, camldo2, ldo_c_table),
 		},
 	},
 
@@ -263,7 +272,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SIMLDO1, simldo1, ldo_a_table),
+			BCM59056_LDO_DESC(SIMLDO1, simldo1, ldo_a_table),
 		},
 	},
 
@@ -271,7 +280,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SIMLDO2, simldo2, ldo_a_table),
+			BCM59056_LDO_DESC(SIMLDO2, simldo2, ldo_a_table),
 		},
 	},
 
@@ -279,7 +288,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SDLDO, sdldo, ldo_c_table),
+			BCM59056_LDO_DESC(SDLDO, sdldo, ldo_c_table),
 		},
 	},
 
@@ -287,7 +296,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SDXLDO, sdxldo, ldo_a_table),
+			BCM59056_LDO_DESC(SDXLDO, sdxldo, ldo_a_table),
 		},
 	},
 
@@ -295,7 +304,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(MMCLDO1, mmcldo1, ldo_a_table),
+			BCM59056_LDO_DESC(MMCLDO1, mmcldo1, ldo_a_table),
 		},
 	},
 
@@ -303,7 +312,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(MMCLDO2, mmcldo2, ldo_a_table),
+			BCM59056_LDO_DESC(MMCLDO2, mmcldo2, ldo_a_table),
 		},
 	},
 
@@ -311,7 +320,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(AUDLDO, audldo, ldo_a_table),
+			BCM59056_LDO_DESC(AUDLDO, audldo, ldo_a_table),
 		},
 	},
 
@@ -319,7 +328,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(MICLDO, micldo, ldo_a_table),
+			BCM59056_LDO_DESC(MICLDO, micldo, ldo_a_table),
 		},
 	},
 
@@ -327,7 +336,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(USBLDO, usbldo, ldo_a_table),
+			BCM59056_LDO_DESC(USBLDO, usbldo, ldo_a_table),
 		},
 	},
 
@@ -335,7 +344,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(VIBLDO, vibldo, ldo_c_table),
+			BCM59056_LDO_DESC(VIBLDO, vibldo, ldo_c_table),
 		},
 	},
 
@@ -343,7 +352,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(CSR, csr, dcdc_csr_ranges),
+			BCM59056_SR_DESC(CSR, csr, dcdc_csr_ranges),
 		},
 	},
 
@@ -351,7 +360,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(IOSR1, iosr1, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(IOSR1, iosr1, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -359,7 +368,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(IOSR2, iosr2, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(IOSR2, iosr2, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -367,7 +376,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(MSR, msr, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(MSR, msr, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -375,7 +384,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(SDSR1, sdsr1, dcdc_sdsr1_ranges),
+			BCM59056_SR_DESC(SDSR1, sdsr1, dcdc_sdsr1_ranges),
 		},
 	},
 
@@ -383,7 +392,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(SDSR2, sdsr2, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(SDSR2, sdsr2, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -391,7 +400,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(VSR, vsr, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(VSR, vsr, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -399,7 +408,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO1, gpldo1, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO1, gpldo1, ldo_a_table),
 		},
 	},
 
@@ -407,7 +416,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO2, gpldo2, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO2, gpldo2, ldo_a_table),
 		},
 	},
 
@@ -415,7 +424,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO3, gpldo3, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO3, gpldo3, ldo_a_table),
 		},
 	},
 
@@ -423,7 +432,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO4, gpldo4, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO4, gpldo4, ldo_a_table),
 		},
 	},
 
@@ -431,7 +440,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO5, gpldo5, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO5, gpldo5, ldo_a_table),
 		},
 	},
 
@@ -439,7 +448,7 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO6, gpldo6, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO6, gpldo6, ldo_a_table),
 		},
 	},
 
@@ -447,11 +456,11 @@ static const struct bcm590xx_reg_data bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_VBUS,
 		.regmap = BCM590XX_REGMAP_SEC,
 		.desc = {
-			BCM590XX_REG_DESC(VBUS, vbus),
+			BCM59056_REG_DESC(VBUS, vbus),
 			.ops = &bcm590xx_ops_vbus,
 			.n_voltages = 1,
 			.fixed_uV = 5000000,
-			.enable_reg = BCM590XX_OTG_CTRL,
+			.enable_reg = BCM59056_OTG_CTRL,
 			.enable_mask = BCM590XX_VBUS_ENABLE,
 		},
 	},
@@ -471,8 +480,8 @@ static int bcm590xx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pmu->mfd = bcm590xx;
-	pmu->n_regulators = BCM590XX_NUM_REGS;
-	pmu->regs = bcm590xx_regs;
+	pmu->n_regulators = BCM59056_NUM_REGS;
+	pmu->regs = bcm59056_regs;
 
 	platform_set_drvdata(pdev, pmu);
 

-- 
2.48.1


