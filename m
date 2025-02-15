Return-Path: <linux-kernel+bounces-516111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72816A36D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01033B13B1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC81A23AF;
	Sat, 15 Feb 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbyDNNAO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8871C7011;
	Sat, 15 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612405; cv=none; b=a3wgVszIR0BNQvSesDOLJvRFq9VsZq5+XBRwPrhODdm0gwtyb9MejNVKhvh6eqCFUd0WRhYWHHLWJ7adgP4CtIoeUTSjrqIkdY/JqFUwbLqYFU9y2swthJSa2T3TY6gh3ppovCNnxsJc/R7TqKT3nOGZqIwM8j7F/ZszyV6QLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612405; c=relaxed/simple;
	bh=oqYohYF5Ie71jrnWUAni9suTN+a2bL/YZmEvhNG2mIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrY6vnlAef36N+uhTat0DpJohPiaUdnma4LEaAMj7lIgxftElv2572ac2C1NytL/t+DPqHbyFRXVpgzWGzzdkAi80a9t05VngYi7DMIqoTGtdHc0dWrxp4mSm7rrL7gH57VgYLfa4Hk1FuQpv3lTrPfuVV31+DQlcAmiVAqdXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbyDNNAO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so5104771a12.1;
        Sat, 15 Feb 2025 01:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612401; x=1740217201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQRjrA34g5L40Z+Leo9ARcvitfo0oKGEzHv4pYRxdtY=;
        b=jbyDNNAOlyGZ7TGBuhzIFtnF05MmoJ8udNgyiFTvGakihWHvGh+TpWLwHhSWgVps9D
         ltmU+SWbkbxv47GGTvjHM48HlbLiGOEF6nyXq5eLd2IzOOxlGr0B5v40cREv7zd1SsII
         BOwWyEmkNLiS3NnM7l+RjXY/N4B0lnt4QeKPyof0JcQySXPJHWzbjFVGxOAmIeaScr6G
         2xvOfsnxwfBw7+SvVjtYFYoXZ3HtdR+HniV+/uxogbUPwyKSnYapscU9Fc2Zx/3Krkz3
         ekVIQeFvK/V8kI60RTcEy6oukJnp6oZoQwn3Tr2yVnK1hzBjrdOZ7W3ea2IcDWCDgzSr
         I1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612401; x=1740217201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQRjrA34g5L40Z+Leo9ARcvitfo0oKGEzHv4pYRxdtY=;
        b=roetX8WlQCAMl2dFYOiq2Uus9+bF7l9JyuLMqUkrlJDzHO8jn1EVKLXIdvgJgU+re4
         3ftuhz6S3pTveJCjbjQrVoNd2uFZbS6U1f4yu37jYnJDGgMdwJ4Ukk50zHK1UnUnWg3c
         yi4VNnsm5tHypBffsOJnNy07QjwPKfhSNKg6OobdUwMq0if8YVEyPXdoIyQQBNcPk8rj
         KZ9pz9oKcEXfDYXxsireNCi+e3H79C4mItEDMDGHjYMdBw36g/v0Gwdc3p6GrVmnlcrg
         V47sIMrU+lPq9DuOViZnH0jJbZCg8eO2a0ij0QPbbdsxSfAN/y/jCOAjFaMVDA1EY7a7
         yclg==
X-Forwarded-Encrypted: i=1; AJvYcCVD0ercnBClVW+NpjijJa/dkWnH2bQcwn4cOc08Pu5N/SAGY4eNylu4iCAtus1cZ/Y5sSlU/oEtL2h5JZOB@vger.kernel.org, AJvYcCXG1FN7aFO/PcpxudKC8CDsDQjfpoeoDc6wEUVyv5x4yCfBEvz7HhqYhANfqg5HKo3OP1kMJq1p6oh2@vger.kernel.org
X-Gm-Message-State: AOJu0YxsldeiIvU9vuWsOg/lPfrbEIpcjKWPuD+HFTjTGBqOUjRm5Lkl
	tiAv1sjhPDmolF6GGmjeIpOw/wZbWnZtj0+rqBS7Sxm2NCEWHBxE
