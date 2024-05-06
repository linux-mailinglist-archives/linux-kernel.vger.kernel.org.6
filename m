Return-Path: <linux-kernel+bounces-169860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FA8BCEAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5861F24BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F217317C;
	Mon,  6 May 2024 13:03:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF945FB9A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000595; cv=none; b=fpPj7EUj8saxVMKuLagyvMciwoVw8YAz5MbEDtBIR9DEJaaV7LNOCI/G2khPJNFnHRgCZ+na0Q+4NSNloCgbfA+6wUR4w4gSh+mx3nax/n3757FVCnEMX+Q/OYgwfaBRrF5q6hJPkxDALNpiI640OXG75nUv+IJwLN3id84ohT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000595; c=relaxed/simple;
	bh=CQyVq+F6jzKSnAUtUnQ3X91KAzPVmn25oCVUP0vkPKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvKehR/ffYeRkWZgLfaUB2tUQ65xHi/Bv+abhCAlFzVCrZrewe/Ohg5a7XMLD/IVs4Q/Zu2uvjfa3PTw89sneigl4+h7mf29d7vN2etx7N9+hxgPznKUlaCKjMpkuNA0EC/P0TU0RxVOxEQvTssWmO5Z9WYN7sGHCG3a3mYl1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VY1hB1Yrczcnyt
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:59:22 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C92D140158
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:03:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 21:03:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 2/5] genirq/irqdomain: Simplify the checks for irq_default_domain
Date: Mon, 6 May 2024 21:02:20 +0800
Message-ID: <20240506130223.317265-3-ruanjinjie@huawei.com>
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

Use ternary to check whether assign irq_default_domain, which can simplify
the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdomain.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index baa53a9e0cd1..42bdbd04bc3c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -661,8 +661,7 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 	struct device_node *of_node;
 	unsigned int virq;
 
-	if (domain == NULL)
-		domain = irq_default_domain;
+	domain = domain ? : irq_default_domain;
 
 	of_node = irq_domain_get_of_node(domain);
 	virq = irq_alloc_desc_from(1, of_node_to_nid(of_node));
@@ -734,8 +733,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 	int virq;
 
 	/* Look for default domain if necessary */
-	if (domain == NULL)
-		domain = irq_default_domain;
+	domain = domain ? : irq_default_domain;
 	if (domain == NULL) {
 		WARN(1, "%s(, %lx) called with NULL domain\n", __func__, hwirq);
 		return 0;
@@ -953,8 +951,7 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 	struct irq_data *data;
 
 	/* Look for default domain if necessary */
-	if (domain == NULL)
-		domain = irq_default_domain;
+	domain = domain ? : irq_default_domain;
 	if (domain == NULL)
 		return desc;
 
@@ -1554,11 +1551,9 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 {
 	int ret;
 
-	if (domain == NULL) {
-		domain = irq_default_domain;
-		if (WARN(!domain, "domain is NULL; cannot allocate IRQ\n"))
-			return -EINVAL;
-	}
+	domain = domain ? : irq_default_domain;
+	if (WARN(!domain, "domain is NULL; cannot allocate IRQ\n"))
+		return -EINVAL;
 
 	mutex_lock(&domain->root->mutex);
 	ret = irq_domain_alloc_irqs_locked(domain, irq_base, nr_irqs, node, arg,
@@ -1962,11 +1957,9 @@ static int irq_domain_debug_show(struct seq_file *m, void *p)
 	struct irq_domain *d = m->private;
 
 	/* Default domain? Might be NULL */
-	if (!d) {
-		if (!irq_default_domain)
-			return 0;
-		d = irq_default_domain;
-	}
+	d = d ? : irq_default_domain;
+	if (!d)
+		return 0;
 	irq_domain_debug_show_one(m, d, 0);
 	return 0;
 }
-- 
2.34.1


