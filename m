Return-Path: <linux-kernel+bounces-311367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95401968834
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5235C28276B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FA20FAB5;
	Mon,  2 Sep 2024 13:00:05 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567120FA85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282005; cv=none; b=AjPcopKpWRLhT0cxDWSU40NkizT66c1TFLUvKw6iOI8euEtgM7haOzY+LVfkcEqySA9tFCY+/24G2Kftk1HfKmnNlginw1MzTcAHoWdpNQoVZnmkWGc4tWCWmP8spMTiaIp21L9Ys1mBaBGgH5pCUfg/aWras53pT1dpitZOtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282005; c=relaxed/simple;
	bh=2pSWQoEzCqvrIMBqA00pOxbh0xN5KgF1JeBw43HoNw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k+ArApCMG6/BdbsmiTemquBRxHzNqSSEBu0wN/1mgf77T17h7yN6nneNuthdi3HITobjgouWXZV6H6XUrEnuY5QtVa5ZKHoXWiKSAg9ULKxEMxUQfXYNROBTKt6H2mxVmP17ItB/Y4l93M/K3zzHFqbHKiy3Maz1qUZXTdMRhQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wy82v4vXQz18Mvw;
	Mon,  2 Sep 2024 20:59:03 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 922D41402DE;
	Mon,  2 Sep 2024 20:59:58 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 20:59:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <tglx@linutronix.de>, <paul.walmsley@sifive.com>,
	<samuel.holland@sifive.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] irqchip/sifive-plic: Make use of __assign_bit() API
Date: Mon, 2 Sep 2024 21:08:24 +0800
Message-ID: <20240902130824.2878644-1-lihongbo22@huawei.com>
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
 dggpeml500022.china.huawei.com (7.185.36.66)

We have for some time the __assign_bit() API to replace
open coded
    if (foo)
        __set_bit(n, bar);
    else
        __clear_bit(n, bar);

Use this API to simplify the code. No functional change
intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f6ef5c495bd..c576b9bbeb13 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,10 +252,8 @@ static int plic_irq_suspend(void)
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
 	for (i = 0; i < priv->nr_irqs; i++)
-		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
-			__set_bit(i, priv->prio_save);
-		else
-			__clear_bit(i, priv->prio_save);
+		__assign_bit(i, priv->prio_save,
+		    readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 
 	for_each_cpu(cpu, cpu_present_mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
-- 
2.34.1