X-Gm-Gg: ASbGncuwyvNQyx186LAFh/K0HEj+u/QoMv+y3sdzGS8JIFyP7lK2oeEVmr7qHNrAtLI
	Zw+5VkirV09V2cEFTwzKnT6OY1JniosSJcqX+Caa0RRRr5axrmJRd0ZmSLB5ExJ3t5AErhaVgB0
	7Bndg17D56pTjRQl/KZP1Farvg73jYC3GwDjLkd4g5Tq1GPKU0vDrM8kvy3IIJIaW3gHm9Os7XN
	CkM9iv5cZv3BOq3D2H8xhobgMb3nUTJcWp0IcqvaW+nM0BK8wJbKg0+/oL1BkukGmmseuvaJykQ
	yKRvt13Xkn7M8oXRtEKIs8h3JE6tcJFZEiC+G3pJaBKkTCBGmZw4Vt51PdFc2Q==
X-Google-Smtp-Source: AGHT+IHtmvpfzlPG7kqanOLatUnJZJdDk3bGEzuKxCepmc1qSUJmR2+4qBUOtrk11Sqn8Y2mfbuL7w==
X-Received: by 2002:a17:906:3112:b0:ab7:d454:11c9 with SMTP id a640c23a62f3a-abb70a798b4mr157267166b.8.1739612401330;
        Sat, 15 Feb 2025 01:40:01 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:59 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:43 +0100
Subject: [PATCH v4 8/9] regulator: bcm590xx: Rename BCM59056-specific data
 as such
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-8-dbfb2d76a855@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=21188;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oqYohYF5Ie71jrnWUAni9suTN+a2bL/YZmEvhNG2mIs=;
 b=esdj7ao1q/E0rzsOy6o/kT2+zIv8N9H555GhxzgZDk1MbIb75+ILwh/tfplgl8+/4f+WZ/Fee
 oRWdn4v7xqXBM5afpC+8pzjeFA6qq+HzatDnKOf+oUJnxH0OW5EGN5z
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Previously, the driver used the BCM590XX prefix for register data
specific to the BCM59056. As we will be introducing other regulators
to this driver as well, make the BCM59056-specific values use the
BCM59056 prefix.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Drop unused BCM590XX_MAX_NUM_REGS constant

Changes in v3:
- Added this commit
---
 drivers/regulator/bcm590xx-regulator.c | 369 +++++++++++++++++----------------
 1 file changed, 189 insertions(+), 180 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 1c73bc880233dec635bcc82c98c763e4f26e0ae1..ccae8f82999b0af085eb40dc31227d345e41462b 100644
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
@@ -208,43 +73,187 @@ static const struct regulator_ops bcm590xx_ops_vbus = {
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
 
-static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
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
+static const struct bcm590xx_reg_info bcm59056_regs[BCM59056_NUM_REGS] = {
 	{
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(RFLDO, rfldo, ldo_a_table),
+			BCM59056_LDO_DESC(RFLDO, rfldo, ldo_a_table),
 		},
 	},
 
@@ -252,7 +261,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(CAMLDO1, camldo1, ldo_c_table),
+			BCM59056_LDO_DESC(CAMLDO1, camldo1, ldo_c_table),
 		},
 	},
 
@@ -260,7 +269,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(CAMLDO2, camldo2, ldo_c_table),
+			BCM59056_LDO_DESC(CAMLDO2, camldo2, ldo_c_table),
 		},
 	},
 
@@ -268,7 +277,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SIMLDO1, simldo1, ldo_a_table),
+			BCM59056_LDO_DESC(SIMLDO1, simldo1, ldo_a_table),
 		},
 	},
 
@@ -276,7 +285,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SIMLDO2, simldo2, ldo_a_table),
+			BCM59056_LDO_DESC(SIMLDO2, simldo2, ldo_a_table),
 		},
 	},
 
@@ -284,7 +293,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SDLDO, sdldo, ldo_c_table),
+			BCM59056_LDO_DESC(SDLDO, sdldo, ldo_c_table),
 		},
 	},
 
@@ -292,7 +301,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(SDXLDO, sdxldo, ldo_a_table),
+			BCM59056_LDO_DESC(SDXLDO, sdxldo, ldo_a_table),
 		},
 	},
 
