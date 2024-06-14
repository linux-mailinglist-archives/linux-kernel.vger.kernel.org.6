Return-Path: <linux-kernel+bounces-215151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A0908ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ED61F22017
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD815CD64;
	Fri, 14 Jun 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFrW7etl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD1157A47
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379231; cv=none; b=naIztuh0WRs52xdiNdCnB0LYssgWz9Mr0LUiWZBXocu18g0qCuX705IK7oEFCwlzkJt6Z7X+XGYcOQ+OF/mtxpM/21DsdlnEjZrwdmamYvuoFEb0+Vvyoe9JdEAXSWnsPeJC5SbBL/7QI8Zocr3iwR7oACBt2Wp3wwnAr9Z1lAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379231; c=relaxed/simple;
	bh=XPs2SWgcg9zduhMhSD7BO0xKySl3NyBcZQRSGIiEXLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dtqe8WpClvFTcHw2pQebdkEErSVnHXTWGx1UkoofR2XdGJQKclAXN0kLD+4ec3btRX+r5xkQWdlr9EY6rI9l/THozGRoA/lCH8y8BTTe3nElDvbEPUr0JJL1MzA6NxoOgF1mRhXpwIuIk3WeXg35JIaK3si/1drdsr1waiNmrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFrW7etl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0932CC2BD10;
	Fri, 14 Jun 2024 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379230;
	bh=XPs2SWgcg9zduhMhSD7BO0xKySl3NyBcZQRSGIiEXLg=;
	h=From:To:Cc:Subject:Date:From;
	b=TFrW7etlj0iwXNYY0ftpeIkaSGEDDdSHHhLlHu9RY9Dcy1BKNE6BN709gSW23z6jN
	 4NYG+TrSA2WzJ768BqsUzeW7070uUkmVza1P4C9v4b0UwxDXgq6W8KyRqp4L3NBlDW
	 XWAkmKLsAEYUrTrcfhiNUBSDwmSkucIAsA3zhs2NssPBxqplshjQNiPnkLAHkiFx/O
	 7+zW7HUXtP7wdwVyyIoaMXPmUtdy0kgq+CBTyK6dSvJNIBWdnHlkCviB2MvPuEVWHJ
	 C5xJvPfOYAxtUwDQF6ri3dn3Gk0OhHRI2pXJZmsSAvTC/oKFLhrinAnOFuCqS0PELI
	 FFZpS5vYjcNVA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/riscv-intc: Remove asmlinkage
Date: Fri, 14 Jun 2024 23:19:55 +0800
Message-ID: <20240614151955.1949-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two functions riscv_intc_aia_irq() and riscv_intc_irq()
are only called by C functions.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

Hi riscv maintainers and all,

Related question:

I believe the asmlinkage in riscv is a nop, is it OK to
remove asmlinkage from all riscv code?

Anyway, no matter what will be the decision, it's correct to
remove asmlinkage in riscv intc driver as this patch does.

thanks

 drivers/irqchip/irq-riscv-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4f3a12383a1e..47f3200476da 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,7 +26,7 @@ static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
 static unsigned int riscv_intc_custom_base __ro_after_init = BITS_PER_LONG;
 static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
 
-static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
+static void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
@@ -34,7 +34,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
 }
 
-static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
+static void riscv_intc_aia_irq(struct pt_regs *regs)
 {
 	unsigned long topi;
 
-- 
2.43.0


