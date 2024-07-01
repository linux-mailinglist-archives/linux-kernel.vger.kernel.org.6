Return-Path: <linux-kernel+bounces-235719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED391D8DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6B41C214D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3C76EEA;
	Mon,  1 Jul 2024 07:23:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C77406D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818628; cv=none; b=WoNq5xX2GOlbFhAzQpeJCUsaNJg2x2rMa2SqUN3yRFlMUhQ5Lc8Oxgv7OqlzR7POEolbJLHkbBP3UzzBo5wVBl50EiKcufY/ueInrw15EzMMX4crFbimozWUBSvn6JGE8oGWQBhwNb6UkOXXJ3Q5o2H+I7gL2Xx6gAN3F4hF3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818628; c=relaxed/simple;
	bh=5ATaNWV+YJOhMk6C1apYFNeG60MBCCHhE5FFpAqThKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9ZR/ggBVSekS3UkjXBUQAZzHgE1/Kmoi0PN8tIFccp44wuShaaAa885BKoei/2YgmLWcxRbqfKOG+lAiZ+8D1voQpCRyGEPG/y5Posv+om8Ke9RJowEJkfx+3ajZu/cMxm1lrS2FteKH5K657JgU/EcvimgZIcUEicsCVcOz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCHZp0q03znYj9;
	Mon,  1 Jul 2024 15:23:30 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id B162F180086;
	Mon,  1 Jul 2024 15:23:43 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 1 Jul 2024 15:23:43 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [PATCH] irqchip/gic-v4: Fix vcpus racing for vpe->col_idx in vmapp and vmovp
Date: Mon, 1 Jul 2024 07:23:05 +0000
Message-ID: <20240701072305.4129823-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500014.china.huawei.com (7.221.188.63)

its_map_vm may modify vpe->col_idx without holding vpe->vpe_lock.
It would result in a vpe resident on one RD after vmovp to a different RD.
Or, a vpe maybe vmovp to a RD same as it is current mapped in vpe table.

On a 2-ITS, GICv4 enabled system, 32 vcpus deployed on cpu of collection 0
and 1. Two pci devices route VLPIs, using each of the ITS.
VPE ready to reside on RD1 may have such unexpected case because another
vcpu on other cpu is doing vmapp and modify his vpe->col_idx.

Unexpected Case 1:
RD                0                              1
                                           vcpu_load
                                           lock vpe_lock
                                           vpe->col_idx = 1
            its_map_vm
            lock vmovp_lock
                                           waiting vmovp_lock
            vpe->col_idx = 0
            (cpu0 is first online cpu)
            vmapp vpe on col0
            unlock vmovp_lock
                                           lock vmovp_lock
                                           vmovp vpe to col0
                                           unlock vmovp_lock
                                           vpe resident here fail to
                                             receive VLPI!

Unexpected Case 2:
RD                0                              1
            its_map_vm                     vcpu_load
            lock vmovp_lock                lock vpe_lock
            vpe->col_idx = 0
                                           vpe->col_idx = 1
            vmapp vpe on col1              waiting vmovp_lock
            unlock vmovp_lock
                                           lock vmovp_lock
                                           vmovp vpe to col1
                                           (target RD == source RD!)
                                           unlock vmovp_lock



Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f99c0a86320b..adda9824e0e7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1794,11 +1794,15 @@ static bool gic_requires_eager_mapping(void)
 static void its_map_vm(struct its_node *its, struct its_vm *vm)
 {
 	unsigned long flags;
+	bool vm_mapped_on_any_its = false;
+	int i;
 
 	if (gic_requires_eager_mapping())
 		return;
 
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
+	for (i = 0; i < GICv4_ITS_LIST_MAX; i++)
+		if (vm->vlpi_count[i] > 0)
+			vm_mapped_on_any_its = true;
 
 	/*
 	 * If the VM wasn't mapped yet, iterate over the vpes and get
@@ -1813,15 +1817,19 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
 			struct its_vpe *vpe = vm->vpes[i];
 			struct irq_data *d = irq_get_irq_data(vpe->irq);
 
-			/* Map the VPE to the first possible CPU */
-			vpe->col_idx = cpumask_first(cpu_online_mask);
+			raw_spin_lock_irqsave(&vpe->vpe_lock, flags);
+
+			if (!vm_mapped_on_any_its) {
+				/* Map the VPE to the first possible CPU */
+				vpe->col_idx = cpumask_first(cpu_online_mask);
+			}
 			its_send_vmapp(its, vpe, true);
 			its_send_vinvall(its, vpe);
 			irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
+
+			raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
 		}
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
 
 static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
-- 
2.30.0


