Return-Path: <linux-kernel+bounces-543280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2FA4D3C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C896A173082
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF41F9EC0;
	Tue,  4 Mar 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVaV1qz1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779431F561C;
	Tue,  4 Mar 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069268; cv=none; b=aJQxDKaIf/xSuXyksHe+F+npZP3En1bc444i9IwSNC6nOfwVKR2nmu84lmURSaDyLDygOZMvY1NvySMQfUD+7ppT6nRutlea7sKRHAsOwlrua8J6w7Gd6sLZy1YkI/1Wa7x4u3hob+egaFBM2CElVb+puzAqNkaOhx5ndvhuxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069268; c=relaxed/simple;
	bh=oxEUTmHEMqFY1U3XRs1IUPrScVAW6Cpse2Hwuls1zg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzVeY2AuUjZq2nxIPcsm/LuiXnzVYqWQMBopAmjwPnXdyGFb/FL0IIxd0iOjFzIs4FO7gx/r+MI7sNyJV8LGByID0ntYHr/1T2XgAyozz3FggDX6CwS98rUgPTYJnTHO/ZO6hdN1I7uCbsGWyg8dJa2RYk6qfDwraeWQAhpZe28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVaV1qz1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso5861306a12.0;
        Mon, 03 Mar 2025 22:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069265; x=1741674065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miYnUngQpr1RBbtYz7RIfEo7Bq9k1QEoiU4vEkueku4=;
        b=gVaV1qz1Rh/+Y+d/42+UqU/1l1QMB/YJGbuiB0FDxmDNHGQWADgLMairi/31F21qq1
         kXVAIP3I2YgyhXRr2F4c6YWbdOBf9A5EKuPPeNI491Mq2EYM7ST8CftQGZMgDav5Fd7E
         hx+OCu1UPGBg6qnkkY38TZ3btyUqTBn6aDorsAI09PcYGMpbEdPzklAaFN5ExCE97YS+
         XREbYepvy4ZL2kpsdEppNEUIN0tbX9ZYRYYoUAtI5vrLKVfSx0wOffv7C2bT24wV9YXA
         AYAbA4NWTkybd1yt3h7CEwGrX2v1zJJQe/YshlBskPxVoHH7kF7taSW2UDTITizY4pnb
         Te4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069265; x=1741674065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miYnUngQpr1RBbtYz7RIfEo7Bq9k1QEoiU4vEkueku4=;
        b=RRGFc7Xr/2gCl9bfn+gO7r20P4fzpxYC8/TKu18OL8szYIPZ0ri2XW93E3sHxaI52R
         fslNLEYYnPuUNVoOxsRN4h/+M3IZvo9l4Ts9fNDIjINYHEeyykMQddTrzkC/NIDpgooY
         JPpNvpcW6VsVP0w1aE79J3NkZP1Ys96XTN6PZPJciNZyKjwSXuagYtzb/lo0wgC+n+oX
         qo13sowC3cAizQfYAGzqpbekJGq1S4a5G1N0sdnwmPti0qJuqVuGukJ/EfyVzm2ERRxv
         eWf8wJu8iinyFiLOQubZx1RpEaqF+R3pR8ccxTkYuQEBrTPt+OLuiMcARW/m07TwUhbz
         Btew==
X-Forwarded-Encrypted: i=1; AJvYcCUtxSXCh+V998Q/Zta695izyDgRDlxEpPKpdXBgQyzHFhoLKZN1k2f0EdN6Ce5Qu9/DvUZPjs8MNxlr@vger.kernel.org, AJvYcCVNCyeJPkYskeGgjSwYKFIuihFvkZN2Sw6P6QNjrB5yGsv9b2n+paEDnBhixIgp16Bt+TCvpcXkBPoaOiqd@vger.kernel.org
X-Gm-Message-State: AOJu0YysshtW19G8/yzF5XiJw/IO+IXGxjr226osXinhFTXxY2dgJIUM
	VUXxJWAhDLk16gdacVrTvfGpw53/4er4cLUOSUl8fcHXCa9Zq2dn
X-Gm-Gg: ASbGncsmqKd+fny7G9IEbBj8NPKkGaWITZB1A7V9XO7usipD5aZmWJkaZV2vj850G0i
	L1Ptab1U3VagCMXFtf+rr0fUnC8Bo6wsI7SlI+N4yoKIXgnOIs+LT/pttU/+d/YDZsNtXWo/xef
	i5nfu+oTI5JEldrCWVbJH4neZizuoAoSKjNX5/ML5f+n2Oken0lL0CdUTzcr7IlQMnB5vv7rACv
	qOt32x79Ez+GY1HSXQyqeCARkMduXWIzh8GNDjTeskuL0UZ5ek4Eu7Zd0MzUL3cGLLsJEq+9Y7+
	khdJVz+YEXiQNrXOTbN4FT/E4Z3mCnvYnVqvnEWodBxnU4pgFJvj/xguVMKEpbBoplRTIoUI0rI
	uVERCUK7HBsvSmjQ=
X-Google-Smtp-Source: AGHT+IGnrGBvm7CMFqDx1JUu51OqAVF8+Jt5v/BXKRxu3NA1l5uHOM2UKCQGexbdQGGob0SLuYbtFQ==
X-Received: by 2002:a05:6402:1e8c:b0:5e4:95d0:7e1f with SMTP id 4fb4d7f45d1cf-5e4d6b75f1cmr16106909a12.29.1741069264508;
        Mon, 03 Mar 2025 22:21:04 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:21:03 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:40 +0100
Subject: [PATCH v6 09/10] regulator: bcm590xx: Rename BCM59056-specific
 data as such
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-9-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069240; l=21159;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oxEUTmHEMqFY1U3XRs1IUPrScVAW6Cpse2Hwuls1zg8=;
 b=umyboGj460WS5aWES07FZid6AFamR9stxFLJiH6GhYUl2Fmc/XxGmJuZ1OguOjT0Y5z8EzCZ7
 8rcJbZAPBPUAeqfkq3YAERD34Edqk9/O1S43IIya/3hKjpRz2/eZ+jb
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


