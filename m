Return-Path: <linux-kernel+bounces-293660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788319582DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7464B25415
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095F18C02C;
	Tue, 20 Aug 2024 09:38:26 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562A18C926
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146705; cv=none; b=aEA8giBVho3DRoRGRhQeh9rCVO1VkogiP/wZmRu/3XEw0Dg4BL2QxtWRQVxsVqauSH8xNs/vFSPKwikBtzHHW06UaY0+m/ZbXS23At1BA1lQJNTnsL2Pp4r6u7UcTJHl1BzCny8xTDXTAIx9h/QqmpuXIdMdGQyWwe60zTZ0wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146705; c=relaxed/simple;
	bh=GPA57yqjWyZMpP+3vnrZiTp5KQjBXboKlfETZsPw/6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VExmhmvvPXlLKrKrj419BlgSqf/eXrinr/ykUUNwedLLtAUcuHts2Yit+zLXP0f3uUALChnnry3WOu5Mm3m2suzpc7xO2+FX1pqwnExpZONdn2Ye3SPGMU6XA8As4Tum1YyLrpnruL0jXuBTn7xVsi/c7NGMyAEk08eC1A9bOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wp4956yjKz1xvd6;
	Tue, 20 Aug 2024 17:36:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 093FE1400FD;
	Tue, 20 Aug 2024 17:38:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 17:38:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <paul.walmsley@sifive.com>,
	<samuel.holland@sifive.com>, <apatel@ventanamicro.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] irqchip/sifive-plic: Fix IS_ERR() vs NULL bug in plic_probe()
Date: Tue, 20 Aug 2024 17:45:42 +0800
Message-ID: <20240820094542.1576537-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The devm_platform_ioremap_resource() function returns error pointers.
It never returns NULL. Update the check accordingly.

Fixes: b68d0ff529a9 ("irqchip/sifive-plic: Use devm_xyz() for managed allocation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..cea8dca89c50 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -511,8 +511,8 @@ static int plic_probe(struct platform_device *pdev)
 	priv->nr_irqs = nr_irqs;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(!priv->regs))
-		return -EIO;
+	if (WARN_ON(IS_ERR(priv->regs)))
+		return PTR_ERR(priv->regs);
 
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-- 
2.34.1


