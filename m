Return-Path: <linux-kernel+bounces-227195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B499149C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1601F21AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFA13B7AE;
	Mon, 24 Jun 2024 12:25:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C094776A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231939; cv=none; b=a/+qFxRztLisNaGdhIbEzr1xuhG7/G33GBDf5V4LE898gI0NCASqL/tfgkV+y5sxjKesuEc1ZIt7QBVDXsMKaJ0pHQGhpQOXd0rUHqBRqD3Iwiq/0qxY447e6v8fAGSjtdfbP7UJp49j06V2yZ2C3dGihEx0H9tiZTAz75lcbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231939; c=relaxed/simple;
	bh=DjOoAm4KZP6XcpqouJqN0T3XcgKaMT2zuyvysyUrnHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVgWrFNauij7uZUw2V4eYJ92D8mCNc5UVXlVbJ9Dwd6viHBCnAdrgU9Ts9GsIRNvP2sGehDY9NtSZbRpE94rLeMMeaeaqinchTZmIC3nqeknbc1UKyEj1LpM3cyQN2213OIN2Tg0r68Y+If51At6/5V1nTE8DgRpqpYjGOQKKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W76XL4lg3zPpLQ;
	Mon, 24 Jun 2024 20:21:54 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id F10EE140156;
	Mon, 24 Jun 2024 20:25:32 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 20:25:32 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [PATCH] irqchip/gic-v4.1: Use the ITS of the NUMA node where current cpu is located
Date: Mon, 24 Jun 2024 12:25:10 +0000
Message-ID: <20240624122510.3906474-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500014.china.huawei.com (7.221.188.63)

When GICv4.1 enabled, guest sending IPI use the last ITS reported.
On multi-NUMA environment with more than one ITS, it makes IPI performance
various from VM to VM, depending on which NUMA the VM is deployed on. We can
use closer ITS instead of the last ITS reported.

Modify find_4_1_its to find the ITS of the NUMA node where current
cpu is located and save it with per cpu variable.

Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3c755d5dad6e..d35b42f3b2af 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -193,6 +193,8 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 
 static DEFINE_IDA(its_vpeid_ida);
 
+static DEFINE_PER_CPU(struct its_node *, its_on_cpu);
+
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
 #define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
@@ -4058,19 +4060,26 @@ static struct irq_chip its_vpe_irq_chip = {
 
 static struct its_node *find_4_1_its(void)
 {
-	static struct its_node *its = NULL;
+	struct its_node *its = NULL;
+	struct its_node *its_non_cpu_node = NULL;
+	int cpu = smp_processor_id();
 
-	if (!its) {
-		list_for_each_entry(its, &its_nodes, entry) {
-			if (is_v4_1(its))
-				return its;
-		}
+	if (per_cpu(its_on_cpu, cpu))
+		return per_cpu(its_on_cpu, cpu);
 
-		/* Oops? */
-		its = NULL;
-	}
+	list_for_each_entry(its, &its_nodes, entry) {
+		if (is_v4_1(its) && its->numa_node == cpu_to_node(cpu)) {
+			per_cpu(its_on_cpu, cpu) = its;
+			return its;
+		}
+		else if (is_v4_1(its))
+			its_non_cpu_node = its;
+ 	}
 
-	return its;
+	if (!per_cpu(its_on_cpu, cpu) && its_non_cpu_node)
+		per_cpu(its_on_cpu, cpu) = its_non_cpu_node;
+
+	return its_non_cpu_node;
 }
 
 static void its_vpe_4_1_send_inv(struct irq_data *d)
-- 
2.30.0


