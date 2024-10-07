Return-Path: <linux-kernel+bounces-352669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450CB992270
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1AD1F21FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24013AF9;
	Mon,  7 Oct 2024 00:14:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C14C98;
	Mon,  7 Oct 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728260096; cv=none; b=SJAWlVjTQvgcnOfzJLRg9kdMZyMrYurFJoxggGIW9dE4i8+/71IsIMpslD6ttbiQI4g9F/6lGEQgAQ72IU6HvP3wN5ZqaCcY/8AjYdhHSUA8EaLRy6v/ZAsku2Om9Nw4v1vjn4aboAtNRUY0ayNzqvxGzhHNxWqmuDaSKTERv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728260096; c=relaxed/simple;
	bh=DrkghZ9iCBPij4tMtQpGuKTetzJpES+lEVEwvbnLsWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWzNtQvdNEzjrTMeAXjNIi7bEr1hgAYUUe0YNnNd7dANGi972RU9GWNezjq2vpEf5qZxSzs7qmxfJlgTeeTmeshKA2YrBLiabAECxqFOQA5FTGatItiABO3nF51euUZ7dAQJUbMqUKC15Lo8W7HzOtzZu3oLNN4nm+qjHo2D5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EE7CFEC;
	Sun,  6 Oct 2024 17:15:24 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C5C3F640;
	Sun,  6 Oct 2024 17:14:52 -0700 (PDT)
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
Subject: [PATCH v2 2/5] mfd: axp20x: ensure relationship between IDs and model names
Date: Mon,  7 Oct 2024 01:14:05 +0100
Message-ID: <20241007001408.27249-3-andre.przywara@arm.com>
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

At the moment there is an implicit relationship between the AXP model
IDs and the order of the strings in the axp20x_model_names[] array.
This is fragile, and makes adding IDs in the middle error prone.

Make this relationship official by changing the ID type to the actual
enum used, and using indexed initialisers for the string list.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c                 | 30 ++++++++++++++--------------
 drivers/regulator/axp20x-regulator.c |  2 +-
 include/linux/mfd/axp20x.h           |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 4051551757f2d..5ceea359289f4 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -34,20 +34,20 @@
 #define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE	BIT(4)
 
 static const char * const axp20x_model_names[] = {
-	"AXP152",
-	"AXP192",
-	"AXP202",
-	"AXP209",
-	"AXP221",
-	"AXP223",
-	"AXP288",
-	"AXP313a",
-	"AXP717",
-	"AXP803",
-	"AXP806",
-	"AXP809",
-	"AXP813",
-	"AXP15060",
+	[AXP152_ID] = "AXP152",
+	[AXP192_ID] = "AXP192",
+	[AXP202_ID] = "AXP202",
+	[AXP209_ID] = "AXP209",
+	[AXP221_ID] = "AXP221",
+	[AXP223_ID] = "AXP223",
+	[AXP288_ID] = "AXP288",
+	[AXP313A_ID] = "AXP313a",
+	[AXP717_ID] = "AXP717",
+	[AXP803_ID] = "AXP803",
+	[AXP806_ID] = "AXP806",
+	[AXP809_ID] = "AXP809",
+	[AXP813_ID] = "AXP813",
+	[AXP15060_ID] = "AXP15060",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -1345,7 +1345,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
 		break;
 	default:
-		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
+		dev_err(dev, "unsupported AXP20X ID %u\n", axp20x->variant);
 		return -EINVAL;
 	}
 
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index a8e91d9d028b8..3ba76dbd0fb9e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1597,7 +1597,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		nregulators = AXP15060_REG_ID_MAX;
 		break;
 	default:
-		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
+		dev_err(&pdev->dev, "Unsupported AXP variant: %d\n",
 			axp20x->variant);
 		return -EINVAL;
 	}
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index f4dfc1871a95b..79ecaaaa20703 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -959,7 +959,7 @@ struct axp20x_dev {
 	unsigned long			irq_flags;
 	struct regmap			*regmap;
 	struct regmap_irq_chip_data	*regmap_irqc;
-	long				variant;
+	enum axp20x_variants		variant;
 	int                             nr_cells;
 	const struct mfd_cell           *cells;
 	const struct regmap_config	*regmap_cfg;
-- 
2.46.2


