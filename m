Return-Path: <linux-kernel+bounces-169842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA48BCE76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BBD289E94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3C4D58E;
	Mon,  6 May 2024 12:51:51 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E81DFED
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999911; cv=none; b=MXPyJX66LaWyC30JYMguOIcPyjlAXVqcTrtyrwa0ycRCaT1JMjVIP1088FRFMHhqPRNFKeuhWLVc8Oo30yGm3TzJnTQykzj94dtR5paInkH+f0yx0sSuDWQqATqlH7pKt5vHqB1/ulZ1dyP9AGUprsLsEfKQN3Y287UaNqrEdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999911; c=relaxed/simple;
	bh=1KXzSoo3QAex6UeVIC3bVa80QNaS8yOCfTa9OgS4nok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GDqyBa52nnIj/TkhzLObnWfdw8xg6xv70z7sk9ZnJsuQ9MjIYN3CWQ4C0Hp1BJ1rYirihOywgDCi5SggrRiA6qsArzu74nkNqZ8/vwP0Dn0M4wqSzr9YoC1Ycg7kZeEtEvRClEQxwNgqyzHEyvYb5vfQSos55ttfoJRiQ7WGfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VY1Rc3kq8z1RBpv
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:48:28 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id C85DD1800C9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:51:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 20:51:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq: Simplify the check for __irq_get_desc_lock()
Date: Mon, 6 May 2024 20:50:57 +0800
Message-ID: <20240506125057.307586-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

If it set "_IRQ_DESC_PERCPU" in "check" but the desc is not percpu, or if
the desc is percpu but it not set "_IRQ_DESC_PERCPU" in "check", it both
return NULL, so simplify the check in __irq_get_desc_lock() with "!=".

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdesc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 88ac3652fcf2..6c52deb134b9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -882,11 +882,7 @@ __irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
 
 	if (desc) {
 		if (check & _IRQ_DESC_CHECK) {
-			if ((check & _IRQ_DESC_PERCPU) &&
-			    !irq_settings_is_per_cpu_devid(desc))
-				return NULL;
-
-			if (!(check & _IRQ_DESC_PERCPU) &&
+			if (!!(check & _IRQ_DESC_PERCPU) !=
 			    irq_settings_is_per_cpu_devid(desc))
 				return NULL;
 		}
-- 
2.34.1


