Return-Path: <linux-kernel+bounces-169865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E68BCEAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8554B1C23A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5706D1BC;
	Mon,  6 May 2024 13:03:19 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6378C60
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000598; cv=none; b=Uxf53VKgkFbx9qyqXpEOyd8R7f2NbprJ5PeC4sPyeHygCloZTZc4AVIStSKEXttvpBZGt5ipk4HpWcXsd7S3otS/bH+bbb5gmIwJ+rVSqkcLOimcmTBQhIbFV/y+4zNbFB+hNt/JnojR4aM10/1T9GPn2o+QkTNJNvYLNl12y6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000598; c=relaxed/simple;
	bh=+ulLU4slP0ZpFDa6qvL8fvK6SU8hdStisvDrncOSz4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JetqGsM3gPCC+ThQotl/PCiddmpchN105ZmK/YN9oxR1HR1G6wYNBzsBwHIA+iUj1v1vVHy0VYjkg7CZtIMvnBJy2Y28xnAE9cIVXH+9CUokiG62UEVGm6BBSz3Fg9kLmlviTXVqy5lSvWs1cGycKp8Hssh87+beq6yGb2jU0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VY1hF6TMTzcp0d
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:59:25 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id B6F59180065
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:03:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 21:03:13 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 5/5] genirq/irqdomain: Clean up for irq_domain_xlate_*
Date: Mon, 6 May 2024 21:02:23 +0800
Message-ID: <20240506130223.317265-6-ruanjinjie@huawei.com>
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

As irq_domain_xlate_onecell() and irq_domain_xlate_onetwocell() have
almost the same logic, introduce irq_domain_xlate_common() to do it and
use a new xlate_type enum variable to distinguish them.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdomain.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2ef53697d877..4dd53d76f7ef 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -985,6 +985,29 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 }
 EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
 
+enum xlate_type {
+	ONE_CELL	= 0,
+	ONE_TWO_CELL,
+};
+
+static inline int irq_domain_xlate_common(const u32 *intspec,
+					  unsigned int intsize,
+					  unsigned long *out_hwirq,
+					  unsigned int *out_type,
+					  enum xlate_type type)
+{
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = IRQ_TYPE_NONE;
+
+	if (type == ONE_TWO_CELL && intsize > 1)
+		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
  *
@@ -995,11 +1018,8 @@ int irq_domain_xlate_onecell(struct irq_domain *d, struct device_node *ctrlr,
 			     const u32 *intspec, unsigned int intsize,
 			     unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN_ON(intsize < 1))
-		return -EINVAL;
-	*out_hwirq = intspec[0];
-	*out_type = IRQ_TYPE_NONE;
-	return 0;
+	return irq_domain_xlate_common(intspec, intsize, out_hwirq,
+				       out_type, ONE_CELL);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
 
@@ -1037,14 +1057,8 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d,
 				const u32 *intspec, unsigned int intsize,
 				unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN_ON(intsize < 1))
-		return -EINVAL;
-	*out_hwirq = intspec[0];
-	if (intsize > 1)
-		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
-	else
-		*out_type = IRQ_TYPE_NONE;
-	return 0;
+	return irq_domain_xlate_common(intspec, intsize, out_hwirq,
+				       out_type, ONE_TWO_CELL);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_onetwocell);
 
-- 
2.34.1


