Return-Path: <linux-kernel+bounces-169864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BB8BCEAE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03838280A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4D6D1BB;
	Mon,  6 May 2024 13:03:18 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050B77F08
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000598; cv=none; b=CiBFh7kH18T2ZmRsn4A8SYTBIyqy/28A86rSCDIJRzdhxBG3XWu5a1IWTaUzJeTm/4XFNoCdZMfwixo18Zxrptlts4RM+GR3Cijsg76w925VjpOC9ymAmYE6jQYybVFzk79lvI9OSYq1ExRBtnz1xwAOeVeyV5F3SX1Sx/JGKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000598; c=relaxed/simple;
	bh=uuxg5U4k/MG1J3jogr6OvT/NI4ZO8YphByPzlme47Wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajylu0GMLaJdD8J+tQ+gD7Gkqzhl4Pzgvmx8dIvYv9HIX5PW4tV2Ojbn5hdH7vfB1ioLUWDl3bD/fjYl5jd5AjJcvdQiuECDiL+k+HS8rkmz0/LhLvSLchXI1f1WY31uaZN8glVsclNGjr+OIPW+SdgQVFkzTzMA3ET1fRprduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VY1jS0mCtzNw6L
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:00:28 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id B882418007D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:03:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 21:03:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 4/5] genirq/irqdomain: Simplify the checks for irq_domain_push/pop_irq()
Date: Mon, 6 May 2024 21:02:22 +0800
Message-ID: <20240506130223.317265-5-ruanjinjie@huawei.com>
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

Since whether desc is NULL or domain is NULL or irq_data is NULL, it
returns -EINVAL, check them together in irq_domain_push/pop_irq(). And
whether the irq domain is not hierarchy or it's parent domain is not
consistent, it returns -EINVAL, check them together too.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdomain.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6d8a368c677b..2ef53697d877 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1613,21 +1613,14 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
 	 * to deadlock, so we just do a simple check before starting.
 	 */
 	desc = irq_to_desc(virq);
-	if (!desc)
+	if (!desc || !domain || !irq_data)
 		return -EINVAL;
+
 	if (WARN_ON(desc->action))
 		return -EBUSY;
 
-	if (domain == NULL)
-		return -EINVAL;
-
-	if (WARN_ON(!irq_domain_is_hierarchy(domain)))
-		return -EINVAL;
-
-	if (!irq_data)
-		return -EINVAL;
-
-	if (domain->parent != irq_data->domain)
+	if (WARN_ON(!irq_domain_is_hierarchy(domain)) ||
+	    domain->parent != irq_data->domain)
 		return -EINVAL;
 
 	parent_irq_data = kzalloc_node(sizeof(*parent_irq_data), GFP_KERNEL,
@@ -1694,17 +1687,11 @@ int irq_domain_pop_irq(struct irq_domain *domain, int virq)
 	 * deadlock, so we just do a simple check before starting.
 	 */
 	desc = irq_to_desc(virq);
-	if (!desc)
+	if (!desc || !domain || !irq_data)
 		return -EINVAL;
 	if (WARN_ON(desc->action))
 		return -EBUSY;
 
-	if (domain == NULL)
-		return -EINVAL;
-
-	if (!irq_data)
-		return -EINVAL;
-
 	tmp_irq_data = irq_domain_get_irq_data(domain, virq);
 
 	/* We can only "pop" if this domain is at the top of the list */
-- 
2.34.1


