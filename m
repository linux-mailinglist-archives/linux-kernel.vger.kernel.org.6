Return-Path: <linux-kernel+bounces-388977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C79B66D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70C71F213C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082E1F4735;
	Wed, 30 Oct 2024 15:02:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0031E885F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300544; cv=none; b=FpkC6agFV+DDHJKeOOZcNXrHBtgMzZVoGAN586My1kRA843WtyPP3t2ykGUDvKSXrfTJ1HN41FuX40yzJfqGrifSz8rvibhiNPxNeC89EYBod8tYQQsPsh2N8vaQ1FMnPZolIcxSJPpxvi6NzUTe+59UFcfxtHHLZctAx+od1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300544; c=relaxed/simple;
	bh=2bKSKgI7FJqNVrw7OMqnymXnoOrC6zDNg5UOHtPRxkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsWu1lnHVCBQ3CDbE8YYFyhm5QbpPtWZEmaOHRrvc9ki3lukH8gUmqwWge1cDmP5cJZmXUoE1k5GkfmB9jRQZP0wlWMY98ZeEMQqhICMI7x3okTOj9b1WzTT1sQGBQPluarWXbjuLn3xyfAMvc+zH7O2BwTprOTbsCCGZrgKel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XdqzM4HgSzdkSw;
	Wed, 30 Oct 2024 22:59:43 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (unknown [7.185.36.76])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DA031402E2;
	Wed, 30 Oct 2024 23:02:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 23:02:16 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: Lee Jones <lee@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Chanwoo
 Choi <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, Wei Yongjun
	<weiyongjun1@huawei.com>
Subject: [PATCH] mfd: rt5033: Fix missing regmap_del_irq_chip()
Date: Wed, 30 Oct 2024 23:41:06 +0800
Message-ID: <1730302867-8391-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)

Fix missing call to regmap_del_irq_chip() in error handling path by
using devm_regmap_add_irq_chip().

Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/mfd/rt5033.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 7e23ab3..84ebc96 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -81,8 +81,8 @@ static int rt5033_i2c_probe(struct i2c_client *i2c)
 	chip_rev = dev_id & RT5033_CHIP_REV_MASK;
 	dev_info(&i2c->dev, "Device found (rev. %d)\n", chip_rev);
 
-	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+	ret = devm_regmap_add_irq_chip(rt5033->dev, rt5033->regmap,
+			rt5033->irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			0, &rt5033_irq_chip, &rt5033->irq_data);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
-- 
2.9.5


