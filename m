Return-Path: <linux-kernel+bounces-169863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E528BCEAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B73F1F24AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEA44C66;
	Mon,  6 May 2024 13:03:17 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5E6D1BB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000597; cv=none; b=Ev3Fsfd42ht7QkECYBFwjfXst/h6KXag0cS8gEXErD64gDMR5Mtjz3galSpCBG+R22743NanLo4IMfE+yS3P80nvNYgGt/2TezT/D8DpTorSzBXfviXQUa5tTrKkxMN7k/ZXQVfRWSDC5Ll/vLb2O+FiECO9zhrzbXqCQ2Vu3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000597; c=relaxed/simple;
	bh=SWCL/GgvDvSAFp81ExaUX0cbPTexrcab9TT6aTWubmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4Oc0TugVfx9rYBTeuCX+q/XVfE39e7UnzzGvar1sYY8aokHI4fyNLz3ONPFiFVgACne7DHfNfqT6ZOBWmNiYxrRfUc4l1v6kXsm0OZBc+NqXgT9M5eL8lBE26ir3gqvs1A+ieNm5gX5MUgI/V+aycTgNmU7dHOD7NzXIbCv1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VY1lH5v0mz1xmgr
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:02:03 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id C10761A016C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:03:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 21:03:10 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 3/5] genirq/irqdomain: Clean code for irq_create_direct_mapping()
Date: Mon, 6 May 2024 21:02:21 +0800
Message-ID: <20240506130223.317265-4-ruanjinjie@huawei.com>
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

Add "out" goto label for irq_domain_update_bus_token(), and
"out_free_desc" goto label for irq_create_direct_mapping(), which can
simplify the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdomain.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 42bdbd04bc3c..6d8a368c677b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -317,10 +317,8 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
 	domain->bus_token = bus_token;
 
 	name = kasprintf(GFP_KERNEL, "%s-%d", domain->name, bus_token);
-	if (!name) {
-		mutex_unlock(&irq_domain_mutex);
-		return;
-	}
+	if (!name)
+		goto out;
 
 	debugfs_remove_domain_dir(domain);
 
@@ -332,6 +330,7 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
 	domain->name = name;
 	debugfs_add_domain_dir(domain);
 
+out:
 	mutex_unlock(&irq_domain_mutex);
 }
 EXPORT_SYMBOL_GPL(irq_domain_update_bus_token);
@@ -672,17 +671,18 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 	if (virq >= domain->hwirq_max) {
 		pr_err("ERROR: no free irqs available below %lu maximum\n",
 			domain->hwirq_max);
-		irq_free_desc(virq);
-		return 0;
+		goto out_free_desc;
 	}
 	pr_debug("create_direct obtained virq %d\n", virq);
 
-	if (irq_domain_associate(domain, virq, virq)) {
-		irq_free_desc(virq);
-		return 0;
-	}
+	if (irq_domain_associate(domain, virq, virq))
+		goto out_free_desc;
 
 	return virq;
+
+out_free_desc:
+	irq_free_desc(virq);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 #endif
-- 
2.34.1


