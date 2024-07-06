Return-Path: <linux-kernel+bounces-243176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990189292BE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358BBB21B43
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765B12BF1C;
	Sat,  6 Jul 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U78+qAHy"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691076036
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264453; cv=none; b=Bh14lI7qSKihlpZ4Nu7pvxzM5/tj4UfpIz1eHrtrXlMrfozdn4P/FxTc13FQXuQy8xBK4Ok5fs8HBN73lIblq7bUXgFoif/vPcI3nBZ0tyxCKIq4jD04vT21qQDs0sU5gtq2yrVrJCLBq1g0jSCTSalSgfuTtVcpuJc4CNjAu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264453; c=relaxed/simple;
	bh=MEc/mOF0FnTN6bRFJayGAdxZkB38Gd32/HktBAaLq7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P84LpX8DHWXxgcyy4HrQ+kZSir1TYttpkdcaSoAgz/vkTKQBr7BrsKx2jHTuPlIpK7zau0TFX0dm2x666NyRiJDJWa4Cl+QySE5SN2RKrKWg4jOyDX+SjUaR/ZmTcIjvlqtJgyQwBWv0rmYnFeRHPDzdPmvPNVe+Tv49w4Sfhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U78+qAHy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720264448;
	bh=MEc/mOF0FnTN6bRFJayGAdxZkB38Gd32/HktBAaLq7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U78+qAHyoSNdvN5VLLvXfbVaeRfKl2kQZQbY2xqo4MfYaJO/SZuUngL+4DyvCi2iR
	 qKjQBhfKXcZVhydOjJcKEXlyIZiMUcV7O36p2nVz1FBuAw3ad8GOBuKMKwXUssB/oz
	 gpMyXqdV8ZrNjZ8NQHhHRHIJb+c910nOHU1Ht/E0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 06 Jul 2024 13:13:42 +0200
Subject: [PATCH 2/2] regmap-irq: handle const struct regmap_irq_sub_irq_map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240706-regmap-const-structs-v1-2-d08c776da787@weissschuh.net>
References: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
In-Reply-To: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720264447; l=1886;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MEc/mOF0FnTN6bRFJayGAdxZkB38Gd32/HktBAaLq7Y=;
 b=i8QH/Tgtm3nuy9VklD/x4Xx3+4MmHRK6tpGEvY/6TCuM3LdRH5U1mlwZgGYundShg8PqTbQFT
 zB0jFWy8KIQD+vFE98SqAZsFs+O3TetzxSjV/z/O9WZ8fk4OIZxR7rT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The struct instances supplied by the drivers are never modified.
Handle them as const in the regmap core allowing the drivers to put them
into .rodata.

Also add a new entry to const_structs.checkpatch to make sure future
instances of this struct already enter the tree as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/regmap/regmap-irq.c | 2 +-
 include/linux/regmap.h           | 2 +-
 scripts/const_structs.checkpatch | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 45fd13ef13fc..d3ec1345b5b5 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -305,8 +305,8 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 					   unsigned int b)
 {
 	const struct regmap_irq_chip *chip = data->chip;
+	const struct regmap_irq_sub_irq_map *subreg;
 	struct regmap *map = data->map;
-	struct regmap_irq_sub_irq_map *subreg;
 	unsigned int reg;
 	int i, ret = 0;
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a6bc2980a98b..2da1cfc52233 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1607,7 +1607,7 @@ struct regmap_irq_chip {
 
 	unsigned int main_status;
 	unsigned int num_main_status_bits;
-	struct regmap_irq_sub_irq_map *sub_reg_offsets;
+	const struct regmap_irq_sub_irq_map *sub_reg_offsets;
 	int num_main_regs;
 
 	unsigned int status_base;
diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 1bfbb3d7f2e0..cc62980cfa6e 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -72,6 +72,7 @@ regmap_bus
 regmap_config
 regmap_irq
 regmap_irq_chip
+regmap_irq_sub_irq_map
 regmap_range
 regmap_range_cfg
 regulator_ops

-- 
2.45.2


