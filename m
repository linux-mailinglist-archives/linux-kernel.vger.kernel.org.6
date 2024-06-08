Return-Path: <linux-kernel+bounces-207135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E769012C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5642824CF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0E17A902;
	Sat,  8 Jun 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i9xnA6G6"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9395135A67
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864541; cv=none; b=nMGJ5PUtSKkBKy7f2yVLF/tQy3z2CrtyEK21nnIVaYPqFlnZhGNPiLg3Wol+FsdoA1IyrTS15USm5S/T1b/6Tb+1/1DW09fjx/3cbuKqTnprW33tM9itXmFyoMpumQhpmxlhOiqntYGZCM/pJORav9ieKylP1g4DhuaLNJ9UQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864541; c=relaxed/simple;
	bh=LCHj8nIxCquw+11XWT9lWJOZdxuZbqDAhg1dlHaP+PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxVb69MChbCNBVtzxJKyXJQU9DJqGgNrmSzdd5Qfy8ugo+X7ZUTa7TBMhl5Iixgd8MfXQS1wOeB8MxINizfQMjDQt7hbDpX2hq2sqM7IqgD2vopEaNZlBnklF22aqSXX7zcJEs8mV86aykf+tewSqYUbSc3e8r5I/vepp2PmCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i9xnA6G6; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VtM4l
	ZNPi+lh6AwJq2XgyJyvoSvwepJ3g7prTCu3fUg=; b=i9xnA6G6iUb1p2kXLy8II
	nvQ33kXrqTUvUXMH/s3Qfd9OfC4Mp9Q0OMpGfrdzoY4xx5IsfIOMzX670a/SUcn+
	ZaoMM4guuM/Gc7Etfr1DhIW6soaqAd1QCWEA440F4xBqhDi7nlTKMLcocbE+dEd0
	lF1tl+wV4sZAliuACepvfI=
Received: from localhost.localdomain (unknown [113.91.88.209])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wDX_3FFiGRmaFzpDQ--.64908S2;
	Sun, 09 Jun 2024 00:35:17 +0800 (CST)
From: Zhenze Zhuang <luuiiruo@163.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Zhenze Zhuang <luuiiruo@163.com>
Subject: [PATCH] genirq: Fix gpio irq will fail to be resend under certain conditions
Date: Sun,  9 Jun 2024 00:36:20 +0800
Message-Id: <20240608163620.89028-1-luuiiruo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_3FFiGRmaFzpDQ--.64908S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7Aw48JF48Ww4xAw47Arb_yoW8JFW8pa
	yrG34UKr4DC3W0qa9Ivw1xAFyUAa1rXr45GFW7C34fAws8WryFqFn5XF4agw10yry2vr4Y
	vF4Yv3y7Cr45CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRxManUUUUU=
X-CM-SenderInfo: 5oxxxxxuxrqiywtou0bp/1tbiMx33k2XAlthMegACsV

When a gpio irq is disable and the wakeup function is enable, and
the device enters suspend, the irq wakeup is triggered but then enters
suspend, the IRQS_REPLAY flag will be set, but the IRQS_REPLAY will
not be cleared because the irq_may_run() condition is not met. After
the gpio irq is enabled and the suspend is entered again, after the
gpio irq is triggered, the check_irq_resend() execution will fail
because the IRQS_REPLAY is asserted, resulting in the interrupt not
being resned.

Signed-off-by: Zhenze Zhuang <luuiiruo@163.com>
---
 kernel/irq/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..8800db8d655c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -690,6 +690,8 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
 	/*
 	 * When an affinity change races with IRQ handling, the next interrupt
 	 * can arrive on the new CPU before the original CPU has completed
@@ -701,8 +703,6 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 		goto out;
 	}
 
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
 	/*
 	 * If its disabled or no action available
 	 * then mask it and get out of here:
-- 
2.34.1


