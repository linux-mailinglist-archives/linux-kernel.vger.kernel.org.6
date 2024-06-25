Return-Path: <linux-kernel+bounces-228168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C7B915BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DD28366D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07651AAD7;
	Tue, 25 Jun 2024 01:40:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74DD2FF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279647; cv=none; b=WKqPBOV36tvsQoH+PnJi197SfDITsIiP8Vl7EZijnfypxysKK1AkOnlkvtZQJ1X7m1SLHKOaZgbSgPrZj0Fc8isiyGk/ql/uf4F62fVVhJi08mPQ2XDCKLEOnXKhwJQv/T27siohZgattc16OQmIlqV+IviGQmI375T7y4mEkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279647; c=relaxed/simple;
	bh=/GsNysvlkQccJ4koqHhSIjAIHMbHGuWrMF/ebJRXi18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPj9hRM0VssNqOPdVHBFZQMJV84ZGmKRGrPGJyUPIYLJmIe6WfxodICIo96BsJcQY8uUMUwBqILpGqN/CwYSi/EAdc/KahBusBDxNq7SLbsvERowxhP9YhhYmNTolP9gTAqW0L1o7WX+Yo8yqZEldk+2EpBK0CcH/j2rbfOhx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W7S9Q59RZz1j5m3;
	Tue, 25 Jun 2024 09:36:42 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B971140109;
	Tue, 25 Jun 2024 09:40:41 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 09:40:40 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [RESEND PATCH] irqchip/gic-v4.1: Use the ITS of the NUMA node where current  cpu is located
Date: Tue, 25 Jun 2024 01:40:19 +0000
Message-ID: <20240625014019.3914240-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500014.china.huawei.com (7.221.188.63)

When GICv4.1 enabled, guest sending IPI use the last ITS reported.
On multi-NUMA environment with more than one ITS, it makes IPI performance
various from VM to VM, depending on which NUMA the VM is deployed on.
We can use closer ITS instead of the last ITS reported.

Modify find_4_1_its to find the ITS of the NUMA node where current
cpu is located and save it with per cpu variable.

(There's format issues with the previous patch, resend it)

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
@@ -4058,19 +4060,25 @@ static struct irq_chip its_vpe_irq_chip = {
 
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
+		} else if (is_v4_1(its))
+			its_non_cpu_node = its;
+	}
 
-	return its;
+	if (!per_cpu(its_on_cpu, cpu) && its_non_cpu_node)
+		per_cpu(its_on_cpu, cpu) = its_non_cpu_node;
+
+	return its_non_cpu_node;
 }
 
 static void its_vpe_4_1_send_inv(struct irq_data *d)
-- 
2.30.0