@@ -300,7 +309,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(MMCLDO1, mmcldo1, ldo_a_table),
+			BCM59056_LDO_DESC(MMCLDO1, mmcldo1, ldo_a_table),
 		},
 	},
 
@@ -308,7 +317,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(MMCLDO2, mmcldo2, ldo_a_table),
+			BCM59056_LDO_DESC(MMCLDO2, mmcldo2, ldo_a_table),
 		},
 	},
 
@@ -316,7 +325,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(AUDLDO, audldo, ldo_a_table),
+			BCM59056_LDO_DESC(AUDLDO, audldo, ldo_a_table),
 		},
 	},
 
@@ -324,7 +333,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(MICLDO, micldo, ldo_a_table),
+			BCM59056_LDO_DESC(MICLDO, micldo, ldo_a_table),
 		},
 	},
 
@@ -332,7 +341,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(USBLDO, usbldo, ldo_a_table),
+			BCM59056_LDO_DESC(USBLDO, usbldo, ldo_a_table),
 		},
 	},
 
@@ -340,7 +349,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_LDO,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_LDO_DESC(VIBLDO, vibldo, ldo_c_table),
+			BCM59056_LDO_DESC(VIBLDO, vibldo, ldo_c_table),
 		},
 	},
 
@@ -348,7 +357,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(CSR, csr, dcdc_csr_ranges),
+			BCM59056_SR_DESC(CSR, csr, dcdc_csr_ranges),
 		},
 	},
 
@@ -356,7 +365,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(IOSR1, iosr1, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(IOSR1, iosr1, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -364,7 +373,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(IOSR2, iosr2, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(IOSR2, iosr2, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -372,7 +381,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(MSR, msr, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(MSR, msr, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -380,7 +389,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(SDSR1, sdsr1, dcdc_sdsr1_ranges),
+			BCM59056_SR_DESC(SDSR1, sdsr1, dcdc_sdsr1_ranges),
 		},
 	},
 
@@ -388,7 +397,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(SDSR2, sdsr2, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(SDSR2, sdsr2, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -396,7 +405,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_SR,
 		.regmap = BCM590XX_REG_REGMAP_PRI,
 		.desc = {
-			BCM590XX_SR_DESC(VSR, vsr, dcdc_iosr1_ranges),
+			BCM59056_SR_DESC(VSR, vsr, dcdc_iosr1_ranges),
 		},
 	},
 
@@ -404,7 +413,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO1, gpldo1, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO1, gpldo1, ldo_a_table),
 		},
 	},
 
@@ -412,7 +421,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO2, gpldo2, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO2, gpldo2, ldo_a_table),
 		},
 	},
 
@@ -420,7 +429,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO3, gpldo3, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO3, gpldo3, ldo_a_table),
 		},
 	},
 
@@ -428,7 +437,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO4, gpldo4, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO4, gpldo4, ldo_a_table),
 		},
 	},
 
@@ -436,7 +445,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO5, gpldo5, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO5, gpldo5, ldo_a_table),
 		},
 	},
 
@@ -444,7 +453,7 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_GPLDO,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
 		.desc = {
-			BCM590XX_LDO_DESC(GPLDO6, gpldo6, ldo_a_table),
+			BCM59056_LDO_DESC(GPLDO6, gpldo6, ldo_a_table),
 		},
 	},
 
@@ -452,11 +461,11 @@ static const struct bcm590xx_reg_info bcm590xx_regs[BCM590XX_NUM_REGS] = {
 		.type = BCM590XX_REG_TYPE_VBUS,
 		.regmap = BCM590XX_REG_REGMAP_SEC,
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
@@ -476,8 +485,8 @@ static int bcm590xx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pmu->mfd = bcm590xx;
-	pmu->n_regulators = BCM590XX_NUM_REGS;
-	pmu->regs = bcm590xx_regs;
+	pmu->n_regulators = BCM59056_NUM_REGS;
+	pmu->regs = bcm59056_regs;
 
 	platform_set_drvdata(pdev, pmu);
 

-- 
2.48.1


