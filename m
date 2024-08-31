Return-Path: <linux-kernel+bounces-309791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FA967076
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48C51C21C09
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3E3176AB6;
	Sat, 31 Aug 2024 09:28:52 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8594C99
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725096532; cv=none; b=qxUGDb/zPltS6Zs/x1FS+GWeINbSZbF6/IIBb055FSopTU/klZZ8OvRUFxhvkKCbWtawzDAvfg8NZOeOsKxRJave+X7kME9hgH7rnkhpXPPcuAG9s9zt49BpFeSbVYXDIUnIovNoyVwRpnBHdxriIwH9P9duhj/ayEKjPk6ZVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725096532; c=relaxed/simple;
	bh=54HWVix3GdJzZcfJ4QZ8u+yWFp2Ci+ChSRxawQ/dJbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHt1oR757g29jCuy4r7xztP5uVWNJ4PytTA8c7VUNZcVsWdDi5mLR6fw9qLPGupAMMDOYBIsb3dVqYa62z7Qxqc326rH+KunlbE5/zkIVoNMlrXWme9sfoCEJXdKDGgQqohhTc4l+/sTMVFoW2vkkwUIQjfQyqfDTpKrWomr7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WwqQt4N6jz1xwLx
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:26:46 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C1A81A0170
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:28:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 17:28:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] genirq/timings: Use min_t() to simplify the code
Date: Sat, 31 Aug 2024 17:36:54 +0800
Message-ID: <20240831093654.4139823-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The irq count can not exceed circular buffer IRQ_TIMINGS_SIZE, use
min_t() to simplify it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/timings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index c43e2ac2f8de..69f103b4c7a6 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -406,8 +406,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	/*
 	 * 'count' will depends if the circular buffer wrapped or not
 	 */
-	count = irqs->count < IRQ_TIMINGS_SIZE ?
-		irqs->count : IRQ_TIMINGS_SIZE;
+	count = min_t(int, irqs->count, IRQ_TIMINGS_SIZE);
 
 	start = irqs->count < IRQ_TIMINGS_SIZE ?
 		0 : (irqs->count & IRQ_TIMINGS_MASK);
-- 
2.34.1


