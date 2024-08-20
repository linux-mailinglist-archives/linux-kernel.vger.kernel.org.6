Return-Path: <linux-kernel+bounces-294035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B4958802
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC961F23159
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0F18FDD0;
	Tue, 20 Aug 2024 13:34:29 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07881AACB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160868; cv=none; b=taEhB6K1imBF77hrZ/tM83uZVI2PfuS/sAZ5rEBR8GQ182lxme4/aKnHnLvLLXnQ+8GBqDTZWyNH9pCnF+JCdgieAZvVhu44S/ef6qmC72KdCvC++tnPEv/DXfok8gnC2W0k9iYrI2eRZZTzQ3iVtmvzYqYB9aO4DA91ZOBoCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160868; c=relaxed/simple;
	bh=xeDvGTbA5s2XxfCK0qvgyZ4+r4yN3Uq6Vo0UvU8pIv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O0jvY1D50p2n13Z0C1PidPUPN9QBlk6+0+tJX34doFrAikWgWF3oN2Zw/vzjlpL/PAqm5v1+xG+AVQb7O1fmsMSReQM/ZgIIrMDJ2ICUO3iKCxUtZ76lZTUPzB/q49axGImHS/oTaw1K0EG4/0CYYxqKrxYCQ6BDfj/YoSBI8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wp9Rc32GDz1S8N7;
	Tue, 20 Aug 2024 21:34:20 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F78E1401F4;
	Tue, 20 Aug 2024 21:34:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 21:34:21 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anup@brainfault.org>, <tglx@linutronix.de>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <ruanjinjie@huawei.com>,
	<bjorn@rivosinc.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] irqchip/riscv-aplic: Fix NULL vs IS_ERR() bug
Date: Tue, 20 Aug 2024 21:28:57 +0800
Message-ID: <20240820132857.247679-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

devm_platform_ioremap_resource() never returns NULL pointer, it will
return ERR_PTR() when it fails, so check it with IS_ERR().

Fixes: 2333df5ae51e ("irqchip: Add RISC-V advanced PLIC driver for direct-mode")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-riscv-aplic-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 28dd175b5764..6d93a85f1fc6 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
 
 	/* Map the MMIO registers */
 	regs = devm_platform_ioremap_resource(pdev, 0);
-	if (!regs) {
+	if (IS_ERR(regs))
 		dev_err(dev, "failed map MMIO registers\n");
-		return -ENOMEM;
+		return PTR_ERR(regs);
 	}
 
 	/*
-- 
2.34.1


