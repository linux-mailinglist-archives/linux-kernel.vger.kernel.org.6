Return-Path: <linux-kernel+bounces-178699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED03D8C569A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC161C21DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB061420C8;
	Tue, 14 May 2024 13:09:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D731411CF
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692169; cv=none; b=oTPQ1eB0du+ErgsMPWlnAYZrCqcW3Z9KP81sCbXch34UMyaD5I6UB7Sm7lxbvalzKypO2RLV1/JXdreOhnubHe4Ktw3mmT0T9L4eH7ubh5ze7kQ183wiWNPNZM+Jpz2YADXZD3SEgkV2+t3v+0I2cAJ0jHUAGypId5QQscs1/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692169; c=relaxed/simple;
	bh=65edET6jm+UN4MrjA0dVXg2bXDSEpLCbz9A1nWNT5T8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJ283SngK0D0sGFrUPJX22Gj68fhgNhMBujZN/Euwk5kP1gSWbBhWEDQcIEviC2Sxv1y3UDXsfPACmQZYROidpCiliugzkegEauhvFzzz9M+9qrharqvSZO71IHX4nfoeKfyTDYb4ifTKiOUmMxRPFz9jfLDkilUKlC10/Lry2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VdxS26w8VzvYcl
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:05:54 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id D96761400CD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:09:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 14 May
 2024 21:09:22 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq: Clean code for handle_edge_irq()
Date: Tue, 14 May 2024 21:09:15 +0800
Message-ID: <20240514130915.2613753-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)

The pending set and mask_ack_irq() repeated twice, a new goto label can
reduce a few lines of code, with no functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/chip.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 638cf5eee04b..4613dc9ff6b6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -775,21 +775,15 @@ void handle_edge_irq(struct irq_desc *desc)
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
-	if (!irq_may_run(desc)) {
-		desc->istate |= IRQS_PENDING;
-		mask_ack_irq(desc);
-		goto out_unlock;
-	}
+	if (!irq_may_run(desc))
+		goto out_mask_ack;
 
 	/*
 	 * If its disabled or no action available then mask it and get
 	 * out of here.
 	 */
-	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
-		desc->istate |= IRQS_PENDING;
-		mask_ack_irq(desc);
-		goto out_unlock;
-	}
+	if (irqd_irq_disabled(&desc->irq_data) || !desc->action)
+		goto out_mask_ack;
 
 	kstat_incr_irqs_this_cpu(desc);
 
@@ -818,6 +812,9 @@ void handle_edge_irq(struct irq_desc *desc)
 	} while ((desc->istate & IRQS_PENDING) &&
 		 !irqd_irq_disabled(&desc->irq_data));
 
+out_mask_ack:
+	desc->istate |= IRQS_PENDING;
+	mask_ack_irq(desc);
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }
-- 
2.34.1


