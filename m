Return-Path: <linux-kernel+bounces-327475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC897766A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ABA1F2430C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409D4A3E;
	Fri, 13 Sep 2024 01:25:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A803443D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190758; cv=none; b=RGlolroS7qlesL3y1YpESpWmjv7lqkCYM1ZePlo4zpVWAy+ErpfMc2S48aRC2FgGPe96JoHS9SX3wxioKHLy4D5BRK48OyoEIyjijfgIvaUvFvYeETeDkNfgrSOuJVA6Vykbobr30hYGnvhr+xei9SQ/XkB9anpUW9UeqsCX0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190758; c=relaxed/simple;
	bh=9vgVqu6YemcpCPzpG8tCwQdV08j/EigS60ejUpRid0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=az5kzJgBN67edAh/Q0+icQc05SqLx5kthoQrm9f3S0WNAP2wR9R37/ASBMOSZDoo5033l154WnUVvegZD2aYfGoBdfp7bPFb36MAA2W/CKOrKbEXw4xyDKAIsiLjTTrH47p8EmjFG3j1RrkPi/Eb1g6uRL4q6fqKnk5CCDOaWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4c7N6SXyz2CpbF;
	Fri, 13 Sep 2024 09:25:20 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ED551402E2;
	Fri, 13 Sep 2024 09:25:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Sep
 2024 09:25:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] regulator: max8973: Use irq_get_trigger_type() helper
Date: Fri, 13 Sep 2024 09:35:03 +0800
Message-ID: <20240913013503.3754712-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use irq_get_trigger_type() to replace irq_get_irq_data() and then
irqd_get_trigger_type(), if the irq data is NULL it will return 0.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/regulator/max8973-regulator.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 96ca146281d6..f68caa07f546 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -470,8 +470,7 @@ static const struct thermal_zone_device_ops max77621_tz_ops = {
 static int max8973_thermal_init(struct max8973_chip *mchip)
 {
 	struct thermal_zone_device *tzd;
-	struct irq_data *irq_data;
-	unsigned long irq_flags = 0;
+	unsigned long irq_flags;
 	int ret;
 
 	if (mchip->id != MAX77621)
@@ -489,9 +488,7 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 	if (mchip->irq <= 0)
 		return 0;
 
-	irq_data = irq_get_irq_data(mchip->irq);
-	if (irq_data)
-		irq_flags = irqd_get_trigger_type(irq_data);
+	irq_flags = irq_get_trigger_type(mchip->irq);
 
 	ret = devm_request_threaded_irq(mchip->dev, mchip->irq, NULL,
 					max8973_thermal_irq,
-- 
2.34.1


