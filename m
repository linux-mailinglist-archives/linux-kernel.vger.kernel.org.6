Return-Path: <linux-kernel+bounces-352671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A56992274
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC89281E80
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99AE28EA;
	Mon,  7 Oct 2024 00:15:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D918C22;
	Mon,  7 Oct 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728260100; cv=none; b=rdysMaCCjfJOvyPKNqIopPtqtOJnTE0vPmaS5WoDtwHauQL5Vp1/SRTllbzTtMdEiTojaoHSgZc6VINu9crhnZdOPitzzSSZL61z8e57sZBSEUB7D/t5kROP5GbAoGoeQ5ITIhCXKm2XdLDy7H3rGj6nFhtZw0YvHDy08kR2mLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728260100; c=relaxed/simple;
	bh=yLzQTkLZ+nr7Onps5le2X5ohuhcu6HMjNYjzkpsIgkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCeVWh5SPWTomG+7WWupyxZMtxUrAG90Ra8FVi4O2fe5Oroqxx/GbV8AwwQsNZAYIgTv1RRrya+5VcT6BbtQmlAFb0/5+3n5FsZxI+kFgSRE7TTui7L/Ndj5tCtI/6Qq282OoGH57ZBW7e813GV0U/F7xH3tqURvmBf1gScBaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6AAEFEC;
	Sun,  6 Oct 2024 17:15:27 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8CE3F640;
	Sun,  6 Oct 2024 17:14:56 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Martin Botka <martin.botka@somainline.org>,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v2 4/5] mfd: axp20x: Add support for AXP323
Date: Mon,  7 Oct 2024 01:14:07 +0100
Message-ID: <20241007001408.27249-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007001408.27249-1-andre.przywara@arm.com>
References: <20241007001408.27249-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP323 is a very close sibling of the AXP313A. The only
difference seems to be the ability to dual-phase the first two DC/DC
converter, which adds another register.

Add the required boilerplate to introduce a new PMIC to the AXP MFD
driver. Where possible, this just maps into the existing structs defined
for the AXP313A, only deviating where needed.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x-i2c.c   |  1 +
 drivers/mfd/axp20x.c       | 26 ++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 791a0b4cb64bb..5c93136f977e7 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID },
+	{ .compatible = "x-powers,axp323", .data = (void *)AXP323_ID },
 	{ .compatible = "x-powers,axp717", .data = (void *)AXP717_ID },
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index bc08ae4332604..251465a656d09 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -42,6 +42,7 @@ static const char * const axp20x_model_names[] = {
 	[AXP223_ID] = "AXP223",
 	[AXP288_ID] = "AXP288",
 	[AXP313A_ID] = "AXP313a",
+	[AXP323_ID] = "AXP323",
 	[AXP717_ID] = "AXP717",
 	[AXP803_ID] = "AXP803",
 	[AXP806_ID] = "AXP806",
@@ -193,6 +194,10 @@ static const struct regmap_range axp313a_writeable_ranges[] = {
 	regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
 };
 
+static const struct regmap_range axp323_writeable_ranges[] = {
+	regmap_reg_range(AXP313A_ON_INDICATE, AXP323_DCDC_MODE_CTRL2),
+};
+
 static const struct regmap_range axp313a_volatile_ranges[] = {
 	regmap_reg_range(AXP313A_SHUTDOWN_CTRL, AXP313A_SHUTDOWN_CTRL),
 	regmap_reg_range(AXP313A_IRQ_STATE, AXP313A_IRQ_STATE),
@@ -203,6 +208,11 @@ static const struct regmap_access_table axp313a_writeable_table = {
 	.n_yes_ranges = ARRAY_SIZE(axp313a_writeable_ranges),
 };
 
+static const struct regmap_access_table axp323_writeable_table = {
+	.yes_ranges = axp323_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp323_writeable_ranges),
+};
+
 static const struct regmap_access_table axp313a_volatile_table = {
 	.yes_ranges = axp313a_volatile_ranges,
 	.n_yes_ranges = ARRAY_SIZE(axp313a_volatile_ranges),
@@ -433,6 +443,15 @@ static const struct regmap_config axp313a_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static const struct regmap_config axp323_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.wr_table = &axp323_writeable_table,
+	.volatile_table = &axp313a_volatile_table,
+	.max_register = AXP323_DCDC_MODE_CTRL2,
+	.cache_type = REGCACHE_MAPLE,
+};
+
 static const struct regmap_config axp717_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1221,6 +1240,7 @@ static int axp20x_power_off(struct sys_off_data *data)
 	unsigned int shutdown_reg;
 
 	switch (axp20x->variant) {
+	case AXP323_ID:
 	case AXP313A_ID:
 		shutdown_reg = AXP313A_SHUTDOWN_CTRL;
 		break;
@@ -1289,6 +1309,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp313a_regmap_config;
 		axp20x->regmap_irq_chip = &axp313a_regmap_irq_chip;
 		break;
+	case AXP323_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp313a_cells);
+		axp20x->cells = axp313a_cells;
+		axp20x->regmap_cfg = &axp323_regmap_config;
+		axp20x->regmap_irq_chip = &axp313a_regmap_irq_chip;
+		break;
 	case AXP717_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp717_cells);
 		axp20x->cells = axp717_cells;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 79ecaaaa20703..c3df0e615fbf4 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -19,6 +19,7 @@ enum axp20x_variants {
 	AXP223_ID,
 	AXP288_ID,
 	AXP313A_ID,
+	AXP323_ID,
 	AXP717_ID,
 	AXP803_ID,
 	AXP806_ID,
@@ -113,6 +114,7 @@ enum axp20x_variants {
 #define AXP313A_SHUTDOWN_CTRL		0x1a
 #define AXP313A_IRQ_EN			0x20
 #define AXP313A_IRQ_STATE		0x21
+#define AXP323_DCDC_MODE_CTRL2		0x22
 
 #define AXP717_ON_INDICATE		0x00
 #define AXP717_PMU_STATUS_2		0x01
-- 
2.46.2


