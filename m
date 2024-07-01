Return-Path: <linux-kernel+bounces-235655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E76391D809
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6A1285345
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5754BAA6;
	Mon,  1 Jul 2024 06:21:21 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5A381AA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814881; cv=none; b=mEGLWx/Wq0tJm/kubu1tf3A0BFS1kl9u746lPwTyGRnSkjkwJnN8zwJlDR7ImA5/MnK5lFMVuarCiTKyvIqi49s5bNqueDOodpD+PrfaqWKt3QALVKSYhBcjQ83x1NpwIobx9lp68MH75OOLZSeA4dEb2/1NFp+zhwlNy4lM6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814881; c=relaxed/simple;
	bh=dW7BqdINXHuQ/V5giKx4pd9BSfttfPOKfuMMjqxROiA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHpNSgbNhdldrfM1F8Bf25G1okMCmPOFs7Xp/oqu7AIqlb5hhca9SdtnwJwM8qqZbiSVBjTkMklR7gIuOnDsqliJ56tPcTAWgtS0pbMB4s/S/Z79jsliyxxxGKHoBIvRfo72hRC6CibslF4uwHhAZheSvZqh1H4OzmdsFuNZyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WCG5d64q0z1T4Hs;
	Mon,  1 Jul 2024 14:16:37 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A370180A9C;
	Mon,  1 Jul 2024 14:21:08 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 1 Jul 2024 14:21:07 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [RESPIN PATCH] irqchip/gic-v4.1: Use local 4_1 ITS to generate VSGI
Date: Mon, 1 Jul 2024 06:20:42 +0000
Message-ID: <20240701062042.4128863-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)

On multi-node GICv4.1 system, VSGI senders always use one certain 4_1 ITS,
because find_4_1_its return the first its_node in list, regardless of
which node the VSGI sender is on. This brings guest vsgi performance drop
when VM is not deployed on the same node as this returned ITS.

On a 2-socket environment, each with one ITS and 32 cpu, GICv4.1 enabled,
4U8G guest, 4 vcpu is deployed on same socket.
When VM on socket0, kvm-unit-tests ipi_hw result is 850ns.
When VM on socket1, it is 750ns. The reason is VSGI sender always
use lasted reported ITS(that on socket1) to inject VSGI. The access
from cpu to other-socket ITS will cost 100ns more compared to cpu to 
local ITS.

To use local ITS, we can get 12% reduction in IPI latency.

The patch modify find_4_1_its to firstly return per-cpu local_4_1_its,
which is init when inherit the VPE table from the ITS on secondary CPUs.
If fail to find local 4_1 ITS, return any 4_1 ITS like before.

Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3c755d5dad6e..f99c0a86320b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -119,6 +119,8 @@ struct its_node {
 	int			vlpi_redist_offset;
 };
 
+static DEFINE_PER_CPU(struct its_node *, local_4_1_its);
+
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
 #define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
@@ -2709,6 +2711,8 @@ static u64 inherit_vpe_l1_table_from_its(void)
 		}
 		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
 
+		*this_cpu_ptr(&local_4_1_its) = its;
+
 		return val;
 	}
 
@@ -2746,6 +2750,8 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 		gic_data_rdist()->vpe_l1_base = gic_data_rdist_cpu(cpu)->vpe_l1_base;
 		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
 
+		*this_cpu_ptr(&local_4_1_its) = *per_cpu_ptr(&local_4_1_its, cpu);
+
 		return val;
 	}
 
@@ -4058,8 +4064,9 @@ static struct irq_chip its_vpe_irq_chip = {
 
 static struct its_node *find_4_1_its(void)
 {
-	static struct its_node *its = NULL;
+	struct its_node *its;
 
+	its = *this_cpu_ptr(&local_4_1_its);
 	if (!its) {
 		list_for_each_entry(its, &its_nodes, entry) {
 			if (is_v4_1(its))
-- 
2.30.0


