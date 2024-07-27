Return-Path: <linux-kernel+bounces-263998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A922F93DDAE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB93283A56
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436DB3B784;
	Sat, 27 Jul 2024 07:32:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB52629D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722065535; cv=none; b=Qi3QT65tVM0uS+z3IKC1jLygIu0/liCjEDEW6/kPmuGWSU3j2mZsJIFlgURvd1m+umgtcBDcLgZUqtk7HoMaPg0o7N56nm15O4iZi5Z3ysljRZsGhGOr3w0blm1fJ+pqk5Z6P/plkOagtWq75mt9Oxn2ix9SzyVnviDIBdTgjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722065535; c=relaxed/simple;
	bh=qFXj9W8JokV87MhzXDZ6DRC24UoUteMdkizHF1yMirU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f501RKXR4o/xbE4QD+xLvnDfvfLIhakhG6KJ/7LNJqwpmbWmhMig9rMz1DUpacJvY0PNDSIwR9CHWS3pac/R2p2K1hzdoyA+l74lztXTDOC/F0Yf+A3Y60oFYwgt8i/B6iZAGbOnSVhW0dMtEQrnxXPEzuce6yo69pFyB0mrIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WWGXY5XrxzxV6F;
	Sat, 27 Jul 2024 15:31:57 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E2DDD1800A1;
	Sat, 27 Jul 2024 15:32:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 27 Jul
 2024 15:32:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>, <joey.gouly@arm.com>,
	<mark.rutland@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] irqchip/gic-v3: Remove asmlinkage for gic_handle_irq()
Date: Sat, 27 Jul 2024 15:36:48 +0800
Message-ID: <20240727073648.1042377-1-ruanjinjie@huawei.com>
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
 kwepemi100008.china.huawei.com (7.221.188.57)

Since commit 064dbfb41691 ("arm64: entry: convert IRQ+FIQ handlers to C"),
the gic_handle_irq() is only called by C functions, so remove
the asmlinkage.

Fixes: 064dbfb41691 ("arm64: entry: convert IRQ+FIQ handlers to C")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c19083bfb943..0efa3443c323 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -930,7 +930,7 @@ static void __gic_handle_irq_from_irqsoff(struct pt_regs *regs)
 	__gic_handle_nmi(irqnr, regs);
 }
 
-static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	if (unlikely(gic_supports_nmi() && !interrupts_enabled(regs)))
 		__gic_handle_irq_from_irqsoff(regs);
-- 
2.34.1


