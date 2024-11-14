Return-Path: <linux-kernel+bounces-409316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001719C8B31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAA81F21A98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AE1FCC4E;
	Thu, 14 Nov 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QMTGCInV"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E91FB8A9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588694; cv=none; b=tHIrAzFJjOLOg+lG+xxmnbB+nmuCFwQOUokqZAxRBhtI2HgpR7G41B85QZr/oi1ycE6HQHUyO14rAURO/eFIok79M19g2IcjA8iALqL3sfAVioaJgYzyW4Pztrxb1QdPJqLpBMFY6KfVuSABa3JcZkCKW9q7AvVJToVSBMBp1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588694; c=relaxed/simple;
	bh=BdX8F9GYE15oH2m4KueFN1WXUWkpazHOd2IWZs953MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiu3ryFeu3LjkQcSnN6LXSoW/IOXBVCZTZ/3PwstUOHUyoOXEprbOETJbwOszUcQ0w8Zpo4kAw+yrai2cLGRGHl3dF6WjUI/kTlgAOTYvz0QOUzjDLsA34QkjTdhLPrHbPhnfGkQkTDjp0HBLrRUwTuCRXeu99RqYi51nARJBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=QMTGCInV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588686;
	bh=TVrPuN62TirQi3n8J4yEY6pFFvqH5BlXogNdJxJWTvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMTGCInVzFrOCynOneQRsCuZJ+NfX58DNoQzN5bCOgh1cfaxP92XRMRFoV+Ojh0R4
	 i6nnahJcJEyT0BjMQ59SpaJ47hRXEhRf2zUjC8ywhiVJxV3mbjF5wc0bOD1IO7sjfj
	 p/MHLovo7xeT1s1VeLOQzO/IjirIa3ZACYsfNwT8NSQQE7qB35tJCeCpMBSuJ6LNeV
	 kiohkY+5LF1D2KdkM6SSY0CVQ9UlzXp6gvvVdP9UKMWaHitj+kLnJQWrJoESU1872s
	 AkSXqPx17mA/fx53ADrhXbqkV+5/L/cSq0/0s3uCrVZ24gTjWycfqSro36EBENTM42
	 iTBJHfFApVAJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QQ3s3Mz4xcd;
	Thu, 14 Nov 2024 23:51:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 20/20] genirq: Remove IRQ_EDGE_EOI_HANDLER
Date: Thu, 14 Nov 2024 23:51:09 +1100
Message-ID: <20241114125111.599093-20-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The powerpc Cell blade support, now removed, was the only user of
IRQ_EDGE_EOI_HANDLER, so remove it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/irq/Kconfig |  4 ----
 kernel/irq/chip.c  | 47 ----------------------------------------------
 2 files changed, 51 deletions(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 529adb1f5859..564f3d454102 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -47,10 +47,6 @@ config GENERIC_IRQ_INJECTION
 config HARDIRQS_SW_RESEND
        bool
 
-# Edge style eoi based handler (cell)
-config IRQ_EDGE_EOI_HANDLER
-       bool
-
 # Generic configurable interrupt chip implementation
 config GENERIC_IRQ_CHIP
        bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 271e9139de77..de5866f57bd7 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -838,53 +838,6 @@ void handle_edge_irq(struct irq_desc *desc)
 }
 EXPORT_SYMBOL(handle_edge_irq);
 
-#ifdef CONFIG_IRQ_EDGE_EOI_HANDLER
-/**
- *	handle_edge_eoi_irq - edge eoi type IRQ handler
- *	@desc:	the interrupt description structure for this irq
- *
- * Similar as the above handle_edge_irq, but using eoi and w/o the
- * mask/unmask logic.
- */
-void handle_edge_eoi_irq(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	raw_spin_lock(&desc->lock);
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	if (!irq_may_run(desc)) {
-		desc->istate |= IRQS_PENDING;
-		goto out_eoi;
-	}
-
-	/*
-	 * If its disabled or no action available then mask it and get
-	 * out of here.
-	 */
-	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
-		desc->istate |= IRQS_PENDING;
-		goto out_eoi;
-	}
-
-	kstat_incr_irqs_this_cpu(desc);
-
-	do {
-		if (unlikely(!desc->action))
-			goto out_eoi;
-
-		handle_irq_event(desc);
-
-	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
-
-out_eoi:
-	chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
-}
-#endif
-
 /**
  *	handle_percpu_irq - Per CPU local irq handler
  *	@desc:	the interrupt description structure for this irq
-- 
2.47.0


