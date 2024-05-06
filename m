Return-Path: <linux-kernel+bounces-169862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34EA8BCEAC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE23288C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038FF78C67;
	Mon,  6 May 2024 13:03:17 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BC6BB29
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000596; cv=none; b=Rm7RzKQSe15fmlOCtsQs3zzoQWA3f/satflnGMNFKhSNJNpW0+dvvWn67j63qQDUf3AOYC+7U/F4bURZXgI4e/+22yGDL9m+yiCpXXsN3i+44Zd3kHSuk2FsWYcbinxgU8nwB2iyr314AOLORho88S5vWzCYP7A7fFkvDLXURYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000596; c=relaxed/simple;
	bh=y9pKMTSpROuW5uGr7WjodDH4J07+axt2U3SLIM1IjUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcntnTlequTjAtCKMqaqNker7B8++5DOSNKCEGpMQxDZx66Dr9QoVRtEjjVpXoakifaC1X+kJEttpI23Ej210uNpEcoGA1JQUy79/NTS8+pgSYDsOT1/uGyy8C+2owOeD0C3KdOD9oIV32innS+DL6iKkOpvGUVmXrpXO6HKMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VY1lC0J7PzcdVt
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:01:59 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E41D140134
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:03:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 21:03:08 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 1/5] genirq/irqdomain: Clean up for irq_create_fwspec_mapping()
Date: Mon, 6 May 2024 21:02:19 +0800
Message-ID: <20240506130223.317265-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506130223.317265-1-ruanjinjie@huawei.com>
References: <20240506130223.317265-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)

In irq_create_fwspec_mapping(), if the hwirq in domain extracted from
fwspec has virq mapping, check the trigger type if they are consistent,
which is a relatively independent function that can be extracted into a
helper function irq_check_trigger_type(), which will make
irq_create_fwspec_mapping() function more readable.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdomain.c | 60 ++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc8891cc16..baa53a9e0cd1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -789,6 +789,38 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 }
 EXPORT_SYMBOL_GPL(of_phandle_args_to_fwspec);
 
+static inline int irq_check_trigger_type(struct irq_fwspec *fwspec,
+					 int virq, irq_hw_number_t hwirq,
+					 unsigned int type)
+{
+	struct irq_data *irq_data;
+
+	/*
+	 * If the trigger type is not specified or matches the
+	 * current trigger type then we are done so return the
+	 * interrupt number.
+	 */
+	if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
+		return 0;
+
+	/*
+	 * If the trigger type has not been set yet, then set
+	 * it now and return the interrupt number.
+	 */
+	if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
+		irq_data = irq_get_irq_data(virq);
+		if (!irq_data)
+			return -EINVAL;
+
+		irqd_set_trigger_type(irq_data, type);
+		return 0;
+	}
+
+	pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
+		hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
+	return -EINVAL;
+}
+
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
 	struct irq_domain *domain;
@@ -829,32 +861,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	 */
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
-		/*
-		 * If the trigger type is not specified or matches the
-		 * current trigger type then we are done so return the
-		 * interrupt number.
-		 */
-		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
-			goto out;
-
-		/*
-		 * If the trigger type has not been set yet, then set
-		 * it now and return the interrupt number.
-		 */
-		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
-			irq_data = irq_get_irq_data(virq);
-			if (!irq_data) {
-				virq = 0;
-				goto out;
-			}
-
-			irqd_set_trigger_type(irq_data, type);
-			goto out;
-		}
-
-		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
-			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
-		virq = 0;
+		if (irq_check_trigger_type(fwspec, virq, hwirq, type))
+			virq = 0;
 		goto out;
 	}
 
-- 
2.34.1


